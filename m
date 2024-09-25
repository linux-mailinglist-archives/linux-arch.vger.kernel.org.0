Return-Path: <linux-arch+bounces-7390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180A98533B
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183D928261C
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1B15575B;
	Wed, 25 Sep 2024 06:51:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E668155751;
	Wed, 25 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247065; cv=none; b=aSDE2bmE0B7fMxl+Qkte4atopio6Pn6JxtSFsLIgHQ+LuYU/Px4nh4juzqA+ahMGgcyA0tdJswjynicymMOdEnthEU2ekXjSEX0rMzUFlVwQco7vMf62SDHacHKhzC24SNLQfe3T6TR5918diCGOMB8dXfT5+NDcCminDUjTvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247065; c=relaxed/simple;
	bh=PSYNZMFkaYoG/HLJwWAvfyDTbE6HRmrOEoHtLD17l0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZ+9CvYx3DTZg0aWqbm32zK7L2ECQQcxESiKXvDpGSNxG3F0rfmT8PFNqbwyTwikD/KYXdCekAPWKuGYHQg3XjrqhTyl03uPRah+u8j6Yolv7fox3/gZkKQRvM9PG73piUARxBrGcbASg6npWV99hRVAL6IbelCUerR9sOpMves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD6nd28lPz9sSK;
	Wed, 25 Sep 2024 08:51:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wiveKoQOCT17; Wed, 25 Sep 2024 08:51:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD6nd1JXyz9sRs;
	Wed, 25 Sep 2024 08:51:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A0E88B76E;
	Wed, 25 Sep 2024 08:51:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qdW7TkhX9VjY; Wed, 25 Sep 2024 08:51:01 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4444C8B763;
	Wed, 25 Sep 2024 08:51:00 +0200 (CEST)
Message-ID: <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
Date: Wed, 25 Sep 2024 08:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
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
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
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

I still can't see the point with that change.

Today 4 architectures implement getrandom and none of them require that 
indirection. Please leave prot and flags as they are in the code.

Then this file is totally pointless, VDSO code can include 
uapi/linux/mman.h directly.

VDSO is userland code, it should be safe to include any UAPI file there.

Christophe

> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_MMAN_H */

