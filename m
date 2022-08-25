Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC75A1AC3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiHYVDr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiHYVDq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 17:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B1255BB
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661461424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42srWBnsAPoUudJYTrvi/uUaLSzYytOXCM57hFJ7wJk=;
        b=MXC8vzXJ6IYz+djc1VXx1Bz5i5V4CQox/yBtQxpuoh6CMuSZ538AJn8kdqHfDZ5eFVZOwO
        JDLyvyFd5bgcuGM4awsseIVAGhZMtPefHRuXwRrTGnl2c6CmAEsISFtYh+uaTcCKbvtOTg
        54eR7GeLia/vYdKU1QKZsmUyLB2A+dQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-HCg0bWV6PP-NG7vSYMZVOA-1; Thu, 25 Aug 2022 17:03:42 -0400
X-MC-Unique: HCg0bWV6PP-NG7vSYMZVOA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E09D2101AA64;
        Thu, 25 Aug 2022 21:03:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F98492CA2;
        Thu, 25 Aug 2022 21:03:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 27PL3fii008281;
        Thu, 25 Aug 2022 17:03:41 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 27PL3eUt008277;
        Thu, 25 Aug 2022 17:03:40 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 25 Aug 2022 17:03:40 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] wait_on_bit: add an acquire memory barrier
In-Reply-To: <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, 22 Aug 2022, Linus Torvalds wrote:

> On Mon, Aug 22, 2022 at 10:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So why don't we just create a "test_bit_acquire()" and be done with
> > it? We literally created clear_bit_unlock() for the opposite reason,
> > and your comments about the new barrier hack even point to it.
> 
> Here's a patch that is
> 
>  (a) almost entirely untested (I checked that one single case builds
> and seems to generate the expected code)
> 
>  (b) needs some more loving
> 
> but seems to superficially work.
> 
> At a minimum this needs to be split into two (so the bitop and the
> wait_on_bit parts split up), and that whole placement of
> <asm/barrier.h> and generic_bit_test_acquire() need at least some
> thinking about, but on the whole it seems reasonable.
> 
> For example, it would make more sense to have this in
> <asm-generic/bitops/lock.h>, but not all architectures include that,
> and some do their own version. I didn't want to mess with
> architecture-specific headers, so this illogically just uses
> generic-non-atomic.h.
> 
> Maybe just put it in <linux/bitops.h> directly?
> 
> So I'm not at all claiming that this is a great patch. It definitely
> needs more work, and a lot more testing.
> 
> But I think this is at least the right _direction_ to take here.
> 
> And yes, I think it also would have been better if
> "clear_bit_unlock()" would have been called "clear_bit_release()", and
> we'd have more consistent naming with our ordered atomics. But it's
> probably not worth changing.
> 
>                Linus

Hi

Here I reworked your patch, so that test_bit_acquire is defined just like 
test_bit. There's some code duplication (in 
include/asm-generic/bitops/generic-non-atomic.h and in 
arch/x86/include/asm/bitops.h), but that duplication exists in the 
test_bit function too.

I tested it on x86-64 and arm64. On x86-64 it generates the "bt" 
instruction for variable-bit test and "shr; and $1" for constant bit test. 
On arm64 it generates the "ldar" instruction for both constant and 
variable bit test.

For me, the kernel 6.0-rc2 doesn't boot in an arm64 virtual machine at all 
(with or without this patch), so I only compile-tested it on arm64. I have 
to bisect it.

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

There are several places in the kernel where wait_on_bit is not followed
by a memory barrier (for example, in drivers/md/dm-bufio.c:new_read). On
architectures with weak memory ordering, it may happen that memory
accesses that follow wait_on_bit are reordered before wait_on_bit and they
may return invalid data.

Fix this class of bugs by introducing a new function "test_bit_acquire"
that works like test_bit, but has acquire memory ordering semantics.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

 arch/x86/include/asm/bitops.h                            |   13 +++++++++++++
 include/asm-generic/bitops/generic-non-atomic.h          |   14 ++++++++++++++
 include/asm-generic/bitops/instrumented-non-atomic.h     |   12 ++++++++++++
 include/asm-generic/bitops/non-atomic.h                  |    1 +
 include/asm-generic/bitops/non-instrumented-non-atomic.h |    1 +
 include/linux/bitops.h                                   |    1 +
 include/linux/buffer_head.h                              |    2 +-
 include/linux/wait_bit.h                                 |    8 ++++----
 kernel/sched/wait_bit.c                                  |    2 +-
 9 files changed, 48 insertions(+), 6 deletions(-)

Index: linux-2.6/include/asm-generic/bitops/generic-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/generic-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/generic-non-atomic.h
@@ -4,6 +4,7 @@
 #define __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H
 
 #include <linux/bits.h>
+#include <asm/barrier.h>
 
 #ifndef _LINUX_BITOPS_H
 #error only <linux/bitops.h> can be included directly
@@ -127,6 +128,18 @@ generic_test_bit(unsigned long nr, const
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/**
+ * generic_test_bit - Determine whether a bit is set with acquire semantics
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline bool
+generic_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /*
  * const_*() definitions provide good compile-time optimizations when
  * the passed arguments can be resolved at compile time.
@@ -137,6 +150,7 @@ generic_test_bit(unsigned long nr, const
 #define const___test_and_set_bit	generic___test_and_set_bit
 #define const___test_and_clear_bit	generic___test_and_clear_bit
 #define const___test_and_change_bit	generic___test_and_change_bit
+#define const_test_bit_acquire		generic_test_bit_acquire
 
 /**
  * const_test_bit - Determine whether a bit is set
Index: linux-2.6/include/asm-generic/bitops/non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/non-atomic.h
@@ -13,6 +13,7 @@
 #define arch___test_and_change_bit generic___test_and_change_bit
 
 #define arch_test_bit generic_test_bit
+#define arch_test_bit_acquire generic_test_bit_acquire
 
 #include <asm-generic/bitops/non-instrumented-non-atomic.h>
 
Index: linux-2.6/include/linux/bitops.h
===================================================================
--- linux-2.6.orig/include/linux/bitops.h
+++ linux-2.6/include/linux/bitops.h
@@ -59,6 +59,7 @@ extern unsigned long __sw_hweight64(__u6
 #define __test_and_clear_bit(nr, addr)	bitop(___test_and_clear_bit, nr, addr)
 #define __test_and_change_bit(nr, addr)	bitop(___test_and_change_bit, nr, addr)
 #define test_bit(nr, addr)		bitop(_test_bit, nr, addr)
+#define test_bit_acquire(nr, addr)	bitop(_test_bit_acquire, nr, addr)
 
 /*
  * Include this here because some architectures need generic_ffs/fls in
Index: linux-2.6/include/linux/wait_bit.h
===================================================================
--- linux-2.6.orig/include/linux/wait_bit.h
+++ linux-2.6/include/linux/wait_bit.h
@@ -71,7 +71,7 @@ static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait,
@@ -96,7 +96,7 @@ static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit,
 				       bit_wait_io,
@@ -123,7 +123,7 @@ wait_on_bit_timeout(unsigned long *word,
 		    unsigned long timeout)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit_timeout(word, bit,
 					       bit_wait_timeout,
@@ -151,7 +151,7 @@ wait_on_bit_action(unsigned long *word,
 		   unsigned mode)
 {
 	might_sleep();
-	if (!test_bit(bit, word))
+	if (!test_bit_acquire(bit, word))
 		return 0;
 	return out_of_line_wait_on_bit(word, bit, action, mode);
 }
Index: linux-2.6/kernel/sched/wait_bit.c
===================================================================
--- linux-2.6.orig/kernel/sched/wait_bit.c
+++ linux-2.6/kernel/sched/wait_bit.c
@@ -47,7 +47,7 @@ __wait_on_bit(struct wait_queue_head *wq
 		prepare_to_wait(wq_head, &wbq_entry->wq_entry, mode);
 		if (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags))
 			ret = (*action)(&wbq_entry->key, mode);
-	} while (test_bit(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
+	} while (test_bit_acquire(wbq_entry->key.bit_nr, wbq_entry->key.flags) && !ret);
 
 	finish_wait(wq_head, &wbq_entry->wq_entry);
 
Index: linux-2.6/include/asm-generic/bitops/non-instrumented-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/non-instrumented-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/non-instrumented-non-atomic.h
@@ -12,5 +12,6 @@
 #define ___test_and_change_bit	arch___test_and_change_bit
 
 #define _test_bit		arch_test_bit
+#define _test_bit_acquire	arch_test_bit_acquire
 
 #endif /* __ASM_GENERIC_BITOPS_NON_INSTRUMENTED_NON_ATOMIC_H */
Index: linux-2.6/arch/x86/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/bitops.h
+++ linux-2.6/arch/x86/include/asm/bitops.h
@@ -207,6 +207,12 @@ static __always_inline bool constant_tes
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
 
+static __always_inline bool constant_test_bit_acquire(long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 static __always_inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
 {
 	bool oldbit;
@@ -226,6 +232,13 @@ arch_test_bit(unsigned long nr, const vo
 					  variable_test_bit(nr, addr);
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	return __builtin_constant_p(nr) ? constant_test_bit_acquire(nr, addr) :
+					  variable_test_bit(nr, addr);
+}
+
 /**
  * __ffs - find first set bit in word
  * @word: The word to search
Index: linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h
===================================================================
--- linux-2.6.orig/include/asm-generic/bitops/instrumented-non-atomic.h
+++ linux-2.6/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -142,4 +142,16 @@ _test_bit(unsigned long nr, const volati
 	return arch_test_bit(nr, addr);
 }
 
+/**
+ * _test_bit_acquire - Determine whether a bit is set with acquire semantics
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __always_inline bool
+_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
+	return arch_test_bit_acquire(nr, addr);
+}
+
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
Index: linux-2.6/include/linux/buffer_head.h
===================================================================
--- linux-2.6.orig/include/linux/buffer_head.h
+++ linux-2.6/include/linux/buffer_head.h
@@ -156,7 +156,7 @@ static __always_inline int buffer_uptoda
 	 * make it consistent with folio_test_uptodate
 	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
 	 */
-	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
+	return test_bit_acquire(BH_Uptodate, &bh->b_state);
 }
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)

