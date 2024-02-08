Return-Path: <linux-arch+bounces-2119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD084DCFA
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 10:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAD51C21E7B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E46BFA9;
	Thu,  8 Feb 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Y12m14dD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v5eGdUQ3"
X-Original-To: linux-arch@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC26BB42;
	Thu,  8 Feb 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384691; cv=none; b=ncJBrqXxD74bNiYmSp6TPHT4AH10Jd5rLzQMjGxpOOPUdFyKMSSsqnqB5jH8re4Va+DNee5iSw7J3NZnpDV0sgbyB/ReOkVqwu+Oiar38bBcwFHPHAiQPL442LT29E9PVY9RV2dguvE3wxyN2lOjkh7vtS4RiAMtera3cWQ7UQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384691; c=relaxed/simple;
	bh=IlQBt5ebpX3rwAe1JJmrdRp8ZYh3Sd+NBJTigxQ+X0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbZPOerdAxMClA7BXTjmqArS1mVCvlMSCXuYbW8si0mRKxCPiQ/zvJ2tWVcpJcGdCX6W+wShV2YGfSxZry7Tvy9xrOtqs2RhfGfbWmNowhNDIbIhwfgjufE661tHlsxYvcoDbbibBn/0qH7cJs57bt+87abGObwqQcZVEEgHVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Y12m14dD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v5eGdUQ3; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 0683D5C006A;
	Thu,  8 Feb 2024 04:31:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Feb 2024 04:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707384688;
	 x=1707471088; bh=kuEW1rpMwiKWoxW/OF1OAVriE1FGgfZTm7jP2rc40xY=; b=
	Y12m14dDvFHfLMvP1O/DQi12gUuaXtTtTjZF4YNHWHUeJ9iFFW5z70JytBnlvKiY
	xczZVlGb4zkSYOcVSlBDzLMEzA/CYejnKBIRmusZr2qvqDvknMPLtcu8Y1bTWjaa
	EbM7sdpULu7graK6STBa8MbYhuAkiC06BO90KhZYmjrHcb8/DTlX9sj82x9K/bkF
	tUwL7z5TryIeZnd9D/wxks6BNzJbT8eOSATeSP5H+kOEWGZwz3n1rYNkMvclGf8F
	Wl3QudHXbdWeWuxhZTU2vxTYFJRPn2boZSO+Bw/cLGk9e9nONmu3d2Yfl/iwmw1W
	jxiGK+LPQUUTW0AicvKYqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707384688; x=
	1707471088; bh=kuEW1rpMwiKWoxW/OF1OAVriE1FGgfZTm7jP2rc40xY=; b=v
	5eGdUQ3SuJni2CDQQwGCnY1FKoBHDE2CwIpxJJdszS9U4/QsUatR/ZP+uvPficTn
	jPorgjXX6DCWSiaHDpWirVA49k27Rqkjwtzo2nJzN70+RUhLcjlnjGKD2FdwZMT9
	SC74FY7ufZgZ6BsgT8nKRVrNtu1nlk7PqZhwQzBugvnGQ1K1sEYASfkWhcUs0/+k
	YChxskxHrFZ4nacTXeNI4UeKT8Oua8a2fuHodRNmJoXRYvYKmGHni45LU84cweId
	LTE4dVU8fnM8YnMl3qwDAhj56csh6GPasf6+aeEk/W1HHBynptTfvrSiQGJqJHFY
	Lkr7Pog1uNlQXO80+PK1g==
X-ME-Sender: <xms:b5_EZTDZEZlteRCk8oHFU2EAHxVfvIfSL_xa3URH20daLiJZW6nH8g>
    <xme:b5_EZZi18FVY508JkUUQb-KFbRXC0pZfgN1MEc2ltvv_wL8pZ-SgEgHrZh5dsh5nL
    DxkwIfikRhPqPbGlPc>
X-ME-Received: <xmr:b5_EZek5JApq5xTrqHdIeWMPSyiavXFa8aEKh28fWSxwPfFlLHAek2d8kJub5wyIYcXndsLovnDIgQT8xcz_W5Gkqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeelueffheehgeeluedvlefghfeukeejteeuveeuhffftdfguefh
    gefgueekffeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:b5_EZVxqI5OxaC4dkeendZ17SLEkT7BidT65ig34mtLFspWIQiDJbA>
    <xmx:b5_EZYS1togzAX8jtB0ptlbcdFkm8qjSe6tfJ5Ib6JsuzSPcGOhMbA>
    <xmx:b5_EZYZ9dqtJfHI6KwCtpGnb-gDM15ULwJZ-yCb8Cq4l4R1wL6qKFw>
    <xmx:cJ_EZR_al3FMdHvPEtGvJUggOeFxU0qIqG-MHf-khclEAN-Cw1Ko7g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 04:31:26 -0500 (EST)
Message-ID: <1e9e4b8c-4e80-4126-9204-fa66049c084e@flygoat.com>
Date: Thu, 8 Feb 2024 09:31:25 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>, Oleg Nesterov <oleg@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <63a1738c-5755-4c2e-a4d4-f5047cdb3660@flygoat.com>
 <7636b9072f2b72f6079a65d456c561716c5d90a3.camel@xry111.site>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <7636b9072f2b72f6079a65d456c561716c5d90a3.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/8 09:23, Xi Ruoyao 写道:
> On Thu, 2024-02-08 at 09:20 +0000, Jiaxun Yang wrote:
>>
>> 在 2024/2/2 12:30, Jiaxun Yang 写道:
>>> Hi all,
>>>
>>> This series fixed extable handling for architecture delay slot (MIPS).
>>>
>>> Please see previous discussions at [1].
>>>
>>> There are some other places in kernel not handling delay slots properly,
>>> such as uprobe and kgdb, I'll sort them later.
>> A gentle ping :-)
>>
>> This series fixes a regression, perhaps it should go through fixes tree.
> If you have Fixes: {sha} and Cc: stable@vger.kernel.org Greg will pick
> it up once it's in Linus tree.

In this case I'd like to backport it manually, as there is only one 
patch in this series
actually fixing the problem.

Thanks
- Jiaxun
>

-- 
---
Jiaxun Yang


