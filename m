Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F1213B94
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGCOMs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:12:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgGCOMs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:12:48 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49yxkP0Qtvz9sQt; Sat,  4 Jul 2020 00:12:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593785565;
        bh=iJLzyrD0mSXbnY/Tz9omAWs9L9QI/h7liXKr6O9US4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1XWoceIh1er+HxFITiIIMeGhPinNcb6T44FNYAYX046dtcwEtP3WQog2SNeeHSlD
         rO1mXLbJ/WkCxQVOoCdBef7XBMYkGiOrJwXUcU5otiIb7RT+3YTcYSrehBvlQyKwJa
         VSlMZbS/MK+3hr3P8hRE/nndp8BrvQBIMwCU+OZjbwRAZgQlc9yJd87ZymkHtAajPL
         xhtBzubHYva6b/YIVoLWCCv3Ra2t7s8GUJJ6erl7ikvyls0maOFlX1aUxEqFnGtkUB
         9pZiy9xd5nXBwgZjSs2SFQ2lpGxXVWpB2vYcoJnP86q1GVB1w39PBetTO9Agyrk8LM
         gMowuznbfCpPA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: [RFC PATCH 5/5] selftests/powerpc: Remove powerpc special cases from stack expansion test
Date:   Sat,  4 Jul 2020 00:13:27 +1000
Message-Id: <20200703141327.1732550-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703141327.1732550-1-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that the powerpc code behaves the same as other architectures we
can drop the special cases we had.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../powerpc/mm/stack_expansion_ldst.c         | 41 +++----------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
index 95c3f3de16a1..ed9143990888 100644
--- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -56,13 +56,7 @@ int consume_stack(unsigned long target_sp, unsigned long stack_high, int delta,
 #else
 		asm volatile ("mov %%rsp, %[sp]" : [sp] "=r" (stack_top_sp));
 #endif
-
-		// Kludge, delta < 0 indicates relative to SP
-		if (delta < 0)
-			target = stack_top_sp + delta;
-		else
-			target = stack_high - delta + 1;
-
+		target = stack_high - delta + 1;
 		volatile char *p = (char *)target;
 
 		if (type == STORE)
@@ -162,41 +156,16 @@ static int test_one(unsigned int stack_used, int delta, enum access_type type)
 
 static void test_one_type(enum access_type type, unsigned long page_size, unsigned long rlim_cur)
 {
-	assert(test_one(DEFAULT_SIZE, 512 * _KB, type) == 0);
+	unsigned long delta;
 
-	// powerpc has a special case to allow up to 1MB
-	assert(test_one(DEFAULT_SIZE, 1 * _MB, type) == 0);
-
-#ifdef __powerpc__
-	// This fails on powerpc because it's > 1MB and is not a stdu &
-	// not close to r1
-	assert(test_one(DEFAULT_SIZE, 1 * _MB + 8, type) != 0);
-#else
-	assert(test_one(DEFAULT_SIZE, 1 * _MB + 8, type) == 0);
-#endif
-
-#ifdef __powerpc__
-	// Accessing way past the stack pointer is not allowed on powerpc
-	assert(test_one(DEFAULT_SIZE, rlim_cur, type) != 0);
-#else
 	// We should be able to access anywhere within the rlimit
+	for (delta = page_size; delta <= rlim_cur; delta += page_size)
+		assert(test_one(DEFAULT_SIZE, delta, type) == 0);
+
 	assert(test_one(DEFAULT_SIZE, rlim_cur, type) == 0);
-#endif
 
 	// But if we go past the rlimit it should fail
 	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
-
-	// Above 1MB powerpc only allows accesses within 4096 bytes of
-	// r1 for accesses that aren't stdu
-	assert(test_one(1 * _MB + page_size - 128, -4096, type) == 0);
-#ifdef __powerpc__
-	assert(test_one(1 * _MB + page_size - 128, -4097, type) != 0);
-#else
-	assert(test_one(1 * _MB + page_size - 128, -4097, type) == 0);
-#endif
-
-	// By consuming 2MB of stack we test the stdu case
-	assert(test_one(2 * _MB + page_size - 128, -4096, type) == 0);
 }
 
 static int test(void)
-- 
2.25.1

