Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698E2182BB2
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLI66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 04:58:58 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50517 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbgCLI65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 04:58:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=majun258@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsNV0cR_1584003530;
Received: from localhost(mailfrom:majun258@linux.alibaba.com fp:SMTPD_---0TsNV0cR_1584003530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Mar 2020 16:58:55 +0800
From:   Ma Jun <majun258@linux.alibaba.com>
To:     guoren@kernel.org
Cc:     majun258@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [PATCH]arch/csky:Enable the gcov function in csky achitecture
Date:   Tue, 10 Mar 2020 23:32:56 +0800
Message-Id: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Support the gcov function in csky architecture

Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 047427f..9c4749d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -64,6 +64,7 @@ config CSKY
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
 	select PCI_MSI if PCI
+	select ARCH_HAS_GCOV_PROFILE_ALL
 
 config CPU_HAS_CACHEV2
 	bool
-- 
1.8.3.1

