Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8A229A68
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgGVOmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 10:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbgGVOmV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 10:42:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D66C0619DC;
        Wed, 22 Jul 2020 07:42:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyFwj-000M7e-I2; Wed, 22 Jul 2020 14:42:13 +0000
Date:   Wed, 22 Jul 2020 15:42:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Message-ID: <20200722144213.GE2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 09:27:32AM +0000, David Laight wrote:
> From: Al Viro
> > Sent: 21 July 2020 21:26
> > Preparation for the change of calling conventions; right now all
> > callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> > the values comparable mod 0xffff and guarantees that 0 will not
> > be returned on success.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  lib/iov_iter.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 7405922caaec..d5b7e204fea6 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1451,7 +1451,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
> >  		int err = 0;
> >  		next = csum_and_copy_from_user(v.iov_base,
> >  					       (to += v.iov_len) - v.iov_len,
> > -					       v.iov_len, 0, &err);
> > +					       v.iov_len, ~0U, &err);
> >  		if (!err) {
> >  			sum = csum_block_add(sum, next, off);
> >  			off += v.iov_len;
> 
> Can't you remove the csum_block_add() by passing the
> old 'sum' in instead of the ~0U ?
> You'll need to keep track of whether the buffer fragment
> is odd/even aligned.
> After an odd length fragment a bswap32() or 8 bit rotate will
> fix things (and maybe one right at the end).

And the benefit of that would be...?  It wouldn't be any simpler,
it almost certainly would not even be a valid microoptimization
(nevermind that this is an arch-independent code)...
