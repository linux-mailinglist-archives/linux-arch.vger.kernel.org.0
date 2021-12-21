Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4847C3A8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbhLUQVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 11:21:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4316 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhLUQVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 11:21:14 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJM602BDQz67M3D;
        Wed, 22 Dec 2021 00:16:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 21 Dec 2021 17:21:12 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 16:21:11 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     David Laight <David.Laight@ACULAB.COM>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
 <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
 <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
 <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
 <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
 <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
 <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
 <3a10b91258bf432baf51932a08335f6e@AcuMS.aculab.com>
Message-ID: <192745f2-776b-f099-f428-c142b04d9a14@huawei.com>
Date:   Tue, 21 Dec 2021 16:21:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <3a10b91258bf432baf51932a08335f6e@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19/12/2021 14:23, David Laight wrote:
>>>>> I have tested this on s390 with HAS_IOPORT=n and allyesconfig as well
>>>>> as running it with defconfig. I've also been using it on my Ryzen 3990X
>>>>> workstation with LEGACY_PCI=n for a few days. I do get about 60 MiB
>>>>> fewer modules compared with a similar config of v5.15.8. Hard to say
>>>>> which other systems might miss things of course.
>>>>>
>>>>> I have not yet worked on the discussed IOPORT_NATIVE flag. Mostly I'm
>>>>> wondering two things. For one it feels like that could be a separate
>>>>> change on top since HAS_IOPORT + LEGACY_PCI is already quite big.
>>>>> Secondly I'm wondering about good ways of identifying such drivers and
>>>>> how much this overlaps with the ISA config flag.
>> I was interesting in the IOPORT_NATIVE flag (or whatever we call it) as
>> it solves the problem of drivers which "unconditionally do inb()/outb()
>> without checking the validity of the address using firmware or other
>> methods first" being built for (and loaded on and crashing) unsuitable
>> systems. Such a problem is in [0]
>>
>> So if we want to support that later, then it seems that someone would
>> need to go back and re-edit many same driver Kconfigs – like hwmon, for
>> example. I think it's better to avoid that and do it now.
> Could you do something where valid arguments to inb() have to come
> from some kernel mapping/validation function and are never in the
> range [0x0, 0x10000).
> Then drivers that are cheating the system will fail.

That sounds like the solution which I had here:

https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/

It worked for the scenario I was interested in, but Arnd had some 
concerns, which you can check there.

> 
> Or, maybe, only allow [0x0, 0x10000) on systems that have a suitable bus.
> With the mapping functions returning a different value (eg the KVA into
> the PCI master window) that can be separately verified.
> That would let drivers do (say) inb(0x120) on systems that have (something
> like) and ISA bus, but not on PCI-only systems which support PCI IO
> accesses through a physical address window.

I'm not sure how this would look in practice. What would the check for 
the suitable bus be?

Thanks,
John
