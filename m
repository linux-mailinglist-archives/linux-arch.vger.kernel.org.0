Return-Path: <linux-arch+bounces-8592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6199B1482
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 06:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B9D1F21C32
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCB13B797;
	Sat, 26 Oct 2024 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKuSS0eB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E191442F2;
	Sat, 26 Oct 2024 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729915801; cv=none; b=rugHHi5OGOHtq8DrpxNpJD5J0KjHV1T/jU+KO6rWG5BxV5iz72pRiDxHKq4TTB+H91JYnmMSmKIJHttVw89EO7ZpWfq174mkNojHX1K4+o9Eh01es4+59t2fRUEdF+SU50Lhqy4Snt/DXi+QJG7OTbrmKfaUTKMKYxyRsBgzLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729915801; c=relaxed/simple;
	bh=lF+GZ34WavKbRCh+8SpENUkvMTOj0nNu/+wtL6EWAuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAyOD96zmrcWj4f13aGJkYLeIUlKnYKqUuAPfjJltgKdvQb/UO0sCMTMgSR+6ZvShtbnwYkSClXIqmODrjtt8j03fgmIZmTIjnhewyCyNysDIrTVBWGF/LN1FGiPLJaSfy1nha6SuxtwbXzJmheFJFQiLl/zpgANEXgHMJ1s3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKuSS0eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16197C4CEC6;
	Sat, 26 Oct 2024 04:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729915800;
	bh=lF+GZ34WavKbRCh+8SpENUkvMTOj0nNu/+wtL6EWAuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKuSS0eBaRI/CXii2QB5Wp13VN5M0EyqE+pRWQ0FIrWhJKg/vIHpdl8T4W8QxNuij
	 T0CG7+FxcgukLYYess7ilgKdACYxJyTQbvNYi5tggRwq+/XFBRGniANM7V3triPr8F
	 UUsS6muPo9iWYwGQFgwiv9w4YPPRVc28KYUlaAdjilM3SQfI6maVNNNlOFU9fEDXsq
	 Gk3BBORntTohGffZpXt1Y890883/3runspv9c8/UKZctcqZ0RsPobpG7rjK4cA5CnO
	 8NZmDph5HkYR8xfmcMREDDHLdj4UGjCSN4dQNMDqTidBJmggOvZ+kQyIdFd4kqd50G
	 JFBNHlz+eaPyA==
Date: Fri, 25 Oct 2024 21:09:58 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
Message-ID: <20241026040958.GA34351@sol.localdomain>
References: <20241025191454.72616-1-ebiggers@kernel.org>
 <20241025191454.72616-5-ebiggers@kernel.org>
 <CAMj1kXEsq7iJThqZ7WA00ei4m59vpC23wPM+Mrj9W+HXfk-aSg@mail.gmail.com>
 <20241025220239.GB2637569@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025220239.GB2637569@google.com>

On Fri, Oct 25, 2024 at 10:02:39PM +0000, Eric Biggers wrote:
> On Fri, Oct 25, 2024 at 10:47:15PM +0200, Ard Biesheuvel wrote:
> > On Fri, 25 Oct 2024 at 21:15, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > Instead of registering the crc32-$arch and crc32c-$arch algorithms if
> > > the arch-specific code was built, only register them when that code was
> > > built *and* is not falling back to the base implementation at runtime.
> > >
> > > This avoids confusing users like btrfs which checks the shash driver
> > > name to determine whether it is crc32c-generic.
> > >
> > 
> > I think we agree that 'generic' specifically means a C implementation
> > that is identical across all architectures, which is why I updated my
> > patch to export -arch instead of wrapping the C code in yet another
> > driver just for the fuzzing tests.
> > 
> > So why is this a problem? If no optimizations are available at
> > runtime, crc32-arch and crc32-generic are interchangeable, and so it
> > shouldn't matter whether you use one or the other.
> > 
> > You can infer from the driver name whether the C code is being used,
> > not whether or not the implementation is 'fast', and the btrfs hack is
> > already broken on arm64.
> > 
> > > (It would also make sense to change btrfs to test the crc32_optimization
> > > flags itself, so that it doesn't have to use the weird hack of parsing
> > > the driver name.  This change still makes sense either way though.)
> > >
> > 
> > Indeed. That hack is very dubious and I'd be inclined just to ignore
> > this. On x86 and arm64, it shouldn't make a difference, given that
> > crc32-arch will be 'fast' in the vast majority of cases. On other
> > architectures, btrfs may use the C implementation while assuming it is
> > something faster, and if anyone actually notices the difference, we
> > can work with the btrfs devs to do something more sensible here.
> 
> Yes, we probably could get away without this.  It's never really been
> appropriate to use the crypto driver names for anything important.  And btrfs
> probably should just assume CRC32C == fast unconditionally, like what it does
> with xxHash64, or even do a quick benchmark to measure the actual speed of its
> hash algorithm (which can also be sha256 or blake2b which can be very fast too).
> 
> Besides the btrfs case, my concern was there may be advice floating around about
> checking /proc/crypto to check what optimized code is being used.  Having
> crc32-$arch potentially be running the generic code would make that misleading.
> It might make sense to keep it working similar to how it did before.
> 
> But I do agree that we could probably get away without this.

While testing this patchset I notice that none of the crypto API drivers for
crc32 or crc32c even need to be loaded on my system anymore, as everything on my
system that uses those algorithms (such as ext4) just uses the library APIs now.
That makes the "check /proc/crypto" trick stop working anyway.

I think you're right that we shouldn't bother with patches 3-4, and I'll plan to
go back to leaving them out in the next version, unless someone yells.

- Eric

