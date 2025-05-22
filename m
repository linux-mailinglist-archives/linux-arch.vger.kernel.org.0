Return-Path: <linux-arch+bounces-12077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF3AC1006
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD34A7D9D
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90232239E86;
	Thu, 22 May 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPOSeoVt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902C33CFC;
	Thu, 22 May 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927940; cv=none; b=fH2Xa6Ft9DqUancfc5JR4loutCupsSGFb7+X+5wrFwo1ofOSVXPkIskudROuZvbStpw6/dVh1/WeiMptkKkyfQ5COPA0o8xWbudMHYlzvomZaNJDe9F/vf2/Y4siqT9IArkgSDRJy9HLurSFxMurRsvsHO6VS6rDg6/kMXdqN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927940; c=relaxed/simple;
	bh=06uyp7Qdl4FbpaK88/amERaA+BHfk/0oiBoW6DdT6Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbT4KGE9MwUoAoKekQ1dcOpQ1nMqfJqLiK1TeoGK1vE1OEfK274In1/+A6a4lnkoAqVWQjWtETSLOHLxXD3W95b4K0kSNFY07qyiGXftKZjwUqTWKAEtKIGS4XFddc6dfE7fp2jzaIo0nNmJAcWaEb38C3pTdmJZJfOvRpGKPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPOSeoVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FE9C4CEE4;
	Thu, 22 May 2025 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747927940;
	bh=06uyp7Qdl4FbpaK88/amERaA+BHfk/0oiBoW6DdT6Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPOSeoVtrBidSC/VM15RLjpQhV6Cb2BgJaJ0py/+wbBEbHGnRM9bG36hDt7LfmeSi
	 ULYfiySnYY9mlLgTRsbMx0FuBJMXIiK7bIMOm77pklWlq9FgQ3tnZxGriJ0IVx+suK
	 GWRnpaH2WgVf1N7+/gg3pzpwFniZUChSQE5qw2+QkW0KXe9mzAcDdzg52NmY/0BEPE
	 Tx9+0rIp2+gCSek3gJGxrU/qWJjygXeJ8hDlcJnw/No3KpA4Af24QaQGm58p6Wr2em
	 tlhYqzF8qmK19jQY8T8fuI0xu0t+CnX4t0WEDGW2CNbRA3eeiJL2haDmsla+tFoZqc
	 SJYMpQPgaMUwg==
Date: Thu, 22 May 2025 18:32:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <aC9Dez8CftbNPcbg@kernel.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <20250521173200.GA1065351@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521173200.GA1065351@cmpxchg.org>

On Wed, May 21, 2025 at 01:32:00PM -0400, Johannes Weiner wrote:
> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> > So, something Liam mentioned off-list was the beautifully named
> > 'mmadvise()'. Idea being that we have a system call _explicitly for_
> > mm-wide modifications.
> > 
> > With Barry's series doing a prctl() for something similar, and a whole host
> > of mm->flags existing for modifying behaviour, it would seem a natural fit.
> 
> That's an interesting idea.
> 
> So we'd have THP policies and Barry's FADE_ON_DEATH to start; and it
> might also be a good fit for the coredump stuff and ksm if we wanted
> to incorporate them into that (although it would duplicate the
> existing proc/prctl knobs). The other MMF_s are internal AFAICS.
> 
> I think my main concern would be making something very generic and
> versatile without having sufficiently broad/popular usecases for it.
> 
> But no strong feelings either way. Like I said, I don't have a strong
> dislike for prctl(), but this idea would obviously be cleaner if we
> think there is enough of a demand for a new syscall.

To me it seems like having a "global mm control" system call makes much
more sense that adding more arms to prctl or overloading process_madvise().

With a dedicated syscall it's much clearer that the operation targets an mm
and it works for the entire mm.
And two usescase seem enough to me to justify a new syscall.

And it's easier to reason about a dedicated syscall designed for a certain
operation that for multiplexed ioctl() style controls.

> > I guess let me work that up so we can see how that looks?
> 
> I think it's worth exploring!
> 

-- 
Sincerely yours,
Mike.

