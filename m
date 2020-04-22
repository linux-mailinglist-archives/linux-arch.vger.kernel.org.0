Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834551B4CB4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDVSei (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 14:34:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:42465 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDVSei (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 14:34:38 -0400
IronPort-SDR: ZLOf+r8bVl/4TgDdUpoqgcd1rfYLGVt/BszNpHbo5heeBPxQQoXg0tj6b/ZqkxGEjO3/6/WQnL
 Q1/eGt6qC3aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 11:34:22 -0700
IronPort-SDR: Uaw9oAX7iOna9W24Ebw7UElOxqgzMM/x/sltDlgLeboc8rB7guAUh6gtjBC2y+SX2hko4XLiq4
 JMpQLRX+vS7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="259165390"
Received: from ddmurill-mobl.amr.corp.intel.com (HELO [10.255.229.247]) ([10.255.229.247])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 11:34:22 -0700
Subject: Re: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
To:     Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-4-steven.price@arm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <6ebff138-a6ad-75c9-bfe5-b7174098e878@intel.com>
Date:   Wed, 22 Apr 2020 11:34:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200422142530.32619-4-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/22/20 7:25 AM, Steven Price wrote:
> Because shmem can swap pages back in without restoring
> the userspace PTE it is also necessary to add a hook for shmem.

I think the swap readahead code does this as well.  It pulls the page
into the swap cache, but doesn't map it in.

...
> +static DEFINE_XARRAY(mte_pages);
> +
> +void *mte_allocate_tag_storage(void)
> +{
> +	/* tags granule is 16 bytes, 2 tags stored per byte */
> +	return kmalloc(PAGE_SIZE / 16 / 2, GFP_KERNEL);
> +}

Yikes, so this eats 2k of unmovable kernel memory per 64k of swap?  This
is *probably* worth having its own slab just so the memory that's used
for it is less opaque.  It could be pretty large.  But, I guess if
you're worried about how much kernel memory this can eat, there's always
the swap cgroup controller to enforce limits.

This also *increases* the footprint of a page while it's in the swap
cache.  That's at least temporarily a _bit_ counterproductive.

I guess there aren't any nice alternatives, though.  I would imagine
that it would be substantially more complicated to rig the swap code up
to write the tag along with the data.  Or, to store the tag data
somewhere *it* can be reclaimed, like in a kernel-internal shmem file or
something.

> +void mte_free_tag_storage(char *storage)
> +{
> +	kfree(storage);
> +}
> +
> +int mte_save_tags(struct page *page)
> +{
> +	void *tag_storage, *ret;
> +
> +	if (!test_bit(PG_mte_tagged, &page->flags))
> +		return 0;
> +
> +	tag_storage = mte_allocate_tag_storage();
> +	if (!tag_storage)
> +		return -ENOMEM;
> +
> +	mte_save_page_tags(page_address(page), tag_storage);
> +
> +	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);

This is indexing into the xarray with the swap entry.val established in
do_swap_page()?  Might be nice to make a note where it came from.

> +	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
> +		mte_free_tag_storage(tag_storage);
> +		return xa_err(ret);
> +	} else if (ret) {
> +		mte_free_tag_storage(ret);

Is there a missing "return ret;" here?  Otherwise, it seems like this
might silently fail to save the page's tags.  I'm not sure what
non-xa_is_err() codes get returned, but if there is one, it could end up
here.

> +	}
> +
> +	return 0;
> +}
...

> +void mte_sync_tags(pte_t *ptep, pte_t pte)
> +{
> +	struct page *page = pte_page(pte);
> +	pte_t old_pte = READ_ONCE(*ptep);
> +	swp_entry_t entry;
> +
> +	set_bit(PG_mte_tagged, &page->flags);
> +
> +	if (!is_swap_pte(old_pte))
> +		return;
> +
> +	entry = pte_to_swp_entry(old_pte);
> +	if (non_swap_entry(entry))
> +		return;
> +
> +	mte_restore_tags(entry, page);
> +}

Oh, here it is!  This gets called when replacing a swap PTE with a
present PTE and restores the tags on swap-in.

Does this work for swap PTEs which were copied at fork()?  I *think*
those might end up in here twice, once for the parent and another for
the child.  If both read the page, both will fault and both will do a
set_pte() and end up in here.  I don't think it will do any harm since
it will just set_bit(PG_mte_tagged) twice and restore the same tags
twice.  But, it might be nice to call that out.

This function is a bit light on comments.  It might make sense, for
instance to note that 'pte' is always a tagged PTE at this point.
