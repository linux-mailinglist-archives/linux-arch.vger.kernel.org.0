Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5F64DC48
	for <lists+linux-arch@lfdr.de>; Thu, 15 Dec 2022 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLONaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Dec 2022 08:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLONaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Dec 2022 08:30:15 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA151B7B2
        for <linux-arch@vger.kernel.org>; Thu, 15 Dec 2022 05:30:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:2d49:7a8c:85ed:ab2b])
        by michel.telenet-ops.be with bizsmtp
        id wdW92800w4DzhY606dW9S1; Thu, 15 Dec 2022 14:30:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p5oJM-000GrD-Fy; Thu, 15 Dec 2022 14:30:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p5oJL-001mxT-SL; Thu, 15 Dec 2022 14:30:07 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: string: Make char intermediate in strcmp() signed
Date:   Thu, 15 Dec 2022 14:30:04 +0100
Message-Id: <bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since char became unsigned, strcmp() always returns a positive number.

"res" is used to store a byte difference, so it should be signed.

Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
See "Re: [PATCH v9] kallsyms: Add self-test facility"
https://lore.kernel.org/r/CAMuHMdWM6+pC3yUqy+hHRrAf1BCz2sz1KQv2zxS+Wz-639X-aA@mail.gmail.com

I'm wondering how many surprises like this are still hidden...
---
 arch/m68k/include/asm/string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
index f759d944c4499404..b8f4ae19e8f6ee2c 100644
--- a/arch/m68k/include/asm/string.h
+++ b/arch/m68k/include/asm/string.h
@@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
 #define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char *cs, const char *ct)
 {
-	char res;
+	signed char res;
 
 	asm ("\n"
 		"1:	move.b	(%0)+,%2\n"	/* get *cs */
-- 
2.25.1

