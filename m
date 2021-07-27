Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468F13D6C13
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhG0CGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 22:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233727AbhG0CGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 22:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627354009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gc2qAAny6uI4PYy9y6akRkV/Lbr8I0Qm8GQKr/8cM5A=;
        b=EZWrts050mC9SSOmneOpMp+VYFI+2lR3dVhZ+98GzF5APeaIXFJcq4Qq7fAA08scj5hQTC
        kkqDj/0DhKfYIfqGb/zwanmKOKdlgeabZ5JPHpZxvivMIWjgU5u1ZyxSGXDPEsLyNUMvZ3
        l/MAj7jNHc+uNsI9wO1Iy4v3dgIrm4E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-oUk98P37MBWcHLl3zx-C1Q-1; Mon, 26 Jul 2021 22:46:48 -0400
X-MC-Unique: oUk98P37MBWcHLl3zx-C1Q-1
Received: by mail-qv1-f71.google.com with SMTP id b6-20020a0cbf460000b02902dbb4e0a8f2so7865942qvj.6
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 19:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Gc2qAAny6uI4PYy9y6akRkV/Lbr8I0Qm8GQKr/8cM5A=;
        b=iL2LNa44F7sFDRC8ief2fnApObkZTGr4dEDHh9/7k4LGC2g/emJb608gs6VSU1zI99
         pxLBcGdBgqZvKEtwD0lWhRf/itBK6THrWVFVsrnavkvRix9atvkRWbZtwNb9taVEdKFO
         NM/ptkA2n21g6Eyw9lGJg37lvxrwXJFm5rm2S7LULrwd8pDzBwf2GbUFrMOSt1YhxU9a
         RAx5HIV+CkgDWKxQPdfHkbq00eH3aSpEiCrunWo343y4A0Rtb4Q9D5Hz0c2Bals+QgYn
         dPnr5XQDjzohhSeQkj6rrA3zVb247chGS0HWDpLVt5AWcgru2fv16RpEy/cr6JfUNqpx
         jGwA==
X-Gm-Message-State: AOAM530OUtZ9yPrvRReSWnT9BSElvtrsSvqqdB8J35SC9M7j5ORtfFjd
        nmN6KHzBbdbWcxWw5B+4O2o5aRYtmoIn4428AZGHZbc/3qbL40C8koKPtd9o1hD6J3o2wvBSLAp
        O/Hbdyy5G/mLDRpEitPbigA==
X-Received: by 2002:a37:a00c:: with SMTP id j12mr19927072qke.249.1627354007879;
        Mon, 26 Jul 2021 19:46:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyInxx0D0TjHwYrv/LBf1kW3yjOtrJyCHHMMIa6GzDbJyzc7slzLpz4HkiHPty1tbBff6i//w==
X-Received: by 2002:a37:a00c:: with SMTP id j12mr19927063qke.249.1627354007668;
        Mon, 26 Jul 2021 19:46:47 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h2sm1097321qkf.106.2021.07.26.19.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 19:46:47 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <llong@redhat.com>, Huacai Chen <chenhuacai@gmail.com>,
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
 <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
 <YP9vp8/acj9TpwyZ@boqun-archlinux>
Message-ID: <eb9f3db3-042b-5e6a-89bb-a61f84f1f29a@redhat.com>
Date:   Mon, 26 Jul 2021 22:46:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP9vp8/acj9TpwyZ@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/26/21 10:29 PM, Boqun Feng wrote:
> On Tue, Jul 27, 2021 at 09:27:51AM +0800, Guo Ren wrote:
>> On Tue, Jul 27, 2021 at 5:21 AM Waiman Long <llong@redhat.com> wrote:
>>> On 7/26/21 1:03 PM, Boqun Feng wrote:
>>>> On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
>>>>> On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>>> On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
>>>>>>> Hi, Geert,
>>>>>>>
>>>>>>> On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>>>> Hi Huacai,
>>>>>>>>
>>>>>>>> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>>>>>>>>> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
>>>>>>>>> has hardware sub-word xchg/cmpxchg support. This option will be used as
>>>>>>>>> an indicator to select the bit-field definition in the qspinlock data
>>>>>>>>> structure.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>>>> Thanks for your patch!
>>>>>>>>
>>>>>>>>> --- a/arch/Kconfig
>>>>>>>>> +++ b/arch/Kconfig
>>>>>>>>> @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
>>>>>>>>>             An architecture should select this when it can successfully
>>>>>>>>>             build and run with CONFIG_FORTIFY_SOURCE.
>>>>>>>>>
>>>>>>>>> +# Select if arch has hardware sub-word xchg/cmpxchg support
>>>>>>>>> +config ARCH_HAS_HW_XCHG_SMALL
>>>>>>>> What do you mean by "hardware"?
>>>>>>>> Does a software fallback count?
>>>>>>> This new option is supposed as an indicator to select bit-field
>>>>>>> definition of qspinlock, software fallback is not helpful in this
>>>>>>> case.
>>>>>>>
>>>>>> I don't think this is true. IIUC, the rationale of the config is that
>>>>>> for some architectures, since the architectural cmpxchg doesn't provide
>>>>>> forward-progress guarantee then using cmpxchg of machine-word to
>>>>>> implement xchg{8,16}() may cause livelock, therefore these architectures
>>>>>> don't want to provide xchg{8,16}(), as a result they cannot work with
>>>>>> qspinlock when _Q_PENDING_BITS is 8.
>>>>>>
>>>>>> So as long as an architecture can provide and has already provided an
>>>>>> implementation of xchg{8,16}() which guarantee forward-progress (even
>>>>>> though the implementation is using a machine-word size cmpxchg), the
>>>>>> architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
>>>>> Seems only atomic could provide forward progress, isn't it? And lr/sc
>>>>> couldn't implement xchg/cmpxchg primitive properly.
>>>>>
>>>> I'm missing you point here, a) ll/sc can provide forward progress and b)
>>>> ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
>>>> PPC).
>>>>
>>>>> How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
>>>>> these instructions and lock the snoop channel?
>>>>> Maybe hardware guys would think that it's easier to implement cas +
>>>>> dcas + amo(short & byte).
>>>>>
>>>> Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
>>>> implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
>>>> of xchg16() doesn't provide forward-progress in an architecture, neither
>>>> does xchg_tail().
>>> Agreed. The xchg_tail() for the "_Q_PENDING_BITS == 1" case is a
>>> software emulation of xchg16(). Pure software emulation like that does
>>> not provide forward progress guarantee. This is usually not a big
>>> problem for non-RT kernel for which occasional long latency is
>>> acceptable, but it is not good for RT kernel.
>> "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
>> the arch could choose.
> I actually agree with this part, but this patchset failed to provide
> enough evidences on why we should choose xchg_tail() implementation
> based on whether hardware has xchg16, more precisely, for an archtecture
> which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
> worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
> performance reason, please show some numbers.
>
> In fact, why don't you introduce a ARCH_QSPINLOCK_USE_GENERIC_XCHG_TAIL,
> and only select it for csky and risc-v, and let other archs choose to
> select or it themselves? FWIW, qspinlock code looks like something
> below with this config:
>
>   #if (CONFIG_NR_CPUS < (1U << 14)) && !defined(CONFIG_ARCH_QSPINLOCK_USE_GENERIC_XCHG_TAIL)
>   #define _Q_PENDING_BITS                8
>   #else
>   #define _Q_PENDING_BITS                1
>
> Just my two cents.
>
The patch sent out by Guo Ren was actually similar to this approach [1]. 
I actually like it better than this patch because the pending bit 
handling is more optimized with "_Q_PENDING_BITS == 8". So we shouldn't 
force _Q_PENDING_BITS to 1 if we just want to avoid using xchg16().

[1] 
https://lore.kernel.org/lkml/1616868399-82848-4-git-send-email-guoren@kernel.org/

Cheers,
Longman

