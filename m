Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F6697BB7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjBOM1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 07:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOM1o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 07:27:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746F34306
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 04:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676464062; x=1708000062;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yTML99LW91LpxJb5rxKQqvR2226GEi/wpj2weDxD2r0=;
  b=DHG+9eDpi9TDAqSCdQH6LTviIv1YEF2KvOH5Q1Lr8jquZFYSutn1gYHV
   S/YjMNleYi0gB9oVQJ8JWGL83QafGYpnX+5BmKNKN2ICexn8JJUiYAznC
   NYX+ArMRx35g/lpOQrq9EpDtMX8BKkWMlg/o8u3HkTDGxF1Aer0nrlj/J
   U+D1odAUCwgRe4nqn0vc9YBX3D6wajDJl8GzmJnZtohG0WPpBpaI4xacZ
   ihGnq+Zgju+M1aE0OHW7kMBgP2bX7797ifONKD+SDyOj5c0oy+lMlzhf+
   MbO9g7sP8P1s6nsctbsfimk19oKb3gsHQmzwK6gJVUhemvr6Q9enjarVg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311044635"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="311044635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647150852"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="647150852"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2023 04:27:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 04:27:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 04:27:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 04:27:40 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 04:27:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE2fh+cyC0RMSatjPfuIaTh45Q6SqPPQla9pp90YV22z97EbDfLiZZDRW/2QW10LmaNvzWQ/BShWJbKdFAxv7Q4zPbRWf+zDFrj2LnnTnG5PBR6LKz21lnTMPP0H4TWekY6memZKNNcvv6Hlb/DazDVsOavneLYc2tb48MseB2M+9qSCiVHGz5gWePqvd/I+ZXem/0F1zyUTvq4cG7ZMLmUW3WH2v0eNTJ+L92cYS9tJ+zvA2D8uOLSBUn9bOY1mjBzVdWWhJ18eawxt3xsUTXdbKMkDpVGvXlw5heRQkskavjRUgTy79PRrBl3915CGVhEI0qs2HvV96CicCL2NBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl/YDM237XQdlrpBQdSrK+iyEAQ9BxUQfAxRg72O4YE=;
 b=mZa88SM6qPvO497cuKg+JaTXyUdBxwn3+z8xNB0Q5ZjX36bs2BiAqxHkxQyG35QgzjBRNKq3JloArw8JT030KGZDW3tOmcppmaV2x2cnuLQuF7yBr5dHkoT50KKQafMASs4ezwzUDLDJpZaAF2kvGR0KUdKEDhlrlQXRcBZRWEyjOb6YPVbhwrcgbN0gGQZg0ugFGhwK45OYe56z+zqiL/K7jMjq36ySJ7Z0MAhB1y8+oAC1dIuV7m9DyBefWeJfJtDLuEvKpk/T3qYustCgUdytWxqTvU2r+OqYX9xDFZbBkSQL5fveoVVTdp/P3ncjqljhEepDhu6fVwGvDTWY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB5198.namprd11.prod.outlook.com (2603:10b6:a03:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 12:27:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 12:27:38 +0000
Message-ID: <27809f5a-17fc-abf6-7703-62a3c1b41ef3@intel.com>
Date:   Wed, 15 Feb 2023 20:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH 10/7] riscv: Implement the new page table range API
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-arch@vger.kernel.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-2-willy@infradead.org>
 <c02faf6e4af4babd24b3107d5fc2c6bff1d63100.camel@intel.com>
Content-Language: en-US
In-Reply-To: <c02faf6e4af4babd24b3107d5fc2c6bff1d63100.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 25731f4e-2e17-4667-6a38-08db0f500659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dz3Helnsvf5rWor0iuCRW8w/WTVgcVxi8YCfQpdEvBpXDW9rKpLmehKqSwjwwdKobo/+oXdP+XVEnakBOdNLCkqSMFOEhWvZTf8z78KvfYLyNbhFmSWx4tncCjEElu90JSwxVwqIe7V92n9JzpxREQD4arCunM7EjRnclbwhkFaWGV0HCIvocVpyMh49K91dvdfiX7qwAQEO1PgdnJDUKk+WACV49rTKwT5nPWIGDs40KVD+i1vDCJSS6hkR27CATLe0vqw2alU8Nn+VT4D/ipQ2Qq7/3tU7PwdFVLeTWTKmS70U9/mEpvVjliJTmmH0t/iyx/I0r34C1rcvrqPr8ahlqOeHtqxn6SBj+6dqSq/sxkdg9n06Cq51lhoIauuRmkbYRpCeJz3iMTsYA3Hwy3D+eHN6LxjtNkC0OIoOGBLkQ9vH7Xd10/haVuB+UGwa3DBfGP9VDUkxyFV0FWKYaQxRuj5+5NfI5UBwgUD12PR5MtpBv7M/2IpEYVoeAavSGPpUzX4GNJ+VDOk1ZBR748EOEYKcjfo5BquATTUW5xLaQiQXs/fJH18xHr+dbPUk07ynNa8lXRFM+RuC6Rh/9rK30vJrnMxZRDqn9NuhAsVa8ZWIon2LDm38UesvvsvHM9KVQjsWn4gjfpzG5mltNTaMDflC5jxTUD45/bGpEccQBB0EsTZLlvDABsZ9sU3BmgkTgc+RrRvfURSIoiShuHFVHaH2YMZ2w0UEZbMWCHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(36756003)(2906002)(5660300002)(6512007)(31696002)(83380400001)(6506007)(26005)(186003)(66476007)(2616005)(8676002)(66556008)(82960400001)(38100700002)(316002)(8936002)(6666004)(478600001)(86362001)(53546011)(6486002)(66946007)(41300700001)(31686004)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFXK1FaUDJsWHJyUEQ0VXM3QWZZNEY5cHVwdTVRMEc4WjgzYUNCYWxsTnFD?=
 =?utf-8?B?SjRMREo3YXpGLzkwYXR0MXN1OExoTnlnKzFYdUp5bUVudnBZQUVEem5NNkwx?=
 =?utf-8?B?bVk4LzJmeXRQZ2JNbjFLQXBVdWdrVXJ4d2M1RmI3RnFJcmxHVG5zV2NLQUNk?=
 =?utf-8?B?U1o0aW4rVElwbWtpUnB6UklKTllIcUREa2JJM0pFcWlRWDVhV0VoVmZIc3RK?=
 =?utf-8?B?dml6K1NmLzlCOGtHa3k4U3RoT3U2TU5NZnFkYVZuMjJXVE1TTlJvb1dLRHJz?=
 =?utf-8?B?R0tTRklRUjByUDUvWGMraXhMOUo0eU5keXp0VGVmT0xlZTJwaDQrK2YxWUFM?=
 =?utf-8?B?d2NJREtURFE1c1lXSXZ0NElWUlNjSGZ1aDZuZUVCampYczg0L3FjSGxwb3pQ?=
 =?utf-8?B?cFFoWmN4OVUwbUtOeVV1MWFIellkM3R1a3VSWDM2eUpXOTM3VTFDSU5VdVAv?=
 =?utf-8?B?d0lPd0Exa3J1Rlg1eGZMS2lYSEhtT1VNR2tRcCt1MHcwRHViY1RIYWtqZStW?=
 =?utf-8?B?U1Y5NTVIeWhCRi9CS2NHU2grUitFVmNoWlZQMXJKbGNsYTJ4a2dzR0I2UUIw?=
 =?utf-8?B?R3lGVUFOTGY1cDBTVFlrS0taakFwY2JHUjYyNktDZlFzcVNET0xYNk1ycDVq?=
 =?utf-8?B?YnVMVmRoMHdPUi9CeTYxejNmVnhvWHQvejdBMTBWTER4Z3JrN3lBUkNUMlNC?=
 =?utf-8?B?bXpCR1lzQysvSnBtMjZZVDFuWDdKVThrMmlyTEc2dURMYlZmeVB1SkIzK29I?=
 =?utf-8?B?V1E0cUFWVUdpd2xsdlEzWTFjMnREQTRsYjNRNVZVd3RVa2RvbnQ0MTFmUEoz?=
 =?utf-8?B?ZlFPZUowY2VXaklWckpnZXNvb0NWTms5TDBrUG5VSmZNOS8vQkdVcTlLQW02?=
 =?utf-8?B?TnZSRlE5Nk9KVzFjYnZsb3JFb2hpVkpWK1ZhNWUvRjU5YXY3K0szOUMzZzEw?=
 =?utf-8?B?OFd6emZrR1F2ZGlOUDlzTDBwVHRvV1Aydy9TalFEd1BkSG1EQkJNMGpWcXhY?=
 =?utf-8?B?WjYyd1VZb3dSbXJSWFNtc3N0ODl0UDZKSEVCdGliNVJtVGZ0UEd5UHFUTWxD?=
 =?utf-8?B?QW5XUXJoRlFXMXBoSW90dXVxMXBWTEcxZDB4bmpkaFN3SUI1UlRNdGk2RlU5?=
 =?utf-8?B?OXpJZnQ2MVR6blVqN05Tb3JUZWx6aTNoc2xwTE9xeGRlamF4OWUwZTFZN2lj?=
 =?utf-8?B?REFtQkE1V0F1amUvYnVhekFKbnJNY28xRlc3Qy9iSDNuSytkODJGU1B2WmNJ?=
 =?utf-8?B?OVUzcjVUak8wMy9BZXdBNWlaNVlkb0orU0JrQVZTdG55ckRNS3h3Q1kwd2h4?=
 =?utf-8?B?QTZLNFcrT1VLTlBHRWhXVnF6WUxQeG4xVFJ0aW4xU0pDZGpqZ2tUVC9iaTB1?=
 =?utf-8?B?M2ZiYmVlTnZFeDFtbkZDdWxaNTg5aTJCNVJDbUdJQWphYjhlZnRBWFB3bHRW?=
 =?utf-8?B?UmhCWkJVbWhSMTlvZFUwYlluT0tGTFNsZVV6NDVBaFRRVk1SaTJMTFd2Vlc1?=
 =?utf-8?B?OTd4UlRSZFZYU1FXaVlVZmVyTTBub0xUbEtYT21LQjFWelFmWlNaTXpSYUx3?=
 =?utf-8?B?dmx6ZUdaNUh5SGNibEliSTlNV1gvbnNIMnBiYTI5ZGoyb2JCSS9icnZBSk1z?=
 =?utf-8?B?NEVtckhNanFqMFBIamk3b1ZQWHVyY2MzZDNnYkRQa1RQMmtiUEhvQ2RNNHhY?=
 =?utf-8?B?VXRZQkVPNmx0dFA1dTU4WkNTMDFZY0drNE9iMFIyQkhkRDJjRy9wMDVZMkFu?=
 =?utf-8?B?YlR2MWJoK2FzQzV5WVlkL1o2d0tta3NDRktCeTFoMnNMbEZDWlYzYnE1bUJx?=
 =?utf-8?B?S2E4RzNsWFhkSWpSL2lsdlZnbGpYVURaVW0yWmJRSEh6b1dvbThhTmc0UkF0?=
 =?utf-8?B?b2Z3U00vMWo3alh6bzEzY1F3alJqSllmSUY5NDNLbUQyVGk0MWRFK2tRdUNr?=
 =?utf-8?B?ejI1enNva0J3ZWNQM0lyL296YWpwTngxamVhNGt3bU9SSkJMRVlaQVZYK25w?=
 =?utf-8?B?bTFRRHpKRWlsbjhiOFkwY3EvVkNORkkxS1dCR1ZxUHYvNHRHdnBZRWJXWE1F?=
 =?utf-8?B?ckV0NjRMaENhejE4TmFVUnB6SVJtMkhqRUM4S1l4TWdoTXFUV2ZudE9zRUR1?=
 =?utf-8?Q?5D857fPJneVnF8jdP+TbqrR3A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25731f4e-2e17-4667-6a38-08db0f500659
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:27:38.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4mCsLohE/SLYPW2l6vEbwDU9foTGe97FWxBbfzQ3GUf71hXIT1UFJ34Y2o/AOthqxrea43xP0VeozwlM4N6FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/15/2023 4:35 PM, Yin Fengwei wrote:
> On Wed, 2023-02-15 at 00:04 +0000, Matthew Wilcox (Oracle) wrote:
>> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
>>
>> The PG_dcache_clear flag changes from being a per-page bit to being a
>> per-folio bit.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  arch/riscv/include/asm/cacheflush.h | 19 +++++++++----------
>>  arch/riscv/include/asm/pgtable.h    | 25 ++++++++++++++++++-------
>>  arch/riscv/mm/cacheflush.c          | 11 ++---------
>>  3 files changed, 29 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cacheflush.h
>> b/arch/riscv/include/asm/cacheflush.h
>> index 03e3b95ae6da..10e5e96f09b5 100644
>> --- a/arch/riscv/include/asm/cacheflush.h
>> +++ b/arch/riscv/include/asm/cacheflush.h
>> @@ -15,20 +15,19 @@ static inline void local_flush_icache_all(void)
>>  
>>  #define PG_dcache_clean PG_arch_1
>>  
>> -static inline void flush_dcache_page(struct page *page)
>> +static inline void flush_dcache_folio(struct folio *folio)
>>  {
>> -       /*
>> -        * HugeTLB pages are always fully mapped and only head page
>> will be
>> -        * set PG_dcache_clean (see comments in flush_icache_pte()).
>> -        */
>> -       if (PageHuge(page))
>> -               page = compound_head(page);
>> -
>> -       if (test_bit(PG_dcache_clean, &page->flags))
>> -               clear_bit(PG_dcache_clean, &page->flags);
>> +       if (test_bit(PG_dcache_clean, &folio->flags))
>> +               clear_bit(PG_dcache_clean, &folio->flags);
>>  }
>> +#define flush_dcache_folio flush_dcache_folio
>>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>>  
>> +static inline void flush_dcache_page(struct page *page)
>> +{
>> +       flush_dcache_folio(page_folio(page));
>> +}
>> +
>>  /*
>>   * RISC-V doesn't have an instruction to flush parts of the
>> instruction cache,
>>   * so instead we just flush the whole thing.
>> diff --git a/arch/riscv/include/asm/pgtable.h
>> b/arch/riscv/include/asm/pgtable.h
>> index 13222fd5c4b4..03706c833e70 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -405,8 +405,8 @@ static inline pte_t pte_modify(pte_t pte,
>> pgprot_t newprot)
>>  
>>  
>>  /* Commit new configuration to MMU hardware */
>> -static inline void update_mmu_cache(struct vm_area_struct *vma,
>> -       unsigned long address, pte_t *ptep)
>> +static inline void update_mmu_cache_range(struct vm_area_struct
>> *vma,
>> +               unsigned long address, pte_t *ptep, unsigned int nr)
>>  {
>>         /*
>>          * The kernel assumes that TLBs don't cache invalid entries,
>> but
>> @@ -415,8 +415,10 @@ static inline void update_mmu_cache(struct
>> vm_area_struct *vma,
>>          * Relying on flush_tlb_fix_spurious_fault would suffice, but
>>          * the extra traps reduce performance.  So, eagerly
>> SFENCE.VMA.
>>          */
>> -       flush_tlb_page(vma, address);
>> +       flush_tlb_range(vma, address, address + nr * PAGE_SIZE);
> 
> The flush_tlb_range() of riscv is a little bit strange to me. It gives
> __sbi_tlb_flush_range() stride PAGE_SIZE. That means if (end - start)
> is larger than stride, it will trigger flush_tlb_all().
> 
> So this change could trigger flush_tlb_all() while original
> flush_tlb_page() just trigger flush_tlb_page().
> 
> My understanding is flush_tlb_page() should be better because 
> flush_pmd_tlb_range() has PMD_SIZE as stride to avoid flush_tlb_all().
> I must miss something here.
So the huge page can have one TLB for huge page. So PMD_SIZE here
makes sense.

Regards
Yin, Fengwei 

> 
> Regards
> Yin, Fengwei
> 
>>  }
>> +#define update_mmu_cache(vma, addr, ptep) \
>> +       update_mmu_cache_range(vma, addr, ptep, 1)
>>  
>>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>>  #define update_mmu_tlb update_mmu_cache
>> @@ -456,12 +458,21 @@ static inline void __set_pte_at(struct
>> mm_struct *mm,
>>         set_pte(ptep, pteval);
>>  }
>>  
>> -static inline void set_pte_at(struct mm_struct *mm,
>> -       unsigned long addr, pte_t *ptep, pte_t pteval)
>> +static inline void set_ptes(struct mm_struct *mm, unsigned long
>> addr,
>> +               pte_t *ptep, pte_t pteval, unsigned int nr)
>>  {
>> -       page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
>> -       __set_pte_at(mm, addr, ptep, pteval);
>> +       page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
>> +
>> +       for (;;) {
>> +               __set_pte_at(mm, addr, ptep, pteval);
>> +               if (--nr == 0)
>> +                       break;
>> +               ptep++;
>> +               addr += PAGE_SIZE;
>> +               pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
>> +       }
>>  }
>> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep,
>> pte, 1)
>>  
>>  static inline void pte_clear(struct mm_struct *mm,
>>         unsigned long addr, pte_t *ptep)
>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> index 3cc07ed45aeb..b725c3f6f57f 100644
>> --- a/arch/riscv/mm/cacheflush.c
>> +++ b/arch/riscv/mm/cacheflush.c
>> @@ -81,16 +81,9 @@ void flush_icache_mm(struct mm_struct *mm, bool
>> local)
>>  #ifdef CONFIG_MMU
>>  void flush_icache_pte(pte_t pte)
>>  {
>> -       struct page *page = pte_page(pte);
>> +       struct folio *folio = page_folio(pte_page(pte));
>>  
>> -       /*
>> -        * HugeTLB pages are always fully mapped, so only setting
>> head page's
>> -        * PG_dcache_clean flag is enough.
>> -        */
>> -       if (PageHuge(page))
>> -               page = compound_head(page);
>> -
>> -       if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>> +       if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
>>                 flush_icache_all();
>>  }
>>  #endif /* CONFIG_MMU */
> 
