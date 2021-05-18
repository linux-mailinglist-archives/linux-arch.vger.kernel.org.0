Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8923876E2
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhERKtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbhERKtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 06:49:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B1C061756
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 03:48:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so1223566wmq.0
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lw//WQHU1n8Lr/SxhTfcfyc8tvk7S4lAFPEm1TkdCHc=;
        b=jX9kX3Vod+I5rJUyU3cakHfzGdz5a5bQTSWVHWoUF68aLrBioufVUMrdLrwYA7KVgN
         eKLuTdcWsE8cCeK881ntTFN7BxBmqSs8GrQ/4HsJs4QkmOMvCgz57xB8py6JNHZ4q55u
         Syqwk3o+fLHz7otqXclL6PhUe3qxkOwcm1ATA400g++22qFMB7cbUis1J8LekpDIOc2R
         dfbFFYZgyi3zDX4ERYVsMsF2OIDcKpVMwV2LRogtiLE/CZxdfD+0uLOzGk5EfdJeji//
         k8PWHbpBHjh8fgP//HMPG5rhN5IUcWeHyw6BUcgC4gLyrIOuwXBTuUUZwfVBxsmVaVIQ
         Te1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lw//WQHU1n8Lr/SxhTfcfyc8tvk7S4lAFPEm1TkdCHc=;
        b=dwvjFM/K+trzQlr1e6NdqREyVpx+hUJtI3+wPoxuRCOKzc6fTX8eXtMVbRWb0zCMMr
         j+3bIdU1zoHqOUru11eK1NTLG7ERaunPf5hz+gY/RS9qfx8oL6Btmj/vZJSz9OePr+bp
         ccbQwJDkYNjCgsEzvoh/KR+rr9s8Uw+Y1tWpOIHF1KXaIqSohK0pLKVRlIQJA2qQEG9h
         ZTbkCnvKjlulGMdGBI9TJ6C1Y8ixPMsq2BwSi0T9o4Mhqlg7cwNmPeBpV6UCureWz3/6
         eKDwTgWlqlhrsPEROKpIzDavCydysqtQeGyIkNY/0TGkiWhFNQXYzEbzEAKmqlBo5Z5r
         fu5w==
X-Gm-Message-State: AOAM532Lz7x/4pk7kKqmQN/HsplPRjjQEaGVaD5DPWEpp0AHwA0LVRSO
        vMQDO9ND7i1yv5EzORxw/Nwmxw==
X-Google-Smtp-Source: ABdhPJzRiT7qtOCBDsKWLZ6LPMj4QiYCEg9Nduj8NBMDuCXcB7+XAdn7gCxXdilFj6ofUcHz4C743g==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr207192wmf.117.1621334890798;
        Tue, 18 May 2021 03:48:10 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id h14sm2930154wmb.1.2021.05.18.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:48:10 -0700 (PDT)
Date:   Tue, 18 May 2021 10:48:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKObZ1GcfVIVWRWt@google.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518102833.GA7770@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 18 May 2021 at 11:28:34 (+0100), Will Deacon wrote:
> I don't have strong opinions on this, but I _do_ want the admission via
> sched_setattr() to be consistent with execve(). What you're suggesting
> ticks that box, but how many applications are prepared to handle a failed
> execve()? I suspect it will be fatal.

Yep, probably.

> Probably also worth pointing out that the approach here will at least
> warn in the execve() case when the affinity is overridden for a deadline
> task.

Right so I think either way will be imperfect, so I agree with the
above.

Maybe one thing though is that, IIRC, userspace _can_ disable admission
control if it wants to. In this case I'd have no problem with allowing
this weird behaviour when admission control is off -- the kernel won't
provide any guarantees. But if it's left on, then it's a different
story.

So what about we say, if admission control is off, we allow execve() and
sched_setattr() with appropriate warnings as you suggest, but if
admission control is on then we fail both?

We might still see random failures in the wild if admission control is
left enabled on those devices but then I think these could qualify as
a device misconfiguration, not as a kernel bug.

Thoughts?

Thanks,
Quentin
