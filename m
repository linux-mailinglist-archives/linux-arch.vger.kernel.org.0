Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E5695595
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 01:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBNAwo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 19:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNAwn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 19:52:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2DC168
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:52:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bi36so21343484lfb.8
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 16:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R4TS2ADE1jCEwaoOWe0k/AJLfcDw2mFKFwgxzj3+qAE=;
        b=q7FlsurgDee1i0EoZRC1Dt6Cl5MbEIJD0uLar8soLfz00ylL+JfAanr+jk333Ye/zk
         itI5Hkk2bE0CfwZKa79YRj6hev2L3ZWDocvD9hLkK2/4jxpoGOnQXVIkNYdCEy6bZ9ye
         /DxydrGMJ9X30Nw8GS5scyVdl9lr/B7KKlwEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4TS2ADE1jCEwaoOWe0k/AJLfcDw2mFKFwgxzj3+qAE=;
        b=lxDJuuyQahpzqRTU0dRdl3w48u2+F55vaiFmd1YJqBSDunpu5ECIoyKS3cMU0jIW/+
         NUA4v5VaJriAR72pB2AHPWX3MjsevETDk/vKqo6ZfXbncvOu2HpkrJo9/VvqkZAhULCp
         5+gVn8HoQBIlNZeG6pD4d+DnoTB1872Cnv9SLH8cvEGAP4AzspXMhGV0/8H38tKQfvwW
         w+6vBCaefV0EZKEFApyt0OiKhGEn9WwoLmBIRjenG+Qq8Dltk2zl1rS/OZo0KS1AyloJ
         EPtiZ+5vRcCZpNf6UfMe58dulzzCBH/ehJabpxoKJWRIR/CnCuHncUcqVZhvatnjwwB0
         SRew==
X-Gm-Message-State: AO0yUKWg3jYj+V5lVDg2XRfFgig9t1MklCCyAiifeViJIeKaAbjgSsdv
        w9wFM5Cc/ODrBEbyN3Q+vDlpsxVr1olUWubDytsA1kKF+tJPFw==
X-Google-Smtp-Source: AK7set9BnTldYq/TiF0rvsXB3Yn04/VPUEse4R0+YiI+dzKLK1P3lHFT7XKZEkcttgIU9v3sSZJmJ0x9Swlzw09SS0A=
X-Received: by 2002:a05:6512:3d1d:b0:4db:17d2:8aea with SMTP id
 d29-20020a0565123d1d00b004db17d28aeamr11564lfv.11.1676335959818; Mon, 13 Feb
 2023 16:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu> <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
 <Y+ob0xFUp+d7LROE@andrea>
In-Reply-To: <Y+ob0xFUp+d7LROE@andrea>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 13 Feb 2023 19:52:27 -0500
Message-ID: <CAEXW_YRZ097Qedp+ffxvVnJGWpehAn3-3efNcrDS5YW5u5QxDA@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 13, 2023 at 6:15 AM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > > Would you like to post a few examples showing some of the most difficult
> > > points you encountered?  Maybe explanation.txt can be improved.
> >
> > Just to list 2 of the pain points:
> >
> > 1. I think it is hard to reason this section
> > "PROPAGATION ORDER RELATION: cumul-fence"
> >
> > All store-related fences should affect propagation order, even the
> > smp_wmb() which is not A-cumulative should do so (po-earlier stores
> > appearing before po-later). I think expanding this section with some
> > examples would make sense to understand what makes "cumul-fence"
> > different from any other store-related fence.
>
> FWIW, litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus illustrates
> the concept of A-cumulativity.

Right, this I knew. The smp_store_release() in that test A-cumulative.
However, the "cumul-fence" naming in the document we are discussing
sounds redundant. (but I could be missing something).

> (The terminology is not LKMM-specific, it was borrowed from other MCM literature, e.g. "Understanding POWER Multiprocessors"
> in Documentation/references.txt.)

Thank you!

> > 2. This part is confusing and has always confused me " The
> > happens-before relation (hb) links memory accesses that have to
> > execute in a certain order"
> >
> > It is not memory accesses that execute, it is instructions that
> > execute. Can we separate out "memory access" from "instruction
> > execution" in this description?
> >
> > I think ->hb tries to say that A ->hb B means, memory access A
> > happened before memory access B exactly in its associated
> > instruction's execution order (time order), but to be specific --
> > should that be instruction issue order, or instruction retiring order?
> >
> > AFAICS ->hb maps instruction execution order to memory access order.
> > Not all ->po does  fall into that category because of out-of-order
> > hardware execution. As does not ->co because the memory subsystem may
> > have writes to the same variable to be resolved out of order. It would
> > be nice to call out that ->po is instruction issue order, which is
> > different from execution/retiring and that's why it cannot be ->hb.
> >
> > ->rf does because of data flow causality, ->ppo does because of
> > program structure, so that makes sense to be ->hb.
> >
> > IMHO, ->rfi should as well, because it is embodying a flow of data, so
> > that is a bit confusing. It would be great to clarify more perhaps
> > with an example about why ->rfi cannot be ->hb, in the
> > "happens-before" section.
> >
> > That's really how far I typically get (line 1368) before life takes
> > over, and I have to go do other survival-related things. Then I
> > restart the activity. Now that I started reading the CAT file as well,
> > I feel I can make it past that line :D. But I never wanted to get past
> > it, till I built a solid understanding of the contents before it.
> >
> > As I read the file more, I can give more feedback, but the above are
> > different 2 that persist.
>
> AFAICT, sections "The happens-before relation: hb" and "An operational model"
> in Documentation/explanation.txt elaborate (should help) clarify such issues.
> About the ->rfi example cf. e.g. Test PPOCA in the above mentioned paper; the
> test remains allowed in arm64 and riscv.

Thank you, this clarifies a lot and appears there is already a similar
relation mentioned in the explanation.txt as Alan pointed. This paper
is great to clarify the concept -- appreciate!.  I wonder what other
ordering 'havocs' do processor branch speculation cause.  This should
imply load-load control dependency is also subject to reordering on
these architectures.

thanks,

  - Joel
