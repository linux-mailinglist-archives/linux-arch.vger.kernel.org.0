Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05965B9C1
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 04:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjACDgq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 22:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjACDgQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 22:36:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC3D7F;
        Mon,  2 Jan 2023 19:36:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3389FB80C8B;
        Tue,  3 Jan 2023 03:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5858C433EF;
        Tue,  3 Jan 2023 03:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672716973;
        bh=DNY322/iimzurqg2rAQmkk32JHcSLTVqr6N5got/hZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s315F9hd6J9rBdKD//LWIM0NIqtumeJ7LB0D5pJ31t+IHC7MLYwejCtjJv/UWjlf4
         GRPldC+U2v/o+GrcbgQGgrDOFdOEnOJZiOFM3M3yNZmbbeWEy+bYEZg/wwygsRtH0N
         jc3O1+WP7Dr1QQFZu0bpOazsVudbWegKFPiKeNbw0df7rg1cfR2wmrUitbhwyQX8mp
         Aia/3Y14iFp8mS0yoF7CzWAtToWLI8u4pO3xthfnC0ZlXuVvDwgffbz8LaQ8KaqHlP
         KZzM9V0kX7EjQrDsLmyR8PNOhuVsaaiXlqT5apUOdYHEPQhB41Rma2GfT+Q1GSFpbv
         f2sTUvYUIly7Q==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V12 2/7] riscv: ptrace: Remove duplicate operation
Date:   Mon,  2 Jan 2023 22:35:26 -0500
Message-Id: <20230103033531.2011112-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230103033531.2011112-1-guoren@kernel.org>
References: <20230103033531.2011112-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The TIF_SYSCALL_TRACE is controlled by a common code, see
kernel/ptrace.c and include/linux/thread_info.h.

clear_task_syscall_work(child, SYSCALL_TRACE);

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2ae8280ae475..44f4b1ca315d 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -212,7 +212,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 
 void ptrace_disable(struct task_struct *child)
 {
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 long arch_ptrace(struct task_struct *child, long request,
-- 
2.36.1

