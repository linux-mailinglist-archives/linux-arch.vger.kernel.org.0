Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC5E22AC9E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgGWKe2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Jul 2020 06:34:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52585 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgGWKe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 06:34:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-112-AklHWXKMPmK7pD_kEP6s_A-1; Thu, 23 Jul 2020 11:34:23 +0100
X-MC-Unique: AklHWXKMPmK7pD_kEP6s_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 11:34:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jul 2020 11:34:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Catalin Marinas' <catalin.marinas@arm.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] raw_copy_from_user() semantics
Thread-Topic: [RFC] raw_copy_from_user() semantics
Thread-Index: AQHWYBxygAO6HUS840aFW/LsMa1rTakTksjwgAAtkICAARbBwIAADSSAgAAU6KA=
Date:   Thu, 23 Jul 2020 10:34:23 +0000
Message-ID: <aef4985d744a4dcdac74f7a5360ec83b@AcuMS.aculab.com>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
 <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
 <20200722113707.GC27540@gaia>
 <8fde1b9044a34ff59eb5ff3dafbf2b97@AcuMS.aculab.com>
 <20200722165346.GB4069@gaia>
 <9c22700a16db4a4f8ae9203efcaed27b@AcuMS.aculab.com>
 <20200723101831.GA7315@gaia>
In-Reply-To: <20200723101831.GA7315@gaia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Catalin Marinas 
> Sent: 23 July 2020 11:19
> On Thu, Jul 23, 2020 at 08:37:27AM +0000, David Laight wrote:
> > From: Catalin Marinas
> > > Sent: 22 July 2020 17:54
> > > On Wed, Jul 22, 2020 at 01:14:21PM +0000, David Laight wrote:
> > > > From: Catalin Marinas
> > > > > Sent: 22 July 2020 12:37
> > > > > On Sun, Jul 19, 2020 at 12:34:11PM -0700, Linus Torvalds wrote:
> > > > > > On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
> > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > > I think we should try to get rid of the exact semantics.
> > > > > >
> > > > > > Side note: I think one of the historical reasons for the exact
> > > > > > semantics was that we used to do things like the mount option copying
> > > > > > with a "copy_from_user()" iirc.
> > > > > >
> > > > > > And that could take a fault at the end of the stack etc, because
> > > > > > "copy_mount_options()" is nasty and doesn't get a size, and just
> > > > > > copies "up to 4kB" of data.
> > > > > >
> > > > > > It's a mistake in the interface, but it is what it is. But we've
> > > > > > always handled the inexact count there anyway by originally doing byte
> > > > > > accesses, and at some point you optimized it to just look at where
> > > > > > page boundaries might be..
> > > > >
> > > > > And we may have to change this again since, with arm64 MTE, the page
> > > > > boundary check is insufficient:
> > > > >
> > > > > https://lore.kernel.org/linux-fsdevel/20200715170844.30064-25-catalin.marinas@arm.com/
> > > > >
> > > > > While currently the fault path is unlikely to trigger, with MTE in user
> > > > > space it's a lot more likely since the buffer (e.g. a string) is
> > > > > normally less than 4K and the adjacent addresses would have a different
> > > > > colour.
> > > > >
> > > > > I looked (though briefly) into passing the copy_from_user() problem to
> > > > > filesystems that would presumably know better how much to copy. In most
> > > > > cases the options are string, so something like strncpy_from_user()
> > > > > would work. For mount options as binary blobs (IIUC btrfs) maybe the fs
> > > > > has a better way to figure out how much to copy.
> > > >
> > > > What about changing the mount code to loop calling get_user()
> > > > to read aligned words until failure?
> > > > Mount is fairly uncommon and the extra cost is probably small compared
> > > > to the rest of doing a mount.
> > >
> > > Before commit 12efec560274 ("saner copy_mount_options()"), it was using
> > > single-byte get_user(). That could have been optimised for aligned words
> > > reading but I don't really think it's worth the hassle. Since the source
> > > and destination don't have the same alignment and some architecture
> > > don't support unaligned accesses (for storing to the kernel buffer), it
> > > would just make this function unnecessarily complicated.
> >
> > It could do aligned words if the user buffer is aligned (it will be
> > most of the time) and bytes otherwise.
> >
> > Or just fallback to a byte loop if the full 4k read fails.
> 
> That's what I'm proposing here (needed for arm64 MTE):
> 
> https://lore.kernel.org/linux-fsdevel/20200715170844.30064-25-catalin.marinas@arm.com/

Seems not unreasonable...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

