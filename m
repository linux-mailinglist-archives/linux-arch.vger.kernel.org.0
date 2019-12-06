Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F871155E5
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFQ4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:56:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfLFQ4K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 11:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l4A/o2+wyjx84ZFaPlMMEV4MACdBKMwfmSyM67ZwjiM=; b=ighuK9muOzPxJYFwUwOg0PO8+
        +JGaeuWGo7vCnedvc0p9ldjmojIcrlB1/qkhQ7mfkR8vsXOmmCsJ6UEwMhCEG6ctJ3vspq6b48DTi
        YQvzm4SDgmQNa9PZy4Hz8JDvGZ80dFBSKbwKpXl+k/PDptFyzmGaPMFpBuioTZ7M61kCwbdilhDKd
        9zimj0UIoPHPBwuK1LRzffeoIsu1uuG2Cm9lbJwCCELh6XynoAML+OMJUAq+mOVqA/1G4EY+cZcnL
        Mg/v5XY7TbPTnRMiguDWsDua+z2b3z+pD4T0fhB8h2LGKBI1iidIVPI6goTDAcnrWw8UO4gv6xK/X
        lEIZVtoJw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idGtf-0001K3-PA; Fri, 06 Dec 2019 16:56:03 +0000
Subject: Re: [PATCH 1/3] cpuinfo: add sysfs based arch independent cpuinfo
 framework
To:     Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-2-trenn@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <65a20b22-8cc9-4492-25d5-4f03727086e8@infradead.org>
Date:   Fri, 6 Dec 2019 08:56:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206162421.15050-2-trenn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/6/19 8:24 AM, Thomas Renninger wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 48b5e103bdb0..39015570b1ca 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -882,6 +882,17 @@ config STRICT_MODULE_RWX
>  	  and non-text memory will be made non-executable. This provides
>  	  protection against certain security exploits (e.g. writing to text)
>  
> +config CPUINFO_SYSFS
> +	bool "Provides processor information in sysfs. Successor of /proc/cpuinfo"

	      Provide

> +	def_bool y
> +	depends on HAVE_CPUINFO_SYSFS
> +	help
> +	  Provides architecture specific processor information in /sys/devices/system/cpu/info> +	  Use this instead of /proc/cpuinfo

End those 2 sentences with periods (full stop), please.

> +
> +config HAVE_CPUINFO_SYSFS
> +	bool
> +
>  # select if the architecture provides an asm/dma-direct.h header
>  config ARCH_HAS_PHYS_TO_DMA
>  	bool


-- 
~Randy

