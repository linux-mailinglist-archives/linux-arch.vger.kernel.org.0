Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82F25E041
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgIDQwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIDQw3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 12:52:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF45C061245;
        Fri,  4 Sep 2020 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b/bAysrgpK7o8RV7Nv82fuLZpX69oef20JEl760QaI0=; b=Yj2sIEDi9HwV9AsgH+AxKTKHN7
        W+kv//OVQBi7WV2UrM0IFMf6mP08zizSMg1p8bPnM2RAmAr2YVY9AdDRRZgZWfph8wxCwO41zP7IR
        5/MVBD50aqAS/ojCHnYZnyEgWyY841ZSthA/o2Z8veXrwvyNI4jRRzAxQwAc7zMJmY58nmMuwYFia
        oDwyMo6Hm1iyjfP5BQv3qzj7/dKad6eTc/RlZ2X0bQsslb8P7a7DYgSKkhp3NyG6/2FIUEO87Mt3k
        jju4moRdueiqdLGeuRovOvkEiK9p/U1t9S+yisC/Um/zJaN9nLwp9E9JizLxUjC8oKeVrfBquFQuc
        O7BAGcUQ==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEwq-000134-Na; Fri, 04 Sep 2020 16:52:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 4/8] asm-generic: prepare uaccess.h for a set_fs-less world
Date:   Fri,  4 Sep 2020 18:52:12 +0200
Message-Id: <20200904165216.1799796-5-hch@lst.de>
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

Put all the set_fs related code under CONFIG_SET_FS so that
asm-generic/uaccess.h can be used for set_fs-less builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 768502bbfb154e..a9e6da7cce25e2 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -83,6 +83,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 #define INLINE_COPY_TO_USER
 #endif /* CONFIG_UACCESS_MEMCPY */
 
+#ifdef CONFIG_SET_FS
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
 #ifndef KERNEL_DS
@@ -105,6 +106,7 @@ static inline void set_fs(mm_segment_t fs)
 #ifndef uaccess_kernel
 #define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #endif
+#endif /* CONFIG_SET_FS */
 
 #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
 
-- 
2.28.0

