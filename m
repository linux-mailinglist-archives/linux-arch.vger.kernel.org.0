Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91D17D320
	for <lists+linux-arch@lfdr.de>; Sun,  8 Mar 2020 10:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCHJxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 Mar 2020 05:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgCHJxc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:32 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6559320866;
        Sun,  8 Mar 2020 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661212;
        bh=WwPtYIv1nGW+mvlP8KwH+cUbKn5SIYN+qnxmc5C+cDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgoQ9wBw8yzgnDSBgg2k8DTh+9TRWmVNnMNMJeMw6UF6pXV8A+HGRoaK3PXC1ATTU
         jDuffFuc/qhGajhaxbKkdMNs/b0JeLO7sFsWR84OVv6fzwge6V4rSZre28TcFPhda+
         10fiKMcekC9rR7hFcg3nTb2KTFI/ui7tAsUK/XP4=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 05/11] riscv: Add vector feature to compile
Date:   Sun,  8 Mar 2020 17:49:48 +0800
Message-Id: <20200308094954.13258-6-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch add a config option which could enable assembler's
vector feature.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig  | 9 +++++++++
 arch/riscv/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 73f029eae0cc..c36589c85700 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -288,6 +288,15 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config VECTOR
+	bool "VECTOR support"
+	default n
+	help
+	  Say N here if you want to disable all vector related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6d09b53cf106..071eb1148e01 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -44,6 +44,7 @@ riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
 riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
 riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
 riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+riscv-march-aflags-$(CONFIG_VECTOR)		:= $(riscv-march-aflags-y)v
 
 KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
 KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
-- 
2.17.0

