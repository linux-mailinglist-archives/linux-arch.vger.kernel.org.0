Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B306237A191
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEKIRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 04:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhEKIRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 May 2021 04:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620721002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLd2jFmyAv8PWEgrP1PmR2Fwcs+q67L/hXPeC7/MiWQ=;
        b=ZJI5BYhNx0YzqHxw7U/fVLL7eIXS6TjJCJ6gZUEG3Da+II+A8d7VhlWBdGy8Pri9DsyIxS
        A5HKU6NuOhGn2A9kjUqCntIwhHejp1Ha/sKnXsu0AQlGUCGumxwaFE54L2fSlZXRjvMvoD
        T6EnSz6KEk96LF3X44AmYgX15L+XQko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-02aNQ_t-PXah-S4ydI7oXg-1; Tue, 11 May 2021 04:16:38 -0400
X-MC-Unique: 02aNQ_t-PXah-S4ydI7oXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A915D1008064;
        Tue, 11 May 2021 08:16:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 349F95D6D1;
        Tue, 11 May 2021 08:16:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH resend v2 5/5] selftests/vm: add test for MADV_POPULATE_(READ|WRITE)
Date:   Tue, 11 May 2021 10:15:34 +0200
Message-Id: <20210511081534.3507-6-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's add a simple test for MADV_POPULATE_READ and MADV_POPULATE_WRITE,
verifying some error handling, that population works, and that softdirty
tracking works as expected. For now, limit the test to private anonymous
memory.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Linux API <linux-api@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh  |  16 +
 4 files changed, 360 insertions(+)
 create mode 100644 tools/testing/selftests/vm/madv_populate.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index b4fc0148360e..c9a5dd1adf7d 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -24,3 +24,4 @@ hmm-tests
 local_config.*
 protection_keys_32
 protection_keys_64
+madv_populate
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 8b0cd421ebd3..04b6650c1924 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -42,6 +42,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += madv_populate
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
new file mode 100644
index 000000000000..b959e4ebdad4
--- /dev/null
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
+ *
+ * Copyright 2021, Red Hat, Inc.
+ *
+ * Author(s): David Hildenbrand <david@redhat.com>
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+#include "../kselftest.h"
+
+#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
+
+/*
+ * For now, we're using 2 MiB of private anonymous memory for all tests.
+ */
+#define SIZE (2 * 1024 * 1024)
+
+static size_t pagesize;
+
+static uint64_t pagemap_get_entry(int fd, char *start)
+{
+	const unsigned long pfn = (unsigned long)start / pagesize;
+	uint64_t entry;
+	int ret;
+
+	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
+	if (ret != sizeof(entry))
+		ksft_exit_fail_msg("reading pagemap failed\n");
+	return entry;
+}
+
+static bool pagemap_is_populated(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	/* Present or swapped. */
+	return entry & 0xc000000000000000ull;
+}
+
+static bool pagemap_is_softdirty(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	return entry & 0x0080000000000000ull;
+}
+
+static void sense_support(void)
+{
+	char *addr;
+	int ret;
+
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	ret = madvise(addr, pagesize, MADV_POPULATE_READ);
+	if (ret)
+		ksft_exit_skip("MADV_POPULATE_READ is not available\n");
+
+	ret = madvise(addr, pagesize, MADV_POPULATE_WRITE);
+	if (ret)
+		ksft_exit_skip("MADV_POPULATE_WRITE is not available\n");
+
+	munmap(addr, pagesize);
+}
+
+static void test_prot_read(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
+	ksft_test_result(!ret, "MADV_POPULATE_READ with PROT_READ\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
+	ksft_test_result(ret == -1 && errno == EINVAL,
+			 "MADV_POPULATE_WRITE with PROT_READ\n");
+
+	munmap(addr, SIZE);
+}
+
+static void test_prot_write(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
+	ksft_test_result(ret == -1 && errno == EINVAL,
+			 "MADV_POPULATE_READ with PROT_WRITE\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
+	ksft_test_result(!ret, "MADV_POPULATE_WRITE with PROT_WRITE\n");
+
+	munmap(addr, SIZE);
+}
+
+static void test_holes(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	ret = munmap(addr + pagesize, pagesize);
+	if (ret)
+		ksft_exit_fail_msg("munmap failed\n");
+
+	/* Hole in the middle */
+	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_READ with holes in the middle\n");
+	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_WRITE with holes in the middle\n");
+
+	/* Hole at end */
+	ret = madvise(addr, 2 * pagesize, MADV_POPULATE_READ);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_READ with holes at the end\n");
+	ret = madvise(addr, 2 * pagesize, MADV_POPULATE_WRITE);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_WRITE with holes at the end\n");
+
+	/* Hole at beginning */
+	ret = madvise(addr + pagesize, pagesize, MADV_POPULATE_READ);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_READ with holes at the beginning\n");
+	ret = madvise(addr + pagesize, pagesize, MADV_POPULATE_WRITE);
+	ksft_test_result(ret == -1 && errno == ENOMEM,
+			 "MADV_POPULATE_WRITE with holes at the beginning\n");
+
+	munmap(addr, SIZE);
+}
+
+static bool range_is_populated(char *start, ssize_t size)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+	bool ret = true;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+	for (; size > 0 && ret; size -= pagesize, start += pagesize)
+		if (!pagemap_is_populated(fd, start))
+			ret = false;
+	close(fd);
+	return ret;
+}
+
+static bool range_is_not_populated(char *start, ssize_t size)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+	bool ret = true;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+	for (; size > 0 && ret; size -= pagesize, start += pagesize)
+		if (pagemap_is_populated(fd, start))
+			ret = false;
+	close(fd);
+	return ret;
+}
+
+static void test_populate_read(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	ksft_test_result(range_is_not_populated(addr, SIZE),
+			 "range initially not populated\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
+	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
+	ksft_test_result(range_is_populated(addr, SIZE),
+			 "range is populated\n");
+
+	munmap(addr, SIZE);
+}
+
+static void test_populate_write(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	ksft_test_result(range_is_not_populated(addr, SIZE),
+			 "range initially not populated\n");
+
+	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
+	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
+	ksft_test_result(range_is_populated(addr, SIZE),
+			 "range is populated\n");
+
+	munmap(addr, SIZE);
+}
+
+static bool range_is_softdirty(char *start, ssize_t size)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+	bool ret = true;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+	for (; size > 0 && ret; size -= pagesize, start += pagesize)
+		if (!pagemap_is_softdirty(fd, start))
+			ret = false;
+	close(fd);
+	return ret;
+}
+
+static bool range_is_not_softdirty(char *start, ssize_t size)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+	bool ret = true;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+	for (; size > 0 && ret; size -= pagesize, start += pagesize)
+		if (pagemap_is_softdirty(fd, start))
+			ret = false;
+	close(fd);
+	return ret;
+}
+
+static void clear_softdirty(void)
+{
+	int fd = open("/proc/self/clear_refs", O_WRONLY);
+	const char *ctrl = "4";
+	int ret;
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening clear_refs failed\n");
+	ret = write(fd, ctrl, strlen(ctrl));
+	if (ret != strlen(ctrl))
+		ksft_exit_fail_msg("writing clear_refs failed\n");
+	close(fd);
+}
+
+static void test_softdirty(void)
+{
+	char *addr;
+	int ret;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (addr == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	/* Clear any softdirty bits. */
+	clear_softdirty();
+	ksft_test_result(range_is_not_softdirty(addr, SIZE),
+			 "range is not softdirty\n");
+
+	/* Populating READ should set softdirty. */
+	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
+	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
+	ksft_test_result(range_is_not_softdirty(addr, SIZE),
+			 "range is not softdirty\n");
+
+	/* Populating WRITE should set softdirty. */
+	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
+	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
+	ksft_test_result(range_is_softdirty(addr, SIZE),
+			 "range is softdirty\n");
+
+	munmap(addr, SIZE);
+}
+
+int main(int argc, char **argv)
+{
+	int err;
+
+	pagesize = getpagesize();
+
+	ksft_print_header();
+	ksft_set_plan(21);
+
+	sense_support();
+	test_prot_read();
+	test_prot_write();
+	test_holes();
+	test_populate_read();
+	test_populate_write();
+	test_softdirty();
+
+	err = ksft_get_fail_cnt();
+	if (err)
+		ksft_exit_fail_msg("%d out of %d tests failed\n",
+				   err, ksft_test_num());
+	return ksft_exit_pass();
+}
+
+#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
+
+#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not defined\n");
+}
+
+#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e953f3cd9664..955782d138ab 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -346,4 +346,20 @@ else
 	exitcode=1
 fi
 
+echo "--------------------------------------------------------"
+echo "running MADV_POPULATE_READ and MADV_POPULATE_WRITE tests"
+echo "--------------------------------------------------------"
+./madv_populate
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
 exit $exitcode
-- 
2.30.2

