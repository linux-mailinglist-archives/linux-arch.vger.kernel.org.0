Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9102D38737C
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbhERHq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 03:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347262AbhERHqz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 03:46:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0401261354;
        Tue, 18 May 2021 07:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621323932;
        bh=Y+V2srtgNnzj+sz2D9W3MzRLHA3Oyb4L5KvaOMTQZcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vK5VwonkDkZYGOJp6YPxhRKo6knrgsSkaAV/BX3HDLzqeEaTAA+6V1aM0uWRDthgO
         GA7xKHvqnbCcxPWVCRWRH2Taf9+f9jqeDMaFKjz1LKAzQsp9D0Hj6SKDK7AgkY9npN
         sg8FN/TpGhAqh4JO7a2DPGtzS2OTYOEWJSQhvhiGqNSA3PDbQL21zcnKcro361OA2B
         IBdhXiQuiIN9AqsY8tKloo056FxIXo4X+X7QWU4SkRt/RDz64TQOfPaQL97O5SNST4
         pFYGuFPVxLVdQbqr6YF2uL28MgO9SvebKPyOiEI8oWODxf2w2ZWKAf0o1A9GfGxwqA
         TyrtMikqL9vqQ==
Received: by mail-wr1-f54.google.com with SMTP id z17so9025539wrq.7;
        Tue, 18 May 2021 00:45:31 -0700 (PDT)
X-Gm-Message-State: AOAM532pYNhbYCwIOE0jH2gDbkHp51VeR1kuO38iOQE7Ole+hOZYORDt
        ztX3+qmg43Hb6txnWxnSZ3ni+r0g9qv0ofnKmuQ=
X-Google-Smtp-Source: ABdhPJzB9aNOakOhJJsNXyx8q3Jo6fxvkR8RjdO1U05M07un4qbYlL3TFt5Q+CmgOiR5uSU3DTozp5J+ZhaPeYV8A5U=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr5184734wrv.286.1621323930626;
 Tue, 18 May 2021 00:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-2-arnd@kernel.org>
 <m1y2cc3d97.fsf@fess.ebiederm.org> <YKNhXQ883lRbqQGA@infradead.org>
In-Reply-To: <YKNhXQ883lRbqQGA@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 09:44:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ecwY1hwDqhW7DyQMGR1a7xiQND=1s7Pd9OP7i5+hoWg@mail.gmail.com>
Message-ID: <CAK8P3a0ecwY1hwDqhW7DyQMGR1a7xiQND=1s7Pd9OP7i5+hoWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 8:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 17, 2021 at 10:57:24PM -0500, Eric W. Biederman wrote:
> > We open ourselves up to bugs whenever we lie to the type system.
> >
> > Skimming through the code it looks like it should be possible
> > to not need the in_compat_syscall and the casts to the wrong
> > type by changing the order of the code a little bit.

There are obviously other ways of doing the same. The reason for doing it
this specific way is so I can eliminate the compat entry point entirely in
patch 4/4.

> What kind of bug do you expect?  We must only copy from user addresses
> once anyway.  I've never seen bugs due the use of in_compat_syscall,
> but plenty due to cruft code trying to avoid it.

Right, I've used the same approach of passing a native-typed __user pointer
and converting it in a copy_from_user/copy_to_user wrapper in a number of
other places, as this tends to produce the most readable version by
concentrating the tricky logic in the one place that already has to be careful.

Most of the bugs I've seen with compat code are from duplicated code paths
that diverge over time when a bugfix for the native version is applied
incorrectly
or not at all to the compat version.

        Arnd
