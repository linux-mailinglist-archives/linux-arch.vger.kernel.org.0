Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601B3EC596
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhHNVUS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhHNVTl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:19:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDFC061764;
        Sat, 14 Aug 2021 14:18:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so26169274pjn.4;
        Sat, 14 Aug 2021 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=drG2tjBiR8dTixSORnvYSPN25clSXQGAiDKtK+5isws=;
        b=lggROPuH4LfGqCW3AL3vBwgd+0h3UqVAvpeKH2hvjvXUTu3a0X8GkyS3u6ENiitCVY
         wbGKiPruEuALAM57DyKHto5A5Yb+MdEy64mZtcl+w8SEhgBTV/5vzs33iPzvip+Ixy6c
         Rf6j9yQChxWgEj7rr5rIW9vZ9kB8d5A/uFqOpbEjONuHaMjrI2QFyZPiY9sQozq8MDS8
         4mD7dK3kT3jGze6wZ/s1uAdhQpMXZ/as3xwYMPYZgv5z1OfNXkp3YuvfZluwt6jiQf9B
         3l8OpDWFysqmTVRfjS8wk5WBZ1/PfKbmdB1wEguTbhZfwG5g16kIlpa19jS+SSBVzzh+
         ztsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drG2tjBiR8dTixSORnvYSPN25clSXQGAiDKtK+5isws=;
        b=qpA0Olv8ubJPGVtsKDhs0VggP67AW9/x9QXCbXv3CvKzdoA32asUC3X6Kvu/QPdC5J
         XTFLPqWfuddz3uj2jJPiJlLAw+KjeH5OPyUbJ+V9FqlCN5/BNJ2UYzCsm6IXz8W7ybu9
         rAIwL/5zF0ScixPG01tb3gfurDN/QlOkpR7SqLjEvB7oYKpxn8K1V9V3TCzXNyRmsGqh
         1fZztgHOPggPO1updrwP+1iV8RggQA61tCFKZtEMzaqqznbMNWRPzW9dD67p4KunkXRV
         nUALJu6TqNxrqTS/soZ1sDL+FSzx6fsO185so2ke2ABhUGOONXkqTzkaCln8GG2iIdBi
         UObQ==
X-Gm-Message-State: AOAM530lEq0LbPU4lGTY5Sq9d0tQ0ZmTCTZkJkLFByPEJp5Q8++9zIJg
        NuYTs5wSQsOlQ3kP5DA2OtA=
X-Google-Smtp-Source: ABdhPJyG1X06h0TQ00eHro2rlQYqVCcp+f7hHHE7B62WF7q7zw22V6Nj0N4oW8ZtFWs2LLEcjw+bPg==
X-Received: by 2002:a63:171d:: with SMTP id x29mr8319221pgl.418.1628975937992;
        Sat, 14 Aug 2021 14:18:57 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p190sm6814093pfb.4.2021.08.14.14.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:18:57 -0700 (PDT)
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
Subject: [PATCH 13/17] tools: Rename bitmap_alloc() to bitmap_zalloc()
Date:   Sat, 14 Aug 2021 14:17:09 -0700
Message-Id: <20210814211713.180533-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210814211713.180533-1-yury.norov@gmail.com>
References: <20210814211713.180533-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Rename bitmap_alloc() to bitmap_zalloc() in tools to follow the bitmap API
in the kernel.

No functional changes intended.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/include/linux/bitmap.h                            | 4 ++--
 tools/perf/bench/find-bit-bench.c                       | 2 +-
 tools/perf/builtin-c2c.c                                | 6 +++---
 tools/perf/builtin-record.c                             | 2 +-
 tools/perf/tests/bitmap.c                               | 2 +-
 tools/perf/tests/mem2node.c                             | 2 +-
 tools/perf/util/affinity.c                              | 4 ++--
 tools/perf/util/header.c                                | 4 ++--
 tools/perf/util/metricgroup.c                           | 2 +-
 tools/perf/util/mmap.c                                  | 4 ++--
 tools/testing/selftests/kvm/dirty_log_perf_test.c       | 2 +-
 tools/testing/selftests/kvm/dirty_log_test.c            | 4 ++--
 tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 13d90b574970..ea97804d04d4 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -112,10 +112,10 @@ static inline int test_and_clear_bit(int nr, unsigned long *addr)
 }
 
 /**
- * bitmap_alloc - Allocate bitmap
+ * bitmap_zalloc - Allocate bitmap
  * @nbits: Number of bits
  */
-static inline unsigned long *bitmap_alloc(int nbits)
+static inline unsigned long *bitmap_zalloc(int nbits)
 {
 	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
 }
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 73b5bcc5946a..22b5cfe97023 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -54,7 +54,7 @@ static bool asm_test_bit(long nr, const unsigned long *addr)
 
 static int do_for_each_set_bit(unsigned int num_bits)
 {
-	unsigned long *to_test = bitmap_alloc(num_bits);
+	unsigned long *to_test = bitmap_zalloc(num_bits);
 	struct timeval start, end, diff;
 	u64 runtime_us;
 	struct stats fb_time_stats, tb_time_stats;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6dea37f141b2..c34d77bee4ef 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -139,11 +139,11 @@ static void *c2c_he_zalloc(size_t size)
 	if (!c2c_he)
 		return NULL;
 
-	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
+	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
 	if (!c2c_he->cpuset)
 		return NULL;
 
-	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
+	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
 	if (!c2c_he->nodeset)
 		return NULL;
 
@@ -2047,7 +2047,7 @@ static int setup_nodes(struct perf_session *session)
 		struct perf_cpu_map *map = n[node].map;
 		unsigned long *set;
 
-		set = bitmap_alloc(c2c.cpus_cnt);
+		set = bitmap_zalloc(c2c.cpus_cnt);
 		if (!set)
 			return -ENOMEM;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 671a21c9ee4d..f1b30ac094cb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2786,7 +2786,7 @@ int cmd_record(int argc, const char **argv)
 
 	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
 		rec->affinity_mask.nbits = cpu__max_cpu();
-		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
+		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
 		if (!rec->affinity_mask.bits) {
 			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
 			err = -ENOMEM;
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96c137360918..12b805efdca0 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -14,7 +14,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index a258bd51f1a4..e4d0d58b97f8 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -27,7 +27,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++) {
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index a5e31f826828..7b12bd7a3080 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -25,11 +25,11 @@ int affinity__setup(struct affinity *a)
 {
 	int cpu_set_size = get_cpu_set_size();
 
-	a->orig_cpus = bitmap_alloc(cpu_set_size * 8);
+	a->orig_cpus = bitmap_zalloc(cpu_set_size * 8);
 	if (!a->orig_cpus)
 		return -1;
 	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
-	a->sched_cpus = bitmap_alloc(cpu_set_size * 8);
+	a->sched_cpus = bitmap_zalloc(cpu_set_size * 8);
 	if (!a->sched_cpus) {
 		zfree(&a->orig_cpus);
 		return -1;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 44249027507a..563dec72adeb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -278,7 +278,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	set = bitmap_alloc(size);
+	set = bitmap_zalloc(size);
 	if (!set)
 		return -ENOMEM;
 
@@ -1294,7 +1294,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	size++;
 
-	n->set = bitmap_alloc(size);
+	n->set = bitmap_zalloc(size);
 	if (!n->set) {
 		closedir(dir);
 		return -ENOMEM;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 99d047c5ead0..29b747ac31c1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -313,7 +313,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 	struct evsel *evsel, *tmp;
 	unsigned long *evlist_used;
 
-	evlist_used = bitmap_alloc(perf_evlist->core.nr_entries);
+	evlist_used = bitmap_zalloc(perf_evlist->core.nr_entries);
 	if (!evlist_used)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428..512dc8b9c168 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -106,7 +106,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 		data = map->aio.data[idx];
 		mmap_len = mmap__mmap_len(map);
 		node_index = cpu__get_node(cpu);
-		node_mask = bitmap_alloc(node_index + 1);
+		node_mask = bitmap_zalloc(node_index + 1);
 		if (!node_mask) {
 			pr_err("Failed to allocate node mask for mbind: error %m\n");
 			return -1;
@@ -258,7 +258,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
 	map->affinity_mask.nbits = cpu__max_cpu();
-	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
+	map->affinity_mask.bits = bitmap_zalloc(map->affinity_mask.nbits);
 	if (!map->affinity_mask.bits)
 		return -1;
 
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 3c30d0045d8d..479868570d59 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -171,7 +171,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm_get_page_shift(vm);
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
-	bmap = bitmap_alloc(host_num_pages);
+	bmap = bitmap_zalloc(host_num_pages);
 
 	if (dirty_log_manual_caps) {
 		cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5fe0140e407e..792c60e1b17d 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -749,8 +749,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
 
-	bmap = bitmap_alloc(host_num_pages);
-	host_bmap_track = bitmap_alloc(host_num_pages);
+	bmap = bitmap_zalloc(host_num_pages);
+	host_bmap_track = bitmap_zalloc(host_num_pages);
 
 	/* Add an extra memory slot for testing dirty logging */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 06a64980a5d2..68f26a8b4f42 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	nested_map(vmx, vm, NESTED_TEST_MEM1, GUEST_TEST_MEM, 4096);
 	nested_map(vmx, vm, NESTED_TEST_MEM2, GUEST_TEST_MEM, 4096);
 
-	bmap = bitmap_alloc(TEST_MEM_PAGES);
+	bmap = bitmap_zalloc(TEST_MEM_PAGES);
 	host_test_mem = addr_gpa2hva(vm, GUEST_TEST_MEM);
 
 	while (!done) {
-- 
2.30.2

