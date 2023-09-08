Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7B7999A9
	for <lists+linux-arch@lfdr.de>; Sat,  9 Sep 2023 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjIIQZb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Sep 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346499AbjIIOqi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Sep 2023 10:46:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96518E;
        Sat,  9 Sep 2023 07:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKIMonmuVGMGv+4EZ/dfS1Etbj1fQ/hVE09+J9N3TObRQ3HQ9yF9Mka00FeX4bn7UmAGMi6fmE7Mn5xggBSAhsh3KZCmY+5bzP27FKBXsxsW1B5Fq5EtIUV0N4WQV+xI/mUrNUMgtJbIqe0+qBp3arQyhK9GYhtBiL8z/cjedlg5+KcM/9ANIorjAon7Y7+RLOBClR8K4D1RHUcHOxpZgrF3o+dZNTRwQWOiDvpTA8b0dEKICRy5KFozroDsEkPWVaLjVRhLCb5rvvrwJInBtbUeHQPd+hz/2az83OsHLe9kuCQt64TvU3rKyhoLT4BsVbjH09Ya4hEHbtL3Sc8jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZql4mqlz9B1rptYl0QJIhZbcKS3aeBTO0e+ohRniJ0=;
 b=klVuVtA7mb67Bdmqvlaavco2/op+czKMTMyN2RPF3CUj8z8e7QNPuQUO5WwCdoq8jk9UGABFKHcNFccxunkBx3eA2n4HM0XI3IwLNdrHcrKiWxCSyp1G2tv6biHWuUVqqylMsvoyQizSdmCxaIECwhEGTAF4mdiVTRk7fY36YlNcGVln3orXsM75VrowkRqv2VsitkfiOktMWnd9zZzSS2oa9xpmW4DxW2dXq/Ac6M0EDqMnzUwORaMU3sfmLKdbjwOboKqVRYBkN/cr0BA4E7dTXvirOQrN9Q9AHGQB/44F3c7DxGOAexMOx1VNn7rB4t5yWWyWps9EVxXEkMuoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZql4mqlz9B1rptYl0QJIhZbcKS3aeBTO0e+ohRniJ0=;
 b=zr9vXivklgdGx2P0n4aUfCWD5uFIhelLOjSko383wpPk5TY5aQXRU8li+WHwe3IMs8mNtdM3ipqL5nA/UT7AYoxDwYhWMJBqJiGk2sXzxdz4r4sHRHGjctWD9x/D9NeFXHfjYtQzB0zTK5tLB73k7kRVVogQgR3V1KoXqYSDWAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6647.namprd17.prod.outlook.com (2603:10b6:208:3fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sat, 9 Sep
 2023 14:46:28 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Sat, 9 Sep 2023
 14:46:28 +0000
Date:   Fri, 8 Sep 2023 03:46:56 -0400
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
Message-ID: <ZPrRcJCjRBvJ9c3N@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: adea8fc6-8fc6-48a9-6d87-08dbb1438c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nagrJG63RTf7XGhUlO/hAZlpvhZEZBO74pVHvxh38jcxgHZrQv2arj18lzBhTC4uhBUOKc59DxWLNqG0Eb2JqbzXQURVa9yQCELCMWfY3Oz49/6rDPIvlL2WChBwnzyl+mEn50cdOERQjnnZEJ02es/lLwZhK5BPnLCC4gd57y9F41gwZ2GkipYjCZvvk2puV9JR19DKtLTZq/v/oa51uk4gARfoEvWT7QbB1euo8Z2N4zWz8Fl2t+oo/EAv7pC5qt8/02JbvJ+IFj8E00+vHKn9Fbyl6jO9ij/0AucNuFBgwRp2BKZKW1C8zqPU6xkSHw92ktRbq/GIRmrtoBfq0RLmFowcLO6Z7Pp9gSPCGmdxhanXYvxCA+suV3B/aFiTA5wLFMv4VuKO2I9R2mEQOVHDLR+DSEIjVercgPGCRlAZCEZncIvUm20FeB91WYsuL/ub/ouv9AesW6Lq7EqMficfNwVGL2Cxz70o/wn6DOWKGtbVmKlfDyUfn0MYUjFfouc5v9bNdn2Npb6ExP5uDBTGJgCqUbELM+50z4rCbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(396003)(366004)(1800799009)(186009)(451199024)(6506007)(6486002)(6666004)(6512007)(966005)(478600001)(83380400001)(2616005)(2906002)(7416002)(44832011)(54906003)(66476007)(66556008)(66946007)(6916009)(26005)(316002)(41300700001)(5660300002)(4326008)(8936002)(8676002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HeQ2YOQpG0HidHW3TaMPzdIxRYPyRbMiYwGFmaADSpQoaPhB9cvG27ZoJoWV?=
 =?us-ascii?Q?bg7/KxB8bGFnEqdv+eQTgpG2ZFobnx5xNaqAfO75dDKQZBicr98CfSrvd+X4?=
 =?us-ascii?Q?ElUUSD6pQDLyZrgQfttiLS9QI77bYBVdM9MLqKNftxzYswUCz/GbssgafBGE?=
 =?us-ascii?Q?Kn3b3hnKJJ9ckL9URXpQ+x2d9CRURwU6ESC43EUrdeVnd3E+9belkiQgxF2A?=
 =?us-ascii?Q?nmj5WyO+rcPE8N1jdruhbffNg6u6yYAu8PTHwryJ2qP5as0RTU35szbflKmc?=
 =?us-ascii?Q?7pW0Qnt+UT1MBVImYyaDhxQpVtVaQ23dCCVNtksfcjErhQelZeZ+3PcDOGyx?=
 =?us-ascii?Q?fjssoxCigXVrfP9EFksGx64ynUkDPp0VwlIo7xf2E71f89nN/IDViuHjX6zA?=
 =?us-ascii?Q?f6skP5aRUMlJ3JMTNpaLDVX0m2H0RTY5qi4SBmkxL98ybkTcvPGT5TS4thVh?=
 =?us-ascii?Q?v/3C9xadevyIkMcQu4ftsFUkn7yUxTbuzMqkKkl36aaIIpLky3xusrFbR99D?=
 =?us-ascii?Q?hpZv43phGA6MhnE/sza3GM+AISwQH/O0jCrjxRV5FtC5JlNMxMvKCPkjraGk?=
 =?us-ascii?Q?MYlVwjZh/mAx500yniNF1qg9ZDSuwsOvFsUXalsQQUDXXvDr9m78Hi5KV1xS?=
 =?us-ascii?Q?e4COyXvTppLzi17iAG13VeJMXLN/c3OOsp4zNCAD2ptSdMYKPjPQhu2Cey1a?=
 =?us-ascii?Q?zFYKv44yLmgzfb3ecRa29YYxokbslCdu+F2MgcIxkjLtwnNu9OvABn3fvpVW?=
 =?us-ascii?Q?1PIFipqv9hh3DbVFNfBhzLj/oC33hVm5/k3kbZ/qQAijMiGBd/wfHGN6z5Sy?=
 =?us-ascii?Q?yC+9HB8ezRtjJtw25Zq0fQ/byBbzmF4eep14fVfMYRBvFE5k6DqwNi1CY9nA?=
 =?us-ascii?Q?FGwZn+jAW6IUCkw0CNOVqLpJeLtRXBBI+uV29T5lBrmaDlaUg/oli0D0BGYG?=
 =?us-ascii?Q?AU7Dk1znykv52ewFgPaXkspfG4HS6TpQbZUKdt//yfMD6xrzoxntRW8QP1pA?=
 =?us-ascii?Q?ScPi8u5nLYDEVARbIPhKlWbTgcT1USm9t/xVGnkBp7hIC4xLYClj+++8v33C?=
 =?us-ascii?Q?/Tcr7hiVsSHs6rBS1PPIhaSx+8yj1eE8SjdZZuAdmhSIUi/2oVlUYOP+Nf3G?=
 =?us-ascii?Q?I3RJfJL6/AVXN6H55rLxFldFuuDpClaIBQipLYevuksIPd/kp0+QBU6lJ/10?=
 =?us-ascii?Q?jqF8gwcqNa3IOLeOmJ5MyntEKIAM22DQBPZP3Djhcp+FSZxZelUyFkfgULZF?=
 =?us-ascii?Q?pHOzsIsPvxryjvh0WMNDe4Xz0x/2qzu1+oyZHtx9VLcQ4ZjfrWggMEbUwozA?=
 =?us-ascii?Q?nYh9BSAtXiyR73F/OFBgE6wXQtSUpYMDJwqOXyZZgvpjPTtdjGDLltpK4h6t?=
 =?us-ascii?Q?6qGhPboYrmVncB+YIK/JpqJpOvGUVP47JJnCDLgTH+dBRb/hAH8sWWXCbN2r?=
 =?us-ascii?Q?16EuvtHXuFBi0N7FG5pH2XT77sX4KgAILMfbi7AQvTCNAlVN3UlO5r9XRHeI?=
 =?us-ascii?Q?IjycgzH6BAmqbLKI8JEDXdaYCfI1LRLjsyUEGQIhwsQr/DSf+JySG671fkJZ?=
 =?us-ascii?Q?L241+HeJyIWLzTKKCaPlshc+L4T22ZUcn4CnJmKeo+l0LuEdgCuXat4002j0?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adea8fc6-8fc6-48a9-6d87-08dbb1438c16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 14:46:27.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14Ljivu2u+5OtvaNx5URUk5WVZkgTHW1v/RbkS3SB36UcGO7xuha1nWqlAQyP8ivCAAMthOfzUpnCXfAtrSlzg5l/JwJbHI5u/6DvJOerdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6647
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 09, 2023 at 10:03:33AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 7, 2023, at 09:54, Gregory Price wrote:
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl 
> > b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 2d0b1bd866ea..25db6d71af0c 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -457,3 +457,4 @@
> >  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
> >  451	i386	cachestat		sys_cachestat
> >  452	i386	fchmodat2		sys_fchmodat2
> > +454	i386	move_phys_pages		sys_move_phys_pages
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl 
> > b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 1d6eee30eceb..9676f2e7698c 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -375,6 +375,7 @@
> >  451	common	cachestat		sys_cachestat
> >  452	common	fchmodat2		sys_fchmodat2
> >  453	64	map_shadow_stack	sys_map_shadow_stack
> > +454	common	move_phys_pages		sys_move_phys_pages
> 
> Doing only x86 is fine for review purposes, but note that
> once there is consensus on actually merging it and the syscall
> number, you should do the same for all architectures. I think
> most commonly we do one patch to add the code and another
> patch to hook it up to all the syscall.tbl files and the
> include/uapi/asm-generic/unistd.h file.
>

I'd looked through a few prior patches and that's what I observed so I
tried to follow that.  For the RFC i think it only made sense to
integrate it with the system i'm actually testing on, but I'll
eventually need to test it on ARM and such.

Noted.

> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 22bc6bc147f8..6860675a942f 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -821,6 +821,11 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned 
> > long nr_pages,
> >  				const int __user *nodes,
> >  				int __user *status,
> >  				int flags);
> > +asmlinkage long sys_move_phys_pages(unsigned long nr_pages,
> > +				    const void __user * __user *pages,
> > +				    const int __user *nodes,
> > +				    int __user *status,
> > +				    int flags);
> 
> The prototype looks good from a portability point of view,
> i.e. I made sure this is portable across CONFIG_COMPAT
> architectures etc.
> 
> What I'm not sure about is whether the representation of physical
> memory pages as a 'void *' is a good choice, I can see potential
> problems with this:
> 
> - it's not really a pointer, but instead a shifted PFN number
>   in the implementation
> 
> - physical addresses may be wider than pointers on 32-bit
>   architectures with CONFIG_PHYS_ADDR_T_64BIT
> 

Hm, good points.

I tried to keep the code close to move_pages for the sake of
familiarity and ease of review, but the physical address length
is not something i'd considered, and I'm not sure how exactly
we would handle CONFIG_PHYS_ADDR_T_64BIT.  If you have an idea,
I'm happy to run with it.

on address vs pfn:

Would using PFNs cause issues with portability of userland code? User
code that gets access to a physical address would have to convert
that to a PFN, which would be kernel-defined.  That could be easy
enough if the kernel exposed the shift size somewhere.

I can see arguments for PFN as opposed to physical address for
portability sake.  This doesn't handle the 64-bit phys address
configuration issue, of course.

In the case where a user already has a PFN (e.g. via mm/page_idle),
defining it as a PFN interface would certainly make more sense.

Mayhaps handling both cases would be useful, depending on the source
information (see below for more details).

> I'm also not sure where the user space caller gets the
> physical addresses from, are those not intentionally kept
> hidden from userspace?
> 
>      Arnd

There are presently 4 places (that I know of), and 1 that is being
proposed here in the near future

1) Generally: /proc/pid/pagemap can be used to do page table
     translations.  I think this is only really useful for testing, 
     since if you have the virtual address and pid you would use
     move_pages, but it's certainly useful for testing this.

2) X86:  IBS (AMD) and PEBS (Intel) can be configured to return physical
     address information instead of virtual address information. In fact
     you can configure it to give you both the virtual and physical
     address for a process.

3) zoneinfo:  /proc/zoneinfo exposes the start PFN of zones

4) /sys/kernel/mm/page_idle:  A way to query whether a PFN is idle.
     While itself seemingly not useful, if the goal is to migrate
     less-used pages to "lower tiers" of memory, then you can query
     the bitmap, directly recover idle PFNs, and attempt to migrate
     them (which may fail, for a variety of reasons).

     https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html


5) CXL (Proposed): a CXL memory device on the PCIe bus may provide
     hot/cold information about its memory.  If a heatmap is provided,
     for example, it would have to be a device address (0-based) or a
     physical address (some base defined by the kernel and programmed
     into device decoders such that it can convert them to 0-based).

     This is presently being proposed but has not been agreed upon yet.

~Gregory
