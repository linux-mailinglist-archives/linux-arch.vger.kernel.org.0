Return-Path: <linux-arch+bounces-8260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C846C9A2FC6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 23:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDA31C25900
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4BC1D54CD;
	Thu, 17 Oct 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J672Ox+o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17E1D5ABE
	for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200296; cv=none; b=s3VVP1IcWxHfxxvOVOXFlG1/wDHIUdX77YrzNFUPR47Hvi1hv7xa+S5PezsyAS4f45qYDlCnFjD6JI4JWbyu+V8IAEcILtZECk8QcqrhxlNmRb7kuEx62+zeCfP24FnzdAEyb3eSWl3HIOmPVlAQLc07lqQce9MUVceUy+UMv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200296; c=relaxed/simple;
	bh=J0wFClx5q4an3jKKOjmI+yKpwbKx7FbSqCKGCyDXRI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf29WpjUWAmaEjbXSP5AfKeywJKg3S8kYB7ZhxU9Qn6W96/qoRqOefwQuaB3oolK5+dua62RzFf3eb4ILyK8OT3tO6m1OMJhO+7jNwAWoBp90Lxj8bclsYi38CZKVP+R9AQ/EWmkdx4aKrI0GQ8jVMDdeIbvQM+MQSiDiHpm9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J672Ox+o; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ab6cbd8b1so31723539f.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2024 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729200292; x=1729805092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMbCxgTGFZeo8xghXumUnHGUAo1uXMmJhzYDvhqP+2w=;
        b=J672Ox+ol+vxDGiEc+jtAx5gYCV7IATsVmTgLpuoamxNmGlePGAiovMDzR/fRNLX4+
         Gz4ou2j2npkbQ2+E+Mk/6rtlEuMPfl23c4FMxT2oHX3nHvrkPHRTwNgS4jBor2E1KmTO
         tUd+kS8Rootm7ApB9jbfRVDC/ONX8B6KHRbC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200292; x=1729805092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMbCxgTGFZeo8xghXumUnHGUAo1uXMmJhzYDvhqP+2w=;
        b=PmyV2BLmZ+mjOWoRPftOOf39p+ctLTHGbX1QL/otdraJXerH9+ozjXrTBCYomhY6PB
         3s1laZKoA/vp/NnnIoOPCgvA0/I5xRln5oSTOVic0edoqeyjoLrtVULdVLiwTXKsaUje
         MLFAz57iiicoAsWJiRjgK84x6NRaoF+HZCDLU9+QSHhiVu6rJAovaHNHudZyspMvbtid
         bEOCsF7DUUA2fdzFVJptqpWqqodkXlM3cwtUcA+Vz79rtTPJ12hghjyxpivCg55Njpi5
         erEwno5fMmtn67FQaZtz4YTROk41T3GyMhBpYXVnFThw2SRmWYIdZLzkeTOVMXubemkF
         X0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyaEcHNPuAOL1oNG3q93i0VliwN4XLFIaUOBC3SqHN6CCFcrGreAasCiOV295qmGuZyuM720XcsNH4@vger.kernel.org
X-Gm-Message-State: AOJu0YwVum6IbcIOQBD0PbrMIlfWByXtq9lLSD7MlxkosJdQS3ukJFEQ
	4TIWa0qAuLBh7YGUZkaVVvWF9r5Dr+5SZwHTHb4RB1xNVro4RJL/KJjMGLdWHZw=
X-Google-Smtp-Source: AGHT+IHC3/MvC+py8nduUW2aOgWAkhavkA1wA78l3+pmvg9lkRGXKBxpxvl3gpbXsZYPTh4UEQlbNw==
X-Received: by 2002:a05:6e02:16cf:b0:3a3:af94:461f with SMTP id e9e14a558f8ab-3a3f4050131mr2223035ab.1.1729200292152;
        Thu, 17 Oct 2024 14:24:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c2b54esm67348173.110.2024.10.17.14.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:24:51 -0700 (PDT)
Message-ID: <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
Date: Thu, 17 Oct 2024 15:24:49 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 14:42, Lorenzo Stoakes wrote:
> Utilise the kselftest harmness to implement tests for the guard page

Splleing NIT - harmness -> harness

> implementation.
> 
> We start by implement basic tests asserting that guard pages can be

implmenting? By the way checkpatch will catch spelling stuuf.
Please see comments about warnings below.

> established (poisoned), cleared (remedied) and that touching poisoned pages
> result in SIGSEGV. We also assert that, in remedying a range, non-poison
> pages remain intact.
> 
> We then examine different operations on regions containing poison markers
> behave to ensure correct behaviour:
> 
> * Operations over multiple VMAs operate as expected.
> * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
>    batches works correctly.
> * Ensuring that munmap() correctly tears down poison markers.
> * Using mprotect() to adjust protection bits does not in any way override
>    or cause issues with poison markers.
> * Ensuring that splitting and merging VMAs around poison markers causes no
>    issue - i.e. that a marker which 'belongs' to one VMA can function just
>    as well 'belonging' to another.
> * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
> * Ensuring that mlock()'ing a range containing poison markers does not
>    cause issues.
> * Ensuring that mremap() can move a poisoned range and retain poison
>    markers.
> * Ensuring that mremap() can expand a poisoned range and retain poison
>    markers (perhaps moving the range).
> * Ensuring that mremap() can shrink a poisoned range and retain poison
>    markers.
> * Ensuring that forking a process correctly retains poison markers.
> * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> * Ensuring that lazyfree simply clears poison markers.
> * Ensuring that userfaultfd can co-exist with guard pages.
> * Ensuring that madvise(..., MADV_POPULATE_READ) and
>    madvise(..., MADV_POPULATE_WRITE) error out when encountering
>    poison markers.
> * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
>    not remove poison markers.

Good summary of test. Does the test require root access?
If so does it check and skip appropriately?

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   tools/testing/selftests/mm/.gitignore    |    1 +
>   tools/testing/selftests/mm/Makefile      |    1 +
>   tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
>   3 files changed, 1170 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/guard-pages.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 689bbd520296..8f01f4da1c0d 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -54,3 +54,4 @@ droppable
>   hugetlb_dio
>   pkey_sighandler_tests_32
>   pkey_sighandler_tests_64
> +guard-pages
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 02e1204971b0..15c734d6cfec 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
>   TEST_GEN_FILES += hugetlb_madv_vs_map
>   TEST_GEN_FILES += hugetlb_dio
>   TEST_GEN_FILES += droppable
> +TEST_GEN_FILES += guard-pages
>   
>   ifneq ($(ARCH),arm64)
>   TEST_GEN_FILES += soft-dirty
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> new file mode 100644
> index 000000000000..2ab0ff3ba5a0
> --- /dev/null
> +++ b/tools/testing/selftests/mm/guard-pages.c
> @@ -0,0 +1,1168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <assert.h>
> +#include <fcntl.h>
> +#include <setjmp.h>
> +#include <errno.h>
> +#include <linux/userfaultfd.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +
> +/* These may not yet be available in the uAPI so define if not. */
> +
> +#ifndef MADV_GUARD_POISON
> +#define MADV_GUARD_POISON	102
> +#endif
> +
> +#ifndef MADV_GUARD_UNPOISON
> +#define MADV_GUARD_UNPOISON	103
> +#endif
> +
> +volatile bool signal_jump_set;

Can you add a comment about why volatile is needed.
By the way did you happen to run checkpatck on this. There are
several instances where single statement blocks with braces {}

I noticed a few and ran checkpatch on your patch. There are
45 warnings regarding codeing style.

Please run checkpatch and clean them up so we can avoid followup
checkpatch cleanup patches.

> +sigjmp_buf signal_jmp_buf;
> +
> +static int userfaultfd(int flags)
> +{
> +	return syscall(SYS_userfaultfd, flags);
> +}
> +
> +static void handle_fatal(int c)
> +{
> +	if (!signal_jump_set)
> +		return;
> +
> +	siglongjmp(signal_jmp_buf, c);
> +}
> +
> +static int pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(SYS_pidfd_open, pid, flags);
> +}
> +
> +/*
> + * Enable our signal catcher and try to read/write the specified buffer. The
> + * return value indicates whether the read/write succeeds without a fatal
> + * signal.
> + */
> +static bool try_access_buf(char *ptr, bool write)
> +{
> +	bool failed;
> +
> +	/* Tell signal handler to jump back here on fatal signal. */
> +	signal_jump_set = true;
> +	/* If a fatal signal arose, we will jump back here and failed is set. */
> +	failed = sigsetjmp(signal_jmp_buf, 0) != 0;
> +
> +	if (!failed) {
> +		if (write) {
> +			*ptr = 'x';
> +		} else {
> +			const volatile char *chr = ptr;
> +
> +			/* Force read. */
> +			(void)*chr;
> +		}
> +	}
> +
> +	signal_jump_set = false;
> +	return !failed;
> +}
> +
> +/* Try and read from a buffer, return true if no fatal signal. */
> +static bool try_read_buf(char *ptr)
> +{
> +	return try_access_buf(ptr, false);
> +}
> +
> +/* Try and write to a buffer, return true if no fatal signal. */
> +static bool try_write_buf(char *ptr)
> +{
> +	return try_access_buf(ptr, true);
> +}
> +
> +/*
> + * Try and BOTH read from AND write to a buffer, return true if BOTH operations
> + * succeed.
> + */
> +static bool try_read_write_buf(char *ptr)
> +{
> +	return try_read_buf(ptr) && try_write_buf(ptr);
> +}
> +
> +FIXTURE(guard_pages)
> +{
> +	unsigned long page_size;
> +};
> +
> +FIXTURE_SETUP(guard_pages)
> +{
> +	struct sigaction act = {
> +		.sa_handler = &handle_fatal,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL)) {
> +		perror("sigaction");
> +		ksft_exit_fail();

Replase the above two with ksft_exit_fail_perror()
There is no need for perror("sigaction"); followed by
ksft_exit_fail();

> +	}
> +
> +	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
> +};
> +
> +FIXTURE_TEARDOWN(guard_pages)
> +{
> +	struct sigaction act = {
> +		.sa_handler = SIG_DFL,
> +		.sa_flags = SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	sigaction(SIGSEGV, &act, NULL);
> +}
> +
> +TEST_F(guard_pages, basic)
> +{
> +	const unsigned long NUM_PAGES = 10;
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANON, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Trivially assert we can touch the first page. */
> +	ASSERT_TRUE(try_read_write_buf(ptr));
> +
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Establish that 1st page SIGSEGV's. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* Ensure we can touch everything else.*/
> +	for (i = 1; i < NUM_PAGES; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Establish a guard page at the end of the mapping. */
> +	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> +			  MADV_GUARD_POISON), 0);
> +
> +	/* Check that both guard pages result in SIGSEGV. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> +
> +	/* Unpoison the first. */
> +	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_UNPOISON));
> +
> +	/* Make sure we can touch it. */
> +	ASSERT_TRUE(try_read_write_buf(ptr));
> +
> +	/* Unpoison the last. */
> +	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> +			     MADV_GUARD_UNPOISON));
> +
> +	/* Make sure we can touch it. */
> +	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> +
> +	/*
> +	 *  Test setting a _range_ of pages, namely the first 3. The first of
> +	 *  these be faulted in, so this also tests that we can poison backed
> +	 *  pages.
> +	 */
> +	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure they are all poisoned. */
> +	for (i = 0; i < 3; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +

This one here and
> +	/* Make sure the rest are not. */
> +	for (i = 3; i < NUM_PAGES; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Unpoison them. */
> +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +	/* Now make sure we can touch everything. */
> +	for (i = 0; i < NUM_PAGES; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now unpoison everything, make sure we don't remove existing entries */
> +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +	for (i = 0; i < NUM_PAGES * page_size; i += page_size) {
> +		ASSERT_EQ(ptr[i], 'x');
> +	}
> +
> +	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
> +}
> +
> +/* Assert that operations applied across multiple VMAs work as expected. */
> +TEST_F(guard_pages, multi_vma)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
> +	int i;
> +
> +	/* Reserve a 100 page region over which we can install VMAs. */
> +	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
> +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_region, MAP_FAILED);
> +
> +	/* Place a VMA of 10 pages size at the start of the region. */
> +	ptr1 = mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr1, MAP_FAILED);
> +
> +	/* Place a VMA of 5 pages size 50 pages into the region. */
> +	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +
> +	/* Place a VMA of 20 pages size at the end of the region. */
> +	ptr3 = mmap(&ptr_region[80 * page_size], 20 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr3, MAP_FAILED);
> +
> +	/* Unmap gaps. */
> +	ASSERT_EQ(munmap(&ptr_region[10 * page_size], 40 * page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 25 * page_size), 0);
> +
> +	/*
> +	 * We end up with VMAs like this:
> +	 *
> +	 * 0    10 .. 50   55 .. 80   100
> +	 * [---]      [---]      [---]
> +	 */
> +
> +	/* Now poison the whole range and make sure all VMAs are poisoned. */
> +
> +	/*
> +	 * madvise() is certifiable and lets you perform operations over gaps,
> +	 * everything works, but it indicates an error and errno is set to
> +	 * -ENOMEM. Also if anything runs out of memory it is set to
> +	 * -ENOMEM. You are meant to guess which is which.
> +	 */
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), -1);
> +	ASSERT_EQ(errno, ENOMEM);
> +
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
> +	}
> +
> +	for (i = 0; i < 5; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr2[i * page_size]));
> +	}
> +
> +	for (i = 0; i < 20; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr3[i * page_size]));
> +	}
> +
> +	/* Now unpoison the range and assert the opposite. */
> +
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), -1);
> +	ASSERT_EQ(errno, ENOMEM);
> +
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr1[i * page_size]));
> +	}
> +
> +	for (i = 0; i < 5; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr2[i * page_size]));
> +	}
> +
> +	for (i = 0; i < 20; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr3[i * page_size]));
> +	}
> +
> +	/* Now map incompatible VMAs in the gaps. */
> +	ptr = mmap(&ptr_region[10 * page_size], 40 * page_size,
> +		   PROT_READ | PROT_WRITE | PROT_EXEC,
> +		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr = mmap(&ptr_region[55 * page_size], 25 * page_size,
> +		   PROT_READ | PROT_WRITE | PROT_EXEC,
> +		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/*
> +	 * We end up with VMAs like this:
> +	 *
> +	 * 0    10 .. 50   55 .. 80   100
> +	 * [---][xxxx][---][xxxx][---]
> +	 *
> +	 * Where 'x' signifies VMAs that cannot be merged with those adjacent to
> +	 * them.
> +	 */
> +
> +	/* Multiple VMAs adjacent to one another should result in no error. */
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_POISON), 0);
> +	for (i = 0; i < 100; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr_region[i * page_size]));
> +	}
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_UNPOISON), 0);
> +	for (i = 0; i < 100; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr_region[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
> +}
> +
> +/*
> + * Assert that batched operations performed using process_madvise() work as
> + * expected.
> + */
> +TEST_F(guard_pages, process_madvise)
> +{
> +	const unsigned long page_size = self->page_size;
> +	pid_t pid = getpid();
> +	int pidfd = pidfd_open(pid, 0);
> +	char *ptr_region, *ptr1, *ptr2, *ptr3;
> +	ssize_t count;
> +	struct iovec vec[6];
> +
> +	ASSERT_NE(pidfd, -1);
> +
> +	/* Reserve region to map over. */
> +	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
> +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_region, MAP_FAILED);
> +
> +	/* 10 pages offset 1 page into reserve region. */
> +	ptr1 = mmap(&ptr_region[page_size], 10 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr1, MAP_FAILED);
> +	/* We want poison markers at start/end of each VMA. */
> +	vec[0].iov_base = ptr1;
> +	vec[0].iov_len = page_size;
> +	vec[1].iov_base = &ptr1[9 * page_size];
> +	vec[1].iov_len = page_size;
> +
> +	/* 5 pages offset 50 pages into reserve region. */
> +	ptr2 = mmap(&ptr_region[50 * page_size], 5 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	vec[2].iov_base = ptr2;
> +	vec[2].iov_len = page_size;
> +	vec[3].iov_base = &ptr2[4 * page_size];
> +	vec[3].iov_len = page_size;
> +
> +	/* 20 pages offset 79 pages into reserve region. */
> +	ptr3 = mmap(&ptr_region[79 * page_size], 20 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr3, MAP_FAILED);
> +	vec[4].iov_base = ptr3;
> +	vec[4].iov_len = page_size;
> +	vec[5].iov_base = &ptr3[19 * page_size];
> +	vec[5].iov_len = page_size;
> +
> +	/* Free surrounding VMAs. */
> +	ASSERT_EQ(munmap(ptr_region, page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
> +
> +	/* Now poison in one step. */
> +	count = process_madvise(pidfd, vec, 6, MADV_GUARD_POISON, 0);
> +
> +	/* OK we don't have permission to do this, skip. */
> +	if (count == -1 && errno == EPERM)
> +		ksft_exit_skip("No process_madvise() permissions\n");

Can you make this a bit more informative? What would user do
if they see this message? Are they supposed to run the test
as root?

> +
> +	/* Returns the number of bytes advised. */
> +	ASSERT_EQ(count, 6 * page_size);
> +
> +	/* Now make sure the poisoning was applied. */
> +
> +	ASSERT_FALSE(try_read_write_buf(ptr1));
> +	ASSERT_FALSE(try_read_write_buf(&ptr1[9 * page_size]));
> +
> +	ASSERT_FALSE(try_read_write_buf(ptr2));
> +	ASSERT_FALSE(try_read_write_buf(&ptr2[4 * page_size]));
> +
> +	ASSERT_FALSE(try_read_write_buf(ptr3));
> +	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));
> +
> +	/* Now do the same with unpoison... */
> +	count = process_madvise(pidfd, vec, 6, MADV_GUARD_UNPOISON, 0);
> +
> +	/* ...and everything should now succeed. */
> +
> +	ASSERT_TRUE(try_read_write_buf(ptr1));
> +	ASSERT_TRUE(try_read_write_buf(&ptr1[9 * page_size]));
> +
> +	ASSERT_TRUE(try_read_write_buf(ptr2));
> +	ASSERT_TRUE(try_read_write_buf(&ptr2[4 * page_size]));
> +
> +	ASSERT_TRUE(try_read_write_buf(ptr3));
> +	ASSERT_TRUE(try_read_write_buf(&ptr3[19 * page_size]));
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr1, 10 * page_size), 0);
> +	ASSERT_EQ(munmap(ptr2, 5 * page_size), 0);
> +	ASSERT_EQ(munmap(ptr3, 20 * page_size), 0);
> +	close(pidfd);
> +}
> +
> +/* Assert that unmapping ranges does not leave poison behind. */
> +TEST_F(guard_pages, munmap)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr, *ptr_new1, *ptr_new2;
> +
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison first and last pages. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> +	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Assert that they are poisoned. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
> +
> +	/* Unmap them. */
> +	ASSERT_EQ(munmap(ptr, page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
> +
> +	/* Map over them.*/
> +	ptr_new1 = mmap(ptr, page_size, PROT_READ | PROT_WRITE,
> +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new1, MAP_FAILED);
> +	ptr_new2 = mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRITE,
> +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new2, MAP_FAILED);
> +
> +	/* Assert that they are now not poisoned. */
> +	ASSERT_TRUE(try_read_write_buf(ptr_new1));
> +	ASSERT_TRUE(try_read_write_buf(ptr_new2));
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that mprotect() operations have no bearing on guard poison markers. */
> +TEST_F(guard_pages, mprotect)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison the middle of the range. */
> +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> +			  MADV_GUARD_POISON), 0);
> +
> +	/* Assert that it is indeed poisoned. */
> +	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
> +
> +	/* Now make these pages read-only. */
> +	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
> +
> +	/* Make sure the range is still poisoned. */
> +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> +
> +	/* Make sure we can poison again without issue.*/
> +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> +			  MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the range is, yet again, still poisoned. */
> +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> +
> +	/* Now unpoison the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +	/* Make sure the whole range is readable. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Split and merge VMAs and make sure guard pages still behave. */
> +TEST_F(guard_pages, split_merge)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr, *ptr_new;
> +	int i;
> +
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the whole range is poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now unmap some pages in the range so we split. */
> +	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
> +
> +	/* Make sure the remaining ranges are poisoned post-split. */
> +	for (i = 0; i < 2; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +	for (i = 2; i < 5; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +	for (i = 6; i < 8; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +	for (i = 9; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now map them again - the unmap will have cleared the poison. */
> +	ptr_new = mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +	ptr_new = mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +	ptr_new = mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	/* Now make sure poisoning is as expected. */
> +	for (i = 0; i < 10; i++) {
> +		bool result = try_read_write_buf(&ptr[i * page_size]);
> +
> +		if (i == 2 || i == 5 || i == 8) {
> +			ASSERT_TRUE(result);
> +		} else {
> +			ASSERT_FALSE(result);
> +		}
> +	}
> +
> +	/* Now poison everything again. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the whole range is poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now split the range into three. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> +
> +	/* Make sure the whole range is poisoned for read. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now reset protection bits so we merge the whole thing. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> +			   PROT_READ | PROT_WRITE), 0);
> +
> +	/* Make sure the whole range is still poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Split range into 3 again... */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> +
> +	/* ...and unpoison the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +	/* Make sure the whole range is remedied for read. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Merge them again. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> +			   PROT_READ | PROT_WRITE), 0);
> +
> +	/* Now ensure the merged range is remedied for read/write. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that MADV_DONTNEED does not remove guard poison markers. */
> +TEST_F(guard_pages, dontneed)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Back the whole range. */
> +	for (i = 0; i < 10; i++) {
> +		ptr[i * page_size] = 'y';
> +	}
> +
> +	/* Poison every other page. */
> +	for (i = 0; i < 10; i += 2) {
> +		ASSERT_EQ(madvise(&ptr[i * page_size],
> +				  page_size, MADV_GUARD_POISON), 0);
> +	}
> +
> +	/* Indicate that we don't need any of the range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
> +
> +	/* Check to ensure poison markers are still in place. */
> +	for (i = 0; i < 10; i++) {
> +		bool result = try_read_buf(&ptr[i * page_size]);
> +
> +		if (i % 2 == 0) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +			/* Make sure we really did get reset to zero page. */
> +			ASSERT_EQ(ptr[i * page_size], '\0');
> +		}
> +
> +		/* Now write... */
> +		result = try_write_buf(&ptr[i * page_size]);
> +
> +		/* ...and make sure same result. */
> +		if (i % 2 == 0) {

You don't need  { here
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +		}

Same here.
  
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that mlock()'ed pages work correctly with poison markers. */
> +TEST_F(guard_pages, mlock)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Populate. */
> +	for (i = 0; i < 10; i++) {
> +		ptr[i * page_size] = 'y';
> +	}
> +
> +	/* Lock. */
> +	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
> +
> +	/* Now try to poison, should fail with EINVAL. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* OK unlock. */
> +	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
> +
> +	/* Poison first half of range, should now succeed. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure poison works. */
> +	for (i = 0; i < 10; i++) {
> +		bool result = try_read_write_buf(&ptr[i * page_size]);
> +
> +		if (i < 5) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +			ASSERT_EQ(ptr[i * page_size], 'x');
> +		}
> +	}
> +
> +	/*
> +	 * Now lock the latter part of the range. We can't lock the poisoned
> +	 * pages, as this would result in the pages being populated and the
> +	 * poisoning would cause this to error out.
> +	 */
> +	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
> +
> +	/*
> +	 * Now unpoison, we do not permit mlock()'d ranges to be remedied as it is
> +	 * a non-destructive operation.
> +	 */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +	/* Now check that everything is remedied. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retains
> + * poison markers where possible.
> + *
> + * - Moving a mapping alone should retain markers as they are.
> + */
> +TEST_F(guard_pages, mremap_move)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr, *ptr_new;
> +
> +	/* Map 5 pages. */
> +	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Place poison markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the poison is in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Map a new region we will move this range into. Doing this ensures
> +	 * that we have reserved a range to map into.
> +	 */
> +	ptr_new = mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE,
> +		       -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
> +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
> +
> +	/* Make sure the poison is retained. */
> +	ASSERT_FALSE(try_read_write_buf(ptr_new));
> +	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
> +
> +	/*
> +	 * Clean up - we only need reference the new pointer as we overwrote the
> +	 * PROT_NONE range and moved the existing one.
> +	 */
> +	munmap(ptr_new, 5 * page_size);
> +}
> +
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retains
> + * poison markers where possible.
> + *
> + * - Expanding should retain, only now in different position. The user will have
> + *   to unpoison manually to fix up (they'd have to do the same if it were a
> + *   PROT_NONE mapping)
> + */
> +TEST_F(guard_pages, mremap_expand)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr, *ptr_new;
> +
> +	/* Map 10 pages... */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	/* ...But unmap the last 5 so we can ensure we can expand into them. */
> +	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
> +
> +	/* Place poison markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the poison is in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Now expand to 10 pages. */
> +	ptr = mremap(ptr, 5 * page_size, 10 * page_size, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Make sure the poison is retained in its original positions. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Reserve a region which we can move to and expand into. */
> +	ptr_new = mmap(NULL, 20 * page_size, PROT_NONE,
> +		       MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	/* Now move and expand into it. */
> +	ptr = mremap(ptr, 10 * page_size, 20 * page_size,
> +		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
> +	ASSERT_EQ(ptr, ptr_new);
> +
> +	/* Again, make sure the poison is retained in its original
> +	 * positions. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/*
> +	 * A real user would have to unpoison, but would reasonably expect all
> +	 * characteristics of the mapping to be retained, including poison
> +	 * markers.
> +	 */
> +
> +	/* Cleanup. */
> +	munmap(ptr, 20 * page_size);
> +}
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retains
> + * poison markers where possible.
> + *
> + * - Shrinking will result in markers that are shrunk over being removed. Again,
> + *   if the user were using a PROT_NONE mapping they'd have to manually fix this
> + *   up also so this is OK.
> + */
> +TEST_F(guard_pages, mremap_shrink)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 5 pages. */
> +	ptr = mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Place poison markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_POISON), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Make sure the poison is in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Now shrink to 3 pages. */
> +	ptr = mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* We expect the poison marker at the start to be retained... */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* ...But remaining pages will not have poison markers. */
> +	for (i = 1; i < 3; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
> +	}
> +
> +	/*
> +	 * As with expansion, a real user would have to unpoison and fixup. But
> +	 * you'd have to do similar manual things with PROT_NONE mappings too.
> +	 */
> +
> +	/*
> +	 * If we expand back to the original size, the end marker will, of
> +	 * course, no longer be present.
> +	 */
> +	ptr = mremap(ptr, 3 * page_size, 5 * page_size, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Again, we expect the poison marker at the start to be retained... */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* ...But remaining pages will not have poison markers. */
> +	for (i = 1; i < 5; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i + page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	munmap(ptr, 5 * page_size);
> +}
> +
> +/*
> + * Assert that forking a process with VMAs that do not have VM_WIPEONFORK set
> + * retain guard pages.
> + */
> +TEST_F(guard_pages, fork)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	pid_t pid;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison the first 5 pages. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> +
> +	pid = fork();
> +	ASSERT_NE(pid, -1);
> +	if (!pid) {
> +		/* This is the child process now. */
> +
> +		/* Assert that the poisoning is in effect. */
> +		for (i = 0; i < 10; i++) {
> +			bool result = try_read_write_buf(&ptr[i * page_size]);
> +
> +			if (i < 5) {
> +				ASSERT_FALSE(result);
> +			} else {
> +				ASSERT_TRUE(result);
> +			}
> +		}
> +
> +		/* Now unpoison the range.*/
> +		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_UNPOISON), 0);
> +
> +		exit(0);
> +	}
> +
> +	/* Parent process. */
> +
> +	/* Parent simply waits on child. */
> +	waitpid(pid, NULL, 0);
> +
> +	/* Child unpoison does not impact parent page table state. */
> +	for (i = 0; i < 10; i++) {
> +		bool result = try_read_write_buf(&ptr[i * page_size]);
> +
> +		if (i < 5) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +		}
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/*
> + * Assert that forking a process with VMAs that do have VM_WIPEONFORK set
> + * behave as expected.
> + */
> +TEST_F(guard_pages, fork_wipeonfork)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	pid_t pid;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Mark wipe on fork. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
> +
> +	/* Poison the first 5 pages. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_POISON), 0);
> +
> +	pid = fork();
> +	ASSERT_NE(pid, -1);
> +	if (!pid) {
> +		/* This is the child process now. */
> +
> +		/* Poison will have been wiped. */
> +		for (i = 0; i < 10; i++) {
> +			ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +		}
> +
> +		exit(0);
> +	}
> +
> +	/* Parent process. */
> +
> +	waitpid(pid, NULL, 0);
> +
> +	/* Poison should be in effect.*/
> +	for (i = 0; i < 10; i++) {
> +		bool result = try_read_write_buf(&ptr[i * page_size]);
> +
> +		if (i < 5) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +		}
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that MADV_FREE frees poison entries as expected. */
> +TEST_F(guard_pages, lazyfree)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Ensure poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Lazyfree range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
> +
> +	/* This should simply clear the poison markers. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_TRUE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expected. */
> +TEST_F(guard_pages, populate)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Populate read should error out... */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_READ), -1);
> +	ASSERT_EQ(errno, EFAULT);
> +
> +	/* ...as should populate write. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_POPULATE_WRITE), -1);
> +	ASSERT_EQ(errno, EFAULT);
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove poison markers. */
> +TEST_F(guard_pages, cold_pageout)
> +{
> +	const unsigned long page_size = self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Poison range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* Ensured poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Now mark cold. This should have no impact on poison markers. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
> +
> +	/* Should remain poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* OK, now page out. This should equally, have no effect on markers. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
> +
> +	/* Should remain poisoned. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that guard pages do not break userfaultd. */
> +TEST_F(guard_pages, uffd)
> +{
> +	const unsigned long page_size = self->page_size;
> +	int uffd;
> +	char *ptr;
> +	int i;
> +	struct uffdio_api api = {
> +		.api = UFFD_API,
> +		.features = 0,
> +	};
> +	struct uffdio_register reg;
> +	struct uffdio_range range;
> +
> +	/* Set up uffd. */
> +	uffd = userfaultfd(0);
> +	if (uffd == -1 && errno == EPERM)
> +		ksft_exit_skip("No uffd permissions\n");

Same comment here about a user friendly message that say what
user shoul do

> +	ASSERT_NE(uffd, -1);
> +
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> +
> +	/* Map 10 pages. */
> +	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Register the range with uffd. */
> +	range.start = (unsigned long)ptr;
> +	range.len = 10 * page_size;
> +	reg.range = range;
> +	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
> +
> +	/* Poison the range. This should not trigger the uffd. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_POISON), 0);
> +
> +	/* The poisoning should behave as usual with no uffd intervention. */
> +	for (i = 0; i < 10; i++) {
> +		ASSERT_FALSE(try_read_write_buf(&ptr[i * page_size]));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
> +	close(uffd);
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +TEST_HARNESS_MAIN

thanks,
-- Shuah


