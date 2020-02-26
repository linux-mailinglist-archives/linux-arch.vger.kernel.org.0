Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0920C170AAF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 22:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBZVmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 16:42:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46618 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgBZVmE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 16:42:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so285118pga.13
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMs6CM+hK6aKdC1S/oL5Dxo9YOdRorQKtX4mbGWHNSk=;
        b=CU1gKkU3xVHYfQWJJENAudAyAiPTUD9x0S1kT0iOTLbD28SlxzNGyC/Pjw96hdP+Ic
         KYiXd/ZyZjzG/MAgYZfYLykdQEZCv52NwiDmvuSsSwe5Lz0GvhE9KWl1U6RevuNcNG/3
         Yu6+M1GqnsTAvu1IQig3Cvlyxb/ZJgDUzh5tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMs6CM+hK6aKdC1S/oL5Dxo9YOdRorQKtX4mbGWHNSk=;
        b=KKHZ9mkgFGgDtrIWaM9xtXNG4b111U9KGeL2xnhnFkt3nXIvdIN5ApxUF5J+lDyZfh
         dqehgRYNAPW5f/1MknoAgFxdUOiIVP5M3/DH9FV6cSaeJUUhQEhhB1W3F1lhkV+iGPUX
         gA+uCdn1ZXvVc01ikGervzFpYxHpT+cWoaeGXtLB6JJMZNtKTybZzG2p7SGrJp1TF+lj
         MYgG22dFZimLxWcklJJ7ZmqNH6MhqB6IMSnj2efSS2f8Oa8ACGtDPhxnZjFVXA1cs+ys
         MA4B4nFQ2q9FosI71tM1Tm82HVt0daQEZKbjBpoW1qRkcrNvrZvc350agEztdB2XIzkT
         aEyQ==
X-Gm-Message-State: APjAAAVTc1ura4zladq9rfKmPuoiTA9pHkjYpXG1nk5RE0atPDdzvKY8
        Suaf+mS3M+lnAd8FWjO77aNMPA==
X-Google-Smtp-Source: APXvYqwNJNZWiE0vCSozBBya4T8gbUsaluXQ146HDDTof3lcBkuezuHeqc1lwfvZRCtbqCDz6bE47w==
X-Received: by 2002:a62:f842:: with SMTP id c2mr746353pfm.104.1582753323721;
        Wed, 26 Feb 2020 13:42:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11sm3814980pjn.2.2020.02.26.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:42:02 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:42:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 06/11] arm64: BTI: Decode BYTPE bits when printing
 PSTATE
Message-ID: <202002261341.D2BB57A@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-7-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-7-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:09PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> The current code to print PSTATE symbolically when generating
> backtraces etc., does not include the BYTPE field used by Branch
> Target Identification.
> 
> So, decode BYTPE and print it too.
> 
> In the interests of human-readability, print the classes of BTI
> matched.  The symbolic notation, BYTPE (PSTATE[11:10]) and
> permitted classes of subsequent instruction are:
> 
>     -- (BTYPE=0b00): any insn
>     jc (BTYPE=0b01): BTI jc, BTI j, BTI c, PACIxSP
>     -c (BYTPE=0b10): BTI jc, BTI c, PACIxSP
>     j- (BTYPE=0b11): BTI jc, BTI j
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index b8e3faa8d406..24af13d7bde6 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -211,6 +211,15 @@ void machine_restart(char *cmd)
>  	while (1);
>  }
>  
> +#define bstr(suffix, str) [PSR_BTYPE_ ## suffix >> PSR_BTYPE_SHIFT] = str
> +static const char *const btypes[] = {
> +	bstr(NONE, "--"),
> +	bstr(  JC, "jc"),
> +	bstr(   C, "-c"),
> +	bstr(  J , "j-")
> +};
> +#undef bstr
> +
>  static void print_pstate(struct pt_regs *regs)
>  {
>  	u64 pstate = regs->pstate;
> @@ -229,7 +238,10 @@ static void print_pstate(struct pt_regs *regs)
>  			pstate & PSR_AA32_I_BIT ? 'I' : 'i',
>  			pstate & PSR_AA32_F_BIT ? 'F' : 'f');
>  	} else {
> -		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
> +		const char *btype_str = btypes[(pstate & PSR_BTYPE_MASK) >>
> +					       PSR_BTYPE_SHIFT];
> +
> +		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO BTYPE=%s)\n",
>  			pstate,
>  			pstate & PSR_N_BIT ? 'N' : 'n',
>  			pstate & PSR_Z_BIT ? 'Z' : 'z',
> @@ -240,7 +252,8 @@ static void print_pstate(struct pt_regs *regs)
>  			pstate & PSR_I_BIT ? 'I' : 'i',
>  			pstate & PSR_F_BIT ? 'F' : 'f',
>  			pstate & PSR_PAN_BIT ? '+' : '-',
> -			pstate & PSR_UAO_BIT ? '+' : '-');
> +			pstate & PSR_UAO_BIT ? '+' : '-',
> +			btype_str);
>  	}
>  }
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
