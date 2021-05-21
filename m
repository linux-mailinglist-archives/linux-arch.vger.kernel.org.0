Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528938C8E5
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhEUOFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 10:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232632AbhEUOFw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 10:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621605865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FWGnS1xTBJJ2Fo3anpEGnC99ELWCmAqg/0rfir/TOM=;
        b=S0WjffjOEhgRFANVKlMKrnN+y0GZ4FN4QZZeY92/YjzgqVKFf/b1L2OCHm0d93cJPolVZ+
        XwcoKuwhPw7IgYH2dRoSxL/X4RRL///iFkbiM6+7NxBHpRxsYnMb1nRjDYG88EzE1i8qPj
        z4KFsmzxG9iFXv3dyrw5S2HECSHJB2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-CAyeZymXMg6yHR0W1IwsrQ-1; Fri, 21 May 2021 10:04:23 -0400
X-MC-Unique: CAyeZymXMg6yHR0W1IwsrQ-1
Received: by mail-ej1-f69.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so6234500ejz.5
        for <linux-arch@vger.kernel.org>; Fri, 21 May 2021 07:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0FWGnS1xTBJJ2Fo3anpEGnC99ELWCmAqg/0rfir/TOM=;
        b=EQbhCysiv0WPCoMZQ+XbxNp1nQg84zkJ+6rIaIe+a3q54HRp7hBYk33dPtJ+2Yefil
         NFIMZsWziyZGpIQJMgEeAyhnNUCSbz0elZyZo9bIkCEBsFUDR6DCfCMl3/ha9kv0L/vA
         r/dXVhJlvYE7+6zJGs68M9C6JLdKOK9g4mr4p7wNe7q0mzv8v8LT5z6nHXGI7WC7F8AG
         qKEyjOlMn4RbRso5tEGg5nicKUl5wNeTgkxlSujdlI+Cdqq9Rdaf9fFCs/1ctxxsnXs1
         EK/a8tdxryr+MKMwxGL3mLeglEJxTlrOnBdBT+q7lxaUcazIPlODd9NTHT7kigcRlD6j
         D5bA==
X-Gm-Message-State: AOAM533OFfnnYiwFymQAwowgzJysBXPjexlKtKRh/bGppYcyx5pCjDYg
        pQ4L7uD5/SAmapNgkCLJYGEHXrjizaPyvRGKXiEYLImm/S1PoyzivIn21UuGkF4oXyHVT5YW02Z
        aAuwubAT7PS3iUjCWsLqvgg==
X-Received: by 2002:a17:906:7c4b:: with SMTP id g11mr10460863ejp.461.1621605862065;
        Fri, 21 May 2021 07:04:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXqTbrJ0iKwqv77esCIvIhfq1WCbIdlw3aMc1GDJjhdYtzXix6uBQJwXOo+Ew6v5VsCgDyRg==
X-Received: by 2002:a17:906:7c4b:: with SMTP id g11mr10460834ejp.461.1621605861789;
        Fri, 21 May 2021 07:04:21 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id qo19sm3569598ejb.7.2021.05.21.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 07:04:21 -0700 (PDT)
Date:   Fri, 21 May 2021 16:04:18 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKe94oTVSbywMw2r@localhost.localdomain>
References: <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
 <YKdsOBCjASzFSzLm@google.com>
 <YKdxxDfu81W28n1A@localhost.localdomain>
 <20210521103724.GA11680@willie-the-truck>
 <3620bad5-2a27-0f9e-f1f0-70036997d33c@arm.com>
 <YKevSSLHjdRvrJ2i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKevSSLHjdRvrJ2i@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/05/21 13:02, Quentin Perret wrote:

...

> So I think Will has a point since, IIRC, the root domains get rebuilt
> during hotplug. So you can imagine a case with a single root domain, but
> CPUs 4-7 are offline. In this case, sched_setattr() will happily promote
> a task to DL as long as its affinity mask is a superset of the rd span,
> but things may get ugly when CPUs are plugged back in later on.
> 
> This looks like an existing bug though. I just tried the following on a
> system with 4 CPUs:
> 
>     // Create a task affined to CPU [0-2]
>     > while true; do echo "Hi" > /dev/null; done &
>     [1] 560
>     > mypid=$!
>     > taskset -p 7 $mypid
>     pid 560's current affinity mask: f
>     pid 560's new affinity mask: 7
> 
>     // Try to move it DL, this should fail because of the affinity
>     > chrt -d -T 5000000 -P 16666666 -p 0 $mypid
>     chrt: failed to set pid 560's policy: Operation not permitted
> 
>     // Offline CPU 3, so the rd now covers CPUs 0-2 only
>     > echo 0 > /sys/devices/system/cpu/cpu3/online
>     [  400.843830] CPU3: shutdown
>     [  400.844100] psci: CPU3 killed (polled 0 ms)
> 
>     // Try to admit the task again, which now succeeds
>     > chrt -d -T 5000000 -P 16666666 -p 0 $mypid
> 
>     // Plug CPU3 back online
>     > echo 1 > /sys/devices/system/cpu/cpu3/online
>     [  408.819337] Detected PIPT I-cache on CPU3
>     [  408.819642] GICv3: CPU3: found redistributor 3 region 0:0x0000000008100000
>     [  408.820165] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
> 
> I don't see any easy way to fix this w/o iterating over all deadline
> tasks in the rd when hotplugging a CPU back on, and blocking the hotplug
> operation if it'll cause affinity issues. Urgh.
> 

Yeah this looks like a plain existing bug, joy. :)

We fixed a few around AC lately, but I guess work wasn't complete.

Thanks,
Juri

