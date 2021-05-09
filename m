Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9537764D
	for <lists+linux-arch@lfdr.de>; Sun,  9 May 2021 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhEILQF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 May 2021 07:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhEILQE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 9 May 2021 07:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A6A613E5;
        Sun,  9 May 2021 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620558901;
        bh=dhpv0r+oSYAmFPsd5evBbwf7jZuMlo7Ox0mCiCvxolQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nrs7zKk7p3eRRlNze8Icr/6a/9+J7ewlNh8kbi18Me3K347rkyas8v+mAvArnk2xs
         B6nQneRUCdY/MTMhsvzggkKmAtdoiU7JofWn4zsx5LJyYvXiffkMNB/FgqyA/nzOqG
         CQsSxhlzqdLcwLFUskxCKnykWPFQQaF9C2dOUfdL57ouKECo7JyU8jvXrxZC+VjGCC
         pAmFohjzEcj+Z0u8ulo5Bwz/toicpnqQ8ifcvEFCemJjkcxm2k96mlJmBqp6rMzN3j
         u0T7qAYpLwDO1CSRF5yQ0qcmmEToeQENq57SyZ1aNCR+NfWQXmoF1VEkx5L7VQ3paH
         ogqye1ATyBpAA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Fixup 610 bootup failed
Date:   Sun,  9 May 2021 11:14:17 +0000
Message-Id: <1620558857-22425-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Actually, there is only one 610 product is in the market(gx6605s).

The soc's DRAM base is 0x10000000, so make it default for 610.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8de5b98..4d59d66 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -316,7 +316,9 @@ config FORCE_MAX_ZONEORDER
 
 config DRAM_BASE
 	hex "DRAM start addr (the same with memory-section in dts)"
-	default 0x0
+	default 0x10000000	if (CPU_CK610)
+	default 0x0		if (!CPU_CK610)
+
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.7.4

