Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEAE15325F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 15:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBEOAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 09:00:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35824 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEOAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 09:00:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so2431781ljb.2
        for <linux-arch@vger.kernel.org>; Wed, 05 Feb 2020 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6BKqmll16sOInobfU6VyCkhuSwCXAOJUDDJ8K0lOl0=;
        b=VgG4hoC6yd/IUqmqQbcNuGA7+KHrljNP38zXsPCrMieBIgjrAwhhfdzcaF0wELZ8RL
         yBVIuQrb1oWG6ojeJaSY9Ay+dtpaaVoRFC4s0n+6K4wRcOipGmJw9XbP1D3pGz75OqXe
         V/rECAXvaGkGvN/sE0K2hEIc2aBWkhWtqgh/3KH2XjN7hNu2aMaPIoxcT8yqwbdVN6UZ
         9mjXkGz8+g+Z/dJMXhbel0kN65lMuCSVnefy7m5oOBZn/Cp0EnQELFF6Zroe2wOC/Zis
         Po2bKcVwcccJexK0sqpRJrb8tjmJQpQGxoMen3XYk7u89M60ePE67TE9Je4dHkyIaLsp
         MiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6BKqmll16sOInobfU6VyCkhuSwCXAOJUDDJ8K0lOl0=;
        b=pKa0rrwcaqr/CNaJ+k9Kpq+sdGKkgoHw0CLeZEEo1D3lEr6MMekmiP3i12RM9q02ke
         lqpLdR+FmKPkvmLfJp4T0G6VFUa1G065PBmg8XAKpFF0UIKdux4hVwD5+7V/drzf5Eqh
         Jqj8dgNMRdPVMrN+pXBXiC0DfaR4QCGQzM3vj6D1Rc8cWnmZFdKdfi8Va9H1YkLkI0I1
         TMrmvBPA3B18mhN7lwi1PIGQ0PYQFea/GynKOWKM/gBtL7VawLEiD8eoCAzYEDsJDp96
         tV7YXUfKSD+e8Ehjg00r/IctcF/qAmojSeXHxjyOcyXBJHS4v4T9ZBySdzXatYyf4uUp
         PA9Q==
X-Gm-Message-State: APjAAAVxDNFNvcxVMSmI5UuAXBId5qnojsmvFnEve/YiywtuoVBdQTRS
        Wt+Yd6A1qGTl9SsbqBp1cAiJvveA1sBLmYFytNI=
X-Google-Smtp-Source: APXvYqzj7tuFJADMUMOVkY2HqHSaxJjv9q5s2AymZMtv0xgeFVL4tGw81sR0rNxMr/ssyCV83GUHYuORFKpo+Iupddc=
X-Received: by 2002:a2e:865a:: with SMTP id i26mr20719314ljj.236.1580911252143;
 Wed, 05 Feb 2020 06:00:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580882335.git.thehajime@gmail.com> <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net> <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
 <20200205124908.GL14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200205124908.GL14879@hirez.programming.kicks-ass.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Wed, 5 Feb 2020 16:00:41 +0200
Message-ID: <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
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

On Wed, Feb 5, 2020 at 2:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> > I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
>
> It might not have been, but presented with this patch, I feel like it
> should've been :-)
>
> > understand your point that a 64 bit architecture that can't handle 64
> > bit atomic operation is broken.
>
> (sadly they actually exist, I shall name no names)
>
> > One way to deal with this in LKL would be to use GCC atomic builtins
> > or if that doesn't work expose them as host operations. This would
> > keep LKL as a meta-arch that can run on multiple physical
> > architectures. I'll give it a try.
>
> What is this LKL you speak of and how does it do the 32bit atomics?
>

LKL is a build of the Linux kernel as a library that can run in many
environments including multiple architectures and OSes [1]

For 32bit atomics LKL also uses the asm-generic implementation. It is
very similar with generic 64bit atomic implementation and it is used
by multiple 32bit arches. I think this was my original reasoning for
this patch and not going with C11 atomics.

> One thing to keep in mind is that the C11 atomics (_Atomic) don't
> trivially map to the LKMM -- although I keep forgetting the exact
> details, there is a paper on it somewhere.  Also, once you're limited to
> a specific arch the issue also becomes much easier than C11 vs LKMM in
> general.

Thanks, I will look it up.

[1] https://github.com/lkl/linux
