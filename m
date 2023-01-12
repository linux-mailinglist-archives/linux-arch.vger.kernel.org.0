Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B106266839A
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 21:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjALUL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 15:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjALUBZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 15:01:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0827E28D;
        Thu, 12 Jan 2023 12:00:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673553633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSFMK1rIzGzwTL932jNXF415JVKVles1xNGjys4yKU0=;
        b=jTjUbgU6p2aPf5TA4DXQik+3vZFGH7cZAVb6GOcwrK6WQ1JBxW2/6C2oloFxXdREJDDPCL
        kkQwQZC2ULLNvxT2ulvf6mx9n97xHK+qQpHP3Km1FKLK82mGmaexaLQvXzcLorARASLgpb
        hc/zeaHlwCNbjlsBnWqk+xz1Qe/hV7BBLA3XBCFOnU8UXscb+8yaVMc9KhtO7BDT4WdFWj
        LlfJZObawvKqhOdXtgP9oq2xowAHdmVw25GgwzmAqde3rleDeZ8YIDUMu1UfItBzoBg+nS
        EJGurVRSxgq9FnUt0OSr+JlcELbRv61SakfsjUuRl8Tpk+xRhkyzlbe4mkkWeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673553633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSFMK1rIzGzwTL932jNXF415JVKVles1xNGjys4yKU0=;
        b=0B1pSFMu/wK0JVav1pjVqrqkngsDSE55g43YcIhaMQfO0NU7pyA/9XMv2C3bvE9TGrGQs2
        BrowKCLmPgMB8VCw==
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        jinankjain@linux.microsoft.com, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: Re: [PATCH v10 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
In-Reply-To: <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
Date:   Thu, 12 Jan 2023 21:00:32 +0100
Message-ID: <87o7r3ed5r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Jinank!

On Mon, Jan 02 2023 at 07:12, Jinank Jain wrote:
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> +/*
> + * FIXME: Change this, once Microsoft Hypervisor changes its assumption
> + * around VMBus interrupt vector allocation for nested root partition.
> + * Or provides a better interface to detect this instead of hardcoding.
> + */
> +#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31

arch/x86/include/asm/irq_vectors.h line 47:

/*
 * Vectors 0x30-0x3f are used for ISA interrupts.
 *   round up to the next 16-vector boundary
 */
#define ISA_IRQ_VECTOR(irq)		(((FIRST_EXTERNAL_VECTOR + 16) & ~15) + irq)

So this overlaps with the legacy interrupt vector space.

> +#ifdef CONFIG_HYPERV
> +	/*
> +	 * This is a hack because we cannot install this interrupt handler
> +	 * via alloc_intr_gate as it does not allow interrupt vector less
> +	 * than FIRST_SYSTEM_VECTORS. And hyperv does not want anything other
> +	 * than 0x31-0x34 as the interrupt vector for vmbus interrupt in case
> +	 * of nested setup.
> +	 */
> +	INTG(HYPERV_INTR_NESTED_VMBUS_VECTOR, asm_sysvec_hyperv_nested_vmbus_intr),
> +#endif

I agree, that this is a hack, but that puts it mildly: It's a completely
broken hack.

> +DECLARE_IDTENTRY_SYSVEC(HYPERV_INTR_NESTED_VMBUS_VECTOR, sysvec_hyperv_nested_vmbus_intr);

This generates the low level entry stub for vector 0x31 at compile time,
which competes with the interrupt stub for external interrupts generated
by:

      SYM_CODE_START(irq_entries_start)


Now the above INTG() hard-codes the IDT entry for vector 0x31 into the
apic_idts table. That marks it as system vector which in turn prevents
idt_setup_apic_and_irq_gates() to install the IDT entry for the external
vector on _ALL_ systems unconditionally.

IOW, you broke world except for systems which do not use the legacy
interrupt space. Congrats!

That legacy space is hardcoded and that's clearly documented so.

0x31 becomes IRQ1 - usually the i8042 - which makes it pretty much
guaranteed that this collides and fails. The worst case consequence is a
fully uncontrolled interrupt storm which is not even detectable.

So this patch is /dev/null material and either the hypervisor side makes
it possible to use a different vector space or this needs some very
careful modifications to the legacy ISA vector assignment.

Thanks,

        tglx
