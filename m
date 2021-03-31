Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE96E35026B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhCaOd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236076AbhCaOc4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012EC60FF1;
        Wed, 31 Mar 2021 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201176;
        bh=Ot/5PmXwS11uulWq3qWA2topEHV4IQyVTJcB7EIJEto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4mj3Ucq0o81O2XyVG3hmXxx3WMjl1D+IiWQy6y3glymXCyXz7HvUH0Y/fnYr9f1h
         1wUUw0fx8O0SKe53NjW/bj/Ou5QXwaPc1g1UvmKUHfz4nwx525LvJmbfcYf5RgZhWk
         XZR9y8fM+4DYoaAJXNL2jgLdlXBwoOnIc/jSJ3r/9sKttJ2VVol/puJBKAjtvOtqgj
         YTwPsq2+RWCppmBEqhKeWazUtN2PGYkR30QcO8bTOPCiOzxjHuAOCNJtEBr/pnFukQ
         2743V9mO+HynrrCRbhsuAOsY5f1+RMF3zawK3FR7K+l/QgZF57ChVKoxlykrytyZNk
         r7q5BWtdFi1iw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v6 9/9] powerpc/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 14:30:40 +0000
Message-Id: <1617201040-83905-10-git-send-email-guoren@kernel.org>
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

Also no need when PPC_LBARX_LWARX is enabled, see the link below.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20201107032328.2454582-1-npiggin@gmail.com/
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 386ae12d8523..6133ad51690e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -151,6 +151,7 @@ config PPC
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32	if PPC_QUEUED_SPINLOCKS && !PPC_LBARX_LWARX
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
-- 
2.17.1

