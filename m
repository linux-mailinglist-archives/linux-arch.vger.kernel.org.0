Return-Path: <linux-arch+bounces-12070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF1AC0B9F
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 14:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC8C17DD27
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A628A40A;
	Thu, 22 May 2025 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERBds/35"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B662381BA;
	Thu, 22 May 2025 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917164; cv=none; b=p2sggFLaXYSEpJ+g2qmoWQ2EdyiJi9TUnrUS07gq6j4MjHavUJRavOc0O9GPqkjlTwS3vBTBzVm4NOgE10KQdFizLNcF+p/FObVGEX445LPMDjm03LvcmIXBMWcF6TNQmnZB41cogR8YsL41Tlil2EwJ157dbxchnc3GAwQeRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917164; c=relaxed/simple;
	bh=r4cYLZUDYQDfzfjRP5THCg2REgGtHgRwFNQ7nd54qMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQi9KSvFOQyAaYJaQ4+19xd7CkjIwrUHjvp3wmWwTN7o98cx+FF4sIN/4VADB6DRHgHuhsl1pPkuFDxN7x7CHNPG1xGaWEGZEw9dpQFhi00f+fXOQivm9ursy7T/GDvw/l4C616y7mFjqtzZg1Ru94oPWVHBCk3lXUvvdQPLnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERBds/35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93155C4CEE4;
	Thu, 22 May 2025 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747917163;
	bh=r4cYLZUDYQDfzfjRP5THCg2REgGtHgRwFNQ7nd54qMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERBds/35Smq1+0+h43mlQ02p5HXfQQqlX2clTAQLhyKzR6NvWTyBdRzW5CGAYieJK
	 BOlnP6uxtfR114DLKpwYkJewkqFFYRc9F7c6EUjbDee6Xue1i0hS88l2AOdEZGdB3j
	 UxcOflPldjgPQwzgCrYw7e4vlq8HLUG82qT1LhB07+EDjYXg3oclTJO4Y9VI0b0P50
	 aM5jMhwdk/u3mph9iJmbcNceRmoFa/NsHQLOcZo8XNsC0nH0cnqpvOSg6I4h07AfM/
	 y3b7MA30fWsUMs6AmRVuemMrWzBH0qWKzm1I9V0ncBDZQ2QuJCBJZ56PGXLbGjKUnz
	 /TrvL6a1NPpjg==
Date: Thu, 22 May 2025 15:32:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: madvise: refactor madvise_populate()
Message-ID: <aC8ZY_B7RKc9RMzw@kernel.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
 <becb11bd-e10c-4f59-9ff1-1f7acd2e1ee0@redhat.com>
 <ea17a0a6-fe19-4f0b-9899-56d39b9fbac3@lucifer.local>
 <d9456551-a3ea-454c-8832-c0530f702ce0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9456551-a3ea-454c-8832-c0530f702ce0@redhat.com>

On Tue, May 20, 2025 at 12:42:33PM +0200, David Hildenbrand wrote:
> On 20.05.25 12:36, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 12:30:24PM +0200, David Hildenbrand wrote:
> > > On 19.05.25 22:52, Lorenzo Stoakes wrote:
> > > > Use a for-loop rather than a while with the update of the start argument at
> > > > the end of the while-loop.
> > > > 
> > > > This is in preparation for a subsequent commit which modifies this
> > > > function, we therefore separate the refactoring from the actual change
> > > > cleanly by separating the two.
> > > > 
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    mm/madvise.c | 39 ++++++++++++++++++++-------------------
> > > >    1 file changed, 20 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 8433ac9b27e0..63cc69daa4c7 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -967,32 +967,33 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
> > > >    	int locked = 1;
> > > >    	long pages;
> > > > -	while (start < end) {
> > > > +	for (; start < end; start += pages * PAGE_SIZE) {
> > > >    		/* Populate (prefault) page tables readable/writable. */
> > > >    		pages = faultin_page_range(mm, start, end, write, &locked);
> > > >    		if (!locked) {
> > > >    			mmap_read_lock(mm);
> > > >    			locked = 1;
> > > >    		}
> > > > -		if (pages < 0) {
> > > > -			switch (pages) {
> > > > -			case -EINTR:
> > > > -				return -EINTR;
> > > > -			case -EINVAL: /* Incompatible mappings / permissions. */
> > > > -				return -EINVAL;
> > > > -			case -EHWPOISON:
> > > > -				return -EHWPOISON;
> > > > -			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> > > > -				return -EFAULT;
> > > > -			default:
> > > > -				pr_warn_once("%s: unhandled return value: %ld\n",
> > > > -					     __func__, pages);
> > > > -				fallthrough;
> > > > -			case -ENOMEM: /* No VMA or out of memory. */
> > > > -				return -ENOMEM;
> > > > -			}
> > > > +
> > > > +		if (pages >= 0)
> > > > +			continue;
> > > > +
> > > > +		switch (pages) {
> > > > +		case -EINTR:
> > > > +			return -EINTR;
> > > > +		case -EINVAL: /* Incompatible mappings / permissions. */
> > > > +			return -EINVAL;
> > > > +		case -EHWPOISON:
> > > > +			return -EHWPOISON;
> > > > +		case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> > > > +			return -EFAULT;
> > > > +		default:
> > > > +			pr_warn_once("%s: unhandled return value: %ld\n",
> > > > +				     __func__, pages);
> > > > +			fallthrough;
> > > > +		case -ENOMEM: /* No VMA or out of memory. */
> > > > +			return -ENOMEM;
> > > 
> > > Can we limit it to what the patch description says? "Use a for-loop rather
> > > than a while", or will that be a problem for the follow-up patch?
> > 
> > Well, kind of the point is that we can remove a level of indentation also, which
> > then makes life easier in subsequent patch.
> > 
> > Happy to change description or break into two (but that seems a bit over the top
> > maybe? :>)
> 
> Probably just mention it, otherwise it looks a bit like unrelated churn :)

And for refactoring patches it's always useful to mention "no functional
change" ;-)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

