Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF66667C93
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjALRdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 12:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjALRdT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 12:33:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571669B21;
        Thu, 12 Jan 2023 08:56:55 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D6BD1EC064D;
        Thu, 12 Jan 2023 17:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673542081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fWLixZfsSchjFbcCFffZRLC8clKaznVXLrwohAMTYUE=;
        b=JlC5CkuWVfA3Nbv9OZsp2q57S4fDlbnO9lWnOlQl3sUvPQCuFuL3gLQFD2GYqSVJC6Y6od
        MrungAaDu3mtxeXWt+Rer4rkpCH5GpRSk/ZZlGxZT7UfsRoAdcbLcXGnpE1g5t/LEWTKAx
        SAdwPKPnS/Zftj6TH4PZIwWjadFGQ7c=
Date:   Thu, 12 Jan 2023 17:47:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v10 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Message-ID: <Y8A5vXKBq1T+JXfo@zn.tnic>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 02, 2023 at 07:12:55AM +0000, Jinank Jain wrote:
> Traditionally we have been using the HYPERVISOR_CALLBACK_VECTOR to relay

Who's "we"?

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> the VMBus interrupt. But this does not work in case of nested
> hypervisor. Microsoft Hypervisor reserves 0x31 to 0x34 as the interrupt
> vector range for VMBus and thus we have to use one of the vectors from
> that range and setup the IDT accordingly.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/idtentry.h    |  2 ++
>  arch/x86/include/asm/irq_vectors.h |  6 ++++++
>  arch/x86/kernel/cpu/mshyperv.c     | 15 +++++++++++++++
>  arch/x86/kernel/idt.c              | 10 ++++++++++
>  drivers/hv/vmbus_drv.c             |  3 ++-
>  5 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 72184b0b2219..c0648e3e4d4a 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -686,6 +686,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_INTR_NESTED_VMBUS_VECTOR,
> +			sysvec_hyperv_nested_vmbus_intr);
>  #endif
>  
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 43dcb9284208..729d19eab7f5 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -102,6 +102,12 @@
>  #if IS_ENABLED(CONFIG_HYPERV)
>  #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
>  #define HYPERV_STIMER0_VECTOR		0xed
> +/*
> + * FIXME: Change this, once Microsoft Hypervisor changes its assumption
      ^^^^^^

This patch looks like it is not ready to go anywhere yet...

> + * around VMBus interrupt vector allocation for nested root partition.

When is that going to happen? If at all...

> + * Or provides a better interface to detect this instead of hardcoding.
> + */
> +#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31
>  #endif
>  
>  #define LOCAL_TIMER_VECTOR		0xec
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 938fc82edf05..4dfe0f9d7be3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -126,6 +126,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	set_irq_regs(old_regs);
>  }
>  
> +DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_nested_vmbus_intr)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	inc_irq_stat(irq_hv_callback_count);
> +
> +	if (vmbus_handler)
> +		vmbus_handler();
> +
> +	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
> +		ack_APIC_irq();
> +
> +	set_irq_regs(old_regs);
> +}
> +
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  	vmbus_handler = handler;
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index a58c6bc1cd68..3536935cea39 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -160,6 +160,16 @@ static const __initconst struct idt_data apic_idts[] = {
>  # endif
>  	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
>  	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
> +#ifdef CONFIG_HYPERV
> +	/*
> +	 * This is a hack because we cannot install this interrupt handler
> +	 * via alloc_intr_gate as it does not allow interrupt vector less
> +	 * than FIRST_SYSTEM_VECTORS. And hyperv does not want anything other
> +	 * than 0x31-0x34 as the interrupt vector for vmbus interrupt in case

Well:

/*
 * IDT vectors usable for external interrupt sources start at 0x20.
 * (0x80 is the syscall vector, 0x30-0x3f are for ISA)
				^^^^^^^^^^^^^^^^^^^^^^

 */
#define FIRST_EXTERNAL_VECTOR		0x20

I guess HyperV decided to reuse those...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
