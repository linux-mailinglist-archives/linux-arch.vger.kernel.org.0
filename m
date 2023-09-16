Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD97A2D47
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjIPCDS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjIPCC7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 22:02:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8546272D
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:01:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so3091545a12.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694829692; x=1695434492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=UU/zFBi267VWGewKzj3NnFippMQA7FWpN6AdgfauBJCkHA5tgrUe8LbkdFzwcyomGH
         vg88ayiWthiGiGokkBRE3nJ1sx9LcLBtLYKDhbLrFaVwJJIYDaM9XlwQuZqQa3P6+c3r
         tJwuZZPSD9tEaM28+N3oj7JLXPw1Oi3eal/lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694829692; x=1695434492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=bmyClVsyxpN9SSdxHa9iPCzCYPEloOr2tzlRHf6nRdMg+glWaTrJi+YXvwDYgzs0tx
         CMDhspAZ/jNjM2VJl3uBy4HKOjRcMZvpinuUHeUuOsmYD2Cx8gqnEekTtyRB31Z1asYb
         8CYgMpF69gH7KJDVlNOtATrRXL2C3xjrwlh744uy6zAbqQP06FfOVMsZ/XIkLtIGWVz/
         as3eYNqcYqhMx7HO/oWSJ3ZiZfGnBu08LkFgeaF8VQQQA+shIyLsGQlDLyYWpr/q6PQo
         +fpBTi0mmI18VIV3Vh1fdGqFkIbLIsYLmHsP6a0qlhSKpkSVlwSgSi7BiO9GcUNOOaN3
         tm6g==
X-Gm-Message-State: AOJu0YwjY1eI56IaEJNnYx7jF6X0YJV4dQad3fpqdUuL9owD6mjyXZx1
        WF3VXGD5FxCKmCwpI6/nM8xtZ5yLNy47E4pgY09staz7
X-Google-Smtp-Source: AGHT+IFQ20XtMM7uC6SrcE3hRdZ/BDr5MRmRXj+zTQEeB1RWM4TU7WeB1+tq3FlEoqgNkAmApuBSlQ==
X-Received: by 2002:a17:906:194:b0:9ad:7d59:4ff9 with SMTP id 20-20020a170906019400b009ad7d594ff9mr2604679ejb.30.1694829692015;
        Fri, 15 Sep 2023 19:01:32 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b009a5f1d15642sm3099812ejb.158.2023.09.15.19.01.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:01:31 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-986d8332f50so359315366b.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 19:01:31 -0700 (PDT)
X-Received: by 2002:a17:906:100b:b0:9a2:28dc:4168 with SMTP id
 11-20020a170906100b00b009a228dc4168mr2220828ejm.61.1694829690885; Fri, 15 Sep
 2023 19:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com> <ZQT4/gA4vIa/7H6q@casper.infradead.org>
In-Reply-To: <ZQT4/gA4vIa/7H6q@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:01:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 15 Sept 2023 at 17:38, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 15, 2023 at 05:27:17PM -0700, Linus Torvalds wrote:
> > On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > +       "1:     ldl_l %0,%4\n"
> > > +       "       xor %0,%3,%0\n"
> > > +       "       xor %0,%3,%2\n"
> > > +       "       stl_c %0,%1\n"
> >
> > What an odd thing to do.
> >
> > Why don't you just save the old value? That double xor looks all kinds
> > of strange, and is a data dependency for no good reason that I can
> > see.
> >
> > Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?
> >
> > Not that I think alpha matters, but since I was looking through the
> > series, this just made me go "Whaa?"
>
> Well, this is my first time writing Alpha assembler ;-)  I stole this
> from ATOMIC_OP_RETURN:
>
>         "1:     ldl_l %0,%1\n"                                          \
>         "       " #asm_op " %0,%3,%2\n"                                 \
>         "       " #asm_op " %0,%3,%0\n"                                 \

Note how that does "orig" assignment first (ie the '%2" destination is
the first instruction), unlike your version.

So in that ATOMIC_OP_RETURN, it does indeed do the same ALU op twice,
but there's no data dependency between the two, so they can execute in
parallel.

> but yes, mov would do the trick here.  Is it really faster than xor?

No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
there's no actual "mov" instruction, iirc.

So it's an ALU op too.

What makes your version expensive is the data dependency, not the ALU op.

So the *odd* thing is not that you have two xor's per se, but how you
create the original value by xor'ing the value once, and then xoring
the new value with the same mask, giving you the original value back -
but with that odd data dependency so that it won't schedule in the
same cycle.

Does any of this matter? Nope. It's alpha. There's probably a handful
of machines, and it's maybe one extra cycle. It's really the oddity
that threw me.

In ATOMIC_OP_RETURN, the reason it does that op twice is simply that
it wants to return the new value. But you literally made it return the
*old* value by doing an xor twice in succession, which reverses the
bits twice.

Was that really what you intended?

               Linus
