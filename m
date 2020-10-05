Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207528322A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 10:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJEIg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 5 Oct 2020 04:36:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25968 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgJEIg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 04:36:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-gvT30tU6O0i1Mz5IyqnV4A-1; Mon, 05 Oct 2020 09:36:52 +0100
X-MC-Unique: gvT30tU6O0i1Mz5IyqnV4A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 5 Oct 2020 09:36:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 5 Oct 2020 09:36:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'paulmck@kernel.org'" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: Litmus test for question from Al Viro
Thread-Topic: Litmus test for question from Al Viro
Thread-Index: AQHWmqaOWthdViPieEmyGwyo/H2Pw6mIrfkA
Date:   Mon, 5 Oct 2020 08:36:51 +0000
Message-ID: <5cf6b793978e4cd8ae10344336c13adb@AcuMS.aculab.com>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
In-Reply-To: <20201004233146.GP29330@paulmck-ThinkPad-P72>
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

From: Paul E. McKenney
> Sent: 05 October 2020 00:32
...
>     manual/kernel: Add a litmus test with a hidden dependency
> 
>     This commit adds a litmus test that has a data dependency that can be
>     hidden by control flow.  In this test, both the taken and the not-taken
>     branches of an "if" statement must be accounted for in order to properly
>     analyze the litmus test.  But herd7 looks only at individual executions
>     in isolation, so fails to see the dependency.
> 
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/manual/kernel/crypto-control-data.litmus b/manual/kernel/crypto-control-data.litmus
> new file mode 100644
> index 0000000..6baecf9
> --- /dev/null
> +++ b/manual/kernel/crypto-control-data.litmus
> @@ -0,0 +1,31 @@
> +C crypto-control-data
> +(*
> + * LB plus crypto-control-data plus data
> + *
> + * Result: Sometimes
> + *
> + * This is an example of OOTA and we would like it to be forbidden.
> + * The WRITE_ONCE in P0 is both data-dependent and (at the hardware level)
> + * control-dependent on the preceding READ_ONCE.  But the dependencies are
> + * hidden by the form of the conditional control construct, hence the
> + * name "crypto-control-data".  The memory model doesn't recognize them.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r1;
> +
> +	r1 = 1;
> +	if (READ_ONCE(*x) == 0)
> +		r1 = 0;
> +	WRITE_ONCE(*y, r1);
> +}

Hmmm.... the compiler will semi-randomly transform that to/from:
	if (READ_ONCE(*x) == 0)
		r1 = 0;
	else
		r1 = 1;
and
	r1 = READ_ONCE(*x) != 0;

Both of which (probably) get correctly detected as a write to *y
that is dependant on *x - so is 'problematic' with P1() which
does the opposite assignment.

Which does rather imply that hurd is a bit broken.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

