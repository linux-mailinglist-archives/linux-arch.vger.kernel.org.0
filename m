Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03E325129
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBYOC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 09:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBYOCx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Feb 2021 09:02:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB72664F11;
        Thu, 25 Feb 2021 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614261732;
        bh=218syAtxT4zx3HGAu9Wl85gzsByTob2ufpdJw7lYcrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ec68jktne3YuJIrm7fi+NhV7SBpTe13byIL7GY/2iuClUrX7kSUgcEYz34SdnnTCP
         7Y7nF04RLJloZp1nmg+uITKuUHzw4yDw37IDQuVDKO1PTr2CZjVVIZOhd0HA4CRCTW
         3sHtd+W6UC8pN8EfCctI7Y3Py3QKGsADTqvXrwGOI9FhTFNtXWzpILIO8Ey2Z3giWD
         mN/kGEOs8TAea0rUxGibeo+gJdjwSWJYvU9lfjaLtH3epvBr3hGf+xrZdAZiWi69m9
         hReIb1+wMoi+EcrbYSlHJ7qHSKn1IJEYZPtSKaKUswk+5OVsxs8u6iJaUnyw1/Omn3
         Kz4FV4lXDGl3Q==
Date:   Thu, 25 Feb 2021 14:02:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] ARM64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210225140205.GA13297@willie-the-truck>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
 <20210225135700.1381396-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225135700.1381396-2-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 25, 2021 at 05:56:59AM -0800, Yury Norov wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 31bd885b79eb..5596eab04092 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -108,6 +108,7 @@ config ARM64
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_IPI
>  	select GENERIC_IRQ_MULTI_HANDLER

Acked-by: Will Deacon <will@kernel.org>

Catalin can pick this up later in the cycle.

Will
