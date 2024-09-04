Return-Path: <linux-arch+bounces-7026-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D911796C47F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1C1F25B9E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA261E009E;
	Wed,  4 Sep 2024 16:56:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AE4778C;
	Wed,  4 Sep 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469000; cv=none; b=q177mAh38Fhx1vB7r0tplY+sJ3fPg9Axh7cTK749+ibV6dvPxafYRun6be4Rpkqjf7GYe/0KeLT7cqzBZnW3BG/U2pYnaUc3qtoaQzJWKnWCarpXb3HxZpUIT7HUQTXLcRrW/45AakVA7zXm8DOuJe4exLcZIPMpTqM/BSWdU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469000; c=relaxed/simple;
	bh=R3p88TseIIEU6PDnnA8E0S+vB/2n7XxrZwfCGfhYxRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol2y2e8edDe5TLLsn/uqXm5DjB3CI16vn0ue3qcXlIJR/3Z4Om33InqSzkrFAIW4SvMsAPjQTL66gRsZommABZZ4eyCJ42I6xD3pUD9/Fj9MiwvJpgWABSIlLEwyALGoaAWJvXdb2lBKcfZM/M1Iwe2IUDYIYq7j87pAnCeWgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzTD43dS3z9sSC;
	Wed,  4 Sep 2024 18:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZyS882MMwzh; Wed,  4 Sep 2024 18:56:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzTD42jdmz9sS7;
	Wed,  4 Sep 2024 18:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B2068B77A;
	Wed,  4 Sep 2024 18:56:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id RPtdGw1i-ycG; Wed,  4 Sep 2024 18:56:36 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 78B008B778;
	Wed,  4 Sep 2024 18:56:35 +0200 (CEST)
Message-ID: <710f9663-e99c-40e2-9c0e-2f5e6e854653@csgroup.eu>
Date: Wed, 4 Sep 2024 18:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] x86: vdso: Introduce asm/vdso/mman.h
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
 <20240903151437.1002990-2-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Introduce asm/vdso/mman.h to make sure that the generic library
> uses only the allowed namespace.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/x86/include/asm/vdso/mman.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 arch/x86/include/asm/vdso/mman.h
> 
> diff --git a/arch/x86/include/asm/vdso/mman.h b/arch/x86/include/asm/vdso/mman.h
> new file mode 100644
> index 000000000000..4c936c9d11ab
> --- /dev/null
> +++ b/arch/x86/include/asm/vdso/mman.h
> @@ -0,0 +1,15 @@
> +
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VDSO_MMAN_H
> +#define __ASM_VDSO_MMAN_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <uapi/linux/mman.h>
> +
> +#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
> +#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS

I still can't see the benefit of duplicating those two defines in every 
arch.

I understand your point that some arch might in the future want to use 
different flags, but unless we already have one such architecture in 
mind we shouldn't make things more complicated than needed.

In case such an architecture is already identified it should be said in 
the commit message

> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_MMAN_H */

