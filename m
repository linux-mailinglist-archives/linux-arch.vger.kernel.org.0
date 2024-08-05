Return-Path: <linux-arch+bounces-5955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE194733F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 04:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437E7281149
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ADB1CAB1;
	Mon,  5 Aug 2024 02:00:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E63FB3B;
	Mon,  5 Aug 2024 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722823210; cv=none; b=j8a2/Agf3cypVOpAoeCnStF3m4kholbA2Wd+v0chPLMrGJeuQXeYvpYZrQcR3elAoJIEKaSFYeMcxAUV5McPSJuqvoOgTKAyfGQfhU6t8NMlu7FPBEsbF1lFu8hhDoySUcMDuHP8PKi2Pnow/ECdgIqYdhzsWFKGFCPC1bEqWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722823210; c=relaxed/simple;
	bh=M3bZcxNiNQCHYqz1OHviPnFK1tXOj0PicXpRsQjfmzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MLQnmv7uxMtE8e6mZmTmH+e0XAhHCYaV3gGZ2iPMmjDJ/9jdLPQTjQbdnG81l8qp6QG89i8DsK4wCBPCw3t8+GT9Jq7TxbEVDeDXtEySPBsXE2lXWrMOU1Fu/M7Mdz8cL0GWSGj/SGHmnQ+N2e7Z0GBV34yokJUb9TXGT1d8yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wcff33DS2z2Clll;
	Mon,  5 Aug 2024 09:55:23 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E9971400D7;
	Mon,  5 Aug 2024 10:00:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 10:00:02 +0800
Message-ID: <dbb9955b-b12f-6b4b-d380-1f95d3d9fed6@huawei.com>
Date: Mon, 5 Aug 2024 10:00:01 +0800
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
 <ZqzGp14u/XTST8v1@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqzGp14u/XTST8v1@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/2 19:44, Russell King (Oracle) wrote:
> On Wed, Jul 31, 2024 at 10:07:53AM +0800, Jinjie Ruan wrote:
>> On 2024/6/20 17:00, Jinjie Ruan wrote:
>>> Enable support for PREEMPT_DYNAMIC on arm32, allowing the preemption model
>>> to be chosen at boot time.
>>>
>>> Similar to arm64, arm32 does not yet use the generic entry code, we must
>>> define our own `sk_dynamic_irqentry_exit_cond_resched`, which will be
>>> enabled/disabled by the common code in kernel/sched/core.c.
>>>
>>> And arm32 use generic preempt.h, so declare
>>> `sk_dynamic_irqentry_exit_cond_resched` if the arch do not use generic
>>> entry. Other architectures which use generic preempt.h but not use generic
>>> entry can benefit from it.
>>>
>>> Test ok with the below cmdline parameters on Qemu versatilepb board:
>>> 	`preempt=none`
>>> 	`preempt=voluntary`
>>> 	`preempt=full`
>>>
>>> Update preempt mode with debugfs interface on above Qemu board is also
>>> tested ok:
>>> 	# cd /sys/kernel/debug/sched
>>> 	# echo none > preempt
>>> 	# echo voluntary > preempt
>>> 	# echo full > preempt
> 
> Do you have a use case for this feature?

Yes, many of our ARM32 products use different preemption models, and it
would be much more convenient if we could configure it at startup.

> 

