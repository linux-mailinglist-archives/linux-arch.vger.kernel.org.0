Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03438819F
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhERUvG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 18 May 2021 16:51:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58707 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235204AbhERUvG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:51:06 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-154-NzcuNrSXNs2GIOJ9Fn180Q-1; Tue, 18 May 2021 21:49:35 +0100
X-MC-Unique: NzcuNrSXNs2GIOJ9Fn180Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 21:49:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Tue, 18 May 2021 21:49:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: RE: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
Thread-Topic: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
Thread-Index: AQHXS1wYCu76VfkYCU+t8Sv5x7/YH6rpt7nQ
Date:   Tue, 18 May 2021 20:49:34 +0000
Message-ID: <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-3-arnd@kernel.org>
In-Reply-To: <20210517203343.3941777-3-arnd@kernel.org>
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
> Sent: 17 May 2021 21:34
> 
> The compat move_pages() implementation uses compat_alloc_user_space()
> for converting the pointer array. Moving the compat handling into
> the function itself is a bit simpler and lets us avoid the
> compat_alloc_user_space() call.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/migrate.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..a68d07f19a1a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1855,6 +1855,23 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  	mmap_read_unlock(mm);
>  }
> 
> +static int put_compat_pages_array(const void __user *chunk_pages[],
> +				  const void __user * __user *pages,
> +				  unsigned long chunk_nr)
> +{

Should that be get_compat_pages_array() ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

