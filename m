Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2618D8E0
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTUPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 16:15:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUPS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 16:15:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so2296332qtv.8
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2sn0BMuGSscu45PVRvZZbp6v7xwjlgP6F5F8pU0hs0U=;
        b=LofRG8M7jWo17M9c1WtCt8oJJftEZDNaylP/ywROMngIFroBJEImzTDG+k6ENZbeWh
         c5/O3SqG9HVKIgC3VxHOtmsHC0g4DYYpN9O+s98quCBtRt7Xh+VuLu2T24FzqpD8XeAD
         J9hkuWhKXrywN8umnbRb3BGVA4MjR9o5dxVKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2sn0BMuGSscu45PVRvZZbp6v7xwjlgP6F5F8pU0hs0U=;
        b=jg8PT+5TQeumAP2OhuqKkhjbOj/Emgu/nf4n6r5PCCYaLQ+gjICwGENKu2eJcNT7mn
         MakPVQyPOurdvTdvjR+INebHTskcb9f71p0Au8ltrVZBQss3yzHcr60v8sCwmZbyr/Ig
         g3irnUuN4J8vXRZuLqc/TKdCtOqXxzgg2pS0Ld3i+m4kdgD3sacqayKwkz8CFhlb5wxg
         t7VTWeJX9VMbBxmatp05oGHCyXruxy0uGxIy36DJV7Q3xLpgM21u1xgv+4O1fMBpCYNc
         SaY8Dw2sCrkBPr7gzrPyyEppzXw6/staV2xYHoZ1EbclSQMwRParL91Cjihw8+yGxfod
         mTZw==
X-Gm-Message-State: ANhLgQ3h3xyFDmFPi+6iWkWNkE9oN9xSb7XZ2NGFJGD8KBMa3jUrfvtG
        0m4odWemk3BJTspL4Ix9JoO9Pg==
X-Google-Smtp-Source: ADFU+vucwBtjyZwodvaMkTXuEeIJGAlD8SjeRVe64DQZgF0LZlFMsQVSre045Dq+6FeSXihuUJV4Kg==
X-Received: by 2002:ac8:3543:: with SMTP id z3mr9723397qtb.214.1584735317574;
        Fri, 20 Mar 2020 13:15:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q24sm5626146qtk.45.2020.03.20.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:15:16 -0700 (PDT)
Date:   Fri, 20 Mar 2020 16:15:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Message-ID: <20200320201516.GA129293@google.com>
References: <20200320065552.253696-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.2003201049230.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201049230.27303-100000@netrider.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 20, 2020 at 10:59:55AM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> 
> > This adds an example for the important RCU grace period guarantee, which
> > shows an RCU reader can never span a grace period.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > new file mode 100644
> > index 0000000000000..c4682502dd296
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > @@ -0,0 +1,40 @@
> > +C RCU+sync+free
> > +
> > +(*
> > + * Result: Never
> > + *
> 
> The following comment needs some rewriting.  The grammar is somewhat
> awkward and a very important "not" is missing.
> 
> > + * This litmus test demonstrates that an RCU reader can never see a write after
> > + * the grace period, if it saw writes that happen before the grace period.
> 
> An RCU reader can never see a write that follows a grace period if it
> did _not_ see writes that precede the grace period.

Yes, you are right. I will change your wording to 'did not see *all* writes
that precede'.

> >  This
> > + * is a typical pattern of RCU usage, where the write before the grace period
> > + * assigns a pointer, and the writes after destroy the object that the pointer
> > + * points to.
> 
> ... that the pointer used to point to.

Will fix.

> > + *
> > + * This guarantee also implies, an RCU reader can never span a grace period and
> > + * is an important RCU grace period memory ordering guarantee.
> 
> Unnecessary comma, and it is not clear what "This" refers to.  The 
> whole sentence should be phrased differently:
> 
> 	This is one implication of the RCU grace-period guarantee,
> 	which says (among other things) that an RCU reader cannot span 
> 	a grace period.

Your wording is better, will use that.

thanks,

 - Joel

