Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0169BE4E
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 03:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBSC65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 21:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBSC64 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 21:58:56 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1DFF08
        for <linux-arch@vger.kernel.org>; Sat, 18 Feb 2023 18:58:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d11so2252939lfg.6
        for <linux-arch@vger.kernel.org>; Sat, 18 Feb 2023 18:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYJq+vBBeNeErQR3SsU+Z5tbRMfJKp6MAmS8Q+mAUrQ=;
        b=ttBg72UaLFrrgdS9DVmdxUhsO3y8oXSKPE1s0ONUw8+UPPiqWMWnsigR+toge9n9oG
         nDiD5Xlm/0C0+A9JX25LFO+pSOMsCuiH+hvy/IBKtX12GTkCC0IiO7K32PwOL4clcKpj
         gdOBIg2XmbkYxINf/mZye4WIYzeOyngCp1GAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYJq+vBBeNeErQR3SsU+Z5tbRMfJKp6MAmS8Q+mAUrQ=;
        b=OpKwnMaH42o6KhXIeXW2OYy+eAj0Y8JVUaStI575oqKiDgHsqLGkk9stdftN0Aack6
         K/Y9cMsKWveL+RuumNhXyeveseW7VXLPnvnqeN9nVQvuPmuWIltQuEV9hyHHSVctBCML
         FSCeIwlquv5qExfnmgFkL3FwbGo0DYtvYJI+0CcEd58W+XFO5wrFHttMm5Pu1apM0BpA
         WzECzZFQp/GDJLMFOt4md0+uxOXnEK2Hb6le7n0m2UVamknOoALlQNSKIvhjt4qdv4qY
         fj6Ce10h2t401VcYp1OSmKYNr9PaIkMxPe256GOJjv0BPZEYVSb7GK4f6gMTjm2fr7iK
         U/2w==
X-Gm-Message-State: AO0yUKWL5d5t9nTD46JZE8hERQtRBIBGm2W3OA9ikLFsEsmZLaMecJ9U
        v5Sv6DRv/6yJ3nLZSb7IurRYUZEVHZxbe/k+BLtT8w==
X-Google-Smtp-Source: AK7set8A9WSSbHjaC5JpHx5wvGpj22uxo9T/zGND11dnt9Ynf9xDHgqGT+MotDp+eriLenXKPJgIc+hmsHlUxAsQXxs=
X-Received: by 2002:a19:f60f:0:b0:4db:4604:6328 with SMTP id
 x15-20020a19f60f000000b004db46046328mr287777lfe.11.1676775533567; Sat, 18 Feb
 2023 18:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu> <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com> <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com> <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu> <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
 <Y/GDzXkJzjxbP6I4@andrea>
In-Reply-To: <Y/GDzXkJzjxbP6I4@andrea>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 18 Feb 2023 21:58:41 -0500
Message-ID: <CAEXW_YQYJP8khRtK+j=djrY9dGYH3vHw+Ujd8_Zwu7xoLxE_AA@mail.gmail.com>
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

On Sat, Feb 18, 2023 at 9:05 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > One additional feedback I wanted to mention, regarding this paragraph
> > under "WARNING":
> > ===========
> > The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> > not perfect; and under some circumstances it is possible for the
> > compiler to undermine the memory model. Here is an example. Suppose
> > both branches of an "if" statement store the same value to the same
> > location:
> > r1 = READ_ONCE(x);
> > if (r1) {
> > WRITE_ONCE(y, 2);
> > ... /* do something */
> > } else {
> > WRITE_ONCE(y, 2);
> > ... /* do something else */
> > }
> > ===========
> >
> > I tried lots of different compilers with varying degrees of
> > optimization, in all cases I find that the conditional instruction
> > always appears in program order before the stores inside the body of
> > the conditional. So I am not sure if this is really a valid concern on
> > current compilers, if not - could you provide an example of a compiler
> > and options that cause it?
>
> The compiler cannot change the order in which the load and the store
> appear in the program (these are "volatile accesses"); the concern is
> that (quoting from the .txt) it "could list the stores out of the
> conditional", thus effectively destroying the control dependency between
> the load and the store (the load-store "reordering" could then be
> performed by the uarch, under certain archs).  For example, compare:
>
> (for the C snippet)
>
> void func(int *x, int *y)
> {
>         int r1 = *(const volatile int *)x;
>
>         if (r1)
>                 *(volatile int *)y = 2;
>         else
>                 *(volatile int *)y = 2;
> }
>
> - arm64 gcc 11.3 -O1 gives:
>
> func:
>         ldr     w0, [x0]
>         cbz     w0, .L2
>         mov     w0, 2
>         str     w0, [x1]
> .L1:
>         ret
> .L2:
>         mov     w0, 2
>         str     w0, [x1]
>         b       .L1
>
> - OTOH, arm64 gcc 11.3 -O2 gives:
>
> func:
>         ldr     w0, [x0]
>         mov     w0, 2
>         str     w0, [x1]
>         ret
>
> - similarly, using arm64 clang 14.0.0 -O2,
>
> func:                                   // @func
>         mov     w8, #2
>         ldr     wzr, [x0]
>         str     w8, [x1]
>         ret
>
> I saw similar results using riscv, powerpc, x86 gcc & clang.

*Sigh*, yeah and even if the conditional logic is not fully stripped
out as in your example, I still see arm64 perform stores in
program-order before ever checking the branch condition:

int prog(void)
{
  int r1 = *(const volatile int *)x;
  if (r1) {
    *(volatile int *)y = 1;
  } else {
    *(volatile int *)y = 1;
    *(volatile int *)z = 2;
  }
}

becomes with armv8 clang and -Os:

prog:
  adrp x8, x
  ldrsw x8, [x8, :lo12:x]
  adrp x9, y
  mov w10, #1
  ldr w8, [x8]
  ldrsw x9, [x9, :lo12:y]
  str w10, [x9]
  cbz w8, .LBB0_2   // LOL
  ret
  .LBB0_2:
  adrp x8, z
  ldrsw x8, [x8, :lo12:z]
  mov w9, #2
  str w9, [x8]
  ret

Anyway sorry for the noise... I believe I did not have the right set
of compiler options yesterday..

Thanks!

 - Joel
