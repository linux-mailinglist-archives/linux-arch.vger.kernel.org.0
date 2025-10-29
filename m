Return-Path: <linux-arch+bounces-14414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB58C1C6D2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D44074E10C7
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C032F6179;
	Wed, 29 Oct 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F6GhY1KP"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FF34C149;
	Wed, 29 Oct 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758608; cv=none; b=TNCQZWq4mGQ3nctt/wCRJH6B66sI58u7b71+7lJsW8etXjAl4/qR/ozyUOBUPC20TwFTG5zVvGfKOAuDLh/NolKfmGz5LPuLll5LVHyXPRjATZX8dNZ3zq4TF7uyoDRYs0ZOlKoVf+tQCWcPpyLlIPsPav8qC5zbNLz5djmRmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758608; c=relaxed/simple;
	bh=TLZS5iTR0nmWjmQ1xgbEvSHLn1neH58TN+5Cy5M470c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTL8rzVWf1vvObmN52Ns0SYLlrE7hqY4Jq5sgIg7cvgXO6DGqVG0Sazl8LqJYzqJ/0iaE/ldaqGAaPPGXeuZzXEe1gs2kpq6xeM5tG1XVF2RxK78WnDWiLK8sh3JQKgPrjwRkdypfzanlhRZvAg4dTg6OBbw+WR5ez/o/coas7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F6GhY1KP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2jlL734Abw0X8N3EaXZAPcb2LloMs29df+lu4QReEx4=; b=F6GhY1KPNHCHCD1glPD35shlTU
	UV6Hy+Jvz0StieysZLFc/PEgydhnKwF1wqtmYDLql+HmILnyWGseg2Emkq7+qw7a0eDWa1FH96kcm
	4GYve75ENlEJ7+Po2x0VVD68U6jKUBARDa2PH7/TkMsdM4WSKJXgcyb0rL4aWhQ7Tu5K7Umc3Kv3W
	RlWmB3yyxFgFMqlcOBTg8eyTTiz5Ip0SikLN8Urbv88Gyojmz4BA48L5K130sofajbkUyOfGPcC27
	uLhOByLHGzv/9uKVkH6/8HO4aeZRXWerlv9EvncD8OwFUii6enNBqx4YhnnK3DqMRK5SWQGTcpRga
	vFLB3DsQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE9tK-00000002Bea-28rC;
	Wed, 29 Oct 2025 17:23:22 +0000
Message-ID: <6204274d-a6b7-4e37-8e5c-deb1caa98317@infradead.org>
Date: Wed, 29 Oct 2025 10:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 03/12] rseq: Provide static branch for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.606732100@linutronix.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251029130403.606732100@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/25 6:22 AM, Thomas Gleixner wrote:
> Guard the time slice extension functionality with a static key, which can
> be disabled on the kernel command line.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
> V3: Document command line parameter - Sebastian
> V2: Return 1 from __setup() - Prateek
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    5 +++++
>  include/linux/rseq_entry.h                      |   11 +++++++++++
>  kernel/rseq.c                                   |   17 +++++++++++++++++
>  3 files changed, 33 insertions(+)
> 



> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -484,3 +484,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>  efault:
>  	return -EFAULT;
>  }
> +
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
> +
> +static int __init rseq_slice_cmdline(char *str)
> +{
> +	bool on;
> +
> +	if (kstrtobool(str, &on))
> +		return -EINVAL;

The norm for __setup function returns is:

		return 0;	/* param not handled - will be added to ENV */
or
		return 1;	/* param is handled (anything non-zero) */


Anything non-zero means param is handled, so maybe -EINVAL is OK here,
since return 0 means that the string is added to init's environment.

If the parsing function recognizes the cmdline option string
(rseq_slice_ext) but the value is invalid, it should pr_error()
or something like that but still return 1; (IMHO).
No need to have "rseq_slice_ext=foo" added to init's ENV.

So return -EINVAL is like return 1 in this case.
IOW it works as needed.  :)

> +
> +	if (!on)
> +		static_branch_disable(&rseq_slice_extension_key);
> +	return 1;
> +}
> +__setup("rseq_slice_ext=", rseq_slice_cmdline);
> +#endif /* CONFIG_RSEQ_SLICE_EXTENSION */

-- 
~Randy


