Return-Path: <linux-arch+bounces-5795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB5944104
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 04:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA5B2850C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8861A255A;
	Thu,  1 Aug 2024 01:27:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9C1A2562;
	Thu,  1 Aug 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475624; cv=none; b=bWh4c1PdvIV1O9KFqlmzsBhpVbVE+e/Bz2sLuPY/y6CvBhp7BiXksqT6QdSES0JlRo8T1lfNUz2OpwNKnIU6LQajchnxR8Sb1pBcnyDYLJR0hqkn9wIaGyTcmlc0oPy8lXW4Sst0k2uE4j/URAK8XM/81AlAujTLjqB46tabuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475624; c=relaxed/simple;
	bh=NyUJU5qt9KOZ5V2FlZXxo9KiqYr69JBvG75ao6KughU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jz7Ib3XCggv5WLCqqTdVn2jiiOHi1iXuaqxWXCr/44I3kNRZWipJCN1pWRVoWf2QLBsIcFoHOlG3DG52iswSjoJuLwBrGBpWDKffEfcS4AyKqweF+gdaS2zrH7wy6Ffud6jguaNRwVTG72uXwvM7xare17FzmlRFiuOjSJxxUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZBBv2kjRz1L927;
	Thu,  1 Aug 2024 09:26:47 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 799C718009B;
	Thu,  1 Aug 2024 09:26:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 09:26:58 +0800
Message-ID: <3855e3a4-769b-5162-0747-cf72b94f7089@huawei.com>
Date: Thu, 1 Aug 2024 09:26:58 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ARM: support PREEMPT_DYNAMIC
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <robh@kernel.org>,
	<vincent.whitchurch@axis.com>, <bhe@redhat.com>, <nico@fluxnic.net>,
	<ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
 <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
 <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
 <ZqoOoUPDIeJX5M0e@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqoOoUPDIeJX5M0e@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/31 18:14, Russell King (Oracle) wrote:
> On Wed, Jul 31, 2024 at 06:03:11PM +0800, Jinjie Ruan wrote:
>> On 2024/7/31 16:24, Russell King (Oracle) wrote:
>>> On Wed, Jul 31, 2024 at 10:07:53AM +0800, Jinjie Ruan wrote:
>>>>>  #ifdef CONFIG_PREEMPTION
>>>>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>>>>> +	bl	need_irq_preemption
>>>>> +	cmp	r0, #0
>>>>> +	beq	2f
>>>>> +#endif
>>>
>>> Depending on the interrupt rate, this can be regarded as a fast path,
>>> it would be nice if we could find a way to use static branches in
>>> assembly code.
>> It seems to be hard to use static keys in assembly code.
>>
>> By the way, currently, most architectures have simplified assembly code
>> and implemented its most functions in C functions. Does arm32 have this
>> plan?
> 
> arm32 is effectively in maintenance mode; very little active development
> is occuring. So, there are no plans to change the code without good
> reason (as code changes without reason will needlessly affect its
> stability.)

Thank you for helping me with my question.

> 

