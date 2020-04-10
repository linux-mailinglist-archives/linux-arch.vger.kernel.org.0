Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFB1A3E63
	for <lists+linux-arch@lfdr.de>; Fri, 10 Apr 2020 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDJCiu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 22:38:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32887 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJCiu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 22:38:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay1so234785plb.0;
        Thu, 09 Apr 2020 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cm3qEVUblIBWQEP7R8pxH+eUa0WNyfWiM9J7eM+Fwmk=;
        b=AVSNgz0eR/mu36t1jtB1pHxzPsuhsLJ5Dgmcn/9c7jPOTV+CNdcyL0zkXP7nLHQzQV
         A10fzku8OWDIGvjGdvgdeH+jWjXzrllDIeVhKdprzXhQynX714rs3Td/tjGR+coEL5Aw
         9O9rN2XFZJ5QvZNpH7rO2zchnfDG/1aaYCeqb4UwllljqxtOrpvrRcKDBEk9COBYQQFO
         1jJAN0Hms3ovic+Bal9KAkQ1W5BRhoTGfKl7mwDWNfIHMcC8IP7152Er0GK1ixcZQijG
         71dIgnkhRybaZPDMrOAJ7jaWMDsjZpbv/oC14bGuigw82SaeZ2oRTYvVKah0eRNKXHb0
         NEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cm3qEVUblIBWQEP7R8pxH+eUa0WNyfWiM9J7eM+Fwmk=;
        b=GvUX1EMRNMGonWMDs6sl6S6tHfxa1eH2Pdx/Y8Wu1mWhfQ6khksEs1m+T9jE9kqE8u
         gWv+F+cvKljaPfjuo5AE48O/yTmhzM2no0LblUDqUJMF3tT2ZC8Fo8tcVpfcGduKXy9z
         qrr1VQ/q/BzSXrQBCSuczL6htWzih5ulw2FmEJdMudcqaVuGNn1ZPrvfSoYXlmA5P8SG
         7ywxFF2MSi5O3igE+YnCRCFFZCk071L23YwRx6qB/1d+NH2teJCtwaw6GR8KZlJ4nmrL
         7YHfPUjX1KHrTN4XdotQLprgHcbBgIi7sCSx3qr1FcW2WB8tL7w1NCMnOcpl0nl94mYa
         roJQ==
X-Gm-Message-State: AGi0PuY8bkPmAxijXmFIsqz3eeoYDsGpLBunDFu88olYd5rH7IP1/NHU
        mOWJjbrJBuBU8kj43o9FWls=
X-Google-Smtp-Source: APiQypJUNzW2Kf/YisQ7Gm6MjGoHraf0uboGBOm6Ai9D7kmeIiXDGo0t/+GLEITvv65wjz5MhoeSGg==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr2775900pjj.53.1586486329072;
        Thu, 09 Apr 2020 19:38:49 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id f4sm456109pjm.9.2020.04.09.19.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 19:38:48 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 10 Apr 2020 11:38:45 +0900
To:     Minchan Kim <minchan@kernel.org>
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Message-ID: <20200410023845.GA2354@jagdpanzerIV.localdomain>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <20200409160826.GC247701@google.com>
 <20200409165030.GG20713@hirez.programming.kicks-ass.net>
 <20200409170813.GD247701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409170813.GD247701@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On (20/04/09 10:08), Minchan Kim wrote:
> > > Even though I don't know how many usecase we have using zsmalloc as
> > > module(I heard only once by dumb reason), it could affect existing
> > > users. Thus, please include concrete explanation in the patch to
> > > justify when the complain occurs.
> > 
> > The justification is 'we can unexport functions that have no sane reason
> > of being exported in the first place'.
> > 
> > The Changelog pretty much says that.
> 
> Okay, I hope there is no affected user since this patch.
> If there are someone, they need to provide sane reason why they want
> to have zsmalloc as module.

I'm one of those who use zsmalloc as a module - mainly because I use zram
as a compressing general purpose block device, not as a swap device.
I create zram0, mkfs, mount, checkout and compile code, once done -
umount, rmmod. This reduces the number of writes to SSD. Some people use
tmpfs, but zram device(-s) can be much larger in size. That's a niche use
case and I'm not against the patch.

	-ss
