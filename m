Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39BD229B43
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgGVPWu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 22 Jul 2020 11:22:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33794 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbgGVPWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 11:22:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-74-f_ZtVPR8PtCaz6mMzPOs4w-1; Wed, 22 Jul 2020 16:22:46 +0100
X-MC-Unique: f_ZtVPR8PtCaz6mMzPOs4w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 22 Jul 2020 16:22:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 22 Jul 2020 16:22:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Topic: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Index: AQHWX51MlcPCEWebQUuN/OB/armWnKkTU0FggABJU4CAABlpkA==
Date:   Wed, 22 Jul 2020 15:22:45 +0000
Message-ID: <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200722144213.GE2786714@ZenIV.linux.org.uk>
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

From: Al Viro
> Sent: 22 July 2020 15:42
> 
> On Wed, Jul 22, 2020 at 09:27:32AM +0000, David Laight wrote:
> > From: Al Viro
> > > Sent: 21 July 2020 21:26
> > > Preparation for the change of calling conventions; right now all
> > > callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> > > the values comparable mod 0xffff and guarantees that 0 will not
> > > be returned on success.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  lib/iov_iter.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > index 7405922caaec..d5b7e204fea6 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -1451,7 +1451,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
> > >  		int err = 0;
> > >  		next = csum_and_copy_from_user(v.iov_base,
> > >  					       (to += v.iov_len) - v.iov_len,
> > > -					       v.iov_len, 0, &err);
> > > +					       v.iov_len, ~0U, &err);
> > >  		if (!err) {
> > >  			sum = csum_block_add(sum, next, off);
> > >  			off += v.iov_len;
> >
> > Can't you remove the csum_block_add() by passing the
> > old 'sum' in instead of the ~0U ?
> > You'll need to keep track of whether the buffer fragment
> > is odd/even aligned.
> > After an odd length fragment a bswap32() or 8 bit rotate will
> > fix things (and maybe one right at the end).
> 
> And the benefit of that would be...?  It wouldn't be any simpler,
> it almost certainly would not even be a valid microoptimization
> (nevermind that this is an arch-independent code)...

It ought to give a minor improvement because it saves the extra
csum_fold() when the checksum from a buffer is added to the
previous total.

On 64bit systems there are even advantages in passing in a 64bit
value - so the caller can add many 32bit values together.
If nothing else it lets you use a '<< 8' if the previous fragment
had an odd length.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

