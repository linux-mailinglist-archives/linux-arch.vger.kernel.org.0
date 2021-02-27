Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B82326D0C
	for <lists+linux-arch@lfdr.de>; Sat, 27 Feb 2021 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhB0Ma1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 07:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhB0Ma0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 07:30:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C693664F30;
        Sat, 27 Feb 2021 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614428985;
        bh=MCaTtkyFYXAFPxtrnr47vRHXHJOy/Gg2Vrr9l/na0sg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKh7xfyclyllhRVu4I19vTdJumgCcMnWUTj3YuPPr6n9s0ZwarhwYKwvaXpA5zsPk
         kjheqrihhZX9hTum3WvSGTgeoJ+xzL2a3tFIsYwPT2DYFkGsXFLtNbH1AQK/XE65Jy
         7ODttEw7Aw819AV+g2vrIBapd68nJgXEHkuKup43oUbNS75BcOG8PU3kGIxYTIuFgQ
         kr35RilkrLGxVzsCHpKSv01urnc5s8IaN23UnTsVMsNuL7dS7f4/3rJ0+OEmb9edTe
         Rtl9QZ0TJZHHGxSEkkTDznfomkTSjXewIxRsLTOFSbgxtuT0PJqfh5Jv+XXd6TpuEJ
         1sL6oERHBuDBw==
Received: by mail-oi1-f177.google.com with SMTP id x20so12785028oie.11;
        Sat, 27 Feb 2021 04:29:45 -0800 (PST)
X-Gm-Message-State: AOAM533i8A+rD3h+bo9ws+Wa0rIPTxAqePfEVrYQfFPSXmVbG2eCnjqk
        B94bvBk6hamp9YFzsm4pizn4fBbZj1IfOXjn+nM=
X-Google-Smtp-Source: ABdhPJw+sS31kUMuqqG7Xvzrc/bl5nZf4IXDxtaoqR1oc3oCESkxd/Uqpt93xGp+rerEKCpBIjcnLJNsJvd5DN5hCDI=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr5148843oib.11.1614428984716;
 Sat, 27 Feb 2021 04:29:44 -0800 (PST)
MIME-Version: 1.0
References: <tencent_30362DDFFEE04E6CDACB6F803734A8DC7B06@qq.com>
In-Reply-To: <tencent_30362DDFFEE04E6CDACB6F803734A8DC7B06@qq.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 27 Feb 2021 13:29:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3UOpW_m=_VfxzmC_FxRnG4yYKRXnkP8k4HeNtuu7dVcg@mail.gmail.com>
Message-ID: <CAK8P3a3UOpW_m=_VfxzmC_FxRnG4yYKRXnkP8k4HeNtuu7dVcg@mail.gmail.com>
Subject: Re: [PATCH] ipc/msg: add msgsnd_timed and msgrcv_timed syscall for
 system V message queue
To:     Eric Gao <eric.tech@foxmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 27, 2021 at 7:52 AM Eric Gao <eric.tech@foxmail.com> wrote:
>
> sometimes, we need the msgsnd or msgrcv syscall can return after a limited
> time, so that the business thread do not be blocked here all the time. In
> this case, I add the msgsnd_timed and msgrcv_timed syscall that with time
> parameter, which has a unit of ms.
>
> Signed-off-by: Eric Gao <eric.tech@foxmail.com>

I have no opinion on whether we want or need this, but I'll have a look
at the implementation, to see if the ABI makes sense.

> index 8fd8c17..42b7db5 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -381,3 +381,5 @@
>  440    n32     process_madvise                 sys_process_madvise
>  441    n32     epoll_pwait2                    compat_sys_epoll_pwait2
>  442    n32     mount_setattr                   sys_mount_setattr
> +443    n32     msgrcv_timed                    sys_msgrcv_timed
> +444    n32     msgsnd_timed                    sys_msgsnd_timed
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 090d29c..0f1f6ee 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -430,3 +430,5 @@
>  440    o32     process_madvise                 sys_process_madvise
>  441    o32     epoll_pwait2                    sys_epoll_pwait2                compat_sys_epoll_pwait2
>  442    o32     mount_setattr                   sys_mount_setattr
> +443    o32     msgrcv_timed                    sys_msgrcv_timed
> +444    o32     msgsnd_timed                    sys_msgsnd_timed

I think mips n32 and o32 both need to use the compat version when running on
a 64-bit kernel, while your patch makes them use the native version.

> @@ -905,7 +906,15 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>
>                 ipc_unlock_object(&msq->q_perm);
>                 rcu_read_unlock();
> -               schedule();
> +
> +               /* sometimes, we need msgsnd syscall return after a given time */
> +               if (timeoutms <= 0) {
> +                       schedule();
> +               } else {
> +                       timeoutms = schedule_timeout(timeoutms);
> +                       if (timeoutms == 0)
> +                               timeoutflag = true;
> +               }

I wonder if this should be schedule_timeout_interruptible() or at least
schedule_timeout_killable() instead of schedule_timeout(). If it should,
this should probably be done as a separate change.

> +COMPAT_SYSCALL_DEFINE5(msgsnd_timed, int, msqid, compat_uptr_t, msgp,
> +                      compat_ssize_t, msgsz, int, msgflg, compat_long_t, timeoutms)
> +{
> +       struct compat_msgbuf __user *up = compat_ptr(msgp);
> +       compat_long_t mtype;
> +
> +       timeoutms = (timeoutms + 9) / 10;
> +
> +       if (get_user(mtype, &up->mtype))
> +               return -EFAULT;
> +
> +       return do_msgsnd(msqid, mtype, up->mtext, (ssize_t)msgsz, msgflg, (long)timeoutms);
> +}

My preference would be to simplify both the timed and non-timed version by
moving the get_user() into do_msgsnd() and using in_compat_task() to pick
the right type. Same for the receive side of course. If you do this,
watch out for
x32 support, which uses the 64-bit version.

       Arnd
