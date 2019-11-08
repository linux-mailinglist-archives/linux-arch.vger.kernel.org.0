Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D2F4BFF
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfKHMl7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 07:41:59 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:25269 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKHMl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 07:41:59 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id xA8CfZiN020169;
        Fri, 8 Nov 2019 21:41:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xA8CfZiN020169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573216896;
        bh=22yogZY8jyZoPkxsCBQlNGZ4kRUtmO2FQfuKV4jBNIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UpmHfW2VombLNqyRYQdMOxRzsUOkQnTeaQzeIJxSOdD9D45KH1oipBsMF/KUPQxTz
         Aa2jfWi8Qj5AQJXn4tNLJuh+Neet/mxBnzEqYE6CBT/AU/J0rrfx3lEfyCkCyj3+e/
         zMOQdwQ8+QfIndyoDtt4JtROzDaCBuaFp/KU4X/779IJ66oLS9SUiZh8/iLsb1VrbL
         QHSXbi4lZGo1xO3J3Akc6sMh2+/he1YOcP/cB9P1S2LMWj7l6OUkp9obP3G8lPD08I
         Hv//tCtRO5JcTSJMyrcUZ9QAtNAZdL/kLDUHpLVeTn+3gKQZfZg7WNUYva0Kzm4O9V
         xWX0Mnhqx5C8A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline function
Date:   Fri,  8 Nov 2019 21:41:33 +0900
Message-Id: <20191108124133.31751-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I just stopped by the ugly variable name, ________addr.
(8 underscores!)

If this is just a matter of casting to (unsigned long), this variable
is unneeded since you can do like this:

({                                                                      \
        __set_fixmap(idx, phys, flags);                                 \
        (unsigned long)(fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1))); \
})

However, I'd rather like to change it to an inline function since it
is more readable, and the parameter types are clearer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/fixmap.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09c1bc7..de4c36912529 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -70,14 +70,14 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
 #endif
 
-/* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)				\
-({									\
-	unsigned long ________addr;					\
-	__set_fixmap(idx, phys, flags);					\
-	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
-	________addr;							\
-})
+/* Return a virtual address with offset calculated */
+static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
+						phys_addr_t phys,
+						pgprot_t flags)
+{
+	__set_fixmap(idx, phys, flags);
+	return fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));
+}
 
 #define set_fixmap_offset(idx, phys) \
 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
-- 
2.17.1

