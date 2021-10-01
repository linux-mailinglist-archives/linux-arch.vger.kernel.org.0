Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC241F4AA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355732AbhJASPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355762AbhJASPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:15:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43723C0613E4;
        Fri,  1 Oct 2021 11:13:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q23so8653634pfs.9;
        Fri, 01 Oct 2021 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9nPluaIygVrxAM46QxhfMM0ANd4//99PAUXWZ29x3A=;
        b=Hk1sxpFAcNvBISxDkT47tb6Ot94ETAL8XlgvxZMq63ic5Hc+uidm9nDadBFUiLPWP0
         0GyZ/1rV7nAdb5UtCDuQDsPn6cFIucbAcHp5IXaGIXniTHVrtx/cVxyUKDhysVnfTCJ+
         yDUVafBcGAHXwyT3gcGL87I17pnVg6BAKfJRP7ccMB66Zq9tOg3nsLG3Ja953Nw3eaW0
         BBy6I7K47GUb9elYvDvttRLhZOKdEDHPl7cU0zJOMgDaXrJ0UoliuZWMroE2UaFk/nDe
         lxVDB1JG8mFg1tT9EuyKZsX2cKk9DoBZ1SQ7kay78GCAcfzftlfLQb9y/yvPLGDVxrnc
         8w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9nPluaIygVrxAM46QxhfMM0ANd4//99PAUXWZ29x3A=;
        b=2zOIrYzYJhbLz0OrqFSpRUYiLRGeK+C98Qab1GO/zTIIAn+JBCNV7xEFNvUg5BH1th
         Agp4b04p4/rbsrviWA7F8+0E5zYgQxEFgDbL7EPBXZeNSaUTXrcwghWMVla0c6m6gi0a
         kEk2qFvbBTFW7+v6UyI72BZRBLiSY6CXQoZmDTjX0bZIgwq+ymBa3x7bwgTaGKCNWKFF
         jUDLGlPVuUja2iNUHTjcBcZNkLFDHlYgkcV20qEdWQ7p6mDhDJJsoqeMsT3FwK03sd74
         PxyVX+d9bRIycqRJLtlZDuRp2PmH58A9b7lS8eecRebfmKxoa6GZ2tW72w2uasYgZYss
         xkZg==
X-Gm-Message-State: AOAM532aNla1czUshUq1X+sLYacz/SUzO3xHv2tADKUazyCLPS7idZAa
        0JcjA3KidCiKfQ77hetInyNaJfZKZFg=
X-Google-Smtp-Source: ABdhPJzcGHE7Dv2IHtgTtm/gnyrsnRhvm3D/bEsoxkxAgwd/4PzhLvKycoqbwywrC+maGOD6cIhGQQ==
X-Received: by 2002:a63:4610:: with SMTP id t16mr10944433pga.176.1633111997754;
        Fri, 01 Oct 2021 11:13:17 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b20sm6969286pfp.26.2021.10.01.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:17 -0700 (PDT)
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
Subject: [PATCH 10/16] include/linux: move for_each_bit() macros from bitops.h to find.h
Date:   Fri,  1 Oct 2021 11:12:39 -0700
Message-Id: <20211001181245.228419-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

for_each_bit() macros depend on find_bit() machinery, and so the
proper place for them is the find.h header.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/bitops.h | 34 ----------------------------------
 include/linux/find.h   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5e62e2383b7f..7aaed501f768 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -32,40 +32,6 @@ extern unsigned long __sw_hweight64(__u64 w);
  */
 #include <asm/bitops.h>
 
-#define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size));		\
-	     (bit) < (size);					\
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-
-/* same as for_each_set_bit() but use bit as value to start with */
-#define for_each_set_bit_from(bit, addr, size) \
-	for ((bit) = find_next_bit((addr), (size), (bit));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-
-#define for_each_clear_bit(bit, addr, size) \
-	for ((bit) = find_first_zero_bit((addr), (size));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
-
-/* same as for_each_clear_bit() but use bit as value to start with */
-#define for_each_clear_bit_from(bit, addr, size) \
-	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
-	     (bit) < (size);					\
-	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
-
-/**
- * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
- * @start: bit offset to start search and to store the current iteration offset
- * @clump: location to store copy of current 8-bit clump
- * @bits: bitmap address to base the search on
- * @size: bitmap size in number of bits
- */
-#define for_each_set_clump8(start, clump, bits, size) \
-	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
-	     (start) < (size); \
-	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
-
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/include/linux/find.h b/include/linux/find.h
index 6048f8c97418..4500e8ab93e2 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -279,4 +279,38 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 #error "Please fix <asm/byteorder.h>"
 #endif
 
+#define for_each_set_bit(bit, addr, size) \
+	for ((bit) = find_first_bit((addr), (size));		\
+	     (bit) < (size);					\
+	     (bit) = find_next_bit((addr), (size), (bit) + 1))
+
+/* same as for_each_set_bit() but use bit as value to start with */
+#define for_each_set_bit_from(bit, addr, size) \
+	for ((bit) = find_next_bit((addr), (size), (bit));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_bit((addr), (size), (bit) + 1))
+
+#define for_each_clear_bit(bit, addr, size) \
+	for ((bit) = find_first_zero_bit((addr), (size));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+/* same as for_each_clear_bit() but use bit as value to start with */
+#define for_each_clear_bit_from(bit, addr, size) \
+	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+/**
+ * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
+
 #endif /*__LINUX_FIND_H_ */
-- 
2.30.2

