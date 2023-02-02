Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756168781E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 10:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBBJBv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 2 Feb 2023 04:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjBBJBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 04:01:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B154550
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 01:01:38 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-190-XaP5QKFjNy-qcXJueChPsA-1; Thu, 02 Feb 2023 09:01:36 +0000
X-MC-Unique: XaP5QKFjNy-qcXJueChPsA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Thu, 2 Feb
 2023 09:01:34 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Thu, 2 Feb 2023 09:01:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Huacai Chen' <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] LoongArch: Make -mstrict-align be configurable
Thread-Topic: [PATCH] LoongArch: Make -mstrict-align be configurable
Thread-Index: AQHZNuKTZOpLs+GXMEuRBwFbIvBWLq67WwCQ
Date:   Thu, 2 Feb 2023 09:01:34 +0000
Message-ID: <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
In-Reply-To: <20230202084238.2408516-1-chenhuacai@loongson.cn>
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

From: Huacai Chen
> Sent: 02 February 2023 08:43
> 
> Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
> configurable.
> 
> Not all LoongArch cores support h/w unaligned access, we can use the
> -mstrict-align build parameter to prevent unaligned accesses.
> 
> This option is disabled by default to optimise for performance, but you
> can enabled it manually if you want to run kernel on systems without h/w
> unaligned access support.

Should there be an associated run-time check during kernel initialisation
that a kernel compiled without -mstrict-align isn't being run on hardware
that doesn't support unaligned accesses.

It can be quite a while before you get a compiler-generated misaligned accesses.

Also isn't there a HAVE_EFFICIENT_MISALIGNED_ACCESS define that would
also need to be set correctly??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

