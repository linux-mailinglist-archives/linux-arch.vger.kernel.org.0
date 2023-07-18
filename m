Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1475771D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGRIyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjGRIyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 04:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E279EE55;
        Tue, 18 Jul 2023 01:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7861B614CA;
        Tue, 18 Jul 2023 08:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C995C433C7;
        Tue, 18 Jul 2023 08:53:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH V2] LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_*
Date:   Tue, 18 Jul 2023 16:53:27 +0800
Message-Id: <20230718085327.2691237-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the current configuration, cpu_has_lsx and cpu_has_lasx cannot be
constants. So cleanup the __builtin_constant_p() checking to reduce the
complexity.

Reviewed-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Update commit message.

 arch/loongarch/include/asm/fpu.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index e4193d637f66..b541f6248837 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -218,15 +218,8 @@ static inline void restore_lsx(struct task_struct *t)
 
 static inline void init_lsx_upper(void)
 {
-	/*
-	 * Check cpu_has_lsx only if it's a constant. This will allow the
-	 * compiler to optimise out code for CPUs without LSX without adding
-	 * an extra redundant check for CPUs with LSX.
-	 */
-	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
-		return;
-
-	_init_lsx_upper();
+	if (cpu_has_lsx)
+		_init_lsx_upper();
 }
 
 static inline void restore_lsx_upper(struct task_struct *t)
@@ -294,7 +287,7 @@ static inline void restore_lasx_upper(struct task_struct *t) {}
 
 static inline int thread_lsx_context_live(void)
 {
-	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
+	if (!cpu_has_lsx)
 		return 0;
 
 	return test_thread_flag(TIF_LSX_CTX_LIVE);
@@ -302,7 +295,7 @@ static inline int thread_lsx_context_live(void)
 
 static inline int thread_lasx_context_live(void)
 {
-	if (__builtin_constant_p(cpu_has_lasx) && !cpu_has_lasx)
+	if (!cpu_has_lasx)
 		return 0;
 
 	return test_thread_flag(TIF_LASX_CTX_LIVE);
-- 
2.39.3

