Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C338E137
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhEXGxd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 02:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhEXGx3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 02:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF7D16105A;
        Mon, 24 May 2021 06:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621839121;
        bh=KUxxMIboqKng0IyfhiaidfhsDw8pJK1odbLPMKgDjI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udf5cfged3xJcKnJN0XoXqeYbQ0f5K1ItIBM4/rX3qVl3zq0o66OSs+jvQI8iGKPi
         k3TNWFD0Wy++YLJR6elWv1awp2Hc+F8SlD4xUyJURVV790FfznntEmso4uz/Hp7IQ+
         h7GILcX79KxX4twcBc3GHarBu8vgWHfQGRXMH59acXvLCfA2IJlu8mTNH5+QGDQInw
         5lO+UsL4yaX/UsydRvf/0l2qGbksND2U/lJGO8t4lLjCxMRfzJVk3t/VXBKPRvlzkN
         HodTttLhOO8Ti2TSX8dLoDT/UDIkfVx/psRGBdRVL/+zQZkUWpHbYPUoWTVQf4qfcg
         oyQlhK6dUtqgQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] riscv: Fixup PAGE_UP in asm/page.h
Date:   Mon, 24 May 2021 06:51:07 +0000
Message-Id: <1621839068-31738-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621839068-31738-1-git-send-email-guoren@kernel.org>
References: <1621839068-31738-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current PAGE_UP implementation is wrong. PAGE_UP(0) should be
0x1000, but current implementation will give out 0.

Although the current PAGE_UP isn't used, it will soon be used in
tlb_flush optimization.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 6a7761c..c611b20 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,7 +37,7 @@
 
 #ifndef __ASSEMBLY__
 
-#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
+#define PAGE_UP(addr)	(((addr)+(PAGE_SIZE))&(~((PAGE_SIZE)-1)))
 #define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
 
 /* align addr on a size boundary - adjust address up/down if needed */
-- 
2.7.4

