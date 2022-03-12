#include "./includes/minitalk.h"

pid_t	g_cpid;

void	ft_sig_handler(int sig, siginfo_t *info, void *nenado)
{
	static char	c;
	static int	i;

	(void)nenado;
	g_cpid = info->si_pid;
	if (sig == SIGUSR2)
	{
		c = (c << 1);
		i++;
	}
	else if (sig == SIGUSR1)
	{
		c = (c << 1) + 1;
		i++;
	}
	if (i > 7)
	{
		write(1, &c, 1);
		i = 0;
		c = 0;
	}
	if (kill(g_cpid, SIGUSR1) == -1)
		ft_putendl_fd("PID client error\n", 1);
}

void	ft_print_pid(void)
{
	pid_t	id;
	char	*str;

	id = getpid();
	str = ft_itoa(id);
	if (str)
	{
		write(1, "PID: ", 5);
		ft_putendl_fd(str, 1);
	}
	else
	{
		write(1, "PID Error\n", 10);
		exit (0);
	}
}

int	main(void)
{
	struct sigaction	sa;

	ft_print_pid();
	sa.sa_sigaction = &ft_sig_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	if (sigaddset(&sa.sa_mask, SIGUSR2) == -1
		|| sigaddset(&sa.sa_mask, SIGUSR1) == -1)
		exit (0);
	if (sigaction(SIGUSR1, &sa, NULL) == -1
		|| sigaction(SIGUSR2, &sa, NULL) == -1)
		exit (0);
	while (1)
		pause();
	return (0);
}
