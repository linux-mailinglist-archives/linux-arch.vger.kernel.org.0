Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46655F06E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiF1ViN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 17:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiF1ViN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 17:38:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B00B7B;
        Tue, 28 Jun 2022 14:38:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 68so13393957pgb.10;
        Tue, 28 Jun 2022 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WjW+6GW3ETFm2JU8jE79XhUoTv6z3/GSxYftllUP/xs=;
        b=Hl4POJee6IPPulGeCkhFVzmaewHFoLW/+/aEoDQjxUpbODhZ1oymIgaTqZ81qNcby5
         tayUWDYOl9MImX18J8dQD7IqMr+zmUU1bqZHU+pNimB587Iq3zDvd9733Lpd08PJ3ZqN
         hCcDuWiBdimpZlnAS7LXz+VIQLfHxUzeRmXR/DhhOL+83rGT7oCb0qCs+I3LD5qbJUOY
         Z7gwLbNztnnB2BuHaZLhgR2hoazBRvaRufJfP7NUdv99H5O/s5nLD+ERJ1SZjBEJ5o3/
         g1yNYiH51zSIYiit2licB5Pp4Mw6FaB2n5sZmRFysJGeMTkqmhnQmnjN1azWYVr/4Saz
         dDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WjW+6GW3ETFm2JU8jE79XhUoTv6z3/GSxYftllUP/xs=;
        b=f2wa68tdcB1EJBEBD9egwCf85hVewX+aAvW4ic7N5atk2Y15nx8sE0dCnEggoImUph
         UjeA5Qfo75sW+NdsIvD9EHY9LD7i1VxY+Ojou7YfMvG2CGetEeDnYKAQylQ6ONDUc8CX
         nbfZRfwBbxEK5r8i14BoG4fvuGEU5bMN3B4woW2aXc3VjoB4sCGFN+S+RGdMmwxl9QCk
         T5Z1mG2Uzd5zpoAD2StT+ybn1l4KKokkT+3GQAEMoMhYCbr6uonCTgq5NdFMFJ8GGKEq
         9uR6NOA9lVo3XdNVRVo4rAye2EcpdnkDRkUAdsP10atJSo+BPCDRgkJEtZZyriPg9Sfv
         gLXw==
X-Gm-Message-State: AJIora/blAk/JCjNaQ5M0dMbtnRj2u0RFEYAl/dBeDoUIFyelW2w7+KR
        zuezxLizQmQ4McYE2EMiO+k=
X-Google-Smtp-Source: AGRyM1sFO6YgYAr9GnaRe8/Ve8aBPD9B79jMLNzzxljl0q+mxUt4Mwk0qg0QIVqzTJY3FgSvSPWrFw==
X-Received: by 2002:a63:3545:0:b0:40c:95f7:d114 with SMTP id c66-20020a633545000000b0040c95f7d114mr5443pga.150.1656452290295;
        Tue, 28 Jun 2022 14:38:10 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033? ([2001:df0:0:200c:75aa:d6ca:4354:6033])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00168a651316csm9770467plk.270.2022.06.28.14.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 14:38:09 -0700 (PDT)
Message-ID: <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
Date:   Wed, 29 Jun 2022 09:38:00 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
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

Hi Arnd,

On 28/06/22 19:08, Arnd Bergmann wrote:
> On Tue, Jun 28, 2022 at 5:25 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
>>
>> Leaving the bounce buffer handling in place, and taking a few other
>> liberties - this is what converting the easiest case (a3000 SCSI) might
>> look like. Any obvious mistakes? The mvme147 driver would be very
>> similar to handle (after conversion to a platform device).
>>
>> The driver allocates bounce buffers using kmalloc if it hits an
>> unaligned data buffer - can such buffers still even happen these days?
>> If I understand dma_map_single() correctly, the resulting dma handle
>> would be equally misaligned?
>>
>> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
>> even though AFAIU memory used for DMA buffers generally isn't consistent
>> on m68k?
> I think it makes sense to skip the bounce buffering as you do here:
> the only standardized way we have for integrating that part is to
> use the swiotlb infrastructure, but as you mentioned earlier that
> part is probably too resource-heavy here for Amiga.
OK, leaving the old custom logic in place allows to convert the 24 bit 
DMA drivers more easily.
>
> I see two other problems with your patch though:
>
> a) you still duplicate the cache handling: the cache_clear()/cache_push()
> is supposed to already be done by dma_map_single() when the device
> is not cache-coherent.

That's one of the 'liberties' I alluded to. The reason I left these in 
is that I'm none too certain what device feature the DMA API uses to 
decide a device isn't cache-coherent. If it's dev->coherent_dma_mask, 
the way I set up the device in the a3000 driver should leave the 
coherent mask unchanged. For the Zorro drivers, devices are set up to 
use the same storage to store normal and coherent masks - something we 
most likely want to change. I need to think about the ramifications of 
that.

Note that zorro_esp.c uses dma_sync_single_for_device() and uses a 32 
bit coherent DMA mask which does work OK. I might  ask Adrian to test a 
change to only set dev->dma_mask, and drop the 
dma_sync_single_for_device() calls if there's any doubt on this aspect.

> b) The bounce buffer is never mapped here, instead you have the
> virt_to_phys() here, which is not the same. I think you need to map
> the pointer that actually gets passed down to the device after deciding
> to use a bouce buffer or not.

I hadn't realized that I can map the bounce buffer just as it's done for 
the SCp data buffer. Should have been obvious, but I'm still learning 
about the DMA API.

I've updated the patch now, will re-send as part of a complete series 
once done.

Cheers,

     Michael


>
>       Arnd
