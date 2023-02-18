Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8169B84A
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 07:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBRGOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 01:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRGON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 01:14:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3853EFF
        for <linux-arch@vger.kernel.org>; Fri, 17 Feb 2023 22:14:12 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id j23so65285ljq.8
        for <linux-arch@vger.kernel.org>; Fri, 17 Feb 2023 22:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9meo/2HsyQjWTOLBePu8gQ8aMOImbRjLtTEkBnxFWA=;
        b=rNW4pWyLBgZAXvqJjvCoQS8lk2lmt0bpvLoQdrZ4JtZt7F/xLQANfMR03xhYfnh+h2
         rmKCOP/qyMs+J36NL88QnT7nLTcqAAMfUbpj9E0xe3jdJKKjcCQ++dD7IBc/gnmYd8Ln
         WROBH3wQ8mnvc2t6fvC/87NGLDoo+sxFiJiaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9meo/2HsyQjWTOLBePu8gQ8aMOImbRjLtTEkBnxFWA=;
        b=HhuxPZWbK4BpQ+8KxblJIqV/5IbYGWheo6p7wHpB6KN7pzAlRSnRycdwOPUxnct3J5
         Ds8NnSpi/ew1BpByjDhaQgrJ5PQZ0AMJ2TWi525CVF6XYH33kq+7yyeG5JOwwXTU+9ms
         z5YWXKRYTJiGNcbLw80EZFVD39IvZbHSeMNnvDTgkHtxXCrqErds+xqa9i+QqPBaQpNc
         UUWYuUqUUE8jTFfTTEJ1lG83HG6E4s859QlGcO973evPPnXvV5K1H6DaxiHXSzUSQ3eS
         g22dt6agSpkZEI0bbAyMcRGHVbhaaxud/PByWWHrKktc3WecfcL2U6uXf9I14OLAYXWx
         2x0g==
X-Gm-Message-State: AO0yUKWHUf5TLiyJO+GJYohaP2ZEwZrJrU/WW0Cm4KcEPOd413PwZIkC
        KVI3ygMKol+h0ztYomQ2Eh1XFKTivFhqZ/vzgeLV4Q==
X-Google-Smtp-Source: AK7set/q4K2z6T8tTM3H+wXeDE+gFiACy9O/yEXPJeOfHZ8S48WmuHxW5F7bIDV9xIb0GRZIxHoXzwQbijx97x4nEzs=
X-Received: by 2002:a05:651c:1688:b0:293:4647:364a with SMTP id
 bd8-20020a05651c168800b002934647364amr1066205ljb.3.1676700850733; Fri, 17 Feb
 2023 22:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20230204004843.GA2677518@paulmck-ThinkPad-P17-Gen-1>
 <Y920w4QRLtC6kd+x@rowland.harvard.edu> <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com> <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
In-Reply-To: <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 18 Feb 2023 01:13:59 -0500
Message-ID: <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
Subject: Re: Current LKMM patch disposition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alan,

On Sat, Feb 11, 2023 at 9:59 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
[...]
>
> Would you like to post a few examples showing some of the most difficult
> points you encountered?  Maybe explanation.txt can be improved.

One additional feedback I wanted to mention, regarding this paragraph
under "WARNING":
===========
The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
not perfect; and under some circumstances it is possible for the
compiler to undermine the memory model. Here is an example. Suppose
both branches of an "if" statement store the same value to the same
location:
r1 = READ_ONCE(x);
if (r1) {
WRITE_ONCE(y, 2);
... /* do something */
} else {
WRITE_ONCE(y, 2);
... /* do something else */
}
===========

I tried lots of different compilers with varying degrees of
optimization, in all cases I find that the conditional instruction
always appears in program order before the stores inside the body of
the conditional. So I am not sure if this is really a valid concern on
current compilers, if not - could you provide an example of a compiler
and options that cause it?

In any case, if it is a theoretical concern, it could be clarified
that this is a theoretical possibility in the text.  And if it is a
real/practical concern, then it could be mentioned the specific
compiler/arch this was seen in.

Thanks!

 - Joel



>
> > > I'm not sure that breaking this relation up into pieces will make it any
> > > easier to understand.
> >
> > Yes, but I tried. I will keep trying to understand your last patch
> > more. Especially I am still not sure, why in the case of an SRCU
> > reader on a single CPU, the following does not work:
> > let srcu-rscs = ([Srcu-lock]; data; [Srcu-unlock]).
>
> You have to understand that herd7 does not track dependencies through
> stores and subsequent loads.  That is, if you have something like:
>
>         r1 = READ_ONCE(*x);
>         WRITE_ONCE(*y, r1);
>         r2 = READ_ONCE(*y);
>         WRITE_ONCE(*z, r2);
>
> then herd7 will realize that the write to y depends on the value read
> from x, and it will realize that the write to z depends on the value
> read from y.  But it will not realize that the write to z depends on the
> value read from x; it loses track of that dependency because of the
> intervening store/load from y.
>
> More to the point, if you have:
>
>         r1 = srcu_read_lock(lock);
>         WRITE_ONCE(*y, r1);
>         r2 = READ_ONCE(*y);
>         srcu_read_unlock(lock, r2);
>
> then herd7 will not realize that the value of r2 depends on the value of
> r1.  So there will be no data dependency from the srcu_read_lock() to
> the srcu_read_unlock().
>
> Alan
