Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B43FCA27
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhHaOnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:10972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238538AbhHaOnQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218496879"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="218496879"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="427495137"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2021 07:42:15 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfc002209;
        Tue, 31 Aug 2021 15:42:12 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 12/22] linkage: add macros for putting ASM functions into own sections
Date:   Tue, 31 Aug 2021 16:41:04 +0200
Message-Id: <20210831144114.154-13-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With ClangLTO or -ffunction-sections (DCE, FG-KASLR), compiler
places C functions into separate sections by default.
However, this doesn't happen with ASM functions which are still
being placed into .text.
Introduce a pack of macros which generate a new unique section
for the describing function named in the same fashion
(.text.<func_name>).
This will be needed to make input .text section empty to harden
the kernel even more.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/linux/linkage.h | 76 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..ef8641a7dc1b 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -355,4 +355,80 @@
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * Allow ASM symbols to have their own unique sections if they are being
+ * generated by the compiler for C functions (DCE, FG-KASLR, LTO).
+ */
+#if (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
+    (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
+    (defined(CONFIG_MODULE_FG_KASLR) && defined(MODULE)) || \
+    (defined(CONFIG_LTO_CLANG))
+
+#define ASM_PUSH_SECTION(name)				\
+	".pushsection .text." #name
+
+#define SYM_TEXT_SECTION(name)				\
+	.pushsection .text.##name
+
+#else /* just .text */
+
+#define ASM_PUSH_SECTION(name)				\
+	".pushsection .text"
+
+#define SYM_TEXT_SECTION(name)				\
+	.pushsection .text
+
+#endif /* just .text */
+
+#ifdef __ASSEMBLY__
+
+#define SYM_TEXT_END_SECTION				\
+	.popsection
+
+#define SYM_FUNC_START_LOCAL_ALIAS_SECTION(name)	\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_FUNC_START_LOCAL_ALIAS(name)
+
+#define SYM_FUNC_START_LOCAL_SECTION(name)		\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_FUNC_START_LOCAL(name)
+
+#define SYM_FUNC_START_NOALIGN_SECTION(name)		\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_FUNC_START_NOALIGN(name)
+
+#define SYM_FUNC_START_WEAK_SECTION(name)		\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_FUNC_START_WEAK(name)
+
+#define SYM_FUNC_START_SECTION(name)			\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_FUNC_START(name)
+
+#define SYM_CODE_START_LOCAL_NOALIGN_SECTION(name)	\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_CODE_START_LOCAL_NOALIGN(name)
+
+#define SYM_CODE_START_NOALIGN_SECTION(name)		\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_CODE_START_NOALIGN(name)
+
+#define SYM_CODE_START_SECTION(name)			\
+	SYM_TEXT_SECTION(name) ASM_NL			\
+	SYM_CODE_START(name)
+
+#define SYM_FUNC_END_ALIAS_SECTION(name)		\
+	SYM_FUNC_END_ALIAS(name) ASM_NL			\
+	SYM_TEXT_END_SECTION
+
+#define SYM_FUNC_END_SECTION(name)			\
+	SYM_FUNC_END(name) ASM_NL			\
+	SYM_TEXT_END_SECTION
+
+#define SYM_CODE_END_SECTION(name)			\
+	SYM_CODE_END(name) ASM_NL			\
+	SYM_TEXT_END_SECTION
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _LINUX_LINKAGE_H */
-- 
2.31.1

