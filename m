Return-Path: <linux-arch+bounces-6586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DB95E6C1
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA211F21747
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540FBA2E;
	Mon, 26 Aug 2024 02:41:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54831BA2D;
	Mon, 26 Aug 2024 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640067; cv=none; b=s2pXqKzcWXH8z3RGJUzB8WCUqIZNsPGGzKJTG+OgzJBeZjiBUp1EvIziNR9Mye5A4LyW6N32yRggm2NNSIV1Y/a1rFwoWjC0AqsmdYSb3e250FLTQMs6B8efD2YhAxNh0B5Yr0BEC0vced6mAkZIDHxvhrpM634+D7mSklVRjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640067; c=relaxed/simple;
	bh=xOxMpaJ6t6gHrg+5+DRm97H5gyn5OOMtADA2NO2iFzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b3HQ5wCjeDdYc3hR8F8vgN5RJNmsvsD4EeHq/MTAc35LCF+vWW/7E3/8s6WLBjysjGuo5YlS0zj64J/mmOXfJbBR0CJXX3BYFRdXzNiE4RRWRL4X0V1OA2XFMFRwNJ/k0c2qi3zb//stuOt5C1gPzU52LxXBmalllR8iwpErghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WsZcf6hSgzhYRc;
	Mon, 26 Aug 2024 10:38:58 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id AFE47140258;
	Mon, 26 Aug 2024 10:41:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 10:41:00 +0800
Message-ID: <8098e0e4-31c8-a700-7f8b-317b2ead8302@huawei.com>
Date: Mon, 26 Aug 2024 10:40:59 +0800
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
To: Linus Walleij <linus.walleij@linaro.org>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, <arnd@arndb.de>,
	<afd@ti.com>, <akpm@linux-foundation.org>, <eric.devolder@oracle.com>,
	<robh@kernel.org>, <vincent.whitchurch@axis.com>, <bhe@redhat.com>,
	<nico@fluxnic.net>, <ardb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>
References: <20240620090028.729373-1-ruanjinjie@huawei.com>
 <79a3de7c-21da-12ce-8372-9c9029c237ac@huawei.com>
 <Zqn0wL5iScf455O5@shell.armlinux.org.uk>
 <034499ea-2cd6-8775-ee94-771cbecd4cdb@huawei.com>
 <CACRpkdYfn6Wxo6N4hNRoMVSQXnsSVAjZXRfYzZtbRuzZyKvhkQ@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CACRpkdYfn6Wxo6N4hNRoMVSQXnsSVAjZXRfYzZtbRuzZyKvhkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/23 23:56, Linus Walleij wrote:
> On Wed, Jul 31, 2024 at 12:03 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> By the way, currently, most architectures have simplified assembly code
>> and implemented its most functions in C functions. Does arm32 have this
>> plan?
> 
> I would turn it around, since I saw that Huawei contributed generic entry
> code for Aarch64, do you folks have a plan to also do patches for ARM32?

Hi, Linus，there are no plans to switch ARM32 to generic entry as it is
already in maintenance mode as Russell said, but we will try to do it if
Russell thinks it makes sense and necessary.

> 
> I have many ARM32 systems and I am happy to help out with reviewing
> and testing if you do.
> 
> Alternatively I might be able to have a look at it, because the entry code
> is right in my work area all the time.

Thank you very much, I'd love your help reviewing and testing the code.

> 
> Yours,
> Linus Walleij

