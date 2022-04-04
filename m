Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3622F4F0F48
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377431AbiDDGWg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 02:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377420AbiDDGWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 02:22:33 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6993702D;
        Sun,  3 Apr 2022 23:20:30 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2346K1Bq008244;
        Mon, 4 Apr 2022 15:20:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2346K1Bq008244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649053206;
        bh=UcJbYMsGaLuu7rAXGRGEhGl4XasheiUdUe7mSwsDoTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQTCEOTZ3vyAuJAL0MhzurcEXRT0uqHWdOrjQYHxk4cv5fN72PJWy5fBWhmPR8R1K
         a67n6Yhgi2DYziOXih72STy2qpLWs9DCTZMlFU0DBiPJyR96FUOzD8G367Q+BZcv2t
         vRq5dbnp+IffePUiSEy1TcqCAShhScE4/ot4fCxhkbK9GmA3MtcStBJBPCycA7kx/6
         dFW+ml2lTsSpmb3Em1Wcrh5Q0yIjCJRU6zz+F8Gab7KUZQ/ELY1kiRvwr673hm9q6Y
         js2Af/IW5uv81oRmQUn+X1Ss6TDfqSJph2bwpgguQoIp2mY4n+d2OdInROb17+X9wm
         +wozaiWr/6gTQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 7/8] posix_types.h: add __kernel_uintptr_t to UAPI posix_types.h
Date:   Mon,  4 Apr 2022 15:19:47 +0900
Message-Id: <20220404061948.2111820-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404061948.2111820-1-masahiroy@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This will allow us to replace uintptr_t with __kernel_uintptr_t in
exported headers. I think this is acceptable because we already have
__kernel_ptrdiff_t.

Define __kernel_uintptr_t in the same ways as __kernel_ptrdiff_t
but with 'unsigned' qualifier.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/h8300/include/uapi/asm/posix_types.h  | 1 +
 arch/s390/include/uapi/asm/posix_types.h   | 2 ++
 arch/sparc/include/uapi/asm/posix_types.h  | 1 +
 arch/xtensa/include/uapi/asm/posix_types.h | 1 +
 include/linux/types.h                      | 2 +-
 include/uapi/asm-generic/posix_types.h     | 2 ++
 tools/arch/h8300/include/asm/bitsperlong.h | 1 +
 7 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/h8300/include/uapi/asm/posix_types.h b/arch/h8300/include/uapi/asm/posix_types.h
index 3efc9dd59476..9728120c6742 100644
--- a/arch/h8300/include/uapi/asm/posix_types.h
+++ b/arch/h8300/include/uapi/asm/posix_types.h
@@ -7,6 +7,7 @@
 typedef unsigned long	__kernel_size_t;
 typedef long		__kernel_ssize_t;
 typedef long		__kernel_ptrdiff_t;
+typedef unsigned long	__kernel_uintptr_t;
 
 #include <asm-generic/posix_types.h>
 
diff --git a/arch/s390/include/uapi/asm/posix_types.h b/arch/s390/include/uapi/asm/posix_types.h
index 1913613e71b6..2c700a44bf83 100644
--- a/arch/s390/include/uapi/asm/posix_types.h
+++ b/arch/s390/include/uapi/asm/posix_types.h
@@ -34,6 +34,7 @@ typedef unsigned short  __kernel_ipc_pid_t;
 typedef unsigned short  __kernel_uid_t;
 typedef unsigned short  __kernel_gid_t;
 typedef int             __kernel_ptrdiff_t;
+typedef unsigned int    __kernel_uintptr_t;
 
 #else /* __s390x__ */
 
@@ -43,6 +44,7 @@ typedef int             __kernel_ipc_pid_t;
 typedef unsigned int    __kernel_uid_t;
 typedef unsigned int    __kernel_gid_t;
 typedef long            __kernel_ptrdiff_t;
+typedef unsigned long   __kernel_uintptr_t;
 typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
 
 #endif /* __s390x__ */
diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index f139e0048628..402e1656e3b5 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -35,6 +35,7 @@ struct __kernel_old_timeval {
 typedef unsigned int           __kernel_size_t;
 typedef int                    __kernel_ssize_t;
 typedef long int               __kernel_ptrdiff_t;
+typedef unsigned long          __kernel_uintptr_t;
 #define __kernel_size_t __kernel_size_t
 
 typedef unsigned short         __kernel_ipc_pid_t;
diff --git a/arch/xtensa/include/uapi/asm/posix_types.h b/arch/xtensa/include/uapi/asm/posix_types.h
index 1dc67592881f..5ba366f6c789 100644
--- a/arch/xtensa/include/uapi/asm/posix_types.h
+++ b/arch/xtensa/include/uapi/asm/posix_types.h
@@ -26,6 +26,7 @@ typedef unsigned short	__kernel_ipc_pid_t;
 typedef unsigned int	__kernel_size_t;
 typedef int		__kernel_ssize_t;
 typedef long		__kernel_ptrdiff_t;
+typedef unsigned long	__kernel_uintptr_t;
 #define __kernel_size_t __kernel_size_t
 
 typedef unsigned short	__kernel_old_uid_t;
diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..a54335007fe2 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -34,7 +34,7 @@ typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;
 typedef __kernel_gid16_t        gid16_t;
 
-typedef unsigned long		uintptr_t;
+typedef __kernel_uintptr_t	uintptr_t;
 
 #ifdef CONFIG_HAVE_UID16
 /* This is defined by include/asm-{arch}/posix_types.h */
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index b5f7594eee7a..4a7c5b852e38 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -68,10 +68,12 @@ typedef unsigned int	__kernel_old_dev_t;
 typedef unsigned int	__kernel_size_t;
 typedef int		__kernel_ssize_t;
 typedef int		__kernel_ptrdiff_t;
+typedef unsigned int	__kernel_uintptr_t;
 #else
 typedef __kernel_ulong_t __kernel_size_t;
 typedef __kernel_long_t	__kernel_ssize_t;
 typedef __kernel_long_t	__kernel_ptrdiff_t;
+typedef __kernel_ulong_t __kernel_uintptr_t;
 #endif
 #endif
 
diff --git a/tools/arch/h8300/include/asm/bitsperlong.h b/tools/arch/h8300/include/asm/bitsperlong.h
index fa1508337ffc..fea7dc923006 100644
--- a/tools/arch/h8300/include/asm/bitsperlong.h
+++ b/tools/arch/h8300/include/asm/bitsperlong.h
@@ -10,6 +10,7 @@
 typedef unsigned long	__kernel_size_t;
 typedef long		__kernel_ssize_t;
 typedef long		__kernel_ptrdiff_t;
+typedef unsigned long	__kernel_uintptr_t;
 #endif
 
 #endif /* __ASM_H8300_BITS_PER_LONG */
-- 
2.32.0

