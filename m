Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E31F97D
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfEORpW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 13:45:22 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34847 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfEORpV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 13:45:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id r7so193054ual.2
        for <linux-arch@vger.kernel.org>; Wed, 15 May 2019 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2m7yv1XhZnPjtDDyBcaCJV3OfxxWTymy93VR6KaE5U=;
        b=CviqV5ydQdEcHOiodPrSzU5jMvwQcoHtcBbzWljh20l7kJfiKaNVIzcADvvKuuu2lZ
         D5dv2aAqIdF3YAbFDCrxnTcTBU90PWElfvdDYQCMrr+nOoGhBZEoDopVuiUf5M58ccQ5
         2tsQw9iTnMF7r9zi5Sax0dbLHIsqOuXqo8Xfad/2eoJL05xFPBEVJVo7Bpy74nSJSWJp
         tiCTG9TdzKLOLYvR9JjOrasUQhZxX3L73rtKi0MnSX2QN8wYp4yV5eT8d6JR0AW98TkG
         CWnq5Zzgpx7YK5fuwC3vCdixJtYQICLk60N+E5r9tJiENbkf1RQcDw4tlX99XRV1SGwF
         SySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2m7yv1XhZnPjtDDyBcaCJV3OfxxWTymy93VR6KaE5U=;
        b=X8N0Lodo4B/PAgmLoQA9yRb0KWIMs+fHDp9a6ctTNsuR/N/CrJCo51FKmEMFLw6AWi
         DqRpWCC2KDAgcxtL6lIR4lBt3hTcVpvSU7DuYt5LJ/AC0r4zO7PQFMMqkYu8UavDzbV2
         u7uVNxiJkOvtl2BlTTFk8VNeOFDHByONVUVvn65yOZFQWAjhoh1tIhObkEymF9h0SueX
         DqqjqZmIi/cjtmoNmxgJTPLb79bAMEuOk09NWkibo4I3kclAH6PRk2i8mzObcupd2wVO
         Lx9F954Nr04aIAuSVjRRXaNWialjSVfrD1D3xtNzgdtsomlpICGgUZfxRU1ZvztFAgqr
         0oRA==
X-Gm-Message-State: APjAAAU45tKuDTDgP2elnIwfXn/++YOtE8zLeGVzKJVm5HBlS814xbmv
        5z5TyuLW6udKs8HpyobZ5ObFCaUM8MgZYJYxR9NbHQ==
X-Google-Smtp-Source: APXvYqywR4mX+Nl6g9f5/Sp0unLUl+sgnKvLBMi1P4KMj6h1ZwXo6NEp9s5gtpFZIlqrfauTRtA7ILfjhAlSpHxYz88=
X-Received: by 2002:ab0:14ab:: with SMTP id d40mr21334220uae.41.1557942319615;
 Wed, 15 May 2019 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190515100400.3450-1-christian@brauner.io>
In-Reply-To: <20190515100400.3450-1-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 15 May 2019 10:45:06 -0700
Message-ID: <CAKOZuesPF+ftwqsNDMBy1LpwJgWTNuQm9-E=C90sSTBYEEsDww@mail.gmail.com>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        elena.reshetova@intel.com, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 15, 2019 at 3:04 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> process that is created via traditional fork()/clone() calls that is only
> referenced by a PID:

Thanks for doing this work. I'm really looking forward to this new
approach to process management.

> int pidfd = pidfd_open(1234, 0);
> ret = pidfd_send_signal(pidfd, SIGSTOP, NULL, 0);
>
> With the introduction of pidfds through CLONE_PIDFD it is possible to
> created pidfds at process creation time.
> However, a lot of processes get created with traditional PID-based calls
> such as fork() or clone() (without CLONE_PIDFD). For these processes a
> caller can currently not create a pollable pidfd. This is a huge problem
> for Android's low memory killer (LMK) and service managers such as systemd.
> Both are examples of tools that want to make use of pidfds to get reliable
> notification of process exit for non-parents (pidfd polling) and race-free
> signal sending (pidfd_send_signal()). They intend to switch to this API for
> process supervision/management as soon as possible. Having no way to get
> pollable pidfds from PID-only processes is one of the biggest blockers for
> them in adopting this api. With pidfd_open() making it possible to retrieve
> pidfd for PID-based processes we enable them to adopt this api.
>
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.

I'm glad it's easier now.

>  arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
>  arch/arm64/include/asm/unistd32.h           |  2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +

It'd be nice to arrange the system call tables so that we need to
change only one file when adding a new system call.

[Snip system call wiring]

> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -67,6 +67,7 @@ struct pid
>  extern struct pid init_struct_pid;
>
>  extern const struct file_operations pidfd_fops;
> +extern int pidfd_create(struct pid *pid);
>
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e2870fe1be5b..989055e0b501 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -929,6 +929,7 @@ asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
>                                 struct old_timex32 __user *tx);
>  asmlinkage long sys_syncfs(int fd);
>  asmlinkage long sys_setns(int fd, int nstype);
> +asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
>  asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
>                              unsigned int vlen, unsigned flags);
>  asmlinkage long sys_process_vm_readv(pid_t pid,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index dee7292e1df6..94a257a93d20 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -832,9 +832,11 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  #define __NR_io_uring_register 427
>  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> +#define __NR_pidfd_open 428
> +__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 428
> +#define __NR_syscalls 429
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 737db1828437..980cc1d2b8d4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1714,7 +1714,7 @@ const struct file_operations pidfd_fops = {
>   * Return: On success, a cloexec pidfd is returned.
>   *         On error, a negative errno number will be returned.
>   */
> -static int pidfd_create(struct pid *pid)
> +int pidfd_create(struct pid *pid)
>  {
>         int fd;
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..237d18d6ecb8 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -38,6 +38,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
>  #include <linux/proc_fs.h>
> +#include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>
> @@ -451,6 +452,53 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>         return idr_get_next(&ns->idr, &nr);
>  }
>
> +/**
> + * pidfd_open() - Open new pid file descriptor.
> + *
> + * @pid:   pid for which to retrieve a pidfd
> + * @flags: flags to pass
> + *
> + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> + * the process identified by @pid. Currently, the process identified by
> + * @pid must be a thread-group leader. This restriction currently exists
> + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> + * leaders).
> + *
> + * Return: On success, a cloexec pidfd is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> +{
> +       int fd, ret;
> +       struct pid *p;
> +       struct task_struct *tsk;
> +
> +       if (flags)
> +               return -EINVAL;

If we support blocking operations on pidfds, we'll want to be able to
put them in non-blocking mode. Does it make sense to accept and ignore
O_NONBLOCK here now?

> +       if (pid <= 0)
> +               return -EINVAL;

WDYT of defining pid == 0 to mean "open myself"?

> +       p = find_get_pid(pid);
> +       if (!p)
> +               return -ESRCH;
> +
> +       rcu_read_lock();
> +       tsk = pid_task(p, PIDTYPE_PID);
> +       if (!tsk)
> +               ret = -ESRCH;
> +       else if (unlikely(!thread_group_leader(tsk)))
> +               ret = -EINVAL;
> +       else
> +               ret = 0;
> +       rcu_read_unlock();
> +
> +       fd = ret ?: pidfd_create(p);
> +       put_pid(p);
> +       return fd;
> +}
