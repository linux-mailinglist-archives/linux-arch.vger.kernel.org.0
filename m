Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED8355EF4
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 00:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbhDFWtx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 18:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344099AbhDFWtw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 18:49:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A908B613EE
        for <linux-arch@vger.kernel.org>; Tue,  6 Apr 2021 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617749383;
        bh=a1o900AcqYwmW0fqkduPTeR3emc4C6Rs1gEIEqdiYaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEGDvjznudoHSkkT4y8V8E5/qd3x4roetFh+RpuJqloQCxb5ul1FSIFFwdyhhkCVE
         CW+F27jDoneZukSbicGCRN0vGYvja89yI0gmXYVVfuw1C0Nr1UXKNB5y8Vl78J6HXr
         YVwxAmbmm/iDQRLgUSYRZ6JfQoPE8yzmWh+bF1mVeJMCO2LkQKYupqhwy/3q3oHsWh
         2Q2DIi5sxyP4cK22nuF0G4d/q3HAxigzoqqsaHEGuTYL5a9sYWneu4cyHAHjroNHJB
         7Uie18iRLZqlQprOAHclOsKzv3IxX7iNngvfGKiu/X/4R8II/8UNOZd1jg+V8wzCer
         Mv1NB0hkTDMYQ==
Received: by mail-ed1-f41.google.com with SMTP id ba6so10939252edb.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Apr 2021 15:49:43 -0700 (PDT)
X-Gm-Message-State: AOAM532kR/jeMdIXvrnaBm6wu7UYK+eCKFs4WzUkmhzn3ObxPinzQ2MP
        lzap34fHX8QtO1wr4mjoKlbnyECzqcVHVP1+PKlwBw==
X-Google-Smtp-Source: ABdhPJwKOmYqoxCioac2TWNaDNZOT88xkRzZYjrRVTEBe+20+kIF/hfmpbTf57P7Ofjo4GQDMBsu3KVolwUAhM7TefM=
X-Received: by 2002:a50:fa92:: with SMTP id w18mr790243edr.172.1617749382023;
 Tue, 06 Apr 2021 15:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210401221104.31584-1-yu-cheng.yu@intel.com> <20210401221104.31584-25-yu-cheng.yu@intel.com>
In-Reply-To: <20210401221104.31584-25-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 6 Apr 2021 15:49:30 -0700
X-Gmail-Original-Message-ID: <CALCETrWf4=1KPYvwpO6KJETZHMHUA6z7rH7nx=SU9gsJSOTXPg@mail.gmail.com>
Message-ID: <CALCETrWf4=1KPYvwpO6KJETZHMHUA6z7rH7nx=SU9gsJSOTXPg@mail.gmail.com>
Subject: Re: [PATCH v24 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 3:12 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack.  This is distinctively different from other pointers
> on the shadow stack, since those pointers point to executable code area.
>
> The restore token can be used as an extra protection for signal handling.
> To deliver a signal, create a shadow stack restore token and put the token
> and the signal restorer address on the shadow stack.  In sigreturn, verify
> the token and restore from it the shadow stack pointer.
>
> Introduce token setup and verify routines.  Also introduce WRUSS, which is
> a kernel-mode instruction but writes directly to user shadow stack.  It is
> used to construct user signal stack as described above.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/cet.h           |   9 ++
>  arch/x86/include/asm/special_insns.h |  32 +++++++
>  arch/x86/kernel/shstk.c              | 126 +++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 8b83ded577cc..ef6155213b7e 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -20,6 +20,10 @@ int shstk_setup_thread(struct task_struct *p, unsigned long clone_flags,
>                        unsigned long stack_size);
>  void shstk_free(struct task_struct *p);
>  void shstk_disable(void);
> +int shstk_setup_rstor_token(bool ia32, unsigned long rstor,
> +                           unsigned long *token_addr, unsigned long *new_ssp);
> +int shstk_check_rstor_token(bool ia32, unsigned long token_addr,
> +                           unsigned long *new_ssp);
>  #else
>  static inline int shstk_setup(void) { return 0; }
>  static inline int shstk_setup_thread(struct task_struct *p,
> @@ -27,6 +31,11 @@ static inline int shstk_setup_thread(struct task_struct *p,
>                                      unsigned long stack_size) { return 0; }
>  static inline void shstk_free(struct task_struct *p) {}
>  static inline void shstk_disable(void) {}
> +static inline int shstk_setup_rstor_token(bool ia32, unsigned long rstor,
> +                                         unsigned long *token_addr,
> +                                         unsigned long *new_ssp) { return 0; }
> +static inline int shstk_check_rstor_token(bool ia32, unsigned long token_addr,
> +                                         unsigned long *new_ssp) { return 0; }
>  #endif
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 1d3cbaef4bb7..c41c371f6c7d 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -234,6 +234,38 @@ static inline void clwb(volatile void *__p)
>                 : [pax] "a" (p));
>  }
>
> +#ifdef CONFIG_X86_SHADOW_STACK
> +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)

u32 __user *addr?

> +{
> +       asm_volatile_goto("1: wrussd %1, (%0)\n"
> +                         _ASM_EXTABLE(1b, %l[fail])
> +                         :: "r" (addr), "r" (val)
> +                         :: fail);
> +       return 0;
> +fail:
> +       return -EPERM;

-EFAULT?

> +}
> +#else
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +       WARN_ONCE(1, "%s used but not supported.\n", __func__);
> +       return -EFAULT;
> +}
> +#endif
> +
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)

u64 __user *addr, perhaps?

> +{
> +       asm_volatile_goto("1: wrussq %1, (%0)\n"
> +                         _ASM_EXTABLE(1b, %l[fail])
> +                         :: "r" (addr), "r" (val)

Can you use the modern [addr] "r" (addr) syntax?
