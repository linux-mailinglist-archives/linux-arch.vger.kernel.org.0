Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F522AA244
	for <lists+linux-arch@lfdr.de>; Sat,  7 Nov 2020 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgKGDHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 22:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgKGDHR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 22:07:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFFC0613CF;
        Fri,  6 Nov 2020 19:07:17 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so3039688qki.6;
        Fri, 06 Nov 2020 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L6+s4a5W/6goVXVckpmZgq0QtyyNxZNKYhipwdzHOkQ=;
        b=q8H9z+Z33U5LldOf/cfXRH6j1fsr3vEYaiB8CB4bCVoGCf2Y3zNKuuHRM5ZuMaPRvz
         8FvWtSqYU60F60zLqTOm3idp7cZC3zD4eOleFMGtvx/vMJVc6tIjRD9A9QZgNO5XH9bo
         qGz94NxjAL6Xs6EzWaHYhiV6jbvmh43Vc7f89PnHtIujCzYIgb6UCI3ugzgulhSVznys
         z+M8g9vomRjdWnLBgpT3BAC7qbRHi+f4WTlUUJKz7ovjo2y9yMpFYJgWAX8gtrv3nkYI
         BtujNtcU9VAtC16bItWA0DQxMledu6Q840zmwrsbopeNPO73G2Qpk5Cqkhi6KeQsBs4j
         gS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L6+s4a5W/6goVXVckpmZgq0QtyyNxZNKYhipwdzHOkQ=;
        b=SyyFYG+GmZjqGUYCllLSBraMYIee9/1ezCWLZGvrQ5BqTJfDagCc0z2V0RPAbao61Z
         5S70+EorhYgePcJCb4PpVhfW0tYVQOP8aFeXd/Vas6bBIbMoE59TrrdCqINkop9iqXjJ
         PPQ8Vew0wTHY8VPD2moSJTdiFBWEJrmSwgfSDW/sdR93nWeML+BesKvaWNtS8a3bGMqf
         m4nlMEGi7e3RVV2AhxLLZUgLpIPLNAiej+4cg2nvFbcF6ohCvvq2z0KStNH0c/cfTqER
         Hz5JE5S+HuR45IaRn+QOLBJM00WDNQNPnimxdM3vuAlnKaobAncyhPxlx0+LvMyTtEya
         caBg==
X-Gm-Message-State: AOAM530YRw0LUgdHEf7ml1hqrXRXIKQnUpkcFH96j2UtDP+O9daZUdAa
        PvuIR/4GSM9ZatnvSn20e2Q=
X-Google-Smtp-Source: ABdhPJx9Y1hlnGHLjdKrqBzkBcwTo0m+3jb+0dcEjfJVQxAjSQ9Qx7ZQJW/CPojt49VoHFknQWF+3g==
X-Received: by 2002:a05:620a:13d4:: with SMTP id g20mr4616295qkl.376.1604718436277;
        Fri, 06 Nov 2020 19:07:16 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j25sm1850050qtk.79.2020.11.06.19.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 19:07:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 46F7927C0054;
        Fri,  6 Nov 2020 22:07:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 06 Nov 2020 22:07:09 -0500
X-ME-Sender: <xms:XA-mX0jREVsm9rwG1hLMVn905cYYFnbC0DJiNCwNEI3lGLL-rxcB2A>
    <xme:XA-mX9Dn8m5YbywltgZOYixnKlR6ovyDz2Qt3w3CiMLMGXnNtXeMzvQK0aX7f1n7i
    SebX7RZnBRk_Ll29Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddutddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeduieejrddvvddtrddvrdduvdeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:XA-mX8Hr0YRG0CQzUaz2LrA6-P6KqQiRTpoMrjDG8a_GhSG8Dewt2A>
    <xmx:XA-mX1QzACC6ijIqWZD8CxRv7CgvMoP4RTCSm4YBsheCz3zKHG-TLQ>
    <xmx:XA-mXxwX5zNQuTiPs3bU18dVqinDv5MYVyomAOLWiwT58cZy0bnE3A>
    <xmx:XQ-mX0ryOKLhXRUmmstkyhvrEn5LrPQohMxTTHQrvw_XavqiL2LEnX--C_0>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id D0A4232803D4;
        Fri,  6 Nov 2020 22:07:07 -0500 (EST)
Date:   Sat, 7 Nov 2020 11:07:02 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Add a glossary of
 LKMM terms
Message-ID: <20201107030702.GE3025@boqun-archlinux>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-5-paulmck@kernel.org>
 <20201106014722.GB3025@boqun-archlinux>
 <20201106180102.GW3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106180102.GW3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 10:01:02AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 06, 2020 at 09:47:22AM +0800, Boqun Feng wrote:
> > On Thu, Nov 05, 2020 at 02:00:14PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  tools/memory-model/Documentation/glossary.txt | 155 ++++++++++++++++++++++++++
> > >  1 file changed, 155 insertions(+)
> > >  create mode 100644 tools/memory-model/Documentation/glossary.txt
> > > 
> > > diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> > > new file mode 100644
> > > index 0000000..036fa28
> > > --- /dev/null
> > > +++ b/tools/memory-model/Documentation/glossary.txt
> > > @@ -0,0 +1,155 @@
> > > +This document contains brief definitions of LKMM-related terms.  Like most
> > > +glossaries, it is not intended to be read front to back (except perhaps
> > > +as a way of confirming a diagnosis of OCD), but rather to be searched
> > > +for specific terms.
> > > +
> > > +
> > > +Address Dependency:  When the address of a later memory access is computed
> > > +	based on the value returned by an earlier load, an "address
> > > +	dependency" extends from that load extending to the later access.
> > > +	Address dependencies are quite common in RCU read-side critical
> > > +	sections:
> > > +
> > > +	 1 rcu_read_lock();
> > > +	 2 p = rcu_dereference(gp);
> > > +	 3 do_something(p->a);
> > > +	 4 rcu_read_unlock();
> > > +
> > > +	 In this case, because the address of "p->a" on line 3 is computed
> > > +	 from the value returned by the rcu_dereference() on line 2, the
> > > +	 address dependency extends from that rcu_dereference() to that
> > > +	 "p->a".  In rare cases, optimizing compilers can destroy address
> > > +	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
> > > +	 for more information.
> > > +
> > > +	 See also "Control Dependency".
> > > +
> > > +Acquire:  With respect to a lock, acquiring that lock, for example,
> > > +	using spin_lock().  With respect to a non-lock shared variable,
> > > +	a special operation that includes a load and which orders that
> > > +	load before later memory references running on that same CPU.
> > > +	An example special acquire operation is smp_load_acquire(),
> > > +	but atomic_read_acquire() and atomic_xchg_acquire() also include
> > > +	acquire loads.
> > > +
> > > +	When an acquire load returns the value stored by a release store
> > > +	to that same variable, then all operations preceding that store
> > 
> > Change this to:
> > 
> > 	When an acquire load reads-from a release store
> > 
> > , and put a reference to "Reads-from"? I think this makes the document
> > more consistent in that it makes clear "an acquire load returns the
> > value stored by a release store to the same variable" is not a special
> > case, it's simple a "Reads-from".
> > 
> > > +	happen before any operations following that load acquire.
> > 
> > Add a reference to the definition of "happen before" in explanation.txt?
> 
> How about as shown below?  I currently am carrying this as a separate
> commit, but I might merge it into this one later on.
> 

Looks good to me, thanks!

Regards,
Boqun

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 774a52cd3d80d6b657ae6c14c10bd9fc437068f3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Nov 6 09:58:01 2020 -0800
> 
>     tools/memory-model: Tie acquire loads to reads-from
>     
>     This commit explicitly makes the connection between acquire loads and
>     the reads-from relation.  It also adds an entry for happens-before,
>     and refers to the corresponding section of explanation.txt.
>     
>     Reported-by: Boqun Feng <boqun.feng@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
> index 3924aca..383151b 100644
> --- a/tools/memory-model/Documentation/glossary.txt
> +++ b/tools/memory-model/Documentation/glossary.txt
> @@ -33,10 +33,11 @@ Acquire:  With respect to a lock, acquiring that lock, for example,
>  	acquire loads.
>  
>  	When an acquire load returns the value stored by a release store
> -	to that same variable, then all operations preceding that store
> -	happen before any operations following that load acquire.
> +	to that same variable, (in other words, the acquire load "reads
> +	from" the release store), then all operations preceding that
> +	store "happen before" any operations following that load acquire.
>  
> -	See also "Relaxed" and "Release".
> +	See also "Happens-Before", "Reads-From", "Relaxed", and "Release".
>  
>  Coherence (co):  When one CPU's store to a given variable overwrites
>  	either the value from another CPU's store or some later value,
> @@ -102,6 +103,11 @@ Fully Ordered:  An operation such as smp_mb() that orders all of
>  	that orders all of its CPU's prior accesses, itself, and
>  	all of its CPU's subsequent accesses.
>  
> +Happens-Before (hb): A relation between two accesses in which LKMM
> +	guarantees the first access precedes the second.  For more
> +	detail, please see the "THE HAPPENS-BEFORE RELATION: hb"
> +	section of explanation.txt.
> +
>  Marked Access:  An access to a variable that uses an special function or
>  	macro such as "r1 = READ_ONCE()" or "smp_store_release(&a, 1)".
>  
