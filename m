Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ECD350260
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhCaOc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236067AbhCaOck (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 717C960FF1;
        Wed, 31 Mar 2021 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201160;
        bh=O2KxmIPB+fHLZecH69jIXhtq++wb564lj/icyjeUAfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuD7utNvxc71QnlLEo6eyoz8UG0sDZiPBtJt3hag6/s4X/dkfRLDhQ5OqJXJFt+j6
         9qXx33FPUmx3G35TT6KpggWZk8CzgnRPRkmBuxb41XLDNB+DLsaZLfn7okWhGAP/fd
         XIcnJzsaYKQDC+07SeSrpysX9+39Fr229UOr1ud5VmRf3ZrA9MM7B1eQrw7Q9Xqnw1
         QLPvIZ3ogIZFd7LK13OYk2vgisiZmroVX6LOouaaODc0ya16hQUPWrUf3ielzPGQMu
         g+xqdXQe1Wujk2SS7zfx9ORiUOU/DX/5BKyLBaTlndIEiV02In4jpH7PAyTKRovgEx
         KBwMY3BPTvyjg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Gardner <rob.gardner@oracle.com>
Subject: [PATCH v6 7/9] sparc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 14:30:38 +0000
Message-Id: <1617201040-83905-8-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617201040-83905-1-git-send-email-guoren@kernel.org>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We don't have native hw xchg16 instruction, so let qspinlock
generic code to deal with it.

Using the full-word atomic xchg instructions implement xchg16 has
the semantic risk for atomic operations.

This patch cancels the dependency of on qspinlock generic code on
architecture's xchg16.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..1079fe3f058c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,6 +91,7 @@ config SPARC64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
-- 
2.17.1

