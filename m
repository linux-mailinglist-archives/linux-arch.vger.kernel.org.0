Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FE7A6A58
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjISSAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjISSAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:00:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E58C9
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 10:59:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FFFC433C8;
        Tue, 19 Sep 2023 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695146396;
        bh=qBVtI3SYwGrdBXfsS/BqqDCajlbfTB2CQ+iywE0bJuA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=b4Ia90Jz3H/98CxWGuLcHOgKzgGkxOlPjvThIyaPcxwYQqx1IxfxKoTUkmpJpIHgo
         fKFQMz3CZdyAAR7e/gwSN1zVePXlHgmawNGt2FZIYaUHAsRno9gHcPkv7n1qdRe11j
         ecJQnjpHEHru3+PZvHEBqgHEcYqz23vhyM8Ii/4yRGKKTA3Eeqj3Bm8FpncbALJEDI
         JrvKX2uX58DBe0ki7mFUlu2pzxc/V0k483yqW0AyFL4/4SP6i1+6V3CW3RZw2SLDTJ
         xJDBvFLcFO5Zn+jTMx7JoXoRtbLZwFA0ZCyL5lI2Sl4YFBBAeSLs82jqAEJg7a4TVi
         bBYhcvfd5uaeQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 84A6027C005B;
        Tue, 19 Sep 2023 13:59:54 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 19 Sep 2023 13:59:54 -0400
X-ME-Sender: <xms:meEJZbvDTnn4-2ZVfNr4j-nrt6DbuzH5sfNP0wDhkWWhZBEk0WeJWA>
    <xme:meEJZcd0vUwdkqaWg39kBoah1_MzWHsQpONejs63Zga-IT2Ndwvw00v4ZKynv0EaY
    N-Dg3OR7Z5fLsCIMVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeiteejleegjeekleegveeujeejvdehjeekveegudduudffueek
    jefffeeujeekhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:meEJZezaaRTBRnaV1Q3ZhkSVJ9wsBpU3oaTGmNlO4OwrPfOhwGPAFw>
    <xmx:meEJZaOqNYpTkL1NXPqGNtGr1AmOfQjS5RQVQ3aQHmYdI3olzDlfrQ>
    <xmx:meEJZb_dr_QMGsxzWzeZH60E3CLCeB8o3NsMuskQcX5DKvFm2Ujt0g>
    <xmx:muEJZRcsxFbM4DMBIvoZlpnm0h12IwvgYsqaIvPFhn8ViA3eWMAxEw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9B17F31A0065; Tue, 19 Sep 2023 13:59:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <0a7e3ccc-db66-428e-8c09-66e67bfded51@app.fastmail.com>
In-Reply-To: <ZQnMzD26VI3C/ivf@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net> <ZP2tYY00/q9ElFQn@memverge.com>
 <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
 <ZQnMzD26VI3C/ivf@memverge.com>
Date:   Tue, 19 Sep 2023 10:59:33 -0700
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Tue, Sep 19, 2023, at 9:31 AM, Gregory Price wrote:
> On Mon, Sep 18, 2023 at 08:34:16PM -0700, Andy Lutomirski wrote:
>>=20
>>=20
>> On Sun, Sep 10, 2023, at 4:49 AM, Gregory Price wrote:
>> > On Sun, Sep 10, 2023 at 02:36:40PM -0600, Jonathan Corbet wrote:
>> >>=20
>> >> So this is probably a silly question, but just to be sure ... what=
 is
>> >> the permission model for this system call?  As far as I can tell, =
the
>> >> ability to move pages is entirely unrestricted, with the exception=
 of
>> >> pages that would need MPOL_MF_MOVE_ALL.  If so, that seems undesir=
able,
>> >> but probably I'm just missing something ... ?
>> >>=20
>> >> Thanks,
>> >>=20
>> >> jon
>> >
>> > Not silly, looks like when U dropped the CAP_SYS_NICE check (no tas=
k to
>> > check against), check i neglected to add a CAP_SYS_ADMIN check.
>>=20
>> Global, I presume?
>>=20
>> I have to admit that I don=E2=80=99t think this patch set makes sense=
 at all.
>>=20
>> As I understand it, there are two kinds of physical memory resource i=
n CXL: those that live on a device and those that live in host memory.
>>=20
>> Device memory doesn=E2=80=99t migrate as such: if a page is on an acc=
elerator, it=E2=80=99s on that accelerator. (If someone makes an acceler=
ator with *two* PCIe targets and connects each target to a different nod=
e, that=E2=80=99s a different story.)
>>=20
>> Host memory is host memory. CXL may access it, and the CXL access fro=
m a given device may be faster if that device is connected closer to the=
 memory. And the device may or may not know the virtual address and PASI=
D of the memory.
>>=20
>
> The CXL memory description here is a bit inaccurate.  Memory on the CXL
> bus is not limited to host and accelerator, CXL memory devices may also
> present memory for use by the system as-if it were just DRAM as well.
> The accessing mechanisms are the same (i.e. you can 'mov rax, [rbx]'
> and the result is a cacheline fetch that goes over the cxl bus rather
> than the DRAM memory controllers).
>
> Small CXL background for the sake of clarity:
>
> type-2 devices are "accelerators", and the memory relationships you
> describe here are roughly accurate.  The intent of this interface is n=
ot
> really for the purpose of managing type-2/accelerator device memory.
>
> type-3 devices are "memory devices", whose intent is to provide the
> system additional memory resources that get mapped into one or more nu=
ma
> nodes.  The intent of these devices is to present memory to the kernel
> *as-if* it were regular old DRAM just with different latency and
> bandwidth attributes. This is a simplification of the overall goal.
>
>
> So from the perspective of the kernel and a memory-tiering system, we
> have numa nodes which abstract physical memory, and that physical memo=
ry
> may actually live anywhere (DRAM, CXL, where-ever).  This memory is
> fungible with the exception that CXL memory should be placed in
> ZONE_MOVABLE to ensure the hot-plugability of those memory devices.
>
>
> The intent of this interface is to make page-migration decisions witho=
ut
> the need to track individual processes or virtual address mappings.
>
> One example would be to utilize the idle page tracking mechanism from
> userland to make migration decisions.
>
> https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html
>
> This mechanism allows a user to determine which PFNs are idle.  Combine
> this information with a move_phys_page syscall, you can now implement
> demotion/promotion in user-land without having to identify the virtual
> address mapping of those PFN's in user-land.
>
>
>> I fully believe that there=E2=80=99s some use for migrating host memo=
ry to a node that's closer to a device.  But I don't think this API is t=
he right way.  First, something needs to figure out that the host memory=
 should be migrated.  Doing this presumably involves identifying which (=
logical!) memory is being accessed and deciding to move it.  Maybe new A=
PIs are needed to enable this.
>>=20
>
> The intent is not to migrate memory to making it "closer to a device",
> assuming you mean the intent is to make that data closer to a device
> that is using it (i.e. an accelerator).
>
> The intent is to allow migration of memory based on a user-defined
> policy via the usage of physical addresses.
>
> Lets consider a bandwidth-expansion focused tiering policy.  Each
> additional CXL Type-3 Memory device provides additional memory
> bandwidth to a processor via its pcie/cxl lanes.
>
> If all you care about is latency, moving/migrating pages closer to the
> processor is beneficial.  However, if you care about maximizing
> bandwidth, distributing memory across all possible devices with some
> statistical distribution is a better goal.
>
> So sometimes you actually want hot data further away because it allows
> for more concurrent cacheline fetches to occur.
>
>
> The question as to whether getting the logical memory address is
> required, useful, or performant depends on what sources of information
> you can pull physical address information from.
>
> Above I explained idle page tracking, but another example would be the
> CXL device directly, which knows 2 pieces of information (generally):
>
> 1) The extent of the memory it is hosting (some size)
> 2) The physical-to-device address mapping for the system contacting it.
>
> The device talks (internally) in 0-based addressing (0x0 up to 0x...),
> but the host places the host physical address (HPA) on the bus
> (0x123450000).  The device receives and converts 0x123450000 (HPA) into
> a 0-base address (device-physical-address, DPA).
>
> How does this relate to this interface?
>
> Consider a device which provides a "heat-map" for the memory it is
> hosting.  If a user or system requests this heat-map, the device can
> only provide that information in terms of either HPA or DPA.  If DPA,
> then the host can recover the HPA by simply looking at the mapping it
> programmed the device with.  This reverse-transaction (DPA-to-HPA) is
> relatively inexpensive.
>
> The idle-page tracking interface is actually a good example of this. It
> is functionally an heat-map for the entire system.
>
> However, things get extraordinary expensive after this.  HPA to host
> virtual address translation (HPA to HVA) requires inspecting every task
> that may map that HPA in its page tables.  When the cacheline fetch hi=
ts
> the bus, you are well below the construct of a "task", and the devices
> has no way of telling you what task is using memory on that device.
>
> This makes any kind of tiering operation based on this type of heat-map
> information somewhat of a non-starter.  You steal so much performance
> just converting that information into task-specific information, that
> you may as well not bother doing it.
>
> Instead, this interface would allow for a tiering policy to operate on
> such heat-map information directly, and since all CXL memory is intend=
ed
> to be placed in ZONE_MOVABLE, that memory should always be migratable.
>
>> But this API is IMO rather silly.  Just as a trivial observation, if =
you migrate a page you identify by physical address, *that physical addr=
ess changes*.  So the only way it possibly works is that whatever heuris=
tic is using the API knows to invalidate itself after calling the API, b=
ut of course it also needs to invalidate itself if the kernel becomes in=
telligent enough to migrate the page on its own or the owner of the logi=
cal page triggers migration, etc.
>>=20
>> Put differently, the operation "migrate physical page 0xABCD000 to no=
de 3" makes no sense.  That physical address belongs to whatever node it=
s on, and without some magic hardware support that does not currently ex=
ist, it's not going anywhere at runtime.
>>=20
>> I just don't see it this code working well, never mind the security i=
ssues.
>
> I think this is more of a terminology issue.  I'm not married to the
> name, but to me move_phys_page is intuitively easier to understand
> because move_page exists and the only difference between the two
> interfaces is virtual vs physical addressing.
>
> move_pages doesn't "migrate a virtual page" either, it "migrates the
> data pointed to by this virtual address to another physical page locat=
ed=20
> on the target numa node".
>
> Likewise this interface "migrates the data located at the physical add=
ress,
> assuming the physical address is mapped, to another page on the target=
 numa
> node".

I'm not complaining about the name.  I'm objecting about the semantics.

Apparently you have a system to collect usage statistics of physical add=
resses, but you have no idea what those pages map do (without crawling /=
proc or /sys, anyway).  But that means you have no idea when the logical=
 contents of those pages *changes*.  So you fundamentally have a nasty r=
ace: anything else that swaps or migrates those pages will mess up your =
statistics, and you'll start trying to migrate the wrong thing.
