Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C24AC2CF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiBGPSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 10:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442390AbiBGOuL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 09:50:11 -0500
X-Greylist: delayed 1248 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 06:50:11 PST
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE8C0401C2
        for <linux-arch@vger.kernel.org>; Mon,  7 Feb 2022 06:50:11 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JspS22MSMz9sSr;
        Mon,  7 Feb 2022 15:29:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dOz3A4mIe6Sr; Mon,  7 Feb 2022 15:29:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JspS21WlXz9sSq;
        Mon,  7 Feb 2022 15:29:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E342B8B770;
        Mon,  7 Feb 2022 15:29:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id om8gFrsfA6rV; Mon,  7 Feb 2022 15:29:21 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C48188B76C;
        Mon,  7 Feb 2022 15:29:21 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 217ETCrr1245796
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 7 Feb 2022 15:29:12 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 217ETBfP1245795;
        Mon, 7 Feb 2022 15:29:11 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] ilog2: Force inlining of __ilog2_u32() and __ilog2_u64()
Date:   Mon,  7 Feb 2022 15:29:08 +0100
Message-Id: <803a2ac3d923ebcfd0dd40f5886b05cae7bb0aba.1644243860.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644244146; l=3187; s=20211009; h=from:subject:message-id; bh=LbJyGmP0iWIV+hgEVGW0oqWQQm1oTy/XNUfH89Xt7zQ=; b=mNHf9SFAjgfitOeHz35BBXMOILPxupHhNaZkP1W+y+gPMKMHKePKlO4d50S4Lfmb78ZD9UoznNAk UQK1iUI1BJvp1QJ1fm+xY+UP2EbLYWNqfZaA/vyQGESu5PZDni/A
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Building a kernel with CONFIG_CC_OPTIMISE_FOR_SIZE leads to
__ilog2_u32() being duplicated 50 times and __ilog2_u64() 3 times
in vmlinux on a tiny powerpc32 config.

__ilog2_u32() being 2 instructions it is not worth being kept out
of line, so force inlining. Allthough the u64 version is a bit bigger,
there is still a small benefit in keeping it inlined. On a 64 bits
config there's a real benefit.

With this change the size of vmlinux text is reduced by 1 kbytes,
which is approx 50% more than the size of the removed functions.

Before the patch there is for instance:

	c00d2a94 <__ilog2_u32>:
	c00d2a94:	7c 63 00 34 	cntlzw  r3,r3
	c00d2a98:	20 63 00 1f 	subfic  r3,r3,31
	c00d2a9c:	4e 80 00 20 	blr

	c00d36d8 <__order_base_2>:
	c00d36d8:	28 03 00 01 	cmplwi  r3,1
	c00d36dc:	40 81 00 2c 	ble     c00d3708 <__order_base_2+0x30>
	c00d36e0:	94 21 ff f0 	stwu    r1,-16(r1)
	c00d36e4:	7c 08 02 a6 	mflr    r0
	c00d36e8:	38 63 ff ff 	addi    r3,r3,-1
	c00d36ec:	90 01 00 14 	stw     r0,20(r1)
	c00d36f0:	4b ff f3 a5 	bl      c00d2a94 <__ilog2_u32>
	c00d36f4:	80 01 00 14 	lwz     r0,20(r1)
	c00d36f8:	38 63 00 01 	addi    r3,r3,1
	c00d36fc:	7c 08 03 a6 	mtlr    r0
	c00d3700:	38 21 00 10 	addi    r1,r1,16
	c00d3704:	4e 80 00 20 	blr
	c00d3708:	38 60 00 00 	li      r3,0
	c00d370c:	4e 80 00 20 	blr

With the patch it has become:

	c00d356c <__order_base_2>:
	c00d356c:	28 03 00 01 	cmplwi  r3,1
	c00d3570:	40 81 00 14 	ble     c00d3584 <__order_base_2+0x18>
	c00d3574:	38 63 ff ff 	addi    r3,r3,-1
	c00d3578:	7c 63 00 34 	cntlzw  r3,r3
	c00d357c:	20 63 00 20 	subfic  r3,r3,32
	c00d3580:	4e 80 00 20 	blr
	c00d3584:	38 60 00 00 	li      r3,0
	c00d3588:	4e 80 00 20 	blr

No more need for __order_base_2() to setup a stack frame and
save/restore caller address. And the following 'add 1' is
merged in the substract.

Another typical use of it:

	c080ff28 <hugepagesz_setup>:
	...
	c080fff8:	7f c3 f3 78 	mr      r3,r30
	c080fffc:	4b 8f 81 f1 	bl      c01081ec <__ilog2_u32>
	c0810000:	38 63 ff f2 	addi    r3,r3,-14
	...

Becomes

	c080ff1c <hugepagesz_setup>:
	...
	c080ffec:	7f c3 00 34 	cntlzw  r3,r30
	c080fff0:	20 63 00 11 	subfic  r3,r3,17
	...

Here no need to move r30 argument to r3 then substract 14 to result. Just work
on r30 and merge the 'sub 14' with the 'sub from 31'.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/log2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index df0b155c2141..9f30d087a128 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -18,7 +18,7 @@
  * - the arch is not required to handle n==0 if implementing the fallback
  */
 #ifndef CONFIG_ARCH_HAS_ILOG2_U32
-static inline __attribute__((const))
+static __always_inline __attribute__((const))
 int __ilog2_u32(u32 n)
 {
 	return fls(n) - 1;
@@ -26,7 +26,7 @@ int __ilog2_u32(u32 n)
 #endif
 
 #ifndef CONFIG_ARCH_HAS_ILOG2_U64
-static inline __attribute__((const))
+static __always_inline __attribute__((const))
 int __ilog2_u64(u64 n)
 {
 	return fls64(n) - 1;
-- 
2.33.1

