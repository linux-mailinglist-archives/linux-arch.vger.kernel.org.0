Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10367379C8
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfFFQe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 6 Jun 2019 12:34:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58934 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfFFQe5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2019 12:34:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-wSjFIz9gN-O0BTNia_e76w-1; Thu, 06 Jun 2019 17:34:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 6 Jun 2019 17:34:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 6 Jun 2019 17:34:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'paulmck@linux.ibm.com'" <paulmck@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: single copy atomicity for double load/stores on 32-bit systems
Thread-Topic: single copy atomicity for double load/stores on 32-bit systems
Thread-Index: AQHVHExZF0f//oAV60q3cSBNG5qc66aO0bMg
Date:   Thu, 6 Jun 2019 16:34:52 +0000
Message-ID: <8d1666df180d4d01aaebb5d41370b338@AcuMS.aculab.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
 <CAMuHMdW-8Jt80mSyHTYmj6354-3f1=Vp_8dY-Nite1ERpUCFew@mail.gmail.com>
 <20190606094340.GD28207@linux.ibm.com>
In-Reply-To: <20190606094340.GD28207@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: wSjFIz9gN-O0BTNia_e76w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Paul E. McKenney
> Sent: 06 June 2019 10:44
...
> But m68k is !SMP-only, correct?  If so, the only issues would be
> interactions with interrupt handlers and the like, and doesn't current
> m68k hardware use exact interrupts?  Or is it still possible to interrupt
> an m68k in the middle of an instruction like it was in the bad old days?

Hardware interrupts were always on instruction boundaries, the
mid-instruction interrupts would only happen for page faults (etc).

There were SMP m68k systems (but I can't remember one).
It was important to continue from a mid-instruction trap on the
same cpu - unless you could guarantee that all the cpus had
exactly the same version of the microcode.

In any case you could probably use the 'cmp2' instruction
for an atomic 64bit write.
OTOH setting that up was such a PITA it was always easier
to disable interrupts.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

