Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB652D43C7
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJKPHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:07:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJKPHU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 11:07:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77B8142F;
        Fri, 11 Oct 2019 08:07:19 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A59083F68E;
        Fri, 11 Oct 2019 08:07:16 -0700 (PDT)
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
Subject: [FIXUP 1/2] squash! arm64: Basic Branch Target Identification support
Date:   Fri, 11 Oct 2019 16:06:28 +0100
Message-Id: <1570806389-16014-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570806389-16014-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <1570806389-16014-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v2:

 * Fix Kconfig typo that claimed that Pointer authentication is part of
   ARMv8.2.  It's v8.3.
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 563dec5..6e26b72 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1425,7 +1425,7 @@ config ARM64_BTI
 
 	  This is intended to provide complementary protection to other control
 	  flow integrity protection mechanisms, such as the Pointer
-	  authentication mechanism provided as part of the ARMv8.2 Extensions.
+	  authentication mechanism provided as part of the ARMv8.3 Extensions.
 
 	  To make use of BTI on CPUs that support it, say Y.
 
-- 
2.1.4

