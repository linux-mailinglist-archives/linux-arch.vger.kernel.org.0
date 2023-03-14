Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84EC6B97C7
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 15:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCNOWQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCNOWP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 10:22:15 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102D144AF;
        Tue, 14 Mar 2023 07:21:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h7so8712211ila.5;
        Tue, 14 Mar 2023 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678803702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TKW/XPJkv5oURqt7x2CDUN4OCZGjwah7XeLljlzahlM=;
        b=BXb6vrp6VDXSx/8zVsqaZiTMWloQyQR07C6BmwaL5XEEHhrBvjmXa4sVgAMIRFcJMP
         t84/XyXj4RlWhdTHC1L5qfIGSD7+gM+doj5KLMuhQv+/Kf5VF/QWJAjPwn/nqPRpWMmJ
         yjH7f8Fzi9Clet/WAHMYlQ9z35b2G62Rxp/lkF9iLRowSoD5bBMgvwrAw73/jX3mJEWu
         una7ToOcu0Vkh2RLyXCnrr6n3mcL2H3W7SpND7pvNGSphGB8g1KBgYI8ZcBb8Rg98tRC
         GjmqbubdUqljgzspAbkEX/dy58+8Zq/GEtAnjDR5hdwwzrBLgJUkBCW4TPft1029HpKN
         /PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKW/XPJkv5oURqt7x2CDUN4OCZGjwah7XeLljlzahlM=;
        b=YO9gA+Lo+N6loq96xXfWvhmSWC4rkHujOsqsXhraqCWpsaYcJ+K7FZDtfXAzoDLUO/
         Qtq2DKU1WrjMuYcG5Z0gMACQYoJtgGtK9lWyUNHXwCnjaf3eHlHNPuNj/9cYYtdalPp/
         /w3PG792CWiL079jgOAhFLDad70m8AhdIzw6A5Z9HSgxHFZQ+N3t5PHX44IJloHKuuRS
         aZriOVKfTil5x7YSVz4NlRdmBy7xw+sFqjT0eGmCLu6IlzLAvAgYfWAVQIFW4rBO8qqy
         GdzUPLiaS+fNLvXXqLDUzJVEb9EVVIQNvzqy+19hfcgKUSzPdWm/CAF8xMG8WakXrdEN
         jodw==
X-Gm-Message-State: AO0yUKXtXCYwDeB+ZAdg9voje/fXH3aOk7XImn6jqnJP8YV5qHXzCl+o
        7sneR6CTetwcwoU/blbZkyA=
X-Google-Smtp-Source: AK7set8nS4HCsoJe3EvRgRh6Rbgb7LduKLS2mLvbdzqK1Fs/7aZ00IntvJc3opJb8N9Imf2GOfhhSQ==
X-Received: by 2002:a92:7f03:0:b0:316:fcbe:627b with SMTP id a3-20020a927f03000000b00316fcbe627bmr1974011ild.4.1678803702619;
        Tue, 14 Mar 2023 07:21:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a926a0c000000b003231580e8e2sm847734ilc.6.2023.03.14.07.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:21:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0012f572-557c-b8fd-5426-3dd43c35b03b@roeck-us.net>
Date:   Tue, 14 Mar 2023 07:21:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 36/38] watchdog: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-watchdog@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-37-schnelle@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230314121216.413434-37-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/14/23 05:12, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f0872970daf9..e5d6f886e25d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -453,6 +453,7 @@ config 21285_WATCHDOG
>   config 977_WATCHDOG
>   	tristate "NetWinder WB83C977 watchdog"
>   	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
> +	depends on HAS_IOPORT
>   	help
>   	  Say Y here to include support for the WB977 watchdog included in
>   	  NetWinder machines. Alternatively say M to compile the driver as
> @@ -1271,6 +1272,7 @@ config ITCO_WDT
>   	select WATCHDOG_CORE
>   	depends on I2C || I2C=n
>   	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
> +	depends on HAS_IOPORT # for I2C_I801
>   	select LPC_ICH if !EXPERT
>   	select I2C_I801 if !EXPERT && I2C
>   	help
> @@ -2148,7 +2150,7 @@ comment "PCI-based Watchdog Cards"
>   
>   config PCIPCWATCHDOG
>   	tristate "Berkshire Products PCI-PC Watchdog"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>   	help
>   	  This is the driver for the Berkshire Products PCI-PC Watchdog card.
>   	  This card simply watches your kernel to make sure it doesn't freeze,
> @@ -2163,7 +2165,7 @@ config PCIPCWATCHDOG
>   
>   config WDTPCI
>   	tristate "PCI-WDT500/501 Watchdog timer"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>   	help
>   	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
>   

