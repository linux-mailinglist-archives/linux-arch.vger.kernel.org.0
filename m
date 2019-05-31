Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83A310F7
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEaPLk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 11:11:40 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:46453 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfEaPLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 11:11:39 -0400
Received: by mail-yb1-f201.google.com with SMTP id v15so7678397ybe.13
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gLta7Etz+AT0uZJXEtTw/d9Eqbqeoj2w6clUtWu9Mu8=;
        b=Rjf39fVreMPfvvAWdL8HT5/mVr9xbaBS39GnzTO7+6MCC0JLLliFuf45FzHxsuMf/s
         L4GVVlmofl8BIzqyEmHmh+i5EKD/M8mhGsWFx1arfIivAjyT2hKxo5ShJzgfiGH//v39
         WcH19jlZSZ93VxzQdGev9phccKTA8RhPeZW60okoDlAJs2WGZdfXrEgitKIl2e0Rnyua
         jFEMeBpQI2iXQrNqGmW3m+rHvpmPKJCjR9Za5pHvFm60T3M/pDOV3DMOKv3hfEBchsgH
         PJxZ7xs49yQsHBMa1Cw7DmgDFuGsAppiL6hkU4pznIdKVCT1z1TsgjSA0EQo93oPO+gj
         AizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gLta7Etz+AT0uZJXEtTw/d9Eqbqeoj2w6clUtWu9Mu8=;
        b=Ji+5yrg2OGCVBc2ekkgRPk3npCDJQUsmvvnKO4kQgnbHEqAfXudTM+L6YDmhcesCBj
         sD7wP6iIaNsnw32RT8djFDa/ThBZ9n/GcIImhcT/Wo4WQNh9Y4Gglb1E9cWZfrQBJ7Q0
         psmwdJDdtfIlr/+apBNBWwxLuN8WbCgXL/MsWzdyJjckmET8tM3kELKH0s1FJWz63mYl
         j5omG/OEzsM9B1RQOMug7Zxg4u5onqV7+X9B4A1fBiyBNClDm9+7S90cwiNada3ozb6g
         vmoBGIDCNG07l3u53FzHTBotJBNrvSkkhHL8kV/XvQZxLSCV9u+fzdCrAGtmRGiZDQYh
         j8xw==
X-Gm-Message-State: APjAAAVLhlq2twKQHpJBxgTkrAOiZzteG/YA1DDNcZ0x0Ga8R7oC9Wbs
        pdmMMGEwNpe6jmqknMwONBo+RnFXlw==
X-Google-Smtp-Source: APXvYqyD9dFfj0smZxXNxXzPioh7Dykim0ewD5FKJbw91RkUv2vU0UgdGRx1UmdnPlXwFR4hNKFTPT+iTQ==
X-Received: by 2002:a81:980b:: with SMTP id p11mr5711332ywg.48.1559315498458;
 Fri, 31 May 2019 08:11:38 -0700 (PDT)
Date:   Fri, 31 May 2019 17:08:29 +0200
In-Reply-To: <20190531150828.157832-1-elver@google.com>
Message-Id: <20190531150828.157832-2-elver@google.com>
Mime-Version: 1.0
References: <20190531150828.157832-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 1/3] lib/test_kasan: Add bitops tests
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
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
Changes in v3:
* Use kzalloc instead of kmalloc.
* Use sizeof(*bits).

Changes in v2:
* Use BITS_PER_LONG.
* Use heap allocated memory for test, as newer compilers (correctly)
  warn on OOB stack access.
---
 lib/test_kasan.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..1ef9702327d2 100644
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
@@ -623,6 +624,73 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kasan_bitops(void)
+{
+	long *bits = kzalloc(sizeof(*bits), GFP_KERNEL);
+	if (!bits)
+		return;
+
+	pr_info("within-bounds in set_bit");
+	set_bit(0, bits);
+
+	pr_info("within-bounds in set_bit");
+	set_bit(BITS_PER_LONG - 1, bits);
+
+	pr_info("out-of-bounds in set_bit\n");
+	set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __set_bit\n");
+	__set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in clear_bit\n");
+	clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __clear_bit\n");
+	__clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in clear_bit_unlock\n");
+	clear_bit_unlock(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __clear_bit_unlock\n");
+	__clear_bit_unlock(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in change_bit\n");
+	change_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __change_bit\n");
+	__change_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in test_and_set_bit\n");
+	test_and_set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __test_and_set_bit\n");
+	__test_and_set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in test_and_set_bit_lock\n");
+	test_and_set_bit_lock(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in test_and_clear_bit\n");
+	test_and_clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __test_and_clear_bit\n");
+	__test_and_clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in test_and_change_bit\n");
+	test_and_change_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __test_and_change_bit\n");
+	__test_and_change_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in test_bit\n");
+	(void)test_bit(BITS_PER_LONG, bits);
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
+	clear_bit_unlock_is_negative_byte(BITS_PER_LONG, bits);
+#endif
+	kfree(bits);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +732,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kasan_bitops();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

