Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6582743A40
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfFMPTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:19:52 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51168 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbfFMNAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 09:00:10 -0400
Received: by mail-qk1-f202.google.com with SMTP id n77so16488127qke.17
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ybi8SfjCPz2J5Q8w+1yX5IhzPr2ih+s0DDGtyk1eE0Q=;
        b=ts1iVh+MGoXxSHAOlM6VYEYvHolnCXBAmkapqrFpT7xVCQzd3Fa2JkT1/HyG97LFTI
         mO4qoHbIWJzYknXJB9Qo9GJzrP+bFZryH68kiERkcgtbTpQ85NTHFaHjFVKszYIV7DQp
         Q1jw3cRylgS8rtUqWuipeckBmtvdIGjD+0qBR+2w2BdtT1j0mAt/Nr9W5IwLPgurFckj
         rlVC/BIiHSswUysRXsjRYgl0Tv+gCDCfg1Lv5xNY6uPfkfi8PZi75+tSjqfaHLZAyzC0
         k7CTsMMm4jVSITG9r6yCHkrahbWECdormGn+3rkzx0NsMpxx2Pi9d4Cw/SkV3QLvo9jW
         SzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ybi8SfjCPz2J5Q8w+1yX5IhzPr2ih+s0DDGtyk1eE0Q=;
        b=pc8GtXX/nHssADX405xpCp8EDILfeSk4AK87VJjQTk2muC06Scnf5V+Du9mBTpRuZG
         c+HQnFHbyewZBuuQJuahX6b+BLvKfjAX2Yt+9yStg6z91JnHOkn74i6RLAzN3YnSRI4Y
         wHpjqMdci9sUFZqYMPvrD/ZWSMwBvmNwkwJJiYXa1KQWRA9sguE+huTSmo+g58CPZ0/t
         JZjTFtQmm1pHCqs4MSxIyhklBP9OzEsPbmAumtivYJm+31TjPR8dWl8MskvlmHmhBfDW
         zypx+S6ee/+USJ7NXf2JOSrUEQxcNbh7Rw/zxty3/574BDKB9ckWqtUR44Rc4fkJXWCv
         asMA==
X-Gm-Message-State: APjAAAUh2l+pH77DHiExWl3kB67+VklBt9EOvRBtcO6kiMPPUg6E7AVW
        +5KYO4XH7wtlBcWe9sGM3xjTZNKdQw==
X-Google-Smtp-Source: APXvYqwtOyF/NipHfM0B1wS4zD7lYMrDN1HIEKEOmJ/DyO1Fbp7VEq6WgJWIEL0g0Ore5QNIIZb+c7v12w==
X-Received: by 2002:a37:47d1:: with SMTP id u200mr37053086qka.21.1560430808803;
 Thu, 13 Jun 2019 06:00:08 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:59:48 +0200
In-Reply-To: <20190613125950.197667-1-elver@google.com>
Message-Id: <20190613125950.197667-2-elver@google.com>
Mime-Version: 1.0
References: <20190613125950.197667-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v5 1/3] lib/test_kasan: Add bitops tests
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
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
Changes in v5:
* Remove incorrect comment.

Changes in v4:
* Remove "within-bounds" tests.
* Allocate sizeof(*bite) + 1, to not actually corrupt other memory in
  case instrumentation isn't working.
* Clarify that accesses operate on whole longs, which causes OOB
  regardless of the bit accessed beyond the first long in the test.

Changes in v3:
* Use kzalloc instead of kmalloc.
* Use sizeof(*bits).

Changes in v2:
* Use BITS_PER_LONG.
* Use heap allocated memory for test, as newer compilers (correctly)
  warn on OOB stack access.
---
 lib/test_kasan.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..267f31a61870 100644
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
@@ -623,6 +624,79 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kasan_bitops(void)
+{
+	/*
+	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
+	 * this way we do not actually corrupt other memory.
+	 */
+	long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
+	if (!bits)
+		return;
+
+	/*
+	 * Below calls try to access bit within allocated memory; however, the
+	 * below accesses are still out-of-bounds, since bitops are defined to
+	 * operate on the whole long the bit is in.
+	 */
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
+	/*
+	 * Below calls try to access bit beyond allocated memory.
+	 */
+	pr_info("out-of-bounds in test_and_set_bit\n");
+	test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_set_bit\n");
+	__test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_set_bit_lock\n");
+	test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_clear_bit\n");
+	test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_clear_bit\n");
+	__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_change_bit\n");
+	test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_change_bit\n");
+	__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_bit\n");
+	(void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
+	clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, bits);
+#endif
+	kfree(bits);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +738,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kasan_bitops();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

