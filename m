Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B702CC10
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfE1QdT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 12:33:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40338 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfE1QdT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 12:33:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id n5so28617283qkf.7
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LR69yw39cmBSKp2W9gsMXj4VuQrD7UTJhZMWtKCJnXo=;
        b=qze2NuI5E9bS04poXLsO6vCW7rptEb4DT6Pp2T7ITI1xctQwZGMpMJeRxySZRC1hzo
         mOMQaumjIUWRLsZ5JRN4YyLDbALV+3XLXhpGbmw4myLtVcKQpmtr2Uj/su8NoBOdvnJw
         JG6aFlEuAfTejzNlQ2taD/hdOx/DgQdJbcJvS+Ye8KTIITxkY2QoS52TioTTWRxm+ERB
         0BuQjOVLFR9GpTfYnWasGl2UTEAFxuvTbm3pmRPF1qXGgonthzIlnm1dFu49bh7JFJoJ
         spSzSFHJaN8nCClHtxU74257jrpwvCZe/oPhHVqCRkOcNs3ZKdNZ49d51JEtASyos0XR
         eUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LR69yw39cmBSKp2W9gsMXj4VuQrD7UTJhZMWtKCJnXo=;
        b=bgUs+uDVQvrEir/rBG/VDd4m9Ivz9XAUfzGeOUUTRtG5mLg6t6dvCAddYm668CCHQZ
         SQVUzsQDdnywWQUwg0ZdZqP2sK/GLpNSQbJ1p3ZFSiMp1BiD/Kcozf1oEMTtfnC/GMKh
         pCtnX4nBfahKocA44MXzUxpH37KSwvLJt1SlMFXct3L/qhpjlTlqlWh8K4cQT7YdNu0a
         pJyngXwyIl5MkVC2yS6M9Wq5CaKCF2Bm+YNUR0Scdm3lXW/5NVtkkWO18e3JFKLgJDYw
         KvV6qU/TPDaiEI+hXKSECtAH9H6afALY7WhTRr/n0vlMZZJ0qpvBEdoAv4xi/rjIMfg6
         2/BQ==
X-Gm-Message-State: APjAAAV7Qv17rubz84BhIOesDs2qBrf47Jyl29g7tQFZtKuCo0D/xJAj
        86ylOidJmITnNU5Wg/eREs6Tk+0NVA==
X-Google-Smtp-Source: APXvYqyPj0jvDds1yN0kQJSjCrz+vBTZlgZzHMoyXOKdZbtkt4jgY70hq4KqMP1xFCC/VbNyKqbJf/efnQ==
X-Received: by 2002:ac8:21ba:: with SMTP id 55mr20465060qty.116.1559061198612;
 Tue, 28 May 2019 09:33:18 -0700 (PDT)
Date:   Tue, 28 May 2019 18:32:56 +0200
Message-Id: <20190528163258.260144-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH 1/3] lib/test_kasan: Add bitops tests
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds bitops tests to the test_kasan module. In a follow-up patch,
support for bitops instrumentation will be added.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/test_kasan.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..f67f3b52251d 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -11,16 +11,17 @@
 
 #define pr_fmt(fmt) "kasan test: %s " fmt, __func__
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/kasan.h>
 #include <linux/kernel.h>
-#include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/module.h>
-#include <linux/kasan.h>
 
 /*
  * Note: test functions are marked noinline so that their names appear in
@@ -623,6 +624,71 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kasan_bitops(void)
+{
+	long bits = 0;
+	const long bit = sizeof(bits) * 8;
+
+	pr_info("within-bounds in set_bit");
+	set_bit(0, &bits);
+
+	pr_info("within-bounds in set_bit");
+	set_bit(bit - 1, &bits);
+
+	pr_info("out-of-bounds in set_bit\n");
+	set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __set_bit\n");
+	__set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in clear_bit\n");
+	clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __clear_bit\n");
+	__clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in clear_bit_unlock\n");
+	clear_bit_unlock(bit, &bits);
+
+	pr_info("out-of-bounds in __clear_bit_unlock\n");
+	__clear_bit_unlock(bit, &bits);
+
+	pr_info("out-of-bounds in change_bit\n");
+	change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __change_bit\n");
+	__change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_set_bit\n");
+	test_and_set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_set_bit\n");
+	__test_and_set_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_set_bit_lock\n");
+	test_and_set_bit_lock(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_clear_bit\n");
+	test_and_clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_clear_bit\n");
+	__test_and_clear_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_and_change_bit\n");
+	test_and_change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in __test_and_change_bit\n");
+	__test_and_change_bit(bit, &bits);
+
+	pr_info("out-of-bounds in test_bit\n");
+	(void)test_bit(bit, &bits);
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
+	clear_bit_unlock_is_negative_byte(bit, &bits);
+#endif
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +730,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kasan_bitops();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

