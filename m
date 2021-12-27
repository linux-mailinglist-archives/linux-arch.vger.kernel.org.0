Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226F2480329
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhL0SDT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhL0SDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 13:03:18 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F23C06173E;
        Mon, 27 Dec 2021 10:03:17 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p4so26395204oia.9;
        Mon, 27 Dec 2021 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=estVpf11XBcCHh7/EsEMsmeAZD0WKzbLuknLI7vdHRc=;
        b=LJCpOzkwux2I4nV1n97aB9IUKvSkBGD3iUUD++H9D4mmSZ/D3sOacT6mjhY6fTgku+
         qHvc+fbPOsRqc0bg48tytzE8mIBM2Q1eievS683WX45BEBNPmwnuA5pe50fRib26/BFN
         6/HKVHvFnyD9BYbilNGf8XcOv8n2g3rE/wZ72yP5DmsbxhKomgtiL1oavpxuDRV/nXGy
         Q6fVaDX8ZKPQft53OsOgdJkO9erQ6zljua5QBUUoc8abkqBvgMv6sWSKnVXGfA3hpSaJ
         ONght/mWkC2YAJykH+ajzmQcuI5Eatc2quB10O3MQyTPoCGnzIJ1GaMjmVPuOQo3pET6
         WwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=estVpf11XBcCHh7/EsEMsmeAZD0WKzbLuknLI7vdHRc=;
        b=6FxaOtI8tBybqbIsbA5rTu5uCpq2wqkuy7AuidPkgeGulK/Gr9F/fZrH83yMud2Tlc
         nkX3LeyVNi6q6HARCVn3LInNUG7YXyB/zbFrpP+3IY1y1eyaR+uoSI8FfyXkA/3AGZPp
         bg7Ivk4Zz3LPR81BIx67bB2ZxKqT1EU8WmYjjtO1bPGfWnFjjuxJgd62AWpZmKBF+eQT
         9pVk64anWcjsZrn6BGnAE9JjRPezAOGDMnnE8IWGaGVt0Y98rrdXXZ3q44LXioHfrr/m
         tm9CnBJrKsJB636pQQK9lWcS4mtjFe4F/MbMg2zHR9OsPZ6dvPMyXAtiPBUf3tBDu9HB
         dS7Q==
X-Gm-Message-State: AOAM5313JdTusG4lcy2EDyGF7YSdQC/Z+yaN5RWCi9DxW6eNqgV8Q6Vy
        H12R1JxYgdM+JiORp07CIJ5dVFoV1yw=
X-Google-Smtp-Source: ABdhPJyPWxZ0FYqGXnkAxeGcmPPuoSSaJqXVZdkH1ZvL+v9Ry2ZD/jZglb5h2L0TwG+Cjf13kprmVw==
X-Received: by 2002:a05:6808:554:: with SMTP id i20mr14023491oig.51.1640628196494;
        Mon, 27 Dec 2021 10:03:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm3452616oiw.48.2021.12.27.10.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 10:03:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-26-schnelle@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC 25/32] watchdog: Kconfig: add HAS_IOPORT dependencies
Message-ID: <280c0490-3a68-5498-5751-d53162203b5b@roeck-us.net>
Date:   Mon, 27 Dec 2021 10:03:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227164317.4146918-26-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/27/21 8:43 AM, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 

How is the need for HAS_IOPORT determined, when exactly is it needed,
and when not ?

$ git grep -E "inb|inw" drivers/watchdog/ | cut -f1 -d: | sort -u
drivers/watchdog/acquirewdt.c
drivers/watchdog/advantechwdt.c
drivers/watchdog/cpu5wdt.c
drivers/watchdog/f71808e_wdt.c
drivers/watchdog/ibmasr.c
drivers/watchdog/ie6xx_wdt.c
drivers/watchdog/it8712f_wdt.c
drivers/watchdog/it87_wdt.c
drivers/watchdog/iTCO_vendor_support.c
drivers/watchdog/iTCO_wdt.c
drivers/watchdog/Kconfig
drivers/watchdog/machzwd.c
drivers/watchdog/mixcomwd.c
drivers/watchdog/ni903x_wdt.c
drivers/watchdog/nic7018_wdt.c
drivers/watchdog/nv_tco.c
drivers/watchdog/pc87413_wdt.c
drivers/watchdog/pcwd.c
drivers/watchdog/pcwd_pci.c
drivers/watchdog/sbc60xxwdt.c
drivers/watchdog/sbc7240_wdt.c
drivers/watchdog/sc1200wdt.c
drivers/watchdog/sch311x_wdt.c
drivers/watchdog/smsc37b787_wdt.c
drivers/watchdog/sp5100_tco.c
drivers/watchdog/w83627hf_wdt.c
drivers/watchdog/w83877f_wdt.c
drivers/watchdog/w83977f_wdt.c
drivers/watchdog/wafer5823wdt.c
drivers/watchdog/wdt977.c
drivers/watchdog/wdt.c
drivers/watchdog/wdt_pci.c

Guenter

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/watchdog/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 05258109bcc2..2e87a65bdc8b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -452,6 +452,7 @@ config 21285_WATCHDOG
>   config 977_WATCHDOG
>   	tristate "NetWinder WB83C977 watchdog"
>   	depends on (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)
> +	depends on HAS_IOPORT
>   	help
>   	  Say Y here to include support for the WB977 watchdog included in
>   	  NetWinder machines. Alternatively say M to compile the driver as
> @@ -1200,6 +1201,7 @@ config ITCO_WDT
>   	select WATCHDOG_CORE
>   	depends on I2C || I2C=n
>   	depends on MFD_INTEL_PMC_BXT || !MFD_INTEL_PMC_BXT
> +	depends on HAS_IOPORT # for I2C_I801
>   	select LPC_ICH if !EXPERT
>   	select I2C_I801 if !EXPERT && I2C
>   	help
> 

