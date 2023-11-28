Return-Path: <linux-arch+bounces-522-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABE7FC033
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553891C20AEA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666715C8FE;
	Tue, 28 Nov 2023 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27FE019A2;
	Tue, 28 Nov 2023 09:21:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 388A1C15;
	Tue, 28 Nov 2023 09:22:26 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45D33F6C4;
	Tue, 28 Nov 2023 09:21:33 -0800 (PST)
Date: Tue, 28 Nov 2023 17:21:31 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	hughd@google.com, pcc@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/27] mm: migrate/mempolicy: Add hook to modify
 migration target gfp
Message-ID: <ZWYhm34kA95ntoaq@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-5-alexandru.elisei@arm.com>
 <20231125100322.GH636165@kernel.org>
 <ZWSDGGJDWDtY0G35@raptor>
 <20231128064957.GI636165@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128064957.GI636165@kernel.org>

Hi,

On Tue, Nov 28, 2023 at 08:49:57AM +0200, Mike Rapoport wrote:
> On Mon, Nov 27, 2023 at 11:52:56AM +0000, Alexandru Elisei wrote:
> > Hi Mike,
> > 
> > I really appreciate you having a look!
> > 
> > On Sat, Nov 25, 2023 at 12:03:22PM +0200, Mike Rapoport wrote:
> > > On Sun, Nov 19, 2023 at 04:56:58PM +0000, Alexandru Elisei wrote:
> > > > It might be desirable for an architecture to modify the gfp flags used to
> > > > allocate the destination page for migration based on the page that it is
> > > > being replaced. For example, if an architectures has metadata associated
> > > > with a page (like arm64, when the memory tagging extension is implemented),
> > > > it can request that the destination page similarly has storage for tags
> > > > already allocated.
> > > > 
> > > > No functional change.
> > > > 
> > > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > > ---
> > > >  include/linux/migrate.h | 4 ++++
> > > >  mm/mempolicy.c          | 2 ++
> > > >  mm/migrate.c            | 3 +++
> > > >  3 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > > > index 2ce13e8a309b..0acef592043c 100644
> > > > --- a/include/linux/migrate.h
> > > > +++ b/include/linux/migrate.h
> > > > @@ -60,6 +60,10 @@ struct movable_operations {
> > > >  /* Defined in mm/debug.c: */
> > > >  extern const char *migrate_reason_names[MR_TYPES];
> > > >  
> > > > +#ifndef arch_migration_target_gfp
> > > > +#define arch_migration_target_gfp(src, gfp) 0
> > > > +#endif
> > > > +
> > > >  #ifdef CONFIG_MIGRATION
> > > >  
> > > >  void putback_movable_pages(struct list_head *l);
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 10a590ee1c89..50bc43ab50d6 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -1182,6 +1182,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
> > > >  
> > > >  		h = folio_hstate(src);
> > > >  		gfp = htlb_alloc_mask(h);
> > > > +		gfp |= arch_migration_target_gfp(src, gfp);
> > > 
> > > I think it'll be more robust to have arch_migration_target_gfp() to modify
> > > the flags and return the new mask with added (or potentially removed)
> > > flags.
> > 
> > I did it this way so an arch won't be able to remove flags set by the MM code.
> > There's a similar pattern in do_mmap() -> calc_vm_flag_bits() ->
> > arch_calc_vm_flag_bits().
> 
> Ok, just add a sentence about it to the commit message.

Great, will do that!

Thanks,
Alex

>  
> > Thanks,
> > Alex
> > 
> > > 
> > > >  		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
> > > >  		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
> > > >  	}
> > > > @@ -1190,6 +1191,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
> > > >  		gfp = GFP_TRANSHUGE;
> > > >  	else
> > > >  		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
> > > > +	gfp |= arch_migration_target_gfp(src, gfp);
> > > >  
> > > >  	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
> > > >  	return page_rmappable_folio(page);
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> > > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

