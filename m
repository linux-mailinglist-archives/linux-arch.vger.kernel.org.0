Return-Path: <linux-arch+bounces-4340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EC8C3778
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 18:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E5DB20A6C
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA64776A;
	Sun, 12 May 2024 16:28:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921F17C95;
	Sun, 12 May 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531286; cv=none; b=OLwf353fCFYTYs+1JaVLsJZV4J8lVmEC7BdAg2xYHfVCobis4yTf7iDZ4OTZxmXJkGNQOgTVaN6VX5jLXBCKRDS42SVtUwXP3scxfvoDxguNsGJlrwmLQ+cn1JjqjxAYeFh+XRTG6GAsZG6HaFFbMI+CZluoZ1oUyoWni/gHvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531286; c=relaxed/simple;
	bh=UzQr1TNXnTNDAEn5uLA+4XARweS6x1GTyqCrZYGwiWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHR/8grwISW188rlvTDUGrCjdZgcOpLkxmHEu/mcF21qkJfCr13wpik3YAbI78z+BOhp+RAPnKbWQfIfsRubJNfuvu+OQRztIQl4nvS5lZF/h11S3DfHEzo8pn59L3qzhgnB2uz7j0F8Vlu8KxfW49EwzSf2cRb+zGbldz/+QD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B45E60004;
	Sun, 12 May 2024 16:26:52 +0000 (UTC)
Message-ID: <0ea4aff6-980f-4fc6-9ab7-9ca4c9d15d1e@ghiti.fr>
Date: Sun, 12 May 2024 18:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/29] riscv mm: manufacture shadow stack pte
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 kito.cheng@sifive.com, keescook@chromium.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 bjorn@rivosinc.com, alexghiti@rivosinc.com, samuel.holland@sifive.com,
 conor@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-12-debug@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240403234054.2020347-12-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 04/04/2024 01:34, Deepak Gupta wrote:
> This patch implements creating shadow stack pte (on riscv). Creating
> shadow stack PTE on riscv means that clearing RWX and then setting W=1.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 4d5983bc6766..6362407f1e83 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -408,6 +408,12 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
>   	return __pte(pte_val(pte) | _PAGE_WRITE);
>   }
>   
> +static inline pte_t pte_mkwrite_shstk(pte_t pte)
> +{
> +	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */


Nit: Not sure the comment is necessary


> +	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
> +}
> +
>   /* static inline pte_t pte_mkexec(pte_t pte) */
>   
>   static inline pte_t pte_mkdirty(pte_t pte)
> @@ -693,6 +699,12 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
>   	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
>   }
>   
> +static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
> +{
> +	/* shadow stack on risc-v is XWR = 010. Clear everything and only set _PAGE_WRITE */
> +	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
> +}
> +
>   static inline pmd_t pmd_wrprotect(pmd_t pmd)
>   {
>   	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

Otherwise:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


