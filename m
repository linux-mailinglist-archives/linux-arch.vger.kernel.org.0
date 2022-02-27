Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2B4C59DB
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiB0HL2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 27 Feb 2022 02:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiB0HL1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 02:11:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A48181EC65
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 23:10:50 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-286-9XdmrcSQOhGG3MJ0OheetQ-1; Sun, 27 Feb 2022 07:10:47 +0000
X-MC-Unique: 9XdmrcSQOhGG3MJ0OheetQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 27 Feb 2022 07:10:45 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 27 Feb 2022 07:10:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Topic: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Index: AQHYK3er/AEA45TQBUCd0AhQFcgB96ym+KOQ
Date:   Sun, 27 Feb 2022 07:10:45 +0000
Message-ID: <7abf3406919b4f0c828dacea6ce97ce8@AcuMS.aculab.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
 <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org>
 <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
 <20220227010956.GW614@gate.crashing.org>
In-Reply-To: <20220227010956.GW614@gate.crashing.org>
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
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Segher Boessenkool
> Sent: 27 February 2022 01:10
> 
> On Sat, Feb 26, 2022 at 11:14:15PM +0100, Arnd Bergmann wrote:
> > On Sat, Feb 26, 2022 at 1:42 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Wed, Feb 23, 2022 at 11:23:39AM -0800, Linus Torvalds wrote:
> >
> > >
> > > The only reason the warning exists is because it is undefined behaviour
> > > (not implementation-defined or anything).  The reason it is that in the
> > > standard is that it is hard to implement and even describe for machines
> > > that are not two's complement.  However relevant that is today :-)

I thought only right shifts of negative values were 'undefined'.
And that was to allow cpu that only had logical shift right
(ie ones that didn't propagate the sign) to be conformant.
I wonder when the last cpu like that was?

Quite why the standards keeps using the term 'undefined behaviour'
beats me - there ought to be something for 'undefined value'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

