Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C13B276D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFXGfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 02:35:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50834 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhFXGfm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Jun 2021 02:35:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwIun-0005DQ-BZ; Thu, 24 Jun 2021 14:32:41 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwIuN-0000Wf-O4; Thu, 24 Jun 2021 14:32:15 +0800
Date:   Thu, 24 Jun 2021 14:32:15 +0800
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
        Christoph Lameter <cl@gentwo.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: scatterwalk - Remove obsolete PageSlab check
Message-ID: <20210624063215.GA31721@gondor.apana.org.au>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-2-hch@lst.de>
 <20210618030157.GA1905674@iweiny-DESK2.sc.intel.com>
 <20210618033728.GA16787@gondor.apana.org.au>
 <20210618181258.GC1905674@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618181258.GC1905674@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 18, 2021 at 11:12:58AM -0700, Ira Weiny wrote:
>
> Interesting!  Thanks!
> 
> Digging around a bit more I found:
> 
> https://lore.kernel.org/patchwork/patch/439637/

Nice find.  So we can at least get rid of the PageSlab call from
the Crypto API.

---8<---
As it is now legal to call flush_dcache_page on slab pages we
no longer need to do the check in the Crypto API.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index c837d0775474..7af08174a721 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -81,12 +81,7 @@ static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
 		struct page *page;
 
 		page = sg_page(walk->sg) + ((walk->offset - 1) >> PAGE_SHIFT);
-		/* Test ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE first as
-		 * PageSlab cannot be optimised away per se due to
-		 * use of volatile pointer.
-		 */
-		if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE && !PageSlab(page))
-			flush_dcache_page(page);
+		flush_dcache_page(page);
 	}
 
 	if (more && walk->offset >= walk->sg->offset + walk->sg->length)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
