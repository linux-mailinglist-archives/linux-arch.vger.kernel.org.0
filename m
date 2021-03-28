Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8C34BB5D
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC1Gb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 02:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhC1Gbj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 02:31:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFCCB61999;
        Sun, 28 Mar 2021 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616913099;
        bh=O2KxmIPB+fHLZecH69jIXhtq++wb564lj/icyjeUAfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIkij08xlS8DB8+yEsaHfhkJ4frVk8aqcXZKUjc8aZRsRg14dDqPdSr8TSjbqYWar
         YZa7xXiDmepsbU0aY2OQB+g9ZqgA6O0epYM/s/Lq/CGXTTUZR/qeGjvktEkSawSenY
         6uspD6vEI92SJzbXoQjxXYH9frX6UTrSuMhM5XRheYpddQnE2p8LoyPEDQ5x0vhDc+
         aPIyENu/RTIQJgeveEE/LmORCiHcAjMknUD4XEEpdndhKUefcId80TspfCdlvafStJ
         6CIxmOlQadSXN+7398RrpGZOq23MCSKdY+hW6nlsOKJHvtdBV75Hz84ouhtYXGQH+u
         8EGq83B9rHGOg==
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
Subject: [PATCH v5 6/7] sparc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Sun, 28 Mar 2021 06:30:27 +0000
Message-Id: <1616913028-83376-7-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616913028-83376-1-git-send-email-guoren@kernel.org>
References: <1616913028-83376-1-git-send-email-guoren@kernel.org>
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

