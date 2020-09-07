Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78CA25F2D6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIGF6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgIGF6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEBAC061575;
        Sun,  6 Sep 2020 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IcaHid71cII3JdZGf+Xd0IQ2uM2gsv/9AEgKNzHRyEw=; b=H1WOIIj271ZAtDnyuua8dwkXWg
        r2WkVVPq/yxVp8BCHZsKDgRq3+7Ex0eLXSijUJaJ2foO3ocMZnFwB5yB6dEr4N5GFoiE/X1qU6HLc
        J7dpaq+AEMp0QyPTPYxMYdb9iEdc6fE9plyD1+5iIGXzqCdgl1QpvU2Uw+W1isRVx7z4VmHewvxjn
        pTLvoAuFkNBMCmmAlswtxEgNhN+MMmKWbU1MP60fKsPZklY1UWSTnK+kLOaePsix4bk3LqhfuB6Xb
        I3vUqiWKPRYc089LL8DSVYvlKBdGv4ACOiw0hxNNhnv2UjAzbtwKqXWss+QML83ATJRrHZpd8osWP
        mEoVmu7Q==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAh-00035O-Mf; Mon, 07 Sep 2020 05:58:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 4/8] asm-generic: make the set_fs implementation optional
Date:   Mon,  7 Sep 2020 07:58:21 +0200
Message-Id: <20200907055825.1917151-5-hch@lst.de>
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

Put all the set_fs related code under CONFIG_SET_FS so that
asm-generic/uaccess.h can be used for set_fs-less builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index b367f339be1a90..45f9872fd74759 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -94,6 +94,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 #define INLINE_COPY_TO_USER
 #endif /* CONFIG_UACCESS_MEMCPY */
 
+#ifdef CONFIG_SET_FS
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
 #ifndef KERNEL_DS
@@ -116,6 +117,7 @@ static inline void set_fs(mm_segment_t fs)
 #ifndef uaccess_kernel
 #define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #endif
+#endif /* CONFIG_SET_FS */
 
 #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
 
-- 
2.28.0

