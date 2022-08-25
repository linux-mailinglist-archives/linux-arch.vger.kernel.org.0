Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247EF5A1527
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbiHYPEF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 25 Aug 2022 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiHYPDs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 11:03:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85785B7ED2
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 08:03:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-CLGAEFtmMmq-sFQCCbZ85g-1; Thu, 25 Aug 2022 16:03:04 +0100
X-MC-Unique: CLGAEFtmMmq-sFQCCbZ85g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Thu, 25 Aug 2022 16:01:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Thu, 25 Aug 2022 16:01:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joseph Myers' <joseph@codesourcery.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Florian Weimer <fweimer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Zack Weinberg" <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Cyril Hrubis" <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Thread-Topic: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Thread-Index: AQHYuJCLMClw4u4WnUme2jwTdxYRD62/tSSA
Date:   Thu, 25 Aug 2022 15:01:31 +0000
Message-ID: <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
 <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joseph Myers
> Sent: 25 August 2022 15:39
> 
> On Thu, 25 Aug 2022, Linus Torvalds wrote:
> 
> > That's a small detail that yes, we've tried to avoid the absolute
> > humongous mess that the C standard library has with their horrendous
> > 'PRId*' mess, but honestly, it's just a tiny detail.
> 
> I've not yet implemented it for glibc or for GCC format checking, but C23
> adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> with printf to print an int64_t and won't need those PRI macros any more.

Is that meant to work regardless of whether the type is
int, long or long long provided the size is correct?

Or does it require the compiler know which type inttypes.h
uses for uint32_t and uint64_t?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

