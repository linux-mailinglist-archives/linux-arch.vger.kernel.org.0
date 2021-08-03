Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD13DEBAA
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhHCLYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Aug 2021 07:24:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3569 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhHCLYd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Aug 2021 07:24:33 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfCF55N1Kz6F7wr;
        Tue,  3 Aug 2021 19:24:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 13:24:21 +0200
Received: from [10.47.27.165] (10.47.27.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 12:24:20 +0100
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
 <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
Date:   Tue, 3 Aug 2021 12:23:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.165]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> Anyway, one thing I mentioned earlier was that we could solve the
>> problem of drivers accessing unmapped IO ports and crashing systems on
>> archs which define PCI_IOBASE by building them under some "native port
>> IO support" flag.
> Right, that was part of the goal here.

Great

> 
>> One example of such a driver was F71805F sensor. You put that under
>> HAS_IOPORT, which would be available for all archs, I think. But I could
>> not see where config LEGACY_PCI is introduced. Could we further refine
>> that config to not build for such archs as arm64?
>>
>> BTW, I think that the PPC dependency was added there to stop building
>> for power for that same reason, so hopefully we get rid of that.
> Good point. It seems that I actually never added the LEGACY_PCI option
> to my patch,

ok, it would be nice to see that.

> so I'm just not building those drivers any more, and not
> defining the inb()/outb() helpers either, causing a build failure when I'm
> missing an option.
> 
> However it sounds like you are interested in a third option here, which
> brings us to:
> 
> LEGACY_PCI: any PCI driver that uses inb()/outb() or is only available
>      on old-style PCI but not PCIe hardware without a bridge.
>      To be disabled for most architectures and possibly distros but can
>      be enabled for kernels that want to use those devices, as long as
>      CONFIG_HAS_IOPORT is set by the architecture.
> 
> HAS_IOPORT: not a legacy PCI device, but can only be built on
>      architectures that define inb()/outb(). To be disabled for s390
>      and any other machine that has no useful definition of those
>      functions.

That seems reasonable. And asm-generic io.h should be ifdef'ed by 
HAS_IOPORT. In your patch you had it under CONFIG_IOPORT - was that 
intentional?

On another point, I noticed SCSI driver AHA152x depends on ISA, but is 
not an isa driver - however it does use port IO. Would such dependencies 
need to be changed to depend on HAS_IOPORT?

I did notice that arm32 support CONFIG_ISA - not sure why.

> 
> HARDCODED_IOPORT: (or another name you might think of,) Used by
>     drivers that unconditionally do inb()/outb() without checking the
>     validity of the address using firmware or other methods first.
>     depends on HAS_IOPORT and possibly architecture specific
>     settings.

Yeah, that sounds the same as what I was thinking. Maybe IOPORT_NATIVE 
could work as a name. I would think that only x86/ia64 would define it. 
A concern though is that someone could argue that is a functional 
dependency, rather than just a build dependency.

Thanks,
John

