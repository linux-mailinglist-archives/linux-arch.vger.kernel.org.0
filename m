Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9963191B7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Feb 2021 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBKR6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Feb 2021 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBKR4P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Feb 2021 12:56:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2852C0613D6
        for <linux-arch@vger.kernel.org>; Thu, 11 Feb 2021 09:55:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lg21so11413996ejb.3
        for <linux-arch@vger.kernel.org>; Thu, 11 Feb 2021 09:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pCiUpeBCgfpgLcOixXyMaSRCIE6sLsL8S3aPB3A1Nk=;
        b=HeDif2XiXW0gIR/nSH+Ff81eWsT3unuN2il6MYQENm81dIPu9ZEv6DQmXsFiyarW/E
         UuqRHRgndgNesCGAh8GQufF7YugahdZzCsyolVu5QT91ej07R7ArAlltahenuFa+nTqy
         k/DOxllhUSBqR4lDuj9WMVOSylyiqNLGaJl3WyzfEQn2Ftm3/iwKJJbq2UWq6cPcuFR7
         IppSm9OAh0K+8VIl12BFYndJOqLCCxFfDtax1enQaA0+vTVkkJTS3nyCVCT7NUebJkcT
         wtmBhfUWrdhT3RadOSwxiRUvvzfV4A+3K9cyg2HFrOYoGeEt86IckSeDieAvdUMZOCw+
         uzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pCiUpeBCgfpgLcOixXyMaSRCIE6sLsL8S3aPB3A1Nk=;
        b=YrcV3fmi4Ux4bh5qqZfW1XFyuP34SwULI0r0yfRTeJQu3ASzmXGuEX7Rt1c0Web10f
         KHZj6mKtXN3heSkosQNtC4LgStBzMd+wD6rLpleXgIVaP9qJSxtLeM+ZONQK/n7qMj4W
         8ICS5PBGix86mOIyBeiQMvS0tc4zJPl0sOsCbKwJ8JM8b4ApLcEhU9AyPrLhpo6eslNU
         SQWaOL2GQ4jtrZvCU/ve4/tKyPqLfeyNaJsEUKBt7kr1sx55qds+tD4PTmP2ph8trEum
         FRDctxAfihgs2bLT4sbK7HMVlrofZHK7RYyrLTxpuiXALZdw9IACOq9nwX6+MGZ/7ZZI
         5BAQ==
X-Gm-Message-State: AOAM532iwDs5GDFN3MY0CJmvUysCyNFfupBe5vkFpFEfu5b2kAZNxe95
        ac9urL/Bb6jJW1vSTkqt1100wg==
X-Google-Smtp-Source: ABdhPJwQdtfNm5nZvjceAOzmmGCdMaSZl/CqH6DTGxgPqq7Z4GkOwRqQmeBrzORpe/zl38s7IazJkA==
X-Received: by 2002:a17:906:184e:: with SMTP id w14mr9887272eje.56.1613066132520;
        Thu, 11 Feb 2021 09:55:32 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g16sm4884187ejo.107.2021.02.11.09.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 09:55:31 -0800 (PST)
Subject: Re: [PATCH 4/4] microblaze: Remove support for gcc < 4
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210210141140.1506212-1-geert+renesas@glider.be>
 <20210210141140.1506212-5-geert+renesas@glider.be>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <1b072177-e212-67ce-7d72-c3d526a480f9@monstr.eu>
Date:   Thu, 11 Feb 2021 18:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210210141140.1506212-5-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/10/21 3:11 PM, Geert Uytterhoeven wrote:
> Since commit cafa0010cd51fb71 ("Raise the minimum required gcc version
> to 4.6") , the kernel can no longer be compiled using gcc-3.
> Hence drop support code for gcc-3.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/microblaze/kernel/module.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/module.c b/arch/microblaze/kernel/module.c
> index 9f12e3c2bb42a319..e5db3a57b9e30d9e 100644
> --- a/arch/microblaze/kernel/module.c
> +++ b/arch/microblaze/kernel/module.c
> @@ -24,9 +24,6 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
>  	Elf32_Sym *sym;
>  	unsigned long int *location;
>  	unsigned long int value;
> -#if __GNUC__ < 4
> -	unsigned long int old_value;
> -#endif
>  
>  	pr_debug("Applying add relocation section %u to %u\n",
>  		relsec, sechdrs[relsec].sh_info);
> @@ -49,40 +46,17 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
>  		 */
>  
>  		case R_MICROBLAZE_32:
> -#if __GNUC__ < 4
> -			old_value = *location;
> -			*location = value + old_value;
> -
> -			pr_debug("R_MICROBLAZE_32 (%08lx->%08lx)\n",
> -				old_value, value);
> -#else
>  			*location = value;
> -#endif
>  			break;
>  
>  		case R_MICROBLAZE_64:
> -#if __GNUC__ < 4
> -			/* Split relocs only required/used pre gcc4.1.1 */
> -			old_value = ((location[0] & 0x0000FFFF) << 16) |
> -					(location[1] & 0x0000FFFF);
> -			value += old_value;
> -#endif
>  			location[0] = (location[0] & 0xFFFF0000) |
>  					(value >> 16);
>  			location[1] = (location[1] & 0xFFFF0000) |
>  					(value & 0xFFFF);
> -#if __GNUC__ < 4
> -			pr_debug("R_MICROBLAZE_64 (%08lx->%08lx)\n",
> -				old_value, value);
> -#endif
>  			break;
>  
>  		case R_MICROBLAZE_64_PCREL:
> -#if __GNUC__ < 4
> -			old_value = (location[0] & 0xFFFF) << 16 |
> -				(location[1] & 0xFFFF);
> -			value -= old_value;
> -#endif
>  			value -= (unsigned long int)(location) + 4;
>  			location[0] = (location[0] & 0xFFFF0000) |
>  					(value >> 16);
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


