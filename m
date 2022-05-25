Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BFC5345AC
	for <lists+linux-arch@lfdr.de>; Wed, 25 May 2022 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiEYVPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 17:15:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D54BA99B;
        Wed, 25 May 2022 14:15:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k186so59055oia.2;
        Wed, 25 May 2022 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CyIVEDRhT/M7EHYfzJq+drDcdbp/lDyRu17RaUijUkM=;
        b=dm3oVIEB25+vDzpB8AA76nAKlTtzq6VJF6QwnO3F+9nfqQn/grLvmiiCBRrr8A35j/
         YwY+O5IBfoLxf6RXdAuQtXpnqQFq9SFOW+EI7EJ3OK56jBl0XaFIbJriNGZ2k+9BU8Fc
         ezHnCF2xD5Y0XLS4fucTTwZxnETqWfX/dUoXl+rgfu0q3xzaEVCHBT1nEI/xdm9+KDKQ
         O9BB5LBs1F7E3J60o5kMhf2pObt2geYeoc3DqEWQ14RMrrQ3a8gsUeOyyB0hegn3WOtl
         HgZfxfGoQp/IJqw7JIDzI8XMXbEYmpZy1JeNc+K5y42FnJ/zbaJ/uEkIXflivV1lqMpo
         Pkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CyIVEDRhT/M7EHYfzJq+drDcdbp/lDyRu17RaUijUkM=;
        b=ogO8LLJUDNbbL1JfWllKHB9MDg0errZ82FlLj7dZlfpmeYnkqPKbn36RVPdi1s+ibL
         FaMt6CM0W+OvvfdwvyfatpstZ7ynrO9Brt9EjlPoXk2Kz/XWLwIKjQNbQvZl+Obtdmfe
         mPcUO3oj8NFh1EjPlRUGsqRzFebG9hgtFJNlO20JpC37joevIVqAhfjAHIHJtK2BLpGm
         GXI+bCnikc+rf3Kh2o4rAhSH8S1TNJliDTI7d17TCZFx/0B/FYBX3pMNDzbN2czfJlHD
         xTpBhA/6kFtM+C6IcOp8Dh3ssgXZh9mybpISipFuBpYPAi7gyqg7LU6JwTjjFX+ljzep
         enPg==
X-Gm-Message-State: AOAM531dIPtBdittGqsNroohrnTq7fvpGDlhWXqQBILyzza23gsoYRjA
        y5qYtGH9AHHLQatAPDRoW04=
X-Google-Smtp-Source: ABdhPJz9jAZDYSt+Q/kkrzMX1JtzWFXqg3ASxtU1e/YjSzMldZ6xlAFfe3xpoKOLfQniTCPVVIcYig==
X-Received: by 2002:a05:6808:571:b0:32a:fdb8:167d with SMTP id j17-20020a056808057100b0032afdb8167dmr6271502oig.198.1653513307023;
        Wed, 25 May 2022 14:15:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d4d0b000000b0060b1fefeb52sm2572003otf.66.2022.05.25.14.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 14:15:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a0bffec3-cf43-417e-3804-9248325266c3@roeck-us.net>
Date:   Wed, 25 May 2022 14:15:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] riscv: compat: Using seperated vdso_maps for
 compat_vdso_info
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, arnd@arndb.de,
        palmer@dabbelt.com, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20220525160404.2930984-1-guoren@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220525160404.2930984-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/25/22 09:04, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This is a fixup for vdso implementation which caused musl to
> fail.
> 
> [   11.600082] Run /sbin/init as init process
> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
> 5.18.0-rc7-next-20220520 #1
> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
> 00ffffffc58199f0
> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
> ffffffffffffffff
> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
> 00ffffff8ade0cc0
> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
> 00ffffffc5819a00
> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
> 00ffffffc5819b00
> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
> 0000000000000000
> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
> 00ffffff8ade0728
> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
> 00ffffffc5819e40
> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
> 0000000000000000
> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
> 0000000000000001
> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
> cause: 000000000000000d
> 
> The last __vdso_init(&compat_vdso_info) replaces the data in normal
> vdso_info. This is an obvious bug.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Heiko Stübner <heiko@sntech.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 50fe4c877603..69b05b6c181b 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>   };
>   
>   #ifdef CONFIG_COMPAT
> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
> +	[RV_VDSO_MAP_VVAR] = {
> +		.name   = "[vvar]",
> +		.fault = vvar_fault,
> +	},
> +	[RV_VDSO_MAP_VDSO] = {
> +		.name   = "[vdso]",
> +		.mremap = vdso_mremap,
> +	},
> +};
> +
>   static struct __vdso_info compat_vdso_info __ro_after_init = {
>   	.name = "compat_vdso",
>   	.vdso_code_start = compat_vdso_start,
>   	.vdso_code_end = compat_vdso_end,
> -	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
> -	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
> +	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
> +	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>   };
>   #endif
>   

