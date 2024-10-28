Return-Path: <linux-arch+bounces-8664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D436A9B3BE3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA991F21DF7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35A1E0DF7;
	Mon, 28 Oct 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwkFVrnN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E151E0B6E;
	Mon, 28 Oct 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147577; cv=none; b=LrkDWhR/Yk0VoXRsH7SsGcMy9ZYEPZ8211KZYQdqbiDiFfg+UGAKdFBS4BhnBaIpj1+9VZ0LAJAS+SxFySI6gTfPa6HkPXPt+oOW5FOk1g05xn7PwgJlxYxTkM9ABgeVd3McdPMUme1JpibVnWNpXzAxxlzuQEzbF/BEcMrId44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147577; c=relaxed/simple;
	bh=ArBKN8f7ZcetMO4ri0yBwc8wdghnkfSbuejFzs4Tz9Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bqWUoi/I/5mTHGutlM9uP94TOy2fIZlcUZCyE9z4EIoHDkcW6bAnlhiVvqfrovU68LaBqEdUewPWkYVyIGGAwm9UATFTK5NRwPoZwzssN4tHKjYpxpSXNzQUepU4w1iw4gXpstQz23kpKdMvFO5kGSHkIWs++IbXIhbYPi3SdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwkFVrnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F087EC4CEC3;
	Mon, 28 Oct 2024 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147576;
	bh=ArBKN8f7ZcetMO4ri0yBwc8wdghnkfSbuejFzs4Tz9Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DwkFVrnNtFLyQJ2kXfxwSPneGRGU1bk2JkWHqJC0HZBgqDEH6FwVE3QoIpeILoo9Y
	 xq7PlTcpKX60sZs9OfvspL8mlKkXGVZiL/SIUqXIrJZbPJqeuJlDTKm4zm5SxdLbit
	 G8nMs3pCzviKzuakpl/9ylp8zEcQFh8IICllXfnPsWYXPvorc3U8XxWv4qX2XqWeKf
	 qRmvX5SqxQRNy1z7/K9ojIXAa4r1It5nr6sMWna4Y9wION1KOTF4xJSQZYNcVWz/nJ
	 OhqKuvDvebpXhu5o6cIRiraPhmlRtBnIowje3I5rSlayRZdMPldwN2yWd0M26iTzBu
	 uLX3XVO0WQ3vA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 22:32:52 +0200
Message-Id: <D57Q4M9MUWEG.3CM7LQ016T6YN@kernel.org>
Cc: "Suren Baghdasaryan" <surenb@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Jann Horn" <jannh@google.com>, "David Hildenbrand"
 <david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 "Muchun Song" <muchun.song@linux.dev>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Helge Deller" <deller@gmx.de>,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, <linux-alpha@vger.kernel.org>,
 <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux-kselftest@vger.kernel.org>,
 "Sidhartha Kumar" <sidhartha.kumar@oracle.com>, "Jeff Xu"
 <jeffxu@chromium.org>, "Christoph Hellwig" <hch@infradead.org>,
 <linux-api@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 5/5] selftests/mm: add self tests for guard page
 feature
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <53efeca2f9db78f7accbeb721106f5786fec9e90.1729699916.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <53efeca2f9db78f7accbeb721106f5786fec9e90.1729699916.git.lorenzo.stoakes@oracle.com>

On Wed Oct 23, 2024 at 7:24 PM EEST, Lorenzo Stoakes wrote:
> Utilise the kselftest harmness to implement tests for the guard page
> implementation.
>
> We start by implement basic tests asserting that guard pages can be
> installed, removed and that touching guard pages result in SIGSEGV. We al=
so
> assert that, in removing guard pages from a range, non-guard pages remain
> intact.
>
> We then examine different operations on regions containing guard markers
> behave to ensure correct behaviour:
>
> * Operations over multiple VMAs operate as expected.
> * Invoking MADV_GUARD_INSTALL / MADV_GUARD_REMOVE via process_madvise() i=
n
>   batches works correctly.
> * Ensuring that munmap() correctly tears down guard markers.
> * Using mprotect() to adjust protection bits does not in any way override
>   or cause issues with guard markers.
> * Ensuring that splitting and merging VMAs around guard markers causes no
>   issue - i.e. that a marker which 'belongs' to one VMA can function just
>   as well 'belonging' to another.
> * Ensuring that madvise(..., MADV_DONTNEED) and madvise(..., MADV_FREE)
>   do not remove guard markers.
> * Ensuring that mlock()'ing a range containing guard markers does not
>   cause issues.
> * Ensuring that mremap() can move a guard range and retain guard markers.
> * Ensuring that mremap() can expand a guard range and retain guard
>   markers (perhaps moving the range).
> * Ensuring that mremap() can shrink a guard range and retain guard marker=
s.
> * Ensuring that forking a process correctly retains guard markers.
> * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> * Ensuring that lazyfree simply clears guard markers.
> * Ensuring that userfaultfd can co-exist with guard pages.
> * Ensuring that madvise(..., MADV_POPULATE_READ) and
>   madvise(..., MADV_POPULATE_WRITE) error out when encountering
>   guard markers.
> * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
>   not remove guard markers.
>
> If any test is unable to be run due to lack of permissions, that test is
> skipped.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/.gitignore    |    1 +
>  tools/testing/selftests/mm/Makefile      |    1 +
>  tools/testing/selftests/mm/guard-pages.c | 1239 ++++++++++++++++++++++
>  3 files changed, 1241 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/guard-pages.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selfte=
sts/mm/.gitignore
> index 689bbd520296..8f01f4da1c0d 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -54,3 +54,4 @@ droppable
>  hugetlb_dio
>  pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
> +guard-pages
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index 02e1204971b0..15c734d6cfec 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -79,6 +79,7 @@ TEST_GEN_FILES +=3D hugetlb_fault_after_madv
>  TEST_GEN_FILES +=3D hugetlb_madv_vs_map
>  TEST_GEN_FILES +=3D hugetlb_dio
>  TEST_GEN_FILES +=3D droppable
> +TEST_GEN_FILES +=3D guard-pages
> =20
>  ifneq ($(ARCH),arm64)
>  TEST_GEN_FILES +=3D soft-dirty
> diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/sel=
ftests/mm/guard-pages.c
> new file mode 100644
> index 000000000000..7db9c913e9db
> --- /dev/null
> +++ b/tools/testing/selftests/mm/guard-pages.c
> @@ -0,0 +1,1239 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <asm-generic/mman.h> /* Force the import of the tools version. =
*/
> +#include <assert.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/userfaultfd.h>
> +#include <setjmp.h>
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
> +/*
> + * Ignore the checkpatch warning, as per the C99 standard, section 7.14.=
1.1:
> + *
> + * "If the signal occurs other than as the result of calling the abort o=
r raise
> + *  function, the behavior is undefined if the signal handler refers to =
any
> + *  object with static storage duration other than by assigning a value =
to an
> + *  object declared as volatile sig_atomic_t"
> + */
> +static volatile sig_atomic_t signal_jump_set;
> +static sigjmp_buf signal_jmp_buf;
> +
> +/*
> + * Ignore the checkpatch warning, we must read from x but don't want to =
do
> + * anything with it in order to trigger a read page fault. We therefore =
must use
> + * volatile to stop the compiler from optimising this away.
> + */
> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
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
> + * Enable our signal catcher and try to read/write the specified buffer.=
 The
> + * return value indicates whether the read/write succeeds without a fata=
l
> + * signal.
> + */
> +static bool try_access_buf(char *ptr, bool write)
> +{
> +	bool failed;
> +
> +	/* Tell signal handler to jump back here on fatal signal. */
> +	signal_jump_set =3D true;
> +	/* If a fatal signal arose, we will jump back here and failed is set. *=
/
> +	failed =3D sigsetjmp(signal_jmp_buf, 0) !=3D 0;
> +
> +	if (!failed) {
> +		if (write)
> +			*ptr =3D 'x';
> +		else
> +			FORCE_READ(ptr);
> +	}
> +
> +	signal_jump_set =3D false;
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
> + * Try and BOTH read from AND write to a buffer, return true if BOTH ope=
rations
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
> +	struct sigaction act =3D {
> +		.sa_handler =3D &handle_fatal,
> +		.sa_flags =3D SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	if (sigaction(SIGSEGV, &act, NULL))
> +		ksft_exit_fail_perror("sigaction");
> +
> +	self->page_size =3D (unsigned long)sysconf(_SC_PAGESIZE);
> +};
> +
> +FIXTURE_TEARDOWN(guard_pages)
> +{
> +	struct sigaction act =3D {
> +		.sa_handler =3D SIG_DFL,
> +		.sa_flags =3D SA_NODEFER,
> +	};
> +
> +	sigemptyset(&act.sa_mask);
> +	sigaction(SIGSEGV, &act, NULL);
> +}
> +
> +TEST_F(guard_pages, basic)
> +{
> +	const unsigned long NUM_PAGES =3D 10;
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr =3D mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANON, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Trivially assert we can touch the first page. */
> +	ASSERT_TRUE(try_read_write_buf(ptr));
> +
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Establish that 1st page SIGSEGV's. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* Ensure we can touch everything else.*/
> +	for (i =3D 1; i < NUM_PAGES; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Establish a guard page at the end of the mapping. */
> +	ASSERT_EQ(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> +			  MADV_GUARD_INSTALL), 0);
> +
> +	/* Check that both guard pages result in SIGSEGV. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> +
> +	/* Remove the first guard page. */
> +	ASSERT_FALSE(madvise(ptr, page_size, MADV_GUARD_REMOVE));
> +
> +	/* Make sure we can touch it. */
> +	ASSERT_TRUE(try_read_write_buf(ptr));
> +
> +	/* Remove the last guard page. */
> +	ASSERT_FALSE(madvise(&ptr[(NUM_PAGES - 1) * page_size], page_size,
> +			     MADV_GUARD_REMOVE));
> +
> +	/* Make sure we can touch it. */
> +	ASSERT_TRUE(try_read_write_buf(&ptr[(NUM_PAGES - 1) * page_size]));
> +
> +	/*
> +	 *  Test setting a _range_ of pages, namely the first 3. The first of
> +	 *  these be faulted in, so this also tests that we can install guard
> +	 *  pages over backed pages.
> +	 */
> +	ASSERT_EQ(madvise(ptr, 3 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Make sure they are all guard pages. */
> +	for (i =3D 0; i < 3; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Make sure the rest are not. */
> +	for (i =3D 3; i < NUM_PAGES; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Remove guard pages. */
> +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_REMOVE), 0);
> +
> +	/* Now make sure we can touch everything. */
> +	for (i =3D 0; i < NUM_PAGES; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/*
> +	 * Now remove all guard pages, make sure we don't remove existing
> +	 * entries.
> +	 */
> +	ASSERT_EQ(madvise(ptr, NUM_PAGES * page_size, MADV_GUARD_REMOVE), 0);
> +
> +	for (i =3D 0; i < NUM_PAGES * page_size; i +=3D page_size) {
> +		char chr =3D ptr[i];
> +
> +		ASSERT_EQ(chr, 'x');
> +	}
> +
> +	ASSERT_EQ(munmap(ptr, NUM_PAGES * page_size), 0);
> +}
> +
> +/* Assert that operations applied across multiple VMAs work as expected.=
 */
> +TEST_F(guard_pages, multi_vma)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr_region, *ptr, *ptr1, *ptr2, *ptr3;
> +	int i;
> +
> +	/* Reserve a 100 page region over which we can install VMAs. */
> +	ptr_region =3D mmap(NULL, 100 * page_size, PROT_NONE,
> +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_region, MAP_FAILED);
> +
> +	/* Place a VMA of 10 pages size at the start of the region. */
> +	ptr1 =3D mmap(ptr_region, 10 * page_size, PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr1, MAP_FAILED);
> +
> +	/* Place a VMA of 5 pages size 50 pages into the region. */
> +	ptr2 =3D mmap(&ptr_region[50 * page_size], 5 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +
> +	/* Place a VMA of 20 pages size at the end of the region. */
> +	ptr3 =3D mmap(&ptr_region[80 * page_size], 20 * page_size,
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
> +	/*
> +	 * Now mark the whole range as guard pages and make sure all VMAs are a=
s
> +	 * such.
> +	 */
> +
> +	/*
> +	 * madvise() is certifiable and lets you perform operations over gaps,
> +	 * everything works, but it indicates an error and errno is set to
> +	 * -ENOMEM. Also if anything runs out of memory it is set to
> +	 * -ENOMEM. You are meant to guess which is which.
> +	 */
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_INSTALL), -1)=
;
> +	ASSERT_EQ(errno, ENOMEM);
> +
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr1[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	for (i =3D 0; i < 5; i++) {
> +		char *curr =3D &ptr2[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	for (i =3D 0; i < 20; i++) {
> +		char *curr =3D &ptr3[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now remove guar pages over range and assert the opposite. */
> +
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_REMOVE), -1);
> +	ASSERT_EQ(errno, ENOMEM);
> +
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr1[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	for (i =3D 0; i < 5; i++) {
> +		char *curr =3D &ptr2[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	for (i =3D 0; i < 20; i++) {
> +		char *curr =3D &ptr3[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now map incompatible VMAs in the gaps. */
> +	ptr =3D mmap(&ptr_region[10 * page_size], 40 * page_size,
> +		   PROT_READ | PROT_WRITE | PROT_EXEC,
> +		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	ptr =3D mmap(&ptr_region[55 * page_size], 25 * page_size,
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
> +	 * Where 'x' signifies VMAs that cannot be merged with those adjacent t=
o
> +	 * them.
> +	 */
> +
> +	/* Multiple VMAs adjacent to one another should result in no error. */
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_INSTALL), 0);
> +	for (i =3D 0; i < 100; i++) {
> +		char *curr =3D &ptr_region[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +	ASSERT_EQ(madvise(ptr_region, 100 * page_size, MADV_GUARD_REMOVE), 0);
> +	for (i =3D 0; i < 100; i++) {
> +		char *curr =3D &ptr_region[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr_region, 100 * page_size), 0);
> +}
> +
> +/*
> + * Assert that batched operations performed using process_madvise() work=
 as
> + * expected.
> + */
> +TEST_F(guard_pages, process_madvise)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	pid_t pid =3D getpid();
> +	int pidfd =3D pidfd_open(pid, 0);
> +	char *ptr_region, *ptr1, *ptr2, *ptr3;
> +	ssize_t count;
> +	struct iovec vec[6];
> +
> +	ASSERT_NE(pidfd, -1);
> +
> +	/* Reserve region to map over. */
> +	ptr_region =3D mmap(NULL, 100 * page_size, PROT_NONE,
> +			  MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_region, MAP_FAILED);
> +
> +	/* 10 pages offset 1 page into reserve region. */
> +	ptr1 =3D mmap(&ptr_region[page_size], 10 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr1, MAP_FAILED);
> +	/* We want guard markers at start/end of each VMA. */
> +	vec[0].iov_base =3D ptr1;
> +	vec[0].iov_len =3D page_size;
> +	vec[1].iov_base =3D &ptr1[9 * page_size];
> +	vec[1].iov_len =3D page_size;
> +
> +	/* 5 pages offset 50 pages into reserve region. */
> +	ptr2 =3D mmap(&ptr_region[50 * page_size], 5 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +	vec[2].iov_base =3D ptr2;
> +	vec[2].iov_len =3D page_size;
> +	vec[3].iov_base =3D &ptr2[4 * page_size];
> +	vec[3].iov_len =3D page_size;
> +
> +	/* 20 pages offset 79 pages into reserve region. */
> +	ptr3 =3D mmap(&ptr_region[79 * page_size], 20 * page_size,
> +		    PROT_READ | PROT_WRITE,
> +		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr3, MAP_FAILED);
> +	vec[4].iov_base =3D ptr3;
> +	vec[4].iov_len =3D page_size;
> +	vec[5].iov_base =3D &ptr3[19 * page_size];
> +	vec[5].iov_len =3D page_size;
> +
> +	/* Free surrounding VMAs. */
> +	ASSERT_EQ(munmap(ptr_region, page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[11 * page_size], 39 * page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[55 * page_size], 24 * page_size), 0);
> +	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
> +
> +	/* Now guard in one step. */
> +	count =3D process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
> +
> +	/* OK we don't have permission to do this, skip. */
> +	if (count =3D=3D -1 && errno =3D=3D EPERM)
> +		ksft_exit_skip("No process_madvise() permissions, try running as root.=
\n");
> +
> +	/* Returns the number of bytes advised. */
> +	ASSERT_EQ(count, 6 * page_size);
> +
> +	/* Now make sure the guarding was applied. */
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
> +	/* Now do the same with unguard... */
> +	count =3D process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
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
> +/* Assert that unmapping ranges does not leave guard markers behind. */
> +TEST_F(guard_pages, munmap)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr, *ptr_new1, *ptr_new2;
> +
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard first and last pages. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +	ASSERT_EQ(madvise(&ptr[9 * page_size], page_size, MADV_GUARD_INSTALL), =
0);
> +
> +	/* Assert that they are guarded. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[9 * page_size]));
> +
> +	/* Unmap them. */
> +	ASSERT_EQ(munmap(ptr, page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[9 * page_size], page_size), 0);
> +
> +	/* Map over them.*/
> +	ptr_new1 =3D mmap(ptr, page_size, PROT_READ | PROT_WRITE,
> +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new1, MAP_FAILED);
> +	ptr_new2 =3D mmap(&ptr[9 * page_size], page_size, PROT_READ | PROT_WRIT=
E,
> +			MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new2, MAP_FAILED);
> +
> +	/* Assert that they are now not guarded. */
> +	ASSERT_TRUE(try_read_write_buf(ptr_new1));
> +	ASSERT_TRUE(try_read_write_buf(ptr_new2));
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that mprotect() operations have no bearing on guard markers. *=
/
> +TEST_F(guard_pages, mprotect)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard the middle of the range. */
> +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> +			  MADV_GUARD_INSTALL), 0);
> +
> +	/* Assert that it is indeed guarded. */
> +	ASSERT_FALSE(try_read_write_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[6 * page_size]));
> +
> +	/* Now make these pages read-only. */
> +	ASSERT_EQ(mprotect(&ptr[5 * page_size], 2 * page_size, PROT_READ), 0);
> +
> +	/* Make sure the range is still guarded. */
> +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> +
> +	/* Make sure we can guard again without issue.*/
> +	ASSERT_EQ(madvise(&ptr[5 * page_size], 2 * page_size,
> +			  MADV_GUARD_INSTALL), 0);
> +
> +	/* Make sure the range is, yet again, still guarded. */
> +	ASSERT_FALSE(try_read_buf(&ptr[5 * page_size]));
> +	ASSERT_FALSE(try_read_buf(&ptr[6 * page_size]));
> +
> +	/* Now unguard the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
> +
> +	/* Make sure the whole range is readable. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Split and merge VMAs and make sure guard pages still behave. */
> +TEST_F(guard_pages, split_merge)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr, *ptr_new;
> +	int i;
> +
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Make sure the whole range is guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now unmap some pages in the range so we split. */
> +	ASSERT_EQ(munmap(&ptr[2 * page_size], page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[5 * page_size], page_size), 0);
> +	ASSERT_EQ(munmap(&ptr[8 * page_size], page_size), 0);
> +
> +	/* Make sure the remaining ranges are guarded post-split. */
> +	for (i =3D 0; i < 2; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +	for (i =3D 2; i < 5; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +	for (i =3D 6; i < 8; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +	for (i =3D 9; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now map them again - the unmap will have cleared the guards. */
> +	ptr_new =3D mmap(&ptr[2 * page_size], page_size, PROT_READ | PROT_WRITE=
,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +	ptr_new =3D mmap(&ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE=
,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +	ptr_new =3D mmap(&ptr[8 * page_size], page_size, PROT_READ | PROT_WRITE=
,
> +		       MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	/* Now make sure guard pages are established. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +		bool result =3D try_read_write_buf(curr);
> +		bool expect_true =3D i =3D=3D 2 || i =3D=3D 5 || i =3D=3D 8;
> +
> +		ASSERT_TRUE(expect_true ? result : !result);
> +	}
> +
> +	/* Now guard everything again. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Make sure the whole range is guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now split the range into three. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> +
> +	/* Make sure the whole range is guarded for read. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_buf(curr));
> +	}
> +
> +	/* Now reset protection bits so we merge the whole thing. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> +			   PROT_READ | PROT_WRITE), 0);
> +
> +	/* Make sure the whole range is still guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Split range into 3 again... */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size, PROT_READ), 0);
> +
> +	/* ...and unguard the whole range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
> +
> +	/* Make sure the whole range is remedied for read. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_buf(curr));
> +	}
> +
> +	/* Merge them again. */
> +	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ | PROT_WRITE), 0);
> +	ASSERT_EQ(mprotect(&ptr[7 * page_size], 3 * page_size,
> +			   PROT_READ | PROT_WRITE), 0);
> +
> +	/* Now ensure the merged range is remedied for read/write. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that MADV_DONTNEED does not remove guard markers. */
> +TEST_F(guard_pages, dontneed)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Back the whole range. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		*curr =3D 'y';
> +	}
> +
> +	/* Guard every other page. */
> +	for (i =3D 0; i < 10; i +=3D 2) {
> +		char *curr =3D &ptr[i * page_size];
> +		int res =3D madvise(curr, page_size, MADV_GUARD_INSTALL);
> +
> +		ASSERT_EQ(res, 0);
> +	}
> +
> +	/* Indicate that we don't need any of the range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_DONTNEED), 0);
> +
> +	/* Check to ensure guard markers are still in place. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +		bool result =3D try_read_buf(curr);
> +
> +		if (i % 2 =3D=3D 0) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +			/* Make sure we really did get reset to zero page. */
> +			ASSERT_EQ(*curr, '\0');
> +		}
> +
> +		/* Now write... */
> +		result =3D try_write_buf(&ptr[i * page_size]);
> +
> +		/* ...and make sure same result. */
> +		ASSERT_TRUE(i % 2 !=3D 0 ? result : !result);
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Assert that mlock()'ed pages work correctly with guard markers. */
> +TEST_F(guard_pages, mlock)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Populate. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		*curr =3D 'y';
> +	}
> +
> +	/* Lock. */
> +	ASSERT_EQ(mlock(ptr, 10 * page_size), 0);
> +
> +	/* Now try to guard, should fail with EINVAL. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), -1);
> +	ASSERT_EQ(errno, EINVAL);
> +
> +	/* OK unlock. */
> +	ASSERT_EQ(munlock(ptr, 10 * page_size), 0);
> +
> +	/* Guard first half of range, should now succeed. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Make sure guard works. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +		bool result =3D try_read_write_buf(curr);
> +
> +		if (i < 5) {
> +			ASSERT_FALSE(result);
> +		} else {
> +			ASSERT_TRUE(result);
> +			ASSERT_EQ(*curr, 'x');
> +		}
> +	}
> +
> +	/*
> +	 * Now lock the latter part of the range. We can't lock the guard pages=
,
> +	 * as this would result in the pages being populated and the guarding
> +	 * would cause this to error out.
> +	 */
> +	ASSERT_EQ(mlock(&ptr[5 * page_size], 5 * page_size), 0);
> +
> +	/*
> +	 * Now remove guard pages, we permit mlock()'d ranges to have guard
> +	 * pages removed as it is a non-destructive operation.
> +	 */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
> +
> +	/* Now check that no guard pages remain. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retai=
ns
> + * guard markers where possible.
> + *
> + * - Moving a mapping alone should retain markers as they are.
> + */
> +TEST_F(guard_pages, mremap_move)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr, *ptr_new;
> +
> +	/* Map 5 pages. */
> +	ptr =3D mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Place guard markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), =
0);
> +
> +	/* Make sure the guard pages are in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Map a new region we will move this range into. Doing this ensures
> +	 * that we have reserved a range to map into.
> +	 */
> +	ptr_new =3D mmap(NULL, 5 * page_size, PROT_NONE, MAP_ANON | MAP_PRIVATE=
,
> +		       -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	ASSERT_EQ(mremap(ptr, 5 * page_size, 5 * page_size,
> +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new), ptr_new);
> +
> +	/* Make sure the guard markers are retained. */
> +	ASSERT_FALSE(try_read_write_buf(ptr_new));
> +	ASSERT_FALSE(try_read_write_buf(&ptr_new[4 * page_size]));
> +
> +	/*
> +	 * Clean up - we only need reference the new pointer as we overwrote th=
e
> +	 * PROT_NONE range and moved the existing one.
> +	 */
> +	munmap(ptr_new, 5 * page_size);
> +}
> +
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retai=
ns
> + * guard markers where possible.
> + *
> + * Expanding should retain guard pages, only now in different position. =
The user
> + * will have to remove guard pages manually to fix up (they'd have to do=
 the
> + * same if it were a PROT_NONE mapping).
> + */
> +TEST_F(guard_pages, mremap_expand)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr, *ptr_new;
> +
> +	/* Map 10 pages... */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +	/* ...But unmap the last 5 so we can ensure we can expand into them. */
> +	ASSERT_EQ(munmap(&ptr[5 * page_size], 5 * page_size), 0);
> +
> +	/* Place guard markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), =
0);
> +
> +	/* Make sure the guarding is in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Now expand to 10 pages. */
> +	ptr =3D mremap(ptr, 5 * page_size, 10 * page_size, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/*
> +	 * Make sure the guard markers are retained in their original positions=
.
> +	 */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Reserve a region which we can move to and expand into. */
> +	ptr_new =3D mmap(NULL, 20 * page_size, PROT_NONE,
> +		       MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr_new, MAP_FAILED);
> +
> +	/* Now move and expand into it. */
> +	ptr =3D mremap(ptr, 10 * page_size, 20 * page_size,
> +		     MREMAP_MAYMOVE | MREMAP_FIXED, ptr_new);
> +	ASSERT_EQ(ptr, ptr_new);
> +
> +	/*
> +	 * Again, make sure the guard markers are retained in their original po=
sitions.
> +	 */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/*
> +	 * A real user would have to remove guard markers, but would reasonably
> +	 * expect all characteristics of the mapping to be retained, including
> +	 * guard markers.
> +	 */
> +
> +	/* Cleanup. */
> +	munmap(ptr, 20 * page_size);
> +}
> +/*
> + * Assert that moving, extending and shrinking memory via mremap() retai=
ns
> + * guard markers where possible.
> + *
> + * Shrinking will result in markers that are shrunk over being removed. =
Again,
> + * if the user were using a PROT_NONE mapping they'd have to manually fi=
x this
> + * up also so this is OK.
> + */
> +TEST_F(guard_pages, mremap_shrink)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 5 pages. */
> +	ptr =3D mmap(NULL, 5 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Place guard markers at both ends of the 5 page span. */
> +	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
> +	ASSERT_EQ(madvise(&ptr[4 * page_size], page_size, MADV_GUARD_INSTALL), =
0);
> +
> +	/* Make sure the guarding is in effect. */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +	ASSERT_FALSE(try_read_write_buf(&ptr[4 * page_size]));
> +
> +	/* Now shrink to 3 pages. */
> +	ptr =3D mremap(ptr, 5 * page_size, 3 * page_size, MREMAP_MAYMOVE);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* We expect the guard marker at the start to be retained... */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* ...But remaining pages will not have guard markers. */
> +	for (i =3D 1; i < 3; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/*
> +	 * As with expansion, a real user would have to remove guard pages and
> +	 * fixup. But you'd have to do similar manual things with PROT_NONE
> +	 * mappings too.
> +	 */
> +
> +	/*
> +	 * If we expand back to the original size, the end marker will, of
> +	 * course, no longer be present.
> +	 */
> +	ptr =3D mremap(ptr, 3 * page_size, 5 * page_size, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Again, we expect the guard marker at the start to be retained... */
> +	ASSERT_FALSE(try_read_write_buf(ptr));
> +
> +	/* ...But remaining pages will not have guard markers. */
> +	for (i =3D 1; i < 5; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_TRUE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	munmap(ptr, 5 * page_size);
> +}
> +
> +/*
> + * Assert that forking a process with VMAs that do not have VM_WIPEONFOR=
K set
> + * retain guard pages.
> + */
> +TEST_F(guard_pages, fork)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	pid_t pid;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Establish guard apges in the first 5 pages. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	pid =3D fork();
> +	ASSERT_NE(pid, -1);
> +	if (!pid) {
> +		/* This is the child process now. */
> +
> +		/* Assert that the guarding is in effect. */
> +		for (i =3D 0; i < 10; i++) {
> +			char *curr =3D &ptr[i * page_size];
> +			bool result =3D try_read_write_buf(curr);
> +
> +			ASSERT_TRUE(i >=3D 5 ? result : !result);
> +		}
> +
> +		/* Now unguard the range.*/
> +		ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
> +
> +		exit(0);
> +	}
> +
> +	/* Parent process. */
> +
> +	/* Parent simply waits on child. */
> +	waitpid(pid, NULL, 0);
> +
> +	/* Child unguard does not impact parent page table state. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +		bool result =3D try_read_write_buf(curr);
> +
> +		ASSERT_TRUE(i >=3D 5 ? result : !result);
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/*
> + * Assert that forking a process with VMAs that do have VM_WIPEONFORK se=
t
> + * behave as expected.
> + */
> +TEST_F(guard_pages, fork_wipeonfork)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	pid_t pid;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Mark wipe on fork. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_WIPEONFORK), 0);
> +
> +	/* Guard the first 5 pages. */
> +	ASSERT_EQ(madvise(ptr, 5 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	pid =3D fork();
> +	ASSERT_NE(pid, -1);
> +	if (!pid) {
> +		/* This is the child process now. */
> +
> +		/* Guard will have been wiped. */
> +		for (i =3D 0; i < 10; i++) {
> +			char *curr =3D &ptr[i * page_size];
> +
> +			ASSERT_TRUE(try_read_write_buf(curr));
> +		}
> +
> +		exit(0);
> +	}
> +
> +	/* Parent process. */
> +
> +	waitpid(pid, NULL, 0);
> +
> +	/* Guard markers should be in effect.*/
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +		bool result =3D try_read_write_buf(curr);
> +
> +		ASSERT_TRUE(i >=3D 5 ? result : !result);
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that MADV_FREE retains guard entries as expected. */
> +TEST_F(guard_pages, lazyfree)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Ensure guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Lazyfree range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_FREE), 0);
> +
> +	/* This should leave the guard markers in place. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that MADV_POPULATE_READ, MADV_POPULATE_WRITE behave as expecte=
d. */
> +TEST_F(guard_pages, populate)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
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
> +/* Ensure that MADV_COLD, MADV_PAGEOUT do not remove guard markers. */
> +TEST_F(guard_pages, cold_pageout)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	char *ptr;
> +	int i;
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Guard range. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* Ensured guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Now mark cold. This should have no impact on guard markers. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_COLD), 0);
> +
> +	/* Should remain guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* OK, now page out. This should equally, have no effect on markers. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
> +
> +	/* Should remain guarded. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +/* Ensure that guard pages do not break userfaultd. */
> +TEST_F(guard_pages, uffd)
> +{
> +	const unsigned long page_size =3D self->page_size;
> +	int uffd;
> +	char *ptr;
> +	int i;
> +	struct uffdio_api api =3D {
> +		.api =3D UFFD_API,
> +		.features =3D 0,
> +	};
> +	struct uffdio_register reg;
> +	struct uffdio_range range;
> +
> +	/* Set up uffd. */
> +	uffd =3D userfaultfd(0);
> +	if (uffd =3D=3D -1 && errno =3D=3D EPERM)
> +		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
> +	ASSERT_NE(uffd, -1);
> +
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
> +
> +	/* Map 10 pages. */
> +	ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> +		   MAP_ANON | MAP_PRIVATE, -1, 0);
> +	ASSERT_NE(ptr, MAP_FAILED);
> +
> +	/* Register the range with uffd. */
> +	range.start =3D (unsigned long)ptr;
> +	range.len =3D 10 * page_size;
> +	reg.range =3D range;
> +	reg.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
> +
> +	/* Guard the range. This should not trigger the uffd. */
> +	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_INSTALL), 0);
> +
> +	/* The guarding should behave as usual with no uffd intervention. */
> +	for (i =3D 0; i < 10; i++) {
> +		char *curr =3D &ptr[i * page_size];
> +
> +		ASSERT_FALSE(try_read_write_buf(curr));
> +	}
> +
> +	/* Cleanup. */
> +	ASSERT_EQ(ioctl(uffd, UFFDIO_UNREGISTER, &range), 0);
> +	close(uffd);
> +	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
> +}
> +
> +TEST_HARNESS_MAIN

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

