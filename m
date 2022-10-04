Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F455F49CD
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 21:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJDTmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJDTma (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 15:42:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49BA659EA;
        Tue,  4 Oct 2022 12:42:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r18so426454pgr.12;
        Tue, 04 Oct 2022 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=HpG5i02vmxe3dnsSL7vxsuxzal8c9ky/pIndry6A4cs=;
        b=hJcs4dlEb7BByvrgCfy9uPQh9LlR4GiVDIbolUzf4p6P20IwqIr9yJ7pvGcXrM8bru
         J9z6f4x8AnlFbo5w3rVHAYIF/qrvUx9rNM/9DM2JrYWA1+Utbbi7rNtqQ8uZE/768etO
         xEzuPqNICgQyZnbbc5UPLgPH2XSYtweENUJizJU60+KhjLBHwNUpDwYJP95E/hG9kvZr
         r6s/gqGxv16/0LDu0c9snGxj2BNDq+vEKxU2sziXYykWcZBYQCJ/4fjw657YOyDIt7h2
         g4sux0RMZY8/Be0j+/IGmLb8jZ2UaeydAI+kN4183nUvNVMPhwku9BKAtBvqoSM0RMZr
         zCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=HpG5i02vmxe3dnsSL7vxsuxzal8c9ky/pIndry6A4cs=;
        b=58QCmq41ebLeT8YAFIgq/b20Cpx6LmGib7X9xm9Xj/i40imn8z4olZh99Ql190VU18
         6EvtNuZp/NNJJBk2Yt7vszdBsSw9up4LFXdjLLdx9gtEQSk9+pdy/m/8wQKl8d7/qYxF
         G2RhLvHcBoFf7iRKz7QXW+r/hlXY5c8+pbjW6kXOwE5nnKuBRxbd5EWtlXVbT5J7flh0
         YfXmImoOMjrjZke/fy0EFKdMfAWtfkPOUEmBX3szuyRYr2qV9PBmP9mNCNnQ5ooStHYL
         ++8GLR8tDzs1E1lmWn9y3AmBHPtEV7z/Nn5cy27SgAUZW70KrZ3GT9rSM/4wLSoRCrnN
         G25w==
X-Gm-Message-State: ACrzQf3X1HEJOx+mok0eOEvn1UfFDEtHBnq4GhE7mFm/EdFJcnVVBV6t
        v9Ed6Y3T3C0WR/pL1ObsRVA=
X-Google-Smtp-Source: AMsMyM7GWgLHJkfVRRnc+wJMyGv6IHovqHeLpZFMtUdxFGhooTwzbJXACUygN9YbTWxKM8GoaBS3JQ==
X-Received: by 2002:a63:ed0a:0:b0:442:2514:95f5 with SMTP id d10-20020a63ed0a000000b00442251495f5mr19483881pgi.402.1664912549362;
        Tue, 04 Oct 2022 12:42:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b00177f4ef7970sm9260926plg.11.2022.10.04.12.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 12:42:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
Date:   Tue, 4 Oct 2022 12:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
 <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 06:03, Arnd Bergmann wrote:
> On Mon, Oct 3, 2022, at 12:45 AM, Guenter Roeck wrote:
> 
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/linux-mm/202208181447.G9FLcMkI-lkp@intel.com/
>>> Cc: Mark Brown <broonie@kernel.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>>> Cc: Matt Turner <mattst88@gmail.com>
>>> Cc: linux-arch@vger.kernel.org
>>> Cc: linux-alpha@vger.kernel.org
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> This patch results in the following build errors when trying to build
>> alpha:allmodconfig.
>>
>> ERROR: modpost: "ioread64" [drivers/pci/switch/switchtec.ko] undefined!
>> ERROR: modpost: "ioread64"
>> [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!
>> ERROR: modpost: "ioread64"
>> [drivers/net/ethernet/freescale/enetc/fsl-enetc-vf.ko] undefined!
>> ERROR: modpost: "iowrite64"
>> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
>> ERROR: modpost: "iowrite64" [drivers/net/wwan/t7xx/mtk_t7xx.ko]
>> undefined!
>> ERROR: modpost: "ioread64" [drivers/net/wwan/t7xx/mtk_t7xx.ko]
>> undefined!
>> ERROR: modpost: "iowrite64" [drivers/firmware/arm_scmi/scmi-module.ko]
>> undefined!
>> ERROR: modpost: "ioread64" [drivers/firmware/arm_scmi/scmi-module.ko]
>> undefined!
>> ERROR: modpost: "iowrite64" [drivers/vfio/pci/vfio-pci-core.ko]
>> undefined!
>> ERROR: modpost: "ioread64" [drivers/ntb/hw/mscc/ntb_hw_switchtec.ko]
>> undefined!
>>
>> Reverting it doesn't help because that just reintroduces the problem
>> that was supposed to be fixed by this patch.
> 
> Thanks for the report, I've now added this patch on top.
> 
> Matt, can you take a look if this look correct?
> 

Looks like something was missed. When building alpha:allnoconfig
in next-20221004:

Building alpha:allnoconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/alpha/kernel/core_marvel.c:807:1: error: conflicting types for 'marvel_ioread8'; have 'unsigned int(const void *)'
   807 | marvel_ioread8(const void __iomem *xaddr)
       | ^~~~~~~~~~~~~~
In file included from arch/alpha/kernel/core_marvel.c:10:
arch/alpha/include/asm/core_marvel.h:335:11: note: previous declaration of 'marvel_ioread8' with type 'u8(const void *)' {aka 'unsigned char(const void *)'}
   335 | extern u8 marvel_ioread8(const void __iomem *);
       |           ^~~~~~~~~~~~~~

Guenter
