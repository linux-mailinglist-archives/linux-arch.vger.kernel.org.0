Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5578FE52
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349751AbjIANdN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 1 Sep 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIANdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 09:33:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B68E77
        for <linux-arch@vger.kernel.org>; Fri,  1 Sep 2023 06:33:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-127-rzP1TfnNM9Kwg3WdJebEew-1; Fri, 01 Sep 2023 14:33:07 +0100
X-MC-Unique: rzP1TfnNM9Kwg3WdJebEew-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Sep
 2023 14:33:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Sep 2023 14:33:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mateusz Guzik' <mjguzik@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Topic: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Index: AQHZ23Vdq8Esj5k0zUGYupOb09r6RrAF7nHA
Date:   Fri, 1 Sep 2023 13:33:03 +0000
Message-ID: <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
In-Reply-To: <20230830140315.2666490-1-mjguzik@gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mateusz Guzik
> Sent: 30 August 2023 15:03
...
> Hand-rolled mov loops executing in this case are quite pessimal compared
> to rep movsq for bigger sizes. While the upper limit depends on uarch,
> everyone is well south of 1KB AFAICS and sizes bigger than that are
> common.

That unrolled loop is pretty pessimal and very much 1980s.

It should be pretty easy to write a code loop that runs
at one copy (8 bytes) per clock on modern desktop x86.
I think that matches 'rep movsq'.
(It will run slower on Atom based cpu.)

A very simple copy loop needs (using negative offsets
from the end of the buffer):
	A memory read
	A memory write
	An increment
	A jnz
Doing all of those every clock is well with the cpu's capabilities.
However I've never managed a 1 clock loop.
So you need to unroll once (and only once) to copy 8 bytes/clock.

So for copies that are multiples of 16 bytes something like:
	# dst in %rdi, src in %rsi, len in %rdx
	add	%rdi, %rdx
	add	%rsi, %rdx
	neg	%rdx
1:
	mov	%rcx,0(%rsi, %rdx)
	mov	0(%rdi, %rdx), %rcx
	add	#16, %rdx
	mov	%rcx, -8(%rsi, %rdx)
	mov	-8(%rdi, %rdx), %rcx
	jnz	1b

Is likely to execute an iteration every two clocks.
The memory read/write all get queued up and will happen at
some point - so memory latency doesn't matter at all.

For copies (over 16 bytes) that aren't multiples of
16 it is probably just worth copying the first 16 bytes
and then doing 16 bytes copies that align with the end
of the buffer - copying some bytes twice.
(Or even copy the last 16 bytes first and copy aligned
with the start.)

I'm also not at all sure how much it is worth optimising
mis-aligned transfers.
An IP-Checksum function (which only does reads) is only
just measurable slower for mis-aligned buffers.
Less than 1 clock per cache line.

I think you can get an idea of what happens from looking
at the PCIe TLP generated for misaligned transfers and
assuming that memory requests get much the same treatment.

Last time I checked (on an i7-7700) misaligned transfers
were done in 8-byte chunks (SSE/AVX) and accesses that
crossed cache-line boundaries split into two.
Since the cpu can issue two reads/clock not all of the
split reads (to cache) will take an extra clock.
(which sort of matches what we see.)
OTOH misaligned writes that cross a cache-line boundary
probably always take a 1 clock penalty.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

