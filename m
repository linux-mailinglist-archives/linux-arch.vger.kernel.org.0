Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347470067C
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjELLQn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 12 May 2023 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjELLQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 07:16:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D46DD9D
        for <linux-arch@vger.kernel.org>; Fri, 12 May 2023 04:16:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-249-VSjj4jpZOom7AJRUgPGuWQ-1; Fri, 12 May 2023 12:16:32 +0100
X-MC-Unique: VSjj4jpZOom7AJRUgPGuWQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 12 May
 2023 12:16:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 12 May 2023 12:16:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Zimmermann' <tzimmermann@suse.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>
CC:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Artur Rojek" <contact@artur-rojek.eu>
Subject: RE: [PATCH v7 1/7] fbdev/hitfb: Cast I/O offset to address
Thread-Topic: [PATCH v7 1/7] fbdev/hitfb: Cast I/O offset to address
Thread-Index: AQHZhLwIoJOHAKlHvkaeoWR92INTOa9We4fw
Date:   Fri, 12 May 2023 11:16:30 +0000
Message-ID: <c25758dd7b4a4563b0d33c751da8cf6d@AcuMS.aculab.com>
References: <20230512102444.5438-1-tzimmermann@suse.de>
 <20230512102444.5438-2-tzimmermann@suse.de>
In-Reply-To: <20230512102444.5438-2-tzimmermann@suse.de>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Zimmermann
> Sent: 12 May 2023 11:25
> 
> Cast I/O offsets to pointers to use them with I/O functions. The I/O
> functions expect pointers of type 'volatile void __iomem *', but the
> offsets are plain integers. Build warnings are
> 
>   ../drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_wait':
>   ../arch/x86/include/asm/hd64461.h:18:33: warning: passing argument 1 of 'fb_readw' makes pointer
> from integer without a cast [-Wint-conversion]
>    18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~
...
>    52 | static inline u16 fb_readw(const volatile void __iomem *addr)
>       |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> 
> This patch only fixes the build warnings. It's not clear if the I/O
> offsets can legally be passed to the I/O helpers. It was apparently
> broken in 2007 when custom inw()/outw() helpers got removed by
> commit 34a780a0afeb ("sh: hp6xx pata_platform support."). Fixing the
> driver would require setting the I/O base address.

Did you try changing the definition of HD64461_IOBASE to include
a (volatile void __iomem *) cast?
A lot less churn...

I'm guessing that 'sh' deosn't have in/out instructions so this
is something that is always mapped at a fixed kernel virtual address?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

