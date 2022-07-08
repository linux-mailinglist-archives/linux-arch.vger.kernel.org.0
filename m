Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452EC56B8C5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 13:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiGHLop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jul 2022 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiGHLoo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2022 07:44:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5797D1F8
        for <linux-arch@vger.kernel.org>; Fri,  8 Jul 2022 04:44:43 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c9b70c382so133386267b3.6
        for <linux-arch@vger.kernel.org>; Fri, 08 Jul 2022 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tm11KlnnIXGr7nvHs0RfeJdMMwEgYtIpJrEKcFo1S38=;
        b=rWcYb2tPMqjko19vnw97Xy75z7EjAz6RBmh89eGBLfmWyDs5ModNXPj7JLs08ESwti
         +P9qMDacx9NPWCzo1qvPCcqALe3Tv8TG17MwtGf6CntF5sNU/oO9fVYBahbKsEZFpdn/
         3AS1PfZBvgy7ZBGgTy1/yqKSA7oyPxZwxPOU0tGQjIuvhCtoHFl4LtEQ2iNATROVVHTr
         zc716yBryWj2deyUOFPTs3AZ8BY/DxP0SJNsbaLEMVmLxMPYHtWYvmJzahK+txzIFcdm
         ig7msRn8p3hWMA71b1/Vy6rhwS8zYwUWpf2L0NWvBveIFCAfaKzCilTFZ62+sD76TbOw
         MfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tm11KlnnIXGr7nvHs0RfeJdMMwEgYtIpJrEKcFo1S38=;
        b=BqKDRquY+ao6YKbD8m8sN+tVb0DATgYEYBcLQBoYE6kzjPY59W561glbbhoEAEGbxw
         MS39DPtZAVzp7WcFaxFYSkG2cqKPWnbF4KRJa+0g8gr7Pie2pq8LW92utDv1VPTofHgX
         Ou+MbR6kd3L58R+S7hxrvIxLfqXTGEi6hpanTu1FXZTAFId7t9q8pF+v9WeDnXfdxTPA
         kU3YOTeNZnl5M+QaYg3dXuNlCDyXnpeML+YZfU0bOl7pN4D6nJbCJSaLrqY/SAVDZlrb
         mVlSbHcDqYNzynZ2XTcgBmDLUTZzru7bOyy/ZR/2q3A3+NtT1LWi1CNZYHTETJVgWyIP
         wuMA==
X-Gm-Message-State: AJIora9XX+DltMMQERiUpN1De62c97jHZhcOZWgMO6JfRIXcyF8ItF//
        DTZ8TY1v3bpNS4duB8h1Gpg9BYtxvKtJmTbNqrFhew==
X-Google-Smtp-Source: AGRyM1vNSF6NE/lZtc1z0M3sVvfrVTwAwR04SbZxKdFyRoo8T5UGNKIPoyecbY5QwNtAgfJCrEYUC0i8y41EMg9uDSo=
X-Received: by 2002:a0d:cf07:0:b0:31d:17cb:ec11 with SMTP id
 r7-20020a0dcf07000000b0031d17cbec11mr3579407ywd.264.1657280682042; Fri, 08
 Jul 2022 04:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu> <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
In-Reply-To: <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
From:   Marco Elver <elver@google.com>
Date:   Fri, 8 Jul 2022 13:44:06 +0200
Message-ID: <CANpmjNOkXz=+221i70CWJexQWwfA_By3+7Cnimwgjmwn7RQdBg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in litmus-tests.txt
To:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
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

On Tue, 14 Jun 2022 at 17:49, Paul Heidekr=C3=BCger
<paul.heidekrueger@in.tum.de> wrote:
>
> As discussed, clarify LKMM not recognizing certain kinds of orderings.
> In particular, highlight the fact that LKMM might deliberately make
> weaker guarantees than compilers and architectures.
>
> Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tu=
m.de/T/#u
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Marco Elver <elver@google.com>

However with the Co-developed-by, this is missing Alan's SOB.

> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> ---
>
> v2:
> - Incorporate Alan Stern's feedback.
> - Add suggested text by Alan Stern to clearly state how the branch and th=
e
>   smp_mb() affect ordering.
> - Add "Co-developed-by: Alan Stern <stern@rowland.harvard.edu>" based on =
the
>   above.
>
>  .../Documentation/litmus-tests.txt            | 37 ++++++++++++++-----
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/me=
mory-model/Documentation/litmus-tests.txt
> index 8a9d5d2787f9..cc355999815c 100644
> --- a/tools/memory-model/Documentation/litmus-tests.txt
> +++ b/tools/memory-model/Documentation/litmus-tests.txt
> @@ -946,22 +946,39 @@ Limitations of the Linux-kernel memory model (LKMM)=
 include:
>         carrying a dependency, then the compiler can break that dependenc=
y
>         by substituting a constant of that value.
>
> -       Conversely, LKMM sometimes doesn't recognize that a particular
> -       optimization is not allowed, and as a result, thinks that a
> -       dependency is not present (because the optimization would break i=
t).
> -       The memory model misses some pretty obvious control dependencies
> -       because of this limitation.  A simple example is:
> +       Conversely, LKMM will sometimes overestimate the amount of
> +       reordering compilers and CPUs can carry out, leading it to miss
> +       some pretty obvious cases of ordering.  A simple example is:
>
>                 r1 =3D READ_ONCE(x);
>                 if (r1 =3D=3D 0)
>                         smp_mb();
>                 WRITE_ONCE(y, 1);
>
> -       There is a control dependency from the READ_ONCE to the WRITE_ONC=
E,
> -       even when r1 is nonzero, but LKMM doesn't realize this and thinks
> -       that the write may execute before the read if r1 !=3D 0.  (Yes, t=
hat
> -       doesn't make sense if you think about it, but the memory model's
> -       intelligence is limited.)
> +       The WRITE_ONCE() does not depend on the READ_ONCE(), and as a
> +       result, LKMM does not claim ordering.  However, even though no
> +       dependency is present, the WRITE_ONCE() will not be executed befo=
re
> +       the READ_ONCE().  There are two reasons for this:
> +
> +                The presence of the smp_mb() in one of the branches
> +                prevents the compiler from moving the WRITE_ONCE()
> +                up before the "if" statement, since the compiler has
> +                to assume that r1 will sometimes be 0 (but see the
> +                comment below);
> +
> +                CPUs do not execute stores before po-earlier conditional
> +                branches, even in cases where the store occurs after the
> +                two arms of the branch have recombined.
> +
> +       It is clear that it is not dangerous in the slightest for LKMM to
> +       make weaker guarantees than architectures.  In fact, it is
> +       desirable, as it gives compilers room for making optimizations.
> +       For instance, suppose that a 0 value in r1 would trigger undefine=
d
> +       behavior elsewhere.  Then a clever compiler might deduce that r1
> +       can never be 0 in the if condition.  As a result, said clever
> +       compiler might deem it safe to optimize away the smp_mb(),
> +       eliminating the branch and any ordering an architecture would
> +       guarantee otherwise.
>
>  2.     Multiple access sizes for a single variable are not supported,
>         and neither are misaligned or partially overlapping accesses.
> --
> 2.35.1
>
