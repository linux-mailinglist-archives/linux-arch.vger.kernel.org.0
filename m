Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C45BA0E0
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIOSjY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIOSjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 14:39:23 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5C7F243;
        Thu, 15 Sep 2022 11:39:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6FC53582BAA;
        Thu, 15 Sep 2022 14:39:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 14:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663267159; x=1663270759; bh=/qz79ubCdt
        KIST5lhOuXCtQIvy0UAiNX+9E0PnaaNJE=; b=NMqg4bP1yppyHWdpJW1co5WEet
        9obyvAlpjzjYYXmI70xf2e02dfQrqAeQPjQhqJr73vYYWRa3LWrhwXbIO217G+ok
        kQgU5EB/W+ePWMnU1oFlnE/TvdmqdKlutWjt6OGGLPw0vxBBNGXkKBw3gI4p3oZ9
        aVAObKYqqSf9cdK221YUDiqNtrXMkc5Hh2Otw3HnEbOHn2C1t0ls60lhyK9ZcIUm
        dySqs2KSb+IeNZPQ7O0QOVEWvU3N2OGGbQnYoSg7lRUy02AaYho7EeD1HXQDXB9Z
        LBul2zX/zcDNd6nmWwdfwHKcZPmATWFSXwQKcVsVwTHDqIqHjbj/AuSb1SAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663267159; x=1663270759; bh=/qz79ubCdtKIST5lhOuXCtQIvy0U
        AiNX+9E0PnaaNJE=; b=K+UQdiZhlxO8OIRPqQggqf+Fb6gZ+Pm97ZSlxyXpaNHk
        ds8g3CLztD5AoomVb644/092xGiOVfh9wGAhlczf3JUm9pGp/tqjyTnlUrx/HeUg
        eidyisuWkogTVARTENcyvJ5NHsgvSnDnSHPSNK/loA8H/7xPKy1OaVatCxhuHUza
        ivqRylS9Zw/P3lLa6sg2t3hhp+mf22UOirgwdvSxV5fI6Y7pukrtZFnWQzctvkHN
        PeX4Srw8aR+1d4Tvzmpz2E1jU4Zw6Tgw3QGa6826+FxQ14ErP2vTjKJqF2haCZeI
        6lqhBwwnftNWASSrjwsDNeoBdIbRF4/TLRm5mIno3Q==
X-ME-Sender: <xms:VnEjYwJGuoQgY26lLCXhny8OemwxhHrhVy8KP1ECbqVpQAqnei-1Sw>
    <xme:VnEjYwK3A2yDTt1FLujp1j0Z6mMP5GeXJc2pl52A67cmN1vOfHqIaznD71EK4rm8c
    ba3nCXTaI99egZhR_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VnEjYwsQOb32ijjg5TjgD2RjhndMpxn-70aTRrN_G2phc4on7_IgQQ>
    <xmx:VnEjY9YivW7ONwGMfU45PKbE-ylR3T2HyGjbyqg66BOAw3dl0nf5EA>
    <xmx:VnEjY3bdXwEn_lb2pmGwV72JUgQVZrrvdJNolJXgeOFOqaH-5g3EeA>
    <xmx:V3EjY4LLtlrQhhHSmIA63szUe_1idsiO7RELN_6_vpeHphMqUMRn_w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B2B51B60089; Thu, 15 Sep 2022 14:39:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <9ae25893-f19f-4186-a19a-7fc55d9295ed@www.fastmail.com>
In-Reply-To: <PH0PR12MB548113D13F9E9CE4D5206514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
 <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
 <PH0PR12MB548113D13F9E9CE4D5206514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
Date:   Thu, 15 Sep 2022 20:38:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Parav Pandit" <parav@nvidia.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "Dan Lustig" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] locking/memory-barriers.txt: Improve documentation for writel()
 usage
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 15, 2022, at 6:35 PM, Parav Pandit wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Sent: Thursday, September 15, 2022 11:16 AM
>> On Thu, Sep 15, 2022, at 4:18 PM, Parav Pandit wrote:
>> >
>> > So more accurate documentation is to say that 'when using writel() a
>> > prior IO barrier is not needed ...'
>> >
>> > How about that?
>> 
>> That's probably fine, not sure if it's worth changing.
>>
> I think it is worth because current documentation, indirectly (or 
> incorrectly) indicate that 
> "writel() does wmb() internally, so those drivers, who has difficulty 
> in using writel() can do, wmb() + raw write".

I don't think it's wrong from a barrier perspective though:
if a driver uses writel_relaxed(), then the only way to guarantee
ordering is to have a full wmb() before it.

> And I sort of see above pattern in two drivers, and it is not good.
> It ends up doing dsb(st) on arm64, while needed barrier is only 
> dmb(oshst).
>
> So to fix those two drivers, it is better to first avoid wmb() 
> documentation reference when referring to writel().

Yes, this suggestion is correct. On x86 and a few others, I think
it's even worse when wmb() is an expensive barrier, while writel()
is the same as writel_relaxed() and the barrier is implied by the
MMIO access.

It might help to spell this out and say that writel() is always
preferred over wmb()+writel_relaxed().

Site note: there are several other problems with wmb()+__raw_writel(),
which on many architectures does not guarantee any atomicity of
the access (a word store could get split into four byte stores),
breaks endianess assumptions and may still not provide the correct
barrier semantics.

>> I see that there is more going on with that function, at least the loop in
>> post_send_nop() probably just wants to use __iowrite64_copy(), but that
>> also has no barrier in it, while changing mlx5_write64() to use iowrite64be()
>> or similar would of course add excessive barriers inside of the loop.
>
> True. All other conversion seems possible.
> For post_send_nop(), __iowmb() needs to be exposed, which is not 
> available today and it is only one-off user,
> I am inclined to keep post_send_nop()  as-is, but want to 
> improve/correct rest of the callers in these two drivers.

__iowmb() is architecture-specific and does not have a well-defined
behavior. wmb() is probably the best choice for post_send_nop().
Alternatively, one could use __iowrite64_copy() for the first few
fields followed by a single writel64be for the last one.

If you think we need something better than that, maybe having
an iowrite64_copy() (without leading __) that includes a barrier
would work.

     Arnd
