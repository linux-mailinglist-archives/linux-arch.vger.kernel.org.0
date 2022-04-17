Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79A50471F
	for <lists+linux-arch@lfdr.de>; Sun, 17 Apr 2022 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiDQIfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Apr 2022 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiDQIfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Apr 2022 04:35:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46526104;
        Sun, 17 Apr 2022 01:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17F6B80AAD;
        Sun, 17 Apr 2022 08:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C0C385A4;
        Sun, 17 Apr 2022 08:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650184349;
        bh=SloG/WECzjYIYLRlYm3HUsPkH+gQKLOl9nBd2sKXDIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJU7SLNo8fVXHypscjr4P5PKojNSvRBR+JJqAfSGKiMIjim3zd8t7YMiTo81EqNFT
         gm5yYbt03tL0HCoY3bMycSxpjWoL+gYVA8YZJeH9PHX01wcYye9YLOi0b60hx6i03x
         IMIar3/2tI7t+tCdBqwAGEzeWlPBJ0GY1lyqSPs+0pAkFkuXo1kz7zkg0S9hzMnb/i
         9imSHPKrLkx0qG0YWp1+HAjwqxGPZfNxgoIfygROU78M0Az59+W9koM8f82PoypGuY
         kZDuLzxtYsyPuEKo64Znr8hoYDnkhJSL3UtIlOYk0jzuSAPxof/41jNZILXiM3+q/w
         VbZ8gGiNBVnMg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org, will@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 3/3] csky: atomic: Add conditional atomic operations' optimization
Date:   Sun, 17 Apr 2022 16:32:04 +0800
Message-Id: <20220417083204.2048364-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417083204.2048364-1-guoren@kernel.org>
References: <20220417083204.2048364-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/atomic.h | 95 ++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
index 5ecc657a2a66..3f2917b748c3 100644
--- a/arch/csky/include/asm/atomic.h
+++ b/arch/csky/include/asm/atomic.h
@@ -112,6 +112,101 @@ ATOMIC_OPS(xor)
 
 #undef ATOMIC_FETCH_OP
 
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int prev, tmp;
+
+	__asm__ __volatile__ (
+		"1:	ldex.w		%0, (%3)	\n"
+		"	cmpne		%0, %4		\n"
+		"	bf		2f		\n"
+		"	mov		%1, %0		\n"
+		"	add		%1, %2		\n"
+		RELEASE_FENCE
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
+		"1:	ldex.w		%0, (%2)	\n"
+		"	movi		%1, 0		\n"
+		"	blz		%0, 2f		\n"
+		"	movi		%1, 1		\n"
+		"	addi		%0, 1		\n"
+		RELEASE_FENCE
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
+		"1:	ldex.w		%0, (%2)	\n"
+		"	movi		%1, 0		\n"
+		"	bhz		%0, 2f		\n"
+		"	movi		%1, 1		\n"
+		"	subi		%0, 1		\n"
+		RELEASE_FENCE
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
+		"1:	ldex.w		%0, (%2)	\n"
+		"	subi		%1, %0, 1	\n"
+		"	blz		%1, 2f		\n"
+		RELEASE_FENCE
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

