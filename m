Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDA7A9BEF
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjIUTFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjIUTEf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 15:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BABD1F3B
        for <linux-arch@vger.kernel.org>; Thu, 21 Sep 2023 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695321273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7t/BumSdqz7jYYtXcF1gDq2WFzlnypJrOD9JQD5AH8=;
        b=YiNs52F8KFlicH7DbWYGoG7pBk1pW2YKpx7fM4vH4Ly8xbDAtOt7ORdfppqd1DSe0rEnBo
        eL3n9exMvj7xcmWriWLf90dEUdn9yP4+6IUw6r84zka6Si5UIlURIm/uj0V27VzOqbNwA3
        wbw4seyWvJ9wm4KL0LvIbfWi8QFXwMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-hGsr711MOhCa2r41Gebw6Q-1; Thu, 21 Sep 2023 07:05:04 -0400
X-MC-Unique: hGsr711MOhCa2r41Gebw6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F25018175A1;
        Thu, 21 Sep 2023 11:05:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8042156A27;
        Thu, 21 Sep 2023 11:04:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, arnd@arndb.de, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        deller@gmx.de, Baoquan He <bhe@redhat.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH v5 4/4] mips: io: remove duplicated codes
Date:   Thu, 21 Sep 2023 19:04:24 +0800
Message-ID: <20230921110424.215592-5-bhe@redhat.com>
In-Reply-To: <20230921110424.215592-1-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By adding <asm-generic/io.h> support, the duplicated phys_to_virt
can be removed to use the default version in <asm-gneneric/io.h>.

Meanwhile move isa_bus_to_virt() down below <asm-generic/io.h> including
to fix the compiling error of missing phys_to_virt definition.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/io.h | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 1ecf255efb40..fe5476c1c689 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -117,24 +117,6 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
 	return __virt_to_phys(x);
 }
 
-/*
- *     phys_to_virt    -       map physical address to virtual
- *     @address: address to remap
- *
- *     The returned virtual address is a current CPU mapping for
- *     the memory address given. It is only valid to use this function on
- *     addresses that have a kernel mapping
- *
- *     This function does not handle bus mappings for DMA transfers. In
- *     almost all conceivable cases a device driver should not be using
- *     this function
- */
-#define phys_to_virt phys_to_virt
-static inline void * phys_to_virt(unsigned long address)
-{
-	return __va(address);
-}
-
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
@@ -143,11 +125,6 @@ static inline unsigned long isa_virt_to_bus(volatile void *address)
 	return virt_to_phys(address);
 }
 
-static inline void *isa_bus_to_virt(unsigned long address)
-{
-	return phys_to_virt(address);
-}
-
 /*
  * Change "struct page" to physical address.
  */
@@ -596,4 +573,9 @@ void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
 #include <asm-generic/io.h>
 
+static inline void *isa_bus_to_virt(unsigned long address)
+{
+	return phys_to_virt(address);
+}
+
 #endif /* _ASM_IO_H */
-- 
2.41.0

