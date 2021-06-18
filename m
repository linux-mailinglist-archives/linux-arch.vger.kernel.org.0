Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D63ACC82
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhFRNp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 09:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232427AbhFRNp2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jun 2021 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624023798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gNZOYxvHRh8WAbiF0tOQgle1Sg6oiAk/FOL9PrzSRM=;
        b=Gl1W5TEbPphPbjyDl1Yp/1vjpdOXpZXiR9aV2SLgW3dGuZ++D4GYq4+2uMoK17xjjZoGIg
        nPhTwv5PuZDEPMLkLseCAn34FRWgdV/gr1FVM7FQgvAmdxmFP1zleb7n1q7d3LzLy3Ugwf
        qJ+54Y9CrPxbtZ4fFEQ3ylhMXWB43ko=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-NBszeYc8PQGqwzpTJuvCjw-1; Fri, 18 Jun 2021 09:43:17 -0400
X-MC-Unique: NBszeYc8PQGqwzpTJuvCjw-1
Received: by mail-ot1-f69.google.com with SMTP id e28-20020a9d491c0000b02903daf90867beso5931657otf.11
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 06:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/gNZOYxvHRh8WAbiF0tOQgle1Sg6oiAk/FOL9PrzSRM=;
        b=OxvrA74wgJImgEnprJFGhbGHdiynlf+aG28g8NIRSLQ+QrSRBxIC4cUefPKWoXMdXe
         zVkt/Q5ZyzqSY+FFEXxJr+ofSTw6nA3m6FRpqcymHSv6bWmoaRO96MtUPkHHsjbw+jOY
         OH3K4uJBVlakOyh3f/WhAN6oDPeABb0jC0rGqYMTRCtjogxfDwywjv+DcuqG1FxT2DJo
         D2prO6b6+8CX6Ri0SImEw3oIaIoTHfK7TxhE1As0WnZNoCPCeaFADxXp7xFrJX620O/g
         cLS7+O1UIdeb2EXRFz++PhbjMRXD+jUxHDm4bwlbfVyDx0nykx//AYhXnJhsUnNZzFSi
         rO4w==
X-Gm-Message-State: AOAM533kwloiqtYBHjBOENf3+sUg903ekulx3cfoOspEv7RIU9B/XvW7
        s3mPiy0ICMMKnNcohYy2tHwnS848snuHzwwGBgco9RCL19d1aTZY/efslhxRmO8ebFx+Sf1UO9X
        Se8CVwuhQGHyf+QB3518wkA==
X-Received: by 2002:aca:ac02:: with SMTP id v2mr15154526oie.154.1624023796412;
        Fri, 18 Jun 2021 06:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziRuflZC5sU6xUXnHTciiKmLsXNlfJiyZE+R44W4RRLT5GaeC5ScAnNM3vfwinOxZJbgTjdA==
X-Received: by 2002:aca:ac02:: with SMTP id v2mr15154517oie.154.1624023796250;
        Fri, 18 Jun 2021 06:43:16 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w11sm1786875oov.19.2021.06.18.06.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:43:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] bug: mark generic BUG() as unreachable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210617214328.3501174-1-trix@redhat.com>
 <20210617214328.3501174-3-trix@redhat.com>
 <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <312e5b85-bfa5-e7f1-c1f7-a13a5d2583b8@redhat.com>
Date:   Fri, 18 Jun 2021 06:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 6/18/21 1:20 AM, Arnd Bergmann wrote:
> On Thu, Jun 17, 2021 at 11:44 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This spurious error is reported for powerpc64, CONFIG_BUG=n
>>
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index f152b9bb916fc..b250e06d7de26 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>>
>>   #else /* !CONFIG_BUG */
>>   #ifndef HAVE_ARCH_BUG
>> -#define BUG() do {} while (1)
>> +#define BUG() do {                                             \
>> +               do {} while (1);                                \
>> +               unreachable();                                  \
>> +       } while (0)
>>   #endif
> Please let's not go back to this version, we had good reasons to use
> the infinite loop,
> mostly to avoid undefined behavior that would lead to the compiler producing
> completely random output in code paths that lead to a BUG() statement. Those
> do cause other kinds of warnings from objtool and from other compilers.
>
> The obvious workaround here would be to add a return statement locally, but
> it may also help to figure out what exactly triggers the warning, as I don't see
> it in my randconfig builds and it may be that there is a bug elsewhere.
>
> I've tried a simple reproducer on https://godbolt.org/z/341P949bG that did not
> show this warning in any of the compilers I tried. Can you try to narrow down
> the exact compiler versions and commmand line options that produce the
> warning? https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ has
> most of the supported gcc versions in case you need those.

Please follow the link in the cover letter to the original issue 
reported for fs/afs/dir + gcc ppc64 9.x / 10.3.1

Adding the return was the first, rejected solution.

Tom

>
>        Arnd
>

