Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1025E058
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgIDQyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 12:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIDQwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 12:52:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1CAC061244;
        Fri,  4 Sep 2020 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MkSVtcwaZuMrc9OzI8eVvOG/Cdl/4QZOV215qZC/7jE=; b=hbn1/jpsA3yTfNkNCn8x40H4wn
        8GMkx35SdpSHWCWGmQKnvmoEzVV6IYm7D9vOKw5mwVdoCNsk0QO9VlNbWD7Kw8EBa05GzrYUMnkQp
        YpaoZOmuc/VK6vRbaBkRlZyFkCM1JIlGBIqkGLoKqyQaTRkqjkcirWhj4glZltC1xFPijF7QuD17+
        LQ+0cKgf4Syn/SzNwk1XRUpJyvFSTWCo4GNudNQN168jaPspKm+SMdsT59xydtvhydNNl2MQQj/oE
        mXjs46r3MnbpMkEM2wIxIT0iABaCUF3cX0wOiAMorxQq3aJFHW64CfcfEhGutpoPsWsOcmL3+jJx3
        RfXkGJ4Q==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEwm-00012c-D9; Fri, 04 Sep 2020 16:52:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/8] maccess: add a generic __{get,put}_kernel_nofault for nommu
Date:   Fri,  4 Sep 2020 18:52:09 +0200
Message-Id: <20200904165216.1799796-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904165216.1799796-1-hch@lst.de>
References: <20200904165216.1799796-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nommu architectures do not have page tables and thus no page faults.
Implement the maccess helpers using get_unaligned and put_unaligned and
enable them unconditionally for !CONFIG_MMU.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index ba68ee4dabfaa7..cc3b2c8b68fab4 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -9,6 +9,26 @@
  */
 #include <linux/string.h>
 
+#ifndef CONFIG_MMU
+#include <asm/unaligned.h>
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	*((type *)dst) = get_unaligned((type *)(src));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	put_unaligned(*((type *)src), (type *)(dst));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
+#define HAVE_GET_KERNEL_NOFAULT 1
+#endif /* !CONFIG_MMU */
+
 #ifdef CONFIG_UACCESS_MEMCPY
 static inline __must_check unsigned long
 raw_copy_from_user(void *to, const void __user * from, unsigned long n)
-- 
2.28.0

