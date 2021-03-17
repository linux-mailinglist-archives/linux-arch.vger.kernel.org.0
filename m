Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0027833EE0D
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCQKHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhCQKGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 06:06:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6DC06174A;
        Wed, 17 Mar 2021 03:06:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so1160499wrp.13;
        Wed, 17 Mar 2021 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1SQ+GGNKDwyfIEItbEL2ldVAMl5sO8mIZDp5MyvIXo=;
        b=PRPO/T6jCzkfCSszaC/CFOWUg8NtnLPSmgNlJcmn6jD1U3/mNNPSQDkR/4E325CEAN
         pML0RzP5YEauFJDvBWh54Tq80XVZhyzoaL8rd5OdlZHXBly4nl0A54npC20KfoflgyWh
         l9MCBP3NmZv/dPBrtgcy+wdtqv1N0dJBzdMEND5jouQXkqHXNkSUUk3Ega/vZTYgThzZ
         Cw5lyiOpFlY4sJTvcP69sa6qqobXBsN47n0OXA30dy7WzqvQCDoAEX4+PNvDWNs2oueL
         UkOXLldjQFJh1TVLUVSzyUwN+RUFXvjxoKZ6jZY//BIT/8ROHxplXptIilmQ6aNVYuwu
         NnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=S1SQ+GGNKDwyfIEItbEL2ldVAMl5sO8mIZDp5MyvIXo=;
        b=CRG73fC711EdBfOwydiPW9xC7Y2siKBeRS8JmIXr1xOmWkJqrWDnYF2gU6mUlyUnBE
         9/YKzAwyF0rHh5BVKPmvq4h1oOn1kIJkYR2qgIem6HGUnUhyypRg1Rfpj6FtO3OJfGq/
         VR09yLymWbUqBfsZ6Wzc7y/xqKiSPbkXdbca7v8Cp/e6UfPNUVoUanY57zF4o6Hzxqsk
         J41+5uxbQi4DfURhu6YGY7FemMGkei9K3LlaN+7sCVIPIN88L3wKdL+S4e1tKPJZKucr
         6IaUiXh2Lvh7BYedF5r1Xsi8twuy2iBCV2OMpZHFGuUFCCYQrFp6w3Ny+d8Kt1zUET2J
         t7bw==
X-Gm-Message-State: AOAM531q/KOMhT6cor66nQq2lyitP6dzY6vn1OYb1FqzKa8ErQFQYlHU
        4f54Y2FM1i1ykRLYePDNmFI=
X-Google-Smtp-Source: ABdhPJxY2pxgwiRMeBhDz6nPlO1fx6e3+/U6q7fkzW/jAiOZzp6hJxiH5JrnDY+AVhXjVVEw9M82pA==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr3523398wrt.117.1615975602929;
        Wed, 17 Mar 2021 03:06:42 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q4sm1997617wma.20.2021.03.17.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:06:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 11:06:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     bp@suse.de, tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] x86: Improve Minimum Alternate Stack Size
Message-ID: <20210317100640.GC1724119@gmail.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316065215.23768-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> During signal entry, the kernel pushes data onto the normal userspace
> stack. On x86, the data pushed onto the user stack includes XSAVE state,
> which has grown over time as new features and larger registers have been
> added to the architecture.
> 
> MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> constant indicates to userspace how much data the kernel expects to push on
> the user stack, [2][3].
> 
> However, this constant is much too small and does not reflect recent
> additions to the architecture. For instance, when AVX-512 states are in
> use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> 
> The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> cause user stack overflow when delivering a signal.

>   uapi: Define the aux vector AT_MINSIGSTKSZ
>   x86/signal: Introduce helpers to get the maximum signal frame size
>   x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
>   selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
>   x86/signal: Detect and prevent an alternate signal stack overflow
>   selftest/x86/signal: Include test cases for validating sigaltstack

So this looks really complicated, is this justified?

Why not just internally round up sigaltstack size if it's too small? 
This would be more robust, as it would fix applications that use 
MINSIGSTKSZ but don't use the new AT_MINSIGSTKSZ facility.

I.e. does AT_MINSIGSTKSZ have any other uses than avoiding the 
segfault if MINSIGSTKSZ is used to create a small signal stack?

Thanks,

	Ingo
