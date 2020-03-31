Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B63198992
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 03:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgCaBkq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 21:40:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40605 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgCaBkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 21:40:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id c9so17036832qtw.7;
        Mon, 30 Mar 2020 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EKZAtUisNzB+elti6oItTfupGpeOM+Jg12azmI7Z6WE=;
        b=l2CifpBIVvo4k2KAev3wORlbRMa5Ibr+LVBJPpQJ0rAZai46OojX7Xaj9S4KNLkQTu
         q66THOkKIH6K+54NA6GaXlZndn9ZdijkFIMGKLlnCPfJBLj1Qa4WPO/nV+fx1qjrk2Ht
         nT7XBR1kLifRcJmNVuZFpq4ZgAFHLgQrABFyt/I/0x8Sy8ori+r85kfTwi96Xrqq0mgG
         0pcvCIMlhgQDJt6VVRdGWtjGS1Bdx0XTg2lghp7l5nf9f5OncRVtzH387NkxyIVdxmwp
         0jEmVS/oTuLC1jrtTnnC5pH1ykTtJdqJkZJ0XSRuxiELHxl3hTKbjCFwpS7DBxzY6L4N
         Wd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKZAtUisNzB+elti6oItTfupGpeOM+Jg12azmI7Z6WE=;
        b=LkkNRjW9GTQBtke2JGtWYpAmEMzG3WX9GJXNoRImyJ22ALMCwjntG5KkHukiMkbeg+
         LwGtFgvZhWoxKAzrk23bN+c7FeJbKQh3DQdpObJWPGqbVZhi4gaOjLxSpkLLApy4hB25
         J2A7cpYumSC+SVO5/LobQsz8zWF7sx/3ta/6BRVczu8iBUJaQJxzskDZSYxY66GyYmG7
         mq+KYgisHQSzi/4Wpt7OnJSI/l+1CD8hvJXKmj6GhFTt19JWnFZke2DZMBhxWd7JbVlP
         NraUbZLCF+RahlBCpoqA8C9msMRNxnfVibXn+6iUQOMvIAT2dKCD1Z/nSdB1nb0vNpi6
         WVJA==
X-Gm-Message-State: ANhLgQ3APPxBOzCBmlO7SmNHvauaDfRrbnY+gsU6lNiiyxlSnhl+KlEO
        7ZqSgeKBlO/JIF4IeBTckxM=
X-Google-Smtp-Source: ADFU+vs4vmEDilC0bYzltcbOvzpZBl2xxNRerAiCGin1ZTsNVPxqBfN1CM3eH+fAXVAVANPGPtyN9Q==
X-Received: by 2002:ac8:348f:: with SMTP id w15mr2919381qtb.219.1585618843878;
        Mon, 30 Mar 2020 18:40:43 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j85sm11874791qke.20.2020.03.30.18.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 18:40:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DF00027C0054;
        Mon, 30 Mar 2020 21:40:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 21:40:41 -0400
X-ME-Sender: <xms:lp-CXoU3EkuNtreqUNGhtXLl-pSdCDyn3Z6b2DjG-F2GU7b_PBDahg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeiiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghdpihhnrhhirgdrfhhrnecukfhppeehvddrudehhedruddu
    uddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:lp-CXkF5NpG9FGc8Esr-qGI6vQLqK-plwQMH23SoCq5ZUUrmgkwbnQ>
    <xmx:lp-CXicdsnSlZW57uKdCmc1BSLecrdPJQoossGWCfGyin4cZwZkjxg>
    <xmx:lp-CXlZ9rLfMlYpUY5h7EXcBCfrGjqd_zAphE1tDspVL5g8XmMX9sA>
    <xmx:mZ-CXtUh2T713PAsia1T5B0H7f59XNA8XmX3DhsUVRCbnseIWtNr21mwtvQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E2FA306CA8E;
        Mon, 30 Mar 2020 21:40:38 -0400 (EDT)
Date:   Tue, 31 Mar 2020 09:40:37 +0800
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
Message-ID: <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327221843.GA226939@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
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
> > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> 
> For full series:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> One question I had was in the existing atomic_set() documentation, it talks
> about atomic_add_unless() implementation based on locking could have issues.
> It says the way to fix such cases is:
> 
> Quote:
>     the typical solution is to then implement atomic_set{}() with
>     atomic_xchg().
> 
> I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> atomic_xchg() would be implemented using locking to avoid atomic_set() having

Right, I think that's the intent of the sentence.

> issues? If so, we could clarify that in the document.
> 

Patches are welcome ;-)

Regards,
Boqun

> thanks,
> 
>  - Joel
> 
> > 
> > Changes since v3:
> > 
> > *	Merge two patches on atomic-set litmus test into one as per
> > 	Alan. (Alan, you have acked only one of the two patches, so I
> > 	don't add you acked-by for the combined patch).
> > 
> > *	Move the atomic litmus tests into litmus-tests/atomic to align
> > 	with Joel's recent patches on RCU litmus tests.
> > 
> > I think we still haven't reach to a conclusion for the difference of
> > atomic_add_unless() in herdtools, and I'm currently reading the source
> > code of herd to resovle this. This is just an updated version to resolve
> > ealier comments and react on Joel's RCU litmus tests.
> > 
> > Regards,
> > Boqun
> > 
> > [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> > 
> > Boqun Feng (4):
> >   tools/memory-model: Add an exception for limitations on _unless()
> >     family
> >   Documentation/litmus-tests: Introduce atomic directory
> >   Documentation/litmus-tests/atomic: Add a test for atomic_set()
> >   Documentation/litmus-tests/atomic: Add a test for
> >     smp_mb__after_atomic()
> > 
> >  Documentation/atomic_t.txt                    | 24 +++++++-------
> >  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
> >  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
> >  Documentation/litmus-tests/atomic/README      | 16 ++++++++++
> >  tools/memory-model/README                     | 10 ++++--
> >  5 files changed, 91 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/README
> > 
> > -- 
> > 2.25.1
> > 
