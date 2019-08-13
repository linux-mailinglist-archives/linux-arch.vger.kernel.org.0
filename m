Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092068C051
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 20:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHMSQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 14:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfHMSQo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 14:16:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4810C20665;
        Tue, 13 Aug 2019 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565720202;
        bh=ppbLRbeVVjSaqCpvUMKl5GQoiS9vv/44Sdhkt7yQd3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvP+S7VM9MT3Wrjtlkc5hTQ6vK5t0nvysuWbLQoHGxlVTugb2KvsmurkwoAGoA41R
         jH6Eb6sVSpJF70TGAZaAaQ38Dt6KuD6oyWcDMpzW8pJ3He2oTfQAHviZzt3V6DNvg4
         2LZQbZbzZqm1mkIZMCps2U4Vfi7zYnp3GZzI+Uko=
Date:   Tue, 13 Aug 2019 20:16:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 06/10] export: allow definition default namespaces in
 Makefiles or sources
Message-ID: <20190813181640.GD2378@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-7-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-7-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:03PM +0100, Matthias Maennich wrote:
> To avoid excessive usage of EXPORT_SYMBOL_NS(sym, MY_NAMESPACE), where
> MY_NAMESPACE will always be the namespace we are exporting to, allow
> exporting all definitions of EXPORT_SYMBOL() and friends by defining
> DEFAULT_SYMBOL_NAMESPACE.
> 
> For example, to export all symbols defined in usb-common into the
> namespace USB_COMMON, add a line like this to drivers/usb/common/Makefile:
> 
>   ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_COMMON
> 
> That is equivalent to changing all EXPORT_SYMBOL(sym) definitions to
> EXPORT_SYMBOL_NS(sym, USB_COMMON). Subsequently all symbol namespaces
> functionality will apply.
> 
> Another way of making use of this feature is to define the namespace
> within source or header files similar to how TRACE_SYSTEM defines are
> used:
>   #undef DEFAULT_SYMBOL_NAMESPACE
>   #define DEFAULT_SYMBOL_NAMESPACE USB_COMMON
> 
> Please note that, as opposed to TRACE_SYSTEM, DEFAULT_SYMBOL_NAMESPACE
> has to be defined before including include/linux/export.h.
> 
> If DEFAULT_SYMBOL_NAMESPACE is defined, a symbol can still be exported
> to another namespace by using EXPORT_SYMBOL_NS() and friends with
> explicitly specifying the namespace.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  include/linux/export.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 8e12e05444d1..1fb243abdbc4 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -166,6 +166,12 @@ struct kernel_symbol {
>  #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
>  #endif
>  
> +#ifdef DEFAULT_SYMBOL_NAMESPACE
> +#undef __EXPORT_SYMBOL
> +#define __EXPORT_SYMBOL(sym, sec)				\
> +	__EXPORT_SYMBOL_NS(sym, sec, DEFAULT_SYMBOL_NAMESPACE)
> +#endif
> +
>  #define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
>  #define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
>  #define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
