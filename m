Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D6435025C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhCaOc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236066AbhCaOce (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F357360FF2;
        Wed, 31 Mar 2021 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201154;
        bh=Bg9d2w1WAX5KFLAnbnlQNHWx+c16ctVJTJF6+EgKbfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrjZ3mx3DLcCEGgombkpOj7HEDG+16RbX7GCxzDylhP8guFWgsFJW1a+vbFusHAdY
         94Qc8qxXh1EaoulNdS9TWbco1PP6GmCZIt2L23pL/QOBIPRyX63GfvbDQ+9NaIDf0j
         cyaxT3exYFQgKDTOgB0wOKQGlgVON8y1piXQwNdT3csJ3MSJFjc5fe9PkswGDii/sd
         eJPqX6kMGOlpOMDJKTbaueqCpyqN6Hisbv6i7VqbZryJVEehQnqSDloumLXlFCearb
         3+InC8R0ziS9cAAyzyzC3f0cJufK7mNuBaiq4wARKob/aEo8zMPVAZ5gZ+eiaTG+y6
         vnrem6tzkauzg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v6 6/9] openrisc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Wed, 31 Mar 2021 14:30:37 +0000
Message-Id: <1617201040-83905-7-git-send-email-guoren@kernel.org>
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
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 591acc5990dc..b299e409429f 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -33,6 +33,7 @@ config OPENRISC
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
-- 
2.17.1

