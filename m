Return-Path: <linux-arch+bounces-12031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA0ABE297
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B4F7A28AE
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12D262815;
	Tue, 20 May 2025 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ec/TqoO7"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023B242D95
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765533; cv=none; b=FVvi/9Qm/IZp6Lyn4TgBBqJ4LnTCU379/gx3YTJuPdHohSgdDpAeHRHSuCiWSsLLaobYQ4TeLobWSq37u8XA3oIiQ6SSQubbMJlAPmliP8+OhXs9W3fuCKx1VhbkPb0kKn/v/CHQXPEJenr567ZGUzglC22HzyGUolDq9O7TegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765533; c=relaxed/simple;
	bh=P0zT0zftKrL/Y88RMq4ovSO9bbq9UeJRdyMwbx8a6D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W71e1y+JWWwrlk6FNaEcY0opvKsYbTiqpJVIaHkrn0Pm0xx6/j6a3bqnYPz5omPDPA/sX7APIcKB1K/Z99jqwuxPwP8y5r6PVhbe2s33uQavb3LcrCnI+bGkHL5CBWl/Y319OKokvVt3S99jBED/wMGT3WEDoBI5nDrnDU5b4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ec/TqoO7; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 11:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747765527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NplcsNYy8UsAypyXRLRttNfePHUJ7ZhLsg1OFHB/1Q=;
	b=Ec/TqoO75jX1OT9KrUOwWuMr8iofzbL5wfGPk1S5goPxoON98WVwfBs4x3PSBWepaGiklT
	t3IDtPPwuth5il4uzg3459jOlTU5bSkAro97+s48XdTfB+8XLNMYHn6Ob4jMF/5aNGZP4Y
	zFLirgjZ8F9BUT349sQdC/oyyVynb/g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> REVIEWERS NOTES:
> ================
> 
> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> 'putting it out there' for feedback. Any serious version of this will add a
> bunch of self-tests to assert correct behaviour and I will more carefully
> confirm everything's working.
> 
> This is based on discussion arising from Usama's series [0], SJ's input on
> the thread around process_madvise() behaviour [1] (and a subsequent
> response by me [2]) and prior discussion about a new madvise() interface
> [3].
> 
> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> 
> ================
> 
> Currently, we are rather restricted in how madvise() operations
> proceed. While effort has been put in to expanding what process_madvise()
> can do (that is - unrestricted application of advice to the local process
> alongside recent improvements on the efficiency of TLB operations over
> these batvches), we are still constrained by existing madvise() limitations
> and default behaviours.
> 
> This series makes use of the currently unused flags field in
> process_madvise() to provide more flexiblity.
> 
> It introduces four flags:
> 
> 1. PMADV_SKIP_ERRORS
> 
> Currently, when an error arises applying advice in any individual VMA
> (keeping in mind that a range specified to madvise() or as part of the
> iovec passed to process_madvise()), the operation stops where it is and
> returns an error.
> 
> This might not be the desired behaviour of the user, who may wish instead
> for the operation to be 'best effort'. By setting this flag, that behaviour
> is obtained.
> 
> Since process_madvise() would trivially, if skipping errors, simply return
> the input vector size, we instead return the number of entries in the
> vector which completed successfully without error.
> 
> The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.
> 
> 2. PMADV_NO_ERROR_ON_UNMAPPED
> 
> Currently madvise() has the peculiar behaviour of, if the range specified
> to it contains unmapped range(s), completing the full operation, but
> ultimately returning -ENOMEM.
> 
> In the case of process_madvise(), this is fatal, as the operation will stop
> immediately upon this occurring.
> 
> By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
> unmapped areas to simply be entirely ignored.

Why do we need PMADV_NO_ERROR_ON_UNMAPPED explicitly and why
PMADV_SKIP_ERRORS is not enough? I don't see a need for
PMADV_NO_ERROR_ON_UNMAPPED. Do you envision a use-case where
PMADV_NO_ERROR_ON_UNMAPPED makes more sense than PMADV_SKIP_ERRORS?

> 
> 3. PMADV_SET_FORK_EXEC_DEFAULT
> 
> It may be desirable for a user to specify that all VMAs mapped in a process
> address space default to having an madvise() behaviour established by
> default, in such a fashion as that this persists across fork/exec.
> 
> Since this is a very powerful option that would make no sense for many
> advice modes, we explicitly only permit known-safe flags here (currently
> MADV_HUGEPAGE and MADV_NOHUGEPAGE only).

Other flags seems general enough but this one is just weird. This is
exactly the scenario for prctl() like interface. You are trying to make
process_madvise() like prctl() and I can see process_madvise() would be
included in all the hate that prctl() receives. 

Let me ask in a different way. Eventually we want to be in a state where
hugepages works out of the box for all workloads. In that state what
would the need for this flag unless you have use-cases other than
hugepages. To me, there is a general consensus that prctl is a hacky
interface, so having some intermediate solution through prctl until
hugepages are good out of the box seems more reasonable.

> 
> 4. PMADV_ENTIRE_ADDRESS_SPACE
> 
> It can be annoying, should a user wish to apply madvise() to all VMAs in an
> address space, to have to add a singular large entry to the input iovec.
> 
> So provide sugar to permit this - PMADV_ENTIRE_ADDRESS_SPACE. If specified,
> we expect the user to pass NULL and -1 to the vec and vlen parameters
> respectively so they explicitly acknowledge that these will be ignored,
> e.g.:
> 
> 	process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
> 			PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS);
> 

I still don't see a need for this flag. Why not the following?

process_madvise(PIDFD_SELF, NULL, -1, advise, PMADV_SKIP_ERRORS)?

