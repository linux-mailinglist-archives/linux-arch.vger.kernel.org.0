Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C574D30C3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJJSpy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:45:54 -0400
Received: from foss.arm.com ([217.140.110.172]:38488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfJJSpy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CDD71000;
        Thu, 10 Oct 2019 11:45:53 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D5CB3F703;
        Thu, 10 Oct 2019 11:45:50 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/12] arm64: BTI: Decode BYTPE bits when printing PSTATE
Date:   Thu, 10 Oct 2019 19:44:36 +0100
Message-Id: <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current code to print PSTATE symbolically when generating
backtraces etc., does not include the BYTPE field used by Branch
Target Identification.

So, decode BYTPE and print it too.

In the interests of human-readability, print the classes of BTI
matched.  The symbolic notation, BYTPE (PSTATE[11:10]) and
permitted classes of subsequent instruction are:

    -- (BTYPE=0b00): any insn
    jc (BTYPE=0b01): BTI jc, BTI j, BTI c, PACIxSP
    -c (BYTPE=0b10): BTI jc, BTI c, PACIxSP
    j- (BTYPE=0b11): BTI jc, BTI j

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v1:

 * Add convenience definitions for all the BTYPE codes, even if we
   don't directly use them all yet.

 * For consistency, align PSR_BTYPE_foo names with the above print
   format:

      PSR_BTYPE_NONE -> -- (BTYPE=0b00)
      PSR_BTYPE_JC -> jc (BTYPE=0b01)
      etc.
---
 arch/arm64/include/asm/ptrace.h |  7 ++++++-
 arch/arm64/kernel/process.c     | 17 +++++++++++++++--
 arch/arm64/kernel/signal.c      |  2 +-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 7d4cd59..212bba1 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -38,7 +38,12 @@
 #define PSR_BTYPE_SHIFT		10
 
 #define PSR_IL_BIT		(1 << 20)
-#define PSR_BTYPE_CALL		(2 << PSR_BTYPE_SHIFT)
+
+/* Convenience names for the values of PSTATE.BTYPE */
+#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)
 
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4c78937..a2b555a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -209,6 +209,15 @@ void machine_restart(char *cmd)
 	while (1);
 }
 
+#define bstr(suffix, str) [PSR_BTYPE_ ## suffix >> PSR_BTYPE_SHIFT] = str
+static const char *const btypes[] = {
+	bstr(NONE, "--"),
+	bstr(  JC, "jc"),
+	bstr(   C, "-c"),
+	bstr(  J , "j-")
+};
+#undef bstr
+
 static void print_pstate(struct pt_regs *regs)
 {
 	u64 pstate = regs->pstate;
@@ -227,7 +236,10 @@ static void print_pstate(struct pt_regs *regs)
 			pstate & PSR_AA32_I_BIT ? 'I' : 'i',
 			pstate & PSR_AA32_F_BIT ? 'F' : 'f');
 	} else {
-		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
+		const char *btype_str = btypes[(pstate & PSR_BTYPE_MASK) >>
+					       PSR_BTYPE_SHIFT];
+
+		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO BTYPE=%s)\n",
 			pstate,
 			pstate & PSR_N_BIT ? 'N' : 'n',
 			pstate & PSR_Z_BIT ? 'Z' : 'z',
@@ -238,7 +250,8 @@ static void print_pstate(struct pt_regs *regs)
 			pstate & PSR_I_BIT ? 'I' : 'i',
 			pstate & PSR_F_BIT ? 'F' : 'f',
 			pstate & PSR_PAN_BIT ? '+' : '-',
-			pstate & PSR_UAO_BIT ? '+' : '-');
+			pstate & PSR_UAO_BIT ? '+' : '-',
+			btype_str);
 	}
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 4a3bd32..452ac5b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -732,7 +732,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 	if (system_supports_bti()) {
 		regs->pstate &= ~PSR_BTYPE_MASK;
-		regs->pstate |= PSR_BTYPE_CALL;
+		regs->pstate |= PSR_BTYPE_C;
 	}
 
 	if (ka->sa.sa_flags & SA_RESTORER)
-- 
2.1.4

