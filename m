Return-Path: <linux-arch+bounces-7030-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCFA96C539
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F71B25663
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2671E413D;
	Wed,  4 Sep 2024 17:18:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6531E202D;
	Wed,  4 Sep 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470315; cv=none; b=O4S42tvSgDFKBbkZiSkEJbo/72lCc4V7wQI68KXhlwDrRk5lYNfEzyZATTPYy64nQs/qS0vRF/BZNlGpd+b063B0OLfMAU089lf3hhmgh8ihPv3hyI39bFXenlnZy4wy5TGDyOlb3RH9etesyH8XipriUzWdKO618IoZKjvzgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470315; c=relaxed/simple;
	bh=dwP0dUhgLp+xDvuD6Z38b1kog/RqmlVxPR+iBWo/T0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSOCHfDH+DWnXSsRY4zzCiAIOyeWZ4xLQQd1TnkI1Wv1kzAFYunWjn7NzqHwMHFQw6HvMbVB0GySbYKLd4qckD8RWcCeXIubepgxpG7fL2z2S/mETvc45PtFDAgxxpQt+L3+/Aeb0dgbKXGFMoo657olKVrlHPo0qt75SY2YTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzTjN1CmTz9sSW;
	Wed,  4 Sep 2024 19:18:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSYeCfSSGneC; Wed,  4 Sep 2024 19:18:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzTjN0L9mz9sSV;
	Wed,  4 Sep 2024 19:18:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E8B128B77A;
	Wed,  4 Sep 2024 19:18:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wqRIgX-QwCxn; Wed,  4 Sep 2024 19:18:31 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 187428B778;
	Wed,  4 Sep 2024 19:18:31 +0200 (CEST)
Message-ID: <8fbb8fed-e8d4-475c-8093-373d0afb62cc@csgroup.eu>
Date: Wed, 4 Sep 2024 19:18:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] vdso: Split linux/array_size.h
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
 <20240903151437.1002990-7-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-7-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Split linux/array_size.h to make sure that the generic library
> uses only the allowed namespace.

There is only one place using ARRAY_SIZE(x), can be open coded as 
sizeof(x)/sizeof(*x) instead.

Christophe

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   include/linux/array_size.h |  8 +-------
>   include/vdso/array_size.h  | 13 +++++++++++++
>   2 files changed, 14 insertions(+), 7 deletions(-)
>   create mode 100644 include/vdso/array_size.h
> 
> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> index 06d7d83196ca..ca9e63b419c4 100644
> --- a/include/linux/array_size.h
> +++ b/include/linux/array_size.h
> @@ -2,12 +2,6 @@
>   #ifndef _LINUX_ARRAY_SIZE_H
>   #define _LINUX_ARRAY_SIZE_H
>   
> -#include <linux/compiler.h>
> -
> -/**
> - * ARRAY_SIZE - get the number of elements in array @arr
> - * @arr: array to be sized
> - */
> -#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> +#include <vdso/array_size.h>
>   
>   #endif  /* _LINUX_ARRAY_SIZE_H */
> diff --git a/include/vdso/array_size.h b/include/vdso/array_size.h
> new file mode 100644
> index 000000000000..4079f7a5f86e
> --- /dev/null
> +++ b/include/vdso/array_size.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _VDSO_ARRAY_SIZE_H
> +#define _VDSO_ARRAY_SIZE_H
> +
> +#include <linux/compiler.h>
> +
> +/**
> + * ARRAY_SIZE - get the number of elements in array @arr
> + * @arr: array to be sized
> + */
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> +
> +#endif  /* _VDSO_ARRAY_SIZE_H */

