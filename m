Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1790E39
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHQHsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:48:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfHQHsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GHc6Yik7xiJpzATFcCLZXqdQpVpnWVpKrNGwCVr+Ge4=; b=aa2Iw1G8i13A7RQ/0VjWsJY9Ex
        DDOL+gOggGuQha4jkIUkidzliYAUfhxFoWCbyj7nf8xw6nLBJjlhJQq4tzQybIRpcKLbjxllHvLLk
        9/h3ZC3odZhlX0L3FP2BQNpdRWSDMJVf0sFxvJxgzHgcaj/PhY5t8YF92zCeEoiS0DUaHet1QKtF8
        Qe90WBkroOt49+SZtE5VnkquqwL3vfQjjEMR3SQc80lPN0DEn0zIn7o9+dpEQCPYUao6yUWa6/acr
        PfVa3PHG7GPLC41ot8QX9nh1teAIUt1pLZTUDLyKt6uAommRf027gectMEWJ9J+AljE0pIpuHcwNZ
        cpwdqsvA==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytRw-0004oo-JJ; Sat, 17 Aug 2019 07:48:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/26] m68k: simplify ioremap_nocache
Date:   Sat, 17 Aug 2019 09:32:35 +0200
Message-Id: <20190817073253.27819-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just define ioremap_nocache to ioremap instead of duplicating the
inline.  Also defined ioremap_uc in terms of ioremap instead of
the using a double indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/kmap.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 03d904fe6087..421b6c9c769d 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -28,14 +28,8 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-#define ioremap_nocache ioremap_nocache
-static inline void __iomem *ioremap_nocache(unsigned long physaddr,
-					    unsigned long size)
-{
-	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
-}
-
-#define ioremap_uc ioremap_nocache
+#define ioremap_nocache ioremap
+#define ioremap_uc ioremap
 #define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
-- 
2.20.1

