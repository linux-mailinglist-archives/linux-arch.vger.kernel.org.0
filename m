Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF07817D306
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 10:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCHJxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 05:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgCHJxf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:35 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0F82084E;
        Sun,  8 Mar 2020 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661214;
        bh=mIeF30dk8XepLf65MsnIOdXD9aNqAhyxQIdY1ux2I4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oncBC7OEpGbGBhNHsUFoTc6m6jijE7vStDC2neSm6LzZpaM0vxsYZJRL1o+mVZeG6
         ERWPjYq/0Th/usgmJFYQBdNNLE+/eM/Yv9L4iW5NtWmREw0A/4ITjKRLvFYNx2W5Q1
         OJCbxrpoDh3j9EQ/5yPf0VT9G6bCsKAhqHu4AsL8=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 06/11] riscv: Add has_vector detect
Date:   Sun,  8 Mar 2020 17:49:49 +0800
Message-Id: <20200308094954.13258-7-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch is to detect "has_vector" at time of CPU feature
parsing.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c8527d770c98..c9ab24e3c79e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -16,6 +16,9 @@ unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
+#ifdef CONFIG_VECTOR
+bool has_vector __read_mostly;
+#endif
 
 void riscv_fill_hwcap(void)
 {
@@ -73,4 +76,9 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		has_fpu = true;
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V)
+		has_vector = true;
+#endif
 }
-- 
2.17.0

