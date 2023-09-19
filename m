Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398317A6AE9
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjISSw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjISSw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:52:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C189E;
        Tue, 19 Sep 2023 11:52:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A62C433BB;
        Tue, 19 Sep 2023 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695149569;
        bh=iBy2r1Ppb7+LblxwetjPZTCM0xkhLmGsPtEb6rgyHpE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=IT4JlwF0Dq8D0KQoqO5NhUVaofEV6Z8R3Pl3JuDU3nL5Vm8YYjgLvExupodGFIU/e
         Bkczf0k5kW+FwKy8rRRSiOCYIwJZZYjV021ckZZ8ZZYScyibaPTD42HIWrdgg7hK2T
         I/i4ZThhM0w95nYBZU/q5h4Wit28P4y1OboR02wQSEhjvhnaCRPYYuyIOvSJsPFYsv
         TX4SV/bOfAWemh5Bk2K2l6VL5OvCqzoM2GcTzX3W2PLwJ48hTFiZPIu753enMGDGpX
         R9b+d5IKnRnBtgtoDw7SZT5lttzKi18P5edAm61XTD/6axSFGsYM1W2DhuxtfBsnDz
         M/KwBWWAbpDzA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CF0AC27C0069;
        Tue, 19 Sep 2023 14:52:47 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 19 Sep 2023 14:52:47 -0400
X-ME-Sender: <xms:_-0JZRJL7I3mgpeI3-Y6zuO02uYza5n6UOdij-aD9L5A5vutLT8VYg>
    <xme:_-0JZdI-nNGc8eTw6kaaItvNFDDgjcu0cu7DEJNsxaz8nDOom5Lb2XagUkw5FgYYQ
    TgSqzASE8xscHIoaMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:_-0JZZvD75yTMOf7Irofp0KNMyMqlNtlWW4wLjm2ItLJXKMtmaAisQ>
    <xmx:_-0JZSb3mj3IFmGz1Bc8du4JTslWg03aJ6hX018Rkc1vj7lWLZgDMg>
    <xmx:_-0JZYYjU3wPiK72Fz35-4Ufq9VLChmRHCcWfXW9fpW4bDmsOdO0Og>
    <xmx:_-0JZYqwkvZwsoX_ifE5nOL8DZrNwWG-K3zUqC239B2uBxCius-hqw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 47DEF31A0064; Tue, 19 Sep 2023 14:52:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <1b7ea860-55e2-48fb-86ba-ff3f9f6d8904@app.fastmail.com>
In-Reply-To: <ZQnmVI0Q/Al5UKgQ@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net> <ZP2tYY00/q9ElFQn@memverge.com>
 <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
 <ZQnMzD26VI3C/ivf@memverge.com>
 <0a7e3ccc-db66-428e-8c09-66e67bfded51@app.fastmail.com>
 <ZQnmVI0Q/Al5UKgQ@memverge.com>
Date:   Tue, 19 Sep 2023 11:52:27 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Gregory Price" <gregory.price@memverge.com>
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Gregory Price" <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>, linux-cxl@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Tue, Sep 19, 2023, at 11:20 AM, Gregory Price wrote:
> On Tue, Sep 19, 2023 at 10:59:33AM -0700, Andy Lutomirski wrote:
>>=20
>> I'm not complaining about the name.  I'm objecting about the semantic=
s.
>>=20
>> Apparently you have a system to collect usage statistics of physical =
addresses, but you have no idea what those pages map do (without crawlin=
g /proc or /sys, anyway).  But that means you have no idea when the logi=
cal contents of those pages *changes*.  So you fundamentally have a nast=
y race: anything else that swaps or migrates those pages will mess up yo=
ur statistics, and you'll start trying to migrate the wrong thing.
>
> How does this change if I use virtual address based migration?
>
> I could do sampling based on virtual address (page faults, IBS/PEBs,
> whatever), and by the time I make a decision, the kernel could have
> migrated the data or even my task from Node A to Node B.  The sample I
> took is now stale, and I could make a poor migration decision.

The window is a lot narrower. If you=E2=80=99re sampling by VA, you coll=
ect stats and associate them with the logical page (the tuple (mapping, =
VA), for example).  The kernel can do this without races from page fault=
s handlers.  If you sample based on PA, you fundamentally race against a=
nything that does migration.

>
> If I do move_pages(pid, some_virt_addr, some_node) and it migrates the
> page from NodeA to NodeB, then the device-side collection is likewise
> no longer valid.  This problem doesn't change because I used virtual
> address compared to physical address.

Sure it does, as long as you collect those samples when you migrate. And=
 I think the kernel migrating to or from device memory (or more generall=
y allocating and freeing device memory and possibly even regular memory)=
 *should* be aware of whatever hotness statistics are in use.

>
> But if i have a 512GB memory device, and i can see a wide swath of that
> 512GB is hot, while a good chunk of my local DRAM is not - then I
> probably don't care *what* gets migrated up to DRAM, i just care that a
> vast majority of that hot data does.
>
> The goal here isn't 100% precision, you will never get there. The goal
> here is broad-scope performance enhancements of the overall system
> while minimizing the cost to compute the migration actions to be taken.
>
> I don't think the contents of the page are always relevant.  The entire
> concept here is to enable migration without caring about what programs
> are using the memory for - just so long as the memcg's and zoning is
> respected.
>

At the very least I think you need to be aware of page *size*.  And if y=
ou want to avoid excessive fragmentation, you probably also want to be a=
ware of the boundaries of a logical allocation.

I think that doing this entire process by PA, blind, from userspace will=
 end up stuck in a not-so-good solution, and the ABI will be set in ston=
e, and it will not be a great situation for long term maintainability or=
 performance.
