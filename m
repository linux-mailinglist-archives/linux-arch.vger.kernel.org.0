Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1B4FEBE4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiDMAVY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 20:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDMAVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 20:21:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D33D4B1;
        Tue, 12 Apr 2022 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1Cz3pjY7YWGZgp7PC+MmjSwo+jq8i41FSV3VLd7PWmA=; b=jKoueA3vIBVbIMNC4paBBsssl8
        vRnbKfpWRA6IhPh4mPGpbcSRKafA3BtV3cydmjb+3FUPiC/iQBc97+jV8GzffjT5Xu3WyUg2A64vO
        8RND7/DnVRAPics7QTspLje8T9hD8OK6/LYe0r5t2F4qOqofrtR+/ynC8s1b8JpzlbPUbEVWY6wH/
        m1IO82IZuAFnWU4aeWOig+BpWErpUlUcI4PIYpDNJ8V7yCKv5JosVRpW9+nuRHHx2AWE3jfF1KDkP
        D7iYUeHCY25etWJ841FmCYOXLVFv/W1uyN2kS/g3DvGEr66+4GMvf7ZGiiHkSjTqeUuwvp1V/iGSZ
        zIfC3DmQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neQih-00Do0t-8D; Wed, 13 Apr 2022 00:18:51 +0000
Message-ID: <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
Date:   Tue, 12 Apr 2022 17:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Libo Chen <libo.chen@oracle.com>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220412231508.32629-2-libo.chen@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi--

On 4/12/22 16:15, Libo Chen wrote:
> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
> make a lot of sense nowaday. Even the original patch dating back to 2008,
> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
> rationale for such dependency.
> 
> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
> There is no reason other architectures cannot given the fact that they
> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
> x86.
> 
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..7209039dfb59 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>  	bool
>  
>  config CPUMASK_OFFSTACK
> -	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS

This "if" dependency only controls whether the Kconfig symbol's prompt is
displayed (presented) in kconfig tools. Removing it makes the prompt always
be displayed.

Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
of DEBUG_PER_CPU_MAPS.

Is there another problem here?

> +	bool "Force CPU masks off stack"
>  	help
>  	  Use dynamic allocation for cpumask_var_t, instead of putting
>  	  them on the stack.  This is a bit more expensive, but avoids

-- 
~Randy
