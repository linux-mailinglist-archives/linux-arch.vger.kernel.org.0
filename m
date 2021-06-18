Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51AC3AC129
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhFRDEI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 23:04:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:25793 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhFRDEH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 23:04:07 -0400
IronPort-SDR: wde48Q8onOCWWWLuTHKh4oHb8HudVZw8WRmTCP3Oz5kFXFaK3W/IYnv/8PCSiQLY9pioGwoFmf
 c9IqvW1D4Y+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206524997"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="206524997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:01:58 -0700
IronPort-SDR: kDCIXbw7lwEjZFI+nFNOMy4qgHpPd6rsmqYlpb0ps01Z+DdBhWSAQ5G+mGTpSRcepgH2/cP20z
 fFfj3eWUWROQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="451243562"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:01:58 -0700
Date:   Thu, 17 Jun 2021 20:01:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        dm-devel@redhat.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 01/18] mm: add a kunmap_local_dirty helper
Message-ID: <20210618030157.GA1905674@iweiny-DESK2.sc.intel.com>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615132456.753241-2-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 03:24:39PM +0200, Christoph Hellwig wrote:
> Add a helper that calls flush_kernel_dcache_page before unmapping the
> local mapping.  flush_kernel_dcache_page is required for all pages
> potentially mapped into userspace that were written to using kmap*,
> so having a helper that does the right thing can be very convenient.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/highmem-internal.h | 7 +++++++
>  include/linux/highmem.h          | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 7902c7d8b55f..bd37706db147 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -224,4 +224,11 @@ do {								\
>  	__kunmap_local(__addr);					\
>  } while (0)
>  
> +#define kunmap_local_dirty(__page, __addr)			\

I think having to store the page and addr to return to kunmap_local_dirty() is
going to be a pain in some code paths.  Not a show stopper but see below...

> +do {								\
> +	if (!PageSlab(__page))					\

Was there some clarification why the page can't be a Slab page?  Or is this
just an optimization?

> +		flush_kernel_dcache_page(__page);		\

Is this required on 32bit systems?  Why is kunmap_flush_on_unmap() not
sufficient on 64bit systems?  The normal kunmap_local() path does that.

I'm sorry but I did not see a conclusion to my query on V1. Herbert implied the
he just copied from the crypto code.[1]  I'm concerned that this _dirty() call
is just going to confuse the users of kmap even more.  So why can't we get to
the bottom of why flush_kernel_dcache_page() needs so much logic around it
before complicating the general kernel users.

I would like to see it go away if possible.

Ira

[1] https://lore.kernel.org/lkml/20210615050258.GA5208@gondor.apana.org.au/

> +	kunmap_local(__addr);					\
> +} while (0)
> +
>  #endif
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 832b49b50c7b..65f548db4f2d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -93,6 +93,10 @@ static inline void kmap_flush_unused(void);
>   * On HIGHMEM enabled systems mapping a highmem page has the side effect of
>   * disabling migration in order to keep the virtual address stable across
>   * preemption. No caller of kmap_local_page() can rely on this side effect.
> + *
> + * If data is written to the returned kernel mapping, the callers needs to
> + * unmap the mapping using kunmap_local_dirty(), else kunmap_local() should
> + * be used.
>   */
>  static inline void *kmap_local_page(struct page *page);
>  
> -- 
> 2.30.2
> 
