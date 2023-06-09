Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91C67291F6
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbjFIH7X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjFIH7G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 03:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FA4227
        for <linux-arch@vger.kernel.org>; Fri,  9 Jun 2023 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686297434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUIKuTNwx3aGCN/mpc81rLXKw/yQlIAJox5sUw6Md70=;
        b=CWHAKSEWmJJzJkiOyZG9eFPU8KON9eYOHwLG6WUuDwIHlt1MCdr2cMMF1u9HYjWo6gAzDv
        OPFXUplSfINESmno72SmSxLTGHtQXymdTwoNpu/yyFS/NUQUuP1Sh+C4UL9ZoLyPlEEeD1
        6+mleVKmeBZvr732Z4vyZ7TPGyKDgCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-qdGF8u1yOFKOwOjmf_5LtQ-1; Fri, 09 Jun 2023 03:56:57 -0400
X-MC-Unique: qdGF8u1yOFKOwOjmf_5LtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7360385A5BB;
        Fri,  9 Jun 2023 07:56:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E440120268C6;
        Fri,  9 Jun 2023 07:56:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        christophe.leroy@csgroup.eu, hch@lst.de, rppt@kernel.org,
        willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v6 11/19] sh: add <asm-generic/io.h> including
Date:   Fri,  9 Jun 2023 15:55:20 +0800
Message-Id: <20230609075528.9390-12-bhe@redhat.com>
In-Reply-To: <20230609075528.9390-1-bhe@redhat.com>
References: <20230609075528.9390-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Also add macro definitions for port|mm io functions since SuperH
has its own implementation in arch/sh/kernel/iomap.c and
arch/sh/include/asm/io_noioport.h. These will conflict with the port|mm io
function definitions in include/asm-generic/io.h to cause compiling
errors like below:

====
  CC      arch/sh/kernel/asm-offsets.s
In file included from ./arch/sh/include/asm/io.h:294,
                 from ./include/linux/io.h:13,
                 ......
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/io.h:792:17: error: conflicting types for ‘ioread8’
  792 | #define ioread8 ioread8
      |                 ^~~~~~~
./include/asm-generic/io.h:793:18: note: in expansion of macro ‘ioread8’
  793 | static inline u8 ioread8(const volatile void __iomem *addr)
      |                  ^~~~~~~
In file included from ./arch/sh/include/asm/io.h:22,
                 from ./include/linux/io.h:13,
                 ......
                 from arch/sh/kernel/asm-offsets.c:16:
./include/asm-generic/iomap.h:29:21: note: previous declaration of ‘ioread8’ was here
   29 | extern unsigned int ioread8(const void __iomem *);
====

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
v5->v6:
  split that inclusion of include/asm-generic/io.h and redefining of the
  helpers from the old patch 11 into this prep patch - Christoph

 arch/sh/include/asm/io.h          | 25 +++++++++++++++++++++++++
 arch/sh/include/asm/io_noioport.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index fba90e670ed4..270e7952950c 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -119,6 +119,26 @@ void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
 __BUILD_MEMORY_STRING(__raw_, q, u64)
 
+#define ioread8 ioread8
+#define ioread16 ioread16
+#define ioread16be ioread16be
+#define ioread32 ioread32
+#define ioread32be ioread32be
+
+#define iowrite8 iowrite8
+#define iowrite16 iowrite16
+#define iowrite16be iowrite16be
+#define iowrite32 iowrite32
+#define iowrite32be iowrite32be
+
+#define ioread8_rep ioread8_rep
+#define ioread16_rep ioread16_rep
+#define ioread32_rep ioread32_rep
+
+#define iowrite8_rep iowrite8_rep
+#define iowrite16_rep iowrite16_rep
+#define iowrite32_rep iowrite32_rep
+
 #ifdef CONFIG_HAS_IOPORT_MAP
 
 /*
@@ -225,6 +245,9 @@ __BUILD_IOPORT_STRING(q, u64)
 #define IO_SPACE_LIMIT 0xffffffff
 
 /* We really want to try and get these to memcpy etc */
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
 void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
 void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
 void memset_io(volatile void __iomem *, int, unsigned long);
@@ -287,6 +310,8 @@ static inline void iounmap(volatile void __iomem *addr) { }
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
+#include <asm-generic/io.h>
+
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index f7938fe0f911..5ba4116b4265 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -53,6 +53,13 @@ static inline void ioport_unmap(void __iomem *addr)
 #define outw_p(x, addr)	outw((x), (addr))
 #define outl_p(x, addr)	outl((x), (addr))
 
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
 static inline void insb(unsigned long port, void *dst, unsigned long count)
 {
 	BUG();
-- 
2.34.1

