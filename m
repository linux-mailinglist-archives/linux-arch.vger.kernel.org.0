Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723C5813BE
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jul 2022 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiGZNCa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGZNC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 09:02:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D415FF7
        for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2022 06:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A47B6B8161F
        for <linux-arch@vger.kernel.org>; Tue, 26 Jul 2022 13:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD44C385A2;
        Tue, 26 Jul 2022 13:02:23 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Disable executable stack by default
Date:   Tue, 26 Jul 2022 21:02:24 +0800
Message-Id: <20220726130224.3987623-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Disable executable stack for LoongArch by default, as all modern
architectures do.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/elf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index f3960b18a90e..5f3ff4781fda 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -288,8 +288,6 @@ struct arch_elf_state {
 	.interp_fp_abi = LOONGARCH_ABI_FP_ANY,	\
 }
 
-#define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
-
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 			    bool is_interp, struct arch_elf_state *state);
 
-- 
2.31.1

