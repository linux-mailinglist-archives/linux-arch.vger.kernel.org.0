Return-Path: <linux-arch+bounces-15807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC55D2776A
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F6E3303EEB7
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C653D300A;
	Thu, 15 Jan 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UgfXRr7k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCA2D7DED;
	Thu, 15 Jan 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500303; cv=none; b=Ta9Q6qhwtbVrtk5kmPEOoEUAG71r8YAbVL/aTxivQ8tmJ8sa5gyhfL29ENS4rj843x82UkW4g8/xlWScFfOSmigQl3Lt6ExQARzgCdUNkE+Gwe+Z9l6nay4pZxFeJYMJDTwSN1bt/Ag+w7BgTMeP0f7YJvLDQbKj4swhSAGELD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500303; c=relaxed/simple;
	bh=6RMWVQuyYm4C0LwDw7pTQTnW8LsYa5O8RN8wtoU7GUU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gAN3ueZbfxBUeM17PmenhXJWr1RpCTW3td+3IuDoWbDhnVird67rXA08fV506gCgUcHEdJaHsDiTaZgthKTDQjpYkGaqTuXuD3/+PsOvnq5khbr4HxyhDCL5d6tUsE1d2GAU5hVxI6wDCYX9/Itp8zA5EtRzwkSAtWSVGeadmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UgfXRr7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF66C116D0;
	Thu, 15 Jan 2026 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768500303;
	bh=6RMWVQuyYm4C0LwDw7pTQTnW8LsYa5O8RN8wtoU7GUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UgfXRr7kNJAlXibce6ruwyzAGqd8zPeDptyXrQLUgHymqRkTH0C1D8Oi5WNl46lH4
	 8qLdRDiByN2nxgyMDvwei4BPZrxxDk02OHj5baKYoD5Sxf8S0aVfo+seJ4C2Chd+uF
	 Ua7zODpxIPIFgwQOHJtfAbMuALXerFlAPOg9bokA=
Date: Thu, 15 Jan 2026 10:05:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RESEND v3 0/4] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
Message-Id: <20260115100501.2b956d74aabfe142d37aa608@linux-foundation.org>
In-Reply-To: <fa37f15c-e5a8-4502-ba82-c077ee7b8e5f@lucifer.local>
References: <20251223214037.580860-1-david@kernel.org>
	<fa37f15c-e5a8-4502-ba82-c077ee7b8e5f@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 17:22:30 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Any update on this series? It's a hotfix series and I don't see it queued
> up anywhere in either mm-hotfixes-unstable or mm-hotfixes-stable, this
> issue is causing ongoing problems for a lot of people, is there any reason
> it's being delayed?
> 
> It's received extensive approval and testing, so should be GTG right?

This has been in mm-unstable for a long time.  As the series had a
mixture of cc:stable and not-cc:stable patches, I figured we'd merge
them all into next merge window and let the -stable maintainers figure
it all out.

As this is more urgent than I believed, we need to figure out what to
do.

a) Pluck out the two cc:stable patches, merge just those into 6.19-rc.

b) Merge all of them into 6.19-rc, let -stable maintainers figure it out

c) Stick with my original plan.

<checks>

The cc:stable "mm/hugetlb: fix excessive IPI broadcasts when unsharing
PMD tables using mmu_gather" has dependencies on the preceding two
non-cc:stable patches.

So I'm thinking I add cc:stable to everything and send the whole series
into 6.19-rcX.  wdyt?


Also, David, where do we stand with

: I'd love to get some generic hugetlb testing on arm64 and powerpc,
: that do hugetlb TLB flushing stuff a bit more special.
:
: I'll try doing some arm64 testing early in the new year myself.

?

