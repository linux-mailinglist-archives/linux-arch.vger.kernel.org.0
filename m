Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206F71BE010
	for <lists+linux-arch@lfdr.de>; Wed, 29 Apr 2020 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgD2OEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 10:04:31 -0400
Received: from foss.arm.com ([217.140.110.172]:39872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgD2OEa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 10:04:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9572B1045;
        Wed, 29 Apr 2020 07:04:29 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F1C3F68F;
        Wed, 29 Apr 2020 07:04:27 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:04:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/23] arm64: alternative: Allow alternative_insn to
 always issue the first instruction
Message-ID: <20200429140425.GC10651@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-2-catalin.marinas@arm.com>
 <20200427165737.GD15808@arm.com>
 <20200428114354.GE3868@gaia>
 <20200429102600.GA30377@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429102600.GA30377@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 11:26:00AM +0100, Dave P Martin wrote:
> On Tue, Apr 28, 2020 at 12:43:54PM +0100, Catalin Marinas wrote:
> > On Mon, Apr 27, 2020 at 05:57:37PM +0100, Dave P Martin wrote:
> > > On Tue, Apr 21, 2020 at 03:25:41PM +0100, Catalin Marinas wrote:
> > > > diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> > > > index 5e5dc05d63a0..67d7cc608336 100644
> > > > --- a/arch/arm64/include/asm/alternative.h
> > > > +++ b/arch/arm64/include/asm/alternative.h
> > > > @@ -111,7 +111,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
> > > >  	.byte \alt_len
> > > >  .endm
> > > >  
> > > > -.macro alternative_insn insn1, insn2, cap, enable = 1
> > > > +/*
> > > > + * Disable the whole block if enable == 0, unless first_insn == 1 in which
> > > > + * case insn1 will always be issued but without an alternative insn2.
> > > > + */
> > > > +.macro alternative_insn insn1, insn2, cap, enable = 1, first_insn = 0
> > > >  	.if \enable
> > > >  661:	\insn1
> > > >  662:	.pushsection .altinstructions, "a"
> > > > @@ -122,6 +126,8 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
> > > >  664:	.popsection
> > > >  	.org	. - (664b-663b) + (662b-661b)
> > > >  	.org	. - (662b-661b) + (664b-663b)
> > > > +	.elseif \first_insn
> > > > +	\insn1
> > > 
> > > This becomes quite unreadable at the invocation site, especially when
> > > invoked as "alternative_insn ..., 1".  "... first_insn=1" is not much
> > > better either).
> > 
> > That I agree.
> > 
> > The reason I didn't leave the alternative in place here is that if gas
> > doesn't support MTE, it will fail to compile. I wanted to avoid the
> > several #ifdef's.
> 
> We could solve that by synthesising the opcodes instead of relying on
> gas (as we do for other extensions).

While in this particular case the instruction takes only one register,
we need gas with MTE support anyway for more complex instructions in the
other .S files. I don't think it's worth the effort of writing our own
assembler in the kernel as macros.

> > While this is C code + inline asm, I'd like to have a consistent
> > behaviour of ALTERNATIVE between C and .S files. Now, given that some of
> > them (like UAO/PAN) are on by default, it probably doesn't make any
> > difference if we always keep the first block (non-alternative).
> > 
> > We could add a new macro ALTERNATIVE_OR_NOP.
> 
> alternative_insn doesn't seem exist for C at all.  Did I miss something?

There is ALTERNATIVE() which is defined for both C and asm (the latter
ends up using alternative_insn).

> > > Can we instead just always behave as if first_insn=1 instead?  This this
> > > works intuitively as an alternative, not the current weird 3-way choice
> > > between insn1, insn2 and nothing at all.  The only time that makes sense
> > > is when one of the insns is a branch that skips the block, but that's
> > > handled via the alternative_if macros instead.
> > > 
> > > Behaving always like first_insn=1 provides an if-else that is statically
> > > optimised if the relevant feature is configured out, which I think is
> > > the only thing people are ever going to want.
> > > 
> > > Maybe something depends on the current behaviour, but I can't see it so
> > > far...
> > 
> > I'll give it a go in v4 and see how it looks.
> > 
> > Another option would be an alternative_else which takes an enable
> > argument.
> 
> Sure, I think it could make sense to have a different wrapper so that
> the meaning of invocations is clearer for this special case.
> 
> 
> For the underlying macro, maybe it would be simpler to make it truly
> 3-way:
> 
> .macro alternative_insn insn_with_cap:req, insn_without_cap:req, cap:req, \
> 				enable_alternative=1, fallback_insn=

'fallback' is an option as well.

See below for what it takes to always emit the first instruction in the
alternative blocks (replacing this patch). The clear_page() zeroing line
would become:

ALTERNATIVE("dc zva, x0", "stzgm xzr, [x0]", ARM64_MTE, CONFIG_ARM64_MTE)

(or alternative_insn, the above save an IS_ENABLED).

--------8<------------------------
From 73f3869cb68fab1505d7b400ae8a39a19c5fc9e9 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 27 Nov 2019 09:07:30 +0000
Subject: [PATCH] arm64: alternative: Always emit the first instruction in
 ALTERNATIVE blocks

Currently with the ALTERNATIVE macro or alternative_insn, the cfg (or
enable) arguments disable the entire asm block. Change the macros to
only omit the alternative block on !IS_ENABLED(cfg). In addition, remove
the cfg arguments to to ALTERNATIVE in those few calls where it is still
passed. There is no change to the resulting kernel image with defconfig.

alternative_insn's enable argument will be used in a subsequent patch
and we are keeping the ALTERNATIVE C macro arguments in line with the
asm version.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/alternative.h | 13 ++++++++-----
 arch/arm64/include/asm/tlbflush.h    |  6 ++----
 arch/arm64/include/asm/uaccess.h     | 15 +++++----------
 arch/arm64/kvm/hyp/entry.S           |  2 +-
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 5e5dc05d63a0..ecb44cb0d6b1 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -66,9 +66,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
  * Alternatives with callbacks do not generate replacement instructions.
  */
 #define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"661:\n\t"							\
 	oldinstr "\n"							\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"662:\n"							\
 	".pushsection .altinstructions,\"a\"\n"				\
 	ALTINSTR_ENTRY(feature)						\
@@ -83,9 +83,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	".endif\n"
 
 #define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"661:\n\t"							\
 	oldinstr "\n"							\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"662:\n"							\
 	".pushsection .altinstructions,\"a\"\n"				\
 	ALTINSTR_ENTRY_CB(feature, cb)					\
@@ -111,9 +111,12 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.byte \alt_len
 .endm
 
+/*
+ * If enable == 0, the alternative block will be omitted.
+ */
 .macro alternative_insn insn1, insn2, cap, enable = 1
-	.if \enable
 661:	\insn1
+	.if \enable
 662:	.pushsection .altinstructions, "a"
 	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
 	.popsection
@@ -289,8 +292,8 @@ alternative_endif
  * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
  *
  * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
- * N.B. If CONFIG_FOO is specified, but not selected, the whole block
- *      will be omitted, including oldinstr.
+ * N.B. If CONFIG_FOO is specified, but not selected, the alternative block
+ *      will be omitted.
  */
 #define ALTERNATIVE(oldinstr, newinstr, ...)   \
 	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..8c79f12900ce 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -30,15 +30,13 @@
 #define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op,	       \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
+			       ARM64_WORKAROUND_REPEAT_TLBI)		       \
 			    : : )
 
 #define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op ", %0",     \
-			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
-			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
+			       ARM64_WORKAROUND_REPEAT_TLBI)		       \
 			    : : "r" (arg))
 
 #define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 32fc8061aa76..d1812cdaab01 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -45,8 +45,7 @@ static inline void set_fs(mm_segment_t fs)
 	if (IS_ENABLED(CONFIG_ARM64_UAO) && fs == KERNEL_DS)
 		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(1), ARM64_HAS_UAO));
 	else
-		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(0), ARM64_HAS_UAO,
-				CONFIG_ARM64_UAO));
+		asm(ALTERNATIVE("nop", SET_PSTATE_UAO(0), ARM64_HAS_UAO));
 }
 
 #define segment_eq(a, b)	((a) == (b))
@@ -175,28 +174,24 @@ static inline bool uaccess_ttbr0_enable(void)
 
 static inline void __uaccess_disable_hw_pan(void)
 {
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,
-			CONFIG_ARM64_PAN));
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN));
 }
 
 static inline void __uaccess_enable_hw_pan(void)
 {
-	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,
-			CONFIG_ARM64_PAN));
+	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN));
 }
 
 #define __uaccess_disable(alt)						\
 do {									\
 	if (!uaccess_ttbr0_disable())					\
-		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), alt,		\
-				CONFIG_ARM64_PAN));			\
+		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), alt));	\
 } while (0)
 
 #define __uaccess_enable(alt)						\
 do {									\
 	if (!uaccess_ttbr0_enable())					\
-		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), alt,		\
-				CONFIG_ARM64_PAN));			\
+		asm(ALTERNATIVE("nop", SET_PSTATE_PAN(0), alt));	\
 } while (0)
 
 static inline void uaccess_disable(void)
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index d22d0534dd60..88b096c18223 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -109,7 +109,7 @@ SYM_INNER_LABEL(__guest_exit, SYM_L_GLOBAL)
 
 	add	x1, x1, #VCPU_CONTEXT
 
-	ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
+	ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN)
 
 	// Store the guest regs x2 and x3
 	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(2)]
