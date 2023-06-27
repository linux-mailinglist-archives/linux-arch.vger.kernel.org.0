Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1AC73FCF8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjF0Ni4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0Niz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 09:38:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8D2D53;
        Tue, 27 Jun 2023 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ONfW7ZUYbngvjHlHF0G9GVinOpWvFBP0ccuvAwijMK4=; b=suOH0njuOSLyoFVzo+hK1Gwuzu
        E9+kq2d6HnJaAbMMvsEL49bzebODaI8tvMCTxqZPUQaT9KQdqzq9d9Q64vq5egAC1SINmfA2ELkD1
        wdlbKIMBa4kvbkVdQaYcXm5/q5V031iw0UJe0uVjrv5sioXYN0LBM1WeomLXVcy5cdh43UfUUzhqm
        M61vx7l0xonUbIce0tKR9iVjxifpeOp0GW1rNcT2fj5314DxyRjGuIoOJn2lEK2xWGa3FMzEM7yj4
        3w+PDtN1qnT8Dt8SxKpx110Jr6NlaRSTNE01hSXINO3bU9A+y7pu92DMY0A6EodH4aLAfjRSCvlpr
        Ott/ynXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE8tw-002lB3-Vj; Tue, 27 Jun 2023 13:38:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 275673002E1;
        Tue, 27 Jun 2023 15:38:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10E7924A407F3; Tue, 27 Jun 2023 15:38:35 +0200 (CEST)
Date:   Tue, 27 Jun 2023 15:38:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        arnd@arndb.de, michael.h.kelley@microsoft.com,
        Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: Re: [EXTERNAL] Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement
 Hyper-V hypercall in sev-snp enlightened guest
Message-ID: <20230627133834.GA2412070@hirez.programming.kicks-ass.net>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
 <20230608132127.GK998233@hirez.programming.kicks-ass.net>
 <8b93aa93-903f-3a69-77f9-0c6b694d826b@gmail.com>
 <d06bb33e-047f-c849-de6a-246bc361c7af@gmail.com>
 <20230627115002.GW83892@hirez.programming.kicks-ass.net>
 <20230627120502.GFZJrQbgSgOhj/44pW@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627120502.GFZJrQbgSgOhj/44pW@fat_crate.local>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023 at 02:05:02PM +0200, Borislav Petkov wrote:
> On Tue, Jun 27, 2023 at 01:50:02PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 27, 2023 at 06:57:28PM +0800, Tianyu Lan wrote:
> > 
> > > > "There is no x86 SEV SNP feature(X86_FEATURE_SEV_SNP) flag
> > 
> > I'm sure we can arrange such a feature if we need it, this isn't rocket
> > science. Boris?
> 
> https://lore.kernel.org/r/20230612042559.375660-7-michael.roth@amd.com
> 
> > This seems to work; it's a bit magical for having a nested ALTERNATIVE
> > but the output seems correct (the outer alternative comes last in
> > .altinstructions and thus has precedence). Sure the [thunk_target] input
> > goes unsed in one of the alteratives, but who cares.
> 
> I'd like to avoid the nested alternative if not really necessary. I.e.,

I really don't see the problem with them; they work as expected.

We rely on .altinstruction order elsewhere as well.

That said; there is a tiny difference between:

ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)

and

ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
	    newinst2, flag2)

and that is alt_instr::instrlen, when the inner alternative is the
smaller, then the outer alternative will add additional padding that the
inner (obviously) doesn't know about.

However that is easily fixed. See the patch below. Boots for
x86_64-defconfig. Look at how much gunk we can delete.

> a static_call should work here too no?

static_call() looses the inline, but perhaps the function is too large
to get inlined anyway.


---
Subject: x86/alternative: Simply ALTERNATIVE_n()

Instead of making increasingly complicated ALTERNATIVE_n()
implementations, use a nested alternative expressions.

The only difference between:

  ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)

and

  ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
              newinst2, flag2)

is that the outer alternative can add additional padding when the inner
alternative is the shorter one, which results in alt_instr::instrlen
being inconsistent.

However, this is easily remedied since the alt_instr entries will be
consecutive and it is trivial to compute the max(alt_instr::instrlen) at
runtime while patching.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h | 60 +++++---------------------------------
 arch/x86/kernel/alternative.c      |  7 ++++-
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7da28fada87..16a98dd42ce0 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -171,36 +171,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
 	alt_end_marker ":\n"
 
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
-
-/*
- * Pad the second replacement alternative with additional NOPs if it is
- * additionally longer than the first replacement alternative.
- */
-#define OLDINSTR_2(oldinstr, num1, num2) \
-	"# ALT: oldinstr2\n"									\
-	"661:\n\t" oldinstr "\n662:\n"								\
-	"# ALT: padding2\n"									\
-	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
-		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
-	alt_end_marker ":\n"
-
-#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
-	"# ALT: oldinstr3\n"									\
-	"661:\n\t" oldinsn "\n662:\n"								\
-	"# ALT: padding3\n"									\
-	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")) > 0) * "							\
-		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")), 0x90\n"							\
-	alt_end_marker ":\n"
-
 #define ALTINSTR_ENTRY(ft_flags, num)					      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
@@ -222,35 +192,19 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
-#define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
-	".popsection\n"
+#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
+	ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
+		    newinst2, flag2)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-#define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
-			newinsn3, ft_flags3)				\
-	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	ALTINSTR_ENTRY(ft_flags3, 3)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinsn1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
-	".popsection\n"
+#define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
+		      newinst3, flag3)					\
+	ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
+		    newinst3, flag3)
 
 /*
  * Alternative instructions for different CPU types or capabilities.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a7e1ec50ad29..f0e34e6f01d4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -398,7 +398,7 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
+	struct alt_instr *a, *b;
 	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
 
@@ -415,6 +415,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
 
+		for (b = a+1; b < end && b->instr_offset == a->instr_offset; b++) {
+			u8 len = max(a->instrlen, b->instrlen);
+			a->instrlen = b->instrlen = len;
+		}
+
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
