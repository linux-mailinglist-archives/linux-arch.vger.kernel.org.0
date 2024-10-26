Return-Path: <linux-arch+bounces-8590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A289B13C2
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D3F1F21D48
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B91388;
	Sat, 26 Oct 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iq6g6CMG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70987161;
	Sat, 26 Oct 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901493; cv=none; b=EmxoHmx44lpEszL2wZnMt6Fk6iwyMXtd7MRaeTOLtp0JrplBOJs6nQdPNQC5XO67ZE/t3o8LiD1EHPX2OR2hXASrYLMa5DdHbfGqOzAiO4bi785vYewkow4mO4qvcxMkQtufGCNoGOP61GDbbRl15+45jYwuj4K55iXE/xVDBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901493; c=relaxed/simple;
	bh=8bPiJCh5vsLoeLgwY5AooV41PIGxIvoymC+u5FvvIbg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p5U2DfHOZw31XgE5bdEw4X+ymFWcVazyLigVCZQseMl08ogEntWA1cKsFRHx/VoGVIeFuJ73nshq45Po0vSf68BEUNAn/ebAnEZlIzKbTs7KVka5LLtavZy+RUlkJYzkc/bMM/VuFMLERb+jdTovxYmr5/3LfFxjfMzgsFZJ09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iq6g6CMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE760C4CECD;
	Sat, 26 Oct 2024 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729901492;
	bh=8bPiJCh5vsLoeLgwY5AooV41PIGxIvoymC+u5FvvIbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iq6g6CMG8g/qm3f7tHs9mC3I7vEzro9rr68maumpd/NjylEk8s7S7CS1gMQIvW0M+
	 96cVDePeTgt8QGsJrS+kxVaVL5Qp3iGjXtJmuIgYrCh3cuJ4WtTPw5sXilInVamYUY
	 8rMLgMJR5TiK1tBBXa7D2hRJwIL8jSQpFnAqcMD0=
Date: Fri, 25 Oct 2024 17:11:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil
 Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn
 <jannh@google.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd
 Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Christian
 Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, Sidhartha
 Kumar <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org, John
 Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-Id: <20241025171131.9ceabcec32ff4c569d87875f@linux-foundation.org>
In-Reply-To: <a10c26ea-3a48-452c-a02d-7522eefd494d@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
	<415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
	<20241023161205.003ad735d5f6ec50ec2eb054@linux-foundation.org>
	<a10c26ea-3a48-452c-a02d-7522eefd494d@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 08:25:46 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I actually do plan to extend this work to support shmem and file-backed
> mappings in the future as a revision to this work.

Useful, thanks.  I pasted this in.

> >
> > (generally, it would be nice to include the proposed manpage update at
> > this time, so people can review it while the code change is fresh in
> > their minds)
> 
> It'd be nice to have the man pages live somewhere within the kernel so we
> can do this as part of the patch change as things evolve during review, but
> obviously moving things about like that is out of scope for this discussion
> :)

Yes, that would be good.  At present the linkage is so poor that things
could get lost.

I guess one thing we could do is to include the proposed manpage update
within the changelogs.  That way it's stored somewhere and gets reviewed
alongside the patches themselves.

> I do explicitly intend to send a manpage update once this series lands
> however.

That's late, IMO.  Sometimes reviewing manpage updates leads people to
ask "hey.  what about X" or "hey, that's wrong".  Michael Kerrisk was
good at finding such holes, back in the day.


