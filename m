Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4F234F14
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHABOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgHABOx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:53 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810282087C;
        Sat,  1 Aug 2020 01:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244492;
        bh=GMHKsKU9E1yq8Lq8GGQ5etwf0y/5+06bWwphgs48sjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CchyPdL15Tddp7Owv7xhFp3aNfQzmhPT3hYbF7AOQDoHjipUCHLBpoJbhesyT95IT
         cFlwQEnflVZzek7KRWUM6DZ4rtSC6wdpT2uSNt1mTOVRc5GUgrFj/tzrNSn0dKfm7f
         vNPuO9d/cKGDTKURlmZYeZKEtp+Vy4atk2kDspWM=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 08/13] csky: Use top-down mmap layout
Date:   Sat,  1 Aug 2020 01:14:08 +0000
Message-Id: <1596244453-98575-9-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Follow riscv mmap layout with commit "riscv: make mmap allocation
top-down by default (54c95a11cc1b)".

Before:
 cat /proc/self/maps
00008000-000dc000 r-xp 00000000 fe:00 17         /bin/busybox
000dc000-000dd000 r--p 000d3000 fe:00 17         /bin/busybox
000dd000-000de000 rw-p 000d4000 fe:00 17         /bin/busybox
2aaa8000-2aac6000 r-xp 00000000 fe:00 196        /lib/ld-2.28.9000.so
2aac6000-2aac7000 r-xp 00000000 00:00 0          [vdso]
2aac7000-2aac8000 r--p 0001e000 fe:00 196        /lib/ld-2.28.9000.so
2aac8000-2aac9000 rw-p 0001f000 fe:00 196        /lib/ld-2.28.9000.so
2aac9000-2aad9000 r-xp 00000000 fe:00 219        /lib/libresolv-2.28.9000.so
2aad9000-2aada000 r--p 0000f000 fe:00 219        /lib/libresolv-2.28.9000.so
2aada000-2aadb000 rw-p 00010000 fe:00 219        /lib/libresolv-2.28.9000.so
2aadb000-2aadd000 rw-p 00000000 00:00 0
2aadd000-2ac27000 r-xp 00000000 fe:00 203        /lib/libc-2.28.9000.so
2ac27000-2ac28000 ---p 0014a000 fe:00 203        /lib/libc-2.28.9000.so
2ac28000-2ac2a000 r--p 0014a000 fe:00 203        /lib/libc-2.28.9000.so
2ac2a000-2ac2b000 rw-p 0014c000 fe:00 203        /lib/libc-2.28.9000.so
2ac2b000-2ac2e000 rw-p 00000000 00:00 0
7fb99000-7fbba000 rwxp 00000000 00:00 0          [stack]

After:
 cat /proc/self/maps
00008000-000dc000 r-xp 00000000 fe:00 17         /bin/busybox
000dc000-000dd000 r--p 000d3000 fe:00 17         /bin/busybox
000dd000-000de000 rw-p 000d4000 fe:00 17         /bin/busybox
77e13000-77f5d000 r-xp 00000000 fe:00 203        /lib/libc-2.28.9000.so
77f5d000-77f5e000 ---p 0014a000 fe:00 203        /lib/libc-2.28.9000.so
77f5e000-77f60000 r--p 0014a000 fe:00 203        /lib/libc-2.28.9000.so
77f60000-77f61000 rw-p 0014c000 fe:00 203        /lib/libc-2.28.9000.so
77f61000-77f66000 rw-p 00000000 00:00 0
77f66000-77f76000 r-xp 00000000 fe:00 219        /lib/libresolv-2.28.9000.so
77f76000-77f77000 r--p 0000f000 fe:00 219        /lib/libresolv-2.28.9000.so
77f77000-77f78000 rw-p 00010000 fe:00 219        /lib/libresolv-2.28.9000.so
77f78000-77f96000 r-xp 00000000 fe:00 196        /lib/ld-2.28.9000.so
77f96000-77f97000 r-xp 00000000 00:00 0          [vdso]
77f97000-77f98000 r--p 0001e000 fe:00 196        /lib/ld-2.28.9000.so
77f98000-77f99000 rw-p 0001f000 fe:00 196        /lib/ld-2.28.9000.so
7fd7b000-7fd9c000 rwxp 00000000 00:00 0          [stack]

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c51f64c..fd92d73 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,6 +9,7 @@ config CSKY
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CSKY_MPINTC if CPU_CK860
@@ -38,6 +39,7 @@ config CSKY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
@@ -151,6 +153,14 @@ config L1_CACHE_SHIFT
 	default "5"	if (CPU_CK807 || CPU_CK810)
 	default "6"	if (CPU_CK860)
 
+config ARCH_MMAP_RND_BITS_MIN
+	default 8
+
+# max bits determined by the following formula:
+#  VA_BITS - PAGE_SHIFT - 3
+config ARCH_MMAP_RND_BITS_MAX
+	default 17
+
 menu "Processor type and features"
 
 choice
-- 
2.7.4

