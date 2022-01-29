Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1464A2F08
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 13:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbiA2MTN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 07:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiA2MSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 07:18:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40CC061751;
        Sat, 29 Jan 2022 04:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B78360B65;
        Sat, 29 Jan 2022 12:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25475C340EE;
        Sat, 29 Jan 2022 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643458731;
        bh=yfEc7zgR3yCBk8Yfn7aWFLEsFQj0j+xfa9v6cbpF6Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdpjdGlMRcHuKdx8nas7nPKxC+10cSp8Gfll1lqGgxvkbB8YMYFeOfPCOFz0wFp+u
         9/wmW0N0MD8TmY+dIFAVv+uY/IExYZRNW0QrxlGzf4RTm0Z6GxFGAc1jqtvqVIIhMp
         hrqQ5ZFYS2uBzY7I/NxA2chymSofMTj6klfxdNpbbHDT+y+GzHDaiCYfQ+qc2nJ+WK
         rPN+CcR7X4tlP/Io4QKbVho8BBzc8L27AzR3L8Vx/GRx0Tr9dBKAMH0FhiaM30UbJz
         TfMy5Ok9Ke1Ki9f6sQIR2w/W22msyhxmfPJYSbES6kdtGlinYTgx6ugDgmejCvK78W
         oZZH/n08IfzQg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 10/17] riscv: compat: process: Add UXL_32 support in start_thread
Date:   Sat, 29 Jan 2022 20:17:21 +0800
Message-Id: <20220129121728.1079364-11-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129121728.1079364-1-guoren@kernel.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
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

