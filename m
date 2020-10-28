Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750129D7B2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Oct 2020 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgJ1W0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbgJ1W0F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2020 18:26:05 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08808C0613CF
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 15:26:05 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f140so526201ybg.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2020 15:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=fmJX2ejnDVI8dcSjhMLymoA7Z2Eqy+pQYeWFz5jhy63fgQy2ttCBz1h6z0zaM6SjnA
         IXAwdr5gcrzyxaftD/b6bXEPCqeuu1x+S1NelVa/5nT9g8XINQaL4+rxRAyy7wvdjAa6
         /BIGiYKHme6ALbRPbCAzPK72rEhO74wu+a6ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=ZcmBLvWbqTyXxHPLV8LrdQbyUyh1OPt9Yw2yJ5czalgSbK4lwOoW2v21TXC0enDadw
         FWMS+jw5e//77Unv+k5O+dH2yEZXl7Lp4O6/FxJP8rEqzkehjhR+ESxCnDZfh4EblUqR
         oVsdorJE9msQT/y79EYtOEmObbdNgErIMbHit/AteBkccvYqL4nJMWy2UMCAZjYgbcbd
         s26OVZYo7b7qo6Kth+Ms0yvUP9CA3WJLoZ7Ein9FRjXoj4GbhrQo59eDgzWQknVhw4Tx
         GHVad2ecWlZS5FxOUP2VUMRAqKAZm0+zYSAa85RtiQj6uXyWBKwUElSIBQXhuFufUndk
         35Zg==
X-Gm-Message-State: AOAM5334q7gK27aJ+Fp2xDOW63euUy8uAjIGZcW/8lZXNi4LsS/XGaFX
        Vs8/g9VgzhFaCB75ur8mQo7Zlz/MBrSRWg==
X-Google-Smtp-Source: ABdhPJxIhDXad77eNUS6JVTDUuoz5BPKcp8l4YkIqQuFS+EEs1MCsoLBv8wRS1ctm7FG86BaJHPlkQ==
X-Received: by 2002:a9d:1ee5:: with SMTP id n92mr5985068otn.152.1603898453779;
        Wed, 28 Oct 2020 08:20:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d11sm2221331oti.69.2020.10.28.08.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:20:52 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] kselftest: Extend vDSO tests
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
 <87y2js1tic.fsf@nanos.tec.linutronix.de>
 <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c7f84f84-7e76-05ee-9fc6-915dec1d51f0@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 09:20:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/26/20 6:50 PM, Shuah Khan wrote:
> On 10/26/20 5:01 PM, Thomas Gleixner wrote:
>> On Mon, Oct 26 2020 at 11:49, Vincenzo Frascino wrote:
>>> This series extends the kselftests for the vDSO library making sure: 
>>> that
>>> they compile correctly on non x86 platforms, that they can be cross
>>> compiled and introducing new tests that verify the correctness of the
>>> library.
>>>
>>> The so extended vDSO kselftests have been verified on all the platforms
>>> supported by the unified vDSO library [1].
>>>
>>> The only new patch that this series introduces is the first one, 
>>> patch 2 and
>>> patch 3 have already been reviewed in past as part of other series 
>>> [2] [3].
>>>
>>> [1] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com 
>>>
>>> [2] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com 
>>>
>>> [3] 
>>> https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com 
>>>
>>>
>>> It is possible to build the series using the command below:
>>>
>>> make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>
>>>
>>> A version of the series rebased on 5.10-rc1 to simplify the testing 
>>> can be found
>>> at [4].
>>>
>>> [4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests
>>
>> Assuming Shuah will pick them up:
>>
>>    Acked-by: Thomas Gleixner <tglx@linutronix.de>
>>
> 
> 
> Thanks. I will pick these up.


Applied to linux-kselftest next

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah

