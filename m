Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E865D365088
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 04:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhDTCvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 22:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTCvE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 22:51:04 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D8F6C06174A;
        Mon, 19 Apr 2021 19:50:34 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8B4E79200BB; Tue, 20 Apr 2021 04:50:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 846FD9200B4;
        Tue, 20 Apr 2021 04:50:33 +0200 (CEST)
Date:   Tue, 20 Apr 2021 04:50:33 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] div64: Correct inline documentation for `do_div'
In-Reply-To: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2104200151310.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Correct inline documentation for `do_div', which is a function-like 
macro the `n' parameter of which has the semantics of a C++ reference: 
it is both read and written in the context of the caller without an 
explicit dereference such as with a pointer.

In the C programming language it has no equivalent for proper functions, 
in terms of which the documentation expresses the semantics of `do_div', 
but substituting a pointer in documentation is misleading, and using the 
C++ notation should at least raise the reader's attention and encourage 
to seek explanation even if the C++ semantics is not readily understood.

While at it observe that "semantics" is an uncountable noun, so refer to 
it with a singular rather than plural verb.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
NB there's a `checkpatch.pl' warning for tabs preceded by spaces, but that 
is just the style of the piece of code quoted and I can see no gain from 
changing it or worse yet making inconsistent.
---
 include/asm-generic/div64.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

linux-div64-doc-fix.diff
Index: linux-3maxp-div64/include/asm-generic/div64.h
===================================================================
--- linux-3maxp-div64.orig/include/asm-generic/div64.h
+++ linux-3maxp-div64/include/asm-generic/div64.h
@@ -8,12 +8,14 @@
  * Optimization for constant divisors on 32-bit machines:
  * Copyright (C) 2006-2015 Nicolas Pitre
  *
- * The semantics of do_div() are:
+ * The semantics of do_div() is, in C++ notation, observing that the name
+ * is a function-like macro and the n parameter has the semantics of a C++
+ * reference:
  *
- * uint32_t do_div(uint64_t *n, uint32_t base)
+ * uint32_t do_div(uint64_t &n, uint32_t base)
  * {
- * 	uint32_t remainder = *n % base;
- * 	*n = *n / base;
+ * 	uint32_t remainder = n % base;
+ * 	n = n / base;
  * 	return remainder;
  * }
  *
