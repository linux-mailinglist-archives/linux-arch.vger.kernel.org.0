Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4881207B97
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405914AbgFXSdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405820AbgFXSdJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:33:09 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7598820738;
        Wed, 24 Jun 2020 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593023588;
        bh=EiMO72eDpdKXWS6Tvej3pkFu8M9hxYW+MQgO4jUfBbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bh9ABLGaUhujAR3M9Ke47tCxbYeH0Sw4aC0Ka1fMN2nxyRMo37M8av85ngm12i5Iu
         Wfzzo1P5nkIMiYT/9bB0qPGr0iWcm613AtvRkpTfzmb86A4FH1YS+OpAkc/kCaGM1D
         SJVGiQua+41yZ2bcbdsvS3XS7Xq91WPbUIUN1k8w=
Date:   Wed, 24 Jun 2020 11:33:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 06/25] mm: Add PG_ARCH_2 page flag
Message-Id: <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
In-Reply-To: <20200624175244.25837-7-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
        <20200624175244.25837-7-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 18:52:25 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> For arm64 MTE support it is necessary to be able to mark pages that
> contain user space visible tags that will need to be saved/restored e.g.
> when swapped out.
> 
> To support this add a new arch specific flag (PG_ARCH_2) that arch code
> can opt into using ARCH_USES_PG_ARCH_2.
> 
> ...
>
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
>  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
>  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
>  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> +#endif

Do we need CONFIG_ARCH_USES_PG_ARCH_2?  What would be the downside to
giving every architecture a PG_arch_2, but only arm64 uses it (at
present)?

