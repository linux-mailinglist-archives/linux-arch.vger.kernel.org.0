Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5A69368C
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 09:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBLIqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 03:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBLIqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 03:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0DD1421F;
        Sun, 12 Feb 2023 00:46:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74C93B80AB5;
        Sun, 12 Feb 2023 08:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDE1C433D2;
        Sun, 12 Feb 2023 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676191595;
        bh=fNKiSkZ0o+fOQDkH9eY0UIJa/qeemlNg5a9Sbw7z4oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUVV+chRkL08PzBAHoMlpmcJa2IhpSQwAz96rwplIsxNTcOagjdz1FjKgKIZm9Xz7
         4pv6hHt7b9nmaV+hF833gn5hNvsDucwwTXlMhpuMzThGhvVuFGMqBA2B5yRqwzl9KX
         2Wc43Xj/4Yfdsa0SIH7Q5qUXhOFTLhOk1YBgVMXYGMKSEd71o/EYsAImLe9oH0tXo8
         IToPWVX6nfL1eBM61cT0MPNI30pgAm15llCo3a4+ZAa7MfdSDZzLkYkYfIFt92bOZ2
         SPXfPRn2/UPxDP60AHCYuVhKHfGgEbsnHoBn/wXC8LSi6TGrRpBsT6yHBMhlRtOwBk
         OSNHjjVZwDwtw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 2/2] char/agp: introduce asm-generic/agp.h
Date:   Sun, 12 Feb 2023 10:46:11 +0200
Message-Id: <20230212084611.1311177-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230212084611.1311177-1-rppt@kernel.org>
References: <20230212084611.1311177-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

There are several architectures that duplicate definitions of
map_page_into_agp(), unmap_page_from_agp() and flush_agp_cache().

Define those in asm-generic/agp.h and use it instead of duplicated
per-architecture headers.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/alpha/include/asm/Kbuild                 |  1 +
 arch/alpha/include/asm/agp.h                  | 13 ------------
 arch/ia64/include/asm/Kbuild                  |  1 +
 arch/ia64/include/asm/agp.h                   | 21 -------------------
 arch/parisc/include/asm/Kbuild                |  1 +
 arch/parisc/include/asm/agp.h                 | 15 -------------
 arch/powerpc/include/asm/Kbuild               |  1 +
 arch/sparc/include/asm/Kbuild                 |  1 +
 arch/sparc/include/asm/agp.h                  | 11 ----------
 .../include/asm => include/asm-generic}/agp.h |  8 +++----
 10 files changed, 8 insertions(+), 65 deletions(-)
 delete mode 100644 arch/alpha/include/asm/agp.h
 delete mode 100644 arch/ia64/include/asm/agp.h
 delete mode 100644 arch/parisc/include/asm/agp.h
 delete mode 100644 arch/sparc/include/asm/agp.h
 rename {arch/powerpc/include/asm => include/asm-generic}/agp.h (59%)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 42911c8340c7..54f5126628c6 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 generated-y += syscall_table.h
+generic-y += agp.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/alpha/include/asm/agp.h b/arch/alpha/include/asm/agp.h
deleted file mode 100644
index 4197b3bc78ee..000000000000
--- a/arch/alpha/include/asm/agp.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef AGP_H
-#define AGP_H 1
-
-#include <asm/io.h>
-
-/* dummy for now */
-
-#define map_page_into_agp(page)		do { } while (0)
-#define unmap_page_from_agp(page)	do { } while (0)
-#define flush_agp_cache() mb()
-
-#endif
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index f994c1daf9d4..aefae2efde9f 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
+generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/agp.h b/arch/ia64/include/asm/agp.h
deleted file mode 100644
index f42c7dcb3d79..000000000000
--- a/arch/ia64/include/asm/agp.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_AGP_H
-#define _ASM_IA64_AGP_H
-
-/*
- * IA-64 specific AGP definitions.
- *
- * Copyright (C) 2002-2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-
-/*
- * To avoid memory-attribute aliasing issues, we require that the AGPGART engine operate
- * in coherent mode, which lets us map the AGP memory as normal (write-back) memory
- * (unlike x86, where it gets mapped "write-coalescing").
- */
-#define map_page_into_agp(page)		do { } while (0)
-#define unmap_page_from_agp(page)	do { } while (0)
-#define flush_agp_cache()		mb()
-
-#endif /* _ASM_IA64_AGP_H */
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index e6e7f74c8ac9..4fb596d94c89 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
+generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/agp.h b/arch/parisc/include/asm/agp.h
deleted file mode 100644
index d193a48490e2..000000000000
--- a/arch/parisc/include/asm/agp.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_PARISC_AGP_H
-#define _ASM_PARISC_AGP_H
-
-/*
- * PARISC specific AGP definitions.
- * Copyright (c) 2006 Kyle McMartin <kyle@parisc-linux.org>
- *
- */
-
-#define map_page_into_agp(page)		do { } while (0)
-#define unmap_page_from_agp(page)	do { } while (0)
-#define flush_agp_cache()		mb()
-
-#endif /* _ASM_PARISC_AGP_H */
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index bcf95ce0964f..419319c4963c 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_spu.h
+generic-y += agp.h
 generic-y += export.h
 generic-y += kvm_types.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 0b9d98ced34a..595ca0be286b 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
+generic-y += agp.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sparc/include/asm/agp.h b/arch/sparc/include/asm/agp.h
deleted file mode 100644
index 5186924fa673..000000000000
--- a/arch/sparc/include/asm/agp.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef AGP_H
-#define AGP_H 1
-
-/* dummy for now */
-
-#define map_page_into_agp(page)		do { } while (0)
-#define unmap_page_from_agp(page)	do { } while (0)
-#define flush_agp_cache()		mb()
-
-#endif
diff --git a/arch/powerpc/include/asm/agp.h b/include/asm-generic/agp.h
similarity index 59%
rename from arch/powerpc/include/asm/agp.h
rename to include/asm-generic/agp.h
index e86f2ce476c9..10db92ede168 100644
--- a/arch/powerpc/include/asm/agp.h
+++ b/include/asm-generic/agp.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_AGP_H
-#define _ASM_POWERPC_AGP_H
-#ifdef __KERNEL__
+#ifndef _ASM_GENERIC_AGP_H
+#define _ASM_GENERIC_AGP_H
 
 #include <asm/io.h>
 
@@ -9,5 +8,4 @@
 #define unmap_page_from_agp(page) do {} while (0)
 #define flush_agp_cache() mb()
 
-#endif /* __KERNEL__ */
-#endif	/* _ASM_POWERPC_AGP_H */
+#endif	/* _ASM_GENERIC_AGP_H */
-- 
2.35.1

