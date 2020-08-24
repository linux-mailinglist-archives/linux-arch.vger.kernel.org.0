Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17639250693
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHXRe4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgHXRep (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:34:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E062067C;
        Mon, 24 Aug 2020 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598290484;
        bh=mu/8EYgOWWMMFVzYggJY3VT5p7NWhR3sCJgvxOn1cR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9po9+1pECMI6iXfro2djH7yNO63Zf3WPyGTSHuQJvh58INJvJSMaD9kVAqGR/6mS
         HATHe2IIR9z8hxM+5OkGCK26YmpZBSioCO+bD/UKz+K47SH/DI5F6aLkTem5p91EdX
         HzkSnV1f1I2pZP+5+O9p1yrK6x7a0kUgqqSizc8E=
Date:   Mon, 24 Aug 2020 19:35:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, wei.liu@kernel.org,
        vkuznets@redhat.com, kys@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: Re: [PATCH v7 09/10] arm64: efi: Export screen_info
Message-ID: <20200824173502.GA1161855@kroah.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 09:46:22AM -0700, Michael Kelley wrote:
> The Hyper-V frame buffer driver may be built as a module, and
> it needs access to screen_info. So export screen_info.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/kernel/efi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index d0cf596..8ff557a 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
>  
>  /* we will fill this structure from the stub, so don't put it in .bss */
>  struct screen_info screen_info __section(.data);
> +EXPORT_SYMBOL(screen_info);

EXPORT_SYMBOL_GPL()?

I have to ask :)

thanks,

greg k-h
