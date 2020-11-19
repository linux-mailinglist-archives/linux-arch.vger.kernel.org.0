Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D22B949E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgKSOaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKSOaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 09:30:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C2C0613CF
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 06:30:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so7385648wmg.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2020 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRlbyeBiYk1IUBo5HOH3WItMevxm3ru4Xm8qrRT2wyg=;
        b=SSZqdpj4RKoJCWr8oozomLprKyqS+l9AkT5kISQ17LF6RpK1CSWLxQlc4sTGOsxyHN
         yYmTFS5gRxoB86T6LfrrF24hrVqbIqulJ8UH//svICGbKaBjLtoTcnaDEXFWGPzc4Ul2
         wpAIpiuIALpUL/C2M++d/zMV1a0YRSycbaBbl1o6BOBNIbSpAza5h5ANnCNVsEmhic4o
         YAkmkOgha5FGHYaEmLHJM0dh8zNxc3MzcU/frv+JV2GFeXl4bkQorrqvYt6HGVpI/xku
         0C6nk6HeyRLeG8UH1/LSJaIX2Tn04O50iOD0dc3aTQv5ok3z5cr6fQ3paiCkX2G/ly7O
         zWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRlbyeBiYk1IUBo5HOH3WItMevxm3ru4Xm8qrRT2wyg=;
        b=bmdVOUuwifKwIe2oPgKIGjZ/Xfk0gHUNW38F5Y6UvsdGYWEPCXxjq1VGXRrCvXVP1i
         Cz8A+RxGuCOWdvM1gAq4VACwsBhyGDAcxOxEDorw/gLZZ5Gu1iRA224sPbXboqAp9/0M
         kwYQnMnFQyIc65UGlVYHJhJa/UC+4Ez3Yhn9BANRfa0tWq1l0nRhvu04TuJDxqidzsvj
         e3g4LI1R4zrlitRBJMtiQNe8vOmk+KFiu+UL5LVBteAT24dPE6VbZbrV71WkLmKOuzI9
         bYkl3kI0FkwLDuTbrsVAcpVq2Fg07SUMKayAp+f5AeKcOYBPCacenDkAFEVdK5HCz4ja
         9fdg==
X-Gm-Message-State: AOAM531wgyx+Z6eSfOzyKr9DeA9JjdwHvd4f8Keem+C0AkIX+Y2XgBlk
        I/MdxvZa3xoR16Ek80vSTp3feaFwGMMHsw==
X-Google-Smtp-Source: ABdhPJy8A5U+1WfeWMxxbnZ1WJ30eOzYlz6bx9wFXE1uJ7iC3YyfUJKLcd4aeL9iz56NGihKFjAC8A==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr1443488wme.28.1605796216613;
        Thu, 19 Nov 2020 06:30:16 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id p4sm40134200wrm.51.2020.11.19.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 06:30:16 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:30:12 +0000
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
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 11/14] sched: Reject CPU affinity changes based on
 arch_cpu_allowed_mask()
Message-ID: <20201119143012.GA2458028@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-12-will@kernel.org>
 <20201119094744.GE2416649@google.com>
 <20201119110723.GE3946@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119110723.GE3946@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday 19 Nov 2020 at 11:07:24 (+0000), Will Deacon wrote:
> Yeah, the cpuset code ignores the return value of set_cpus_allowed_ptr() in
> update_tasks_cpumask() so the failure won't be propagated, but then again I
> think that might be the right thing to do. Nothing prevents 32-bit and
> 64-bit tasks from co-existing in the same cpuseti afaict, so forcing the
> 64-bit tasks onto the 32-bit-capable cores feels much worse than the
> approach taken here imo.

Ack. And thinking about it more, failing the cgroup operation wouldn't
guarantee that the task's affinity and the cpuset are aligned anyway. We
could still exec into a 32 bit task from within a 64 bit-only cpuset.

> The interesting case is what happens if the cpuset for a 32-bit task is
> changed to contain only the 64-bit-only cores. I think that's a userspace
> bug

Maybe, but I think Android will do exactly that in some cases :/

> but the fallback rq selection should avert disaster.

I thought _this_ patch was 'fixing' this case by making the cpuset
operation pretty much a nop on the task affinity? The fallback rq stuff
is all about hotplug no?

Thanks,
Quentin
