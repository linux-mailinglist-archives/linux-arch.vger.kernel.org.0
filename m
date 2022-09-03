Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B385ABEC8
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiICLlm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiICLll (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 07:41:41 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB453D25;
        Sat,  3 Sep 2022 04:41:39 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [IPv6:2a09:80c0:254::14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 5E3C04D;
        Sat,  3 Sep 2022 13:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1662205296;
        bh=WTHSGOgXdL1ETWQB4FmjCtq7b8+QUK7FV8+8M7WsAaQ=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=AS887YsN6S7/Ti227pObQKvjit4dHOmfKaqtPMo4KgKboWFSGMTcIVOUEXtJ/tTF1
         VvtJh114tguB3szieJipx4Z7tDowAjax3P1C7ZbOssuI5sIGreIToLeQjtdikoqRNM
         /mp83GZfkyzbLeLU+32HkyKZUUQ3f/dFkrOgVqUcQqKwS4qnZy4X0+oRLjOxCjjFRK
         Jp3ca3wja9qNgMCSfyPJbrZRpIJZcK6HVwUzQ/Rfkjoj9QN33hdl+6QJNkQ5OcqEJg
         ZSnTVMwSc/qka9HJLbdVzZtOIzMnpvet2VjbvMjrv+QaaCY2lURJA3kDBOOajXprnk
         WBhB5yjM0LlIQ==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 586EF1ADC; Sat,  3 Sep 2022 13:41:36 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id 2BBBD1ADB;
        Sat,  3 Sep 2022 13:41:36 +0200 (CEST)
Received: from mail.in.tum.de (mailproxy.in.tum.de [IPv6:2a09:80c0::78])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id 275D11AD9;
        Sat,  3 Sep 2022 13:41:36 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id 23B3C4A01E6; Sat,  3 Sep 2022 13:41:36 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 4B57F4A01CD;
        Sat,  3 Sep 2022 13:41:35 +0200 (CEST)
        (Extended-Queue-bit xtech_yq@fff.in.tum.de)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v3] tools/memory-model: Weaken ctrl dependency definition
 in explanation.txt
From:   =?utf-8?Q?Paul_Heidekr=C3=BCger?= <Paul.Heidekrueger@in.tum.de>
In-Reply-To: <YxKtmk2q8Uzb+Qk9@rowland.harvard.edu>
Date:   Sat, 3 Sep 2022 13:41:34 +0200
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7E3D42D-2ABE-4D16-9DCA-0605F0C84F7D@in.tum.de>
References: <20220902211341.2585133-1-paul.heidekrueger@in.tum.de>
 <YxKtmk2q8Uzb+Qk9@rowland.harvard.edu>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3. Sep 2022, at 03:27, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, Sep 02, 2022 at 09:13:40PM +0000, Paul Heidekr=C3=BCger wrote:
>> The current informal control dependency definition in explanation.txt =
is
>> too broad and, as discussed, needs to be updated.
>>=20
>> Consider the following example:
>>=20
>>> if(READ_ONCE(x))
>>>  return 42;
>>>=20
>>> WRITE_ONCE(y, 42);
>>>=20
>>> return 21;
>>=20
>> The read event determines whether the write event will be executed =
"at all"
>> - as per the current definition - but the formal LKMM does not =
recognize
>> this as a control dependency.
>>=20
>> Introduce a new definition which includes the requirement for the =
second
>> memory access event to syntactically lie within the arm of a non-loop
>> conditional.
>>=20
>> Link: =
https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.=
tum.de/
>> Cc: Marco Elver <elver@google.com>
>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
>> Cc: Martin Fink <martin.fink@in.tum.de>
>> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@in.tum.de>
>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>=20
>> ---
>>=20
>> v3:
>> - Address Alan and Joel's feedback re: the wording around switch =
statements
>> and the use of "guarding"
>>=20
>> v2:
>> - Fix typos
>> - Fix indentation of code snippet
>>=20
>> v1:
>> @Alan, since I got it wrong the last time, I'm adding you as a =
co-developer
>> after my SOB. I'm sorry if this creates extra work on your side due =
to you
>> having to resubmit the patch now with your SOB if I understand =
correctly,
>> but since it's based on your wording from the other thread, I =
definitely
>> wanted to give you credit.
>>=20
>> tools/memory-model/Documentation/explanation.txt | 8 +++++---
>> 1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tools/memory-model/Documentation/explanation.txt =
b/tools/memory-model/Documentation/explanation.txt
>> index ee819a402b69..0b7e1925a673 100644
>> --- a/tools/memory-model/Documentation/explanation.txt
>> +++ b/tools/memory-model/Documentation/explanation.txt
>> @@ -464,9 +464,11 @@ to address dependencies, since the address of a =
location accessed
>> through a pointer will depend on the value read earlier from that
>> pointer.
>>=20
>> -Finally, a read event and another memory access event are linked by =
a
>> -control dependency if the value obtained by the read affects whether
>> -the second event is executed at all.  Simple example:
>> +Finally, a read event X and another memory access event Y are linked =
by
>> +a control dependency if Y syntactically lies within an arm of an if
>> +statement and X affects the evaluation of the if condition via a =
data or
>> +address dependency (or similarly for a switch statement).  Simple
>> +example:
>>=20
>> 	int x, y;

Hang on, shouldn't this read "a write event" instead of "another memory
access event"? Control dependencies only provide ordering from READ_ONCE =
to
WRITE_ONCE, not from READ_ONCE to (READ | WRITE)_ONCE?

Or am I missing something?

Many thanks,
Paul=
