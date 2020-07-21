Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC95228A61
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 23:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgGUVLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUVLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:11:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D60C061794;
        Tue, 21 Jul 2020 14:11:20 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxzXi-00HRBK-OX; Tue, 21 Jul 2020 21:11:18 +0000
Date:   Tue, 21 Jul 2020 22:11:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Message-ID: <20200721211118.GB2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 01:58:47PM -0700, Linus Torvalds wrote:
> On Tue, Jul 21, 2020 at 1:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This seems dangerous to me.
> >
> > Maybe some implementation depends on the fact that they actually do
> > the csum 16 bits at a time, and never see an overflow in "int",
> > because they keep folding things.
> >
> > You now break that assumption, and give it an initial value that the
> > csum code itself would never generate, and wouldn't handle right.
> >
> > But I didn't check. Maybe we don't have anything that stupid in the kernel.

I did.

> I take it back. The very first place I looked seemed to do exactly that.
> 
> See "do_csum()" in the kernel. It doesn't handle carry for any of the
> usual cases, exactly because it knows it doesn't need to.
> 
> Ok, so do_csum() doesn't take that initial value, but it's very much
> an example of the kind of algorithm I was thinking of: it does do
> things 32 bits at a time and handles the carry bit in that inner loop,
> but internally it knows that the val;ues are limited in other places,
> and doesn't need to handle carry everywhere.

Theoretically - sure.  I can post the full analysis of that stuff (starting
with the proof that all instances of csum_partial() are OK in that respect,
which takes care of the default instances, then instance-by-instance
analysis of the rest); will need to collate the pieces, remove the actionable
obscenities, etc., but I have done that analysis.  Made for rather unpleasant
couple of weeks... ;-/
