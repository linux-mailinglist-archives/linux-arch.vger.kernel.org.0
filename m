Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174D01730CA
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 07:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgB1GMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 01:12:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40287 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1GMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 01:12:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so1962387qka.7;
        Thu, 27 Feb 2020 22:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wyty40W/Qu8GnwhYqxyjqRT5oV/6aZoaZV9g8IYFv9c=;
        b=DfTtz8qok49FosFplrh33Y+hSE7m7IFREBcDa+rJ4zLj4+VeOtCsBkIFXcNYtxef9Q
         S7JbDBWkvaFQKb3mdWIJ/cG8ZHYyVUUVvNEEYt/0ChtAsLIM9jPz/T6ZN6T5D29TY7/J
         Y+iYrGfeDeKpbgkjx+/P+sjdyauQ3p5dH4mp/ClLnOTzOvy4aT8xdnT+vPQali2uKCDf
         7eJXnOiqP+JNRcbASlmRqG0sKiB7DoXXxzRLZ75C25GmlUn3yGv/fVYY+CyCsJ1u+RPJ
         /b1yWW81IIxTDabnFSHbA2wluSDV4B7QCYCa22P5BvRwB3ZTIF8r29N7qAL7n0UNhSgO
         kkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wyty40W/Qu8GnwhYqxyjqRT5oV/6aZoaZV9g8IYFv9c=;
        b=HlMJ4DSwsiGkBKeDQNsnHQyDFfBgn9czHvisOJKqIwE3248xe+3BnejB3U1eDLgz2N
         V9o/I+tWjFqBoDMhmRt1jT3+FRJA52DZUZfaSqD04AKcL+jRWwG9NQtf8CPF8X537WCF
         utn83OUYW2GsIafp3V9/d3S9f5fqcUrUoCpYjuphvhHXREDupCrjfM+UtpRs77AQ6D5d
         drbLgb+u5rocC0jBz0yUytQeG2ip5GU4JwPbkxNbXtIYKYQJWbeIbqvSgrR5jk658ZND
         lxSLkGOUbWW8s6C6kiGcLdOd+uL0zP6z00CWGd78IzUEzV4jUBMtCn1jY3Ce3BEe7W4u
         5I2Q==
X-Gm-Message-State: APjAAAVDoK2QBkhcD+sArM6l/ghNc3rJ8HUoiu+/GQOrjJyyGP3VJ2eR
        i5G6Ij0EdQR528PsK/q47Xc=
X-Google-Smtp-Source: APXvYqyQ/W/wSgr89mAFJI+Vkpgacn91PVqegXumByTWinq73Oahtc3x5zuqEslYTpx5bV+7JFY3UQ==
X-Received: by 2002:ae9:e413:: with SMTP id q19mr3129318qkc.248.1582870360131;
        Thu, 27 Feb 2020 22:12:40 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n12sm4482218qkg.89.2020.02.27.22.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:12:39 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 00FB321FE5;
        Fri, 28 Feb 2020 01:12:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 28 Feb 2020 01:12:38 -0500
X-ME-Sender: <xms:VK9YXjtuyRD1ML6U8iahQ1YTxvwTYpCHHjZVeoJm3AB8stlaIybH5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgpdhinhhrihgrrdhfrhenucfkphephedvrdduheehrdduuddu
    rdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:VK9YXnpBDuVCU3KlMZF2U1uDLkdDTh_z5L00xk6z4YKjlwDIzbE7Yg>
    <xmx:VK9YXi6Zt_kD7rVL1UBlywYHL3pxLLfNp7bKZ3-0GZr0ONyufUYsiQ>
    <xmx:VK9YXsqQ--OyU2onyUZewe7cqOCSz22mIR_LBFT7tRW1Dfu8gZeB4w>
    <xmx:Va9YXsn-tlpdEVVg-wauh9yuLigtr5EV17UQxcPtQnLxqOpxntrNnqj-UBY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70FB03060BD1;
        Fri, 28 Feb 2020 01:12:36 -0500 (EST)
Date:   Fri, 28 Feb 2020 14:12:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Documentation/locking/atomic: Add litmus tests
 for atomic APIs
Message-ID: <20200228061234.GS69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
 <20200227175441.GB12046@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227175441.GB12046@andrea>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 06:54:41PM +0100, Andrea Parri wrote:
> On Thu, Feb 27, 2020 at 08:40:44AM +0800, Boqun Feng wrote:
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs. And based on the previous discussion, I create a
> > new directory Documentation/atomic-tests and put these litmus tests
> > here.
> > 
> > This patchset starts the work by adding the litmus tests which are
> > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > it consistent with the litmus tests.
> > 
> > Previous version:
> > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > 
> > Changes since v2:
> > 
> > *	Change from "RFC" to "PATCH".
> > 
> > *	Wording improvement in atomic_t.txt as per Alan's suggestion.
> > 
> > *	Add a new patch describing the usage of atomic_add_unless() is
> > 	not limited anymore for LKMM litmus tests.
> > 
> > My PR on supporting "(void) expr;" statement has been merged by Luc
> > (Thank you, Luc). So all the litmus tests in this patchset can be
> > handled by the herdtools compiled from latest master branch of the
> > source code.
> > 
> > Comments and suggestions are welcome!
> 
> A few nits (see inline), but otherwise the series looks good to me;
> with those fixed, please feel free to add:
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> 

Thank you and Alan! I will fix those in the next version.

Regards,
Boqun

> to the entire series.
> 
> Thanks,
>   Andrea
> 
> 
> > 
> > Regards,
> > Boqun
> > 
> > [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> > 
> > Boqun Feng (5):
> >   tools/memory-model: Add an exception for limitations on _unless()
> >     family
> >   Documentation/locking/atomic: Fix atomic-set litmus test
> >   Documentation/locking/atomic: Introduce atomic-tests directory
> >   Documentation/locking/atomic: Add a litmus test for atomic_set()
> >   Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> > 
> >  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
> >  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
> >  Documentation/atomic-tests/README             | 16 ++++++++++
> >  Documentation/atomic_t.txt                    | 24 +++++++-------
> >  MAINTAINERS                                   |  1 +
> >  tools/memory-model/README                     | 10 ++++--
> >  6 files changed, 92 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >  create mode 100644 Documentation/atomic-tests/README
> > 
> > -- 
> > 2.25.0
> > 
