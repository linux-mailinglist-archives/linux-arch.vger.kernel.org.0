Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C366639CE39
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFFJGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFJGw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADAC061429;
        Sun,  6 Jun 2021 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970303;
        bh=OILVP/xTrY25solt1VG9doQOz27QZP5b+AfmystSFro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wwd1JFTUhf/IlgOz7j2TUa5JCLi2yaOe/hCx2R788MyBvmkFVbfkQJIjFZC1pA0Qb
         Rl5GK2mPJGAdfyAm1Awa1m2d4tjOphz3ceoA32ULnQTCzEIsAsw+TPpbGzZGN7HCLL
         8gosXVoV8lECcwhCT2WPflUCKOtZjyIoDPHPmAV4oR/im31bj2TRLNgM3azv9Jq8rT
         fHpOO654x8qu1VdHEZg0YMfNIch6lNCTRVcUN2h8LLq3bqTxM38SDou1FHmL9qL2CD
         eb0L02cWE18iNh/VsEig5twdfNkYb+WJsG4QEDQHi8/dQrMKWW6SKdFbfZG5lxqaPK
         zvbwLJjZoNrHw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v2 01/11] riscv: asid: Use global mappings for kernel pages
Date:   Sun,  6 Jun 2021 09:03:56 +0000
Message-Id: <1622970249-50770-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We map kernel pages into all addresses space, so they can be marked as
global. This allows hardware to avoid flushing the kernel mappings when
moving between address spaces.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9469f46..346a3c6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -134,7 +134,8 @@
 				| _PAGE_WRITE \
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
-				| _PAGE_DIRTY)
+				| _PAGE_DIRTY \
+				| _PAGE_GLOBAL)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
-- 
2.7.4

