Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32CB24E1F6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgHUUPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 16:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUPY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 16:15:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7D820738;
        Fri, 21 Aug 2020 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598040923;
        bh=/T7D++jQJVYAEaRhehB6OXQudUAED1x+6RQtwjpgepM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oskdNenPwocChae4HFuF7bNEbcd6pqb+OlqWuz9XE4T4ExAobZJPQ+Vv46iy4oJdJ
         oXZ5UgEOsQ9iMg+gIaCRVB3NH/LeXX5fSGqlllwM6nWkPLGW1EIkJD68mjCC8Opx/j
         cXUc7Nleu7OIBwWugqQCCej8//v19BgSMb5VLM1Q=
Date:   Fri, 21 Aug 2020 13:15:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 06/12] powerpc: inline huge vmap supported functions
Message-Id: <20200821131522.c819f9c5c1fc24d90244c6dd@linux-foundation.org>
In-Reply-To: <20200821151216.1005117-7-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
        <20200821151216.1005117-7-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 22 Aug 2020 01:12:10 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -bool arch_vmap_p4d_supported(pgprot_t prot);
> -bool arch_vmap_pud_supported(pgprot_t prot);
> -bool arch_vmap_pmd_supported(pgprot_t prot);
> +static inline bool arch_vmap_p4d_supported(pgprot_t prot)
> +{
> +	return false;
> +}
> +
> +static inline bool arch_vmap_pud_supported(pgprot_t prot)
> +{
> +	/* HPT does not cope with large pages in the vmalloc area */
> +	return radix_enabled();
> +}
> +
> +static inline bool arch_vmap_pmd_supported(pgprot_t prot)
> +{
> +	return radix_enabled();
> +}
>  #endif

Oh.  OK, whatever ;)
