Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F933EC576
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhHNVS7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhHNVSi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:18:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D3C0612AC;
        Sat, 14 Aug 2021 14:18:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u15so865452plg.13;
        Sat, 14 Aug 2021 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVk4rfFwKtI+nZlF1wG+Xa1jTWegY7TnqFeFUCsMRjo=;
        b=O59g2zYWLDAbW/HowGp96VnWY8nCocJKhRS1A7q0yWULedTf9hRnEPTBZjs9MyA+gK
         C9qOSVAnsdyUVlCwgHxRKmHTuD2LSNIk21r0wVfr0zMN4iE2Ngv79PR5V/2wJKC1Y86Z
         EePoYiPiMT7Bu0PRjrfQOm4yMPDzCMoHCBK3wOPlzSvCinmTxegd3JZHQCD5IoIXZf/e
         g2m+5HEh+1FI4MAjbrvGhnOsrqP57/iuwTB7Nd+kxORjNwTw4Bo95NQA7nw2lTdYTJ9K
         TBPyr8gBSpCkbyFGC/fYRz6h6Kure7a9V6mSIQUXN6OhK2hkNimK5iqHAOulS1dVlJKX
         5yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVk4rfFwKtI+nZlF1wG+Xa1jTWegY7TnqFeFUCsMRjo=;
        b=qrZ/UB9btJzKgy1lkyicR3fENj7lMcGoMYDoYV1OuVqRBTNV8zyI6x6vJBsfOwsEZU
         y8KWY7QxZq53OTlxiij/lLVOWsMjHiR131h557ToP+eZ39MagGj84g6IZ6YdtTlmF6H7
         JJiribWRtl8loIF0eM2jt6BcE56fwhrbtehs4QR+u+qUGFDAThDG0SXZ0Jh00Rm5DPFF
         zz4f25MGkJRSrHLdfaB/T2PXd1sKuo+hPoqV4ddpoOYnBC1z6gBdfFGqmbt+wTmBv12L
         4r82fD1BVyismJrWqXiowJ7VFRHPxLdrS2iuK701Y7XhCnj3Wj1AD9BN5HGAF2kA9M7w
         LQRA==
X-Gm-Message-State: AOAM530yO6pVZGWwgFYirK+17IzKEqkEooE7ADyHJqT5ahjFtxavrJL9
        1OIaDF2LbqutcWkQZRVNiD4=
X-Google-Smtp-Source: ABdhPJzURz0CmMkY+pgKxUckqz5ulzsVmX1l1qYfLzAiEcKI6nWqbuTL+f+grbfnWDsVUsQGI1/deA==
X-Received: by 2002:a63:f959:: with SMTP id q25mr8420380pgk.52.1628975886202;
        Sat, 14 Aug 2021 14:18:06 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id k197sm6575967pfd.190.2021.08.14.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:18:05 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 06/17] cpumask: use find_first_and_bit()
Date:   Sat, 14 Aug 2021 14:17:02 -0700
Message-Id: <20210814211713.180533-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
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
index f3689a52bfd0..4a03f6636e6c 100644
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

