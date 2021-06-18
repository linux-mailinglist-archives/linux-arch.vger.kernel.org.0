Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47093AD1DB
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhFRSPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 14:15:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:21508 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhFRSPK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:10 -0400
IronPort-SDR: 4BfT8humAN2ALNjUzCLOCS4uv0cmFaxGAqim28EeRyYYtSF34bEVludBax4VEqIhmX6Z+Y46v5
 p/PHYgt9Julw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="228130352"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="228130352"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:13:00 -0700
IronPort-SDR: fZjz2UBcjkF09ZLFZzZqWyvwCbkGqlZanM6atUtLAcrBp3dXyferraXT69g8eiZc0puz+dQdsp
 3jQAgCFqGSuA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="453226714"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:12:58 -0700
Date:   Fri, 18 Jun 2021 11:12:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        "David S. Miller" <davem@davemloft.net>,
        Christoph Lameter <cl@gentwo.de>
Subject: Re: [PATCH 01/18] mm: add a kunmap_local_dirty helper
Message-ID: <20210618181258.GC1905674@iweiny-DESK2.sc.intel.com>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-2-hch@lst.de>
 <20210618030157.GA1905674@iweiny-DESK2.sc.intel.com>
 <20210618033728.GA16787@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618033728.GA16787@gondor.apana.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 18, 2021 at 11:37:28AM +0800, Herbert Xu wrote:
> On Thu, Jun 17, 2021 at 08:01:57PM -0700, Ira Weiny wrote:
> >
> > > +		flush_kernel_dcache_page(__page);		\
> > 
> > Is this required on 32bit systems?  Why is kunmap_flush_on_unmap() not
> > sufficient on 64bit systems?  The normal kunmap_local() path does that.
> > 
> > I'm sorry but I did not see a conclusion to my query on V1. Herbert implied the
> > he just copied from the crypto code.[1]  I'm concerned that this _dirty() call
> > is just going to confuse the users of kmap even more.  So why can't we get to
> > the bottom of why flush_kernel_dcache_page() needs so much logic around it
> > before complicating the general kernel users.
> > 
> > I would like to see it go away if possible.
> 
> This thread may be related:
> 
> https://lwn.net/Articles/240249/

Interesting!  Thanks!

Digging around a bit more I found:

https://lore.kernel.org/patchwork/patch/439637/

Auditing all the flush_dcache_page() arch code reveals that the mapping field
is either unused, or is checked for NULL.  Furthermore, all the implementations
call page_mapping_file() which further limits the page to not be a swap page.

All flush_kernel_dcache_page() implementations appears to operate the same way
in all arch's which define that call.

So I'm confident now that additional !PageSlab(__page) checks are not needed
and this patch is unnecessary.   Christoph, can we leave this out of the kmap
API and just fold the flush_kernel_dcache_page() calls back into the bvec code?

Unfortunately, I'm not convinced this can be handled completely by
kunmap_local() nor the mem*_page() calls because there is a difference between
flush_dcache_page() and flush_kernel_dcache_page() in most archs...  [parisc
being an exception which falls back to flush_kernel_dcache_page()]...

It seems like the generic unmap path _should_ be able to determine which call
to make based on the page but I'd have to look at that more.

Ira
