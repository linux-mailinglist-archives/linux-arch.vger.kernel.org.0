Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4641F48B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355726AbhJASPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355750AbhJASOp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F8C0613EB;
        Fri,  1 Oct 2021 11:13:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pg10so6655222pjb.5;
        Fri, 01 Oct 2021 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIPuS4OLzQCF5AgK/VmYDt3q+TnxbO8XesSIDRxgCzY=;
        b=OUPs20Lz/NmbRxei/rcKEENCor4GrIksTbNzrra8o8sGuoimx71sXhzX9Of43nAnI/
         mtkXVzPKdKv18s+rx/EDmdNghESXRYhcZubBhhiltyvNDVGcAN1wfPJp6chufp3k5zKa
         DtCX0vJNCzUwHi0xdLwtTK985EUilWbQIKMWGdgIrEELDhcRcMJg8N8NFHuDF12RNQPz
         6rHWpH1T21yydWaNUcBB8SvN/n4NeggmGa7dghzyUMTL4jIlroY40idxGtFCOXovvnZG
         i7cdjmKJSVuY+GoLvZAtZC6hQy7WfscaNhF9R3CmeyVmTkey4TfMvi/1IP07zzSCFrow
         reag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIPuS4OLzQCF5AgK/VmYDt3q+TnxbO8XesSIDRxgCzY=;
        b=YOz9fgTCgGAUGnenRa0NEggV+tC7lvbszQQ/a6VyNXtt7IHYO6Ny+k6kMOJLdCyrQy
         GCgu7kpZ+9vZCK2lh4kQ3+Tqze60VPQygDhMZNLWyWB3Si5lnU0XgzDidAoulKips1/u
         kVuKzQUFnp8e8mJ1958EvdDutNmWLHCyE+MmVJ05WkQxZeUizIES1ENIIrgAeMIfRG2A
         MOKQsAUNfknIwnUKhZlH5wK/YWzJzRFTfdlXWgHfLBimXG784R98BaO9GAnp5nlY4M2H
         Lc5eb0GNZvZVxX9nPAFSfKq8d4ZvxJtxHAVfwjxqP83K+8RQlVxWYtmjPNaht8VCn94D
         WeoA==
X-Gm-Message-State: AOAM53110TMZQD0kavlQce35X71IodAVfWU3fAkBujBmM88IPlB3X7aU
        /hcuV/gr2TLo0WsFrExRqwFyxbNHwEo=
X-Google-Smtp-Source: ABdhPJwYsv/lJiq2bBbSjjU3f4DxXazbTsA4OLPiXahnaImXyC6vCzP9cY+tmf9cr+7T5Q6pwdEmdw==
X-Received: by 2002:a17:90a:da06:: with SMTP id e6mr14937823pjv.63.1633111980523;
        Fri, 01 Oct 2021 11:13:00 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 186sm5925966pfg.20.2021.10.01.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:00 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 05/16] lib: add find_first_and_bit()
Date:   Fri,  1 Oct 2021 11:12:34 -0700
Message-Id: <20211001181245.228419-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
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
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Alexey Klimov <aklimov@redhat.com>
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

