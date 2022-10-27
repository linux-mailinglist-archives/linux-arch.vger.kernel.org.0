Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFA60EF1A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 06:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiJ0EiZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 00:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiJ0EiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 00:38:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E214C525;
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so373712qto.3;
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z82YBLhaDf3VVRR+1KtfyF0eqkqAo5/CJFY1HjdHvl0=;
        b=V3pQIFvH1iXGqin3GYjH5b6IaAPfwSgAqGETYH2MkzIhPTIKr1/gl6/QhaUpJEwcaz
         vk4umLQYqlZqe6GUl7eV4D8CIobBXy+ULmHCq6L1IYe2M1axXU8QTldK8QSQVSJv+VjX
         IBT1SihR0nOr4zop4hEQVdl+BHHrNgtZAMBu/8ybKiVMDYuH6oHf7LQOICL2bFzymbfP
         qv/K6PeCHr2gcE20xMhM6CjP8qdm2RQUEMqkCq6Aym/IHnOyEUxUGhUNevOr5mV4UW6F
         qVwDKOBUQM+FIEASaZnoJphXxyDKmLlNrDs5yQ1wgDOM9KH5x3gYmF0ABkGHQxAnr006
         aPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z82YBLhaDf3VVRR+1KtfyF0eqkqAo5/CJFY1HjdHvl0=;
        b=XB650NMZC2fv1ThMDV0ep/0Fili2VOIwQo27qSU+T6Ze5Clpj7cxIXIwkHKqySP0q+
         P1c5yQsY2AyArlVUZx/0zo/p2e+iLndNtPZMZ6iiSi0OY2urCVzLq3bGLO+/6RG5UeCe
         jkCeu7r/M/m8PQJJucOqo6t+MLTpcZUXwrzJHzVfyEuyOqJG98H0XdcUCaS4L4VtCZ7O
         b5a0I+yby5EordvUzTGkp7ii3hpXjfJlyXw59xq7OpgYfwKl/+qFfZoXC6r8WxmvWPnn
         9AK32bx1f64u/p/SBKEKS6UTLJ4OMVDEUwkTsmyD74R93bWNagaAV9Jc1AUmLHg75fs0
         50Og==
X-Gm-Message-State: ACrzQf3BbytgvxE77Lsw43VPoCb8AyZsm82cO4PslDXH0pEWffsRJGKg
        PALK+675g0FDn5x+YY2rMYqPL4HgG7g=
X-Google-Smtp-Source: AMsMyM5aVk/PNwGA1wAuf/6a+MZeIJ/mzjfI9rmQkWjPkz6JaF53THDGBGMeQFvK3l3dIxEncYDGmg==
X-Received: by 2002:ac8:57c5:0:b0:39a:6512:6e3e with SMTP id w5-20020ac857c5000000b0039a65126e3emr40331087qta.334.1666845494658;
        Wed, 26 Oct 2022 21:38:14 -0700 (PDT)
Received: from localhost ([2601:589:4102:7400:ade5:9c32:44f6:bc7d])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006eed75805a2sm300913qkg.126.2022.10.26.21.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:38:14 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
Date:   Wed, 26 Oct 2022 21:38:08 -0700
Message-Id: <20221027043810.350460-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027043810.350460-1-yury.norov@gmail.com>
References: <20221027043810.350460-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'inline' keyword is only a recommendation for compiler. If it decides to
not inline bitmap, find_bit, cpumask or nodemask functions, the whole
small_const_nbits() machinery doesn't work.

This is how a standard GCC 11.3.0 does for my x86_64 build now. This patch
replaces 'inline' directive with unconditional '__always_inline' to make
sure that there's always a chance for compile-time optimization. It doesn't
change size of kernel image, according to bloat-o-meter.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h   |  46 ++++++-------
 include/linux/cpumask.h  | 144 +++++++++++++++++++--------------------
 include/linux/find.h     |  40 +++++------
 include/linux/nodemask.h |  86 +++++++++++------------
 4 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7d6d73b78147..40e53a2ecc0d 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -189,7 +189,7 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
  * the bit offset of all zero areas this function finds is multiples of that
  * power of 2. A @align_mask of 0 means no alignment is required.
  */
-static inline unsigned long
+static __always_inline unsigned long
 bitmap_find_next_zero_area(unsigned long *map,
 			   unsigned long size,
 			   unsigned long start,
@@ -237,7 +237,7 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
-static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
+static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
 
@@ -247,7 +247,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0, len);
 }
 
-static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
+static __always_inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
 
@@ -257,7 +257,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 }
 
-static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
+static __always_inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
@@ -271,7 +271,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 /*
  * Copy bitmap and clear tail bits in last word.
  */
-static inline void bitmap_copy_clear_tail(unsigned long *dst,
+static __always_inline void bitmap_copy_clear_tail(unsigned long *dst,
 		const unsigned long *src, unsigned int nbits)
 {
 	bitmap_copy(dst, src, nbits);
@@ -317,7 +317,7 @@ void bitmap_to_arr64(u64 *buf, const unsigned long *bitmap, unsigned int nbits);
 	bitmap_copy_clear_tail((unsigned long *)(buf), (const unsigned long *)(bitmap), (nbits))
 #endif
 
-static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
+static __always_inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -325,7 +325,7 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
+static __always_inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -334,7 +334,7 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
+static __always_inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -343,7 +343,7 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		__bitmap_xor(dst, src1, src2, nbits);
 }
 
-static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+static __always_inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -351,7 +351,7 @@ static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 	return __bitmap_andnot(dst, src1, src2, nbits);
 }
 
-static inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
+static __always_inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -367,7 +367,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline bool bitmap_equal(const unsigned long *src1,
+static __always_inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -387,7 +387,7 @@ static inline bool bitmap_equal(const unsigned long *src1,
  *
  * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
  */
-static inline bool bitmap_or_equal(const unsigned long *src1,
+static __always_inline bool bitmap_or_equal(const unsigned long *src1,
 				   const unsigned long *src2,
 				   const unsigned long *src3,
 				   unsigned int nbits)
@@ -398,7 +398,7 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
 }
 
-static inline bool bitmap_intersects(const unsigned long *src1,
+static __always_inline bool bitmap_intersects(const unsigned long *src1,
 				     const unsigned long *src2,
 				     unsigned int nbits)
 {
@@ -408,7 +408,7 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline bool bitmap_subset(const unsigned long *src1,
+static __always_inline bool bitmap_subset(const unsigned long *src1,
 				 const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -417,7 +417,7 @@ static inline bool bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
+static __always_inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -425,7 +425,7 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 	return find_first_bit(src, nbits) == nbits;
 }
 
-static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
+static __always_inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
@@ -482,7 +482,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		__bitmap_clear(map, start, nbits);
 }
 
-static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
+static __always_inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -491,7 +491,7 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 		__bitmap_shift_right(dst, src, shift, nbits);
 }
 
-static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
+static __always_inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -500,7 +500,7 @@ static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *sr
 		__bitmap_shift_left(dst, src, shift, nbits);
 }
 
-static inline void bitmap_replace(unsigned long *dst,
+static __always_inline void bitmap_replace(unsigned long *dst,
 				  const unsigned long *old,
 				  const unsigned long *new,
 				  const unsigned long *mask,
@@ -512,7 +512,7 @@ static inline void bitmap_replace(unsigned long *dst,
 		__bitmap_replace(dst, old, new, mask, nbits);
 }
 
-static inline void bitmap_next_set_region(unsigned long *bitmap,
+static __always_inline void bitmap_next_set_region(unsigned long *bitmap,
 					  unsigned int *rs, unsigned int *re,
 					  unsigned int end)
 {
@@ -563,7 +563,7 @@ static inline void bitmap_next_set_region(unsigned long *bitmap,
  * That is ``(u32 *)(&val)[0]`` gets the upper 32 bits,
  * but we expect the lower 32-bits of u64.
  */
-static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
+static __always_inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 {
 	bitmap_from_arr64(dst, &mask, 64);
 }
@@ -576,7 +576,7 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
  * Returns the 8-bit value located at the @start bit offset within the @src
  * memory region.
  */
-static inline unsigned long bitmap_get_value8(const unsigned long *map,
+static __always_inline unsigned long bitmap_get_value8(const unsigned long *map,
 					      unsigned long start)
 {
 	const size_t index = BIT_WORD(start);
@@ -591,7 +591,7 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
  * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
  * @start: bit offset of the 8-bit value; must be a multiple of 8
  */
-static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
+static __always_inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 				     unsigned long start)
 {
 	const size_t index = BIT_WORD(start);
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index c2aa0aa26b45..9543b22d6dc2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -41,7 +41,7 @@ typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
 extern unsigned int nr_cpu_ids;
 #endif
 
-static inline void set_nr_cpu_ids(unsigned int nr)
+static __always_inline void set_nr_cpu_ids(unsigned int nr)
 {
 #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
 	WARN_ON(nr != nr_cpu_ids);
@@ -124,7 +124,7 @@ static __always_inline unsigned int cpumask_check(unsigned int cpu)
  *
  * Returns >= nr_cpu_ids if no cpus set.
  */
-static inline unsigned int cpumask_first(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_first(const struct cpumask *srcp)
 {
 	return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -135,7 +135,7 @@ static inline unsigned int cpumask_first(const struct cpumask *srcp)
  *
  * Returns >= nr_cpu_ids if all cpus are set.
  */
-static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
 {
 	return find_first_zero_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -147,7 +147,7 @@ static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
  *
  * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
  */
-static inline
+static __always_inline
 unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask *srcp2)
 {
 	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
@@ -159,7 +159,7 @@ unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct cpumask
  *
  * Returns	>= nr_cpumask_bits if no CPUs set.
  */
-static inline unsigned int cpumask_last(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_last(const struct cpumask *srcp)
 {
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -171,7 +171,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
  *
  * Returns >= nr_cpu_ids if no further cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_next(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
@@ -187,7 +187,7 @@ unsigned int cpumask_next(int n, const struct cpumask *srcp)
  *
  * Returns >= nr_cpu_ids if no further cpus unset.
  */
-static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 {
 	/* -1 is a legal arg here. */
 	if (n != -1)
@@ -197,18 +197,18 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 
 #if NR_CPUS == 1
 /* Uniprocessor: there is only one valid CPU */
-static inline unsigned int cpumask_local_spread(unsigned int i, int node)
+static __always_inline unsigned int cpumask_local_spread(unsigned int i, int node)
 {
 	return 0;
 }
 
-static inline unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
+static __always_inline unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
 						      const struct cpumask *src2p)
 {
 	return cpumask_first_and(src1p, src2p);
 }
 
-static inline unsigned int cpumask_any_distribute(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 {
 	return cpumask_first(srcp);
 }
@@ -227,7 +227,7 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
  *
  * Returns >= nr_cpu_ids if no further cpus set in both.
  */
-static inline
+static __always_inline
 unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		     const struct cpumask *src2p)
 {
@@ -259,7 +259,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 	for_each_clear_bit(cpu, cpumask_bits(mask), nr_cpumask_bits)
 
 #if NR_CPUS == 1
-static inline
+static __always_inline
 unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
@@ -335,7 +335,7 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
  * Often used to find any cpu but smp_processor_id() in a mask.
  * Returns >= nr_cpu_ids if no cpus set.
  */
-static inline
+static __always_inline
 unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 {
 	unsigned int i;
@@ -354,7 +354,7 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
  *
  * Returns >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
 {
 	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, cpumask_check(cpu));
 }
@@ -367,7 +367,7 @@ static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *s
  *
  * Returns >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -383,7 +383,7 @@ unsigned int cpumask_nth_and(unsigned int cpu, const struct cpumask *srcp1,
  *
  * Returns >= nr_cpu_ids if such cpu doesn't exist.
  */
-static inline
+static __always_inline
 unsigned int cpumask_nth_andnot(unsigned int cpu, const struct cpumask *srcp1,
 							const struct cpumask *srcp2)
 {
@@ -476,7 +476,7 @@ static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *
  * cpumask_setall - set all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_setall(struct cpumask *dstp)
+static __always_inline void cpumask_setall(struct cpumask *dstp)
 {
 	bitmap_fill(cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -485,7 +485,7 @@ static inline void cpumask_setall(struct cpumask *dstp)
  * cpumask_clear - clear all cpus (< nr_cpu_ids) in a cpumask
  * @dstp: the cpumask pointer
  */
-static inline void cpumask_clear(struct cpumask *dstp)
+static __always_inline void cpumask_clear(struct cpumask *dstp)
 {
 	bitmap_zero(cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -498,7 +498,7 @@ static inline void cpumask_clear(struct cpumask *dstp)
  *
  * If *@dstp is empty, returns false, else returns true
  */
-static inline bool cpumask_and(struct cpumask *dstp,
+static __always_inline bool cpumask_and(struct cpumask *dstp,
 			       const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
@@ -512,7 +512,7 @@ static inline bool cpumask_and(struct cpumask *dstp,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
+static __always_inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
 			      const struct cpumask *src2p)
 {
 	bitmap_or(cpumask_bits(dstp), cpumask_bits(src1p),
@@ -525,7 +525,7 @@ static inline void cpumask_or(struct cpumask *dstp, const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline void cpumask_xor(struct cpumask *dstp,
+static __always_inline void cpumask_xor(struct cpumask *dstp,
 			       const struct cpumask *src1p,
 			       const struct cpumask *src2p)
 {
@@ -541,7 +541,7 @@ static inline void cpumask_xor(struct cpumask *dstp,
  *
  * If *@dstp is empty, returns false, else returns true
  */
-static inline bool cpumask_andnot(struct cpumask *dstp,
+static __always_inline bool cpumask_andnot(struct cpumask *dstp,
 				  const struct cpumask *src1p,
 				  const struct cpumask *src2p)
 {
@@ -554,7 +554,7 @@ static inline bool cpumask_andnot(struct cpumask *dstp,
  * @dstp: the cpumask result
  * @srcp: the input to invert
  */
-static inline void cpumask_complement(struct cpumask *dstp,
+static __always_inline void cpumask_complement(struct cpumask *dstp,
 				      const struct cpumask *srcp)
 {
 	bitmap_complement(cpumask_bits(dstp), cpumask_bits(srcp),
@@ -566,7 +566,7 @@ static inline void cpumask_complement(struct cpumask *dstp,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline bool cpumask_equal(const struct cpumask *src1p,
+static __always_inline bool cpumask_equal(const struct cpumask *src1p,
 				const struct cpumask *src2p)
 {
 	return bitmap_equal(cpumask_bits(src1p), cpumask_bits(src2p),
@@ -579,7 +579,7 @@ static inline bool cpumask_equal(const struct cpumask *src1p,
  * @src2p: the second input
  * @src3p: the third input
  */
-static inline bool cpumask_or_equal(const struct cpumask *src1p,
+static __always_inline bool cpumask_or_equal(const struct cpumask *src1p,
 				    const struct cpumask *src2p,
 				    const struct cpumask *src3p)
 {
@@ -592,7 +592,7 @@ static inline bool cpumask_or_equal(const struct cpumask *src1p,
  * @src1p: the first input
  * @src2p: the second input
  */
-static inline bool cpumask_intersects(const struct cpumask *src1p,
+static __always_inline bool cpumask_intersects(const struct cpumask *src1p,
 				     const struct cpumask *src2p)
 {
 	return bitmap_intersects(cpumask_bits(src1p), cpumask_bits(src2p),
@@ -606,7 +606,7 @@ static inline bool cpumask_intersects(const struct cpumask *src1p,
  *
  * Returns true if *@src1p is a subset of *@src2p, else returns false
  */
-static inline bool cpumask_subset(const struct cpumask *src1p,
+static __always_inline bool cpumask_subset(const struct cpumask *src1p,
 				 const struct cpumask *src2p)
 {
 	return bitmap_subset(cpumask_bits(src1p), cpumask_bits(src2p),
@@ -617,7 +617,7 @@ static inline bool cpumask_subset(const struct cpumask *src1p,
  * cpumask_empty - *srcp == 0
  * @srcp: the cpumask to that all cpus < nr_cpu_ids are clear.
  */
-static inline bool cpumask_empty(const struct cpumask *srcp)
+static __always_inline bool cpumask_empty(const struct cpumask *srcp)
 {
 	return bitmap_empty(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -626,7 +626,7 @@ static inline bool cpumask_empty(const struct cpumask *srcp)
  * cpumask_full - *srcp == 0xFFFFFFFF...
  * @srcp: the cpumask to that all cpus < nr_cpu_ids are set.
  */
-static inline bool cpumask_full(const struct cpumask *srcp)
+static __always_inline bool cpumask_full(const struct cpumask *srcp)
 {
 	return bitmap_full(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -635,7 +635,7 @@ static inline bool cpumask_full(const struct cpumask *srcp)
  * cpumask_weight - Count of bits in *srcp
  * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
  */
-static inline unsigned int cpumask_weight(const struct cpumask *srcp)
+static __always_inline unsigned int cpumask_weight(const struct cpumask *srcp)
 {
 	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
 }
@@ -645,7 +645,7 @@ static inline unsigned int cpumask_weight(const struct cpumask *srcp)
  * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
  * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
  */
-static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
+static __always_inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
 						const struct cpumask *srcp2)
 {
 	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cpumask_bits);
@@ -657,7 +657,7 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
  * @srcp: the input to shift
  * @n: the number of bits to shift by
  */
-static inline void cpumask_shift_right(struct cpumask *dstp,
+static __always_inline void cpumask_shift_right(struct cpumask *dstp,
 				       const struct cpumask *srcp, int n)
 {
 	bitmap_shift_right(cpumask_bits(dstp), cpumask_bits(srcp), n,
@@ -670,7 +670,7 @@ static inline void cpumask_shift_right(struct cpumask *dstp,
  * @srcp: the input to shift
  * @n: the number of bits to shift by
  */
-static inline void cpumask_shift_left(struct cpumask *dstp,
+static __always_inline void cpumask_shift_left(struct cpumask *dstp,
 				      const struct cpumask *srcp, int n)
 {
 	bitmap_shift_left(cpumask_bits(dstp), cpumask_bits(srcp), n,
@@ -682,7 +682,7 @@ static inline void cpumask_shift_left(struct cpumask *dstp,
  * @dstp: the result
  * @srcp: the input cpumask
  */
-static inline void cpumask_copy(struct cpumask *dstp,
+static __always_inline void cpumask_copy(struct cpumask *dstp,
 				const struct cpumask *srcp)
 {
 	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), nr_cpumask_bits);
@@ -719,7 +719,7 @@ static inline void cpumask_copy(struct cpumask *dstp,
  *
  * Returns -errno, or 0 for success.
  */
-static inline int cpumask_parse_user(const char __user *buf, int len,
+static __always_inline int cpumask_parse_user(const char __user *buf, int len,
 				     struct cpumask *dstp)
 {
 	return bitmap_parse_user(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
@@ -733,7 +733,7 @@ static inline int cpumask_parse_user(const char __user *buf, int len,
  *
  * Returns -errno, or 0 for success.
  */
-static inline int cpumask_parselist_user(const char __user *buf, int len,
+static __always_inline int cpumask_parselist_user(const char __user *buf, int len,
 				     struct cpumask *dstp)
 {
 	return bitmap_parselist_user(buf, len, cpumask_bits(dstp),
@@ -747,7 +747,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  *
  * Returns -errno, or 0 for success.
  */
-static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -759,7 +759,7 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
  *
  * Returns -errno, or 0 for success.
  */
-static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
+static __always_inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
@@ -767,7 +767,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 /**
  * cpumask_size - size to allocate for a 'struct cpumask' in bytes
  */
-static inline unsigned int cpumask_size(void)
+static __always_inline unsigned int cpumask_size(void)
 {
 	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
 }
@@ -820,7 +820,7 @@ typedef struct cpumask *cpumask_var_t;
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
-static inline
+static __always_inline
 bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
 	return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
@@ -836,13 +836,13 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
  *
  * See alloc_cpumask_var_node.
  */
-static inline
+static __always_inline
 bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
 }
 
-static inline
+static __always_inline
 bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return alloc_cpumask_var(mask, flags | __GFP_ZERO);
@@ -852,7 +852,7 @@ void alloc_bootmem_cpumask_var(cpumask_var_t *mask);
 void free_cpumask_var(cpumask_var_t mask);
 void free_bootmem_cpumask_var(cpumask_var_t mask);
 
-static inline bool cpumask_available(cpumask_var_t mask)
+static __always_inline bool cpumask_available(cpumask_var_t mask)
 {
 	return mask != NULL;
 }
@@ -863,43 +863,43 @@ typedef struct cpumask cpumask_var_t[1];
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
 
-static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return true;
 }
 
-static inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
+static __always_inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
 					  int node)
 {
 	return true;
 }
 
-static inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
+static __always_inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	cpumask_clear(*mask);
 	return true;
 }
 
-static inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
+static __always_inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
 					  int node)
 {
 	cpumask_clear(*mask);
 	return true;
 }
 
-static inline void alloc_bootmem_cpumask_var(cpumask_var_t *mask)
+static __always_inline void alloc_bootmem_cpumask_var(cpumask_var_t *mask)
 {
 }
 
-static inline void free_cpumask_var(cpumask_var_t mask)
+static __always_inline void free_cpumask_var(cpumask_var_t mask)
 {
 }
 
-static inline void free_bootmem_cpumask_var(cpumask_var_t mask)
+static __always_inline void free_bootmem_cpumask_var(cpumask_var_t mask)
 {
 }
 
-static inline bool cpumask_available(cpumask_var_t mask)
+static __always_inline bool cpumask_available(cpumask_var_t mask)
 {
 	return true;
 }
@@ -929,12 +929,12 @@ void init_cpu_present(const struct cpumask *src);
 void init_cpu_possible(const struct cpumask *src);
 void init_cpu_online(const struct cpumask *src);
 
-static inline void reset_cpu_possible_mask(void)
+static __always_inline void reset_cpu_possible_mask(void)
 {
 	bitmap_zero(cpumask_bits(&__cpu_possible_mask), NR_CPUS);
 }
 
-static inline void
+static __always_inline void
 set_cpu_possible(unsigned int cpu, bool possible)
 {
 	if (possible)
@@ -943,7 +943,7 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
 	if (present)
@@ -954,7 +954,7 @@ set_cpu_present(unsigned int cpu, bool present)
 
 void set_cpu_online(unsigned int cpu, bool online);
 
-static inline void
+static __always_inline void
 set_cpu_active(unsigned int cpu, bool active)
 {
 	if (active)
@@ -963,7 +963,7 @@ set_cpu_active(unsigned int cpu, bool active)
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
-static inline void
+static __always_inline void
 set_cpu_dying(unsigned int cpu, bool dying)
 {
 	if (dying)
@@ -986,7 +986,7 @@ set_cpu_dying(unsigned int cpu, bool dying)
 	((struct cpumask *)(1 ? (bitmap)				\
 			    : (void *)sizeof(__check_is_bitmap(bitmap))))
 
-static inline int __check_is_bitmap(const unsigned long *bitmap)
+static __always_inline int __check_is_bitmap(const unsigned long *bitmap)
 {
 	return 1;
 }
@@ -1001,7 +1001,7 @@ static inline int __check_is_bitmap(const unsigned long *bitmap)
 extern const unsigned long
 	cpu_bit_bitmap[BITS_PER_LONG+1][BITS_TO_LONGS(NR_CPUS)];
 
-static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
+static __always_inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 {
 	const unsigned long *p = cpu_bit_bitmap[1 + cpu % BITS_PER_LONG];
 	p -= cpu / BITS_PER_LONG;
@@ -1017,7 +1017,7 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
  * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
  * region.
  */
-static inline unsigned int num_online_cpus(void)
+static __always_inline unsigned int num_online_cpus(void)
 {
 	return atomic_read(&__num_online_cpus);
 }
@@ -1025,27 +1025,27 @@ static inline unsigned int num_online_cpus(void)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
-static inline bool cpu_online(unsigned int cpu)
+static __always_inline bool cpu_online(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
 
-static inline bool cpu_possible(unsigned int cpu)
+static __always_inline bool cpu_possible(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_possible_mask);
 }
 
-static inline bool cpu_present(unsigned int cpu)
+static __always_inline bool cpu_present(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_present_mask);
 }
 
-static inline bool cpu_active(unsigned int cpu)
+static __always_inline bool cpu_active(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
-static inline bool cpu_dying(unsigned int cpu)
+static __always_inline bool cpu_dying(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_dying_mask);
 }
@@ -1057,27 +1057,27 @@ static inline bool cpu_dying(unsigned int cpu)
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
 
-static inline bool cpu_online(unsigned int cpu)
+static __always_inline bool cpu_online(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_possible(unsigned int cpu)
+static __always_inline bool cpu_possible(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_present(unsigned int cpu)
+static __always_inline bool cpu_present(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_active(unsigned int cpu)
+static __always_inline bool cpu_active(unsigned int cpu)
 {
 	return cpu == 0;
 }
 
-static inline bool cpu_dying(unsigned int cpu)
+static __always_inline bool cpu_dying(unsigned int cpu)
 {
 	return false;
 }
@@ -1111,7 +1111,7 @@ static inline bool cpu_dying(unsigned int cpu)
  * Returns the length of the (null-terminated) @buf string, zero if
  * nothing is copied.
  */
-static inline ssize_t
+static __always_inline ssize_t
 cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 {
 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
@@ -1134,7 +1134,7 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
  * Returns the length of how many bytes have been copied, excluding
  * terminating '\0'.
  */
-static inline ssize_t
+static __always_inline ssize_t
 cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
 		loff_t off, size_t count)
 {
@@ -1149,7 +1149,7 @@ cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
  * Everything is same with the above cpumap_print_bitmask_to_buf()
  * except the print format.
  */
-static inline ssize_t
+static __always_inline ssize_t
 cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
 		loff_t off, size_t count)
 {
diff --git a/include/linux/find.h b/include/linux/find.h
index ccaf61a0f5fd..db2f2851601d 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -45,7 +45,7 @@ unsigned long _find_next_bit_le(const unsigned long *addr, unsigned
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
@@ -74,7 +74,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -105,7 +105,7 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
@@ -134,7 +134,7 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
@@ -161,7 +161,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -187,7 +187,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
 {
 	if (n >= size)
@@ -212,7 +212,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -239,7 +239,7 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
  * Returns the bit number of the N'th set bit.
  * If no such, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 				unsigned long size, unsigned long n)
 {
@@ -265,7 +265,7 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_and_bit(const unsigned long *addr1,
 				 const unsigned long *addr2,
 				 unsigned long size)
@@ -289,7 +289,7 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -310,7 +310,7 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
  *
  * Returns the bit number of the last set bit, or size.
  */
-static inline
+static __always_inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -333,7 +333,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
 					const unsigned long *addr2,
 					unsigned long size, unsigned long offset)
@@ -356,7 +356,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
  * Returns the bit number for the next set bit, or first set bit up to @offset
  * If no bits are set, returns @size.
  */
-static inline
+static __always_inline
 unsigned long find_next_bit_wrap(const unsigned long *addr,
 					unsigned long size, unsigned long offset)
 {
@@ -373,7 +373,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
  * Helper for for_each_set_bit_wrap(). Make sure you're doing right thing
  * before using it alone.
  */
-static inline
+static __always_inline
 unsigned long __for_each_wrap(const unsigned long *bitmap, unsigned long size,
 				 unsigned long start, unsigned long n)
 {
@@ -414,19 +414,19 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 
 #if defined(__LITTLE_ENDIAN)
 
-static inline unsigned long find_next_zero_bit_le(const void *addr,
+static __always_inline unsigned long find_next_zero_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
 	return find_next_zero_bit(addr, size, offset);
 }
 
-static inline unsigned long find_next_bit_le(const void *addr,
+static __always_inline unsigned long find_next_bit_le(const void *addr,
 		unsigned long size, unsigned long offset)
 {
 	return find_next_bit(addr, size, offset);
 }
 
-static inline unsigned long find_first_zero_bit_le(const void *addr,
+static __always_inline unsigned long find_first_zero_bit_le(const void *addr,
 		unsigned long size)
 {
 	return find_first_zero_bit(addr, size);
@@ -435,7 +435,7 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 #elif defined(__BIG_ENDIAN)
 
 #ifndef find_next_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
@@ -454,7 +454,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 #endif
 
 #ifndef find_first_zero_bit_le
-static inline
+static __always_inline
 unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
@@ -468,7 +468,7 @@ unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 #endif
 
 #ifndef find_next_bit_le
-static inline
+static __always_inline
 unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index efef68c9352a..4e7e7ae9dd11 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -107,11 +107,11 @@ extern nodemask_t _unused_nodemask_arg_;
  */
 #define nodemask_pr_args(maskp)	__nodemask_pr_numnodes(maskp), \
 				__nodemask_pr_bits(maskp)
-static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
+static __always_inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
 	return m ? MAX_NUMNODES : 0;
 }
-static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
+static __always_inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
 	return m ? m->bits : NULL;
 }
@@ -132,19 +132,19 @@ static __always_inline void __node_set(int node, volatile nodemask_t *dstp)
 }
 
 #define node_clear(node, dst) __node_clear((node), &(dst))
-static inline void __node_clear(int node, volatile nodemask_t *dstp)
+static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
 {
 	clear_bit(node, dstp->bits);
 }
 
 #define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
-static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_fill(dstp->bits, nbits);
 }
 
 #define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
-static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
+static __always_inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_zero(dstp->bits, nbits);
 }
@@ -154,14 +154,14 @@ static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 
 #define node_test_and_set(node, nodemask) \
 			__node_test_and_set((node), &(nodemask))
-static inline bool __node_test_and_set(int node, nodemask_t *addr)
+static __always_inline bool __node_test_and_set(int node, nodemask_t *addr)
 {
 	return test_and_set_bit(node, addr->bits);
 }
 
 #define nodes_and(dst, src1, src2) \
 			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -169,7 +169,7 @@ static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_or(dst, src1, src2) \
 			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -177,7 +177,7 @@ static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_xor(dst, src1, src2) \
 			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -185,7 +185,7 @@ static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_andnot(dst, src1, src2) \
 			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
-static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
+static __always_inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
@@ -193,7 +193,7 @@ static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 
 #define nodes_complement(dst, src) \
 			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
-static inline void __nodes_complement(nodemask_t *dstp,
+static __always_inline void __nodes_complement(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
 	bitmap_complement(dstp->bits, srcp->bits, nbits);
@@ -201,7 +201,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 
 #define nodes_equal(src1, src2) \
 			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_equal(const nodemask_t *src1p,
+static __always_inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_equal(src1p->bits, src2p->bits, nbits);
@@ -209,7 +209,7 @@ static inline bool __nodes_equal(const nodemask_t *src1p,
 
 #define nodes_intersects(src1, src2) \
 			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_intersects(const nodemask_t *src1p,
+static __always_inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
@@ -217,33 +217,33 @@ static inline bool __nodes_intersects(const nodemask_t *src1p,
 
 #define nodes_subset(src1, src2) \
 			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
-static inline bool __nodes_subset(const nodemask_t *src1p,
+static __always_inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
 #define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
-static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
 #define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
-static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
 
 #define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
-static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
+static __always_inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_weight(srcp->bits, nbits);
 }
 
 #define nodes_shift_right(dst, src, n) \
 			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_right(nodemask_t *dstp,
+static __always_inline void __nodes_shift_right(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
@@ -251,7 +251,7 @@ static inline void __nodes_shift_right(nodemask_t *dstp,
 
 #define nodes_shift_left(dst, src, n) \
 			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
-static inline void __nodes_shift_left(nodemask_t *dstp,
+static __always_inline void __nodes_shift_left(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
 	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
@@ -261,13 +261,13 @@ static inline void __nodes_shift_left(nodemask_t *dstp,
           > MAX_NUMNODES, then the silly min_ts could be dropped. */
 
 #define first_node(src) __first_node(&(src))
-static inline unsigned int __first_node(const nodemask_t *srcp)
+static __always_inline unsigned int __first_node(const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
 }
 
 #define next_node(n, src) __next_node((n), &(src))
-static inline unsigned int __next_node(int n, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node(int n, const nodemask_t *srcp)
 {
 	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
 }
@@ -277,7 +277,7 @@ static inline unsigned int __next_node(int n, const nodemask_t *srcp)
  * the first node in src if needed.  Returns MAX_NUMNODES if src is empty.
  */
 #define next_node_in(n, src) __next_node_in((n), &(src))
-static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
+static __always_inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 {
 	unsigned int ret = __next_node(node, srcp);
 
@@ -286,7 +286,7 @@ static inline unsigned int __next_node_in(int node, const nodemask_t *srcp)
 	return ret;
 }
 
-static inline void init_nodemask_of_node(nodemask_t *mask, int node)
+static __always_inline void init_nodemask_of_node(nodemask_t *mask, int node)
 {
 	nodes_clear(*mask);
 	node_set(node, *mask);
@@ -304,7 +304,7 @@ static inline void init_nodemask_of_node(nodemask_t *mask, int node)
 })
 
 #define first_unset_node(mask) __first_unset_node(&(mask))
-static inline unsigned int __first_unset_node(const nodemask_t *maskp)
+static __always_inline unsigned int __first_unset_node(const nodemask_t *maskp)
 {
 	return min_t(unsigned int, MAX_NUMNODES,
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
@@ -338,21 +338,21 @@ static inline unsigned int __first_unset_node(const nodemask_t *maskp)
 
 #define nodemask_parse_user(ubuf, ulen, dst) \
 		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
-static inline int __nodemask_parse_user(const char __user *buf, int len,
+static __always_inline int __nodemask_parse_user(const char __user *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
 	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
 #define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), MAX_NUMNODES)
-static inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
+static __always_inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
 {
 	return bitmap_parselist(buf, dstp->bits, nbits);
 }
 
 #define node_remap(oldbit, old, new) \
 		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
-static inline int __node_remap(int oldbit,
+static __always_inline int __node_remap(int oldbit,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	return bitmap_bitremap(oldbit, oldp->bits, newp->bits, nbits);
@@ -360,7 +360,7 @@ static inline int __node_remap(int oldbit,
 
 #define nodes_remap(dst, src, old, new) \
 		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
-static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
+static __always_inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
 {
 	bitmap_remap(dstp->bits, srcp->bits, oldp->bits, newp->bits, nbits);
@@ -368,7 +368,7 @@ static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
 
 #define nodes_onto(dst, orig, relmap) \
 		__nodes_onto(&(dst), &(orig), &(relmap), MAX_NUMNODES)
-static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 		const nodemask_t *relmapp, int nbits)
 {
 	bitmap_onto(dstp->bits, origp->bits, relmapp->bits, nbits);
@@ -376,7 +376,7 @@ static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
 
 #define nodes_fold(dst, orig, sz) \
 		__nodes_fold(&(dst), &(orig), sz, MAX_NUMNODES)
-static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
+static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 		int sz, int nbits)
 {
 	bitmap_fold(dstp->bits, origp->bits, sz, nbits);
@@ -418,22 +418,22 @@ enum node_states {
 extern nodemask_t node_states[NR_NODE_STATES];
 
 #if MAX_NUMNODES > 1
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node_isset(node, node_states[state]);
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 	__node_set(node, &node_states[state]);
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 	__node_clear(node, &node_states[state]);
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return nodes_weight(node_states[state]);
 }
@@ -443,11 +443,11 @@ static inline int num_node_state(enum node_states state)
 
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
-static inline unsigned int next_online_node(int nid)
+static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node(nid, node_states[N_ONLINE]);
 }
-static inline unsigned int next_memory_node(int nid)
+static __always_inline unsigned int next_memory_node(int nid)
 {
 	return next_node(nid, node_states[N_MEMORY]);
 }
@@ -455,13 +455,13 @@ static inline unsigned int next_memory_node(int nid)
 extern unsigned int nr_node_ids;
 extern unsigned int nr_online_nodes;
 
-static inline void node_set_online(int nid)
+static __always_inline void node_set_online(int nid)
 {
 	node_set_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
 }
 
-static inline void node_set_offline(int nid)
+static __always_inline void node_set_offline(int nid)
 {
 	node_clear_state(nid, N_ONLINE);
 	nr_online_nodes = num_node_state(N_ONLINE);
@@ -469,20 +469,20 @@ static inline void node_set_offline(int nid)
 
 #else
 
-static inline int node_state(int node, enum node_states state)
+static __always_inline int node_state(int node, enum node_states state)
 {
 	return node == 0;
 }
 
-static inline void node_set_state(int node, enum node_states state)
+static __always_inline void node_set_state(int node, enum node_states state)
 {
 }
 
-static inline void node_clear_state(int node, enum node_states state)
+static __always_inline void node_clear_state(int node, enum node_states state)
 {
 }
 
-static inline int num_node_state(enum node_states state)
+static __always_inline int num_node_state(enum node_states state)
 {
 	return 1;
 }
@@ -502,7 +502,7 @@ static inline int num_node_state(enum node_states state)
 
 #endif
 
-static inline int node_random(const nodemask_t *maskp)
+static __always_inline int node_random(const nodemask_t *maskp)
 {
 #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
 	int w, bit;
-- 
2.34.1

