Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536B925D64F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgIDKdc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbgIDKbn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:43 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F542087C;
        Fri,  4 Sep 2020 10:31:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 28/29] arm64: mte: Kconfig entry
Date:   Fri,  4 Sep 2020 11:30:28 +0100
Message-Id: <20200904103029.32083-29-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add Memory Tagging Extension support to the arm64 kbuild.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v9:
    - Slight improvement on the ARM64_AS_HAS_MTE comment.
    
    v7:
    - Binutils gained initial support for MTE in 2.32.0. However, a late
      architecture addition (LDGM/STGM) is only supported in the newer
      2.32.x and 2.33 versions. Change the AS_HAS_MTE option to also check
      for stgm in addition to .arch armv8.5-a+memtag.
    
    v6:
    - Remove select ARCH_USES_PG_ARCH_2, no longer defined.
    
    v5:
    - Remove duplicate ARMv8.5 menu entry.
    
    v4:
    - select ARCH_USES_PG_ARCH_2.
    - remove ARCH_NO_SWAP.
    - default y.

 arch/arm64/Kconfig | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..e7450fbd0aa7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1664,6 +1664,39 @@ config ARCH_RANDOM
 	  provides a high bandwidth, cryptographically secure
 	  hardware random number generator.
 
+config ARM64_AS_HAS_MTE
+	# Initial support for MTE went in binutils 2.32.0, checked with
+	# ".arch armv8.5-a+memtag" below. However, this was incomplete
+	# as a late addition to the final architecture spec (LDGM/STGM)
+	# is only supported in the newer 2.32.x and 2.33 binutils
+	# versions, hence the extra "stgm" instruction check below.
+	def_bool $(as-instr,.arch armv8.5-a+memtag\nstgm xzr$(comma)[x0])
+
+config ARM64_MTE
+	bool "Memory Tagging Extension support"
+	default y
+	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Memory Tagging (part of the ARMv8.5 Extensions) provides
+	  architectural support for run-time, always-on detection of
+	  various classes of memory error to aid with software debugging
+	  to eliminate vulnerabilities arising from memory-unsafe
+	  languages.
+
+	  This option enables the support for the Memory Tagging
+	  Extension at EL0 (i.e. for userspace).
+
+	  Selecting this option allows the feature to be detected at
+	  runtime. Any secondary CPU not implementing this feature will
+	  not be allowed a late bring-up.
+
+	  Userspace binaries that want to use this feature must
+	  explicitly opt in. The mechanism for the userspace is
+	  described in:
+
+	  Documentation/arm64/memory-tagging-extension.rst.
+
 endmenu
 
 config ARM64_SVE
