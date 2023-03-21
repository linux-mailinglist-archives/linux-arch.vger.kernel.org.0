Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AA6C29B7
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCUFRk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 01:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUFRi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 01:17:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1938452;
        Mon, 20 Mar 2023 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679375856; x=1710911856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yiy86NJGKnaxXuR3fBKwqnPyQxDaYuuMkJIOWUTojpI=;
  b=mgBIoNyXrWV4NYGQ7Q8ySDdYDqUYdsY2AZuuzEPSaAj8VSoIBTEkNYBQ
   K/zAFVlQ674wv3DtwlvTkNSVRVlKfmtTst9Pcjvt5xTbuQepocCeV+EfG
   QdKA5UE9ops3XelxMuJazYcRbnP5VXkDoY+ewoV0JtDdj1UbW+GLjBzIA
   fV8uu02Ucd5VpPr4DT/lyIYkPy9KgP66Yye23S68JRCUu5OhgLe5yD+qz
   Uxeg8TkgIYazcPgi8B9bW1LxI5IgSTk0/n35+zlAefSBdFiNH7CnpbJFt
   Cx2YnxuqL0r+pR+9xr/aCqsEy8X9SB+013n3t4EhOv+IqSY4JJTzUkzqT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322691755"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="322691755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010786313"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="1010786313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 22:17:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 22:17:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 22:17:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 22:17:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 22:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFQeGd6cN57MRWZJGSmF2SCTZ9uUaEsXePcrTJ0xAfokrTHelJw4J0gLboLTLyG2QZE/UAt9icY3Z63+qo0A6yhd0mM+beZrT8aLw8vOGos9CGGYqEDGNYGSgPhdVk5y420FsGNofn/1X+B3MuUXyq63R+mr9KHzEb5sL9NKBGzPyZEOTp/cg4UALJKxqXPpdz1CZV0OImxDbi9CzfSsH5SU1t4JdWQ6T+MqjEIJJn7xALvz48MxHvc6TVETmBBvix2Lebil53z93EA6eiPjaUJzEqFuOzp7YOjr4agAo4+UWFVQaHeDfDX/8Xoh0tOstzqwiAfNU6A2SJYaQsDZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfuyskc+hVJZ6fi9NmnRifEmAt0YaAa2SzV1dg0vg1I=;
 b=JMPv2LN3mBfFAmQWiJFArUyFAZSs6gUmApRlz9ZrW+PfMFU6xl4erGB94T3M9L0W2sCxuPnRUtvskBv1AQD5CcF744clo9M8+u/fZ7gvLZ+1RsIIokpXuS1VGf5eVMj5ZC7DsWj4gJ6Bk3NesYnWfWRZC6E4R7IaZnpjZePKqc474CAjIoEJUVMX4qc9j9fd351ESAVti6MUsPyuHOGksoHnHY6+VmwSLCKKYosW0wCZKt4eB9Br8osR4vLp5XmkoCG1+frj02M5Y0my3l+yZkEMqetz7KpVSTBby87DdJv0yvstdn6VutysuzyCbzpfEVYAthPjWcrA6BhcsVCXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:17:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 05:17:32 +0000
Message-ID: <f0c4bd16-e8ec-fda6-108d-8a9848f0eadd@intel.com>
Date:   Tue, 21 Mar 2023 13:13:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-arch@vger.kernel.org>,
        <will@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <483fd440-df7b-fab3-b138-f3789f2dc078@intel.com>
 <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: fad9b0ed-5526-49ed-0a51-08db29cb92f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22LfMgUissStjpS3QFbGvvogmxkzaf92jGxMO0GvkbkG8IesR1WPFAKYJF8m1J+HHDO5kbYHeluIonfxOpITiBdfXBdaX0kz0JphajbzAVdoSIfBrN/hlGCPPg1kuEIL3V4yTEXBUwTHpNpNE4t0LyzxqgLkO2Nh0pknwIyr7VFkgrEEGcwG0eDCiE7G913TYOdLC9qZRZ134O15aKjU0dn0IO95CoEMpT+IE0FoLsUHD4EiBzFuXbJmHoP1dOg74I1QkzPFz1s7Cu5Dq1sxzt/Qa7xrZZtDkFlh2M20P1F6kUWxiA2BWF8//HTn3jcqqrKx0+4y0o413c2QiXNPqHfO3ijhcnK0pLldhD5MDrdrO3yZDUyYKPKh4m3luIJUCcvIPZWMwvdR9mJPc7K/F7OZMgIML+LNvoNBNYRVb5XcSKGR75EvbA6HeNVVm0q5Df7W0qax5Vc7DEfP/LKTaycwR+KNExqdwhBnJnbe+f0S9BGbXNNHKPXM8I4/fa6Qly0AO0TmM/L5nN70LM1hPaQlzL8rLzD5Mjd12wqmyB8lZrO9IB0K8IWyglT91W1KWrxqX1iQs56zzF/ElKnLZ+gSm21jf0+C+QzoMW4qWr4ldjDZgoHTqm28SL87Op6Qz5LX/i15n1krt44eXK3N6Op0nRFpNjOvGuD/w7S5SMvnK2TmaPvojYL4P03/p6Te2aTN9+z35H+JuoVX9GJIhEMHZlmUpNcS+Bx9/EjOfjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199018)(8936002)(41300700001)(5660300002)(4326008)(31686004)(6512007)(36756003)(31696002)(86362001)(38100700002)(82960400001)(2906002)(6666004)(83380400001)(478600001)(6486002)(2616005)(6506007)(26005)(186003)(6916009)(53546011)(316002)(8676002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZjZS9wNzlEUUplMzA3MzgxWTVaQjBOd2pZcXJlUXIyRmh4SUE0eEczSEZK?=
 =?utf-8?B?QVBhMUNTOWlBb01pYlJFOG12MHRycWs1WnpFMGx1RHZWNDZqekt5RDBZL2xI?=
 =?utf-8?B?RFhZOU1xNDRCRTRmSi83NXU0dHM0dldDY3FDOW51STh5WUkrQkVSZVNBaXov?=
 =?utf-8?B?cnlwWm5KQkFPenFPWFZacDVtZUpqa0RIZU5zc0VqNkRTSzdtS2hXbkliRmE1?=
 =?utf-8?B?cWVub3hrZVNGdldTNVpETnVsc09UbnFoSXlyZzBqZk9LS0taSE1oWkNGWk5K?=
 =?utf-8?B?UDZsMXVTdit0U1lLN1JsekNkTUcxR0ZROCt3WThqeHBRcmd2azhSWHlwb3BM?=
 =?utf-8?B?OXBadGFETHd2ZlppRkJTeFFLNm1kaWxqK0k0Vkw0dFBGM2FhbUZVRDI5WXZQ?=
 =?utf-8?B?N1pZRHVmaUdZZTZWUXdTcmhrRCt1WWlHWXhmVTRDZWxFRGZRZnhUVTBzblZN?=
 =?utf-8?B?S0JhWWc3SEoyb05KazRpTi9mT2hGcnpiMnRsOXA5TWpoS1k1WXRDUy9OeTlq?=
 =?utf-8?B?aUNtZWw0bzBKd1VVUEQ4cm1BcVorenhNL1p5ZGRWMldiQ0d2RXRNaVc0L3B4?=
 =?utf-8?B?K2JHSDUyVlJqY2lwZEZ1Z1dQTngyRkdPUHZWRGNzTjR1MTlUV1AvaTRnL0ky?=
 =?utf-8?B?d3hNSitFeXNLRnRzcHdjWElVQWtCWFhCSmNDNGZ3WGd3bytnTHF4NU1tQ0lz?=
 =?utf-8?B?bm5YV1RnYXhxL2Jkay9PSjJWN3MwUmdvSjd4UG4zMmk2aDJTK0ROczVOQXpn?=
 =?utf-8?B?ZWU2VXJjVXYrdHlpR0FVZ202N2xkTVEyRzlZaitEMHJZSUZiZFVnZlFCVm56?=
 =?utf-8?B?czBhd1FIelZ5SW1nNit0bXMzR3VqZzJnUHY5bXlWK09nTklWQk91bitPUzVQ?=
 =?utf-8?B?S2o0ZTNJMGVGNC9HMHVXMTMxUmFUSkdjSTN6em9ZQzVhNncvY2tjLzdsOERU?=
 =?utf-8?B?dzN4TnI4TllTdlgrVXR1bXU1d09WVUJya3cwTWtKaUs1RmdBVVVwcEpkS1U5?=
 =?utf-8?B?RUgwVXRreWNBQ09Sc1BTeGN1MnlndnBjQ1FFa3hDZ2pxT1ltTVUranBWRndU?=
 =?utf-8?B?czVrTFBKMERtZDBBelhUUDVDVkYxeTRUc0paNEllV2Fieno0alNpajc1aG9B?=
 =?utf-8?B?aVdSZ0cvT1NQSTJtMTZJWFJLb0dueVJwekhiYk9OdGxQNVpUcE5CNkN4ZUZj?=
 =?utf-8?B?aTgzUVVsV3h1V0VlMEZoL3poZGpkb2U3dGIrdUNTTFJCWkFCOU5ndzhEL0hq?=
 =?utf-8?B?TFJqRnBGRjFscDV0TkF3SkNqd20yNjI4andEMSt5WmZ5VGJ2MGlHSU9hVzlR?=
 =?utf-8?B?bTNHTEVMTUgwZEJtWHVqWUxpZytWZDU1THFka2hsazFLWllCTFFUMHJRT0Nw?=
 =?utf-8?B?bGt4eW5TK3NxcTdsTWNSeXNIUVNkamh1TURiSXhoaWdXcG9DYnVVUVhWTWUw?=
 =?utf-8?B?U3JqcWJ2U3A1UlVyT1RWSEZ0ZGJBRXJaanpscThkUUxLTW5xUGtNb0FhaVZ4?=
 =?utf-8?B?U09OWWtyRTNrWnFRcmYzUzhOOGVXMkwwYWxKRzhyaFdESUhqSytzYnl2cTVB?=
 =?utf-8?B?Ly9BSVFlSTF0bmZxdUpmeEVDckpZRFp4RmErUmlDN3BVYVRwbWlvbWNxb3Rv?=
 =?utf-8?B?bUxHNjFwT2E0Uy9MbnRycnZqWmRieVh5T2pPcWhPdzlsM3AyQjVZejg3MWpj?=
 =?utf-8?B?SndCY3B3TmlwVnZBQUs3d1Y0Zi9HMjZoaUYzSEZ1cHEvRGZIRGdFMFEvT0Q1?=
 =?utf-8?B?WUFmSXhEMFFpc3ViTVJCeXVCNmRIbUdxZEFPUDJua01qbC9XR0d3U2Jtam9p?=
 =?utf-8?B?U1dGMzNaeVpQU051UTNEWWNhMnVYWXRtOU9BcVEza0lWVEJQNk9uekxQdnU0?=
 =?utf-8?B?OWVub1QyREgwMituWmpnOXR6M1R3OFhtbjFkZFBaWXIyemZaSWJoWlN5ZEVT?=
 =?utf-8?B?bitVZ2RkWVVDSmN3cHJZQ1hpN2RQZGpUTThlejFnTjNhNHJITjVReDdEejcv?=
 =?utf-8?B?Q2FQS0VOeDR4dDJFU0lRbXczemJUOW54OXFRNjRrcUdHZjBzcU5uNlBSRTRG?=
 =?utf-8?B?Wk1tRWNPMHZOWG9xWXhaRXVYendybmYvMUxHZ01CcVJ3bU9YbWc1S2diYmlL?=
 =?utf-8?B?b0c3TG5oM1FVTCtFYnBycU0yejgzYmZjUU5LVmlKODFvcXZOUVdOTnRLWHlG?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fad9b0ed-5526-49ed-0a51-08db29cb92f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:17:32.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj+hPViEC6nIwTn5qf61VL4WiDfDktFxHuJbT1mHLczVEkV0vAdVH5c5TZ3rbZelDOTVOnDdzro+n0Fn2rilOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/20/23 22:08, Matthew Wilcox wrote:
> On Mon, Mar 20, 2023 at 09:38:55PM +0800, Yin, Fengwei wrote:
>> Thanks a lot to Ryan for helping to test the debug patch I made.
>>
>> Ryan confirmed that the following change could fix the kernel build regression:
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index db86e459dde6..343d6ff36b2c 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3557,7 +3557,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>
>>                  ret |= filemap_map_folio_range(vmf, folio,
>>                                  xas.xa_index - folio->index, addr, nr_pages);
>> -               xas.xa_index += nr_pages;
>> +               xas.xa_index += folio_test_large(folio) ? nr_pages : 0;
>>
>>                  folio_unlock(folio);
>>                  folio_put(folio);
>>
>> I will make upstream-able change as "xas.xa_index += nr_pages - 1;"
> 
> Thanks to both of you!
> 
> Really, we shouldn't need to interfere with xas.xa_index at all.
> Does this work?
Yes. This works perfectly in my side. Thanks.

Regards
Yin, Fengwei

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8e4f95c5b65a..e40c967dde5f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3420,10 +3420,10 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
>   	return false;
>   }
>   
> -static struct folio *next_uptodate_page(struct folio *folio,
> -				       struct address_space *mapping,
> -				       struct xa_state *xas, pgoff_t end_pgoff)
> +static struct folio *next_uptodate_folio(struct xa_state *xas,
> +		struct address_space *mapping, pgoff_t end_pgoff)
>   {
> +	struct folio *folio = xas_next_entry(xas, end_pgoff);
>   	unsigned long max_idx;
>   
>   	do {
> @@ -3461,22 +3461,6 @@ static struct folio *next_uptodate_page(struct folio *folio,
>   	return NULL;
>   }
>   
> -static inline struct folio *first_map_page(struct address_space *mapping,
> -					  struct xa_state *xas,
> -					  pgoff_t end_pgoff)
> -{
> -	return next_uptodate_page(xas_find(xas, end_pgoff),
> -				  mapping, xas, end_pgoff);
> -}
> -
> -static inline struct folio *next_map_page(struct address_space *mapping,
> -					 struct xa_state *xas,
> -					 pgoff_t end_pgoff)
> -{
> -	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
> -				  mapping, xas, end_pgoff);
> -}
> -
>   /*
>    * Map page range [start_page, start_page + nr_pages) of folio.
>    * start_page is gotten from start by folio_page(folio, start)
> @@ -3552,7 +3536,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   	int nr_pages = 0;
>   
>   	rcu_read_lock();
> -	folio = first_map_page(mapping, &xas, end_pgoff);
> +	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
>   	if (!folio)
>   		goto out;
>   
> @@ -3574,11 +3558,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>   
>   		ret |= filemap_map_folio_range(vmf, folio,
>   				xas.xa_index - folio->index, addr, nr_pages);
> -		xas.xa_index += nr_pages;
>   
>   		folio_unlock(folio);
>   		folio_put(folio);
> -	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
> +		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> +	} while (folio);
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   out:
>   	rcu_read_unlock();
> 
>> Ryan and I also identify some other changes needed. I am not sure how to
>> integrate those changes to this series. Maybe an add-on patch after this
>> series? Thanks.
> 
> Up to you; I'm happy to integrate fixup patches into the current series
> or add on new ones.

