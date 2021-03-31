Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0458E35025B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhCaOc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236078AbhCaOcs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6931060FF3;
        Wed, 31 Mar 2021 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201168;
        bh=sUpQ42V7/BeYJXo8xKilrJhdJzUrsLncMVt8E/NbmTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCVYBSdWsYiqvYH5oYGVId4/MzMe7NvqmPl9pDexAmFGD5cqNZXH9o4HF+vhiGkPO
         8FwMZKnRdTNt/mGm5FdZTRJq1SejRG6Dxn8BSX9Q9sF8/FJERgS/Joq1pLuXw/+SpX
         fYWvWFagOvEbTBlo/Pm13nwT+dH76caJG6x5oxHY56TU/7XMud7W4lSCBA+Ztvbs94
         c0JgeKblXHOXlNsS4FEsCYE4cla47L5ne5HZ+MMUdf+o+9w1vaKOmt595yXPl7W+Hh
         KH/sOLUZchvSdfTn72MXz6kpPr/LWwx757q1Byt0vVOGqX8v9929SUwkrE66Ui0awe
         zbLNNqBSjJGpA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v6 8/9] xtensa: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 14:30:39 +0000
Message-Id: <1617201040-83905-9-git-send-email-guoren@kernel.org>
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

