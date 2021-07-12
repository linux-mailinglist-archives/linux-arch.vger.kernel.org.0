Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328F03C62F1
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhGLSyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 14:54:00 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43641 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhGLSx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 14:53:59 -0400
Received: by mail-wr1-f48.google.com with SMTP id a13so26972072wrf.10;
        Mon, 12 Jul 2021 11:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5+8/I2xuFzJHMxWB2HAAJNVN0cTcc2X0j3gTSMtEos=;
        b=Ju7PgHJxykQPSMAXpwq2MFXhdCTsYJ9XgKJ6NfzrvFpjsPBYfi2QyN70BH+XvnHM5A
         /+Ad9CSoUqILSmUQzjR6u8kqYUmaKONRlDkvTubVFOQbCNG0V9r9C8oJQsFl834yfCcL
         jzFNSY1drd87jZ8iyVNQuNAL7T7tLC7gr+e86A5yiPuVHKjUchHTvLPGGRp07FxRJ34R
         o8ty4ljZdLC6RDqPGZ8nFOkvglWkEVAxxtqtKVJ+H8LjAb4i0XIr+J+Im9dPjzB4Fx+d
         Bibldbo3pGrVpWfQ4HG5UWsqEhDTNRT1tM2WE0SPkHySLd+58H+4Kj2MkF8BhJZb8j5f
         /BnA==
X-Gm-Message-State: AOAM5320zL0a45MjoqCmTl2RAEwCqsfRzUbYmfXY6eaWD145pO6k/umL
        mmNjMQt7LEXrwVKrxrhv75U=
X-Google-Smtp-Source: ABdhPJytMD7fHPo8L1VMOxqwMmVo06a6lDvGxQ1/JVNRo2AE71fbjGksdN8pIFce9ihWXxkZ9bLhyw==
X-Received: by 2002:a05:6000:136a:: with SMTP id q10mr498157wrz.25.1626115869811;
        Mon, 12 Jul 2021 11:51:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 11sm248292wmo.10.2021.07.12.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:51:09 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:51:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be
 arch neutral
Message-ID: <20210712185107.vgm2qyltftzmfua7@liuwe-devbox-debian-v2>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
 <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
 <20210712182400.yze3wochnyccaflw@liuwe-devbox-debian-v2>
 <MWHPR21MB15930361106EDB7183D3505CD7159@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15930361106EDB7183D3505CD7159@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 06:41:21PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Monday, July 12, 2021 11:24 AM
> > 
> > On Sun, Jul 11, 2021 at 08:25:14PM -0700, Michael Kelley wrote:
> > [...]
> > > +int hv_common_cpu_init(unsigned int cpu)
> > > +{
> > > +	void **inputarg, **outputarg;
> > > +	u64 msr_vp_index;
> > > +	gfp_t flags;
> > > +	int pgcount = hv_root_partition ? 2 : 1;
> > > +
> > > +	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> > > +	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> > > +
> > > +	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> > 
> > This is changed from alloc_pages to kmalloc. Does it ensure the
> > alignment is still correct?
> > 
> > Wei.
> 
> It does.  The alignment guarantee made by kmalloc() was changed a
> couple of years ago.  See commit 59bb47985c1d.  Here's the current text
> from the comments preceding kmalloc():
> 
> * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
>  * bytes. For @size of power of two bytes, the alignment is also guaranteed
>  * to be at least to the size.

OK. That's good.

Wei.

> 
> Michael
> 
