Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBF228217
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgGUO1D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUO1D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:27:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9FC061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:27:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so6467508wrh.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kvJLCEgw2Y91sCTQ6JSG1TMyYmzQtuSE0ssBK5vqs5A=;
        b=Tn+r0hMiMyEfGIJmZgmo6wJEFjb2HH6GCrM+njCb9LqnllYAU1jL/tRFHVOeISf8V0
         cUgzOv7/XLu0fcSl8pd3MBTDTZY4dB7Vj4ztR+pUk27T4bLEaDmQjd870ztfZE0Kh12K
         4qq1hYirQGcUBcFBjWPZSZhsCbhkLRbJfpQswZDiNdzKd7iwJfENFFapWeWcielyE7x8
         zoi0q6a4YYf2XTduTfPeWTq3gUNdYH24cM0O/EmtkUk2u7/Fq5B8/oEPdSSJJ8E2fXK8
         1PxAqg5uOIoTDm453qNw/rmJn2Qqgv6kUu99tXCA1QdwzumYYSbR+0M+eaovBe/b9MlF
         cNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kvJLCEgw2Y91sCTQ6JSG1TMyYmzQtuSE0ssBK5vqs5A=;
        b=Nnvt3+Bbq2ajdeNfPJbU6o1J+M4j43TMxv3Lxe0xn2U6l0zmc57EmkKpE5SXlytNsC
         S+W+cZzZ1zDY6sEPTJNP5/Uf7qX1zaKl3rPyDLRWhYFdsWyqriA88qJ79hysFIib8mA4
         AhDh81RMIlSvjqlK19jJnJGZq+xyL0kQBgc6bP1qlrF/TJp6YISmliiuzuDeA9asfxX8
         XfcV38zBOx954ZeGFIdXl1xlqeE0keTrCAZ6sC5dZCHXuzm/X75wzyb78noTiKoMOPNb
         fRGP1ku9nzbZUEVeP9EyCXMBRBERsXB/bucaRL7ya+U4/uiV8GKUDv8NA6GtywSvwHVw
         /LqQ==
X-Gm-Message-State: AOAM533dSa0Qf64tNdToItZeQefjcbBF880hXMXaBqGg0El2Yh9M9K0E
        Eo/CgaCB9Ec28T1g1AxvnGxevw==
X-Google-Smtp-Source: ABdhPJxGzk4oR9ONcZurm+l1j9rPZGsvwGlNZG3a4Foe4DEAKpp2AmXipHtkPf+S4ADPqd9YhnTwMA==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr25505561wrn.94.1595341620825;
        Tue, 21 Jul 2020 07:27:00 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id b18sm36258317wrs.46.2020.07.21.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:27:00 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:26:54 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] kcsan: Skew delay to be longer for certain access
 types
Message-ID: <20200721142654.GA3396394@elver.google.com>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-4-elver@google.com>
 <20200721140523.GA10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721140523.GA10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 04:05PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 21, 2020 at 12:30:11PM +0200, Marco Elver wrote:
> > For compound instrumentation and assert accesses, skew the watchpoint
> > delay to be longer. We still shouldn't exceed the maximum delays, but it
> > is safe to skew the delay for these accesses.
> 
> Complete lack of actual justification.. *why* are you doing this, and
> *why* is it safe etc..

CONFIG_KCSAN_UDELAY_{TASK,INTERRUPT} define the upper bound. When
randomized, the delays aggregate around a mean of KCSAN_UDELAY/2. We're
not breaking the promise of not exceeding the max by skewing the delay
if randomized. That's all this was meant to say.

I'll rewrite the commit message:

	For compound instrumentation and assert accesses, skew the
	watchpoint delay to be longer if randomized. This is useful to
	improve race detection for such accesses.

	For compound accesses we should increase the delay as we've
	aggregated both read and write instrumentation. By giving up 1
	call into the runtime, we're less likely to set up a watchpoint
	and thus less likely to detect a race. We can balance this by
	increasing the watchpoint delay.

	For assert accesses, we know these are of increased interest,
	and we wish to increase our chances of detecting races for such
	checks.

	Note that, CONFIG_KCSAN_UDELAY_{TASK,INTERRUPT} define the upper
	bound delays. Skewing the delay does not break this promise as
	long as the defined upper bounds are still adhered to.

Thanks,
-- Marco
