Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C773C64102F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLBVsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 16:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiLBVrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 16:47:55 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329031128;
        Fri,  2 Dec 2022 13:47:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4BC8B320091B;
        Fri,  2 Dec 2022 16:47:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Dec 2022 16:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670017666; x=1670104066; bh=JB
        VDtu38LeFB5nSSjItviv90aFCAl1CdWcwU6/jpxG0=; b=LFj6Haobo0ntdgGce6
        fcxZeLAIy8ADoYy71k8+4ZsT2PEPju8IuqEVdlGEolgkZKTN/3qqNI0VKLO65mmX
        a9oOCr9Zpgzt6jjDFDdgpXyGtMFA27l8ZmUNWx3Nx+JMEcRNS/omGrw5Jh9z1Bjx
        ppoAai0lW9TAhoKkgxYHvj597NloJVehLA0aR6kCJz2akvqotQha+Gkk9aGCyHoA
        pFzioo+PmKLIaFL6sMk9Vd90ccoBExxdjQd0Plew5TST3tkzc8fANY09IJnwGVvs
        Ojh+Itw+cI6xMhB0Usr06dr27hf3hWd9tO2+aDfynVKuSqtbvM2A4fpMHnPt6FNF
        22Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670017666; x=1670104066; bh=JBVDtu38LeFB5nSSjItviv90aFCA
        l1CdWcwU6/jpxG0=; b=jTi0A3ARIWABQTDm1XZ4c9i/gGhVacveUIB7xz6PvpGE
        xfJDHsQOeSh90YweFgZDj0pnJRxa3MAg1j8sVKibKn9y3+hrbetZ7FQMV2tzg+6F
        BZ93FxU7t8P8ZzgPtLLYbovypnLj0Z47u/K69nbobXL18ZKAOqOwVcS7onOYCVI8
        otVgdGjnlCdoFXxrdOc0mUiOA+YRePODM+7Pma+yy/LMwihN5ajqGpr+4I4CMNFU
        aVH845Ik0W1G0DPf+LYSLZU5mvuZCHoXbyZclaIjdYdh30U/+TgEcEGIX4EeB0RJ
        4VZuc2j4lAWMo/s5XUzPfKHBPRNuQZBSwsXaoKe7EA==
X-ME-Sender: <xms:gXKKYzO7NC0ViI7ylIIclOclJY7DRlGWsZZJ6njoEthHqqIw3wquDg>
    <xme:gXKKY9-inbRzBqwRBLIKJOPjGQJIb7rE87S7NDOzIh7RpxeszQ-sgI5uahctQbiT8
    deIynGWh2ss9h0Q78c>
X-ME-Received: <xmr:gXKKYyQLZwbJHBXsiIY_TrH2F_dmeWyyTS-aLgQHD32c60327t-868le8RpD1ahtoIEwag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfddkmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvkddfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeevfeeltdfhffevfeeuveehkeffueelkeei
    feegieekjedugedvudejiefgheffudenucffohhmrghinhepthgutggrlhhlrdhssgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:gXKKY3uC9Q_TNvuJ5mM6TqEAY8kivsFSfIcnsY6NKsZOcRuK1J7LHg>
    <xmx:gXKKY7fUao4dnX11KMFGnTwmMR5i-mTb7hFwnhjgrUoxF7tpXSPuVw>
    <xmx:gXKKYz2YM-otuq_AYPHWZRFTwvHabkmT9iV1748dt63W-x0oLvxZaA>
    <xmx:gnKKY0tPBkfI1jriP2HDby0ePLv4BmVpiU2PUJLXDAV8pIBc-4uGVw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 16:47:45 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0AA2A10975F; Sat,  3 Dec 2022 00:47:42 +0300 (+03)
Date:   Sat, 3 Dec 2022 00:47:41 +0300
From:   "'Kirill A. Shutemov'" <kirill@shutemov.name>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     'Dave Hansen' <dave.hansen@intel.com>,
        "'ak@linux.intel.com'" <ak@linux.intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>, "'bp@alien8.de'" <bp@alien8.de>,
        "'brijesh.singh@amd.com'" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'jane.chu@oracle.com'" <jane.chu@oracle.com>,
        "'kirill.shutemov@linux.intel.com'" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        "'luto@kernel.org'" <luto@kernel.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'sathyanarayanan.kuppuswamy@linux.intel.com'" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "'seanjc@google.com'" <seanjc@google.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'wei.liu@kernel.org'" <wei.liu@kernel.org>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Message-ID: <20221202214741.7vfmqgvgubxqffen@box.shutemov.name>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144043.ne34k5xw7dahzscq@box.shutemov.name>
 <SA1PR21MB1335EEEC1DE4CB42F6477A5EBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <SA1PR21MB133594060B7EB17CF1FDBD95BF159@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB133594060B7EB17CF1FDBD95BF159@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 30, 2022 at 07:14:49PM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Wednesday, November 23, 2022 10:55 AM
> > To: Kirill A. Shutemov <kirill@shutemov.name>
> > 
> > > From: Kirill A. Shutemov <kirill@shutemov.name>
> > > Sent: Wednesday, November 23, 2022 6:41 AM
> > > [...]
> > > I have plan to expand __tdx_hypercall() to cover more registers.
> > > See the patch below.
> > 
> > Great! Thank you!
> > 
> > > Is it enough for you?
> > Yes.
> 
> Hi Kirill, it would be great if you could post a formal patch so that
> I can rebase my patchset accordingly.

The patch doesn't make sense without a user. The use-case I wanted to use
it for awaits update of GHCI. It make take time.

Below is proper patch. Feel free to include it into your patchset.

From fdf892e8f84c98e4cb7f3f7a613f32c8da396bd7 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 23 Nov 2022 07:31:05 +0300
Subject: [PATCH] x86/tdx: Expand __tdx_hypercall() to handle more arguments

So far __tdx_hypercall() only handles six arguments for VMCALL.
Expanding it to six more register would allow to cover more use-cases.

Using RDI and RSI as VMCALL arguments requires more register shuffling.
RAX is used to hold tdx_hypercall_args pointer and RBP stores flags.

While there, fix typo in the comment on panic branch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index 437308004ef2..9f09947495e2 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -75,12 +75,18 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
 
 	BLANK();
+	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
+	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
 	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
 	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
 	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
 	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
 	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
 	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
+	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
+	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
+	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
+	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
 
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
