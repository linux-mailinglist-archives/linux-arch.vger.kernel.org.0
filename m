Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49455BBA85
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIQVCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIQVCN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 17:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3D2BB09
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663448530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exjrZBoAB9OswSJ+2snEFZtWR7Bm/d7rxWnSNZBLWA4=;
        b=MmsZkj541yhEKMoRNsQXwFXgk65UXiIdqZ+6L9orbpl1y7A8W/UNpeIeJ4+cC11KnwE2GC
        hXH928VU2zH1f6EXnSjSTPpZsetfXTvoGSsOP8xTTUhZHpVdrQcDGuAz5a23rqjmEOR4OI
        SVF9VD4OZAr8hz0cLijz/6WSuMsq7kQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-RYmQivWQO8SOzwcsBsb-iQ-1; Sat, 17 Sep 2022 17:02:08 -0400
X-MC-Unique: RYmQivWQO8SOzwcsBsb-iQ-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b00452c6289448so8029342edd.17
        for <linux-arch@vger.kernel.org>; Sat, 17 Sep 2022 14:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=exjrZBoAB9OswSJ+2snEFZtWR7Bm/d7rxWnSNZBLWA4=;
        b=kQyqJjnC7PDxFH/s0Da+lxm9NBPptirCLvW2gc0Ekuqcc+6dhzeDzvUZ3FCnRMObkx
         H5r/6zKRDQ/ktcet8rNCnaYlz1yO0vlp01qBljNJ92ub1Ft9IIcy8dzCJHrWor3IM1e5
         2f0sLbN3BX8VYRW6eKhKTgQfxc0BaFOqiiK2cKdOcFDEBjkLBb74MgnOwBPwsdfsaPxA
         4EIb/o8/QWf6wmiKlJwgn9QITXTgw2YWsdNDQCRHBGf04el97Nklg27aEcZa4drWaIoj
         Si0COeHIqFnHmDS8kLus8LkMAYwxWvfxiCjWwwVYYm56DZx5fJ+VneT0NFXLyeQM8907
         UrBA==
X-Gm-Message-State: ACrzQf2oiKTFyyMsxf4rEpgPtElZnwpndYEzgopZhCsI1ExFFrL2PtEv
        XOxBEbpxqqo2oaf/lW6DMNRlfSn/hV9HoFSoLSTUOLB69ptVCd/KnfRikAlLdyUCmbTh68043Vw
        O30s2qSjLRm89lQgP/zXdEg==
X-Received: by 2002:a05:6402:241e:b0:443:be9:83c0 with SMTP id t30-20020a056402241e00b004430be983c0mr9417563eda.24.1663448527316;
        Sat, 17 Sep 2022 14:02:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5BDIYTlR9dOu6lgXF8p40ynxtoORH0r/SKn2QxzLu/3INeGEePtuPsB3l9DLjSPecp4ikOcQ==
X-Received: by 2002:a05:6402:241e:b0:443:be9:83c0 with SMTP id t30-20020a056402241e00b004430be983c0mr9417549eda.24.1663448527166;
        Sat, 17 Sep 2022 14:02:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b00780ab5a9116sm2880143ejh.211.2022.09.17.14.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 14:02:06 -0700 (PDT)
Message-ID: <8d9c5cb5-ef1e-d46e-bfa6-39c80e3f060e@redhat.com>
Date:   Sat, 17 Sep 2022 23:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V3] LoongArch: Add ACPI-based generic laptop driver
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mark Gross <markgross@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220917065250.1671718-1-chenhuacai@loongson.cn>
 <80b46671-6d01-f2a2-7b9b-cb4c27cc87c6@redhat.com>
 <CAAhV-H7zwtJ06=2LQXg_uonRA8vzUif4AQNbzF_L2jewf7cVTA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAhV-H7zwtJ06=2LQXg_uonRA8vzUif4AQNbzF_L2jewf7cVTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 9/17/22 17:39, Huacai Chen wrote:
> Hi, Hans,
> 
> On Sat, Sep 17, 2022 at 6:00 PM Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>>> +     /* Prepare input device, but don't register */
>>> +     generic_inputdev->name =
>>> +             "Loongson Generic Laptop/All-in-one Extra Buttons";
>>> +     generic_inputdev->phys = ACPI_LAPTOP_DRVR_NAME "/input0";
>>> +     generic_inputdev->id.bustype = BUS_HOST;
>>> +     generic_inputdev->dev.parent = NULL;
>>> +
>>> +     /* Init subdrivers */
>>> +     for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++) {
>>> +             ret = generic_subdriver_init(&generic_sub_drivers[i]);
>>> +             if (ret < 0) {
>>> +                     input_free_device(generic_inputdev);
>>> +                     return ret;
>>> +             }
>>> +     }
>>
>> I see above that you have only 1 subdriver. Do you expect there to be
>> more in the future ?  If not then it would be better to just completely
>> remove the subdriver abstraction and simply do everything directly
>> from the main probe/remove functions (see below).
> At this time we only add the most basic subdriver, and more subdrivers
> will be added, so I want to keep it here.

Ok, that is fine.

Regards,

Hans

