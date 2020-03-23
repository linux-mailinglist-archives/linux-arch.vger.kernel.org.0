Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAA18EDA8
	for <lists+linux-arch@lfdr.de>; Mon, 23 Mar 2020 02:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWBbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Mar 2020 21:31:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36844 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCWBbC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Mar 2020 21:31:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so13763919qko.3
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2020 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbZKelnf9av4oEdayiPkq2WIuUvuqILBE4whTz9Zy2k=;
        b=HPqpl9aRL2IrrGwnAOvgDAi/cVDDDaGlZqNH/RHRtShz8vnbD0h7gid7z52XPaRGbX
         XnyuJ9t9ds7SP5R4oV4L0ZFj23FgypcAaUZMUeGraJJzPdOdF4t7ju67lq/GCsmkTCUU
         qE7OKB/zrZv39pb12o9DOvH70d7RRh6IGW7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbZKelnf9av4oEdayiPkq2WIuUvuqILBE4whTz9Zy2k=;
        b=Ub5BuSuFiFxNJqruyO8ms9K/MT8gxYQLw3Mm687G0h4N03Vt0JjGJUeOO86h8fHUV3
         2l1G+t5ZynSpqGYafP+oMTF39WwS6mWV4fdA7BVo2xRhYrjkwIwgpdZGb7IKRZ5uPRfO
         iFVYBBPuj16Anc7TH3pmWCF0tCx2h6OfiaOLTfMYz4H1WzN8oKZ5CLgl5drlPICsM/Bn
         VxAhs0a7dA6PUxdQTgvU7y+9VRLFe0wA3Zg+MEngdzdhQLWfUVDKfs8T+PkoHclk/JBc
         0rHHdBsZpMuHD6/H4ISFD3qLId+DDFjiVnQSirbDi0oLxxngRRm4ZhGty8od16zvbx0T
         9ZfA==
X-Gm-Message-State: ANhLgQ1owWZVqe4IWppuTocRex2BdVEFJtYIcCFMdHZikmtiNlaMHIFA
        Kcccwj77V1D5N7sYGz5biGJWkQ==
X-Google-Smtp-Source: ADFU+vvl/ceqkZSABdKNWG2+QDkHNSdEo2qVpqX7fZIzcLTum3BEMWl2hOTneYuMX9D2cX934TdQ0g==
X-Received: by 2002:a37:cc1:: with SMTP id 184mr19167675qkm.430.1584927061435;
        Sun, 22 Mar 2020 18:31:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f26sm9918119qkl.119.2020.03.22.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:31:00 -0700 (PDT)
Date:   Sun, 22 Mar 2020 21:31:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20200323013100.GA207949@google.com>
References: <20200320165948.GB155212@google.com>
 <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
 <20200320214432.GB129293@google.com>
 <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 21, 2020 at 10:05:01AM +0800, Boqun Feng wrote:
> On Fri, Mar 20, 2020 at 05:44:32PM -0400, Joel Fernandes wrote:
> > On Fri, Mar 20, 2020 at 04:56:59PM -0400, Alan Stern wrote:
> > > On Fri, 20 Mar 2020, Joel Fernandes wrote:
> > > 
> > > > On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > > > > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > > > > 
> > > > > > This adds an example for the important RCU grace period guarantee, which
> > > > > > shows an RCU reader can never span a grace period.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > > > > >  1 file changed, 37 insertions(+)
> > > > > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > 
> > > > > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > new file mode 100644
> > > > > > index 0000000000000..73557772e2a32
> > > > > > --- /dev/null
> > > > > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > 
> > > > > Do these new tests really belong here?  I thought we were adding a new 
> > > > > directory under Documentation/ for litmus tests that illustrate parts 
> > > > > of the LKMM or memory-barriers.txt.
> > > > > 
> > > > > By contrast, the tests under tools/memory-model are merely to show 
> > > > > people what litmus tests look like and how they should be written.
> > > > 
> > > > I could add it to tools/memory-model/Documentation/ under a new
> > > > 'examples' directory there. We could also create an 'rcu' directory in
> > > > tools/memory-model/litmus-tests/ and add these there. Thoughts?
> > > 
> > > What happened was that about a month ago, Boqun Feng added
> > > Documentation/atomic-tests for litmus tests related to handling of
> > > atomic_t types (see
> > > <https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
> > > interpose an extra directory level, making it
> > > Documentation/litmus-tests/atomic?  Or
> > > Documentation/LKMM-litmus-tests/atomic?
> > > 
> > > Then the new tests added here could go into
> > > Documentation/litmus-tests/rcu, or whatever.
> > 
> > That's fine with me. Unless anyone objects, I will add to
> > Documentation/litmus-tests/rcu and resend.
> > 
> 
> Seems good to me, I will resend my patchset with the new directory. And
> I assume in your patchset you will include the MAINTAINERS part for
> adding Documentation/litmus-tests/ as a diretory watched by LKMM group?
> In that case, I won't need to add any change to MAINTAINERS file in mine
> and we won't have any conflict. ;-)

Yes, will add to MAINTAINERS so that you don't have to :) About to send my
queue now.

thanks,

 - Joel

