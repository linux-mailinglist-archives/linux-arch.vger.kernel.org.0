Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88400C2F88
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfJAJED (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 05:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733273AbfJAJED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Oct 2019 05:04:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2370821872;
        Tue,  1 Oct 2019 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569920642;
        bh=ATnyEFPDPF0YF2jKwwMipduqmTRVvuPs9YSLpUGcY1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2Bouksca4/Ysk5lJ7WWmFPnxcT3xv7UFw5yLaQ6XaZLpDW4shGpVV1cbBrIufFvS
         6G73iE8E37vEYzs8FKpN4ItDwwuuQMYS8tsa0Q5eVhMYrH/69oeEWI17IWCFoIt1EW
         Qo7/75w2RFkOYv3E5+EZepM3CPEZu4zv2gF9FNu4=
Date:   Tue, 1 Oct 2019 10:03:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/29] arm64: Move EXCEPTION_TABLE to RO_DATA segment
Message-ID: <20191001090355.blnaqlf4rfzucpb2@willie-the-truck>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-19-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926175602.33098-19-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kees,

On Thu, Sep 26, 2019 at 10:55:51AM -0700, Kees Cook wrote:
> The EXCEPTION_TABLE is read-only, so collapse it into RO_DATA.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 81d94e371c95..c6ba2eee0ee8 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -5,6 +5,8 @@
>   * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
>   */
>  
> +#define RO_DATA_EXCEPTION_TABLE_ALIGN	8
> +
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/kernel-pgtable.h>
> @@ -135,8 +137,8 @@ SECTIONS
>  	. = ALIGN(SEGMENT_ALIGN);
>  	_etext = .;			/* End of text section */
>  
> -	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
> -	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
> +	/* everything from this point to __init_begin will be marked RO NX */
> +	RO_DATA(PAGE_SIZE)
>  
>  	. = ALIGN(PAGE_SIZE);

Do you reckon it would be worth merging this last ALIGN directive into the
RO_DATA definition too? Given that we want to map the thing read-only, it
really has to be aligned either side.

Anyway, that's only a nit, so:

Acked-by: Will Deacon <will@kernel.org>

Will

P.S. Please CC the arm64 maintainers on arm64 patches -- I nearly missed
this one!
