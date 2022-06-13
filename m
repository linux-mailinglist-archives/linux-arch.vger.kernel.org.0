Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0680F54A180
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiFMVbr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 13 Jun 2022 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiFMVaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 17:30:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF75918D
        for <linux-arch@vger.kernel.org>; Mon, 13 Jun 2022 14:29:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-9N43S4nTPaqalKCbtLkcWA-1; Mon, 13 Jun 2022 22:29:47 +0100
X-MC-Unique: 9N43S4nTPaqalKCbtLkcWA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 13 Jun 2022 22:29:46 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 13 Jun 2022 22:29:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Luck, Tony'" <tony.luck@intel.com>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        Marco Elver <elver@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Thread-Topic: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Thread-Index: AQHYfL4xWJEoq3eTcEeKREBjFjjrHK1JHg2A//+t5kCAAH9LAIAEkeOA//+tDzCAAFKXkA==
Date:   Mon, 13 Jun 2022 21:29:46 +0000
Message-ID: <5d65491caf6249c8b72c7a6ced95614c@AcuMS.aculab.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com>
 <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
 <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com>
 <c82877aa7cc244f2bf0f65dfb2b617e7@intel.com>
In-Reply-To: <c82877aa7cc244f2bf0f65dfb2b617e7@intel.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Luck, Tony
> Sent: 13 June 2022 17:27
> 
> >> It's listed in Documentation/atomic_bitops.txt.
> >
> > Oh, so my memory was actually correct that I saw it in the docs
> > somewhere.
> > WDYT, should I mention this here in the code (block comment) as well
> > that it's atomic and must not lose `volatile` as Andy suggested or
> > it's sufficient to have it in the docs (+ it's not underscored)?
> 
> I think a comment that the "volatile" is required to prevent re-ordering
> is enough.
> 
> But maybe others are sufficiently clear on the meaning? I once wasted
> time looking for the non-atomic __test_bit() version (to use in some code
> that was already protected by a spin lock, so didn't need the overhead
> of an "atomic" version) before realizing there wasn't a non-atomic one.

Does it make any sense for 'test bit' to be atomic?

I'm not even sure is needs any ordering constraints either.
The result is always stale - the value can be changed by
another cpu at any time.

The set/clear atomic bit-ops require a RMW bus cycle - which has
to be locked (or similar) to avoid corruption.

The atomic 'test and set' (etc) are RMW and return a valid state.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

