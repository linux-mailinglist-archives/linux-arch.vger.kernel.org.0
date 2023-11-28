Return-Path: <linux-arch+bounces-520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0A7FC022
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB43FB21527
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E155B5C3;
	Tue, 28 Nov 2023 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88FF610EC;
	Tue, 28 Nov 2023 09:17:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99F93C15;
	Tue, 28 Nov 2023 09:18:20 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3773F6C4;
	Tue, 28 Nov 2023 09:17:28 -0800 (PST)
Date: Tue, 28 Nov 2023 17:17:25 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/27] mm: page_alloc: Add an arch hook to allow
 prep_new_page() to fail
Message-ID: <ZWYgpVFpQNxKrQM2@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-6-alexandru.elisei@arm.com>
 <dadc9d17-f311-47f1-a264-28b42bed0ab0@redhat.com>
 <ZWSHF2hVOPTBIQLY@raptor>
 <0a0f9345-3138-4e89-80cd-c7edaf2ff62d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0f9345-3138-4e89-80cd-c7edaf2ff62d@redhat.com>

Hi,

On Tue, Nov 28, 2023 at 05:57:31PM +0100, David Hildenbrand wrote:
> On 27.11.23 13:09, Alexandru Elisei wrote:
> > Hi,
> > 
> > Thank you so much for your comments, there are genuinely useful.
> > 
> > On Fri, Nov 24, 2023 at 08:35:47PM +0100, David Hildenbrand wrote:
> > > On 19.11.23 17:56, Alexandru Elisei wrote:
> > > > Introduce arch_prep_new_page(), which will be used by arm64 to reserve tag
> > > > storage for an allocated page. Reserving tag storage can fail, for example,
> > > > if the tag storage page has a short pin on it, so allow prep_new_page() ->
> > > > arch_prep_new_page() to similarly fail.
> > > 
> > > But what are the side-effects of this? How does the calling code recover?
> > > 
> > > E.g., what if we need to populate a page into user space, but that
> > > particular page we allocated fails to be prepared? So we inject a signal
> > > into that poor process?
> > 
> > When the page fails to be prepared, it is put back to the tail of the
> > freelist with __free_one_page(.., FPI_TO_TAIL). If all the allocation paths
> > are exhausted and no page has been found for which tag storage has been
> > reserved, then that's treated like an OOM situation.
> > 
> > I have been thinking about this, and I think I can simplify the code by
> > making tag reservation a best effort approach. The page can be allocated
> > even if reserving tag storage fails, but the page is marked as invalid in
> > set_pte_at() (PAGE_NONE + an extra bit to tell arm64 that it needs tag
> > storage) and next time it is accessed, arm64 will reserve tag storage in
> > the fault handling code (the mechanism for that is implemented in patch #19
> > of the series, "mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for
> > mprotect(PROT_MTE)").
> > 
> > With this new approach, prep_new_page() stays the way it is, and no further
> > changes are required for the page allocator, as there are already arch
> > callbacks that can be used for that, for example tag_clear_highpage() and
> > arch_alloc_page(). The downside is extra page faults, which might impact
> > performance.
> > 
> > What do you think?
> 
> That sounds a lot more robust, compared to intermittent failures to allocate
> pages.

Great, thank you for the feedback, I will use this approach for the next
iteration of the series.

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

