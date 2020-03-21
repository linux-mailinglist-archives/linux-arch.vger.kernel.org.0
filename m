Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4318DD92
	for <lists+linux-arch@lfdr.de>; Sat, 21 Mar 2020 03:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCUCFK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 22:05:10 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34620 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCUCFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 22:05:10 -0400
Received: by mail-qv1-f65.google.com with SMTP id o18so4176803qvf.1;
        Fri, 20 Mar 2020 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqEPVEoRdujNeFvEZNFf0K2LnjjxzBACdE/GEwgTyq8=;
        b=WDBYDUXCK+1lMxLHrnuS6uf0lXjiRANYqCWKcTMIfO6V3o+Oc2yGZvl5In+Qr+dXIV
         HNtdC83n5ayc8+Q6YdiEHxxI7cUKyR2lSohl01YK94+6ThXeq0cwU855n3sj7iG/7lFV
         5UOQiECJhSP9FTfkJ0KWVd37tWwkFIRcP7aUUhDGycWeGPntMPwY0k8IoP27sfjWNMon
         QcMb6DM3PZGkZjn2P4cnI1u/4LA8pdpqmWBnQgS8h3yU2/VvZS0tVcSWVnkDCmh7ag6H
         TizLfo7mEHx6H3i5I6WR3edra/dJQPzRCESwqQtlqbSrTP69Ud81kDahzcBqptsY8LQf
         D3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqEPVEoRdujNeFvEZNFf0K2LnjjxzBACdE/GEwgTyq8=;
        b=PvlcGc5ikjUOaxz66AE8dAcwoho2LbpdppPbybBr2CCYKGamI9qYyVGTyqadbONrHm
         R7DtsKn8MhEitUc1rRlAdAjurhml9OHdacH0JzWdf3kyuNwQUXBPWnWMBQRCsi3Lql3s
         5LO24c94lymwyNxXqnmtO5lnC/nMghkOS0P4DGUGLM7gNjDcsLcT3c8RcYMF2EpYk+Sq
         vXPhQ0Y727I2k9H+156NeAfMc6kHjSlr8xTafZfpKCMXI5iLbrLTHLrlQoaLROH5M3cE
         sof4IfkuzLza5fdFd51gNxLfYuai3T3Ro/aYh2BNG0d+/vOxusrP9GOU2UQMdaVPFagJ
         nfdA==
X-Gm-Message-State: ANhLgQ1OhEyjV64QtUFKmJ0oyARuvGN8JM3YplVbD0TVag+CEQlHCosj
        ohLZnAC7Er9oj2t2qM0T+K8=
X-Google-Smtp-Source: ADFU+vsp9j0kc5FQVKZ7/33nHlYdtFh1uju+hCOgUj/rYWoUd/WdTaOQRe7tNWMyrwuHQjXbtlBRQA==
X-Received: by 2002:ad4:4c12:: with SMTP id bz18mr11370560qvb.17.1584756308536;
        Fri, 20 Mar 2020 19:05:08 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n6sm5660317qkh.70.2020.03.20.19.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2020 19:05:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF45A27C0054;
        Fri, 20 Mar 2020 22:05:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 20 Mar 2020 22:05:06 -0400
X-ME-Sender: <xms:T3Z1XtSmmSLKsgAuuJX7R-ns3aNuJ6uPB1C0NtUL2aPRs8MHg72yXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegvddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehtgihtrdgshidpmhgrrhgtrdhinhhfohenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:T3Z1XtQfLNBv9PoNmITJJrWJY-DaEWhapkxQOq0pSXFXnT6OaYwhLQ>
    <xmx:T3Z1Xg0QvA-PQEm4p2o-QohgmN6xSlOcHmRzihoc7wfgHyQUxP-25Q>
    <xmx:T3Z1XnzPJMkTvVvcXion7Zw86pyzHhJ8rDyazdQ40YHgW61Sk01skQ>
    <xmx:UnZ1Xg4ckfDIexzkUuxQxhhjLuyZoatIpjfk1TO3hw7tMAZbdvjQDnnJf1Y>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A2F5328005D;
        Fri, 20 Mar 2020 22:05:03 -0400 (EDT)
Date:   Sat, 21 Mar 2020 10:05:01 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
Message-ID: <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200320165948.GB155212@google.com>
 <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
 <20200320214432.GB129293@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320214432.GB129293@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 05:44:32PM -0400, Joel Fernandes wrote:
> On Fri, Mar 20, 2020 at 04:56:59PM -0400, Alan Stern wrote:
> > On Fri, 20 Mar 2020, Joel Fernandes wrote:
> > 
> > > On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > > > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > > > 
> > > > > This adds an example for the important RCU grace period guarantee, which
> > > > > shows an RCU reader can never span a grace period.
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > > > >  1 file changed, 37 insertions(+)
> > > > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > 
> > > > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > new file mode 100644
> > > > > index 0000000000000..73557772e2a32
> > > > > --- /dev/null
> > > > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > 
> > > > Do these new tests really belong here?  I thought we were adding a new 
> > > > directory under Documentation/ for litmus tests that illustrate parts 
> > > > of the LKMM or memory-barriers.txt.
> > > > 
> > > > By contrast, the tests under tools/memory-model are merely to show 
> > > > people what litmus tests look like and how they should be written.
> > > 
> > > I could add it to tools/memory-model/Documentation/ under a new
> > > 'examples' directory there. We could also create an 'rcu' directory in
> > > tools/memory-model/litmus-tests/ and add these there. Thoughts?
> > 
> > What happened was that about a month ago, Boqun Feng added
> > Documentation/atomic-tests for litmus tests related to handling of
> > atomic_t types (see
> > <https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
> > interpose an extra directory level, making it
> > Documentation/litmus-tests/atomic?  Or
> > Documentation/LKMM-litmus-tests/atomic?
> > 
> > Then the new tests added here could go into
> > Documentation/litmus-tests/rcu, or whatever.
> 
> That's fine with me. Unless anyone objects, I will add to
> Documentation/litmus-tests/rcu and resend.
> 

Seems good to me, I will resend my patchset with the new directory. And
I assume in your patchset you will include the MAINTAINERS part for
adding Documentation/litmus-tests/ as a diretory watched by LKMM group?
In that case, I won't need to add any change to MAINTAINERS file in mine
and we won't have any conflict. ;-)

Regards,
Boqun


> thanks,
> 
>  - Joel
> 
