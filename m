Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7B59EBC1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiHWTEF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiHWTDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 15:03:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003BAA4C8;
        Tue, 23 Aug 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661276223; x=1692812223;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RE32PMsFqXLCqHx1Fguwx6bAZ9+l6WoY6OqyIaj3Pvo=;
  b=CBZoqE0D/JfysxFwob4n2S8UnFBvpjUnUqC8P2e+aTiJvwgeI1P9ArTj
   JZg2bfyMGtqMd2j1ijFR3Nw9m13TIUyIuGK9FCn3rasOwEWNwcDHncxzK
   iHNZBwqIMSsZVZqmLXYVxJKkDWuaFUFccOYa0yHVCdJOv6/89YqFk+S/J
   gZIFO9UXh1kF33MPb733g7Rf4K2wAu00tQVZvuTmLZXrIorhWeY79tB3c
   C5LgVyh7H9DLesHll83xUhMhmwJ7ELYNea3fgmlmvVNdGKcb4wNKFs3Vx
   DUJC4kQQAcsjxLVsUu/ayfQwH6rf9LTpSFUkKV5ikLqif9RhOwP++hdAh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355483075"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="355483075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="937555978"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2022 10:36:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:36:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 10:36:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 10:36:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 10:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Acn0RdbvzrnQGOtw0v06fHJmREkfFyHLXOeQ/kodwvwvwEaccW6/gFDAyieaftzk4GMu367a4/zLs8oaBNav7ObWYOpcRidqE4SlqykFgre76AkpMtg/V4mnzVq/jUmDQdUuB5hK2FJ5DI/5/PeXo54Mz7E7oxN3rEAaIx+5OPbJpD41BgghMRmCTSq0yK/CnFDgDdsrYM+l/vFB8MLziRuboVufn9GV+QLOYJs64liUyhDG3JWv9NT/Zu93OUGOiIWdCjlTblgNtSTHT901mn5s8bF2dai40IgzoSuGlUQmQMUBhwRDSWigvNEp0cyFbtO0wANqcFO5GryMMyF9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTI89WPZi1qFQWpaNd2REPvZPsqBv3HvkkbF3GtrWac=;
 b=MiE7b4UA7qk7jAHgvFg1ObM81VJT9nfPrCs4M9+EGOjy3SObTxihWq/wCvUEQmpzGUF0mbRyoTzqKXqpNBulsd3ZLjQujjlaIRAHUSU1mesef5sch6gKUBdWkmjS+BUNa/YEaQWBwYjy9QIU2E4FfmdNmm7e1XIydkf4DFHqtQRyM+C8hlpD4YJdbXi3FyXM0eAVKN7sBPhqLj1+7lV99XcYglnUZ/mLXav5bHzr5B4+HY2XEbwqEn6MgvGmgQC5NVnbjFY2NjHsiaDjoBSlJPcZwdt1F0vWbQzGQQd6zdpq/phSbV6qz92BIkveefFXKakDRGIKPgjP876Q8QYbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2631.namprd11.prod.outlook.com
 (2603:10b6:a02:be::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 17:36:50 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 17:36:50 +0000
Date:   Tue, 23 Aug 2022 10:36:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-arch@vger.kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <a.manzanares@samsung.com>,
        <bwidawsk@kernel.org>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <x86@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <6305102fac9a9_18ed729442@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220819171024.1766857-1-dave@stgolabs.net>
 <YwMkUMiKf3ZyMDDF@infradead.org>
 <20220822133736.roxmpj6sfo6gsij2@offworld>
 <6303c7f4bb650_1b322947f@dwillia2-xfh.jf.intel.com.notmuch>
 <20220823153737.7p7lpkqsu4otraxh@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220823153737.7p7lpkqsu4otraxh@offworld>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7860cde5-7992-4d95-4ca9-08da852e0fb7
X-MS-TrafficTypeDiagnostic: BYAPR11MB2631:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6T1jpnV0ScCrhS5a91Rl5c6QPPN6Hc2Njb75xpdsmJ3Oz8suFWCl3QtVsx1n+4ZfcKkTt1/WTTkBx0H5JT/uP4bG6mrBFv0sA0MPLApj6aMP1GGvthnC2OFoTo5vreE3zNvRIBenl4/zIwNi+6EHVh53j7pZrv7G1neLoWKD8OQjVRgX/j+r8sPCsjE/cyx2N9Gh7IFHbqsIXTE1zWcAORyaMHXgD2mlE+Ez2YoZmA1a85WZRBM9V//bmm0STyUXGAVd/xEJr1h7UcO+iKfbxJ8NxRwMP2+GY8EjCVVjOgfDAGF27CigzHDOA+HbGnR7tOsh0gxJY9kfRGN2zRiqH1mf+pg8mX9mQW7V7Qp32drt+hM3a13igAgx6lHDVjZwOSmGate9+ECid04jIP9PhYWZdzXskYj9uwT8EWKV4m9/d4mP/R9mPOHaBAKbTsFGdpT9S5A8XgIxfdBQk522L3CL4eQrzIiQ/YfWlm5LIvwQjagEVAXhBabGGPC8t+b18KVDtSY6X5TZ34cu5T8SPjLFWNJkvlfIM/S8EG//pZUOY9OhJuuUVdnakUylmGKJCadEnz8ESz2zSdx6iR3mS3cxt75d9lVf7O9ZbLSFpdgzwvReYtF+zUEfr8sAg5WNAdPbYBToU6+9Ztsi8oyzS2ataDF/a9xVwvLW4qYgnXqy3r/8DS2F4xq3AuSXsfKIcU7Zdt++rW4I50tpsMOmvofLCOe5CWGNSJ2FUxd/60U1ZO4ae+VfJ0YLyIEsu+AKJCcQ/RwTHkXkn012OjvvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(8936002)(7416002)(2906002)(478600001)(966005)(6486002)(83380400001)(5660300002)(66476007)(66556008)(186003)(38100700002)(110136005)(4326008)(8676002)(66946007)(316002)(26005)(9686003)(6512007)(82960400001)(6666004)(86362001)(41300700001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVQugM6bzR96mEnMO5VFw4x7mzESdQXckbgU2uUwOMbq6VcWxFh9l3zrJDwe?=
 =?us-ascii?Q?OSguVOwjwUuDFDUgoOv9HwtaAQPPcfpu5vWqqHSIv3yiVJlU7QVLeAjo9qjk?=
 =?us-ascii?Q?te1zTKCyKZcXsApmHU3qYnEU/rNSt+zqPE49U2JnLZJAv8jtdThhpjZmx3f9?=
 =?us-ascii?Q?LXSp0+S1LGHP5lhCVoSfyYCENx6wfIG8sngoQi96qtZsjj0kDpTDBvM7YDb2?=
 =?us-ascii?Q?P5/QWv80RM3lM97AUf7xXwbzQZtApMAhTu3WXnP1QQmVHZW2J5SvtYTDQ4JU?=
 =?us-ascii?Q?qgyT44KjyOiNBLaIGlVI/WrQhDMP0w98pwDwMzsKrFR+IhC9GBghOheQ8TmS?=
 =?us-ascii?Q?Bg1c4xaG5bO+fjLw5/neMsVCOb2VoH583t0xoHwMLLDEob3xwYCDJqloxqCA?=
 =?us-ascii?Q?t4LDJRMdeJ2qN22jd1UuB67GCq1ngbmgP52YODdbk2sJ9OvEDdTkbhoRFIB3?=
 =?us-ascii?Q?l3tNMlLmNjhJBNZQy3bQypC/K2DjNmHVwnlTJysV5LC7os0W6hi/3L/MF9Az?=
 =?us-ascii?Q?ewVvPqjzPWOleF+FuRcvP2f+m+53HQISQAqUtZwL79nig8Rbxblr5uqGTeAe?=
 =?us-ascii?Q?Yt23FAmtXeXVRm+a6qqeZBINY6k1zvLtLJX+dR8ygPqA1bEitQjyivEvfqay?=
 =?us-ascii?Q?Tq4qrF0x1La57gtDSbuIpOOChnpJI5mGte4fUzqHK5aFk4egy0uNQGhQACvW?=
 =?us-ascii?Q?BAkA3pJ6gUe+unat9jRfBXQUFzBkFsFBug7x2qrGOqgjK8aQjag5623UdF7W?=
 =?us-ascii?Q?KES658xUMqfxZzwp00FXFcZ1944kX7GK/hxLjVfls3rdOUwocQMw61kifnfI?=
 =?us-ascii?Q?6iDos6xAdKvTNN9aJWh7kZQ2lgNkZMuvVZHxm7vhON0rPGwHNzbV6QlTboSC?=
 =?us-ascii?Q?81TOO/ypsgu1X3YfRbsJZCMypX9hu7/QXkN9M6lpPMrkB0S8m4/IPZFvhCge?=
 =?us-ascii?Q?VaI81N+zQ+4xcYowgoI8aK8Lgs/bBy38XGJRyyFV+1owpPz2oae5HjK+nSoP?=
 =?us-ascii?Q?dycL1uJWnKY1XtBXhvbtzELRW5stGnL/cI2jmLbuCm5g4B1WLzpMVn41hLT1?=
 =?us-ascii?Q?HVKcCzOTXCCBXloLfx5YvNdfCTYgbrExiJbrPYed/0Fw0yO04kcbb1bNyhjL?=
 =?us-ascii?Q?Sbv1GpCchl5nW0wwh/69xupDrvH72xYLHoL9JEIszree+f4HC33pbSUi8/Am?=
 =?us-ascii?Q?R0Q4gYuv/1nDOz2/gSyZQaXpGxHg4TdnN2+NUMUJYgZew5I9wT0nKZo0bIIE?=
 =?us-ascii?Q?mJuZtIgWC2H5AmuFGl7QczfeDly8M7mUUqWrXe8px6z51Nr/pl/+jSmvVF9C?=
 =?us-ascii?Q?SRLN0TlqSmYDVfNjQ+xJLra9WAjron8vpzdhvUFAPdjnE1iG1QST/twRXHK6?=
 =?us-ascii?Q?u0I1tnlhdshTu7/03c5twl6/sepzUd3Bwr1Bnw1MmdyOvixZbpu2gejkwZm7?=
 =?us-ascii?Q?KSoyT3m3T6M0sHQfuy9BI9YSjze+uBNJ56RKDT1iuIkEc+xKJnJxaq+MtkzA?=
 =?us-ascii?Q?H5fcBzpx0cGhweBB4xy8tyAkHHbAREjT1stLgz16yfOGeda5I2Plc7sBqOws?=
 =?us-ascii?Q?z7mx8e6riyf+JGzOVMzL90QuYJ2uhCB1AtSZnRVhmi0EMSgti7TuxE5TuaUE?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7860cde5-7992-4d95-4ca9-08da852e0fb7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 17:36:50.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J34MasPKmQVNVP8HVOU0HZ1iyG9i5BkcSA6Cg49m/nS6S0xTHM/Cf3z/vD3lUsU4kUIFnBBgfqBMEEXSzYzq9fjegLPpiSoglowxaBqANOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Davidlohr Bueso wrote:
> On Mon, 22 Aug 2022, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> On Sun, 21 Aug 2022, Christoph Hellwig wrote:
> >>
> >> >On Fri, Aug 19, 2022 at 10:10:24AM -0700, Davidlohr Bueso wrote:
> >> >> index b192d917a6d0..ac4d4fd4e508 100644
> >> >> --- a/arch/x86/include/asm/cacheflush.h
> >> >> +++ b/arch/x86/include/asm/cacheflush.h
> >> >> @@ -10,4 +10,8 @@
> >> >>
> >> >>  void clflush_cache_range(void *addr, unsigned int size);
> >> >>
> >> >> +/* see comments in the stub version */
> >> >> +#define flush_all_caches() \
> >> >> +	do { wbinvd_on_all_cpus(); } while(0)
> >> >
> >> >Yikes.  This is just a horrible, horrible name and placement for a bad
> >> >hack that should have no generic relevance.
> >>
> >> Why does this have no generic relevance? There's already been discussions
> >> on how much wbinv is hated[0].
> >>
> >> >Please fix up the naming to make it clear that this function is for a
> >> >very specific nvdimm use case, and move it to a nvdimm-specific header
> >> >file.
> >>
> >> Do you have any suggestions for a name? And, as the changelog describes,
> >> this is not nvdimm specific anymore, and the whole point of all this is
> >> volatile memory components for cxl, hence nvdimm namespace is bogus.
> >>
> >> [0] https://lore.kernel.org/all/Yvtc2u1J%2Fqip8za9@worktop.programming.kicks-ass.net/
> >
> >While it is not nvdimm specific anymore, it's still specific to "memory
> >devices that can bulk invalidate a physical address space". I.e. it's
> >not as generic as its location in arch/x86/include/asm/cacheflush.h
> >would imply. So, similar to arch_invalidate_pmem(), lets keep it in a
> >device-driver-specific header file, because hch and peterz are right, we
> >need to make this much more clear that it is not for general
> >consumption.
> 
> Fine, I won't argue - although I don't particularly agree, at least wrt
> the naming. Imo my naming does _exactly_ what it should do and is much
> easier to read than arch_has_flush_memregion() which is counter intuitive
> when we are in fact flushing everything. This does not either make it
> any more clearer about virt vs physical mappings either (except that
> it's no longer associated to cacheflush). But, excepting arm cacheflush.h's
> rare arch with braino cache users get way too much credit in their namespace
> usage.


> 
> But yes there is no doubt that my version is more inviting than it should be,
> which made me think of naming it to flush_all_caches_careful() so the user
> is forced to at least check the function (or one would hope).

So I'm not married to arch_has_flush_memregion() or even including the
physical address range to flush, the only aspect of the prototype I want
to see incorporated is something about the target / motivation for the
flush.

"flush_all_caches_careful()" says nothing about what the API is being
"careful" about. It reminds of Linus' comments on memcpy_mcsafe()

https://lore.kernel.org/all/CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com/

"Naming - like comments - shouldn't be about what some implementation
is, but about the concept."

So "memregion" was meant to represent a memory device backed physical
address range, but that association may only be in my own head.  How
about something even more explicit like:
"flush_after_memdev_invalidate()" where someone would feel icky using it
for anything other than what we have been talking about in this thread.

> Anyway, I'll send a new version based on the below - I particularly agree
> with the hypervisor bits.

Ok, just one more lap around the bikeshed track, but I think we're
converging.
