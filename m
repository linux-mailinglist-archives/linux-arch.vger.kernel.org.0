Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0135E5962AD
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiHPSuK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHPSuI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 14:50:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02EF804BD;
        Tue, 16 Aug 2022 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660675808; x=1692211808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CNcQzR4lZvsCNmJOOuudrR6jvRNpPCc7xgDhGRQvKu4=;
  b=ccun/rQR1/mqszXWjuZjpYNW5ksFRUli+MSTPpfcyCSEawCcao35vpVZ
   K4ZmiJxurBVqxqMdIzre7O9OA2yLaKLhECc4HbZrpZnr4tmjbf0lIdGke
   REJ2NALzbxh2rsMVZn10GDZUbZvpobhhJ/bG4i71rf9OYl2Qwh65AGANn
   iOWE8C6fpD12jxlsMux3w/9x/v6C4uPCybHFoymGdoMeEyZtfh4F9bA6p
   PeYIenCwTMXPJKKwAQGjMbDyPn2Qx4a87BAngYO4WWsWvse9L0blYhcmS
   GQ5ZTHo96VFeYZO/B63RJ0d00fbgBew2m9V5AHnzpkTMt9iGOg8VGe0rQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354047836"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="354047836"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="667248114"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 11:50:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 11:50:06 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 11:50:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 11:50:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 11:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiyCGKrWEunVdjEL7xkFSswON7M4rRfEXZ2nmp52oBmcIMmb1mG35iqp61Y0RtFqrNFiQ4Ob2gi5oDFviWiIAAJ1lRH0wH+ZDsAbLQReVVgQAe6rBSfrRcokhizULCCUfUS+3Y8HxRu4akaBscSAoVOCE9HGIQwW2pSCjjPhSmeED+J0BL3zBdatyQO+55RxstktvPn71EpyqvOzCDJ1C0NVofqdBZqQGFhoCwsIqWzttCJXqiKmB7jjVYBfi6LYx9/bkJAQDev2L6V/0yTqicvX7pFQaxCHoZjWACy5dpMxvFJHAPoaNzpV2bT4go72+4+GMFon+1zo1/fueTSLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL2x6cxI+T+AIl7t2EddbuBABTDIcMSy3GEozC3TGnE=;
 b=j0OwUtZTWRrF8eVpOH8dWMruO5VKJfF7+x3Q1PHrLaMpK9tshROmLufe4QUyH4qsfxIZ2cS7soAPk30cB+pxujlax9U2H0ag1p8TE5qHkQKIvYB7x72m/1443fmtCSHHwi9z33Q9P1EtTU0Y+eQDedffbJHh+CcVARkymjhLI/Z1xaNGa0zpqU+zePBsGPxqJ4MP1HWOT+2aMpgtf5nx/VJjjuE4ZXqxJc0GcFtGi7x1gfEThVisiouuTv26zea5qOsGPa7oAWly+np46qZ8ZKQCgRZJGILrD4Zufmj1V3vt4nR5eSOeydudYShWxGm2BqCWgSUh9O31mlEB5h+r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB3228.namprd11.prod.outlook.com
 (2603:10b6:5:5a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 16 Aug
 2022 18:50:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 18:50:02 +0000
Date:   Tue, 16 Aug 2022 11:49:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <a.manzanares@samsung.com>, <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <62fbe6d7b75ae_f2f5129482@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld>
 <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
 <62fbcae511ec1_dfbc129453@dwillia2-xfh.jf.intel.com.notmuch>
 <20220816165301.4m4w6zsse62z4hxz@offworld>
 <CAA9_cmfBubQe6EGk5+wjotvofZavfjFud-JMPW13Au0gpAcWog@mail.gmail.com>
 <20220816175259.o5h5wv23rs2bvcu6@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220816175259.o5h5wv23rs2bvcu6@offworld>
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 727a576d-d259-43fd-808c-08da7fb820b7
X-MS-TrafficTypeDiagnostic: DM6PR11MB3228:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEn9R2p0nysqOgf6Oz5dE26F5WSrTV+cHbi0ADoCn3Q1apH95irtdvEpHGae4yREyxGaG5L7mh+OcsmmvodZGe28FEBlZtPn3eCDiw3g/7LvJeCcjShb3xSpG483bmrRjgGEQgAJA8W2GcJd8LEbdEe7cu/lNlDM9MeGrKWNweT5Mam17df6K5xkqRU+oidt5jfmHDObAZG3d/4RpM0weSx4Ho0oB0/gyDIjfqcxqQibDOHP8xQdA3v3+blVDMAEnnWXVaFRE2a9ExKPl1z6dDiFeZVVfj/4iaVlObMgSObwufZBZk6U2FtwWEmrK89TXe8t1PlqB1/f2r2fD5G6ZcCDd4DOUmrZ33TUQFrV5v0QHtEs/wStPB73CbwcMlIB1MNPliNmdclc0pqLmtpUH5w6kMuKPZ3GhulhGHjgjnrG7yH2/VaT2ihQKuexMlKG8UXi44xIBKEO9o5ofvf9z8iH/d4B6sz0mGhOl0Bv+RIYhyiyCXk5r3KrDvgoP2g6EhXbngxA5DdZ9lWo4KK5dL2kQfiemeE6wXaUgM9wf2skd4+p9C4VP3CQMu8jvq/R1HyzWRBJJZ8wCeqyeKF40YL7xlh6fSRXXkdrOny9cn6s1pw7TolIigI+iq11XtlB0IcRMPLTVQBKh1tvgZpmlv+wWA6Vq6cVwSpbrqVRBvW5YYCwlsJ2PAqQBwk7Lc1PlD2MQ2mqBHcXhmqTferRdqvTzE73pBwkO535AN1UtfgVSuRV9g++EUqoZECavh1T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(366004)(376002)(66476007)(110136005)(4326008)(66556008)(8676002)(7416002)(5660300002)(54906003)(316002)(66946007)(6486002)(2906002)(478600001)(26005)(8936002)(38100700002)(41300700001)(83380400001)(6506007)(9686003)(6512007)(86362001)(6666004)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmOEV0HyL7kuANbLl5GvlXJ1+gtIRaufKnSpDjpftSCM/3SWfonkrKqdjr1B?=
 =?us-ascii?Q?D91lnb6DZhVcSsUu71BnX0Oa3e234PDlIKcCoK8l5BKohkD8xapvINsQqUiY?=
 =?us-ascii?Q?tLZ3F3pjRYmtddyfO96F1Vp6BZ+9Wo27A/UrxlkOWCCck7AdCuct3o537Bng?=
 =?us-ascii?Q?sgLIZkySVMY5opYP6AYESre3gv5LOJ3vP7zrbf9kcl6gTWjiCEB76nWY41rJ?=
 =?us-ascii?Q?4UEviaK5K4/pEvFnEgyD6uTZRzsbv/wmRTV8lW+Itv5JqP4rgroyffo3piVW?=
 =?us-ascii?Q?JM3BLt1NK6v74lrLBNzviZPvpgWVeVJoqRoDp1OJQXELmRmSxxXXDbQNMebg?=
 =?us-ascii?Q?JYjh0Xrf83fvPDiaWu23S7yEEbI9iWJ+irsfPPjUgjHGNbyBynfk9CYta4SR?=
 =?us-ascii?Q?2JOIB+OEZkJv806IlJdS7Crjp1g5pPwPb9+/YdIiYzYA4xZ5MC+qZENqtmQL?=
 =?us-ascii?Q?9cs2I7il8nROzfxxEh2zd4nLRAjA5tX2R8fRQ4NvTiRPhtaho8cwWDeADRAN?=
 =?us-ascii?Q?8A21Fp5UY7RuNpjXOIRgy96pKFf6vTNOpTPErQylmCa/D6eDgEskTreXZkL3?=
 =?us-ascii?Q?8W1mKr6ssmZd6dfSL6yQQgJ2nZ+oyWd6GfNv+EPg4LuHCYRvVD1ImgCM2YrM?=
 =?us-ascii?Q?765lyKawqINY4g3xh5r0UFIQ2PTx6xD4+ZWus+cNFlljA0c0Visq52bq8U9+?=
 =?us-ascii?Q?y0enUYo14P3LbQpuYVuIg5Fkv6ucnIF4C1r5eDTnP96hY1VuYSN6UK1vkIjP?=
 =?us-ascii?Q?gGkgN8tuVwbtsky6hTDNOmkwcy8m493n28LZdgldwixbseFXAaSNGTxyRD6x?=
 =?us-ascii?Q?UUUnOGR75cc95I/Bwj1CyvUMEFVAPmgdYuBGxr8RPsSzNhFdjfJV1+QmCGHp?=
 =?us-ascii?Q?3gJ0btY4vAt1VP1zafLpohZRy6eCR0aZhsdKzMM/WZrKt+8M3nxmxRgTry05?=
 =?us-ascii?Q?HTRyL5TlENOEc8W9mUnrOSzMW0UEaD2XRmuvQ0bbL3JvhXpVji7QvZG8B8cK?=
 =?us-ascii?Q?WfWDD3X0wLzX+tNN93kuecAeDowNQWMR9RQmG6E3XgtFd1ZaGj5SNPpPYI9G?=
 =?us-ascii?Q?yJdmU0smxKLt+C4KWnQ5ymG8hr6sImVuBXhT+CBbu5JHsTMJ/cKznnoFBCZj?=
 =?us-ascii?Q?x0hsdRGCLi7oCtoglZrXXFhNB7oue99y5s4NbG+IkxS217Ro2AcRMmC+XiYy?=
 =?us-ascii?Q?+V5m3m9rM/U/3W+RwGImuQnJkzxHHDBr/k+s7Z39csTLq0EvMCYRd+J5LeCM?=
 =?us-ascii?Q?uTxmfqMgUWh+WXiaTSuZvHmEbYTs4zlT+Vy8cfVGZWB6GZ4Y6JCjd3kHK6RX?=
 =?us-ascii?Q?WjVif8nETxPMeqnQS/CItX9CfNoLvEd9he548VnhsLbCQXF/4o5Pb5NeUayK?=
 =?us-ascii?Q?gkaF2DPl7f+5uZHRIZrGMI8x9ZsaAxa17sQGow1TB+k0H28kwYz/SOyrKM+7?=
 =?us-ascii?Q?sptznEJ1TWecBVA9xEHQnLx5v/paSSZ2AtM9AcnVTkZgVN3v2Nat7CG9o5ld?=
 =?us-ascii?Q?dOUP9bWKwKGhyufBdCNSy1hB4w+I6/J4SlHm7/hHV2ecFZaCwlI8RKagSrPw?=
 =?us-ascii?Q?/PkBI4xTqn4uPztDmKAsA9bAHhl175c1Lpff6Vtwzfe0hgD5YUnklduQRlPl?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 727a576d-d259-43fd-808c-08da7fb820b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 18:50:02.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A75Km2RItXdiJQYU5RiBfAOggyjxBqGj2dwFMIe4RXaK/TJpRsN05ZkMzj7xJ4s++zzNEREpQPflbXQxiTeUzxHR2hIg2Fq8VDVNrhKX9kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3228
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
> On Tue, 16 Aug 2022, Dan Williams wrote:
> 
> >On Tue, Aug 16, 2022 at 10:30 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >>
> >> On Tue, 16 Aug 2022, Dan Williams wrote:
> >>
> >> >Peter Zijlstra wrote:
> >> >> On Mon, Aug 15, 2022 at 09:07:06AM -0700, Davidlohr Bueso wrote:
> >> >> > diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> >> >> > index b192d917a6d0..ce2ec9556093 100644
> >> >> > --- a/arch/x86/include/asm/cacheflush.h
> >> >> > +++ b/arch/x86/include/asm/cacheflush.h
> >> >> > @@ -10,4 +10,7 @@
> >> >> >
> >> >> >  void clflush_cache_range(void *addr, unsigned int size);
> >> >> >
> >> >> > +#define flush_all_caches() \
> >> >> > +  do { wbinvd_on_all_cpus(); } while(0)
> >> >> > +
> >> >>
> >> >> This is horrific... we've done our utmost best to remove all WBINVD
> >> >> usage and here you're adding it back in the most horrible form possible
> >> >> ?!?
> >> >>
> >> >> Please don't do this, do *NOT* use WBINVD.
> >> >
> >> >Unfortunately there are a few good options here, and the changelog did
> >> >not make clear that this is continuing legacy [1], not adding new wbinvd
> >> >usage.
> >>
> >> While I was hoping that it was obvious from the intel.c changes that this
> >> was not a new wbinvd, I can certainly improve the changelog with the below.
> >
> >I also think this cache_flush_region() API wants a prominent comment
> >clarifying the limited applicability of this API. I.e. that it is not
> >for general purpose usage, not for VMs, and only for select bare metal
> >scenarios that instantaneously invalidate wide swaths of memory.
> >Otherwise, I can now see how this looks like a potentially scary
> >expansion of the usage of wbinvd.
> 
> Sure.
> 
> Also, in the future we might be able to bypass this hammer in the presence
> of persistent cpu caches.

What would have helped is if the secure-erase and unlock definition in
the specification mandated that the device emit cache invalidations for
everything it has mapped when it is erased. However, that has some
holes, and it also makes me think there is a gap in the current region
provisioning code. If I have device-A mapped at physical-address-X and then
tear that down and instantiate device-B at that same physical address
there needs to be CPU cache invalidation between those 2 events.
