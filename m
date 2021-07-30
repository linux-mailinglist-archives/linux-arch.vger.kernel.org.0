Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44B23DBDB7
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhG3Rav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3Rau (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 13:30:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AFC061765;
        Fri, 30 Jul 2021 10:30:46 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r18so12386701iot.4;
        Fri, 30 Jul 2021 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHsMKNhV7OwL5/mb1IIZfkjAk7SLD17GCn8Ec+XEXAM=;
        b=OwX4txoExZtKsbvkkF3Ty6YMuO0yiLRNADxSTrBEyhilKdRpl6xCcv7WkjW6RJRGpE
         uV8PwyhqtWgQVhC+0iQBxeXYGX8nKrnZSP44r1BEaVmHnF++10IH30K3fyNENz6ek0PL
         gfUzMyYpc4N3/9FdQHAnBupLvNbj7+JHoPz55094D3xG80xOj4j/u/NJJIkEcaLAZHC6
         dP1rm0BliBlzr9Jj02c4XcjvIIG6gaySoJMxn+pVopB85MGd3jVSN+Aoq6nn+M8wTZGH
         n6ixyNv4L/8jn0ZOOEFEf5G+kupxTRew4Woj6z3HKB4RDWdrc2gLYgogpgxquD/6+mEF
         02GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHsMKNhV7OwL5/mb1IIZfkjAk7SLD17GCn8Ec+XEXAM=;
        b=r1xK25hd5xXF4GEREbNs0ZGrSgn5XOftLqWFrfUyI+e9+fmDRXK3NbMvmSJJlYmnco
         I4KwvbTpWAV80IkgZmbwvZOcE9vSO7uzV8EaO5PLcOGjX84lZKH5GEcFHUf2Xta2DVZZ
         /hZr2v3KY1RzXDTjeOjHjhHm1Zb+UKx3Qjisu0P5d/Hj4xoJMbk6IgEOBY43TvY+dz3c
         59Cve8fIECQoPvd6iCAAnUmk9UhpwFy6IFNNkgiZ7WSYiSMepKCju7Q4KIyA1kKOI/75
         KHbYACcQz8Dw1e6vRJ+IiZfQ8143ecy0ORvvfheyIxQM8XvceTdI+5t88oIznjKksJrs
         0L1w==
X-Gm-Message-State: AOAM531iLyuc0jA3ES0GEoBFAx+NTF186wTnV1Tk+3xTtiz5MXqHyM4B
        VLdGDyxm+dchF3E5uVT9sjY=
X-Google-Smtp-Source: ABdhPJx4HDV95l8buFg8Ixg+PTIBRNjxRXBAh8Ozz2Gb4aE52xoZ8NNGTH8LL1Q7pXoqbIO3xozI6A==
X-Received: by 2002:a6b:f707:: with SMTP id k7mr1005465iog.125.1627666245515;
        Fri, 30 Jul 2021 10:30:45 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e9sm1163567ils.61.2021.07.30.10.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:30:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7D5A127C005B;
        Fri, 30 Jul 2021 13:30:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Jul 2021 13:30:44 -0400
X-ME-Sender: <xms:QzcEYQIbmQamGupiogWro6i4Wilby76fK1-G1vO4kiHiSDzDxHp36g>
    <xme:QzcEYQJoQkcEdGoIC7RzJT65Wv2xGxP8-xMRJFgzzR8mKn-JWtn6sW5LU_kX4hX_p
    a7_1BSBes97go0j-Q>
X-ME-Received: <xmr:QzcEYQtt8JVs8rredBOBkK6rwxFt0d0vBtmGQ7_PWLAvxO-9Mm9XW3giz0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheehgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheekveejhedujeffudetiedtveeufefhjeeivdfhgfeuuddttdeghedtudei
    tefgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:QzcEYda7XS5ykQPuUALQWEOMi43Qn0Vr6JAA7eCzE3Vy8BB3aYxuqQ>
    <xmx:QzcEYXYCN-7XAEOk2Bl4EXm84JvKaiPttDKQII4fwDC1xx0Mn0c96g>
    <xmx:QzcEYZCsUPNJNujha7WdawB3K_k-uad7t-sbcYBvC9muwd6LH-ph6A>
    <xmx:RDcEYb72_W_BHoRvnDYAHqhL8MobAwC9qspa-VABOJx-NLPzYzQULw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 13:30:42 -0400 (EDT)
Date:   Sat, 31 Jul 2021 01:30:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Question] Alignment requirement for readX() and writeX()
Message-ID: <YQQ3KAXrPN1CuglL@boqun-archlinux>
References: <YQQr+twAYHk2jXs6@boqun-archlinux>
 <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 06:58:30PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 30, 2021 at 6:43 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi,
> >
> > The background is that I'm reviewing Wedson's PR on IoMem for
> > Rust-for-Linux project:
> >
> >         https://github.com/Rust-for-Linux/linux/pull/462
> >
> > readX() and writeX() are used to provide Rust code to read/write IO
> > memory. And I want to find whether we need to check the alignment of the
> > pointer. I wonder whether the addresses passed to readX() and writeX()
> > need to be aligned to the size of the accesses (e.g. the parameter of
> > readl() has to be a 4-byte aligned pointer).
> >
> > The only related information I get so far is the following quote in
> > Documentation/driver-io/device-io.rst:
> >
> >         On many platforms, I/O accesses must be aligned with respect to
> >         the access size; failure to do so will result in an exception or
> >         unpredictable results.
> >
> > Does it mean all readX() and writeX() need to use aligned addresses?
> > Or the alignment requirement is arch-dependent, i.e. if the architecture
> > supports and has enabled misalignment load and store, no alignment
> > requirement on readX() and writeX(), otherwise still need to use aligned
> > addresses.
> >
> > I know different archs have their own alignment requirement on memory
> > accesses, just want to make sure the requirement of the readX() and
> > writeX() APIs.
> 
> I am not aware of any driver that requires unaligned access on __iomem
> pointers, and since it definitely doesn't work on most architectures, I think
> having an unconditional alignment check makes sense.
> 
> What would the alignment check look like? Is there a way to annotate
> a pointer that is 'void __iomem *' in C as having a minimum alignment
> when it gets passed into a function that uses readl()/writel() on it?
> 

If we want to check, I'd expect we do the checks inside
readX()/writeX(), for example, readl() could be implemented as:

	#define readl(c) 					\
	({							\
		u32 __v;					\
								\
		/* alignment checking */			\
		BUG_ON(c & (sizeof(__v) - 1));			\
		__v = readl_relaxed(c);				\
		__iormb(__v);					\
		__v;						\
	})

It's a runtime check, so if anyone hates it I can understand ;-)

Regards,
Boqun

>        Arnd
