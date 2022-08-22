Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8259C5E5
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiHVSQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiHVSQ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 14:16:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F81DA7A;
        Mon, 22 Aug 2022 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661192187; x=1692728187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9+6T541/iPdWZSxW3AxdY7Wknt3iExDekbSKIRCRZb8=;
  b=UnD8VdWcTNmvH3wszDL5/4Cf79WH6FWVmjicchV19iW+pzW9Fo6O/PkN
   hOVJjXhZ2fdAp0oLaBguMCwZHXlIkOpZb/PFDhe2OLEkWAexlIP5ooiFW
   /asXUZLStkJWnYdN7G6cs+qBPCEedrwNFQDnwtBYs422KQg/6syxt1h+p
   OtCq8aXNTXZTqcY+PUTHPGW4Xo9WyOPqMn3+XWfIS/I4UxykD4ZYTonPf
   DZsClBYqRg2aHHzz0sp62Lbpubg2HrvSgf5hUIo5bBiFMkl3jdxg6Net/
   flxpMYv5bc/CFRZMSW5xBLcWNsxQGpXnkyjwYNWD+qt7UBw+YRhAZjiq+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294771620"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294771620"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="605386148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2022 11:16:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 11:16:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 11:16:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 11:16:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 11:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlEtDKeDzUyIED94L9d/MCg0Xo5M4I99hiGQic+ZNcEK4H3nU6GOuCOlAq0VTJUKaM2lug9yP/W/GZ42IXnIMuRyFC7JHSz7r8/UnNDjiobz+fxPp7ovIw2tbD2tqEYnJsAMrhe0ZoooC44Em1EPDH0AEZCevt6e3wIGWZxNiOl42xX3W4gHJdHbBSkqCUOvqOXLQejbqJ7HYAYdTwF8g3kagVIw7NX+jx5mYLgK5UCbu6TiOZLfkfFW+1kjxbCVz3aAspQ04gOgh8zaidQIqrW26NhUtJ6BnLI/7vKFcQe+b0FQq1vivvfT/5yPWgTMIiaslr57rxYuPP5q9PmW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUbobgIeL/N+J+EW2JNzqR7VBpsA+C0Szxj4pQK7HcE=;
 b=PFwgCzSoFYAfRj6iTVsWU7AUAUU+qZ3exeohnadxOzte9xd1nWCK/3rCu/95Krz6O/Y2gzHINmSPkG6qqR5tgWPH18r83aKxVhFaecnubCVl9hcQUtRPfXneENyBZ+reMzbKSayGo9RgHlONhesr9ydg+aaUy9Ltd1p9K6j3JIdZ3U9id3AhcqTgn9nlzV75tDbYiwrFnA8fdNf+YonPaE//uPTs1kA/1hPgYd6cJcMb/nQ2/DdluuQWrLbyYgOeX7DlwZfoogD934wpPL6eeLVGH/tGNvQMdRubLoDq6nK9vNVxF9EX5SVZ3MIbS1idIRZG0yVGSljvbt58fFvz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB6052.namprd11.prod.outlook.com
 (2603:10b6:208:394::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 22 Aug
 2022 18:16:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 18:16:23 +0000
Date:   Mon, 22 Aug 2022 11:16:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Christoph Hellwig <hch@infradead.org>
CC:     <linux-arch@vger.kernel.org>, <dan.j.williams@intel.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <6303c7f4bb650_1b322947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220819171024.1766857-1-dave@stgolabs.net>
 <YwMkUMiKf3ZyMDDF@infradead.org>
 <20220822133736.roxmpj6sfo6gsij2@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220822133736.roxmpj6sfo6gsij2@offworld>
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f61af3a2-0bcc-43f5-68e4-08da846a6bcc
X-MS-TrafficTypeDiagnostic: BL1PR11MB6052:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTJgDm9DNls3VHBzp5E9IQJlNwYS4sLaGWEnYg51C0A8a4w7yoIX7OvERlKPuDveVDPryW18kggxkTzhDVU/YXMaig9mFOY5VmtRkUFi+zumtjJ4SebZ7KbKWOc4/Vsvk5BThpdzL7bUf3Hp5863HDwb8WKSzC3X/lby1jtuUwB1AS4chTzoVdaAxSBZxN727YDPP6g1Zfqo0VeCBNRYF69jJRat2gi13+iwXWcMiam/n0zInXhoGyO377G6o892jm97TV51ETCQMCZDume+ShQKHY6qTXeuVpfgNu+WWjuuFsITDZeZkkAWKRKQa0yUkf9Fbd+3siXTpigHLk91Jo9Faee6OKNGIK4RBVdgT5yAyny/7gSpCIEOdASwjMvT8mZ63OE+2BVjgApcE8d3sgIZZJ1s/peT/ncI8+dbLVL1/iHc4wipxxUTkZ86fFvVPyox5coMB5ExqOlZaHOJGhzlzMH9VixyY8aZEY69Mgudbzyq/YmiP1wpic1oOhM6nnVR1H5aaZ3pSsyAEwpnp9e7/wuTA+S/6SNj/Ji3cW388e8TgUab6dtTrPlaeleziFtaFtGwb/ZglkYpcGyVbOk8943YTHnD17HRIxXDKSAud7Y0RnF6THKIyA7KfKfML9TmLC7LGlHBTrvFzHG5tM5GvS7YVZlvid95HKPWO2pj4psHPzvQyhr7nTM8HAuscgb0tEz/1DIo4/dJIXkp/N+HrCSQD7QsOeEHsrEdsRNBRup8seNseb2ZWW3DbqQ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(366004)(39860400002)(376002)(186003)(66946007)(66476007)(8676002)(4326008)(66556008)(478600001)(110136005)(6486002)(966005)(8936002)(5660300002)(83380400001)(7416002)(38100700002)(41300700001)(86362001)(2906002)(9686003)(26005)(6512007)(316002)(82960400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WeudPZ1YHpGKtQ3LvlcFYk83UUWA/TamPRZS+1wbL4FNkmzutyfErq8JvMlB?=
 =?us-ascii?Q?7T5g9TfK8UcOPdXm/7CMojwdA4CUOi7GF9rhy1P6ImJn33A4dmRfvyJ4wKAA?=
 =?us-ascii?Q?K6wWlCej1XZ8oAuYKGTkgO4gmGU+7a6mYMOrQKEPk8Lh2+oSyK+75TGYC5TG?=
 =?us-ascii?Q?sURRn+rTecl57Wo+CUMmVKpTC+kKCMY80+3tig41aqGXn0eIF+fITWhzgCqa?=
 =?us-ascii?Q?bAIQoR65BO+QHw6Vsq9Yr169ECElrGa4BDaF3zpeUQgs6jzvxKqzn5ooog9E?=
 =?us-ascii?Q?lJwk7uedc8tm08RNE0dVjhZmXwzipNbKgn7ZBOtFF4oOuroRiWluNj/8ykpj?=
 =?us-ascii?Q?YUv+7y5cTGyGfoQe7rWV3SY2mBumVoPQs22LVaAyqKfR8Lp3yFqoO0pUHB4b?=
 =?us-ascii?Q?a6WCNqTCPKBmEAfsiSfpqvj7kC/s/MWka7HujsMMhj9DnD32/N25qPdZeNCg?=
 =?us-ascii?Q?nIyL8mHYz8rQ7l6fMp+9GkgKMOVkWPxJdnqHBBQ88uDID3s2VAUkb/pnGqNm?=
 =?us-ascii?Q?nEPHTU8vYnFKbDYSf4sMv0KhSSWnVHcLZ8pjCZvhD6p476W1HNPeu0WIgx2t?=
 =?us-ascii?Q?s2tzf+bR/U7GvwJ6FVcBlzar86UbY04lJhspYaRqUqy1QzmFK2jjD0l3PqNj?=
 =?us-ascii?Q?crHtfZTofArjM2sa+pQJcjnFtvD1XnyamI1gcvqdUPj9Bz5yRb7TC5teUKKk?=
 =?us-ascii?Q?WB/bJ+rSDItz0yQoWED3SbndlUf+ro7fkWmAURtZZ2Rrs2Xb5n3qv+vjT1s+?=
 =?us-ascii?Q?XKJwS+77nQZqMRqeVJfJjrj5MQ8arnNg1tnAvRsUm57dH3vc2QJDESgNVTgW?=
 =?us-ascii?Q?23c2S97z3dc6phJLKsDW7sXdg4oTmFJKeKmqNEEOgIiY5tZVz4peaah03nhP?=
 =?us-ascii?Q?iuq/FNeRnM/I/6S/ne1Y/U73DaRN7ufwYndyMQb+EKT1grODJUA5/RS6zf6g?=
 =?us-ascii?Q?YYV+IGxDqLFzryqgm1w9EyFjP3zxmBpb23EnrKEoRJ209DSnMqp8RHbrHONx?=
 =?us-ascii?Q?DWyvvusB/Y+JxbIcFdteP/kbxmatPHKTfkmveSTPqIJKdA6AtR6BeaVRVTZs?=
 =?us-ascii?Q?uhcvXILEwH7yAdjfjd2EkcsBWVyBLfYp3q2o3nTz4wzRfgn7H9NXTAO1s7f5?=
 =?us-ascii?Q?ThIq0JmpgSl5f4c2X5kINOO+KvGWOxYl9z1/OblbiwbqmlgW96hPS9GbmB3v?=
 =?us-ascii?Q?8ysxhEy5WWX+njzpgu15by5JqmLaGihQMyM01r0QbpG9Ex9dMv0gdYZwM502?=
 =?us-ascii?Q?SaAIa7fmEFTZOACwGHUaU2Qa9B9ATHy+3fXqP/IWRUgo7uosE1eE1i7SFcP8?=
 =?us-ascii?Q?ib5toeUIj5O5Z2/qOlcOThwML8tlpoP6+dMPSgkleG6hJGkH9/QNoElaxhBd?=
 =?us-ascii?Q?n4g84R7jGAgDZMR5VWVIDbaDPHVI7DvXQIaWxuotfG3Fhty0FLcFUqaCSOh2?=
 =?us-ascii?Q?os3pLd6vEVcp8SCf2b0jS1Wz21Tt6v57pchEmCkvuDuMbXLKpCWK5qL+Aygm?=
 =?us-ascii?Q?TalCxoxScx+CxcXOEFviyaFLOq19jvnmVAHXmcpm9lbtk3VevZzTTzu5tI59?=
 =?us-ascii?Q?V0EMFN5RVbIP1hc5ZBKe3dggHELn7cNmoV4HyYUAkKfz8AYM2dYVx38I7fQg?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f61af3a2-0bcc-43f5-68e4-08da846a6bcc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 18:16:23.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyieLoLnTL94ZtwPAV8j4WEFHE1WFSe6Dygx6qfHAPi8biEUdz6lDEoVweUyg/wZylalcd7hOzs2+iZnljzLVggtKDFGbYRHjkLQqI4aFls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
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
> On Sun, 21 Aug 2022, Christoph Hellwig wrote:
> 
> >On Fri, Aug 19, 2022 at 10:10:24AM -0700, Davidlohr Bueso wrote:
> >> index b192d917a6d0..ac4d4fd4e508 100644
> >> --- a/arch/x86/include/asm/cacheflush.h
> >> +++ b/arch/x86/include/asm/cacheflush.h
> >> @@ -10,4 +10,8 @@
> >>
> >>  void clflush_cache_range(void *addr, unsigned int size);
> >>
> >> +/* see comments in the stub version */
> >> +#define flush_all_caches() \
> >> +	do { wbinvd_on_all_cpus(); } while(0)
> >
> >Yikes.  This is just a horrible, horrible name and placement for a bad
> >hack that should have no generic relevance.
> 
> Why does this have no generic relevance? There's already been discussions
> on how much wbinv is hated[0].
> 
> >Please fix up the naming to make it clear that this function is for a
> >very specific nvdimm use case, and move it to a nvdimm-specific header
> >file.
> 
> Do you have any suggestions for a name? And, as the changelog describes,
> this is not nvdimm specific anymore, and the whole point of all this is
> volatile memory components for cxl, hence nvdimm namespace is bogus.
> 
> [0] https://lore.kernel.org/all/Yvtc2u1J%2Fqip8za9@worktop.programming.kicks-ass.net/

While it is not nvdimm specific anymore, it's still specific to "memory
devices that can bulk invalidate a physical address space". I.e. it's
not as generic as its location in arch/x86/include/asm/cacheflush.h
would imply. So, similar to arch_invalidate_pmem(), lets keep it in a
device-driver-specific header file, because hch and peterz are right, we
need to make this much more clear that it is not for general
consumption.

There is already include/linux/memregion.h for identifying memory regions
with a common id across ACPI NFIT, DAX "soft reserved" regions, and CXL.
So how about something like along the same lines as
arch_invalidate_pmem():

diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c04c4fd2e209..0310135d7a42 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -21,3 +21,23 @@ static inline void memregion_free(int id)
 }
 #endif
 #endif /* _MEMREGION_H_ */
+
+/*
+ * Device memory technologies like NVDIMM and CXL have events like
+ * secure erase and dynamic region provision that can invalidate an
+ * entire physical memory address range at once. Limit that
+ * functionality to architectures that have an efficient way to
+ * writeback and invalidate potentially terabytes of memory at once.
+ */
+#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
+void arch_flush_memregion(phys_addr_t phys, resource_size_t size);
+bool arch_has_flush_memregion(void);
+#else
+static inline bool arch_has_flush_memregion(void)
+{
+       return false;
+}
+static void arch_flush_memregion(phys_addr_t phys, resource_size_t size);
+{
+}
+#endif

...where arch_has_flush_memregion() on x86 is:

bool arch_has_flush_memregion(void)
{
	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR)
}

...to make it clear that this API is unavailable in virtual
environments.
