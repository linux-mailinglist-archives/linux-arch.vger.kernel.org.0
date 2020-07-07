Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AFC217610
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGGSMO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 14:12:14 -0400
Received: from foss.arm.com ([217.140.110.172]:39176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGGSMN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 14:12:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8541FB;
        Tue,  7 Jul 2020 11:12:13 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0D963F71E;
        Tue,  7 Jul 2020 11:12:10 -0700 (PDT)
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arch@vger.kernel.org, suzuki.poulose@arm.com,
        Zhenyu Ye <yezhenyu2@huawei.com>, linux-kernel@vger.kernel.org,
        xiexiangyou@huawei.com, steven.price@arm.com,
        zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org,
        prime.zeng@hisilicon.com, guohanjun@huawei.com, olof@lixom.net,
        kuhn.chenqun@huawei.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com> <20200707173617.GA32331@gaia>
 <d26f23960443a7f270847c90242e07ab@kernel.org> <20200707174612.GC32331@gaia>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <327b23f9-bc6f-ae68-72aa-b0e4a6da98f0@arm.com>
Date:   Tue, 7 Jul 2020 19:12:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707174612.GC32331@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-07-07 18:46, Catalin Marinas wrote:
> On Tue, Jul 07, 2020 at 06:43:35PM +0100, Marc Zyngier wrote:
>> On 2020-07-07 18:36, Catalin Marinas wrote:
>>> On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
>>>> @@ -59,6 +69,47 @@
>>>>   		__ta;						\
>>>>   	})
>>>>
>>>> +/*
>>>> + * __TG defines translation granule of the system, which is decided
>>>> by
>>>> + * PAGE_SHIFT.  Used by TTL.
>>>> + *  - 4KB	: 1
>>>> + *  - 16KB	: 2
>>>> + *  - 64KB	: 3
>>>> + */
>>>> +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
>>>
>>> Nitpick: maybe something like __TLBI_TG to avoid clashes in case someone
>>> else defines a __TG macro.
>>
>> I have commented on this in the past, and still maintain that this
>> would be better served by a switch statement similar to what is used
>> for TTL already (I don't think this magic formula exists in the
>> ARM ARM).
> 
> Good point, it would be cleaner indeed.

FWIW, we use the somewhat obtuse "(shift - 10) / 2" in the SMMUv3 
driver, but that's because we support multiple different granules at 
runtime and want to generate efficient code. Anything based on 
PAGE_SHIFT that resolves to a compile-time constant has no excuse for 
not being written in a clear and obvious manner ;)

Robin.
