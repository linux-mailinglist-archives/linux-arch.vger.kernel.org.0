Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB007A5BCE
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjISIAm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 19 Sep 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjISIAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 04:00:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16BA102
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 01:00:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-109-scVoAueRPmK64unopgoamQ-1; Tue, 19 Sep 2023 09:00:16 +0100
X-MC-Unique: scVoAueRPmK64unopgoamQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Sep
 2023 09:00:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Sep 2023 09:00:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v6 3/4] riscv: Add checksum library
Thread-Topic: [PATCH v6 3/4] riscv: Add checksum library
Thread-Index: AQHZ5/ZuR2Nhj94ZDEWquHSBL7yNdbAdI/3wgARFmYCAAGOr4A==
Date:   Tue, 19 Sep 2023 08:00:12 +0000
Message-ID: <0fe9694900c7492c96dce6b67710173f@AcuMS.aculab.com>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
 <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
 <0357e092c05043fba13eccad77ba799f@AcuMS.aculab.com> <ZQkOSf1b66lHzjaf@ghost>
In-Reply-To: <ZQkOSf1b66lHzjaf@ghost>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

...
> > So ending up with (something like):
> > 	end = buff + length;
> > 	...
> > 	while (++ptr < end) {
> > 		csum += data;
> > 		carry += csum < data;
> > 		data = ptr[-1];
> > 	}
> > (Although a do-while loop tends to generate better code
> > and gcc will pretty much always make that transformation.)
> >
> > I think that is 4 instructions per word (load, add, cmp+set, add).
> > In principle they could be completely pipelined and all
> > execute (for different loop iterations) in the same clock.
> > (But that is pretty unlikely to happen - even x86 isn't that good.)
> > But taking two clocks is quite plausible.
> > Plus 2 instructions per loop (inc, cmp+jmp).
> > They might execute in parallel, but unrolling once
> > may be required.
> >
> It looks like GCC actually ends up generating 7 total instructions:
> ffffffff808d2acc:	97b6                	add	a5,a5,a3
> ffffffff808d2ace:	00d7b533          	sltu	a0,a5,a3
> ffffffff808d2ad2:	0721                	add	a4,a4,8
> ffffffff808d2ad4:	86be                	mv	a3,a5
> ffffffff808d2ad6:	962a                	add	a2,a2,a0
> ffffffff808d2ad8:	ff873783          	ld	a5,-8(a4)
> ffffffff808d2adc:	feb768e3          	bltu	a4,a1,ffffffff808d2acc <do_csum+0x34>
> 
> This mv instruction could be avoided if the registers were shuffled
> around, but perhaps this way reduces some dependency chains.

gcc managed to do 'data += csum' so had add 'csum = data'.
If you unroll once that might go away.
It might then be 10 instructions for 16 bytes.
Although you then need slightly larger alignment code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

