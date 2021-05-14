Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04686380764
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhENKhN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 14 May 2021 06:37:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:40199 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhENKhL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:37:11 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-137-fwXplDQpOp69AZgAtM4owA-1; Fri, 14 May 2021 11:35:55 +0100
X-MC-Unique: fwXplDQpOp69AZgAtM4owA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 14 May 2021 11:35:53 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Fri, 14 May 2021 11:35:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 13/13] asm-generic: simplify asm/unaligned.h
Thread-Topic: [PATCH v2 13/13] asm-generic: simplify asm/unaligned.h
Thread-Index: AQHXSKitCXoL3prwmEWP1GjWUsVA9qrix5rQ
Date:   Fri, 14 May 2021 10:35:52 +0000
Message-ID: <4e815e094eea410e88747a74c81953b1@AcuMS.aculab.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-14-arnd@kernel.org>
In-Reply-To: <20210514100106.3404011-14-arnd@kernel.org>
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

From: Arnd Bergmann
> Sent: 14 May 2021 11:01
> 
> The get_unaligned()/put_unaligned() implementations are much more complex
> than necessary, now that all architectures use the same code.
...
> This new version does allow aggregate types into get_unaligned(), which
> was not the original goal but might come in handy.

Adding '* 1' to the value would stop that and shouldn't add any code.
Although you might want to cast back to the original type to
avoid 'short' being converted to 'int'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

