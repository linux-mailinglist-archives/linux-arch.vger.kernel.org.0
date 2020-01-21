Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE22143CBA
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 13:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAUMZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 07:25:31 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40119 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbgAUMZb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jan 2020 07:25:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=majun258@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ToI-QKx_1579609523;
Received: from localhost(mailfrom:majun258@linux.alibaba.com fp:SMTPD_---0ToI-QKx_1579609523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 20:25:28 +0800
From:   MaJun <majun258@linux.alibaba.com>
To:     guoren@kernel.org
Cc:     mj145409@alibaba-inc.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org, MaJun <majun258@linux.alibaba.com>
Subject: [PATCH] csky: Fix the compile error when enable ck860
Date:   Tue, 21 Jan 2020 18:50:00 +0800
Message-Id: <1579603800-25146-1-git-send-email-majun258@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a compile error when ck860 processor is choosed.
To fix this compile error, the FPU config should be disabled.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig           | 2 +-
 arch/csky/configs/defconfig | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847..f6ad4c6 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -154,7 +154,7 @@ config CPU_CK860
 	select CPU_HAS_TLBI
 	select CPU_HAS_CACHEV2
 	select CPU_HAS_LDSTEX
-	select CPU_HAS_FPUV2
+	select CPU_HAS_FPUV2 if CPU_HAS_FPU
 endchoice
 
 choice
diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
index 7ef4289..ad9591c 100644
--- a/arch/csky/configs/defconfig
+++ b/arch/csky/configs/defconfig
@@ -10,9 +10,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_DEFAULT_DEADLINE=y
-CONFIG_CPU_CK807=y
-CONFIG_CPU_HAS_FPU=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -27,10 +24,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_TTY_PRINTK=y
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_CSKY_MPTIMER=y
-CONFIG_GX6605S_TIMER=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
@@ -56,6 +50,5 @@ CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
1.8.3.1

