Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC4D30BC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfJJSpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:45:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfJJSpm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A3128;
        Thu, 10 Oct 2019 11:45:41 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1A123F703;
        Thu, 10 Oct 2019 11:45:38 -0700 (PDT)
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
Subject: [PATCH v2 04/12] arm64: docs: cpu-feature-registers: Document ID_AA64PFR1_EL1
Date:   Thu, 10 Oct 2019 19:44:32 +0100
Message-Id: <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
update the documentation to match.

Add it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Note to maintainers:

 * This patch has been racing with various other attempts to fix
   the same documentation in the meantime.

   Since this patch only fixes the documenting for pre-existing
   features, it can safely be dropped if appropriate.

   The _new_ documentation relating to BTI feature reporting
   is in a subsequent patch, and needs to be retained.
---
 Documentation/arm64/cpu-feature-registers.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 2955287..b86828f 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -168,8 +168,15 @@ infrastructure:
      +------------------------------+---------+---------+
 
 
-  3) MIDR_EL1 - Main ID Register
+  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | SSBS                         | [7-4]   |    y    |
+     +------------------------------+---------+---------+
+
 
+  4) MIDR_EL1 - Main ID Register
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
@@ -188,7 +195,7 @@ infrastructure:
    as available on the CPU where it is fetched and is not a system
    wide safe value.
 
-  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
+  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
@@ -210,7 +217,7 @@ infrastructure:
      | DPB                          | [3-0]   |    y    |
      +------------------------------+---------+---------+
 
-  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
+  6) ID_AA64MMFR2_EL1 - Memory model feature register 2
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
@@ -218,7 +225,7 @@ infrastructure:
      | AT                           | [35-32] |    y    |
      +------------------------------+---------+---------+
 
-  6) ID_AA64ZFR0_EL1 - SVE feature ID register 0
+  7) ID_AA64ZFR0_EL1 - SVE feature ID register 0
 
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
-- 
2.1.4

