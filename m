Return-Path: <linux-arch+bounces-13131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16939B225E3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A35F3A1270
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CB29BDBC;
	Tue, 12 Aug 2025 11:32:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48982857DF;
	Tue, 12 Aug 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998321; cv=none; b=JncRcE5RvzVxhCsJ+8YoeEctyhGwoEtXD661GdtIIqkJg4IVpWCEW7+0hp/cuiIc2yZLpoVOgRLcZuMKGixf6jAEicuxQKtXOPuYXVOVGXlh68dcgiVbZawbKK1Wz/bbir0l+MK6PJgdixvHMe7DUOgFV0BK1JJFa1vidPdnBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998321; c=relaxed/simple;
	bh=7kxPRunFsFqcegGcujVUOac3phCEbrLXAC4fvNP2PMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoKpi+9LBOuaICaVsvEd4a375WXmJdV3XAizTMARnq7VxUXvSK9g1Uq/LmIeiDq4VnRpEdmk1++hkf1J+95U31/ZlsJPSQ0g7galkqxn477Qc9GqvEH1lT8OC253zilV+HCjRhzIk4rs0RdbKwJoIXPl8TEfwLR9Y7TnjrnBySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF99D44964;
	Tue, 12 Aug 2025 11:31:47 +0000 (UTC)
Message-ID: <cf90951d-0eee-4b51-a769-b657144dab7a@ghiti.fr>
Date: Tue, 12 Aug 2025 13:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>
References: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeejtdduugemkeguuggumegskegrtdemvdejfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeejtdduugemkeguuggumegskegrtdemvdejfhgspdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeejtdduugemkeguuggumegskegrtdemvdejfhgsngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg

Hi Christophe,

On 8/12/25 13:14, Christophe Leroy wrote:
> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_user() in include/asm-generic/pgtable-nopmd.h
>
> But pud_user() only exists on ARM64 and RISCV and is not expected
> by any part of MM.
>
> Add the missing definition in arch/riscv/include/asm/pgtable-32.h
> and remove it from asm-generic/pgtable-nopmd.h
>
> A stub pud_user() is also required for ARM64 after
> commit ed928a3402d8 ("arm64/mm: fix page table check compile
> error for CONFIG_PGTABLE_LEVELS=2")
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>   arch/arm64/include/asm/pgtable.h    | 1 +
>   arch/riscv/include/asm/pgtable-32.h | 5 +++++
>   include/asm-generic/pgtable-nopmd.h | 1 -
>   3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index abd2dee416b3b..fef7cc7a340d8 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -955,6 +955,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>   
>   #define pud_valid(pud)		false
>   #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
> +#define pud_user		false /* Always 0 with folding */
>   #define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
>   
>   /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 00f3369570a83..37878ef374668 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -36,4 +36,9 @@
>   static const __maybe_unused int pgtable_l4_enabled;
>   static const __maybe_unused int pgtable_l5_enabled;
>   
> +static inline int pud_user(pud_t pud)
> +{
> +	return 0;
> +}
> +
>   #endif /* _ASM_RISCV_PGTABLE_32_H */
> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
> index 8ffd64e7a24cb..b01349a312fa7 100644
> --- a/include/asm-generic/pgtable-nopmd.h
> +++ b/include/asm-generic/pgtable-nopmd.h
> @@ -30,7 +30,6 @@ typedef struct { pud_t pud; } pmd_t;
>   static inline int pud_none(pud_t pud)		{ return 0; }
>   static inline int pud_bad(pud_t pud)		{ return 0; }
>   static inline int pud_present(pud_t pud)	{ return 1; }
> -static inline int pud_user(pud_t pud)		{ return 0; }
>   static inline int pud_leaf(pud_t pud)		{ return 0; }
>   static inline void pud_clear(pud_t *pud)	{ }
>   #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))


Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex


