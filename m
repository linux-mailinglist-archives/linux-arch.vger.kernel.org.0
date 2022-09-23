Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1933C5E81DF
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiIWSkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiIWSkg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 14:40:36 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD88A6C28;
        Fri, 23 Sep 2022 11:40:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0EF3A580B86;
        Fri, 23 Sep 2022 14:40:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 14:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663958433; x=1663962033; bh=8bciG4zq3c
        1fgJUXpN6Xfq9ayVFaPQsJlfJ51hqnhag=; b=mu67ZZTY1E4gC5hxnR1tmic3BO
        ZVXCEqwfYme1u37Pje/jqcZ6LktWbkFtLVZtsUJWckNCuUPqUWniIxWGnFZrkYUL
        htd69DHyz8UB3ySN3MBNY7k0KCgdn+35GdkNOV+NxUVgOXlYTiDbSqo3JdeYdfAr
        8FCuxr9qn4bhCauzeek9Xmkct+W2vSau3Ne78lhQIMiEHGxwxRBYpB7RBKb/oL4x
        d0KiEiqGc9YXthq5X6UZ7+kSWWp30viWsA3UaQRPWk6SVtbnm6ySKLk/zSJFlBkE
        cMYRym6QtnleWesctMiSu36e01UGtf/LYTG8dMZ/vYLOWTWk+w6+0xfmNdgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663958433; x=1663962033; bh=8bciG4zq3c1fgJUXpN6Xfq9ayVFa
        PQsJlfJ51hqnhag=; b=BpNX57Z48CaWEz00dPfahZ6syraP4PZdPltC3nWaV6g2
        voFSWSU4ND0nk8HSEvZ0wcfSXKAz1Dymd3n4/IbIBqH7rndUsmCVQrgGkEXaVUdo
        /Jw7y7ki8xmIU5Dlo8I0kMmjH62mRRCrts8pBUbgcP3zz5x0+Mw0cKTxAqGT/1P6
        35HADwMOBJHlwDA2akAvZtFxfJsSQHRXqT7hifoLpoifxVdiML02Ly4COGPi6GDd
        5Cxs7hX0PRcATDOuiO/RKz+hduKXKBtxt8m8KDzqjLCOqRDyaz3Oif7kSczq+AEo
        FspR3U9KyRG/FuQxNoeB5fIDtyqpLZOz/Og5SadSFQ==
X-ME-Sender: <xms:of0tYzae2rnLTD-qLbyPHXGZFC3ko-zoCeoDBTsi8gB4s4PxKf4b5Q>
    <xme:of0tYyb994GU0hI41uH6_jA285Gtd_ak4BGecRZrQDAsK8mQxvaZEK3QaPrTrewDC
    FTKagF4h2WYmoLxBt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:of0tY19Fb253gGbJN2R3j6Y6BWxLaCgUCjr_PA-NpDrMFTSmZIVL_g>
    <xmx:of0tY5pPK5iCiGLFoFtM_tBZmVBMtr9RuErA33ZhMk6e-V7FiHf9JQ>
    <xmx:of0tY-oEMd7ucQkB8vHXIBPRKHRw6IWl3WamWHHcSHKEDPKVJOy-1g>
    <xmx:of0tYyYjb7v5PqJNh8GQ6e8XYw31z5T__ZeBcbx9n9ydY_WF32Kufg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1F141B60086; Fri, 23 Sep 2022 14:40:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <b7379459-989f-446d-9d1d-b381a8550de1@www.fastmail.com>
In-Reply-To: <PH0PR12MB548166865BF446C7F232DCE1DC519@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
 <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
 <PH0PR12MB548113D13F9E9CE4D5206514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ae25893-f19f-4186-a19a-7fc55d9295ed@www.fastmail.com>
 <PH0PR12MB548166865BF446C7F232DCE1DC519@PH0PR12MB5481.namprd12.prod.outlook.com>
Date:   Fri, 23 Sep 2022 20:40:12 +0200
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

On Fri, Sep 23, 2022, at 5:55 PM, Parav Pandit wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Sent: Friday, September 16, 2022 12:09 AM

>> > And I sort of see above pattern in two drivers, and it is not good.
>> > It ends up doing dsb(st) on arm64, while needed barrier is only
>> > dmb(oshst).
>> >
>> > So to fix those two drivers, it is better to first avoid wmb()
>> > documentation reference when referring to writel().
>> 
>> Yes, this suggestion is correct. On x86 and a few others, I think it's even
>> worse when wmb() is an expensive barrier, while writel() is the same as
>> writel_relaxed() and the barrier is implied by the MMIO access.
>> 
>> It might help to spell this out and say that writel() is always preferred over
>> wmb()+writel_relaxed().
>> 
> True.
>
>> Site note: there are several other problems with wmb()+__raw_writel(),
>> which on many architectures does not guarantee any atomicity of the access
>> (a word store could get split into four byte stores), breaks endianess
>> assumptions and may still not provide the correct barrier semantics.
>>
> Hmm. So far didn't observe this on arm64, x86_64, ppc64 yet.
> May be because the address is aligned to 8 bytes, we don't see the byte stores?

It's complicated. On some architectures (but not the ones you list),
__raw_writel() is a pointer dereference, so the compiler is allowed
to use whichever instruction it wants. Depending on the CPU it
is building for, gcc can decide to split up those stores when it
sees a pointer that was assigned from pointer with lesser alignment
(which is undefined behavior in C). If the pointer is actually
unaligned but gcc does not see this, then powerpc and arm will
trigger an alignment exception for an MMIO location even on CPUs
that can work with unaligned data on normal RAM.

> mlx5_write64() variant to use writeX() and avoid wmb() post the 
> documentation update is good start.

Ok, fair enough, as long as the loop function is not timing
critical itself.

    Arnd
