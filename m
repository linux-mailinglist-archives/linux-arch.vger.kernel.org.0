Return-Path: <linux-arch+bounces-7396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B012098535D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 09:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6755F1F249B2
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 07:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7313D62F;
	Wed, 25 Sep 2024 07:00:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C583139579;
	Wed, 25 Sep 2024 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247630; cv=none; b=EL95wbcxg32dKHrjczXFcMOXxCAJQyGiCeuw0Oy+Bowa3ER01gtCP7UHu/F7GG+0AjDyQUR02M/uMY7b5nW7ycu0YchJ8SBxJTIvPMeACRGW+qGuyGNfVsKKlYPQluYC3tENU8KNlSBfCjztW3lKGIsikpYhx9v6w2Qj7Hx1dcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247630; c=relaxed/simple;
	bh=2Opq9pYRYc+2NVUla/yJtqyEXKvkYT4SyaMbK4xNJoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYLetpKXb1szqHNZTowTpSkXZ2IA/wn4aCc/1HcTKyRj0DXlkRvja+hMRxkUT1M1mdaV6sMa8yhmVjOncDqTxBUfZcE6efhuXR6XL3WkidzWQVzQNVZVkX4BK52NmVuh83FdEKT7YWN/fF0RZjUK1voYaubLMrlN4TlRNG/Fvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD70W5ZJ3z9sSn;
	Wed, 25 Sep 2024 09:00:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhhpyeqXXEzF; Wed, 25 Sep 2024 09:00:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD70W4pv4z9sSm;
	Wed, 25 Sep 2024 09:00:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 93B748B76E;
	Wed, 25 Sep 2024 09:00:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xoSrzQH1T2Dz; Wed, 25 Sep 2024 09:00:27 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B2E828B763;
	Wed, 25 Sep 2024 09:00:26 +0200 (CEST)
Message-ID: <15db661b-bd41-41ca-bc0c-e627a3564d76@csgroup.eu>
Date: Wed, 25 Sep 2024 09:00:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] vdso: Introduce uapi/vdso/random.h
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
 <20240923141943.133551-8-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-8-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Introduce uapi/vdso/random.h to make sure that the generic
> library uses only the allowed namespace.

I can't see the reason for this change.

VDSO is userland code and should be safe to include any UAPI header.

Christophe

