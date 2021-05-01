Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781B3708FE
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAVEg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 May 2021 17:04:36 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:59364 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEAVEf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 May 2021 17:04:35 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8DC33A5DF54;
        Sat,  1 May 2021 23:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1619903018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcbSLwuICr6Udix8ctgEOYjRfptG+tEIQT5YVV6bUi8=;
        b=R+qKBo8+Odi+ppTFSIOpPGb8VaxfcVkkhTqC4TE0dsGVraIuFto8vUJM1p3s+WYkrA1JIQ
        7I+tt3lWzHq7mfTV52Y+RB0MgE/jVJ8gZ4PAwDEKxqqFxLQB7xWu8GS1SdkOOEWwj8w1M9
        52Rggvh2enI1e83tRL9WDcbTEGAikkg=
Date:   Sat, 1 May 2021 23:03:37 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Message-ID: <20210501210337.66qxgomc643lbdyi@spock.localdomain>
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
 <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello.

On Fri, Apr 30, 2021 at 03:06:30PM -0700, Linus Torvalds wrote:
> On Fri, Apr 30, 2021 at 1:46 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >
> > I've hit a mainline gcc 10.2 (also gcc 9.3) bug which triggers at -O3
> > causing wrong codegen.
> 
> I'd be more than happy to just disable CC_OPTIMIZE_FOR_PERFORMANCE_O3 entirely.

FWIW, we used to find real bugs using -O3 in the past [1].

> The advantages are very questionable - with a lot of the optimizations
> at O3 being about loops, something which the kernel to a close
> approximation doesn't have.
> 
> Most kernel loops are "count on one hand" iterations, and loop
> optimizations generally just make things worse.
> 
> And we've had problems with -O3 before, because not only are the
> optimizations a bit esoteric, they are often relatively untested. If
> you look around at various projects (outside the kernel), -O2 is
> generally the "default".
> 
> And that's entirely ignoring the gcc history - where -O3 has often
> been very buggy indeed. It's gotten much better, but I just don't see
> the upside of using -O3.
> 
> In fact, it looks like we already have that
> 
>         depends on ARC
> 
> for -O3, exactly because nobody really wants to use this.
> 
> So this bug seems to be entirely ARC-specific, in that only ARC can
> use -O3 for the kernel already.
> 
>              Linus

[1] https://lore.kernel.org/lkml/673b885183fb64f1cbb3ed2387524077@natalenko.name/

-- 
  Oleksandr Natalenko (post-factum)
