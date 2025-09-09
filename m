Return-Path: <linux-arch+bounces-13455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9854B50208
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8BB7AA189
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF3258ED1;
	Tue,  9 Sep 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zTXq6smt"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E624397A;
	Tue,  9 Sep 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433683; cv=none; b=fpPW+chz2C/XVKcOs/sWIcoRga5gZeVtgZErMcEWFMuc+gkuhQX+IHAyWNf6xa2snWQOlt+bSsKCIxspHcNwd0tM/h174Q83gEKyoqEOkcPAKMde/PMyRwxb0j3//01fqyiyCKrs25fT7eSnzGCmsUybcYfg3UY+mHgrRdrEhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433683; c=relaxed/simple;
	bh=zSttbFfUJbT1dbYvt8ZmIXvptbSmiISm7HofeLAq/Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4WKjuEFHHez/2BkUj6tlGe9vPIru27Zr4AIyG3RL+//rEKY7kD1pIJVhXD1lytHRbzbOLWAzScrKxAge1ovXvooDLOrlURDVuIHZ4H0aJpUaGXiKMVckYmhZVvwetdQJ5Nip4wvPuKGKOpjXd2qPow9tN8WYVG6God+/+B6kBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zTXq6smt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1AmmQtJpgAtvBwqwiCJRi6SPMvAwCEB308R+UkiJ9V0=; b=zTXq6smtxdu8pNaXVD07tNonvc
	tQ7gRxoLmEJEX8aqMs0cHrDoo2ymzUZ5v2mFTtCFmdJBeHb4/AaU18avWqywM+7BNIG8M5rSMjVaq
	LYmYa3au4B02A5JjBRDDQ66O6/WafnxjPmYUZ+r4/dUJEH+UYiiT7j0RAsONgQ1nW6N9Grr5N7I20
	cCKFtUGMZuM1Dkot0/sZpm42CTZfEH2cneRar8BU6Nwt1hsGEKCLII5iV4q3ABRf14IuPxdXvm/q3
	Vb2uIxpGiuDJv8qepNFa3LgOkrFkqXY8bOxmMfYph1HywOE4HKmzc6qoR5MLwQndDPdc9DUhbIb+R
	PzExahEQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0mW-00000008NHJ-2xnM;
	Tue, 09 Sep 2025 16:01:20 +0000
Message-ID: <78605ac1-e385-4a93-b656-aca2753fa172@infradead.org>
Date: Tue, 9 Sep 2025 09:01:20 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/12] rseq: Provide static branch for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.744169647@linutronix.de>
 <0f28cc54-1f84-4f28-bd61-ee9e0b9d0d0c@amd.com>
 <94f08403-31f5-43ee-871d-5e0ebcfd3b6c@infradead.org> <87v7lrvn82.ffs@tglx>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87v7lrvn82.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/25 5:12 AM, Thomas Gleixner wrote:
> On Mon, Sep 08 2025 at 21:11, Randy Dunlap wrote:
>> On 9/8/25 8:10 PM, K Prateek Nayak wrote:
>>> Hello Thomas,
>>>
>>> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>>>> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
>>>> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
>>>> +
>>>> +static int __init rseq_slice_cmdline(char *str)
>>>> +{
>>>> +	bool on;
>>>> +
>>>> +	if (kstrtobool(str, &on))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!on)
>>>> +		static_branch_disable(&rseq_slice_extension_key);
>>>> +	return 0;
>>>
>>> I believe this should return "1" signalling that the cmdline was handled
>>> correctly to avoid an "Unknown kernel command line parameters" message.
>>
>> Good catch. I agree.
>> Thanks.
> 
> It seems I can't get that right ever ....

Yeah, it's bass-ackwards.

I guess that's partly why we have early_param() and friends.

-- 
~Randy


