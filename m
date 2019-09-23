Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5FDBBB1C
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 20:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437962AbfIWSSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 14:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438133AbfIWSSE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Sep 2019 14:18:04 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BD3217D7
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569262683;
        bh=KQ8YtMSUvBH+IEHZPN4F+9fUdawjUfYBpTtUWbWv5xA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EcTmLIqMPZQJAyFQKFNsUCMcomj2YImlbE7UswNurg5uOjUS7B+ZrDdmYbbiZXoSj
         7hMyu8oOOf7xnjv5MJ0jhjA717vnLvJOhZys2yHl4jCElJn2dFfYMbs+Ky4tAeStgw
         U3XBQmOfYiB7wqP6GXpDomgUvdOh8hhcEPuP3gEE=
Received: by mail-wr1-f41.google.com with SMTP id n14so15057648wrw.9
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 11:18:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVrKiIdrfGQ07nayB7t9Iy9pv5ExZghabuW2uauKEPZChZOlPN0
        f8X7hjU86WTN3t3FITCelWjbTL5qH9dLFMnu0vtmbA==
X-Google-Smtp-Source: APXvYqw9QoPpUoxk4JNixTG3ZMLD68/a+CDLIBqUsLls0MSYtDH5cRZnjxNzbm5yL+MNYc9za6vT6Uwp++RwwMYwHhA=
X-Received: by 2002:a5d:4647:: with SMTP id j7mr578006wrs.106.1569262681278;
 Mon, 23 Sep 2019 11:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150809.860645841@linutronix.de>
In-Reply-To: <20190919150809.860645841@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 11:17:50 -0700
X-Gmail-Original-Message-ID: <CALCETrWjDtcued8nYv=FtcjREz8C4Kj6OaCCirUkbZQForSo+A@mail.gmail.com>
Message-ID: <CALCETrWjDtcued8nYv=FtcjREz8C4Kj6OaCCirUkbZQForSo+A@mail.gmail.com>
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
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
> Entering a guest is similar to exiting to user space. Pending work like
> handling signals, rescheduling, task work etc. needs to be handled before
> that.
>
> Provide generic infrastructure to avoid duplication of the same handling code
> all over the place.
>
> Update ARM64 struct kvm_vcpu_stat with a signal_exit member so the generic
> code compiles.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm64/include/asm/kvm_host.h |    1
>  include/linux/entry-common.h      |   66 ++++++++++++++++++++++++++++++++++++++
>  kernel/entry/common.c             |   44 +++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -409,6 +409,7 @@ struct kvm_vcpu_stat {
>         u64 wfi_exit_stat;
>         u64 mmio_exit_user;
>         u64 mmio_exit_kernel;
> +       u64 signal_exits;
>         u64 exits;
>  };
>
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -255,4 +255,70 @@ static inline void arch_syscall_exit_tra
>  /* Common syscall exit function */
>  void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval);
>
> +#if IS_ENABLED(CONFIG_KVM)
> +
> +#include <linux/kvm_host.h>
> +
> +#ifndef ARCH_EXIT_TO_GUESTMODE_WORK
> +# define ARCH_EXIT_TO_GUESTMODE_WORK   (0)
> +#endif
> +
> +#define EXIT_TO_GUESTMODE_WORK                                         \
> +       (_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME |     \
> +        ARCH_EXIT_TO_GUESTMODE_WORK)
> +
> +int core_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +                               unsigned long ti_work);
> +
> +/**
> + * arch_exit_to_guestmode - Architecture specific exit to guest mode function
> + * @kvm:       Pointer to the guest instance
> + * @vcpu:      Pointer to current's VCPU data
> + * @ti_work:   Cached TIF flags gathered in exit_to_guestmode()
> + *
> + * Invoked from core_exit_to_guestmode_work(). Can be replaced by
> + * architecture specific code.
> + */
> +static inline int arch_exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +                                        unsigned long ti_work);

Can you add a comment about whether IRQs are supposed to be off (I
assume they are) and perhaps a lockdep assertion to verify it?
