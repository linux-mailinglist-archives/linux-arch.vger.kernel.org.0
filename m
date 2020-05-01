Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660521C2059
	for <lists+linux-arch@lfdr.de>; Sat,  2 May 2020 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEAWJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 May 2020 18:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgEAWJt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 May 2020 18:09:49 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B927520857;
        Fri,  1 May 2020 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588370988;
        bh=hyTUi8k9QleCFVpcgAZ6YYDaMkXEa5xJb5HTy4SEi9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GPQWCRRHLJg2Zl8cgmkGWbp7Tgn+ivU4M8hBbWb4IQI1sGAnX/mV/i1Lyh/amTZdC
         vgn21bnvxHvu7jVeG6N3ie5ON7pYY//OPHYOAyysUdpLdyFLZhzTvii7N+TQnFlEUw
         l0PKqTkdq3Hg476WHDApPzwvFSmjMv60SV2VPHc0=
Date:   Fri, 1 May 2020 15:09:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
        bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Message-Id: <20200501150947.367ca6b38a394f1ff678ed4b@linux-foundation.org>
In-Reply-To: <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
References: <20200414131348.444715-1-hch@lst.de>
        <20200414131348.444715-22-hch@lst.de>
        <20200414151344.zgt2pnq7cjq2bgv6@debian>
        <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
        <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 30 Apr 2020 22:38:10 -0400 John Dorminy <jdorminy@redhat.com> wrote:

> the change
> description refers to PROT_KERNEL, which is a symbol which does not
> appear to exist; perhaps PAGE_KERNEL was meant?

Yes, thanks, fixed.
