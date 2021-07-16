Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7563CB6FD
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 13:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhGPLxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhGPLxG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 07:53:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7BC061762
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:50:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so5667872wmc.2
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nzabWvrTaM3dlhAMkGE1TPAE+zrQX3XHiWsmylmIlBU=;
        b=vZIQ2SoXPxosz3Bc9mWtUSTcZht3OswE1gyNYTdMwjAIrpVhZRfuRU+Dat7i7t2Q18
         1PLnalJ3nd+LH1FIQZWVrAGH6bN43KDGKvuBvVQ0uknQ7NHcyNtlb3T0h2MCvMgfOwqn
         fXtOZGYnsXGzAC7V0zMi8MkHS1manK4/OJ1Axk1Ip3tOvv2AVridtc5f+umTDfqvVees
         IMQkIGSval7DAA/tXpX5NWiucWrcKyZUI+aVR/oBbHbZgiggfg4417x8OWtfgpeiZ77F
         tKu9txadr8mqRh2PQmCVkE6XX+s3I9loUxCI7XTTFw/Yn0d2vsBrWnt0TQjN8L8shwBy
         oJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzabWvrTaM3dlhAMkGE1TPAE+zrQX3XHiWsmylmIlBU=;
        b=nZIIMH39wCkgCx2ZC/jp3+sSjxafemebu8izzK3NTFmMwP8yIAJ6Xxl9Vi/4A4L243
         qFFaYdbwbnFfc/NYu8N/3ySP6Nv/sfeBP56cqEVLvQXzmxfZTYshG56DzoZStEjEMUPp
         PS2iEo29hqQF4jHX1fmHgcVbpGVYXahNt/qC/lBmJiiXv3eW9oo+KThx1IH6H7fKhSnG
         9CfQA2e1hQgwlmgDE3ixbX7Prajkm5tOfUGc8iW6vKSgJcavdXj+OybKIAFlx5GYDP5z
         2C2L/9yubHzif0xUoa7Doe2PEXoL6B0SaVHhxDllY+QtwlV1BFe738Co/C+tyZvoy/4W
         koIg==
X-Gm-Message-State: AOAM53072pjcOmR5rWtYvq0z0+fPYjNd3VhML6JPEvQLxGjwqCCaE/tp
        LThfJun2pd+oWnuDxmUHHCsr2A==
X-Google-Smtp-Source: ABdhPJz90bjV8HNPkHQzMz/XoPtiqek4tWIDIT6qDxVDzEa6QFp1dFA6Swhn79pbKl14mnyKnqqj0g==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr16168668wma.66.1626436210180;
        Fri, 16 Jul 2021 04:50:10 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:fb3b:45b4:a42a:5668])
        by smtp.gmail.com with ESMTPSA id k24sm10147181wrh.30.2021.07.16.04.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 04:50:09 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:50:04 +0200
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 0/6] Final si_trapno bits
Message-ID: <YPFybJQ7eviet341@elver.google.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
 <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org>
 <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
 <87a6mnzbx2.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6mnzbx2.fsf_-_@disp2133>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 01:09PM -0500, Eric W. Biederman wrote:
> As a part of a fix for the ABI of the newly added SIGTRAP TRAP_PERF a
> si_trapno was reduced to an ordinary extention of the _sigfault case
> of struct siginfo.
> 
> When Linus saw the complete set of changes come in as a fix he requested
> that the set of changes be trimmed down to just what was necessary to
> fix the SIGTRAP TRAP_PERF ABI.
> 
> I had intended to get the rest of the changes into the merge window for
> v5.14 but I dropped the ball.
> 
> I have made the changes to stop using __ARCH_SI_TRAPNO be per
> architecture so they are easier to review.  In doing so I found one
> place on alpha where I used send_sig_fault instead of
> send_sig_fault_trapno(... si_trapno = 0).  That would not have changed
> the userspace behavior but it did make the kernel code less clear.
> 
> My rule in these patches is everywhere that siginfo layout calls
> for SIL_FAULT_TRAPNO the code uses either force_sig_fault_trapno
> or send_sig_fault_trapno.
> 
> And of course I have rebased and compile tested Marco's compile time
> assert patches.
> 
> Eric
> 
> 
> Eric W. Biederman (3):
>       signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
>       signal/alpha: si_trapno is only used with SIGFPE and SIGTRAP TRAP_UNK
>       signal: Remove the generic __ARCH_SI_TRAPNO support
> 
> Marco Elver (3):
>       sparc64: Add compile-time asserts for siginfo_t offsets
>       arm: Add compile-time asserts for siginfo_t offsets
>       arm64: Add compile-time asserts for siginfo_t offsets

Nice, thanks for the respin. If I diffed it right, I see this is almost
(modulo what you mentioned above) equivalent to:
  https://lore.kernel.org/linux-api/m1tuni8ano.fsf_-_@fess.ebiederm.org/
+ what's already in mainline. It's only missing:

	signal: Verify the alignment and size of siginfo_t
	signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency

Would this be appropriate for this series, or rather separately, or
dropped completely?

Thanks,
-- Marco
