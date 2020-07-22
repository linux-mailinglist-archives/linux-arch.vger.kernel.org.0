Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB9229787
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGVLhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 07:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgGVLhL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 07:37:11 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C87820729;
        Wed, 22 Jul 2020 11:37:10 +0000 (UTC)
Date:   Wed, 22 Jul 2020 12:37:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] raw_copy_from_user() semantics
Message-ID: <20200722113707.GC27540@gaia>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
 <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 19, 2020 at 12:34:11PM -0700, Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > I think we should try to get rid of the exact semantics.
> 
> Side note: I think one of the historical reasons for the exact
> semantics was that we used to do things like the mount option copying
> with a "copy_from_user()" iirc.
> 
> And that could take a fault at the end of the stack etc, because
> "copy_mount_options()" is nasty and doesn't get a size, and just
> copies "up to 4kB" of data.
> 
> It's a mistake in the interface, but it is what it is. But we've
> always handled the inexact count there anyway by originally doing byte
> accesses, and at some point you optimized it to just look at where
> page boundaries might be..

And we may have to change this again since, with arm64 MTE, the page
boundary check is insufficient:

https://lore.kernel.org/linux-fsdevel/20200715170844.30064-25-catalin.marinas@arm.com/

While currently the fault path is unlikely to trigger, with MTE in user
space it's a lot more likely since the buffer (e.g. a string) is
normally less than 4K and the adjacent addresses would have a different
colour.

I looked (though briefly) into passing the copy_from_user() problem to
filesystems that would presumably know better how much to copy. In most
cases the options are string, so something like strncpy_from_user()
would work. For mount options as binary blobs (IIUC btrfs) maybe the fs
has a better way to figure out how much to copy.

> I think that was the only truly _valid_ case of "we actually copy data
> from user space, and we might need to handle a partial case", and
> exactly because of that, it had already long avoided the whole "assume
> copy_from_user gives us byte-accurate data before the fault".

With MTE, we didn't find any other instance of copy_from_user() where
the byte accuracy matters. The close relative, strncpy_from_user(),
already handles exact copying via a fall back to byte at a time.

-- 
Catalin
