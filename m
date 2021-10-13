Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26FA42C82E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhJMSAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbhJMR75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 13:59:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0FC061764
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m21so3053770pgu.13
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kcjz/jZcxE+mB3F2AkM0clWB2nKEsktmPdDaqY7pNLM=;
        b=L75cOX6+P2Yg2PCtJBc3rDxsjCw7N/NVtlafkSSqqUGzYVqCBBPEt9zMKsJ+BBeqTQ
         XSfl2ZFSn+uvEQ2K00+x27I4dsgfBWLotrBBXGLMS7tKuUf8Tj6WaQSomgkFtKyLA4W2
         lCeFO9tpk6CbOVBc2TLZDwUMCfoxm5xa5u7L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kcjz/jZcxE+mB3F2AkM0clWB2nKEsktmPdDaqY7pNLM=;
        b=099Oh249K9cPx/1Imyn5EsoW0semwBZW6CHrga2/VuTy0dDy8VWORbM8cHNFiqXEK/
         Vl26XmvzCZVat6gelcg64wkpnlxKREZvddm76C8FNE2iEarOr8mfg5o/bKGViPS9y4JV
         9I66SYvcFp2yLjfoDBzySiUNzyFDGnUM6+uh2QdpmIW7paQiHiyutCEyBbUwArOCrCxk
         gPXtdRFBsW/vHsX7eo4AyrSCx08hRd3398wD2cJGbCFdDU7hXW/aYoKIOBGWTqa2VvTt
         H1FCQipG8WB12mt6QsRDI8IT4xxhJKoodm7zaiyfGrUIXGut/EOy6TkZFXB+lZrhNgtx
         NASg==
X-Gm-Message-State: AOAM532MHe+E5X2frMwH+37UB3mC3poOEllZCMQtbYT9Yntuw/5eezIj
        Z5rLoOJTajcoGE9X01VG+70klg==
X-Google-Smtp-Source: ABdhPJx3hCeP0/qXzBriQG9RAyOIBhOSahtHSc2nigzi8GBlJyOW45fh2MS5OSF1B4QStfEMj11pPA==
X-Received: by 2002:a63:2acc:: with SMTP id q195mr450989pgq.45.1634147872623;
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm162132pgn.64.2021.10.13.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] x86/boot/compressed: Avoid duplicate malloc() implementations
Date:   Wed, 13 Oct 2021 10:57:41 -0700
Message-Id: <20211013175742.1197608-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4454; h=from:subject; bh=hYF77CNx8NXydRq0Sh94JwlUksK5cSbvI41FvGg5UbQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhZx4VrL7HD4WV4zwnJZdT6sN2jDPwltje0/KQButA e0RjcEKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWceFQAKCRCJcvTf3G3AJjoGD/ sGuSJ5GjwOngN6Kzcn20C3dlHYxuKIeUYkhzF7JVQ1n9+cPfhqDVzDkbO+NJHYfvK7zrlGgsa6wtI2 fi7EeRT/FVXdNE356vGVAKnwm8+JqAf8+fMAZCnQAtpMjwF6Wgs9uBhPvRxnKb2AKTXjWqEiwhfTBS QabEnkh5Xo6Dy2QFIJVGPob91BrYShwcIClCE2qTZiAIGbKxS4ia3bHtBPTDXVLNgutIo9Lemw9Htd 70YgUsSCEj0YBclhomTZ4ZMh/hN6yNgXDVo8vnUGrLqtWKsrqAec1NSe11qDqnG2ih+vcoYkivRemG c6TCd9u6BDGU8EIATYPTf577U7csmm4Mdfi29fsUhG58Fg0z9Os2/cZd4LKvAJFZmDmyIQvrnw9Ymt jHGrMQz2/qdikk4WfndV7Pw+tJ7c68L2hHXynezzXebe1LdW2fcuVaeeME1cyF0kjZ9x1lIBw3MBEv Q+OqsZCZ0mSjrL2zFAovH6+vnhA5M1wv34ML2bYsgn/kDHg7SgmIEfzCvi/0p4rk9guAkF+VSMhNQn s/AEh3Knh2JP4VvkKq4gR1of3+iCI8cr5aPhhwppSOvqqJdjozgCHojH4ZZG/m1yiprZBQBWEDVT1n Ax/1g3/3igDo4LbXRABYBefMmZOEFhGay99YNxHgk0tkgX2EXq8bucbu/1Hg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The early malloc() and free() implementation in include/linux/decompress/mm.h
(which is also included by the static decompressors) is static. This is
fine when the only thing interested in using malloc() is the decompression
code, but the x86 early boot environment may use malloc() in a couple places,
leading to a potential collision when the static copies of the available
memory region ("malloc_ptr") gets reset to the global "free_mem_ptr" value.
As it happened, the existing usage pattern was accidentally safe because each
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

Once the future FGKASLR series is added, however, it will insert
additional malloc() calls local to fgkaslr.c in the middle of
parse_elf()'s malloc()/free() pair:

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

Fixed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/kaslr.c |  4 ----
 arch/x86/boot/compressed/misc.c  |  3 +++
 arch/x86/boot/compressed/misc.h  |  2 ++
 include/linux/decompress/mm.h    | 12 ++++++++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 67c3208b668a..411b268bc0a2 100644
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
index 31139256859f..975ef4ae7395 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -44,6 +44,8 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+void *malloc(int size);
+void free(void *where);
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
2.30.2

