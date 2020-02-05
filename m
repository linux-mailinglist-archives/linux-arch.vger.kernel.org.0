Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35831153083
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBEMYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 07:24:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44127 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEMYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:24:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so2071953ljj.11
        for <linux-arch@vger.kernel.org>; Wed, 05 Feb 2020 04:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNJTQRpvL9KkINBfR6JsMwnparCaLzisFRucTcRYKRU=;
        b=o+QAMuQsOlmfI+xJDJQOPCspwS/4JdBY8TvHBLahl6cBsVNuTgqcmKqFdg8K8wt6+O
         A+oRVpPYqRwFqKEEgH2DEJwuPovAUr1pGcUkxZKgA4HqeomFlmLyMGX505hMrfb3tnqU
         P/QQLox9bU581U3QsMCYGeMDVZdv9x5/sBEnBw/yQlPSmgF9v6JdszIlzCPvCGgA7Q/j
         7U6hbcbhejCTlG3Dt9nEl1NteEBokfLA83YQDeXYDL43rf6uxZXY8lBuTsJd/Pl4u2fD
         hul1l3CGnUVUkhU3Hj7Iz00COP/qFPCQ92Qlgf761Io7Hhl+bGqF1DPFprt5U6Af23k8
         5FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNJTQRpvL9KkINBfR6JsMwnparCaLzisFRucTcRYKRU=;
        b=WgkjAdfj3pokZo+jOF6z7p2/KNQuxaSSp+opIiwGO6x/30/vLzJh+dnKeGTdvWbQ1o
         sayNv+LaaTnRsCk8j+QmUJDNAsNp630g9HdYTIxuy69KmrfysyAL3nHWY55Wmbc0GhzI
         6P0sOc4pjaEBl0nKZ8uPlsVqtRyoh10ZwNpjoQqswEzRVsLlGRfUb8V+nopK7MUVWnZc
         MZ1iC4jro/L+5OQtF1UEEWmnt7New3zCOviqdzjg5qmFiNVM0DyyGdubabOLsiatbf8l
         o+UXosq6L6HNB1KwMRgPUorvCzXzoEqfHCWzruC8mw/FpMFAuN5DpMQOYiS9K5mzV241
         YhvQ==
X-Gm-Message-State: APjAAAVhOyVjgqGQFHjoAFpXL5otPiHba4R2yGz7QOXVGx1xw0M9/gQg
        iisiEXsn8g5L2KhluQMrQkiGWNY73vMlZP5pOTukfrlZMEw=
X-Google-Smtp-Source: APXvYqwF/IFipOIXbw//cZg/+/z4SIsBW1Cx/rEUivXce1Gh45q0nNjPvOFjJLRU1D6MbVY0CSPb1VuHCfOMpXUyxlc=
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr1515306ljp.32.1580905489363;
 Wed, 05 Feb 2020 04:24:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580882335.git.thehajime@gmail.com> <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200205093454.GG14879@hirez.programming.kicks-ass.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Wed, 5 Feb 2020 14:24:38 +0200
Message-ID: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 5, 2020 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> >
> > With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> > are not compiled due to type conflict of atomic64_t defined in
> > linux/type.h.
> >
> > This commit fixes the issue and allow using generic atomic64 ops.
> >
> > Currently, LKL is only the user which defines GENERIC_ATOMIC64
> > (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
> > issues before this commit.
>
> Uhhhhh, no.
>
> Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.
>
> Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.
>
> Please explain more.
>

Hi Peter,

I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
understand your point that a 64 bit architecture that can't handle 64
bit atomic operation is broken.

One way to deal with this in LKL would be to use GCC atomic builtins
or if that doesn't work expose them as host operations. This would
keep LKL as a meta-arch that can run on multiple physical
architectures. I'll give it a try.
