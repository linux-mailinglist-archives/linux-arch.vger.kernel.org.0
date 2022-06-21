Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E445532DD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349595AbiFUNEM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 21 Jun 2022 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349892AbiFUNEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 09:04:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6F2825296
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 06:04:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-D7su6iPqNO-F5Tx2uXwdog-1; Tue, 21 Jun 2022 14:04:05 +0100
X-MC-Unique: D7su6iPqNO-F5Tx2uXwdog-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 21 Jun 2022 14:04:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 21 Jun 2022 14:04:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Cyril Hrubis' <chrubis@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "zack@owlfolio.org" <zack@owlfolio.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: RE: [PATCH v3] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Thread-Topic: [PATCH v3] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Thread-Index: AQHYhWa4Wwgq8v8s30aZYtCosiJuGq1Z063Q
Date:   Tue, 21 Jun 2022 13:04:04 +0000
Message-ID: <a26ab9bfc27a430bb8a7b6aa2f39d724@AcuMS.aculab.com>
References: <20220621120355.2903-1-chrubis@suse.cz>
In-Reply-To: <20220621120355.2903-1-chrubis@suse.cz>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Cyril Hrubis 
> Sent: 21 June 2022 13:04
> 
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace for C code.
> 
> We cannot make the change for C++ since that would be non-backwards
> compatible change and may cause possible regressions and even
> compilation failures, e.g. overloaded function may no longer find a
> correct match.

Isn't is enough just to mention C++ name mangling?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

