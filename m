Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC95A304A
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiHZUDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHZUDh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 16:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30EE97F4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661544216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGiL/wFCui2ekwiPy88y1EJnxLA/VbwmHPhh3BhqAuQ=;
        b=fPEH7cboM1vF+ZQl7bSqZl+8DUvMTJMCfLvV1FPoez+YcKrLMmUZJlESrRSZLjm6mF5/7p
        5KjNVfZIfGsaWjwsg6VSDaQ4871C9PY4OGCbbPbhDGR0u7arUZlVXuo2mxBEF/VxuF5jp4
        deizKh5A2zdtUhjbPpuusfTL21O4h0s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-ZPeGTIVKOLmpXAjMEkzZzA-1; Fri, 26 Aug 2022 16:03:30 -0400
X-MC-Unique: ZPeGTIVKOLmpXAjMEkzZzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 169A3280EA3B;
        Fri, 26 Aug 2022 20:03:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E717C2166B26;
        Fri, 26 Aug 2022 20:03:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QK3TsN007661;
        Fri, 26 Aug 2022 16:03:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QK3SCr007657;
        Fri, 26 Aug 2022 16:03:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 16:03:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: [PATCH] provide arch_test_bit_acquire for architectures that define
 test_bit
In-Reply-To: <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, 26 Aug 2022, Geert Uytterhoeven wrote:

> Hi Mikulas,
> 
> noreply@ellerman.id.au reports lots of build failures on m68k:
> 
>     include/asm-generic/bitops/non-instrumented-non-atomic.h:15:33:
> error: implicit declaration of function 'arch_test_bit_acquire'; did
> you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
> 
> which I've bisected to this commit.
> 
> http://kisskb.ellerman.id.au/kisskb/head/3e5c673f0d75bc22b3c26eade87e4db4f374cd34

Does this patch fix it? It is untested.

I'm not sure about the hexagon architecture, it is presumably in-order so 
that test_bit and test_bit_acquire are equivalent, but I am not sure about 
that - I'm adding hexagon maintainer to the recipient field.

Mikulas



provide arch_test_bit_acquire for architectures that define test_bit

Some architectures define their own arch_test_bit and they also need
arch_test_bit_acquire, otherwise they won't compile.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")

---
 arch/alpha/include/asm/bitops.h   |    7 +++++++
 arch/hexagon/include/asm/bitops.h |   15 +++++++++++++++
 arch/ia64/include/asm/bitops.h    |    7 +++++++
 arch/m68k/include/asm/bitops.h    |    7 +++++++
 arch/s390/include/asm/bitops.h    |    7 +++++++
 5 files changed, 43 insertions(+)

Index: linux-2.6/arch/m68k/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/bitops.h
+++ linux-2.6/arch/m68k/include/asm/bitops.h
@@ -163,6 +163,13 @@ arch_test_bit(unsigned long nr, const vo
 	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 static inline int bset_reg_test_and_set_bit(int nr,
 					    volatile unsigned long *vaddr)
 {
Index: linux-2.6/arch/alpha/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/alpha/include/asm/bitops.h
+++ linux-2.6/arch/alpha/include/asm/bitops.h
@@ -289,6 +289,13 @@ arch_test_bit(unsigned long nr, const vo
 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
Index: linux-2.6/arch/hexagon/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/hexagon/include/asm/bitops.h
+++ linux-2.6/arch/hexagon/include/asm/bitops.h
@@ -179,6 +179,21 @@ arch_test_bit(unsigned long nr, const vo
 	return retval;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	int retval;
+
+	asm volatile(
+	"{P0 = tstbit(%1,%2); if (P0.new) %0 = #1; if (!P0.new) %0 = #0;}\n"
+	: "=&r" (retval)
+	: "r" (addr[BIT_WORD(nr)]), "r" (nr % BITS_PER_LONG)
+	: "p0", "memory"
+	);
+
+	return retval;
+}
+
 /*
  * ffz - find first zero in word.
  * @word: The word to search
Index: linux-2.6/arch/ia64/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/ia64/include/asm/bitops.h
+++ linux-2.6/arch/ia64/include/asm/bitops.h
@@ -337,6 +337,13 @@ arch_test_bit(unsigned long nr, const vo
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /**
  * ffz - find the first zero bit in a long word
  * @x: The long word to find the bit in
Index: linux-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/bitops.h
+++ linux-2.6/arch/s390/include/asm/bitops.h
@@ -185,6 +185,13 @@ arch_test_bit(unsigned long nr, const vo
 	return *p & mask;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
 {

