Return-Path: <linux-arch+bounces-12959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE00B127A9
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jul 2025 01:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D830B3A460D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F47261574;
	Fri, 25 Jul 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WC9QXExV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63244126C1E;
	Fri, 25 Jul 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487463; cv=none; b=eOOeuGbDiT5mNG8B8eoza4/5owuVVb2KBw7paUKaSLkmkhqWAM3bTis7J6GblT8nhs9CviTwV4uJGg+EVvrwPFRze9opRY5sQ0xTYJ8YOIDAR4KuwUGzxyINhgZQKkuv86WNUizZqrJ/ZzrWFucO19+7FAadOIkqMoQwZ6w4KVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487463; c=relaxed/simple;
	bh=k2UEv3H0rQL8yvRCGdCtZL7jRC7k7qI5xjgkdT+pMnc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YqQWKO7lGFFGnvaxRvhVNKwObhG4GKh5ueCiZlQJgTbCjBmWllRNF6WHp7Vjrg99YkuSRIweIRy5LleWv23PgmV6SlALwhHJ9o9Jk1vH+UIROGEk30pMrDsMoY+gFtYxMEBMg+7/TIrq8JCl3JpD8Vo+kOlmlt0nHx4QGWAK8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WC9QXExV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F40DC4CEE7;
	Fri, 25 Jul 2025 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753487463;
	bh=k2UEv3H0rQL8yvRCGdCtZL7jRC7k7qI5xjgkdT+pMnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WC9QXExVCil7nvhzYbXj3XM3h/Vl1LWn9QMpKzNOvDfzK7tmmu6merjEVhJvQmzZv
	 yUs17VM0Wf8pDrcd2pktcCxdrBzsT/O4NubFFqw75xqNVvpwEY/HNkNuGp9pQt+3zI
	 1dZ89hPoykgJ6fKPaTCp8tj3cHuOlfHg0tFzV40c=
Date: Fri, 25 Jul 2025 16:51:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H . Peter Anvin" <hpa@zyccr.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Juergen Gross <jgross@suse.de>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Oscar Salvador <osalvador@suse.de>, Joao
 Martins <joao.m.martins@oracle.com>, Lorenzo Sccakes
 <lorenzo.stoakes@oracle.com>, Jane Chu <jane.chu@oracle.com>, Alistair
 Popple <apopple@nvidia.com>, Mike Rapoport <rppt@kernel.org>, David
 Hildenbrand <david@redhat.com>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Ard Biesheuvel
 <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>, John Hubbard
 <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>, Peter Xu
 <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>, Bibo Mao
 <maobibo@loongson.cn>, Anshuman Khandual <anshuman.khandual@arm.com>, Joerg
 Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 mm-hotfixes 0/5] mm, arch: a more robust approach to
 sync top level kernel page tables
Message-Id: <20250725165101.e636bbe3fa69ad0b73810914@linux-foundation.org>
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 10:21:01 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:

> During our internal testing, we started observing intermittent boot
> failures when the machine uses 4-level paging and has a large amount
> of persistent memory:
> 
>   BUG: unable to handle page fault for address: ffffe70000000034
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 0 P4D 0 
>   Oops: 0002 [#1] SMP NOPTI
>   RIP: 0010:__init_single_page+0x9/0x6d
>   Call Trace:
>    <TASK>
>    __init_zone_device_page+0x17/0x5d
>    memmap_init_zone_device+0x154/0x1bb
>    pagemap_range+0x2e0/0x40f
>    memremap_pages+0x10b/0x2f0
>    devm_memremap_pages+0x1e/0x60
>    dev_dax_probe+0xce/0x2ec [device_dax]
>    dax_bus_probe+0x6d/0xc9
>    [... snip ...]
>    </TASK>
> 
> ...
>
>  arch/x86/include/asm/pgalloc.h          | 20 +++++++++++++
>  arch/x86/include/asm/pgtable_64_types.h |  3 ++
>  arch/x86/mm/init_64.c                   | 37 ++++++++++++++-----------
>  arch/x86/mm/kasan_init_64.c             |  8 +++---
>  include/asm-generic/pgalloc.h           | 16 +++++++++++
>  include/linux/pgtable.h                 | 17 ++++++++++++
>  include/linux/vmalloc.h                 | 16 -----------
>  mm/kasan/init.c                         | 10 +++----
>  mm/percpu.c                             |  4 +--
>  mm/sparse-vmemmap.c                     |  4 +--
>  10 files changed, 90 insertions(+), 45 deletions(-)

Are any other architectures likely to be affected by this flaw?

It's late for 6.16.  I'd propose that this series target 6.17 and once
merged, the cc:stable tags will take care of 6.16.x and earlier.

It's regrettable that the series contains some patches which are
cc:stable and some which are not.  Because 6.16.x and earlier will end
up getting only some of these patches, so we're backporting an untested
patch combination.  It would be better to prepare all this as two
series: one for backporting and the other not.

It's awkward that some of the cc:stable patches have a Fixes: and
others do not.  Exactly which kernel version(s) are we asking the
-stable maintainers to merge these patches into?

This looks somewhat more like an x86 series than an MM one.  I can take
it via mm.git with suitable x86 acks.  Or drop it from mm.git if it
goes into the x86 tree.  We can discuss that.


For now, I'll add this to mm.git's mm-new branch.  There it will get a
bit of exposure but it will be withheld from linux-next.  Once 6.17-rc1
is released I can move this into mm.git's mm-unstable branch to expose
it to linux-next testers.

Thanks.  I'll suppress the usual added-to-mm emails, save a few electrons.

