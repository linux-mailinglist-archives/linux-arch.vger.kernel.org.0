Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF45B8571
	for <lists+linux-arch@lfdr.de>; Wed, 14 Sep 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiINJqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 14 Sep 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiINJqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Sep 2022 05:46:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7FC61D8B
        for <linux-arch@vger.kernel.org>; Wed, 14 Sep 2022 02:46:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-97-cVSXdUInMX6xYwzzN9bkjA-1; Wed, 14 Sep 2022 10:46:10 +0100
X-MC-Unique: cVSXdUInMX6xYwzzN9bkjA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 14 Sep
 2022 10:46:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 14 Sep 2022 10:46:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nathan Chancellor' <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 05/15] kbuild: build init/built-in.a just once
Thread-Topic: [PATCH 05/15] kbuild: build init/built-in.a just once
Thread-Index: AQHYx0ts+NPkxXYHC0WeQrq6VU/re63erc0g
Date:   Wed, 14 Sep 2022 09:46:08 +0000
Message-ID: <87548726b6cc4f518836db38d45a04f2@AcuMS.aculab.com>
References: <20220828024003.28873-1-masahiroy@kernel.org>
 <20220828024003.28873-6-masahiroy@kernel.org>
 <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X>
In-Reply-To: <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X>
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

...
> > +VERSION=$(cat .version) 2>/dev/null &&
> > +VERSION=$(expr $VERSION + 1) 2>/dev/null ||
> > +VERSION=1

What's wrong with:
VERSION=$(($(cat .version 2>/dev/null) + 1))

If you are worried about .version not containing a valid
number and $((...)) failing then use ${VERSION:-1} later.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

