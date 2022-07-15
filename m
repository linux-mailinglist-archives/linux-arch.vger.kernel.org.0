Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E11576144
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiGOM1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOM1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 08:27:34 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C3820D1;
        Fri, 15 Jul 2022 05:27:33 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 6FD8F98;
        Fri, 15 Jul 2022 14:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1657888050;
        bh=zGE/jDIo1cfQsc+MnjdwsHIGgAF/4RlBe+yR6eNgnes=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=Ry/i9d/zyiTV+xWdRYvKVN/SbuXo5p5zNUtP2m5Y8UgSv5RQQydATc1Paj2mXm2r4
         hphlL3ROKc3e2BtI/OO2ZbCQKKLOzjKOQ62oSrq3PTMKIdB8D3SD2BV/aPonr531i3
         1YGQoZpNQqVXnlKQ0rexqAUQUH61WXoPOce1qJpBcnrycK8PSoD5k8BAB81YOq+GKT
         MxV4uJhGqbHNvANs1HSE6pS/POjflssPArH4K9ALazQs1FFwnrVhI7rx6q5Pw1hO2N
         qHTfUmvDgXZzei3loZ6anYsqkJBH2Etf2xbhARMR3W0blbU71woE8jtsDdXJ4M33V+
         5nuy5w85gsfCA==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 6E438DD0; Fri, 15 Jul 2022 14:27:30 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 404A4DCD;
        Fri, 15 Jul 2022 14:27:30 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 3B74B5B5;
        Fri, 15 Jul 2022 14:27:30 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 355A54A0215; Fri, 15 Jul 2022 14:27:30 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 3B3BB4A0129;
        Fri, 15 Jul 2022 14:27:29 +0200 (CEST)
        (Extended-Queue-bit xtech_mr@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <YrnFCSjESpeQdciv@rowland.harvard.edu>
Date:   Fri, 15 Jul 2022 14:27:28 +0200
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
 <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
 <YrnFCSjESpeQdciv@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, Jun 27, 2022 at 11:47:43AM +0200, Paul Heidekr=C3=BCger wrote:
>>> On 21. Jun 2022, at 16:24, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>>>=20
>>> On Tue, Jun 21, 2022 at 01:59:27PM +0200, Paul Heidekr=C3=BCger =
wrote:
>>>> OK. So, LKMM limits the scope of control dependencies to its =
arm(s), hence
>>>> there is a control dependency from the last READ_ONCE() before the =
loop
>>>> exists to the WRITE_ONCE().
>>>>=20
>>>> But then what about the following:
>>>>=20
>>>>> int *x, *y;
>>>>>=20
>>>>> int foo()
>>>>> {
>>>>> 	/* More code */
>>>>>=20
>>>>> 	if(READ_ONCE(x))
>>>>> 		return 42;
>>>>>=20
>>>>> 	/* More code */
>>>>>=20
>>>>> 	WRITE_ONCE(y, 42);
>>>>>=20
>>>>> 	/* More code */
>>>>>=20
>>>>> 	return 0;
>>>>> }
>>>>=20
>>>> The READ_ONCE() determines whether the WRITE_ONCE() will be =
executed at all,
>>>> but the WRITE_ONCE() doesn't lie in the if condition's arm.
>>>=20
>>> So in this case the LKMM would not recognize that there's a control=20=

>>> dependency, even though it clearly exists.
>>=20
>> Oh, that's unfortunate.
>>=20
>> Then I would still argue that the "at all" definition is misleading. =
This
>=20
> I agree, and I would welcome a patch improving the definition. Perhaps=20=

> something along the lines of what I wrote earlier in this email =
thread.

I have just been thinking about how to word this patch; am I correct in
assuming that the LKMM does not deal with loop conditions? Or in other
words, there is no way for a loop condition to impose a ctrl dependency =
on
any WRITE_ONCE's in the loop body? It are only if and switch statements =
the
LKMM is concerned with in the case of ctrl dependencies?

Many thanks,
Paul

>> time in the other direction as I had initially proposed though, as =
the above
>> example is a case where "at all" holds true, but LKMM doesn't cover =
it. Or
>> do you think that caveating this in litmus-tests.txt, e.g. via the =
patch we
>> had recently worked out [1], is enough?
>=20
> No, the explanation should be improved.
>=20
> Alan


