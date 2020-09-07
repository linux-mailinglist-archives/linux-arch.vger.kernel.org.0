Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B314E25F2E6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIGF7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgIGF6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7550C061573;
        Sun,  6 Sep 2020 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VnA1aUsu5TomLCD5ptE3Uk0kKV7NqTrbQlcFxHGi76E=; b=ZjbVCjEaaehMz9voBwAM76LeuG
        knxGbQzTYw4TQEgvxoZ3zLglBuKA5gZRxagXF4Y+wMtgZZvYyicNS5jnluNpZofHGY8aqFz4+mBeu
        8beWQhXoQzL0+rHhfvdOWElBkd9I3VboCtEexB6w+C5JiDC6HWSAhza9VO6XyaKeP1upaNVsWMMa/
        suecZHC8UpqM8qVW//H1YOIIsi9Wu46EphVtBJMQFxBZwRNKhagIrcpZTwWMcsPQpvCeQDaeoX3FB
        fdJWyGDozNbqKC8xayzUqngpBhTFwor9nI7CE9RWylrGRYnOq/iq30vrTjz9pazYQnDEzuQ28Lopw
        IyodhHQQ==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAl-00036e-E0; Mon, 07 Sep 2020 05:58:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 7/8] riscv: implement __get_kernel_nofault and __put_user_nofault
Date:   Mon,  7 Sep 2020 07:58:24 +0200
Message-Id: <20200907055825.1917151-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement the non-faulting kernel access helpers directly instead of
abusing the uaccess routines under set_fs(KERNEL_DS).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/uaccess.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index b67d1c616ec348..264e52fb62b143 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -486,6 +486,26 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 	__ret;							\
 })
 
+#define HAVE_GET_KERNEL_NOFAULT
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	long __kr_err;							\
+									\
+	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	if (unlikely(__kr_err))						\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	long __kr_err;							\
+									\
+	__put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	if (unlikely(__kr_err))						\
+		goto err_label;						\
+} while (0)
+
 #else /* CONFIG_MMU */
 #include <asm-generic/uaccess.h>
 #endif /* CONFIG_MMU */
-- 
2.28.0

