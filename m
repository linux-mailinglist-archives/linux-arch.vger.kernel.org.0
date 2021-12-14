Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298624747CC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhLNQXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhLNQXV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC10C06175E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:08 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id f5-20020a5d4dc5000000b001a0b1481734so2039977wru.23
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=skozoj/jy7S42qGZfIJzyseQ0Pabpjak8N8BbHk2KcY=;
        b=Vd5CTpkkxcmGYalWsgO4iC+qSrXDthqHuJx6DrgC9iKo9HMwYyEQam2KetfJFVgSY7
         KV59+O/gwGsNyRbKQw1w2uWXfAW2IVyiqyvEK3YOmIZdzFL8NMvh7GzAUop7zbTkJY++
         ToXxFC6R+EfY2ptaU6k3DzHZuReo4bXtopgd4CXDlT0QaS/IkccBGx/VkphSd7S0a3c+
         H2xpV8p9Tfae70/+S/YSPipRHzy5gGA/28QaqcOHVTfBy4NITdKNZ+yzGUO32S9YiCLG
         QQrXA8OJk4+U7ZF0z3L7QYfGwz3Mcp0npreVe2kKeecacCvBHADZUhWOIfdNT2RHuk/D
         CSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=skozoj/jy7S42qGZfIJzyseQ0Pabpjak8N8BbHk2KcY=;
        b=rhy9MF9hvacrjnuYrYwVgWOLnF6QZ4LFmniXTzGr0VzFdS3Y3HtkyaJ4Z3pRlNYUzW
         ydF+YJneI/SxFZyWu1FT+UWhCNiIQRQs5KD9d3rcjBtIwAlQ5hHijXYnt3mnOXphBH27
         JFhtDnlE7nxnOj2F0AjNgiBJsuAcB0kjlI1mKL32WihWYKJo2sI1s5fY7jnBaCeGzXsg
         vvF0/fHxi2VfR2/yST/piL4m86TC42YzvjNJGhbKy28/txRVR6XDKc2ziUN4I8VCaQ7y
         saND+SMhqOLOiol9wQZ6fFgiFblnkBIFkbn0LHlG+Wp2io2tfmkg78rL9lI8mV+tIRG0
         Zeow==
X-Gm-Message-State: AOAM532JMVGLcnO5qanxo14+M9k2sQLD/NS9l4xPlroHKTj3fxmX7HcM
        DKS1/esVKKvOgWaUBkv0RcrNXpeXFZ0=
X-Google-Smtp-Source: ABdhPJyZT3GAy+sA4QLGQ8+5dOxsVBZiOrAVdpV3J2YUvqzm9NVSSyPrs05zBKAwEC5raJXcUkuZKFzoASg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:d1e2:: with SMTP id g2mr6927018wrd.179.1639498987401;
 Tue, 14 Dec 2021 08:23:07 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:34 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-28-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 27/43] x86: kmsan: add iomem support
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

Functions from lib/iomap.c and arch/x86/lib/iomem.c interact with hardware,
so KMSAN must ensure that:
 - every read function returns an initialized value
 - every write function checks values before sending them to hardware.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
Link: https://linux-review.googlesource.com/id/I45527599f09090aca046dfe1a26df453adab100d
---
 arch/x86/lib/iomem.c |  5 +++++
 lib/iomap.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index df50451d94ef7..2307770f3f4c8 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -1,6 +1,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #define movs(type,to,from) \
 	asm volatile("movs" type:"=&D" (to), "=&S" (from):"0" (to), "1" (from):"memory")
@@ -37,6 +38,8 @@ void memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 		n-=2;
 	}
 	rep_movs(to, (const void *)from, n);
+	/* KMSAN must treat values read from devices as initialized. */
+	kmsan_unpoison_memory(to, n);
 }
 EXPORT_SYMBOL(memcpy_fromio);
 
@@ -45,6 +48,8 @@ void memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
 	if (unlikely(!n))
 		return;
 
+	/* Make sure uninitialized memory isn't copied to devices. */
+	kmsan_check_memory(from, n);
 	/* Align any unaligned destination IO */
 	if (unlikely(1 & (unsigned long)to)) {
 		movs("b", to, from);
diff --git a/lib/iomap.c b/lib/iomap.c
index fbaa3e8f19d6c..bdda1a42771b2 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -6,6 +6,7 @@
  */
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 
 #include <linux/export.h>
 
@@ -70,26 +71,31 @@ static void bad_io_access(unsigned long port, const char *access)
 #define mmio_read64be(addr) swab64(readq(addr))
 #endif
 
+__no_sanitize_memory
 unsigned int ioread8(const void __iomem *addr)
 {
 	IO_COND(addr, return inb(port), return readb(addr));
 	return 0xff;
 }
+__no_sanitize_memory
 unsigned int ioread16(const void __iomem *addr)
 {
 	IO_COND(addr, return inw(port), return readw(addr));
 	return 0xffff;
 }
+__no_sanitize_memory
 unsigned int ioread16be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read16be(port), return mmio_read16be(addr));
 	return 0xffff;
 }
+__no_sanitize_memory
 unsigned int ioread32(const void __iomem *addr)
 {
 	IO_COND(addr, return inl(port), return readl(addr));
 	return 0xffffffff;
 }
+__no_sanitize_memory
 unsigned int ioread32be(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read32be(port), return mmio_read32be(addr));
@@ -142,18 +148,21 @@ static u64 pio_read64be_hi_lo(unsigned long port)
 	return lo | (hi << 32);
 }
 
+__no_sanitize_memory
 u64 ioread64_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
+__no_sanitize_memory
 u64 ioread64_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
 	return 0xffffffffffffffffULL;
 }
 
+__no_sanitize_memory
 u64 ioread64be_lo_hi(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_lo_hi(port),
@@ -161,6 +170,7 @@ u64 ioread64be_lo_hi(const void __iomem *addr)
 	return 0xffffffffffffffffULL;
 }
 
+__no_sanitize_memory
 u64 ioread64be_hi_lo(const void __iomem *addr)
 {
 	IO_COND(addr, return pio_read64be_hi_lo(port),
@@ -188,22 +198,32 @@ EXPORT_SYMBOL(ioread64be_hi_lo);
 
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
@@ -239,24 +259,32 @@ static void pio_write64be_hi_lo(u64 val, unsigned long port)
 
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
@@ -328,14 +356,20 @@ static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
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
@@ -343,14 +377,20 @@ EXPORT_SYMBOL(ioread32_rep);
 
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
2.34.1.173.g76aa8bc2d0-goog

