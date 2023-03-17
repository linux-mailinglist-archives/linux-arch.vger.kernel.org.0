Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E333C6BDE5E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 02:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQB6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 21:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCQB6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 21:58:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856E7B4A0;
        Thu, 16 Mar 2023 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679018316; x=1710554316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lp0w8jbd7CT4NHcFyhkWlbWnMOO1+g8Qw2EzeNcptM=;
  b=Qw6HGK1MYa/a3UsTQFwDIrFnVa0jX347c6OkeCYG8tuSIKnkvMM4NyhF
   34naLu/SGQrKZRBvKq9yORLTGNk/QgF++0ZpN7r5z/NjhqnzWuKv8Wcl5
   VaO2jtfylksq35WqWugM3cOjA+X6FZuk/P0EytnmQEg9c2xjA6+3vBCol
   uqbgNXwmnRapwBPvM9Dir6EhIGQGnZjTc5nkEYu+3MJLtcJZV4BuvOtaw
   3LzAzNp0QiFmVCvrVOhsUb3gUsm28QiqG02vOCFhBowqIcd80VvJyz0Td
   WIL5xizuie6ym9CONJB2npzW5UIY733VDFgUmiCC7vw8ChZ2mus3mNZ4R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340528460"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="340528460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 18:58:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="769180464"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="769180464"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2023 18:58:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 18:58:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 18:58:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 18:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzSQ9qXxMbqoACS1KYfzMsG5UZPxTdsdsDKI60u7Dwo4yzZHP+P4WonpdHx/d728xaRerRsVUOhN+DJIG172iM0NSyayyuVQGLXuk4v3xl3JEau/FisGS36AYkzaYo2WtoYjiCi4RFChksI9ThSlPdqAexNRfWAzoIJga7Re+Chz5dRF9RiFlJC7G9fHVHCklNRpozjHORK7jro0Ua/whNuxkajf8KR2ixIHe8zIXKRhOriZKQ39ZW7D/+ZOtyK1TTeDgSYZM33gntJ904ML7jYw5q39mF1Uhf5lEiDwnvo5EtvMnSpra/GYtv59tPlMdnRwRcbhVUcIychlFtR0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiECh7uMw7plYhYzTYBMzDRzW1iFgVq1FdBiAXbEmaI=;
 b=gPGDHBh31woVJn1cbTH2C+socQJ/MnQJ1RaVMWWtQT/zyVn+4pbGPGFc/1bu5txtwO7+Kx8+4z+XEKBx0/Qt6woM0mT8z/8wCt5pdlI0+PW614giFBF2hVBBn4yjyjOIQw49my0nzVds1gKzsInHyComNEGMjo9fy91asINK1mFKwA9JmP4rpsac8K4V4ewsXPsNe8kzZoQcbw1I6ot6vxApm7VV8CmrFeYleY+N9XCPyGuwz6/92g4iEF3Xlcm9Q83E2cKeThTtnwutPWRj3FN+0JXq4FN2dj9F2xjIZ8KFygJs9X7SJKWIzlHpqQkd2HeBARwX3TOeskGDyZ5Xww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB8099.namprd11.prod.outlook.com (2603:10b6:208:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 01:58:27 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 01:58:27 +0000
Message-ID: <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
Date:   Fri, 17 Mar 2023 09:58:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
To:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
CC:     <linux-arch@vger.kernel.org>, <will@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZBNXcmOrrOS4Rydg@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 3066398c-9652-4664-f8f6-08db268b193b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpaOe0Dm64ZYiM2qdGOEUNij739TBN3vN8nWv7IxA9ky1yLVHvqKiS7LaI7aCNCiD3EKFc0wl9li11GQqvnzEr/lKmVtSwavAIqXwVul4WAdCjAeXDXdzi6Xpi+T3qEIkdIcz2YeRi3eOcameH7Qw9FgiA3IKreANvToTozeoSaBJPO4Cf5rqcQUzTZPYJSB0xCdNZ66+OvDgfYsUQcKU3dzEgJKLRKBm5i687UDk/o8dXKYZ5D3wfffuqrcXPGmSD01hboB3TDk/7jHyKpiR0g1OIx8wnr2uB8CMhz28yghA1qLyajLfpS/q0zdH8yahEwO9etIPpDSvBezBS9M6bWyvURTzcwF1FJSV4ISkYA2bW69iLQI5AFgTQ6anBXI+t+PXgnLzrER5UBqiae6jH+pyGTCVqLiAxyRwKcZGWR+8y6u+6T1ogftDwa90Cs2KRLyxMHjpmsSErflo7E2BgoR9YPG626dGz2lz3S1rjlykkf5YeaOwkhXbsBF7ukJi+NveTYduBuqEJ0iDlq4Nu/Wre1RlKhwnVCCcj3H5XLvMxnmGpo4tR8u8OnWJpfx4wHtdid0eIXiMXnuUnEIc3oFU5rGFyHy3c1PJw4ZaYCRmz+0G8otSiy90YYkWWLAFtLaObSgWVubHyvfo3W8/pAEItIOp6AHavEHOsLrQxONR0nMLO9VKxTLZb9rXQ97lLro9ztwneS8+QsVFInITsVULQkCtwsirxj+nKR4CCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199018)(6666004)(6506007)(6512007)(2616005)(478600001)(186003)(83380400001)(26005)(66476007)(66946007)(66556008)(6486002)(110136005)(8676002)(31686004)(53546011)(316002)(4326008)(8936002)(5660300002)(41300700001)(38100700002)(82960400001)(2906002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBQblM5RmNmWi9sVVRaa1I1c3dHM2JkWDhDL0xxaEgxbzF4ME5neDlZT1Nu?=
 =?utf-8?B?K04wU3Z5UktVVnNDWk1ERzUwdXBLeHFudHlSdytXMjVsc1dNMUo4VDNhQlYv?=
 =?utf-8?B?bFc4UWZXRkFlMjg1SFZBNmVsNTBZZFY4N3FMVnZpVEd0ZklqV1lIOUx6SUlR?=
 =?utf-8?B?MFUycUQzdUVjcmQ2aFJUaCtFZjNobjJjZnRWUnFVa0F3V0xZMkwxV3NFNkFE?=
 =?utf-8?B?MmxoRlF3Y0tlYmJyY1hnaUNvVmdFTFA2aGV5anBmbUVVazFaN1BuRmxHMnJL?=
 =?utf-8?B?T3Z0c0F2YS9kZDRwYzZlTzIrU21rRGNmMkhmeHJBNG1SRDBaOXZyakJyV0RH?=
 =?utf-8?B?bXpzVURLVzR4MUJhbTQ2T3I1TlJ4bmJoMG1wLzJUSnpSZy9Fd0RZRDBpVHpN?=
 =?utf-8?B?dkJDdS9xZHdSbFBHaDNkSFlWS243VkZPVkhPNE5YcXRBRXR5eHphWHk2RDNt?=
 =?utf-8?B?bHdYZHVGTHVQRU9CSmV4Wm0vemp0b3VUVE4zU3VWcWRJVlIxR055aU4wRGg0?=
 =?utf-8?B?RTJTdUV6a2dJNkd4SzRHVlZBZTVzZjlqSjRBckk2TDNWNXZBTUdUenZZYWp5?=
 =?utf-8?B?czdHMHNTYXZtOVR0UzJsdXQ2R2R6ZlpqbVcrbjFJNXNjY1FiTnhIaUxaUk1t?=
 =?utf-8?B?Z2IyRG1NbCtOenJWS2t0dmZ5dndFZTBQalZSc2VvZXFYTHRhalF1dHFvalY2?=
 =?utf-8?B?YzRzSEV6VnVWa1h6SUpPend1K24zRDIyMmtXdkZObU5tTlJiYW5xZWUxUms0?=
 =?utf-8?B?aWtIenRqd3R4Q0s0MVZXRzhSM0orNm9FWUFKaENqVGJXbGNZVi9FV0VkMVBT?=
 =?utf-8?B?YTlkdmk5Q3JFeWFObzc3OXpFY2N0YzE2RGI0UGdKM2dtc0g1Z1EwMzNjOTVL?=
 =?utf-8?B?YXRNaVVMblVNNERBdjB3Wk9zSjJHc1hlaGtsSXJ3L25ub3hOK3VZVGFiV1Bk?=
 =?utf-8?B?NVFDOHIzbC9HWWNURTJseVd3UnQ2dDVVc1ZkQ0VpeHRmc0pjN1prdTNrMTls?=
 =?utf-8?B?YUNMVVFNQXNOV1hiRFZ6OTJjbXlSWTFYOTAvUTdXbExRY0hITzBqTm1Jc3Bm?=
 =?utf-8?B?T3VjS24zUElqd09OTUNrL28vWXhtTVFyam9NMGZGckNXVHVOdit5MUx4RUdJ?=
 =?utf-8?B?ZHo3N1JCQlJpMVpWVVk1bmpTQmNVa2RKT2hMSUxJd3dUcUxtb0hVazFQbG1H?=
 =?utf-8?B?ZVB0QzB6NkdIZ3E2RjVjbWN4MzBta0UvUW5TK2JtcnZDSXMyYWdBejlUV2sy?=
 =?utf-8?B?VzlJUnY0V2VHL3RLYlkyZHVBeG9Kbmx2Y09KK1lMZk5TNUhUa1Q1VnNURFJ5?=
 =?utf-8?B?TG12K0Nrazh1TFpwaXZUUlVNaExYQlEvU2M2TkJEc2ZtTlB1aW9vMWdMd2gr?=
 =?utf-8?B?M3luOURyNzlaVzNPSVhQNjNuTkE4QUVIRDluOHY0aXA1TmZZOGd4aWYrdnVU?=
 =?utf-8?B?aXdsZE1MQmw2b2YwL2N3YStmSVBBVFFwcU5TSkFzYUdpeWZGUy9VNGIxWDlz?=
 =?utf-8?B?ZHd3RUVDKzJ6QVpXdDBhaERhdm1td1JqUnpFazJGVmhzclJ5eG1EaFkzcjU5?=
 =?utf-8?B?N3dodklacVZOUGtLM2VFREc4UGhFRVFUL2lzUWN3MzNVUE1CcEhvUmNWajJa?=
 =?utf-8?B?Yk10M0gwR08rSjhLQmxwNXI0OU9zNWVoWXgvcS8ydGRSU0MreTAvcnAxWlFj?=
 =?utf-8?B?cFNvbDJWSHRVc0xsallyOWVCM1p4SEhhdldWeUlnRXA2QVFpZjVLRmJIcVBM?=
 =?utf-8?B?QTJQZkh4MW1sL2dnM0o4YWoyTnhFR0hBL05ZZExuYlNyUllPamZZL3VPWHJR?=
 =?utf-8?B?MHMraTlEYzR1VUtobVR6RVRDbDMyQUpidUZCWEZBRFN6QXBaVW1Odmh6Y1ZY?=
 =?utf-8?B?NEM0QnVCWjE4bVJ0S0NiV0ROTEQzUG43NC8zMFNVaUh5VGoxT2VaTHZ3b0Qx?=
 =?utf-8?B?SzNxb3Q5VjlncGVvOHdndEdUNDZwQlQ4cDFkTVJJbWxGY0VEdHd2RnF6Mndp?=
 =?utf-8?B?WVNRcHA0WGVzUnRRRFpkSHNjR0hEUXpJc1pqQVJ1MW5CTENGUC9ZMXpGaWZo?=
 =?utf-8?B?S2VkZVRiUkRuTE5ScFBjY2VZOHJxNGpuL2wwa1Rrc203bldCNGNHZkhVQVU3?=
 =?utf-8?B?KzdGM002T2JUdzN5WjQxTDg2bk9SM3U4dFZXcjFoeWZuYVNWZHFLaTdaUWRl?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3066398c-9652-4664-f8f6-08db268b193b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 01:58:27.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O9aaWgl1AoVEMzM8XN8nGt1g8ST6hgWe09s23FWKs87jFsHp45UwrBWDF1L6xim2CfSNMSMu0Y3vZ50Xp+xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
> On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
>> On 16/03/2023 16:23, Yin, Fengwei wrote:
>>>> I think you are changing behavior here - is this intentional? Previously this
>>>> would be evaluated per page, now its evaluated once for the whole range. The
>>>> intention below is that directly faulted pages are mapped young and prefaulted
>>>> pages are mapped old. But now a whole range will be mapped the same.
>>>
>>> Yes. You are right here.
>>>
>>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
>>> can avoid to handle vmf->address == addr specially. It's OK to 
>>> drop prefault and change the logic here a little bit to:
>>>   if (arch_wants_old_prefaulted_pte())
>>>       entry = pte_mkold(entry);
>>>   else
>>>       entry = pte_sw_mkyong(entry);
>>>
>>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
>>> because HW will set the ACCESS bit in page table entry.
>>>
>>> Add Will Deacon in case I missed something here. Thanks.
>>
>> I'll defer to Will's response, but not all arm HW supports HW access flag
>> management. In that case it's done by SW, so I would imagine that by setting
>> this to old initially, we will get a second fault to set the access bit, which
>> will slow things down. I wonder if you will need to split this into (up to) 3
>> calls to set_ptes()?
> 
> I don't think we should do that.  The limited information I have from
> various microarchitectures is that the PTEs must differ only in their
> PFN bits in order to use larger TLB entries.  That includes the Accessed
> bit (or equivalent).  So we should mkyoung all the PTEs in the same
> folio, at least initially.
> 
> That said, we should still do this conditionally.  We'll prefault some
> other folios too.  So I think this should be:
> 
>         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
> 
According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
If we change prefault like above, the PTEs is set as "yong" which loose benefit
on ARM64 with hardware access flag.

ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
and let hardware to update it to "yong"?

Regards
Yin, Fengwei
