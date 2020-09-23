Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62363275ED8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIWRkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 13:40:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:57506 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgIWRkT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 13:40:19 -0400
IronPort-SDR: qWFXvjDakOmlQVX79lzTDLSBuvt2oZ+Yc7WrhEjrpXqB8FMnn7HHitDs+jBjn/b6z1mV3hit1e
 Kk4/lvpG23BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="179057001"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="179057001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:40:18 -0700
IronPort-SDR: HF6l80Vl4GPB6WBckXE/1zi6edCdb0E0SoZ0b2AIqsy1uPUzAKQS8Xx8vNJW5nsqHkQEO/idC8
 xMkCI9K6Mq7w==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="309993016"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.14.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 10:40:12 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
Subject: [PATCH v5 04/10] x86: Make sure _etext includes function sections
Date:   Wed, 23 Sep 2020 10:38:58 -0700
Message-Id: <20200923173905.11219-5-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200923173905.11219-1-kristen@linux.intel.com>
References: <20200923173905.11219-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     | 17 +++++++++++++++--
 include/asm-generic/vmlinux.lds.h |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9a03e5b23135..b0718eef283f 100644
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
index afd5cdf79a3a..6f7239e033e8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -863,7 +863,7 @@
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

