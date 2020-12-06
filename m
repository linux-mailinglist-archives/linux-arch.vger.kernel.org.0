Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87A2D014F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLFGu0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgLFGuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:50:25 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107BC0613D0;
        Sat,  5 Dec 2020 22:49:45 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q3so6299977pgr.3;
        Sat, 05 Dec 2020 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3PEmlh6aE9CmyO6zewKzfybfIALm2kxq/ng8znMTqEA=;
        b=JVXFe3IBbCRSIJuJiYBKNO5rGLdrvvVreHIaGiLsmcZ8MZhohdh69fp++C09/SNhfU
         Bhqv3iTcnFCnS6Sk241c7tmx98KK4C4LUcQkBa0nWBi22AJoesed7XsquNChoq7c5xJf
         ZC+RjB3R6ShhsMddmwRkBUpS848NqunYolIEoEkh7X45+tnBXuV5g0RM0FgpMAC+0D5l
         DQ3bJC2xBMJeQHBafaxxTW0Ct/ezVJcK6LdbSOG6xImNQNMB9o72YsWG+3sZHlt5+ypI
         FRxH5xM/VhKgBoP425CHaHymBTNh/mQSkiEme+T1UaZR5c5FXbzlkWX6v2fD0ij1fO7W
         TfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3PEmlh6aE9CmyO6zewKzfybfIALm2kxq/ng8znMTqEA=;
        b=SsfzXA0mSyi7cXSbBFoQu4fpCLwiNrX/6gPiNegtbwaEgxM1Rv3eh83v/d7B9K6pC0
         3J/vIP58WvJ2Ev5qQTIfG5cLIWolrZ5p3wsqShQnJnawdxapfOrAUFU2FLVNTMSvLaHX
         +MWil9YTQ53QXcudJ+r1mFui/vnkiKr0qFcHWOfhaSqN8nA+G/uMFkemmgltJgGuwuQS
         qjHQ8OKQnN/pWy1A/nETBA0tgm8zWB2mTuBDDwlNTRevZVJ66Zd/4fWjfTKDkgecGQ2K
         gkMrAAvukki3PqmovaB6aOGzNvtmHdeKxUSTKKy5FbE5CF1TuQeT8fNmkuzEeHsEQ4oF
         wrnw==
X-Gm-Message-State: AOAM531hxjPD2pPSyvjeFiElqaDYfySwciH8HkodMvgn0reFuNOk/7xC
        U4KYQbWsQ1lPy3qlP/FeacQ=
X-Google-Smtp-Source: ABdhPJySs3OnKLZRLL8BIAVrl1XwWl4I+rynhN0TAq4NY5C47XMnkTI47eP9Z3mqKg/Z68m4M5yPdA==
X-Received: by 2002:aa7:93c3:0:b029:19d:e081:9751 with SMTP id y3-20020aa793c30000b029019de0819751mr3222921pff.73.1607237385069;
        Sat, 05 Dec 2020 22:49:45 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id h4sm8336821pgp.8.2020.12.05.22.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:49:44 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:49:35 +0900
From:   Levi Yun <ppbuk5246@gmail.com>
To:     akpm@linux-foundation.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        arnd@arndb.de, jpoimboe@redhat.com, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        mhiramat@kernel.org, jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        glider@google.com, orson.zhai@unisoc.com,
        takahiro.akashi@linaro.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/8] lib/find_bit: Add test-module,find_last_zero_bit
Message-ID: <20201206064935.GA6252@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add test module to test find_last_zero_bit and
find_each_*_bit_revserse.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/Kconfig.debug        |   8 ++
 lib/Makefile             |   1 +
 lib/test_find_last_bit.c | 235 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 lib/test_find_last_bit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..481e366d0e82 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2188,6 +2188,14 @@ config FIND_BIT_BENCHMARK
 
 	  If unsure, say N.
 
+config TEST_FIND_LAST_BIT
+	tristate "Test find_last_*_bit functions"
+	help
+	  This builds the "test_find_last_bit" module that measure find_last_*_bit()
+	  functions performance.
+
+	  If unsure, say N.
+
 config TEST_FIRMWARE
 	tristate "Test firmware loading via userspace interface"
 	depends on FW_LOADER
diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..310719df6207 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -58,6 +58,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
+obj-$(CONFIG_TEST_FIND_LAST_BIT) += test_find_last_bit.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
diff --git a/lib/test_find_last_bit.c b/lib/test_find_last_bit.c
new file mode 100644
index 000000000000..579866c476d1
--- /dev/null
+++ b/lib/test_find_last_bit.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for find_prev_*_bit functions.
+ *
+ * Copyright (c) 2020 Levi Yun.
+ */
+
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+
+
+#define BITMAP_LEN		(4096UL * 8 * 10)
+#define BITMAP_LAST_IDX		BITMAP_LEN - 1
+
+
+static DECLARE_BITMAP(zero_bitmap, BITMAP_LEN) __initdata;
+static DECLARE_BITMAP(full_bitmap, BITMAP_LEN) __initdata;
+
+static int __init test_for_each_clear_rev(const void *bitmap, unsigned long len)
+{
+	unsigned long cur;
+	unsigned long expect = BITMAP_LAST_IDX;
+
+	pr_err("[%s:%d] Start test clear full iteration\n", __func__, __LINE__);
+
+	len = BITMAP_LEN;
+
+	for_each_clear_bit_reverse(cur, bitmap, len) {
+		if (cur != expect) {
+			pr_err("[%s:%d] full iteration fail!,  expect: %lu, cur: %lu\n",
+					__func__, __LINE__, expect, cur);
+
+			return 0;
+		}
+
+		expect--;
+	}
+
+	len = BITMAP_LEN;
+
+	cur = len / 3;
+	expect = cur;
+	pr_err("[%s:%d] Success\n", __func__, __LINE__);
+
+	pr_err("[%s:%d] Start test clear iteration with starting point\n", __func__, __LINE__);
+	for_each_clear_bit_from_reverse(cur, bitmap, len) {
+		if (cur != expect) {
+			pr_err("[%s:%d] full iteration fail!,  expect: %lu, cur: %lu\n",
+					__func__, __LINE__, expect, cur);
+
+			return 0;
+		}
+
+		expect--;
+	}
+
+	pr_err("[%s:%d] Success\n", __func__, __LINE__);
+
+	return 0;
+}
+
+static int __init test_for_each_set_rev(const void *bitmap, unsigned long len)
+{
+	unsigned long cur;
+	unsigned long expect = BITMAP_LAST_IDX;
+
+	len = BITMAP_LEN;
+	pr_err("[%s:%d] Start test set full iteration\n", __func__, __LINE__);
+	for_each_set_bit_reverse(cur, bitmap, len) {
+		if (cur != expect) {
+			pr_err("[%s:%d] full iteration fail!,  expect: %lu, cur: %lu\n",
+					__func__, __LINE__, expect, cur);
+
+			return 0;
+		}
+
+		expect--;
+	}
+	pr_err("[%s:%d] Success\n", __func__, __LINE__);
+
+
+	len = BITMAP_LEN;
+	cur = len / 3;
+	expect =  cur;
+
+	pr_err("[%s:%d] Start test set iteration with starting point\n", __func__, __LINE__);
+	for_each_set_bit_from_reverse(cur, bitmap, len) {
+		if (cur != expect) {
+			pr_err("[%s:%d] full iteration fail!,  expect: %lu, cur: %lu\n",
+					__func__, __LINE__, expect, cur);
+
+			return 0;
+		}
+
+		expect--;
+	}
+	pr_err("[%s:%d] Success\n", __func__, __LINE__);
+
+	return 0;
+}
+
+static int __init test_find_last_bit_clear_middle(void *bitmap)
+{
+	unsigned long idx;
+	unsigned long len = 4096;
+
+	pr_err("[%s] Start test\n", __func__);
+
+	clear_bit(1, bitmap);
+	clear_bit(65, bitmap);
+	clear_bit(136, bitmap);
+	clear_bit(4095, bitmap);
+
+	idx = find_last_zero_bit(bitmap, len);
+	if (idx != 4095) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 4095, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 136) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 127, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 65) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 65, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 1) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 1, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 1) {
+		pr_err("[%s] Fail (find no bit clear)! expect: %u, idx: %lu\n", __func__, 1, idx);
+
+		goto teardown;
+	}
+
+	pr_err("[%s] Success\n", __func__);
+
+teardown:
+	set_bit(4095, bitmap);
+	set_bit(136, bitmap);
+	set_bit(65, bitmap);
+	set_bit(1, bitmap);
+
+	return 0;
+}
+
+static int __init test_find_last_zero_bit(void *bitmap, unsigned long len)
+{
+	unsigned long idx;
+	pr_err("[%s] Start test\n", __func__);
+
+	idx = find_last_zero_bit(bitmap, len);
+	if (idx != len) {
+		pr_err("[%s] Fail! expect: %lu, idx: %lu\n", __func__, len, idx);
+
+		goto teardown;
+	}
+
+	clear_bit(4095, bitmap);
+	clear_bit(2032, bitmap);
+	clear_bit(0, bitmap);
+
+	idx = find_last_zero_bit(bitmap, len);
+	if (idx != 4095) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 4095, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 2032) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 2032, idx);
+
+		goto teardown;
+	}
+
+	idx = find_last_zero_bit(bitmap, idx);
+	if (idx != 0) {
+		pr_err("[%s] Fail! expect: %u, idx: %lu\n", __func__, 0, idx);
+
+		goto teardown;
+	}
+
+	pr_err("[%s] Success\n", __func__);
+
+teardown:
+	set_bit(0, bitmap);
+	set_bit(2032, bitmap);
+	set_bit(4095, bitmap);
+
+	return 0;
+}
+
+static int __init find_last_bit_test(void)
+{
+	bitmap_zero(zero_bitmap, BITMAP_LEN);
+	bitmap_fill(full_bitmap, BITMAP_LEN);
+	pr_err("\nStart testing find_last_*_bit()\n");
+
+	test_for_each_clear_rev(zero_bitmap, BITMAP_LEN);
+	test_for_each_set_rev(full_bitmap, BITMAP_LEN);
+	test_find_last_bit_clear_middle(full_bitmap);
+	test_find_last_zero_bit(full_bitmap, BITMAP_LEN);
+
+	pr_err("\nFinish testing find_last_*_bit()\n");
+
+	/*
+	 * Everything is OK. Return error just to let user run benchmark
+	 * again without annoying rmmod.
+	 */
+	return -EINVAL;
+}
+
+
+module_init(find_last_bit_test);
+
+
+MODULE_LICENSE("GPL");
-- 
2.27.0
