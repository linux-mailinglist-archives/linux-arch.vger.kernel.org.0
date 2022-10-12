Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB575FC38D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJLKMp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLKL5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 06:11:57 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE0C1491;
        Wed, 12 Oct 2022 03:11:00 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MnT11119fz9sn7;
        Wed, 12 Oct 2022 12:10:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wtxVnYrpYkGT; Wed, 12 Oct 2022 12:10:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MnT0w6bPWz9sn9;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF4DE8B763;
        Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sh41mYxjMUkf; Wed, 12 Oct 2022 12:10:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B44B8B778;
        Wed, 12 Oct 2022 12:10:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 29CA9xvH1165791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:09:59 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 29CA9w1X1165790;
        Wed, 12 Oct 2022 12:09:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH 4/8] mm: ioremap: allow ARCH to have its own ioremap definition
Date:   Wed, 12 Oct 2022 12:09:40 +0200
Message-Id: <b70d1dee4f0cf0b414cd8cfa7fe7010cc2a9b80f.1665568707.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1665568707.git.christophe.leroy@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665569382; l=1330; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=pSQX+3R5l8yvSGc+qkTev81y2XIqLGw6PFFnkQligIE=; b=zWurECqheXmUTffogCAe30owe1KhB1RI3oYNq9HsETrOLA27gGdAVkQZj6cfecqptAIthEw9L1hH EOFoMbwbA41on1zCjSwXJIgrS+XDg2I8KkUbkw5Cud4RR5oURxR2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Baoquan He <bhe@redhat.com>

Architectures like xtensa, arc, can be converted to GENERIC_IOREMAP,
to take standard ioremap_prot() and ioremap_xxx() way. But they have
ARCH specific handling for ioremap() method, than standard ioremap()
method.

In oder to convert them to take GENERIC_IOREMAP method, allow these
architecutres to have their own ioremap definition.

This is a preparation patch, no functionality change.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 43eb4f62e954..b2ed73708a3e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1081,11 +1081,14 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 void iounmap(volatile void __iomem *addr);
 void generic_iounmap(volatile void __iomem *addr);
 
+#ifndef ioremap
+#define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
 	/* _PAGE_IOREMAP needs to be supplied by the architecture */
 	return ioremap_prot(addr, size, _PAGE_IOREMAP);
 }
+#endif
 #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
 
 #ifndef ioremap_wc
-- 
2.37.1

