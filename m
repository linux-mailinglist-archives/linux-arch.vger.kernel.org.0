Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0F636205
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 15:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiKWOkx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiKWOkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 09:40:52 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1722D770;
        Wed, 23 Nov 2022 06:40:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 30BCF5C019A;
        Wed, 23 Nov 2022 09:40:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Nov 2022 09:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669214448; x=1669300848; bh=n1
        WjqFYEXBYVwQe/Dpt+ETX0vIcSilwHRfofxgefvcg=; b=nOc6plIzkuhr6gXzSq
        T0clKacxYiKM+aLWK0+KaeJVgKKqByy8hNK47gofFnjNg+xoG1jREIPwugJyR+Gj
        jBQ3UzIQKGZVAtMktBE/eX32WiloIfVRPfnylerzhLmhWvSr1S6ttQ2bZRr0Hlw+
        ZjozICBNTJPIZnGC7EMbyGmp+H/K4shMsRyzvbV1mshO9pudgrUyidX0ElYncXWb
        Qoos2otcQXrqTwlh6Exm0INyEp2ntoUVDiblxVdGIFmmSLG3oaJx4PUbvQ+7tb9r
        jDZUTloRN2EpljdezK/m5TldhosDxxXRqd5IfR7iinVL4hyPjwYOX+MKpI0W8o2P
        aVpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669214448; x=1669300848; bh=n1WjqFYEXBYVwQe/Dpt+ETX0vIcS
        ilwHRfofxgefvcg=; b=ODjYSb5bi8cfFLPi6FPavL9wtWFLQJ43AtUNcK9RDN9+
        /+HKSekgxVlpz8pIsjlGoSH0diisHGRoyfgLU9eioWZePnKP7Yo5twR4Y90qcYAc
        mXSd/AlI9u7y9XbABB/1dNcE4iBbfvVFnHAYvUyStwljktpaebMflWipumDepRZy
        ml7C4/A8//z+Mql+3HEgT/mUM9vHKBrLJgmS7HwXNQAtAiCIJ1x/JR/BnzWHZ0pW
        DDBw0JXzdOtal8hpB4E5Q8jczpSjAPsxUhKtKzrgzo9yhstjPobPMyJmvpx0k7ny
        OM8hNcXSsC4xHQ6kBixHQkkbsAdXpwVX+1jiWIsaEA==
X-ME-Sender: <xms:7zB-Y9Lps2OnEh8gjdQZvkfNbGAtT5Z9ELZc2VjwkOMevQOLXEct0A>
    <xme:7zB-Y5JWOwkD82mHPQxpKEATMijrkx6kQs7Al67iYBfukJNA9-R4OdDyrJbv0Lhdn
    kOCPeRkx0sMR0iwk-8>
X-ME-Received: <xmr:7zB-Y1tgA6B6WSjWXs74VkRXwDzMZQjZE0tf5n57US6sO7Wiem6Y1KPAD6wvl-QNsEkCxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephffgffeuteehheevteefhfeihfeuhedvgfejgedt
    jeehhfdvieejkedvkeehjeefnecuffhomhgrihhnpehtuggtrghllhdrshgsnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:7zB-Y-Y0ySwOcNjAdXjKJC9oYVidvOw8UMQbkygA9h_t1vAxQTtE_g>
    <xmx:7zB-Y0bufUu9keU0djuPKePG_HiZ30ICXk6yJKKXIErCreeSUNd5RA>
    <xmx:7zB-YyD0Hybcn-wj8aOvbW9RypPaO9GMIT6NlDq0Yxe8kL6C9goScg>
    <xmx:8DB-YwKMYC_8FXM8P-TymbYVp6xeRQY9mHUpdgB0JP4dJvUqJin09Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 09:40:46 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C2AFC109A41; Wed, 23 Nov 2022 17:40:43 +0300 (+03)
Date:   Wed, 23 Nov 2022 17:40:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Message-ID: <20221123144043.ne34k5xw7dahzscq@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 23, 2022 at 01:37:26AM +0000, Dexuan Cui wrote:
> > From: Dave Hansen <dave.hansen@intel.com>
> > Sent: Monday, November 21, 2022 12:39 PM
> > [...]
> > On 11/21/22 11:51, Dexuan Cui wrote:
> > > __tdx_hypercall() doesn't work for a TDX guest running on Hyper-V,
> > > because Hyper-V uses a different calling convention, so add the
> > > new function __tdx_ms_hv_hypercall().
> > 
> > Other than R10 being variable here and fixed for __tdx_hypercall(), this
> > looks *EXACTLY* the same as __tdx_hypercall(), or at least a strict
> > subset of what __tdx_hypercall() can do.
> > 
> > Did I miss something?
> 
> The existing asm code for __tdx_hypercall() passes through R10~R15
> (see TDVMCALL_EXPOSE_REGS_MASK) to the (KVM) hypervisor.
> 
> Unluckily, for Hyper-V, we need to pass through RDX, R8, R10 and R11
> to Hyper-V, so I don't think I can use the existing __tdx_hypercall() ?
> 
> > Another way of saying this:  It seems like you could do this with a new
> > version of _tdx_hypercall() (and all in C) instead of a new
> > __tdx_hypercall().
> 
> I don't think the current TDVMCALL_EXPOSE_REGS_MASK allows me
> to pass through RDX and R8 to Hyper-V.
> 
> PS, the comment before __tdx_hypercall() contains this line:
> 
> "* RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific
> arguments."
> 
> But it looks like currently RBX an RBP are not used at all in 
> arch/x86/coco/tdx/tdcall.S ?

I have plan to expand __tdx_hypercall() to cover more registers.
See the patch below.

Is it enough for you?

---
 arch/x86/coco/tdx/tdcall.S        | 82 ++++++++++++++++++++++---------
 arch/x86/include/asm/shared/tdx.h |  6 +++
 arch/x86/kernel/asm-offsets.c     |  6 +++
 3 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb1134f22d..64e57739dc9d 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -13,6 +13,12 @@
 /*
  * Bitmasks of exposed registers (with VMM).
  */
+#define TDX_RDX		BIT(2)
+#define TDX_RBX		BIT(3)
+#define TDX_RSI		BIT(6)
+#define TDX_RDI		BIT(7)
+#define TDX_R8		BIT(8)
+#define TDX_R9		BIT(9)
 #define TDX_R10		BIT(10)
 #define TDX_R11		BIT(11)
 #define TDX_R12		BIT(12)
@@ -27,9 +33,9 @@
  * details can be found in TDX GHCI specification, section
  * titled "TDCALL [TDG.VP.VMCALL] leaf".
  */
-#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
-					  TDX_R12 | TDX_R13 | \
-					  TDX_R14 | TDX_R15 )
+#define TDVMCALL_EXPOSE_REGS_MASK	\
+	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
 
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
@@ -124,19 +130,32 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r14
 	push %r13
 	push %r12
+	push %rbx
+	push %rbp
+
+	movq %rdi, %rax
+	movq %rsi, %rbp
+
+	/* Copy hypercall registers from arg struct: */
+	movq TDX_HYPERCALL_r8(%rax),  %r8
+	movq TDX_HYPERCALL_r9(%rax),  %r9
+	movq TDX_HYPERCALL_r10(%rax), %r10
+	movq TDX_HYPERCALL_r11(%rax), %r11
+	movq TDX_HYPERCALL_r12(%rax), %r12
+	movq TDX_HYPERCALL_r13(%rax), %r13
+	movq TDX_HYPERCALL_r14(%rax), %r14
+	movq TDX_HYPERCALL_r15(%rax), %r15
+	movq TDX_HYPERCALL_rdi(%rax), %rdi
+	movq TDX_HYPERCALL_rsi(%rax), %rsi
+	movq TDX_HYPERCALL_rbx(%rax), %rbx
+	movq TDX_HYPERCALL_rdx(%rax), %rdx
+
+	push %rax
 
 	/* Mangle function call ABI into TDCALL ABI: */
 	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
 	xor %eax, %eax
 
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_HYPERCALL_r10(%rdi), %r10
-	movq TDX_HYPERCALL_r11(%rdi), %r11
-	movq TDX_HYPERCALL_r12(%rdi), %r12
-	movq TDX_HYPERCALL_r13(%rdi), %r13
-	movq TDX_HYPERCALL_r14(%rdi), %r14
-	movq TDX_HYPERCALL_r15(%rdi), %r15
-
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
 	/*
@@ -148,14 +167,14 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * HLT operation indefinitely. Since this is the not the desired
 	 * result, conditionally call STI before TDCALL.
 	 */
-	testq $TDX_HCALL_ISSUE_STI, %rsi
+	testq $TDX_HCALL_ISSUE_STI, %rbp
 	jz .Lskip_sti
 	sti
 .Lskip_sti:
 	tdcall
 
 	/*
-	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
 	 * something has gone horribly wrong with the TDX module.
 	 *
 	 * The return status of the hypercall operation is in a separate
@@ -165,30 +184,45 @@ SYM_FUNC_START(__tdx_hypercall)
 	testq %rax, %rax
 	jne .Lpanic
 
-	/* TDVMCALL leaf return code is in R10 */
-	movq %r10, %rax
+	pop %rax
 
 	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, %rsi
+	testq $TDX_HCALL_HAS_OUTPUT, %rbp
 	jz .Lout
 
-	movq %r10, TDX_HYPERCALL_r10(%rdi)
-	movq %r11, TDX_HYPERCALL_r11(%rdi)
-	movq %r12, TDX_HYPERCALL_r12(%rdi)
-	movq %r13, TDX_HYPERCALL_r13(%rdi)
-	movq %r14, TDX_HYPERCALL_r14(%rdi)
-	movq %r15, TDX_HYPERCALL_r15(%rdi)
+	movq %r8,  TDX_HYPERCALL_r8(%rax)
+	movq %r9,  TDX_HYPERCALL_r9(%rax)
+	movq %r10, TDX_HYPERCALL_r10(%rax)
+	movq %r11, TDX_HYPERCALL_r11(%rax)
+	movq %r12, TDX_HYPERCALL_r12(%rax)
+	movq %r13, TDX_HYPERCALL_r13(%rax)
+	movq %r14, TDX_HYPERCALL_r14(%rax)
+	movq %r15, TDX_HYPERCALL_r15(%rax)
+	movq %rdi, TDX_HYPERCALL_rdi(%rax)
+	movq %rsi, TDX_HYPERCALL_rsi(%rax)
+	movq %rbx, TDX_HYPERCALL_rbx(%rax)
+	movq %rdx, TDX_HYPERCALL_rdx(%rax)
 .Lout:
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
 	 * with VMM-controlled values. This needs to include all registers
-	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
-	 * context will be restored.
+	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
+	 * will be restored.
 	 */
+	xor %r8d,  %r8d
+	xor %r9d,  %r9d
 	xor %r10d, %r10d
 	xor %r11d, %r11d
+	xor %rdi,  %rdi
+	xor %rsi,  %rsi
+	xor %rdx,  %rdx
 
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %rbp
+	pop %rbx
 	pop %r12
 	pop %r13
 	pop %r14
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index e53f26228fbb..8068faa52de1 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -22,12 +22,18 @@
  * This is a software only structure and not part of the TDX module/VMM ABI.
  */
 struct tdx_hypercall_args {
+	u64 r8;
+	u64 r9;
 	u64 r10;
 	u64 r11;
 	u64 r12;
 	u64 r13;
 	u64 r14;
 	u64 r15;
+	u64 rdi;
+	u64 rsi;
+	u64 rbx;
+	u64 rdx;
 };
 
 /* Used to request services from the VMM */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 437308004ef2..cf819c5ed2de 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -81,6 +81,12 @@ static void __used common(void)
 	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
 	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
 	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
+	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
+	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
+	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
+	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
+	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
