Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E26322893
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhBWKIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 05:08:18 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45189 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhBWKHs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 05:07:48 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 11NA6MWu027532;
        Tue, 23 Feb 2021 19:06:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 11NA6MWu027532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614074783;
        bh=owZQEXlFIQ33aUPBIXx5P3uyVNGtycyIe/UsLJziBHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l44/E6+HFnGiVvw+YJmuspNes+npkA4ClvTaqyrX7X5+RlJjrF9JNVGcVTqSwK+4r
         rH8iwhSClDlwVh1Qwc/Lo4VLhx9uP3Fg1pYYNoOIwbQVmF1EKOMqcbtaGOIVB99pZm
         vB8cWFja1r3rzWUXQDxoybw6rE6CkIbBi80fQifB0oYJMgUtaPve4sPmKtqK81aNzi
         zB0DBNQ1kH3a5HZbuvBhJ+UpTau5yblloiLiviMtSa/anKZdcxKP53yFE79nl/vuEo
         99EoCFqOil/yLL64J0bou6fwMlE1fKRP+UB+NDooldit4tKzinjnE0lNPMRWforwAA
         0Obx6MXyJ1VEg==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic/ioctl.h: use BUILD_BUG_ON_ZERO() for type check
Date:   Tue, 23 Feb 2021 19:06:19 +0900
Message-Id: <20210223100619.798698-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the latest sparse, I do not see the error claimed by commit
d55875f5d52c ("include/asm-generic/ioctl.h: fix _IOC_TYPECHECK sparse
error").

Anyway, using BUILD_BUG_ON_ZERO() is clearer, and we do not need
to worry about sparse because BUILD_BUG_ON_ZERO() definition in
<linux/build_bug.h> is a constant zero when __CHECKER__ is defined.

Also, remove #ifndef __KERNEL__ from <uapi/asm-generic/ioctl.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/ioctl.h      | 12 ++++--------
 include/uapi/asm-generic/ioctl.h | 13 ++++++-------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/ioctl.h b/include/asm-generic/ioctl.h
index 9fda9ed000cd..d5129d70ee1c 100644
--- a/include/asm-generic/ioctl.h
+++ b/include/asm-generic/ioctl.h
@@ -2,17 +2,13 @@
 #ifndef _ASM_GENERIC_IOCTL_H
 #define _ASM_GENERIC_IOCTL_H
 
+#include <linux/build_bug.h>
 #include <uapi/asm-generic/ioctl.h>
 
-#ifdef __CHECKER__
-#define _IOC_TYPECHECK(t) (sizeof(t))
-#else
 /* provoke compile error for invalid uses of size argument */
-extern unsigned int __invalid_size_argument_for_IOC;
+#undef _IOC_TYPECHECK
 #define _IOC_TYPECHECK(t) \
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
-#endif
+	BUILD_BUG_ON_ZERO(sizeof(t) != sizeof(t[1]) || \
+			  sizeof(t) >= (1 << _IOC_SIZEBITS))
 
 #endif /* _ASM_GENERIC_IOCTL_H */
diff --git a/include/uapi/asm-generic/ioctl.h b/include/uapi/asm-generic/ioctl.h
index a84f4db8a250..d50bd39ec3e3 100644
--- a/include/uapi/asm-generic/ioctl.h
+++ b/include/uapi/asm-generic/ioctl.h
@@ -72,9 +72,8 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
-#ifndef __KERNEL__
-#define _IOC_TYPECHECK(t) (sizeof(t))
-#endif
+#define _IOC_TYPECHECK(t)	0
+#define _IOC_SIZE_WITH_TYPECHECK(t)	(sizeof(t) + _IOC_TYPECHECK(t))
 
 /*
  * Used to create numbers.
@@ -82,10 +81,10 @@
  * NOTE: _IOW means userland is writing and kernel is reading. _IOR
  * means userland is reading and kernel is writing.
  */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IO(type,nr)		_IOC(_IOC_NONE, type, nr, 0)
+#define _IOR(type,nr,size)	_IOC(_IOC_READ, type, nr, _IOC_SIZE_WITH_TYPECHECK(size))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE, type, nr, _IOC_SIZE_WITH_TYPECHECK(size))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE, type, nr, _IOC_SIZE_WITH_TYPECHECK(size))
 #define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
 #define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
 #define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-- 
2.27.0

