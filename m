Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B3278E98
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIYQb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 12:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIYQbz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 12:31:55 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F0923718
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601051514;
        bh=Ik7sogL+z9aD/+1OiO4uM25gNcDglZeUy/6lyvSwMb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nm1XxwGHIt9UmR/Ifr4xaeqfrQvzLDMgtpU5lpUmSpR33k/zrqbBOn3hX+AwEosps
         2RQ7KCKnD7imgUyW9DiA/EdUWTNV7LG5Q7VMUEG/SR1m2R2ImEta9ouGe2Bl078/bI
         0V179iT1PxrQibpFo9qCprANqXPllF8qydxgC0vw=
Received: by mail-wr1-f41.google.com with SMTP id k15so4224094wrn.10
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2020 09:31:54 -0700 (PDT)
X-Gm-Message-State: AOAM530Gr+HbBvgKuIirvI3LBChWsfSMpOtGrCItJTR7yHT+eqca9rNU
        68mDbYuhqI4J2YtvegE4cBJINfVemEoyOizbz5ehSQ==
X-Google-Smtp-Source: ABdhPJwloz7GRCeaksqcAiQSK6BA/smLdlgKTRsnAcqj22VT9muQh8MWEkpeHivxaVg9kyXoGTbw7yd3PH1Uou0uWMU=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr5368504wrv.184.1601051512977;
 Fri, 25 Sep 2020 09:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200925145804.5821-1-yu-cheng.yu@intel.com> <20200925145804.5821-9-yu-cheng.yu@intel.com>
In-Reply-To: <20200925145804.5821-9-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 25 Sep 2020 09:31:40 -0700
X-Gmail-Original-Message-ID: <CALCETrXs11c8ZcB2QdWUm5CeCXRm1wo706g5J9ajR8+6yYTgtQ@mail.gmail.com>
Message-ID: <CALCETrXs11c8ZcB2QdWUm5CeCXRm1wo706g5J9ajR8+6yYTgtQ@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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

On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Vsyscall entry points are effectively branch targets.  Mark them with
> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
> and reset IBT state machine.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
> v13:
> - Check shadow stack address is canonical.
> - Change from writing to MSRs to writing to CET xstate.
>
>  arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
>  arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
>  arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
>  3 files changed, 44 insertions(+)
>
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index 44c33103a955..315ee3572664 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -38,6 +38,9 @@
>  #include <asm/fixmap.h>
>  #include <asm/traps.h>
>  #include <asm/paravirt.h>
> +#include <asm/fpu/xstate.h>
> +#include <asm/fpu/types.h>
> +#include <asm/fpu/internal.h>
>
>  #define CREATE_TRACE_POINTS
>  #include "vsyscall_trace.h"
> @@ -286,6 +289,37 @@ bool emulate_vsyscall(unsigned long error_code,
>         /* Emulate a ret instruction. */
>         regs->ip = caller;
>         regs->sp += 8;
> +
> +#ifdef CONFIG_X86_CET
> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
> +               struct cet_user_state *cet;
> +               struct fpu *fpu;
> +
> +               fpu = &tsk->thread.fpu;
> +               fpregs_lock();
> +
> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +                       copy_fpregs_to_fpstate(fpu);
> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
> +               }
> +
> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> +               if (!cet) {
> +                       fpregs_unlock();
> +                       goto sigsegv;

I *think* your patchset tries to keep cet.shstk_size and
cet.ibt_enabled in sync with the MSR, in which case it should be
impossible to get here, but a comment and a warning would be much
better than a random sigsegv.

Shouldn't we have a get_xsave_addr_or_allocate() that will never
return NULL but instead will mark the state as in use and set up the
init state if the feature was previously not in use?
