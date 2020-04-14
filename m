Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42A1A81C6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437441AbgDNPOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 11:14:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54473 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437681AbgDNPNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 11:13:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2so13341992wmb.4;
        Tue, 14 Apr 2020 08:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HmBLSR0xc1v+9c640X8yq/gCGBtmZiJRhg2yrai8Uso=;
        b=D14QHr9SaRvNqJrN7V4ylJqJZJppU9twbzkK/fNI+KX4UE4L+iib2DfQxpN0Kyf9k0
         0jWxU8/32Xv3x3XlfJ86tDihFLVOxvOlzEi+ZMdwJLITS8dFK0BX1BnSFMbIukqCz67j
         Ry1D6UKhhWu8p54BC/8irvBUyM3rgmP6+q/b2UJkE1sNp9+K1kUVaK3Hqvzd2UaPuxIZ
         anSMQsSW2BVe26VRK/LLL2FrqobB6z1ttZtlJECb+JJs28wjdhWhRht82hzPbhtmGZQY
         R0TVcuvCAw7BpJsD+qr74o0Ega4Th5Rzz6uz0/Q9BGJM7Sc2yzOzFgFMlpPGsGilpct1
         7zIg==
X-Gm-Message-State: AGi0PuZzw+k35gwrD6pHLwZlJLjT1GDlWp2uALnwrcBTshm1PN1umiRv
        3/JHGYY/h+9WzdYhOwjiHQA=
X-Google-Smtp-Source: APiQypKJS2zs752mK3EmkKLPxDY+LMikzE4AHuLMlZzMU6rlOFHrjCq5D1gZZCfYEUzJLxq6M+CEVA==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr393464wmi.50.1586877227391;
        Tue, 14 Apr 2020 08:13:47 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id t67sm20386094wmg.40.2020.04.14.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:13:46 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:13:44 +0100
From:   Wei Liu <wei.liu@kernel.org>
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Message-ID: <20200414151344.zgt2pnq7cjq2bgv6@debian>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414131348.444715-22-hch@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
> The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com> [hyperv]
> Acked-by: Gao Xiang <xiang@kernel.org> [erofs]
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/hyperv/hv_init.c              |  3 +--
[...]
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 5a4b363ba67b..a3d689dfc745 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	 * not be stopped in the case of CPU offlining and the VM will hang.
>  	 */
>  	if (!*hvp) {
> -		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> -				 PAGE_KERNEL);
> +		*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>  	}

Acked-by: Wei Liu <wei.liu@kernel.org>
