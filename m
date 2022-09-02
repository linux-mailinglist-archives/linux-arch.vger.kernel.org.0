Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA85AB63C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiIBQJ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiIBQJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 12:09:28 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76A12DCCA;
        Fri,  2 Sep 2022 09:02:38 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MK2gh20VLz9sm9;
        Fri,  2 Sep 2022 18:00:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YNJVilXel6gn; Fri,  2 Sep 2022 18:00:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MK2gg3ygYz9sn8;
        Fri,  2 Sep 2022 18:00:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65BA58B787;
        Fri,  2 Sep 2022 18:00:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dk69SktskfzF; Fri,  2 Sep 2022 18:00:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 10DB28B764;
        Fri,  2 Sep 2022 18:00:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 282G0KMD2222677
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 18:00:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 282G0KuP2222676;
        Fri, 2 Sep 2022 18:00:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/2] powerpc/math-emu: Remove -w build flag and fix warnings
Date:   Fri,  2 Sep 2022 18:00:09 +0200
Message-Id: <2663961738a46073713786d4efeb53100ca156e7.1662134272.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <8403854a4c187459b2f4da3537f51227b70b9223.1662134272.git.christophe.leroy@csgroup.eu>
References: <8403854a4c187459b2f4da3537f51227b70b9223.1662134272.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662134391; l=10716; s=20211009; h=from:subject:message-id; bh=9BKDKnTYRn9z/fD81I7/jaKkCtvDR5jkuKtW17NTf74=; b=4rsKsUuEqQ0gWJ6plPSBabasErVHGA5UIV2av+sNnUWzgJh+Qj5IIGsEFHLkYGHmTUAdStcx0ksY iaY/ignZDLy/WUOBc1DswNtYoyI2t2LqEA9r0w21EdegYRCNkiAa
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As reported by Nathan, the module_init() macro was not taken into
account because the header was missing. That means spe_mathemu_init()
was never called.

This should have been detected by gcc at build time, but due to
'-w' flag it went undetected.

Removing that flag leads to many warnings hence errors.

Fix those warnings then remove the -w flag.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
v2: Added 3 fallthrough; in include/math-emu/op-common.h for the sake of CLANG.
---
 arch/powerpc/math-emu/Makefile   |  2 --
 arch/powerpc/math-emu/math.c     | 18 +++++-----
 arch/powerpc/math-emu/math_efp.c | 57 +++++++++++++++++---------------
 include/math-emu/op-common.h     |  3 ++
 4 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index a8794032f15f..26fef2e5672e 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -16,5 +16,3 @@ obj-$(CONFIG_SPE)		+= math_efp.o
 
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
-
-ccflags-y = -w
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 36761bd00f38..936a9a149037 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -24,9 +24,9 @@ FLOATFUNC(mtfsf);
 FLOATFUNC(mtfsfi);
 
 #ifdef CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED
-#undef FLOATFUNC(x)
+#undef FLOATFUNC
 #define FLOATFUNC(x)	static inline int x(void *op1, void *op2, void *op3, \
-						 void *op4) { }
+						 void *op4) { return 0; }
 #endif
 
 FLOATFUNC(fadd);
@@ -396,28 +396,28 @@ do_mathemu(struct pt_regs *regs)
 
 	case XCR:
 		op0 = (void *)&regs->ccr;
-		op1 = (void *)((insn >> 23) & 0x7);
+		op1 = (void *)(long)((insn >> 23) & 0x7);
 		op2 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
 		op3 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
 	case XCRL:
 		op0 = (void *)&regs->ccr;
-		op1 = (void *)((insn >> 23) & 0x7);
-		op2 = (void *)((insn >> 18) & 0x7);
+		op1 = (void *)(long)((insn >> 23) & 0x7);
+		op2 = (void *)(long)((insn >> 18) & 0x7);
 		break;
 
 	case XCRB:
-		op0 = (void *)((insn >> 21) & 0x1f);
+		op0 = (void *)(long)((insn >> 21) & 0x1f);
 		break;
 
 	case XCRI:
-		op0 = (void *)((insn >> 23) & 0x7);
-		op1 = (void *)((insn >> 12) & 0xf);
+		op0 = (void *)(long)((insn >> 23) & 0x7);
+		op1 = (void *)(long)((insn >> 12) & 0xf);
 		break;
 
 	case XFLB:
-		op0 = (void *)((insn >> 17) & 0xff);
+		op0 = (void *)(long)((insn >> 17) & 0xff);
 		op1 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index aa3bb8da1cb9..f01e3475f689 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -219,6 +219,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		case AB:
 		case XCR:
 			FP_UNPACK_SP(SA, va.wp + 1);
+			fallthrough;
 		case XB:
 			FP_UNPACK_SP(SB, vb.wp + 1);
 			break;
@@ -227,8 +228,8 @@ int do_spe_mathemu(struct pt_regs *regs)
 			break;
 		}
 
-		pr_debug("SA: %ld %08lx %ld (%ld)\n", SA_s, SA_f, SA_e, SA_c);
-		pr_debug("SB: %ld %08lx %ld (%ld)\n", SB_s, SB_f, SB_e, SB_c);
+		pr_debug("SA: %d %08x %d (%d)\n", SA_s, SA_f, SA_e, SA_c);
+		pr_debug("SB: %d %08x %d (%d)\n", SB_s, SB_f, SB_e, SB_c);
 
 		switch (func) {
 		case EFSABS:
@@ -279,7 +280,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			} else {
 				SB_e += (func == EFSCTSF ? 31 : 32);
 				FP_TO_INT_ROUND_S(vc.wp[1], SB, 32,
-						(func == EFSCTSF));
+						(func == EFSCTSF) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -288,7 +289,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			FP_CLEAR_EXCEPTIONS;
 			FP_UNPACK_DP(DB, vb.dp);
 
-			pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
+			pr_debug("DB: %d %08x %08x %d (%d)\n",
 					DB_s, DB_f1, DB_f0, DB_e, DB_c);
 
 			FP_CONV(S, D, 1, 2, SR, DB);
@@ -302,7 +303,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_ROUND_S(vc.wp[1], SB, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -313,7 +314,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_S(vc.wp[1], SB, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -323,7 +324,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		break;
 
 pack_s:
-		pr_debug("SR: %ld %08lx %ld (%ld)\n", SR_s, SR_f, SR_e, SR_c);
+		pr_debug("SR: %d %08x %d (%d)\n", SR_s, SR_f, SR_e, SR_c);
 
 		FP_PACK_SP(vc.wp + 1, SR);
 		goto update_regs;
@@ -347,6 +348,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		case AB:
 		case XCR:
 			FP_UNPACK_DP(DA, va.dp);
+			fallthrough;
 		case XB:
 			FP_UNPACK_DP(DB, vb.dp);
 			break;
@@ -355,9 +357,9 @@ int do_spe_mathemu(struct pt_regs *regs)
 			break;
 		}
 
-		pr_debug("DA: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DA: %d %08x %08x %d (%d)\n",
 				DA_s, DA_f1, DA_f0, DA_e, DA_c);
-		pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DB: %d %08x %08x %d (%d)\n",
 				DB_s, DB_f1, DB_f0, DB_e, DB_c);
 
 		switch (func) {
@@ -409,7 +411,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			} else {
 				DB_e += (func == EFDCTSF ? 31 : 32);
 				FP_TO_INT_ROUND_D(vc.wp[1], DB, 32,
-						(func == EFDCTSF));
+						(func == EFDCTSF) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -418,7 +420,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			FP_CLEAR_EXCEPTIONS;
 			FP_UNPACK_SP(SB, vb.wp + 1);
 
-			pr_debug("SB: %ld %08lx %ld (%ld)\n",
+			pr_debug("SB: %d %08x %d (%d)\n",
 					SB_s, SB_f, SB_e, SB_c);
 
 			FP_CONV(D, S, 2, 1, DR, SB);
@@ -432,7 +434,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_D(vc.dp[0], DB, 64,
-						((func & 0x1) == 0));
+						((func & 0x1) == 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -443,7 +445,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_ROUND_D(vc.wp[1], DB, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -454,7 +456,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_D(vc.wp[1], DB, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -464,7 +466,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		break;
 
 pack_d:
-		pr_debug("DR: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DR: %d %08x %08x %d (%d)\n",
 				DR_s, DR_f1, DR_f0, DR_e, DR_c);
 
 		FP_PACK_DP(vc.dp, DR);
@@ -493,6 +495,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		case XCR:
 			FP_UNPACK_SP(SA0, va.wp);
 			FP_UNPACK_SP(SA1, va.wp + 1);
+			fallthrough;
 		case XB:
 			FP_UNPACK_SP(SB0, vb.wp);
 			FP_UNPACK_SP(SB1, vb.wp + 1);
@@ -503,13 +506,13 @@ int do_spe_mathemu(struct pt_regs *regs)
 			break;
 		}
 
-		pr_debug("SA0: %ld %08lx %ld (%ld)\n",
+		pr_debug("SA0: %d %08x %d (%d)\n",
 				SA0_s, SA0_f, SA0_e, SA0_c);
-		pr_debug("SA1: %ld %08lx %ld (%ld)\n",
+		pr_debug("SA1: %d %08x %d (%d)\n",
 				SA1_s, SA1_f, SA1_e, SA1_c);
-		pr_debug("SB0: %ld %08lx %ld (%ld)\n",
+		pr_debug("SB0: %d %08x %d (%d)\n",
 				SB0_s, SB0_f, SB0_e, SB0_c);
-		pr_debug("SB1: %ld %08lx %ld (%ld)\n",
+		pr_debug("SB1: %d %08x %d (%d)\n",
 				SB1_s, SB1_f, SB1_e, SB1_c);
 
 		switch (func) {
@@ -568,7 +571,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			} else {
 				SB0_e += (func == EVFSCTSF ? 31 : 32);
 				FP_TO_INT_ROUND_S(vc.wp[0], SB0, 32,
-						(func == EVFSCTSF));
+						(func == EVFSCTSF) ? 1 : 0);
 			}
 			if (SB1_c == FP_CLS_NAN) {
 				vc.wp[1] = 0;
@@ -576,7 +579,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 			} else {
 				SB1_e += (func == EVFSCTSF ? 31 : 32);
 				FP_TO_INT_ROUND_S(vc.wp[1], SB1, 32,
-						(func == EVFSCTSF));
+						(func == EVFSCTSF) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -587,14 +590,14 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_ROUND_S(vc.wp[0], SB0, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			if (SB1_c == FP_CLS_NAN) {
 				vc.wp[1] = 0;
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_ROUND_S(vc.wp[1], SB1, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -605,14 +608,14 @@ int do_spe_mathemu(struct pt_regs *regs)
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_S(vc.wp[0], SB0, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			if (SB1_c == FP_CLS_NAN) {
 				vc.wp[1] = 0;
 				FP_SET_EXCEPTION(FP_EX_INVALID);
 			} else {
 				FP_TO_INT_S(vc.wp[1], SB1, 32,
-						((func & 0x3) != 0));
+						((func & 0x3) != 0) ? 1 : 0);
 			}
 			goto update_regs;
 
@@ -622,9 +625,9 @@ int do_spe_mathemu(struct pt_regs *regs)
 		break;
 
 pack_vs:
-		pr_debug("SR0: %ld %08lx %ld (%ld)\n",
+		pr_debug("SR0: %d %08x %d (%d)\n",
 				SR0_s, SR0_f, SR0_e, SR0_c);
-		pr_debug("SR1: %ld %08lx %ld (%ld)\n",
+		pr_debug("SR1: %d %08x %d (%d)\n",
 				SR1_s, SR1_f, SR1_e, SR1_c);
 
 		FP_PACK_SP(vc.wp, SR0);
diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 4b57bbba588a..8ce066c035cf 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -662,12 +662,14 @@ do {									\
 	if (X##_e < 0)								\
 	  {									\
 	    FP_SET_EXCEPTION(FP_EX_INEXACT);					\
+	    fallthrough;							\
 	  case FP_CLS_ZERO:							\
 	    r = 0;								\
 	  }									\
 	else if (X##_e >= rsize - (rsigned > 0 || X##_s)			\
 		 || (!rsigned && X##_s))					\
 	  {	/* overflow */							\
+	    fallthrough;							\
 	  case FP_CLS_NAN:                                                      \
 	  case FP_CLS_INF:							\
 	    if (rsigned == 2)							\
@@ -767,6 +769,7 @@ do {									\
 	if (X##_e >= rsize - (rsigned > 0 || X##_s)				\
 	    || (!rsigned && X##_s))						\
 	  {	/* overflow */							\
+	    fallthrough;							\
 	  case FP_CLS_NAN:                                                      \
 	  case FP_CLS_INF:							\
 	    if (!rsigned)							\
-- 
2.37.1

