Return-Path: <linux-arch+bounces-14421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952CC1D643
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04EE734CBCA
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBF31814C;
	Wed, 29 Oct 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ggcWHElx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rP3MKsLS"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F13161B3;
	Wed, 29 Oct 2025 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772358; cv=none; b=LAkb4MOiPfHjaO0MVor3RLmWmi+krLR4oJ7UnKJ1hBbkjTY+qGtIf9xbpKhOYmuiSxEHhmIm6QLPVQ0+1/BMffpA0Xj+TMjG85lp8e3xFWrhz6KJZ/OdcOhXvoIRw+JsjoPA3ZDbR5uRghexy+5fsKCEB05WEtnVQOOlP9v9VEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772358; c=relaxed/simple;
	bh=THcOf89JOsrj2LrJVtrEsGreOpLtH9RkJ97KPzJqwtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nutGQjHpZcG4a57Kpdo/kEdiiaHeCbV5uK+BmV7fGbev1KLV0XrgFoNxjuanPpTYEcehc8MqBq3MS/lNutp6jJgnmHy8sjX0uGy0B0At1++Jjh3j/isjZDRZ4kjR7+m0c78EwKLEDeDyriql4MO5XvI2pekby7zbsw4Ee2y23fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ggcWHElx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rP3MKsLS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761772354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMyhVuj/oZGiM/ZV18fbEBtSDd2bWkLWoAHm9lYO8rE=;
	b=ggcWHElxa5L9tPErTPC0RCCQqrjVifqlH+EXKAI+XNQQfP+qxCXznXayn3rrxnQsh+/Iwe
	twQQIURAtYiSUOg+2G2izPUbRPZunwPz8kFxiF9zXrRYPKcCp3x5Z57Ziqn0KIK/eC4PSi
	3WK5iRWHoMPrBEJyccIWhpUt9Vm3pEvhoMGjGlfJ7GbkKh6eiswRflps3zUQtt+9PTK3sj
	H4UgYFbTmlw2qf2tmgh2cF9Q2Cwk1IXzI0mL5T+/0r2/2eEfQVVksHkkJK07Tww64E6q+8
	PJVDzOfn821wE3bj7EhPVDyrt9QyicOu/RsnJJjrLdWoDBCg2Egrn2DTYuWd/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761772354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jMyhVuj/oZGiM/ZV18fbEBtSDd2bWkLWoAHm9lYO8rE=;
	b=rP3MKsLSO4GMjCsMwdwBHQPjEuQsmWZZdqBRXmqwlqLMVMz3sLOTSEgkIt5awQslI8NnUa
	CcWn7b7RHv4nAUDw==
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 03/12] rseq: Provide static branch for time slice
 extensions
In-Reply-To: <6204274d-a6b7-4e37-8e5c-deb1caa98317@infradead.org>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.606732100@linutronix.de>
 <6204274d-a6b7-4e37-8e5c-deb1caa98317@infradead.org>
Date: Wed, 29 Oct 2025 22:12:33 +0100
Message-ID: <87pla5tnsu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 10:23, Randy Dunlap wrote:
> On 10/29/25 6:22 AM, Thomas Gleixner wrote:
>> +static int __init rseq_slice_cmdline(char *str)
>> +{
>> +	bool on;
>> +
>> +	if (kstrtobool(str, &on))
>> +		return -EINVAL;
>
> The norm for __setup function returns is:
>
> 		return 0;	/* param not handled - will be added to ENV */
> or
> 		return 1;	/* param is handled (anything non-zero) */
>
>
> Anything non-zero means param is handled, so maybe -EINVAL is OK here,
> since return 0 means that the string is added to init's environment.
>
> If the parsing function recognizes the cmdline option string
> (rseq_slice_ext) but the value is invalid, it should pr_error()
> or something like that but still return 1; (IMHO).
> No need to have "rseq_slice_ext=foo" added to init's ENV.
>
> So return -EINVAL is like return 1 in this case.
> IOW it works as needed.  :)

Bah. I hate this logic so much and I never will memorize it.

