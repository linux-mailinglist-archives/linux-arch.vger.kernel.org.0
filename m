Return-Path: <linux-arch+bounces-11337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81184A8128A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE227A52DF
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1B188CDB;
	Tue,  8 Apr 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9QSCPFK"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11151DE3A9;
	Tue,  8 Apr 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130310; cv=none; b=VEbyMzpcA1kGoM0Tr8ry8Hn/yTf1Wu1U60ktuqnixNZAVsbJq8vAeAD/VajV1SxDh3Q4W096/PKGmAnJfxh/FfcO9Ow22kRyc/KZOsc6v/+KcKFuXCcPSyyKG26Mz8FO21LLOTKiD/f2KwHoMKLH1HLtvj3dxNIMrYYmX6sFlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130310; c=relaxed/simple;
	bh=+eU1l90ug4VLQCFWctk77ffIqdBjl5mOtKRYScVzcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnORTq08n62xVm8gZiIBfYq8gM5hoUmb/322x1y7Kmxn51e7mxQrcREB69bhYz/N5vCAwRFXzfitD4ejBtpUZKaO/sKqmvHTJ9qg/xQfe1+ZoLSIaOqUBDurSBWlw6WvR2bW0T8bKYlGsLEatfLU7W9EIN4nXUzeadsFzNnfTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t9QSCPFK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8c5kGuEjzUrixCQz8SJfmiMTtSSZ6M/pup07QMbIZo=; b=t9QSCPFKWRX+IEXLLTG7nFPvtv
	qDrwtyW8ndHz9ADtdBvDwK9R1/b7GawfLb9Ry+HoJokPfkHZsWEY8kmm+jpBlq6UtOttGJYiUw7RR
	YQcU45qxxKziWZ2wo5RrV8K7L++OSyA0Pg6W4VCgKFlOrXroMKnLYbVxn6C0iXMlaNBqc55NZ+7ry
	DAQLC5cv7ugIBp7R5NUNcrnkv6P4QXcnyZrwaQNIPaFmW3FgZted7FwYDS5UBdqKAJDVf5IQeUvr3
	Gezyf9Lp+/2LMaVmh9DL4kYQDtD4GOp47bbpeRMV5gu/qNM87gpbm6R4yQ33Abl/XS2ElP+tzf6AO
	XyawnGVw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2Bx2-0000000GpOB-0hye;
	Tue, 08 Apr 2025 16:37:28 +0000
Date: Tue, 8 Apr 2025 17:37:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 02/12] x86: pgtable: Always use pte_free_kernel()
Message-ID: <Z_VQxyqkU8DV7QGy@casper.infradead.org>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
 <20250408095222.860601-3-kevin.brodsky@arm.com>
 <409d2019-a409-4e97-a16f-6b345b0f5a38@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409d2019-a409-4e97-a16f-6b345b0f5a38@intel.com>

On Tue, Apr 08, 2025 at 08:22:47AM -0700, Dave Hansen wrote:
> Are there any tests for folio_test_pgtable() at free_page() time? If we
> had that, it would make it less likely that another free_page() user
> could sneak in without calling the destructor.

It's hidden, but yes:

static inline bool page_expected_state(struct page *page,
                                        unsigned long check_flags)
{
        if (unlikely(atomic_read(&page->_mapcount) != -1))
                return false;

PageTable uses page_type which aliases with mapcount, so this check
covers "PageTable is still set when the last refcount to it is put".

I don't think we really use the page refcount when allocating/freeing
page tables.  Anyone want to try switching it over to using
alloc_frozen_pages() / free_frozen_pages()?  Might need to move that API
out of mm/internal.h ...

