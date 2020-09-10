Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9998264F03
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIJTcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 15:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgIJTc2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 15:32:28 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D89C061573
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 12:32:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y11so4234250lfl.5
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTbGWidANXm2pjjCI9iaMQBY/df45EdumvXop+9a4ao=;
        b=gkhGKJWFcLTHyB5x5aFfN6rnXH8dCRqQWjJKd9NZmHZK/NC/oX0q6HVDmBmeekhRv6
         GTPYMsgUuX5KTeHU91CyIJtiMizZNYrRnX9QG0ENhdKweAOaB0W4mGxVSrji+PC28UP6
         VshPJp7YLq+DwXcjz/A/kXWDuc/ae+MhCxRmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTbGWidANXm2pjjCI9iaMQBY/df45EdumvXop+9a4ao=;
        b=g8R84oCulzBYdXC8eSjt9DV9JwLFiIPEfpJ/Q814Y/Jl6Co3B73b1StOr3tcAFQx6q
         BpmN/75h+Zyf9cRvf8t93iSy3nJqJATj9mA4BOZyszeprPX+d8oBurXDs8nLCD0ZZom5
         zqTy5SZpAwVTTqpn7XFS7FXEexiqDN2ToVF9M+4Puvg50tcWSJCywWWJuX+kUbBrz8E+
         L77KO57IA/mlDXQKOeCAywlJblPd9ijJlrUfERF5T02qMGCKjAQLTCkDltrnxPy9cY+5
         Mfst/vEI2LzLi9diESV0q3bbElTpf7+NdRWEbNguBojgj5CRRfGrhn7a8C0Lt413NgIJ
         BBUA==
X-Gm-Message-State: AOAM533qYm4rDiBqxOWm/2m4TPtxjrqfutPvQf0PZyVxVNuQbotr6ZVW
        aF1epvxeIS+MGILqxpHmviKaxOacujJ1mA==
X-Google-Smtp-Source: ABdhPJwr9zRbbiig75etqqdqGiOv+gP6zTTLTwbrdVPkKDJygAKjd4s6noOGtJmTnC42L+xJ7qpy7A==
X-Received: by 2002:a19:480c:: with SMTP id v12mr4868991lfa.195.1599766342667;
        Thu, 10 Sep 2020 12:32:22 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b11sm1545636lfo.66.2020.09.10.12.32.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:32:22 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b19so9665494lji.11
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 12:32:21 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr5043564ljc.371.1599766341582;
 Thu, 10 Sep 2020 12:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca> <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
 <20200910211010.46d064a7@thinkpad>
In-Reply-To: <20200910211010.46d064a7@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 12:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Message-ID: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 12:11 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> That sounds a lot like the pXd_offset_orig() from Martins first approach
> in this thread:
> https://lore.kernel.org/linuxppc-dev/20190418100218.0a4afd51@mschwideX1/

I have to admit to finding that name horrible, but aside from that, yes.

I don't think "pXd_offset_orig()" makes any sense as a name. Yes,
"orig" may make sense as the variable name (as in "this was the
original value we read"), but a function name should describe what it
*does*, not what the arguments are.

Plus "original" doesn't make sense to me anyway, since we're not
modifying it. To me, "original" means that there's a final version
too, which this interface in no way implies. It's just "this is the
value we already read".

("orig" does make some sense in that fault path - because by
definition we *are* going to modify the page table entry, that's the
whole point of the fault - we need to do something to not keep
faulting. But here, we're not at all necessarily modifying the page
table contents, we're just following them and readign the values once)

Of course, I don't know what a better name would be to describe what
is actually going on, I'm just explaining why I hate that naming.

*Maybe* something like just "pXd_offset_value()" together with a
comment explaining that it's given the upper pXd pointer _and_ the
value behind it, and it needs to return the next level offset? I
dunno. "value" doesn't really seem horribly descriptive either, but at
least it doesn't feel actively misleading to me.

Yeah, I get hung up on naming sometimes. I don't tend to care much
about private local variables ("i" is a perfectly fine variable name),
but these kinds of somewhat subtle cross-architecture definitions I
feel matter.

               Linus
