Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5861F47C41C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbhLUQtC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 11:49:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4317 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhLUQtB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Dec 2021 11:49:01 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJMnD4ZC8z6GDFT;
        Wed, 22 Dec 2021 00:47:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 17:48:59 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 16:48:58 +0000
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
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
 <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
 <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
 <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
 <d45ee18a-1faa-9c56-071d-18f5737d225c@huawei.com>
 <11e180449d82e5276586cdaab5e70a1c1b3adb42.camel@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3d543c90-383f-647a-5cd4-f7fd4e7246ad@huawei.com>
Date:   Tue, 21 Dec 2021 16:48:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <11e180449d82e5276586cdaab5e70a1c1b3adb42.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/12/2021 09:27, Niklas Schnelle wrote:
>>   > My feeling is that in this case we want some other dependency, e.g. a
>>   > new CONFIG_LPC. It should actually be possible to use this driver on
>>   > any machine with an LPC bus, which would by definition be the primary
>>   > I/O space, so it should be possible to load it on Arm64.
>>
>> You did suggest HARDCODED_IOPORT earlier in this thread, and the
>> definition/premise there seemed sensible to me.
>>
>> Anyway it seems practical to make all these changes in a single series,
>> so need a way forward as Niklas has no such changes for this additional
>> kconfig option.
>>
>> As a start, may I suggest we at least have Niklas' patch committed to a
>> dev branch based on -next or latest mainline release for further analysis?
>>
>> Thanks,
>> John
>>
>>
> My plan would be to split the patch up into more manageable pieces as
> suggested by Arnd plus of course fixes like the missing ARM select. As
> Arnd suggested I'll split the HAS_IOPORT additions into the initial
> introduction plus arch selects and then the HAS_IOPORT dependencies per
> subsytem. I think these per subsystem dependency patches then would be
> a great place to find drivers which should have a different dependency
> be it on LPC or a newly introduced HARDCODED_IOPORT. The thing is we
> can find and check HAS_IOPORT dependencies easily but it's hard to find
> HARDCODED_IOPORT so I think the lattter should be a refinement of the
> former. It can of course still go in as a single series. I'll
> definitely make the next iteration available as a git branch.

I'll do an audit for what would require HARDCODED_IOPORT to understand 
the scope while you can continue the work on your current path.

Thanks,
john

