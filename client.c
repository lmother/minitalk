#include "./includes/minitalk.h"

void	ft_sig_one(pid_t pid)
{
	if (kill(pid, SIGUSR1) == -1)
	{
		ft_putendl_fd("PID Error", 1);
		exit (0);
	}
}

void	ft_sig_two(pid_t pid)
{
	if (kill(pid, SIGUSR2) == -1)
	{
		ft_putendl_fd("PID Error", 1);
		exit (0);
	}
}

void	ft_send_sig(char *str, pid_t pid)
{
	int	i;
	int	k;

	k = 0;
	while (str && str[k])
	{
		i = 128;
		while (i >= 1)
		{
			if (i & str[k])
				ft_sig_one(pid);
			else
				ft_sig_two(pid);
			i /= 2;
			usleep(5000);
		}
		k++;
	}
}

void	ft_handler(int sig)
{
	usleep(50);
	if (sig != SIGUSR1)
		exit (0);
}

int	main(int agrc, char **agrv)
{
	struct sigaction	sa;

	sa.sa_handler = ft_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	sigaddset(&sa.sa_mask, SIGUSR1);
	sigaction(SIGUSR1, &sa, NULL);
	if (agrc == 3)
		ft_send_sig(agrv[2], ft_atoi(agrv[1]));
	else
		write(1, "The arguments are not valid\n", 30);
	return (0);
}
