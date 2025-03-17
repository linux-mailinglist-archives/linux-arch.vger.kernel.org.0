Return-Path: <linux-arch+bounces-10924-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4AA66329
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 00:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC113A5B45
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279F2066CC;
	Mon, 17 Mar 2025 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdhvRWsC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2C12066C1
	for <linux-arch@vger.kernel.org>; Mon, 17 Mar 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255543; cv=none; b=tvXmQxBHkgOsYm7RAg6OGpfG/MVko/ChZkE9RnExxTH1BWSeuwKDBXmJUH8lNPC67cbIbg1YstVrYtxgDr3qGwt/odCQItJQkaezLY2HF4f2JI8+dlAo+b6Tr04dSc6sDlT0amMAY+acnt5u2EjjjcHD3BmTbFT5Jpe7TVCJzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255543; c=relaxed/simple;
	bh=gvz05YIWaLvwfZjPBEm872B5QkOs/p9lPHWGYTN34MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxdCQNTgtSv6z9dsOmTBSCC894Fn0C5xUHf90Hup2/1HG37h+bgliP763KAN1Kc8TGClTVRq/zuqFj6DrwWjgZCnIw0DK6VSpGw5MipUKekPlCt9mJ73Wcz4ouxPf1T32vYx8CYqmSeK1X/kmcHWtyxaKc2A/VY58U1E9hlCyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdhvRWsC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742255541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ln9muO+UnoEXyYsgLcV9Ra/t7A/95ouFlMUsf8wdrpI=;
	b=BdhvRWsCYp+zEO74P9kkwjE3ptYivWXcZ5YdPTzqdBb4rjfOl2aVsZ6Vc/cg8r1af/cqUf
	qVTQLbrUTGj00HY6+da8dhAt0vitPnhJuEzKrJbDaX43YNjcaA4H6kMNAoFjLT0lByBE0M
	K/FDizBFXEh7CvA0xDih120IKAILoko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-DU2R_2XDMkuC00OGsR7rfg-1; Mon,
 17 Mar 2025 19:52:14 -0400
X-MC-Unique: DU2R_2XDMkuC00OGsR7rfg-1
X-Mimecast-MFC-AGG-ID: DU2R_2XDMkuC00OGsR7rfg_1742255532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C30A195608B;
	Mon, 17 Mar 2025 23:52:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53A23180174E;
	Mon, 17 Mar 2025 23:52:05 +0000 (UTC)
Date: Tue, 18 Mar 2025 07:52:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 1/5] arch/x86: Drop own definition of pgd,p4d_leaf
Message-ID: <Z9i1oGaAR9c2MPbN@MiWiFi-R3L-srv>
References: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/13/24 at 09:08am, Christophe Leroy wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> We provide generic definitions of pXd_leaf in pgtable.h when the arch
> do not define their own, where the generic pXd_leaf always return false.
> 
> Although x86 defines {pgd,p4d}_leaf, they end up being a no-op, so drop them
> and make them fallback to the generic one.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/include/asm/pgtable.h | 10 ----------
>  1 file changed, 10 deletions(-)

Seems this series is missed. It does do a great clean up.

> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 65b8e5bb902c..772f778bac06 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -252,13 +252,6 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
>  	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
>  }
>  
> -#define p4d_leaf p4d_leaf
> -static inline bool p4d_leaf(p4d_t p4d)
> -{
> -	/* No 512 GiB pages yet */
> -	return 0;
> -}
> -
>  #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
>  
>  #define pmd_leaf pmd_leaf
> @@ -1396,9 +1389,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
>  	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
>  }
>  
> -#define pgd_leaf	pgd_leaf
> -static inline bool pgd_leaf(pgd_t pgd) { return false; }
> -
>  #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
>  /*
>   * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages
> -- 
> 2.44.0
> 
> 


