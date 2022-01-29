Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D324A2ED7
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 13:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiA2MSD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 07:18:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47596 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiA2MSC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 07:18:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D02FB82699;
        Sat, 29 Jan 2022 12:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A469C340E8;
        Sat, 29 Jan 2022 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643458679;
        bh=wcdNn9I8JZy3Jn2cpELP40HF9DF9IQSOPOhCqQoEm0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcXhfIHAwMmNCOsrgWWrnTiy9h9XFsgtuDmDz9kNFWAIBu4jiIf19YdRjTUa51ZRg
         VfgkziwbCM3px7n4pDb4RAn3f/7kbFN5Ile0VW/f4Bb5DAtoAmmvpMcZ9W5VG5HnKB
         Zx0RQFZzOllSVklD7NuhopFKnVDivp3M4h0IKJRwVw+3t5eregWhkjiEQqAo7sMSvf
         CCJjywMdVPfHjs/INTsaQfrbb32yMVEbCiHUPcyDVG9d2mcaS5+eanWIofmk8Prefa
         G4S68KBsp90SABvvEsulZoMIpGDUOu9HR30Ozyb4oHPkDT51KazNyCH5cqMrkkETBk
         c6ndr/9/GKr0A==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 02/17] fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
Date:   Sat, 29 Jan 2022 20:17:13 +0800
Message-Id: <20220129121728.1079364-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129121728.1079364-1-guoren@kernel.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V doesn't neeed compat_stat, so using __ARCH_WANT_COMPAT_STAT
to exclude unnecessary SYSCALL functions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/arm64/include/asm/unistd.h   | 1 +
 arch/mips/include/asm/unistd.h    | 2 ++
 arch/parisc/include/asm/unistd.h  | 1 +
 arch/powerpc/include/asm/unistd.h | 1 +
 arch/s390/include/asm/unistd.h    | 1 +
 arch/sparc/include/asm/unistd.h   | 1 +
 arch/x86/include/asm/unistd.h     | 1 +
 fs/stat.c                         | 2 +-
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 4e65da3445c7..037feba03a51 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifdef CONFIG_COMPAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c2196b1b6604..25a5253db7f4 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -50,6 +50,8 @@
 # ifdef CONFIG_32BIT
 #  define __ARCH_WANT_STAT64
 #  define __ARCH_WANT_SYS_TIME32
+# else
+#  define __ARCH_WANT_COMPAT_STAT
 # endif
 # ifdef CONFIG_MIPS32_O32
 #  define __ARCH_WANT_SYS_TIME32
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index cd438e4150f6..14e0668184cb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -168,6 +168,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 
 #ifdef CONFIG_64BIT
 #define __ARCH_WANT_SYS_TIME
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 5eb462af6766..b1129b4ef57d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -44,6 +44,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 #define __ARCH_WANT_SYS_FORK
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 9e9f75ef046a..4260bc5ce7f8 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -28,6 +28,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
+#   define __ARCH_WANT_COMPAT_STAT
 #   define __ARCH_WANT_SYS_TIME32
 #   define __ARCH_WANT_SYS_UTIME32
 # endif
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 1e66278ba4a5..d6bc76706a7a 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -46,6 +46,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 #endif
 
 #ifdef __32bit_syscall_numbers__
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 80e9d5206a71..761173ccc33c 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #  include <asm/unistd_32_ia32.h>
 #  define __ARCH_WANT_SYS_TIME
 #  define __ARCH_WANT_SYS_UTIME
+#  define __ARCH_WANT_COMPAT_STAT
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..ffdeb9065d53 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -639,7 +639,7 @@ SYSCALL_DEFINE5(statx,
 	return do_statx(dfd, filename, flags, mask, buffer);
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_STAT)
 static int cp_compat_stat(struct kstat *stat, struct compat_stat __user *ubuf)
 {
 	struct compat_stat tmp;
-- 
2.25.1

