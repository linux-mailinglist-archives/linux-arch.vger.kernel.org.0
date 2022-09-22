Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968275E5D8B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Sep 2022 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIVIci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Sep 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIVIch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Sep 2022 04:32:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A5611C18
        for <linux-arch@vger.kernel.org>; Thu, 22 Sep 2022 01:32:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n15so7371550wrq.5
        for <linux-arch@vger.kernel.org>; Thu, 22 Sep 2022 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=w4tcViQqnjkZMSwdvcgkNZF0h1NsjZIwQovOy+zVQ2I=;
        b=vHOx7wC6aChu35eeWjL5OzPmKV4uVjxDdeYtIsNGR+9jYiv/4bNePy29IcwaGL9pQo
         gV/8z2Dyv6BSZI/QsPlf+Tz/7z4+B4KLCF8q8sZdvJiltTVY9O60BHaFxucWA88HvRAJ
         PmM3rZ+hF0kKFA6zgLop1QJPyXVgEYDsVpCWRcwTqGngx+HXz4yhDNkChKYf6D5+9cd4
         RiooU+CpBQdwFu+NhYIBI/wLEHIcA1oODBnoFqZ6e9hpGZ1WdNFkTZ7h2uw2LOCieFRq
         zi0xndQuhSCZNYMyszCOdrE4iP3aKj4WHZ6EOXCQoAN9TrdPiaXaEMa1y70DWJ9itNSv
         53/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=w4tcViQqnjkZMSwdvcgkNZF0h1NsjZIwQovOy+zVQ2I=;
        b=JgwgItjFptjN9ow0bKxempl9CEHbnPFiOWSabghVw5HQr88LUY1YWsXE/cvKSo96Vc
         4knfnaMqnmpzRDputy5aGYYhZqez07uQ1/UtDol7riWrprSaGW8UOxIZY2rM6Zpg2xO/
         bvOvb640tRU9Mz3Cx33OkMJ7HJv9TxqBu6yEP57+/XxMHXTl7je45xjqLSnjc1KJ+eqz
         DXVSPKDjjFumUtdIQZ2Fv4g9nz6CHaRS4JUQvv5eR4pbqkdW3E3F48nKzrhh8l1rMmYe
         BPIHSdbUS846agGobDpvvHyFpZYgU1kgGJfZkQeftThYTQ/vS0g38K3Bg5SJ0VlZqFTA
         TKSA==
X-Gm-Message-State: ACrzQf3wN7Tgte+0HA9q0wvFKJ52CIM0xQDKtA9KkZ7MMJ1MCBue/hiQ
        yOtFBVP+eWW5KtevxYKkG+Wc8w==
X-Google-Smtp-Source: AMsMyM7qKm9SQA2KImY3Xih62bjMjrAUJWQJi3hfABFOYyK2n67PrvYixF/8esG9ZjvFBF5YT0SnhQ==
X-Received: by 2002:a5d:6e91:0:b0:226:ea99:7d06 with SMTP id k17-20020a5d6e91000000b00226ea997d06mr1205148wrz.220.1663835554477;
        Thu, 22 Sep 2022 01:32:34 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003a5fa79007fsm5150777wmc.7.2022.09.22.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:32:34 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 2/2] Input: i8042: Add LoongArch support in
 i8042-acpipnpio.h
In-Reply-To: <20220917064020.1639709-2-chenhuacai@loongson.cn>
References: <20220917064020.1639709-1-chenhuacai@loongson.cn>
 <20220917064020.1639709-2-chenhuacai@loongson.cn>
Date:   Thu, 22 Sep 2022 10:32:33 +0200
Message-ID: <87a66rhkri.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 17, 2022 at 14:40, Huacai Chen <chenhuacai@loongson.cn> wrote:

> LoongArch uses ACPI and nearly the same as X86/IA64 for 8042. So modify
> i8042-acpipnpio.h slightly and enable it for LoongArch in i8042.h. Then
> i8042 driver can work well under the ACPI firmware with PNP typed key-
> board and mouse configured in DSDT.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

I would have split the pr_info() move in its own patch since it seems
like a "valid fix" on its own, but i'm probably too pedantic about this.

So, please take my:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++--
>  drivers/input/serio/i8042.h           | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index d14b9fb59d6c..c22151f180bb 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -2,6 +2,7 @@
>  #ifndef _I8042_ACPIPNPIO_H
>  #define _I8042_ACPIPNPIO_H
>  
> +#include <linux/acpi.h>
>  
>  #ifdef CONFIG_X86
>  #include <asm/x86_init.h>
> @@ -1449,16 +1450,19 @@ static int __init i8042_pnp_init(void)
>  
>  	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
>  		i8042_pnp_exit();
> +		pr_info("PNP: No PS/2 controller found.\n");
>  #if defined(__ia64__)
>  		return -ENODEV;
> +#elif defined(__loongarch__)
> +		if (acpi_disabled == 0)
> +			return -ENODEV;
>  #else
> -		pr_info("PNP: No PS/2 controller found.\n");
>  		if (x86_platform.legacy.i8042 !=
>  				X86_LEGACY_I8042_EXPECTED_PRESENT)
>  			return -ENODEV;
> +#endif
>  		pr_info("Probing ports directly.\n");
>  		return 0;
> -#endif
>  	}
>  
>  	if (i8042_pnp_kbd_devices)
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> index bf2592fa9a78..adb5173372d3 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -19,7 +19,7 @@
>  #include "i8042-snirm.h"
>  #elif defined(CONFIG_SPARC)
>  #include "i8042-sparcio.h"
> -#elif defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#elif defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
>  #include "i8042-acpipnpio.h"
>  #else
>  #include "i8042-io.h"
> -- 
> 2.31.1
