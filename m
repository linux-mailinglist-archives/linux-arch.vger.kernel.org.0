Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED60A20587A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgFWRYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 13:24:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:61940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733130AbgFWRYg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 13:24:36 -0400
IronPort-SDR: XQzcqg6RAm4uyvBuTP9EUzhF1/Zpy+fpBJ1wihLaqu4slz4iISN3XaLN/DXRmuaWNGM0RbiXC+
 eaxnle/aTcSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="142391493"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="142391493"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 10:24:35 -0700
IronPort-SDR: yRJhzfNrUwOMLoy2DUDz43v79VZvHgbwzzZaxQI0bYDJJknbQcAXZPwa3rsXBEL164bV4ls11B
 H0MY9Eztl3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="423080075"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.213.182.184])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2020 10:24:33 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
Subject: [PATCH v3 05/10] x86: Make sure _etext includes function sections
Date:   Tue, 23 Jun 2020 10:23:22 -0700
Message-Id: <20200623172327.5701-6-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623172327.5701-1-kristen@linux.intel.com>
References: <20200623172327.5701-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When using -ffunction-sections to place each function in
it's own text section so it can be randomized at load time, the
linker considers these .text.* sections "orphaned sections", and
will place them after the first similar section (.text). In order
to accurately represent the end of the text section and the
orphaned sections, _etext must be moved so that it is after both
.text and .text.* The text size must also be calculated to
include .text AND .text.*

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/vmlinux.lds.S     | 17 +++++++++++++++--
 include/asm-generic/vmlinux.lds.h |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..e8da7eeb4d8d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -146,9 +146,22 @@ SECTIONS
 #endif
 	} :text =0xcccc
 
-	/* End of text section, which should occupy whole number of pages */
-	_etext = .;
+	/*
+	 * -ffunction-sections creates .text.* sections, which are considered
+	 * "orphan sections" and added after the first similar section (.text).
+	 * Placing this ALIGN statement before _etext causes the address of
+	 * _etext to be below that of all the .text.* orphaned sections
+	 */
 	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+
+	/*
+	 * the size of the .text section is used to calculate the address
+	 * range for orc lookups. If we just use SIZEOF(.text), we will
+	 * miss all the .text.* sections. Calculate the size using _etext
+	 * and _stext and save the value for later.
+	 */
+	text_size = _etext - _stext;
 
 	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a5552cf28d5d..34eab6513fdc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -835,7 +835,7 @@
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
 		orc_lookup = .;						\
-		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
+		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
 		orc_lookup_end = .;					\
 	}
-- 
2.20.1

