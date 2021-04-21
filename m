Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3691366CBD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbhDUN0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhDUNZ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 09:25:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFEFDC06174A;
        Wed, 21 Apr 2021 06:25:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C10E892009C; Wed, 21 Apr 2021 15:25:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BC6F992009B;
        Wed, 21 Apr 2021 15:25:22 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:25:22 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/math/test_div64: Fix error message formatting
Message-ID: <alpine.DEB.2.21.2104211445290.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Align the expected result with one actually produced for easier visual 
comparison; this has to take into account what the format specifiers 
will actually produce rather than the characters they consist of.  E.g.:

test_div64: ERROR: 10000000ab275080 / 00000009 => 01c71c71da20d00e,00000002
test_div64: ERROR: expected value              => 0000000013045e47,00000001

(with a failure induced by setting bit #60 of the divident).

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 lib/math/test_div64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-3maxp-div64/lib/math/test_div64.c
===================================================================
--- linux-3maxp-div64.orig/lib/math/test_div64.c
+++ linux-3maxp-div64/lib/math/test_div64.c
@@ -170,7 +170,7 @@ static inline bool test_div64_verify(u64
 	if (!test_div64_verify(quotient, remainder, i, j)) {		\
 		pr_err("ERROR: %016llx / %08x => %016llx,%08x\n",	\
 		       divident, divisor, quotient, remainder);		\
-		pr_err("ERROR: expected value=> %016llx,%08x\n",	\
+		pr_err("ERROR: expected value              => %016llx,%08x\n",\
 		       test_div64_results[i][j].quotient,		\
 		       test_div64_results[i][j].remainder);		\
 		result = false;						\
