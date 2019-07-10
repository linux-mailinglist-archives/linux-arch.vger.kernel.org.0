Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2064B09
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfGJQ44 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 12:56:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50260 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfGJQ44 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 12:56:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so3041038wml.0;
        Wed, 10 Jul 2019 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7OwvYhB15aIMvo/DzgqTZyHfK2iyk2Ozeap178Si5cc=;
        b=fF4+44OiqYPDLpiMhDd8uRC81fZ+5ZiTlL8IYEnymiVPLjDQK1feNJAv4DvCgWujg/
         Dtld9lq52t0/fGN+oXZ7AflJPZuAJvgF2fg1UuBiciR0ko37nM/9QQUdnMDobkcM0d5O
         F+Daz1XqOp7PFE98PLoRu57txu1Voa7s07Sde+AIjohwN3FF4tJTFLap6zQVzrFELqrX
         L1CctMo/eXdVaidD6gtjUYn2sYwcrWkuoCvnHI34rxfypgfpS5y7lYp4tyBJrC3nYtjQ
         Z27nSQfFdfcjcxCcDOuX4lfXsjWeP6T/GnpqkUD3OusK22W5xzG48iH+cMSN1eYfNxw2
         c5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OwvYhB15aIMvo/DzgqTZyHfK2iyk2Ozeap178Si5cc=;
        b=aRwyRHz7ksw91iWpr8kFYmUOQ5vk3WmESw0VMK3vOPwrqtWOSCRFlt/6ns/r6GN01h
         Su07+EZ9QCWE2mtn4B4SrKVTLxCB8Wi+sW/Fmmo4cgPZqY1OiU2XUYV/0P1ssvnO4Z/l
         5ptI8biZLNbKNG/my/e5TxX4WLBv328dimDx7ekL2FD1P+61WZktJdBhRYLt3NkIDUAz
         +CJv4xVf5Ona1WR1LsU6IG3qIIb/3J6jfYRMBXQtMGJ6P3S0xskwkbExE2e2Cwf6DUgW
         muV4iI/Q/ajx3WypeEoM1A7oCg6YO/NB5fZnUmd5H8amdUc8bWG9/gW8gIhmJZse1Qr9
         IXRQ==
X-Gm-Message-State: APjAAAXg30X+RIkiO3nt3gKAnb1J9/+E+OkjZawDViBv5cNBkWlH/OdO
        pWpDKl6Z0w/yFTSdN5pCCFI=
X-Google-Smtp-Source: APXvYqxYbymgnQTtkuBAonwUEvUE2MH+9+rn1rpzlqSEVDTpmHe1buRlfNK4vNYxBPWpVLMx3aTOzA==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr6023248wmm.83.1562777813579;
        Wed, 10 Jul 2019 09:56:53 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id e5sm2553928wro.41.2019.07.10.09.56.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:56:52 -0700 (PDT)
Date:   Wed, 10 Jul 2019 09:56:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
Message-ID: <20190710165651.GA29814@archlinux-threadripper>
References: <20190710130206.1670830-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710130206.1670830-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 10, 2019 at 03:01:53PM +0200, Arnd Bergmann wrote:
> On 32-bit x86 when building with clang-9, the loop gets turned back into
> an inefficient division that causes a link error:
> 
> kernel/time/vsyscall.o: In function `update_vsyscall':
> vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'
> 
> Use the provided __iter_div_u64_rem() function that is meant to address
> the same case in other files.
> 
> Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/time/vsyscall.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index a80893180826..8cf3596a4ce6 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
>  	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
>  	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>  	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
> -	while (nsec >= NSEC_PER_SEC) {
> -		nsec = nsec - NSEC_PER_SEC;
> -		vdso_ts->sec++;
> -	}
> -	vdso_ts->nsec	= nsec;
> +	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
>  
>  	if (__arch_use_vsyscall(vdata))
>  		update_vdso_data(vdata, tk);
> -- 
> 2.20.0
> 

What an interesting function. Looks good to me and I can confirm it
fixes the link error.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
