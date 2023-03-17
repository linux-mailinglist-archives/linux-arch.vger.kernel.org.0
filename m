Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106C6BEA14
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCQN3O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCQN3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 09:29:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CE1B570;
        Fri, 17 Mar 2023 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679059749; x=1710595749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m8x2ZGCAV6rm/zzPK0eolRMSDEIuh8u83GVspHayXG0=;
  b=k2DVkACJ28/3uj5iEeKRdWrPitzqyNjn6MgEyNH5Z41l7jmSif+yVUjU
   c3Yiub0BnTA/e5x91vWn0ilvEGlzNVKeW8rLScmKvALBbIhoQjpoaIXrc
   cqb0EWgB8n+mHsNOfU5+drh5gyuggSfcNs+klC2QQIEgiQz96bzwpWyeZ
   HqHqOycC+I/V3T8D4kXPXJU3MAM0/kH1XVgkazmqw7nwOB0cU8b6tt0Ns
   p4OuymWb1+YryQg0HbBJ8w9tY9w/cU0ZqODriac/fmXlORMd1uX1r5OtE
   wkwyXUdZ2xpzG7pq3RaF0iCQNq2lz+ZynVoZNrPQ6ubj+72oikRfhKHsD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="339797640"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339797640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 06:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804097971"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804097971"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2023 06:29:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 06:29:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 06:29:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 06:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfoQeut1Z7JcYgrhdaPNT7FF+biOyYTgIW8lsxufIWw81r6dF4aA2vcF09MPkOzb4/cAtzkEQmWWduk59nGYXfBMPYoz2DLzs4NBrnIwK5hZe9UcJCcDjikZS6vM33WfCzK3h3Bqp6OF0rxPv26d66IfNhkVUWRvI41RKyHuVIqpS613MlU/0QEpMRumqAkCazE6bM6FPjHo3mLH1+8948o49o4dS/MXeYOpPYwxr4j/q+71N+CFYr7QFGaWXhfHFplwRvn+mWrVNjxB53EFKcsvVIOLRIv2E6FO8gxKedkB21QkSvit27FXXfkZpnQxswsfXxR/JAY71lKg3EmjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxEe06Ep7OdN9lUnnQ95ytQTgT3VuYs3IrHQRxrJt2I=;
 b=Z5U93IeMDdAPjrpVl6uLZRaOxIFNOTMndN6ZQQ5W5tqXm8sCxKq6LJW+27EXOpFc+F8yV9WgUBHe9FCrd6eGzxkj9v6Sfe4qktCjKZWCj6fYizLGvxkLsqruTmM3c74Z1lDJxPGZFaR0EfyP7tukUOXoNViKZW/luI4aQ3MiC3y0W0teO0H8fB9wh3pfgE/boVWNgxYv28ZSlwbyShFAvAdn2N69nhqNkIkkEv1+YiBk8xgXLwFLr1HbA0/9b3xLPoJXEsZ13IyOPK2IGrC/AwRp3TyIiTsO5ObSwcLbEm+361YvVzSjVDUdgzjyeOqrEuIfd5mJ+ZGvm2LFVrgB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 13:29:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 13:29:06 +0000
Message-ID: <c7c7f5ed-ef80-ef6f-4a73-806b21e7c65d@intel.com>
Date:   Fri, 17 Mar 2023 21:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-35-willy@infradead.org>
 <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
 <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
 <0f581d0d-3139-4007-2161-592a0a545b50@intel.com>
 <fe743597-cefa-4bf8-aa3f-da9cc10bbd5f@arm.com>
 <f3ffe13c-321a-07f6-6a6f-1a67f585ffe2@intel.com>
 <2b41a6dd-130b-acf3-72fd-b996272c1710@arm.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <2b41a6dd-130b-acf3-72fd-b996272c1710@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ2PR11MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6896de00-ffe0-4e33-df73-08db26eb951e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W34IF7YxM7GFcBlq15COkWz82kCw+svrI8iIcL5OTWFHmGaTLZigPfob7gtjdc5EinGHy3UiN2gZzpiv4oCvZd9Sth2GmillNFDkwckroE6jWZUWGaIsFRin2zrpo5rLGXc0xnNXAK7fpA63X3k4++HfR/7UeTnKhqrQQps0aY0w/7DaO2ixpUi5/scYGzwVDSryD+jfzNprOEXk8X5xfqDZYq5/LQGRoNP1b83/nQxfzJg3aNCGZLQ2vskhbsJ+LLN9uNSkCDxIgfFKksQTrZIbaQEArHEj4Kp5rL4EmpaaTTKa0hY0m7AWCfQZyvDWe6Y1kuw6fKSclFffqeUaWGUEVq/F1uUPWaP7ASMc0XQBqUxQJxeWDx242EQ0epfvRAEr8yzsj+nP5kksvjjDsSbi9UGxAA570USHAFx1cg8w4lNbf9xSn/icnhDQKWBqM8/N2mwtGfD2dZb8gWkesa6zmcR4snducrfCQ2WKfRxoZ9fDEL/f3wUZ79dn9PHisJyOQVFO6ayvhOaR+vf74hyIjBmeMHlS7BZRwhnZn7YxGA/Eq8RtuxKHqzbCgKK26j1YtLYM2+44zXsOX7sLuumS+CAvVYosABeSJbpOW295t/U5nxLEiLQr8ZacJU+N1P2gv+RTcjUE0z8Nq+taU5ZyV6+MEuYiYH70keIHKRS+GC7Wje6enmzgdYRULihUjYUkSI5wSuwhZaF6cpNQdIy1TSU17qmxecP+0aRireM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(66476007)(66946007)(66556008)(5660300002)(4326008)(8676002)(8936002)(6666004)(82960400001)(36756003)(38100700002)(6486002)(316002)(66899018)(2906002)(31686004)(41300700001)(2616005)(186003)(110136005)(478600001)(83380400001)(26005)(6512007)(6506007)(53546011)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitIZnY5akU2VDNBZm9tRWZKOER1dUo1K1V6aWhYaThFOE9PWkIzN3dmMHNh?=
 =?utf-8?B?RFV3QUw2ZVV3NnN3QVZGV3RWUmk3S3BzWkVCMmJwa1hDR0h3Zmc2NlM4QjNo?=
 =?utf-8?B?a1JUMEcwWkRmQmluK0xQVTVLOVc0UFVyY1B3L1gxVWlLY2FSck9kRkEyN3hS?=
 =?utf-8?B?cngvZllJMTVpWGFSSldoSSs2OGZCVFcyNjVVdkZPRG0yanZDMFJsQW1LSldQ?=
 =?utf-8?B?WW1FZlNoSmw4MjdYZk5uekFlTVZSWmFOUkJPQkFPdWtNYnBDK0FiQUc1UjVr?=
 =?utf-8?B?UUY4YVZlOWxnMUNvL0tKZm9WQnBGbkpMZ2RCMmNVTUpBTTdZN09DQlhqQVV0?=
 =?utf-8?B?cUJSeEFPNGg3QXhZRWx2bUVUTG93c2JJT2szTTFWOTlHSDk1NjhXWFRDYUVx?=
 =?utf-8?B?UVFPUGY3RThiOFNkVS9VMzRXcGswS0J6NXlCeGt1NitzS1JMYktHUHJlNStW?=
 =?utf-8?B?c2pxazV1Rm9RREhqYkpoSjZXM3UwRXVqZG00Q1Jrd21RWGE1UWxXdmtZUDly?=
 =?utf-8?B?eXZzM0k4bW9DVjc1MURlZTdoSU1ZOWQ1UDR2N2R4eG5meTlIa3ErOVBLS3I3?=
 =?utf-8?B?RVhaWE9GY0tFUmtLUExDMHVMTE9KK0YxK1g3a1h2cTBKWmpjalNzRUV5Z2lE?=
 =?utf-8?B?ZU5CbWxJZ3U3TTU5bXNHeEhHMmpTTnM2dHlMVlZJOWh3dXN2NENvei92L05S?=
 =?utf-8?B?WTlxYzFpemtlU3UxQWg5bzdGb3NoaHJaa3lEOUt1dTVlUEJTVlBVQkpEcVFm?=
 =?utf-8?B?U0k0b000bW96QzQ2NlgxSzV4TTVTZWVGbVBoNUZyZDJUVDFMNXIzQ1lEQkVy?=
 =?utf-8?B?Q0xjOUhaNlJpQnl0eGI3ZDBwLzNKSXhweTJ0S1VRVDZ5MExwNWJTMDRua1Bv?=
 =?utf-8?B?UU5rMEo4aFVCT1FvZGc2cUZoanJ6V1Z2Nm5WMEhjNktsMWxEbnMyaXI5Sk0y?=
 =?utf-8?B?M0lQLzRvekVPTWo5OEFDNk1RSTQ4NlUydEk1Y2FwV2paeEx5QWFqa2JDRlpB?=
 =?utf-8?B?ckRxc0tWU2ZDNkZ3VlhhZ2c5V2VPeG80TXVEK3dFS1hQd1NxVmZkZ0VaTk9B?=
 =?utf-8?B?SnFyUENnelBub2dpdmlFR2h3am0zd0RIWmJMUVNjYlZuK1RncTZRTTBKaGlW?=
 =?utf-8?B?cUlSQUFJaHBPeVBKWVpySVVLczZucnB1cndsMEVIZVRZQzJMZXNoeWFsTzND?=
 =?utf-8?B?UUc1UHM4ZENnSjRNZFRTbTlTN0IwOStaaDlRZlVvZldwQ2NLMk5ZT3UxWEp6?=
 =?utf-8?B?SE4zWWJ6aWlSUUVaRGZsa2NodGZidHU1VW5nNHJTZGpQa05URUIwQW9MMEVB?=
 =?utf-8?B?THp5RE5udHUzcVVZUHBHelYweFpkdmJMbzA1VlM5OXc4Z1QvKzFkbGJLZEZS?=
 =?utf-8?B?Tk1FK2lmWi9oT0ViWFVTVjl3MWZKRU5XTGU0WEoxSGM4ellhL0wxbkprdThk?=
 =?utf-8?B?dGt4T09yeFBTWTZad1dPNk5QbTBNdklkVithWEVXN1NYTUM2MEh4dGw4UGNs?=
 =?utf-8?B?cFdLUVhBekxXNkhPZEp1SytRS1UvOWxBZlJwT0RyTFFneVRxVE14anV6L2xk?=
 =?utf-8?B?Qkp1a1BrQUROaENvN080OEhXUzBYLzNrb1dYekZNQjZUWUVHZzdWZlBwMlRX?=
 =?utf-8?B?d1FtOXZNaGZJUHNmK1ZtdURMZ2s1eUtQSlZiUjhGR1ZNc2d0eHNwSGNlN1VB?=
 =?utf-8?B?TU54eGhMR1o5WFFTTkhFQWpsa214OUlPQ3Azb2FDdlg1V2NjT0J6N2dnY0NC?=
 =?utf-8?B?L1FZR3YwZTF2MEdpNk9UOExVbVBnLysvZTd2WFBhNmVXdHNiV3k0Y05LTmww?=
 =?utf-8?B?cmtlcjBpeEhiRG9nalNqaU1aZjFIcnR4bjhrREFNKzlxY3dHNnFXeEtPVm5V?=
 =?utf-8?B?aTI1eWpNb0ZmTm5LN29uN21waE5sYXdXZzJDWUNpSk9IeTRmZ0cxalBqOFZs?=
 =?utf-8?B?ZHNWK1JreHhFSDhqWmRLMjNnZ29KWGpIb3J3VUE3UVBkMGgzNUZVYnd3b0d2?=
 =?utf-8?B?aFd0c1RkTzM0SzRpNnVFRDUwNE1mbndPeTN2MS9SQ3p4d1JaVEFlQUxRaTF1?=
 =?utf-8?B?eEloaFV2UThhcy9LZU9rd3kvWWRiZkpNaVhVRk5wV1pRdU5YUEJ3OHZ1bVJM?=
 =?utf-8?B?NkJJWjlXVm9kL2Q5VzRHQ2tGbXFHemVBNGd1dnZjYVcvckRiWTN0MFAxZThP?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6896de00-ffe0-4e33-df73-08db26eb951e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 13:29:06.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMZqXo6AVOBnaVv5vC3hiw6Z/Vv+9VuVZxj0kjEMlarbCaiqkbKNt/O2HlXKWtDM5gIb/r7b6EQlZjo6rY7PZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
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



On 3/17/2023 8:46 PM, Ryan Roberts wrote:
> On 17/03/2023 08:23, Yin, Fengwei wrote:
> [...]
> 
>>>>>> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
>>>>>> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
>>>>>> ext4 filesystem). Looks like instruction aborts are taking much longer and a
>>>>>> selection of syscalls are a bit slower. Still hunting down the root cause. Will
>>>>>> report once I have conclusive diagnosis.
>>>>>
>>>>> I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
>>>>> amount of time in the instruction abort handling code once patches 32-36 are
>>>>> included. Everything in the flame graph is just taking longer. Perhaps we are
>>>>> getting more instruction aborts somehow? I have the flamegraphs if anyone wants
>>>>> them - just shout and I'll email them separately.
>>>> Thanks a lot to Ryan for sharing the flamegraphs to me. I found the __do_fault()
>>>> is called with patch 32-36 while no __do_fault() just with first 31 patches. I 
>>>> suspect the folio_add_file_rmap_range() missed some PTEs population. Please give
>>>> me few days to find the root cause and fix. Sorry for this.
>>>
>>> You're welcome. Give me a shout once you have a re-spin and I'll rerun the tests.
>> Could you please help to try following changes? Thanks in advance.
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 40be33b5ee46..137011320c68 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3504,15 +3504,16 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>  		if (!pte_none(vmf->pte[count]))
>>  			goto skip;
>>  
>> -		if (vmf->address == addr)
>> -			ret = VM_FAULT_NOPAGE;
>> -
>>  		count++;
>>  		continue;
>>  skip:
>>  		if (count) {
>>  			set_pte_range(vmf, folio, page, count, addr);
>>  			folio_ref_add(folio, count);
>> +			if ((vmf->address < (addr + count * PAGE_SIZE)) &&
>> +					(vmf->address >= addr))
>> +				ret = VM_FAULT_NOPAGE;
>> +
>>  		}
>>  
>>  		count++;
>> @@ -3525,6 +3526,9 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>  	if (count) {
>>  		set_pte_range(vmf, folio, page, count, addr);
>>  		folio_ref_add(folio, count);
>> +		if ((vmf->address < (addr + count * PAGE_SIZE)) &&
>> +				(vmf->address >= addr))
>> +			ret = VM_FAULT_NOPAGE;
>>  	}
>>  
>>  	vmf->pte = old_ptep;
>>
> 
> I'm afraid this hasn't fixed it, and I still see __do_fault(). I'll send the
> flame graph over separately.
> 
> Given I'm running on ext4, I wasn't expecting to see any large page cache
> folios? So I don't think we would have expected this patch to help anyway? (or
> perhaps there are still THP folios? But I think they will get PMD mapped?).
OK. I will try to reproduce the issue on my local env to see whether I could
reproduce it on x86_64 env.


Regards
Yin, Fengwei

> 
> 
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Ryan
>>>>>>
>>>>>>
>>>>>>> +			}
>>>>>>> +
>>>>>>> +			if (first)
>>>>>>> +				nr++;
>>>>>>> +		} while (page++, --nr_pages > 0);
>>>>>>>  	} else if (folio_test_pmd_mappable(folio)) {
>>>>>>>  		/* That test is redundant: it's for safety or to optimize out */
>>>>>>>  
>>>>>>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>>  	mlock_vma_folio(folio, vma, compound);
>>>>>>>  }
>>>>>>>  
>>>>>>> +/**
>>>>>>> + * page_add_file_rmap - add pte mapping to a file page
>>>>>>> + * @page:	the page to add the mapping to
>>>>>>> + * @vma:	the vm area in which the mapping is added
>>>>>>> + * @compound:	charge the page as compound or small page
>>>>>>> + *
>>>>>>> + * The caller needs to hold the pte lock.
>>>>>>> + */
>>>>>>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>> +		bool compound)
>>>>>>> +{
>>>>>>> +	struct folio *folio = page_folio(page);
>>>>>>> +	unsigned int nr_pages;
>>>>>>> +
>>>>>>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>>>>>>> +
>>>>>>> +	if (likely(!compound))
>>>>>>> +		nr_pages = 1;
>>>>>>> +	else
>>>>>>> +		nr_pages = folio_nr_pages(folio);
>>>>>>> +
>>>>>>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>>>>>>> +}
>>>>>>> +
>>>>>>>  /**
>>>>>>>   * page_remove_rmap - take down pte mapping from a page
>>>>>>>   * @page:	page to remove mapping from
>>>>>>
>>>>>
>>>
>>>
> 
