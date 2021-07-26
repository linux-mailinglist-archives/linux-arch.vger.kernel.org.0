Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9583B3D688E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGZUkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 16:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232504AbhGZUkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 16:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627334458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xim6bdht22BrjCKEPJR4zAHmqMdradXeETF8ZAhZEOg=;
        b=Ao93IhJhQZTABtFe00817BwFn4GthnreMo2EpceLmQpp/PNQ8oxSh4DGAaNkQqJ6GCaJwG
        mq/REmzE5dJo1uswmlVlWilFse3Ogw5O26ovgP60xizTkWSjIF7FQgZ7nbBm7kNS9ra6pK
        bNIz2tyk8bdAg3OVgHxpEmxlisMOTXA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-6JKuS40WO-6pA1F-LukwWQ-1; Mon, 26 Jul 2021 17:20:57 -0400
X-MC-Unique: 6JKuS40WO-6pA1F-LukwWQ-1
Received: by mail-qk1-f197.google.com with SMTP id c5-20020a05620a2005b02903b8d1e253a9so10004521qka.11
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 14:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xim6bdht22BrjCKEPJR4zAHmqMdradXeETF8ZAhZEOg=;
        b=BHSJr8K9GknNU3I8fEzRgXdzj7Wox6pwTevvkCuVoCxwOpRSJiwqz+2dWrA8c2cG03
         FccrwoXBdBiHZjkMqTE4JMPNEw+Obuy+IndID+HJ1wHrR1GgrJ0GyROr1NCTPO2fgneM
         leftLpGIVKjEgePf/NFrQgrt/gPrP80x36d7hdnrMrr4fiABLAM4QWg6gQqJ+H/jXc/L
         8TtTbeoHH1yxXX3N2c37dXfPAC+GVKtKTR7dPUYV/Y0drx8obvY7Hyrb46q3K5ww8YWd
         w2B6pLeYeR6SOSv+R7IqUl0INCb5XfyJs76pkFRJHn5Ir1T5VS/EMcUh3QbV/2Ar52nQ
         hxtQ==
X-Gm-Message-State: AOAM533A+wIalmEURBZOUe9z63/xPkynvcbaKxCR3QssZ2AR1cscmAWz
        YNL1yseHVD0kJY9bGYrh+J/x6ezxU/lG3f2OaRPyQvB238P2WbDsYYH8a4A+5ZOKO6gEOh0uXpq
        ku6EEhK1KyGDoG0mwIYgtuw==
X-Received: by 2002:a37:9ec1:: with SMTP id h184mr19403559qke.0.1627334457358;
        Mon, 26 Jul 2021 14:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyixwr222cEEqcKMj8DdxDsQTDpmMX49mnyTQgvlZhoUw0TsyPgGGpabnW0lxAAyoDWi8BuqQ==
X-Received: by 2002:a37:9ec1:: with SMTP id h184mr19403545qke.0.1627334457143;
        Mon, 26 Jul 2021 14:20:57 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x7sm506931qtw.24.2021.07.26.14.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 14:20:56 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
Message-ID: <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
Date:   Mon, 26 Jul 2021 17:20:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP7q5GBweaeWgvcs@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/26/21 1:03 PM, Boqun Feng wrote:
> On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
>> On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>> On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
>>>> Hi, Geert,
>>>>
>>>> On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>> Hi Huacai,
>>>>>
>>>>> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>>>>>> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
>>>>>> has hardware sub-word xchg/cmpxchg support. This option will be used as
>>>>>> an indicator to select the bit-field definition in the qspinlock data
>>>>>> structure.
>>>>>>
>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/arch/Kconfig
>>>>>> +++ b/arch/Kconfig
>>>>>> @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
>>>>>>            An architecture should select this when it can successfully
>>>>>>            build and run with CONFIG_FORTIFY_SOURCE.
>>>>>>
>>>>>> +# Select if arch has hardware sub-word xchg/cmpxchg support
>>>>>> +config ARCH_HAS_HW_XCHG_SMALL
>>>>> What do you mean by "hardware"?
>>>>> Does a software fallback count?
>>>> This new option is supposed as an indicator to select bit-field
>>>> definition of qspinlock, software fallback is not helpful in this
>>>> case.
>>>>
>>> I don't think this is true. IIUC, the rationale of the config is that
>>> for some architectures, since the architectural cmpxchg doesn't provide
>>> forward-progress guarantee then using cmpxchg of machine-word to
>>> implement xchg{8,16}() may cause livelock, therefore these architectures
>>> don't want to provide xchg{8,16}(), as a result they cannot work with
>>> qspinlock when _Q_PENDING_BITS is 8.
>>>
>>> So as long as an architecture can provide and has already provided an
>>> implementation of xchg{8,16}() which guarantee forward-progress (even
>>> though the implementation is using a machine-word size cmpxchg), the
>>> architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
>> Seems only atomic could provide forward progress, isn't it? And lr/sc
>> couldn't implement xchg/cmpxchg primitive properly.
>>
> I'm missing you point here, a) ll/sc can provide forward progress and b)
> ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> PPC).
>
>> How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
>> these instructions and lock the snoop channel?
>> Maybe hardware guys would think that it's easier to implement cas +
>> dcas + amo(short & byte).
>>
> Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
> implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> of xchg16() doesn't provide forward-progress in an architecture, neither
> does xchg_tail().

Agreed. The xchg_tail() for the "_Q_PENDING_BITS == 1" case is a 
software emulation of xchg16(). Pure software emulation like that does 
not provide forward progress guarantee. This is usually not a big 
problem for non-RT kernel for which occasional long latency is 
acceptable, but it is not good for RT kernel.

Cheers,
Longman

