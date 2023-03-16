Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4F6BD582
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCPQ0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCPQ0M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:26:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B0D5176;
        Thu, 16 Mar 2023 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678983965; x=1710519965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wRuhZumuE/FBe4i12d7mIp8GMUYzDUYO2vuo1erpkyU=;
  b=Mib2Xf88V2kzpcW3WidRlMm/yW0otkdfaIL7u50mEey6o65CDciGe7DL
   qFcODA0pW7JRXWGXisM3cW3XTcKFvYmi4Gu/qQZLRfcyY28p0NeoeR4nt
   6L1z37HnqMZ3kpOsffOF5ZOb4svHk9kf/Z9AASpDSxBgGGml7g6SSIFiw
   jR7hOhM6uPqoRfHO0FdaiaIquVqM27XeSM4cKDDXWdQrR6yMTSi2kRgYN
   jR68oCNLsqNjsQvpIDb0fRZI/2K3gtkCuKLnX6BpBPmZV9iJ3EK/fGb/v
   zpLYmh+2+Jr/rwmRpQe0btGE9h+WSwB6/5MuLtRlImXfpwKvreldv6GeN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339589117"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339589117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 09:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="790374736"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="790374736"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2023 09:23:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:23:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 09:23:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 09:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lINWi8NxBQZpv6f9t7uEecbI5yNPVQeg4Zijwb8PPkO5TagOaCJ10leAqvnHHx9GbZM/hSUovWmDUUWL3J4xXl0zP2oQ62ul2o2VMKTkQv1QyMytVVGwZrFPm0+SxWWsX9xN0CCiH+0V7x9XyIEaXTMZviXjd0E+XKgRuQnNBcKkw+B6yDWekRy3aeSDA8/whc3ZLIrYR8U/B42nvXD5T94deu5w4O2zMuXsZEJPPdXi2N5PJeXGCeD0IR11hed6VQ3031t914jDGWES9t8kVO1VdjnhPr+h0P0MBtQBSDnekoj1Mvi4hZ3P0ddfFtT/OiR9EXOZTgKHMYJEOfe/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfsRso45sD6/kzL6x2VCUM1himwYCeY6oh3y9o7y+c4=;
 b=YJ7/R89h55IvZeJYQCKIWKAHBPJE2Bk3yqAgkIrKjqsUicX2jscSkejQFiPPrNFOn2XZTba35xffdnHYHx2iUvsBfdONI1FhKYjBGNxRcVC6sKyZTR77tYJg16r59sAdpAi58phxXSuoTu3rFNnDcLseNgdKeCVye71oq7kUlxmnc6g1lxsyg6yGg5+XJ0dsaaiUXt3o0KLTTqmMKzyzyX3m1ESYzib7sVd40H/CXB+/RhT08YwnmradNjL6p4a9LowRlqONtClXh+BZusEiM9hoS3d/2o/tvsbYFvFzc9k47pFi1rqlOUBmiqRh7OsfUrccJYBo05hwML7Hj5pd7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 16:23:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 16:23:37 +0000
Message-ID: <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
Date:   Fri, 17 Mar 2023 00:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-arch@vger.kernel.org>, <will@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA0PR11MB4621:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9e4383-30b6-4fa8-52ee-08db263acba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlR+nUoJexrPN01gixw3FPlL8kwmWbkhaLESeWqRRhIlPIZ0Iyr8JMZKvqEsKhDctqgaknHC9jrZhyGJVmhAzgVUErtB3p0M2UbLcOoLFpejXQPv4mqNCAyHlZ/s9MoWlMKb/OX6tedM2/M2zeCtP6+fxQb7gUmxNXrmQaBj3hfqJQir5ltNJyJ3EuSB30KY/TgirubsXIQ7wBTcqzOtE2FWzDtp1cdMd5+4rnu0spw1c9mVHUUHIsi1UWXVW127g1IPC2w+qLB/mIeaHkxrjihMgysRKDYyz0fy0G3Yv26bfL+SpWlyrJtSybnNoHIjRWmE4DvkzxB46bQVkeudyeM3CU16T2whHKyxQBRLfgcdKxFqGTvnAfZh9v0g55I84gG3d0TBbfqt/cdy8vG7FdyDAGIm/es3jeuFB9iJCt15LYqUXovlOxrgu4F7Z/Hbn2rMnAuHUl5EPh3o2OpQ28jd62tXxnnCAXN5nvPfasXkQwWNRMxlu5zhWSDsyfT0oE/P3qCi3JPq/xewC7tjbMxq1epv5+0oH+CG5sOiGvAnHNQOv8GVRJG0//Wk7ywZ648NbV26H7Bbf1BML1VmL6GPlKSqHbfgQQIsITiagqD2LhNBrgogJ2StYjCRH2OetuALCmyD9m6OvUU5Pt6IGkBurEoCO0PrXHGIuuyejcs9RByfxrHkSr5RDeh792jjIUVybH8e+K5DA0Ie+0s7EYUmH6VdhD3ybMS52xlmuNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199018)(86362001)(31696002)(36756003)(82960400001)(38100700002)(4326008)(2906002)(41300700001)(5660300002)(8936002)(2616005)(6506007)(53546011)(26005)(83380400001)(186003)(6512007)(316002)(110136005)(66476007)(8676002)(66556008)(478600001)(6666004)(6486002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlselpnUHo4cW4wcjJyMHl2SWgyS2gxQWIvVnlNQXZxWUtISXZ2TlIvdWtr?=
 =?utf-8?B?UDN6bGYxVzhDZUMxdWNOOG1ZbFYwUTI3TFhhUlZ5N3B2cFh3SVVSVVZWa3lB?=
 =?utf-8?B?RFVjUkNTYWYyUFB3Q2ZzZU5EeEN0YVA0M3orQlkrTmNHVWFERVFyNi8rOFRW?=
 =?utf-8?B?OGVIMS9VVTFOdlR5dGg4OG42TlgyYUxtbTc1YjNnWjAvYzNLWjVGcFFETGp4?=
 =?utf-8?B?SjRVOGxLV0M0K2JmRmJxVmRmWWY4N21IWCtweGx2ZllyUEJudll5NGZkQUJ3?=
 =?utf-8?B?VlBweUo4SUpwMHY2SCt5d1NvZHJoZHJvMXh3SE1lUkZKNFV0dVdVK29iaFZp?=
 =?utf-8?B?ZVF0VmlDSTVYYjZMZnJpMkg2U05xaU1lWDRQTHFhQlFsQU40RVJKcE9IdDFu?=
 =?utf-8?B?Tm5TNStSV1J4ODRHVzhMam4rUy80OVA5VjQvckMvVnpxVVNSYmFxOGVOSGtp?=
 =?utf-8?B?ZWJiRGxTdlRNZnhrMUR5bXYyQ2x6a2U0Y05TSENaK3BVcFlWNXNWS21SajYw?=
 =?utf-8?B?U1FOM0EyeXMvU0tMUEFtaFZ1K0pFdGdvUmNiNk9GRFNrZzIvc0krUHRFNkow?=
 =?utf-8?B?SWRvNE1wMEpwWUd6U2JKOTEzVVM4NXExNWdFL0Z0bjR4MXY2d2xvcWVZRkJV?=
 =?utf-8?B?REozSS9LY1dIZExMa281dFBRY04vaEZqVG9FSVAzQWVDbS9aMUxBL2ViRWJr?=
 =?utf-8?B?dGR3a2pvc2lBRWc0R003Q0haYytBL25QZVM1L3pGSmwrdlpGUFpncWNLSnQy?=
 =?utf-8?B?Wnk3bk8xOUJpV0RWSFMxeFJDRnBrYUVrMFNLbzE5aVMrTUhDYTRBdGx0MHE1?=
 =?utf-8?B?cU5QbzBNK2txNXZGL0owSVZRRnZvVUFyYk5zNzcxZFgxeXYvLzhKbXVpTFhN?=
 =?utf-8?B?SlA4THB2TjVhSElPY2lwdVhNc2JuWmpmUUNDNVdmOXVDY2FHVHJyV01KVjVQ?=
 =?utf-8?B?T1QzT2JaTUdsQnozMzRQVW9HUDhBSGxBNWZGOG16RER4RVQ1ck5Jbm0zQXZJ?=
 =?utf-8?B?bkMzZVJWT3ZzMVcvNE1SV1lNN1JHQlpHdUtmdGwrbkEwOUQxUEl0azZGNVBU?=
 =?utf-8?B?eDBiQWtkWi9qenFIVzdvaGxBMEs0aU1ZOE1NRFNHUnMvZHExSDdQWU0yQzY4?=
 =?utf-8?B?eWt4ekpySS93T2phWVJXaEhXUFVZRW9idk9HMzVTL2laaTZaOER5cWkxTFJD?=
 =?utf-8?B?SVBFeVRGZTMyaTBFUmNxYnpUanJlN2RHNkJUbDk4VXJRcWZ5QmU5QkhuVVdE?=
 =?utf-8?B?ZUplai9DdCtpMUpHUHVITUxIZE5IbGx6ZEJqdEJkMlBIRkZjdVlKbHNYQ3lM?=
 =?utf-8?B?cWRlWnMvZkxHZE5xcktVV3BBUXRjYURIVTZiSEFsd0t0UExqYk85SVdmV1JP?=
 =?utf-8?B?bjdqU0ZRZEZKR09YczBxSFlTekExOXM5QVkxTisvK1lUYiszWFhQMjJtUnBw?=
 =?utf-8?B?K3d6ZFA1ZzJ0NlhHQ1plY2NxaldHcVlBWmhqQXpORWM5OVdZZlNqcHRKQkFk?=
 =?utf-8?B?bDdMT3didTh1MlRoTStrVk0xUDBXWnpjT3RXUEp5WDg1SXlNQ01uWUFTVlMx?=
 =?utf-8?B?V1l1S2hETlJBem1lTXBxbDZzU3FQbllmaHdxb05UZUoxNnV1Y0ZsQjF1NnlX?=
 =?utf-8?B?b1ROM21ockRkZ3pkaENseUZtSER1RXhXc3VrS043QTA2SDhnNFYrQVRFL3dz?=
 =?utf-8?B?ZFZGS3hCOWp4dHVCQytwenREbFdaNUFrb0ROZnY5Z2E5aFFnRG1ibTVTOXlN?=
 =?utf-8?B?dlRoMTV4aTk0bzZJR0FlZkZVWWxFZVRJRlVrTHcrVWNZazE3NUljWFYrMW00?=
 =?utf-8?B?VzgrcjR6Zm4rUGkvMEs5Zm9sbFNOWHdIaU5CTnZKcm9KUUE0V3BscFUwS0F5?=
 =?utf-8?B?MWl5blNiSlJzd3NNa210aHJHYThSSitMeW5VK2dwSkcyTWQ2cy91QTJTMEkx?=
 =?utf-8?B?WjZCcWNiZ0UxWWJ6TGVxczIvaFAyMjdRZ1JONGpsVzZzVlNBa28ya1BjS1Fx?=
 =?utf-8?B?VC85WStNMjUyU0gzbWdyajZVSXhKOElWRzhuTkJPK0xPTVNLZXFWVnVlTjlT?=
 =?utf-8?B?WTMyNkF4Z0Y5ZzlFa3YrWUgvZC95K290SysrSFBCWThpdk5UMWtDQWk3d25k?=
 =?utf-8?Q?+kUUtPi3le/WRfb+PiXP+IfJZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9e4383-30b6-4fa8-52ee-08db263acba9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:23:37.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLI5AxQsY1AliDIVlb+Lbu6OfKG2UwkFESnPW540WZpVzaQqK710ICeO4KRq9remy+7dcQdx0TX5Yz+cTpYfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/2023 11:26 PM, Ryan Roberts wrote:
> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>> From: Yin Fengwei <fengwei.yin@intel.com>
>>
>> set_pte_range() allows to setup page table entries for a specific
>> range.  It takes advantage of batched rmap update for large folio.
>> It now takes care of calling update_mmu_cache_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  Documentation/filesystems/locking.rst |  2 +-
>>  include/linux/mm.h                    |  3 ++-
>>  mm/filemap.c                          |  3 +--
>>  mm/memory.c                           | 27 +++++++++++++++------------
>>  4 files changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 7de7a7272a5e..922886fefb7f 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -663,7 +663,7 @@ locked. The VM will unlock the page.
>>  Filesystem should find and map pages associated with offsets from "start_pgoff"
>>  till "end_pgoff". ->map_pages() is called with page table locked and must
>>  not block.  If it's not possible to reach a page without blocking,
>> -filesystem should skip it. Filesystem should use do_set_pte() to setup
>> +filesystem should skip it. Filesystem should use set_pte_range() to setup
>>  page table entry. Pointer to entry associated with the page is passed in
>>  "pte" field in vm_fault structure. Pointers to entries for other offsets
>>  should be calculated relative to "pte".
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index ee755bb4e1c1..81788c985a8c 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1299,7 +1299,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>  }
>>  
>>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>> +		struct page *page, unsigned int nr, unsigned long addr);
>>  
>>  vm_fault_t finish_fault(struct vm_fault *vmf);
>>  vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 6e2b0778db45..e2317623dcbf 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3504,8 +3504,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>  			ret = VM_FAULT_NOPAGE;
>>  
>>  		ref_count++;
>> -		do_set_pte(vmf, page, addr);
>> -		update_mmu_cache(vma, addr, vmf->pte);
>> +		set_pte_range(vmf, folio, page, 1, addr);
>>  	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
>>  
>>  	/* Restore the vmf->pte */
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 6aa21e8f3753..9a654802f104 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4274,7 +4274,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>  }
>>  #endif
>>  
>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>> +		struct page *page, unsigned int nr, unsigned long addr)
>>  {
>>  	struct vm_area_struct *vma = vmf->vma;
>>  	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>> @@ -4282,7 +4283,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>  	bool prefault = vmf->address != addr;
> 
> I think you are changing behavior here - is this intentional? Previously this
> would be evaluated per page, now its evaluated once for the whole range. The
> intention below is that directly faulted pages are mapped young and prefaulted
> pages are mapped old. But now a whole range will be mapped the same.

Yes. You are right here.

Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
can avoid to handle vmf->address == addr specially. It's OK to 
drop prefault and change the logic here a little bit to:
  if (arch_wants_old_prefaulted_pte())
      entry = pte_mkold(entry);
  else
      entry = pte_sw_mkyong(entry);

It's not necessary to use pte_sw_mkyong for vmf->address == addr
because HW will set the ACCESS bit in page table entry.

Add Will Deacon in case I missed something here. Thanks.


Regards
Yin, Fengwei

> 
> Thanks,
> Ryan
> 
>>  	pte_t entry;
>>  
>> -	flush_icache_page(vma, page);
>> +	flush_icache_pages(vma, page, nr);
>>  	entry = mk_pte(page, vma->vm_page_prot);
>>  
>>  	if (prefault && arch_wants_old_prefaulted_pte())
>> @@ -4296,14 +4297,18 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>  		entry = pte_mkuffd_wp(entry);
>>  	/* copy-on-write page */
>>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>> -		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>> -		page_add_new_anon_rmap(page, vma, addr);
>> -		lru_cache_add_inactive_or_unevictable(page, vma);
>> +		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
>> +		VM_BUG_ON_FOLIO(nr != 1, folio);
>> +		folio_add_new_anon_rmap(folio, vma, addr);
>> +		folio_add_lru_vma(folio, vma);
>>  	} else {
>> -		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
>> -		page_add_file_rmap(page, vma, false);
>> +		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
>> +		folio_add_file_rmap_range(folio, page, nr, vma, false);
>>  	}
>> -	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
>> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>> +
>> +	/* no need to invalidate: a not-present page won't be cached */
>> +	update_mmu_cache_range(vma, addr, vmf->pte, nr);
>>  }
>>  
>>  static bool vmf_pte_changed(struct vm_fault *vmf)
>> @@ -4376,11 +4381,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>  
>>  	/* Re-check under ptl */
>>  	if (likely(!vmf_pte_changed(vmf))) {
>> -		do_set_pte(vmf, page, vmf->address);
>> -
>> -		/* no need to invalidate: a not-present page won't be cached */
>> -		update_mmu_cache(vma, vmf->address, vmf->pte);
>> +		struct folio *folio = page_folio(page);
>>  
>> +		set_pte_range(vmf, folio, page, 1, vmf->address);
>>  		ret = 0;
>>  	} else {
>>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
> 
