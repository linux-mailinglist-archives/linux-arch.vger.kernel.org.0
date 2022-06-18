Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBD55018A
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jun 2022 03:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383705AbiFRBGz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbiFRBGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 21:06:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C447AF0;
        Fri, 17 Jun 2022 18:06:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1926932pjr.0;
        Fri, 17 Jun 2022 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KRIeihzYwpT99jVYyWrBvkWlYlvrvIZJfg260Yku6Lc=;
        b=mYCiRA6jX3TZBBpH5i1bdKxf86pnFybirRcUnA7+QegXGbzOVw+vVyBSconShTfcN0
         cCwY9Lg+Wp1DUlN7ZuDKZXZp+Lq9oTrhj5Egt9NASpHMRY0WFnq2TqiOXmxGI5seYlbP
         q0BPpHgaiqex7reMZd7eeiSPLbAesZfnXOSNpNddBnH0OtREDZ0fHr/GsKwCbGO2CEAh
         0hN2+Q0eH6pq4ZYITkDSH3pFg/hKtXahXOuIosfi8Y0II3BWuxt8tZ5GTulif6PPtR6w
         mWvi9cySEswvHdKCNsD70zRyxq32NFDfKs677RtcCSsSo3yIFNheD9lUFe9of5dO2FCw
         T3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KRIeihzYwpT99jVYyWrBvkWlYlvrvIZJfg260Yku6Lc=;
        b=EORI6MAvMD6kGOhV1mvUYiNIhU/4mhkeWdawxiqUahXOJxRRF8vRmVvtEs102WIuvJ
         jziivnj1IRCXpa2aDjdZm7wM34Rof976a8kZzUqx7o6cJGB2fNLCMzmY0u992o7XSTcR
         7xXf2mMr9QZU78wpFwcQL3WMsytbs29IK99gAwFF3tyYFmjIOLLfjqkyDaM3+rch0kb4
         jCnB4IjxuCPk69uskLqUJMwALdD97KT7fKGdQ8xbbY3gD7OqPjy+cqhGEG0ilWtaOVft
         h6w9ccWj/PnUA9PCVUNahhG3iG3zGFxkLP7UTcsRNCgYWXvgf/Vm8eLU5q+kky+qBcyN
         yQvg==
X-Gm-Message-State: AJIora/U2jFhW8Cz9bvxYXCYxI76rtUzy7vphHu5yjtk+zqmL9vxiW/E
        iKJ5BXkZikqBivWrSNIag3E=
X-Google-Smtp-Source: AGRyM1u1j6XUfwl32yRCm+A4vEBywEwNGmaCfY9KqlZE6/HghD6w2fj/KwvqmOMndnHwj1ctiT07Vw==
X-Received: by 2002:a17:90b:4ac9:b0:1e3:1dca:d995 with SMTP id mh9-20020a17090b4ac900b001e31dcad995mr13457922pjb.111.1655514413476;
        Fri, 17 Jun 2022 18:06:53 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b00161947ecc82sm4126766plh.199.2022.06.17.18.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:06:52 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Arnd Bergmann <arnd@kernel.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
Date:   Sat, 18 Jun 2022 13:06:40 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220617125750.728590-4-arnd@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd,

Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All architecture-independent users of virt_to_bus() and bus_to_virt()
> have been fixed to use the dma mapping interfaces or have been
> removed now.  This means the definitions on most architectures, and the
> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>
> The only exceptions to this are a few network and scsi drivers for m68k
> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
> with the old interfaces and are probably not worth changing.

The Amiga SCSI drivers are all old WD33C93 ones, and replacing 
virt_to_bus by virt_to_phys in the dma_setup() function there would 
cause no functional change at all.

drivers/vme/bridges/vme_ca91cx42.c hasn't been used at all on m68k (it 
is a PCI-to-VME bridge chipset driver that would be needed on 
architectures that natively use a PCI bus). I haven't found anything 
that selects that driver, so not sure it is even still in use??

That would allow you to drop the remaining virt_to_bus define from 
arch/m68k/include/asm/virtconvert.h.

I could submit a patch to convert the Amiga SCSI drivers to use 
virt_to_phys if Geert and the SCSI maintainers think it's worth the churn.

32bit powerpc is a different matter though.

Cheers,

	Michael
