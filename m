Return-Path: <linux-arch+bounces-7031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7196C54A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759EA1F290F1
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C01E2029;
	Wed,  4 Sep 2024 17:19:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFF1E2014;
	Wed,  4 Sep 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470399; cv=none; b=KZOx3ISGtgmaNjbrZvAe32G66h00YPE2FMDA6HCrRLCSokU/JwGdBThcbeEXQwaCZFpTRnLJL1dhd1b23H1ZbtVHVc8EPaAy4j1wXT6vlFNtCpI9X2A9FlABVSvVR+5Uvxf6X0eY3gWPkz12SOM8GLythKO+O9w3RtyIXtlPLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470399; c=relaxed/simple;
	bh=Kh/H8Y19ex2FWgeKdHu7JRX6V0NyK6SCuuAvl7o4zeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5IepP8Oe6TsEsiH04no4TNGCYtQUaawuUNas8HhKiGJ8yOyatrcIyVsf77w5LdGq76t+IlLOY1HxU8wpOnHn+uM4XB9WbutJuViinMO2BnUIqqyGvzvmS4etHlhT8DpdiHv6d7zjWorCO+vLKVu4fAhm6Z/KePwR9j1G/M6+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzTkz63MCz9sSY;
	Wed,  4 Sep 2024 19:19:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dR5-G9h3yyI; Wed,  4 Sep 2024 19:19:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzTkz5Cgrz9sSX;
	Wed,  4 Sep 2024 19:19:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A7598B77A;
	Wed,  4 Sep 2024 19:19:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OPXzgoBSR4gb; Wed,  4 Sep 2024 19:19:55 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93FC38B778;
	Wed,  4 Sep 2024 19:19:54 +0200 (CEST)
Message-ID: <ebb01fce-aea5-4d82-b8b9-2e30f534b54c@csgroup.eu>
Date: Wed, 4 Sep 2024 19:19:54 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] x86: vdso: Modify asm/vdso/getrandom.h to include
 datapage
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
 <20240903151437.1002990-8-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-8-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Modify asm/vdso/getrandom.h to include datapage.

Does  asm/vdso/getrandom.h need datapage ? If not it is the ones that 
need it that should include it.

> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/x86/include/asm/vdso/getrandom.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
> index ff5334ad32a0..4597d5a6f094 100644
> --- a/arch/x86/include/asm/vdso/getrandom.h
> +++ b/arch/x86/include/asm/vdso/getrandom.h
> @@ -7,6 +7,8 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +#include <vdso/datapage.h>
> +
>   #include <asm/unistd.h>
>   #include <asm/vvar.h>
>   

