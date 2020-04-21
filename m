Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49921B2972
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgDUO0X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 10:26:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgDUO0W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:26:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53DF3C14;
        Tue, 21 Apr 2020 07:26:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBE6A3F68F;
        Tue, 21 Apr 2020 07:26:20 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 06/23] arm64: mte: Tags-aware clear_page() implementation
Date:   Tue, 21 Apr 2020 15:25:46 +0100
Message-Id: <20200421142603.3894-7-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142603.3894-1-catalin.marinas@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When the Memory Tagging Extension is enabled, the tags need to be set to
zero a page is cleared as they are visible to the user.

Introduce an MTE-aware clear_page() which clears the tags in addition to
data.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/clear_page.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index 073acbf02a7c..9f85a4cf9568 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -5,7 +5,9 @@
 
 #include <linux/linkage.h>
 #include <linux/const.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
 #include <asm/page.h>
 
 /*
@@ -19,8 +21,9 @@ SYM_FUNC_START(clear_page)
 	and	w1, w1, #0xf
 	mov	x2, #4
 	lsl	x1, x2, x1
-
-1:	dc	zva, x0
+1:
+alternative_insn "dc zva, x0", "stzgm xzr, [x0]", \
+			 ARM64_MTE, IS_ENABLED(CONFIG_ARM64_MTE), 1
 	add	x0, x0, x1
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
