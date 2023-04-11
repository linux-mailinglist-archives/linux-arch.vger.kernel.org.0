Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A368C6DD730
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKJup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDKJub (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 05:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBC10E5;
        Tue, 11 Apr 2023 02:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0B462377;
        Tue, 11 Apr 2023 09:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C48AC433D2;
        Tue, 11 Apr 2023 09:50:26 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH] LoongArch: Enable PG when wakeup from suspend
Date:   Tue, 11 Apr 2023 17:49:59 +0800
Message-Id: <20230411094959.3368451-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some firmwares don't enable PG when wakeup from suspend, so do it in
kernel. This can improve code compatibility for boot kernel.

Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/power/suspend_asm.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/power/suspend_asm.S b/arch/loongarch/power/suspend_asm.S
index 90da899c06a1..e2fc3b4e31f0 100644
--- a/arch/loongarch/power/suspend_asm.S
+++ b/arch/loongarch/power/suspend_asm.S
@@ -80,6 +80,10 @@ SYM_INNER_LABEL(loongarch_wakeup_start, SYM_L_GLOBAL)
 
 	JUMP_VIRT_ADDR	t0, t1
 
+	/* Enable PG */
+	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
+	csrwr		t0, LOONGARCH_CSR_CRMD
+
 	la.pcrel	t0, acpi_saved_sp
 	ld.d		sp, t0, 0
 	SETUP_WAKEUP
-- 
2.39.1

