Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F876BD599
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCPQaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCPQaR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:30:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080822037;
        Thu, 16 Mar 2023 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678984183; x=1710520183;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0jrPbyTNoXKkwwXAVc4WlR6Pz+mdcLX9K1FAb3Qmvmk=;
  b=bq6m+DMdZglKNpV8NGfXK2KSEj+g8BPYqtc54Cp3oph0nXBvN8ZMLZeS
   oyucMStqtiXlb/IXH5wdun9NPmKHv48Y7hYXDAU4XmLWkyfEv9NeglVyN
   FUuZ9hqOfBNAeo+0MCV4q2vygezxEBkyABcE/hdEpveAd8pGJS2jKppLM
   Naxi/EKU44TppkXc/WduOfHQZ3lqDTfcZTLaciwqs1dgZVquxNX4NG00H
   vFDYay1EVfieAuny3sgOYjSL4TnYA1mPUZku8g9IeeNwbgrII9Fvd672U
   r1u16Z42VhBFskbcboy6EZiWW8TXJlousWEWMJFWuYjqG8Olh1N8ZB1TA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="335530243"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="335530243"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 09:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="925818220"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="925818220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 09:27:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:27:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 09:27:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 09:27:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 09:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFlrgrr50QPZ6ZIXDzeDCZYHsRjg5OLRjC0disAM4DRv53hCLRIKTky7gNNFwic+H0UdETwcWMSFcyKvWzSfff+eKnWLvWKGRejEvryw32Kx/GJqpWLQSxybnrm93612FQmXKWoAWPvKjOoVBg9SfO4zkpIZGO+d+0lMX/vTupdqiIlTjs4sCD3zpFeyduk2cTrHuGTodc3r9AWoqcjjqNy4fPr81Vd+3uuHlNdNvIQGYEGEBKeSBANJA10jH8jbT+HZ5anU4/vyKo4K95CfWhfzdKPHmkpmaODCfDuYRCmnsuAPiXy64lFqcCiPGJ0pz783m4Fp/Cv7ZnivWt1oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b964wrpx1utm4VazZrHFelY/oPM86sA842e3DrCTDcU=;
 b=haIuNEnRUePgZEYLLIYadfqT3v0NGzIHD9/FA9Pf+xgUXEb/s9ious57Qv0cnjUxphZaNwacif1T/5zmYsWiSeIFzjaxZKEHGZ7Tl+xZTx9eeHPTRQmdVQnzD/5gHSVYLMK8QIHRjbK58I3w/JIPk8Exl2LCQ2VgHymNH1Ec3Hi6alFZq3lDjG2yxC83hxXxQSrq5LgVUSH6Yc7cWzECMFMjwSmJ4KMYHaBZugUF/U51UjDXhgz7JDLPMNLk9IA/VLlzErkajd0dtv9hchOMkcmG7Aln+wTLJxT6pZs0cW7ZuRziOwb1l0SZ4OdxiGInBdikIN0qdFcPJVg59qRtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 16:27:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 16:27:28 +0000
Message-ID: <0f581d0d-3139-4007-2161-592a0a545b50@intel.com>
Date:   Fri, 17 Mar 2023 00:27:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-35-willy@infradead.org>
 <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
 <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: e9153d26-3c52-4d25-e0b1-08db263b555f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnW3XFdkkmDM2JnFVEPdk6uziP31YYL6vWbZ3HxTfZ3abACypca3mB+JVCeYdOJ9gf8MA5Rf25SaXqeBqWbNaM9GDVimwa+DvMsMyBtPdzEtgj2aSHA+vtaEzAxpTyN/j5ZXJzcGp8mosuVM00Dkvz5aa2Xp70cpJAecuxaIit7139Ygb/FJ/h1CbLDYFx4ornJ2Vx/xcSx2SmFj7hP8uFG+mQ9XTaaqBrk1H9F+QJprPjL7d3nwWq2pxmlyFcmTDAPcwW0pJvOZ9FiY+mpOUvOfs1f/Nr2OmKylMBlZjpT8l3o/NX91naWZAixd8HRS03ujEUA40E1FSKhgFRp3DPi8e+65S7JVZhU6YWgQM6qFOUESD2Q+hJPHMl//9UysjAi2SOs473VaM66sdwGetV8CltUnnB5rMZvyfgFPGKX+oPk9pBUUPxyqpGdi/kLwym7UibEp6yb47cuFvmx6nYsaFK/veAB2aM+WqAqRGGz+pK7ddpxdBE7eEfyxk+IRG2ch4Oi2cCXW29F/hQgY5CK7cxoIkGJPzGUfy8uM5By41AiEnv7shIfL1Xdcrqkdfqjbw9ukEh8ekEbFecHaPObC5uMQjNNk7jP3M0vVUsPl2MheI3MktgAO6Xs4pJ1Lp+LNiqUAWbt341FnjM2hC4cbW+t3gDOl7crD93x7A5+ApjgM3mMGYZQ0D4TwSuK17JttjyCRwBU3YHn9FXASiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(6666004)(8936002)(41300700001)(2906002)(5660300002)(82960400001)(38100700002)(31696002)(966005)(6486002)(36756003)(316002)(8676002)(4326008)(66476007)(66556008)(83380400001)(86362001)(110136005)(478600001)(66946007)(53546011)(6506007)(6512007)(26005)(2616005)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTdyWG1FYjk1MlhRVGZhWmhsRnVCTjFZRnhqcnZYYnlKakR3UWJOWkwwQUR0?=
 =?utf-8?B?MWpmWTVQcjVVMGl2K2NmdXB4SU95UC9obitCblUyaGVkRnlJd0I4NE9QRkNR?=
 =?utf-8?B?cGxmRytqWDRuNFhkYWhKSUxlTkFBUXYvM05mTXh1eWxscmhTWlI5L0NISGxk?=
 =?utf-8?B?QnZSMk96R09KKzZFYkZ6VlV1Q0JxcGpqOERwMU1HVWRXazNSOEFnS3AyWlBQ?=
 =?utf-8?B?Vy9mbjZGOU9keGs0QzlPbm5BcDB0RmcvUER2S3FzQVU1VjYzRXJaWjFjWWho?=
 =?utf-8?B?REluVDRyc2VQek4rR2tOUk1nRHVJbUVERmdGcDZxNFlxM3JITDAzUTdiaUkw?=
 =?utf-8?B?b3MrdnhzUTFvMGhQSm9tUU5zYTRPb2o2MTVrTDJnMmlWaUFnZ3FSd3N4QmpR?=
 =?utf-8?B?UE1wcFo0YWZFK0kyS0lncjZQUlV3VzRJZGFRMWdQUGtKSUF2N2JLNzIzMmZW?=
 =?utf-8?B?TkhlNXBSbVpKZ2lMNU9EMkl4MDg3T3Y1d3FTSVMrampTUHBka1h5MDUva2Nr?=
 =?utf-8?B?OFcxQVJTVG1DMklzRTNXb3lNb2dQYk9rTWkrdlBWYm5ZZ21DMUJRWk1HZVdp?=
 =?utf-8?B?SHl6TDJGb2hWQ1U3TkVHc2hBTm5qcDh6aHlVQVFnbDhjMzNZSTRqZVVrSlI5?=
 =?utf-8?B?ckxYQmdmWjNZTDZ6Q3kvSnlWQXp6SGZWaWRKbm9YMFZTWnRYQjMrcTVtWnZ6?=
 =?utf-8?B?NDVPSWdUS1ZSdDVhVmI4UTFDcmNFQ0I4alJZM0t3MFNuOXZDT08xYXd5cEc2?=
 =?utf-8?B?YVVXTzF2eFdiWC9DcXB0dGZhZHlnamJkQjlOeHlSanFORGNrMmpuSXpHbDNR?=
 =?utf-8?B?MWVVck43K1NVWWNOanR3b1BrcXpJTGJnYXM3YmM0TS9LVmpPNWVjWUdhSVVD?=
 =?utf-8?B?cHRGaFFsUVVTNjdSZGpCd2ZGV05UdVAzdmlpdlJ6UXoxOGZoZ1EreGpvWjVP?=
 =?utf-8?B?ZW1TTjFmTncySGlEbVYzR251U1FFQ2orbmE5UjlyU1g4Sk1pVzY1NHk1YzRy?=
 =?utf-8?B?TTlLYmh0T0NYNHJKN2hWV1lPamd2RGxkSDIrVnZUM0VuM3FlMWlRcFdrQjdZ?=
 =?utf-8?B?QTV2aFBYSTE4ZW5GK2xKVjhLRkM0Tm1yVWdrV001WlVLYW5KOHFFNFh1RjdU?=
 =?utf-8?B?NWl6UFJqREE4bDRIVm0rU1kybm5DRUQzdE04b0sxSEVaRkpKTmc5LzdweTdk?=
 =?utf-8?B?U2Y2bE9rcVRpM0pRd0xKMm5tRkJyNVpZRzVyc01FSzJSbWF1T2liOU95Y3BR?=
 =?utf-8?B?VVFmb284djlFczlnVVlmODREV0l2aERlUEdTZkRJMjlHRUZxVFJTNHk0cW5u?=
 =?utf-8?B?Rnp6Z24ybDYyK3lyL3RybkQ4QVdCZDFQa1VUV3B1TXdOT3VhSmFacXk1T0pT?=
 =?utf-8?B?OE5LV0JtNFZwU2dMT1J5T2lsTEZIVjIwNndIYkZrd2JrUzRPNVl1RkhYQWNy?=
 =?utf-8?B?UExHR0ZlMXV0WVU3bEFDbGpPUHBqbHZNWnB6ZXdGS1VuYXd5dE9ieGYySDRu?=
 =?utf-8?B?b2FBN3p3MFJXdXJmTnE1ZXNiRGV6OWVnR2s3ZnZsNmZnSk5ad0ZXUzYyWXp1?=
 =?utf-8?B?bnd2N3M2NDFSSS9yajEzNEg0QWxKZVJ5MFZDa1EwWGtCVEd4b0hwWDdHYUZl?=
 =?utf-8?B?NzcxMGxicmZXeGhUMWZUWldOa1hwckl6WWR5YUtYNXI2eDcvbkdndExaU3pi?=
 =?utf-8?B?d1RBdDZCL0ZGTGlmem5SY0dWNFhWSjJNUWlnMDVmMlJtR1lWKzBXWnRlY0Nm?=
 =?utf-8?B?bi9waWxndzNYVUw2Sy9oUUxXNStmSURpVTZIY2RBWGFoeEcvNkcxRTJuNkZD?=
 =?utf-8?B?QjFvZlZUclNvd01Kb1JxSjcyY2RhVWpzS3MranhRTkRtQUFrSGgyRHJTdEdt?=
 =?utf-8?B?Q3dKRGYwc1JDOTJHSnBNc3kyeVNEU3IrWXVMUWo0d2Faa1V5bDBabXkyUDNG?=
 =?utf-8?B?cnJFd0VUTjdhdkRsalRpNys0K0Iwb08xVTJWQittYmdRYW5jOTJhck9xZEJJ?=
 =?utf-8?B?RWpqOGl5OG1sVEhsUk9JSDFzWWlCaGo1NHBoZWxmUE90N0g1ejdzS2VsYVZX?=
 =?utf-8?B?YUwybzZhSzJsc3lxU3ZiOFFmZElTN3B6STJteGRMT3N3TWtXMzlBcGlabzNB?=
 =?utf-8?Q?EK8QP9iew2kSW/nsh3/xSN5m4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9153d26-3c52-4d25-e0b1-08db263b555f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 16:27:28.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wS+ZHaH37aePm8YyyeOYDq3Hs1shlZmcq7yCvztxJP0hI2LIHedm1qQP8YK3xoIu8WUTw6JlBXt3UiYqtKf6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
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

Hi Matthew,

On 3/16/2023 12:08 AM, Ryan Roberts wrote:
> On 15/03/2023 13:34, Ryan Roberts wrote:
>> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>>> From: Yin Fengwei <fengwei.yin@intel.com>
>>>
>>> folio_add_file_rmap_range() allows to add pte mapping to a specific
>>> range of file folio. Comparing to page_add_file_rmap(), it batched
>>> updates __lruvec_stat for large folio.
>>>
>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>  include/linux/rmap.h |  2 ++
>>>  mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
>>>  2 files changed, 48 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index b87d01660412..a3825ce81102 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>>  		unsigned long address);
>>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>>  		bool compound);
>>> +void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>>> +		struct vm_area_struct *, bool compound);
>>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>>  		bool compound);
>>>  
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 4898e10c569a..a91906b28835 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1301,31 +1301,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>  }
>>>  
>>>  /**
>>> - * page_add_file_rmap - add pte mapping to a file page
>>> - * @page:	the page to add the mapping to
>>> + * folio_add_file_rmap_range - add pte mapping to page range of a folio
>>> + * @folio:	The folio to add the mapping to
>>> + * @page:	The first page to add
>>> + * @nr_pages:	The number of pages which will be mapped
>>>   * @vma:	the vm area in which the mapping is added
>>>   * @compound:	charge the page as compound or small page
>>>   *
>>> + * The page range of folio is defined by [first_page, first_page + nr_pages)
>>> + *
>>>   * The caller needs to hold the pte lock.
>>>   */
>>> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>> -		bool compound)
>>> +void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>>> +			unsigned int nr_pages, struct vm_area_struct *vma,
>>> +			bool compound)
>>>  {
>>> -	struct folio *folio = page_folio(page);
>>>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>>> -	int nr = 0, nr_pmdmapped = 0;
>>> -	bool first;
>>> +	unsigned int nr_pmdmapped = 0, first;
>>> +	int nr = 0;
>>>  
>>> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>>> +	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>>>  
>>>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>>>  	if (likely(!compound)) {
>>> -		first = atomic_inc_and_test(&page->_mapcount);
>>> -		nr = first;
>>> -		if (first && folio_test_large(folio)) {
>>> -			nr = atomic_inc_return_relaxed(mapped);
>>> -			nr = (nr < COMPOUND_MAPPED);
>>> -		}
>>> +		do {
>>> +			first = atomic_inc_and_test(&page->_mapcount);
>>> +			if (first && folio_test_large(folio)) {
>>> +				first = atomic_inc_return_relaxed(mapped);
>>> +				first = (nr < COMPOUND_MAPPED);
>>
>> This still contains the typo that Yin Fengwei spotted in the previous version:
>> https://lore.kernel.org/linux-mm/20230228213738.272178-1-willy@infradead.org/T/#m84673899e25bc31356093a1177941f2cc35e5da8
>>
>> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
>> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
>> ext4 filesystem). Looks like instruction aborts are taking much longer and a
>> selection of syscalls are a bit slower. Still hunting down the root cause. Will
>> report once I have conclusive diagnosis.
> 
> I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
> amount of time in the instruction abort handling code once patches 32-36 are
> included. Everything in the flame graph is just taking longer. Perhaps we are
> getting more instruction aborts somehow? I have the flamegraphs if anyone wants
> them - just shout and I'll email them separately.
Thanks a lot to Ryan for sharing the flamegraphs to me. I found the __do_fault()
is called with patch 32-36 while no __do_fault() just with first 31 patches. I 
suspect the folio_add_file_rmap_range() missed some PTEs population. Please give
me few days to find the root cause and fix. Sorry for this.


Regards
Yin, Fengwei

> 
>>
>> Thanks,
>> Ryan
>>
>>
>>> +			}
>>> +
>>> +			if (first)
>>> +				nr++;
>>> +		} while (page++, --nr_pages > 0);
>>>  	} else if (folio_test_pmd_mappable(folio)) {
>>>  		/* That test is redundant: it's for safety or to optimize out */
>>>  
>>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>  	mlock_vma_folio(folio, vma, compound);
>>>  }
>>>  
>>> +/**
>>> + * page_add_file_rmap - add pte mapping to a file page
>>> + * @page:	the page to add the mapping to
>>> + * @vma:	the vm area in which the mapping is added
>>> + * @compound:	charge the page as compound or small page
>>> + *
>>> + * The caller needs to hold the pte lock.
>>> + */
>>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>> +		bool compound)
>>> +{
>>> +	struct folio *folio = page_folio(page);
>>> +	unsigned int nr_pages;
>>> +
>>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>>> +
>>> +	if (likely(!compound))
>>> +		nr_pages = 1;
>>> +	else
>>> +		nr_pages = folio_nr_pages(folio);
>>> +
>>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>>> +}
>>> +
>>>  /**
>>>   * page_remove_rmap - take down pte mapping from a page
>>>   * @page:	page to remove mapping from
>>
> 
