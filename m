Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7E55C475
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiF0VMr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 17:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbiF0VMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 17:12:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F6DFFF;
        Mon, 27 Jun 2022 14:12:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 65so10104663pfw.11;
        Mon, 27 Jun 2022 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Oa0Pw8WRwWFDk13UOTNU8r4Zj28fKsbMsHZJFWhjWbI=;
        b=UuI0dBFgPO4diTfHy/9LPAgfpBMcc774BorzXErxQR5b8AL+fMoTv1/RUwCaUUs5Wz
         wZ41GicoS5ofRiqUMfzJSjLcsa3Lrxfcq7QsnrIjny3YpmiuCR7VENM6FYB8xkBQFZxV
         /SvrqOuGEaAsBy3VjIJv2hWBCfpevI/Qjf6b6TAcBGWsZyeAXg1pQFprfgEMNNGBMg2o
         tYBcjNK8DJCwca5jr2WTeEiIenBQUcRBZixJW3S/qcpsfVeN23O6kRkqiR3GcuTz6FFB
         bxC1nlLwsXhKrEY7yB3vYz/3Q3omwcdSNomhexVJsFmeYGEIJmGjE/zTpXa346zjItic
         z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oa0Pw8WRwWFDk13UOTNU8r4Zj28fKsbMsHZJFWhjWbI=;
        b=ggrIRs5NxUdbE3UQDLmv7HW65aasUG/2OIT6fHQYjEF6YyvD8580r98QK+hd8E80Yx
         LhgoPU7HogDLUOQe/CcOFIi0LqkCV4JBRm9CzR5sK8HaUHXrAuoVb5ia4NZAKwZngGG5
         P2cdStQoM+c2hC/SP6GlUFREtfAjdxw3nVeWa4JnsVPHl3cdQHEvEhXbGLpJSVshEa+O
         LRHX2QPvtX2u/vHB1oKW4pEZYawtNgaRkcOqOtin/ubyGCEw8S17wKAmEPl2pdS7fGRn
         0zAypo+bVA9IZj7tBOQ6mPKyAX+cXsy75BjSkJc/5z4ybe780/vD6vq7mw8/FzrUuyYT
         Yb4w==
X-Gm-Message-State: AJIora/AUk+/01RCo+ecfVBGj+eyFFFXhl6WFsHBwcSBOdGKzGnA9uPP
        mRK7/3K88ZW23giQDatBHoU=
X-Google-Smtp-Source: AGRyM1uTPLx0FmbccmLLTUeOwpDtfjfY9meoJGws1yrh1VdVD8/6CKl+WA5aLqzWBJfSXBuzMThY8A==
X-Received: by 2002:a05:6a00:2311:b0:4e1:52bf:e466 with SMTP id h17-20020a056a00231100b004e152bfe466mr16676782pfh.77.1656364364243;
        Mon, 27 Jun 2022 14:12:44 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:310d:de36:ea8e:ce87? ([2001:df0:0:200c:310d:de36:ea8e:ce87])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a6b0b00b001ece55b938asm9847689pjj.32.2022.06.27.14.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 14:12:43 -0700 (PDT)
Message-ID: <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
Date:   Tue, 28 Jun 2022 09:12:33 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 27/06/22 20:26, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> All architecture-independent users of virt_to_bus() and bus_to_virt()
>>> have been fixed to use the dma mapping interfaces or have been
>>> removed now.  This means the definitions on most architectures, and the
>>> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
>>>
>>> The only exceptions to this are a few network and scsi drivers for m68k
>>> Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
>>> with the old interfaces and are probably not worth changing.
>> The Amiga SCSI drivers are all old WD33C93 ones, and replacing
>> virt_to_bus by virt_to_phys in the dma_setup() function there would
>> cause no functional change at all.
> FTR, the sgiwd93 driver use dma_map_single().

Thanks! From what I see, it doesn't have to deal with bounce buffers 
though?

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
