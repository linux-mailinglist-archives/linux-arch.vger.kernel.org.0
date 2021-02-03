Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80330DBCC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBCNuw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 08:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhBCNuv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 08:50:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428C364F74;
        Wed,  3 Feb 2021 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612360210;
        bh=T8QKz01mCo74ckdQQ6dLGoIrJyBA3kMHFWwx0BPy+GY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sgAHl396bC/vDbUnEo+D7kLbPdMDjJrXmC6r36iUQDBLpVAZvbk/m2dQlyDKD/foE
         whZY+3M7TOxM+0881KHrxVmAP8Tj9Xc5TDS30WixPnqYDV3EEkAYMR/O0S9XYxZPmI
         OS6unieQhRuLekg+MASqBzOn6Se0j+RtU8463mqShRuV6GH1Bi57tuamBbdM6ixq7Q
         2jKc8TLsFRWweCJBR1qTtbLMDmFYy9atDrMCzOeoJBgRbNWO3IEzdyz9JBXX4RpUNR
         OzccRNDvbvT+PjaDwas5C0PLXvMzL8syYdhCWQX4dWEa+IWT2C3UX5w0nYD1keHeXH
         N4PIwssjd5Xuw==
Received: by mail-oi1-f181.google.com with SMTP id n7so26731927oic.11;
        Wed, 03 Feb 2021 05:50:10 -0800 (PST)
X-Gm-Message-State: AOAM532czPQIKo7fCaPg1iKxbaWovhMmQQPA/YurnlcOFROb12OiqHwP
        Xcm6YIwfahF2eMA+IvRtq4Cj0ji0q3SSA9vgxgU=
X-Google-Smtp-Source: ABdhPJyXScMKqmrmAKp8hOV509EZpHGS8g4L+3tgvovafCqNYdXrDJo1vItWqzi3+2/6fzjPIGfwnFPLJrvJIiAETr8=
X-Received: by 2002:aca:eb0a:: with SMTP id j10mr2098549oih.4.1612360209432;
 Wed, 03 Feb 2021 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-14-wei.liu@kernel.org>
 <MWHPR21MB1593959647DA60219E19C25ED7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202170248.4hds554cyxpuayqc@liuwe-devbox-debian-v2> <20210203132601.ftpwgs57qtok47cg@liuwe-devbox-debian-v2>
In-Reply-To: <20210203132601.ftpwgs57qtok47cg@liuwe-devbox-debian-v2>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 3 Feb 2021 14:49:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0m8jEij-RdP1PTcNcJW2+mXQ1dA4=s+JLXhnv+NyFiHw@mail.gmail.com>
Message-ID: <CAK8P3a0m8jEij-RdP1PTcNcJW2+mXQ1dA4=s+JLXhnv+NyFiHw@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 3, 2021 at 2:26 PM Wei Liu <wei.liu@kernel.org> wrote:
> On Tue, Feb 02, 2021 at 05:02:48PM +0000, Wei Liu wrote:
> > On Tue, Jan 26, 2021 at 01:26:52AM +0000, Michael Kelley wrote:
> > > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > > > +union hv_device_id {
> > > > + u64 as_uint64;
> > > > +
> > > > + struct {
> > > > +         u64 :62;
> > > > +         u64 device_type:2;
> > > > + };
> > >
> > > Are the above 4 lines extraneous junk?
> > > If not, a comment would be helpful.  And we
> > > would normally label the 62 bit field as
> > > "reserved0" or something similar.
> > >
> >
> > No. It is not junk. I got this from a header in tree.
> >
> > I am inclined to just drop this hunk. If that breaks things, I will use
> > "reserved0".
> >
>
> It turns out adding reserved0 is required. Dropping this hunk does not
> work.

Generally speaking, bitfields are not great for specifying binary interfaces,
as the actual bit order can differ by architecture. The normal way we get
around it in the kernel is to use basic integer types and define macros
for bit masks. Ideally, each such field should also be marked with a
particular endianess as __le64 or __be64, in case this is ever used with
an Arm guest running a big-endian kernel.

That said, if you do not care about the specific order of the bits, having
anonymous bitfields for the reserved members is fine, I don't see a
reason to name it as reserved.

      Arnd
