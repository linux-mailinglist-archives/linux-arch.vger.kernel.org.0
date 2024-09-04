Return-Path: <linux-arch+bounces-7029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F096C51D
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F30B22120
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B661674;
	Wed,  4 Sep 2024 17:17:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C35473E;
	Wed,  4 Sep 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470254; cv=none; b=T3+XvUR6hb7V8EcRlmZ9wlUUSAg+TzKSzK+omS8+8mecKczM9IcwhSk+xDGSvYEJ0jJKPz0AgUrgr7dwVniVoOSXRsYNthphqqGD8iDRXP4Xve/lvMWzHx0DZB3uzs56P9UEtLQ+mBhtEaiPuRJOVHyErofFP5hDI3MmQEKNnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470254; c=relaxed/simple;
	bh=X4/4PpYe9Wm0Hy9XexLX1Fk65/zF/vpp8G89yVAXhz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJEXVqw9Jv96/QTPTcwykB91RcaV4Ic/rxqVdEGTH7j1Kpe0FTQbjsoOtewAfzA77nwVa6k4p9e3s1f/ZIa4rhsewAWtlVDa26sOd1BFa1t9Y4uHEI8LfkBDoJZ74xi5IHdX3C9q0ekE8rRMFLYdL61Eukb9ubgIsqJ+IElUzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzThB6wRTz9sST;
	Wed,  4 Sep 2024 19:17:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23q8UjPNxB-l; Wed,  4 Sep 2024 19:17:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzThB5g1Yz9sSS;
	Wed,  4 Sep 2024 19:17:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AC51E8B77A;
	Wed,  4 Sep 2024 19:17:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id paQV1BysDOD5; Wed,  4 Sep 2024 19:17:30 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C71548B778;
	Wed,  4 Sep 2024 19:17:29 +0200 (CEST)
Message-ID: <b78eab34-61f5-4c9e-b080-d2524cd30eb8@csgroup.eu>
Date: Wed, 4 Sep 2024 19:17:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vdso: Split linux/minmax.h
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-6-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-6-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Split linux/minmax.h to make sure that the generic library
> uses only the allowed namespace.

It is probably easier to just don't use min_t() in VDSO. Can be open 
coded without impeeding readability.

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   include/linux/minmax.h | 28 +---------------------------
>   include/vdso/minmax.h  | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+), 27 deletions(-)
>   create mode 100644 include/vdso/minmax.h
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 98008dd92153..846e3fa65c96 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -6,6 +6,7 @@
>   #include <linux/compiler.h>
>   #include <linux/const.h>
>   #include <linux/types.h>
> +#include <vdso/minmax.h>
>   
>   /*
>    * min()/max()/clamp() macros must accomplish three things:
> @@ -84,17 +85,6 @@
>   #define __types_ok3(x,y,z,ux,uy,uz) \
>   	(__sign_use(x,ux) & __sign_use(y,uy) & __sign_use(z,uz))
>   
> -#define __cmp_op_min <
> -#define __cmp_op_max >
> -
> -#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
> -
> -#define __cmp_once_unique(op, type, x, y, ux, uy) \
> -	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
> -
> -#define __cmp_once(op, type, x, y) \
> -	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
> -
>   #define __careful_cmp_once(op, x, y, ux, uy) ({		\
>   	__auto_type ux = (x); __auto_type uy = (y);	\
>   	BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),	\
> @@ -204,22 +194,6 @@
>    * Or not use min/max/clamp at all, of course.
>    */
>   
> -/**
> - * min_t - return minimum of two values, using the specified type
> - * @type: data type to use
> - * @x: first value
> - * @y: second value
> - */
> -#define min_t(type, x, y) __cmp_once(min, type, x, y)
> -
> -/**
> - * max_t - return maximum of two values, using the specified type
> - * @type: data type to use
> - * @x: first value
> - * @y: second value
> - */
> -#define max_t(type, x, y) __cmp_once(max, type, x, y)
> -
>   /*
>    * Do not check the array parameter using __must_be_array().
>    * In the following legit use-case where the "array" passed is a simple pointer,
> diff --git a/include/vdso/minmax.h b/include/vdso/minmax.h
> new file mode 100644
> index 000000000000..26724f34c513
> --- /dev/null
> +++ b/include/vdso/minmax.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_MINMAX_H
> +#define __VDSO_MINMAX_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/compiler.h>
> +
> +#define __cmp_op_min <
> +#define __cmp_op_max >
> +
> +#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
> +
> +#define __cmp_once_unique(op, type, x, y, ux, uy) \
> +	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
> +
> +#define __cmp_once(op, type, x, y) \
> +	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
> +
> +/**
> + * min_t - return minimum of two values, using the specified type
> + * @type: data type to use
> + * @x: first value
> + * @y: second value
> + */
> +#define min_t(type, x, y) __cmp_once(min, type, x, y)
> +
> +/**
> + * max_t - return maximum of two values, using the specified type
> + * @type: data type to use
> + * @x: first value
> + * @y: second value
> + */
> +#define max_t(type, x, y) __cmp_once(max, type, x, y)
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __VDSO_MINMAX_H */

