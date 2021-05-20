Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A601A38AD86
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbhETMFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbhETMFe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 May 2021 08:05:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26405C06917C
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 03:34:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u133so8865241wmg.1
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5n6riXCd1vkZQcoH0r5gYShL1+XQ6uXaF5ZA75ztkS4=;
        b=hqF1evK4XE7TofUsWGxTL13k2AC6u5yfZPjf37ZMM6wuWy4eazgaoxsdsj4w7FSenB
         Suqt0myWlzhpBr4iWL3CsiFkL/KE7Ot/esZP0uWdz+8wuYpAeWgNHUhcdGNl1UCxRO0o
         xS7CdKhyi4jGanQWWI3xKFxQoVoLb0IgGRFJFihhHtx1/zac3eiqhaf4dQiBOq1/4wtv
         NA81yyGUp5grSRuRZJXK9aOYqLiCPSGIBXZMPG+fCpkyfbmRJtHyQT5RogbOGlMwsNl9
         J0kUIoAY1OFO8I9n2tDAiqXGl8FZmhYDVgkNikPJkpp1EwxNbAQeqAp+aiWzdWKTMlfH
         K6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5n6riXCd1vkZQcoH0r5gYShL1+XQ6uXaF5ZA75ztkS4=;
        b=Ihe5NCoQUxNS3dEVwXWsju3YN/RJyelaUjsmbG3y0+lGUYN+Mpi9UvaWkuo0nuOctp
         htQJ0+gw1ym+JWzAw+fdNm91NIumrttrjUOCSOrVWt+VbBdowSr4tKlZHa7tsCp8KV+S
         zQc/XOXFBHszhjmUfwjmi/7ppkY2A9NSyqjOpQt3KAno8lTygvCaqiNjZz962YMNmbcc
         LaV2y9ASI/K+WB06t5S/aww88x9MfzYbLSjja7ag5LZznQBdTNAQWkvYzomSgOyoddat
         GLdxjDVrI23DS06mvooB9Fsqn80a43c6U6fwUjWC01g+1ziAvXSAYlM+M/wJWlxShSqt
         0RTA==
X-Gm-Message-State: AOAM53011Ws3R+mbvPhnazSCHWhsBRrGZJqQZDMS5s+kqp7Ceu3fyGIk
        KGWjvoSTaoctM1BWq1kZKH6QwA==
X-Google-Smtp-Source: ABdhPJxq6/OQqdBrhuKZaLq+XaCRlIoDOoH49bUkTeQ3q8Q0V8pTmzOTJi3JYtKP3tAWP/lop7kWOg==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr3398343wmh.86.1621506841514;
        Thu, 20 May 2021 03:34:01 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id r1sm2649161wrt.67.2021.05.20.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:34:00 -0700 (PDT)
Date:   Thu, 20 May 2021 10:33:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKY7FvFeRlXVjcaA@google.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520101640.GA10065@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> require admission control to be disabled for sched_setattr() but allow
> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> is probably similar to CPU hotplug?).

Still not sure that we can let execve go through ... It will break AC
all the same, so it should probably fail as well if AC is on IMO

