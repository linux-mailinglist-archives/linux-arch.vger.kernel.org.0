Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711334747DE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhLNQYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhLNQXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:46 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBDC061756
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:35 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so17514620edx.9
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i4Z+HeLj0NbbaW9XsBkHpSzUhX9tYLnEL06CEMz9cxQ=;
        b=CtNztcjBEqraF6PWTnSXaJZwhKs4VOr8XcR8KBg/pBQ2Da/PejhZCJsQKJ2YjR7v2/
         kbtjnRWYF6oHjIE1QUU9sNrJZ8oX1PRsaB0k0wwiGw3KahKYBs8kQxsYyIVySa1+C8gk
         9CaiRdFR0QdNccdq18vSMjDF/91noPRWA/PSRMJ06eKAO4TKKxY6Xra42mzaC6fUiyvg
         daWq/hDnfRZaLNtnJTkxe1lSZQA8VJLyT1WDrfP17NsWbAfasFzl8yGpRlOTOKmlWzTu
         hifPioMqhyX4Qx2LkQcqzJfpAUnlpCQYhZJ4Vpv0aBceVSNFALwdReKnTErJKjqlvToM
         3Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i4Z+HeLj0NbbaW9XsBkHpSzUhX9tYLnEL06CEMz9cxQ=;
        b=uwnTzHwjz7kW8ooI23GRkwsErk3Y+sAPFzsAkPIb5Wis8oFW3+GFyBNTO9aJZHT/IS
         4Ec90NLZ5XewQ+PxRAQtcxtsOnOfWlTaIc0r+FW05UP0R/qu828fPRf5A4n9WY0KYjdb
         LSI3gXTe0Plnzpg9IiQYbYbzXsX4ePD7ZNqmDB8NiH0PRfcYMFjHgyN65GWXmvQQV2Es
         a0JS2TlaS7nAJc1kcax/yjlWIcuHlNfwBCrMufl3ulI9hmhhZ/D7BpUmsLyLKYWdwrG5
         npwerD4bzWHCop7dyZiABnMtNn4OoH5hyC5JJQ4nMB7V6R1cHca1gQ9RXYySmAUBjIYb
         cbOg==
X-Gm-Message-State: AOAM531u3Hf57LSoAqOwMIdNhYChrVUsRf8zJ3jNZ9SUkaGoPYZs1iUf
        qzP3QFjLSFjBhsa3kcSZlQLXUCHFHYw=
X-Google-Smtp-Source: ABdhPJwqPu8nQr3pQusJoQrA+ALDwH/+qHW5RVV26eLzrA0etrVpkzgZzSUC2jzB1IRlcmv9IvT3/jPW864=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:906:1913:: with SMTP id
 a19mr6790529eje.484.1639499014263; Tue, 14 Dec 2021 08:23:34 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:44 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-38-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 37/43] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86,
 enable it for KASAN/KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
index 5c2ccb85f2efb..760570ff3f3e4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -310,6 +310,10 @@ config GENERIC_ISA_DMA
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
index c6506c6a70922..81be8498353a6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -66,7 +66,9 @@ endif
         lib-$(CONFIG_X86_USE_3DNOW) += mmx_32.o
 else
         obj-y += iomap_copy_64.o
+ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
+endif
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
-- 
2.34.1.173.g76aa8bc2d0-goog

