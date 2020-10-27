Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31F29A1EB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441433AbgJ0Aup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 20:50:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41419 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411002AbgJ0Auo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 20:50:44 -0400
Received: by mail-io1-f65.google.com with SMTP id u62so13259064iod.8
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2020 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1CZ2k4hR9c3bjTh0zoqy1spVt5F8Uv6qO7frIZFMui8=;
        b=MKIHY4zgxSPG/n9XVnq6+PffUcL0ZlFFJ2mw2k63AaRiVO8V49k60+daDit0NXlsum
         kRMH846fY4Est5lYhs6+8nXAUujsAKy+QR1uYU2dOLPZE60a2qhL2986HFlApMvYQThq
         mkko3XmBeQY/GuHQQSXg+2kT0pCFG4N+S91Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CZ2k4hR9c3bjTh0zoqy1spVt5F8Uv6qO7frIZFMui8=;
        b=eaUyMTEjm0bG9ik5ZDbq/RckiVOCjJSWUAhPalcW5RD7gdzvWtxBvw/zsPvET9Ba+a
         TFt0Xl+CUmaKEuDTNBXDaynXcgZSgqzlNXcxIHNZEwSIBmDFUYZY4is1P9yuFzZMvChV
         w2xHbYKCZBDNtbxPOf3N30CCDva/o+Rotqj1JB5lSIsdmL9LQjnQyJqPEMexwB7/3+n/
         JtlAI4MNhSMgP8UCIqn0I9qbOYRvuM8S5eVrnyD73w58VRCHsW/Ho5Ea2ExTW0RW1CL2
         SLk3idawtodddsR6myOvrU66cxRgboJZAJS5ySRDVPZhaxkuuS9HxuzVXRpgiRUC0H6h
         xn1A==
X-Gm-Message-State: AOAM530rJVdpUJmSySLT+8ROOpgnE5sWf0mUb0u6wPVOISedv2rai2Ke
        RTmvF3WFcFeEmncjpZ6dBTEozQ==
X-Google-Smtp-Source: ABdhPJzI6/YgrdTP7Pxl7fP0LGkzFgxf9z7H9Pr4VGcBoWiKHluDujRZ7xbJcmczFs6R/QM5wYI4KA==
X-Received: by 2002:a6b:8d97:: with SMTP id p145mr12625844iod.190.1603759843715;
        Mon, 26 Oct 2020 17:50:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f65sm7427553ilg.88.2020.10.26.17.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 17:50:43 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
Date:   Mon, 26 Oct 2020 18:50:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87y2js1tic.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/26/20 5:01 PM, Thomas Gleixner wrote:
> On Mon, Oct 26 2020 at 11:49, Vincenzo Frascino wrote:
>> This series extends the kselftests for the vDSO library making sure: that
>> they compile correctly on non x86 platforms, that they can be cross
>> compiled and introducing new tests that verify the correctness of the
>> library.
>>
>> The so extended vDSO kselftests have been verified on all the platforms
>> supported by the unified vDSO library [1].
>>
>> The only new patch that this series introduces is the first one, patch 2 and
>> patch 3 have already been reviewed in past as part of other series [2] [3].
>>
>> [1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
>> [2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
>> [3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com
>>
>> It is possible to build the series using the command below:
>>
>> make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>
>>
>> A version of the series rebased on 5.10-rc1 to simplify the testing can be found
>> at [4].
>>
>> [4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests
> 
> Assuming Shuah will pick them up:
> 
>    Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 


Thanks. I will pick these up.

thanks,
-- Shuah

