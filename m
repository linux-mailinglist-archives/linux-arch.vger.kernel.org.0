Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFC34BB5C
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC1Gbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 02:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhC1Gbc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 02:31:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAC76191A;
        Sun, 28 Mar 2021 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616913092;
        bh=QzKnPWoBnPHqdJHKCVpbj1BpTP2hO0zRu8JrhjYU+j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCRMri96fe/VV+ky4tT+TYgNgYdWWJzEgeXfW1Tvd/axc2XqcW9wem1Jg6EWGepv2
         QjpcK6XDPVTYzlAGc9cBpGJNs76gqhECTTGkJoQEDk+3zXn3vooA/aHijGpPJOqIjA
         KaNg4iVmEpWEVc+v+reBWXGLdp/9vX3UPt6ESFnyGi8C3C85wjhdaSIOc2rHkvEjGU
         q/dKoB5wnBsLvoh7s8j/ZofobGS9h+hH0KO9HHec613wxtdvFuKWgCppj0bO1HPk6w
         BYMnDjrYcXcZ5Cd+KQpevDg06rlgh2/Yp6Q3kReMZDAa8puVTZfEmFJKn+m05xwAZ0
         BuEJgjqjL8urw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v5 4/7] powerpc/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Sun, 28 Mar 2021 06:30:25 +0000
Message-Id: <1616913028-83376-5-git-send-email-guoren@kernel.org>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 386ae12d8523..69ec4ade6521 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -151,6 +151,7 @@ config PPC
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32	if PPC_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
-- 
2.17.1

