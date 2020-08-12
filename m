Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDCB24239A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHLBIF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 21:08:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgHLBIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 21:08:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D453732FD42127E7D3BA;
        Wed, 12 Aug 2020 09:08:02 +0800 (CST)
Received: from [10.174.178.86] (10.174.178.86) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 12 Aug
 2020 09:07:44 +0800
Subject: Re: [PATCH v3 0/8] huge vmalloc mappings
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
 <20200811173217.0000161e@huawei.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <d457aabc-9f58-f47e-f5fa-9539618b2759@huawei.com>
Date:   Wed, 12 Aug 2020 09:07:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200811173217.0000161e@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.86]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/8/12 0:32, Jonathan Cameron wrote:
> On Mon, 10 Aug 2020 12:27:24 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
>> Not tested on x86 or arm64, would appreciate a quick test there so I can
>> ask Andrew to put it in -mm. Other option is I can disable huge vmallocs
>> for them for the time being.
> 
> Hi Nicholas,
> 
> For arm64 testing with a Kunpeng920.
> 
> I ran a quick sanity test with this series on top of mainline (yes mid merge window
> so who knows what state is...).  Could I be missing some dependency?
> 
> Without them it boots, with them it doesn't.  Any immediate guesses?
> 

I've already reported this bug in v2, and yeah I also tested it on arm64
(not Kunpeng though), so looks like it still hasn't been fixed.

...
>>
>> Since v2:
>> - Rebased on vmalloc cleanups, split series into simpler pieces.
>> - Fixed several compile errors and warnings
>> - Keep the page array and accounting in small page units because
>>   struct vm_struct is an interface (this should fix x86 vmap stack debug
>>   assert). [Thanks Zefan]

though the changelog says it's fixed for x86.

