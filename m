Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85F3A4EDC
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFLMju (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:39:50 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40823 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFLMju (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:39:50 -0400
Received: by mail-qt1-f173.google.com with SMTP id t9so4801746qtw.7;
        Sat, 12 Jun 2021 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTQKmMRat0zLLjLTg60IuFoUE4mlUd1rf/gNdQ4/W4A=;
        b=sud1x9t+JlGX6t3Z9dEy61OEyQ2SPI2v7pDnpNbqGtHdR1ln4fagnUl4r1TgyKbZI9
         TDspQqb93S9sWLeRzWbRKpMkwGBd2vNVpFqY4K0t4xNnorqK3jca6nOzwPsxO1KOpu0a
         fCDUHrR2emLWld2MwmhAjHihRzk+qU/FGkgYeWq+c336ObNTcEtY+Yv4uz+gsLr1XcSI
         N8swN6ijbzakvpBRs3e6Xd9OnrBJiBxzgB1zb5W4VqdlY/7JTFJThlyLQP+nyYZkt/ht
         FCwwzujOyWfJcBaN05zEEFkKxH1EdAP5rPE91vDoY7bMBge3BrjDF0oflLQYdC99bZ7P
         f3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTQKmMRat0zLLjLTg60IuFoUE4mlUd1rf/gNdQ4/W4A=;
        b=G8lRgIx9hkwRx3FsZe2fyofjzwLHiPzus8uoCv+zAOglhXVR86hRUrpwEYG+QHHDXO
         1YOSi+Ryf7d4DPY6M7eMjNUxYz7Vs/LHQCuUc6QslmBeIqhZyYZs5quw+cIxCUOrpsjn
         ZIeSjMF0G70dJG9ScKDFuGXqn+8+5gPSQgoURhyk16jMIgdEH+xfkCzfg1w98s99eBR1
         L6aZbyT/0QnIBQdvbaMe8CWPx4I191wWnCKWM022I7UZ68d3BW7EeaCZ3CUs8IDsmP08
         p7/FVjIphEUKtbuoCMDz0BDkYRe16IXmMm6EbK8N5U8h0SXgpmLXLScEA5WKJMW+RhTk
         i9BQ==
X-Gm-Message-State: AOAM532sidxMU4C0t2j9eK+8teTxevEj1p8e+ygdBVvytA65omDJJzsM
        +o/4He4NlCCnYBcUZ7oQOoIhiw68z3XARw==
X-Google-Smtp-Source: ABdhPJzA1m65c6QDYeb10DrdTDbQ6Hp+DkZNgU36GCf3VLChDERQFYzMptncBFb2A6KCfA1Q9EZSJw==
X-Received: by 2002:a05:622a:1008:: with SMTP id d8mr6905020qte.257.1623501410183;
        Sat, 12 Jun 2021 05:36:50 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id p199sm6477550qka.128.2021.06.12.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:49 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/8] lib: add find_first_and_bit()
Date:   Sat, 12 Jun 2021 05:36:36 -0700
Message-Id: <20210612123639.329047-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently find_first_and_bit() is an alias to find_next_and_bit(). However,
it is widely used in cpumask, so it worth to optimize it. This patch adds
its own implementation for find_first_and_bit().

On x86_64 find_bit_benchmark says:

Before (#define find_first_and_bit(...) find_next_and_bit(..., 0):
Start testing find_bit() with random-filled bitmap
[  140.291468] find_first_and_bit:           46890919 ns,  32671 iterations
Start testing find_bit() with sparse bitmap
[  140.295028] find_first_and_bit:               7103 ns,      1 iterations

After:
Start testing find_bit() with random-filled bitmap
[  162.574907] find_first_and_bit:           25045813 ns,  32846 iterations
Start testing find_bit() with sparse bitmap
[  162.578458] find_first_and_bit:               4900 ns,      1 iterations

(Thanks to Alexey Klimov for thorough testing.)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h     | 27 +++++++++++++++++++++++++++
 lib/find_bit.c           | 21 +++++++++++++++++++++
 lib/find_bit_benchmark.c | 21 +++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index ea57f7f38c49..6048f8c97418 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -12,6 +12,8 @@ extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_first_and_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
@@ -123,6 +125,31 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_first_and_bit
+/**
+ * find_first_and_bit - find the first set bit in both memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_and_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_and_bit(addr1, addr2, size);
+}
+#endif
+
 #ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0f8e2e369b1d..1b8e4b2a9cba 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -89,6 +89,27 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(_find_first_bit);
 #endif
 
+#ifndef find_first_and_bit
+/*
+ * Find the first set bit in two memory regions.
+ */
+unsigned long _find_first_and_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	unsigned long idx, val;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
+		val = addr1[idx] & addr2[idx];
+		if (val)
+			return min(idx * BITS_PER_LONG + __ffs(val), size);
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(_find_first_and_bit);
+#endif
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5637c5711db9..db904b57d4b8 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -49,6 +49,25 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
 	return 0;
 }
 
+static int __init test_find_first_and_bit(void *bitmap, const void *bitmap2, unsigned long len)
+{
+	static DECLARE_BITMAP(cp, BITMAP_LEN) __initdata;
+	unsigned long i, cnt;
+	ktime_t time;
+
+	bitmap_copy(cp, bitmap, BITMAP_LEN);
+
+	time = ktime_get();
+	for (cnt = i = 0; i < len; cnt++) {
+		i = find_first_and_bit(cp, bitmap2, len);
+		__clear_bit(i, cp);
+	}
+	time = ktime_get() - time;
+	pr_err("find_first_and_bit: %18llu ns, %6ld iterations\n", time, cnt);
+
+	return 0;
+}
+
 static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 {
 	unsigned long i, cnt;
@@ -129,6 +148,7 @@ static int __init find_bit_test(void)
 	 * traverse only part of bitmap to avoid soft lockup.
 	 */
 	test_find_first_bit(bitmap, BITMAP_LEN / 10);
+	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN / 2);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	pr_err("\nStart testing find_bit() with sparse bitmap\n");
@@ -145,6 +165,7 @@ static int __init find_bit_test(void)
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
 	test_find_first_bit(bitmap, BITMAP_LEN);
+	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	/*
-- 
2.30.2

