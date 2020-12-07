Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40DD2D0EF9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Dec 2020 12:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLGL0Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 06:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgLGL0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Dec 2020 06:26:15 -0500
Date:   Mon, 7 Dec 2020 11:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607340335;
        bh=tCa+SCe7Tz2pY32ACYBN1TqZqetx06uBL1NMCeLWUZ4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO1t2k18IowPpv2iCVCBshWRF1a4vzde4KtMgs8ydGWAtuVF3pf1r2hNBS+BeFIOI
         6Nh2gDTQ5J+29/yVnmVEgLy3lXoGzzozXzjdPoZ8QnP9bx1xeAoA5hKi+yY0qv/0QZ
         PLos+SmCTZMcDWZLWYs74X0zGOpNAGG2IkxNmV7TFOe8coW0M3f/J9SUBOoZUmgLlk
         MFYmpYwZ3qqk2vUX78qY9TyScLj3mJKqGujU4XKLUo7gK20qG6Rs/8JJUz/N7aO+KN
         3z6QgfEaIz+bNzqqs9L6qQPc8VmUkYiCgO6emc8xdpVOGkCTVB6lh4a2tu/rPU2Y1g
         gC0NEAeaU65Wg==
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] arm64: enable  GENERIC_FIND_FIRST_BIT
Message-ID: <20201207112530.GB4379@willie-the-truck>
References: <20201205165406.108990-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205165406.108990-1-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 05, 2020 at 08:54:06AM -0800, Yury Norov wrote:
> ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> enable it in config. It leads to using find_next_bit() which is less
> efficient:

[...]

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..2b90ef1f548e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -106,6 +106,7 @@ config ARM64
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_FIND_FIRST_BIT

Does this actually make any measurable difference? The disassembly with
or without this is _very_ similar for me (clang 11).

Will
