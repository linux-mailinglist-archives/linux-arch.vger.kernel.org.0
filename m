Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7A56230F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiF3T0R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiF3T0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 15:26:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E365C42ED6;
        Thu, 30 Jun 2022 12:26:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 68so244883pgb.10;
        Thu, 30 Jun 2022 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BGB9eQ8ZjliFMgcRVKHE6urD7afsm+Bb1aKDYwW5Jfo=;
        b=iWoDQJ/dSdAde8AnIfDLxTdgiCOtOm+79LF23IYKQzTSvSChn0RKCEgkrj6yW/aq/L
         Ng7bKjXng0gluiBq2N+qXVNpXYJtqS/oCtHvj7VFuOyHwQQMfGgLnLNQOCJAEJPkpiFz
         k9OtgFn1UYqtdFU3SJ6Burv7HN7xACp19dipB8UXOnRrfrcJd6leCbIArojfXdQMEk7Y
         dmdguQ+pTW3/V2p6m9x2fWOO9yUsbTxLRRBRVk14fYaRWck/UzINDGudetShPegD8vs/
         9UYWZVqajm4CeiChNVdfJ+MpdaPqsySivwBLzVcXqDzRte+YXhoifrJyNvp0EqNB047u
         BQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BGB9eQ8ZjliFMgcRVKHE6urD7afsm+Bb1aKDYwW5Jfo=;
        b=VMM2qeV4TeVh107oxSuXYoYtsQ3ynBjpvZcOBxdLW+Sy5Xi3bB0UJAHit02skzzcw+
         cHQn14cnC1zL2i63e++5Stfq2ggzD8etgtMqjPwOKRnG0sTjLZ+OGCFsZBd2LHS/OZCz
         z3CVXz3pdoPv7b3Vu2XQPdAwQAozlOZnz3HgmfMhgyEnsgeDJ4Ib/RMtK0uFZhgUvFVn
         DyvWEBtQ69/DYw7uPGYPVEfwf9yHem6/AbjBAzsVGTZSwD0XNNOT5t7rK1Hh/oh++XYC
         8Q51jIt1dOgNXCPhmPNpUNZ/g9c1pSbiOc8OhHKYAE8ylDk3JGWtUMXAGQk9+AKrmKSm
         BSKg==
X-Gm-Message-State: AJIora++omdqAHfpA/aT6Yl588oIjo02muae58iNp9g8Iy4g5ZMz0x8I
        kPS4nA5ilZmHvu2pEPejzPw=
X-Google-Smtp-Source: AGRyM1tk83J3rH/OFTSOHRQYyzuFUGQ/lxtqXLEqqvb1V70fRLzAxXraPK8BYuQ19iCr74oVBVR7bQ==
X-Received: by 2002:a63:4a0b:0:b0:40d:d4c1:131f with SMTP id x11-20020a634a0b000000b0040dd4c1131fmr8603747pga.242.1656617175475;
        Thu, 30 Jun 2022 12:26:15 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b411:35d2:9458:bbe5? ([2001:df0:0:200c:b411:35d2:9458:bbe5])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b0051bbd79fc9csm13969994pfc.57.2022.06.30.12.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:26:14 -0700 (PDT)
Message-ID: <13e45965-4e55-11b1-bfdc-59efaad27464@gmail.com>
Date:   Fri, 1 Jul 2022 07:26:05 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
 <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
 <YrvwZi9NQSpFjStX@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <YrvwZi9NQSpFjStX@infradead.org>
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

Hi Christoph,

On 29/06/22 18:25, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 09:38:00AM +1200, Michael Schmitz wrote:
>> That's one of the 'liberties' I alluded to. The reason I left these in is
>> that I'm none too certain what device feature the DMA API uses to decide a
>> device isn't cache-coherent.
> The DMA API does not look at device features at all.  It needs to be
> told so by the platform code.  Once an architecture implements the
> hooks to support non-coherent DMA all devices are treated as
> non-coherent by default unless overriden by the architecture either
> globally (using the global dma_default_coherent variable) or per-device
> (using the dev->dma_coherent field, usually set by arch_setup_dma_ops).
Haven't got any of that, so non-coherent DMA is all we can use (even 
though some of the RAM used for bounce buffers may actually be coherent 
due to the page table cache bits).
>
>> If it's dev->coherent_dma_mask, the way I set
>> up the device in the a3000 driver should leave the coherent mask unchanged.
>> For the Zorro drivers, devices are set up to use the same storage to store
>> normal and coherent masks - something we most likely want to change. I need
>> to think about the ramifications of that.
> No, the coherent mask is slightly misnamed amd not actually related.

Thanks, that had me confused.

Cheers,

     Michael


