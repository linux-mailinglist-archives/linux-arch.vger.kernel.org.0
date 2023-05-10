Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EAE6FE294
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEJQfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjEJQfX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 12:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516787D8B;
        Wed, 10 May 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D803F63F22;
        Wed, 10 May 2023 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBAC4339C;
        Wed, 10 May 2023 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736515;
        bh=D/zx5C3wzjM0zZXbvIgMONVy5BqICz3TUA896+jQLlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pM5PoYrty7yCH0RwPEETSGMTPtIBfqrDnxC1Of4QRrUvRYpcqhfo6CnKstuBdrJ1p
         Y8cTCUfcyPT9HCkODQhlW0ldspb1r8HMngbvPk58T/mxUVoWPYO0S8YT67WaBZmkkS
         0guf3w7XP62n7Ufw6skcC1kTsgNS41PBKc3ftTIiOzKTnQIUvBMw98EWCV5UsjLA28
         6w71JHcobAAmgW+ISjtdcEJaao3XBzY1Aov9TpeRhc+o6IRxbfwVCAXdnvBBH/xOYT
         JabESi0GONWMCoSl4Pw7TmgOCBO1uEBG3nscObwQzvG6izQ9zkRZEu5L++sWiusIiK
         gcuU64Yx8J6dw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Schaffner Tobias <tobias.schaffner@siemens.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RT 1/3] asm-generic/preempt: also check preempt_lazy_count for should_resched() etc.
Date:   Thu, 11 May 2023 00:24:04 +0800
Message-Id: <20230510162406.1955-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162406.1955-1-jszhang@kernel.org>
References: <20230510162406.1955-1-jszhang@kernel.org>
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

lazy preempt count is great mechanism to help ordinary SCHED_OTHER
tasks' throughput Under PREEMPT_RT. But current implementation relies
on each arch-specific code to check the preempt_lazy_count in
should_resched() and __preempt_count_dec_and_test(), if the arch, e.g
riscv use the asm-generic preempt implementation, it losts the great
lazy preempt mechanism.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/asm-generic/preempt.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index b4d43a4af5f7..b583e7c38ccf 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -59,6 +59,11 @@ static __always_inline void __preempt_count_sub(int val)
 	*preempt_count_ptr() -= val;
 }
 
+#ifdef CONFIG_PREEMPT_LAZY
+#define preempt_lazy_count()		(current_thread_info()->preempt_lazy_count)
+#else
+#define preempt_lazy_count()		(0)
+#endif
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	/*
@@ -66,7 +71,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
 	 * lost.
 	 */
-	return !--*preempt_count_ptr() && tif_need_resched();
+	return !--*preempt_count_ptr() && !preempt_lazy_count() && tif_need_resched();
 }
 
 /*
@@ -75,6 +80,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 	return unlikely(preempt_count() == preempt_offset &&
+			!preempt_lazy_count() &&
 			tif_need_resched());
 }
 
-- 
2.40.1

