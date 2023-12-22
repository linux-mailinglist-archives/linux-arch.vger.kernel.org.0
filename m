Return-Path: <linux-arch+bounces-1159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731A81C4D2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 06:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7223283082
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A6611B;
	Fri, 22 Dec 2023 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3DUILVz5"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EB79C4;
	Fri, 22 Dec 2023 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mANM6RUEEd5RIcHHpg3Hi1iLZpC1YP27KzcxuzjOh/Y=; b=3DUILVz5D+yojTQiI8YhKFDEes
	RkuBVNdqwSfU/ewrJeUGXNbrBWrdCRZ5akxQPW82mqBSsLTwSSr1P+ahAMZ6je0Odj6ntomwSu/+7
	+O+pCgjbsd5ej0oJp3flIEhRQ17EKu8pqDnfEWzpIBUC0xXBJWwcUb6CWyTCVp8GVK4JMJIZUQjkr
	jUFIBrAoCXnOf8txjXVcGMc3tQOh1e08qlG9YCAfgz1HvvCVuq0mPdvm+CtcX/Z5HXxVOvAWhz7Vl
	+yMKBe6abozVqg81Rylf3xOpcu/OZ7qMC4v757bQuY49AoPbLZ0gonzDqKIHm6m1DxIVTIt17gms9
	A549XPhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYYp-0052LL-1D;
	Fri, 22 Dec 2023 05:59:03 +0000
Date: Thu, 21 Dec 2023 21:59:03 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Message-ID: <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122221814.139916-3-deller@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Nov 22, 2023 at 11:18:12PM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
> 64-bit pointers into the __ksymtab* sections.
> Make sure that those sections will be correctly aligned at module link time,
> otherwise unaligned memory accesses may happen at runtime.

The ramifications are not explained there. You keep sending me patches
with this and we keep doing a nose dive on this. It means I have to do
more work. So as I had suggested with your patch which I merged in
commit 87c482bdfa79 ("modules: Ensure natural alignment for
.altinstructions and __bug_table sections") please clarify the
impact of not merging this patch. Also last time you noticed the
misalignment due to a faulty exception handler, please mention how
you found this out now.

And since this is not your first patch on the exact related subject
I'd appreciate if you can show me perf stat results differences between
having and not having this patch merged. Why? Because we talk about
a performance penalthy, but we are not saying how much, and since this
is an ongoing thing, we might as well have a tool belt with ways to
measure such performance impact to bring clarity and value to this
and future related patches.

> The __kcrctab* sections store 32-bit entities, so use ALIGN(4) for those.

I've given some thought about how to test this. Sadly perf kallsysms
just opens the /proc/kallsysms file, but that's fine, we need our own
test.

I think a 3 new simple modules selftest would do it and running perf
stat on it. One module, let us call it module A which constructs its own
name space prefix for its exported symbols and has tons of silly symbols
for arbitrary data, whatever. We then have module B which refers to a
few arbitrary symbols from module A, hopefully spread out linearly, so
if module A had 10,000 symbols, we'd have module A refer to a symbol
ever 1,000 symbols. Finally we want a symbol C which has say, 50,000
symbols all of which will not be used at all by the first two modules,
but the selftest will load module C first, prior to calling modprobe B.

We'll stress test this way two calls which use find_symbol():

1) Upon load of B it will trigger simplify_symbols() to look for the
symbol it uses from the module A with tons of symbols. That's an
indirect way for us to call resolve_symbol_wait() from module A without
having to use symbol_get() which want to remove as exported as it is
just a hack which should go away. Our goal is for us to test
resolve_symbol() which will call find_symbol() and that will eventually
look for the symbol on module A with:

  find_exported_symbol_in_section()

That uses bsearch() so a binary search for the symbol and we'd end up
hitting the misalignments here. Binary search will at worst be O(log(n))
and so the only way to aggreviate the search will be to add tons of
symbols to A, and have B use a few of them.

2) When you load B, userspace will at first load A as depmod will inform
userspace A goes before B. Upon B's load towards the end right before
we call module B's init routine we get complete_formation() called on
the module. That will first check for duplicate symbols with the call
to verify_exported_symbols(). That is when we'll force iteration on
module C's insane symbol list.

The selftests just runs

perf stat -e pick-your-poison-for-misalignments tools/testing/selftests/kmod/ksymtab.sh

Where ksymtab.sh is your new script which calls:

modprobe C
modprobe B

I say pick-your-poison-for-misalignments because I am not sure what is
best here.

Thoughts?

> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: <stable@vger.kernel.org> # v6.0+

That's a stretch without any data, don't you think?

 Luis

