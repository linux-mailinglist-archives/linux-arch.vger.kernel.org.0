Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A786C5FC972
	for <lists+linux-arch@lfdr.de>; Wed, 12 Oct 2022 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJLQrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJLQrr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 12:47:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B620792EC;
        Wed, 12 Oct 2022 09:47:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b4so27098947wrs.1;
        Wed, 12 Oct 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkYwffHoTj+UGeb69vyYv3Vi6xsZterM+r8p4HSwk3k=;
        b=qt8qxQtSMmPSznXRe9pn8HRdFJaewZGwEj1d2XqeJIUx7fTdVWUet+16K0OFzpIWK6
         Zk5upGfpxB93/w9tOsCA58VK11SJPgjbhNfiqAMe9K5nBOeFP7FusCxGHEYKFmUke4b/
         tJRSixQsn1aCq2/YKwKNDqFFhAt4Xek2mA+DovqEa/pSJ4PqV0CNRLDTdYAol3bESito
         y+A4DoxRkyPPRL4gG+R3UHZhAkPHviiSgz6gRsD7K0aMdi4hn/ReQf9ke+vM6TW5GEuN
         wsHEWUBDeB5vZm1+IwtfJbyF4nfih/t790IREmOraOJFifaG+hVDFMpPjH/wX9142rvs
         XmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkYwffHoTj+UGeb69vyYv3Vi6xsZterM+r8p4HSwk3k=;
        b=SovgRyRQHISurAVVCovEUeEVP1g/ZaElmhFQ0WIcAFbpes0SHH592QjZSGMI5HwmqN
         7anAJ8ykc4O6frT+YTO3msN0Yq+qh/EufcIqXTzTWEpWgfmxAtwCtaOu83PhYvi5YxZJ
         cvjeL04hol/7K9MLjJN79KsKnKnXuw5KCcIK3E9s/IpD987OwHF7ZhjF1SarUTf7fWxL
         hUuojgow220n2gCcH/ZHUsk2nyty/NWS4KpfvIiTrYM0wWI7ZF2Ndys567xY8NOA4FUY
         XI5eGeyZP0p65SJg+VItMO3SCSglwpihMOeCv4MjZ8xfowyvj02j2aPrvQ1EUQkqUg1q
         ZizA==
X-Gm-Message-State: ACrzQf28G5Icqw2x/Vh4r9H68gJu07lTDFwuvIokAEjMl2Uuc7fK9Qes
        wtmFgUhfom8/HlTV1a2CDvI=
X-Google-Smtp-Source: AMsMyM5QG/hbTP0GgOdpLWkfLu7at/Wgl1M2fr1LZcGBYHj6q7svLrd3xOaQiLDwa/S213jc6sDvfA==
X-Received: by 2002:a05:6000:10d1:b0:22e:3bc5:c91c with SMTP id b17-20020a05600010d100b0022e3bc5c91cmr18250079wrx.368.1665593264626;
        Wed, 12 Oct 2022 09:47:44 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c065600b003c6c2ff7f25sm2056959wmm.15.2022.10.12.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:47:44 -0700 (PDT)
Date:   Wed, 12 Oct 2022 16:47:43 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [RFC PATCH 2/8] openrisc: mm: remove unneeded early ioremap code
Message-ID: <Y0bvr/gKaKYd7ur2@oscomms1>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <9010e8719949cce376dc3f75a97b8bfb2ff98442.1665568707.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9010e8719949cce376dc3f75a97b8bfb2ff98442.1665568707.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 12, 2022 at 12:09:38PM +0200, Christophe Leroy wrote:
> From: Baoquan He <bhe@redhat.com>
> 
> Under arch/openrisc, there isn't any place where ioremap() is called.
> It means that there isn't early ioremap handling needed in openrisc,
> So the early ioremap handling code in ioremap() of
> arch/openrisc/mm/ioremap.c is unnecessary and can be removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org

Thanks for picking this up.

Perhaps add this link?

Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/

But either way.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/ioremap.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 8ec0dafecf25..90b59bc53c8c 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,8 +22,6 @@
>  
>  extern int mem_init_done;
>  
> -static unsigned int fixmaps_used __initdata;
> -
>  /*
>   * Remap an arbitrary physical address space into the kernel virtual
>   * address space. Needed when the kernel wants to access high addresses
> @@ -52,24 +50,14 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  	p = addr & PAGE_MASK;
>  	size = PAGE_ALIGN(last_addr + 1) - p;
>  
> -	if (likely(mem_init_done)) {
> -		area = get_vm_area(size, VM_IOREMAP);
> -		if (!area)
> -			return NULL;
> -		v = (unsigned long)area->addr;
> -	} else {
> -		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> -			return NULL;
> -		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> -		fixmaps_used += (size >> PAGE_SHIFT);
> -	}
> +	area = get_vm_area(size, VM_IOREMAP);
> +	if (!area)
> +		return NULL;
> +	v = (unsigned long)area->addr;
>  
>  	if (ioremap_page_range(v, v + size, p,
>  			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> -		if (likely(mem_init_done))
> -			vfree(area->addr);
> -		else
> -			fixmaps_used -= (size >> PAGE_SHIFT);
> +		vfree(area->addr);
>  		return NULL;
>  	}
>  
> -- 
> 2.37.1
> 
