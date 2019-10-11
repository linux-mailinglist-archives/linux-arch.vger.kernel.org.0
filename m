Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAED4447
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfJKPbH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:31:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35647 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfJKPbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 11:31:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id r134so3625832ywg.2
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mxX6ZfMEu9UblL7e3DTkotuZrSFsmDbCoebjzwcL8h0=;
        b=ufYqM9IQiYWJXmizW9EncXRMAuDKV9ixLq/HSNFNpNZkGyWPmgPmKChqyOWtlvaJz2
         g171+ritEahrlLdJp1/aQUN77kRibcDDDwNCbo1kCC7dMbYiIJm8FjDvrXt0BigYOpqM
         vxCWKhAfox0ET7SmICRFSnzf1UwkwSa/pULtSsJlSPL1imZcNtZ2ZxNcvzlubz3Fio+i
         Z0+zDzeaG/fXw9rtujEMs1vg88g+XvC0vcVF7sOA8Flf5dsgLysz9Xi/cfy0IzepX0wX
         tZ7vvGrcZJ6cA8xJ5YMjLE1j0APNWiCpGkJ7Ter0ruivx4Mva/2M1NJ4EF66JZS06BLC
         4/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mxX6ZfMEu9UblL7e3DTkotuZrSFsmDbCoebjzwcL8h0=;
        b=kx4/jOQDLqcG3lPGLpLZDezasIGOqvKmX65jH5+d0HugC+jXNkzXchS/KSmpJJjgtW
         Og+3ZxgYMJ7WhA54jcCb9Z4O8bfAE1fXKDGsPMYNi1/i/UdFiVRYuhzw8UTrEZNMV8/9
         xux/UXVqsKxaAFi/y059A1xDFnmWqq2PBOfT2Y6gHFwBhiTM1RmrbocZQ10YEUpZraen
         p7czvzudBvb5o1M3PCYT592tOEGKpIKyu2e8tDNdHycv1QbSPsg/ltLGutp6+w/yy5UM
         AjvLFvTZlq5pELZIVlRU4YM/rNDUwJHWw5wTiQVxh9zcf8rzV32YUhyQ8w1ioeQc/MSi
         NZTg==
X-Gm-Message-State: APjAAAXKAMVpFA52ylp9P0s0RrGbe6cEUucXJmGzhaD2bZ3xRl7HkBPR
        GwdAWqy0WzEGt0+mwPz8m8mQgw==
X-Google-Smtp-Source: APXvYqz6suOMvjy8hdUWKuD9/89Nspymjqm4b1UZYQ8wE1NHnKF8NkD1PtR18YIcumQ9lLTUYrRm2w==
X-Received: by 2002:a81:a30d:: with SMTP id a13mr2662067ywh.278.1570807865387;
        Fri, 11 Oct 2019 08:31:05 -0700 (PDT)
Received: from [192.168.1.44] (67.216.151.25.pool.hargray.net. [67.216.151.25])
        by smtp.gmail.com with ESMTPSA id d63sm2313883ywe.55.2019.10.11.08.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 08:31:04 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] arm64: BTI: Decode BYTPE bits when printing
 PSTATE
To:     Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <18c9318c-d122-b534-b526-318935d9e2cc@linaro.org>
Date:   Fri, 11 Oct 2019 11:31:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/10/19 2:44 PM, Dave Martin wrote:
>  #define PSR_IL_BIT		(1 << 20)
> -#define PSR_BTYPE_CALL		(2 << PSR_BTYPE_SHIFT)
> +
> +/* Convenience names for the values of PSTATE.BTYPE */
> +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)

It'd be nice to sort this patch earlier, so that ...

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a3bd32..452ac5b 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -732,7 +732,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  
>  	if (system_supports_bti()) {
>  		regs->pstate &= ~PSR_BTYPE_MASK;
> -		regs->pstate |= PSR_BTYPE_CALL;
> +		regs->pstate |= PSR_BTYPE_C;
>  	}
>  
>  	if (ka->sa.sa_flags & SA_RESTORER)

... setup_return does not need to be adjusted a second time.

I don't see any other conflicts vs patch 5.


r~
