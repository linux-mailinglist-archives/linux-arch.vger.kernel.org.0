Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115345F3316
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJCQHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJCQH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 12:07:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27623BDC;
        Mon,  3 Oct 2022 09:07:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d11so10079086pll.8;
        Mon, 03 Oct 2022 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=Dvy2xvZBjbbxD4I6LW/0qoLOCIiEas9Nb7Ts/zuWvus=;
        b=PxHFGfJYSYBX1Yg/Mzj3ErQD6Iv0rG1btseJGyeEaERkil/gZnYatRuvX/+xDoa4cE
         0qfsGQOa7yVM1BAidTjqULiNyec7OvR3XyJUQYahJ2UOzSm2ZXD1elof2tdvhWWEleXz
         MZP4H5ayJ+sgdT7wm3bva+RJX3PhM8n0N0rTBZnLqiauxn4RS/QQqt+Oe/JTefg5rdNo
         wgwNEHgjP0T4wk2FvREvS65Qagg09v/Hsuq5vDVZwHD5hGjQ4R688DVvthiGSS/vROCw
         UleTzlOSUC7azvfKbfallf4ZuZDxTbONRqkFsZ3kQdGZ7Xe5BkIf/AhuDcHR+sdlkZTj
         Sp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=Dvy2xvZBjbbxD4I6LW/0qoLOCIiEas9Nb7Ts/zuWvus=;
        b=iqHFlJJbbB/+FZk8V2N1VQhx00TppjlximigGZyimhKUan5PPtkljfxKUgsYQ1OVG9
         /DwyLL5yhpSq4LcUq2ITeOcojtt3KqSVnFU2gpg1sqlXlywnbC/4V5NB5GyxszXW5R8M
         5p9mkyTFDfeRxWjJBdQgGhbS3ueuhkSXTUjCyW+pSgDEnj+gN5au2NCTSh01EG8BKimC
         Gle9vnu6M5bWb1j0BY2pYPsrxUKykla0ZgHvsNoMB5FXut1kHn03cHS557e4PbMU2/FZ
         aVcLGMMq9gHAmc41cRiP3ONL0VS+Y2e7IFVckzC9iCtu7l8hYIWK+z18C7dr3a1w9YjN
         G4Vw==
X-Gm-Message-State: ACrzQf37Lsx8rH1IWEfwSyoTrOiZ+4cITGcSENsb0Pve6kqjVnlnGfvQ
        1Sn+vWDsuM5KcMgtF9w2TOJJNHFRGjy8XA==
X-Google-Smtp-Source: AMsMyM7vO/dk9MQEIlTY8pCQKVBOJ5IQ9cTEAfosOQqXty6O6jxDdrEImSCTVrcw+cd/qjdQ4DTgng==
X-Received: by 2002:a17:903:2410:b0:17a:b32:dbec with SMTP id e16-20020a170903241000b0017a0b32dbecmr22602723plo.163.1664813247654;
        Mon, 03 Oct 2022 09:07:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0017a0e78ed0dsm7324534plk.254.2022.10.03.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:07:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 3 Oct 2022 09:07:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] alpha: Fix ioread64/iowrite64 helpers
Message-ID: <20221003160724.GA654712@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 03, 2022 at 02:13:16PM +0200, Linus Walleij wrote:
> When doing allmod builds it turns out some modules are using
> ioread64() and iowrite64() that the alpha does not implement,
> as it is using <asm-generic/iomap.h> without selecting
> GENERIC_IOMAP.
> 
> Fix this by implementing the ioread64()/iowrite64() stubs
> as well, using readq() and writeq() respectively.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
> Link: https://lore.kernel.org/linux-arch/20221002224521.GA968453@roeck-us.net/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Note that I don't have a preference about the two suggested patches.
Both fix the problem I had observed.

Thanks,
Guenter

> ---
> Arnd if this looks OK then please apply it on linux-arch
> for fixes.
> ---
>  arch/alpha/kernel/io.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
> index 838586abb1e0..5f3e75a945c1 100644
> --- a/arch/alpha/kernel/io.c
> +++ b/arch/alpha/kernel/io.c
> @@ -41,6 +41,11 @@ unsigned int ioread32(const void __iomem *addr)
>  	return ret;
>  }
>  
> +u64 ioread64(const void __iomem *addr)
> +{
> +	return readq(addr);
> +}
> +
>  void iowrite8(u8 b, void __iomem *addr)
>  {
>  	mb();
> @@ -59,12 +64,19 @@ void iowrite32(u32 b, void __iomem *addr)
>  	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
>  }
>  
> +void iowrite64(u64 b, void __iomem *addr)
> +{
> +	writeq(b, addr);
> +}
> +
>  EXPORT_SYMBOL(ioread8);
>  EXPORT_SYMBOL(ioread16);
>  EXPORT_SYMBOL(ioread32);
> +EXPORT_SYMBOL(ioread64);
>  EXPORT_SYMBOL(iowrite8);
>  EXPORT_SYMBOL(iowrite16);
>  EXPORT_SYMBOL(iowrite32);
> +EXPORT_SYMBOL(iowrite64);
>  
>  u8 inb(unsigned long port)
>  {
> -- 
> 2.34.1
> 
