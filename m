Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083F235F923
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbhDNQm0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 12:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348415AbhDNQmZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 12:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618418524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnJdpNabY+UhubKC2MgcqWbpPeK4ePb1V0N3HBFbgJY=;
        b=KJnovz4H/DZl6Zc+abq3vAp9myOFlvZ9VLk0R09miA64fPs3W3n0Hcm98eZ8oUk0OZwkyD
        WOnEHBlx+oEAomXwUioOxciAjBW2RC7onx+tIleRVH0E1ARz8QCbRT4tik9Q+LeO5y3HpS
        a3eSpX+WStOLcq1fg9p+3xEkO2KV620=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-4RuJfuecPQKk7t6v1fhM2A-1; Wed, 14 Apr 2021 12:42:02 -0400
X-MC-Unique: 4RuJfuecPQKk7t6v1fhM2A-1
Received: by mail-qk1-f197.google.com with SMTP id n5so10540782qkf.3
        for <linux-arch@vger.kernel.org>; Wed, 14 Apr 2021 09:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PnJdpNabY+UhubKC2MgcqWbpPeK4ePb1V0N3HBFbgJY=;
        b=UA4tw9CC/s0s+P5pSay2bFJ8/VA7La8+7+EY6nVXlfelbKSSFiN4qnqhiJgQwLP5vD
         A8/LCdaJC+dQQY+q8wCIvAJqbgZq5ud+lUOY+d13qL/u4NaP0Id7pLvdX+FCEDbJspNO
         EyzfSlSVvN19cXUJpuk884xrHHdYanoLrPwsdPHtgbUlvwatAhY3AxNKUgCqd8oRyZwX
         u+A9A5bI9+w0ZLlmsoHVzW9nGp8Jjx1h9hazZ0N58BCf5XfQt/+j6fUW4ij3bPJtvGpW
         Yf4tCoi6v1lB574/RwJS1sZ03HOOnEUxNa/F+BXrJrx+paxNWdFGVrbKrrIMMTLKYvoI
         +Fjw==
X-Gm-Message-State: AOAM532RTyqlb2DHyp/xG2yR5fTq84cdGanBXfx1uOoYEyxLj4NOHLAZ
        X6qJ/xFoG8rOsllkUJ3Y7dPYTurbMDun6Su08YOiQBvgzXPr8YoN0ZkN8M5ZkThImoNISWPLDhz
        7jyqAo0q70qwzclhtj6n4YA==
X-Received: by 2002:a05:620a:2455:: with SMTP id h21mr7536340qkn.26.1618418521901;
        Wed, 14 Apr 2021 09:42:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRhFVFMHz8Be/M/dKxKS+io32B918NzPPgGt0jE84n64vdPsNaiFrBlCfEvwyOSIiIv2++SQ==
X-Received: by 2002:a05:620a:2455:: with SMTP id h21mr7536321qkn.26.1618418521712;
        Wed, 14 Apr 2021 09:42:01 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j15sm6347179qtl.88.2021.04.14.09.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:42:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [External] : Re: [PATCH v14 4/6] locking/qspinlock: Introduce
 starvation avoidance into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-5-alex.kogan@oracle.com>
 <87mtu2vhzz.fsf@linux.intel.com>
 <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
Message-ID: <4a9dbfa7-db68-a2dc-9018-a5b74f0f421c@redhat.com>
Date:   Wed, 14 Apr 2021 12:41:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA1141EF-76A8-47A9-97B9-3CB2FC246B1A@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/13/21 5:01 PM, Alex Kogan wrote:
> Hi, Andi.
>
> Thanks for your comments!
>
>> On Apr 13, 2021, at 2:03 AM, Andi Kleen <ak@linux.intel.com> wrote:
>>
>> Alex Kogan <alex.kogan@oracle.com> writes:
>>> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
>>> +			Set the time threshold in milliseconds for the
>>> +			number of intra-node lock hand-offs before the
>>> +			NUMA-aware spinlock is forced to be passed to
>>> +			a thread on another NUMA node.	Valid values
>>> +			are in the [1..100] range. Smaller values result
>>> +			in a more fair, but less performant spinlock,
>>> +			and vice versa. The default value is 10.
>> ms granularity seems very coarse grained for this. Surely
>> at some point of spinning you can afford a ktime_get? But ok.
> We are reading time when we are at the head of the (main) queue, but
> don’t have the lock yet. Not sure about the latency of ktime_get(), but
> anything reasonably fast but not necessarily precise should work.
>
>> Could you turn that into a moduleparm which can be changed at runtime?
>> Would be strange to have to reboot just to play with this parameter
> Yes, good suggestion, thanks.
>
>> This would also make the code a lot shorter I guess.
> So you don’t think we need the command-line parameter, just the module_param?

The CNA code, if enabled, will be in vmlinux, not in a kernel module. As 
a result, I think a module parameter will be no different from a kernel 
command line parameter in this regard.

Cheers,
Longman


