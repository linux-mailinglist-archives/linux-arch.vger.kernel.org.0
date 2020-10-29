Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1D29EFAC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgJ2PZp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgJ2PZp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 11:25:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7EC0613D6
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2020 08:25:45 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y8so1965026qki.12
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2020 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HvgcHzvgNIHPBHqniJljI4Ra8aRcuzZdi/nFEGJJmlk=;
        b=Um/m2vHRRFZAYWoO06a+XLlpac03GEvrXOXS1V20I2AKQk4w5GkBfkGV/46D8ZpN5S
         BWxWNch8CArb5m/vTHZUEc4EfIYBgA+rxQqiC+T2dHpCn3nvzQ05mU5/q+kNNCP5ViVw
         ONGRXSiS594/R1bUFbRO1aGw4Tv9iiF20MUy8dmo0sXdejh5PBrAyNONbIyx3LRdQXi+
         ut87BXzrd+IhzK3P7N72GV1q5E0T5rZ6Uhw2+wi94u4KLMo5i3+3MH67qqSG3M9NZPt6
         c1RlmzZytANnC76GOxqvpz1TgczJ+bazkHTJ1b6CtG+nALo7EOjOUE98IZH7TJFubCbt
         ILAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HvgcHzvgNIHPBHqniJljI4Ra8aRcuzZdi/nFEGJJmlk=;
        b=Bv2vmnQ9XdwY+i9/NAdrC10Buu1TtRd3UXumtp3mICrBJoy8ATDyi/oBXaaDSP9cfp
         TenXRODEYlcFUylDZrNNeCToIRGdHOEHRrKsr2GxYUgB1Q0x7VyPBo0SLP9pU0CucLmg
         DhEFpjWTTzG7eod44rfJYjFCouJPAXgiFQTDeDpeX2xBxgyzp1GbXK0css0g3XglFySA
         amLNfGmg2W0evjh74Pipb1xjJu+yZ349eK3GmUdn1uxmSXYcnIH26Pg3kLrc/1nsYVCz
         YYTblkz2NoZm4qMCJfXLo+YTv/E56vT8DJ0avgMdATJw2xoqWgZF5gK0+qQG031zLK0S
         lDDQ==
X-Gm-Message-State: AOAM532lLaeesCxkGy5vQg2rnij291YqlbipDRp7SQe70ZUtEm4y4Iv9
        BOqrWMmPZPPY7ZjOkuqNvRPP95VfpPE=
X-Google-Smtp-Source: ABdhPJxXWDsknf/Rb1rtb69rxvbDaZbMZ5tivJ14O17u25JSH7WJ9sVZ532+dseKBdIafTNKXVhMMmXELQA=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:ad4:4770:: with SMTP id d16mr2851186qvx.61.1603985144473;
 Thu, 29 Oct 2020 08:25:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:25:39 +0100
Message-Id: <20201029152539.3766146-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v5] x86: add failure injection to get/put/clear_user
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 - no significant changes

v3:
 - no changes

v4:
 - instrument the new out-of-line implementations of get_user()/put_user()
 - fix a minor checkpatch warning in the inline assembly

v5:
 - rebase after another change to put_user()
 - fix an issue reported by kernel test robot <lkp@intel.com>

---
---
 arch/x86/include/asm/uaccess.h | 38 +++++++++++++++++++++-------------
 arch/x86/lib/usercopy_64.c     |  3 +++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be3df82..036467b850f8 100644
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
@@ -126,11 +127,16 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%P4"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
-	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
+	if (should_fail_usercopy()) {					\
+		(x) = 0;						\
+		__ret_gu = -EFAULT;					\
+	} else {							\
+		asm volatile("call __" #fn "_%P4"			\
+			     : "=a" (__ret_gu), "=r" (__val_gu),	\
+				ASM_CALL_CONSTRAINT			\
+			     : "0" (ptr), "i" (sizeof(*(ptr))));	\
+		(x) = (__force __typeof__(*(ptr))) __val_gu;		\
+	}								\
 	__builtin_expect(__ret_gu, 0);					\
 })
 
@@ -220,15 +226,19 @@ extern void __put_user_nocheck_8(void);
 	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
 	__chk_user_ptr(ptr);						\
-	__ptr_pu = (ptr);						\
-	__val_pu = (x);							\
-	asm volatile("call __" #fn "_%P[size]"				\
-		     : "=c" (__ret_pu),					\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (__ptr_pu),					\
-		       "r" (__val_pu),					\
-		       [size] "i" (sizeof(*(ptr)))			\
-		     :"ebx");						\
+	if (unlikely(should_fail_usercopy())) {				\
+		__ret_pu = -EFAULT;					\
+	} else {							\
+		__ptr_pu = (ptr);					\
+		__val_pu = (x);						\
+		asm volatile("call __" #fn "_%P[size]"			\
+			     : "=c" (__ret_pu),				\
+				ASM_CALL_CONSTRAINT			\
+			     : "0" (__ptr_pu),				\
+			       "r" (__val_pu),				\
+			       [size] "i" (sizeof(*(ptr)))		\
+			     : "ebx");					\
+	}								\
 	__builtin_expect(__ret_pu, 0);					\
 })
 
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e97ab1..5617b3864586 100644
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
2.29.1.341.ge80a0c044ae-goog

