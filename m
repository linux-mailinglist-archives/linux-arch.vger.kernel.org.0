Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527317D39FC
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjJWOph convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 23 Oct 2023 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjJWOpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 10:45:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D082715
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2023 07:44:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258--tpglOZGPGiuWPN3BCowLg-1; Mon, 23 Oct 2023 15:44:14 +0100
X-MC-Unique: -tpglOZGPGiuWPN3BCowLg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 15:44:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 23 Oct 2023 15:44:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AQHaBR+gEduqS7qeiEe28JhvJJTzV7BXcjfw
Date:   Mon, 23 Oct 2023 14:44:13 +0000
Message-ID: <83a6e7e00f824f1daef01ad599aad663@AcuMS.aculab.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
In-Reply-To: <20231022194020.GA972254@ZenIV>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro
> Sent: 22 October 2023 20:40
....
> We need a way for csum_and_copy_{from,to}_user() to report faults.
> The approach taken back in 2020 (avoid 0 as return value by starting
> summing from ~0U, use 0 to report faults) had been broken; it does
> yield the right value modulo 2^16-1, but the case when data is
> entirely zero-filled is not handled right.  It almost works, since
> for most of the codepaths we have a non-zero value added in
> and there 0 is not different from anything divisible by 0xffff.
> However, there are cases (ICMPv4 replies, for example) where we
> are not guaranteed that.
> 
> In other words, we really need to have those primitives return 0
> on filled-with-zeroes input.  So let's make them return a 64bit
> value instead; we can do that cheaply (all supported architectures
> do that via a couple of registers) and we can use that to report
> faults without disturbing the 32bit csum.

Does the ICMPv4 sum need to be zero if all zeros but 0xffff
if there are non-zero bytes in there?

IIRC the original buggy case was fixed by returning 0xffff
for the all-zero buffer.

Even if it does then it would seem more sensible to have the
checksum function never return zero, csum_and_copy() return
zero on fault and add extra code to the (unusual) ICMP reply
code to detect 0xffff and convert to zero if the buffer is
all zeros.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

