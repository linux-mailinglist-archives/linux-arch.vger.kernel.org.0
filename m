Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E0170CE2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 00:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBZX7u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 18:59:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34922 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgBZX7u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 18:59:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id 145so1472422qkl.2;
        Wed, 26 Feb 2020 15:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CS6s48/fad45V23lipX1Fu4yrThXZZxHb+g1PPIjhHA=;
        b=IRi3k6jh6CuNv9Iro1mODuBhyGCOIg1/vXBw8jI0ViW2AXxKWxW8sK7Een8m08wiHc
         3B5yTb7fi9uWt9azv8i9bgSCAT0Tiglgfl+IZT43wzBE/Pe64tLTUNA+Fr55ueUCyhR4
         5NLFyV2r5wMTwrYrYvbJjgzRcNUBLF2fcDU71Vu/8xvOBNbFfIDbrFKusJaBK5EPEl47
         nsSEsEMTot2hkGeWVysMjLio5a0dYAKfhaYFJEYyX5zlrCT0K/nMCDXA232K/SWWiZz+
         PNDUrpIjA9YPQ/ZSFhYjrZFVlNKbLewNjzoRQKrviTXKbLf2UlrGp7MGzTudpX0vkHQm
         ATXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CS6s48/fad45V23lipX1Fu4yrThXZZxHb+g1PPIjhHA=;
        b=hYzC16KZD8GfO42Ziu+A1zDQ5eT+zK5Gb7RvTF9H7qnpYp0a+9EmctH9BurA+IWmNr
         F2ipkU6+4gwwIJR9hJopXCbnWxIHr22m0E86T0ahBCPXsItnwrfb8ZroPUZvd1X4E10/
         aBcJU8QXG82fL+jJY8Y2B3vKQeKPxGTTnWOjsy+3eeoAAzt/+qq1iJ1e28zFy5V/T//P
         /SMlv+b9pdWAip3EkjidTqx9XrD1vWFxDS9iIZvvPy2E0ghswveQtwcAaV3g9M/YFhGq
         N5vVAJom4lbV4Qj8LbJVrJec/1D20Xkjym4nRRMkuR3Ino8g0mEB29mxsUCZinuCIRAK
         ryHg==
X-Gm-Message-State: APjAAAV6lH71iOSYLOPfEVuoVmICHYLyqKrC8Wcojp6zIJWZX6kuq7XP
        st5xC7vEYSMBHfo42dUSiiI=
X-Google-Smtp-Source: APXvYqwP2u0Kb+4Dq8jv1W/FJcdrY0PYuMBX+e+UaZQvwyocsi3K5G4bg9viAStlyxSs4Q6+LcvX9Q==
X-Received: by 2002:a37:de0d:: with SMTP id h13mr2220679qkj.332.1582761588987;
        Wed, 26 Feb 2020 15:59:48 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t187sm2048550qke.85.2020.02.26.15.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:59:48 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id A299221BA9;
        Wed, 26 Feb 2020 18:59:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Feb 2020 18:59:46 -0500
X-ME-Sender: <xms:cAZXXhbjjJjIv7V0GQ9zs4TInE16GsnUN1ylPrvZElfWfDhZebbEWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cAZXXrqb9SBYjA0sUQmdlA-1Ux1dndcfzLMAVeog4XU9JZ7tQIJRvQ>
    <xmx:cAZXXoDWg5d4uZmDGU7zy3meZEfDfeWPDBwh9H3Rhc40dN2o8Q6jyQ>
    <xmx:cAZXXpqPZHyNyRIt62uIgFv38kmSH4trGdqZNT16aTZamMm_0I74QA>
    <xmx:cgZXXiaXZEufA1TgQY8MAwt2l1tutBAigwptFf_og_WDSQFnHNLoqc0L5ME>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 194BF328005D;
        Wed, 26 Feb 2020 18:59:43 -0500 (EST)
Date:   Thu, 27 Feb 2020 07:59:42 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Remove lock-final checking in
 lock.cat
Message-ID: <20200226235942.GR69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200226032142.89424-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002260953110.3674-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002260953110.3674-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 09:58:12AM -0500, Alan Stern wrote:
> On Wed, 26 Feb 2020, Boqun Feng wrote:
> 
> > In commit 30b795df11a1 ("tools/memory-model: Improve mixed-access
> > checking in lock.cat"), we have added the checking to disallow any
> > normal memory access to lock variables, and this checking is stronger
> > than lock-final. So remove the lock-final checking as it's unnecessary
> > now.
> 
> I don't understand this description.  Why do you say that the
> normal-access checking is stronger than the lock-final check?
> 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  tools/memory-model/lock.cat | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > index 6b52f365d73a..827a3646607c 100644
> > --- a/tools/memory-model/lock.cat
> > +++ b/tools/memory-model/lock.cat
> > @@ -54,9 +54,6 @@ flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
> >   *)
> >  empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
> >  
> > -(* The final value of a spinlock should not be tested *)
> > -flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
> > -
> >  (*
> >   * Put lock operations in their appropriate classes, but leave UL out of W
> >   * until after the co relation has been generated.
> 
> With this check removed, what will prevent people from writing litmus 
> tests like this?
> 

You are right, one thing I was missing is although FW is a subset of M,
however FW & IW is not empty. Thanks! I will drop this.

Regards,
Boqun

> C test
> 
> {
> 	spinlock_t s;
> }
> 
> ...
> 
> exists (s=0)
> 
> Alan
> 
