Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284262D21D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 05:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKQEH5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 23:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQEHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 23:07:31 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FF23DF82;
        Wed, 16 Nov 2022 20:04:29 -0800 (PST)
Received: from [10.156.157.53] (unknown [167.220.238.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 63C5B20B83C2;
        Wed, 16 Nov 2022 20:04:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C5B20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668657869;
        bh=NITiavHJuaVVgscwVFRz0twmEth6zrlX/bXMmObThsk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fRSL89hw3U3kIGJwpmtSVKNsNBoBYrOeQvp0AXx7k1vtv3ysYsK1ULZwRDOJITuNB
         0/lmDjxYDy6rA/oUk/+0ttXbisiu3/6ZvojQGloetHv8P1GAuwFGMxv3sIHP6wfzYW
         yW0woOHn7TdGmMG8wuyzRDczGn57/9j2Iu/8/53Q=
Subject: Re: [PATCH v3 0/5] Add support running nested Microsoft Hypervisor
To:     Wei Liu <wei.liu@kernel.org>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
References: <https://lore.kernel.org/linux-hyperv/cover.1667406350.git.jinankjain@linux.microsoft.com/T/#t>
 <cover.1667480257.git.jinankjain@linux.microsoft.com>
 <Y3TTt/mOe3pzDLZn@liuwe-devbox-debian-v2>
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Message-ID: <24f4cef8-3e87-4303-9fb3-0011339fdceb@linux.microsoft.com>
Date:   Thu, 17 Nov 2022 09:34:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y3TTt/mOe3pzDLZn@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 11/16/2022 5:42 PM, Wei Liu wrote:
> On Thu, Nov 03, 2022 at 01:04:02PM +0000, Jinank Jain wrote:
>> This patch series plans to add support for running nested Microsoft
>> Hypervisor. In case of nested Microsoft Hypervisor there are few
>> privileged hypercalls which need to go L0 Hypervisor instead of L1
>> Hypervisor. This patches series basically identifies such hypercalls and
>> replace them with nested hypercalls.
>>
>> Jinank Jain (5):
>>    x86/hyperv: Add support for detecting nested hypervisor
> I see `__weak hv_nested` in this patch.
>
> I guess this version has fixed ARM64 build?

It is fixed in v4 of the patch series.

Regards,

Jinank


>
>>    Drivers: hv: Setup synic registers in case of nested root partition
>>    x86/hyperv: Add an interface to do nested hypercalls
>>    Drivers: hv: Enable vmbus driver for nested root partition
>>    x86/hyperv: Change interrupt vector for nested root partition
>>
>>   arch/x86/include/asm/hyperv-tlfs.h | 17 +++++++-
>>   arch/x86/include/asm/idtentry.h    |  2 +
>>   arch/x86/include/asm/irq_vectors.h |  6 +++
>>   arch/x86/include/asm/mshyperv.h    | 68 ++++++++++++++++++++++++++++--
>>   arch/x86/kernel/cpu/mshyperv.c     | 22 ++++++++++
>>   arch/x86/kernel/idt.c              |  9 ++++
>>   drivers/hv/hv.c                    | 18 +++++---
>>   drivers/hv/hv_common.c             |  7 ++-
>>   drivers/hv/vmbus_drv.c             |  5 ++-
>>   include/asm-generic/hyperv-tlfs.h  |  1 +
>>   10 files changed, 141 insertions(+), 14 deletions(-)
>>
>> -- 
>> 2.25.1
>>
