#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_ARGS 100

int main(void){
    char *line = NULL;
    size_t size = 0;
    while (1){
        //força o programa a mostrar imediatamente o que está no stdout
        printf("%% ");
        fflush(stdout);

        if (getline(&line, &size, stdin) == -1)
            break;

        line[strcspn(line, "\n")] = '\0';
        //divide a linha em argumentos

        char *args[MAX_ARGS];
        int argc = 0;
        char *token = strtok(line, " ");

        while (token != NULL && argc < MAX_ARGS - 1){
            args[argc] = token;
            argc++;
            token = strtok(NULL, " ");
        }
        args[argc] = NULL;

        if (argc == 0)
            continue;

        if (strcmp(args[0], "exit") == 0)
            break;
        //

        pid_t pid = fork();

        if (pid == -1){
            perror("fork");
            continue;
        }

        if (pid == 0){
            execvp(args[0], args);
            perror("execvp");
            exit(EXIT_FAILURE);
        }else{
            waitpid(pid, NULL, 0);
        }
    }

    free(line);
    return 0;
}
