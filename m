Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D13577D6D
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jul 2022 10:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGRIY2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jul 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGRIY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2022 04:24:27 -0400
Received: from mailout2.rbg.tum.de (mailout2.rbg.tum.de [IPv6:2a09:80c0::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FEFD30;
        Mon, 18 Jul 2022 01:24:23 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout2.rbg.tum.de (Postfix) with ESMTPS id 5F1D04C0202;
        Mon, 18 Jul 2022 10:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1658132660;
        bh=vCBvfh0xbfQFSxwOO2I6Ian7DC2jft0gxceubyH4xek=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=QxQOqVW6zrpLESeYIvT8L2CmybEel0CkvWxCu0VVS4PqP8b+s7aDBSS+gm3GoJt3P
         okoGCqNqAUS6YQYxw+q1Ju4sQLNthoece2QiqNXMgX741SZT26ZNE8f0fORGdAsLaA
         qXo505p0/KGRkHfPGVq/5V0oluoz/JZIxsTSJgm3OYjZNyNNENODnTVc4P6RvwyfGP
         KUFgynxVwlEPX3EQ3Vh97lh1c/a/KM70OQXk3vh+/Uyn8IA7EyLNPnNpaNkPpQQisl
         MXAZQYACweHX3ky4lWyHUsKAjY2a1pd7zCXhyVnMNPpGwyThdmnbN+1QEAt0IxjKH1
         09BZlKtmui60g==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 5AE2DDD0; Mon, 18 Jul 2022 10:24:20 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 37EAADCD;
        Mon, 18 Jul 2022 10:24:20 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 321275B5;
        Mon, 18 Jul 2022 10:24:20 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 2E9144A04E5; Mon, 18 Jul 2022 10:24:20 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 8BD214A038D;
        Mon, 18 Jul 2022 10:24:19 +0200 (CEST)
        (Extended-Queue-bit xtech_fm@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <20220715152145.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 18 Jul 2022 10:24:19 +0200
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
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
Message-Id: <BD651F14-7C88-4553-A4E8-986042271CAD@in.tum.de>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
 <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
 <YrnFCSjESpeQdciv@rowland.harvard.edu>
 <20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de>
 <YtFrPoOARrL/etBu@rowland.harvard.edu>
 <20220715152145.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Paul E. McKenney <paulmck@kernel.org> wrote:

> On Fri, Jul 15, 2022 at 09:27:26AM -0400, Alan Stern wrote:
>> On Fri, Jul 15, 2022 at 02:27:28PM +0200, Paul Heidekr=C3=BCger =
wrote:
>>> I have just been thinking about how to word this patch; am I correct =
in
>>> assuming that the LKMM does not deal with loop conditions? Or in =
other
>>> words, there is no way for a loop condition to impose a ctrl =
dependency on
>>> any WRITE_ONCE's in the loop body? It are only if and switch =
statements the
>>> LKMM is concerned with in the case of ctrl dependencies?
>>=20
>> In theory, the LKMM does say that a loop condition imposes a control=20=

>> dependency on any memory accesses within the loop body.  However, the=20=

>> herd7 tool has only very limited support for looping constructs, so =
in=20
>> practice it's not possible to create suitable litmus tests with =
loops.
>=20
> And Alan isn't joking.  The closest simulation that I know of is to
> combine limited loop unrolling with the "filter" clause.  The point of
> the filter clause is to eliminate from consideration executions that
> need the more iterations of the loop to be unrolled.
>=20
> And that means that as far as LKMM is concerned, loop-based control
> dependencies are similar to those for nested "if" statements.
>=20
> 							Thanx, Paul

Makes sense, thank you both!

Paul=
