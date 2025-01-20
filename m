Return-Path: <linux-arch+bounces-9820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E9EA16D76
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D402168662
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127011E1A08;
	Mon, 20 Jan 2025 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucadM5bO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9o4F5V4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20C1E0DD1;
	Mon, 20 Jan 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380180; cv=none; b=jPBeph+i1edjirf/uPGb4ES5RGSglnYTotXBX7AtEXk9T+Ba91L+eGVm2E68ZAmmFc4/jiqI6mDjQREdSv5Z3TugrVi5DBGcS2kzV/H9rPRmXY7VY9jkRra3E8XX/EURpPjznM7gf6esYz8MGlotWs7Y24PDUz96c6NoyHnOd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380180; c=relaxed/simple;
	bh=TlgvnGy9kE8yjMdW/P7SlSp4i3l7W11/n25nmMtu0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+lBrjJVES85+KcnH4xrenyQXMJpAdXYIWLq9Md9wlox56/dvbSzHGeATQsgT9lFYvTAuq5+P3dsZuQTXlyTDimjjbOnAz4qmdc2UC6zU0ykSxVPjf19tq0lpTES97lCf0+KNjDZwv456k0W0KitaHJfBe8R6OfVVQySRlcJLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucadM5bO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9o4F5V4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 Jan 2025 14:36:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737380174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Y1ype3ppnk0OeLhlW6Fo6oGTzJOolSI9eUh0ZWOLg=;
	b=ucadM5bOVbfdvZCnRWtmy+aDeTh37dAelp+eIEo03lbXyp9t8rzHFm4M+J2pnUVkwxX7xn
	z5LSbxYY6Iv/XEIRYfq4UV+oJ8u5XKGPmKophcyFqcNT6ZG/CTpzJB+x2iHN54IR7whTh/
	wj/oAIs8dt5dEXV8E9LRyPUORpBS88Kk3YJX7kQoNkDZVWaabl7N230Qqi9lRNUyCuslVH
	OSmWEzwWqfHcPzS4Y7C5VaKpzCq6EKLqfb/AM5N4WyVAu055qu2Muz4lixXOLqVfjUMpdA
	BdehfMeW3YloV5jWITXEmlMi3sOJwjKyhEgjVl98KoFEgIsI54WXHOtieK0BNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737380174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0Y1ype3ppnk0OeLhlW6Fo6oGTzJOolSI9eUh0ZWOLg=;
	b=O9o4F5V46TdLOi2N39ZpjQB39vyvKSyb0ubc96CpLkE6yHaZDWDffzOiUqFO1NZpxJo2vn
	rnLIlrIrptM6C7Cw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org, 
	x86@kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 2/3] um: avoid copying FP state from init_task
Message-ID: <20250120142855-9d570200-cef7-4cfb-9ee5-81c8005a99d8@linutronix.de>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-3-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217202745.1402932-3-benjamin@sipsolutions.net>

On Tue, Dec 17, 2024 at 09:27:44PM +0100, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The init_task instance of struct task_struct is statically allocated and
> does not contain the dynamic area for the userspace FP registers. As
> such, limit the copy to the valid area of init_task and fill the rest
> with zero.
> 
> Note that the FP state is only needed for userspace, and as such it is
> entirely reasonable for init_task to not contain it.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Closes: https://lore.kernel.org/Z1ySXmjZm-xOqk90@google.com
> Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")

No stable backport? The broken commit is now in the 6.13 release.

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Tested-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  arch/um/kernel/process.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index 30bdc0a87dc8..3a67ba8aa62d 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -191,7 +191,15 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
>  int arch_dup_task_struct(struct task_struct *dst,
>  			 struct task_struct *src)
>  {
> -	memcpy(dst, src, arch_task_struct_size);
> +	/* init_task is not dynamically sized (missing FPU state) */
> +	if (unlikely(src == &init_task)) {
> +		memcpy(dst, src, sizeof(init_task));
> +		memset((void *)dst + sizeof(init_task), 0,
> +		       arch_task_struct_size - sizeof(init_task));
> +	} else {
> +		memcpy(dst, src, arch_task_struct_size);
> +	}

Nitpick:
This could make use of memcpy_and_pad() in various forms.

> +
>  	return 0;
>  }
>  
> -- 
> 2.47.1
> 

