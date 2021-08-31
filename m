Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02B23FCA18
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhHaOnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:12657 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238550AbhHaOnL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198723492"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="198723492"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="519710705"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2021 07:42:10 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfa002209;
        Tue, 31 Aug 2021 15:42:08 +0100
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
Subject: [PATCH v6 kspp-next 10/22] x86/boot/compressed: Avoid duplicate malloc() implementations
Date:   Tue, 31 Aug 2021 16:41:02 +0200
Message-Id: <20210831144114.154-11-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The preboot malloc() (and free()) implementation in
include/linux/decompress/mm.h (which is also included by the
static decompressors) is static. This is fine when the only thing
interested in using malloc() is the decompression code, but the
x86 preboot environment uses malloc() in a couple places, leading to a
potential collision when the static copies of the available memory
region ("malloc_ptr") gets reset to the global "free_mem_ptr" value.
As it happens, the existing usage pattern happened to be safe because each
user did 1 malloc() and 1 free() before returning and were not nested:

extract_kernel() (misc.c)
	choose_random_location() (kaslr.c)
		mem_avoid_init()
			handle_mem_options()
				malloc()
				...
				free()
	...
	parse_elf() (misc.c)
		malloc()
		...
		free()

Adding FGKASLR, however, will insert additional malloc() calls local to
fgkaslr.c in the middle of parse_elf()'s malloc()/free() pair:

	parse_elf() (misc.c)
		malloc()
		if (...) {
			layout_randomized_image(output, &ehdr, phdrs);
				malloc() <- boom
				...
		else
			layout_image(output, &ehdr, phdrs);
		free()

To avoid collisions, there must be a single implementation of malloc().
Adjust include/linux/decompress/mm.h so that visibility can be
controlled, provide prototypes in misc.h, and implement the functions in
misc.c. This also results in a small size savings:

$ size vmlinux.before vmlinux.after
   text    data     bss     dec     hex filename
8842314     468  178320 9021102  89a6ae vmlinux.before
8842240     468  178320 9021028  89a664 vmlinux.after

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/boot/compressed/kaslr.c |  4 ----
 arch/x86/boot/compressed/misc.c  |  3 +++
 arch/x86/boot/compressed/misc.h  |  2 ++
 include/linux/decompress/mm.h    | 12 ++++++++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e36690778497..7d94f95c84dd 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -32,10 +32,6 @@
 #include <generated/utsrelease.h>
 #include <asm/efi.h>
 
-/* Macros used by the included decompressor code below. */
-#define STATIC
-#include <linux/decompress/mm.h>
-
 #define _SETUP
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
 #undef _SETUP
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 743f13ea25c1..a4339cb2d247 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -28,6 +28,9 @@
 
 /* Macros used by the included decompressor code below. */
 #define STATIC		static
+/* Define an externally visible malloc()/free(). */
+#define MALLOC_VISIBLE
+#include <linux/decompress/mm.h>
 
 /*
  * Provide definitions of memzero and memmove as some of the decompressors will
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 31139256859f..1a2e422dc357 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -44,6 +44,8 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern void *malloc(int size);
+extern void free(void *where);
 extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index 868e9eacd69e..9192986b1a73 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -25,13 +25,21 @@
 #define STATIC_RW_DATA static
 #endif
 
+/*
+ * When an architecture needs to share the malloc()/free() implementation
+ * between compilation units, it needs to have non-local visibility.
+ */
+#ifndef MALLOC_VISIBLE
+#define MALLOC_VISIBLE static
+#endif
+
 /* A trivial malloc implementation, adapted from
  *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  */
 STATIC_RW_DATA unsigned long malloc_ptr;
 STATIC_RW_DATA int malloc_count;
 
-static void *malloc(int size)
+MALLOC_VISIBLE void *malloc(int size)
 {
 	void *p;
 
@@ -52,7 +60,7 @@ static void *malloc(int size)
 	return p;
 }
 
-static void free(void *where)
+MALLOC_VISIBLE void free(void *where)
 {
 	malloc_count--;
 	if (!malloc_count)
-- 
2.31.1

