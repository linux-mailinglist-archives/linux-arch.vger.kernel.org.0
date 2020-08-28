Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D396B255C10
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH1OO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgH1OOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 10:14:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F63C061233;
        Fri, 28 Aug 2020 07:14:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so1082821wmj.2;
        Fri, 28 Aug 2020 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sycAbAcK1rdW3N5HoDcjcIO5PVBl/0B4H7zbWTI4nyw=;
        b=Z9FgIFFCv3YqPY7sQpiIUIYbZehaP6xmxmMsbB8/LjGrS8m1oUcW1R/Ip6E4p9D0wS
         OLvfpi1MqJiMmDds7uRx8VEcn65CF5SvR9Ik+1YYS+GkrbSjvMCsdiJW8ssQLokCHLDR
         TA56drkx2DV0uDvtCdkYrzSDLUJEanhNyc5dpza4IZx6OKr+2KMx92bpXBtsronWaJ7y
         B5w+ZWa5//b6d6+yisi2jMK1dX5XmLYzGuhR4PBWvFulNlESw/YqWCUyXfrdDA1xwaUc
         dErJWft7b/y44MM2WYc4eKT/hoCbF1nzH0FUKcHFpCfpxtHuOhVaCx5w7luyt9Bhq7Ud
         o4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sycAbAcK1rdW3N5HoDcjcIO5PVBl/0B4H7zbWTI4nyw=;
        b=TvnfR5EFBYncvNIN0QRPr7MAI1sJTh46tC8P4CUNQfrK6XMoVEZneNwfFxJWmk8u6+
         VzBXuc+asjdf6NmqDsU+VxRIELGrv++fA4QYMSOPwhfmIuqIdQGeGsWc/G0ctPF91NEF
         O+Y8p+cYjtnvo0VWwQNQ56TM3HpINwE+hiVPYEcFqx87U5Ib0WJweAk6ShLbHpDW+yOl
         HgAR3FCnfIB41ovnwZknupjUFULqvd3B1oC6alyO5d7R9UVw4DHhrQN7dmXQiYFoxNSt
         xCIGlTNYM+h7974oecM1+pASh8bzOlzuTP6e6N3d9aM0MCHfx5vN2MvwK3wgExLd2YqT
         7+Cg==
X-Gm-Message-State: AOAM5326LwlkfiaOc2AcQLW94JIh816RcsN4gEtdq0qMb5LNbjB6CCMo
        gLU5HPDgSLW3oBAeLp1eqNY=
X-Google-Smtp-Source: ABdhPJwp+FcvL5lnhKDafDKCCaabbsOmowgmmteE2IHYeExQ7CTxo9gCSAS2LEXZpnLmHykMj2K0+A==
X-Received: by 2002:a1c:a746:: with SMTP id q67mr1956344wme.128.1598624057520;
        Fri, 28 Aug 2020 07:14:17 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id t4sm2248235wre.30.2020.08.28.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:14:16 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v2 3/3] x86: add failure injection to get/put/clear_user
Date:   Fri, 28 Aug 2020 14:13:44 +0000
Message-Id: <20200828141344.2277088-4-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200828141344.2277088-1-alinde@google.com>
References: <20200828141344.2277088-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

To test fault-tolerance of user memory acceses in x86, add support for
fault injection.

Make both put_user() and get_user() fail with -EFAULT, and clear_user()
fail by not clearing any bytes.

Signed-off-by: Albert van der Linde <alinde@google.com>
---
v2:
 - no significant changes
---
 arch/x86/include/asm/uaccess.h | 68 +++++++++++++++++++---------------
 arch/x86/lib/usercopy_64.c     |  3 ++
 2 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ecefaffd15d4..004eeee2199a 100644
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
@@ -175,11 +176,16 @@ extern int __get_user_bad(void);
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
 	might_fault();							\
-	asm volatile("call __get_user_%P4"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
+	if (should_fail_usercopy()) {					\
+		(x) = 0;						\
+		__ret_gu = -EFAULT;					\
+	} else {							\
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
+	if (should_fail_usercopy()) {					\
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
index b0dfac3d3df7..7747cda5780d 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -7,6 +7,7 @@
  * Copyright 2002 Andi Kleen <ak@suse.de>
  */
 #include <linux/export.h>
+#include <linux/fault-inject-usercopy.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 
@@ -50,6 +51,8 @@ EXPORT_SYMBOL(__clear_user);
 
 unsigned long clear_user(void __user *to, unsigned long n)
 {
+	if (should_fail_usercopy())
+		return n;
 	if (access_ok(to, n))
 		return __clear_user(to, n);
 	return n;
-- 
2.28.0.402.g5ffc5be6b7-goog

