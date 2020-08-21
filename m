Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2349024D336
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHUKvK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgHUKuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 06:50:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43308C061388;
        Fri, 21 Aug 2020 03:50:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 83so1385967wme.4;
        Fri, 21 Aug 2020 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7tDI05IPzywart990YNcTNTyc6TKWCEiVG0oiXqDtA=;
        b=UAajDDkyhD907nQYZfjrHuWjZkUHLlVChhdHILZT3Vc2+yBkCOl5aYMgHBezbRKBBK
         iD2SqkVvsl24F5ZT1wLQ2GRvGj1TzjzCsFttQoPr5SBfVHlwixlEGZcdMbAZ+vwehgTG
         SBxD6LgxbFI6RJ+8xnarJUXCoWp6c+XFpOkoiNOFbHrxJB/JV+TQQDf5RDqqMvvr7EBo
         HEC8LjHsjb0svfWleN9nI+Q+Wz32F50w/S28Yjrh1lAELT2+K/AE5dsJov54lBCTJvDZ
         Fq7wMdwZ43iN3rdu6ELkHxZya6jRX+obA1KaSC0s2Nywi3jEIaTssJve9OYp4Bg1SSaJ
         VeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7tDI05IPzywart990YNcTNTyc6TKWCEiVG0oiXqDtA=;
        b=hfxRlzali5Gw6nSog0mBX8HEnfVnGz0yjGi7UekcPEuhkv2YVvtABgJ+wLV4r4vU69
         ixFCqY/oxf9bC0HNEsWmIMSyO04IddRynBL69Hmcj2ONysd5Md+i/URN1taaGBhZvAei
         uOUL8IDkJEBFd0+skT2fjxD3dja+GCsPrxtl0aYk/FB7sqCpEZS0pczLQusRGZw6MXMT
         7MQn50hxQ6WSXLDwqJtWjmkHEFkl7OHW/ogz+f3W8z6FDaLhpHOnfs/iIVO1UrGb55i0
         zXEHA68+j2raOTPs0okmxBhh4vQSrgiRsv0nQBrgLOIw82lb4WGS1Oknw6RG9WkUuc0q
         lX4A==
X-Gm-Message-State: AOAM532GYVYU9mPUsVwB2T+yep9w3cZ/Y00TZXeYYZAf5b0eSrqqubrc
        +X5IKI24y4giwZ+f2oGoG3c=
X-Google-Smtp-Source: ABdhPJwPEh3VKSxccgGmwY+rti6JeG+jmyaVESWFMKhS0PqYxi2oFt9ssH1E0fwIPrr1oRK0FuvbaQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr2505519wmh.168.1598007049766;
        Fri, 21 Aug 2020 03:50:49 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 8sm3784911wrl.7.2020.08.21.03.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:50:49 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Albert van der Linde <alinde@google.com>
Subject: [PATCH 3/3] x86: add failure injection to get/put/clear_user
Date:   Fri, 21 Aug 2020 10:49:25 +0000
Message-Id: <20200821104926.828511-4-alinde@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821104926.828511-1-alinde@google.com>
References: <20200821104926.828511-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

To test fault-tolerance of usercopy accesses in x86, add support for
fault injection.

Make both put_user() and get_user() fail with -EFAULT, and clear_user()
fail by partially clearing fewer bytes.

Signed-off-by: Albert van der Linde <alinde@google.com>
---
 arch/x86/include/asm/uaccess.h | 70 +++++++++++++++++++---------------
 arch/x86/lib/usercopy_64.c     |  9 ++++-
 2 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ecefaffd15d4..dacb6105831e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -5,6 +5,7 @@
  * User space memory access functions
  */
 #include <linux/compiler.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 #include <asm/asm.h>
@@ -174,12 +175,17 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	might_fault();							\
-	asm volatile("call __get_user_%P4"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
+	if (should_fail_usercopy(sizeof(*(ptr)))) {			\
+		(x) = 0;						\
+		__ret_gu = -EFAULT;					\
+	} else {							\
+		might_fault();						\
+		asm volatile("call __get_user_%P4"			\
+			: "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
-	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+			: "0" (ptr), "i" (sizeof(*(ptr))));		\
+		(x) = (__force __typeof__(*(ptr))) __val_gu;		\
+	}								\
 	__builtin_expect(__ret_gu, 0);					\
 })
 
@@ -236,31 +242,35 @@ extern void __put_user_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr)					\
-({								\
-	int __ret_pu;						\
-	__typeof__(*(ptr)) __pu_val;				\
-	__chk_user_ptr(ptr);					\
-	might_fault();						\
-	__pu_val = x;						\
-	switch (sizeof(*(ptr))) {				\
-	case 1:							\
-		__put_user_x(1, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 2:							\
-		__put_user_x(2, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 4:							\
-		__put_user_x(4, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 8:							\
-		__put_user_x8(__pu_val, ptr, __ret_pu);		\
-		break;						\
-	default:						\
-		__put_user_x(X, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	}							\
-	__builtin_expect(__ret_pu, 0);				\
+#define put_user(x, ptr)						\
+({									\
+	int __ret_pu;							\
+	__typeof__(*(ptr)) __pu_val;					\
+	__chk_user_ptr(ptr);						\
+	might_fault();							\
+	__pu_val = x;							\
+	if (should_fail_usercopy(sizeof(*(ptr)))) {			\
+		__ret_pu = -EFAULT;					\
+	} else {							\
+		switch (sizeof(*(ptr))) {				\
+		case 1:							\
+			__put_user_x(1, __pu_val, ptr, __ret_pu);	\
+			break;						\
+		case 2:							\
+			__put_user_x(2, __pu_val, ptr, __ret_pu);	\
+			break;						\
+		case 4:							\
+			__put_user_x(4, __pu_val, ptr, __ret_pu);	\
+			break;						\
+		case 8:							\
+			__put_user_x8(__pu_val, ptr, __ret_pu);		\
+			break;						\
+		default:						\
+			__put_user_x(X, __pu_val, ptr, __ret_pu);	\
+			break;						\
+		}							\
+	}								\
+	__builtin_expect(__ret_pu, 0);					\
 })
 
 #define __put_user_size(x, ptr, size, label)				\
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index b0dfac3d3df7..b749590d753e 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -7,6 +7,7 @@
  * Copyright 2002 Andi Kleen <ak@suse.de>
  */
 #include <linux/export.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 
@@ -50,8 +51,14 @@ EXPORT_SYMBOL(__clear_user);
 
 unsigned long clear_user(void __user *to, unsigned long n)
 {
+	long not_copied = should_fail_usercopy(n);
+
+	if (not_copied < 0)
+		not_copied = n;
+
 	if (access_ok(to, n))
-		return __clear_user(to, n);
+		return not_copied + __clear_user(to, n - not_copied);
+
 	return n;
 }
 EXPORT_SYMBOL(clear_user);
-- 
2.28.0.297.g1956fa8f8d-goog

