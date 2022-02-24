Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D464C26B1
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 10:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiBXI6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 03:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiBXI5z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 03:57:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030EC22B38;
        Thu, 24 Feb 2022 00:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B027CB82497;
        Thu, 24 Feb 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BEC340F0;
        Thu, 24 Feb 2022 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645693043;
        bh=IJ7jR8mTvejG9VzZtr4+z5Hdjv3FHdsfGnEFZTtHWjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRanqTr33zBAXAH2uXeTnUP+Is9PE4Ci3uq199mcf9qGI6qcQj7PndVNQu/ukxaiy
         WG0meUuLYcBl3fBYYnWI5udGZsSUIRDmJocXIq5U9/r/s0bPdAel1HidOtsAgBXHM4
         c2xRr8ReX7AcU3bZe7K9QzKx76D5WHF+k2OJldB2GBWDNDa/ngOJaE0gGZOp54otYU
         38KaKoeqmfZqnweizNylPXa35e5kE6CQNOcCIz6EPHlriB/3Wnp9+6U6N15rDV94d4
         PUAD1GUFF6tDGdKRHv5Pwcbd+l3ZcRV099vvMeMTXzjqg+LDDraT1Q3uxNi0aCMS9D
         6+fmnLmPjTsIw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V6 20/20] riscv: compat: Add COMPAT Kbuild skeletal support
Date:   Thu, 24 Feb 2022 16:54:10 +0800
Message-Id: <20220224085410.399351-21-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224085410.399351-1-guoren@kernel.org>
References: <20220224085410.399351-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Adds initial skeletal COMPAT Kbuild (Running 32bit U-mode on
64bit S-mode) support.
 - Setup kconfig & dummy functions for compiling.
 - Implement compat_start_thread by the way.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..6f11df8c189f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -73,6 +73,7 @@ config RISCV
 	select HAVE_ARCH_KGDB if !XIP_KERNEL
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
@@ -123,12 +124,18 @@ config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
 
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+	default 8
+
 # max bits determined by the following formula:
 #  VA_BITS - PAGE_SHIFT - 3
 config ARCH_MMAP_RND_BITS_MAX
 	default 24 if 64BIT # SV39 based
 	default 17
 
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+	default 17
+
 # set if we run in machine mode, cleared if we run in supervisor mode
 config RISCV_M_MODE
 	bool
@@ -406,6 +413,18 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config COMPAT
+	bool "Kernel support for 32-bit U-mode"
+	default 64BIT
+	depends on 64BIT && MMU
+	help
+	  This option enables support for a 32-bit U-mode running under a 64-bit
+	  kernel at S-mode. riscv32-specific components such as system calls,
+	  the user helper functions (vdso), signal rt_frame functions and the
+	  ptrace interface are handled appropriately by the kernel.
+
+	  If you want to execute 32-bit userspace applications, say Y.
+
 endmenu
 
 menu "Boot options"
-- 
2.25.1

