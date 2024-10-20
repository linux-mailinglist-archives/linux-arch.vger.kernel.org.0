Return-Path: <linux-arch+bounces-8307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F8D9A556D
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103AE1C20F53
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A55194C94;
	Sun, 20 Oct 2024 17:44:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B56AA7;
	Sun, 20 Oct 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446278; cv=none; b=rvYC91M55XK2YdvjgcfwRB57Yl5YgausWRm2hR/FeT4+VhiRhJ8XU72vLLP4QxOwk6ZuOnUt5e7ieagbq8AI+pZOpjlUPrjE9ypR1LDY88+wq5JZdQ29xilhcBJGlqo78vwMAmd+XrBTOC35qiH5myuQ6SiRSKnLykpP4pmPqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446278; c=relaxed/simple;
	bh=r/w8lsb8WKZRC9vQEw3SJnhjGHXAAsZ6aR9bEYkSyVs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GTFtD+bo4RcYkcNeatHz82NS12+KUuqQcY96PFFXPBQPT0uFjlW5LwuBINLx59Q6RlLmGYPleX+3lz36jJYmG/hS8bxBc99LxxyAPYQnc2/EJDC51+rfjXM6ie8ycyM43DZDE2Uxhn6MQTPBDH0zNVPWkwIz5ZWcVME1AN3wSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=37437 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1t2ZsI-002agy-2T;
	Sun, 20 Oct 2024 17:37:54 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
	(envelope-from <fw@deneb.enyo.de>)
	id 1t2ZsI-008CWx-26;
	Sun, 20 Oct 2024 19:37:54 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Suren Baghdasaryan
 <surenb@google.com>,  "Liam R . Howlett" <Liam.Howlett@oracle.com>,
  Matthew Wilcox <willy@infradead.org>,  Vlastimil Babka <vbabka@suse.cz>,
  "Paul E . McKenney" <paulmck@kernel.org>,  Jann Horn <jannh@google.com>,
  David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Muchun Song <muchun.song@linux.dev>,
  Richard Henderson <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  "James E . J . Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
  Chris Zankel <chris@zankel.net>,  Max Filippov <jcmvbkbc@gmail.com>,
  Arnd Bergmann <arnd@arndb.de>,  linux-alpha@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  linux-arch@vger.kernel.org,  Shuah Khan <shuah@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  linux-kselftest@vger.kernel.org,  Sidhartha
 Kumar <sidhartha.kumar@oracle.com>,  Jeff Xu <jeffxu@chromium.org>,
  Christoph Hellwig <hch@infradead.org>,  linux-api@vger.kernel.org,  John
 Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Date: Sun, 20 Oct 2024 19:37:54 +0200
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com> (Lorenzo
	Stoakes's message of "Sun, 20 Oct 2024 17:20:00 +0100")
Message-ID: <87a5eysmj1.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Lorenzo Stoakes:

> Early testing of the prototype version of this code suggests a 5 times
> speed up in memory mapping invocations (in conjunction with use of
> process_madvise()) and a 13% reduction in VMAs on an entirely idle android
> system and unoptimised code.
>
> We expect with optimisation and a loaded system with a larger number of
> guard pages this could significantly increase, but in any case these
> numbers are encouraging.
>
> This way, rather than having separate VMAs specifying which parts of a
> range are guard pages, instead we have a VMA spanning the entire range of
> memory a user is permitted to access and including ranges which are to be
> 'guarded'.
>
> After mapping this, a user can specify which parts of the range should
> result in a fatal signal when accessed.
>
> By restricting the ability to specify guard pages to memory mapped by
> existing VMAs, we can rely on the mappings being torn down when the
> mappings are ultimately unmapped and everything works simply as if the
> memory were not faulted in, from the point of view of the containing VMAs.

We have a glibc (so not Android) dynamic linker bug that asks us to
remove PROT_NONE mappings in mapped shared objects:

  Extra struct vm_area_struct with ---p created when PAGE_SIZE < max-page-size
  <https://sourceware.org/bugzilla/show_bug.cgi?id=31076>

It's slightly different from a guard page because our main goal is to
avoid other mappings to end up in those gaps, which has been shown to
cause odd application behavior in cases where it happens.  If I
understand the series correctly, the kernel would not automatically
attribute those PROT_NONE gaps to the previous or subsequent mapping.
We would have to extend one of the surrounding mapps and apply
MADV_POISON to that over-mapped part.  That doesn't seem too onerous.

Could the ELF loader in the kernel do the same thing for the main
executable and the program loader?

