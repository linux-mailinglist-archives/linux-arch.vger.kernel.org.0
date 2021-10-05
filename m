Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA026421E51
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhJEFof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhJEFnr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:43:47 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30239C0617AF;
        Mon,  4 Oct 2021 22:41:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e7so18763326pgk.2;
        Mon, 04 Oct 2021 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIoEZvUunyoBxXbbv99PoMzXoVzxmlZkq0hicXdZBHM=;
        b=H7MuVgk8rwoCPuSVs67duOR8ofBrB0Cd3fq7R6N+e2r7KhWAau2+Ig2aGOBiUORiK9
         s3I+ntszDfJd9GwXR0+AVeQP6o7tJfDWDDXbCk7bZ50nGgBO4/OW9txjHsVfwaMROOdn
         dOtmb36Nn7j4zVWnKRr4TeHTUdoLIi3lpfehF/n+r99U6VDEfCbVXafXYlgEzFsA6nlU
         4HOS95sZ6/hdGmsgX+s8RTGwSKgg4FXPQra9G4AgggY/77BIlMJugYFbk0BDIufoeowA
         otNn1PtOJR5rP2II9HVwh6Wn2DrcVQz2MYoJgJh30fRodClTprFYWTML7LCEEJVDk55w
         K7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIoEZvUunyoBxXbbv99PoMzXoVzxmlZkq0hicXdZBHM=;
        b=Si9x6dbvlQw6sWVnQkvUZvdgbfnx+/kzBgl22ZaCQ73g6/pRH34K2S7y6d2XiPaP7U
         l2i/c5S66Z3ZIAwQH0ybt/9JpDqz8tBabp1iyR/zYMN0FY8tL3c0sb4wGhAF/dsyqfFe
         jL2KNcrVgXkwMkZHvjt74UHPF/75JU+iB9gYt7kePUhP53sKGYUgFvPc0aLrc+xcz3+3
         5xamnDg6dPHe2IdPrVtY/LnOicT365/oyF++op3pEURZswJA+HpYMYVRPBy4X5Q0YK8Z
         0WpZaGWWm7KRlLjbqREbARIXNIYktHAnqdQoNhAgLBkvLBnh2EEE2X96UUkJwowEVoH4
         bxyQ==
X-Gm-Message-State: AOAM530qGyeQpk5N4xd1c2ORqwFtVY0QCLr7ltGmf3Bt7q2AGZAX3rff
        BjRVMlQa07NELTL9AW/Jts8=
X-Google-Smtp-Source: ABdhPJz4xb91hITMRHuZKCbv+Xs/qD8OtY1aPP1x4hzEQBnTzH7yv2IkQITt4SMIFDV/bwD4ZEdEfA==
X-Received: by 2002:a62:3606:0:b0:445:38d5:98bf with SMTP id d6-20020a623606000000b0044538d598bfmr29550548pfa.4.1633412501560;
        Mon, 04 Oct 2021 22:41:41 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id g22sm19264702pfj.15.2021.10.04.22.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:41:41 -0700 (PDT)
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
Subject: [PATCH 14/16] bitmap: unify find_bit operations
Date:   Mon,  4 Oct 2021 22:40:57 -0700
Message-Id: <20211005054059.475634-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005054059.475634-1-yury.norov@gmail.com>
References: <20211005054059.475634-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

bitmap_for_each_{set,clear}_region() are similar to for_each_bit()
macros in include/linux/find.h, but interface and implementation
of them are different.

This patch adds for_each_bitrange() macros and drops unused
bitmap_*_region() API in sake of unification.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
---
 drivers/mmc/host/renesas_sdhi_core.c |  2 +-
 include/linux/bitmap.h               | 33 ----------------
 include/linux/find.h                 | 56 ++++++++++++++++++++++++++++
 mm/percpu.c                          | 20 ++++------
 4 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a4407f391f66..9c99fb576911 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -628,7 +628,7 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	 * is at least SH_MOBILE_SDHI_MIN_TAP_ROW probes long then use the
 	 * center index as the tap, otherwise bail out.
 	 */
-	bitmap_for_each_set_region(bitmap, rs, re, 0, taps_size) {
+	for_each_set_bitrange(rs, re, bitmap, taps_size) {
 		if (re - rs > tap_cnt) {
 			tap_end = re;
 			tap_start = rs;
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index c88b2321ba14..e57dca065343 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -55,12 +55,6 @@ struct device;
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
  *  bitmap_find_next_zero_area_off(buf, len, pos, n, mask, mask_off)  as above
- *  bitmap_next_clear_region(map, &start, &end, nbits)  Find next clear region
- *  bitmap_next_set_region(map, &start, &end, nbits)  Find next set region
- *  bitmap_for_each_clear_region(map, rs, re, start, end)
- *  						Iterate over all clear regions
- *  bitmap_for_each_set_region(map, rs, re, start, end)
- *  						Iterate over all set regions
  *  bitmap_shift_right(dst, src, n, nbits)      *dst = *src >> n
  *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
  *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
@@ -465,14 +459,6 @@ static inline void bitmap_replace(unsigned long *dst,
 		__bitmap_replace(dst, old, new, mask, nbits);
 }
 
-static inline void bitmap_next_clear_region(unsigned long *bitmap,
-					    unsigned int *rs, unsigned int *re,
-					    unsigned int end)
-{
-	*rs = find_next_zero_bit(bitmap, end, *rs);
-	*re = find_next_bit(bitmap, end, *rs + 1);
-}
-
 static inline void bitmap_next_set_region(unsigned long *bitmap,
 					  unsigned int *rs, unsigned int *re,
 					  unsigned int end)
@@ -481,25 +467,6 @@ static inline void bitmap_next_set_region(unsigned long *bitmap,
 	*re = find_next_zero_bit(bitmap, end, *rs + 1);
 }
 
-/*
- * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
- * @rs and @re should be integer variables and will be set to start and end
- * index of the current clear or set region.
- */
-#define bitmap_for_each_clear_region(bitmap, rs, re, start, end)	     \
-	for ((rs) = (start),						     \
-	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end));	     \
-	     (rs) < (re);						     \
-	     (rs) = (re) + 1,						     \
-	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end)))
-
-#define bitmap_for_each_set_region(bitmap, rs, re, start, end)		     \
-	for ((rs) = (start),						     \
-	     bitmap_next_set_region((bitmap), &(rs), &(re), (end));	     \
-	     (rs) < (re);						     \
-	     (rs) = (re) + 1,						     \
-	     bitmap_next_set_region((bitmap), &(rs), &(re), (end)))
-
 /**
  * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
  * @n: u64 value
diff --git a/include/linux/find.h b/include/linux/find.h
index ae9ed52b52b8..5bb6db213bcb 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -301,6 +301,62 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+/**
+ * for_each_set_bitrange - iterate over all set bit ranges [b; e)
+ * @b: bit offset of start of current bitrange (first set bit)
+ * @e: bit offset of end of current bitrange (first unset bit)
+ * @addr: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_set_bitrange(b, e, addr, size)			\
+	for ((b) = find_next_bit((addr), (size), 0),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
+
+/**
+ * for_each_set_bitrange_from - iterate over all set bit ranges [b; e)
+ * @b: bit offset of start of current bitrange (first set bit); must be initialized
+ * @e: bit offset of end of current bitrange (first unset bit)
+ * @addr: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_set_bitrange_from(b, e, addr, size)		\
+	for ((b) = find_next_bit((addr), (size), (b)),		\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
+
+/**
+ * for_each_clear_bitrange - iterate over all unset bit ranges [b; e)
+ * @b: bit offset of start of current bitrange (first unset bit)
+ * @e: bit offset of end of current bitrange (first set bit)
+ * @addr: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_clear_bitrange(b, e, addr, size)		\
+	for ((b) = find_next_zero_bit((addr), (size), 0),	\
+	     (e) = find_next_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_zero_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_bit((addr), (size), (b) + 1))
+
+/**
+ * for_each_clear_bitrange_from - iterate over all unset bit ranges [b; e)
+ * @b: bit offset of start of current bitrange (first set bit); must be initialized
+ * @e: bit offset of end of current bitrange (first unset bit)
+ * @addr: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
+#define for_each_clear_bitrange_from(b, e, addr, size)		\
+	for ((b) = find_next_zero_bit((addr), (size), (b)),	\
+	     (e) = find_next_bit((addr), (size), (b) + 1);	\
+	     (b) < (size);					\
+	     (b) = find_next_zero_bit((addr), (size), (e) + 1),	\
+	     (e) = find_next_bit((addr), (size), (b) + 1))
+
 /**
  * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
  * @start: bit offset to start search and to store the current iteration offset
diff --git a/mm/percpu.c b/mm/percpu.c
index 1cf0bb904b1d..ff4e7a89eb61 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -779,7 +779,7 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 {
 	struct pcpu_block_md *block = chunk->md_blocks + index;
 	unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
-	unsigned int rs, re, start;	/* region start, region end */
+	unsigned int start, end;	/* region start, region end */
 
 	/* promote scan_hint to contig_hint */
 	if (block->scan_hint) {
@@ -795,9 +795,8 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 	block->right_free = 0;
 
 	/* iterate over free areas and update the contig hints */
-	bitmap_for_each_clear_region(alloc_map, rs, re, start,
-				     PCPU_BITMAP_BLOCK_BITS)
-		pcpu_block_update(block, rs, re);
+	for_each_clear_bitrange_from(start, end, alloc_map, PCPU_BITMAP_BLOCK_BITS)
+		pcpu_block_update(block, start, end);
 }
 
 /**
@@ -1852,13 +1851,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	/* populate if not all pages are already there */
 	if (!is_atomic) {
-		unsigned int page_start, page_end, rs, re;
+		unsigned int page_end, rs, re;
 
-		page_start = PFN_DOWN(off);
+		rs = PFN_DOWN(off);
 		page_end = PFN_UP(off + size);
 
-		bitmap_for_each_clear_region(chunk->populated, rs, re,
-					     page_start, page_end) {
+		for_each_clear_bitrange_from(rs, re, chunk->populated, page_end) {
 			WARN_ON(chunk->immutable);
 
 			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
@@ -2014,8 +2012,7 @@ static void pcpu_balance_free(bool empty_only)
 	list_for_each_entry_safe(chunk, next, &to_free, list) {
 		unsigned int rs, re;
 
-		bitmap_for_each_set_region(chunk->populated, rs, re, 0,
-					   chunk->nr_pages) {
+		for_each_set_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
 			pcpu_depopulate_chunk(chunk, rs, re);
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_depopulated(chunk, rs, re);
@@ -2085,8 +2082,7 @@ static void pcpu_balance_populated(void)
 			continue;
 
 		/* @chunk can't go away while pcpu_alloc_mutex is held */
-		bitmap_for_each_clear_region(chunk->populated, rs, re, 0,
-					     chunk->nr_pages) {
+		for_each_clear_bitrange(rs, re, chunk->populated, chunk->nr_pages) {
 			int nr = min_t(int, re - rs, nr_to_pop);
 
 			spin_unlock_irq(&pcpu_lock);
-- 
2.30.2

