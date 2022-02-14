Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195F44B56F6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbiBNQhl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:37:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiBNQhJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:37:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FAE6517D;
        Mon, 14 Feb 2022 08:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11168614E2;
        Mon, 14 Feb 2022 16:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67DEC340F1;
        Mon, 14 Feb 2022 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856612;
        bh=XYviTV8III28kBrCQmsfuK51xOc09ZOif7iEHrUTuIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVfOMM7vTqw4XdpMNlrmm2jS83mfS0hYdjkQzrKj6vrH9+Dvn0L42AdShO8RRf9Zt
         dCgJRVDvimHn/Uhy8K6/LoOqKmFRoenKTwmfXsum/yC+2647Q4iFanRlWF3K/xS92S
         gCEmlRiZlTgkTyjEKX3J6/tBJHCW3fBRdNZcGJninmBDlMLvinDaCzw9S7lbmfV8Yj
         asCqU2GVX1KEmy6ol6Y4c8F7ub3PAxvrL7Bv3Yonu/G0OWA7/HKZkm9UtkPubPBkfM
         dXhuOWxE8SbyX8yNCneVJdVo8zXW4C1x2+08uIEcESmpPYEb+YIs98IFRoa3DME4D0
         G0ya2TSp8tVbQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 06/14] mips: use simpler access_ok()
Date:   Mon, 14 Feb 2022 17:34:44 +0100
Message-Id: <20220214163452.1568807-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Before unifying the mips version of __access_ok() with the generic
code, this converts it to the same algorithm. This is a change in
behavior on mips64, as now address in the user segment, the lower
2^62 bytes, is taken to be valid, relying on a page fault for
addresses that are within that segment but not valid on that CPU.

The new version should be the most effecient way to do this, but
it gets rid of the special handling for size=0 that most other
architectures ignore as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/uaccess.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index db9a8e002b62..d7c89dc3426c 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -19,6 +19,7 @@
 #ifdef CONFIG_32BIT
 
 #define __UA_LIMIT 0x80000000UL
+#define TASK_SIZE_MAX	__UA_LIMIT
 
 #define __UA_ADDR	".word"
 #define __UA_LA		"la"
@@ -33,6 +34,7 @@
 extern u64 __ua_limit;
 
 #define __UA_LIMIT	__ua_limit
+#define TASK_SIZE_MAX	XKSSEG
 
 #define __UA_ADDR	".dword"
 #define __UA_LA		"dla"
@@ -42,22 +44,6 @@ extern u64 __ua_limit;
 
 #endif /* CONFIG_64BIT */
 
-/*
- * Is a address valid? This does a straightforward calculation rather
- * than tests.
- *
- * Address valid if:
- *  - "addr" doesn't have any high-bits set
- *  - AND "size" doesn't have any high-bits set
- *  - AND "addr+size" doesn't have any high-bits set
- *  - OR we are in kernel mode.
- *
- * __ua_size() is a trick to avoid runtime checking of positive constant
- * sizes; for those we already know at compile time that the size is ok.
- */
-#define __ua_size(size)							\
-	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
-
 /*
  * access_ok: - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -79,9 +65,9 @@ extern u64 __ua_limit;
 static inline int __access_ok(const void __user *p, unsigned long size)
 {
 	unsigned long addr = (unsigned long)p;
-	unsigned long end = addr + size - !!size;
+	unsigned long limit = TASK_SIZE_MAX;
 
-	return (__UA_LIMIT & (addr | end | __ua_size(size))) == 0;
+	return (size <= limit) && (addr <= (limit - size));
 }
 
 #define access_ok(addr, size)					\
-- 
2.29.2

