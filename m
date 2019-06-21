Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9397A4E7CE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 14:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFUMJa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 08:09:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFUMJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 08:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TLk+4THjY639lP4H3Ig0SGJVbynvk/vuhBXQ5z+cMtc=; b=hSnRTQPSKxpEbpf8hVcB69sR4
        B1SGehk3ShdniUYDS+6JkdDpGy+UMF5cv15XPf0lJ03734Jdex15xwd1CHpeEhjD5t5k2OfQKNAiP
        iERKz4RaUbK0xWCgAl15kqqG9WTK16lW6uAvBzLOr/IDOfrbfNGmLvLpW9hBZ+tcq3240y99J5Bpl
        x0BvHTpuSfBARdJH9QvgSni7VFrxlr71uY0xmTdBGiZYP2z9kw2m9gRuLmk3cI1g63CJ9VC4UxEEI
        J/wnStdlskwyE/+z90FKCzAZGpFyOi7aVpZmhD5Jij7TCcXjPwVPjeZzpL8//NDLh10/4vVc1cF4F
        Jy8vtiB4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIM9-0004Za-CW; Fri, 21 Jun 2019 12:09:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 437442021E58E; Fri, 21 Jun 2019 14:09:23 +0200 (CEST)
Date:   Fri, 21 Jun 2019 14:09:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        namit@vmware.com
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190621120923.GT3463@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
 <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
 <20190620212256.GC3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620212256.GC3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 20, 2019 at 11:22:56PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 20, 2019 at 11:48:17AM -0700, Vineet Gupta wrote:

> > I do worry about the occasional alignment induced extra NOP_S instruction (2 byte)
> > but there doesn't seem to be an easy solution. Heck if we could use the NOP_S /
> > B_S in first place. While not a clean solution by any standards, could anything be
> > done to reduce the code path of DO_ONCE() so that unlikely code is not too far off.
> 
> if one could somehow get the arch_static_branch*() things to
> conditionally emit either the 2 or 4 byte jump, depending on the offset
> (which is known there, since we stick it in the __jump_table), then we
> can have arch_jump_label_transform() use that same condition to switch
> between 2 and 4 bytes too.
> 
> I just don't know if it's possible :-/

So I had to try; but GAS macro .if directives don't like labels as
arguments, not constant enough for them.

../arch/x86/include/asm/jump_label.h:26: Error: non-constant expression in ".if" statement

Damn!

---
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -12,24 +12,19 @@
 # define STATIC_KEY_INIT_NOP GENERIC_NOP5_ATOMIC
 #endif
 
-#include <asm/asm.h>
-#include <asm/nops.h>
+asm(".include \"asm/jump_label_asm.h\"");
 
 #ifndef __ASSEMBLY__
 
 #include <linux/stringify.h>
 #include <linux/types.h>
+#include <asm/asm.h>
+#include <asm/nops.h>
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_NOP l_yes=\"%l[l_yes]\", key=\"%c0\", branch=\"%c1\""
+			  : : "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
@@ -38,57 +33,13 @@ static __always_inline bool arch_static_
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_JMP l_yes=\"%l[l_yes]\", key=\"%c0\", branch=\"%c1\""
+			  : : "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#else	/* __ASSEMBLY__ */
-
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key + 1 - .
-	.popsection
-.endm
-
-#endif	/* __ASSEMBLY__ */
-
-#endif
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_JUMP_LABEL_H */
--- /dev/null
+++ b/arch/x86/include/asm/jump_label_asm.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_JUMP_LABEL_ASM_H
+#define _ASM_X86_JUMP_LABEL_ASM_H
+
+#include <asm/asm.h>
+#include <asm/nops.h>
+
+#ifdef __ASSEMBLY__
+
+.macro STATIC_BRANCH_ENTRY l_target:req l_yes:req key:req branch:req
+	.pushsection __jump_table, "aw"
+	.long		\l_target - ., \l_yes - .
+#ifdef __X86_64__
+	.quad		(\key - .) + \branch
+#else
+	.long		(\key - .) + \branch
+#endif
+	.popsection
+.endm
+
+.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
+.Lstatic_branch_nop_\@:
+.iflt 127 - .
+	.byte 0x66, 0x90
+.else
+	.byte STATIC_KEY_INIT_NOP
+.endif
+	STATIC_BRANCH_ENTRY l_target=.Lstatic_branch_nop_\@, l_yes=\l_yes, key=\key, branch=\branch
+.endm
+
+.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
+.Lstatic_branch_jmp_\@:
+.if \l_yes - . < 127
+	.byte 0xeb
+	.byte \l_yes - (. + 1)
+.else
+	.byte 0xe9
+	.long \l_yes - (. + 4)
+.endif
+	STATIC_BRANCH_ENTRY l_target=.Lstatic_branch_jmp_\@, l_yes=\l_yes, key=\key, branch=\branch
+.endm
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_X86_JUMP_LABEL_ASM_H */
