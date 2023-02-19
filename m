Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617F69BE19
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 03:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBSCFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 21:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSCFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 21:05:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1D13DE9;
        Sat, 18 Feb 2023 18:05:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d14so6530786eda.4;
        Sat, 18 Feb 2023 18:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAG0HrBT+nsRDBk5CT3fX4o0S+udyVyKE7ZqJ4H9AH4=;
        b=qIN//xl1ZDXS0szWN3S/OOut7PPst+N6uWkUJ+hRLujRtmZaNjPYfs6nIi8eeJWtbk
         QspmpY8l8W2lcbPLkGlUqf63Lf59A4DDJwVS0Jd8WyK78SAdA5lHEZ0SM2r/7nfYqhzd
         fH8mLurYIDs3iEbM242ESx+Rdt7/Y31FVNCrgV35bjAiKhiuiyggcKoFTvYSI4T/ePly
         ibRao3K3RfNMdSjdFaw0QKbOloQlRRHI9eIb77d4Gtqp+htHCj8etHEh8gk/kzsDeByP
         rp6K3fefWLCwEvuA9V4tXrQxs5bQAMzDr5dzw1Ppnw9LeMJgNRrmv0hU5KAxCYxnlozR
         S0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAG0HrBT+nsRDBk5CT3fX4o0S+udyVyKE7ZqJ4H9AH4=;
        b=FgahnurGZPA60o289q7uiSXbb7FEj5OlY4pPauJBlRb2/3DqJc8t2TnZkzG0IGZNNX
         5ypXNeKf7wY34U6AIBdolYBw5jhkw2Gd9snTo7f+o/UFkCGRHga37sCXamXzJb7oE0ZK
         2ql0JRzgBbws/a03ZRhcmrn9quyrtwv+Y2Es0CcGasuO919lvPY26sV53bsta7Tljy0j
         3I0y2r3/MnVxiJu+8kByLAHgIVCJW+9e35E4xGl7FwLiqQZKoG04rWTFF0U5gAwVwzAy
         X6offRzAUBRiQSm/2JrunsWav65ku/I8Kb9NKlGH1J3iYZ6T3M+FiDWPJLIGhHtzXGNc
         cHAA==
X-Gm-Message-State: AO0yUKUJg7tAK2Jv0o/4ZqV3YXKp3o0fhgNWl/IZ+7KT4tRMyh7TLY38
        YM1pzyLqTrZYzyvPSA1lG3BBWrWmFq/vJRGG
X-Google-Smtp-Source: AK7set9yQauCBQB3u2AjNtHRFyKL21MFwQclHD9/bSMJrhyR99YO2MkRzvDQ/1YUj+WcoVwN6wIMBw==
X-Received: by 2002:a17:906:c44a:b0:8b1:fc:d737 with SMTP id ck10-20020a170906c44a00b008b100fcd737mr3887401ejb.19.1676772307408;
        Sat, 18 Feb 2023 18:05:07 -0800 (PST)
Received: from andrea (host-79-32-69-136.retail.telecomitalia.it. [79.32.69.136])
        by smtp.gmail.com with ESMTPSA id lg17-20020a170906f89100b008b1797a53b4sm3263873ejb.215.2023.02.18.18.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 18:05:06 -0800 (PST)
Date:   Sun, 19 Feb 2023 03:05:01 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y/GDzXkJzjxbP6I4@andrea>
References: <20230204014941.GS2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y95yhJgNq8lMXPdF@rowland.harvard.edu>
 <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQ3fvFDNi9wG5w4Zqkbda8SUByOnM6y6MXQpxT9oQw8xQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> One additional feedback I wanted to mention, regarding this paragraph
> under "WARNING":
> ===========
> The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> not perfect; and under some circumstances it is possible for the
> compiler to undermine the memory model. Here is an example. Suppose
> both branches of an "if" statement store the same value to the same
> location:
> r1 = READ_ONCE(x);
> if (r1) {
> WRITE_ONCE(y, 2);
> ... /* do something */
> } else {
> WRITE_ONCE(y, 2);
> ... /* do something else */
> }
> ===========
> 
> I tried lots of different compilers with varying degrees of
> optimization, in all cases I find that the conditional instruction
> always appears in program order before the stores inside the body of
> the conditional. So I am not sure if this is really a valid concern on
> current compilers, if not - could you provide an example of a compiler
> and options that cause it?

The compiler cannot change the order in which the load and the store
appear in the program (these are "volatile accesses"); the concern is
that (quoting from the .txt) it "could list the stores out of the
conditional", thus effectively destroying the control dependency between
the load and the store (the load-store "reordering" could then be
performed by the uarch, under certain archs).  For example, compare:

(for the C snippet)

void func(int *x, int *y)
{
	int r1 = *(const volatile int *)x;

	if (r1)
		*(volatile int *)y = 2;
	else
		*(volatile int *)y = 2;
}

- arm64 gcc 11.3 -O1 gives:

func:
	ldr     w0, [x0]
	cbz     w0, .L2
	mov     w0, 2
	str     w0, [x1]
.L1:
	ret
.L2:
	mov     w0, 2
	str     w0, [x1]
	b       .L1

- OTOH, arm64 gcc 11.3 -O2 gives:

func:
	ldr     w0, [x0]
	mov     w0, 2
	str     w0, [x1]
	ret

- similarly, using arm64 clang 14.0.0 -O2,

func:                                   // @func
	mov     w8, #2
	ldr     wzr, [x0]
	str     w8, [x1]
	ret

I saw similar results using riscv, powerpc, x86 gcc & clang.

  Andrea
