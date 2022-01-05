Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDA484BEF
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 02:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiAEBHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 20:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiAEBHr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 20:07:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB92C061761;
        Tue,  4 Jan 2022 17:07:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f5so155343884edq.6;
        Tue, 04 Jan 2022 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QcBoRznUQAtg4CEHssJ6IifXUoLNnxsCgJFoPsNsb6A=;
        b=LiLJAkJ0XeZjqsciuczbQmeqfldjcMuDVO48OIZgmdniFlvaypegSIX2JGGRz0EiGt
         YbFzR/jt5iCc49g1leTPWmZpyorA9WAZGm2xoEWE86zAKeS8k9BJWAo0T5ghWH3i6bX6
         Z66fNYyf1RYgsnKvIB30W8m49lxPGdFjQW8iIg+orlXe/EnEjqCF0tkSWLQGfoiOxPzl
         NarKYUn5vvQd6IwtHsADDxQJ5Ws1tYq6pOvndi8i0h4A11hFkCicn70YV9VoHJ/KgTDv
         RkgoOwadBua/is1dnpO/ANR2usdDW6WehCfLtG0mPUBkmPa5W1HxjqXezYCmxGZ7+KVN
         Ivrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QcBoRznUQAtg4CEHssJ6IifXUoLNnxsCgJFoPsNsb6A=;
        b=lSMawEJMWHpCDb9tyJRsDzDv9qQYX9gsIAtHa+Zz9ff9dc+s817C60D3sfGv7Y9hp6
         LVBhsY8i1+hTKrD5WA/XS8Jah4L4NycfzxQq+n3wtTOk3ECScU4i/D3UGMkLM9MQXDF4
         /hTokI6/s7XqN39BiRDOmZG9VnAY+2YjDcbahGSFrIxVr8n5rN4vg1YiQdMaSHOOm5yW
         4Y2MH4nHO1SZW7cN9eA9Tm4M4dGkbFilRCzoHTDL8F94Df8E2ZbQVWDXvahWofwk2Fsr
         6h1mYXwrEyTsw16U+gCE7mcArC8ETItbvK3N7JJistd60ZP4E3cj4UvdD/5jsbFwQcqa
         rY1g==
X-Gm-Message-State: AOAM532T5JGMwCNvRvUC1LbbZ/Q4UWiW4UkXltOTY04dBw4qK6l6b02l
        LBqUI5LjptTpmdi3t8GdJWY=
X-Google-Smtp-Source: ABdhPJxwbYP1wQfL9S/iZi9ubZVSGaotyhW3Tig/qr6A+xXhD0bJjHhiaKyAZaRiOHmgJJCtwzW1/Q==
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr50100643edc.100.1641344865149;
        Tue, 04 Jan 2022 17:07:45 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id sh11sm11965180ejc.17.2022.01.04.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:07:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 02:07:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdTvXkKFzA0pOjFf@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTpAJxgI+s9Wwgi@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > > I.e. I think the bug was simply to make main.c aware of the array, now 
> > > that the INIT_THREAD initialization is done there.
> > 
> > Yes, that seems right.
> > 
> > Unfortunately, while the kernel now builds, it does not boot in QEMU. I 
> > tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if I 
> > could reproduce that breakage there but the build errors out at that 
> > change (I do see notes of bisection breakage in some of the commits) so I 
> > assume that is expected.
> 
> Yeah, there's a breakage window on ARM64, I'll track down that 
> bisectability bug.

I haven't fixed this ARM64 bisection breakage yet, but I've integrated & 
backmerged all the other fixes and changes, and pushed it out to the WIP 
branch:

    # 1755441e323b per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets

    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers

Let me know if there's anything missing or if there's a new breakage.

This is pretty close to what will be -v2.

Thanks,

	Ingo
