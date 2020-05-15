Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21481D574E
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEORRL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEORRK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:17:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC414113E;
        Fri, 15 May 2020 10:17:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 339633F305;
        Fri, 15 May 2020 10:17:08 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE support
Date:   Fri, 15 May 2020 18:16:10 +0100
Message-Id: <20200515171612.1020-25-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For performance analysis it may be desirable to disable MTE altogether
via an early param. Introduce arm64.mte_disable and, if true, filter out
the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
user.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    New in v4.

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8679e8..7436e7462b85 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -373,6 +373,10 @@
 	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
 			Format: <io>,<irq>,<nodeID>
 
+	arm64.mte_disable=
+			[ARM64] Disable Linux support for the Memory
+			Tagging Extension (both user and in-kernel).
+
 	ataflop=	[HW,M68k]
 
 	atarimouse=	[HW,MOUSE] Atari Mouse
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index aaadc1cbc006..f7596830694f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -126,12 +126,23 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 static bool __system_matches_cap(unsigned int n);
 
 #ifdef CONFIG_ARM64_MTE
+static bool mte_disable;
+
+static int __init arm64_mte_disable(char *buf)
+{
+	return strtobool(buf, &mte_disable);
+}
+early_param("arm64.mte_disable", arm64_mte_disable);
+
 s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
 {
 	struct device_node *np;
 	static bool memory_checked = false;
 	static bool mte_capable = true;
 
+	if (mte_disable)
+		return ID_AA64PFR1_MTE_NI;
+
 	/* EL0-only MTE is not supported by Linux, don't expose it */
 	if (val < ID_AA64PFR1_MTE)
 		return ID_AA64PFR1_MTE_NI;
