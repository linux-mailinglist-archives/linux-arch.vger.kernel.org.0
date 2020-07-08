Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1E2187CB
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgGHMkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 08:40:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7271 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728759AbgGHMkw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 08:40:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0728392B2E12DCE78B07;
        Wed,  8 Jul 2020 20:40:46 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 20:40:39 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v5 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
Date:   Wed, 8 Jul 2020 20:40:30 +0800
Message-ID: <20200708124031.1414-2-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200708124031.1414-1-yezhenyu2@huawei.com>
References: <20200708124031.1414-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This patch detect this feature.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/sysreg.h  |  3 +++
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index d7b3bb0cb180..96fe898bfb5f 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -62,7 +62,8 @@
 #define ARM64_HAS_GENERIC_AUTH			52
 #define ARM64_HAS_32BIT_EL1			53
 #define ARM64_BTI				54
+#define ARM64_HAS_TLBI_RANGE			55
 
-#define ARM64_NCAPS				55
+#define ARM64_NCAPS				56
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 463175f80341..b4eb2e5601f2 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -617,6 +617,9 @@
 #define ID_AA64ISAR0_SHA1_SHIFT		8
 #define ID_AA64ISAR0_AES_SHIFT		4
 
+#define ID_AA64ISAR0_TLBI_RANGE_NI	0x0
+#define ID_AA64ISAR0_TLBI_RANGE		0x2
+
 /* id_aa64isar1 */
 #define ID_AA64ISAR1_I8MM_SHIFT		52
 #define ID_AA64ISAR1_DGH_SHIFT		48
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fae0efc80c1..5491bf47e62c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2058,6 +2058,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 	},
 #endif
+	{
+		.desc = "TLB range maintenance instruction",
+		.capability = ARM64_HAS_TLBI_RANGE,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR0_EL1,
+		.field_pos = ID_AA64ISAR0_TLB_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = ID_AA64ISAR0_TLBI_RANGE,
+	},
 	{},
 };
 
-- 
2.19.1


