Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE952C8B4E
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgK3Rg5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 12:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387748AbgK3Rg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 12:36:56 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25035C0613D2
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 09:36:16 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so22501793wmg.4
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXquueW7RwtRbSUyF0GUkPiPyiBc1RMHTutwlm7gt9U=;
        b=YZSMYUXMw3eHMy3QopppKqtvLhx0+nK/5nPnT6HxkmvvKbkVhKWxBCqASbsFUuH1mC
         vyYI8CjHKvhEymyG1bGJaar0x8BJoFBwCj0U8OX7lDYxDYdPoo2TirozgKEtqfGu2ypf
         1pzfRaAgWClglozMdpzqwSUxx2376Sf8XTEgB0k5roT+DbQOjljSFFV4JkU7piIwi6JT
         MmlcwkdrZzElnTO17j9uf/ZUHZioqVYEvoxafcHZodiA9Eq0pCtsa06PUxnTXvNn3eMD
         YM/bDhgOeLOq5hreUWI31EroxfJvM5E/zk0Qf+TGB1wmLNDnZyv4RFvVKMLwbiviUkdU
         yp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXquueW7RwtRbSUyF0GUkPiPyiBc1RMHTutwlm7gt9U=;
        b=D8BEFQbo1/RxuCz2C2PRFb8vo6SAYz5HRjnWfa6UFO2j/hHf33CXNq2vgyGhR16LML
         wgN6LI+wRGy4tBYIYqoqsUZLlqyJEtylvw6eM9sQHkqH/db4QreFY4SbtGC4+V88h4Th
         b1eHMf+5uQJKYuECAgaAZaicv9xHRaC+lEqvaRSERwzMhp4W4AJK/7ZtSvYNlm52jp85
         p6Xf2Yl3lLw2VLaHyhI1vuPxJRLATGKBFCmMauE849dpgrccuNhJJ1dGXGIvRIsf73X3
         5Aq7FOjanKHBnRn9qG26EUFgcEcinu9SotMJIKWQhYKAWpC+icuI2BO4gEpUGKedRoU6
         Dcow==
X-Gm-Message-State: AOAM533PqIJVWQX4FlaD3qgB4X4hyhAzV5OeJG80Fj7939C2L491emdX
        Bo8l/SwFexq8yokup+hFR+jWpose4ExMkw==
X-Google-Smtp-Source: ABdhPJyv0kIDqw35nKHHG3r+Jvq9Q37fbXRLDAKsgXCJ4crAEZHm92iXyhudgXVwGNW3N/Z9A2F+pQ==
X-Received: by 2002:a7b:c94d:: with SMTP id i13mr24303675wml.130.1606757774631;
        Mon, 30 Nov 2020 09:36:14 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id b14sm27809837wrq.47.2020.11.30.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:36:14 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:36:10 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201130173610.GA1715200@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday 30 Nov 2020 at 17:05:31 (+0000), Qais Yousef wrote:
> I create 3 cpusets: 64bit, 32bit and mix. As the name indicates, 64bit contains
> all 64bit-only cpus, 32bit contains 32bit-capable ones and mix has a mixture of
> both.
> 
> If I try to move my test binary to 64bit cpuset, it moves there and I see the
> WARN_ON_ONCE() triggered. The task has attached to the new cpuset but
> set_allowed_cpus_ptr() has failed and we end up with whatever affinity we had
> previously. Breaking cpusets effectively.

Right, and so does exec'ing from a 64 bit task into 32 bit executable
from within a 64 bit-only cpuset :( . And there is nothing we can really
do about it, we cannot fail the exec because we need this to work for
existing apps, and there is no way the Android framework can know
upfront.

So the only thing we can do really is WARN() and proceed to ignore the
cpuset, which is what this series does :/. It's not exactly pretty but I
don't think we can do much better than that TBH, and it's the same thing
for the example you brought up. Failing cpuset_can_attach() will not
help, we can only WARN and proceed ...

Now, Android should be fine with that I think. We only need the kernel
to implement a safe fallback mechanism when userspace gives
contradictory commands, because we know there are edge cases userspace
_cannot_ deal with correctly, but this fallback doesn't need to be
highly optimized (at least for Android), but I'm happy to hear what
others think.

Thanks,
Quentin
