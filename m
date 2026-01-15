Return-Path: <linux-arch+bounces-15810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF15D28895
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 21:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17D45300F673
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39882877D4;
	Thu, 15 Jan 2026 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FKLxLDO6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AD21FF46;
	Thu, 15 Jan 2026 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510406; cv=none; b=CD8vOmdv4yQSvvdbD8F/0ReIVTEfqmx2IEU35H/z8+miQmYMpqenA84dQSuLWjBfHlh64/Ci32QP3zNTu9BQo/vJtQv40Dui6AZ8Ca+7aPSyCEq0NyKfsSqSWLEpOwFEoVphqYmFa1sn57oIZpQDRD+tndyw3KnF0XmdfnQ4zqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510406; c=relaxed/simple;
	bh=+kSn6OZb689goDZqhJCcy2AxMqtGudBDlkvG4nHQZN8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EmRQsi3UZHsxVk3xiGtW2XEdQDk98CmvJqzNj1TAvAq3jAx7RWgyLWQzVE7HGBHbXkj12yfsVxxwbeCYvxoHTHSOubZ/XLtI32YPsMbcuNTQ8nCy9g8g8FJDzkHPrbTkdP1q7oNruBphrJNlepTzy7yj1HDplNzV3dmJH8JaQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FKLxLDO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78038C116D0;
	Thu, 15 Jan 2026 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768510406;
	bh=+kSn6OZb689goDZqhJCcy2AxMqtGudBDlkvG4nHQZN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FKLxLDO6WXGtdWy1XYnd/pnyJXXBMLdvo3ZvG1BHZf8HQJO80m9gwZxcxFcynmIu2
	 JVqSh29Yf4miHM1RVCKZINiVX4Dy9/POf8a5LSlyVZlW/HUMOcpHX6n3oooRr7XpUW
	 NCVaEuUx2RPTF9CggzR1Xnyinjj1b8guq+FoIHBk=
Date: Thu, 15 Jan 2026 12:53:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-Id: <20260115125324.6373966518a479c585c4f404@linux-foundation.org>
In-Reply-To: <84a00b16-0fd3-4a32-bb7a-f117dcdcf1e2@kernel.org>
References: <20251223214037.580860-1-david@kernel.org>
	<fa37f15c-e5a8-4502-ba82-c077ee7b8e5f@lucifer.local>
	<20260115100501.2b956d74aabfe142d37aa608@linux-foundation.org>
	<84a00b16-0fd3-4a32-bb7a-f117dcdcf1e2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 20:40:13 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 1/15/26 19:05, Andrew Morton wrote:
> > On Thu, 15 Jan 2026 17:22:30 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > 
> >> Any update on this series? It's a hotfix series and I don't see it queued
> >> up anywhere in either mm-hotfixes-unstable or mm-hotfixes-stable, this
> >> issue is causing ongoing problems for a lot of people, is there any reason
> >> it's being delayed?
> >>
> >> It's received extensive approval and testing, so should be GTG right?
> > 
> > This has been in mm-unstable for a long time.  As the series had a
> > mixture of cc:stable and not-cc:stable patches, I figured we'd merge
> > them all into next merge window and let the -stable maintainers figure
> > it all out.
> > 
> > As this is more urgent than I believed, we need to figure out what to
> > do.
> > 
> > a) Pluck out the two cc:stable patches, merge just those into 6.19-rc.
> > 
> > b) Merge all of them into 6.19-rc, let -stable maintainers figure it out
> 
> Right. We can just CC: stable on comment fixes #2 and #3 to make 
> back-porting easier.

Yep.  Seems lame to be backporting comment fixes because real fixes
were textually dependent.  Also seems lame to retain known-wrong
comments in stable kernels!

> > 
> > 
> > Also, David, where do we stand with
> > 
> > : I'd love to get some generic hugetlb testing on arm64 and powerpc,
> > : that do hugetlb TLB flushing stuff a bit more special.
> > :
> > : I'll try doing some arm64 testing early in the new year myself.
> > 
> > ?
> 
> Not done yet, unfortunately. (I don't (yet) have easy access to decent 
> arm64 hardware ;) )
> 
> I still hope that Jann could quickly have a look, but it's been a while 
> already since I posted v1.

OK.  It may well have had the hoped-for testing in linux-next, only we
didn't hear about it.


