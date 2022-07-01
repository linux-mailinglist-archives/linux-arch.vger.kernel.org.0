Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B92563563
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGAO0q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiGAOZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:25:39 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D261CB32
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:13 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w22-20020a05640234d600b00435ba41dbaaso1882861edc.12
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d5jq2vBXLL0PAqQqIdp+R/eYgdfcHLruJviOlOzbAyw=;
        b=foA7zxm3d/yxHBn+7dN7Qf5yVA+m4cALhyxiFKss7bKF1M3ODx5vEwdDu8Z7CnbCBu
         OSIkaWKjVsPLHctCSmjj3EWUvd9aiSVqRJZDm9K2CWqUG+ieeba45Mq3u6VJQJwcNq0r
         lOhN5cunTXvYPcXTrITquDdeJ+XqRcLXJE5ps4uaJ8K1ae2F4Veo0wjtVjDSDkzSsl+w
         BbkhLScv8E9JYEftt93Q5opL13Lup7qtptxPZoQ4Dr14N6VU9IQAlCZiwEZVKyBiSk5N
         b6V/btlcruxgs+blFm7eLtLE3qAI3wOZyf4T1eZP8bk02wLrZgXR4/OGq1K4+0HF+aE0
         hslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d5jq2vBXLL0PAqQqIdp+R/eYgdfcHLruJviOlOzbAyw=;
        b=MmQh5zrdBR9bLP8zLMSeQQyeokYhi8TbkvnSSbn0ppg17AVjjAm8pTxiR3ydqz5mvy
         K9ByaDKf5rKOp1EqdkLs5NF2xqkGbBANOHllZLa6Cof4qlAiaTbxMcxqe1l1RrIhznGe
         VeEigYyt339AUZJQvXptwtsknEp9WkfgRdPJztxhEKSMhzUFUKZdAy7+S3h39CIs+NBn
         Ls+Q5VqXyIVyBqwXvvWPRJA5U/PGKk5pglrs2WdM5TI/y/alaxGgGw1/UIRm0grzQd+8
         8Rub02UakzFBjZ8aA0AVXzetfeDkpjycuO0EbN3wA1t0qSm45GOklHemOCBRtn6nubMW
         hP0Q==
X-Gm-Message-State: AJIora9XOk/S3Mjkqb7mwtZ9VTzax0aIsNC4z+Q5iyJjKTLUd1NY29Qu
        hCeSjd8zzfAqse0fOLosiJ/PRSKKytE=
X-Google-Smtp-Source: AGRyM1tOQ9hEzrWjXXF1mGZvlD2bn9kK96D3aHnwRR/ak9ADNhFKggqQeO/Ez5UYkEsxu56uu1Qj7OsLgis=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:aa7:d5c9:0:b0:435:8099:30e6 with SMTP id
 d9-20020aa7d5c9000000b00435809930e6mr19303788eds.384.1656685451552; Fri, 01
 Jul 2022 07:24:11 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:45 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-21-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 20/45] kmsan: add iomap support
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Functions from lib/iomap.c interact with hardware, so KMSAN must ensure
that:
 - every read function returns an initialized value
 - every write function checks values before sending them to hardware.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

v4:
  -- switch from __no_sanitize_memory (which now means "no KMSAN
     instrumentation") to __no_kmsan_checks (i.e. "unpoison everything")

Link: https://linux-review.googlesource.com/id/I45527599f09090aca046dfe1a26df453adab100d
---
 lib/iomap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/iomap.c b/lib/iomap.c
index fbaa3e8f19d6c..4f8b31baa5752 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -6,6 +6,7 @@
  */
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #include <linux/export.h>
 
@@ -70,26 +71,35 @@ static void bad_io_access(unsigned long port, const char *access)
 #define mmio_read64be(addr) swab64(readq(addr))
 #endif
 
+/*
+ * Here and below, we apply __no_kmsan_checks to functions reading data from
+ * hardware, to ensure that KMSAN marks their return values as initialized.
+ */
+__no_kmsan_checks
 unsigned int ioread8(const void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
 	return 0xff;
 }
+__no_kmsan_checks
 unsigned int ioread16(const void __iomem *addr)
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 	return 0xffff;
 }
+__no_kmsan_checks
 unsigned int ioread16be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 	return 0xffff;
 }
+__no_kmsan_checks
 unsigned int ioread32(const void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 	return 0xffffffff;
 }
+__no_kmsan_checks
 unsigned int ioread32be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
@@ -142,18 +152,21 @@ static u64 pio_read64be_hi_lo(unsigned long port)
 	return lo | (hi << 32);
 }
 
+__no_kmsan_checks
 u64 ioread64_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
+__no_kmsan_checks
 u64 ioread64_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
+__no_kmsan_checks
 u64 ioread64be_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_lo_hi(port),
@@ -161,6 +174,7 @@ u64 ioread64be_lo_hi(const void __iomem *addr)
 	return 0xffffffffffffffffULL;
 }
 
+__no_kmsan_checks
 u64 ioread64be_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_hi_lo(port),
@@ -188,22 +202,32 @@ EXPORT_SYMBOL(ioread64be_hi_lo);
 
 void iowrite8(u8 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, outb(val,port), writeb(val, addr));
 }
 void iowrite16(u16 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, outw(val,port), writew(val, addr));
 }
 void iowrite16be(u16 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write16be(val,port), mmio_write16be(val, addr));
 }
 void iowrite32(u32 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, outl(val,port), writel(val, addr));
 }
 void iowrite32be(u32 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
 }
 EXPORT_SYMBOL(iowrite8);
@@ -239,24 +263,32 @@ static void pio_write64be_hi_lo(u64 val, unsigned long port)
 
 void iowrite64_lo_hi(u64 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write64_lo_hi(val, port),
 		writeq(val, addr));
 }
 
 void iowrite64_hi_lo(u64 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write64_hi_lo(val, port),
 		writeq(val, addr));
 }
 
 void iowrite64be_lo_hi(u64 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write64be_lo_hi(val, port),
 		mmio_write64be(val, addr));
 }
 
 void iowrite64be_hi_lo(u64 val, void __iomem *addr)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(&val, sizeof(val));
 	IO_COND(addr, pio_write64be_hi_lo(val, port),
 		mmio_write64be(val, addr));
 }
@@ -328,14 +360,20 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
 void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insb(port,dst,count), mmio_insb(addr, dst, count));
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(dst, count);
 }
 void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insw(port,dst,count), mmio_insw(addr, dst, count));
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(dst, count * 2);
 }
 void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
 {
 	IO_COND(addr, insl(port,dst,count), mmio_insl(addr, dst, count));
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(dst, count * 4);
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -343,14 +381,20 @@ EXPORT_SYMBOL(ioread32_rep);
 
 void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(src, count);
 	IO_COND(addr, outsb(port, src, count), mmio_outsb(addr, src, count));
 }
 void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(src, count * 2);
 	IO_COND(addr, outsw(port, src, count), mmio_outsw(addr, src, count));
 }
 void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(src, count * 4);
 	IO_COND(addr, outsl(port, src,count), mmio_outsl(addr, src, count));
 }
 EXPORT_SYMBOL(iowrite8_rep);
-- 
2.37.0.rc0.161.g10f37bed90-goog

