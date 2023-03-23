Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175D6C6BE2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 16:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCWPGf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Mar 2023 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCWPGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 11:06:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA580233C6
        for <linux-arch@vger.kernel.org>; Thu, 23 Mar 2023 08:05:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-R2rEoX7jPMafGqBjMLdziw-1; Thu, 23 Mar 2023 15:03:57 +0000
X-MC-Unique: R2rEoX7jPMafGqBjMLdziw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 23 Mar
 2023 15:03:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 23 Mar 2023 15:03:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mel Gorman' <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/10] Fix confusion around MAX_ORDER
Thread-Topic: [PATCH 00/10] Fix confusion around MAX_ORDER
Thread-Index: AQHZXBOmxeBm0+nagESVZv8C8tAqRK8IeMpg
Date:   Thu, 23 Mar 2023 15:03:56 +0000
Message-ID: <54496a4d8b31499993aac50f2979f99a@AcuMS.aculab.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230321163845.qpybxa5rlwclvko2@suse.de>
In-Reply-To: <20230321163845.qpybxa5rlwclvko2@suse.de>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mel Gorman
> Sent: 21 March 2023 16:39
> 
> On Wed, Mar 15, 2023 at 02:31:23PM +0300, Kirill A. Shutemov wrote:
> > MAX_ORDER currently defined as number of orders page allocator supports:
> > user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> >
> > This definition is counter-intuitive and lead to number of bugs all over
> > the kernel.
> >
> > Fix the bugs and then change the definition of MAX_ORDER to be
> > inclusive: the range of orders user can ask from buddy allocator is
> > 0..MAX_ORDER now.
> >
> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Overall looks sane other than the fixups that need to be added as
> flagged by LKP. There is a mild risk for stable backports that reference
> MAX_ORDER but that's the responsibilty of who is doing the backport.
> There is a mild risk of muscle memory adding off-by-one errors for new
> code using MAX_ORDER but it's low.

How many of the places that use MAX_ORDER weren't touched?
Is it actually worth changing the name at the same time.
That will stop stable backport issues.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

