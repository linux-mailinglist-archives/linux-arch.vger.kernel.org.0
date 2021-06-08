Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA939F716
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhFHMuk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 8 Jun 2021 08:50:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:24281 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232351AbhFHMuj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 08:50:39 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-286-rjzIJM_MPTyFs9Jyebup6g-1; Tue, 08 Jun 2021 13:48:41 +0100
X-MC-Unique: rjzIJM_MPTyFs9Jyebup6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 8 Jun 2021 13:48:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 8 Jun 2021 13:48:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC] LKMM: Add volatile_if()
Thread-Topic: [RFC] LKMM: Add volatile_if()
Thread-Index: AQHXWSohzZ+wiGIEgk6EAayn44xGXqsKFedw
Date:   Tue, 8 Jun 2021 12:48:40 +0000
Message-ID: <208f76bd2815443981e73d790b1b7174@AcuMS.aculab.com>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 04 June 2021 11:12
> 
> Hi!
> 
> With optimizing compilers becoming more and more agressive and C so far
> refusing to acknowledge the concept of control-dependencies even while
> we keep growing the amount of reliance on them, things will eventually
> come apart.
> 
> There have been talks with toolchain people on how to resolve this; one
> suggestion was allowing the volatile qualifier on branch statements like
> 'if', but so far no actual compiler has made any progress on this.
> 
> Rather than waiting any longer, provide our own construct based on that
> suggestion. The idea is by Alan Stern and refined by Paul and myself.
> 
> Code generation is sub-optimal (for the weak architectures) since we're
> forced to convert the condition into another and use a fixed conditional
> branch instruction, but shouldn't be too bad.

What happens on mips-like architectures (I think includes riscv)
that have 'compare two registers and branch' instructions rather
than a more traditional 'flags register'?

The generated code it likely to be somewhat different.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

