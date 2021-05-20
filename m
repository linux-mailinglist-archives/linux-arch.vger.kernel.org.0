Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB38B38AE87
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhETMke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 08:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237675AbhETMkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621514340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOIVdpfN2++n8/GKFmvYS9IGAgx5CHEBQ5+iuVYXyMs=;
        b=WjIglvB2rR0C/TgNkenFOn3L0VkdblFfCXSMAQd1UQgBnX4B+/rAJKqyQVybicVssxehuS
        egPoP5K/gD9nC4i7xPHddlLs+KePeDZVVD9t7svAoK3ZzPIHJQX8RluuW7WVd3UzDKRN0h
        OtG3SiLLqkHy+UeAFHiZoC3JArgCPwM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-RRzPCoODM2yyVd0D-9beVg-1; Thu, 20 May 2021 08:38:58 -0400
X-MC-Unique: RRzPCoODM2yyVd0D-9beVg-1
Received: by mail-ej1-f69.google.com with SMTP id p18-20020a1709067852b02903dab2a3e1easo1956161ejm.17
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 05:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOIVdpfN2++n8/GKFmvYS9IGAgx5CHEBQ5+iuVYXyMs=;
        b=SsijuhNC9Dg1hRYiPd2pz5f83r0uiEB8feCknRXo0kWy0o1FDnfrLnAEFp3EWVvg/Y
         S5YT5a/++Kx6G8/CrT2lSAMQRraKF4DOQMH2tJYvOO5JzQSseR1MUexaOD3cIJViUBoP
         FaSvHWoJxLaQnM48eJe2zN4VQbIMW3gC0dVLvWdDa5xQiRknSE9Wt1QrnahosiN/TKzA
         3roGU92JFL+xD1uqgSxw7ZUN62nKtF0TPSxpkRcBN6/4uBnB7cQmIhAkjRpyKkbtNN98
         92+LcoRT4uk8d0hBiV6RLzu8JcowjoVTFjelIhvge6PAZ6PL39RCQXZlzMsuv7iyusuI
         9DYA==
X-Gm-Message-State: AOAM533Xv/HVvJWUco1fXp6dDqJH98m1tcmGvuRsFbxl/bZl47MdfUg1
        NXfbuBkVvEw35gd9P4IvHrVfdxGp68dtWooGsspTonj/ksOU9Vki4N9II53SuMv5x7KqMq8uoED
        Q3E2iyutAWaPQIMT6W5OlAg==
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr1868666edd.139.1621514337558;
        Thu, 20 May 2021 05:38:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyVTDOjgeaqCpwILha+/83d56/oX5zK6fUGvNZ2QZlK9m9LPZmG+LUPF/8nzE9gRj9uvKGtw==
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr1868641edd.139.1621514337375;
        Thu, 20 May 2021 05:38:57 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id lv10sm1454309ejb.32.2021.05.20.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 05:38:57 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
Date:   Thu, 20 May 2021 14:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKY7FvFeRlXVjcaA@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/20/21 12:33 PM, Quentin Perret wrote:
> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
>> Ok, thanks for the insight. In which case, I'll go with what we discussed:
>> require admission control to be disabled for sched_setattr() but allow
>> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
>> is probably similar to CPU hotplug?).
> 
> Still not sure that we can let execve go through ... It will break AC
> all the same, so it should probably fail as well if AC is on IMO
> 

If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
the admission control needs to be re-executed, and it could fail. So I see this
operation equivalent to sched_setaffinity(). This will likely be true for future
schedulers that will allow arbitrary affinities (AC should run on affinity
change, and could fail).

I would vote with Juri: "I'd go with fail hard if AC is on, let it
pass if AC is off (supposedly the user knows what to do)," (also hope nobody
complains until we add better support for affinity, and use this as a motivation
to get back on this front).

-- Daniel

