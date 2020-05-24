Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132841E0058
	for <lists+linux-arch@lfdr.de>; Sun, 24 May 2020 18:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgEXQAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 May 2020 12:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgEXQAp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 24 May 2020 12:00:45 -0400
Received: from localhost.localdomain (unknown [115.204.118.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE2220853;
        Sun, 24 May 2020 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590336045;
        bh=6QgtLV+0vdTqaB+iHBsYydQhtUGWMXrsX6zRo+CZDt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8Dr+hMGMPiJKX8wsWzSoMm/CT00gzF5Fi58FAO9g1kl9sHRXh9frcBg2AwkmKIZE
         +NQoKD4zihBpU2B1q+NrQiMgVyTYfx5LXjyUNyqDgtr4+Hug+vFV9tYttpS0cRNEn4
         eSAchpQ1veZv/RO2+haPj7kxe2WQcbPn/vSuWL1g=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arnd.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] csky: Fixup abiv2 syscall_trace break a4 & a5
Date:   Sun, 24 May 2020 15:59:23 +0000
Message-Id: <1590335964-79023-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590335964-79023-1-git-send-email-guoren@kernel.org>
References: <1590335964-79023-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current implementation could destory a4 & a5 when strace, so we need to get them
from pt_regs by SAVE_ALL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv2/inc/abi/entry.h | 2 ++
 arch/csky/kernel/entry.S        | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 698df2f..6ee71bf 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -13,6 +13,8 @@
 #define LSAVE_A1	28
 #define LSAVE_A2	32
 #define LSAVE_A3	36
+#define LSAVE_A4	40
+#define LSAVE_A5	44
 
 #define KSPTOUSP
 #define USPTOKSP
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index bfbef30..76dc729 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -173,8 +173,10 @@ csky_syscall_trace:
 	ldw	a3, (sp, LSAVE_A3)
 #if defined(__CSKYABIV2__)
 	subi	sp, 8
-	stw	r5, (sp, 0x4)
-	stw	r4, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A4)
+	stw	r9, (sp, 0x0)
+	ldw	r9, (sp, LSAVE_A5)
+	stw	r9, (sp, 0x4)
 #else
 	ldw	r6, (sp, LSAVE_A4)
 	ldw	r7, (sp, LSAVE_A5)
-- 
2.7.4

