Return-Path: <linux-arch+bounces-12037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8182AABE407
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33BE1BC06D0
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C2525CC45;
	Tue, 20 May 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R64hWWjb"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AF248F75
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770587; cv=none; b=mXQLAH9U3raLPUxv1PHWDtegK5ps1s6Zx2U+Cse2OPa783ev1SGG+7K/R7tigOT/OFRhQ5l6AqDDTqYZ2ivKzie4CG7yVtOM4nszkx1gnZJgo2si+CrX7PCJjSBWEXRnXbStxt4W9Wsumj/OtO81SnLTpWtAcU8f2h//X7DalrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770587; c=relaxed/simple;
	bh=yp++ExNfdarbln37M9Ni/ssLi6mj8UDcz8fTDir/POg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ43p2FhXy/S9mOtdzJiFO0vF8iPS63oz/95nWfyK2WsvDpntC/Dc/YPZA2qgJlnNg9gwDvJ/r8l8DrAu94OHt9srOdwjmj/I9EF2lppoTPjAfRrjqUI4CAc6FRNqhPT4v8OqLQxKhJcHdZyPAnAlW7Y0y4cyxhdVCnXSOjJ9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R64hWWjb; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 12:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747770570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap6lLptMrOyoM0t6NCaw2RL7aQfE/xOfmjbMVDHdErc=;
	b=R64hWWjbqedB9au/4qhjEPJDFVCtXcMvcxdwEJf0jbQhgi2uuTHTZGxIDf/oUA6SFhhgjK
	FFlUaPtllA4LD4/TOAjRycSeMQe5F1KYZu/TyhS1fwq58bO3Xr3D0AcibAZPPNpBd1EG7C
	97OnYC7SMwO9aM2uTOxsLliUzj7BDZM=
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
Message-ID: <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 07:45:43PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 11:25:05AM -0700, Shakeel Butt wrote:
> > On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> > > REVIEWERS NOTES:
> > > ================
> > >
> > > This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> > > 'putting it out there' for feedback. Any serious version of this will add a
> > > bunch of self-tests to assert correct behaviour and I will more carefully
> > > confirm everything's working.
> > >
> > > This is based on discussion arising from Usama's series [0], SJ's input on
> > > the thread around process_madvise() behaviour [1] (and a subsequent
> > > response by me [2]) and prior discussion about a new madvise() interface
> > > [3].
> > >
> > > [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> > > [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> > > [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> > > [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> > >
> > > ================
> > >
> > > Currently, we are rather restricted in how madvise() operations
> > > proceed. While effort has been put in to expanding what process_madvise()
> > > can do (that is - unrestricted application of advice to the local process
> > > alongside recent improvements on the efficiency of TLB operations over
> > > these batvches), we are still constrained by existing madvise() limitations
> > > and default behaviours.
> > >
> > > This series makes use of the currently unused flags field in
> > > process_madvise() to provide more flexiblity.
> > >
> > > It introduces four flags:
> > >
> > > 1. PMADV_SKIP_ERRORS
> > >
> > > Currently, when an error arises applying advice in any individual VMA
> > > (keeping in mind that a range specified to madvise() or as part of the
> > > iovec passed to process_madvise()), the operation stops where it is and
> > > returns an error.
> > >
> > > This might not be the desired behaviour of the user, who may wish instead
> > > for the operation to be 'best effort'. By setting this flag, that behaviour
> > > is obtained.
> > >
> > > Since process_madvise() would trivially, if skipping errors, simply return
> > > the input vector size, we instead return the number of entries in the
> > > vector which completed successfully without error.
> > >
> > > The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.
> > >
> > > 2. PMADV_NO_ERROR_ON_UNMAPPED
> > >
> > > Currently madvise() has the peculiar behaviour of, if the range specified
> > > to it contains unmapped range(s), completing the full operation, but
> > > ultimately returning -ENOMEM.
> > >
> > > In the case of process_madvise(), this is fatal, as the operation will stop
> > > immediately upon this occurring.
> > >
> > > By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
> > > unmapped areas to simply be entirely ignored.
> >
> > Why do we need PMADV_NO_ERROR_ON_UNMAPPED explicitly and why
> > PMADV_SKIP_ERRORS is not enough? I don't see a need for
> > PMADV_NO_ERROR_ON_UNMAPPED. Do you envision a use-case where
> > PMADV_NO_ERROR_ON_UNMAPPED makes more sense than PMADV_SKIP_ERRORS?
> 
> I thought I already explained this above:
> 
> 	"In the case of process_madvise(), this is fatal, as the operation
> 	 will stop immediately upon this occurring."
> 
> This is somewhat bizarre behaviour. You specify multiple vector entries
> spanning different ranges, but one spans some unmapped space and now the
> whole process_madvise() operation grinds to a halt, except the vector entry
> containing ranges including unmapped space is completed.
> 
> This is strange behaviour, and it makes sense to me to optionally disable
> this.
> 
> If you were looping around doing an madvise(), this would _not_ occur, you
> could filter out the -ENOMEM's. It's a really weird peculiarity in
> process_madvise().
> 
> Moreover, you might not want an error reported, that possibly duplicates
> _real_ -ENOMEM errors, when you simply encounter unmapped addresses.
> 
> Finally, if you perform an operation across the entire address space as
> proposed you may wish to stop on actual error but not on the (inevitable at
> least in 64-bit space) gaps you'll encounter.

So, we *may* wish to stop on actual error, do you have a more concrete
example? We should not add an API on a case which may be needed. We can
always add stuff later when the actual concrete use-cases come up.

> 
> >
> > >
> > > 3. PMADV_SET_FORK_EXEC_DEFAULT
> > >
> > > It may be desirable for a user to specify that all VMAs mapped in a process
> > > address space default to having an madvise() behaviour established by
> > > default, in such a fashion as that this persists across fork/exec.
> > >
> > > Since this is a very powerful option that would make no sense for many
> > > advice modes, we explicitly only permit known-safe flags here (currently
> > > MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
> >
> > Other flags seems general enough but this one is just weird. This is
> > exactly the scenario for prctl() like interface. You are trying to make
> > process_madvise() like prctl() and I can see process_madvise() would be
> > included in all the hate that prctl() receives.
> 
> I'm really not sure what you mean. prctl() has no rhyme nor reason, so not
> sure what a 'prctl() like interface' means here, and you're not explaining
> what you mean by that.

I meant it applies a property at the task or process level and has
examples where those properties are inherited to children.

> 
> Presumably you mean you find this odd as you feel it sits outside the realm
> of madvise() behaviour.

The persistence across exec seems weird.

> 
> But I'd suggest it does not - the idea is to align _everything_ with
> madvise(). Rather than adding an entirely arbitrary function in prctl(), we
> are going the other way - keeping everything relating to madvise()-like
> modification of memory _in mm_ and _in madvise()_, rather than bitrotting
> away in kernel/sys.c.

The above para seems like you are talking about code which can be moved
to mm.

> 
> So we get alignment in the fact that we're saying 'we establish a _default_
> madvise flag for a process'.

I think this is an important point. So, we want to introduce a way to
set a process level property which can be inherited through fork/exec.
With that in mind, is process_madvise() (or even madvise()) really a
good interface for it? There is no need for address ranges for such
use-case.

> 
> We restrict initially to VM_HUGEPAGE and VM_NOHUGEPAGE to a. achieve what
> you guys at meta want while also opening the door to doing so in future if
> it makes sense to.

Please drop the "you guys at meta". We should be aiming for what is good
for all (or most) linux users. Whatever is done here will be
incorporated in systemd which will be used very widely.

> 
> This couldn't be more different than putting some arbitrary code relating
> to mm in the 'netherrealm' of prctl().
> 
> 
> >
> > Let me ask in a different way. Eventually we want to be in a state where
> > hugepages works out of the box for all workloads. In that state what
> > would the need for this flag unless you have use-cases other than
> > hugepages. To me, there is a general consensus that prctl is a hacky
> > interface, so having some intermediate solution through prctl until
> > hugepages are good out of the box seems more reasonable.
> 
> No, fundamentally disagree. We already have MADV_[NO]HUGEPAGE. This will
> have to be supported. In a future where things are automatic, these may be
> no-ops in 'auto' mode.
> 
> But the requirement to have these flags will still exist, the requirement
> to do madvise() operations will still exist, we're simply expanding this
> functionality.
> 
> The problem arises the other way around when we shovel mm stuff in
> kernel/sys.c.

I think you mixing the location of the code and the interface which will
remain relevant long term. I don't see process_madvise (or madvise) good
interface for this specific functionality (i.e. process level property
that gets inherited through fork/exec). Now we can add a new syscall for
this but to me, particularly for hugepage, this functionality is needed
temporarily until hugepages are good out of the box. However if there is
a use-case other than hugepages then yes, why not a new syscall.


