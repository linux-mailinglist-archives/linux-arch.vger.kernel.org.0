Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF27574A0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGRGsx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGRGsr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 02:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B1B2;
        Mon, 17 Jul 2023 23:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C5E961484;
        Tue, 18 Jul 2023 06:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D226C433C9;
        Tue, 18 Jul 2023 06:48:40 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Cleanup __builtin_constant_p() checking for cpu_has_*
Date:   Tue, 18 Jul 2023 14:48:19 +0800
Message-Id: <20230718064819.2549052-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In current configuration, cpu_has_lsx and cpu_has_lasx are impossible
constants. So cleanup the __builtin_constant_p() checking to reduce the
complexity.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/fpu.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index e4193d637f66..f02f4a0d0d64 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -218,12 +218,7 @@ static inline void restore_lsx(struct task_struct *t)
 
 static inline void init_lsx_upper(void)
 {
-	/*
-	 * Check cpu_has_lsx only if it's a constant. This will allow the
-	 * compiler to optimise out code for CPUs without LSX without adding
-	 * an extra redundant check for CPUs with LSX.
-	 */
-	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
+	if (!cpu_has_lsx)
 		return;
 
 	_init_lsx_upper();
@@ -294,7 +289,7 @@ static inline void restore_lasx_upper(struct task_struct *t) {}
 
 static inline int thread_lsx_context_live(void)
 {
-	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
+	if (!cpu_has_lsx)
 		return 0;
 
 	return test_thread_flag(TIF_LSX_CTX_LIVE);
@@ -302,7 +297,7 @@ static inline int thread_lsx_context_live(void)
 
 static inline int thread_lasx_context_live(void)
 {
-	if (__builtin_constant_p(cpu_has_lasx) && !cpu_has_lasx)
+	if (!cpu_has_lasx)
 		return 0;
 
 	return test_thread_flag(TIF_LASX_CTX_LIVE);
-- 
2.39.3

