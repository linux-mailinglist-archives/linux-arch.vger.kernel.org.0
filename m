Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C746041DFA8
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbhI3RAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 13:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344261AbhI3RAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633021135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZIqihkoQq6wIRYi9LhWdCqUUXnDlaND1FW0gU9oESk=;
        b=URRKfKKmc6Hp13hSYXiFatp0XEbVKKmFHyLq1rzgwfUf/2nEapSFo7zMkNz6uBuccGIjyd
        yFm8iklcuf+rYLd90Th2JKdsNyrqKgHRkO+HoxoD0u2e9dHJBN4v+I77gFGCFych9FStJV
        fwANpFM28HeVgzDQ9NAhVIU4iD1Zm8s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-H9eAeOCzOEiypiJOBA62_g-1; Thu, 30 Sep 2021 12:58:54 -0400
X-MC-Unique: H9eAeOCzOEiypiJOBA62_g-1
Received: by mail-qv1-f71.google.com with SMTP id p75-20020a0c90d1000000b0037efc8547d4so11169767qvp.16
        for <linux-arch@vger.kernel.org>; Thu, 30 Sep 2021 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1ZIqihkoQq6wIRYi9LhWdCqUUXnDlaND1FW0gU9oESk=;
        b=boizRJUfhNRdOmEjleHb8O0z3igBe0HS5HzSB+Gtyjuxkl24IJzWksCa3GcQij7CGI
         qBBIU4RXSVm/Eb2bE5MH4P5ca6OD9lpS/ThgMeJy0rBGAJq/TDqT6EDPdhPm7TUJ8ltp
         fxS6O0gT/neFZA5bc0cNvUimgcog3IM2w4s1kMVLOETaecp1ugHwZ6l4NcUCZKDC8pEM
         xpZTBIxuPnKdGut0BOTUWbqGz8HN4IZOCUEu+rkxS50ZtwS7QGLC7BhG6PeLv8oJp5AZ
         43MnAXI68FZHV2rDtn2MMC9UHpRHS7Q82SBaCEMuxqINOb6hAeAWfdrjDOU8GdqycNzY
         Tgcg==
X-Gm-Message-State: AOAM532E+i0kInYp0tmYsvteOff/1q4KEKbItgFwnQNS11guAkPbS21R
        16MfJBI1SfRzUaThZ9QDZJZg+pCRv6wHs+cgTcumBqzYtrHSNfVWIrWv97DlzNgdoS94rMVRkqP
        BitW0dVIbhq5WyMSEAgCPAw==
X-Received: by 2002:a05:622a:3cb:: with SMTP id k11mr7575867qtx.233.1633021133602;
        Thu, 30 Sep 2021 09:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAebG6rBOzuQnF7H08UlB7Hf8EqfYw6Ix04hP8U3b1W+2X0tPZ5kxUQJS2/YkFCWH8K3GZSw==
X-Received: by 2002:a05:622a:3cb:: with SMTP id k11mr7575844qtx.233.1633021133402;
        Thu, 30 Sep 2021 09:58:53 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o13sm2111020qtk.37.2021.09.30.09.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:58:52 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
To:     Barry Song <21cnbao@gmail.com>, alex.kogan@oracle.com
Cc:     arnd@arndb.de, bp@alien8.de, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, guohanjun@huawei.com, hpa@zytor.com,
        jglauber@marvell.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de, will.deacon@arm.com,
        x86@kernel.org
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210930094447.9719-1-21cnbao@gmail.com>
Message-ID: <a6340beb-3b4a-2518-9340-ea0fc7583dbe@redhat.com>
Date:   Thu, 30 Sep 2021 12:58:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210930094447.9719-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/30/21 5:44 AM, Barry Song wrote:
>> We have done some performance evaluation with the locktorture module
>> as well as with several benchmarks from the will-it-scale repo.
>> The following locktorture results are from an Oracle X5-4 server
>> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
>> cores each). Each number represents an average (over 25 runs) of the
>> total number of ops (x10^7) reported at the end of each run. The
>> standard deviation is also reported in (), and in general is about 3%
>> from the average. The 'stock' kernel is v5.12.0,
> I assume x5-4 server has the crossbar topology and its numa diameter is
> 1hop, and all tests were done on this kind of symmetrical topology. Am
> I right?
>
>      ┌─┐                 ┌─┐
>      │ ├─────────────────┤ │
>      └─┤1               1└┬┘
>        │  1           1   │
>        │    1       1     │
>        │      1   1       │
>        │        1         │
>        │      1   1       │
>        │     1      1     │
>        │   1         1    │
>       ┌┼┐1             1  ├─┐
>       │┼┼─────────────────┤ │
>       └─┘                 └─┘
>
>
> what if the hardware is using the ring topology and other topologies with
> 2-hops or even 3-hops such as:
>
>       ┌─┐                 ┌─┐
>       │ ├─────────────────┤ │
>       └─┤                 └┬┘
>         │                  │
>         │                  │
>         │                  │
>         │                  │
>         │                  │
>         │                  │
>         │                  │
>        ┌┤                  ├─┐
>        │┼┬─────────────────┤ │
>        └─┘                 └─┘
>
>
> or:
>
>
>      ┌───┐       ┌───┐      ┌────┐      ┌─────┐
>      │   │       │   │      │    │      │     │
>      │   │       │   │      │    │      │     │
>      ├───┼───────┼───┼──────┼────┼──────┼─────┤
>      │   │       │   │      │    │      │     │
>      └───┘       └───┘      └────┘      └─────┘
>
> do we need to consider the distances of numa nodes in the secondary
> queue? does it still make sense to treat everyone else equal in
> secondary queue?

The purpose of this patch series is to minimize cacheline transfer from 
one numa node to another. Taking the fine grained detail of the numa 
topology into account will complicate the code without much performance 
benefit from my point of view. Let's keep it simple first. We can always 
improve it later on if one can show real benefit of doing so.

Cheers,
Longman


