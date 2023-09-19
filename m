Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26827A6BEF
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjISUAT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 16:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjISUAS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 16:00:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CDC9C;
        Tue, 19 Sep 2023 13:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imCMwj5lPFB7uMhYW4GZTWzKpFVg4QDxHHTUU5fUbbnQrY9VVw+WDU8UNzn01zCibD3mtjtdlnCCaTSApCou5+XcMHwGgxnidd+zJAUqumcWXRAJCnYUzllL7kd2RkVwACHr1XXKQE1/7HBfYyCZln2iidOX7TPduk7reuYiUY3J/MaoUnpPJ+/VXLmZQnK5g0YE9or1XgU+fF96ESp+T3C3rbt14X0fddgKdTvRBEsq7OANE+NIkOMFYJma4qumKWFtdr+snRO5wBseb6rHqRxYJ6QeYSQ4sYGPRu9jSwW8U8otgxFnpFY4NQ8b+9glRTfkYq5h7Br3P7JPlliJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M65/YX0u+OL9gq+V3+q+iaPDBvIjibRRGKWVvpbHrKM=;
 b=fHLRwpr/xXMTtjdEClTB+5cg5BNJq9hHzW6xbvG6atlODiRPxZRLB7GjMEa3ejPo4Z4CY+IYdF8BiHZal98WbTVbQ8iBE/1sHtGbEQSCNf/LGX8HzsbZo/lrgmChX2fHcC5OEi8NB1GVa2VPyyyfpEqeW4/lGmc2l3+LEpaIUNXyPNTkoGJn7fGKswk1Z+W68bgHTBJ0H2SgqHFT1hf3hYW0u31i3vJvCTFPOlHDFExrEX9yf4Rz3Sv0ItJfFK+DHztO6/w9zTF9KBh7jhWIwbnBPOXbb7yZME1Qstxlh9WehHLtUxpiy9Le8pKqd01rwJYQdtl1PfqWEqErA2iKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M65/YX0u+OL9gq+V3+q+iaPDBvIjibRRGKWVvpbHrKM=;
 b=EMZRJ+5zHQtBybDxv8g4MIrFUcn1XB+DoVMGkzLYJAl1mQJKlPUp0ezIsjtGIwZalqfXBA0RDfXH0VF6pXtsPkF2KYar3JJgufen77ZXbQ7bCeXTT73yTsrXW4AvVfwbyJvvr7kB9nKOae82jtCE4dzzOdC+rQQjp3chlVSNRz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6309.namprd17.prod.outlook.com (2603:10b6:208:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 20:00:07 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 20:00:07 +0000
Date:   Tue, 19 Sep 2023 15:59:57 -0400
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
Message-ID: <ZQn9vfKGB4pqvYsG@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <878r9dzrxj.fsf@meer.lwn.net>
 <ZP2tYY00/q9ElFQn@memverge.com>
 <42d97bb4-fa0c-4ecc-8a1b-337b40dca930@app.fastmail.com>
 <ZQnMzD26VI3C/ivf@memverge.com>
 <0a7e3ccc-db66-428e-8c09-66e67bfded51@app.fastmail.com>
 <ZQnmVI0Q/Al5UKgQ@memverge.com>
 <1b7ea860-55e2-48fb-86ba-ff3f9f6d8904@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b7ea860-55e2-48fb-86ba-ff3f9f6d8904@app.fastmail.com>
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 909bc047-6202-4af5-b681-08dbb94b0517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyZLsuXCAiGwtWIVCVeUT7gyVW55Jf2DN3XMaAE/lb70GzNQZZS897EaCsY+vbKc6nEqDXxVb1gsENXGEiTPex0GVVhl0qIxO6CFKq1AHZMLuXjLZig7Oi0M549FXBvM1OrQyqOEHax/RKwQ/BHqzQcIJHQquLiA+CL/U2DG+InypVho+0LtiMxGx9q7L3vnWyKe83GfNTuwA19cHjo0W5gDwR3PojwEPLg/z3jOK07Cn9CoIKQQZw9NlPayXYhaujmOC7ZDJ+GdlwaFKm4rmd0h12m39o1AuaAT8toDUlgHjto1027PUA+Y2kBkwMn/iV/jLRjLTWGptD3H0al0zXNI38LSO1kt2v+fKsrPOC/NoOPdWMYwgNiJaPeJ7OR7WQh80ke7U9XPi2yZ0xxhuPq7v67L8lIOrgXkNJ+7Orwh79R8TD5zG19libQqTUY9ZhKkUVg390z811kABLdNbWEpMnCA4xhzCZmRsoQiXlvBZHXQ2PWNnpRzXGcIHm5jLRIND207wfQZD5k+ZHFXU3uI9UFKBoqk0E6XCFnAWP3L4f+5Sl3Q1ynZ7wF5LFuY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39840400004)(366004)(346002)(1800799009)(451199024)(186009)(478600001)(6506007)(6666004)(6486002)(6512007)(4326008)(83380400001)(26005)(2616005)(8676002)(2906002)(7416002)(66556008)(6916009)(66476007)(54906003)(316002)(66946007)(5660300002)(8936002)(41300700001)(44832011)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEphRC9RSUNkL0FjZktXS1ZxRlJPRXM1eEowa3NEY1MydTdYQlRMUGcrZTJI?=
 =?utf-8?B?RmpVY2FoU1NYK0ZRakNuM0d1U1JYT0pOSitoY25mUW10dDJkWTR3MnRCSFlB?=
 =?utf-8?B?Q1M0N0lXbkdYSWNBbHdGRmtJU0NpYmgyWDloUUFLai9Eb0o1K2hzbkF0V2k4?=
 =?utf-8?B?eWRNSFRKbGlJWEhOcVJ1TXVCcVhQMWprVlVzcWdTeGFzQnFLMFNua1gzOStE?=
 =?utf-8?B?U1d6YWs2SkF3eGlZaUdCZ0hGQm9YU294NHE5TWZnSExWaloya0t3REV4clNj?=
 =?utf-8?B?ZW9LTk5PRzhZQ0djVFd0M2ZMaHp2OGsrN1J6cVcvQ1hZTWhCeWhQK3FGTXJi?=
 =?utf-8?B?Vmk1ZlFFRW8yME5UY2IydlgrU0RISkQwNzhub1JmcUtmRTBTT2ZQTVdBYTFM?=
 =?utf-8?B?cCtkOFpEMXFqWURnY3ZvMmlTVE9CNXFIaU1oZUZsemlOYTZkZG1lWUpDMWxD?=
 =?utf-8?B?SHUyWHY1Zm8wbUQ1UzlJMWdhRWZkTnJwUjk3UkZ2dzNyRzNRSGJUNnVLbjla?=
 =?utf-8?B?aXY3K1RBL1YwZXpwdGVXNHJuMzYwU1pyN2VFRnBXWElGN1NUNWlndDlQb2FM?=
 =?utf-8?B?dzUzNkNXY214eElNUHk2NXVSMVk1dW9QVU1GR1NadGhERE9CNVJxQ0tDejZx?=
 =?utf-8?B?dkx0SmxvRFVmWkczTFY4WFVvOVQwdXQyUFZ4U0pJemFERVJyM0N2eFdFejVC?=
 =?utf-8?B?YVZQVUZ4NnNtZnpOQUhUcnRsREVoQzNGemlQYWdQa0NIQWRZdVlnYVB3UjBa?=
 =?utf-8?B?WHQzM2ZwWWtvcjFSVkFLeUVyYVJGWGoxemVqTDhMTmRXMjRzY0F3RHFRRHZy?=
 =?utf-8?B?ckE5QllXZkhTbkRYMDBjRDRIMHVYOUVGV3ZodEMwZ1RZbkNSZXFXcmtjbEZh?=
 =?utf-8?B?ODhLSjYxOGhuTnBJNzZCbFRPUHlnbHlZdVEyL3NUeStRWG1ZU3lEQTJvRi8v?=
 =?utf-8?B?cjVOckpVaGsraVRjUzNjakVMVnQ1MHhLZ1ovMEhndndWOHRtM3l6cldOTlo4?=
 =?utf-8?B?UTZOMFBmK3ZZbDhaUVNLY20zajJFSmRvcWdkWEg3Nlhnb2QvV2QwbFdodGpW?=
 =?utf-8?B?WUl6YVdpcGFBM0xCa3ZPUS9zU3hHTzZsOGdEcXkzOFhFMzRKcWFsV1FzZDhm?=
 =?utf-8?B?TlMySEdHYS9hWVpXYWczNUVHdG1mV0IrcHBoSCtnWFllMmhzckxGTkFKNzdB?=
 =?utf-8?B?aW1ZR2FZdjJUTmJxOHZVZlo0VUEzSThJdjdOQkVLdFdIL09TeFFKcXFpa0Vh?=
 =?utf-8?B?NG54dFBEdmlSZU1ZbjBySmdILzNRNkpkTHR4ZXRKbkpTVmhIMVJSZTdTWmxX?=
 =?utf-8?B?eFlrOWIwczhSV3ZKb05QWFNRdGhjaVhRV24zQ0Qwbit5M3UyTjZNR2RaR0U2?=
 =?utf-8?B?cmFuWlhIYXZDTU5IemJaUjk3c1ZqYUlwRUE1S2QxbUpvTHl6TVY3a1loR1Nv?=
 =?utf-8?B?a21tNkxmZysvNXRKaUxiUXZrWkJycklKQW9pNE12NTdtQkxSNEFsWDQ4L1lM?=
 =?utf-8?B?K2FIOXNnbnB1K1NzVUhEZG0yWGs0bitUQUFoYVRCR1d3RG9TM29FWmsxQW9D?=
 =?utf-8?B?akxJSHdENkRtMzhWdHpIZ0VvUERoa1NzZ01sVW82S1RWdExlK3dYbmx5NFMx?=
 =?utf-8?B?cEdKdzUzRjFScXZ1bXZuVkhXTkpGK1A3L3hvMUVEcFA0T0V1NjUzYW5sOGIv?=
 =?utf-8?B?THlnRmFaRUZkOXJEYTQxMy9oS1F6a0NsandrYzhBSGl3YjQvV01HclYycVBZ?=
 =?utf-8?B?Njl2RGd0Z0hENUpSRGQwZm0zU2lra3hVb3ozNlEyTHgzTkZjQmI0bXQwRVdT?=
 =?utf-8?B?T1pjd1ViaXFjamV5YXp3NXBDWDhTWGJyQnNLSU8zWlFSUHBFWGppYkFOTXVW?=
 =?utf-8?B?QnNtM2FNelh4eCt1T1V5Yk41SHh6MmFncWo2V3hTam1BZjg1VGlGNGVVc0t1?=
 =?utf-8?B?K3pZVU5sRHlGamhMZ2RVTkd5TndQSUxMNkJSVzZaKzhQU1VrZmFWTHo3clZM?=
 =?utf-8?B?R3lSekwrZWFpQzVtanFpYXB1ZVNmYzBHVjRFaUNVblVFc2lhQXJRa1lEdUJj?=
 =?utf-8?B?Tm5lSU9qUWEvVDJrbmFSbldGN2xBR1ltVjgzS0Rzd0xoNGhFeU9mRVd3b3k5?=
 =?utf-8?B?c1NHc2R1YjNSOFFGNCtSaFlJVWV4SnpMWHBTaFFSUFYycEZjNDFiQ1hwbUVJ?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909bc047-6202-4af5-b681-08dbb94b0517
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 20:00:07.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cng2y8d2Fsq28j9fp19vI77X0QyXvVclIW0ZwpG9qrpUZAt54ZY82gFoOizYHJwhVSs7ceXyDEZzl7bjgWjDtG0+G8FXdIYDPfEkePsj3hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 11:52:27AM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Sep 19, 2023, at 11:20 AM, Gregory Price wrote:
> > On Tue, Sep 19, 2023 at 10:59:33AM -0700, Andy Lutomirski wrote:
> >> 
> >> I'm not complaining about the name.  I'm objecting about the semantics.
> >> 
> >> Apparently you have a system to collect usage statistics of physical addresses, but you have no idea what those pages map do (without crawling /proc or /sys, anyway).  But that means you have no idea when the logical contents of those pages *changes*.  So you fundamentally have a nasty race: anything else that swaps or migrates those pages will mess up your statistics, and you'll start trying to migrate the wrong thing.
> >
> > How does this change if I use virtual address based migration?
> >
> > I could do sampling based on virtual address (page faults, IBS/PEBs,
> > whatever), and by the time I make a decision, the kernel could have
> > migrated the data or even my task from Node A to Node B.  The sample I
> > took is now stale, and I could make a poor migration decision.
> 
> The window is a lot narrower. If you’re sampling by VA, you collect stats and associate them with the logical page (the tuple (mapping, VA), for example).  The kernel can do this without races from page faults handlers.  If you sample based on PA, you fundamentally race against anything that does migration.
> 

Race conditions are race conditions, narrow or otherwise.  The narrow-ness
of the condition is either irrelevant, or you can accept some level of race
because the goal allows for slop within a certain window.

In fact, the entire purpose of this interface is to very explicity
reduce the time it takes to go from sampling to migration decision.

Certainly a user could simply use a heatmap with cgroups.numa_stat
to determine what processes they should interrogate - but for systems
with many tennants/processes/tasks, sometimes just acting on the overall
view of memory would be better served if *major* changes have to be made
to the overall distribution.


Similarly, collection of data can likewise we made more performant.

Faults introduce runtime overhead.  Pushing heatmap collection to
devices alleviates the need for introducing that overhead.  Use of
IBS/PEBS is (by nature of sampling and a variety of quirks having to do
with the prefetcher) quite inaccurate and costly to compute after being
collected.


Ultimately if your goal is extremely high precision for the performance
of a single process, I agree with your analysis.  However, I never claimed
the goal is precision on the level a single process.  On the contrary,
the goal is system-wide tiering based on cheap-to-acquire information.

> >
> > If I do move_pages(pid, some_virt_addr, some_node) and it migrates the
> > page from NodeA to NodeB, then the device-side collection is likewise
> > no longer valid.  This problem doesn't change because I used virtual
> > address compared to physical address.
> 
> Sure it does, as long as you collect those samples when you migrate. And I think the kernel migrating to or from device memory (or more generally allocating and freeing device memory and possibly even regular memory) *should* be aware of whatever hotness statistics are in use.
>

I'm not keen on "the kernel should..." implying "user land should not".

I don't disagree that the kernel could/should/would use this same
information.  My proposal here is that there is value in enabling
userland to do the same thing (so long as security is not compromised).

> >
> > But if i have a 512GB memory device, and i can see a wide swath of that
> > 512GB is hot, while a good chunk of my local DRAM is not - then I
> > probably don't care *what* gets migrated up to DRAM, i just care that a
> > vast majority of that hot data does.
> >
> > The goal here isn't 100% precision, you will never get there. The goal
> > here is broad-scope performance enhancements of the overall system
> > while minimizing the cost to compute the migration actions to be taken.
> >
> > I don't think the contents of the page are always relevant.  The entire
> > concept here is to enable migration without caring about what programs
> > are using the memory for - just so long as the memcg's and zoning is
> > respected.
> >
> 
> At the very least I think you need to be aware of page *size*.  And if you want to avoid excessive fragmentation, you probably also want to be aware of the boundaries of a logical allocation.
>

Re page size: this was brought up in a prior email, and I agree,
but that also doesn't really change for move_pages.  The man page for
move_pages already says this:

"""
pages is an array of pointers to the pages that should be moved.
These are pointers that should be aligned to page boundaries.
"""

But to an extent I agree with you.

A device collecting data as I describe won't necessarily know the
page size (or there may even be multiple sized pages hosted on the
device).  Operating on that data blind does have some risks.

Some work probably could be done to ensure the data being used doesn't,
for example, cause a hugepage to be migrated multiple times.  In that
regard, if the address doesn't match the base of the page the migration
should fail.

I think there are simple ways to avoid these footguns.

> 
> I think that doing this entire process by PA, blind, from userspace will end up stuck in a not-so-good solution, and the ABI will be set in stone, and it will not be a great situation for long term maintainability or performance.

"entire process" and "blind" are a little bit of an straw man here. The
goal is to marry many pieces of data to make decisions about how and
what to move, with as many (flexible) tools available to enact changes
quickly to reduce the staleness of information issue.

Sometimes it would be "more blind" than others, yes.  In other cases,
such a device-provided heatmap would simply be informational for overall
system health.

To me, unless I'm misunderstanding, it sounds like you think system-wide
tiering decisions should not be a function userland is empowered to do
directly, but instead should be implemented entirely in the kernel?

~Gregory
