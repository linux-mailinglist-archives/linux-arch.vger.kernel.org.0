Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB98E4EADE6
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiC2M4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiC2M4T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:56:19 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7A25D5EB
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:30 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id l24-20020a056402231800b00410f19a3103so10968313eda.5
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RlYSbadXoEfpVHc0vV/XNEsRdhGi1prUW+giHTFauGk=;
        b=Dk6OfzDOhhWLYgl5XDrPV/wHbOcl0QIYza/6JtkZqHgLudavSZzmjMk+5f28h2orgU
         iHrCh6plBIwBN36pcmW+p7rGqqO0YMM7u/i5PR6jUmB+3M7Gvzrldrx36VWhdEly5wqL
         OCFVfyQ70Xqs++xgzaju3Y7LpDid5Y2SH/Q8CDmTucqxRIowd4s6C0QFAALHjEO+0nwB
         fuNr7hQPe/Epycuo17M1wj5VYq+p5MbKDJtrQQ5brwghYeQJKrjFvhP1FeN553lIB4Ty
         /plVPtHNwRzPgAYEUGGThxWuO/QztfBN6vGOWx0oeHAc0cwrK2ZfAWzl7GaTEqAJcx59
         JBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RlYSbadXoEfpVHc0vV/XNEsRdhGi1prUW+giHTFauGk=;
        b=UKEs+ZXEA1DiwH81DDwgs9S3g2icuDyHgmp9x3X8CBpw5y90vboSUvK6LfCBG0LXAU
         9Oeq0lXHsiQkAhXggrpzQxtHn2WU8KVfoZ3DErig3blJTQ1gxU1qYajVPFTslCtI2m4v
         MhyFRhD0FLXAKevIPmY8Ne3mLvue0ehoB2a0iRQkER9gz5Y/pCbIdm3btn7+Kwj6ZDgm
         6B63QNlUhwX3JUx3CD29v0vNJJ1wz3+Anasi+z5B0mU99pb1EesbfWULl3CAh0Lo4Gel
         7GMkw40OLqrO8yHkDkdo/N7sXGGskt7QBeECMOd1AjTWLDi12uJkjpHHaFKG6VHqaeZ7
         ZHzQ==
X-Gm-Message-State: AOAM533UMFsgWB6YJyf0hPlev4HS66H6pgQIzDxv9vkvIEn2etaDrrLM
        wMNdAiA54g0ED7JXQuf3SNirtxVVN7A=
X-Google-Smtp-Source: ABdhPJwAQ2KpkKZtt/s3LazFEoxsBevCE6SqXEdguMxH7F8FiFrFs/1K5CRo60urh/1AvLKrhdVF+1gfvd0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:2d20:b0:6df:8c3f:730a with SMTP id
 gs32-20020a1709072d2000b006df8c3f730amr34340038ejc.725.1648557748867; Tue, 29
 Mar 2022 05:42:28 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:14 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-46-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 45/48] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on
 x86, enable it for KASAN/KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed to allow memory tools like KASAN and KMSAN see the
memory accesses from the checksum code. Without CONFIG_GENERIC_CSUM the
tools can't see memory accesses originating from handwritten assembly
code.
For KASAN it's a question of detecting more bugs, for KMSAN using the C
implementation also helps avoid false positives originating from
seemingly uninitialized checksum values.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/I3e95247be55b1112af59dbba07e8cbf34e50a581
---
 arch/x86/Kconfig                |  4 ++++
 arch/x86/include/asm/checksum.h | 16 ++++++++++------
 arch/x86/lib/Makefile           |  2 ++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660c..86df15017f79d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -315,6 +315,10 @@ config GENERIC_ISA_DMA
 	def_bool y
 	depends on ISA_DMA_API
 
+config GENERIC_CSUM
+	bool
+	default y if KMSAN || KASAN
+
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index bca625a60186c..6df6ece8a28ec 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,9 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
-#define HAVE_CSUM_COPY_USER
-#define _HAVE_ARCH_CSUM_AND_COPY
-#ifdef CONFIG_X86_32
-# include <asm/checksum_32.h>
+#ifdef CONFIG_GENERIC_CSUM
+# include <asm-generic/checksum.h>
 #else
-# include <asm/checksum_64.h>
+# define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
+# define HAVE_CSUM_COPY_USER
+# define _HAVE_ARCH_CSUM_AND_COPY
+# ifdef CONFIG_X86_32
+#  include <asm/checksum_32.h>
+# else
+#  include <asm/checksum_64.h>
+# endif
 #endif
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f76747862bd2e..7ba5f61d72735 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -65,7 +65,9 @@ ifneq ($(CONFIG_X86_CMPXCHG64),y)
 endif
 else
         obj-y += iomap_copy_64.o
+ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
+endif
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
-- 
2.35.1.1021.g381101b075-goog

