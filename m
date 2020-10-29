Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240D129F820
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgJ2Wci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:32:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgJ2Wch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 18:32:37 -0400
Message-Id: <20201029222652.396632514@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604010750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bMLYR+ULvXX0256D4Df+wpxshaXLT7cqrLUawfmTX9Q=;
        b=VCA691jLGnAZqdkXjZ9aUxRkLnyXLfBMqRSIRGqu4/sp5RVdZI3iAlpz3yv3t1RyGv51sf
        aj9j5cUxfpMz1aNToNIzkolkGvpz7ly1nZ0wFgpScVGDCVLa9utWAflNggS31P6+Vx5DgO
        1C8/Ue4XDTwlZf88m6Fw19NheeTWMADwN2TxrPGwBVXeCC/gnrTmhvqU8zHGAfIieyG/Z5
        i1fEod79b3LJX5Bn5Do/KyPghX9o5UthsAzdPKiEuUUjL0qxS/SNe26GnpIA1NCCeOno1z
        DFWxF3vPmxWQH5W4OmZ6SbVraqTnScVGk0DBL33R6duvu8JhKTsFJouGGv1nyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604010750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bMLYR+ULvXX0256D4Df+wpxshaXLT7cqrLUawfmTX9Q=;
        b=STUDCvqBTgV5xXrnXgKMETTb5aOCokIJFCvgDEer9TTJtzFGrKJQw3D5iibPwOcWdvspr/
        F17h1AXIu/YLuvCg==
Date:   Thu, 29 Oct 2020 23:18:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [patch V2 18/18] io-mapping: Provide iomap_local variant
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similar to kmap local provide a iomap local variant which only disables
migration, but neither disables pagefaults nor preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out from the large combo patch and add the !IOMAP_ATOMIC variants
---
 include/linux/io-mapping.h |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -83,6 +83,23 @@ io_mapping_unmap_atomic(void __iomem *va
 }
 
 static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	migrate_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+	migrate_enable();
+}
+
+static inline void __iomem *
 io_mapping_map_wc(struct io_mapping *mapping,
 		  unsigned long offset,
 		  unsigned long size)
@@ -101,7 +118,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -166,7 +183,20 @@ io_mapping_unmap_atomic(void __iomem *va
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	migrate_disable();
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+	migrate_enable();
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,

