Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AC6BE371
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCQIZd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjCQIZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:25:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B4DDF27;
        Fri, 17 Mar 2023 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679041444; x=1710577444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sj7QSI04yOdoXcjhya42SAzZWKHXmdvxCTXNxtFjVY0=;
  b=LFTXuSiLCTiYBcd9QXWFt62yXuNbkaqx//MMVv6h2Qe97EnPhxyI79b8
   unwPZKKnOYBo3hPhO9UZBeMLsgqV/rHfc706qvd8pldakP8wLd6yF8oAH
   /k06R5aP7fwzS1Y9UGp3JWbC59/KlXFc5kGcHTJx2YICI9rH8x/9JHhg7
   9KwdmGx/zd+xHXXiKeQJz0xI2Fb6+ocU+Cvg80t/u9QMjVQEKIMGwTzqU
   5YgMb7E/WDG/6C9fphlRmO3L9n1tSsl+spTO6vEAB22NRIUgVl2oCkTRL
   lhHmrRNBbr+rnk7Yo7Ghgv77TcG1VR2loyA3O2B6U30UHQWD2Z1/4NI1w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="365909942"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="365909942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854365293"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="854365293"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2023 01:23:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 01:23:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 01:23:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 01:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff4hrnYyn1p8o6/IwrxxdAok9taN/otwC0xd3bf5JS7pK53+z1IC1Su/pnzjShUl6ru1PEdW/13UllN3aFdNhhc/oDaAFcOZlcGk5pZ3bAFVf3uDLIKguB2mqUrVBc27LASfx6QGqE8YOEan0xlaJYoOw/AYrXg87oz5ejn2TpUkBf0iRK0RAG34c2jzeivKoQ+/pLERxoWOWI59+wx5ZiDmyH5bH3BOys9lZCWJZxyTE/SLTdA6nXLLWp+wA17Ql41PfOLWoBpf9Jk35O+rzZgk8LuOlOa8stPYRNPt3fFysyIj2cxX33vl8XIcwkZcvnVTkUz1Wg+rpNI1gqEr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UbWC/9f7qlFKxysDUNhFlLrh/gYq80SKU83y2me5XA=;
 b=DoAuUDVOlbEDNl4Nzrn9s09WE3WHNoSf7YZ+C/FOdo/Xfteb7YgEVmjDrHC97yAXb2a9rZN1zZfhmnI9OHIThGUCQd8SDAUg1wcDZFqfmp+vfzhOSuAJbVcyiFb7MBgdB19p6OT/dTNz5OtKRZuordsOkF+Ihd9k9mwWraXwKoQtvkg7bwcIiGU6ZTcCPP18Uh5/PGJXrzhORbeFz73sTWoj50hA3qBULGl83DubuPsxqTSphnCF/pKUe9onnXm4h2fbz+CrcPgYagL2RnREWdGDm1d4jLlFzg0W6l7PN0ufMY1alsGpWnqaZfoyRj7B3+uXi9OqCNHfvyT+sgsZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 08:23:56 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::b974:36b0:e768:1b21]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::b974:36b0:e768:1b21%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 08:23:56 +0000
Message-ID: <f3ffe13c-321a-07f6-6a6f-1a67f585ffe2@intel.com>
Date:   Fri, 17 Mar 2023 16:23:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-35-willy@infradead.org>
 <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
 <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
 <0f581d0d-3139-4007-2161-592a0a545b50@intel.com>
 <fe743597-cefa-4bf8-aa3f-da9cc10bbd5f@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <fe743597-cefa-4bf8-aa3f-da9cc10bbd5f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|CO1PR11MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a666f6-2b3e-4c23-f44a-08db26c0f354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iq9ETeM7JBEr0WcUvhBWy3IYxju42allo6QUfDx7jTPWejoFPas+Yiqc08gknRfCaDrzIgwo2wKSJIWAvl6TjWf+dfjiuPBXGJeblsYtebCbylhJMxyLY+lbftEbo89DVny7C5JEpOE6PbANKPlL90C7PLn93y/VyXGjxJW/ctyXcsVtx0B1hggRY6F0a0bO2/1HIoPMzIwh/tAo4i0gaAPy3U9+fxKdvNyEZFNBvW6mfJN4feUHU5niUIr+FhHRA3Ey9iCHIZE+6th6QiDfehodNJzmsonBp1EmkMIQE9R17LVBp5zRCnGlWHbquMwuk2fK77/T+mHKNfzs2v2TRDWn0ZG5NKvTERYJHuldAFcJjATiE+dUIzWEDpwS7LPNEEnX3BVDSFUhkSqQYcjzSDsHRDRZ9u4r8PrsLg8aH+Vc1bxmsrmH6rF3WbMdi7JPIGN2dYs4Vvf/aKSlRbr+NDHim6ORyyqk5rXkMX7IPGkFqJ4kFYjs2VhuB3IFVieYotQ2kZJxwWkqfE+h98H7OVoFPYej2HMcgM7iWu6WJfFgvNRTPuWawv0XwmrA7WAqCZAUyekbWbPOOVaI8yRMXIV3YQVut1hHq/K4fT2Ei0e0CFDuW+aIXq0rfIrabako1IAkzjLnV6t+vYIhtY4jfMHTOyOhbVwSZgF1sJ4dffENHbPKp7RrrZO/TczeqT1agBAwo1zSfIMIQ+Al3/1SJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(86362001)(82960400001)(41300700001)(5660300002)(2906002)(8936002)(36756003)(31696002)(4326008)(66946007)(26005)(6486002)(6512007)(6506007)(2616005)(316002)(83380400001)(38100700002)(186003)(53546011)(66556008)(6666004)(478600001)(110136005)(966005)(8676002)(66476007)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lXeEpSZ1dVVkNRQm53QzdPbGhKRkEzbkoxZzBDcG51dEd1cjVnSjcxenFQ?=
 =?utf-8?B?L1lOSkw4cnR6dUhDQXdIM0JHRGJ3WWZJRVRwS2NhOXFqNXBWUVh6djA4bTVi?=
 =?utf-8?B?RDJYcmVielRqUzV2UWc3OVdVcVlJWmU5M1lmeDdhVUUwanMzVFI2QUx3MmNs?=
 =?utf-8?B?RVd1V0drOWladXZFMFZBNHFlSWFUMy9EUHpCek9ObnhxU0gzMzFBUVZ6Qmsw?=
 =?utf-8?B?VUFTT2JXTW9FZWQ2VEVCSGwzSXpJTFBIamM1Wm5wOUEraHgvVG1Sb01LSDBK?=
 =?utf-8?B?eHJ3dlYvSlZLU3pRWWVjYzQxYVhiY0pncjE1NnBWU3EvZVl4dnAwS3FtZ01W?=
 =?utf-8?B?a0p0RWZ6OGZBNER0QjBFTTlYZERibENBd3VsRWNhR1lhYzMwM1I0dHlGaktI?=
 =?utf-8?B?TkwycmdOVVBqa3JoNDQ0eTM5SEpSMk95YUlMR1FoVEFlK1VKTHlzb1hRNyth?=
 =?utf-8?B?ckkzdVlxaWswZ0JqcEpMOEN5eEJCYWNza0lNanJ4WVV3Y1AxQUhBOFBiQUU0?=
 =?utf-8?B?d01CK1Fmd1Z1VEk0YURqN2lFWUpXdUt4dm5CVkw1Ris5V3JXRGUyRzZSeU9n?=
 =?utf-8?B?OWZuZjd3VmtLemlML2orUEkydjZmaUwxOFJ1LzZOS1MrUnVrV24xcVg3dzV2?=
 =?utf-8?B?bzRrbEFzL3BQc0V5b0ZRU2IrNkp0RlRwWURLWWpyMFozZDIzanJRNUxNd3pZ?=
 =?utf-8?B?UTFtaHg2L2FURll4cjA3eEJROGhRUlY3MnZzT1RSblIycURDTWNaK1VjVWNG?=
 =?utf-8?B?MW96Njk0WmQvVVFWem12bjdZQ1ZoTDBhaDZOOGpvN3V2RDNLY05LanhvakZN?=
 =?utf-8?B?NWwvc1JhVjE3aFpVMHpKL0lIeWFDa1p6Y2dQcUQvYU43TC9UZVBSM0tISGFh?=
 =?utf-8?B?MEEyUlEzOFAxc0FVdlY3UlF1NnZyZ1dJcFR6a2gxM1FrdjRZRXVjS0RRb3Iv?=
 =?utf-8?B?QWpWakZaWjlyeFRpZVZ3TklYWU1lQ01uRnJQZzVBZ1N2N25qQXZmOTRDZVRH?=
 =?utf-8?B?NDZDQUZ5RDJEUStmNy9UVzB5cGh1MDg3d0FRbElzTUVIR0VWNTh4K2d0bFY2?=
 =?utf-8?B?NTFoRmsxbUN2UmZuQU5lVFF1dlQzMk1xSzdhOUlGaFVvRmNybWNxMW5SWHY2?=
 =?utf-8?B?V1pxd0s3QWpOVnV4UWlXM3R1Q3UrQktoeUNFNTFWcXBrNXp0V090eVNFL01p?=
 =?utf-8?B?eWQ3emxJZm9XMWpINWVWeGlOWHpvazFuN1ZOdmJRem9Hd1gvMUV4TW4wcVB5?=
 =?utf-8?B?MzFVRS9zc05BTWxTSkdmU0tIVGZOZ20zTW9GR0NGVnovbklTdWNkQkRpbXBL?=
 =?utf-8?B?Sm1KZnZSMHNEd3BGZ0lidlp3U0FndG5RU2xTck9WbXdVb01aVzVSVlhCZjFs?=
 =?utf-8?B?anhzcmRwdWZNZWNsU0dqVkJXYnc1bWlhckNYOHhiaktRUVNjTVN5VVdiYW5k?=
 =?utf-8?B?a251SDhBcW1GRlRmekpBc0NKMENDaDVDdmVTYjVpNGFBcS9MSS9hV3FHWXlU?=
 =?utf-8?B?cDJQT3pYdjU2UFdUbG9zbis4OVRkTDZiRnBQYWlIRDNEa2FKRVo2dzJvQ3Nw?=
 =?utf-8?B?TVg3Wm9wTnQzVGxiVmJSZDhWbDM4RytvQVBLaGNIRkZvOGZlZC9lWk5vQ0Q5?=
 =?utf-8?B?UVFpUDJaRFhuU3A4MDFMYjBtNGlQWGVwbVprNERZaFJPR1Y4T3JQL2ZUT0RI?=
 =?utf-8?B?TE5iWGZmTlFvMGNtZlZkR0V6b092L3hLUkp1WjhZL2dDYVZNRGdxbVdsdjcv?=
 =?utf-8?B?TEo3WVNleTFzYTg2cnF2RWFyQ21TV2YzWm93UXlLMy9zTjRRZjNIS1JXTWRp?=
 =?utf-8?B?Q2gwRk9nc2NzcDFjbC9tU016NU5ZSXJtSmQrSWYwcVUzU3lPd3lLeGcraHNY?=
 =?utf-8?B?VysyQnFUYU01S2FGZ2huMDVEVENlWTN0b0VsVU00Um5tTVJ4OXBLcHEzZGl0?=
 =?utf-8?B?VDUxeUdsU2gvNDZnRURwQk1PZU1ZZDlQOWRhaEc4ODR5dE04c1JDN215bEVH?=
 =?utf-8?B?ZEhsZHJKYS9hbTBxRjkrWDUwTVdwckJnM3VlZkhEN0RaSnZiZVBBZCt0UFJK?=
 =?utf-8?B?U3FLSDN5bWRjaysyaEd1d3plQ0NPbUlHbzVtRHpsZGY3UWdocER5Tkg1Z2hO?=
 =?utf-8?B?UHc5V2h6TFpxYk45ZXZEdUdJeWpCQWxDd0hJWjR6RVV6MkhMbTN0WURHZ3RE?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a666f6-2b3e-4c23-f44a-08db26c0f354
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 08:23:56.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MJu8GkHSfMRlk4SU3m8mP29jI2RjJPAUqV7lQ633zgtF+f1Yp3cLV9Zp+FnfeZc0t4fDuo1NPUJsdpjzd7k8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ryan,

On 3/17/2023 12:34 AM, Ryan Roberts wrote:
> On 16/03/2023 16:27, Yin, Fengwei wrote:
>> Hi Matthew,
>>
>> On 3/16/2023 12:08 AM, Ryan Roberts wrote:
>>> On 15/03/2023 13:34, Ryan Roberts wrote:
>>>> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>>>>> From: Yin Fengwei <fengwei.yin@intel.com>
>>>>>
>>>>> folio_add_file_rmap_range() allows to add pte mapping to a specific
>>>>> range of file folio. Comparing to page_add_file_rmap(), it batched
>>>>> updates __lruvec_stat for large folio.
>>>>>
>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>> ---
>>>>>  include/linux/rmap.h |  2 ++
>>>>>  mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
>>>>>  2 files changed, 48 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>>> index b87d01660412..a3825ce81102 100644
>>>>> --- a/include/linux/rmap.h
>>>>> +++ b/include/linux/rmap.h
>>>>> @@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>>>>  		unsigned long address);
>>>>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>>>>  		bool compound);
>>>>> +void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>>>>> +		struct vm_area_struct *, bool compound);
>>>>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>>>>  		bool compound);
>>>>>  
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 4898e10c569a..a91906b28835 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1301,31 +1301,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>>  }
>>>>>  
>>>>>  /**
>>>>> - * page_add_file_rmap - add pte mapping to a file page
>>>>> - * @page:	the page to add the mapping to
>>>>> + * folio_add_file_rmap_range - add pte mapping to page range of a folio
>>>>> + * @folio:	The folio to add the mapping to
>>>>> + * @page:	The first page to add
>>>>> + * @nr_pages:	The number of pages which will be mapped
>>>>>   * @vma:	the vm area in which the mapping is added
>>>>>   * @compound:	charge the page as compound or small page
>>>>>   *
>>>>> + * The page range of folio is defined by [first_page, first_page + nr_pages)
>>>>> + *
>>>>>   * The caller needs to hold the pte lock.
>>>>>   */
>>>>> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>> -		bool compound)
>>>>> +void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>>>>> +			unsigned int nr_pages, struct vm_area_struct *vma,
>>>>> +			bool compound)
>>>>>  {
>>>>> -	struct folio *folio = page_folio(page);
>>>>>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>>>>> -	int nr = 0, nr_pmdmapped = 0;
>>>>> -	bool first;
>>>>> +	unsigned int nr_pmdmapped = 0, first;
>>>>> +	int nr = 0;
>>>>>  
>>>>> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>>>>> +	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>>>>>  
>>>>>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>>>>>  	if (likely(!compound)) {
>>>>> -		first = atomic_inc_and_test(&page->_mapcount);
>>>>> -		nr = first;
>>>>> -		if (first && folio_test_large(folio)) {
>>>>> -			nr = atomic_inc_return_relaxed(mapped);
>>>>> -			nr = (nr < COMPOUND_MAPPED);
>>>>> -		}
>>>>> +		do {
>>>>> +			first = atomic_inc_and_test(&page->_mapcount);
>>>>> +			if (first && folio_test_large(folio)) {
>>>>> +				first = atomic_inc_return_relaxed(mapped);
>>>>> +				first = (nr < COMPOUND_MAPPED);
>>>>
>>>> This still contains the typo that Yin Fengwei spotted in the previous version:
>>>> https://lore.kernel.org/linux-mm/20230228213738.272178-1-willy@infradead.org/T/#m84673899e25bc31356093a1177941f2cc35e5da8
>>>>
>>>> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
>>>> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
>>>> ext4 filesystem). Looks like instruction aborts are taking much longer and a
>>>> selection of syscalls are a bit slower. Still hunting down the root cause. Will
>>>> report once I have conclusive diagnosis.
>>>
>>> I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
>>> amount of time in the instruction abort handling code once patches 32-36 are
>>> included. Everything in the flame graph is just taking longer. Perhaps we are
>>> getting more instruction aborts somehow? I have the flamegraphs if anyone wants
>>> them - just shout and I'll email them separately.
>> Thanks a lot to Ryan for sharing the flamegraphs to me. I found the __do_fault()
>> is called with patch 32-36 while no __do_fault() just with first 31 patches. I 
>> suspect the folio_add_file_rmap_range() missed some PTEs population. Please give
>> me few days to find the root cause and fix. Sorry for this.
> 
> You're welcome. Give me a shout once you have a re-spin and I'll rerun the tests.
Could you please help to try following changes? Thanks in advance.

diff --git a/mm/filemap.c b/mm/filemap.c
index 40be33b5ee46..137011320c68 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3504,15 +3504,16 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (!pte_none(vmf->pte[count]))
 			goto skip;
 
-		if (vmf->address == addr)
-			ret = VM_FAULT_NOPAGE;
-
 		count++;
 		continue;
 skip:
 		if (count) {
 			set_pte_range(vmf, folio, page, count, addr);
 			folio_ref_add(folio, count);
+			if ((vmf->address < (addr + count * PAGE_SIZE)) &&
+					(vmf->address >= addr))
+				ret = VM_FAULT_NOPAGE;
+
 		}
 
 		count++;
@@ -3525,6 +3526,9 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	if (count) {
 		set_pte_range(vmf, folio, page, count, addr);
 		folio_ref_add(folio, count);
+		if ((vmf->address < (addr + count * PAGE_SIZE)) &&
+				(vmf->address >= addr))
+			ret = VM_FAULT_NOPAGE;
 	}
 
 	vmf->pte = old_ptep;


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>> +			}
>>>>> +
>>>>> +			if (first)
>>>>> +				nr++;
>>>>> +		} while (page++, --nr_pages > 0);
>>>>>  	} else if (folio_test_pmd_mappable(folio)) {
>>>>>  		/* That test is redundant: it's for safety or to optimize out */
>>>>>  
>>>>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>  	mlock_vma_folio(folio, vma, compound);
>>>>>  }
>>>>>  
>>>>> +/**
>>>>> + * page_add_file_rmap - add pte mapping to a file page
>>>>> + * @page:	the page to add the mapping to
>>>>> + * @vma:	the vm area in which the mapping is added
>>>>> + * @compound:	charge the page as compound or small page
>>>>> + *
>>>>> + * The caller needs to hold the pte lock.
>>>>> + */
>>>>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>> +		bool compound)
>>>>> +{
>>>>> +	struct folio *folio = page_folio(page);
>>>>> +	unsigned int nr_pages;
>>>>> +
>>>>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>>>>> +
>>>>> +	if (likely(!compound))
>>>>> +		nr_pages = 1;
>>>>> +	else
>>>>> +		nr_pages = folio_nr_pages(folio);
>>>>> +
>>>>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * page_remove_rmap - take down pte mapping from a page
>>>>>   * @page:	page to remove mapping from
>>>>
>>>
> 
> 
