Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A3421E3E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhJEFoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhJEFnY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE5C061786;
        Mon,  4 Oct 2021 22:41:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u7so16389495pfg.13;
        Mon, 04 Oct 2021 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9nPluaIygVrxAM46QxhfMM0ANd4//99PAUXWZ29x3A=;
        b=ZnfcQu7W0sA+iHxVOf++U/MTFN8VM5oN0Hez5QOh7+ny6emw+OAhT8tQVhR/C3P+4+
         TVhcgRJDLmUpnn9MXFal//LhQaYmO4PIgNdGrpYssl/iOFt9AiF+7g/79sTxOQUJug1D
         0zb1WDbT2z4J1BDi4GMVZ91KNMm1kXNwWnGIEGTPApYn/68dKPAHDvLJeFg2j/vJMckk
         b+Lnu+MVpcO0+/SwbfbmANbNWZzYLjBAzetfHyx795JjyJ2b0AC/1oVd6iBzXQfMQJye
         ztpMc9Boio0Ks9oqnqlSOLh4F4xGhpRAt/7nKHVoMCipJ/zmQ/d2IS+BolLHUr0PvPZe
         0zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9nPluaIygVrxAM46QxhfMM0ANd4//99PAUXWZ29x3A=;
        b=xmsuzmnw2jscDeb4hJN013mqGRV99beiPdbzK2S4gU0xz/DAkClq8lucwQi4f7tiFe
         Ul2EDm47BUG53wrjwDo5drvRY5NDXLFmllxZCRJ541G/DdDHeAWkxE5InsaNrP/vdAdP
         6AbrcwnNr5SpsEH2Q34Tyau1XW34y+OVWSWxWPBEgi34bsb2uRvfktzNm7CGvr4gxJFK
         vjX6BuopXxbl4TwE/IpoISXzMJkogGp3dhXCfy+RwEWt/onXn/Mj2baUTbNoalhIyfsv
         XPU4qnUa8AIQygmGhA9JDRCuWPDomHTJpbsxiXiB7Sb0wtJKk0TQTk2tliLIpxnyfjc7
         rb2A==
X-Gm-Message-State: AOAM531GVXKkfkdlrE/X2xJKaQl3jQLQeIjp5CQ7iabaGz5808a9uQMI
        PB1t36KFxtkJ122e2aukXbY=
X-Google-Smtp-Source: ABdhPJz9Y/BWEVUgHcP1FR/crduh996vCoQAuFnQD5sdS7/wiP35B9flW1N+clMqcvTh7OS8VyhIxg==
X-Received: by 2002:a63:da49:: with SMTP id l9mr13958792pgj.277.1633412488925;
        Mon, 04 Oct 2021 22:41:28 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z4sm16714009pfz.99.2021.10.04.22.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:28 -0700 (PDT)
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
Date:   Mon,  4 Oct 2021 22:40:53 -0700
Message-Id: <20211005054059.475634-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
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

