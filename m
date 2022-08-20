Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695559AF5D
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiHTSFq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiHTSFp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 14:05:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A72D1D2;
        Sat, 20 Aug 2022 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2/0qrxj7HSrJO5jwPWZjY59WQuXjOzJXYQ9uh9ZAsQo=; b=zmQffzGzFl5ibBw5on7lF8ST1v
        2o8nfgwHpCqaIHaIow+FY5OgF7ODiRRxBUwMZh2HrdmzQrbI0tgRn4GoIILjzvKQ87Ng7FaLoFBYk
        wxHCYq6jZFKxytonwb4AVGxCvPy+WLCw9cbIGg36RhAI8PFhcUUqmUq3GLJSv33x18AWydnCSmOKv
        kucLwxAHvjn8l96dQWFt2Z1A5Y8DzFMxv6eklTyl1EfncL9iK+jk7VphMvoRVRf2fxzn15jxhwpRk
        CKqaW1FxWkboflAfYes1BDBePhfPJOY0w+tfwhgHmkWvvLYQM5zn3sRoSKbLf0jtiEun6R1aG8e34
        EzLJeo6w==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPSqm-00BOEc-1k; Sat, 20 Aug 2022 18:05:36 +0000
Message-ID: <b2e77db8-0037-e890-cdda-8bbce1786fa9@infradead.org>
Date:   Sat, 20 Aug 2022 11:05:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] LoongArch: Select PCI_QUIRKS to avoid build error
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220820025755.3110083-1-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220820025755.3110083-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 8/19/22 19:57, Huacai Chen wrote:
> PCI_LOONGSON is a mandatory for LoongArch and it is selected in Kconfig
> unconditionally, but its dependency PCI_QUIRKS is missing and may cause
> a build error when "make randconfig":
> 
>    arch/loongarch/pci/acpi.c: In function 'pci_acpi_setup_ecam_mapping':
>>> arch/loongarch/pci/acpi.c:103:29: error: 'loongson_pci_ecam_ops' undeclared (first use in this function)
>      103 |                 ecam_ops = &loongson_pci_ecam_ops;
>          |                             ^~~~~~~~~~~~~~~~~~~~~
>    arch/loongarch/pci/acpi.c:103:29: note: each undeclared identifier is reported only once for each function it appears in
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for PCI_LOONGSON
>    Depends on [n]: PCI [=y] && (MACH_LOONGSON64 [=y] || COMPILE_TEST [=y]) && (OF [=y] || ACPI [=y]) && PCI_QUIRKS [=n]
>    Selected by [y]:
>    - LOONGARCH [=y]
> 
> Fix it by selecting PCI_QUIRKS unconditionally, too.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 4abc9a28aba4..26aeb1408e56 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -111,6 +111,7 @@ config LOONGARCH
>  	select PCI_ECAM if ACPI
>  	select PCI_LOONGSON
>  	select PCI_MSI_ARCH_FALLBACKS
> +	select PCI_QUIRKS
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
>  	select SMP

-- 
~Randy
