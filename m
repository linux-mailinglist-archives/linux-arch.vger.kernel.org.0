Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A23C62C6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 20:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhGLSnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 14:43:39 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:43855 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 14:43:38 -0400
Received: by mail-wm1-f42.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so657768wmc.2;
        Mon, 12 Jul 2021 11:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D59GsRYdhJINiP6dq9QYRT2Bb38FejzYmevLyP1CGwk=;
        b=K5rfQCcA/SmLi5LkQMCIc9LxSqCeeC2OdTRhfSeqtNTJ6UarZAD0jTOe4lCknNKeRz
         AefSkIbWwvH/689eOGaMoGRXczWuhcXU/8y57Zhh/mAPhU7WV+mnTf9UnowHaiF6jnal
         ChauwKlcjShfdWl2Lt7iqVlqC8KCBPn8BHnDqaereGFzkmPUc570CbqPIooaVNOklAje
         aYBXfTWGmRPS4T4OGOoq5asfhSRGxa/JJm5n88mO2QF0rB2aCDNMKPWiQaP5zDmTW6Lf
         /D74+PTbVcCSapyPs295Ev6Z6tRU6NHFuGDByesNywMHiwF4x+NHCo2oH9xJrr5B9kQ1
         ACJw==
X-Gm-Message-State: AOAM532uO2+5S/rMqGrfWahB8GKjhfTkjmuPWRewRkVfSHrUuronZGwD
        POOeSxRUhnB2Z2MYQOeCsq4=
X-Google-Smtp-Source: ABdhPJw/Mzd4lbM22UySRWqhSgvJP0Dua+t9FdOBysWuxCrxQg00ymckYgDUxCmtNQEnvONsSHYMRA==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr9895715wmf.36.1626115249254;
        Mon, 12 Jul 2021 11:40:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k20sm14173959wrd.70.2021.07.12.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:40:48 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:40:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be
 arch neutral
Message-ID: <20210712184047.cyrebl6orh5znmkk@liuwe-devbox-debian-v2>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
 <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
 <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 06:24:00PM +0000, Wei Liu wrote:
> On Sun, Jul 11, 2021 at 08:25:14PM -0700, Michael Kelley wrote:
> [...]
> > +int hv_common_cpu_init(unsigned int cpu)
> > +{
> > +	void **inputarg, **outputarg;
> > +	u64 msr_vp_index;
> > +	gfp_t flags;
> > +	int pgcount = hv_root_partition ? 2 : 1;
> > +
> > +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > +	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> > +
> > +	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> 
> This is changed from alloc_pages to kmalloc. Does it ensure the
> alignment is still correct? 

kmalloc is rather complex and can be backed by either SLUB, SLAB or
SLOB, all of which differ from the others.

I _think_ for large allocations (> 1 native page) they tend to pass the
request on to the page allocator, but still there is a level of
indirection.

If the host page size is 64KiB, while the allocation is only 4KiB or
8KiB, could there be a chance that they become misaligned?

Wei.

> 
> Wei.
