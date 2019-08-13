Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E698C058
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 20:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfHMSRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 14:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfHMSRh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 14:17:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0162120665;
        Tue, 13 Aug 2019 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565720256;
        bh=ODQ3g1b+4WWI1Y+sTyjeEEkmXSZ1vLnLLfxKPgIj4TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRGQXroQxcAhJdNbVGc99NxIL4lFjPcDg7ibmGCnDdWLTD7m1RB9aSseD0XA2LN2J
         42UcYahiZr8oXQoCdQPAaxGef5rdIp2ctdXDRxPTaQg/yRhxbHnE3uYBISvvSAfvki
         0po/OvyYWIG3OJdzzVccC86G+t2vsNwWD7yaNH2Q=
Date:   Tue, 13 Aug 2019 20:17:34 +0200
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
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH v2 05/10] module: add config option
 MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
Message-ID: <20190813181734.GE2378@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-6-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-6-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:17:02PM +0100, Matthias Maennich wrote:
> If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
> requirement for modules to import all namespaces that are used by
> the module is relaxed.
> 
> Enabling this option effectively allows (invalid) modules to be loaded
> while only a warning is emitted.
> 
> Disabling this option keeps the enforcement at module loading time and
> loading is denied if the module's imports are not satisfactory.
> 
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  init/Kconfig    | 14 ++++++++++++++
>  kernel/module.c | 11 +++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index bd7d650d4a99..b3373334cdf1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2119,6 +2119,20 @@ config MODULE_COMPRESS_XZ
>  
>  endchoice
>  
> +config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
> +	bool "Allow loading of modules with missing namespace imports"
> +	default n

the default for config options is always N, no need to list it here.

> +	help
> +	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
> +	  a namespace. A module that makes use of a symbol exported with such a
> +	  namespace is required to import the namespace via MODULE_IMPORT_NS().
> +	  This option relaxes this requirement when loading a module. While
> +	  technically there is no reason to enforce correct namespace imports,
> +	  it creates consistency between symbols defining namespaces and users
> +	  importing namespaces they make use of.
> +
> +	  If unsure, say N.
> +
>  config TRIM_UNUSED_KSYMS
>  	bool "Trim unused exported kernel symbols"
>  	depends on MODULES && !UNUSED_SYMBOLS
> diff --git a/kernel/module.c b/kernel/module.c
> index 57e8253f2251..7c934aaae2d3 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1408,9 +1408,16 @@ static int verify_namespace_is_imported(const struct load_info *info,
>  			imported_namespace = get_next_modinfo(
>  				info, "import_ns", imported_namespace);
>  		}
> -		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
> -		       mod->name, kernel_symbol_name(sym), namespace);
> +#ifdef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
> +		pr_warn(
> +#else
> +		pr_err(
> +#endif
> +			"%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
> +			mod->name, kernel_symbol_name(sym), namespace);
> +#ifndef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
>  		return -EINVAL;
> +#endif

This #ifdef mess is a hack, but oh well :)

If you drop the above default line, feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
