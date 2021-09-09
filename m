Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6D404C6D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Sep 2021 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhIIL5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Sep 2021 07:57:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33810 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbhIILyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2021 07:54:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98B442237B;
        Thu,  9 Sep 2021 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631188415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQS9ZQeFJQGmX5k5doxlCL9tdEWoOdO3DeKwN1zi5T0=;
        b=00v59IeElg7EiE7DHb1zWtlUZ3YJjEriMz7GShwSI6HjWFzOHS2CdJ7M8fAz9nQNtDDcbs
        J94bvmK7f4pGSSFGQotiPbZkObv+nYsyIAt733HOZLRCX7yJf4RBKu48LKihYPWrZIbBaf
        eTzw669qmbL0RhD8IQ34BLGFO+BFHEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631188415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQS9ZQeFJQGmX5k5doxlCL9tdEWoOdO3DeKwN1zi5T0=;
        b=p8MQdENfUnWaooQFXZj2H0QuLNNlmNpjSCkjq7a3nqRLLVr7DZorlFYl4fe7CAR7GhGKtc
        Yfa5jdGKWMEhqCDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3BD0DA3CFC;
        Thu,  9 Sep 2021 11:53:35 +0000 (UTC)
Date:   Thu, 9 Sep 2021 13:53:35 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
cc:     linux-hardening@vger.kernel.org,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        Marta A Plantykow <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6 kspp-next 16/22] livepatch: only match unique symbols
 when using fgkaslr
In-Reply-To: <20210831144114.154-17-alexandr.lobakin@intel.com>
Message-ID: <alpine.LSU.2.21.2109091347400.20761@pobox.suse.cz>
References: <20210831144114.154-1-alexandr.lobakin@intel.com> <20210831144114.154-17-alexandr.lobakin@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, 31 Aug 2021, Alexander Lobakin wrote:

> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> If any type of function granular randomization is enabled, the sympos
> algorithm will fail, as it will be impossible to resolve symbols when
> there are duplicates using the previous symbol position.
> 
> Override the value of sympos to always be zero if fgkaslr is enabled for
> either the core kernel or modules, forcing the algorithm
> to require that only unique symbols are allowed to be patched.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  kernel/livepatch/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 335d988bd811..852bbfa9da7b 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -169,6 +169,17 @@ static int klp_find_object_symbol(const char *objname, const char *name,
>  	else
>  		kallsyms_on_each_symbol(klp_find_callback, &args);
>  
> +	/*
> +	 * If any type of function granular randomization is enabled, it
> +	 * will be impossible to resolve symbols when there are duplicates
> +	 * using the previous symbol position (i.e. sympos != 0). Override
> +	 * the value of sympos to always be zero in this case. This will
> +	 * force the algorithm to require that only unique symbols are
> +	 * allowed to be patched.
> +	 */
> +	if (IS_ENABLED(CONFIG_FG_KASLR))
> +		sympos = 0;
> +

I ran the live patching tests and no problem occurred, which is great. We 
do not have a test for old_sympos, which makes the testing less telling, 
but at least nothing blows up with the section randomization itself.

However, I want to reiterate what I wrote for the same patch in v5 
series.

The above hunk should work, but I wonder if we should make it more 
explicit. With the change the user will get the error with "unresolvable 
ambiguity for symbol..." if they specify sympos and the symbol is not 
unique. It could confuse them.

So, how about it making it something like

if (IS_ENABLED(CONFIG_FG_KASLR) || IS_ENABLED(CONFIG_MODULE_FG_KASLR))
        if (sympos) {
                pr_err("fgkaslr is enabled, specifying sympos for symbol '%s' in object '%s' does not work.\n",
                        name, objname);
                *addr = 0;
                return -EINVAL;
        }

? (there could be goto to the error out at the end of the function to 
save copy-pasting).

In that case, if sympos is not specified, the user will get the message 
which matches the reality. If the user specifies it, they will get the 
error in case of fgkaslr (no matter if the symbol is found or not).

What do you think?

Miroslav
