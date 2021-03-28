Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE334BB5F
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhC1Gb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 02:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhC1Gbm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 02:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4715619A0;
        Sun, 28 Mar 2021 06:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616913102;
        bh=sUpQ42V7/BeYJXo8xKilrJhdJzUrsLncMVt8E/NbmTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1i+Vgp+d0Nt/rDzju12lI4q66EYLkSy5JZ076QiXlZZAxL4Zz1kplBNEVKnDnzeL
         XUtkjJuzzqCLW32Oy7ysq/RMmkHMZuPYez5Wyxk2SMMxQoDGAf6hQweBSn8yFBqUCW
         ilcp7x5OfSZ83pAAh9tjiC72g4z2cXm2BDzOz97kdkTOZQbGOFPWZ2VNnDrQitQwTS
         PSxomOd2/RHIlHwBLl4fVNVs7Ua1PUFN+gK1ipO1IHCQiFh6FVawbp4ISyuFZ29+sQ
         ZJw6ShzgANhvydDXfVdd/XWVF3Es2P54W9xEgMHObmbb/odl0xgFm9ORAQlNoAWC4v
         O2brtoUrLFkBQ==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v5 7/7] xtensa: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Sun, 28 Mar 2021 06:30:28 +0000
Message-Id: <1616913028-83376-8-git-send-email-guoren@kernel.org>
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
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9ad6b7b82707..f19d780638f7 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -9,6 +9,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
-- 
2.17.1

