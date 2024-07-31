Return-Path: <linux-arch+bounces-5764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A923942B8B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB81C20DE8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B601AB500;
	Wed, 31 Jul 2024 10:03:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1371AB537;
	Wed, 31 Jul 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420198; cv=none; b=axJ6q7kffMq4Dn0h3whzinLt7gD8NMWPQuP9HR9+iSEIQiqd6ba3DCaUIE+DBjRU+dzKibSabSb/6qh+06GCkCfHSO9tbtcD06PUeGs8dsqVQVgyI2f9ISuLve6cTFNwv2StPIr+VjCUFSvwKWP73ZFWE7Uc7asUArUr40a+Ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420198; c=relaxed/simple;
	bh=DukT5UE7XKYXtC2eML+NcnbLOHXSPE0vVMkE58Iu10Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GPOtHgMRixKjJ/w+EGqaFXCH4QyU2h0+e6QeiRqRFuMKLnzcbqKzhcVdxadyiSogF/+0IRcgu5fdnWnAI/VFM+c1fvUUxTFbJ9gQWGI2/PQSbyNGP63ZCRW5tHgbgPLsFYcc1ndGoRq4FtpMqHjeMZ0eHSfRWis9ohjBCHIcJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYnbW00MbzyPGX;
	Wed, 31 Jul 2024 17:58:14 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4878B180101;
	Wed, 31 Jul 2024 18:03:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 18:03:12 +0800
Message-ID: <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
Date: Wed, 31 Jul 2024 18:03:11 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
It seems to be hard to use static keys in assembly code.

By the way, currently, most architectures have simplified assembly code
and implemented its most functions in C functions. Does arm32 have this
plan?

> 

