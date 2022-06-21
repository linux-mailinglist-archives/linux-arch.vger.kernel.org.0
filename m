Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD35553E46
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 00:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbiFUWFa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354458AbiFUWF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 18:05:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054962E9EB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 15:05:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d19so17067259lji.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qk9wW2plDRuZUfEbH5Ob9wJ8MzMD7oQ2u+YwN1EZlno=;
        b=PksK/pvVejHaPuJXQTH64r9lAa+BSxcqKlrp/YdZR0LE3hMPpWsFWMmQlN59uGmqpC
         NGtOHmEng/i/D9QbisoA6LN/yBGK4iJJU/k3KEURwdY+ntci4FCk3uFB9wCf3zkTyyph
         ujW4+5Ew683yYv1nlMz+a1NfvCpJtah5v1ZIP9FAYrl/OBRwO35C0h4y6vt/5DidZ0aA
         VDgDJZB5O2+5JjDtUDq97kAzxKFMzbHUTgi+BlLmCK8Vaoeh9ARNa840AGaHLk8g7jiE
         HhIIQ5x6G6w07sWsUsLL5/c4nKukLWjXG7Og10dAonWaQ2gTR4W0jlT/QAo+ZavHaGtb
         stUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qk9wW2plDRuZUfEbH5Ob9wJ8MzMD7oQ2u+YwN1EZlno=;
        b=jUlQqjO+sI4SVRBfw2ly5hsV6CyreOiNHGCwdLR62D56LCdA5sEDUDASQiQKA7zOdE
         /h0aAy/NL70SnhFtLx4vXDtPd0BRmK0w0UOxxSXOgUQQ5a5dnzTGEny8aDWmPu9i72Y7
         qpecS0IOvlOdqG/XyeaWxvcWC36qDwfkHEQ9qaA7ALkl/hXbCbmsR0Ijo/PDHveEVtVx
         AGZlh/1fjJRqb5iRdcM+p2hapN8u+gvR5dI218rzTnrRG6Wn5WCVo5MaWaz1yP+Pea2Z
         ifHr4KgnlGICKae2y4X4VvWB9Z/sMsmlzBypmGftGBSQxhrVkmMo9hy1beQFe3H6B+NU
         QPvw==
X-Gm-Message-State: AJIora9iIdbh4NE9bnYEr06jEn3ZbElEl82s63r6DqMcafyr+9haz7qj
        Moi3GZQrZ0O43gUOCIdveOg4AJb6de7ct5ur6oiQcg==
X-Google-Smtp-Source: AGRyM1s8ItdZNicXgy4vfEI31Rcdko+391VPjrdp8750VHiNV/XVuGohJzT8zmLpof5YTXJPo8fI2yLlcamrBqB4reA=
X-Received: by 2002:a05:651c:23b:b0:259:fee:cc2a with SMTP id
 z27-20020a05651c023b00b002590feecc2amr130672ljn.400.1655849123759; Tue, 21
 Jun 2022 15:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local> <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
 <YmKF5tiH4W8AVdXe@Pauls-MacBook-Pro.local> <CAKwvOd=yLgY_0SwfBuOAzo=+zeWNMu4FMp65y0bi_RM+1G3NWQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=yLgY_0SwfBuOAzo=+zeWNMu4FMp65y0bi_RM+1G3NWQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 15:05:12 -0700
Message-ID: <CAKwvOdkrZbRTfrK_cFRseoONGi7qQ-_4vB=Zm9KH3Bb2KZ5tww@mail.gmail.com>
Subject: Re: Dangerous addr to ctrl dependency transformation in fs/nfs/delegation.c::nfs_server_return_marked_delegations()?
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 17, 2022 at 3:29 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 22, 2022 at 3:39 AM Paul Heidekr=C3=BCger
> <paul.heidekrueger@in.tum.de> wrote:
> >
> > On Thu, Apr 14, 2022 at 02:21:25PM -0700, Nick Desaulniers wrote:
> > > On Thu, Apr 7, 2022 at 8:22 AM Paul Heidekr=C3=BCger
> > > <paul.heidekrueger@in.tum.de> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > work on my dependency checker tool is progressing nicely, and it is
> > > > flagging, what I believe is, a harmful addr to ctrl dependency
> > > > transformation. For context, see [1] and [2]. I'm using the Clang
> > > > compiler.
> > > > [1]: https://linuxplumbersconf.org/event/7/contributions/821/attach=
ments/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > > > [2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-=
Pro/T/#u
> > >
> > > Hi Paul,
> > > Thanks for the report and your (and your team's) work on this tool.
> > > Orthogonal to your report, Jose (cc'ed) and I are currently in the
> > > planning process to put together a Kernel+Toolchain microconference
> > > track at Linux Plumbers Conference [0] this year (Sept 12-14) in
> > > Dublin, Ireland.  Would you or someone from your group be able and
> > > interested in presenting more information about your work to an
> > > audience of kernel and toolchain developers at such an event?
> > >
> > > Would others be interested in such a topic? (What do they say in
> > > Starship Troopers...?...Would you like to know more?)
> > >
> > > [0] https://lpc.events/event/16/
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> > Hi Nick and Jose,
> >
> > Many thanks for inviting us! I would love to do a talk at LPC! Hopefull=
y
> > in person too.
> >
> > Given that there have been several talks around this topic at LPC
> > already, it seems very fitting, and we'll hopefully have more to share
> > by then. Actually we have more to share already :-)
> >
> > https://lore.kernel.org/all/YmKE%2FXgmRnGKrBbB@Pauls-MacBook-Pro.local/=
T/#u
> >
> > I assume we will have to submit an abstract soon?
>
> Yes, if you go to: https://lpc.events/event/16/abstracts/
>
> click "Submit new abstract" in the bottom right.
>
> Under the "Track" dropdown, please select "Toolchains Track."

Hi Paul, we'll need all proposals soon.
If you're still considering attending Linux Plumbers conf, please
submit a proposal:
https://lpc.events/event/16/abstracts/
Please make sure to select "Toolchains Track" as the "Track" after
clicking on "Submit new abstract."

> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
