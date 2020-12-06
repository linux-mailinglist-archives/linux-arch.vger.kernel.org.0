Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5092D014C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLFGt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLFGt4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:49:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFEC0613D1;
        Sat,  5 Dec 2020 22:49:16 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id i3so3248284pfd.6;
        Sat, 05 Dec 2020 22:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JHUF9M56L8pdroROSR587IeeoCouh6v3u8sIURXLiNA=;
        b=SOyfMthpjyhEi/02hNXXLzHE/6Af7pxFK6SOtjOIeC+ugV5YbVyFSjTK3i//pfaNZI
         L9ujV0+gQrECKVfWXMt8n+t7w1pARd088tOxIPKf4Nu0HTF/cEa8hgG5GeqNJzCb1asD
         MlKtib3G0oCGwFGR6Uprq7nwwixDQnQ+hfbIroSJVwKKy/fAgRgkYnWV5dsG0WChb8Sz
         5OtStMUY3Cq3sJmzbH2aac06G3JtYpN6jNSAUXaJjRGmkIt1IlkDuD8LwEcQ2CgIvBS9
         PqUEuue5E6AVrdcHvN9LsrtfsvtWBz3VC889sSNXYpffA5JAHreL2cQQIBAs1mfS91X7
         mcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JHUF9M56L8pdroROSR587IeeoCouh6v3u8sIURXLiNA=;
        b=Zs85017FWYIATQEVeXxiEIzm1A1qTIs05pBgoTnkSiVuuAjg9K3aXZYSpH0Lh/1Bc9
         hvUDay88S6ZoW0ZjrnSIE+Q3G5RBImULLpU87RJ1B7PRFihdNAeHnG38iwbObiPXOUxC
         J3Z1C4WgljXmmDGEVSPHGLGDGp2lsyo3fqS6C+hPJENG++scoPoKX+AD3w6i0JFgaBRy
         Hi18xfxRot7hPV7kLNBuOBY8c2YHLCktCHIZjORsqlQ380evOJ0h1eaQYdT6wk9SqG9J
         7HIoTqCWbe9f4bLEvv+QRyjavzJDxVaLI7CcKuBzRIWq9HQIb26UKr1dVFK1zafxn61Q
         90fA==
X-Gm-Message-State: AOAM530o4ndcZbbDdy0bPTogqVPKr9+mwST/EQAjb9ukvpiGxeC/4ryi
        Z7766V3bVkIhGbcvqf2qmbU=
X-Google-Smtp-Source: ABdhPJxiA0F32S55TyaAc9F/HlMsxvkqL0uY2yvMaSaLugwwFxqynL5xNu1KVJLAzhu0u9nvo4djzQ==
X-Received: by 2002:a05:6a00:22c9:b029:198:15b2:bbd3 with SMTP id f9-20020a056a0022c9b029019815b2bbd3mr11223897pfj.64.1607237355539;
        Sat, 05 Dec 2020 22:49:15 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id a18sm511721pfg.107.2020.12.05.22.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:49:15 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:49:05 +0900
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
Subject: [PATCH v2 5/8] lib/find_bit_bench.c: Add find_last_zero_bit.
Message-ID: <20201206064905.GA6183@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add bench test of find_last_zero_bit.

Also, this patch fix the unmatched iterations value with
find_next_bit and find_last_bit which happen when
the last bit set or not,
Let suppose, 4096 bitmap size and 4095 bit is set only.
In this case former find_next_bit returns iterations count as 0.
But find_last_bit returns it as 1.
This unmatched return value makes some confusion.
So we fix it.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/find_bit_benchmark.c | 51 +++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5637c5711db9..007371169008 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
  */
 static int __init test_find_first_bit(void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < len; cnt++) {
+	do {
 		i = find_first_bit(bitmap, len);
 		__clear_bit(i, bitmap);
-	}
+	} while (i++ < len && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
 
 static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
+	do {
+		i = find_next_bit(bitmap, BITMAP_LEN, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 
 static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_zero_bit(bitmap, len, i) + 1;
+	do {
+		i = find_next_zero_bit(bitmap, len, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -84,27 +86,46 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 
 	time = ktime_get();
 	do {
-		cnt++;
 		l = find_last_bit(bitmap, len);
 		if (l >= len)
 			break;
 		len = l;
-	} while (len);
+	} while (len >= 0 && ++cnt); /**< to find real 0 bit set. */
 	time = ktime_get() - time;
 	pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
 
 	return 0;
 }
 
+static int __init test_find_last_zero_bit(const void *bitmap, unsigned long len)
+{
+	unsigned long l, cnt = 0;
+	ktime_t time;
+
+	time = ktime_get();
+	do {
+		l = find_last_zero_bit(bitmap, len);
+		if (l >= len)
+			break;
+		len = l;
+	} while (len >= 0 && ++cnt); /**< to find real 0 bit set. */
+	time = ktime_get() - time;
+	pr_err("find_last_zero_bit:      %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
+
 static int __init test_find_next_and_bit(const void *bitmap,
 		const void *bitmap2, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	do {
+		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -123,6 +144,7 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
+	test_find_last_zero_bit(bitmap, BITMAP_LEN);
 
 	/*
 	 * test_find_first_bit() may take some time, so
@@ -144,6 +166,7 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
+	test_find_last_zero_bit(bitmap, BITMAP_LEN);
 	test_find_first_bit(bitmap, BITMAP_LEN);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
-- 
2.27.0
