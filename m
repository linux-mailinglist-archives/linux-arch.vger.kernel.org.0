Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266203AC16B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFRDki (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 23:40:38 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50748 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhFRDki (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jun 2021 23:40:38 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lu5KJ-0000aH-Fe; Fri, 18 Jun 2021 11:37:51 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lu5Jw-0004Nh-Un; Fri, 18 Jun 2021 11:37:28 +0800
Date:   Fri, 18 Jun 2021 11:37:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20210618033728.GA16787@gondor.apana.org.au>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-2-hch@lst.de>
 <20210618030157.GA1905674@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618030157.GA1905674@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 17, 2021 at 08:01:57PM -0700, Ira Weiny wrote:
>
> > +		flush_kernel_dcache_page(__page);		\
> 
> Is this required on 32bit systems?  Why is kunmap_flush_on_unmap() not
> sufficient on 64bit systems?  The normal kunmap_local() path does that.
> 
> I'm sorry but I did not see a conclusion to my query on V1. Herbert implied the
> he just copied from the crypto code.[1]  I'm concerned that this _dirty() call
> is just going to confuse the users of kmap even more.  So why can't we get to
> the bottom of why flush_kernel_dcache_page() needs so much logic around it
> before complicating the general kernel users.
> 
> I would like to see it go away if possible.

This thread may be related:

https://lwn.net/Articles/240249/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
