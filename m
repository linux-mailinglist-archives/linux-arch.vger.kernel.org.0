Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C26C72DE
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 23:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCWWQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Mar 2023 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCWWQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 18:16:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E307C241CB
        for <linux-arch@vger.kernel.org>; Thu, 23 Mar 2023 15:16:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-j6IE1sL7Moe3xE5Tqe041Q-1; Thu, 23 Mar 2023 22:16:13 +0000
X-MC-Unique: j6IE1sL7Moe3xE5Tqe041Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 23 Mar
 2023 22:16:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 23 Mar 2023 22:16:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Thread-Topic: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Thread-Index: AQHZXMdjsqmkKsLMq0ilztF2kMGJDa8I7Ypw
Date:   Thu, 23 Mar 2023 22:16:12 +0000
Message-ID: <f4d24e8024e84ec5a20ab17b6c2d7f60@AcuMS.aculab.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-2-mark.rutland@arm.com> <ZBnk3O0QLs6+8KNN@arm.com>
 <ZBsLGTYjKoUTLrva@FVFF77S0Q05N>
In-Reply-To: <ZBsLGTYjKoUTLrva@FVFF77S0Q05N>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mark Rutland
> Sent: 22 March 2023 14:05
....
> > IIUC, in such tests you only vary the destination offset. Our copy
> > routines in general try to align the source and leave the destination
> > unaligned for performance. It would be interesting to add some variation
> > on the source offset as well to spot potential issues with that part of
> > the memcpy routines.
> 
> I have that on my TODO list; I had intended to drop that into the
> usercopy_params. The only problem is that the cross product of size,
> src_offset, and dst_offset gets quite large.

I thought that is was better to align the writes and do misaligned reads.
Although maybe copy_to/from_user() would be best aligning the user address
(to avoid page faults part way through a misaligned access).

OTOH, on x86, is it even worth bothering at all.
I have measured a performance drop for misaligned reads, but it
was less than 1 clock per cache line in a test that was doing
2 misaligned reads in at least some of the clock cycles.
I think the memory read path can do two AVX reads each clock.
So doing two misaligned 64bit reads isn't stressing it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

