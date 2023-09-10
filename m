Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5579C101
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjIKVGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjIKOtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 10:49:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F8E4D;
        Mon, 11 Sep 2023 07:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIzcos7kMXgXpXAxyYmpnIr4D4Jul6UY9LqbbNfhAeA9uNb4ZsYBJN4OO7pgX8B8Nnn8aVn1zYFA0Xm0qaU9D8DENj1hZ9OxMU87zZ1yyIMwXSvOkdCwipX8iCPt51aaprvWZYvRGnkMYQBPR0A64x1lUdLz3k1UMupoqPFQLhvdS2fpVE+kZkqwaRo79jSpIZfHXX0qBgaQljUrGebla1xG+5DbZaFhwpT+8iRieNDPgbcIlho0ebeGDLUoQB4s5CY3xQzGvlV9ypoR8yRSvpTgpHPrHSEqq00WG4jVXxnH4xgRQkLxC7dRPbhz6+4gHBrFw6RvuTAnba++nvfjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwJOxpAp9dHs/UVh2VAyV7o4fOVzHIQk12g7qrxAqFA=;
 b=JsZnb9IArXEP4wkGWl7bqPh4azFGx+ndcHHIAyKzHLUs+3esHcngiKoF+jKZGMLdDI0Slj580+AIhM/o3x4xpxhWJk0aqMe5iMhpxGsSSjp41FWUA01tcEb9ZXdzIR0XIVJZzD41myuDDggx5/IRX1Y+ROAZ1QADWpRQuMPDR5p9ccKrUR8vti1xweknB+X+1rcp4s2qnjoLCAIZzJkMpLZa5ExaynPOxGmFxjIEFkexrxXiE2hZxmoDXPd6unBXqntA3ndqeyUO58da5N+LKm1pDVtBvg+g9pA5a35knkTVwGDXpqvDs78xt+HfayMqIdGr1ZVBddMVNtjdLLDaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwJOxpAp9dHs/UVh2VAyV7o4fOVzHIQk12g7qrxAqFA=;
 b=L5vv36E+S2Eiy46cp11EpI3iv+Nb0sihCiaGQUKRKNFz8g1GwFj14dZJwUsSD7nyg5cPBJkoHd0y+ZBEnOHRfmLd/6FBgu7fO5XemP6jIZysfLqY7n6EYFGIJzvuNsFwoQHW8/esxmoSsi9Lnc1Js5zYZQJgTQhioENtXtLfVF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4815.namprd17.prod.outlook.com (2603:10b6:510:8b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 14:49:07 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::94b1:abab:838f:650e%4]) with mapi id 15.20.6745.030; Mon, 11 Sep 2023
 14:49:06 +0000
Date:   Sun, 10 Sep 2023 07:49:53 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZP2tYY00/q9ElFQn@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r9dzrxj.fsf@meer.lwn.net>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 49529720-dd94-4c97-5f62-08dbb2d63faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F2YnYaatLozgTTnAiA+zT53A623jIrd/FVnznolsz8MK2lraogDTncIEAdFg0NvEZrGxAMas3EHRnyG9MFv5ecvqLqgCgadLffAff3xA7eZ6jJ5PL87WeYqzE4BJ2+EspLIBFvvLqqomo1spY/RMGV2CMjffzGSreChrE9z7tFXbO0GNlUezzXzcew4GN358BG6Hqg+nvMOH5os+128d92SXYTBvNNXAm5Wc+x+Lg4RFutovOKFxPCo1WOPgjiub8Lrp6QAGXEy38vIvFgcvDStMmqns4VW3WCHQpTiqaCqQ2mtqG2LO4vTdS3CWCmT3MFAUQn3Vf+/CX54b3JPSzToXTpNRN5oxy/rjrK4gZDy5QjyzQxz9UwxzW9ZJPVyBIzmwrQQy32jFHAikPJM0vj9Bak4tXr5Cta4T1JDolmKqLXznSInTWMVza9JZG6fzl4n8CegLGvNRPzNM6uT9X7DvAPiAWUEDQXfwYyQEYtJbjS0aZdqRFs6kN+VnwPKhpfB4IrCHDnXsvoTmrSyrY+8lBuaNzd51IqpdVSWxPN+/AvSeLD94dyUlAjS4LqO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(136003)(346002)(376002)(451199024)(186009)(1800799009)(8676002)(7416002)(2906002)(4326008)(44832011)(8936002)(41300700001)(5660300002)(66476007)(66946007)(66556008)(6916009)(316002)(478600001)(6506007)(6486002)(6512007)(6666004)(2616005)(26005)(83380400001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbAeylw0XYiavNwxL9peU0BqfDa0gpqui0BzYfAeJP+GIJnlMoHhyf0pmRH9?=
 =?us-ascii?Q?qC1AKZQpzG2wrfvf7I7h4mcWcd7gRcpiUBngbla3W57QJrrH5QFN6PJilZta?=
 =?us-ascii?Q?Jg4vuOjesWBXZ+g/ZcETTGGYP2MJLJz+xTio6Gh3PNRKvmSoXjDeevbC/o/p?=
 =?us-ascii?Q?8jd0ITIc+lH6p4W6B3w66OuKh1/NHzfJVIs9b+jJgM51AHSpEDwU97meoxHa?=
 =?us-ascii?Q?4qKxleVFpIp5FP/idEJ7XeaBwD0T6b7O+DguIdIf8OtjmK1+H2Rp2s/SlVt/?=
 =?us-ascii?Q?ODZAGFB1LT1/IC6JrVknvO/ERBtVSA/JAW7mDgLiSjMVatXIgXLYt/pw32cX?=
 =?us-ascii?Q?WkdeRaRTNV7Ll560jm2mwE+B/4tTu5EpVf+6HKAKtugvjvWCZVC6AHz849kc?=
 =?us-ascii?Q?PSXvaK+w79D8t+v1kUAFRWeiM04+q8vUIKED8hIeJ6dKCG8a8uQel+4LyO6K?=
 =?us-ascii?Q?KplQbKXiKSSu5HH8a75BVl8M1YmaPtUdjXsiSK0vVTDWqVXEXjNLcZIH53hf?=
 =?us-ascii?Q?/OL6Wmco4OmWfDqFrSiizfwYDp+N+qftPXrLHHk+1Oce+HRgwl94trAd3aXn?=
 =?us-ascii?Q?6CpOePlJO4VG/J6CTTsXUMO10aR0c44KzmrQVd7SCYZiGRZVczfBfW5VmUOD?=
 =?us-ascii?Q?A3JYMdYNQdeqIhqL7LsSnvcIHEqz+E604YpPXC0EMtt8TBvxvsKOYTjrWb7g?=
 =?us-ascii?Q?78nSiJIXSg7SJqQJ6K0gTxXARB4p8Zjvn7bM5l1mS6BO2J8XJ+sYFnnaa5mo?=
 =?us-ascii?Q?KRLhvQeRN/H3cBVAfG74eGhDEaNQHOzyJzHHkx+yYasLv1sGDjDEX3xUyZqB?=
 =?us-ascii?Q?u29XyDPmbA43gCb37bd/5XJ1wf8lbRyhFzMBaplv8QuubQss8Oj3ddbpJVBv?=
 =?us-ascii?Q?Ff1o9pmT8oPifVxU/PTmLtPoTbT/vr7rQTO4EnRMQiUWyVjREJAAjlzwQ8ob?=
 =?us-ascii?Q?K/Q2z/dgos8FtoisYxFPAnyCvdizIpScQYNQ2G/uA+un6IGB2cw76GQDgFqa?=
 =?us-ascii?Q?OVgpHkgJVwaWrPQfCG5BdNfEqJV821ySqIc1I0PmVcYfT40/XCSemTBwizcz?=
 =?us-ascii?Q?EKZFum37OsIstB2kaLdDQTDp6taPt5GsHTa4G7p49V2Lf1u0ZRE4dHrKnZq1?=
 =?us-ascii?Q?MEDLGR5mPUjRiLZF7wGXBU71nZMn78AnLd40eTJ5EZU0M9ojktXHyykY6Ujs?=
 =?us-ascii?Q?xbIvoCO/cyX9zSS2KrlqVcgfNcawr4Kn2tFCAE7vg9iYMFowTPICLj8UsrDx?=
 =?us-ascii?Q?km8ekGlRtef3JNYLf9c5tYZ3NmMWLcmO3YVI0AO9qs62LW2NnZLSEja0CxQQ?=
 =?us-ascii?Q?0MoNwYIsGB89N0HIt7ZWB5VcusIv53RygAVTNXwg2NJRFKRFhYYy6fv9k4i0?=
 =?us-ascii?Q?FNKXO+/RwuN0sBjKq0zCwlURzjGadP4F584OPN9MqlP/YoKqF0lXC+VdBvbT?=
 =?us-ascii?Q?L7AC8QPDNw8UH9lhPDVx19UzMUPjy7M2uBdYHpCb21FSD/12p91v/OcylB7W?=
 =?us-ascii?Q?knINWQRkijbeQlhpOSVxclUGaLHCsSKEGU61g5GnYcoPv/DODGrFerwHa3Vt?=
 =?us-ascii?Q?wqF07i7QSKdVVGxTH2QFA8xE5N/PoV1i8XILkEvul/+/+icmnWkdl+CXCQ5Y?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49529720-dd94-4c97-5f62-08dbb2d63faf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:49:06.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOTFPMPUtHFobeRbMW2QLg9wcl7eCUwk9PoWe33cH31Dt2Jz4J7AhWpFDWrYP2+WJoqnqrUakeqAMftluowTt/89ACVbqTH+RzSRs2aljuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4815
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 02:36:40PM -0600, Jonathan Corbet wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > Similar to the move_pages system call, instead of taking a pid and
> > list of virtual addresses, this system call takes a list of physical
> > addresses.
> >
> > Because there is no task to validate the memory policy against, each
> > page needs to be interrogated to determine whether the migration is
> > valid, and all tasks that map it need to be interrogated.
> >
> > This is accomplished via an rmap_walk on the folio containing
> > the page, and interrogating all tasks that map the page.
> >
> > Each page must be interrogated individually, which should be
> > considered when using this to migrate shared regions.
> >
> > The remaining logic is the same as the move_pages syscall. One
> > change to do_pages_move is made (to check whether an mm_struct is
> > passed) in order to re-use the existing migration code.
> >
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
> >  include/linux/syscalls.h                |   5 +
> >  include/uapi/asm-generic/unistd.h       |   8 +-
> >  kernel/sys_ni.c                         |   1 +
> >  mm/migrate.c                            | 178 +++++++++++++++++++++++-
> >  tools/include/uapi/asm-generic/unistd.h |   8 +-
> >  7 files changed, 197 insertions(+), 5 deletions(-)
> 
> So this is probably a silly question, but just to be sure ... what is
> the permission model for this system call?  As far as I can tell, the
> ability to move pages is entirely unrestricted, with the exception of
> pages that would need MPOL_MF_MOVE_ALL.  If so, that seems undesirable,
> but probably I'm just missing something ... ?
> 
> Thanks,
> 
> jon

Not silly, looks like when U dropped the CAP_SYS_NICE check (no task to
check against), check i neglected to add a CAP_SYS_ADMIN check.

Oversight on my part, I'll work it in with other feedback.

Thanks!
~Gregory
