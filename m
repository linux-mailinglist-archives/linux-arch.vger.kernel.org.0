Return-Path: <linux-arch+bounces-13138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00BB22DD0
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 18:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5A9562204
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF232F8BDD;
	Tue, 12 Aug 2025 16:29:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36A2F83B0;
	Tue, 12 Aug 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016164; cv=none; b=kCee9Whno7skzW2qx0z+33w2ja1041hrN5kps/e6+PcnoSO06lobZ79ZASSts8CqhnF5XIit4CMO5Ct3Oj8jmUmq0/fIKMc5Ypi+9hHYrSaaKYNSdulNE3A03GCqoh5uP5j5nsMArysOb94x2VamV554WicQ1vV3qzQKbHi6Ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016164; c=relaxed/simple;
	bh=E5FFVbeyuoL91fZs6JxyY6XKwmihYtlLtav+5KQ8T4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUGqAWwZNi3jQUegZS3RqJzD6ibq+Jo5jzJ0dpzxHGgXWauo1TaP11EE6PPfOn1CuBGFBeGlIvGK3L2uuPaq/MM87eWbKJ/+CRMwBWnF0xCwpfPuFQtW/94p7fiyViOXTpE4vg2UxM8dYZcJpbCaNCN2kL4eDWR6WiHfIIvkrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43F5C4CEF6;
	Tue, 12 Aug 2025 16:29:21 +0000 (UTC)
Date: Tue, 12 Aug 2025 17:29:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
Message-ID: <aJtr38x3A1o1Q7dH@arm.com>
References: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>

On Tue, Aug 12, 2025 at 01:14:19PM +0200, Christophe Leroy wrote:
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
>  arch/arm64/include/asm/pgtable.h    | 1 +
>  arch/riscv/include/asm/pgtable-32.h | 5 +++++
>  include/asm-generic/pgtable-nopmd.h | 1 -
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index abd2dee416b3b..fef7cc7a340d8 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -955,6 +955,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
>  
>  #define pud_valid(pud)		false
>  #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
> +#define pud_user		false /* Always 0 with folding */

Doesn't pud_user take an argument? With that fixed:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(strangely I couldn't get the build to fail without a pud_user
definition, even with the PGTABLE_LEVELS=2 and PAGE_TABLE_CHECK=y
configuration)

