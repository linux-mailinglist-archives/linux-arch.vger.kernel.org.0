Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1719C53D609
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jun 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiFDIEn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jun 2022 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiFDIEm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jun 2022 04:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAF35AA0
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 01:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423BB60F06
        for <linux-arch@vger.kernel.org>; Sat,  4 Jun 2022 08:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5399CC385B8;
        Sat,  4 Jun 2022 08:04:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix copy_thread() build error
Date:   Sat,  4 Jun 2022 16:06:14 +0800
Message-Id: <20220604080614.268078-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
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

Commit c5febea0956fd387 ("fork: Pass struct kernel_clone_args into
copy_thread") change the prototype of copy_thread() and cause build
error, fix it.

Fixes: c5febea0956fd387 ("fork: Pass struct kernel_clone_args into copy_thread")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/process.c | 7 +++++--
 include/linux/efi.h             | 1 +
 include/linux/pe.h              | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 6d944d65f600..5e090ffd16b9 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -120,10 +120,13 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-	unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
+int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long childksp;
+	unsigned long tls = args->tls;
+	unsigned long usp = args->stack;
+	unsigned long clone_flags = args->flags;
+	unsigned long kthread_arg = args->stack_size;
 	struct pt_regs *childregs, *regs = current_pt_regs();
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
