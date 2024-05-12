Return-Path: <linux-arch+bounces-4341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3591E8C378D
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8241F21158
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80E42A8E;
	Sun, 12 May 2024 16:30:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223E1109;
	Sun, 12 May 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715531430; cv=none; b=OPNHxpt6jy2ZUUTEJ6ucZOwH5QI64ckILXMQ7asSpSiDURQbFaL4+z7TQBL6mEApN+wJInIiqUTZEuq9CPyux2m1v4xplqLqeiF/1H5xhjx/DrXQvOebTQMEXRilG/QKAMP5YvUGSkjxTHb9gbM9N8xsMRqcbv6doBogQtEVyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715531430; c=relaxed/simple;
	bh=0HdeaOF1XK2sxOtEvQ5oWU9I6tjX477QwMYRfdMojhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JF/yTD7BVyvcHvc34jWTr8SgdLhOyjHh7ZxvZXMpXk+dxoH8AL5gbPI0N1ntstkCTBRvFRTdffNadYPJWCiKPbjd+0TgCExZt6x/t1ErauH5ys00+Ip48ji5rXVlPd7CTV+RsRexMd420czz/Zd6MaZ0O6+lvPSlg+Ejifl+Opc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B667840006;
	Sun, 12 May 2024 16:29:03 +0000 (UTC)
Message-ID: <a8ee97ee-c51c-4d6a-a9fc-54b065215ebf@ghiti.fr>
Date: Sun, 12 May 2024 18:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/29] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
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
 <20240403234054.2020347-13-debug@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240403234054.2020347-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 04/04/2024 01:35, Deepak Gupta wrote:
> pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
> Underlying arch can have two types of writeable mappings. One that can be
> written using regular store instructions. Another one that can only be
> written using specialized store instructions (like shadow stack stores).
> pte_mkwrite can select write PTE encoding based on VMA range (i.e.
> VM_SHADOW_STACK)
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/pgtable.h |  7 +++++++
>   arch/riscv/mm/pgtable.c          | 21 +++++++++++++++++++++
>   2 files changed, 28 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 6362407f1e83..9b837239d3e8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -403,6 +403,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
>   
>   /* static inline pte_t pte_mkread(pte_t pte) */
>   
> +struct vm_area_struct;
> +pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
> +#define pte_mkwrite pte_mkwrite
> +
>   static inline pte_t pte_mkwrite_novma(pte_t pte)
>   {
>   	return __pte(pte_val(pte) | _PAGE_WRITE);
> @@ -694,6 +698,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>   	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
>   }
>   
> +pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
> +#define pmd_mkwrite pmd_mkwrite
> +
>   static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
>   {
>   	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
> diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
> index ef887efcb679..c84ae2e0424d 100644
> --- a/arch/riscv/mm/pgtable.c
> +++ b/arch/riscv/mm/pgtable.c
> @@ -142,3 +142,24 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   	return pmd;
>   }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
> +{
> +	if (vma_is_shadow_stack(vma->vm_flags))
> +		return pte_mkwrite_shstk(pte);
> +
> +	pte = pte_mkwrite_novma(pte);


I would directly return pte_mkwrite_novma(pte) instead of assigning pte.


> +
> +	return pte;
> +}
> +
> +pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> +{
> +	if (vma_is_shadow_stack(vma->vm_flags))
> +		return pmd_mkwrite_shstk(pmd);
> +
> +	pmd = pmd_mkwrite_novma(pmd);


Ditto here.


> +
> +	return pmd;
> +}
> +


Otherwise:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


