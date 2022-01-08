Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310644886CC
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiAHWoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 8 Jan 2022 17:44:38 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30710 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbiAHWoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 17:44:37 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-280-499iGOrwP9q2rn5_yVejbA-1; Sat, 08 Jan 2022 22:44:34 +0000
X-MC-Unique: 499iGOrwP9q2rn5_yVejbA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sat, 8 Jan 2022 22:44:33 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sat, 8 Jan 2022 22:44:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Kyle Huey" <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: RE: [PATCH 06/10] exit: Implement kthread_exit
Thread-Topic: [PATCH 06/10] exit: Implement kthread_exit
Thread-Index: AQHYBL6SK3WWv05P/UGJJpzMMoEvlqxZuMlQ
Date:   Sat, 8 Jan 2022 22:44:33 +0000
Message-ID: <160ab942f83043d4878719e5354925cc@AcuMS.aculab.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-6-ebiederm@xmission.com>
        <YdelKq9U86/dHPcm@zeniv-ca.linux.org.uk>
 <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Eric W. Biederman
> Sent: 08 January 2022 18:36
> 
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > IMO the right way to handle that would be
> > 	1) turn these two do_exit() into do_exit(0), to reduce
> > confusion
> > 	2) deal with all do_exit() in kthread payloads.  Your
> > name for the primitive is fine, IMO.
> > 	3) make that primitive pass the return value by way of
> > a field in struct kthread, adjusting kthread_stop() accordingly
> > and passing 0 to do_exit() in kthread_exit() itself.
> >
> > (2) is not as trivial as you seem to hope, though.  Your patches
> > in drivers/staging/rt*/ had papered over the problem in there,
> > but hadn't really solved it.
> >
> > thread_exit() should've been shot, all right, but it really ought
> > to have been complete_and_exit() there.  The thing is, complete()
> > + return does *not* guarantee that driver won't get unloaded before
> > the thread terminates.  Possibly freeing its .code and leaving
> > a thread to resume running in there as soon as it regains CPU.
> >
> > The point of complete_and_exit() is that it's noreturn *and* in
> > core kernel.  So it can be safely used in a modular kthread,
> > if paired with wait_for_completion() in or before module_exit.
> > complete() + do_exit() (or complete + return as you've gotten
> > there) doesn't give such guarantees at all.
> 
> 
> I think we are mostly in agreement here.
> 
> There are kernel threads started by modules that do:
> 	complete(...);
>         return 0;
> 
> That should be at a minimum calling complete_and_exit.  Possibly should
> be restructured to use kthread_stop().

There is also module_put_and_exit(0);
Which must have an implied THIS_MODULE.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

