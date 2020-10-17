Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E062912C6
	for <lists+linux-arch@lfdr.de>; Sat, 17 Oct 2020 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436600AbgJQPz1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Oct 2020 11:55:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53101 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436599AbgJQPz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 17 Oct 2020 11:55:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CD6zs339Vz9v4h3;
        Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MhA9Gwx4xqNd; Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CD6zs1qBZz9v4h1;
        Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F21C48B778;
        Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wtrs88iciF0T; Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD8BD8B75E;
        Sat, 17 Oct 2020 17:55:21 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 77B5866461; Sat, 17 Oct 2020 15:55:21 +0000 (UTC)
Message-Id: <96c6172d619c51acc5c1c4884b80785c59af4102.1602949927.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] asm-generic: Force inlining of get_order() to work around
 gcc10 poor decision
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Sat, 17 Oct 2020 15:55:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When building mpc885_ads_defconfig with gcc 10.1,
the function get_order() appears 50 times in vmlinux:

[linux]# ppc-linux-objdump -x vmlinux | grep get_order | wc -l
50

[linux]# size vmlinux
   text	   data	    bss	    dec	    hex	filename
3842620	 675624	 135160	4653404	 47015c	vmlinux

In the old days, marking a function 'static inline' was forcing
GCC to inline, but since commit ac7c3e4ff401 ("compiler: enable
CONFIG_OPTIMIZE_INLINING forcibly") GCC may decide to not inline
a function.

It looks like GCC 10 is taking poor decisions on this.

get_order() compiles into the following tiny function,
occupying 20 bytes of text.

0000007c <get_order>:
  7c:   38 63 ff ff     addi    r3,r3,-1
  80:   54 63 a3 3e     rlwinm  r3,r3,20,12,31
  84:   7c 63 00 34     cntlzw  r3,r3
  88:   20 63 00 20     subfic  r3,r3,32
  8c:   4e 80 00 20     blr

By forcing get_order() to be __always_inline, the size of text is
reduced by 1940 bytes, that is almost twice the space occupied by
50 times get_order()

[linux-powerpc]# size vmlinux
   text	   data	    bss	    dec	    hex	filename
3840680	 675588	 135176	4651444	 46f9b4	vmlinux

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/asm-generic/getorder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index e9f20b813a69..f2979e3a96b6 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -26,7 +26,7 @@
  *
  * The result is undefined if the size is 0.
  */
-static inline __attribute_const__ int get_order(unsigned long size)
+static __always_inline __attribute_const__ int get_order(unsigned long size)
 {
 	if (__builtin_constant_p(size)) {
 		if (!size)
-- 
2.25.0

