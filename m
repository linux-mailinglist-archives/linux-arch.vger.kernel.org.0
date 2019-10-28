Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A4E7A1F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfJ1UdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 16:33:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfJ1UdA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 16:33:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so11268807wrw.13
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EwQTFZSk5O7vX7swlaOuLVLMaZkFLorXcfCxGEXx5Qo=;
        b=gOAfVpawMglDHZyrr5hx99nNlkPDeJH+UcHFvmuFudu4djfLHIZj6rLEpNTKdhq4b2
         /m/k921iasrcaLlxBKRfjNHJgCwPOdrB5YlJCHCMULiMHTZFu5TL7B8EkQnhtp5xfEQb
         LpPlrW9g9Z+gso+Hh0/+dUhoUm9OsU1eCSnafVGDSqzHLh0G7wGY8dgqecP0ZSTnjdYM
         yOwGVQ85kzjeHYdLqn2oALSNlncob1hjaj8Fbu0NiQB6qW0cvOULJ8ypxzSmAxsmV2Uf
         DlJhhS3wKCf2wtA1zSWOy/fWD3C6xDEZH+gQaW5y1vopTQ+xfGj6coQVeGJvz/EK2PP6
         CoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EwQTFZSk5O7vX7swlaOuLVLMaZkFLorXcfCxGEXx5Qo=;
        b=D97jdsG+OCf8hnvzw0jY04AsOaTRxm4L7Q62OTSzDp0ULgnqqYpv7VwBcouLcHy/Ry
         YPiCAKACUYLutzlczXva0OsCBvI5Vh8F1LzgFORiy2rS3BUjlUozKq9wJZKCIy4QA/La
         O0rUbOF9OMBP8YJa9RFYgVQ/NyVPO7aojdZXOtYxY0CmkNTP1RQ2FoEBKUyEa9fgD9P8
         nt+ONm4fC8cKsB9lzhcflckjV58gt7i4+AdCSL9fNJvVdjoACRdkUO4gjn128dwZ0uJG
         PbYJ6xEXpUUTtjUVL3Kr6WlpmWfgI9Tzy2bASGRQMjeK7R0Zgnux3/c+GUqv4k7v7xY6
         z88A==
X-Gm-Message-State: APjAAAWFowUQiLMa35XWKZXM4SbJBeet68UJF9Qb9XQcH82EGk+DvWA/
        j1WngaQoNdsox1xUP6HaPF5HQw==
X-Google-Smtp-Source: APXvYqyLBGOlH+bPmEXY+7+tPa3M41JiOd8S2fUC3UGdD2WwRX9+AKmDGwnzfi61kjv8yE1ia8Y9Nw==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr16981514wrs.345.1572294777264;
        Mon, 28 Oct 2019 13:32:57 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id q15sm7227992wrr.82.2019.10.28.13.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:32:56 -0700 (PDT)
From:   richard.henderson@linaro.org
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, Dave.Martin@arm.com,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date:   Mon, 28 Oct 2019 21:32:54 +0100
Message-Id: <20191028203254.7152-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028203254.7152-1-richard.henderson@linaro.org>
References: <20191028203254.7152-1-richard.henderson@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

Expose the ID_AA64ISAR0.RNDR field to userspace, as the
RNG system registers are always available at EL0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use __mrs_s and fix missing cc clobber (Mark),
    Log rng failures with pr_warn (Mark),
    Use __must_check; put RNDR in arch_get_random_long and RNDRRS
    in arch_get_random_seed_long (Ard),
    Use ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE, and check this_cpu_has_cap
    when reading random data.  Move everything out of line, now that
    there are 5 other function calls involved, and to unify the rate
    limiting on the pr_warn.
---
 Documentation/arm64/cpu-feature-registers.rst |  2 +
 arch/arm64/include/asm/archrandom.h           | 32 +++++++
 arch/arm64/include/asm/cpucaps.h              |  3 +-
 arch/arm64/include/asm/sysreg.h               |  4 +
 arch/arm64/kernel/cpufeature.c                | 13 +++
 arch/arm64/kernel/random.c                    | 95 +++++++++++++++++++
 arch/arm64/Kconfig                            | 12 +++
 arch/arm64/kernel/Makefile                    |  1 +
 drivers/char/Kconfig                          |  4 +-
 9 files changed, 163 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/archrandom.h
 create mode 100644 arch/arm64/kernel/random.c

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 2955287e9acc..78d6f5c6e824 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -117,6 +117,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | RNDR                         | [63-60] |    y    |
+     +------------------------------+---------+---------+
      | TS                           | [55-52] |    y    |
      +------------------------------+---------+---------+
      | FHM                          | [51-48] |    y    |
diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
new file mode 100644
index 000000000000..2f166decb7d8
--- /dev/null
+++ b/arch/arm64/include/asm/archrandom.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARCHRANDOM_H
+#define _ASM_ARCHRANDOM_H
+
+#ifdef CONFIG_ARCH_RANDOM
+
+bool __must_check arch_get_random_long(unsigned long *v);
+bool __must_check arch_get_random_int(unsigned int *v);
+bool __must_check arch_get_random_seed_long(unsigned long *v);
+bool __must_check arch_get_random_seed_int(unsigned int *v);
+
+/*
+ * These functions are technically part of the linux/random.h interface,
+ * but are not currently used.  For arm64, they're not actually usable
+ * separately from arch_get_random_long, etc, because we have to disable
+ * preemption around the per-cpu test plus the system register read.
+ * Against some future use, pretend success here, deferring failure to
+ * the actual read.
+ */
+
+static inline bool arch_has_random(void)
+{
+	return true;
+}
+
+static inline bool arch_has_random_seed(void)
+{
+	return true;
+}
+
+#endif /* CONFIG_ARCH_RANDOM */
+#endif /* _ASM_ARCHRANDOM_H */
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ac1dbca3d0cd..1dd7644bc59a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -54,7 +54,8 @@
 #define ARM64_WORKAROUND_1463225		44
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_TVM	45
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
+#define ARM64_HAS_RNG				47
 
-#define ARM64_NCAPS				47
+#define ARM64_NCAPS				48
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fafb43d..5e718f279469 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -365,6 +365,9 @@
 #define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
 #define SYS_DCZID_EL0			sys_reg(3, 3, 0, 0, 7)
 
+#define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
+#define SYS_RNDRRS_EL0			sys_reg(3, 3, 2, 4, 1)
+
 #define SYS_PMCR_EL0			sys_reg(3, 3, 9, 12, 0)
 #define SYS_PMCNTENSET_EL0		sys_reg(3, 3, 9, 12, 1)
 #define SYS_PMCNTENCLR_EL0		sys_reg(3, 3, 9, 12, 2)
@@ -539,6 +542,7 @@
 			 ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
 
 /* id_aa64isar0 */
+#define ID_AA64ISAR0_RNDR_SHIFT		60
 #define ID_AA64ISAR0_TS_SHIFT		52
 #define ID_AA64ISAR0_FHM_SHIFT		48
 #define ID_AA64ISAR0_DP_SHIFT		44
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 80f459ad0190..456d5c461cbf 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -119,6 +119,7 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
  * sync with the documentation of the CPU feature register ABI.
  */
 static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
@@ -1565,6 +1566,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
+#endif
+#ifdef CONFIG_ARCH_RANDOM
+	{
+		.desc = "Random Number Generator",
+		.capability = ARM64_HAS_RNG,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR0_EL1,
+		.field_pos = ID_AA64ISAR0_RNDR_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
 #endif
 	{},
 };
diff --git a/arch/arm64/kernel/random.c b/arch/arm64/kernel/random.c
new file mode 100644
index 000000000000..17956d3251c4
--- /dev/null
+++ b/arch/arm64/kernel/random.c
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Random number generation using ARMv8.5-RNG.
+ */
+
+#include <linux/random.h>
+#include <linux/ratelimit.h>
+#include <linux/printk.h>
+#include <linux/preempt.h>
+#include <asm/cpufeature.h>
+
+bool arch_get_random_long(unsigned long *v)
+{
+	bool ok;
+
+	preempt_disable_notrace();
+
+	ok = this_cpu_has_cap(ARM64_HAS_RNG);
+	if (ok) {
+		/*
+		 * Reads of RNDR set PSTATE.NZCV to 0b0000 on success,
+		 * and set PSTATE.NZCV to 0b0100 otherwise.
+		 */
+		asm volatile(
+			__mrs_s("%0", SYS_RNDR_EL0) "\n"
+		"	cset %w1, ne\n"
+		: "=r"(*v), "=r"(ok)
+		:
+		: "cc");
+
+		if (unlikely(!ok)) {
+			pr_warn_ratelimited("cpu%d: sys_rndr failed\n",
+					    read_cpuid_id());
+		}
+	}
+
+	preempt_enable_notrace();
+	return ok;
+}
+
+bool arch_get_random_int(unsigned int *v)
+{
+	unsigned long val;
+
+	if (arch_get_random_long(&val)) {
+		*v = val;
+		return true;
+	}
+
+	return false;
+}
+
+bool arch_get_random_seed_long(unsigned long *v)
+{
+	preempt_disable_notrace();
+
+	if (this_cpu_has_cap(ARM64_HAS_RNG)) {
+		unsigned long ok, val;
+
+		/*
+		 * Reads of RNDRRS set PSTATE.NZCV to 0b0000 on success,
+		 * and set PSTATE.NZCV to 0b0100 otherwise.
+		 */
+		asm volatile(
+			__mrs_s("%0", SYS_RNDRRS_EL0) "\n"
+		"	cset %1, ne\n"
+		: "=r"(val), "=r"(ok)
+		:
+		: "cc");
+
+		if (likely(ok)) {
+			*v = val;
+			preempt_enable_notrace();
+			return true;
+		}
+
+		pr_warn_ratelimited("cpu%d: sys_rndrrs failed\n",
+				    read_cpuid_id());
+	}
+
+	preempt_enable_notrace();
+	return false;
+}
+
+bool arch_get_random_seed_int(unsigned int *v)
+{
+	unsigned long val;
+
+	if (arch_get_random_seed_long(&val)) {
+		*v = val;
+		return true;
+	}
+
+	return false;
+}
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..5bc88601f07b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1438,6 +1438,18 @@ config ARM64_PTR_AUTH
 
 endmenu
 
+menu "ARMv8.5 architectural features"
+
+config ARCH_RANDOM
+	bool "Enable support for random number generation"
+	default y
+	help
+	  Random number generation (part of the ARMv8.5 Extensions)
+	  provides a high bandwidth, cryptographically secure
+	  hardware random number generator.
+
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 478491f07b4f..a47c2b984da7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
+obj-$(CONFIG_ARCH_RANDOM)		+= random.o
 
 obj-y					+= vdso/ probes/
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..f26a0a8cc0d0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -539,7 +539,7 @@ endmenu
 
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
-	depends on X86 || S390 || PPC
+	depends on X86 || S390 || PPC || ARM64
 	default n
 	help
 	Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
@@ -559,4 +559,4 @@ config RANDOM_TRUST_BOOTLOADER
 	device randomness. Say Y here to assume the entropy provided by the
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
-	only mixes the entropy pool.
\ No newline at end of file
+	only mixes the entropy pool.
-- 
2.17.1

