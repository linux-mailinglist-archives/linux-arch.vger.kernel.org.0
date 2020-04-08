Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6E1A26BA
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgDHQHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 12:07:48 -0400
Received: from verein.lst.de ([213.95.11.211]:43068 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgDHQHs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 12:07:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9BEC068C4E; Wed,  8 Apr 2020 18:07:43 +0200 (CEST)
Date:   Wed, 8 Apr 2020 18:07:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        bpf@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: decruft the vmalloc API
Message-ID: <20200408160743.GA30662@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408160324.GS25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408160324.GS25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 05:03:24PM +0100, Russell King - ARM Linux admin wrote:
> I haven't read all your patches yet.
> 
> Have you tested it on 32-bit ARM, where the module area is located
> _below_ PAGE_OFFSET and outside of the vmalloc area?

I have not tested it.  However existing in-kernel users that use
different areas (and we have quite a few of those) have not been
changed at all.  I think the arm32 module loader (like various other
module loaders) falls into that category.
