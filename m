Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEE2DF9C
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE2OXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 10:23:38 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45021 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfE2OXf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 10:23:35 -0400
Received: by mail-qk1-f201.google.com with SMTP id v2so1997283qkd.11
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XGYstJC40WMJZKWA//5lX0DesV6Lf9IkKEWuIExOKfQ=;
        b=OxGkFghtWB+nfC8qcX2Kw1DsVLZiXrr3A8z8E+HRZvmT+P4PZgsM2i8FKDtVN7tDgH
         hgop1Onj22rDTO2gGCvdFKPSO5xNidsp747aLgC9xF4Ex/ixAp8jFbPx2QKZVN78N+hS
         Ggk2ZZ0W62WvE2E+pcwmicVuwiHwioEk+iAoq+K6OUsq+SBpoSwg9BkU8291Q3nF+9Vf
         SAWqxBrsaXEfWREmKwjcZzjQCB6CCmetGG45pyIdrG36kONp49A30PgdE3C+JilhISgE
         cHl3B8pFu2Eo8q7ybm2dJV9ScZ3Ulm+tHTyE4HopaiULoL+Vv8VhjnUZXjwpZLykZA2B
         p3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XGYstJC40WMJZKWA//5lX0DesV6Lf9IkKEWuIExOKfQ=;
        b=nYF7R5G1BZIVPTiB1SiYwdLTfKCZJH3VHCXcMOsCb6Hh8HaN1v4IEd4mBHg+MlRhMY
         1/5fGTJFpfTlPaw5hZumKwzzs7vB1zmj7cYabWXwGrJkhExcOymPWg3t0Nk9pmAut3g+
         03BsiPQB0x2U7VO/fC5kQzIxsMBVEGSI7BdpH9dSX1M496o8avPiBQ1MP/Kyb1rcM3Mq
         r3e7qujOWhna1LdcuCyHZaEBaPLItijtCxGAnRRnG/zCgpqnfFlY5FfeMfwhQn/AUXcT
         DRiSIFK0KfQaVDqanz2e4havBsRzvFEsD3ongI0nVXv/txcZOM+LXWJ5P8j3RLl7d6CZ
         c15w==
X-Gm-Message-State: APjAAAUbGM8wBthhYjvMqrWm//7wycO3EY38UVn8z57/eruUY/TnuLTU
        FNgBoUVc2w+77JUURmupTrtj6SWsOA==
X-Google-Smtp-Source: APXvYqyVy0u4kXUacxu4+JJYQdDdggxgHbmHU0olidJDRn2GT+1ov13CB+Sljlt1m7OrwthQ92dwHTjTPA==
X-Received: by 2002:ac8:270b:: with SMTP id g11mr72071334qtg.363.1559139814057;
 Wed, 29 May 2019 07:23:34 -0700 (PDT)
Date:   Wed, 29 May 2019 16:14:59 +0200
In-Reply-To: <20190529141500.193390-1-elver@google.com>
Message-Id: <20190529141500.193390-2-elver@google.com>
Mime-Version: 1.0
References: <20190529141500.193390-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v2 1/3] lib/test_kasan: Add bitops tests
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
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
Changes in v2:
* Use BITS_PER_LONG.
* Use heap allocated memory for test, as newer compilers (correctly)
  warn on OOB stack access.
---
 lib/test_kasan.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..6562df0ca30d 100644
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
+	long *bits = kmalloc(sizeof(long), GFP_KERNEL | __GFP_ZERO);
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

