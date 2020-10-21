Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECD294B6B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410396AbgJUKqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 06:46:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410333AbgJUKqp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 06:46:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D701C1042;
        Wed, 21 Oct 2020 03:46:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C1A43F66E;
        Wed, 21 Oct 2020 03:46:43 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Date:   Wed, 21 Oct 2020 11:46:11 +0100
Message-Id: <20201021104611.2744565-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021104611.2744565-1-qais.yousef@arm.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So that userspace can detect if the cpu has aarch32 support at EL0.

CPUREGS_ATTR_RO() was renamed to CPUREGS_RAW_ATTR_RO() to better reflect
what it does. And fixed to accept both u64 and u32 without causing the
printf to print out a warning about mismatched type. This was caught
while testing to check the new CPUREGS_USER_ATTR_RO().

The new CPUREGS_USER_ATTR_RO() exports a Sanitised or RAW sys_reg based
on a @cond to user space. The exported fields match the definition in
arm64_ftr_reg so that the content of a register exported via MRS and
sysfs are kept cohesive.

The @cond in our case is that the system is asymmetric aarch32 and the
controlling sysctl.enable_asym_32bit is enabled.

Update Documentation/arm64/cpu-feature-registers.rst to reflect the
newly visible EL0 field in ID_AA64FPR0_EL1.

Note that the MRS interface will still return the sanitized content
_only_.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

Example output. I was surprised that the 2nd field (bits[7:4]) is printed out
although it's set as FTR_HIDDEN.

# cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
0x0000000000000011
0x0000000000000011
0x0000000000000011
0x0000000000000011
0x0000000000000011
0x0000000000000011

# echo 1 > /proc/sys/kernel/enable_asym_32bit

# cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
0x0000000000000011
0x0000000000000011
0x0000000000000012
0x0000000000000012
0x0000000000000011
0x0000000000000011

 Documentation/arm64/cpu-feature-registers.rst |  2 +-
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/kernel/cpuinfo.c                   | 58 +++++++++++++++++--
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index f28853f80089..bfcbda6d6f35 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -166,7 +166,7 @@ infrastructure:
      +------------------------------+---------+---------+
      | EL1                          | [7-4]   |    n    |
      +------------------------------+---------+---------+
-     | EL0                          | [3-0]   |    n    |
+     | EL0                          | [3-0]   |    y    |
      +------------------------------+---------+---------+
 
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f795c8221f4..0f7307c8ad80 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -221,7 +221,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL2_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
 	ARM64_FTR_END,
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 93c55986ca7f..632b9d5b5230 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -231,25 +231,71 @@ static struct kobj_type cpuregs_kobj_type = {
  * future expansion without an ABI break.
  */
 #define kobj_to_cpuinfo(kobj)	container_of(kobj, struct cpuinfo_arm64, kobj)
-#define CPUREGS_ATTR_RO(_name, _field)						\
+#define CPUREGS_RAW_ATTR_RO(_name, _field)				\
 	static ssize_t _name##_show(struct kobject *kobj,			\
 			struct kobj_attribute *attr, char *buf)			\
 	{									\
 		struct cpuinfo_arm64 *info = kobj_to_cpuinfo(kobj);		\
 										\
-		if (info->reg_midr)						\
-			return sprintf(buf, "0x%016x\n", info->reg_##_field);	\
-		else								\
+		if (info->reg_midr) {						\
+			u64 val = info->reg_##_field;				\
+			return sprintf(buf, "0x%016llx\n", val);		\
+		} else {							\
 			return 0;						\
+		}								\
 	}									\
 	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
 
-CPUREGS_ATTR_RO(midr_el1, midr);
-CPUREGS_ATTR_RO(revidr_el1, revidr);
+/*
+ * Expose the Sanitized or RAW user space visible fields of a sys_register
+ * based @cond.
+ *
+ * if (@cond)
+ *	expose raw register & user_mask
+ * else
+ *	expose sanitized register & user_mask
+ *
+ * user_mask is based on arm64_ftr_reg definition.
+ */
+#define CPUREGS_USER_ATTR_RO(_name, _raw_field, _san_id, cond)			\
+	static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)			\
+	{									\
+		u64 val = 0;							\
+										\
+		if (cond) {							\
+			struct arm64_ftr_reg *reg = get_arm64_ftr_reg(_san_id);	\
+			struct cpuinfo_arm64 *info = kobj_to_cpuinfo(kobj);	\
+										\
+			if (!reg)						\
+				return 0;					\
+										\
+			if (info->reg_midr) {					\
+				val = info->reg_##_raw_field & reg->user_mask;	\
+				val |= reg->user_val;				\
+				return sprintf(buf, "0x%016llx\n", val);	\
+			} else {						\
+				return 0;					\
+			}							\
+		} else {							\
+			val = 0;						\
+			if (!emulate_sys_reg(_san_id, &val)) {			\
+				return sprintf(buf, "0x%016llx\n", val);	\
+			} else {						\
+				return 0;					\
+			}							\
+		}								\
+	}									\
+	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
+
+CPUREGS_RAW_ATTR_RO(midr_el1, midr);
+CPUREGS_RAW_ATTR_RO(revidr_el1, revidr);
+CPUREGS_USER_ATTR_RO(id_aa64pfr0, id_aa64pfr0, SYS_ID_AA64PFR0_EL1, system_supports_asym_32bit_el0());
 
 static struct attribute *cpuregs_id_attrs[] = {
 	&cpuregs_attr_midr_el1.attr,
 	&cpuregs_attr_revidr_el1.attr,
+	&cpuregs_attr_id_aa64pfr0.attr,
 	NULL
 };
 
-- 
2.25.1

