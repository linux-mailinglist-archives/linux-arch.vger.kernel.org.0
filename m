Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373694C5DF6
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiB0SJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 13:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0SJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 13:09:53 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8E5AA63;
        Sun, 27 Feb 2022 10:09:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k7so1413775ilo.8;
        Sun, 27 Feb 2022 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xC1AEvib8Cf944AeDGf2M/f6rb9ZO4jKeFVIH15Nbqk=;
        b=DjLbC97iDYNMPnSfMYcYuR7ZmA6TphGvtXjUpwS0GCSsJn0B3FGWTXnBy/1EKkvQzN
         K7WEOm+RJe51gRu0uUeEZK75RFW7agFiAF5WZLW9IBTXq0xy6fKQPdXftZX4iOl6aqc8
         PU8S0lucMlfUFvD9Is7TosZUz7+SV63HqKBU7sRQzJdTvRj1a1Ui5vRFpGyxwycklla4
         ncH1ESWKPzUKjq4IZtvbBFaxv+gF5jglaK7t8B4uQOzBHWXczEFaLTNyIwqw6FtXL946
         Bu7TUlvw9NnQYwUF9NG5XioFz8khWJjItWMJfGQ4f7s6LKH42Y+95XfrefOjK2FHLXCt
         /IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC1AEvib8Cf944AeDGf2M/f6rb9ZO4jKeFVIH15Nbqk=;
        b=6kvQC/+zubD479MfS+wuB5zyRznJgWw5H1ZXKfbLmr5BNUB0BqOdslkZ3aRKkkiWfL
         iBWtoYncC9DSiUrwOtVi6ADGFAHEcypc4ugyO1FQu+DVZzqqqi9iUGfd9VykwIH2NiW3
         AETpsIN7On55U4+Dqxr7Uj8zYvRyC9voeW6s4n0ZhpgLU7SxH+zx36q6tNGWBJoeIkQK
         9VT+0l7aLuXNNkRMLMdFAvLxhOtxoRPD2dyzEFE24LPfCmuvHx2pWihpMQDuug5n7qtQ
         8azm/3fWiXN0DhF1d9oD7gRxYZWU66U2tdqqXeajD7SOZjiRah6w1UmE6OMBJN2mgoad
         SKGA==
X-Gm-Message-State: AOAM531p/WQ32JY1hE3hNXJJKzwcUKeZk0pK7qJwUw1TZXQlSA2PO3rS
        AiprCQd1rX7suYWrcB3OE+p3h1alXA+FyjGaUmY=
X-Google-Smtp-Source: ABdhPJxvYPkV0VhY3Nxwq1nnZZ3cC8FXlIxU37f/ajKBusrVgs3BqdM0ArwdXZ+dStcHjAA9zbidtAhl7zTHVFLk1tc=
X-Received: by 2002:a05:6e02:188b:b0:2c2:5444:afb9 with SMTP id
 o11-20020a056e02188b00b002c25444afb9mr14962600ilu.237.1645985355120; Sun, 27
 Feb 2022 10:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org> <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
 <20220227113245.GY614@gate.crashing.org>
In-Reply-To: <20220227113245.GY614@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 27 Feb 2022 19:09:03 +0100
Message-ID: <CANiq72m28WrjVHkcg5Y0LDa51Ur4OCpFbGdcq+v4gqiC0Wi6zg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 27, 2022 at 1:09 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> How will you define dividing by zero so that its behaviour is reasonable
> for every program, for example?

The solution is to let the developer specify what they need to happen.
That choice should include the unsafe possibility (i.e. unchecked),
because sometimes that is precisely what we need.

> Invoking an error handler at runtime
> has most of the same unwanted effects, except is is never silent.  You

It may not be what it is needed in some cases (thus the necessity to
be able to choose), but at least one can predict what happens and
different compilers, versions, flags, inputs, etc. would agree.

Cheers,
Miguel
