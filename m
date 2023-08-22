Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25222784545
	for <lists+linux-arch@lfdr.de>; Tue, 22 Aug 2023 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjHVPUU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Aug 2023 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPUU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2023 11:20:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A2ECC6;
        Tue, 22 Aug 2023 08:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D4C626DA;
        Tue, 22 Aug 2023 15:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E2C433C7;
        Tue, 22 Aug 2023 15:20:14 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix hw_breakpoint_control() for watchpoints
Date:   Tue, 22 Aug 2023 23:19:43 +0800
Message-Id: <20230822151943.1115318-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In hw_breakpoint_control(), encode_ctrl_reg() has already encoded the
MWPnCFG3_LoadEn/MWPnCFG3_StoreEn bits in info->ctrl. We don't need to
add (1 << MWPnCFG3_LoadEn | 1 << MWPnCFG3_StoreEn) unconditionally.

Otherwise we can't set read watchpoint and write watchpoint separately.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/hw_breakpoint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index 021b59c248fa..fc55c4de2a11 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -207,8 +207,7 @@ static int hw_breakpoint_control(struct perf_event *bp,
 			write_wb_reg(CSR_CFG_CTRL, i, 0, CTRL_PLV_ENABLE);
 		} else {
 			ctrl = encode_ctrl_reg(info->ctrl);
-			write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl | CTRL_PLV_ENABLE |
-				     1 << MWPnCFG3_LoadEn | 1 << MWPnCFG3_StoreEn);
+			write_wb_reg(CSR_CFG_CTRL, i, 1, ctrl | CTRL_PLV_ENABLE);
 		}
 		enable = csr_read64(LOONGARCH_CSR_CRMD);
 		csr_write64(CSR_CRMD_WE | enable, LOONGARCH_CSR_CRMD);
-- 
2.39.3

