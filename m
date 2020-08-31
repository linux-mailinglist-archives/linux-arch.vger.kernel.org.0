Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C434B257F75
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgHaRRt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgHaRRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 13:17:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB152C061755;
        Mon, 31 Aug 2020 10:17:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so431598wmd.1;
        Mon, 31 Aug 2020 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+nbsjObGEQTbldxK9r/J/0l54hz3WdGBb4kWLFeHtdc=;
        b=Dx+2ufm2r6fK25HiX1RMSlUidv/QGw4uPXaRL6i7mexd7xL0hFBtLS4EzMQG/CdwnX
         x5s36sbIxBMaW8rvJpgD6ehhu4M0Ybr/5/AaXA0kF5cg4HM7/WlpKO1JH0ev9HC/LADp
         0F3SOaec49UEeOhrG6gEgcVi9/AwZQYvjekESTbiyFRE4o8MovAfgBIq+8QeDrt5N83h
         f0YFqIgUCtneqXL3gFoZZMw7mGFctnnF/VkA5hcKx0vKM5cLmFcqGdtyA/geyvNIeuDo
         HxRMdyh9i3Pzz6MhpAgG/Djl40XS3SI6hyO0C9aoRubn1AckHFClT2LKA88X7GUR2Oes
         gFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+nbsjObGEQTbldxK9r/J/0l54hz3WdGBb4kWLFeHtdc=;
        b=CoulpLwwyOBdEhijhMKLmP1QAEi988NWvhD0GCFeJy2bmUEdyVJeIpjW5v/8ZUXaKI
         /rLmTVja5CpxsidKO0oDqGMv61ELctn/4NRqve5Fp6ql9FEKfgbXu446v1qD0TPo/py6
         cJCbGOHLXRgamJvqFRfPQUwFdOvgD3niaI5G2m9zlup96Ux+vMMozur1MBw36zCptGhH
         R6SY3EhgK8XNPwW0VzHH27wC5tCSWqAyf+eZ8aX2yCahrEtBwqgS00yL9phLolKfo3i+
         spPYtZcXnO7ujBMrtZvU5ms5FsYnhdsS6VCHVnHnW3+t3QKZBD4EIcmpDJ2IFpSRe1yk
         59ZA==
X-Gm-Message-State: AOAM532y6mw9mzJs8zkhUdEPeo3fDVRfsp3l7U0iAhGms/8jwsZJuy5P
        F6DIxdYp+qzeL8bqaKi3OKY=
X-Google-Smtp-Source: ABdhPJwKFzt8ldI9tB15Yc56sc4C4H6P4uAMd8lRcJSd25uy/2Qxgs23epbBzGXYfbc0jBfBs1/gEQ==
X-Received: by 2002:a1c:415:: with SMTP id 21mr285439wme.183.1598894264450;
        Mon, 31 Aug 2020 10:17:44 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id w15sm840978wro.46.2020.08.31.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:17:43 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de,
        peterz@infradead.org
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v3 3/3] x86: add failure injection to get/put/clear_user
Date:   Mon, 31 Aug 2020 17:17:33 +0000
Message-Id: <20200831171733.955393-4-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200831171733.955393-1-alinde@google.com>
References: <20200831171733.955393-1-alinde@google.com>
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

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Albert van der Linde <alinde@google.com>
---
v2:
 - no significant changes

v3:
 - no changes
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

