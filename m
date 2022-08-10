Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880458F369
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiHJUGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJUGb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 16:06:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4D72847;
        Wed, 10 Aug 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660161990; x=1691697990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JSG3ixkP4bVprOhaV3jc/IkrLsbznj78HQcCvMqt4Mo=;
  b=HSwxGEVXEYc7cew519bstJ831UalONk7v3zj/4uEygbMl1Qv/QMVpnvj
   Hbra6bnZ6S23Ms8tLUJIfM7toDGjyv40HMLmKazTsXLJ+7jD6STGRJgA1
   ouQ/U7ol+Yx3D66UWvnRkqKRyaYRpc93ZOXwzah/XP4ioYqqCmzvEJjxy
   ohNoMw9Y6pmOK25/VUTO83pou4SctbgtiCOMJnYPv+jWmzuk2WfCe6c01
   iD9IvaIH6+vSKxUs/xPmTX8o1qKPaZ1mhjmInmIls+aPF8Mhks/YIS7Mj
   o4AUO9Bh/HzVmE9gCNHpZm+PJBP5k9BMRuaXrXb05wqkIaclSyiCwJMZY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="288748120"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="288748120"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605278700"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2022 13:06:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 13:06:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 10 Aug 2022 13:06:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 10 Aug 2022 13:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKH4uhaEgOThfeZxCCuy2OojvO4S7dEngTDg3F3WiL9RpXcF0IrB8uhfUdkC7QXUZ9OYTK5MNyK4feVyW02eBYUKNPN8ZLR06BkBTc6FFAcu9rT/wBGcypC6t+WoNyXs2d+cpj6X1ZpqllxpdadSULOZOIoTn5EHYQENhzNip8qbxkyyEE+mp6/WNDEdCA7IjL3iaV138ucom6lDMsITXH1WjxuaDGiqjgtvQL6orxhFCTcmzDX8vZWKu60xhn6CLLXpgY6eh1SWr7sz64Jb0UevdhLHGbdLp9FbHT6SSB8eRjvzOajC/KzSrh//NYmSdZqJktey0mOL9kxswutzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLtf6yx3X40oRu8BiFHef8XxdiDYlyU6TWJ8vBLX9bE=;
 b=kceiYmUnJtO0jOw2QsNOmFVBHbxvdC4LbBnBLMwd6ei6PGutCWa4Uy1WbvQtTjiEMQ2vwZCbLA58Q/pVgzUFVabVO77X+Hvm+Om4d6Mok3y7G9wESq/MlZKerDy+zCnjMsFw2tNPvgEh5TfMTLPpgQjO2ZL1isf5Y702+eDyKQB42k2OXzWAUDuS37jXGht4SF5Ry+dDoTmJA2s/+FCY+s2OpXcF5bddk19Li/FPqlqOzORLdPGLkZ8kB9E3wetuadv0iLKnjrJP1Yaajrj4518+Tl764oClSRchuVfKkednqLkO64MdpUIxYhEa39b2SQ6I34RJAYElUzIqz16JuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4428.namprd11.prod.outlook.com
 (2603:10b6:5:202::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 20:06:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.022; Wed, 10 Aug 2022
 20:06:20 +0000
Date:   Wed, 10 Aug 2022 13:06:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <a.manzanares@samsung.com>,
        <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 10/15] x86: add an arch helper function to invalidate
 all cache for nvdimm
Message-ID: <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf4e788-2415-4abf-144e-08da7b0bcac0
X-MS-TrafficTypeDiagnostic: DM6PR11MB4428:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBj5Pb25n1YnYyorc7G430t6MD+ID71oP+xCmOMrWoxxU4QTZ0XY0J4NimAuGEkpS+ia0BdmyhHcWdXLe8A6z8TNMrSDNqcbYFJiED28s09INF9pq0DOltBFmyo/OWYsVyCrRCxhrfZpHL/XqMLqdYl9fsWncL3GjitYzMCKDe4WOYxKHoPtyEZksUd4G1Yca6PPg7iSH2OMVH7VCP/gMIIIDFCKylu7jH/svvlbvG6dTAIxYeAhYJM3CiRcATl+dRi33gTjCq19B5DK3Ud2/nDbgoCsn4mrLVsHrg5WQprFBzn3uQQg18MmOCMXrF3TjRx4SxSGadYBoRuc8hMr6wnmhQKUjxH7m1GzRXrKWV7zUNMfb6PTCh0+pV0RvO3MyEiOIpw3QQCnGtFVnhYVE9kGNgvHg0TUS1tV6ci/LMsMWfbqFhD7xgdP+erZOtpxWfx3hubB/NslsLs1sqWU3CDP5sbBHXpNfTxiG/09sb6+mKNFVbkX+M6Thyta28Pw9NHEpB6tQXlzJ8kUjDW5wue5Nd9MAnPNeiZiRXiVKJB7ws7xl9eklrw8qHxjkULce46h5VUdkGX3usOFI/EMRDNGFQGV5yBt2boi6/cO1wgwKg2xgJNVGh7xNmGm8TQbxGDEEiB/4glXzCYal+CqeTaVoLbsAx73CNLzHzv6t7b1alLibUH8qL48+xqPZ5Qph/BXFWZhfdn005WbLSj1hdPujkMTlHzd3mMH/5gCXueJmP++gF1RXPwghslenlqzohwFO/dOfjej/zK5ztXTVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(366004)(376002)(41300700001)(6512007)(53546011)(9686003)(26005)(2906002)(6506007)(86362001)(82960400001)(83380400001)(6636002)(8936002)(38100700002)(66946007)(66476007)(6486002)(8676002)(66556008)(966005)(7416002)(4326008)(54906003)(186003)(478600001)(110136005)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ou+q66llpaYdKP87bn/g3ggJeN0iZvY7vIz0S6qE56FMIFOdil3UHrc2OC+q?=
 =?us-ascii?Q?rCAkULKRTfU6j/wNzBdczjkDV+JSFqflDYr27uIvNH4EehG5zyQObiUyq+vH?=
 =?us-ascii?Q?nf/n4FWz1CCHFEY3oFk6qFf3oJQxCRf6oR9M3Rcs21TAPO935nRk176kqQ9S?=
 =?us-ascii?Q?8O1NH8lViYhSkjuOkkNZlAo+k6clvfuzKl60pcjsue2dnOp1Vh1nb4jTThw0?=
 =?us-ascii?Q?6UNDF5teIGRwXISKLr1SBsZU5P9pLsBlisTqOaHypRhJEghVyHxoQKDJZKTq?=
 =?us-ascii?Q?LzRlAACurAwFZI2D5zzd+n5a4raGhVvk9TfV2qN8SCKvH8N1yl4DjBA3QhK3?=
 =?us-ascii?Q?A/yyQdMtVGadcHMq/2Pbq4agcrTP8mpk6Ghz71J1mAeMuI4AhMQwnCo1fk5V?=
 =?us-ascii?Q?G2fMMQ8hlg7vFdFZ3K4Wl4fjGX2X7/Ewnf4UKL9tlylEieRCzNSBekfYE1V1?=
 =?us-ascii?Q?pZXQPNvjKAJ4gSwvgh1vuZ7Oed0ROIteSLN/Hv3CgDt+jDW5O/Ap6FAfZx6m?=
 =?us-ascii?Q?1fFNEFm/KTTTRSnMRWSv++zbxUChSBami3d3ph0XPREIDsiUvrbYurPQ5Tg4?=
 =?us-ascii?Q?l+scDZCRvAyOffeRhkZVJURgTcvGg3Luy5/WDkjxZ5L175pu9yIiGnyDd2Fu?=
 =?us-ascii?Q?/NkaipqmzN8CT3zLqzeeB8uio/LkP9TF8Q75/FMr48Pd0cueOqzsDuP9ucIf?=
 =?us-ascii?Q?f4Z5YCnlZbcZMd2y8j/W/ph2k4Bjbjk2VXE2x6MurSDWgcNkmgEccxKu3BoP?=
 =?us-ascii?Q?Nvwji8pPmuaqBss0ebpal8NfTEFO/+LMtVIaQ9XlFWEjBuHCzQ1AqUTjVCPK?=
 =?us-ascii?Q?QJBuuUdAH8KkbcUhL9StoR69Zl0Zy9YGF3iicXYvszn+e1lOOWYohpsoZHl1?=
 =?us-ascii?Q?I5ul9PEaWhoHnHXy4vhMv9Nt9mVlDYwsjAyAD491N5As/vBZRyOtTRbWhxiI?=
 =?us-ascii?Q?hwtMQD+0wPHFn8AIj3QuFxEKYwuv/ysrn5fcbPdjzEb8dhDZDmOR+bJUsw1P?=
 =?us-ascii?Q?VPwjsZ3v0b+WqS+NXfUZLIviNz+rjiRqT+u1RBdBf653AGU2nd72OpEwNETg?=
 =?us-ascii?Q?SYA6UPLyZMPwOVnDC5qqy75PnojKhO4jsDs02kxcZpFzpzReFWqlODJUHpfS?=
 =?us-ascii?Q?InEStDv85csISivHkHj3xVgouF+Z+hjM35mAR+qY7DWQo94XX3VU65+dkc0G?=
 =?us-ascii?Q?5VCeoEwSIYbZd21iI+9lzNFIBiPkwg6AHSYeFO3Yb6q7rGIBgXyXnuGxwedn?=
 =?us-ascii?Q?S0Ol3njq+j79Mh77ps3y6G/T7WCnOL9562obhKZSGHBWi2eMsOTgXX8TNg7M?=
 =?us-ascii?Q?ELpvOTQH/XPWXCbn/pWY8qrOtnWJ/ey7dLUKIB+4RrVfVHdGX9WP7LzzT+yO?=
 =?us-ascii?Q?0EcaSB0sH7Qu4RXKcDt7GN9Pp5KvpfA4JmxmNq3+5E/Sxcj2U242XqPHt5cT?=
 =?us-ascii?Q?pO6JOg3sCOuB78/3yTsQNkZyQVIllWbGvfOBqrYwgWw/R1HWRIuNwKHRcHxV?=
 =?us-ascii?Q?CiNPLv/YBVfj0fNIHln8C24E6etM7KpClwuXm0nVU0WeKEj6sDZSt5FXx/3g?=
 =?us-ascii?Q?3KYrx9K7U9eL+VHmDIL2FOBlawoC327QU1CMx162rvcX1/EMzXpLImKTmNrC?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf4e788-2415-4abf-144e-08da7b0bcac0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 20:06:20.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgjzIoS+oiqQ30hvzizTZ1odQkG+jimVr8eI0iZcLc97Pj+R80CaZsLkanysp5NQl9jJ8kfwbdNsSd1Mk8dlC/lzF4MVqfnFPp6Bg8oWwJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4428
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Mark Rutland wrote:
> On Tue, Aug 09, 2022 at 02:47:06PM -0700, Dave Jiang wrote:
> > 
> > On 8/3/2022 10:37 AM, Jonathan Cameron wrote:
> > > On Tue, 19 Jul 2022 12:07:03 -0700
> > > Dave Jiang <dave.jiang@intel.com> wrote:
> > > 
> > > > On 7/17/2022 10:30 PM, Davidlohr Bueso wrote:
> > > > > On Fri, 15 Jul 2022, Dave Jiang wrote:
> > > > > > The original implementation to flush all cache after unlocking the
> > > > > > nvdimm
> > > > > > resides in drivers/acpi/nfit/intel.c. This is a temporary stop gap until
> > > > > > nvdimm with security operations arrives on other archs. With support CXL
> > > > > > pmem supporting security operations, specifically "unlock" dimm, the
> > > > > > need
> > > > > > for an arch supported helper function to invalidate all CPU cache for
> > > > > > nvdimm has arrived. Remove original implementation from acpi/nfit and
> > > > > > add
> > > > > > cross arch support for this operation.
> > > > > > 
> > > > > > Add CONFIG_ARCH_HAS_NVDIMM_INVAL_CACHE Kconfig and allow x86_64 to
> > > > > > opt in
> > > > > > and provide the support via wbinvd_on_all_cpus() call.
> > > > > So the 8.2.9.5.5 bits will also need wbinvd - and I guess arm64 will need
> > > > > its own semantics (iirc there was a flush all call in the past). Cc'ing
> > > > > Jonathan as well.
> > > > > 
> > > > > Anyway, I think this call should not be defined in any place other
> > > > > than core
> > > > > kernel headers, and not in pat/nvdimm. I was trying to make it fit in
> > > > > smp.h,
> > > > > for example, but conviniently we might be able to hijack
> > > > > flush_cache_all()
> > > > > for our purposes as of course neither x86-64 arm64 uses it :)
> > > > > 
> > > > > And I see this as safe (wrt not adding a big hammer on unaware
> > > > > drivers) as
> > > > > the 32bit archs that define the call are mostly contained thin their
> > > > > arch/,
> > > > > and the few in drivers/ are still specific to those archs.
> > > > > 
> > > > > Maybe something like the below.
> > > > Ok. I'll replace my version with yours.
> > > Careful with flush_cache_all(). The stub version in
> > > include/asm-generic/cacheflush.h has a comment above it that would
> > > need updating at very least (I think).
> > > Note there 'was' a flush_cache_all() for ARM64, but:
> > > https://patchwork.kernel.org/project/linux-arm-kernel/patch/1429521875-16893-1-git-send-email-mark.rutland@arm.com/
> > 
> > 
> > flush_and_invalidate_cache_all() instead given it calls wbinvd on x86? I
> > think other archs, at least ARM, those are separate instructions aren't
> > they?
> 
> On arm and arm64 there is no way to perform maintenance on *all* caches; it has
> to be done in cacheline increments by address. It's not realistic to do that
> for the entire address space, so we need to know the relevant address ranges
> (as per the commit referenced above).
> 
> So we probably need to think a bit harder about the geenric interface, since
> "all" isn't possible to implement. :/
> 

I expect the interface would not be in the "flush_cache_" namespace
since those functions are explicitly for virtually tagged caches that
need maintenance on TLB operations that change the VA to PA association.
In this case the cache needs maintenance because the data at the PA
changes. That also means that putting it in the "nvdimm_" namespace is
also wrong because there are provisions in the CXL spec where volatile
memory ranges can also change contents at a given PA, for example caches
might need to be invalidated if software resets the device, but not the
platform.

Something like:

    region_cache_flush(resource_size_t base, resource_size_t n, bool nowait)

...where internally that function can decide if it can rely on an
instruction like wbinvd, use set / way based flushing (if set / way
maintenance can be made to work which sounds like no for arm64), or map
into VA space and loop. If it needs to fall back to that VA-based loop
it might be the case that the caller would want to just fail the
security op rather than suffer the loop latency.
