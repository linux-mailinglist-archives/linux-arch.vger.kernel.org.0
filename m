Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE30DC44
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhBCOJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 09:09:52 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43054 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhBCOJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 09:09:50 -0500
Received: by mail-wr1-f53.google.com with SMTP id z6so24400223wrq.10;
        Wed, 03 Feb 2021 06:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7NdKPFVZmzRdCrC5SRoIaasaHnznmEayh0x0PGuBTA=;
        b=feQF8TgmgvMWXTAgeEA74jLQatxpzclMBJve54rTcQ8V8U4IXDniVeSQSPgC9lTnc1
         vu/Fxacmfmm2P967wzwUWxyk7vHTquMwyearpHBALpXEmRDXng/yO9VkdWXVZXKq1Jk9
         Rw47Y0j8lRkx3rTLZOVkkBunzHzEIlPVjqGrV/4Y+ZtgoqtGfCG1l2zsKeJLOJAeMOfj
         jLoiRTFxDJRcR+tsMkTER26lqj2rOvmGRvetQH0hfeJAg9nDcRsxvm8VqrLhH/cx0JrE
         uWhud++8GoeHRe7sJwCssUOfBCPnFZSVtVuOXxyD3lxrx0i7hHUyCTcwm384nNRKH48B
         6HqA==
X-Gm-Message-State: AOAM530G7pz1R/Ouv8ID3EeK/2fH1GA0b2w5XIlx0ydHs8gc9gyc0qQu
        sO1H1ke1IIMjYIB3prHWGsn26ZdS7wA=
X-Google-Smtp-Source: ABdhPJy9Az99qBaTfuXfDsvznn2GuE5+jkwlgksTiOBdWpqqeZNnvtVlZ2lin2xQpct0gYlRpWksfQ==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr3809982wrr.108.1612361348006;
        Wed, 03 Feb 2021 06:09:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u10sm2754907wmj.40.2021.02.03.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:09:07 -0800 (PST)
Date:   Wed, 3 Feb 2021 14:09:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Message-ID: <20210203140906.g35zr7366hh7p5f3@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-14-wei.liu@kernel.org>
 <MWHPR21MB1593959647DA60219E19C25ED7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202170248.4hds554cyxpuayqc@liuwe-devbox-debian-v2>
 <20210203132601.ftpwgs57qtok47cg@liuwe-devbox-debian-v2>
 <CAK8P3a0m8jEij-RdP1PTcNcJW2+mXQ1dA4=s+JLXhnv+NyFiHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0m8jEij-RdP1PTcNcJW2+mXQ1dA4=s+JLXhnv+NyFiHw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:49:53PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 3, 2021 at 2:26 PM Wei Liu <wei.liu@kernel.org> wrote:
> > On Tue, Feb 02, 2021 at 05:02:48PM +0000, Wei Liu wrote:
> > > On Tue, Jan 26, 2021 at 01:26:52AM +0000, Michael Kelley wrote:
> > > > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > > > > +union hv_device_id {
> > > > > + u64 as_uint64;
> > > > > +
> > > > > + struct {
> > > > > +         u64 :62;
> > > > > +         u64 device_type:2;
> > > > > + };
> > > >
> > > > Are the above 4 lines extraneous junk?
> > > > If not, a comment would be helpful.  And we
> > > > would normally label the 62 bit field as
> > > > "reserved0" or something similar.
> > > >
> > >
> > > No. It is not junk. I got this from a header in tree.
> > >
> > > I am inclined to just drop this hunk. If that breaks things, I will use
> > > "reserved0".
> > >
> >
> > It turns out adding reserved0 is required. Dropping this hunk does not
> > work.
> 
> Generally speaking, bitfields are not great for specifying binary interfaces,
> as the actual bit order can differ by architecture. The normal way we get
> around it in the kernel is to use basic integer types and define macros
> for bit masks. Ideally, each such field should also be marked with a
> particular endianess as __le64 or __be64, in case this is ever used with
> an Arm guest running a big-endian kernel.

Thanks for the information.

I think we will need to wait until Microsoft Hypervisor clearly defines
the endianess in its header(s) before we can make changes to the copy in
Linux.

> 
> That said, if you do not care about the specific order of the bits, having
> anonymous bitfields for the reserved members is fine, I don't see a
> reason to name it as reserved.

Michael, let me know what you think. I'm not too fussed either way.

Wei.

> 
>       Arnd
