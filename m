Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399D3A3C53
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFKGzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 02:55:40 -0400
Received: from verein.lst.de ([213.95.11.211]:35264 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFKGzj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Jun 2021 02:55:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D2A168AFE; Fri, 11 Jun 2021 08:53:39 +0200 (CEST)
Date:   Fri, 11 Jun 2021 08:53:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 09/16] ps3disk: use memcpy_{from,to}_bvec
Message-ID: <20210611065338.GA31210@lst.de>
References: <20210608160603.1535935-1-hch@lst.de> <20210608160603.1535935-10-hch@lst.de> <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 06:48:22PM -0700, Ira Weiny wrote:
> I'm still not 100% sure that these flushes are needed but the are not no-ops on
> every arch.  Would it be best to preserve them after the memcpy_to/from_bvec()?
> 
> Same thing in patch 11 and 14.

To me it seems kunmap_local should basically always call the equivalent
of flush_kernel_dcache_page.  parisc does this through
kunmap_flush_on_unmap, but none of the other architectures with VIVT
caches or other coherency issues does.

Does anyone have a history or other insights here?
