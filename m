Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A99249196
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 01:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHRXzE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRXzD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 19:55:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5560C061389;
        Tue, 18 Aug 2020 16:55:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 189so9851759pgg.13;
        Tue, 18 Aug 2020 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7422GZO6a07uIkKor7gPEwTDJ5nsCQ3Ry5yAt5O8lbE=;
        b=gMyjMFHMZ82HKryOjvxwx+F/WntkodrlGmMyg6R7N0IHb5pHbZJ2k0ralLblXfYqL/
         HQZjT2RKaUaN3Uk3JabTmTarIRkc3O68LG7LcQH8kYO86uTGmkxmC9Ytu/uttNCVZa2o
         x3obkAAD8V+AhQ0gZu2rje3wjt0tugdGmVYAwn1DUd2a0Lt/pCFhkrAI/1sFTvK2+ZrH
         8bsq4C+a5mGB7fkRfk8nDdyDoV7XhBrorbH+5b5BDCVx6zy1RK7cx4R2mmh8fIFE+Lba
         qsiBqHi5nQQiyojMGEz1nD9G4jfH0RSejMBTfanRtuUDRIbO/WFS5JiKmxNHmj5fbCNB
         fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7422GZO6a07uIkKor7gPEwTDJ5nsCQ3Ry5yAt5O8lbE=;
        b=M27Um82/BV7LZqfa0zQy7DHUJaWCqPzLMw0eiLEpM5tuAKWBZA3WW6WiFRjbKBQ0Rw
         a+BEk1Hyl38TSuWxiQcEr+rmdHPH/o3jvFxkx/zqtD8msAOGYqDX1diiDEePYHgwp2+S
         oR5rdqiRyVAwfHBOfVlAikeGc64BAHpPx9eGgKWLDLLImi7NgKrPg8MzXuL190fPBdOg
         pXul0jSFE0DhTn3+najdYjmzjfzU9cDgX4kbdHk4YV5sF6IBlBcmApIo0OQ2MVIUrqln
         Sgxxf6LjuHU3yRVuLKEJNCeBlPWwQYbdo6w/r70AbsR8cTeHjoa0ear/yy82TlUd/Scq
         Jp1w==
X-Gm-Message-State: AOAM532wljonu2vb9AHG4/YhAoqH8GMdseuSgJgSbwI3CfECxrV/c3Df
        iAlk5GAwoQaFHORCpa5iDQJJempKtKA=
X-Google-Smtp-Source: ABdhPJyzpeAN/fom5Hv0bXjaUwSL/42Sf1RXPTAqHPvb7BVJcMMUtDCYGB20BWOdQLzx7mJ5D5fnvg==
X-Received: by 2002:a63:471b:: with SMTP id u27mr14757480pga.139.1597794903474;
        Tue, 18 Aug 2020 16:55:03 -0700 (PDT)
Received: from localhost (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id q12sm27030752pfg.135.2020.08.18.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 16:55:02 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:54:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     peterz@infradead.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200807111126.GI2674@hirez.programming.kicks-ass.net>
        <1597220073.mbvcty6ghk.astroid@bobo.none>
        <20200812103530.GL2674@hirez.programming.kicks-ass.net>
        <1597735273.s0usqkrlsk.astroid@bobo.none>
        <20200818154143.GT2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200818154143.GT2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1597793862.l8c4pmmzpq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of August 19, 2020 1:41 am:
> On Tue, Aug 18, 2020 at 05:22:33PM +1000, Nicholas Piggin wrote:
>> Excerpts from peterz@infradead.org's message of August 12, 2020 8:35 pm:
>> > On Wed, Aug 12, 2020 at 06:18:28PM +1000, Nicholas Piggin wrote:
>> >> Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 p=
m:
>> >> >=20
>> >> > What's wrong with something like this?
>> >> >=20
>> >> > AFAICT there's no reason to actually try and add IRQ tracing here, =
it's
>> >> > just a hand full of instructions at the most.
>> >>=20
>> >> Because we may want to use that in other places as well, so it would
>> >> be nice to have tracing.
>> >>=20
>> >> Hmm... also, I thought NMI context was free to call local_irq_save/re=
store
>> >> anyway so the bug would still be there in those cases?
>> >=20
>> > NMI code has in_nmi() true, in which case the IRQ tracing is disabled
>> > (except for x86 which has CONFIG_TRACE_IRQFLAGS_NMI).
>> >=20
>>=20
>> That doesn't help. It doesn't fix the lockdep irq state going out of
>> synch with the actual irq state. The code which triggered this with the
>> special powerpc irq disable has in_nmi() true as well.
>=20
> Urgh, you're talking about using lockdep_assert_irqs*() from NMI
> context?
>=20
> If not, I'm afraid I might've lost the plot a little on what exact
> failure case we're talking about.
>=20

Hm, I may have been a bit confused actually. Since your Fix=20
TRACE_IRQFLAGS vs NMIs patch it might now work.

I'm worried powerpc disables trace irqs trace_hardirqs_off()
before nmi_enter() might still be a problem, but not sure
actually. Alexey did you end up re-testing with Peter's patch
or current upstream?

Thanks,
Nick
