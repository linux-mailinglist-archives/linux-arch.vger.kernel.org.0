Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A530119BD41
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgDBIEJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 04:04:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34906 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBIEI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 04:04:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id k13so3059509qki.2;
        Thu, 02 Apr 2020 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RrpRpmxA/fGboHRy3eyeHpJ/mOa8uiqe+HX3yiHuZEQ=;
        b=gUrX7ZZc0XLA2HPpXA8mci+HiDbRIHNoRDPjCEoo8m0heDllzPu+jhZt2xdegVDfTk
         ayF+S4CV4+5gmXr16QS7MdV1Hmj65KEecMkLiteAPgPNRWchkszkSMDAJzZU8rv1qWmT
         Yryoabdcv1SqjDXIzzPmawPqeWSmqP1+SaaXih3l8R3bIp3egiXaNUiJ+ku0B3es8YdB
         hcEqRiH/MhHqr2IlChpXy2mcQ+kTyJrBbgjPWOVS4QvoOVcthmYl8Zny9ZLeiAivoxGp
         SzWVDJ3XGyLc51QPQbyutFCSeaqaBNLl+v2UYZJROR5zJnoaBEY3oafxYz3X29Ed4H3y
         seRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RrpRpmxA/fGboHRy3eyeHpJ/mOa8uiqe+HX3yiHuZEQ=;
        b=HfcxbNfEp3vuXISLBDGrrwoiQH2aTwCIlTk6SdgSLG0nYsrtxyYZlMXeu7kKd01Ilm
         b7Bd/4yKO4TIGy49/TvHudNPZzaNW6oYfTiy7jSB0f7WHXlUJdQmimSjz/OQJEnzjb2a
         OkDlC2OL8veZ2GTRj2otL2qoUGxIsO4TsR2o4/TyIdeMMVaqrXce7kGzmEv9SN+SaHb4
         8v1SwnfXn346IoQh8L86umu48ziky0agajsH+MxLnMFWo7OBKFt20Vj+zpvZJ9SmVtZ1
         Mc904Z+6m+MX8+Mufx63xFkuK0CNjNLavpZfEIRiPy+4StcQNgXS1B5YgVKPdGAcUbtn
         HmWg==
X-Gm-Message-State: AGi0PuZ7n/xoLxaauYxkhy6ZjY4RRozHJZhV10IqjRTHrrsu3vPMrOIY
        E/RrvCVN74Qe3HI4mguWEvk=
X-Google-Smtp-Source: APiQypJpCr7nUnc3rF94SHauVHaTkWD05E+isjAAeyRD9zOI+oAc/3RVxfTZ7SxFL63nlfKnGtqudA==
X-Received: by 2002:a37:27cd:: with SMTP id n196mr2320125qkn.144.1585814645559;
        Thu, 02 Apr 2020 01:04:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w28sm3296712qtc.27.2020.04.02.01.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 01:04:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0881227C0058;
        Thu,  2 Apr 2020 04:04:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 04:04:03 -0400
X-ME-Sender: <xms:cJyFXpzN2snz4Kko4y3ygTaIP7yvOCU3KKHyrYkMP1ltoM7L4gboKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduuddurdejudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cJyFXm9sH9adqCr8497XOy9_vdG4WsKKER-oqdc8CaTsSM4x9vk5Mw>
    <xmx:cJyFXtx7fF9IsOv0RCNT73pwBVywEDfL8eut7crZUyERimJ6uunpVA>
    <xmx:cJyFXjuG4n8OzlCoSpp5SBAphH83V0pAAH4sDUI-eBumC7VWwckLKg>
    <xmx:c5yFXiEYB70MKHpCqsjdPbd5GgMKPA3nIJRB-rUKAUozPLaL8YTCjpAVuw8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F856328005A;
        Thu,  2 Apr 2020 04:04:00 -0400 (EDT)
Date:   Thu, 2 Apr 2020 16:03:58 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Message-ID: <20200402080358.GC59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
 <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200402035816.GA46686@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402035816.GA46686@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 01, 2020 at 11:58:16PM -0400, Joel Fernandes wrote:
> On Tue, Mar 31, 2020 at 09:40:37AM +0800, Boqun Feng wrote:
> > On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> > > On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> > > > A recent discussion raises up the requirement for having test cases for
> > > > atomic APIs:
> > > > 
> > > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > > 
> > > > , and since we already have a way to generate a test module from a
> > > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > > tests for atomic APIs. And based on the previous discussion, I create a
> > > > new directory Documentation/atomic-tests and put these litmus tests
> > > > here.
> > > > 
> > > > This patchset starts the work by adding the litmus tests which are
> > > > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > > > it consistent with the litmus tests.
> > > > 
> > > > Previous version:
> > > > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > > > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > > > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> > > 
> > > For full series:
> > > 
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > One question I had was in the existing atomic_set() documentation, it talks
> > > about atomic_add_unless() implementation based on locking could have issues.
> > > It says the way to fix such cases is:
> > > 
> > > Quote:
> > >     the typical solution is to then implement atomic_set{}() with
> > >     atomic_xchg().
> > > 
> > > I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> > > atomic_xchg() would be implemented using locking to avoid atomic_set() having
> > 
> > Right, I think that's the intent of the sentence.
> > 
> > > issues? If so, we could clarify that in the document.
> > > 
> > 
> > Patches are welcome ;-)
> 
> 
> ---8<-----------------------
> 
> Like this? I'll add it to my tree and send it to Paul during my next
> series, unless you disagree ;-)
> 
> Subject: [PATCH] doc: atomic_t: Document better about the locking within
>  atomic_xchg()
> 
> It is not fully clear how the atomic_set() would not cause an issue with
> preservation of the atomicity of RMW in this example. Make it clear that
> locking within atomic_xchg() would save the day.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/atomic_t.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 0f1fdedf36bbb..1d9c307c73a7c 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -129,6 +129,8 @@ with a lock:
>      unlock();
>  
>  the typical solution is to then implement atomic_set{}() with atomic_xchg().
> +The locking within the atomic_xchg() in CPU1 would ensure that the value read
> +in CPU0 would not be overwritten.
>  
>  
>  RMW ops:
> -- 
> 2.26.0.292.g33ef6b2f38-goog
> 
