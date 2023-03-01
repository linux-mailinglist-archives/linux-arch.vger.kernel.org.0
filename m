Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329816A662E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCADEh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 22:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCADEf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 22:04:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D14D51A;
        Tue, 28 Feb 2023 19:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677639874; x=1709175874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MyXZ0n6fqqjqXD/catrwMm4mYd21Yu1WXiwLP4LrLOA=;
  b=nD7yLbVc4Dr1VXmbtoqJKDTi0H6dhdkivZ0KulTWgSDzV4Ce528D7Wo7
   RtQ6HZpnxQzHRdOQrxMpPpCVMS8FpbV7YuRHW1U/ddXXGuEh/2NAoq2kX
   am9hdBojFFehAubtnEFVqA3C9k3Ii4ogIzi+xR9bT+jTpoiba4nLtrYd9
   pfQbcRalS93+K26KqyoDpkOsZjsW/E9dPvqrqEikuMDnrmjwTQbRvMhNQ
   PrEblrqXJ4Bo7eepql3Q2Yv6sDUJyTD3s83nmoZzdCDO2RsiWNX4pEQ9F
   ZuovbTJFEsMRCLj790tAlVvkNF/us7giMHLWO2/j1TlzQwLiFm55C/T85
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335796553"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="335796553"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 19:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="624310330"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="624310330"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2023 19:04:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 19:04:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 19:04:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 19:04:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc/wZ+0/G5fTGjSjn6N8FZtPnrYTkNc4HUuqcLhgvqJZ3TyB+qr0AoBKkO4uBblYTd8a96eZuJyKOHIkthVOGqPKEKBdcGs7g9Y+vmYMb8ZkhVe0SSYpdxWOa9a5bIhqVktNAZ6aO7XaJZgrUzDdozfmjxDfosfCi2tjrTwp9Zm4vlzS/WpsEeNyphSlMpVLZsX0pfQjAoxu4YB5fz6fd4BiOdZpKqWuygXIlunjVMEaqusD1/CkwLf5MaJ+AF00TBLWcWjwUVi+ot9JXQGCqS5aumZlCJe2DqSxoTSZz5TZwFXhnlv2j5qUSpAJ98G8S9slm7JFZt7HmYqz2LZ4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qm/iHretRBksm5tcu68Hh5uEiWw6HslA6UCMOhZwdw=;
 b=MfRyK8Xv7qnNU+8mb4y7f8k2OKFIrMS7jKAGRMFiHbPQIKEdJ8TBWj9PXHEzONayp9lUh/chl3r06Pi9DxsJwYFqknq39GG9LS/qXNIcLZP2XRK5Ls5VmhBmH4h3wSXabTdFvB0TUiR5VL9i+rpPH+oStttfCR9ItgtaROqcg/u38+mKGV94rLjtmw+YDxJgdN9JNZfo6ScbLzXdrY0ZDXvR9fa664iDV027x3hgHFnZkdXtVmmQ3t72tw/cJ7raEQGhwcpfJmMOkgCFqvURQ88rm0aSWtJ4mz4URQDbz1Av42YooCbpFxKSC/LqkIEjsQdaUBMz3SYZUQ3NSeMU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:04:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%9]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 03:04:31 +0000
Message-ID: <b706a120-0efe-00d3-b945-d56a71ea55dd@intel.com>
Date:   Wed, 1 Mar 2023 11:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 32/34] rmap: add folio_add_file_rmap_range()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-arch@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-33-willy@infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230228213738.272178-33-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c88aca-108c-450d-cd40-08db1a01ad7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntGj4nRIt2k1NBq7JqScp7iYuSMIwAM1Wb3Hqqwu9WopcKZsY0Wm63jPBucuvl3JmxbubN3nMKjDxW2eK9AqRPKm/IUKEll48kCZuTFFnliwVO2J2ZF5Ydg2uhgqK2bXM8lBvfC4tinLNl/YbPiyWsnC1/4zcTc/sh2atjgK1u7CAaCNHfScEsNtJbT37JvvN1iU47Kj15f4Qq9e9T5ODSW995vJ5w26sZyRSXq1bZsgtolLCRgs6JeSH/GpI4WkQk8ssFw+JQa9hkWITm/Vyyyw0u+5Ww9WL9W/6Mj+uKg3UYDwNuyxyIkKe9KQN3l5z6CuR4q7fscdhLPvMC6JgwuWvBE8FngL3dj75nUrrpTDp+VGXyefpKcYWtSgA3l6nGpEdAnd9eZ9khdcf85yLhrz5wq+Yzozisc4h4P4ypboVZnQhOUSnITJ1VwVkS+BGmkkg2tDQeBDbzKw4L/FBgGSKM6PKggM7dV/7J4AHHVCKCs98GJdYy6ugleU6fgiGEiGKO3a89p9/rHM13E8RZX+0liZKa0tho6O+//Wi0f4VzNQzamCopLGuUO+76z97LLOIY3TSLN7M5qz/CHQY/Gh6yiKGUU3o4ADqAJZWxFummu09P0dstibIJe0GuYlndgpQwH/AaxmU/u5+RnGKvhNVRCGJHjobJh083jTBSGRk3eYcSU/TZRYT8kXnQE77zlQux4tm60RJQhBmRcwh82JIu6KEK/EVuFilsSpQ04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199018)(2616005)(82960400001)(38100700002)(83380400001)(36756003)(2906002)(6486002)(6666004)(53546011)(6512007)(6506007)(478600001)(26005)(186003)(31696002)(5660300002)(316002)(86362001)(31686004)(8936002)(41300700001)(4326008)(8676002)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGgwVHdEeVppOEtqUlJNMFlWQStqK0lHLzUzd2NtKzR5V09LL2hVb3RIeVhJ?=
 =?utf-8?B?ZmY5VFVmZHVvNkRVTXJEbjAvcEhYL1l3QUtJTDZlTzM2MHd0aXIwMDBLbm5B?=
 =?utf-8?B?Q0RIdzlNOTErNlhBMC8wMmJCemtOSG81enVjYitmR0Q3TzJXQTJxMzdoOG50?=
 =?utf-8?B?ZXlBdTVyWUlUeGh0Q29qSW9XOG82UVl5aURVVjlwMGpVdCtwOXptVTJJa3N2?=
 =?utf-8?B?SitLTzAvWmdMV1RzNC9KWnFUV1lrZTNzbDk4aGxnRWRCRkpKQUN5WUJwNEkr?=
 =?utf-8?B?elRrMUpvNkRJQXdoSklDRVNrbTQrNHd4Qk1QaDFnZG1XTXMvWk5rdTNoczQv?=
 =?utf-8?B?aDFKRk42ZDU1VEMyOUUwdmVWci9VK0VsWXV5clliYVYvTG1KYy9Rd0RQR3BY?=
 =?utf-8?B?WHAvSXNKb2RCa05leUNHcXVFN1hvS0s1NXZRdE9aUk5EVklWckg1TXczR3FD?=
 =?utf-8?B?eS9rOUtYbTVCcS82KzA5RUxKQ1hEYnZkZDlaVVZyRXUyZzNsNTdJTWpNMmI4?=
 =?utf-8?B?alk3dHk5K3pFSExhNkRjaEFidkg0Z3dRd05VSWdTV0puNlFZd0M4a0FJOU02?=
 =?utf-8?B?MjdTRWJuaHF2ZVpIbmcwQktpMGhCbU9qUkNsLzVNVHE2UENQa0F3MjJTajlP?=
 =?utf-8?B?Ti9oVTg1clMwMmxmZVA3cmlKYUZ5SHVkZ1lhUnlHK2NIZWxlaHBlMVpXUGk3?=
 =?utf-8?B?Kzkza2ZnNzRqMnhJR041cVRBVVA4Z2U5SnIzVjRlSDlHVS8vMkdmcHdJS3p0?=
 =?utf-8?B?b0JkT2ZtOUk2cW9IRTNRc1c2ZHhGZ1drWVBzK1NLK2dmK0JuYTlvRThDdC9i?=
 =?utf-8?B?VVZ0VkQzamtRYy9qeWpqT1ZhSG0xWlJTMVZXbmFadUpQMmxEcXNuQUdDZlNH?=
 =?utf-8?B?MEdXMGozNjRyblhmTVdFam5oZDNlZmlyN1NhUmIvdDU4a0FjWlNUMFZBQlpa?=
 =?utf-8?B?cWJmN3JMeE80eEp1VUl1ZjBjbHBOSUtwMk0zaGRaL2J6NUREWlZjVzVGTjRJ?=
 =?utf-8?B?M0p5MjJFZXAxNlorck9BZ3hrTXVoRlNnRGN4cFBUZG96L0hKMXBmYW55NGpj?=
 =?utf-8?B?Y0hna3VPbG5wZHRCZXRMNUJVMmxEZjhPLzN6azJFT21KcDdlSk5TRkZESzZX?=
 =?utf-8?B?Um5qSllscFZyQmNyY3RhVUhOUE9DSDd2OUNaNkRqa2dtWmJJSXNlSFZNTndl?=
 =?utf-8?B?aG1qbVpMRHpLSE5JV3NXV1JweGVXWWNsVTNzYjgzMmJXQ3BIVVE1Y0ZnTlZW?=
 =?utf-8?B?SHk1RzFZQk1rbFNjL3RVeWtVNlk2UWNTd09QcWM0YUlieGpSRWdsUHorMU1F?=
 =?utf-8?B?ODNyam1UQkZCdTJiQ0huNERzN0hxSUcxSy9FWWsxTDBPS09zYktnWk91OU9x?=
 =?utf-8?B?MTdEdWJlNDh0bVNBVEN6cnpQWjdBZ1lDUkdzRDM0NXEyODk5MzhvTmZ3VnVo?=
 =?utf-8?B?dmVMRjRROVArdkVPNGw1eElKcklVOWFTeHdhSFY1TllBTzBXKy8rRE05OVdz?=
 =?utf-8?B?eG5oRDdaOGQ5QUFMdEJ5VG0ybjBweVR4cGZwVDIwcFl5UytSUDhTZklWRnhD?=
 =?utf-8?B?SVBTNUZaamdXK1BoQ3kwZDhQOExRd0ZFNVNydkIxNUJZaFk3UEF0cWt4ZUto?=
 =?utf-8?B?Mm5nUW1XSG5VeW1UcDNtc3JUdU1XU1gwelR5RUNVVlpTWWNIbEVhemlrWVJE?=
 =?utf-8?B?UW92VmIrcGlFQlBVK05VVXNyZ0NnOEw1bGVvdlU2TklWTXFDMVJvNEN2NXFn?=
 =?utf-8?B?SnFDMjY4MlNyYzRwV3F4bDRrQi9Kb0NyVHhSOUt3aXhBbW4rMmRuZzhhWjM2?=
 =?utf-8?B?RWFzMXVIQjIwSkk4d2tWUHN4ZnhuZXNYOVNmZkFZTTdBQWc0UElBTUNvcHdk?=
 =?utf-8?B?WkNqbS9MN2dDOG5pcFNDL3RSVU1leVhuTU5VY2pCTnNvY3VvNVRXUjlvVUJQ?=
 =?utf-8?B?VVN5alFFRloycThVTDJrREdyMmZJS0kxVzV6TlY1N3NYek43T0NFeGtoVUJR?=
 =?utf-8?B?VFFQelU3d2RqQXVSS1Bvc3RMcFh1N3haVzZWdmtDbG95MUg3K2dwbjQ1MElZ?=
 =?utf-8?B?V1cwK05rWDByTHY1MzdLcnBhcVl5QUpvQmVyN3RxRWU3YU9LVmFHK2FLSENq?=
 =?utf-8?B?a0ZmMnNmOWgrcDB2bUQwV1c3Ynp0R1FjWU9yb1lYN3dqMWRtZmpjMjFwZDRP?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c88aca-108c-450d-cd40-08db1a01ad7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 03:04:31.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrxIuitCZ257vvqT5eAKts5He2O9VgjNpvp/OeAJPYxm9k0MvXTIND5AoQp/HanJhBxJvDojh7TZv5wIu1Hi4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/1/2023 5:37 AM, Matthew Wilcox (Oracle) wrote:
> From: Yin Fengwei <fengwei.yin@intel.com>
> 
> folio_add_file_rmap_range() allows to add pte mapping to a specific
> range of file folio. Comparing to page_add_file_rmap(), it batched
> updates __lruvec_stat for large folio.
> 
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 48 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..a3825ce81102 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
> +void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
> +		struct vm_area_struct *, bool compound);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>  		bool compound);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index bacdb795d5ee..fffdb85a3b3d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1303,31 +1303,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  }
>  
>  /**
> - * page_add_file_rmap - add pte mapping to a file page
> - * @page:	the page to add the mapping to
> + * folio_add_file_rmap_range - add pte mapping to page range of a folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @nr_pages:	The number of pages which will be mapped
>   * @vma:	the vm area in which the mapping is added
>   * @compound:	charge the page as compound or small page
>   *
> + * The page range of folio is defined by [first_page, first_page + nr_pages)
> + *
>   * The caller needs to hold the pte lock.
>   */
> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
> -		bool compound)
> +void folio_add_file_rmap_range(struct folio *folio, struct page *page,
> +			unsigned int nr_pages, struct vm_area_struct *vma,
> +			bool compound)
>  {
> -	struct folio *folio = page_folio(page);
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	int nr = 0, nr_pmdmapped = 0;
> -	bool first;
> +	unsigned int nr_pmdmapped = 0, first;
> +	int nr = 0;
>  
> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> +	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> -		first = atomic_inc_and_test(&page->_mapcount);
> -		nr = first;
> -		if (first && folio_test_large(folio)) {
> -			nr = atomic_inc_return_relaxed(mapped);
> -			nr = (nr < COMPOUND_MAPPED);
> -		}
> +		do {
> +			first = atomic_inc_and_test(&page->_mapcount);
> +			if (first && folio_test_large(folio)) {
> +				first = atomic_inc_return_relaxed(mapped);
> +				first = (nr < COMPOUND_MAPPED);
Sorry. Just noticed this typo which was my bad. This should be:
				first = (first < COMPOUND_MAPPED);


Regards
Yin, Fengwei

> +			}
> +
> +			if (first)
> +				nr++;
> +		} while (page++, --nr_pages > 0);
>  	} else if (folio_test_pmd_mappable(folio)) {
>  		/* That test is redundant: it's for safety or to optimize out */
>  
> @@ -1356,6 +1364,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  	mlock_vma_folio(folio, vma, compound);
>  }
>  
> +/**
> + * page_add_file_rmap - add pte mapping to a file page
> + * @page:	the page to add the mapping to
> + * @vma:	the vm area in which the mapping is added
> + * @compound:	charge the page as compound or small page
> + *
> + * The caller needs to hold the pte lock.
> + */
> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
> +		bool compound)
> +{
> +	struct folio *folio = page_folio(page);
> +	unsigned int nr_pages;
> +
> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
> +
> +	if (likely(!compound))
> +		nr_pages = 1;
> +	else
> +		nr_pages = folio_nr_pages(folio);
> +
> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
> +}
> +
>  /**
>   * page_remove_rmap - take down pte mapping from a page
>   * @page:	page to remove mapping from
