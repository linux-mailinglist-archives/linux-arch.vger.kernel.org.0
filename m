Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1039D1A3896
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgDIRIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 13:08:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45387 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIRIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 13:08:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id w11so1077230pga.12;
        Thu, 09 Apr 2020 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQvrRMm1xrJntOiYTsW2Lx5FztmdO0PKJyWqixStKZM=;
        b=SMSIs7zBXCYahuaxAxR+LoWlUnZeIr9zTb2pf+IjX3ssSGO4f/LJ71rs7cs+jdg3O/
         IC2318r5GGhJcELuDl/Ze0uwNXia0OcIjwna6k5blB77mj0Y4XtCiMcbIK8st3rNlQ+e
         osVfwDBBL2rIaU7lZns6ACclP5PoeUh8qegQnwkKt4YjmRM4qERNzP7oJBRDLPzgJljZ
         qy1lKCQ8rFVztGlVzfI/Rkmzy7LEt8LalUdIpP0YHvwYF+bjfC0BE4mFZcwtZ0vyDnDC
         IIFREURwImK0S68ylJtyrSaPkrzDPGZiOeOLFfr2hQJsER61wmNg7KZF/yKS5L8L3Igm
         o7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bQvrRMm1xrJntOiYTsW2Lx5FztmdO0PKJyWqixStKZM=;
        b=i3nkaZ13ETB5IUczlsyQYc9Thcx/YHhjSVhB6zhwj1wGO7PkZIEa6KzjIM2eTvuzeV
         VhoVoJa0Fp1Zm1+Io1kOZxgm0T9P4SXeu08JuiXSS636dOvB3VPRlDpOQ3Ud/is5Q4JU
         HVd1YybmDVTykG4wtC8DYe6ce3/XHFzmlCT/o7xYk6E3XwQBnN5uWX2JgWmaAbR6Ky+0
         /ieUaHVV0NvprR31j0ZxEJfAoZNTI65EEbPugMNnZnf0EeM/JuwJia9D7J87dUmhx6HA
         /uscLSKdpmxDn9pZUVolGR0Ra7RmB+Y5cCHhLRSelCQs9EcXPxwt3b7QAIBXMsV7bqMD
         Ny7w==
X-Gm-Message-State: AGi0PuahRDUn8Tv1zLIE7P0ApJYSh0GbBOnoGIPeVUMxDm31Gv0Zog2S
        kW17R47N+UzkY32rOCOpEVI=
X-Google-Smtp-Source: APiQypIGXl7ptK897jLts3QdF+EDBFxPJWcYJ6uqbpmOLvOgFWAldqFqZYwLtwgtv4/3t4lh0qbzWw==
X-Received: by 2002:a63:d143:: with SMTP id c3mr401112pgj.171.1586452097545;
        Thu, 09 Apr 2020 10:08:17 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id w142sm1167934pff.111.2020.04.09.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:08:16 -0700 (PDT)
Date:   Thu, 9 Apr 2020 10:08:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200409170813.GD247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165030.GG20713@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 09, 2020 at 06:50:30PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 09, 2020 at 09:08:26AM -0700, Minchan Kim wrote:
> > On Wed, Apr 08, 2020 at 01:59:08PM +0200, Christoph Hellwig wrote:
> > > This allows to unexport map_vm_area and unmap_kernel_range, which are
> > > rather deep internal and should not be available to modules.
> > 
> > Even though I don't know how many usecase we have using zsmalloc as
> > module(I heard only once by dumb reason), it could affect existing
> > users. Thus, please include concrete explanation in the patch to
> > justify when the complain occurs.
> 
> The justification is 'we can unexport functions that have no sane reason
> of being exported in the first place'.
> 
> The Changelog pretty much says that.

Okay, I hope there is no affected user since this patch.
If there are someone, they need to provide sane reason why they want
to have zsmalloc as module.

Acked-by: Minchan Kim <minchan@kernel.org>
