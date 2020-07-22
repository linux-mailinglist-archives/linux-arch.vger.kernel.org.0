Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0A229C02
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgGVPzB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGVPy6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 11:54:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A343C0619DC;
        Wed, 22 Jul 2020 08:54:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyH52-000Nu3-Iv; Wed, 22 Jul 2020 15:54:52 +0000
Date:   Wed, 22 Jul 2020 16:54:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Message-ID: <20200722155452.GF2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 03:22:45PM +0000, David Laight wrote:

> > And the benefit of that would be...?  It wouldn't be any simpler,
> > it almost certainly would not even be a valid microoptimization
> > (nevermind that this is an arch-independent code)...
> 
> It ought to give a minor improvement because it saves the extra
> csum_fold() when the checksum from a buffer is added to the
> previous total.
> 

Sigh...  _WHAT_ csum_fold()?

static inline __wsum
csum_block_add(__wsum csum, __wsum csum2, int offset)
{
        u32 sum = (__force u32)csum2;

        /* rotate sum to align it with a 16b boundary */
        if (offset & 1)
                sum = ror32(sum, 8);

        return csum_add(csum, (__force __wsum)sum);
}

David, do you *ever* bother to RTFS?  I mean, competent supercilious twits
are annoying, but at least with those you can generally assume that what
they say makes sense and has some relation to reality.  You, OTOH, keep
spewing utter bollocks, without ever lowering yourself to checking if your
guesses have anything to do with the reality.  With supercilious twit part
proudly on the display - you do speak with confidence, and the way you
dispense the oh-so-valuable advice to everyone around...
