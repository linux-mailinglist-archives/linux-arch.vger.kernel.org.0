Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA854DAAF9
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 08:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354024AbiCPHFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354014AbiCPHFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 03:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7A1116E;
        Wed, 16 Mar 2022 00:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 209C46102A;
        Wed, 16 Mar 2022 07:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4477AC340F3;
        Wed, 16 Mar 2022 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414234;
        bh=G+0AfE7fg3YZ31nVbGgXwDbWLMbNh9zLjXb0j5/M9J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nybp5adYtr7Ur6IyxyPBbWGX6UjhQ/Br+hhkl+qxt5b9Ap8nRFBeS+2VP0jDtILcV
         M+YnsFi+bBgPZ3gCkSP6P3BkkwiNDdGotdwb8zmOcXSHtUYBxrn8NeTNPs0dsGY1z2
         oktuLE/RwHOInwxiES3whLRhyTjZKXFZQCySX5ck8N+M460nv0gob2pOIyTP24JPvh
         p7K2/1LsFK9Do5uIAeCakYc2GmO6+S9dy0lntpYuMD3PM63klw2Nz12Ogyq65gjPnT
         JIOwiWeptfggSvM4Q4WcWoLBgHSjyDr2meVaPapE57/+jXneaZ/ddZtY6Ol05WmQW1
         +aNi4lxlGS76w==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de
Subject: [PATCH V8 02/20] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
Date:   Wed, 16 Mar 2022 15:02:59 +0800
Message-Id: <20220316070317.1864279-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316070317.1864279-1-guoren@kernel.org>
References: <20220316070317.1864279-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The F_GETLK64/F_SETLK64/F_SETLKW64 fcntl opcodes are only implemented
for the 32-bit syscall APIs, but are also needed for compat handling
on 64-bit kernels.

Consolidate them in unistd.h instead of definining the internal compat
definitions in compat.h, which is rather error prone (e.g. parisc
gets the values wrong currently).

Note that before this change they were never visible to userspace due
to the fact that CONFIG_64BIT is only set for kernel builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/include/asm/compat.h        | 4 ----
 arch/mips/include/asm/compat.h         | 4 ----
 arch/mips/include/uapi/asm/fcntl.h     | 4 ++--
 arch/powerpc/include/asm/compat.h      | 4 ----
 arch/s390/include/asm/compat.h         | 4 ----
 arch/sparc/include/asm/compat.h        | 4 ----
 arch/x86/include/asm/compat.h          | 4 ----
 include/uapi/asm-generic/fcntl.h       | 4 ++--
 tools/include/uapi/asm-generic/fcntl.h | 2 --
 9 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index eaa6ca062d89..276328765408 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -73,10 +73,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index bbb3bc5a42fd..6a350c1f70d7 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -65,10 +65,6 @@ struct compat_flock {
 	s32		pad[4];
 };
 
-#define F_GETLK64	33
-#define F_SETLK64	34
-#define F_SETLKW64	35
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 9e44ac810db9..0369a38e3d4f 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -44,11 +44,11 @@
 #define F_SETOWN	24	/*  for sockets. */
 #define F_GETOWN	23	/*  for sockets. */
 
-#ifndef __mips64
+#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
 #define F_GETLK64	33	/*  using 'struct flock64' */
 #define F_SETLK64	34
 #define F_SETLKW64	35
-#endif
+#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
 
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 #define __ARCH_FLOCK_EXTRA_SYSID	long l_sysid;
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 7afc96fb6524..83d8f70779cb 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -52,10 +52,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index cdc7ae72529d..0f14b3188b1b 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -110,10 +110,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64       12
-#define F_SETLK64       13
-#define F_SETLKW64      14    
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index bd949fcf9d63..108078751bb5 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -84,10 +84,6 @@ struct compat_flock {
 	short		__unused;
 };
 
-#define F_GETLK64	12
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 struct compat_flock64 {
 	short		l_type;
 	short		l_whence;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7516e4199b3c..8d19a212f4f2 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -58,10 +58,6 @@ struct compat_flock {
 	compat_pid_t	l_pid;
 };
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /*
  * IA32 uses 4 byte alignment for 64 bit quantities,
  * so we need to pack this structure.
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 77aa9f2ff98d..f13d37b60775 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -116,13 +116,13 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#ifndef CONFIG_64BIT
+#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
-#endif
+#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
 
 #ifndef F_SETOWN_EX
 #define F_SETOWN_EX	15
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 99bc9b15ce2b..0197042b7dfb 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -115,13 +115,11 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#ifndef CONFIG_64BIT
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
-#endif
 
 #ifndef F_SETOWN_EX
 #define F_SETOWN_EX	15
-- 
2.25.1

