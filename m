Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33C0116E56
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLIN63 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 08:58:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLIN62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 08:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wfB5eYEKYbznlKXlwvrX8OFMl1D2sjJ0QQBFfWysImA=; b=ukPbOjtTMSFzWUelOj6xnn6II7
        XRctBcaSFhh4oEO9KgR1Kcks3sCyHmQvFodgkkH2d4FAFeKhr6AZlWg+7rSeK/8mrlapPbRbW/bQr
        lltlUdHij0JChdaJJ9nKixjdYUbt9t7j8cYdO5bJadOrDFjFLpByMY8+qo1rZ44VZaeSarI+qxVdD
        dHIIjEZo4diyolSZmPIuEKOZZ6d+MIMETkyncCQebTHMWEWxZb+N/D6k5YueKRoZjK9aKjC1/jw1g
        RSCjqgbvVVzc0LMtQWy6QOaJe8ibH007eTxLgSw1JKL50dWHaslBF8zI23mB7EIRVvdaHGEpyYXL1
        6w4TKsiQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieJYR-0001an-Er; Mon, 09 Dec 2019 13:58:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: define ioremap_nocache to ioremap
Date:   Mon,  9 Dec 2019 14:58:21 +0100
Message-Id: <20191209135823.28465-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
References: <20191209135823.28465-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

They are both defined the same way, but this makes it easier to validate
the scripted ioremap_nocache removal following soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/io.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 3f6ce74335b4..d9caa811a2fa 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -227,29 +227,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  */
 #define ioremap(offset, size)						\
 	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
-
-/*
- * ioremap_nocache     -   map bus memory into CPU space
- * @offset:    bus address of the memory
- * @size:      size of the resource to map
- *
- * ioremap_nocache performs a platform specific sequence of operations to
- * make bus memory CPU accessible via the readb/readw/readl/writeb/
- * writew/writel functions and the other mmio helpers. The returned
- * address is not guaranteed to be usable directly as a virtual
- * address.
- *
- * This version of ioremap ensures that the memory is marked uncachable
- * on the CPU as well as honouring existing caching rules from things like
- * the PCI bus. Note that there are other caches and buffers on many
- * busses. In particular driver authors should read up on PCI writes
- *
- * It's useful if some control registers are in such an area and
- * write combining or read caching is not desirable:
- */
-#define ioremap_nocache(offset, size)					\
-	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
-#define ioremap_uc ioremap_nocache
+#define ioremap_nocache		ioremap
+#define ioremap_uc		ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
-- 
2.20.1

