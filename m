Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F1508B03
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379797AbiDTOrt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379785AbiDTOrj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 10:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D9240;
        Wed, 20 Apr 2022 07:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F371E6176C;
        Wed, 20 Apr 2022 14:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC5C385A0;
        Wed, 20 Apr 2022 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650465891;
        bh=uhUfyEvMq+wqDi6kDMjqVy2PHOt/CvPeNGoHGdg5hr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZIMXDq+kA8YeVTfqhw0qC4fqHVN56HMMHEaEDn/0GQjStW7aOmFByvOIvov2Ol4i
         iNcGQL//4xEg3r+cQzmkB728AHYHF6CLTT8Dh3mMy38JFkme7CWoW9C8R7pOxj6y7h
         6EJtlr0+9A0T2m1A44CeFYm75ovrK2R7uRCAdSKTc0V4tUydNNLJGTiMk9PPvgTfxB
         5S/WU6AGyQnA8opiXLWGC/e0uv4COExuwGq5UPtN5QrwBb8H5ipK4vxBo4grNokhRz
         U1A6NFo5X0liMzHZGeC8KDCml7sKqAnvt4lyofJjiYNgWMwj0gmIJX3NwX1mwhBRQ/
         A37xq72Z0v1xA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, palmer@dabbelt.com,
        mark.rutland@arm.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, dlustig@nvidia.com, parri.andrea@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 5/5] riscv: atomic: Add conditional atomic operations' optimization
Date:   Wed, 20 Apr 2022 22:44:17 +0800
Message-Id: <20220420144417.2453958-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420144417.2453958-1-guoren@kernel.org>
References: <20220420144417.2453958-1-guoren@kernel.org>
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
 arch/riscv/include/asm/atomic.h | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 5589e1de2c80..a62c5de71033 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -374,6 +374,44 @@ ATOMIC_OPS()
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
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
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
+		"	sc.w.aqrl %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
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
@@ -394,6 +432,46 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
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
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
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
+		"	sc.d.aqrl %[rc], %[rc], %[c]\n"
+		"	bnez      %[rc], 0b\n"
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

