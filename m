Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B03A763A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 07:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFOFGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 01:06:23 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50656 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhFOFGW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 01:06:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lt1Ec-0006cw-4n; Tue, 15 Jun 2021 13:03:34 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lt1E3-0001MR-0g; Tue, 15 Jun 2021 13:02:59 +0800
Date:   Tue, 15 Jun 2021 13:02:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ira Weiny <ira.weiny@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/16] ps3disk: use memcpy_{from,to}_bvec
Message-ID: <20210615050258.GA5208@gondor.apana.org.au>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-10-hch@lst.de>
 <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
 <20210611065338.GA31210@lst.de>
 <20210612040743.GG1600546@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612040743.GG1600546@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 11, 2021 at 09:07:43PM -0700, Ira Weiny wrote:
>
> More recently this was added:
> 
> 7e34e0bbc644 crypto: omap-crypto - fix userspace copied buffer access
> 
> I'm CC'ing Tero and Herbert to see why they added the SLAB check.

Probably because the generic Crypto API has the same check.  This
all goes back to

commit 4f3e797ad07d52d34983354a77b365dfcd48c1b4
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Feb 9 14:22:14 2009 +1100

    crypto: scatterwalk - Avoid flush_dcache_page on slab pages

    It's illegal to call flush_dcache_page on slab pages on a number
    of architectures.  So this patch avoids doing so if PageSlab is
    true.

    In future we can move the flush_dcache_page call to those page
    cache users that actually need it.

    Reported-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

But I can't find any emails discussing this so let me ask Dave
directly and see if he can tell us what the issue was or might
have been.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
