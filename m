Return-Path: <linux-arch+bounces-12798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B04B06E0F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509663B39A2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3DD2877D8;
	Wed, 16 Jul 2025 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+jkV3Mw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0028688E;
	Wed, 16 Jul 2025 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647788; cv=none; b=W4uwgSXZFtG1VxiKns8KVn1tRLZZ1bDu7OUU7xv2ulSzb5yDlQREF3TRwBgwjPbdI+c9AV3gIRGjZVsDjNuqA8oMc67cfw4/11zKFd2X9qXiyUPcodxRKgWP/iDcj62hro7c+6z492gm+SZ1zvpVgsJgSCMMqLyywoEQEX/U1yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647788; c=relaxed/simple;
	bh=IIT1xDly5XiLWWy6yF/5OPem42SSOoCdInssOEVkt+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfNamAEXnaJXQdLQuDs8XhrFVwPzoI46tZmmHA6mHyZo1fl8253VRo2Sz9w9mHnyp48C1QAgJloxyG2NFC7RWEBJkxQPT3+WKaZMRhqVBjMx0z55EZwvGy4+5hA7VzaZxylb1mm1TDN1fPmbovgcuZjcdx54KAuQMcPGOnvs2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+jkV3Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF115C4CEF0;
	Wed, 16 Jul 2025 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752647788;
	bh=IIT1xDly5XiLWWy6yF/5OPem42SSOoCdInssOEVkt+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+jkV3Mw2Ejpjw+53TaC+3JmhqsqPvOBAx9qubzRyUGzLUW5JcTpEPYXbu2QuLSOc
	 IUpmUYv6ID5a/Y+/m6fGCtP/yfvsvbvr6ipJLJJNwvmfgTridqLSaWnIIExVccTKop
	 1vP/5W24fER1YG0HAqVGKCULOSCJ+XZs7cgXU55BkPgOv6jm6JhUdsfZSrDAsAtoqp
	 h0pgwgV3hqvQ1OrkTpq6pPSC6DkuWrb0CrkPUz1ElQ92TFCscQ+Y43i7tWcncVvxCs
	 UWRPkfJomk+fhqpe+1rk5ro1SEpw/SNft9nQEFrJqjIi0Lb7EzDcPF6N+WnGKBcikt
	 3pQIuvUiQ0U6g==
Date: Wed, 16 Jul 2025 09:36:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
	muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, linux-mm@kvack.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexghiti@rivosinc.com, agordeev@linux.ibm.com,
	anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
	ryan.roberts@arm.com, will@kernel.org
Subject: Re: [PATCH 0/3] drop hugetlb_free_pgd_range()
Message-ID: <aHdIYXvppA6RKxic@kernel.org>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716012611.10369-1-anthony.yznaga@oracle.com>

On Tue, Jul 15, 2025 at 06:26:08PM -0700, Anthony Yznaga wrote:
> For all architectures that support hugetlb except for sparc,
> hugetlb_free_pgd_range() just calls free_pgd_range(). It turns out
> the sparc implementation is essentially identical to free_pgd_range()
> and can be removed. Remove it and update free_pgtables() to treat
> hugetlb VMAs the same as others.
> 
> Anthony Yznaga (3):
>   sparc64: remove hugetlb_free_pgd_range()
>   mm: remove call to hugetlb_free_pgd_range()
>   mm: drop hugetlb_free_pgd_range()

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/sparc/include/asm/hugetlb.h |   5 --
>  arch/sparc/mm/hugetlbpage.c      | 119 -------------------------------
>  include/asm-generic/hugetlb.h    |   9 ---
>  include/linux/hugetlb.h          |   7 --
>  mm/memory.c                      |  42 +++++------
>  5 files changed, 18 insertions(+), 164 deletions(-)
> 
> -- 
> 2.47.1
> 

-- 
Sincerely yours,
Mike.

