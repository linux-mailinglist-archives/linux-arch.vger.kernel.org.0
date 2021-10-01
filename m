Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5A41F48A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355848AbhJASPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355761AbhJASOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA50C0613E4;
        Fri,  1 Oct 2021 11:13:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so4555257pfv.12;
        Fri, 01 Oct 2021 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQRHCblSluQbIpKux4YUTKcJ4EpZKx7DnMWO8vXdRIU=;
        b=JpJB8on8KCekNV6APNk79jaBTmAAXIMYyrv8jaOwxRMB7h8GF+3I5QZp77fkYBTOEk
         PAnYIrlNbI346YWFB0jHiNGHAHJKLgFu8yo4jPSPorX/FLAoDw5y5akQmblzzjKNMWur
         3SJyCsEYzTwY8CbLxqxLXnQg/8tkPZFEfRf8w26esAftDVjw05iN+BxYJVA4KVQxxrPb
         EM+WLSQmt6KlsyqHytXuXGrwx6OZlJHMuMAKhtt5wE0fQCWi8AAsnGy6IDK7NlIrPRJ4
         V/6J+Mn6yJWJGKlI4nlVkLwrO0L+3mvQWFBjcvZuHOPPUXDMv6di6hehpfBuKK9N6Wxg
         xA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQRHCblSluQbIpKux4YUTKcJ4EpZKx7DnMWO8vXdRIU=;
        b=2Mwq8NcA2nDVSYVHykPL2nR3k9oSpQQtYb8GG2xXTrF/eBMb7OZXh6tnvRm4A8k8R2
         Gy39xSCFGGoIX0nWnWYtPakAHMB3vmYxG3JcNsqyhb3Y5TRRcRSqJxlbZrODGL8Qc3R3
         Tah2CAwiYByxNBY6HlJqqDL9Jc7ZYO/A+q3j5mO7NSG9hjoZQQD29STTVG/PPQX0kvAG
         1tmkXMXGTJS47Dnb8hwAKfXLcLYqbnuooGQRGHxTIhuqThqVNFfA9qTWWtzR9sFASKe0
         jyknQ4ktu6lBT2zIzKHxu4HQtXOlrXSTFU6YO44+9RRUaCRuqWcoydqdRGQoHHdxSO3L
         Oj0Q==
X-Gm-Message-State: AOAM533DpDlhky3ud1jFMlAYBsLtrw68ESXsVbFhxSAg/4hcHMAlkk5m
        IUocHlhd5WPJcEYMbFXcYNs=
X-Google-Smtp-Source: ABdhPJymg4NsZq3tJG+1dEEgxkdiiZIuJNdUsgU+8t+z13Plr/rqUYI0RPW44NUkOqFp3tD8FcNCIA==
X-Received: by 2002:aa7:9e1c:0:b0:44b:b97a:12c2 with SMTP id y28-20020aa79e1c000000b0044bb97a12c2mr11558717pfq.71.1633111983954;
        Fri, 01 Oct 2021 11:13:03 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d19sm7020209pfn.102.2021.10.01.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:03 -0700 (PDT)
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
Subject: [PATCH 06/16] cpumask: use find_first_and_bit()
Date:   Fri,  1 Oct 2021 11:12:35 -0700
Message-Id: <20211001181245.228419-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now we have an efficient implementation for find_first_and_bit(),
so switch cpumask to use it where appropriate.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/cpumask.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1e7399fc69c0..c4e1b9ea0ba4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -123,6 +123,12 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
 	return 0;
 }
 
+static inline unsigned int cpumask_first_and(const struct cpumask *srcp1,
+					     const struct cpumask *srcp2)
+{
+	return 0;
+}
+
 static inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return 0;
@@ -167,7 +173,7 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 
 static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
 					     const struct cpumask *src2p) {
-	return cpumask_next_and(-1, src1p, src2p);
+	return cpumask_first_and(src1p, src2p);
 }
 
 static inline int cpumask_any_distribute(const struct cpumask *srcp)
@@ -195,6 +201,19 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
 	return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
+/**
+ * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
+ */
+static inline
+unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
+{
+	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
+}
+
 /**
  * cpumask_last - get the last CPU in a cpumask
  * @srcp:	- the cpumask pointer
@@ -585,15 +604,6 @@ static inline void cpumask_copy(struct cpumask *dstp,
  */
 #define cpumask_any(srcp) cpumask_first(srcp)
 
-/**
- * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
- * @src1p: the first input
- * @src2p: the second input
- *
- * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
- */
-#define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
-
 /**
  * cpumask_any_and - pick a "random" cpu from *mask1 & *mask2
  * @mask1: the first input cpumask
-- 
2.30.2

