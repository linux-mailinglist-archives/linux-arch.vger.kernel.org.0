Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7902A102C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 22:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgJ3V2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 17:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgJ3V2o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 17:28:44 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8E822241;
        Fri, 30 Oct 2020 21:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604093323;
        bh=tZSPplLftF65YenDg5MlNkzy10RGzZxkh25MXH0GVn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PnRgQyolUgqkCmxzG1qYuQvzFNCGWid218+CcJ56bfcRGfXuszO7y5Pa6YL7Yze08
         J/7Tsj67hoX/Y1z9arApiqu3hxdDEUtyRhSVJltPMxBHhMPJleX9zExIEGYRtwALYT
         WM/wRk2bR5M1DT5XgRdUsyy5cegXXECSS8xLX2YE=
Received: by mail-qk1-f171.google.com with SMTP id k9so6251708qki.6;
        Fri, 30 Oct 2020 14:28:43 -0700 (PDT)
X-Gm-Message-State: AOAM533LWWoL0PXBLjvgY64ovW0oNDnxqEq0ALj7ZVc0y6hMgc6wQ5y4
        gKnz69slxqfC9cMEwzVQ/+z07NdMglggMESgAE8=
X-Google-Smtp-Source: ABdhPJwzRQW1k5B6zbrTfsf30S/rHG5MM3vjwuzzwTJuv1SPViYWCLHZOGFiwlUAQWhT5QXO52QrgMTVaMhXXk5+ufM=
X-Received: by 2002:a05:620a:215d:: with SMTP id m29mr4296031qkm.138.1604093322540;
 Fri, 30 Oct 2020 14:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201030154519.1245983-1-arnd@kernel.org> <20201030154919.1246645-1-arnd@kernel.org>
 <20201030154919.1246645-4-arnd@kernel.org> <20201030165338.GG1551@shell.armlinux.org.uk>
In-Reply-To: <20201030165338.GG1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Oct 2020 22:28:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ZCinLU0zWj9x0=QoFkrui+1QACjADzAa4yyUaO+qzXA@mail.gmail.com>
Message-ID: <CAK8P3a0ZCinLU0zWj9x0=QoFkrui+1QACjADzAa4yyUaO+qzXA@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 5:53 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Oct 30, 2020 at 04:49:14PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The system call number is used in a a couple of places, in particular
> > ptrace, seccomp and /proc/<pid>/syscall.
> >
> > The last one apparently never worked reliably on ARM for tasks
> > that are not currently getting traced.
> >
> > Storing the syscall number in the normal entry path makes it work,
> > as well as allowing us to see if the current system call is for
> > OABI compat mode, which is the next thing I want to hook into.
>
> I'm not sure this patch is correct.

I'm not following where you still see a mismatch, I was hoping I
had fixed them all after your previous review :(

The thread_info->syscall entry should now consistently contain
__NR_SYSCALL_BASE on an EABI kernel, and all users of
that should consistently mask it out.

> Tracing the existing code for OABI:
>
> asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
> {
>         current_thread_info()->syscall = scno;

This no longer stores to current_thread_info()->syscall but instead
reads the number from syscall_get_nr().

>         /* Legacy ABI only. */
> USER(   ldr     scno, [saved_pc, #-4]   )       @ get SWI instruction
>         bic     scno, scno, #0xff000000         @ mask off SWI op-code
>         eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number
>         tst     r10, #_TIF_SYSCALL_WORK         @ are we tracing syscalls?
>         bne     __sys_trace
>
> __sys_trace:
>         mov     r1, scno
>         add     r0, sp, #S_OFF
>         bl      syscall_trace_enter
>
> So, thread_info->syscall does not include __NR_SYSCALL_BASE. The
> reason for this is the code that makes use of that via syscall_get_nr().
> kernel/trace/trace_syscalls.c:

On both CONFIG_OABI_COMPAT and on !CONFIG_AEABI kernels,
I store the value before masking out __NR_SYSCALL_BASE
after my change. For EABI-only kernels there is no need for
the mask.

>         syscall_nr = trace_get_syscall_nr(current, regs);
>         if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>                 return;
>
> and NR_syscalls is the number of syscalls, which doesn't include the
> __NR_SYSCALL_BASE offset.
>
> So, I think this patch actually breaks OABI.

The value returned from trace_get_syscall_nr() is always in
the 0...NR_syscalls range without the __NR_SYSCALL_BASE
for a valid syscall. because of the added

 static inline int syscall_get_nr(struct task_struct *task,
                                 struct pt_regs *regs)
 {
-       return task_thread_info(task)->syscall;
+       return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
 }

(plus the corresponding logic for OABI_COMPAT.

Which of the above do you think I got wrong?

      Arnd
