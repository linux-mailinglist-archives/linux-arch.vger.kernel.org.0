Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5431F399
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 02:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSB0w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 20:26:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBSB0v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 20:26:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB84564ED5
        for <linux-arch@vger.kernel.org>; Fri, 19 Feb 2021 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613697971;
        bh=fJwtJB/HDR3ilN4vGWzecz9MdjUktr8sE8/8Lj+agnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NuoPwIT6jPCvq7CVpE/RtirLulnNpdzGlK68XaOpM3R2YKEuoOh4eUnIJ144K9FeD
         6mIwP/zrONWtPFo6OHrcsNp1aXfjgcNLWNwFLsX3H5Scj914pyJNKvFBWOWApvATtw
         7h6NlWL1eYUnrkN9HRAyHFOdSPrb+CXmf0yr8Sp5OFGWvade7pZLgsqt0ht7KqatCl
         CiqO6oW2LnJtN0PrpEbJXPdv8Zp4RFmd17DwZFZfaXQFJu3ESBjCDyEhmhcY+0jUQ/
         4uGPniGZBe40KP38/d4NEbZM3D1QtWNuvnMzHnZu3f71z+GXGjUUcC3uYpTQQdwWQ0
         xFTMhRK9xtSIQ==
Received: by mail-ed1-f41.google.com with SMTP id o3so6719031edv.4
        for <linux-arch@vger.kernel.org>; Thu, 18 Feb 2021 17:26:10 -0800 (PST)
X-Gm-Message-State: AOAM531vpgB3xrp5gYvFXPw9pUaMI4LQG8Ej/iFBc1O3GiCokmDyRMKY
        EVTonQcJ13uslpD2/f4EFoKlbgsBVc7eNMXKNTPxJA==
X-Google-Smtp-Source: ABdhPJz9RKmMCDP9wSoKObG17qi1NUro62wHOW6LLChZ1Op/hEl2UrY5iiGTy+gNcjBpcwId0RTiDEISDMvJE8ODtTI=
X-Received: by 2002:a05:6402:1bc7:: with SMTP id ch7mr6925128edb.84.1613697969219;
 Thu, 18 Feb 2021 17:26:09 -0800 (PST)
MIME-Version: 1.0
References: <20210203172242.29644-1-chang.seok.bae@intel.com> <20210203172242.29644-5-chang.seok.bae@intel.com>
In-Reply-To: <20210203172242.29644-5-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 18 Feb 2021 17:25:58 -0800
X-Gmail-Original-Message-ID: <CALCETrXuFrHUU-L=HMofTgEDZk9muPnVtK=EjsTHqQ01XhbRYg@mail.gmail.com>
Message-ID: <CALCETrXuFrHUU-L=HMofTgEDZk9muPnVtK=EjsTHqQ01XhbRYg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] x86/signal: Detect and prevent an alternate signal
 stack overflow
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 3, 2021 at 9:27 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The kernel pushes context on to the userspace stack to prepare for the
> user's signal handler. When the user has supplied an alternate signal
> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> stack size is sufficient for the current hardware context.
>
> Check if writing the hardware context to the alternate stack will exceed
> it's size. If yes, then instead of corrupting user-data and proceeding with
> the original signal handler, an immediate SIGSEGV signal is delivered.
>
> While previous patches in this series allow new source code to discover and
> use a sufficient alternate signal stack size, this check is still necessary
> to protect binaries with insufficient alternate signal stack size from data
> corruption.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v3:
> * Updated the changelog (Borislav Petkov)
>
> Changes from v2:
> * Simplified the implementation (Jann Horn)
> ---
>  arch/x86/kernel/signal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 0d24f64d0145..8e2df070dbfd 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -242,7 +242,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>         unsigned long math_size = 0;
>         unsigned long sp = regs->sp;
>         unsigned long buf_fx = 0;
> -       int onsigstack = on_sig_stack(sp);
> +       bool onsigstack = on_sig_stack(sp);
>         int ret;
>
>         /* redzone */
> @@ -251,8 +251,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>
>         /* This is the X/Open sanctioned signal stack switching.  */
>         if (ka->sa.sa_flags & SA_ONSTACK) {
> -               if (sas_ss_flags(sp) == 0)
> +               if (sas_ss_flags(sp) == 0) {
>                         sp = current->sas_ss_sp + current->sas_ss_size;
> +                       /* On the alternate signal stack */
> +                       onsigstack = true;

This is buggy.  The old code had a dubious special case for
SS_AUTODISARM, and this interacts poorly with it.  I think you could
fix it by separating the case in which you are already on the altstack
from the case in which you're switching to the altstack, or you could
fix it by changing the check at the end of the function to literally
check whether the sp value is in bounds instead of calling
on_sig_stack.

Arguably the generic helpers could be adjusted to make this less annoying.
