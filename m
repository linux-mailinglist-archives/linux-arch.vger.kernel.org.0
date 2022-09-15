Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999EB5B9E6E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiIOPLm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiIOPJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:09:51 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF49CCC6
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:20 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id jg32-20020a170907972000b0077ce313a8f0so5601927ejc.15
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=UAXLi6hWes4K0I7wTwgH8ix0vMuStYu2bu/++oTzO6o=;
        b=ERCi1CpV4jZif78HFY8gJQN4P8IDxcWvvUgCJpc8tDdg16sYqfI+n7+eI/UuSCUmAL
         SRsI5Hb91SXSeFx5sJE1WSEv/4pORbIjsWZTzgEFYcgB/oZjvlbdnJymDpzxMI9WqsSA
         fzkKSe+qfBYibckT/e2O3pBw/nejcxC4oW7V9C7vbDKbUxY/1oiLcrrUCzDCYPL0adsT
         b2RNlS/5f0ZdOsGOr5ezTbcfH4d1nDZoSyn+/iVHMh1x3nzhYUV/wDYZq+9D8wPhUAkh
         ifAj5YfBWK0ZWXgVZXSMG/CcCXlZscKX8+i4U7n68cPdraXGc+ejH1kH30GZoeyXCaAN
         BRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=UAXLi6hWes4K0I7wTwgH8ix0vMuStYu2bu/++oTzO6o=;
        b=BS5OqzMvBJkk28NUdNIXRPeNiIyxh+1Hx6G4hNbHTPpkVKfuS8H+s2juK5yUJ3ui38
         ye1a/5j1jEleHd+sn9O1dYyw4uZXYJc0x0vIgIJsxk4JPQC2PEBdZRSmsRjOjfBkadPr
         okUS5G6FIY0qMHPMtEZ27vY9Itvl7q9fXV6pzeYdjcduxSMLUUrckit25O4Hv7JURCYg
         PC5sjxl2lGVrRNzt9TcBN9OZKLqtPNP3pvm+TIT6i7uc1k5nZTzlTKHVObZ3oxnbRFiB
         tgEjoQcBb1zEfFOyO71Z9hSRykKNJpZlK2JO3sLiPrd3mdkM8BpJJ8ZS+lUo/Pkexv55
         4ZbA==
X-Gm-Message-State: ACrzQf30SeHmxCv7UBZciQ/CHIilQuu4rnfTkJThNURWZ0IXOXnwVO03
        ozkwHbp9jU8EHdzy2PHgGIz+VL83JTM=
X-Google-Smtp-Source: AMsMyM75ouYEbc3+dMPfZoPiB6oSYiohoWcuheQnJIsz7c3U6au3f9s6axieNdPO5ybuRDS+Vorz5dq1hn0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:aa7:ca50:0:b0:44e:973b:461e with SMTP id
 j16-20020aa7ca50000000b0044e973b461emr269636edt.414.1663254379373; Thu, 15
 Sep 2022 08:06:19 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:11 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-38-glider@google.com>
Subject: [PATCH v7 37/43] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on
 x86, enable it for KASAN/KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index f9920f1341c8d..33f4d4baba079 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -324,6 +324,10 @@ config GENERIC_ISA_DMA
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
2.37.2.789.g6183377224-goog

