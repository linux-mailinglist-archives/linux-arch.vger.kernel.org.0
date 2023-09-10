Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADD79B5C9
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjIKVGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbjIKPrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 11:47:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F296B121;
        Mon, 11 Sep 2023 08:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHNR4/U+CHQ13E/WmcKSZp48cFMQqd1irN39Qsm4Ql3C8Yp7wYxnocNpYYUeU7B5USljCg0xzDolCY6X1yL/OmrrumBxCvJ6mWRd+mj6HntbCyAt59Xvya6l25pezsQRgcDWXtDXseYT/DgE1j3BaqRO3Hhtr8Nghs0S9Ug1e8t57yPRVVhVPi6N46MG2eT//DZIts7bWWryHp4FKObM5m03em2h2Nahx21Vgddb1xWqZWZyrKt0Dp+Iauikuw8SZZs7IZQYJsKpv91bs6XSvwDcssy3E/pKRmxMQ91dK4S37hKdDbEVEh6zq3Ij+cMalQMbc8UElqC6zxVulVXGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1/v/hXiimiR/ueUgC0D/TouK+2ZIfKud4W62UpKMDQ=;
 b=DE23xPukfc9Q0/Cu9D9YbWtZeobRDAgToYRorN13MgfHIGJcpFa98lX8xx6RySHfFXjZ1RqcIEmvzuCwLw1+NhQC/C3DfVMyyCFx3Ypsu507OH7Ng5w95tywsgrgmWjK+EA1Ru8W8gW+wP31ueyK4xC9O4NIXuY1VkPBY8BXBE8DKyVn11sJDQl/JlJmaTUHNo8KbhTNyBaXCs6QjtH5u0TZSRVt/jhW/HcfTsqC+CnFAYxP6dl2/276DZtJ/cIgJV+KJ+Dh7y20VA2ZDOfHqhHzOe32uTWcQ4mpNUndyajy2eyTnXBwrZPiiNkhBFuPT3Qy5WrABiApSQh/2s52Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1/v/hXiimiR/ueUgC0D/TouK+2ZIfKud4W62UpKMDQ=;
 b=GhA7thoLVCWZrFPli5o72MfYRz8/0hBYizETgLl7Cs4ql44+6I0ty0ubxP1NDhbxcRprCzFheeFW5jQMHBVtRH592qFyrhl67o4BPDRHhnjB6fo4e5ESG45VU7x3CSHgUCreDfI5c0KwkktbjzxF9D7T3nseknw5i4nFfsnzhw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BY5PR17MB3953.namprd17.prod.outlook.com (2603:10b6:a03:231::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 15:46:58 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Mon, 11 Sep 2023
 15:46:58 +0000
Date:   Sun, 10 Sep 2023 08:52:31 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZP28D8dZXz3+4s9v@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
 <ZPrRcJCjRBvJ9c3N@memverge.com>
 <2fe03345-01a2-4cfe-9648-ae088493d1af@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe03345-01a2-4cfe-9648-ae088493d1af@app.fastmail.com>
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BY5PR17MB3953:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e2485e-24c9-4601-3f0c-08dbb2de54fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tchUKbQ3FzARpwjpMDIABV8JXU3pXZkOef/N0pw9o/cfC1ER73JoUqoOplIXvNl/Xpvj4iSmt+rmUUvxOpBwr6Iwewvv8oLbuuvsKs8OiuEH4AQedJPQrC1ukF6+tkDXYyxRGKsNxNNzRnjiwH6HAJpjUdsLsJRMznRMcGi1TBL6ZMGIQp+pJ9EA4/HynIvoz4RykECMTANecJoYZ47RC49plRib5Ppres8YN+YzvKT/jTKfeWpTnvKwwn9ObRiQokfm87LAfIBmOZs29qOcSHQhQFMRo+wY8frTwwgCh69f05grp886i/3udtLan/hOzY03QJGp5bD2UxEbR8mWyB5exVbMojL2dHT2HZ7v5zDWwm2KZeJUYyZRYv+sulRmFAz3/1A9U0zZR5kRD+CLVVcRFOj1RowOoMGi8nTRxD/FRKCWFVq/NGoKINDdZopNECY0EboMr7V+H8KEHlwarGiZ2gUPw+x2Ppx49G5mW/rv+VIbikxyO+hfuQEAsSJRSxxaiVsTR/2c56SAnG09eVAsk87WWnw6XvM5q78Iv3NXnnPHkXK1xMF8IZHG3u/1wuDH5Ax3vzu2gettwxZUGTcec2BY4eSgJtjx2Hr+7N4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39830400003)(396003)(136003)(376002)(186009)(451199024)(1800799009)(6506007)(6486002)(6512007)(6666004)(83380400001)(86362001)(38100700002)(36756003)(2616005)(26005)(6916009)(316002)(7416002)(41300700001)(66556008)(66946007)(4326008)(54906003)(2906002)(66476007)(8936002)(8676002)(44832011)(5660300002)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzfCQXmFftUBAQz5CLBlkexR/LQAPd6dQ4qSJ0ipwgDVTegSHFomKCOsBl5+?=
 =?us-ascii?Q?nwTIm5fpZGAYu/CpUEjxXZ2nublnfe9kOCl7UDkld8336I6Mrrh2wcJZWB95?=
 =?us-ascii?Q?yxY6FytHUpsSSSObVedZNvbvQTjgeLdltuaeSfXuyEaN1VqjLLOpmBPyAxzN?=
 =?us-ascii?Q?7cbH5W8tnGrW5ZFiq1yeJ/4OcD2KrihCvDrlNw5iFqYZI7ts0GLn4/eu/DYO?=
 =?us-ascii?Q?liYtwrwGI3yLSrzwX0fkF8w/CNip2o3ZaAHlfyaIwXHxMT8Fko2lt7i79nCc?=
 =?us-ascii?Q?F49l5yO7lPQL2L30IlJw1lorYZtDZ0E+Ijp5z+mBbu5fdJEsAwxzkFHdv/HY?=
 =?us-ascii?Q?Ciqtv4+vKf1Lfrw3svI+riLmFMLVS9U1BFfkYJIfCper4WmTVrwTdR1wAXvW?=
 =?us-ascii?Q?vt91Y5qiZPssGHY5p4zSxMiDb/pewMRAhnnHMxSP0qOlQ1jC5X6ePQDPO4rH?=
 =?us-ascii?Q?OicwKsnW/75eYasMgzSkWKihP0TNjkjnd23aWKRmfAAVjgwy83JNcEXtQqMe?=
 =?us-ascii?Q?PPSg+1N8whnWHMuElQ+uZgpxGrbu357dFTtwKhpolSFR52Hfxa/Orb78EYtG?=
 =?us-ascii?Q?Fs7TvbVIl2wSHrXGUboK115W7gCa4kk51ruGgoG81P2NKcoRhg93297jKRvE?=
 =?us-ascii?Q?dn+tyJqkd5y7AMfQ23pyFOmwWENVlOIx0/j7/D4ysjEGLRwdSkVZ07NYY0SR?=
 =?us-ascii?Q?Z2BAFKO/Ex4q0gPQrOlm4NsI5+2Q/zYgCbBMpOKe1BSCswh1dDaps6hh34fv?=
 =?us-ascii?Q?AoQccsGV8Xs/zOsGiNnsNLtjw4+5oVcQ7mbOcJyR40+AiQ/2IbCUM8FATuuZ?=
 =?us-ascii?Q?jBkvjMDiDU9mSIQ6ZQfGspM06gfoQ0aIml2vQrBOmMak25QHymtz/UsKwf5v?=
 =?us-ascii?Q?qwmmI6vfuoORwg6lM5Rwmaglx1ivdjCtDEXJLOu9EKD6R4dgZKwP3OHIAK7D?=
 =?us-ascii?Q?iuyKFPS0FiIIubW+745xZjrcC6pfnD1X+7zC95xGywKipPO664L+bVHgExw+?=
 =?us-ascii?Q?rr+MGN+z/VErY4CANX4+at1IZAXFlwqWHtafs1GBL4OU14McIDl+YHTVZcyN?=
 =?us-ascii?Q?O2NQ4m1UGsejYxA2g0ckSXNdLCXihQnp+Wp5Kswj1LUHg0dS0CorKMFOHx2o?=
 =?us-ascii?Q?Dz6gKTh6bbkkWeahOwoVHjK5Y4O5zOqf7GI/FPEvKBYSw/ZZ23vTWJ7XbO4b?=
 =?us-ascii?Q?ZA3Jai9ZTnMAhYoZzNAReplhY4vVpFi1VPYP2rDnXkeS/sgsd55AAEVfWymC?=
 =?us-ascii?Q?iG9Mb2imChB0xMBv96CEDdTll1t5YLxs0twUayTtAQFlI6uAyGMi5YURQRkb?=
 =?us-ascii?Q?KiHjtfblm2cph5QtNKJlMEzuXxe6Mb61xKJyTr20+ksQiNf9zoHqO3254Ocw?=
 =?us-ascii?Q?2r57VyKnE7ixeGIVRRas88zk+qOFHAuCLslgd4xC1NYjg7CfB6HacK7Eq5dg?=
 =?us-ascii?Q?sT0egvKVXws4pvPsNHaEEnycg8NQKkGH+ZpkBGc56C5LAg2TIpCHmOVh5O1y?=
 =?us-ascii?Q?QjLgY+hPIKLFG97IUhMd26kk8ciGdFa03Kg4cw7J81oIEBiMw2taHdtiJ7N3?=
 =?us-ascii?Q?r4IJgTa+X8rLcqW+VvamMpbccy10lq9A+sLYy6hciJa/pzZhqvST1mIA0VpZ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e2485e-24c9-4601-3f0c-08dbb2de54fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 15:46:58.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcK0ZOQNS4a6dbYRxW8LMM7mmDOlHmCj9eAu4w53yFwPK45cVPlSOq8fGxlmPBmihHyy/2ovWUewDD2SEzeAkReVvZBQJu3xPhx+SlY2ZW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3953
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 09, 2023 at 05:18:13PM +0200, Arnd Bergmann wrote:
> 
> I think a pointer to '__u64' is the most appropriate here,
> that is compatible between 32-bit and 64-bit architectures
> and covers all addresses until we get architectures with
> 128-bit addressing.
> 
> Thinking about it more, I noticed an existing bug in
> both sys_move_pages and your current version of
> sys_move_phys_pages: the 'pages' array is in fact not
> suitable for compat tasks and needs an is_compat_task
> check to load a 32-bit address from compat userspace on
> the "if (get_user(p, pages + i))" line.
>

I'll clean up the current implementation for what I have on a v2 of an
RFC, and then look at adding some pull-ahead patches to fix both
move_pages and move_phys_pages for compat processes.  Might take me a
bit, I've only done compat work once before and I remember it being
annoying to get right.

I did see other work on migrate.c hanging around on the list, I'll
double check this hasn't already been discovered/handled.

> > on address vs pfn:
> >
> > Would using PFNs cause issues with portability of userland code? User
> > code that gets access to a physical address would have to convert
> > that to a PFN, which would be kernel-defined.  That could be easy
> > enough if the kernel exposed the shift size somewhere.
> 
> I don't think we currently use PFN anywhere in the syscall
> ABI, so this introduces a new basic type into uapi headers that
> is currently kernel internal.
> 
> A 32-bit PFN is always sufficient to represent all physical
> addresses on native 32-bit kernel, but not necessarily for
> compat user space on 64-bit kernels with an address space wider
> than 44 bits (16 terabyte address range).
> 
> For the interface it would also require the same quirk
> for compat tasks that I pointed out above that is missing
> in sys_move_pages today.
> 
> A minor quirk of PFN values is that they require knowing
> the page size to convert addresses, but I suppose you need
> that anyway.
>

Hm.  So, based on the 5 sources I listed below, some can be PFN and
others can be phys-addr.  To validate a physical address and
ensure the page is online, we have to convert to PFN anyway.

So for the user's sake, lets consider

Source Data: PFN
User Actions:
    1) If interface requires phys-addr, convert to phys-addr
    2) If interface allows PFN, simply pass in as-is
Kernel Actions:
    0) If Phys-Addr, convert to PFN
    1) Validate the PFN (no bits beyond architecture length)
    2) Get and validate struct page

Source Data: Phys-Addr
User Actions:
    1) If interface requires phys-addr, simply pass in as-is
    2) If interface requries PFN, convert to PFN
Kernel Actions:
    0) If Phys-addr, convert to PFN
    1) Validate the PFN (no bits beyond arch length)
    2) Get and validate struct page

I think the take-away here is that the kernel has to validate the PFN
regardless, and the kernel already has the information to do that.

If you want to use both PFN (Idle Bit) and Phys Addr (IBS/PEBS)
information, then the user needs the information to do page shifts
That requires more exposure of kernel information, and is possibly
complicated by things like hugepages.  It seems better to simply
allow the interface to take both values, and add flags which
format is being used.

The worst possible result of malformed input is that the wrong page
is migrated.  That's no different than move_phys_pages(/dev/random),
and the user already requires CAP_SYS_NICE or _ADMIN, so there are
probably worse things they could accomplish.

Additionally, this allows the page buffer to simply use __u64*,
and no need to expose a new user type for PFN.

Now the interactions look like:

Source Data: Phys-Addr or PFN
User Actions:
    0) move_phys_pages([phys-addr | pfn], MPOL_MF_(PHYS_ADDR ^ PFN))
Kernel Actions:
    0) If Phys-addr, convert to PFN
    1) Validate the PFN (no bits beyond arch length)
    2) Get and validate struct page

This only requires plumbing new 2 flags through do_pages_move, and no
new user-exposed types or information.

Is there an ick-factor with the idea of adding the following?

MPOL_MF_PHYS_ADDR : Treat page migration addresses as physical
MPOL_MF_PFN : Treat page migration addresses as PFNs

> 
> These do not seem to be problematic from the ASLR perspective, so
> I guess it may still be useful without CAP_SYS_ADMIN.
> 
>      Arnd

After reviewing the capabilities documentation it seems like
CAP_SYS_NICE is the appropriate capability.  My last meassage I said
CAP_SYS_ADMIN was probably correct, but I think using CAP_SYS_NICE
is more appropriate unless there are strong feelings due to the use of
PFN and Physcall Address.

I'm not sure rowhammer is of great concern in this interface because you
can't choose the destination address, only the destination node. Though
I suppose someone could go nuts and try to "massage" a node in some way
to get a statistical likelihood of placement (similar heap grooming).

~Gregory
