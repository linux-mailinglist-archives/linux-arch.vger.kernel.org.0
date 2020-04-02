Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA319BACC
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 05:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgDBD6V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Apr 2020 23:58:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35663 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbgDBD6T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2020 23:58:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id e14so2240514qts.2
        for <linux-arch@vger.kernel.org>; Wed, 01 Apr 2020 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FIyZcbBeG4NXJvMIHPgjJKueNZcgIVXv/zRU7nobAb0=;
        b=Pc/GApuxKxKJ4bznwNkN+CkN4TiVYXmSvMHqy3rRcc2gAFWoLbpnys6Er6Ql+hrGx5
         uWA5/opZRWMsm0gpqLB6ENnw2y+J3UKL1HFFWzEO3kqeNAUHHgdpqPP23VSHgYl4JylN
         Vh7w3QiNKuKjVsCz12A9nX5Tl3VEfmxtkYzg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FIyZcbBeG4NXJvMIHPgjJKueNZcgIVXv/zRU7nobAb0=;
        b=Di+CStj7drlV59Sg7sHlkXvZwgsRzDzxa6lTT1wBDs62gZCMEaJOpD6FGEOx/utF4y
         +FcCOoftYu0Qa974h8GUSsvL64jrAPkcdJ8RWscGND+FIknprJsNRrSlNehq0GpPkxZQ
         J8rYZQ06X+FEnvZQ4PFBU7575nvVyw96Vt6+NTgpv74XKTMzKR6Ao883Z/T5qsFMkJBN
         FQP8xZpjbuULsAguviRaQr3/qSHrrJ2QqYKqxVuernd8gfmQMlDAu6NKDtdYCPo0vzWy
         KjXdyMxzLxFQrBqdzxftFsX13Bu4/220jhZZUtZNZ7NYHQEcnWXDyaPK5nuI49IZLG8O
         h0/g==
X-Gm-Message-State: AGi0PuYarmZNezv92n2EaXaQB08zaHe8JnxfQJp4eZEZB2zJhMzFmntG
        W9CKSjIH/3H9vceHHNorqD1+bw==
X-Google-Smtp-Source: APiQypLI/ljsVswFPJHBN8JmhzhORetkqVNWwTsAxc6mCYlKhNGyM+vomCJUSXIada/n7ObMO2EvJw==
X-Received: by 2002:ac8:33cd:: with SMTP id d13mr990302qtb.265.1585799897328;
        Wed, 01 Apr 2020 20:58:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x74sm2833685qkb.40.2020.04.01.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 20:58:16 -0700 (PDT)
Date:   Wed, 1 Apr 2020 23:58:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20200402035816.GA46686@google.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
 <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 31, 2020 at 09:40:37AM +0800, Boqun Feng wrote:
> On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> > On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> > > A recent discussion raises up the requirement for having test cases for
> > > atomic APIs:
> > > 
> > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > 
> > > , and since we already have a way to generate a test module from a
> > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > tests for atomic APIs. And based on the previous discussion, I create a
> > > new directory Documentation/atomic-tests and put these litmus tests
> > > here.
> > > 
> > > This patchset starts the work by adding the litmus tests which are
> > > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > > it consistent with the litmus tests.
> > > 
> > > Previous version:
> > > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> > 
> > For full series:
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > One question I had was in the existing atomic_set() documentation, it talks
> > about atomic_add_unless() implementation based on locking could have issues.
> > It says the way to fix such cases is:
> > 
> > Quote:
> >     the typical solution is to then implement atomic_set{}() with
> >     atomic_xchg().
> > 
> > I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> > atomic_xchg() would be implemented using locking to avoid atomic_set() having
> 
> Right, I think that's the intent of the sentence.
> 
> > issues? If so, we could clarify that in the document.
> > 
> 
> Patches are welcome ;-)


---8<-----------------------

Like this? I'll add it to my tree and send it to Paul during my next
series, unless you disagree ;-)

Subject: [PATCH] doc: atomic_t: Document better about the locking within
 atomic_xchg()

It is not fully clear how the atomic_set() would not cause an issue with
preservation of the atomicity of RMW in this example. Make it clear that
locking within atomic_xchg() would save the day.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/atomic_t.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0f1fdedf36bbb..1d9c307c73a7c 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -129,6 +129,8 @@ with a lock:
     unlock();
 
 the typical solution is to then implement atomic_set{}() with atomic_xchg().
+The locking within the atomic_xchg() in CPU1 would ensure that the value read
+in CPU0 would not be overwritten.
 
 
 RMW ops:
-- 
2.26.0.292.g33ef6b2f38-goog

