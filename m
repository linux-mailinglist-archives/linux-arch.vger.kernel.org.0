Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0379D278CBB
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgIYPa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 11:30:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYPa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Sep 2020 11:30:58 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MK3FW-1k0RTl3uV4-00LUYa; Fri, 25 Sep 2020 17:30:56 +0200
Received: by mail-qk1-f179.google.com with SMTP id q63so3169693qkf.3;
        Fri, 25 Sep 2020 08:30:55 -0700 (PDT)
X-Gm-Message-State: AOAM530qR/qXZ6jAiPfeslA3hWHjfleucb7j9hg8TbkHG58vVZSGr0sw
        7EfTwqyor6qUxRJxo/0kfUWoM/JenZO0HakCAkA=
X-Google-Smtp-Source: ABdhPJwViFuhR693mJsi/dMIOSfPt325VJh7VG9UX6ruHa7SF+GVqx2YpXQOMKPH5JMPhgn7i6oNEU0/IDo4ojtcxQA=
X-Received: by 2002:a37:a483:: with SMTP id n125mr521612qke.286.1601047854526;
 Fri, 25 Sep 2020 08:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-1-arnd@arndb.de> <20200919081906.GV1551@shell.armlinux.org.uk>
 <CAK8P3a1k9Ms8EBD-KxsGWY8LxzWqLh-E6ZaemcTMeYoRKBaQUg@mail.gmail.com>
In-Reply-To: <CAK8P3a1k9Ms8EBD-KxsGWY8LxzWqLh-E6ZaemcTMeYoRKBaQUg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 17:30:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZFvXPbKRJzjh5Gj08TcQYNV+MoSTLXjTOnkyVb4WuNA@mail.gmail.com>
Message-ID: <CAK8P3a3ZFvXPbKRJzjh5Gj08TcQYNV+MoSTLXjTOnkyVb4WuNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BqCMMSoyRrviZQlLSe/1hZjWAOw7cRzBNgqfwmFAo0uTFqKoe8N
 LYHmMQ65mUiELoDg+BB/V8VMtzq9XXZ8ntA/JWpytwQPBqMOAfapITesodPr+psZVW1F+s/
 qJis4JpEdLcK/47tNFT4DjdlzebSSnP/69c3Fk/OJYNST4j3KTpPN8erKQpx/P65SOIBqQH
 /9wkI9DDfigSABAb6aHIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vDEzA/YuduA=:acQ+b2jLJw0uNZQSgYGBxL
 I4Jw+k9sBg+GJvZ0lWrSLmoPWD4nzNAfv91uNFkq2S4JjNq0aaJs/a2FP3cvmtqsqdq8r0IEk
 bIEdZmHZO49o/IQMtSDADsHv3swSmyh6xR3D+EPQEwJOAoixZcKenDNKr++6VdBRpkZMb4NUO
 BzCMocqttbYA+ek6/wlCzgS6LFQNaw9c+LbXgYbmroCCovhtj9vuu/4UycHTsMF06rr5dG2u+
 J8LdfanxAqXphDAFNr+jM/OEs865ohAC+mYOFRaPN9KyYkzMu1tzn3zwloa1MaIohJWvLsaFm
 XHPwPu+EAj4vvdmUdkbNIxKN5nG2NEkMht9+IAhoTG80h7KhjI5tVlh+826h8jFCk5wOUYwsb
 EPDObavvorcrx1rtttQByv4yhwgjMA/dCRafez6hB97QlPIJHCQ/9TgIL1Nq3VhA2Viw/sEHd
 IhNUuS+uhH6buUkz46O29vdax+QRuc+4fHBdk1SdBBXzWttPzcnmfVtnItDIIvIH+YNAOD9Oz
 OcDYrOOXSGGU1lOTwihfS+wNAL4rgPsdEAd2trlF04Fx30iCDB59IsX+Ggh+4yD76U1EaZMFl
 je3JwS9Uxd4oQTrOeDBlh2QKEeProl9VlYtqj0OYHgOG6ZdbxDtGePBVy62Hg0D0SOS3SAcqa
 Jp3NEhPDIGFO2UOHL9OB5lkfzYm/xKgc9VZOEauO0fxXmfb0mepHbRF7Z7KYx3YIO0QI85BLu
 44jQ37VUk+VvWuIXVgXThqEv+QhLb6pjLPxe0CgBYki+/m/Ew5z/mywkBpL7JuFv4hNJlmeQV
 xNVs+8NVsEES/IGcYYCaFcf12BBtb16acx65aSsC7WnCzEmvm250LD8hw7z7UA/kqxVHY05
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 25, 2020 at 4:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Sep 19, 2020 at 10:19 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Sep 18, 2020 at 02:46:15PM +0200, Arnd Bergmann wrote:
> > > Hi Christoph, Russell,
> > >
> > > Here is an updated series for removing set_fs() from arch/arm,
> > > based on the previous feedback.
> > >
> > > I have tested the oabi-compat changes using the LTP tests for the three
> > > modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
> > > and I have lightly tested the get_kernel_nofault infrastructure by
> > > loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.
> >
> > I'm not too keen on always saving the syscall number, but for the gain
> > of getting rid of set_fs() I think it's worth it. However...
> >
> > I think there are some things to check - what value do you end up
> > with as the first number in /proc/self/syscall when you do:
> >
> > strace cat /proc/self/syscall
> >
> > ?
>
> > It should be 3, not 0x900003. I suspect you're getting the latter
> > with these changes.  IIRC, task_thread_info(task)->syscall needs to
> > be the value _without_ the offset, otherwise tracing will break.
>
> It seems broken in different ways, depending on the combination
> of kernel and userland:
>
> 1. EABI armv5-versatile kernel, EABI Debian 5:
> $ cat /proc/self/syscall
> 0 0x1500000000003 0x1500000000400 0x1500000000400 0x60000013c7800480
> 0xc0008668c0112f8c 0xc0112d14c68e1f68 0xbeab06f8 0xb6e80d4c
> $ strace -f cat /proc/self/syscall
> execve("/bin/cat", ["cat", "/proc/self/syscall"], [/* 16 vars */]) =
> -1 EINTR (Interrupted system call)
> dup(2)                                  = -1 EINTR (Interrupted system call)
> write(2, "strace: exec: Interrupted system "..., 38) = -1 EINTR
> (Interrupted system call)
> exit_group(1)                           = ?

Both the missing number and the broken strace are fixed with

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 610e32273c81..2c0bde14fba6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -226,7 +226,8 @@ ENTRY(vector_swi)
         * get the old ABI syscall table address.
         */
        bics    r10, r10, #0xff000000
-       str     r10, [tsk, #TI_SYSCALL]
+       strne   r10, [tsk, #TI_SYSCALL]
+       streq   scno, [tsk, #TI_SYSCALL]
        eorne   scno, r10, #__NR_OABI_SYSCALL_BASE
        ldrne   tbl, =sys_oabi_call_table
 #elif !defined(CONFIG_AEABI)

It was already working with CONFIG_AEABI=y and
CONFIG_OABI_COMPAT=n

> 2. EABI kernel, OABI Debian 5:
> $ cat /proc/self/syscall
> 3 0x1500000000003 0x13ccc00000400 0x1500000000400 0x60000013c7800480
> 0xc0008de0c0112f8c 0xc0112d14c7313f68 0xbeed27d0 0xb6eab324
> $ strace cat /proc/self/syscall
> execve("/bin/cat", ["cat", "/proc/self/syscall"], [/* 16 vars */]) = -1090648236
> --- SIGILL (Illegal instruction) @ 0 (0) ---
> +++ killed by SIGILL +++

This was caused by me after all, here is my fix:

--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/tracehook.h>
 #include <linux/unistd.h>

+#include <asm/syscall.h>
 #include <asm/traps.h>

 #define CREATE_TRACE_POINTS
@@ -898,11 +899,11 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
                return -1;
 #else
        /* XXX: remove this once OABI gets fixed */
-       secure_computing_strict(current_thread_info()->syscall);
+       secure_computing_strict(syscall_get_nr(current, regs));
 #endif

        /* Tracer or seccomp may have changed syscall. */
-       scno = current_thread_info()->syscall;
+       scno = syscall_get_nr(current, regs);

        if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
                trace_sys_enter(regs, scno);

> 3. OABI kernel, OABI Debian 5:
>  cat /proc/self/syscall
> 9437187 0x1500000000003 0x13ccc00000400 0x1500000000400 0x100060000013
> 0x15000c72cff6c 0xc72cfe9000000000 0xbece27d0 0xb6f2f324

This one is fixed by

--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -22,7 +22,7 @@ extern const unsigned long sys_call_table[];
 static inline int syscall_get_nr(struct task_struct *task,
                                 struct pt_regs *regs)
 {
-       if (!IS_ENABLED(CONFIG_OABI_COMPAT))
+       if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
                return task_thread_info(task)->syscall;

        return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;



I'll send an updated patch once I've addressed Christoph's comments.

      Arnd
