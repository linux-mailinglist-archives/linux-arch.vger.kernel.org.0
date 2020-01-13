Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D891393D1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 15:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAMOkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 09:40:04 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMOkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 09:40:03 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Ml6i4-1jVcZa0wRw-00lTV4; Mon, 13 Jan 2020 15:40:02 +0100
Received: by mail-lj1-f173.google.com with SMTP id w1so10347745ljh.5;
        Mon, 13 Jan 2020 06:40:02 -0800 (PST)
X-Gm-Message-State: APjAAAWzD2ul6sj5rXLMJh6USlbl9+jEM5edJO9fuOZ9NHXkwo5abrxC
        W9AznZbF3fycNJtTX4qhfE1io+6S2xrYEV9GMOk=
X-Google-Smtp-Source: APXvYqyG+qKmdLtlyo+saYSnu5MHSGySW3aSQW9RS5F+YJRsHBRHifqWafDZ2kjCxII1OEgtsIpm5t4+I0vXZQXNo/k=
X-Received: by 2002:a2e:b5d5:: with SMTP id g21mr11036798ljn.89.1578926401740;
 Mon, 13 Jan 2020 06:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-2-will@kernel.org>
 <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com> <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
In-Reply-To: <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 15:39:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t9757M5CRKNX_X+T9VuLX+5=z5_845rLJGTG50RogXA@mail.gmail.com>
Message-ID: <CAK8P3a1t9757M5CRKNX_X+T9VuLX+5=z5_845rLJGTG50RogXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
To:     Joe Perches <joe@perches.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3fb8OaF47jNPkU9w7BdKJ+Mbx9CBT63TVUqOnD2X2APo3pepp1j
 qfqBVCjdOzuMymbGtjeyRYNBSSF1KFj/FsIxDZwGLKcKShfe4SGA079YWcijY4TK/Hzams7
 tacw5suIT4/Vw556Bb3qHPbwM1G7c4dq/FuSJVA8saQ7au8gbjzDqWx6o2Td9JWr5mo1CM4
 J/GDtkQLC4qa8zyFtExCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0hMiuvmEWa4=:IEnRoS5lIk4tJZDzirdCkJ
 MLLloKSgGBLBT2SB8S34L9+190u4DKsvRZvDwYYJixcEwNNvs6rqbxe++a4Qjs5oho/10zKgx
 r7JYCPRlPgjTc/LOJgWeFiQNRX5mP/xVIyrg9GvV5X3tOyMYukV/GGnf1iNwJVgnMRDK4NrFv
 RwwEW83bO3oVHsyHGNLfRCyD1hoYeKE2h7BjJWNHiRAPBECRF6rPPDY6utyOXVWkJWCDsJOQX
 b19pjMPGFWl02fo9N9OeCAdF+2ftPBcGQofTubclZ76/a+Avp7gKPuXQI86C8fuOBc5OM3Dd5
 w8uZmSXHwPI4c5rPo/MxiM7LuObG56HuWQ/SIXyQsgmbzBWKgkFFkD7tIjOI5yWTcOUaZRIbm
 52P3ZGDCOyOrBZtLETMqdAs0quYCP1/hZqLAJ7XC1gqTTT0e0KB4kwFjzewODMXzb5h90ayD4
 I3ZEJEyJOq7CNnaX5mOTX1wj5fm1Nh3JMsXWEy2vmqKC1jwoe/0HW/bGoejTRCMIcIKmh3QIj
 4pfwuV3AqRx2KayTn17MfDABC8SIUNuwxByLF7B6MZILP4OCmqUzCblAmmCtfOGahC5sZKaR7
 rYX5BDzZolZN09PnmYmyoFiJ7SWr+eSV6FuMJs73w9kxuqHFIQE9HheP4rOL98sQoD9xh7US3
 aqNviaxiq4EWXFjjYilnaKsPSsxYnBZdh8Syxyi3MmLyNdEAQAMBBBcM1JFPpTon6+oGhRRwG
 QmRlxtX87M/XKREA+/1BuLh/1+6vnno6R/J3QI+CfoiTRN4iiy94ibzUf7Yxqz+6iSR/Rg0f3
 ziUbHmJ/a3BW0XByP86Z0pEw2Or8WFH+eF1AjFh2FV+wR4IfhZr40HYfwofgWjFngnJai2A/C
 KoIpEidkRLoHYroi5Dtg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 6:54 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-01-10 at 18:35 +0100, Arnd Bergmann wrote:
> > On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > > discarding the 'volatile' qualifier:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > We've been working around this using some nasty hacks which make
> > > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > > kernel builds now, emit a warning if we detect it during the build.
> >
> > No objection to recommending gcc-4.8, but I think this should either
> > just warn once during the kernel build instead of for every file, or
> > it should become a hard requirement.
>
> It might as well be a hard requirement as
> gcc 4.8.0 is already nearly 7 years old.
>
> gcc 4.6.0 released 2011-03-25
> gcc 4.8.0 released 2013-03-22
>
> Perhaps there are exceedingly few to zero new
> instances using gcc compiler versions < 4.8

The last time we had this discussion, the result was that gcc-4.8 is
probably ok as a minimum version, but moving to 5.1+ (from 2015)
was not an obvious choice:

https://www.spinics.net/lists/linux-kbuild/msg23648.html

If nobody complains about the move to 4.8, we can try moving to
gcc-5.1 and GNU99/GNU11 next year  ;-)

       Arnd
