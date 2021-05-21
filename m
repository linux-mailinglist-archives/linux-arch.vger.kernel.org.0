Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C938C75B
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhEUNCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 09:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhEUNCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621602050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SP1j3lBexDWEssgurMXzVe6QbtETBwWqUZ3KB+CEW78=;
        b=Jiv85j/rsrsh/TwEPgGAPmzq+aeIXjA7nW3tT/0lU83v9IusmHNt2a4E2+LsakdQAauP8c
        ee49DeJMB224hRPt3JAuqfDKYjdZGjN33spi/FHy5NZjZFfD/zXcYEOO8d4ptIda7JxbMf
        056Sm9xPZ2fBtg4d1Y4PWPEgzAuJ65o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-jyc_Nl1bOVutJKMnAhOwTw-1; Fri, 21 May 2021 09:00:49 -0400
X-MC-Unique: jyc_Nl1bOVutJKMnAhOwTw-1
Received: by mail-lj1-f200.google.com with SMTP id t1-20020a2e9d010000b02900f5b2b52da7so6276383lji.8
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 06:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SP1j3lBexDWEssgurMXzVe6QbtETBwWqUZ3KB+CEW78=;
        b=a+nxfE4f0rz+6Ve9/zJ5YWsQFRUauXEKveryXpmuYQn8LxxDgJKB5vU0+/aUmjsb5X
         SejpaU0VBJoL+D7ShEQ5c7Qteq2Vm7u3WPTmi9iv/EJllGBR7DZJ6pKMc0SfCvqBSBdC
         GQWA1jftStMVx9Fq9/cXIdIfeehsEdKSgopxXRAtxX8sf7BY47Y5U/PZdNtXWf45t6FY
         xgLf3yGePJJCHbDa0alvF1Kq8FXCm4AHoVaHnKQVrAnH4Y0MLNCjL1Egr49k1CDX1b46
         MUKcfZVsCj9s6u5pxoSUuIlpGyRsHnvXdaZh+UPSnwWMdQnEBrb/y/Sewd//DfE6OCJi
         LHKw==
X-Gm-Message-State: AOAM53190XIKrMerROp4fEB9X/zo1dli/HiTddJ8Z3vXAtgJn4703Ih4
        cBjhBVeA9e4mvxDf8G+xUDHV7IsGzj1C5ptcu9zG9NuSgkcC2CnxaqpSMVudcC+b5dYKT/pNZ5x
        wr1c5hgWt8oxIhuoEwwyNqw==
X-Received: by 2002:a2e:5842:: with SMTP id x2mr6722335ljd.228.1621602046830;
        Fri, 21 May 2021 06:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUAgJJeugJDvgzv58Unyyv+sMfrnrZRt7zMDFjI81QGSvDbxDDn0PxzWyb4Ax/MVpyYscj6A==
X-Received: by 2002:a2e:5842:: with SMTP id x2mr6722105ljd.228.1621602044422;
        Fri, 21 May 2021 06:00:44 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id g4sm4024868edw.8.2021.05.21.06.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:00:44 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Will Deacon <will@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Quentin Perret <qperret@google.com>,
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
References: <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com> <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain> <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b7182444-1385-214f-4526-6e83be3d7f02@redhat.com>
Date:   Fri, 21 May 2021 15:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521103724.GA11680@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/21/21 12:37 PM, Will Deacon wrote:
> Interesting, thanks. Thinking about this some more, it strikes me that with
> these silly asymmetric systems there could be an interesting additional
> problem with hotplug and deadline tasks. Imagine the following sequence of
> events:
> 
>   1. All online CPUs are 32-bit-capable
>   2. sched_setattr() admits a 32-bit deadline task
>   3. A 64-bit-only CPU is onlined

At the point 3, the global scheduler assumption is broken. For instance, in a
system with four CPUs and five ready 32-bit-capable tasks, when the fifth CPU as
added, the working conserving rule is violated because the five highest priority
thread are not running (only four are) :-(.

So, at this point, for us to keep to the current behavior, the addition should
be.. blocked? :-((

>   4. Some of the 32-bit-capable CPUs are offlined

Assuming that point 3 does not exist (i.e., all CPUs are 32-bit-capable). At
this point, we will have an increase in the pressure on the 32-bit-capable CPUs.

This can also create bad effects for 64-bit tasks, as the "contended" 32-bit
tasks will still be "queued" in a future time where they were supposed to be
done (leaving time for the 64-bit tasks).

> I wonder if we can get into a situation where we think we have enough
> bandwidth available, but in reality the 32-bit task is in trouble because
> it can't make use of the 64-bit-only CPU.

I would have to think more, but there might be a case where this contended
32-bit tasks could cause deadline misses for the 64-bit too.

> If so, then it seems to me that admission control is really just
> "best-effort" for 32-bit deadline tasks on these systems because it's based
> on a snapshot in time of the available resources.

The admission test as is now is "best-effort" in the sense that it allows a
workload higher than it could handle (it is necessary, but not sufficient AC).
But it should not be considered "best-effort" because of violations in the
working conserving property as a result of arbitrary affinities among tasks.
Overall, we have been trying to close any "exception left" to this later case.

I know, it is a complex situation, I am just trying to illustrate our concerns,
because, in the near future we might have a scheduler that handles arbitrary
affinity correctly. But that might require us to stick to an AC. The AC is
something precious for us.

(yeah, SP would not face this problem... now that I made progress on RV I can
get back to it).

-- Daniel

