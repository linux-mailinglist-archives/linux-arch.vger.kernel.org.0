Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972838F84F
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 04:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhEYCsx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 22:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230255AbhEYCsx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 22:48:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B91D613F5;
        Tue, 25 May 2021 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621910844;
        bh=AVRcXtmLCIJi5XnfF9tb6jrsuH0Q2wdP15ACb5u8w4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyyT73HbHY0cm5IyO2xEVdvH1M8nQXF7qK5A/fdEkoXO2swvy6PSID+TwxhDJtELF
         l9V0V2lQZzFWQEEpoOF07KLLvGQud4M1cficgvUXueJNfBpI6h9c9PNq3WaxJrsGTY
         5frmBpssWcFnZizsl+BrAsRXvXEeen+78LHvNFfD1FhvLo0LaUBLxm6VY6AOlqmNNt
         TFvvh8jiO2UcOY5Ya/zs/usVa+LDn0c3YNLVLn19tVTdVMjFAFh/VDxDBGv2eiqXrv
         46AeKsghCK4x7J+0oTlLr2+JsSwoMmLjTR3tAQMCQCoW/85sm9hZAxaK00d3l5kx4G
         nD+W/MV7yYdEQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 1/2] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
Date:   Tue, 25 May 2021 02:46:26 +0000
Message-Id: <1621910787-34598-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621910787-34598-1-git-send-email-guoren@kernel.org>
References: <1621910787-34598-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Kernel virtual address translation should avoid care asid or it'll
cause more TLB-miss and TLB-refill. Because the current asid in satp
belongs to the current process, but the target kernel va TLB entry's
asid still belongs to the previous process.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
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

