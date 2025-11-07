Return-Path: <linux-arch+bounces-14561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E3C3FC58
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599281892EC5
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54225A631;
	Fri,  7 Nov 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXWmGg0J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CD2DF3DA
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515919; cv=none; b=Ns2ykSduSpvfbwS905rScplJMtuxgbPzi69D4HMaK/79/lHkNTwToiXPqTt2+GpaHC8Il/tvxRXRNJh6QT3J2jDjGma3lYKPJVSDkP3KHdn+ZvjUdBhd14CBxqniyTRpJS9Sbc8XHbomjwzos4KqiX8b3asbHyny/YwqnPkRCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515919; c=relaxed/simple;
	bh=J/aI4rKmxspso1/MCo9q/nVgTvxtSI/RPPnCjmkZ3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNFHgGX0w5TYy0fHB41AwHYFbsulkGoJJ0pkSVhDZsVPNVQdm/3REWzzUKPtqhw7BMZzuji0s/F9MFPjaw8Z05jr+UpBwiqOYrJbk65uFBoMH49T6ToQEBph/lyw6uKUFm26I/rNjcwlQb615jv5QYBeqervgUCpd7Zg/45mSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXWmGg0J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aad4823079so619989b3a.0
        for <linux-arch@vger.kernel.org>; Fri, 07 Nov 2025 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515917; x=1763120717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3UolEFy3bRdP252sm4YQ2agYywAUHuWFJXJIEy7jek=;
        b=XXWmGg0JNlez0SkMg/AnaDYb2Wpi62VZD0MkDPerJyygC5aaRMGj9IQN74kgFkCyce
         5WwkqZm8qEK98/7Ya2ux08ftJkb2p4VNM0AFVjVeHwAk1+6D9+1Vmm2pjeD+aBv9wZm3
         enToORStbQohav9T3DxlfAAF6UaEUhLYOoKPpQgvlGszLozaQgC/jVj+9qYmOzHfOlyh
         LNcPpeVlmdoO2jqweVMHg0tFWwm1A5ybSBNnj72NIxmBdmPXTCRmdqEfv6ZSIJH5ALJ6
         g2jL70O3JTJXhOjBgJN5fodEytNc5s9lgDUcMWqriAmfPGcNJG33VGA+ygVoonLZS16g
         8STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515917; x=1763120717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3UolEFy3bRdP252sm4YQ2agYywAUHuWFJXJIEy7jek=;
        b=XHWIO9tX9sP55deV8q28B/60Wjf6FZWNpRZDGRV41Eeq6/lbXmxELoqaGSCrewIaEa
         +47nYwAHkpO8vvucAZLxr1JFcCGES50/UWV9vWNnZ5C7JTA1ocK89eaO6ZdrAd1dCdw3
         eNiy4Uzjrv5ucUnhXd48Ld5AE/hIC1fqsU6DqUkglDHbZuulFopaVm92116Lzx+VAjvR
         pD2KsuCOLr1OpQ+QLlwJK02ogTVlDYtS8d8ZTmdYaPSMw6exqWrNZfgpWfn8rxQ6fUvT
         sRJAwoicdUhi5vkWVBSLWvmxdxmbgOusATZ8h2caALMtQS8NlK71ddr1QR9LsbzoQuej
         oD5g==
X-Forwarded-Encrypted: i=1; AJvYcCUzbYT6168KnLQ5hvY0+RHQLg+EtMpNbvbEZe7OXJLir41qhCuzvRgCpGpkiqcnPlux7z7lXYWaIOx0@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTHMs+LKt0gk61FrszKWGBWkaOgKHFBleu7NGtT4aMxmwBwYu
	lF4PN6WOv1/754Y4HNaUWpO5QORCzikSphYsVoD4C6wp4IFjyCCehrR4
X-Gm-Gg: ASbGncuMD5vQEyBUah0l9xZScJcn+O+7yiNLIJhacKM7n3F88zEFWLhb2H/75kJ5TKw
	63YUasK4WS+suYp+Era28Bdfv1+rHMTfFw0w4/fFf2M0eXseA0/c2znCyTypp9bn1ZX1BmOKk7U
	l/mV160m91PQAgO3p9F4iy8Nay6qxSMCFMesPUC6GLp6OThSMZqBvcAvdrXUBdcaWbSIr9fWlxG
	PerBwj5+OjABhTFqPMd9ZsRuQT41uPwrRwxG8LIhAU6U4I/B4WP1x2Y3YzrYgzX65RB1+V4oJrI
	6rKx68QEr0sI0Epyketqwxvuf66f17quCUh+7dXJU7oONMUX9yDOhqhUGKvZIHVZ9bBqpIt7F6d
	7rxfG9L7gfWQ4THuT8Cq9j7Gv9mrYtZsxKFV4saVnfZQ+btqfS9l4RTq2yjQ9Ontz2ZcLJg7FlJ
	UgyW+E
X-Google-Smtp-Source: AGHT+IEgK3+y79M6QAxgxitqK9nN+XnGR2GDAi2/FrE6+S2IrZU3wlJefPhdXptP4GRU9s4WXBb9ew==
X-Received: by 2002:a17:90b:35cf:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-3434c4eca56mr3374514a91.11.1762515916704;
        Fri, 07 Nov 2025 03:45:16 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e718asm2717145b3a.30.2025.11.07.03.45.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Nov 2025 03:45:16 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: chenhuacai@loongson.cn
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	chenhuacai@kernel.org,
	jack@suse.cz,
	kevin.brodsky@arm.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	vishal.moola@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*() about HIGHMEM
Date: Fri,  7 Nov 2025 19:44:55 +0800
Message-ID: <20251107114455.59111-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251107095922.3106390-1-chenhuacai@loongson.cn>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Fri,  7 Nov 2025 17:59:22 +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.

Nice cleanup!

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> Resend because the lines begin with # was eaten by git.
> 
>  include/asm-generic/pgalloc.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..706e87b43b19 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -18,8 +18,7 @@
>   */
>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  {
> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
> -			~__GFP_HIGHMEM, 0);
> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);

I looked into the history and it seems you are right. This defensive pattern
was likely introduced by Vishal Moola in commit c787ae5[1].

After this cleanup, would it make sense to add a BUILD_BUG_ON() somewhere
to check that __GFP_HIGHMEM is not present in GFP_PGTABLE_KERNEL and
GFP_PGTABLE_USER? This would prevent any future regression ;)

Just a thought ...

[1] https://github.com/torvalds/linux/commit/c787ae5b391496f4f63bc942c18eb9fdee05741f

Cheers,
Lance

>  
>  	if (!ptdesc)
>  		return NULL;
> @@ -172,7 +171,6 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -226,7 +224,6 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -270,7 +267,6 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, order);
>  	if (!ptdesc)

