Return-Path: <linux-arch+bounces-5760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9493942A5F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B83F1F22AB3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66771AAE12;
	Wed, 31 Jul 2024 09:25:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7F43169;
	Wed, 31 Jul 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417916; cv=none; b=uHAagLnKjJbs8wHmB+dxVse6Xh2qhmDX+1q1C4KQ0LjNRyrtBRaE6Hsfe0T9gbUBdy0xhM6bTHlFhHKhRqW/F/pYdhbvULW2/oMt3uXQGXryOUhJDm7lKCk5y/RNLw2rmFH7+CmJgZZB2Uz2NmXoNbe/ExoDyAefE2VVnZzab+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417916; c=relaxed/simple;
	bh=cOP75LXCMDQL3U3FSzkwpQpbnups8qWQGSIaCFYZD1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tYLm1zvh0PpK8BCp4NFO3DOBwwPqTo4d6RrPSMB7gQH3uMQNHK/TwgrygPFy1j3zZry5jqTurMC1as/bd+cyhHj+MgpAM3o6hcaXadMaCUVwN6ma33cxrkQBGF2pUVl60AyFHwYr/r8lnqtifwJnTTAMqJMs2UHjiwL+GiH5gKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYmld2MBQzyPJG;
	Wed, 31 Jul 2024 17:20:13 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 93461141091;
	Wed, 31 Jul 2024 17:25:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:25:10 +0800
Message-ID: <548bfcba-4619-6a49-dc2f-40d921300ab4@huawei.com>
Date: Wed, 31 Jul 2024 17:25:10 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/31 16:24, Russell King (Oracle) wrote:
> On Wed, Jul 31, 2024 at 10:07:53AM +0800, Jinjie Ruan wrote:
>>>  #ifdef CONFIG_PREEMPTION
>>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>>> +	bl	need_irq_preemption
>>> +	cmp	r0, #0
>>> +	beq	2f
>>> +#endif
> 
> Depending on the interrupt rate, this can be regarded as a fast path,
> it would be nice if we could find a way to use static branches in
> assembly code.

You're right, it's more elegant to use dynamic keys in assembly, let me
think about how to do it.

> 

