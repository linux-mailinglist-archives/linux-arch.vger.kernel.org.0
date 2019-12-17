Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA4123326
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 18:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLQRH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 12:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQRH0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 12:07:26 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F5D21582;
        Tue, 17 Dec 2019 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576602445;
        bh=9qLjCTJpYDZjDSgYG+Ze2rFSDFpRuJkwVOsNbCXu0yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCZA19g8+N5u/xEbIwE1OkPJs7Q9S+e4Y81lid+WvA3+cRX4qe8OuIKisihkv0c/l
         11VbnaWSg9gj0yX2tA2M/5poVsgWBQNWKvgdJIz/uubigq7HhGPmSVAoAbgku2i5Ye
         YBVeE6w6e3k1AR2O/IkXLuxvyZNJbHTKwRVO/jMc=
Date:   Tue, 17 Dec 2019 17:07:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191217170719.GA869@willie-the-truck>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 12, 2019 at 12:49:52PM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > The root of my concern in all of this, and what started me looking at it in
> > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > for a pointer means that local variables in macros declared using typeof()
> > suddenly start generating *hideous* code, particularly when pointless stack
> > spills get stackprotector all excited.
> 
> Yeah, removing volatile can be a bit annoying.
> 
> For the particular case of the bitops, though, it's not an issue.
> Since you know the type there, you can just cast it.
> 
> And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> 
>     typeof(0+(*p)) __var;
> 
> since you might as well get the integer promotion anyway (on the
> non-volatile result).
> 
> But that doesn't work with structures or unions, of course.
> 
> I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> have it with 64-bit entities on 32-bit machines, but that's ok with
> the "0+" trick.

Other than the two trivial examples Arnd and I spotted, it looks like
we're in for some fun with the page-table types such as pud_t but that
/should/ be fixable with enough effort.

However, I'm really banging my head against the compiler trying to get
your trick above to work for pointer types when the pointed-to-type is
not defined. As a very cut down example (I pulled this back out of the
preprocessor and cleaned it up a bit):


struct dentry {
	struct inode *d_inode;
};

static inline struct inode *d_inode_rcu(struct dentry *dentry)
{
	return ({
		typeof(0 + dentry->d_inode) __x = (*(volatile typeof(dentry->d_inode) *)&(dentry->d_inode));
		(typeof(dentry->d_inode))__x;
	});
}


Trying to compile this results in:

  | In function 'd_inode_rcu':
  | error: invalid use of undefined type 'struct inode'

whereas it compiles fine if you remove the '0 +' from the first typeof.

What am I missing? Perhaps the compiler wants the size information of
'struct inode' before it will contemplate the arithmetic, but if so then
I don't think we can use this trick after all. Hmm.

Will
