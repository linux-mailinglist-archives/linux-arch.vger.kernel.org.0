Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A154C2714
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 10:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiBXI7q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 03:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiBXI5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 03:57:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E863FD;
        Thu, 24 Feb 2022 00:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D00B8249D;
        Thu, 24 Feb 2022 08:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C93FC36AE2;
        Thu, 24 Feb 2022 08:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645692992;
        bh=gBbgf5kf3c5mmUEjAYay2wu7mAYR3Ivcy9PEqe9Gg2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qj/38JcZbxTPSmptmMS4yEQnYu+l125VzFo/Ah1g0JDHdEhu43kZTVtnwZLc/VOwj
         yhQWn0u5Z9FXOzml7YR0PGoLfMfGVyBS+kG5JDrW5TsHa5esKlgij8z1R29jh8ldw7
         BcYOSlVRlCHzv0c9iqFnSrznkEMweKP8CD8lUG73uoLXLNIA5bycrxn9Nrobs+gi0G
         AqW514Y4lNjkMo7ntm5w5Yy3ZrGDCREFH8DecO6KSzVfqLvjEDhKPIBAFoXuPCGjo/
         vIk+RgZy6gxnY3ktiN8tfLxe448UsYKijNebRDxXyPgYlYtUMaPNpqPem9zf8mq+w+
         IRHX2pHtJEgzQ==
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
Subject: [PATCH V6 13/20] riscv: compat: process: Add UXL_32 support in start_thread
Date:   Thu, 24 Feb 2022 16:54:03 +0800
Message-Id: <20220224085410.399351-14-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224085410.399351-1-guoren@kernel.org>
References: <20220224085410.399351-1-guoren@kernel.org>
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
index 03ac3aa611f5..54787ca9806a 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 	regs->epc = pc;
 	regs->sp = sp;
+
+	if (is_compat_task())
+		regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
+	else
+		regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
 }
 
 void flush_thread(void)
-- 
2.25.1

