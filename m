Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CB75FAA8
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jul 2023 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGXPVr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jul 2023 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGXPVr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2023 11:21:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B331993
        for <linux-arch@vger.kernel.org>; Mon, 24 Jul 2023 08:21:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-YddD4a0QMAeEa0RPH5axFw-1; Mon, 24 Jul 2023 16:21:35 +0100
X-MC-Unique: YddD4a0QMAeEa0RPH5axFw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 24 Jul
 2023 16:21:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 24 Jul 2023 16:21:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 01/38] minmax: Add in_range() macro
Thread-Topic: [PATCH v5 01/38] minmax: Add in_range() macro
Thread-Index: AQHZs4Qv/1fQZPDRnUKleGkrGqhqrK/JG+mA
Date:   Mon, 24 Jul 2023 15:21:35 +0000
Message-ID: <b289de3f739948b7915444ea8e01fdc6@AcuMS.aculab.com>
References: <20230710204339.3554919-1-willy@infradead.org>
        <20230710204339.3554919-2-willy@infradead.org>
 <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
In-Reply-To: <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andrew Morton
> Sent: 11 July 2023 00:14
> To: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-arch@vger.kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
> 
> On Mon, 10 Jul 2023 21:43:02 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Determine if a value lies within a range more efficiently (subtraction +
> > comparison vs two comparisons and an AND).  It also has useful (under
> > some circumstances) behaviour if the range exceeds the maximum value of
> > the type.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -158,6 +158,32 @@
> >   */
> >  #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
> >
> > +static inline bool in_range64(u64 val, u64 start, u64 len)
> > +{
> > +	return (val - start) < len;
> > +}
> > +
> > +static inline bool in_range32(u32 val, u32 start, u32 len)
> > +{
> > +	return (val - start) < len;
> > +}
> > +
> > +/**
> > + * in_range - Determine if a value lies within a range.
> > + * @val: Value to test.
> > + * @start: First value in range.
> > + * @len: Number of values in range.
> > + *
> > + * This is more efficient than "if (start <= val && val < (start + len))".
> > + * It also gives a different answer if @start + @len overflows the size of
> > + * the type by a sufficient amount to encompass @val.  Decide for yourself
> > + * which behaviour you want, or prove that start + len never overflow.
> > + * Do not blindly replace one form with the other.
> > + */
> > +#define in_range(val, start, len)					\
> > +	sizeof(start) <= sizeof(u32) ? in_range32(val, start, len) :	\
> > +		in_range64(val, start, len)
> 
> There's nothing here to prevent callers from passing a mixture of
> 32-bit and 64-bit values, possibly resulting in truncation of `val' or
> `len'.
> 
> Obviously caller is being dumb, but I think it's cost-free to check all
> three of the arguments for 64-bitness?
> 
> Or do a min()/max()-style check for consistently typed arguments?

Just use integer promotions to extend everything to 'unsigned long long'.

#define in_range(val, start, len) ((val) + 0ull - (start)) < (len))

If all the values are unsigned 32bit the compiler will discard
all the zero extensions.

If values might be signed types (with non-negative values)
you might want to do explicit ((xxx) + 0u + 0ul + 0ull) to avoid
any potentially expensive sign extensions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

