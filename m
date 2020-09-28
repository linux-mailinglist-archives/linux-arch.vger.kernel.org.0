Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EB27B363
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI1Rh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 13:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgI1Rh5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 13:37:57 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF42E21941
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601314677;
        bh=NigSMLyumIm9ggwTyG5LDnbruxmBhHyjdEZJ9Az6pxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BWf0gF/1Q2N2DRi0WitlGM15dK3OoCFj7ovB6s6ZXn5zi2NKs3faVDgZTWbQcnGc0
         cGifc3fJghySiXTrJ7GmiKOHhCYNGczgcFgzS1ey7Yzx4wfjeZSNbAhghZBhCql8PV
         XM6gRGQYTk2QBxa7BidHfDlS6u3mAqGTqwZNQJ1I=
Received: by mail-wm1-f48.google.com with SMTP id b79so1992213wmb.4
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 10:37:56 -0700 (PDT)
X-Gm-Message-State: AOAM53079ATajOECvBiOn5IqYLrduoFYuJCmXQNXuNO0usRRLhikdelY
        HvI5mSgjj3ky9o2A4MOtUEzq6S49j8I7n5a5nU2sXA==
X-Google-Smtp-Source: ABdhPJz8+wjcR1Xd7cJT/xzMQ5Y823qmYExTDDQnf50+Oxufxdq2wRFjnFMC9Lbm2uLY6O2u6ua5c+9MahX9wVjYQZA=
X-Received: by 2002:a1c:740c:: with SMTP id p12mr291853wmc.176.1601314675297;
 Mon, 28 Sep 2020 10:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net> <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
In-Reply-To: <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 28 Sep 2020 10:37:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
Message-ID: <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 28, 2020 at 9:59 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
> > > On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> +
> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +               if (!cet) {
> +                       /*
> +                        * This is an unlikely case where the task is
> +                        * CET-enabled, but CET xstate is in INIT.
> +                        */
> +                       WARN_ONCE(1, "CET is enabled, but no xstates");

"unlikely" doesn't really cover this.

> +                       fpregs_unlock();
> +                       goto sigsegv;
> +               }
> +
> +               if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
> +                       cet->user_ssp += 8;

This looks buggy.  The condition should be "if SHSTK is on, then add 8
to user_ssp".  If the result is noncanonical, then some appropriate
exception should be generated, probably by the FPU restore code -- see
below.  You should be checking the SHSTK_EN bit, not SSP.

Also, can you point me to where any of these canonicality rules are
documented in the SDM?  I looked and I can't find them.


This reminds me: this code in extable.c needs to change.

__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
                                    struct pt_regs *regs, int trapnr,
                                    unsigned long error_code,
                                    unsigned long fault_addr)
{
        regs->ip = ex_fixup_addr(fixup);

        WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing
FPU registers.",
                  (void *)instruction_pointer(regs));

        __copy_kernel_to_fpregs(&init_fpstate, -1);

Now that we have supervisor states like CET, this is buggy.  This
should do something intelligent like initializing all the *user* state
and trying again.  If that succeeds, a signal should be sent rather
than just corrupting the task.  And if it fails, then perhaps some
actual intelligence is needed.  We certainly should not just disable
CET because something is wrong with the CET MSRs.
