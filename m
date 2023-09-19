Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06E7A57EE
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 05:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjISDeu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjISDes (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 23:34:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DD10F
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 20:34:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5A2C433C7;
        Tue, 19 Sep 2023 03:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695094481;
        bh=Ug61tlaIf3jVwA+vuMnvL9oytVI52HzVDJSVhgg7OYE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Qaw8yAVj8cLkKsMPLP7fny4VqkAg5grjFnB9YpWoRcNPxzYKoAQ5MJJx4F69Jfsb5
         6FyFm/uEgwZePXB7N9WguLUw7BEzn0zVJa3xCLhrakOPQwQFgF9aCfcjWLIUCgMTmL
         v9U31aPmq7YvUGwX0kcm76/k4lW0wAUrXnA8F8xd1lYI+/wBCDl/+6JQF5y23uzvwd
         JoX5KBsgic+cvfSbxxLZAQzWEJZ5wGvggZ0X+2tD5sCuZTINUgg7CU7n98m6XPVNY7
         a8FKIBGnqXukjujv3s+62Qj1AjEXQgQjN6nlgg4st+k9PBqeN3XRtKjsclXGAoqfEu
         ZAMK/6a21jL0g==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7C30D27C005A;
        Mon, 18 Sep 2023 23:34:39 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 18 Sep 2023 23:34:39 -0400
X-ME-Sender: <xms:zhYJZbtRN3P0YpzdZN2PAhUKSqW2llZg8auqyWkazTyWat4G7ZoFvA>
    <xme:zhYJZcfqVYwNZwMlpWG3h_kPQTGOns4qorKI-zZRrjJnFcD6WyiQe2xIX3YFtZltG
    iLVxmz2Q8ayEIDC1UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:zhYJZewYWOrvV3YSwyPJzaN7sTaWYkUncX1xQE30PLn28Of6UBCMDg>
    <xmx:zhYJZaMQWtTZunZtfYafBiwSPHE2J2I3bPCmBq6jiPCG4t0oZCL89Q>
    <xmx:zhYJZb9L00FaJeaHDNwAHc1w4gg7AccRkI2PHihGUXcQLmbxVZ8nQg>
    <xmx:zxYJZRdyxh_EWLvd-3hzhKteA9DSO7hunxG5zEYS6gloHfJ12GUMpg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 41EA631A0064; Mon, 18 Sep 2023 23:34:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
In-Reply-To: <ZP2tYY00/q9ElFQn@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net> <ZP2tYY00/q9ElFQn@memverge.com>
Date:   Mon, 18 Sep 2023 20:34:16 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Gregory Price" <gregory.price@memverge.com>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sun, Sep 10, 2023, at 4:49 AM, Gregory Price wrote:
> On Sun, Sep 10, 2023 at 02:36:40PM -0600, Jonathan Corbet wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>>=20
>> > Similar to the move_pages system call, instead of taking a pid and
>> > list of virtual addresses, this system call takes a list of physical
>> > addresses.
>> >
>> > Because there is no task to validate the memory policy against, each
>> > page needs to be interrogated to determine whether the migration is
>> > valid, and all tasks that map it need to be interrogated.
>> >
>> > This is accomplished via an rmap_walk on the folio containing
>> > the page, and interrogating all tasks that map the page.
>> >
>> > Each page must be interrogated individually, which should be
>> > considered when using this to migrate shared regions.
>> >
>> > The remaining logic is the same as the move_pages syscall. One
>> > change to do_pages_move is made (to check whether an mm_struct is
>> > passed) in order to re-use the existing migration code.
>> >
>> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
>> > ---
>> >  arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
>> >  arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
>> >  include/linux/syscalls.h                |   5 +
>> >  include/uapi/asm-generic/unistd.h       |   8 +-
>> >  kernel/sys_ni.c                         |   1 +
>> >  mm/migrate.c                            | 178 ++++++++++++++++++++=
+++-
>> >  tools/include/uapi/asm-generic/unistd.h |   8 +-
>> >  7 files changed, 197 insertions(+), 5 deletions(-)
>>=20
>> So this is probably a silly question, but just to be sure ... what is
>> the permission model for this system call?  As far as I can tell, the
>> ability to move pages is entirely unrestricted, with the exception of
>> pages that would need MPOL_MF_MOVE_ALL.  If so, that seems undesirabl=
e,
>> but probably I'm just missing something ... ?
>>=20
>> Thanks,
>>=20
>> jon
>
> Not silly, looks like when U dropped the CAP_SYS_NICE check (no task to
> check against), check i neglected to add a CAP_SYS_ADMIN check.

Global, I presume?

I have to admit that I don=E2=80=99t think this patch set makes sense at=
 all.

As I understand it, there are two kinds of physical memory resource in C=
XL: those that live on a device and those that live in host memory.

Device memory doesn=E2=80=99t migrate as such: if a page is on an accele=
rator, it=E2=80=99s on that accelerator. (If someone makes an accelerato=
r with *two* PCIe targets and connects each target to a different node, =
that=E2=80=99s a different story.)

Host memory is host memory. CXL may access it, and the CXL access from a=
 given device may be faster if that device is connected closer to the me=
mory. And the device may or may not know the virtual address and PASID o=
f the memory.

I fully believe that there=E2=80=99s some use for migrating host memory =
to a node that's closer to a device.  But I don't think this API is the =
right way.  First, something needs to figure out that the host memory sh=
ould be migrated.  Doing this presumably involves identifying which (log=
ical!) memory is being accessed and deciding to move it.  Maybe new APIs=
 are needed to enable this.

But this API is IMO rather silly.  Just as a trivial observation, if you=
 migrate a page you identify by physical address, *that physical address=
 changes*.  So the only way it possibly works is that whatever heuristic=
 is using the API knows to invalidate itself after calling the API, but =
of course it also needs to invalidate itself if the kernel becomes intel=
ligent enough to migrate the page on its own or the owner of the logical=
 page triggers migration, etc.

Put differently, the operation "migrate physical page 0xABCD000 to node =
3" makes no sense.  That physical address belongs to whatever node its o=
n, and without some magic hardware support that does not currently exist=
, it's not going anywhere at runtime.

I just don't see it this code working well, never mind the security issu=
es.
