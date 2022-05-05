Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7651B6CF
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiEED7l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 23:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242381AbiEED7i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 23:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF674A3FD;
        Wed,  4 May 2022 20:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18FC6135D;
        Thu,  5 May 2022 03:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE0C385AE;
        Thu,  5 May 2022 03:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722953;
        bh=PFNl6xABaY2in+HPLdVvyvlQKRywP5jYrBLTCrJwmLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUpRYvGbqagkM91KCHl9lnkgT0M4jydo1Y6ta+GWU2KUqBmrdLFm8jStVLcZIFsed
         a1RIgXuZWvD+s5Y13WJ0IQrQUKU4fwTb5IpgbM3TMbXKpuM8ipOoLuqko9QFs8Ybrc
         Qh9TnQk9+vMsNht8F/daDwNtQZ8jDPd5wvWbgzB/EgDJtEvTI8ToXhDjmrVbO3puHO
         oRiB0XGP9uSm6NMcM6QhpwLZ24EMTJuKrLNUpa2Dn6+UsWJ5mCOxIrHOONSpJEvjTo
         BW1TM8HoViprvZV+l/ZWMdKFMQZAkBcEnkyYClT4Ku7p8JDwg8V/L3DpN/HVdN4r8c
         zJwNNZFNa3lxQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 3/5] riscv: atomic: Add custom conditional atomic operation implementation
Date:   Thu,  5 May 2022 11:55:24 +0800
Message-Id: <20220505035526.2974382-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505035526.2974382-1-guoren@kernel.org>
References: <20220505035526.2974382-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add conditional atomic operations' custom implementation (similar
to dec_if_positive), here is the list:
 - arch_atomic_inc_unless_negative
 - arch_atomic_dec_unless_positive
 - arch_atomic64_inc_unless_negative
 - arch_atomic64_dec_unless_positive

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Dan Lustig <dlustig@nvidia.com>
---
 arch/riscv/include/asm/atomic.h | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f3c6a6eac02a..0dfe9d857a76 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -310,6 +310,46 @@ ATOMIC_OPS()
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 
+static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int prev, rc;
+
+	__asm__ __volatile__ (
+		"0:	lr.w      %[p],  %[c]\n"
+		"	bltz      %[p],  1f\n"
+		"	addi      %[rc], %[p], 1\n"
+		"	sc.w.rl   %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
+		"	fence     rw, rw\n"
+		"1:\n"
+		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
+		:
+		: "memory");
+	return !(prev < 0);
+}
+
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+
+static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int prev, rc;
+
+	__asm__ __volatile__ (
+		"0:	lr.w      %[p],  %[c]\n"
+		"	bgtz      %[p],  1f\n"
+		"	addi      %[rc], %[p], -1\n"
+		"	sc.w.rl   %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
+		"	fence     rw, rw\n"
+		"1:\n"
+		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
+		:
+		: "memory");
+	return !(prev > 0);
+}
+
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+
 static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 {
        int prev, rc;
@@ -331,6 +371,48 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 #define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
 
 #ifndef CONFIG_GENERIC_ATOMIC64
+static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	s64 prev;
+	long rc;
+
+	__asm__ __volatile__ (
+		"0:	lr.d      %[p],  %[c]\n"
+		"	bltz      %[p],  1f\n"
+		"	addi      %[rc], %[p], 1\n"
+		"	sc.d.rl   %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
+		"	fence     rw, rw\n"
+		"1:\n"
+		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
+		:
+		: "memory");
+	return !(prev < 0);
+}
+
+#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+
+static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	s64 prev;
+	long rc;
+
+	__asm__ __volatile__ (
+		"0:	lr.d      %[p],  %[c]\n"
+		"	bgtz      %[p],  1f\n"
+		"	addi      %[rc], %[p], -1\n"
+		"	sc.d.rl   %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
+		"	fence     rw, rw\n"
+		"1:\n"
+		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
+		:
+		: "memory");
+	return !(prev > 0);
+}
+
+#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+
 static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
        s64 prev;
-- 
2.25.1

