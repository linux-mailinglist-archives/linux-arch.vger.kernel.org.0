Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62217B9AC7
	for <lists+linux-arch@lfdr.de>; Sat, 21 Sep 2019 01:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404536AbfITXim (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Sep 2019 19:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405089AbfITXim (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 19:38:42 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12ED2190F
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2019 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022721;
        bh=Wik4rfMbhEVpjZ+F5SEOzlR8nFOtVPD464Wph4SfE/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k5DPMFh3AuxisWELDYJaa5j3Ulyxpef64b2q3VHCKJrgvI8ybLFvMnT2lgdVq/8TP
         CA5sfzDKaU5XattA7I43emW4xBOpxHB+cKTWLRk2wKZhFBZxvYmStQoFdnQR9XiOg2
         g4ghnMkwM69M8vhJbcyQxBqTpcPjPCl6IHSb9P8k=
Received: by mail-wm1-f49.google.com with SMTP id x2so4110735wmj.2
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2019 16:38:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWtWU+nmlFF4xwh3Z+J+4+8TymR5HD/hFtFfNHgt3xuF+9wUB9u
        4+jj+K+qMlYT+arFMgOPw2gUDwBPGkOnAprl+883Hg==
X-Google-Smtp-Source: APXvYqybrxDHlJMFvoR9P/n6cEFiVjlH/cMiyx1q8imMAGyv/bfcWbKQkMLNmHx9YXEy0qPdX2hwoYoU/AoVAGVTR9U=
X-Received: by 2002:a1c:5f0b:: with SMTP id t11mr5224781wmb.76.1569022719184;
 Fri, 20 Sep 2019 16:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150808.521907403@linutronix.de>
In-Reply-To: <20190919150808.521907403@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 16:38:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
Message-ID: <CALCETrXB92rZqHMyhSULWVY3Q5=t9q4N9aZFCTn4k0DMNPJfMQ@mail.gmail.com>
Subject: Re: [RFC patch 01/15] entry: Provide generic syscall entry functionality
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On syscall entry certain work needs to be done conditionally like tracing,
> seccomp etc. This code is duplicated in all architectures.
>
> Provide a generic version.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/Kconfig                 |    3 +
>  include/linux/entry-common.h |  122 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/Makefile              |    1
>  kernel/entry/Makefile        |    3 +
>  kernel/entry/common.c        |   33 +++++++++++
>  5 files changed, 162 insertions(+)
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -27,6 +27,9 @@ config HAVE_IMA_KEXEC
>  config HOTPLUG_SMT
>         bool
>
> +config GENERIC_ENTRY
> +       bool
> +
>  config OPROFILE
>         tristate "OProfile system profiling"
>         depends on PROFILING
> --- /dev/null
> +++ b/include/linux/entry-common.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_ENTRYCOMMON_H
> +#define __LINUX_ENTRYCOMMON_H
> +
> +#include <linux/tracehook.h>
> +#include <linux/syscalls.h>
> +#include <linux/seccomp.h>
> +#include <linux/sched.h>
> +#include <linux/audit.h>
> +
> +#include <asm/entry-common.h>
> +
> +/*
> + * Define dummy _TIF work flags if not defined by the architecture or for
> + * disabled functionality.
> + */
> +#ifndef _TIF_SYSCALL_TRACE
> +# define _TIF_SYSCALL_TRACE            (0)
> +#endif
> +
> +#ifndef _TIF_SYSCALL_EMU
> +# define _TIF_SYSCALL_EMU              (0)
> +#endif
> +
> +#ifndef _TIF_SYSCALL_TRACEPOINT
> +# define _TIF_SYSCALL_TRACEPOINT       (0)
> +#endif
> +
> +#ifndef _TIF_SECCOMP
> +# define _TIF_SECCOMP                  (0)
> +#endif
> +
> +#ifndef _TIF_AUDIT
> +# define _TIF_AUDIT                    (0)
> +#endif

I'm wondering if these should be __TIF (double-underscore) or
MAYBE_TIF_ or something to avoid errors where people do flags |=
TIF_WHATEVER and get surprised.

> +/**
> + * syscall_enter_from_usermode - Check and handle work before invoking
> + *                              a syscall
> + * @regs:      Pointer to currents pt_regs
> + * @syscall:   The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * enabled.
> + *
> + * Returns: The original or a modified syscall number
> + */

Maybe document that it can return -1 to skip the syscall and that, if
this happens, it may use syscall_set_error() or
syscall_set_return_value() first.  If neither of those is called and
-1 is returned, then the syscall will fail with ENOSYS.
