Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E91AD13E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgDPUhm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Apr 2020 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgDPUhl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 16:37:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0DC061A0C;
        Thu, 16 Apr 2020 13:37:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so2186142pfc.12;
        Thu, 16 Apr 2020 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XptGLsb8LK835cBV0jSCf0HRG/zsBSED6dv7tPgulp4=;
        b=gnCYkWmGETLB8PFSLV04Wdrz2FK+gEIIVYi1koqv0Kj68T1sE9a0zKATXAPY7gyzfJ
         suAROh/dNMoI6pHy/mCCmAEukmmvuLcuT+oRiOR7pSsJ7zs8in52Gebp1M1SYorAU4tK
         gOw3D6aDwjxZUg6c2JW6Y26Oj3CTSIyaIex5HlRUwrN0Akr9mc2rJN/ETJ63AkMWNaPZ
         lBqmfTlQr2tQLv3hxk3korpwrPMIzUOkCHKM9MiAc5EcYNrnyoXofMkm1N6eYHhs/DeF
         913mMDnNGshbbDlgR/ygTf2Uto9ROB2t1oEKoFobtuWYnROIBcT0nnQEOaLeZGRWafc8
         pefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XptGLsb8LK835cBV0jSCf0HRG/zsBSED6dv7tPgulp4=;
        b=MxW0PSGrt0SfuwDyrVTKA3/ccX+uoQSfUwzzRijA+xbrXZ8N3RR3XATDn3qwVTRRDL
         iGCVR32pLV8H7j0LFp1Ni7HdIGpXH+H/a6Uqp2jgP1Dnpqyzii0KvvFOSU+aQXyXqkXj
         iqeZGbSSs0NOyTyMZum/tpG5eyng8DJCb2B31lEyTDbeDgqMs5VJKwXCrBOReaclTLq/
         15bQb8DPi27+330AWKImJ0vyuplQT4mnL0i2r8BOwHDwWz706yYzJpiKu0BlaCy6BjS1
         OY9Aapp+wyBRXbc8SyIQtg/lRcLipRQ51tiVcnzjp1zY0JxfvqyBQq4noNlB1NQQrtd5
         oqyQ==
X-Gm-Message-State: AGi0PuYZnxIMTeu51BcxARMuli6w1G9tnZ/nM0H3b1cchJLd6EZ5IBF4
        om3sGt3jb63zUcpvsdtrREY=
X-Google-Smtp-Source: APiQypLz/G622vMAZI/1t7tx6iXdrAiprqdhsptFvPk2bcCnaQJR//IYq0Xxli2CBTatOLYd6eCB1g==
X-Received: by 2002:a63:2e03:: with SMTP id u3mr15186804pgu.121.1587069460712;
        Thu, 16 Apr 2020 13:37:40 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id u13sm3654978pjb.45.2020.04.16.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:37:38 -0700 (PDT)
Date:   Thu, 16 Apr 2020 13:37:36 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200416203736.GB50092@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
 <20200410231136.GA101325@google.com>
 <20200411072052.GA31242@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411072052.GA31242@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,


Sorry for the late.

On Sat, Apr 11, 2020 at 09:20:52AM +0200, Christoph Hellwig wrote:
> Hi Minchan,
> 
> On Fri, Apr 10, 2020 at 04:11:36PM -0700, Minchan Kim wrote:
> > It doesn't mean we couldn't use zsmalloc as module any longer. It means
> > we couldn't use zsmalloc as module with pgtable mapping whcih was little
> > bit faster on microbenchmark in some architecutre(However, I usually temped
> > to remove it since it had several problems). However, we could still use
> > zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
> > really want to rollback the feature, they should provide reasonable reason
> > why it doesn't work for them. "A little fast" wouldn't be enough to exports
> > deep internal to the module.
> 
> do you have any data how much faster it is on arm (and does that include
> arm64 as well)?  Besides the exports which were my prime concern,

https://github.com/sjenning/zsmapbench

I need to recall the memory. IIRC, it was almost 30% faster at that time
in ARM so was not trivial at that time. However, it was story from
several years ago.

> zsmalloc with pgtable mappings also is the only user of map_kernel_range
> outside of vmalloc.c, if it really is another code base for tiny
> improvements we could mark map_kernel_range or in fact remove it entirely
> and open code it in the remaining callers.

I alsh have temped to remove it. Let me have time to revist it in this
chance.

Thanks.
