Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9FC4A5F5A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiBAPH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:07:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34350 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbiBAPHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:07:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4AC61646;
        Tue,  1 Feb 2022 15:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDA7C340F2;
        Tue,  1 Feb 2022 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728039;
        bh=yfEc7zgR3yCBk8Yfn7aWFLEsFQj0j+xfa9v6cbpF6Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XijAuT9bnUGuYuCUmoALNBnEHlhZtDhCRON0RFO4F+1ePEy+7up2ymK2Ee3ugl35d
         Yaj4xeZMW1Asnh8eo46/EAvXu1I0vZizvuVgx83fqUzo8RsmbK6A0q/tKOhnA0InKi
         07WJFqfZsdSh5B1iKRzKqYFRDDFUKI41b/wd93Vpr0zWE29Vemj8+KymSC4bYkkMlK
         JB4JE4rW7JwmWjGG1DiEeSWyBj2hf6gCDG2iHi5SRLLhWJ8QP9q8kXMniqKjs6zzoA
         8r9gJx1Nsox9ck34CBiPhkdvtWJWJEwJ5CP7vktOGRnnlpclGdvMSGvdk6RShWn2ie
         QD1vkrdlU+wZQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 13/21] riscv: compat: process: Add UXL_32 support in start_thread
Date:   Tue,  1 Feb 2022 23:05:37 +0800
Message-Id: <20220201150545.1512822-14-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201150545.1512822-1-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If the current task is in COMPAT mode, set SR_UXL_32 in status for
returning userspace. We need CONFIG _COMPAT to prevent compiling
errors with rv32 defconfig.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/kernel/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..1a666ad299b4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 	regs->epc = pc;
 	regs->sp = sp;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		regs->status |= SR_UXL_32;
+#endif
 }
 
 void flush_thread(void)
-- 
2.25.1

