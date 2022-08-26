Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389E85A309C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHZUn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiHZUn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 16:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA574DC0B4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661546636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nam1cAfsFD5oHCEiyBVoFhT08lyzL12/kSxOf4iyFlo=;
        b=UlDyBGQFeeohjxLiNfHWJXmUi1Di/0jia91rkaMiofqEJNq3SWVsiZFirDlb9zdDfoX98q
        rpm+okhcHnSqJwk/AzcR4Sh6jnUFc84PHD49GFC3EJ74nv1qJSeiJ083jgbCrLRyedGulz
        iPisv3ZWHICpCX3T/wJPB6Ze+HrVuiU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-t2YgIOmwO7ugWLUU88GpeQ-1; Fri, 26 Aug 2022 16:43:52 -0400
X-MC-Unique: t2YgIOmwO7ugWLUU88GpeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE35E3C0F398;
        Fri, 26 Aug 2022 20:43:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAD7945D2;
        Fri, 26 Aug 2022 20:43:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27QKhpZP024898;
        Fri, 26 Aug 2022 16:43:51 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27QKhpRT024894;
        Fri, 26 Aug 2022 16:43:51 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Aug 2022 16:43:51 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
In-Reply-To: <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com> <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, 26 Aug 2022, Linus Torvalds wrote:

> On Fri, Aug 26, 2022 at 12:23 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> >     include/asm-generic/bitops/non-instrumented-non-atomic.h:15:33:
> > error: implicit declaration of function 'arch_test_bit_acquire'; did
> > you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
> >
> 
> Ahh. m68k isn't using any of the generic bitops headers.
> 
> *Most* architectures have that
> 
>    #include <asm-generic/bitops/non-atomic.h>
> 
> and get it that way, but while it's common, it's most definitely not universal:
> 
>   [torvalds@ryzen linux]$ git grep -L bitops/non-atomic.h
> arch/*/include/asm/bitops.h
>   arch/alpha/include/asm/bitops.h
>   arch/hexagon/include/asm/bitops.h
>   arch/ia64/include/asm/bitops.h
>   arch/m68k/include/asm/bitops.h
>   arch/s390/include/asm/bitops.h
>   arch/sparc/include/asm/bitops.h
>   arch/x86/include/asm/bitops.h
> 
> and of that list only x86 has the new arch_test_bit_acquire().
> 
> So I assume it's not just m68k, but also alpha, hexagon, ia64, s390
> and sparc that have this issue (unless they maybe have some other path
> that includes the gerneric ones, I didn't check).

For sparc, there is arch/sparc/include/asm/bitops_32.h and 
arch/sparc/include/asm/bitops_64.h that include 
asm-generic/bitops/non-atomic.h

For the others, the generic version is not included.

I'm wondering why do the architectures redefine test_bit, if their 
definition is equivalent to the generic one? We could just delete 
arch_test_bit and use "#define arch_test_bit generic_test_bit" as well.

> This was actually why my original suggested patch used the
> 'generic-non-atomic.h' header for it, because that is actually
> included regardless of any architecture headers directly from
> <linux/bitops.h>.
> 
> And it never triggered for me that Mikulas' updated patch then had
> this arch_test_bit_acquire() issue.
> 
> Something like the attached patch *MAY* fix it, but I really haven't
> thought about it a lot, and it's pretty ugly. Maybe it would be better
> to just add the
> 
>    #define arch_test_bit_acquire generic_test_bit_acquire
> 
> to the affected <asm/bitops.h> files instead, and then let those
> architectures decide on their own that maybe they want to use their
> own test_bit() function because it is _already_ an acquire one.
> 
> Mikulas?
> 
> Geert - any opinions on that "maybe the arch should just do that
> #define itself"? I don't think it actually matters for m68k, you end
> up with pretty much the same thing anyway, because
> "smp_load_acquire()" is just a load anyway..
> 
>                  Linus

Another untested patch ... tomorrow, I'll try to compile it, at least for 
architectures where Debian provides cross-compiling gcc.




From: Mikulas Patocka <mpatocka@redhat.com>

Some architectures define their own arch_test_bit and they also need
arch_test_bit_acquire, otherwise they won't compile. We also clean up the
code by using the generic test_bit if that is equivalent to the
arch-specific version.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")

---
 arch/alpha/include/asm/bitops.h   |    7 ++-----
 arch/hexagon/include/asm/bitops.h |   15 +++++++++++++++
 arch/ia64/include/asm/bitops.h    |    7 ++-----
 arch/m68k/include/asm/bitops.h    |    7 ++-----
 arch/s390/include/asm/bitops.h    |   10 ++--------
 arch/sh/include/asm/bitops-op32.h |   12 ++----------
 6 files changed, 25 insertions(+), 33 deletions(-)

Index: linux-2.6/arch/alpha/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/alpha/include/asm/bitops.h
+++ linux-2.6/arch/alpha/include/asm/bitops.h
@@ -283,11 +283,8 @@ arch___test_and_change_bit(unsigned long
 	return (old & mask) != 0;
 }
 
-static __always_inline bool
-arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
-}
+#define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
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
@@ -331,11 +331,8 @@ arch___test_and_change_bit(unsigned long
 	return (old & bit) != 0;
 }
 
-static __always_inline bool
-arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
-}
+#define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 /**
  * ffz - find the first zero bit in a long word
Index: linux-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/bitops.h
+++ linux-2.6/arch/s390/include/asm/bitops.h
@@ -176,14 +176,8 @@ arch___test_and_change_bit(unsigned long
 	return old & mask;
 }
 
-static __always_inline bool
-arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	const volatile unsigned long *p = __bitops_word(nr, addr);
-	unsigned long mask = __bitops_mask(nr);
-
-	return *p & mask;
-}
+#define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
Index: linux-2.6/arch/m68k/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/bitops.h
+++ linux-2.6/arch/m68k/include/asm/bitops.h
@@ -157,11 +157,8 @@ arch___change_bit(unsigned long nr, vola
 	change_bit(nr, addr);
 }
 
-static __always_inline bool
-arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
-}
+#define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 static inline int bset_reg_test_and_set_bit(int nr,
 					    volatile unsigned long *vaddr)
Index: linux-2.6/arch/sh/include/asm/bitops-op32.h
===================================================================
--- linux-2.6.orig/arch/sh/include/asm/bitops-op32.h
+++ linux-2.6/arch/sh/include/asm/bitops-op32.h
@@ -135,16 +135,8 @@ arch___test_and_change_bit(unsigned long
 	return (old & mask) != 0;
 }
 
-/**
- * arch_test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static __always_inline bool
-arch_test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
-}
+#define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 #include <asm-generic/bitops/non-instrumented-non-atomic.h>
 

