Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC63DBE74
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhG3Skl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 14:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhG3Skj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 14:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627670432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3VUm09HRjzyVdvGrdFxz4pkI4m7bmJUChTQiJGRYAM=;
        b=ZtakFV3NMEzKdN61e8I8qE5bU4xtknXHqY103XpR6jk53jReUObNeKhvh8Et3pMBUpEXEY
        qK6Zn/W/3Fn4skEQHYbbEa9/P4tR+IXI4Yz/veNiE+R3R6yB2xrEwysIV91jO0dzHrvd9b
        gWADbhhIjPbwWgtrJQuLzOo3yaJF+YA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-w8sipduXNPuARMiRnnssAQ-1; Fri, 30 Jul 2021 14:40:31 -0400
X-MC-Unique: w8sipduXNPuARMiRnnssAQ-1
Received: by mail-qt1-f199.google.com with SMTP id g10-20020ac8768a0000b029023c90fba3dcso4841399qtr.7
        for <linux-arch@vger.kernel.org>; Fri, 30 Jul 2021 11:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O3VUm09HRjzyVdvGrdFxz4pkI4m7bmJUChTQiJGRYAM=;
        b=B65WB/SuFixd6TNAYGQ2qrPmXhK2+YbGEg3n6h+OlxcySNCDk7RoVbEeHwHn9ADAuh
         H60n+jo05QaDHK/Mx0Ts6AbgxU9VBcNtRqtr7wM+mgCtlnvdVxOYpa2JSMrzx17Dhesg
         UDjacO2FSmg/ctFmrmXD+Jph6kkwrToomPJTCapldVIUF5tFlcMAbwG63ujf6qQRhj5c
         D+Ss+8QKhYswD5xHxKpLHbyyvDieYcmXW6C1LdDP0V1+zyXHrglNfn+e+spTAJQQv6JR
         8oo5DXl0lMBi9z+rB48tp3ztzTCaHqRydn+dQ5NnOBKHSw+ujvSqW77I9otB2q3BFOEN
         F8rQ==
X-Gm-Message-State: AOAM531MrX2HWlIdGRq4KidaYljWCgxJPcNuZxiArMjADy2Eu63q+Pqn
        R/BxJ6DD0B+LcrNbSjOWZoKHfecgOctz3fbZoDw4n2PoosV68rcXUKEWZ5xq0uG/pS7sgvLI1jd
        v3CnhtNYjAHE58ZL0iv2NMQ==
X-Received: by 2002:a37:66d6:: with SMTP id a205mr3578713qkc.422.1627670430641;
        Fri, 30 Jul 2021 11:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydbZCs5e0C+UMhJz4Fc/mmq/3srHUfTYT5Xwt5gdhhZaC0GVFt4OJ9O5WHjTkxZ8kPPI0wew==
X-Received: by 2002:a37:66d6:: with SMTP id a205mr3578703qkc.422.1627670430446;
        Fri, 30 Jul 2021 11:40:30 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v5sm1310192qkh.39.2021.07.30.11.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 11:40:29 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     hev <r@hev.cc>, Will Deacon <will@kernel.org>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20210728114822.1243-1-wangrui@loongson.cn>
 <20210729093923.GD21151@willie-the-truck>
 <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com>
Message-ID: <7574da60-fb71-dad2-b099-a815a0a18c22@redhat.com>
Date:   Fri, 30 Jul 2021 14:40:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/29/21 6:18 AM, hev wrote:
> Hi, Will,
>
> On Thu, Jul 29, 2021 at 5:39 PM Will Deacon <will@kernel.org> wrote:
>> On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
>>> From: wangrui <wangrui@loongson.cn>
>>>
>>> This patch introduce a new atomic primitive 'and_or', It may be have three
>>> types of implemeations:
>>>
>>>   * The generic implementation is based on arch_cmpxchg.
>>>   * The hardware supports atomic 'and_or' of single instruction.
>> Do any architectures actually support this instruction?
> No, I'm not sure now.
>
>> On arm64, we can clear arbitrary bits and we can set arbitrary bits, but we
>> can't combine the two in a fashion which provides atomicity and
>> forward-progress guarantees.
>>
>> Please can you explain how this new primitive will be used, in case there's
>> an alternative way of doing it which maps better to what CPUs can actually
>> do?
> I think we can easily exchange arbitrary bits of a machine word with atomic
> andnot_or/and_or. Otherwise, we can only use xchg8/16 to do it. It depends on
> hardware support, and the key point is that the bits to be exchanged
> must be in the
> same sub-word. qspinlock adjusted memory layout for this reason, and waste some
> bits(_Q_PENDING_BITS == 8).

It is not actually a waste of bits. With _Q_PENDING_BITS==8, more 
optimized code can be used for pending bit processing. It is only in the 
rare case that NR_CPUS >= 16k - 1 that we have to fall back to 
_Q_PENDING_BITS==1. In fact, that should be the only condition that will 
make _Q_PENDING_BITS=1.

Cheers,
Longman

