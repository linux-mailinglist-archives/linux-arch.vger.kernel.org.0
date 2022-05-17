Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C6A52AE2A
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 00:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiEQW3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 May 2022 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiEQW3x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2022 18:29:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA152E6D
        for <linux-arch@vger.kernel.org>; Tue, 17 May 2022 15:29:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h29so570610lfj.2
        for <linux-arch@vger.kernel.org>; Tue, 17 May 2022 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vRrKK940tfY15AL/k2whqSoFtZdbDZpofZ1keoPwuls=;
        b=bmW79KvYYbX9yJ25BckYi9U4OZPqh9WoGqI0OtODtPwXovUvFB0Mlx7LQg5aEmBLUA
         BiVzwzxveln6wne0cgVGF37mWxwUOsxkjXFyhS7Ax8UPP2uL61asXWWhB84s9eLrEoZI
         afCElLueYI9Ar3gaweUf3VPgkl8g5E5Xa1bH3nfox4kc7tal/yDxEE7djtQyPkLGrlNm
         FZTPC87BoRi7kWr611X2F6GFlucPK7Ih5N/LkMzOwVzwow7t/qDugrr5X5/tiMk8pEf7
         pcJeNVa+Qj8MSJRjtdM+pY3HWqdoLYvA/hhXaTzVduKO35znsTrdWKlyNc4Jl4t0AgRo
         3SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vRrKK940tfY15AL/k2whqSoFtZdbDZpofZ1keoPwuls=;
        b=Zjf+9GptFZsnGxINytXZMSyVR39EZytXk8Pn1uqYu0WD17RRY+oZLB+C42DnxJu6to
         nL7QURrdShwVKKN/p9yLAKOKGSnvaeahWBPmLabOUHPNHIm17sOgM4hnH9tKusbqMtYt
         5eaNglNIkj7HCnELaDiZ5FiTDBoF/0/XxXCInmRQg2lHbTOS0lVY+4dX6nNBRedsaIZR
         2VF98ygSN9Tj4v2vwhiEOMO3KR+iJ10zzpmfdq6jOBNM0pByDf/U0pHFZHmk0Zn/te7w
         EXssHXfH2rPwXsc2RA6szwFejVat3QRhUVvbFwxYuewbXJV095Ktxob0J1MG9/RCVEov
         RXgg==
X-Gm-Message-State: AOAM530Oc8bSTsiGbeCahNbHynQPbINkMdmE5X8nAs2BLdZJPwSIiCvQ
        iHr9FjYN/L0UpEHuUl1hswRy8HNjE8Z+WFKbstt2pQ==
X-Google-Smtp-Source: ABdhPJzAQmbCDjA2O7dLfFPHDMx+mXoBHhB/mP3eIxQ/7+fxV1qQkpaIZEiwttGEcDDfQrLU5iW98Ti7DlMBe9dnlbo=
X-Received: by 2002:a05:6512:1d1:b0:471:f63a:b182 with SMTP id
 f17-20020a05651201d100b00471f63ab182mr18342309lfp.392.1652826588756; Tue, 17
 May 2022 15:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yk7/T8BJITwz+Og1@Pauls-MacBook-Pro.local> <CAKwvOdkEULT_OOeaaCneJjbrE=O3kC8SMDs2thFa9gBfpuo2Jg@mail.gmail.com>
 <YmKF5tiH4W8AVdXe@Pauls-MacBook-Pro.local>
In-Reply-To: <YmKF5tiH4W8AVdXe@Pauls-MacBook-Pro.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 May 2022 15:29:36 -0700
Message-ID: <CAKwvOd=yLgY_0SwfBuOAzo=+zeWNMu4FMp65y0bi_RM+1G3NWQ@mail.gmail.com>
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
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

On Fri, Apr 22, 2022 at 3:39 AM Paul Heidekr=C3=BCger
<paul.heidekrueger@in.tum.de> wrote:
>
> On Thu, Apr 14, 2022 at 02:21:25PM -0700, Nick Desaulniers wrote:
> > On Thu, Apr 7, 2022 at 8:22 AM Paul Heidekr=C3=BCger
> > <paul.heidekrueger@in.tum.de> wrote:
> > >
> > > Hi all,
> > >
> > > work on my dependency checker tool is progressing nicely, and it is
> > > flagging, what I believe is, a harmful addr to ctrl dependency
> > > transformation. For context, see [1] and [2]. I'm using the Clang
> > > compiler.
> > > [1]: https://linuxplumbersconf.org/event/7/contributions/821/attachme=
nts/598/1075/LPC_2020_--_Dependency_ordering.pdf
> > > [2]: https://lore.kernel.org/llvm/YXknxGFjvaB46d%2Fp@Pauls-MacBook-Pr=
o/T/#u
> >
> > Hi Paul,
> > Thanks for the report and your (and your team's) work on this tool.
> > Orthogonal to your report, Jose (cc'ed) and I are currently in the
> > planning process to put together a Kernel+Toolchain microconference
> > track at Linux Plumbers Conference [0] this year (Sept 12-14) in
> > Dublin, Ireland.  Would you or someone from your group be able and
> > interested in presenting more information about your work to an
> > audience of kernel and toolchain developers at such an event?
> >
> > Would others be interested in such a topic? (What do they say in
> > Starship Troopers...?...Would you like to know more?)
> >
> > [0] https://lpc.events/event/16/
> > --
> > Thanks,
> > ~Nick Desaulniers
>
> Hi Nick and Jose,
>
> Many thanks for inviting us! I would love to do a talk at LPC! Hopefully
> in person too.
>
> Given that there have been several talks around this topic at LPC
> already, it seems very fitting, and we'll hopefully have more to share
> by then. Actually we have more to share already :-)
>
> https://lore.kernel.org/all/YmKE%2FXgmRnGKrBbB@Pauls-MacBook-Pro.local/T/=
#u
>
> I assume we will have to submit an abstract soon?

Yes, if you go to: https://lpc.events/event/16/abstracts/

click "Submit new abstract" in the bottom right.

Under the "Track" dropdown, please select "Toolchains Track."
--=20
Thanks,
~Nick Desaulniers
