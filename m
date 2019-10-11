Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209D8D43CA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJKPHX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:07:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJKPHX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 11:07:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54291570;
        Fri, 11 Oct 2019 08:07:22 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDF4D3F68E;
        Fri, 11 Oct 2019 08:07:19 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [FIXUP 2/2] squash! arm64: Basic Branch Target Identification support
Date:   Fri, 11 Oct 2019 16:06:29 +0100
Message-Id: <1570806389-16014-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570806389-16014-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <1570806389-16014-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Add Kconfig dependency on CONFIG_ARM64_PTR_AUTH]

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

This one could use some discussion.

Two conforming hardware implementations containing BTI could nonetheless
have incompatible Pointer auth implementations, meaning that we expose
BTI to userspace but not Pointer auth.

That's stupid hardware design, but the architecture doesn't forbid it
today.  We _could_ detect this and hide BTI from userspace too, but
if a big.LITTLE system contains Pointer auth implementations with
mismatched IMP DEF algorithms, we lose -- we have no direct way to
detect that.

Since BTI still provides some limited value without Pointer auth,
disabling it unnecessarily might be regarded as too heavy-handed.

Changes since v2:

 * Depend on CONFIG_ARM64_PTR_AUTH=y.

   During test hacking, I observed that there are situations where
   userspace should be entitled to assume that Pointer auth is present
   if BTI is present.

   Although the kernel BTI support doesn't require any aspect of
   Pointer authentication, there are architectural dependencies:

    * ARMv8.5 requires BTI to be implemented. [1]
    * BTI requires ARMv8.4-A to be implemented. [1], [2]
    * ARMv8.4 requires ARMv8.3 to be implemented. [3]
    * ARMv8.3 requires Pointer authentication to be implemented. [4]

   i.e., an implementation that supports BTI but not Pointer auth is
   broken.

   BTI is also designed to be complementary to Pointer authentication:
   without Pointer auth, BTI would offer no protection for function
   returns, seriously undermining the value of the feature.

   See ARM ARM for ARMv8-A (ARM DDI 0487E.a) Sections:

   [1] A2.8.1, "Architectural features added by ARMv8.5"

   [2] A2.2.1, "Permitted implementation of subsets of ARMv8.x and
       ARMv8.(x+1) architectural features"

   [3] A2.6.1, "Architectural features added by Armv8.3"

   [4] A2.6, "The Armv8.3 architecture extension"
---
 arch/arm64/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6e26b72..a64d91d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1418,16 +1418,21 @@ menu "ARMv8.5 architectural features"
 config ARM64_BTI
 	bool "Branch Target Identification support"
 	default y
+	depends on ARM64_PTR_AUTH
 	help
 	  Branch Target Identification (part of the ARMv8.5 Extensions)
 	  provides a mechanism to limit the set of locations to which computed
 	  branch instructions such as BR or BLR can jump.
 
-	  This is intended to provide complementary protection to other control
+	  To make use of BTI on CPUs that support it, say Y.
+
+	  BTI is intended to provide complementary protection to other control
 	  flow integrity protection mechanisms, such as the Pointer
 	  authentication mechanism provided as part of the ARMv8.3 Extensions.
+	  For this reason, it does not make sense to enable this option without
+	  also enabling support for Pointer authentication.
 
-	  To make use of BTI on CPUs that support it, say Y.
+	  Thus, to enable this option you also need to select ARM64_PTR_AUTH=y.
 
 	  Userspace binaries must also be specifically compiled to make use of
 	  this mechanism.  If you say N here or the hardware does not support
-- 
2.1.4

