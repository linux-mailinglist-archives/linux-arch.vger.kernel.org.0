Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183E55D14C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiF0IKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiF0IKI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 04:10:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01F560F5;
        Mon, 27 Jun 2022 01:10:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id n12so8333861pfq.0;
        Mon, 27 Jun 2022 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Kp9FmTyX7dGRB9FFbW8qRxYhCrBAW1WHUiTJLo4/9H4=;
        b=K613IOtiRm08GX4X7oLeBesl1pBHqqYHcDPxV7/3JEOF5n76WCWDPXYNIgN0NseE0r
         8bhO3DE3uflpJFhEfLuanvcY7ac1lLtGB/8aZNJ1w8d3jV6V1SXnxHfkCRZIkH+m60fi
         ilVcVdkV5hD1+m3AzPdKtBDW9iqf+vzUo0E9kO/Oxbv+90q0xA8uOJhRB2Gz3SW5oEWi
         yKk2yydgdryqRmqfaDuIl43PVHCXytxBCYpQ5I2V4y5AEhtLIR3BDFYDUcWk3s24zyZI
         ERJQUFowl0fWdYSG/t8vSvdCVgNdMU6LggXDVdbEtT+SZx0p1RxJ0xGekYMy+MddZSUr
         wYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Kp9FmTyX7dGRB9FFbW8qRxYhCrBAW1WHUiTJLo4/9H4=;
        b=mcP8nfCwrJo9ffxhw6K0c7s/ERC6gMcQxrjz8Ak++nrITeKJc4lfBpLKM/Wga+O4an
         +daghyrFIZCeP5qgpQpBm0ILbAAHqsd8YCsAsdYmyUuFbBj/81QQ4HaxVZO0DLIPcqUb
         pAvZcWr3XTCxrd0qP1uI8+YhU3YEF0xHiE4MGMo5/MxSuqwLVFBLo9iYr6pdFT99oMGF
         l25DH0KSKcI5uePlL6zwJiTgs8FsaI1GOlObEHOCysFkROPX/m7B47Zy0o0DeFNQEWHD
         EN1LFSgFbkPyiThzAq5P2Sri2rJKXP877PUMm39b3ZsE4qFg2Kt3cO7AlaCHqCp+DktI
         kDlA==
X-Gm-Message-State: AJIora90ORWReK6fYnuFwQ8ycV7MXHYi571Gj8Zpn2PPKWtli98+OAuG
        98vZO6d3K0ylMnxce4G9dU4=
X-Google-Smtp-Source: AGRyM1sg7iF/y7vKHgXwujHvRSIecgmir4U7fRrNlW+Dv0GKekuR9SBw+l3PLY+27c36Xro7hy0FTA==
X-Received: by 2002:a63:794e:0:b0:40d:99b:bb4 with SMTP id u75-20020a63794e000000b0040d099b0bb4mr11868551pgc.133.1656317407267;
        Mon, 27 Jun 2022 01:10:07 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090ad70300b001ecdd9507b9sm6536341pju.26.2022.06.27.01.09.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:10:06 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
 <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
 <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1fa7f932-ed3d-974c-dccb-de628191993d@gmail.com>
Date:   Mon, 27 Jun 2022 20:09:46 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd,

Am 26.06.2022 um 20:36 schrieb Arnd Bergmann:
>> There are no platform specific header files other than asm/amigahw.h and
>> asm/mvme147hw.h, currently only holding register address definitions.
>> Would it be OK to add m68k_virt_to_bus() in there if it can't remain in
>> asm/virtconvert.h, Geert?
>
> In that case, I would just leave it under the current name and not change
> m68k at all. I don't like the m68k_virt_to_bus() name because there is
> not anything CPU specific in what it does, and keeping it in a common
> header does nothing to prevent it from being used on other platforms
> either.

Fair enough.

>>>> 32bit powerpc is a different matter though.
>>>
>>> It's similar, but unrelated. The two apple ethernet drivers
>>> (bmac and mace) can again either get changed to use the
>>> dma-mapping interfaces, or get a custom pmac_virt_to_bus()/
>>> pmac_bus_to_virt() helper.
>>
>> Hmmm - I see Finn had done the DMA API conversion on macmace.c which
>> might give some hints on what to do about mace.c ... no idea about
>> bmac.c though. And again, haven't got hardware to test, so custom
>> helpers is it, then.
>
> Ok.

Again, no platform specific headers to shift renamed helpers to, so may 
as well keep this as-is.

Cheers,

	Michael


>
>           Arnd
>
