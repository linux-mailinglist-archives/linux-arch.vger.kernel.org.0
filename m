Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866DC50D037
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiDXHc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiDXHcw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 03:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CA152789;
        Sun, 24 Apr 2022 00:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F4218B80E07;
        Sun, 24 Apr 2022 07:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2FC385BD;
        Sun, 24 Apr 2022 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650785389;
        bh=UD7MfGnyGMX7gUmVXWT1olQvCjItiLH77jglfvKJE84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ha5lJxF7K1uPp8pkZBQv/o+MFGfSvYEgJiWxV9Pcv2cpGPHjr2/xEQGbUIOnEZYNw
         qcZJ09xkLDqYCsRqipKDibJeQFDeChFA76Ave5NPgjgOd+XwWz8NJLjY2ULWAi7gjd
         Br/XIv7TrKe1Hgze/2Zq2Ol79BMY9WiAJHgsZ7cqrXRjoo+K8S2qU/s2l6ypp165Cn
         YUdXe3L3pOercR489w/bgKoxMzSFwrYiyIRTnEwRnGnA4tnpCUd39SoQYodT/4dFFc
         LNjlqKD5JUDL62B3oSQL2pPfLMR/hhBPkWJRPsjDIBZmE2LXBryIGwicdNzEM8gr1Q
         d3su9bH9DQYCg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 3/3] csky: atomic: Add conditional atomic operations' optimization
Date:   Sun, 24 Apr 2022 15:29:18 +0800
Message-Id: <20220424072918.2596899-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424072918.2596899-1-guoren@kernel.org>
References: <20220424072918.2596899-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add conditional atomic operations' optimization:
 - arch_atomic_fetch_add_unless
 - arch_atomic_inc_unless_negative
 - arch_atomic_dec_unless_positive
 - arch_atomic_dec_if_positive

Comments by Boqun:

FWIW, you probably need to make sure that a barrier instruction inside
an lr/sc loop is a good thing. IIUC, the execution time of a barrier
instruction is determined by the status of store buffers and invalidate
queues (and probably other stuffs), so it may increase the execution
time of the lr/sc loop, and make it unlikely to succeed. But this really
depends on how the arch executes these instructions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/csky/include/asm/atomic.h | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
index 56c9dc8e91b3..60406ef9c2bb 100644
--- a/arch/csky/include/asm/atomic.h
+++ b/arch/csky/include/asm/atomic.h
@@ -100,6 +100,101 @@ ATOMIC_OPS(xor)
 
 #undef ATOMIC_FETCH_OP
 
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int prev, tmp;
+
+	__asm__ __volatile__ (
+		RELEASE_FENCE
+		"1:	ldex.w		%0, (%3)	\n"
+		"	cmpne		%0, %4		\n"
+		"	bf		2f		\n"
+		"	mov		%1, %0		\n"
+		"	add		%1, %2		\n"
+		"	stex.w		%1, (%3)	\n"
+		"	bez		%1, 1b		\n"
+		FULL_FENCE
+		"2:\n"
+		: "=&r" (prev), "=&r" (tmp)
+		: "r" (a), "r" (&v->counter), "r" (u)
+		: "memory");
+
+	return prev;
+}
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+
+static __always_inline bool
+arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int rc, tmp;
+
+	__asm__ __volatile__ (
+		RELEASE_FENCE
+		"1:	ldex.w		%0, (%2)	\n"
+		"	movi		%1, 0		\n"
+		"	blz		%0, 2f		\n"
+		"	movi		%1, 1		\n"
+		"	addi		%0, 1		\n"
+		"	stex.w		%0, (%2)	\n"
+		"	bez		%0, 1b		\n"
+		FULL_FENCE
+		"2:\n"
+		: "=&r" (tmp), "=&r" (rc)
+		: "r" (&v->counter)
+		: "memory");
+
+	return tmp ? true : false;
+
+}
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+
+static __always_inline bool
+arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int rc, tmp;
+
+	__asm__ __volatile__ (
+		RELEASE_FENCE
+		"1:	ldex.w		%0, (%2)	\n"
+		"	movi		%1, 0		\n"
+		"	bhz		%0, 2f		\n"
+		"	movi		%1, 1		\n"
+		"	subi		%0, 1		\n"
+		"	stex.w		%0, (%2)	\n"
+		"	bez		%0, 1b		\n"
+		FULL_FENCE
+		"2:\n"
+		: "=&r" (tmp), "=&r" (rc)
+		: "r" (&v->counter)
+		: "memory");
+
+	return tmp ? true : false;
+}
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+
+static __always_inline int
+arch_atomic_dec_if_positive(atomic_t *v)
+{
+	int dec, tmp;
+
+	__asm__ __volatile__ (
+		RELEASE_FENCE
+		"1:	ldex.w		%0, (%2)	\n"
+		"	subi		%1, %0, 1	\n"
+		"	blz		%1, 2f		\n"
+		"	stex.w		%1, (%2)	\n"
+		"	bez		%1, 1b		\n"
+		FULL_FENCE
+		"2:\n"
+		: "=&r" (dec), "=&r" (tmp)
+		: "r" (&v->counter)
+		: "memory");
+
+	return dec - 1;
+}
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
+
 #define ATOMIC_OP()							\
 static __always_inline							\
 int arch_atomic_xchg_relaxed(atomic_t *v, int n)			\
-- 
2.25.1

