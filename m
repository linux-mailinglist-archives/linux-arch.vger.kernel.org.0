Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F26E219E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Apr 2023 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDNLD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Apr 2023 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDNLDT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Apr 2023 07:03:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B75BA2;
        Fri, 14 Apr 2023 04:02:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a13so18430716ybl.11;
        Fri, 14 Apr 2023 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470145; x=1684062145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kx60gPyz21zGny2wq1MLpxjTHVNPSvIGV/NnpA6RLxw=;
        b=Zx4g1PuWGlVKxUqZ/0vxG2A31kxW86iABWWVampEw55ip6/zCi3nt3r0vOhp3zvmDD
         T92Ey+Q4Tctt0+ieyGwSrjfVFz4HgxG+Tc7zEdatXS4w9aP4GJI/EsGAG6Mt9YzMDyVt
         c1SsOZ2PgEVMdUgb0a2OduKxNWoPnFWA9fT6lZRixgEodT60Rgu3LpCv3XnlvqszGGtA
         PNEB+7Ug8B1kUXhNoZosWNWimBBc8JIsMcqCUjin312vt8QqrTTnlkvqrOnki6DHhI/p
         R1NA5KM35FYhKpvk/cehO++DS/xOa3/NgQeYSVSmtooErKEFPxy7kLTC1cyHwNChGbhF
         fnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470145; x=1684062145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx60gPyz21zGny2wq1MLpxjTHVNPSvIGV/NnpA6RLxw=;
        b=SsdJ29RTB/8L6UnnIS0HYbO4dwrpYftY6uk/Fwv+2uLKyd+rrX85H1oIx6ymRy8fQn
         KYRT1TT/AoM+NuNjId1RU77h3pK9YSQH93baYsLowqK76QG6KY6Vx4HmlFa2oowb2OWD
         ojhtZvnwbEQyoey11+mBX23RmlLPMMsjZoBf8fUDseoW6BWm7GYXYtBjRR77W5Iih9B/
         fMURKDprcg1nQnAFXRD+QSxr53lbBu+fDJN+XE31yr+DeDo70fUag/Kn8EEQ7q+GPaFU
         uEjUnL+lPsDXivU3U5t2XjRIKWCrUS1NLoXhvmqeRq+NCOpauHl0Sxah3+hs85sFL/sp
         hc1g==
X-Gm-Message-State: AAQBX9eiUWEE7DuhiePX1XVokX/VN5HqVu73YwYmlF0ppmpnaG/u6gDb
        SdYUmEyvCMDd9pXVVvOQC4v4qAoREmp+waeZPWA=
X-Google-Smtp-Source: AKy350Z9qTI+pWB/3eRBCRhTDkNrXv8r6Okj/HkBsJciO4o5yaCEZ/s2LvCH0gTXkrW6ehUA1rHY7STv94Z79tWto88=
X-Received: by 2002:a25:df94:0:b0:b8b:f5fb:5986 with SMTP id
 w142-20020a25df94000000b00b8bf5fb5986mr3475520ybg.10.1681470145431; Fri, 14
 Apr 2023 04:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230403174406.4180472-1-ltykernel@gmail.com> <20230403174406.4180472-14-ltykernel@gmail.com>
In-Reply-To: <20230403174406.4180472-14-ltykernel@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 14 Apr 2023 13:02:14 +0200
Message-ID: <CAM9Jb+gsHLgkqFf=ydtv4_Tr1uE5qeMQu4PhnD-aJ10OvzBbhA@mail.gmail.com>
Subject: Re: [RFC PATCH V4 13/17] x86/sev: Add Check of #HV event in path
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Add check_hv_pending() and check_hv_pending_after_irq() to
> check queued #HV event when irq is disabled.
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/entry/entry_64.S       | 18 ++++++++++++++++
>  arch/x86/include/asm/irqflags.h | 11 ++++++++++
>  arch/x86/kernel/sev.c           | 38 +++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index d877774c3141..efa56dfde19e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1073,6 +1073,15 @@ SYM_CODE_END(paranoid_entry)
>   * R15 - old SPEC_CTRL
>   */
>  SYM_CODE_START_LOCAL(paranoid_exit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       /*
> +        * If a #HV was delivered during execution and interrupts were
> +        * disabled, then check if it can be handled before the iret
> +        * (which may re-enable interrupts).
> +        */
> +       mov     %rsp, %rdi
> +       call    check_hv_pending
> +#endif
>         UNWIND_HINT_REGS
>
>         /*
> @@ -1197,6 +1206,15 @@ SYM_CODE_START(error_entry)
>  SYM_CODE_END(error_entry)
>
>  SYM_CODE_START_LOCAL(error_return)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       /*
> +        * If a #HV was delivered during execution and interrupts were
> +        * disabled, then check if it can be handled before the iret
> +        * (which may re-enable interrupts).
> +        */
> +       mov     %rsp, %rdi
> +       call    check_hv_pending
> +#endif
>         UNWIND_HINT_REGS
>         DEBUG_ENTRY_ASSERT_IRQS_OFF
>         testb   $3, CS(%rsp)
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 8c5ae649d2df..8368e3fe2d36 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -11,6 +11,10 @@
>  /*
>   * Interrupt control:
>   */
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +void check_hv_pending(struct pt_regs *regs);
> +void check_hv_pending_irq_enable(void);
> +#endif
>
>  /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
>  extern inline unsigned long native_save_fl(void);
> @@ -40,12 +44,19 @@ static __always_inline void native_irq_disable(void)
>  static __always_inline void native_irq_enable(void)
>  {
>         asm volatile("sti": : :"memory");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       check_hv_pending_irq_enable();
> +#endif
>  }
>
>  static __always_inline void native_safe_halt(void)
>  {
>         mds_idle_clear_cpu_buffers();
>         asm volatile("sti; hlt": : :"memory");
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +       check_hv_pending_irq_enable();
> +#endif
>  }
>
>  static __always_inline void native_halt(void)
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 2684a45b50a6..6445f5356c45 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -179,6 +179,44 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
>         this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>  }
>
> +static void do_exc_hv(struct pt_regs *regs)
> +{
> +       /* Handle #HV exception. */
> +}
> +
> +void check_hv_pending(struct pt_regs *regs)
> +{
> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return;
> +
> +       if ((regs->flags & X86_EFLAGS_IF) == 0)
> +               return;
> +
> +       do_exc_hv(regs);
> +}
> +
> +void check_hv_pending_irq_enable(void)
> +{
> +       struct pt_regs regs;
> +
> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return;
> +
> +       memset(&regs, 0, sizeof(struct pt_regs));
> +       asm volatile("movl %%cs, %%eax;" : "=a" (regs.cs));
> +       asm volatile("movl %%ss, %%eax;" : "=a" (regs.ss));
> +       regs.orig_ax = 0xffffffff;
> +       regs.flags = native_save_fl();
> +
> +       /*
> +        * Disable irq when handle pending #HV events after
> +        * re-enabling irq.
> +        */
> +       asm volatile("cli" : : : "memory");

Just curious, Does the hypervisor injects irqs via doorbell page when
interrupts are disabled with "cli" ? Trying to understand the need to
cli/sti covering on "do_exc_hv".

Thanks,
Pankaj

> +       do_exc_hv(&regs);
> +       asm volatile("sti" : : : "memory");
> +}
> +
>  void noinstr __sev_es_ist_exit(void)
>  {
>         unsigned long ist;
> --
> 2.25.1
>
