Return-Path: <linux-arch+bounces-7395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365A985353
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DB2B23245
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B5156644;
	Wed, 25 Sep 2024 06:58:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763C155C9A;
	Wed, 25 Sep 2024 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247529; cv=none; b=JhPHYc9EYAm6XGKQiLKjmlkFe38ezyvXR5u/3zVdX2QD/119LpaXFvoe/lMf3B2II6MvlHb2M37UNGoZZy49eGQ59lC3vIe5L51bmWPCqTtA1kvT1Qhrhsc3NTPA+DGxPdNK9A+iJiFurdEss7GvSO9wIiHVOzK3FfNrXp+c+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247529; c=relaxed/simple;
	bh=EAd0qLHsohRHdqR09kqHrPoMq2fQkiuBxp/rDrIbScM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOQnLxP5WTuMJ/BJERp89AqyB3mLcmwLrAOeczn1Hp9+W9ErLxTgxk4ifG03rfnXaudcysjqGEJREXzNguo43mYcdkk+iDwvXYJnc2uT8GwiccaQPYnMRh4snK2QlBKnuiSl2ydV9kO30kMKvbXMcYLQLzT6mvZzjLObv3PK2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD6yZ300gz9sSj;
	Wed, 25 Sep 2024 08:58:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UaB2eINDhMGJ; Wed, 25 Sep 2024 08:58:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD6yZ26zyz9sSh;
	Wed, 25 Sep 2024 08:58:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 34DAC8B76E;
	Wed, 25 Sep 2024 08:58:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kxe6WZTzBxkJ; Wed, 25 Sep 2024 08:58:46 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 681498B763;
	Wed, 25 Sep 2024 08:58:45 +0200 (CEST)
Message-ID: <9ca674df-fb14-4d7a-880f-5dd2a37a0d4f@csgroup.eu>
Date: Wed, 25 Sep 2024 08:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] vdso: Modify vdso/getrandom.h to include the asm
 header
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
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-7-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-7-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Modify vdso/getrandom.h to include the getrandom asm header.

You should explain why this is needed, i.e. what item in 
vdso/getrandom.h requires asm/vdso/getrandom.h

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   include/vdso/getrandom.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
> index 6ca4d6de9e46..5cf3f75d6fb6 100644
> --- a/include/vdso/getrandom.h
> +++ b/include/vdso/getrandom.h
> @@ -7,6 +7,7 @@
>   #define _VDSO_GETRANDOM_H
>   
>   #include <linux/types.h>
> +#include <asm/vdso/getrandom.h>
>   
>   #define CHACHA_KEY_SIZE         32
>   #define CHACHA_BLOCK_SIZE       64

