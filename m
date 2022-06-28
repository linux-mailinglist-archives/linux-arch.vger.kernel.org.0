Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E055F218
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 01:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiF1XuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 19:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiF1XuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 19:50:17 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496503917E;
        Tue, 28 Jun 2022 16:50:15 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so14300314pjb.2;
        Tue, 28 Jun 2022 16:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SkmGWod1utKevQCGJfPo61gCs9z/vOcHKNlbLZdqJ/g=;
        b=EJF6TCv+QdstsKjx9+Ll8rT4I6VWrHZYep+wOwkBBsFSeb+amOrTW3NOT8BhW4wqLP
         7cSVavxsDll6Uwo4NYGjljVXHi1V6tQDTDrfJfLT/eL/P9aIUs8yEcIntYP6lGdv7Mr+
         /X9wAwva55pxgYE2OP//TnhvIdpsBsShY+JFCz+O7rrgmrYuFfjAjckVHyj+OZZeerzw
         RB4zIe5n3FjcZrUEim692E+sbgmQs+7LRgeOGZpBKIGzNplYTcfA2ic5EhH2WET824d6
         kNsht2MEPw5/Ka8eK/0q1EiUwcsNcAFtDHDcZsZzbrZto1WZwx99Cn1jPjCgJ1R2pyS5
         DH+g==
X-Gm-Message-State: AJIora9Mu1rfq1bUY1HAr3jSQ8g4kSZySnMESMNgqLO8e3Cpy5Qg4G+7
        laDnT5mynD00DGdfQ+iHaG4=
X-Google-Smtp-Source: AGRyM1tnnxYUcJUuaxfKTDWykUv9yEoY4oVypBD4NkfNBc/cSEjrtWY1RB48/mXAX8MoxReO3fVA2g==
X-Received: by 2002:a17:90b:4c0d:b0:1ed:2466:c0d3 with SMTP id na13-20020a17090b4c0d00b001ed2466c0d3mr2517451pjb.6.1656460214627;
        Tue, 28 Jun 2022 16:50:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id cr9-20020a056a000f0900b0052594a3ba89sm6923182pfb.65.2022.06.28.16.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 16:50:13 -0700 (PDT)
Message-ID: <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
Date:   Tue, 28 Jun 2022 16:50:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
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
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/28/22 16:09, Michael Schmitz wrote:
> On 29/06/22 09:50, Arnd Bergmann wrote:
>> On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz 
>> <schmitzmic@gmail.com> wrote:
>>> On 28/06/22 19:03, Geert Uytterhoeven wrote:
>>>>> The driver allocates bounce buffers using kmalloc if it hits an
>>>>> unaligned data buffer - can such buffers still even happen these days?
>>>> No idea.
>>> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
>>> code path is still being used.
>> kmalloc() guarantees alignment to the next power-of-two size or
>> KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
>> is cacheline aligned.
> 
> And all SCSI buffers are allocated using kmalloc? No way at all for user 
> space to pass unaligned data?
> 
> (SCSI is a weird beast - I have used a SCSI DAT tape driver many many 
> years ago, which broke all sorts of assumptions about transfer block 
> sizes ... but that might actually have been in the v0.99 days, many 
> rewrites of SCSI midlevel ago).
> 
> Just being cautious, as getting any of this tested will be a stretch.

An example of a user space application that passes an SG I/O data buffer 
to the kernel that is aligned to a four byte boundary but not to an 
eight byte boundary if the -s (scattered) command line option is used: 
https://github.com/osandov/blktests/blob/master/src/discontiguous-io.cpp

Bart.
