Return-Path: <linux-arch+bounces-12081-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98996AC15B6
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 22:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA643A94D1
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDD19995D;
	Thu, 22 May 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1YSWwGd"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCA1F76C2
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947256; cv=none; b=PaEGzdAXsWKATGGXlHrakRBsDIcr7RFeDcAB45XuQGxHguxfcrTWnU1CXfkSxbd8eUxTBiUz4IglqehC3eI7RDFV/H8iX+GbHmB3WGg0ZtbnHrf9nG9t07oVVXEJKWsSQiMDKjtodoIqBvNcbxxd2S8X+j1HyIqPN0ObiC8qUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947256; c=relaxed/simple;
	bh=19yQodn4iaDI9boqRbWRZtNZmzvDMbTFtSez4CbJtrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkbeoFgHFMx9o4DkbWdAjwSEXeWPPYCdiIJmFlDF+5WT68W7orq+qQu/p7hDHpbwz/0AJDdFjXhsfyzMDf1Stis1VMo8wWrsHjBENnil5K1z+mJUUkeoAifwTiHDAE44UXaG6ifDRSoWp9QvoMrN7i5c1gVo4R2HuD50+i/v6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1YSWwGd; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 May 2025 13:53:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747947242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/jOsasnD7/8FvY3TuCm8IbQDBYnKBvwXkRBxlVl1tk=;
	b=h1YSWwGdktd+9jrot8ivB1HH/4tagr/1MSzzWk9RJfwfhjNNDb7J7ixbXutQZSXc2J1rgu
	XYAHAK4qqLuNoPh9tf8Zh0VPT+KKLJvkGpa33UD8bl6fu/+pNAAXH2vMQRy0MxOKW19j2f
	Dx0PJDKE79+tN16wChdBGKFxdZK9IhA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <uhla5o5xqshcrihc5gpkqqyoplj7hxrbptp6prmwd2mh3ikw4m@m6apbkyfny6c>
References: <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <e4d9dd63-5000-4939-b09c-c322d41a9d70@lucifer.local>
 <x6uzxhwrgamet2ftqtgzxcg7osnw62rcv4eym52nr4l6awsqgt@qivrdfpguaop>
 <9433c2d6-200c-4320-80f3-840ca5e66f64@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9433c2d6-200c-4320-80f3-840ca5e66f64@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 22, 2025 at 03:05:30PM +0200, David Hildenbrand wrote:
> On 21.05.25 19:39, Shakeel Butt wrote:
> > On Wed, May 21, 2025 at 05:49:15PM +0100, Lorenzo Stoakes wrote:
> > [...]
> > > > 
> > > > Please let's first get consensus on this before starting the work.
> > > 
> > > With respect Shakeel, I'll work on whatever I want, whenever I want.
> > 
> > I fail to understand why you would respond like that.
> 
> Relax guys ... :) Really nothing to be fighting about.

Agreed.

[...]

> 
> 
> To summarize my current view:
> 
> 1) ebpf: most people are are not a fan of that, and I agree, at least
>    for this purpose. If we were talking about making better *placement*
>    decisions using epbf, it would be a different story.

From placement decisions, do you mean placement between memory
tiers/nodes or something else?

> 
> 2) prctl(): the unloved child, and I can understand why. Maybe now is
>    the right time to stop adding new MM things that feel weird in there.
>    Maybe we should already have done that with the KSM toggle (guess who
>    was involved in that ;) ).

At the moment systemd is the user I know of and I think it would very
easy to migrate it to whatever new thing we decide here.

> 
> 3) process_madvise(): I think it's an interesting extension, but
>    probably we should just have something that applies to the whole
>    address space naturally. At least my take for now.
> 
> 4) new syscall: worth exploring how it would look. I'm especially
>    interested in flag options (e.g., SET_DEFAULT_EXEC) and how we could
>    make them only apply to selected controls.

Were there any previous discussion on SET_DEFAULT_EXEC? First time I am
hearing about it.

Overall I agree with your assessment and thus I was requesting to at
least discuss the new syscall option as well.


