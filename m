Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3559608F
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiHPQu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPQuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 12:50:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C36566C;
        Tue, 16 Aug 2022 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660668653; x=1692204653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IpNK6qLUvV/ULSseM9aN7cNAERw/bXVWnBmhLCFn1MU=;
  b=jMXg+QSuxonmKEkHN0ycFJbWpc28MNcQKTPYIl1QSWGgqr16ffKklSmF
   gtMeLxSQ9prlknE5M8gw5J6euDPW6dngOMbxKWxxvt1nV+M+g+H4FHEMU
   dro6giXq68NjdEsAu0Huqt8f8bcoIuoZdDfRTTYONECqiHVjKqd7bDvL3
   tA1nnH3XGi7h2B/GA+VGAdY+3/R9jJ4tivsyEgpEQx8K2T9k9ez/Apv2O
   8tkHJJsFRNopamZ/wwNdhfwcwkYB2Unsqml2t3W10cBjePeh0P9EWWDej
   jL6ElkGmTnA1vPBlgTkq8FXsVi6VNTP59I4TvBOcBvLr+5ZGbUv+zVCUW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293547395"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="293547395"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="667188838"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 09:50:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:50:51 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:50:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 09:50:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 09:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiGOHL9uvdhr0tXWT0eQWz4iAIfKQMtVfCKaAJSvxdkjpPBYoX3nZJMCA8A3SICT8EEIvYTw2lgZxtfS28L2r7ZXW2LnpO7a0wV8Yyw5457bkR4M1vQ2u2iQy+GPKuDa4qdgEcHD2ixGsprXI5YB1uEGmnXs6+b9juaX4fgm4PpoXVVouOkK28QoBzyxtsJ1lFCA+Tt1LIQ7RouDb2N+X0rxzs5niZ5r2Pf6z57uPpgM5sE0U8sODYYgptlZxRce3qc0sbf3aE+fUSzxXYISFHEeHuKKCrWneVUawkGqTuZwEut+oNWwUvoY8krvXjnJCLVVRUeSP4sB5hRwjKmGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0cd4PkPEInMl/GCRJ82j8hD2BZuDsKBg8fpI5gHukg=;
 b=gXRPOw0npHerfMGZW7Az4enT3mUsQmOBdh8FPqj0CLaE1PvJfRs8lCj4MNe3Y/8wmQEsf0yoU+xeSytCwBfy61zg5QCDH55KhH6tr2vGTdiwjwB0u/jopbf4g9ILV4C7cwemqy7Zk4omQSa3jOfNu/4HpzB9jWUegeuLSAak6otw7ais0/mYcVrhh0yzztP3rHdy0UlMvfibbz+Lc2J7JfME8mXx3d5nFUVcvyDKWBf78TN+oIzhGLdQJXcxiqVil6TeMs4Z7OU4LxON3fnYR4osHcJXmBQrshRkwEw1/JQYp5ZRlVPelBNWSFtFqERv/dbAHUZpdv3JVqJ+/aSd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 16:50:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 16:50:48 +0000
Date:   Tue, 16 Aug 2022 09:50:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <62fbcae511ec1_dfbc129453@dwillia2-xfh.jf.intel.com.notmuch>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld>
 <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da25945d-ea8b-4eb8-63d4-08da7fa778a0
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCtGe4Pqvpw98PvoB6Yg62qnkBMcJaXUTxVNfP6GH/r9FsrFa8TEpYkauiuxhyRH4AJDhtCXdtDN+QD0u+HhxCR3daJBzkb0nz1Tq26exyH2v+rpaSNcRrZEXWwn9srSq0GQEE1qcIFDwTvA/tUulBUgw3QCkbTB2z0WmWA5pcFt+cGk8sZAQ2vVLcpdlzxd13vHzdRDY9ER8y3vMSS5JsZfUzpN6UB9hblms1vslUUcchBfn+JjJ81kb+kRUlBaer64ixBTWsomDbFRURh/amv1l/N7y+MY/N7OcocZy6SQcJ8pc7UgCdBMH1VpmAhji5Lu0XeGtQMmrQuSm8VKzB304aukOw4qCjGjn+e/ncxjFJyo5NCJTyNYJxdcmtzo1huEbE6cDoTnBglRHJ/AMnoIf3DyBc1JqQcgNyAb2oL2wYaKiwxq1s6xetClRZ26KUyo/kjou8+2+w94F/IOY8Rpozm1zUwSqnHDq7sd+xzn9yTvuE5KgZgQDvL9qzCL0p88CqbeOnAiQnfJ7a5IkYgcXYbwLK1OmrUZAhiQGEVxCGkCdjDgyswq+XDGQvJc0/SBd3ZUIlVHKACXO46y5Ap9fsidMDsrbVLOYQqHkok4q9vgMvtvbVaP3FcZPpE9spEFRUNkxIzeg83LE2h200hpe05+6e1O01vfwHHPrAt54wkZ4wlLyIfBrzybU2rEsxE0ZOWQV/po3R2yoSv1ye4CNvkN909QmZiD3GmdjVVsqoF358VCmOfPkYxxCc0i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(110136005)(82960400001)(6512007)(26005)(9686003)(38100700002)(6486002)(7416002)(8936002)(5660300002)(86362001)(6506007)(478600001)(41300700001)(6666004)(66476007)(8676002)(66946007)(2906002)(66556008)(4326008)(83380400001)(186003)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3edS/bSC4apiehzqQ7R6DF+STbRV2MjKbc54gFwbWuRo/GiZALUsczUu4wI?=
 =?us-ascii?Q?/iqz/3f1psJdujiHYUKqjzDjnRK6xtBByazbHNYbCo6gbwiAZJjTbhdxZ5jm?=
 =?us-ascii?Q?Lt5NH+QzlsQbISI8R8NwUapNaxyS6nJki/EVNQ9wmXPOWrpdZ0hKvrk7Q7UX?=
 =?us-ascii?Q?nOtbIPsCzH6nMdDfr8vlBcam1E4tw9d4D413R8sp7MbITz7Xia6bAdCMMw77?=
 =?us-ascii?Q?CGwGswGCdJcjZUBClVj/pH99f+fhgxSbu7NdQ/KujgOC3J3bj6/OstiNMNKm?=
 =?us-ascii?Q?7sl5yfx/iLVTaF9JSqnngPGjopr4XlxIZXP1RJQgbZAZOM9G2DHHAZh1tVdc?=
 =?us-ascii?Q?0YwW466DvaNeO1w5GB+8OrMW9oZE1kVgAOgebkbzW0Yo/kwI6WBh0MBBtKDm?=
 =?us-ascii?Q?Wgqb87JTwFxSryw18D9BCLBo3u5j6YL7riHdhuCcbLs2C71dMxvrCm5d6HZZ?=
 =?us-ascii?Q?Bf5cwS83uhy3S0EumMU4trilRozGg5bke0tec1pRJJnUjoKT75J0Tt4MZxc6?=
 =?us-ascii?Q?hlD2BpAAZQ3vLRD8Mug4rXRyUhSuKP6w4gt6z1Djt1Y0EkpY5PeZgxIOsROQ?=
 =?us-ascii?Q?onYmvsRcCTOdoW0/6//9C9Gg2r6rWuTYhO67S1l9nFMJqh+jfDceXIc9CXzS?=
 =?us-ascii?Q?sB5Oe+SdBFNHNfv8wHmGgFGPKjhqJV+3nwhomBMkdUhiIdrCzuf8lypLNwv9?=
 =?us-ascii?Q?T55ErC/BN4s1uTo3lEnh9HmLDR7UpQ9NG0x5sPqMBtzS831XX4yP8N4B/Xcs?=
 =?us-ascii?Q?ox1r6IQEHaAjnA6kiox3/+fohA5nAOQMUBL/mdThenuuyp6o/gc8NMBOd9m+?=
 =?us-ascii?Q?cJPepXQtnHXf+AgrY9qfJtbCcAYdRNJjHbyMDEfWOX0Tw4AuPUX+7XdWTYtX?=
 =?us-ascii?Q?940LtDH89zjHLnq8unKcPmoYMTwwYHVr+4uifpcC0GCH3tSWI6M+HYtbsu4R?=
 =?us-ascii?Q?Ihg2inNUvZY70lR4wk850WU4UO//lRWpgIzGFegVI6FgYdwBmGnjr9Mzcntd?=
 =?us-ascii?Q?Pkru5TELh7UdwiWK1QStNRmCFC7ZVRt+GKwLS4vJ6l7pa/JzlorUh7Tsp1fF?=
 =?us-ascii?Q?AFFetkxSKxTVs1j32ueZ2gTw9nHmE5Bb7ivaprdsUNa3D5G+VYdZFdsKlc2+?=
 =?us-ascii?Q?ctXYaDBJl6+CndzmhEk1eHO78VMvebu2RnvGmskJRv9S3u0zpVbD+L/LTiR/?=
 =?us-ascii?Q?acEdbPhUUxBeXYwAaRAyRaYhgqbSe4BrGb/fXMOdrWizDsRMTABpXReiuV1h?=
 =?us-ascii?Q?yp6IVuFqneDIZQbWWu6phjHB3PSyuWBzbM9ME0E3sucjdBSMx3dCQrsBLV5B?=
 =?us-ascii?Q?2qiPe53MuXQIOMe/OhZSqiHPcFgRuKvNrjNJajcUyhd7oYVOtevVvJq6M6yf?=
 =?us-ascii?Q?E2fqr18qfw6ksppWcvnr3RS8vyjD7OQAL2JhOj+f+T3uLasnw6v06dqve9Id?=
 =?us-ascii?Q?4McwVgDrS9Cdf6+z3arGMQMNaq3YVT+ATC251JH2UZPrQNqy5ugNvIY2jAoU?=
 =?us-ascii?Q?huHsCuqAtuhpI8ZxZxQ6MDaqB+Eg2YJoF7LmJFZ5vu3AYQfo5qbLBT9Urrsg?=
 =?us-ascii?Q?f74/4nfYAmr9pF8G7ur/Gm6S7Pn4edhK+byFoTaeu1OmDZnjxX9Gn93VWbPD?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da25945d-ea8b-4eb8-63d4-08da7fa778a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 16:50:48.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evZdvf3s2WrO6su+43qmSO7R3H2WFJC+h5NpDZTcJzw0q04mtOsiPh9TvMAM+AKVMcR82OS9DYedmoUUugDeDfkclncx7h3Atn+gSII42dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
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

Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 09:07:06AM -0700, Davidlohr Bueso wrote:
> > diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> > index b192d917a6d0..ce2ec9556093 100644
> > --- a/arch/x86/include/asm/cacheflush.h
> > +++ b/arch/x86/include/asm/cacheflush.h
> > @@ -10,4 +10,7 @@
> > 
> >  void clflush_cache_range(void *addr, unsigned int size);
> > 
> > +#define flush_all_caches() \
> > +	do { wbinvd_on_all_cpus(); } while(0)
> > +
> 
> This is horrific... we've done our utmost best to remove all WBINVD
> usage and here you're adding it back in the most horrible form possible
> ?!?
> 
> Please don't do this, do *NOT* use WBINVD.

Unfortunately there are a few good options here, and the changelog did
not make clear that this is continuing legacy [1], not adding new wbinvd
usage.

The functionality this is enabling is to be able to instantaneously
secure erase potentially terabytes of memory at once and the kernel
needs to be sure that none of the data from before the secure is still
present in the cache. It is also used when unlocking a memory device
where speculative reads and firmware accesses could have cached poison
from before the device was unlocked.

This capability is typically only used once per-boot (for unlock), or
once per bare metal provisioning event (secure erase), like when handing
off the system to another tenant. That small scope plus the fact that
none of this is available to a VM limits the potential damage. So,
similar to the mitigation we did in [2] that did not kill off wbinvd
completely, this is limited to specific scenarios and should be disabled
in any scenario where wbinvd is painful / forbidden.

[1]: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
[2]: e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")
