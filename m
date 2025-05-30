Return-Path: <linux-arch+bounces-12149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D5AC8744
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 06:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10B1A24D60
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB741192B90;
	Fri, 30 May 2025 04:17:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7172481DD;
	Fri, 30 May 2025 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748578641; cv=none; b=i7lpgWIN79d4xlmf+6h4bOqPBnY9hsROMTxu94OoUiwlq7BJP8YJo4ChcdWwxoIyEZzuy5FULg237GGTQjh8yRC0tfxFKVCnVjM50IH6VLRAGEh7KFr+r9yzjRzFuj+xAJjAIibMzYnIWGQ8D9zX+x3HB5oze+Ck4jkJZjGAU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748578641; c=relaxed/simple;
	bh=PK5lVIejwrSt83oWqGLdppWRBT8sp9w2fqV+ldsPJIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7CsBXmkMUcczmcUSQoZfy8TfVttzoSwiP04f0d5Ij74+huw/Brwkc89iGpkmfPMgncuOG9OPHOxSKVZO0bjxmPv2UsN/MbDhg73NxRJDpriCmPZUeUDcjBGg1/GOTj6ZHmeFDpSWXzVS49HzThgIvb7U86jn7fwGWKotCrKkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8CEC4CEE9;
	Fri, 30 May 2025 04:17:17 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] asm-generic: Add sched.h inclusion in simd.h
Date: Fri, 30 May 2025 12:16:58 +0800
Message-ID: <20250530041658.909576-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
causes a build error for PREEMPT_RT kernels:

  CC      lib/crypto/sha256.o
In file included from ./include/asm-generic/simd.h:6,
                 from ./arch/loongarch/include/generated/asm/simd.h:1,
                 from ./include/crypto/internal/simd.h:9,
                 from ./include/crypto/internal/sha2.h:6,
                 from lib/crypto/sha256.c:15:
./include/asm-generic/simd.h: In function 'may_use_simd':
./include/linux/preempt.h:111:34: error: 'current' undeclared (first use in this function)
  111 | # define softirq_count()        (current->softirq_disable_cnt & SOFTIRQ_MASK)
      |                                  ^~~~~~~
./include/linux/preempt.h:112:82: note: in expansion of macro 'softirq_count'
  112 | # define irq_count()            ((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
      |                                                                                  ^~~~~~~~~~~~~
./include/linux/preempt.h:143:34: note: in expansion of macro 'irq_count'
  143 | #define in_interrupt()          (irq_count())
      |                                  ^~~~~~~~~
./include/asm-generic/simd.h:18:17: note: in expansion of macro 'in_interrupt'
   18 |         return !in_interrupt();
      |                 ^~~~~~~~~~~~

So add sched.h inclusion in simd.h to fix it.

Fixes: 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/asm-generic/simd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/simd.h b/include/asm-generic/simd.h
index ac29a22eb7cf..70c8716ad32a 100644
--- a/include/asm-generic/simd.h
+++ b/include/asm-generic/simd.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/preempt.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 
 /*
-- 
2.47.1


