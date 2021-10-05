Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53CE421E27
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhJEFnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhJEFnI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435C4C061783;
        Mon,  4 Oct 2021 22:41:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w14so1528934pll.2;
        Mon, 04 Oct 2021 22:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIPuS4OLzQCF5AgK/VmYDt3q+TnxbO8XesSIDRxgCzY=;
        b=IB/e9E/C1kr8o0K5p8DzE62VkGgywadLxe9xGEIVZ9iGC/sIxNgo2/87mURnDogKP7
         m8HBiNbsUvDrIoE43mIFRcXZSGZ9tctHdgAwm3etPMRH6gJs8iyQcs6qegXbIu+l44O9
         7HoVSFbODN5nUtrtzlzDy3nKiDJDLm6qbTXFZR5BCvQCuG4DCx7b/G23X5rN+kYfgp1u
         s1xj1BKNkrR5a9CcA+ETt9hwhj1A2+wJaxnJ70fiYtihkSPJbEZTFOkXgw5FF7UpTfjo
         tfncNoW/B7FETJce8ZEtvy7GWga+cqQ76Og9QapjpdZBbFOdSIGTs7khxf/6tSqZAV3n
         oU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIPuS4OLzQCF5AgK/VmYDt3q+TnxbO8XesSIDRxgCzY=;
        b=gUB4fGcRXoQSoqj8CwTBj5kjOzUVcQYi4J5DbhgPZ6/lWoWXrocr3X4q9lpG7LJsZ3
         4a3jeDgi76wnAniuzaIIt+S5wV1nSJli1jPYp5W4v7BH0WHw9iqwWk4vFGqTiwuivxgC
         nCc88ZItJ1AEKoZTL7v7nJDSy56rYTUzQQ/h5p0qtcPjpujOx5/kf+k2jI58oXRMe9Oq
         NJLGZPbnoGzbOMfIOeCQVRJCCGh0qsHO8XONUyrVzT51qfWaSOa6402HvnHXSaep6Ock
         JD+hxGnnUIpA2RAY4HcIkdXzrWoYNJkOpixeRwd13h/qhuqGKbY5IeMELuYl6JOCQRzS
         OcZQ==
X-Gm-Message-State: AOAM530jszMsmJEqFmaKXx/Kubiy1DQWFG9qtSuc1ECxHGnKmO3aJvEA
        KOFPcSjJaQe5FGI0xApHLz0=
X-Google-Smtp-Source: ABdhPJz8WyWYoFwsoQMeCU3ssjLVOLt9VS4oUnytD2/OaWtFurLWyTtrhH5Pr8dODfpZCySuXm3Ejw==
X-Received: by 2002:a17:902:c78a:b0:13e:cac2:4b41 with SMTP id w10-20020a170902c78a00b0013ecac24b41mr3494570pla.17.1633412472703;
        Mon, 04 Oct 2021 22:41:12 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j12sm16719053pfj.206.2021.10.04.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:12 -0700 (PDT)
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
Date:   Mon,  4 Oct 2021 22:40:48 -0700
Message-Id: <20211005054059.475634-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
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

