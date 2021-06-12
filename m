Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36E3A4EE3
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFLMkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:40:17 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:37454 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFLMkH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:40:07 -0400
Received: by mail-qv1-f46.google.com with SMTP id x6so13118389qvx.4;
        Sat, 12 Jun 2021 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGYip1TYwkBVOq/t4svj5wGlh/+ScwbEreTBrPkXi/s=;
        b=qwxBASDfdCZdFScmA/IVTIh3Wyvgvef/wR69EcmQD6bijDwtjo3RoOefxXv50wpFr9
         cPyg3bGdSldG8wwrypkfUO9DeImQWy3pa/WoW1Ad7AgPVgaHOykhTJP/sXqr+sO2m/1U
         s9gNXBFuSnfXF7aS4ZkCxRySwRuz25DHjQXlwyW1Xef8/4ygpr8jgpCbDJnUxwu8pHB3
         TzXjWBJG5L3nqu1VQtLSdy/zO1HduzZpzHFJ6efZ2TZn9H7J4UF82/zkVYf9EAofWwSx
         dhyj0shH+JrVz3p3jDU0UolboiyAWAw0oT9Tzxs2+J9PF+/vNK9gDKbW16VL0qBlWD2v
         trLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGYip1TYwkBVOq/t4svj5wGlh/+ScwbEreTBrPkXi/s=;
        b=fxNDVWgT9W7mWVOZ4bFCpH3a5DH6stHrEgeb0oI8PHzJRGQfY8GQ0Us4iozbyCsCAS
         NnVcLEias0uTAfBM2UAQyTFAizSVyX78etVlJmB2LeZsKKiEkPlqpnRlfIUxMkU+kP6B
         8syNaGpc+6GlgIQ538yrDn/WKKJ/Px12b3xn5zsBE6jxWlsLZeDHueYk/RC8kDWqZqkA
         c38dQqquXCANimyrS/UxpEx9yXKXNrZvEfsj0YPIA6qUjMmhnGr3VOv8lcClUsjtD2Bq
         j4Kd9fPyWaCA2GEvsC8KEf2hAx8MM2COA4ZjZKsgtOUWh16QMynVDBCSgxowb89a+4Nz
         elVA==
X-Gm-Message-State: AOAM5321YcZCsVAjdOkGfBA0VPCPqDZwziwtMrq+vCb35V+6AHEU4rtC
        E7NoNAjf7dg4JCO8CobkXW8K+XG2OUaD5Q==
X-Google-Smtp-Source: ABdhPJzcPXTmnQZ+0XckFTqbklKl+XY0/0UrTwtbheT2/LYqSuNqs6KgCcjV6LbpL4IZnsvMlB9KkQ==
X-Received: by 2002:a05:6214:1909:: with SMTP id er9mr9371442qvb.13.1623501411544;
        Sat, 12 Jun 2021 05:36:51 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id f130sm6434285qke.37.2021.06.12.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:51 -0700 (PDT)
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
Subject: [PATCH 6/8] cpumask: use find_first_and_bit()
Date:   Sat, 12 Jun 2021 05:36:37 -0700
Message-Id: <20210612123639.329047-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now we have an efficient implementation for find_first_and_bit(),
so switch cpumask to use it where appropriate.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bfc4690de4f4..6bee58600946 100644
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

