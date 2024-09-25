Return-Path: <linux-arch+bounces-7391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D998533F
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 08:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3FE285702
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6104155CB3;
	Wed, 25 Sep 2024 06:52:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424B155CA5;
	Wed, 25 Sep 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247146; cv=none; b=s9RmJZJxhtLWKgFdjBi5arIrnsiTJahuHEhNEFiPo5gaKlewV/aaDdqWECeZpplCxQYG/UOJKqW9Tn+gy5GhUOf5x2uMTa8W8BestwgbrT//8K0Rf3C7ZBbe3Lp8cGjedi8TRhgZrI5dJ9k/ehX1/OYd7ZMbSvjbb6dgZE32Bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247146; c=relaxed/simple;
	bh=1cbHJHmr4qIBX4NVfnMUMNO5Ol4MFaXBDbzupdbp3TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdeUlqVJ6vNoSsRbQpjAzzEo8/uDwXj19Vu+yMglzEVTa1EbySk4uh0L2/SN/ljf/PAajD3DfPEucOCW7979S7mKkOPqFXRMWFjOo6xRF4C8F5N91FztwRxc6pnXw99mUFbb2kOQAwxs7liqDPoJyhdv2DK370D1ZLdiYXEnBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD6qC3byrz9sSY;
	Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhn-04nPqxse; Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD6qC2hFCz9sSX;
	Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 482688B76E;
	Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nzd3Q0q-rGGs; Wed, 25 Sep 2024 08:52:23 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 422638B763;
	Wed, 25 Sep 2024 08:52:22 +0200 (CEST)
Message-ID: <ef85b562-b883-4b43-867d-bd83fc28d9fe@csgroup.eu>
Date: Wed, 25 Sep 2024 08:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] arm64: vdso: Introduce asm/vdso/mman.h
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
 <20240923141943.133551-3-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-3-vincenzo.frascino@arm.com>
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
>   arch/arm64/include/asm/vdso/mman.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 arch/arm64/include/asm/vdso/mman.h
> 
> diff --git a/arch/arm64/include/asm/vdso/mman.h b/arch/arm64/include/asm/vdso/mman.h
> new file mode 100644
> index 000000000000..4c936c9d11ab
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/mman.h
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
> +

Same comment here as for x86, the flags are the same on all archictures, 
no need for such an indirection which makes the code less readable.

Christophe

