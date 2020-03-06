Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82BD17C333
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFQnt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 11:43:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgCFQnt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 11:43:49 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 16B078550CAB53C01BB0;
        Fri,  6 Mar 2020 16:43:48 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Mar 2020 16:43:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Mar 2020
 16:43:47 +0000
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
 <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
 <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
 <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com>
 <CAK8P3a2wdCrBP=a8ZypWoC=HyCU3oYYNeCddWM7oT+xM9gTPhw@mail.gmail.com>
 <182a37c2-7437-b1bd-8b86-5c9ce2e29f00@huawei.com>
 <CAK8P3a22fEGdVKVVs_40Rc_vs9SQ2ikejwMtFpyR_o+74utWaA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <15e7158d-184d-9591-89a6-cd6b10ef054d@huawei.com>
Date:   Fri, 6 Mar 2020 16:43:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a22fEGdVKVVs_40Rc_vs9SQ2ikejwMtFpyR_o+74utWaA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2020 16:29, Arnd Bergmann wrote:
>> The idea is good, but it would be nice if we just somehow use a common
>> asm-generic io.h definition directly in logic_pio.c, like:
>>
>> asm-generic io.h:
>>
>> #ifndef __raw_inw // name?
>> #define __raw_inw __raw_inw
>> static inline u16 __raw_inw(unsigned long addr)
>> {
>>          u16 val;
>>
>>          __io_pbr();
>>          val = __le16_to_cpu(__raw_readw(addr));
>>          __io_par(val);
>>          return val;
>> }
>> #endif
>>
>> #include <linux/logic_pio.h>
>>
>> #ifndef inw
>> #define inw __raw_inw
>> #endif
> Yes, makes sense. Maybe __arch_inw() then? Not great either, but I think
> that's better than __raw_inw() because __raw_* would sound like it
> mirrors __raw_readl() that lacks the barriers and byteswaps.

Right, I had the same concern. And maybe the "arch" prefix is 
misleading. Just __inw could be ok, and hopefully not conflict with the 
arch/arm/mach-* definitions.

Thanks,
John
