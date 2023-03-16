Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A76BD616
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCPQnA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCPQm6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:42:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBF234E4;
        Thu, 16 Mar 2023 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678984949; x=1710520949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BfSffAW4pk6WIRYYKfkDz9CXmnTHyMFk6FDnGjlmhxI=;
  b=ax6cDRCgwzY5GXw4gruPWMAVIjNmOHCvuKW59g6KIG1JZzuwh1celi1o
   N4ySqIVCvz3JoutpzEuRhyG5DeDkaIWw9/AdGFDEPjkSk3RO5P616pKQ2
   Qfn8eRT2AZjdDSqO9p7vvKk88MW0171SsBzn5AVW3dIS+a0hXG+dLMQrm
   x5pkZ1rfAZWeB1QpbKZMk4Q7WlvWeiRkfShr7oYL/pOOLZ/AFL5gGhk+D
   tFVhKbSxkFeGajWo2lMq9POwxN+7Q7CO/WgLtjWBeblcVNdEMjPPD8I1p
   RcnDrDyjx2kUS3L4O2Qwqo+ex64FbqbWQHo1bFQa1x09PTi2E359oPx+6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424319829"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424319829"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 09:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="679971481"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679971481"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 09:41:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:41:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 09:41:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 09:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuNEpLFBc2LCbHbWX3a/zvQM1AG5+SFUsATB6IwW0QqMhCGR2UaIu06dLpnstXkQ3Q/z/VipVa34IGhHZGKKvCyF+0AX3bopqsqWDdv/PWHtWzPnUO/wxmUPOLMLkqajTqUY7U9FvuzaqVdO00PoqVnFYP0Osqy8Fvc626a8XmeSoRTa483oP96R/E01EKiniztUuWKzyK9+vXPh5sVobYwVmi9ZtPeIRt0kbyWosFdYgR/8HMqksuN4ugQnkefAYIXotBmW7cKqVGua8mZWay/keWIgcOupx24u3jLBr07JzWyMi7ei1r1XQvxVH4ruw/J+0FDDW6olIFPTVQCQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HjwEL5ouCINGtmJGDKysyMjJiDfAMPDAwkFuJeC6kA=;
 b=aYvt6BLOgpbKJ8PYNHpd5q7OVwIcPkooOA0QHFfQ+GRDQhoTtXj6wkGHMkyh0HmDeo0etkmhDzrKuoKZC0SO3BgURnz2eReUGvGxPh4cnvtBLOnXNK+bwvc6EpQK9u/GNNkpefcAz31qMfqt47Htkf5/K7UhOOh48Vf+B192drFNjWcEcD3U6Gna2kkWgqUh6mxSfYLN+5lSs1Oey5ITvw8Onic6muE4AWldwzNmdIQDRDRkQ93FarXIcUecgn4/l9NYE7SV3cog6sJSqs3DTAGLsETVQiLcuOojjEnqMFriCcG3xanIESnk7Gg3yKef0ZHPPKyEaKS+FqIJorNmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 16:41:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 16:41:23 +0000
Message-ID: <bdf56f89-1126-5a8d-48df-c723b23a8793@intel.com>
Date:   Fri, 17 Mar 2023 00:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-arch@vger.kernel.org>, <will@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfdce5a-f44d-4ecb-01d2-08db263d4744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlBvSSsybHgnIhDGuA1XAUe69GR0hhhgK3um22itqxPZJICaXRAEzDkMmLM6Ns4hXIPo1kGfH7elk0J97nmFav/XFgPfWQC5cbsTSEbYcCYW9nxj+LGFWTZy7F3FgX2z8U03qVH0eIfHD1zalXkDlNsLAEmN/2wYEbbVjhLVI3liigqIYBdRhNVtnJUiikqkjzgSm0n+kyxxCM5u8L5BxIQLjyMMKmRC2KTNQiPK3O8j/djBmDOPesCD25hzDClO48wZ4IKzdCOWUA6z8DilGuYl92xNyRZu4w/dHMmqlv/aUMLoChDdDDpfATQzZaf8b7G9yzRhkKq1iNRNxk7knPMNvVQO5XmYSKo5bunz//P1ZcApqbIBPh9ilh8zU5hfCmJmSaiUIJiIEsI5U3TQ4k5/LlXW4Z5zyjBKO/q1ljxltzFKJWbCTLSR0FskavIDujc2kC/rnbD8eSy4zxJH64O3bCL6oaEwfkNnFL945n2Yq4cU7xoN8lu6v6XSjX1rO22B9G360yDzr7FyjQY1XOQDjf2OE9z5+Wg+04y0rodeuYxEu57GhCNr7maL6Jkro2G3AaU6saejIlyUgtWa+Nih0suBLTPnokB2HQDFXIrj0QoOr2nZH4Q3fmKHvA0e7fTodNZAFpWcaxV4o63KECB5raU5f2vWsP9KnQEYRwD8mStasYIhY6mSMs15HLn/O1Nbi2Q2Cz1k4EtY0HfEFJ2RvfpdpOCUnef+qDuLwgueGh+fa6fGCnUb/bROcJHIiVgXAt/Dd89EVFKhIQiUnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199018)(6486002)(31686004)(478600001)(2616005)(6666004)(316002)(6512007)(6506007)(53546011)(110136005)(26005)(186003)(8676002)(66476007)(4326008)(66556008)(66946007)(83380400001)(41300700001)(2906002)(8936002)(5660300002)(38100700002)(36756003)(82960400001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxGN2ZzUVoyOUg3QjJwazBKTkxtdTZFUFRpSzdUUWpGcnRtKzErK05qOVdV?=
 =?utf-8?B?cUtXdjMxeXFXQUJYdmpjcFpWMEVvSHkvaEpwVWZ2RDZkVmxvak1nUDJodnFL?=
 =?utf-8?B?dyt1WUR3Vk53L00zamMxcklLT08walYraS9RcitwQlI3QnRQblVWa2MzNTBW?=
 =?utf-8?B?clhUMTFiWFJ1MlJOd2tXLzNpYWVJWnMzZWhKWVVpcktFYjFNSlhCNU9sbnp5?=
 =?utf-8?B?QWM2NGtKMDg3RXhta1RKd1FXTUxYc2Jxd0c1VDFOOFN6V0x0ZWc1L0xsQWlO?=
 =?utf-8?B?ZUZZQzNrVFBvQWJKcW5vYTlaNXdzdDlzbzA4ZDM2Z2k3dnBDOTFjazdZM3I1?=
 =?utf-8?B?dE4xTHBwS3RSTTVQdDlXTFpGRGJSU2lsZ1FBSTkwR05DNjd0dVZKcXpYRWo1?=
 =?utf-8?B?eVpGNFJrMnJScVRwcmZmZ0dvUHYxWERkWm0ySTlDdHhoZWw1RlJkd1N1dTVH?=
 =?utf-8?B?cTc2c25ZRTNqSWcyN1ErMll3aGxscFhnR3lQYnVIa1UxRWdiQmwwYXFtL3Qr?=
 =?utf-8?B?Tkx6czArU29oMGlsUi9mcjFwNERzUjZpR0UxMW9nZWJOZ1I4R0d4U3pBYU9S?=
 =?utf-8?B?QzVyYk1hYUFSWnNZWU51a0c1dytyaFNSSEdUeENDUTVTbTIwU2Z3b1lLMW1C?=
 =?utf-8?B?WlZqNGZpalZMSW16UzF3a1owTzJNdy9GVDVWTlUyVUdVc3ZBQk9PN01xdzBG?=
 =?utf-8?B?T0RlNDExQU0rekIwMktGLyt0YzhCOFkvdWNXNjNXb1gwd2pISnhrM1lqdFY2?=
 =?utf-8?B?bzFIMjhaQUFxYU1oVVBWc1piVE9GekdRSmlVa0lWMlVHaXhuUm52dUMrYjRm?=
 =?utf-8?B?ZTdGQ0VhcHZLRDB5RUdMemhva3JmRmZrRUlld2E1V3FHYmR4QldUaHBhdWY3?=
 =?utf-8?B?ekU5aVpzQXdhbW4xQmtLUk1WK29ydFVzQUduYkNYT1B0dTFFQ3dSWENqaGQr?=
 =?utf-8?B?bDB4K2oxQmEwRjdqMFh2YkJOWTF3ank4MkJyczFBa3BPQ2lxbmxvcklUakx2?=
 =?utf-8?B?OGtYb0U5N1JoRTVVRFpyeDRzZ2p1NVVMUlpIQk5TdUxXM1JMWEtBTC9JR0ZP?=
 =?utf-8?B?RG9tRHMxcUpuZThjZGdjVnN1azFadnc0L05HRXZtN01pWGpaa2YyVmQyNnB6?=
 =?utf-8?B?Qm52QjNDcm5kMUZ3LzFPaFZ0dnJFVit5LytVZ0tMKzZidTY3U3NibzRNR1BM?=
 =?utf-8?B?R2o0enVVYUNUYVhvNTMxdGlRZnRhSWs1NDlHUXpLYXR2RGxNWko2UzRxb2No?=
 =?utf-8?B?NU9CcVBvd01oZjdPUFprbXBybUFvWnNMWHpib3R2SytkenFCdkFXbEJHWHYv?=
 =?utf-8?B?U25Cd3puWEJRa2hWY05DV0pkSXl5Q1V4ZDMyMG5wMmVmem9IUFh5OXJKQ01W?=
 =?utf-8?B?TUQvbHArcjNOM1VScE83dEJkeklJbmNGZEx1bmpBcnhpQWExMnZGVU1INUxo?=
 =?utf-8?B?N28yV3ZVQnhNR3RGbmNqWDNJNnYwSUN4TEwxUk91cEJmVE9pMmNlelJLU2dF?=
 =?utf-8?B?SzZGbnkwaGVDK21qdWpFYTBkQlBtS2IzNXZSeXB2eERDR1lkRE5UU0pwcGZX?=
 =?utf-8?B?cWx1eldpWTQ4b1YrRnVWdUNHQVBsVjVRZUp2eC9oVStrRkt5cWEyNGNBZmpU?=
 =?utf-8?B?dDNrb1pVc0NPTTZpVEVCMEZnQm0zT05wNWdMQ3Z0dHZhanNDV3ZHOER6Q1Fm?=
 =?utf-8?B?Wi9JMDVXQUJBYmZra2p1VjU4Z0UvY0haZnJ6SVhTdVBTUkc5cmpna003OG5J?=
 =?utf-8?B?bHkvK2tobHNUWkh3WmFVem92dFBnVjZkRHliOUxGalJGZ3NXaDROMkV3djgy?=
 =?utf-8?B?Z0RDd1FZb3J2YmU5UksyM1dzZWEwTHNST2Zpb3VGNUJPczQzOW1zYkpXTnVy?=
 =?utf-8?B?SFppQSt3bHVmK2lISnJNOVk1ZmxaaVRYcys0ZlNiUXN5Sk82RG16NTAwdHlw?=
 =?utf-8?B?UHFuSk9STlZWM2Nua2o4VEJYTUFLd3lYeFNuYnZBcXIzY1ducjBSelNhOTcz?=
 =?utf-8?B?WVU5M3hmc3ZVd1JNNUJPNXJyT1NMR2pvUXNUb283VzNGN3cxcXVxbUxKR1ZN?=
 =?utf-8?B?MU1MWStZTEgxWGVYU3dZUlh5MXN6K0p3SDhYQWwvQ2srY1ZtR1B1SG9JVXkw?=
 =?utf-8?Q?3SQNo6PUgTrq7+uO+ZnnmVsmn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfdce5a-f44d-4ecb-01d2-08db263d4744
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:41:23.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEBjoEnZAZ57HBCrGkaGOTe6wVYbyHRXUUexzGQLCaltKJudVnFNaT4xlcwYPwDTimAlPYfEsaAaCVAzt+MVNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/17/2023 12:38 AM, Ryan Roberts wrote:
> On 16/03/2023 16:23, Yin, Fengwei wrote:
>>
>>
>> On 3/15/2023 11:26 PM, Ryan Roberts wrote:
>>> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>>>> From: Yin Fengwei <fengwei.yin@intel.com>
>>>>
>>>> set_pte_range() allows to setup page table entries for a specific
>>>> range.  It takes advantage of batched rmap update for large folio.
>>>> It now takes care of calling update_mmu_cache_range().
>>>>
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> ---
>>>>  Documentation/filesystems/locking.rst |  2 +-
>>>>  include/linux/mm.h                    |  3 ++-
>>>>  mm/filemap.c                          |  3 +--
>>>>  mm/memory.c                           | 27 +++++++++++++++------------
>>>>  4 files changed, 19 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 7de7a7272a5e..922886fefb7f 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -663,7 +663,7 @@ locked. The VM will unlock the page.
>>>>  Filesystem should find and map pages associated with offsets from "start_pgoff"
>>>>  till "end_pgoff". ->map_pages() is called with page table locked and must
>>>>  not block.  If it's not possible to reach a page without blocking,
>>>> -filesystem should skip it. Filesystem should use do_set_pte() to setup
>>>> +filesystem should skip it. Filesystem should use set_pte_range() to setup
>>>>  page table entry. Pointer to entry associated with the page is passed in
>>>>  "pte" field in vm_fault structure. Pointers to entries for other offsets
>>>>  should be calculated relative to "pte".
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index ee755bb4e1c1..81788c985a8c 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1299,7 +1299,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>>>  }
>>>>  
>>>>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
>>>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
>>>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>>> +		struct page *page, unsigned int nr, unsigned long addr);
>>>>  
>>>>  vm_fault_t finish_fault(struct vm_fault *vmf);
>>>>  vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 6e2b0778db45..e2317623dcbf 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3504,8 +3504,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>>>  			ret = VM_FAULT_NOPAGE;
>>>>  
>>>>  		ref_count++;
>>>> -		do_set_pte(vmf, page, addr);
>>>> -		update_mmu_cache(vma, addr, vmf->pte);
>>>> +		set_pte_range(vmf, folio, page, 1, addr);
>>>>  	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
>>>>  
>>>>  	/* Restore the vmf->pte */
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 6aa21e8f3753..9a654802f104 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4274,7 +4274,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>>>  }
>>>>  #endif
>>>>  
>>>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>>> +		struct page *page, unsigned int nr, unsigned long addr)
>>>>  {
>>>>  	struct vm_area_struct *vma = vmf->vma;
>>>>  	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>>> @@ -4282,7 +4283,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>>>  	bool prefault = vmf->address != addr;
>>>
>>> I think you are changing behavior here - is this intentional? Previously this
>>> would be evaluated per page, now its evaluated once for the whole range. The
>>> intention below is that directly faulted pages are mapped young and prefaulted
>>> pages are mapped old. But now a whole range will be mapped the same.
>>
>> Yes. You are right here.
>>
>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
>> can avoid to handle vmf->address == addr specially. It's OK to 
>> drop prefault and change the logic here a little bit to:
>>   if (arch_wants_old_prefaulted_pte())
>>       entry = pte_mkold(entry);
>>   else
>>       entry = pte_sw_mkyong(entry);
>>
>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
>> because HW will set the ACCESS bit in page table entry.
>>
>> Add Will Deacon in case I missed something here. Thanks.
> 
> I'll defer to Will's response, but not all arm HW supports HW access flag
> management. In that case it's done by SW, so I would imagine that by setting
> this to old initially, we will get a second fault to set the access bit, which
> will slow things down. I wonder if you will need to split this into (up to) 3
> calls to set_ptes()?
If no HW access flag, arch_wants_old_prefaulted_pte() will return false. So
path will goto pte_sw_mkyong(entry). Right?


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>  	pte_t entry;
>>>>  
>>>> -	flush_icache_page(vma, page);
>>>> +	flush_icache_pages(vma, page, nr);
>>>>  	entry = mk_pte(page, vma->vm_page_prot);
>>>>  
>>>>  	if (prefault && arch_wants_old_prefaulted_pte())
>>>> @@ -4296,14 +4297,18 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>>>  		entry = pte_mkuffd_wp(entry);
>>>>  	/* copy-on-write page */
>>>>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>>>> -		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>> -		page_add_new_anon_rmap(page, vma, addr);
>>>> -		lru_cache_add_inactive_or_unevictable(page, vma);
>>>> +		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
>>>> +		VM_BUG_ON_FOLIO(nr != 1, folio);
>>>> +		folio_add_new_anon_rmap(folio, vma, addr);
>>>> +		folio_add_lru_vma(folio, vma);
>>>>  	} else {
>>>> -		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
>>>> -		page_add_file_rmap(page, vma, false);
>>>> +		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
>>>> +		folio_add_file_rmap_range(folio, page, nr, vma, false);
>>>>  	}
>>>> -	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
>>>> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>>>> +
>>>> +	/* no need to invalidate: a not-present page won't be cached */
>>>> +	update_mmu_cache_range(vma, addr, vmf->pte, nr);
>>>>  }
>>>>  
>>>>  static bool vmf_pte_changed(struct vm_fault *vmf)
>>>> @@ -4376,11 +4381,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>  
>>>>  	/* Re-check under ptl */
>>>>  	if (likely(!vmf_pte_changed(vmf))) {
>>>> -		do_set_pte(vmf, page, vmf->address);
>>>> -
>>>> -		/* no need to invalidate: a not-present page won't be cached */
>>>> -		update_mmu_cache(vma, vmf->address, vmf->pte);
>>>> +		struct folio *folio = page_folio(page);
>>>>  
>>>> +		set_pte_range(vmf, folio, page, 1, vmf->address);
>>>>  		ret = 0;
>>>>  	} else {
>>>>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>
> 
