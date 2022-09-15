Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8F5BA22C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIOVF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOVF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 17:05:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0A901AA;
        Thu, 15 Sep 2022 14:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52C90B82136;
        Thu, 15 Sep 2022 21:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB10C433C1;
        Thu, 15 Sep 2022 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663275953;
        bh=ZTlRWzdCjBAx3bH9+dtYR09jPGy07SAWGHOUyD/Qpl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNTI5WaCQ7Qd80ZdMTxdgMs7EfZSgx0H1s/ibA/wkcQdTqtknwe8qdztixKSti45w
         Ar8kuh4fOu/uLe7f55ZhqMWOJ2NqGGjDsZ2rrCzyTjajyazrgyHg0qLH4z833vUzlX
         YHHLeNiA38U/hh9WIDcJLNxOqj2Li1ab5yQf1mig=
Date:   Thu, 15 Sep 2022 14:05:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/43] Add KernelMemorySanitizer infrastructure
Message-Id: <20220915140551.2558e64c6a3d3a57d7588f5d@linux-foundation.org>
In-Reply-To: <20220915150417.722975-1-glider@google.com>
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 15 Sep 2022 17:03:34 +0200 Alexander Potapenko <glider@google.com> wrote:

> Patchset v7 includes only minor changes to origin tracking that allowed
> us to drop "kmsan: unpoison @tlb in arch_tlb_gather_mmu()" from the
> series.
> 
> For the following patches diff from v6 is non-trivial:
>  - kmsan: add KMSAN runtime core
>  - kmsan: add tests for KMSAN

I'm not sure this really merits a whole new patchbombing, but I'll do
it that way anyway.

For the curious, the major changes are:

For "kmsan: add KMSAN runtime core":

 mm/kmsan/core.c   |   28 ++++++++++------------------
 mm/kmsan/kmsan.h  |    1 +
 mm/kmsan/report.c |    8 ++++++++
 3 files changed, 19 insertions(+), 18 deletions(-)

--- a/mm/kmsan/core.c~kmsan-add-kmsan-runtime-core-v7
+++ a/mm/kmsan/core.c
@@ -29,13 +29,6 @@
 #include "../slab.h"
 #include "kmsan.h"
 
-/*
- * Avoid creating too long origin chains, these are unlikely to participate in
- * real reports.
- */
-#define MAX_CHAIN_DEPTH 7
-#define NUM_SKIPPED_TO_WARN 10000
-
 bool kmsan_enabled __read_mostly;
 
 /*
@@ -219,23 +212,22 @@ depot_stack_handle_t kmsan_internal_chai
 	 * Make sure we have enough spare bits in @id to hold the UAF bit and
 	 * the chain depth.
 	 */
-	BUILD_BUG_ON((1 << STACK_DEPOT_EXTRA_BITS) <= (MAX_CHAIN_DEPTH << 1));
+	BUILD_BUG_ON(
+		(1 << STACK_DEPOT_EXTRA_BITS) <= (KMSAN_MAX_ORIGIN_DEPTH << 1));
 
 	extra_bits = stack_depot_get_extra_bits(id);
 	depth = kmsan_depth_from_eb(extra_bits);
 	uaf = kmsan_uaf_from_eb(extra_bits);
 
-	if (depth >= MAX_CHAIN_DEPTH) {
-		static atomic_long_t kmsan_skipped_origins;
-		long skipped = atomic_long_inc_return(&kmsan_skipped_origins);
-
-		if (skipped % NUM_SKIPPED_TO_WARN == 0) {
-			pr_warn("not chained %ld origins\n", skipped);
-			dump_stack();
-			kmsan_print_origin(id);
-		}
+	/*
+	 * Stop chaining origins once the depth reached KMSAN_MAX_ORIGIN_DEPTH.
+	 * This mostly happens in the case structures with uninitialized padding
+	 * are copied around many times. Origin chains for such structures are
+	 * usually periodic, and it does not make sense to fully store them.
+	 */
+	if (depth == KMSAN_MAX_ORIGIN_DEPTH)
 		return id;
-	}
+
 	depth++;
 	extra_bits = kmsan_extra_bits(depth, uaf);
 
--- a/mm/kmsan/kmsan.h~kmsan-add-kmsan-runtime-core-v7
+++ a/mm/kmsan/kmsan.h
@@ -27,6 +27,7 @@
 #define KMSAN_POISON_FREE 0x2
 
 #define KMSAN_ORIGIN_SIZE 4
+#define KMSAN_MAX_ORIGIN_DEPTH 7
 
 #define KMSAN_STACK_DEPTH 64
 
--- a/mm/kmsan/report.c~kmsan-add-kmsan-runtime-core-v7
+++ a/mm/kmsan/report.c
@@ -89,12 +89,14 @@ void kmsan_print_origin(depot_stack_hand
 	depot_stack_handle_t head;
 	unsigned long magic;
 	char *descr = NULL;
+	unsigned int depth;
 
 	if (!origin)
 		return;
 
 	while (true) {
 		nr_entries = stack_depot_fetch(origin, &entries);
+		depth = kmsan_depth_from_eb(stack_depot_get_extra_bits(origin));
 		magic = nr_entries ? entries[0] : 0;
 		if ((nr_entries == 4) && (magic == KMSAN_ALLOCA_MAGIC_ORIGIN)) {
 			descr = (char *)entries[1];
@@ -109,6 +111,12 @@ void kmsan_print_origin(depot_stack_hand
 			break;
 		}
 		if ((nr_entries == 3) && (magic == KMSAN_CHAIN_MAGIC_ORIGIN)) {
+			/*
+			 * Origin chains deeper than KMSAN_MAX_ORIGIN_DEPTH are
+			 * not stored, so the output may be incomplete.
+			 */
+			if (depth == KMSAN_MAX_ORIGIN_DEPTH)
+				pr_err("<Zero or more stacks not recorded to save memory>\n\n");
 			head = entries[1];
 			origin = entries[2];
 			pr_err("Uninit was stored to memory at:\n");
_

and for "kmsan: add tests for KMSAN":

--- a/mm/kmsan/kmsan_test.c~kmsan-add-tests-for-kmsan-v7
+++ a/mm/kmsan/kmsan_test.c
@@ -469,6 +469,34 @@ static void test_memcpy_aligned_to_unali
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+static noinline void fibonacci(int *array, int size, int start) {
+	if (start < 2 || (start == size))
+		return;
+	array[start] = array[start - 1] + array[start - 2];
+	fibonacci(array, size, start + 1);
+}
+
+static void test_long_origin_chain(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect,
+				    "test_long_origin_chain");
+	/* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
+	volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
+	int last = ARRAY_SIZE(accum) - 1;
+
+	kunit_info(
+		test,
+		"origin chain exceeding KMSAN_MAX_ORIGIN_DEPTH (UMR report)\n");
+	/*
+	 * We do not set accum[1] to 0, so the uninitializedness will be carried
+	 * over to accum[2..last].
+	 */
+	accum[0] = 1;
+	fibonacci((int *)accum, ARRAY_SIZE(accum), 2);
+	kmsan_check_memory((void *)&accum[last], sizeof(int));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_uninit_kmalloc),
 	KUNIT_CASE(test_init_kmalloc),
@@ -486,6 +514,7 @@ static struct kunit_case kmsan_test_case
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_long_origin_chain),
 	{},
 };
 
_

