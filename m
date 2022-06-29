Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAE55F244
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 02:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiF2AOy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 20:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF2AOx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 20:14:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6C522516;
        Tue, 28 Jun 2022 17:14:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o18so12546375plg.2;
        Tue, 28 Jun 2022 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=05ASLe35KlS/635AYkr9ttdQBevoBXGVkR7t9AbxzS8=;
        b=dzzx4WtXS/WkHpvykE0Ug4pI7IQoDYpxYcwT22eGTgXydtRyVau06KToMULz4WZ85p
         grc9sV1BmBI096bjPV6AYIg+FD5hBe5gj3092gLAqIoDR6Usno3qkCUxW0him8f4Kt+7
         5Uf02V1S6CU9QXgRzjHroyahVKDiR/lHNsV044fz9JWOwGa1zg1AbzobwrAmZjbW8zFF
         NJWZj5bNSbN92/C5/1fpmT4IbOePFpLv8AN2psJq3YvTqAwnlZ6jrlyHQy1YHFlzFM4V
         6GGIoWoQqCmV+YlWQVYdo/a8/uHvejllTjqLg43Sy9OxgGuiI2LvtGtvLWOWEwxpHjVI
         SvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=05ASLe35KlS/635AYkr9ttdQBevoBXGVkR7t9AbxzS8=;
        b=Vehktr0tLQ/RatkkMM7U7Ezp4A+PPnWPsGkhNKzqPNYTLYGCS7kgvqjJpmsA/mT7Zj
         yuvSRCJdX0rZ8jf8bltL227l5vJ5TnKH3BQLN2o9JdXK6z45ItHIN9QIlh8poaVXVOly
         LVfiDLKolykD+2394olkL8jBGXg/xczVDuQQqDzvgULle9V5d1O8q3IFOqpf4pDJGAvf
         uneGraK+opAVRalhv+KFTUXaNcaRz1rdaOiy6BDwk/F1u/KWbSHluPh4mn1bi2p4gOrh
         wf/VWgnZJ4l9pPskCDuV+LM2Qmp82QXwiHAvt0hW8NMHH0IO9O+QFRWdNeSrSjhMX/gF
         kFuw==
X-Gm-Message-State: AJIora9K8YNA9F+SXHUMwVRNw/fqek8+4LScMtZBjYoRbWtTgOHTJ8xC
        bBLhSUjNLmVTB2HYDqVKA0A=
X-Google-Smtp-Source: AGRyM1s6BvhKknOd3DGT0QQr5uB83fgcSZ645ndGItCzAFy4UPsuv2Gt9Oy4n8CrGTj/IyliMMkT6Q==
X-Received: by 2002:a17:903:240e:b0:168:ea13:f9e0 with SMTP id e14-20020a170903240e00b00168ea13f9e0mr7684101plo.6.1656461692074;
        Tue, 28 Jun 2022 17:14:52 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033? ([2001:df0:0:200c:75aa:d6ca:4354:6033])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0016a276aada7sm9950167plc.20.2022.06.28.17.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 17:14:51 -0700 (PDT)
Message-ID: <2402062b-aae6-a247-06a8-3775c2909bdb@gmail.com>
Date:   Wed, 29 Jun 2022 12:14:42 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
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
 <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
 <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
In-Reply-To: <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
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

Hi Bart,

On 29/06/22 12:01, Michael Schmitz wrote:
>
>> An example of a user space application that passes an SG I/O data 
>> buffer to the kernel that is aligned to a four byte boundary but not 
>> to an eight byte boundary if the -s (scattered) command line option 
>> is used: 
>> https://github.com/osandov/blktests/blob/master/src/discontiguous-io.cpp
>
> Thanks - four byte alignment actually wouldn't be an issue for me. 
> It's two byte or smaller that would trip up the SCSI DMA.
>
> While I'm sure such an even more pathological test case could be 
> written, I was rather worried about st.c and sr.c input ...
Nevermind - I just see m68k defines ARCH_DMA_MINALIGN to be four bytes. 
Should be safe for all that matters, then.

Cheers,

     Michael


