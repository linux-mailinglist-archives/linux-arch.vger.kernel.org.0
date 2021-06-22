Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490433B103D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFVW42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 18:56:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55326 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFVW42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 18:56:28 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by linux.microsoft.com (Postfix) with ESMTPSA id E0F4E20B7178;
        Tue, 22 Jun 2021 15:54:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0F4E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624402451;
        bh=Tl/MqcbHnp8xGqeWdgRroSBwVZt7wf+ch9P7/tROCwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HS9Z03mla6AcYrNF8e9t4BhRj+ZqxeC0m28b60MnUtCj5BoPxHGcsrgbvI85JV5fc
         rzTdN5SWGtvDovnJNq0tw5dGdwYPNiBE/uicd+MaewLpbxcEn8U5+10vccqWQbJzkZ
         YAF53lKJbJZpAjE1iAx3GJtvPELzKqTs/I74L2CQ=
Received: by mail-pj1-f53.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso108979pjb.4;
        Tue, 22 Jun 2021 15:54:11 -0700 (PDT)
X-Gm-Message-State: AOAM532qD5KkFuocTtLhJcZX5tN5HoycC0Owtu4a6yERs9RxtSduXLB2
        bSaVeSkR+lDn3fCOo8/pq/KVfjsfeqL8YlUgZFw=
X-Google-Smtp-Source: ABdhPJwur4gE5RoxKcLIaOyclPiSjF5vB4YWJrdEMaEpXNmQlecOYJB/5NdbhATAhHnr4SEgjhJIq+fga2b+ZlM+mbE=
X-Received: by 2002:a17:90a:1e82:: with SMTP id x2mr6352268pjx.11.1624402451512;
 Tue, 22 Jun 2021 15:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com> <YNChl0tkofSGzvIX@infradead.org>
 <17bb90eef20145cd9cca1b8e72a514ad@AcuMS.aculab.com>
In-Reply-To: <17bb90eef20145cd9cca1b8e72a514ad@AcuMS.aculab.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 00:53:35 +0200
X-Gmail-Original-Message-ID: <CAFnufp06+s43z5SxL48LB73=GdzYFiq578MCHZ_NMUNZkwdo9g@mail.gmail.com>
Message-ID: <CAFnufp06+s43z5SxL48LB73=GdzYFiq578MCHZ_NMUNZkwdo9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: optimized memcpy
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 22, 2021 at 10:19 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Christoph Hellwig
> > Sent: 21 June 2021 15:27
> ...
> > > +           for (next = s.ulong[0]; count >= bytes_long + mask; count -= bytes_long) {
> >
> > Please avoid the pointlessly overlong line.  And (just as a matter of
> > personal preference) I find for loop that don't actually use a single
> > iterator rather confusing.  Wjy not simply:
> >
> >               next = s.ulong[0];
> >               while (count >= bytes_long + mask) {
> >                       ...
> >                       count -= bytes_long;
> >               }
>
> My fist attack on long 'for' statements is just to move the
> initialisation to the previous line.
> Then make sure there is nothing in the comparison that needs
> to be calculated every iteration.
> I suspect you can subtract 'mask' from 'count'.
> Giving:
>                 count -= mask;
>                 next = s.ulong[0];
>                 for (;; count > bytes_long; count -= bytes_long) {
>

This way we'll lose the remainder, as count is used at the end to copy
the leftover.
Anyway, both bytes_long and mask are constant, I doubt they get summed
at every cycle.

> Next is to shorten the variable names!
>
>         David
>

-- 
per aspera ad upstream
