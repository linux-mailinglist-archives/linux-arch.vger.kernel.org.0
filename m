Return-Path: <linux-arch+bounces-12417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E4AE1EE8
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B736A50A8
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6E8F5B;
	Fri, 20 Jun 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R6X5fgou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJNMfWAG"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A82C0313
	for <linux-arch@vger.kernel.org>; Fri, 20 Jun 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433678; cv=none; b=D6mPyyKERioGduB3uBXDSHEcmYUO/Ud2NSEEqXUt12l/qETYYHLUvehsbFA2lLTMBMwiwOdiRPek2kd/KThFYfQ05WS1nJ+IDThcmns2PUp3GpYHOwwzlCd/zOjBfgHfguC3qMHxeHkxZIgmGSYDyQc/V7lw5CJ9nD/aJhTo6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433678; c=relaxed/simple;
	bh=jrPzLCECzHzj1WtciASTK7VNYPCQuih237z80jsEcXQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FGx1AtPTVus5+NENrBlJlXCUpS9JkCgAWP6vmnswHyd5YQfLtIye3t7VwVxn/32UlcQGY0pdc68V7dAFBf2r9LwDTB8vF/YxB6tBRPNQTendlOFWhP0CVjLHd3CsUASD8lNLwpo0DbpX64VOj26sEgatwRkclz5e8q9QhL/Y4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R6X5fgou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJNMfWAG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 386232540276;
	Fri, 20 Jun 2025 11:34:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Fri, 20 Jun 2025 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750433671;
	 x=1750520071; bh=F3HFxAKJVWrN5DaDhfcB8BCz5W0xV2aHq+tqLMfXuEg=; b=
	R6X5fgouTSPzszwIuxM6BvG2gMCY4eaGCJdSiht4I23URwDC8eM4/32dNRcwlCCs
	mMhNcyjxMx/QyWcxIIYdZpCeIzpWH31TOqKYf4ZRsXcmHWStteLlAJeI03L6V7ee
	Sk5qxwT//S9HOuYgUgeNerPDVPlM3/6Sv2KAscRLEVDrjpYQp7aZR5FUebwjasgy
	lkpYnYceqZEZw1eQHOpqDucLR35jiD/g0jImUQENcWxqzUjKuxrr217UjLm4WON0
	ANgE2/P4DIZ2tsHebKwoaONYe/H+Y6WlfL90R9SVqhH/uJnsHccLMRggFwzg9ksr
	ROGJs+sALsbbn/CMvpkgyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750433671; x=
	1750520071; bh=F3HFxAKJVWrN5DaDhfcB8BCz5W0xV2aHq+tqLMfXuEg=; b=H
	JNMfWAG0abj+xfgvY5JZQLRvy32Ks+JTw3iUIAnEIicSWz+2sYpODwd4aRw6uWve
	ueWvzYiYeDTFzU0ulyMmzY04CGZ81AKWtxPWo1841cfTqd7MUwIO9HJaRMHd8qsC
	hTK+cTSt16qQyc4ptIUDRlHPk78cHp62TB7ELg9RuUFUsgshlM4vfyaPBOij5aD4
	YsLNzYvT9KXD+/vaxFW+a9AjHyiZEm295yE/imrz5REK+EArxeeIOvf+/yzYib8o
	hwjHZr4Uy7lS0zOYMDZzrC7zNxw9troQHfNZenKrR1rCwTrCEyKOayCil167xUiK
	Q8tubU21lePw/BRtxs40A==
X-ME-Sender: <xms:hn9VaOTALfMia7nwOd3lQpS0mlv1QGzuUtf9jKug8Y5fuC6VZQX1pw>
    <xme:hn9VaEjIbZYLl0TA5ZwOP6mwaVPHzuS7q7sPQk0Nj4ss24-92pEZrXujsreNdJfds
    YBJbqlIJDUAKzhGQZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:hn9VaH8VP1BRZsmqyHoihIWWD3-OY5eh-1QO4E98bmYXgxUoU0wLMw>
    <xmx:hn9VaLG3SNnvVMOVmTCsLeluajAGYflZdlTHDP89EvOeh8cwJMwwyg>
    <xmx:hn9VaKlA-aw1BRNg_A9bgjaLtxdK_0D9yd7gj8Uj4rq57_hPAoeeHw>
    <xmx:hn9VaPY5SKs_yajKQenOSrhgw42_US23maAkXwC94BkVEKMykCVGzQ>
    <xmx:h39VaLFmE86WUeHC2mb_7VGLWzt0dZSD8rxDAxfdZlkRFbEzfTs29Usa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B721700063; Fri, 20 Jun 2025 11:34:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5175ccf11ae6abd1
Date: Fri, 20 Jun 2025 17:33:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <d2f2d26c-f856-454b-8afa-5373a062a327@app.fastmail.com>
In-Reply-To: <20241202040316.GB933328@ZenIV>
References: <20241202040207.GM3387508@ZenIV> <20241202040316.GB933328@ZenIV>
Subject: Re: [PATCH 2/3] alpha: regularize the situation with asm/param.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 2, 2024, at 05:03, Al Viro wrote:
> The only reason why alpha can't do what sparc et.al. are doing
> is that include/asm-generic/param.h relies upon the value of HZ
> set for userland header in uapi/asm/param.h being 100.
>
> We need that value to define USER_HZ and we need that definition
> to outlive the redefinition of HZ kernel-side.  And alpha needs
> it to be 1024, not 100 like everybody else.
>
> So let's add __USER_HZ to uapi/asm-generic/param.h, defaulting to
> 100 and used to define HZ.  That way include/asm-generic/param.h
> can use that thing instead of open-coding it - it won't be affected
> by undefining and redefining HZ.
>
> That done, alpha asm/param.h can be removed and uapi/asm/param.h
> switched to defining __USER_HZ and EXEC_PAGESIZE and then including
> <asm-generic/param.h> - asm/param.h will resolve to uapi/asm/param.h,
> which pulls <asm-generic/param.h>, which will do the right thing
> both in the kernel and userland contexts.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks correct to me, though after looking at it for a bit
I think I came up with a way to simplify it further:

> index 49c7119934e2..e4e410f9bf85 100644
> --- a/arch/alpha/include/uapi/asm/param.h
> +++ b/arch/alpha/include/uapi/asm/param.h
> @@ -2,14 +2,9 @@
>  #ifndef _UAPI_ASM_ALPHA_PARAM_H
>  #define _UAPI_ASM_ALPHA_PARAM_H
> 
> -#define HZ		1024
> -
> +#define __USER_HZ	1024
>  #define EXEC_PAGESIZE	8192
> 
> -#ifndef NOGROUP
> -#define NOGROUP		(-1)
> -#endif
> -
> -#define MAXHOSTNAMELEN	64	/* max length of hostname */
> +#include <asm-generic/param.h>

If you make this one

#ifdef __KERNEL__
#define USER_HZ	1024
#endif

and rely on 'make headers_install' to drop the USER_HZ
macro again, you can avoid the additional __USER_HZ macro
and just guard against redefining it in asm-generic/param.h.

With or without that change,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

