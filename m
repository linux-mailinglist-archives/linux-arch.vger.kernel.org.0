Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444336508F
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 04:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDTCvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 22:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTCvV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 22:51:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB8AC06174A;
        Mon, 19 Apr 2021 19:50:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 07E0D9200BC; Tue, 20 Apr 2021 04:50:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 03A6C92009D;
        Tue, 20 Apr 2021 04:50:48 +0200 (CEST)
Date:   Tue, 20 Apr 2021 04:50:48 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
In-Reply-To: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We already check the high part of the divident against zero to avoid the 
costly DIVU instruction in that case, needed to reduce the high part of 
the divident, so we may well check against the divisor instead and set 
the high part of the quotient to zero right away.  We need to treat the 
high part the divident in that case though as the remainder that would 
be calculated by the DIVU instruction we avoided.

This has passed correctness verification with test_div64 and reduced the
module's average execution time down to 1.0445s and 0.2619s from 1.0668s
and 0.2629s respectively for an R3400 CPU @40MHz and a 5Kc CPU @160MHz.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
I have made an experimental change on top of this to put `__div64_32' out 
of line, and that increases the averages respectively up to 1.0785s and 
0.2705s.  Not a terrible loss, especially compared to generic times quoted 
with 3/4, but still, so I think it would best be made where optimising for 
size, as noted in the cover letter.
---
 arch/mips/include/asm/div64.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-3maxp-div64/arch/mips/include/asm/div64.h
===================================================================
--- linux-3maxp-div64.orig/arch/mips/include/asm/div64.h
+++ linux-3maxp-div64/arch/mips/include/asm/div64.h
@@ -68,9 +68,11 @@
 									\
 	__high = __div >> 32;						\
 	__low = __div;							\
-	__upper = __high;						\
 									\
-	if (__high) {							\
+	if (__high < __radix) {						\
+		__upper = __high;					\
+		__high = 0;						\
+	} else {							\
 		__asm__("divu	$0, %z1, %z2"				\
 		: "=x" (__modquot)					\
 		: "Jr" (__high), "Jr" (__radix));			\
