Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4786DC5D2
	for <lists+linux-arch@lfdr.de>; Mon, 10 Apr 2023 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDJKoD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 10 Apr 2023 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJKoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Apr 2023 06:44:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FB92D5E
        for <linux-arch@vger.kernel.org>; Mon, 10 Apr 2023 03:44:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-8fV8-B5cOpqAWPyi2bo6Mw-1; Mon, 10 Apr 2023 11:43:56 +0100
X-MC-Unique: 8fV8-B5cOpqAWPyi2bo6Mw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 10 Apr
 2023 11:43:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 10 Apr 2023 11:43:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alan Stern' <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Jade Alglave" <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Jonas Oberhauser" <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Paul_Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        "Will Deacon" <will@kernel.org>
Subject: RE: Litmus test names
Thread-Topic: Litmus test names
Thread-Index: AQHZaM/U3RxZdOvMEkORgNwDbqnnkK8kYK2g
Date:   Mon, 10 Apr 2023 10:43:52 +0000
Message-ID: <470b82a5fca84521a1ae903c15ef992b@AcuMS.aculab.com>
References: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
In-Reply-To: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=1.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Stern
> Sent: 06 April 2023 22:36
> 
> Paul:
> 
> I just saw that two of the files in tools/memory-model/litmus-tests have
> almost identical names:
> 
> 	Z6.0+pooncelock+pooncelock+pombonce.litmus
> 	Z6.0+pooncelock+poonceLock+pombonce.litmus
> 
> They differ only by a lower-case 'l' vs. a capital 'L'.  It's not at all
> easy to see, and won't play well in case-insensitive filesystems.

Change the 'L' to a '1' - that'll be ok on case-insensitive
filesystems :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

