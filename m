Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89E2B8951
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 02:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKSBMq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 20:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKSBMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 20:12:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC30C0613D4;
        Wed, 18 Nov 2020 17:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TMXl8eP8f+rdhsuETVYmBMrtcwFUog3k1+Ypy5Ju3oA=; b=FVps4gScS2k+oVdahvk9DZ6i1J
        FdkAkPMiM+0tEkK9teAcqHXD83Z3mj1ExtS5YxqcozewAllYfT5OaR9cK4I3hBPPiuvwTANJwyftt
        lOGoV/yxDHQRMCa86DbEdgUVtwg+Xpj63Q+WJP4x9FbfUCXYP6Ak6q1sPiz3glJ/4SefmeCTfYOMz
        /B9LND/6y0Lu5DugC35YW0tp4Yg4lkH1Jx/Liw3G9pRYgszRUVAIzfBf3kxVBWk5q2OHy3mKZ77sJ
        AjQDbUHzeQ8Z2F0A0Pb7WDmtue6Bs6VBEpuAkYVB2ZEMLJLJaZfVckaZrfOG6kzErNm5RulXA/R1f
        cX89S//g==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfYUv-0001Q0-1T; Thu, 19 Nov 2020 01:12:29 +0000
Subject: Re: [PATCH v5 2/5] numa: Move numa implementation to common code
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org
References: <20201119003829.1282810-1-atish.patra@wdc.com>
 <20201119003829.1282810-3-atish.patra@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c650ecd7-7cd3-fd8e-7d4b-ed32ca91ca70@infradead.org>
Date:   Wed, 18 Nov 2020 17:12:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201119003829.1282810-3-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/18/20 4:38 PM, Atish Patra wrote:
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 8d7001712062..c5956c8845cc 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
>  	  appropriate scaling, sysfs interface for reading capacity values at
>  	  runtime.
>  
> +config GENERIC_ARCH_NUMA
> +	bool
> +	help
> +	  Enable support for generic NUMA implementation. Currently, RISC-V
> +	  and ARM64 uses it.

	            use it.

> +
>  endmenu


-- 
~Randy

