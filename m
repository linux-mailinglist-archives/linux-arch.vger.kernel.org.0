Return-Path: <linux-arch+bounces-12136-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C422AC81E0
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EA1189B767
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0A230273;
	Thu, 29 May 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJS1AqDr"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EA22DFBB
	for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541303; cv=none; b=PTgl8okSCA9QceaB73/z8Wg9bPAstWOMH2WG+dfts5IAU5H7lQJf0YqWa82mn53MRcYfGpZj3sghGOzeFQkrFSo8qStuO0T14U89JlFKBzs62vIoTigBL+SUJA1JxGs4xbbCNJk81wPnP2rPWMiT/zQVmwMHd8/f2GKOxd0+oQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541303; c=relaxed/simple;
	bh=KBM4gDQL6RmWak7R11X4Mj8qjAtLTn7WlwV9XPIcAl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDWZl2EHiexujWbOOspzj+Vf3inNW9uQy1V0hk06Xkw+JH4hejEZLf1qvH2xZVVbIElXh8Cm0sI1U7NnB5tooYist90vCf3rNtwNaf7garNyzEDbWXIysL1nq8yGmjCX4jazs3OPrQ2wF4ohtG0hgoRRmjtmQ+FcTW1thCK151k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJS1AqDr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 May 2025 10:54:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748541288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pS2FSZ2IbKnKh7XDkalyzQrPqCzDhOSivlmDlIMu2js=;
	b=lJS1AqDr42wTTOr9PD8EM9OAg0B5Cqik/XMtq3EZEb3gUBeQKu5BpfeKK+WFgVHf14DGtJ
	CVx03AxfYYkg+zzK3ct/aZAlRzTnojel4FZzGOiKDf7c79R9hP3N8OEtZQXmleKpSoWeGH
	FsBbdRisJ5bhu75MsdqKQ70U8lywP68=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <c7fqqny5yv7smhxnxe5o4rc2wepmc6uei76teymfhxoana34nk@sfqnc2qclf23>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDh9LtSLCiTLjg2X@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

Hi Willy,

On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> On Thu, May 29, 2025 at 03:43:26PM +0100, Lorenzo Stoakes wrote:
> > After discussions in various threads (Usama's series adding a new prctl()
> > in [0], and a proposal to adapt process_madvise() to do the same -
> > conception in [1] and RFC in [2]), it seems fairly clear that it would make
> > sense to explore a dedicated API to explicitly allow for actions which
> > affect the virtual address space as a whole.
> > 
> > Also, Barry is implementing a feature (currently under RFC) which could
> > additionally make use of this API (see [3]).
> 
> I think the reason that you're having trouble coming up with a good
> place to put these ideas is because they are all bad ideas.  Do none of
> them.  Problem solved.
> 
> People should put more effort into allocating THPs automatically and
> monitoring where they're helping performance and where they're hurting
> performance,

Can you please expand on people putting more effort? Is it about
workloads or maybe malloc implementations (tcmalloc, jemalloc) being
more intelligent in managing their allocations/frees to keep more used
memory in hugepage aligned regions? And conveying to kernel which
regions they prefer hugepage backed and which they do not? Or something
else?

> instead of coming up with these baroque reasons to blame
> the sysadmin for not having tweaked some magic knob.

To me this is not about blaming sysadmin but more about sysadmin wanting
more fine grained control on THP allocation policies for different
workloads running in a multi-tenant environment.

