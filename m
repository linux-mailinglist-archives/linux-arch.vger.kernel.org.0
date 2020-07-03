Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D5213B8F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGCOMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:12:41 -0400
Received: from ozlabs.org ([203.11.71.1]:49655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgGCOMk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:12:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49yxkG5RBnz9sR4; Sat,  4 Jul 2020 00:12:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593785558;
        bh=15fI55SZP5j6guXIt082X3iCYa/XF1pgK7epjzV0ArQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUSRr248jcHj/z3CFKM0QhvfAZ3JS/veTjjCjCVR/1wGmrhy4jR+1hnZTZINOjqUa
         627uXmujjRxs5yBCMCve912CLsU0xToJRbDqGh+nn2HKmMXatSxWLYZZYnwDsTeCCS
         d1dThwDWlv/IY90NPAXjM0kbIbjFnEio0vfPkaCf20seS6WLsMovZg55Dpjb2UqLwx
         WFBlk23Y0kICAAIiqdqcjaS4ngPxumGQa5IufaGOl8aLJ8ceyJNZPcIN+KTYSgDiVf
         U66BYbnBqvM1AgMcB2Un2GSxJ1uTWuUJddCPTQ5dgyayKZUuPLlmdlQoOEaES0Uv32
         ibWZsRS0j3QOg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: [PATCH 3/5] selftests/powerpc: Update the stack expansion test
Date:   Sat,  4 Jul 2020 00:13:25 +1000
Message-Id: <20200703141327.1732550-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703141327.1732550-1-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update the stack expansion load/store test to take into account the
new allowance of 4096 bytes below the stack pointer.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/mm/stack_expansion_ldst.c        | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
index 0587e11437f5..95c3f3de16a1 100644
--- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -186,17 +186,17 @@ static void test_one_type(enum access_type type, unsigned long page_size, unsign
 	// But if we go past the rlimit it should fail
 	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
 
-	// Above 1MB powerpc only allows accesses within 2048 bytes of
+	// Above 1MB powerpc only allows accesses within 4096 bytes of
 	// r1 for accesses that aren't stdu
-	assert(test_one(1 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4096, type) == 0);
 #ifdef __powerpc__
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) != 0);
+	assert(test_one(1 * _MB + page_size - 128, -4097, type) != 0);
 #else
-	assert(test_one(1 * _MB + page_size - 128, -2049, type) == 0);
+	assert(test_one(1 * _MB + page_size - 128, -4097, type) == 0);
 #endif
 
 	// By consuming 2MB of stack we test the stdu case
-	assert(test_one(2 * _MB + page_size - 128, -2048, type) == 0);
+	assert(test_one(2 * _MB + page_size - 128, -4096, type) == 0);
 }
 
 static int test(void)
-- 
2.25.1

