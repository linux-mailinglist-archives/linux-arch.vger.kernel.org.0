Return-Path: <linux-arch+bounces-13444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 270AEB4A081
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 06:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C271B254E3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 04:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2A2C1587;
	Tue,  9 Sep 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K49EFCyf"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663654654;
	Tue,  9 Sep 2025 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391082; cv=none; b=sGhdTaCrDUjbBNFvZTinYumrFWnwTPZsJKbn8PgE6dGO7efKw5JCq3HBLDiavX0DnDiNdTLKDCMgiAAWTyTr2WZ6LhgziaxDs0n5WKjL+mBpkPynM/N5tS7134TWTLsziRUU17U92jrxVfLLVbeEM1ryBPZiRIT5dQyywgmzZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391082; c=relaxed/simple;
	bh=o80n4ExUoBAJUnTE9XsmrZlYvocq1FJTlQI4X2crCJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N06MrD8K0DG7T2FVxAUrNLvbWhyT9veKFmCQ/Sncte9X8sEif0XXeA+q9o3k3DBjtFeMxeT1T7EIYgtwDy0nQ2ZbBceaqWc+D8YvvP+rHLdbr6uuHcQaweFGd7OZ9m3GcpF4FFHDYjuAxdlywZZpqr15EpK6amCaBU1k9i9PGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K49EFCyf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=H+Mt0obVe+OHMg9mtzsKgB8kbdimq6iDYKrqcoNyusY=; b=K49EFCyfJCBdULh6YgKLpruaW1
	nxEQBusnHzafOmNDLfmKbUUs4c/GEAxqA44xLHdxfZ6eRp0PjSplqlQdYgfO22DNza++WZ726bKt5
	Qy03D7XgBLDX1AoXtVha0T3f8jlZ4vl75tBRZzjM7ebrwxx1fACZwjEuutDBPuBeHYqESFFQbk7NM
	5MI52+YgIwPBHN+oO/45Dr/+1mGSHyvQK9HUhml69clnXhog4/3r9L5nAxUE7IWOwXCcuFcJImaz5
	rqF6Jq/hVRvExIpQa6fVqsryZd+pvoTdMiEnhToqiJZ3oUni7D89n7kAKByh70iIrAklYdpT2lSy5
	pTqujRHw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvphN-0000000487l-0Nke;
	Tue, 09 Sep 2025 04:11:17 +0000
Message-ID: <94f08403-31f5-43ee-871d-5e0ebcfd3b6c@infradead.org>
Date: Mon, 8 Sep 2025 21:11:16 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/12] rseq: Provide static branch for time slice
 extensions
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0f28cc54-1f84-4f28-bd61-ee9e0b9d0d0c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/25 8:10 PM, K Prateek Nayak wrote:
> Hello Thomas,
> 
> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
>> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
>> +
>> +static int __init rseq_slice_cmdline(char *str)
>> +{
>> +	bool on;
>> +
>> +	if (kstrtobool(str, &on))
>> +		return -EINVAL;
>> +
>> +	if (!on)
>> +		static_branch_disable(&rseq_slice_extension_key);
>> +	return 0;
> 
> I believe this should return "1" signalling that the cmdline was handled
> correctly to avoid an "Unknown kernel command line parameters" message.

Good catch. I agree.
Thanks.

>> +}
>> +__setup("rseq_slice_ext=", rseq_slice_cmdline);
>> +#endif /* CONFIG_RSEQ_SLICE_EXTENSION */
>>
> 

-- 
~Randy


