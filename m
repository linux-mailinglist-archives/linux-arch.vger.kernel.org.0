Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974B838B3E4
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhETQB6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 12:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233301AbhETQB5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 12:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621526435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8JiB2x9xqhth6XifEh3aGlH81y4eaL+aj39sK1+85dc=;
        b=bD2lm8qeHPm63RJjoE+U8BxeSg3eFTFf0yAg0FP22p9/atZMqvnFbN99nIAbSG36/YsNbM
        YwI1+sePI0LxvWbZLUY57+tITiYKva/BAXYf3/bpXUQuTLFvPgZZj7leTcy/D3dMiY93bl
        BWBcWE/9Ow28EYc6RoQlN1eNv2HiM34=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-fgigWEnMMAyIrrGcdN3pfA-1; Thu, 20 May 2021 12:00:33 -0400
X-MC-Unique: fgigWEnMMAyIrrGcdN3pfA-1
Received: by mail-ed1-f72.google.com with SMTP id c15-20020a05640227cfb029038d710bf29cso3742950ede.16
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 09:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JiB2x9xqhth6XifEh3aGlH81y4eaL+aj39sK1+85dc=;
        b=HV3oJHAj1hb7S8Mxkm/Q1OPB+eOGkSzhGSnsEX38eutMXwpsiNuk5NjIgx9Owb0kmE
         iI9suxoqCH8Ta7bp7KzylgCKzEKBs7ciq3rszwLa7LDmaUsTDti5JM4/MNeFZGnsYmUL
         NFhiDTrzO/yysMvuGm0ISE+EMz6D7BI7l81GrYb3EFyn6Yj0y59BHqDTSr4SoAXCpH6u
         3w4K0XvJEqF84AmPVG+7rKna+MklD8dvzWikR1CPdbXaGcwFsLzmShlarmIYCIQxc5W8
         BGS1075/iCZqPM4CLQ5tzO1BTGgZXWoKhD2+65LdSQ+NTqsyj6tncieiIcJrz9V+I6rI
         hAog==
X-Gm-Message-State: AOAM532tPBGvGt2i6Cevu7SRI5KtRobinogafq1iwaQf/2OedEvh6PqK
        EzxhDltqo9XRZKnduU7ryqXYTbmVzsyN1lzk4+7lsygSjuVErAGW3TzVifzVJOqfV5t/hTjX78F
        AeTnDbGb6q+a+NvhbNdM4JQ==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr5641184edb.216.1621526431806;
        Thu, 20 May 2021 09:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0JY5dsBRU3sGFN1ur/1DvGeSSS+X93hOqr06JEg0lZLSN3U1xv12CQqdMNCc3MG232aCkZA==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr5641148edb.216.1621526431629;
        Thu, 20 May 2021 09:00:31 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id z17sm1586158ejc.69.2021.05.20.09.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 09:00:31 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org> <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck> <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck> <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <0dbdfe1e-dede-d33d-ca89-768a1fa3c907@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <eff0f358-d5f3-47c7-539b-527814093f89@redhat.com>
Date:   Thu, 20 May 2021 18:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0dbdfe1e-dede-d33d-ca89-768a1fa3c907@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/21 5:06 PM, Dietmar Eggemann wrote:
> On 20/05/2021 14:38, Daniel Bristot de Oliveira wrote:
>> On 5/20/21 12:33 PM, Quentin Perret wrote:
>>> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
>>>> Ok, thanks for the insight. In which case, I'll go with what we discussed:
>>>> require admission control to be disabled for sched_setattr() but allow
>>>> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
>>>> is probably similar to CPU hotplug?).
>>>
>>> Still not sure that we can let execve go through ... It will break AC
>>> all the same, so it should probably fail as well if AC is on IMO
>>>
>>
>> If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
>> the admission control needs to be re-executed, and it could fail. So I see this
>> operation equivalent to sched_setaffinity(). This will likely be true for future
>> schedulers that will allow arbitrary affinities (AC should run on affinity
>> change, and could fail).
>>
>> I would vote with Juri: "I'd go with fail hard if AC is on, let it
>> pass if AC is off (supposedly the user knows what to do)," (also hope nobody
>> complains until we add better support for affinity, and use this as a motivation
>> to get back on this front).
>>
>> -- Daniel
> 
> (1) # chrt -d -T 5000000 -P 16666666 0 ./32bit_app
> 
> (2) # ./32bit_app &
> 
>     # chrt -d -T 5000000 -P 16666666 -p 0 pid_of(32bit_app)
> 
> 
> Wouldn't the behaviour of (1) and (2) be different w/o this patch?
> 
> In (1) __sched_setscheduler() happens before execve so it operates on
> p->cpus_ptr equal span.
> 
> In (2) span != p->cpus_ptr so DL AC will fail.
> 

As far as I got, the case (1) would be spitted in two steps:

 - __sched_setscheduler() will work, then
 - execv() would fail because (span != p->cpus_ptr)

So... at the end, both (1) and (2) would result in a failure...

am I missing something?

-- Daniel

