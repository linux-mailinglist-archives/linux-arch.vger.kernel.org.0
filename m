Return-Path: <linux-arch+bounces-7027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87096C50A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ACB1F26A4F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799481E0B74;
	Wed,  4 Sep 2024 17:15:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2A5464E;
	Wed,  4 Sep 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470103; cv=none; b=DmeZgYZt+XL/mCRrP6IFxUeepxoQnqB3Cqh2D4HjA1wr/ACqS1gOpZ/dJuWbci5mIW4o6mZ3TrE6wupRIj1h1S6Ig9Ux6tjDaxmmPfS3/zOFCMHwLxxqRVbroeR5XHUIMUCNOmoclgndHPswpL+yRjxAA55mepTO9xe/M8KnBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470103; c=relaxed/simple;
	bh=JfDqkoJGilVq7sn4CKZULFSWceteaKnpJqHWMuP9cFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASAKKsYocuJO0GX+Y7Bu3e1PbPDm6vU2w5YOEytpsUaIG8wVKGlN7IpcybxD3mEyQxvedKbnzjoVH0WyDipiliZKFHyEeYgsfWOoDS91kEFDCJcDGWpfjDE0uTfDRwOz8ENGifMvOGdZmSR9t5b1eQCy0fWJZSqIRiNdn59HBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzTdH42rQz9sSK;
	Wed,  4 Sep 2024 19:14:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlpA-TvtqbJ6; Wed,  4 Sep 2024 19:14:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzTdH3BWjz9sSH;
	Wed,  4 Sep 2024 19:14:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 58D1C8B77A;
	Wed,  4 Sep 2024 19:14:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wEG_f2jM11cu; Wed,  4 Sep 2024 19:14:59 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E3E68B778;
	Wed,  4 Sep 2024 19:14:58 +0200 (CEST)
Message-ID: <919d9520-32a5-4a32-880d-8ac53601b188@csgroup.eu>
Date: Wed, 4 Sep 2024 19:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
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
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-4-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Introduce asm/vdso/page.h to make sure that the generic library
> uses only the allowed namespace.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/x86/include/asm/vdso/page.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 arch/x86/include/asm/vdso/page.h
> 
> diff --git a/arch/x86/include/asm/vdso/page.h b/arch/x86/include/asm/vdso/page.h
> new file mode 100644
> index 000000000000..b0af8fbef27c
> --- /dev/null
> +++ b/arch/x86/include/asm/vdso/page.h
> @@ -0,0 +1,15 @@
> +
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VDSO_PAGE_H
> +#define __ASM_VDSO_PAGE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/page_types.h>
> +
> +#define VDSO_PAGE_MASK	PAGE_MASK
> +#define VDSO_PAGE_SIZE	PAGE_SIZE

Same, I don't think we need those macros to duplicate PAGE_SIZE and 
PAGE_MASK in each and every architecture.

The best would be to use CONFIG_PAGE_SHIFT which is defined the same way 
on every architecture and refactor PAGE_SIZE and PAGE_MASK and get rid 
of all arch specific definitions of PAGE_SIZE and PAGE_MASK.

> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_PAGE_H */

