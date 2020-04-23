Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9291B5935
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDWKcQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 06:32:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:4641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWKcP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 06:32:15 -0400
IronPort-SDR: XoMvfqoXksFUn2hasl/uqQQGlt+7qs015ZYwg0/ihw5Kx6hK7QVu3jaQMBwSHdXp5O5w30y+sT
 McyKaIJMdzGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 03:32:15 -0700
IronPort-SDR: Tbx4AP8Zju7uVt+bsFFBuorEKEDp+DufEyq0utUZQmn5wkfXhsC5SmipnzOBUDHfLSF+NGOyYH
 O/V5r9IH1k5g==
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="247718369"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 03:32:10 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 158F7204C6; Thu, 23 Apr 2020 13:32:08 +0300 (EEST)
Date:   Thu, 23 Apr 2020 13:32:08 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/29] staging: media: ipu3: use vmap instead of
 reimplementing it
Message-ID: <20200423103207.GO5381@paasikivi.fi.intel.com>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414131348.444715-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 14, 2020 at 03:13:23PM +0200, Christoph Hellwig wrote:
> Just use vmap instead of messing with vmalloc internals.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
