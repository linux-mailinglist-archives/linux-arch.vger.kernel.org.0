Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECC7A6900
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 18:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjISQcC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjISQbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 12:31:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6018F;
        Tue, 19 Sep 2023 09:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDnH8UIh6OKc1FD6ZYs6cWjSx/4ILJpM0Ikmu2EiZSxqqzj3aSkhzQluqiacpjy/b+nrfLjg/FxJQL+Y/Kqnf10dSKiWohmbB/U4J/YSwHUR6MldKPdMdhtY5tJGgeUXrRd7rHy+NQsaYCNRV16rx8+Mv+g1oD2T7+QjiDOXFiarWFcNQ7V9gVTNaaCrTPpKBfVn0HScRWYsMsMnFXHO3x3InERe/kIxUnNtd2kx652D0o2HwKIuvHbDEYA5pLvheZpyome34X4ecN0aoka3HjGOwA+JljH7KWRpPkjx2Sp9wGhnq9sccjxLmXc1EV63x45EnhFYhySQ09BkZ7WM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UODKOHb/I+cwBhSz6vQysDtn/sF1tdUnwHzoGIjkhX0=;
 b=SP0/WSOYU6xjxhzj2FmS7JmJx14ivbOR2YdfyUVEGjGWN81mDzis6w3i0fjskzwPnA2bTyunEFAtDC5AFYpDBY84TzC1Tt1VGGRpTu3kpc7GsC/7mfUH5cSCf9N1XTAXJ1hl82mIu6y9Wa6/Vr18ziGmMeCtRGsrVEttoAa+WynYgulPPVUtEX/W088cUOO2pSyh27XMN+//DHwcUpa2o09CVu3AfHz79NT1v9Lqh2ekUsqkJOgSYnhcyBin2uokl/EONmB6I6djCxFCpnW1+U2a+SSo60QR88dSpPC7PzkXKiFUOwqnLkVbBIKpNCxiyz1cB0cX5NFWKhPtx6ne8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UODKOHb/I+cwBhSz6vQysDtn/sF1tdUnwHzoGIjkhX0=;
 b=c/dz441xpMu12vqjwry1I7Nr9S4DWuFEFds8+YowrF0H5juCE1Ze5IlQOlgzrobVeUh0SuDevVkfzNP6MkXLEiqdQDTybTb61RuppldtW2Vi3v3M0BmsXkoALBE3LmL8UMX84qmp0QRWmUC5rd5lmp+8+E27/wwR34wB2JpiWF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5144.namprd17.prod.outlook.com (2603:10b6:a03:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 16:31:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:31:17 +0000
Date:   Tue, 19 Sep 2023 12:31:08 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZQnMzD26VI3C/ivf@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net>
 <ZP2tYY00/q9ElFQn@memverge.com>
 <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1b8280-699c-44f2-35f9-08dbb92dd8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7ZQPSsoMnPVa8ao7GIlZnFFlADTm09QKwr0i3RsdX5YvTEi17lw3qdx4ncvERJzuEBotTjqSsql1s49kRVIWVHtWF+TH4E45fNz9c/3N2j+dXvYJrIybEF3xYX6jsnJyNxiP8tj8jmKRI/e6G+3KG9MH/mGkAgsCanXFx8HPJp6xhAoVpGSCAawHu+/HhLovI8rLM9jBdvWw4ZfAJxUr6mpBO/fjTjJveb9cejotVm/TmRrI6/oO0JgVV9h3lcNtQD0NZ4IKHlzfrX1j5u9jwsK0m0Jmw1Q175xBTz90A0LbOcMh4jSIaZTE7AwTZ4ue40PCa3pG2DdwItin4LOtOy+lPbUMd2DoatJ3VCSoRb5SOGw9yJP/shTTvJHaI8QRT5o4g6jjb/gdZdQQ5uIFOztFGulcG0Y8QideQJ8VSH+MwtfuGc9Fcp2MwhxHWw/5c39eGjnN6rME3ELQIMISSnKKZlnebU7kt60YyWPi9uDNnyX8SsJ26Ad/7cP8eU1LT5rEz10wUq1jJ3pfPpx/oLf1BuhW7iq9GbdAjfJobc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39840400004)(136003)(186009)(1800799009)(451199024)(66946007)(66556008)(66476007)(54906003)(316002)(6916009)(478600001)(6666004)(38100700002)(966005)(7416002)(2906002)(86362001)(36756003)(41300700001)(44832011)(5660300002)(8676002)(4326008)(8936002)(2616005)(26005)(83380400001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVE2QzBGbzRENytQUEdIZkRadjBzWEkrYzFuTnBOanRKbXVTRncwUFlHOUVN?=
 =?utf-8?B?L24zOUw0bDVOZkFLMFNHYzN3SjhXeVIwSGoxOHk4QVZ6Qzk4LzVVMWsrSDNL?=
 =?utf-8?B?bG9zZFVSOWVsY0hLWFRnMmdlc0dUT1dTZ20xMy9zbEpEKzVLTnNUYmVKa1gv?=
 =?utf-8?B?Q2haSlNXZHd2UWFLOWllQ2dJMUJtRHhLN1NpOVFzeHRIUHc4YkpKOXhyeWly?=
 =?utf-8?B?VVBVd2ZSM1NrRktsV2s2Y1VycGdYb2MzenZvSkZzMnd1aHJra05IK09vY1pj?=
 =?utf-8?B?VVVxVGtIbnFjeDVsa29nd0NvQjhmUVN0bTJnUVdWVGF0ZmlCVkwyc285Vzlr?=
 =?utf-8?B?ZmRsc0ZGQlJYa0swVTBEK0JMQ29EY0thVDBjbHc1eHJOZGwvcE5CUEphR1FM?=
 =?utf-8?B?dEU0ZUV2M0NmSGJTV2REcWpjKzFBb3pzeG9GWHhZUnFXcW4wK2lxT21ZeUYz?=
 =?utf-8?B?RFVCL0dxUDRNWDRMSmFPK2VVOEF6OGZNdFVzdzg2SDJsN3NuS2pBZWQwZFB0?=
 =?utf-8?B?aFY4bExsalk4T2lBcGIrTVFGdkZmcXQ0ZFg3SFRtR2F2cmlmK0Y2SUdGdzdi?=
 =?utf-8?B?NXZrNFBaNGR2VCtOL0M5eis2MzR0QzU2SytneGYrLzJ1YmUxT2o5VHJBaERY?=
 =?utf-8?B?WExGR0xDaGdSUmNEcU1vVGtLQnhYNCtSSFo0UWFvSnpHdjR4bExuL25VbitE?=
 =?utf-8?B?U2lwKzlmM2VJaG5xcGY5UDljdS9hWjkzdzVwU0s2b1FPWm85R0FqSjlJRks4?=
 =?utf-8?B?K2tTOHJHVk01TlR4VmpPTEd0bkdmMUVQNmtsM3Z5ZVNXbjdLVklxT0Z5TkEv?=
 =?utf-8?B?dEFBOXRCTFZleEJNZjZTVm16UHFyNVB0a1FjZ3Y5emFrZnA0bFpsaVMwOU5q?=
 =?utf-8?B?N3p3T1BYbitNREdaeTRaMXhXa0tJN1ZmbTZxNlNETk1sSTRPbUlnekZwRTN4?=
 =?utf-8?B?bURPbm51bkdkK1ppL3VLSFYrU3UydUVjMm5jcm5INDgrclBVazdyTWRsUWFw?=
 =?utf-8?B?dXE3Nll5aFcycXphdG5sd1J2YkN3c09IZGNJS1JJNzI2a2I3cXIxSWZwSWQ0?=
 =?utf-8?B?WUlXR2JtVEFxbCtJaForQ3dUOUNMajZQMkgrczZ5SGxNdmgvd0ovS2VEWlRx?=
 =?utf-8?B?SEx3T3BkVDhzUWlyMi9TUTJZTU1vUHVpOGVmeHE3ZlE3RCtvdzVFbzB1V2Ux?=
 =?utf-8?B?WVpVVytnWUVHaEFReFIvU1cyMjlkdmhtWnQ1L0pqcHhTUTZxTVdDREI2N2Iw?=
 =?utf-8?B?YS9xRS9HVXFTNVFjMDFIQ3JyWXcxTVBjWHRzWjl3T0xxWjdqVXA0Q2lOemJY?=
 =?utf-8?B?Um5PN3VFcWVhaVE0Vy9qd0g0ZnkvdVlrZSt5MW9vekcrcjN5VEVhVFJsMnhP?=
 =?utf-8?B?aVBpRk45Ynp5b3pPVjVzZ2dCNG4xNDlPS3lsQko3QkV1RWMzVWlDUlNqSlA5?=
 =?utf-8?B?VCs1RHJRejVjcDBmZ3hrRHFTWGVxT2hDSkxYaTZ3aWlaQkdhYW8xTTF3SnhX?=
 =?utf-8?B?MzB6OVRRV0RmWWNwajgwRUROa2JNMTZ5dlcrVnFVVnoyclBOUEZsTHhlNVk0?=
 =?utf-8?B?YTlEZEhKSXEzQ0taYlAvaTRVUWJUeDNnZWFlZHV5VitqMlhWNXl6YUNKT1Vz?=
 =?utf-8?B?K1BtQnBYL0ZNdHVueUtoa21JUk9YT0laY3RLQlZlMVlrMGRkOWRwSGZVeXMz?=
 =?utf-8?B?T3ZsWlI1WDVmK3hkb3EzcSt5a3E2ekhVNjY4aWp6bDhwd3pLNm9RaVhBaWZL?=
 =?utf-8?B?dE5MclpyVGsxUzl3Q1BtNG5OMUhwREdpL1ZuY2hDWlpSK3ZPbmZ3azlmM0Jo?=
 =?utf-8?B?TElvQ0xyVmdaK2ZwOVhweFFQUWhaeUtyQnhZbVV4LzgzZXZWaHhSYUpacE94?=
 =?utf-8?B?QytuUGpJaE8yUUhHcGlSd0l5SnBuazZ1TnhDdmdLQk0rS0hPdU5ENU53U29T?=
 =?utf-8?B?b1V2YWdFQmVScnBJbFc4ckJCLzZ4ZnVXLzBNclVDOVB0bDEvalI4bGoxY0ZS?=
 =?utf-8?B?a0JWaG1lZy9lelFGd1MrZCtzeDRITGhrcjkxNHNCb0J5Znd3ZVlnbk0wUjVw?=
 =?utf-8?B?SGMzSXdubFU2bVliNmJGVTRBdGZ4VElZTHlaZ2NxWGova3FZMW9US1grbFh5?=
 =?utf-8?B?dVRjcXd5bWtKM1FvYzJZTU1YZXMzTlRVTmtMQStDNCtTTnlJd3hYRHlMK3dK?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1b8280-699c-44f2-35f9-08dbb92dd8ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:31:17.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BRZD0Btq/NRc1H6/EjwchmtbTyqLuaKjCGuV99tTqJOKEFY/UArRdkcaRsEq/+QlQUB/GSTi6mw5JSeab2NUQCaVrNc5OT7yhmYX4czmKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 18, 2023 at 08:34:16PM -0700, Andy Lutomirski wrote:
> 
> 
> On Sun, Sep 10, 2023, at 4:49 AM, Gregory Price wrote:
> > On Sun, Sep 10, 2023 at 02:36:40PM -0600, Jonathan Corbet wrote:
> >> 
> >> So this is probably a silly question, but just to be sure ... what is
> >> the permission model for this system call?  As far as I can tell, the
> >> ability to move pages is entirely unrestricted, with the exception of
> >> pages that would need MPOL_MF_MOVE_ALL.  If so, that seems undesirable,
> >> but probably I'm just missing something ... ?
> >> 
> >> Thanks,
> >> 
> >> jon
> >
> > Not silly, looks like when U dropped the CAP_SYS_NICE check (no task to
> > check against), check i neglected to add a CAP_SYS_ADMIN check.
> 
> Global, I presume?
> 
> I have to admit that I don’t think this patch set makes sense at all.
> 
> As I understand it, there are two kinds of physical memory resource in CXL: those that live on a device and those that live in host memory.
> 
> Device memory doesn’t migrate as such: if a page is on an accelerator, it’s on that accelerator. (If someone makes an accelerator with *two* PCIe targets and connects each target to a different node, that’s a different story.)
> 
> Host memory is host memory. CXL may access it, and the CXL access from a given device may be faster if that device is connected closer to the memory. And the device may or may not know the virtual address and PASID of the memory.
> 

The CXL memory description here is a bit inaccurate.  Memory on the CXL
bus is not limited to host and accelerator, CXL memory devices may also
present memory for use by the system as-if it were just DRAM as well.
The accessing mechanisms are the same (i.e. you can 'mov rax, [rbx]'
and the result is a cacheline fetch that goes over the cxl bus rather
than the DRAM memory controllers).

Small CXL background for the sake of clarity:

type-2 devices are "accelerators", and the memory relationships you
describe here are roughly accurate.  The intent of this interface is not
really for the purpose of managing type-2/accelerator device memory.

type-3 devices are "memory devices", whose intent is to provide the
system additional memory resources that get mapped into one or more numa
nodes.  The intent of these devices is to present memory to the kernel
*as-if* it were regular old DRAM just with different latency and
bandwidth attributes. This is a simplification of the overall goal.


So from the perspective of the kernel and a memory-tiering system, we
have numa nodes which abstract physical memory, and that physical memory
may actually live anywhere (DRAM, CXL, where-ever).  This memory is
fungible with the exception that CXL memory should be placed in
ZONE_MOVABLE to ensure the hot-plugability of those memory devices.


The intent of this interface is to make page-migration decisions without
the need to track individual processes or virtual address mappings.

One example would be to utilize the idle page tracking mechanism from
userland to make migration decisions.

https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html

This mechanism allows a user to determine which PFNs are idle.  Combine
this information with a move_phys_page syscall, you can now implement
demotion/promotion in user-land without having to identify the virtual
address mapping of those PFN's in user-land.


> I fully believe that there’s some use for migrating host memory to a node that's closer to a device.  But I don't think this API is the right way.  First, something needs to figure out that the host memory should be migrated.  Doing this presumably involves identifying which (logical!) memory is being accessed and deciding to move it.  Maybe new APIs are needed to enable this.
> 

The intent is not to migrate memory to making it "closer to a device",
assuming you mean the intent is to make that data closer to a device
that is using it (i.e. an accelerator).

The intent is to allow migration of memory based on a user-defined
policy via the usage of physical addresses.

Lets consider a bandwidth-expansion focused tiering policy.  Each
additional CXL Type-3 Memory device provides additional memory
bandwidth to a processor via its pcie/cxl lanes.

If all you care about is latency, moving/migrating pages closer to the
processor is beneficial.  However, if you care about maximizing
bandwidth, distributing memory across all possible devices with some
statistical distribution is a better goal.

So sometimes you actually want hot data further away because it allows
for more concurrent cacheline fetches to occur.


The question as to whether getting the logical memory address is
required, useful, or performant depends on what sources of information
you can pull physical address information from.

Above I explained idle page tracking, but another example would be the
CXL device directly, which knows 2 pieces of information (generally):

1) The extent of the memory it is hosting (some size)
2) The physical-to-device address mapping for the system contacting it.

The device talks (internally) in 0-based addressing (0x0 up to 0x...),
but the host places the host physical address (HPA) on the bus
(0x123450000).  The device receives and converts 0x123450000 (HPA) into
a 0-base address (device-physical-address, DPA).

How does this relate to this interface?

Consider a device which provides a "heat-map" for the memory it is
hosting.  If a user or system requests this heat-map, the device can
only provide that information in terms of either HPA or DPA.  If DPA,
then the host can recover the HPA by simply looking at the mapping it
programmed the device with.  This reverse-transaction (DPA-to-HPA) is
relatively inexpensive.

The idle-page tracking interface is actually a good example of this. It
is functionally an heat-map for the entire system.

However, things get extraordinary expensive after this.  HPA to host
virtual address translation (HPA to HVA) requires inspecting every task
that may map that HPA in its page tables.  When the cacheline fetch hits
the bus, you are well below the construct of a "task", and the devices
has no way of telling you what task is using memory on that device.

This makes any kind of tiering operation based on this type of heat-map
information somewhat of a non-starter.  You steal so much performance
just converting that information into task-specific information, that
you may as well not bother doing it.

Instead, this interface would allow for a tiering policy to operate on
such heat-map information directly, and since all CXL memory is intended
to be placed in ZONE_MOVABLE, that memory should always be migratable.

> But this API is IMO rather silly.  Just as a trivial observation, if you migrate a page you identify by physical address, *that physical address changes*.  So the only way it possibly works is that whatever heuristic is using the API knows to invalidate itself after calling the API, but of course it also needs to invalidate itself if the kernel becomes intelligent enough to migrate the page on its own or the owner of the logical page triggers migration, etc.
> 
> Put differently, the operation "migrate physical page 0xABCD000 to node 3" makes no sense.  That physical address belongs to whatever node its on, and without some magic hardware support that does not currently exist, it's not going anywhere at runtime.
> 
> I just don't see it this code working well, never mind the security issues.

I think this is more of a terminology issue.  I'm not married to the
name, but to me move_phys_page is intuitively easier to understand
because move_page exists and the only difference between the two
interfaces is virtual vs physical addressing.

move_pages doesn't "migrate a virtual page" either, it "migrates the
data pointed to by this virtual address to another physical page located 
on the target numa node".

Likewise this interface "migrates the data located at the physical address,
assuming the physical address is mapped, to another page on the target numa
node".

The virtual-address sister-function doesn't "move the physical page"
either, it moves the data from one physical page to another and updates
the page tables.

~Gregory
