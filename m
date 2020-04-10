Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE341A4C73
	for <lists+linux-arch@lfdr.de>; Sat, 11 Apr 2020 01:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJXLm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Apr 2020 19:11:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53525 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJXLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Apr 2020 19:11:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id cl8so109435pjb.3;
        Fri, 10 Apr 2020 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQcdpto7s/yGk2w0OzvQ6UptVyKViN3oMFbbBVW84wQ=;
        b=q7YTOEbnyV60h/2JZUSD3yvsv3FfYyTmAHedS5dXvC6eEJqoWdAqQM8fRMbYNEb/DL
         TWa8f1bEPIXO2DpHtzWmZ1hQdADUheduicV44X6NhmrZnsTNDIZa9VTHkg2rqK9WXs9O
         CtfQg7RxKV1aU+9PajTKBmDFHloR88hUsjTCxairuAofrjSvkiIjlmrksHhAsr4eSull
         P/eN5aSURPoT5uOWbLvn9TO2HAsL3MlV2FT0WDF8H+ov5BHzMNCa3A04caDPl50c1Iqw
         Q60AlHo9v7XVZ5xht9Dtvdi6fj0cEQuu9XG4/VxucECmylB5pc3N/jO1PdzV7ryJfNk2
         odzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bQcdpto7s/yGk2w0OzvQ6UptVyKViN3oMFbbBVW84wQ=;
        b=jFjuvyzg8iHEn0BzyXsyOcuMX+9/ulPTf8RuLKDgxteAeIWT3kPyc6Vvt8lhhKq4EM
         5H22CXcPxBL5U5vXSljQ+6okr3V4GTlyg88ZPLWhTJKh/N3uLtJOrd8fd2Fs0wXy7l2a
         14XQHNKslSG003xjm4riGXvGyoboJCUOplKBF1SYU3GBhw/tUb8I53U7R1lN5hyTS6sn
         vx39QM2Vi4+onOHVWFq7B7QG/eeksxGzne3KkQo/CwJgwHvnXbHyBhBNDct/qrhjWOhP
         f2psHDCGqcCdUU4OiTqtnGEmRUzFBcvBKAn5rO63gM0c2qM52nbhrps1ZfzAwQKHnMRU
         DjBw==
X-Gm-Message-State: AGi0PubCEw3nWKBkKxeofpAlyUv341TQbMzuDHi9gRHEhFOwnwP9ERWb
        9E5LgX7ZErVLKrbyhrn2Aj0=
X-Google-Smtp-Source: APiQypIEPforRWpT0WXypxL4A3ey15BGc+kDge0iIn1cftbyny3ESjfu/Br0BZMCFGD2PtWlRrOKew==
X-Received: by 2002:a17:902:b409:: with SMTP id x9mr6968379plr.125.1586560301031;
        Fri, 10 Apr 2020 16:11:41 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id 15sm2629073pfu.186.2020.04.10.16.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 16:11:39 -0700 (PDT)
Date:   Fri, 10 Apr 2020 16:11:36 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20200410231136.GA101325@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
 <20200410023845.GA2354@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410023845.GA2354@jagdpanzerIV.localdomain>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sergey,

On Fri, Apr 10, 2020 at 11:38:45AM +0900, Sergey Senozhatsky wrote:
> On (20/04/09 10:08), Minchan Kim wrote:
> > > > Even though I don't know how many usecase we have using zsmalloc as
> > > > module(I heard only once by dumb reason), it could affect existing
> > > > users. Thus, please include concrete explanation in the patch to
> > > > justify when the complain occurs.
> > > 
> > > The justification is 'we can unexport functions that have no sane reason
> > > of being exported in the first place'.
> > > 
> > > The Changelog pretty much says that.
> > 
> > Okay, I hope there is no affected user since this patch.
> > If there are someone, they need to provide sane reason why they want
> > to have zsmalloc as module.
> 
> I'm one of those who use zsmalloc as a module - mainly because I use zram
> as a compressing general purpose block device, not as a swap device.
> I create zram0, mkfs, mount, checkout and compile code, once done -
> umount, rmmod. This reduces the number of writes to SSD. Some people use
> tmpfs, but zram device(-s) can be much larger in size. That's a niche use
> case and I'm not against the patch.

It doesn't mean we couldn't use zsmalloc as module any longer. It means
we couldn't use zsmalloc as module with pgtable mapping whcih was little
bit faster on microbenchmark in some architecutre(However, I usually temped
to remove it since it had several problems). However, we could still use
zsmalloc as module as copy way instead of pgtable mapping. Thus, if someone
really want to rollback the feature, they should provide reasonable reason
why it doesn't work for them. "A little fast" wouldn't be enough to exports
deep internal to the module.

Thanks.
