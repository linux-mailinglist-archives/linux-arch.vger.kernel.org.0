Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B46A86F4
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 17:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCBQkW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 2 Mar 2023 11:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCBQkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 11:40:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2343826B9
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 08:40:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-A5lFE1XCPGKDtKtLTQWNjw-1; Thu, 02 Mar 2023 16:40:02 +0000
X-MC-Unique: A5lFE1XCPGKDtKtLTQWNjw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Thu, 2 Mar
 2023 16:40:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Thu, 2 Mar 2023 16:40:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Matt Evans <mev@rivosinc.com>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] asm-generic: avoid __generic_cmpxchg_local warnings
Thread-Topic: [PATCH] asm-generic: avoid __generic_cmpxchg_local warnings
Thread-Index: AQHZTOV6rBj5Jypz4Uesl5tZ9VpdrK7nsNjg
Date:   Thu, 2 Mar 2023 16:40:00 +0000
Message-ID: <60996fd3604b403ab67e8f73854264ee@AcuMS.aculab.com>
References: <20230302090032.3740505-1-arnd@kernel.org>
In-Reply-To: <20230302090032.3740505-1-arnd@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

...
> I had another look at why the cast is even needed for atomic_cmpxchg(),
> and as Matt describes the problem here is that atomic_t contains a
> signed 'int', but cmpxchg() takes an 'unsigned long' argument, and
> converting between the two leads to a 64-bit sign-extension of
> negative 32-bit atomics.

How about:
	signed_var + 0u + 0ull;

Converts 32bit signed to 64bit unsigned without sign extension.
Compiler will throw it all away if not needed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

