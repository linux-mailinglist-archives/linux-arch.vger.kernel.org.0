Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E744E693562
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBLAaf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Feb 2023 19:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBLAaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Feb 2023 19:30:35 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336A11E81
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 16:30:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m10so10751776ljp.3
        for <linux-arch@vger.kernel.org>; Sat, 11 Feb 2023 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s25OdojLKrw23uabiD2nb64DPsEZjV6BzQqrSUcoojs=;
        b=V24a2EEE3ENW9b/2DuyQhf48wsSvEMoXuavh5FbNeB1We/90ECz8aDziq2CPnoIFmT
         qCVdDNyHdNThokfWWFdjAVTt5P9JlW+BnssRFdzL4SZf2dqg0rD+in/isn1nDpcX4bWU
         cZ15nvlXlWsjlVibGvVqW3QlnSV1UidMHBg6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s25OdojLKrw23uabiD2nb64DPsEZjV6BzQqrSUcoojs=;
        b=FQ1BNPKDpkYz5JCnG6Tyyh3Q9VnnWsHsKlqaVdy3lzPpwgBHrQ/Cxj05Lgcum4emM8
         Ei01efXrGMAxExH7klLVENr9T66rxDdK4fxuOCPUltuTYLH0F/jIXWdryZgiK2CLh758
         1sLH76BT1GXYsC07P40EYy8sNVgcbI+p4pkbJb/r6HmdTGEB56DTAXKmHTwVVEoGm/NO
         d7uQpddbc4imPUAwNqnuAzibTqqeQbD2xp5xnN0LwNyuZ5ucOEAMJXvswVVnl6Di9XFs
         GWEEdm/yl+WHMMq3D8sKIX8ORI/xac+ayJDa0/xrj56LBtrQtG87t1Qlryh0iiLXpHUv
         bGGg==
X-Gm-Message-State: AO0yUKVBkHS2BHb//WLC7JUl6Xzza/fHrDP6yoprTqkHfNQf6+T+439N
        B2/DT5xSYf1DsuzziyZemG5+8BtS+6SDSyYkphFxIA==
X-Google-Smtp-Source: AK7set8IDIbaKuj57SwCjUJA7sUBRIVB991j6cFunDWeSBy3f5yCFPt0TjoZHks8AOuJ5CwBl/rAne1uUIhMX1lb72U=
X-Received: by 2002:a2e:b531:0:b0:291:1684:2226 with SMTP id
 z17-20020a2eb531000000b0029116842226mr3841659ljm.110.1676161831680; Sat, 11
 Feb 2023 16:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu> <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
In-Reply-To: <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 11 Feb 2023 19:30:32 -0500
Message-ID: <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, Feb 11, 2023 at 05:18:17PM +0000, Joel Fernandes wrote:
>
[..]
> > +
> > +(* Data dependency between lock and idx store *)
> > +let srcu-lock-to-store-idx = ([Srcu-lock]; data)
> > +
> > +(* Data dependency between idx load and unlock *)
> > +let srcu-load-idx-to-unlock = (data; [Srcu-unlock])
> > +
> > +(* Read-from dependency between idx store on one CPU and load on same/another.
> > + * This is required to model the splitting of critical section across CPUs. *)
> > +let srcu-store-to-load-idx = (rf ; srcu-load-idx-to-unlock)
> > +
> > +(* SRCU data dependency flow. Exclude the Srcu-unlock to not transcend back to back rscs *)
> > +let carry-srcu-data = (srcu-lock-to-store-idx ; [~ Srcu-unlock] ; srcu-store-to-load-idx)*
> > +
> > +let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; [Srcu-unlock]) & loc
>
> That doesn't look right at all.  Does it work with the following?
>
> P0(struct srcu_struct *lock)
> {
>         int r1;
>
>         r1 = srcu_read_lock(lock);
>         srcu_read_unlock(lock, r1);
> }
>
> or
>
> P0(struct srcu_struct *lock, int *x, int *y)
> {
>         *x = srcu_read_lock(lock);
>         *y = *x;
>         srcu_read_unlock(lock, *y);
> }
>
> The idea is that the value returned by srcu_read_lock() can be stored to
> and loaded from a sequence (possibly of length 0) of variables, and the
> final load gets fed to srcu_read_unlock().  That's what the original
> version of the code expresses.

Now I understand it somewhat, and I see where I went wrong. Basically,
you were trying to sequence zero or one "data + rf sequence" starting
from lock and unlock with a final "data" sequence. That data sequence
can be between the srcu-lock and srcu-unlock itself, in case where the
lock/unlock happened on the same CPU.

Damn, that's really complicated.. and I still don't fully understand it.

In trying to understand your CAT code, I made some assumptions about
your formulas by reverse engineering the CAT code with the tests,
which is kind of my point that it is extremely hard to read CAT. That
is kind of why I want to understand the CAT, because for me
explanation.txt is too much at a higher level to get a proper
understanding of the memory model.. I tried re-reading explanation.txt
many times.. then I realized I am just rewriting my own condensed set
of notes every few months.

> I'm not sure that breaking this relation up into pieces will make it any
> easier to understand.

Yes, but I tried. I will keep trying to understand your last patch
more. Especially I am still not sure, why in the case of an SRCU
reader on a single CPU, the following does not work:
let srcu-rscs = ([Srcu-lock]; data; [Srcu-unlock]).

Thanks!

 - Joel
