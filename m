Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8788278B98
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfG2MRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 08:17:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43599 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfG2MRt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 08:17:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so27953473pfg.10
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e1piTx10aEJP+ZI+r0n8JUDegiNyJ7yZ6BkYGQZQSIs=;
        b=tqEB3bTeUovzCMZVnoBL0VJTUh86W8/2VgLHc6/ZQjLA9hgiLeKrYkqwQE/GD6IqBE
         FKd9huGHW2KkeSAnKZfAwq29pFLq1B+is2K+sC1ElnpnPQcKrmKBiWjMiZZb4hvMsTo3
         cN+REtfsEboRgwIYOmaphzdrUjjxw/imZu0oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e1piTx10aEJP+ZI+r0n8JUDegiNyJ7yZ6BkYGQZQSIs=;
        b=GTAP+tgKHBbqjIs7LSzgSAYOt08km+/50LJbwuj75KdDr8UfxRTgnTq/BwfX62dRqL
         GLAJbrLOjvIs2bS7fTD4qnzpUfv1g7id7+k3JcH2V5sFICrVH3lhnk9PVng5aUdt/IP0
         Kzm7yjKZN7QaaqdW7Om9Du8i8KoFm7TDAUM1CyQy0HVTtC+Yu/Xbu17o3oPHgQfUIxeb
         uTPIoCK3AuV5VoLVYYNeN4j0EhPhqfu/QwZ5Aas/02zO5lfoMvCbSgyU8rJ1e5vRppNl
         AxaW2yugoZ3PVKswoS7GpABS5xuCMkvNbst/cajyHZNMmMwHxRxtVQAMMyVzdjig5/iv
         Q7Tg==
X-Gm-Message-State: APjAAAUahC/TDjYMVoVrqSqhjWGcUL1iESuYAAvYe/MHYkyrkHzd3/Jt
        Wfejmw799mD0+He6eeXrTSs=
X-Google-Smtp-Source: APXvYqynz1Nxden8tOcN+CpArgJ+RHKDrVg/RZJzN6ThDymD1kOvhHPEaxfWXfDpwK/bYkua4T+EkQ==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr111463058pjw.90.1564402668284;
        Mon, 29 Jul 2019 05:17:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g2sm77410208pfb.95.2019.07.29.05.17.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:17:47 -0700 (PDT)
Date:   Mon, 29 Jul 2019 08:17:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe
 link
Message-ID: <20190729121745.GA140682@google.com>
References: <20190728031303.164545-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
 <20190728151959.GA82871@google.com>
 <20190728152806.GB26905@tardis>
 <20190728153544.GA87531@google.com>
 <20190729055044.GC26905@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729055044.GC26905@tardis>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 01:50:44PM +0800, Boqun Feng wrote:
> On Sun, Jul 28, 2019 at 11:35:44AM -0400, Joel Fernandes wrote:
> [...]
> > > > > > +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> > > > > > +of y executes before P2's store to z (second fence), which implies that
> > > > > > +that stores to x and y propagate to P2 before the smp_store_release(), which
> > > > > > +means that P2's smp_store_release() will propagate stores to x and y to all
> > > > > > +CPUs before the store to z propagates (A-cumulative property of this fence).
> > > > > > +Finally P0's load of z executes after P2's store to z has propagated to
> > > > > > +P0 (rfe link).
> > > > > 
> > > > > Again, a better change would be simply to replace the two instances of
> > > > > "fence" in the original text with "cumul-fence".
> > > > 
> > > > Ok that's fine. But I still feel the rfe is not a part of the cumul-fence.
> > > > The fences have nothing to do with the rfe. Or, I am missing something quite
> > > > badly.
> > > > 
> > > > Boqun, did you understand what Alan is saying?
> > > > 
> > > 
> > > I think 'cumul-fence' that Alan mentioned is not a fence, but a
> > > relation, which could be the result of combining a rfe relation and a
> > > A-cumulative fence relation. Please see the section "PROPAGATION ORDER
> > > RELATION: cumul-fence" or the definition of cumul-fence in
> > > linux-kernel.cat.
> > > 
> > > Did I get you right, Alan? If so, your suggestion is indeed a better
> > > change.
> > 
> > To be frank, I don't think it is better if that's what Alan meant. It is
> > better to be explicit about the ->rfe so that the reader walking through the
> > example can clearly see the ordering and make sense of it.
> > 
> > Just saying 'cumul-fence' and then hoping the reader sees the light is quite
> > a big assumption and makes the document less readable.
> > 
> 
> After a bit more rereading of the document, I still think Alan's way is
> better ;-)

I think I finally understood. What I was missing was this definition of
cumul-fence involves an rf relation (with writes being possibly on different
CPUs).

E ->cumul-fence F
	F is a release fence and some X comes before F in program order,
	where either X = E or else E ->rf X; or

So I think what Alan meant is there is a cumul-fence between y=1 and z=1
because fo the ->rfe of y. Thus making it not necessary to mention the rfe.

Labeling E and F in the example...

	P1()
	{
		WRITE_ONCE(x, 2);
		smp_wmb();
		WRITE_ONCE(y, 1);		// This is E
	}

	P2()
	{
		int r2;

		r2 = READ_ONCE(y);		// This is X
		smp_store_release(&z, 1);	// This is F
	}

Here, E ->rf X ->release-fence -> F
implies,
      E ->cumul-fence F

Considering that, I agree with Alan's suggestion.

> 
> 	The formal definition of the prop relation involves a coe or
> 	fre link, followed by an arbitrary number of cumul-fence links,
> 	ending with an rfe link.
> 
> , so using "cumul-fence" actually matches the definition of ->prop.
> 
> For the ease of readers, I can think of two ways:
> 
> 1.	Add a backwards reference to cumul-fence section here, right
> 	before using its name.

Instead of that, a reference to the fact that the rfe causes a cumul-fence
between y=1 and z=1 may be helpful. No need backward reference IMO.

> 2.	Use "->cumul-fence" notation rather than "cumul-fence" here,
> 	i.e. add an arrow "->" before the name to call it out that name
> 	"cumul-fence" here stands for links/relations rather than a
> 	fence/barrier. Maybe it's better to convert all references to 
> 	links/relations to the "->" notations in the whole doc.

No, it is a fence that causes the relation in this example.

I don't think there is a distinction between ->cumul-fence and cumul-fence at
least for this example. The smp_store_release() is a FENCE which in this
example is really a cumul-fence between y=1 and z=1 because the release fence
affects propogation order of y and z on all CPUs. For any given CPU, y
propagates to that CPU before z does, even though y and z executed on
different CPUs.

I think what you're talking about is some other definition of cumul-fence
that is not mentioned in the formal definitions. May be you can update the
document with such definition then? AFAIU, cumul-fence is always a fence.

thanks,

 - Joel

