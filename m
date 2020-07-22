Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0268229EA3
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGVRjK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVRjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 13:39:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790B5C0619DC;
        Wed, 22 Jul 2020 10:39:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyIhr-000Qcs-Cu; Wed, 22 Jul 2020 17:39:03 +0000
Date:   Wed, 22 Jul 2020 18:39:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Message-ID: <20200722173903.GG2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 04:17:02PM +0000, David Laight wrote:
> > David, do you *ever* bother to RTFS?  I mean, competent supercilious twits
> > are annoying, but at least with those you can generally assume that what
> > they say makes sense and has some relation to reality.  You, OTOH, keep
> > spewing utter bollocks, without ever lowering yourself to checking if your
> > guesses have anything to do with the reality.  With supercilious twit part
> > proudly on the display - you do speak with confidence, and the way you
> > dispense the oh-so-valuable advice to everyone around...
> 
> Yes, I do look at the code.
> I've actually spent a lot of time looking at the x86 checksum code.
> I've posted a patch for a version that is about twice as fast as the
> current one on a large range of x86 cpus.
> 
> Possibly I meant the 32bit reduction inside csum_add()
> rather than what csum_fold() does.

Really?
static inline unsigned add32_with_carry(unsigned a, unsigned b)
{  
        asm("addl %2,%0\n\t"
            "adcl $0,%0"
            : "=r" (a)
            : "0" (a), "rm" (b));
        return a;
}
static inline __wsum csum_add(__wsum csum, __wsum addend)
{
        return (__force __wsum)add32_with_carry((__force unsigned)csum,
                                                (__force unsigned)addend);
}

I would love to see your patch, anyway, along with the testcases and performance
comparison.

> Having worked on the internals of SYSV, NetBSD and Linux I probably
> forget the exact names for a few things.

That's usually dealt with by a few minutes with grep and vi...

> The brain can only hold so much information.

Bravo.  "I can't be arsed to check anything" spun into the claim of one's
superior experience.

What it means in practice is that your output is so much garbage that _might_
be untangled into something meaningful if the reader manages to guess the
substitutions.  Provided that the reconstruction won't not turn out to be
a composite of things applying to different versions of different kernels,
not being valid for any of those, that is...
