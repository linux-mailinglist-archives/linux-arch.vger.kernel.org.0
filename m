Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC925E039
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIDQwc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgIDQw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 12:52:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FAC061246;
        Fri,  4 Sep 2020 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ttKAZXFTdZgjTFfSwyEULSe/BTBQjBlyN7XpL7zPz6k=; b=oVIW9KeoYnK3snaQmqigyM9bk1
        VNtmyrLS05ICP3ujzNGFEK2UL7gcWGiYvYSel8+mT7ktm/BFy258Yqt/x5lfToZRnT3DF+BwUSYyv
        90F1nd6QtB6oqxn4/p8A9KLc9eB/JWY0Srn3so/OeRDYteTlnh2yRasDd2cZ/IIhCrEd6bEFhhPT0
        FzHZcxYjcdIqBdQAx+l2SJRzCMnUnGdls/Chne20VcQlK4wxSwVWimCpoVcYeHy5U3aqMzLf4AmN0
        i+uOIITCXwo7wmafRLyn/tVfo5jJmIBUgcGbBY/xzsRG4nkGHdc0tuN4/AllOvSR6b7j94EAyOjfO
        XjupkZ9A==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEwp-00012v-BA; Fri, 04 Sep 2020 16:52:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/8] asm-generic: fix unaligned access hamdling in raw_copy_{from,to}_user
Date:   Fri,  4 Sep 2020 18:52:11 +0200
Message-Id: <20200904165216.1799796-4-hch@lst.de>
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

Use get_unaligned and put_unaligned for the small constant size cases
in the generic uaccess routines.  This ensures they can be used for
architectures that do not support unaligned loads and stores, while
being a no-op for those that do.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/uaccess.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index cc3b2c8b68fab4..768502bbfb154e 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -36,19 +36,17 @@ raw_copy_from_user(void *to, const void __user * from, unsigned long n)
 	if (__builtin_constant_p(n)) {
 		switch(n) {
 		case 1:
-			*(u8 *)to = *(u8 __force *)from;
+			*(u8 *)to = get_unaligned((u8 __force *)from);
 			return 0;
 		case 2:
-			*(u16 *)to = *(u16 __force *)from;
+			*(u16 *)to = get_unaligned((u16 __force *)from);
 			return 0;
 		case 4:
-			*(u32 *)to = *(u32 __force *)from;
+			*(u32 *)to = get_unaligned((u32 __force *)from);
 			return 0;
-#ifdef CONFIG_64BIT
 		case 8:
-			*(u64 *)to = *(u64 __force *)from;
+			*(u64 *)to = get_unaligned((u64 __force *)from);
 			return 0;
-#endif
 		}
 	}
 
@@ -62,19 +60,17 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	if (__builtin_constant_p(n)) {
 		switch(n) {
 		case 1:
-			*(u8 __force *)to = *(u8 *)from;
+			put_unaligned(*(u8 *)from, (u8 __force *)to);
 			return 0;
 		case 2:
-			*(u16 __force *)to = *(u16 *)from;
+			put_unaligned(*(u16 *)from, (u16 __force *)to);
 			return 0;
 		case 4:
-			*(u32 __force *)to = *(u32 *)from;
+			put_unaligned(*(u32 *)from, (u32 __force *)to);
 			return 0;
-#ifdef CONFIG_64BIT
 		case 8:
-			*(u64 __force *)to = *(u64 *)from;
+			put_unaligned(*(u64 *)from, (u64 __force *)to);
 			return 0;
-#endif
 		default:
 			break;
 		}
-- 
2.28.0

