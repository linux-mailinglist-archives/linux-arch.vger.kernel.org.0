Return-Path: <linux-arch+bounces-9928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64863A2009C
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 23:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50711886748
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E31990BA;
	Mon, 27 Jan 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HKtB5XDG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04751B64A;
	Mon, 27 Jan 2025 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017221; cv=none; b=lUj2+OEi9ALtUMJXsmGV0/SenlhIdJhPNpOOXgE9wR4idsAQePBYyItD6toBi7YcBNckBoKRqM2UoyZ6OTjJ8mjhPP0UJhXyscm+/5Nqn1OhzDWJYKIgmvyRrEUO+4k/CbNs+xWo1IpSBfWEnsV9kp9QxKtvYNKHGEehI3R9wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017221; c=relaxed/simple;
	bh=AFXXyE8v95CfzioBCb2Xv7hlTXv5LhiICb5s0v8I0To=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YOE92Gv+61kUr9PCR/BzgBimgT0ENYos/PTcyWJZvTtzPvUdM13XrbXZeZu/LUv8WQB1nDPYjIszT4k60SeNqvEXm55NxaiQ8GqPawXPrqkEqrwDhW+ap6LzunorUkXmsF9Ov/rn9aqHCVU1WpnRm1wGC8vaX7Kci8eQWWLAlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HKtB5XDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851EAC4CED2;
	Mon, 27 Jan 2025 22:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738017220;
	bh=AFXXyE8v95CfzioBCb2Xv7hlTXv5LhiICb5s0v8I0To=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKtB5XDGDekFry9rzSFFDaex3oQMQ/tpN4FCxjAiLEFevNResmj1C1sgTwE80DpA/
	 jreG49ccUJUMkOs3fN7yIa80aLcv71bkZ2Ug15J6h7FyXcEoEeKQlRYSZDVDEMxYd1
	 ZsooKlUPqEE7sNYWjk2FcGIAax/Q1/KA5WbX0hRI=
Date: Mon, 27 Jan 2025 14:33:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 david@redhat.com, khalid@kernel.org, jthoughton@google.com, corbet@lwn.net,
 dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
 brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
 catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
 liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tglx@linutronix.de, cgroups@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
Message-Id: <20250127143339.b1f6b6d5586f319762c5e516@linux-foundation.org>
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:

> Memory pages shared between processes require page table entries
> (PTEs) for each process. Each of these PTEs consume some of
> the memory and as long as the number of mappings being maintained
> is small enough, this space consumed by page tables is not
> objectionable. When very few memory pages are shared between
> processes, the number of PTEs to maintain is mostly constrained by
> the number of pages of memory on the system. As the number of shared
> pages and the number of times pages are shared goes up, amount of
> memory consumed by page tables starts to become significant. This
> issue does not apply to threads. Any number of threads can share the
> same pages inside a process while sharing the same PTEs. Extending
> this same model to sharing pages across processes can eliminate this
> issue for sharing across processes as well.
> 
> ...
>
> API
> ===
> 
> mshare does not introduce a new API. It instead uses existing APIs
> to implement page table sharing. The steps to use this feature are:
> 
> 1. Mount msharefs on /sys/fs/mshare -
>         mount -t msharefs msharefs /sys/fs/mshare
> 
> 2. mshare regions have alignment and size requirements. Start
>    address for the region must be aligned to an address boundary and
>    be a multiple of fixed size. This alignment and size requirement
>    can be obtained by reading the file /sys/fs/mshare/mshare_info
>    which returns a number in text format. mshare regions must be
>    aligned to this boundary and be a multiple of this size.
> 
> 3. For the process creating an mshare region:
>         a. Create a file on /sys/fs/mshare, for example -
>                 fd = open("/sys/fs/mshare/shareme",
>                                 O_RDWR|O_CREAT|O_EXCL, 0600);
> 
>         b. Establish the starting address and size of the region
>                 struct mshare_info minfo;
> 
>                 minfo.start = TB(2);
>                 minfo.size = BUFFER_SIZE;
>                 ioctl(fd, MSHAREFS_SET_SIZE, &minfo)
> 
>         c. Map some memory in the region
>                 struct mshare_create mcreate;
> 
>                 mcreate.addr = TB(2);
>                 mcreate.size = BUFFER_SIZE;
>                 mcreate.offset = 0;
>                 mcreate.prot = PROT_READ | PROT_WRITE;
>                 mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>                 mcreate.fd = -1;
> 
>                 ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

I'm not really understanding why step a exists.  It's basically an
mmap() so why can't this be done within step d?

>         d. Map the mshare region into the process
>                 mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>                         MAP_SHARED, fd, 0);
> 
>         e. Write and read to mshared region normally.
> 
> 4. For processes attaching an mshare region:
>         a. Open the file on msharefs, for example -
>                 fd = open("/sys/fs/mshare/shareme", O_RDWR);
> 
>         b. Get information about mshare'd region from the file:
>                 struct mshare_info minfo;
> 
>                 ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
> 
>         c. Map the mshare'd region into the process
>                 mmap(minfo.start, minfo.size,
>                         PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> 5. To delete the mshare region -
>                 unlink("/sys/fs/mshare/shareme");
> 

The userspace intergace is the thing we should initially consider.  I'm
having ancient memories of hugetlbfs.  Over time it was seen that
hugetlbfs was too standalone and huge pages became more (and more (and
more (and more))) integrated into regular MM code.  Can we expect a
similar evolution with pte-shared memory and if so, is this the correct
interface to be starting out with?

