Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00ED6995C1
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 14:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBPN2E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Feb 2023 08:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBPN2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2023 08:28:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715D552A8
        for <linux-arch@vger.kernel.org>; Thu, 16 Feb 2023 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676554081; x=1708090081;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=TeVKG4DuMDHVWpJdKT3tahz8US0jqKvI1yWwn+nKL/4=;
  b=JF/Zvt0j+GuN7aYSMHSNqxlVHJIXVNQMLLIfDrwA548vZzfzmAU2lwou
   qrv8O1EJuRvXczCEue2+AnkfI816m1+9c0sFen+xIElnGZjbgSEnPJeNn
   xEeMciPJhU/C3osG7ffPZ/osHPvGKwQh0L5dnmRsbdTx84+7dPeTcOPoP
   7KOf137thdtScnpk1VZisPpTO3TJVe2YOU3LqvAHqbM2sdP3p+/5X/nKL
   BKpPKwCBltGlkt+YiMYFUTFgt3GNlrFHT3y3Pcu0QHyYkEiwnLH2vdMic
   sg4NvbtxrmqKwDEpjFQHcqJp2jAi4pUs9/ENpVQ4BdIYqZvyEh29O9DUN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333041490"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333041490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:28:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700493655"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="700493655"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 16 Feb 2023 05:28:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 05:28:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 05:28:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 05:27:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqhD743QpMNS+C6DouN8OhVCq0lO2eh9D60AAEPzyTe7Gwh1QwV4mfJNConXTVQpTFgZ8YiTTQxLJtyA9Cb7PY35ckJw4nzGe92racmnAPYUv0rCgGuSwdh2Aiexf8EV5Rq0mMnK/nk5fUg04U9rvI80PEqMLtQ6xlfI1ZfWihEGrogVDp0BaXEZ24inhyD1fTufl1i+/7oB7+GErGMdYXlBCKORCXSlXDstv501PSauCkxgTHcCLgxNF4P+rXNNmxsZ7fYThCKK0nvYrvPXpo/I0W/tTMmYuZjXZqF4VRNDiQnqusY2c7WM81aa4jdKKGEJjyFHP8F/rCdl42uf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DEH4nmpofnTl9Gru6yIEKJmb2hxcu0IoTFGnjmztdo=;
 b=BOvNfNmFfgb5qf9X6p1kkVaC/E/QpGVnuECo/HDcYbGe3ATmC2Gf+nXUbxmzk0+t+jK7zPz4GJ8+ZSvRl+5vzd27WUQK3d8GHNwj+VRZRfmHsc1ILAQWftuSX8pr/K7LZg3di69ciWN8aICi7hPd8d/PgfSGcU6xTiZBbyD4s4cCLYEFpg/fUirfA9XckAriurwTTuvL1O1gmn2c4RL587YnHK6jvG/Jz5LeYZ9MOhbQtlH0DOcbhAYO9GNUau7dejIZ4CpIczoCsylRx9SrSs3q3nUD14ABKBAFmEBn8L2bhw0yLVEWAhiAU1DBZb5y5emRajjFllqS3qn39gRs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6018.namprd11.prod.outlook.com (2603:10b6:8:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 13:27:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%7]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 13:27:58 +0000
Message-ID: <86ab3990-1188-20e2-2055-941f083ca522@intel.com>
Date:   Thu, 16 Feb 2023 21:27:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 10/7] riscv: Implement the new page table range API
To:     Alexandre Ghiti <alex@ghiti.fr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-2-willy@infradead.org>
 <c02faf6e4af4babd24b3107d5fc2c6bff1d63100.camel@intel.com>
 <2e77208f-78e7-b225-7daa-57f08d703b04@ghiti.fr>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <2e77208f-78e7-b225-7daa-57f08d703b04@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: b17f8dfb-5892-4661-ae4f-08db10219dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4PPGPsxqhrg9HOgcBwstrP9TYgVGsUH1kq1WEwodZS5TjJEBG6lp9CdgxhH1hpOVh0Pft6RFaHsuymWjo3OzJ5+Ola0xxsKhwqXc/032YKJrYXn5moaoy/96ZPv+4gdecvBsFSV1ux3/Z+15rwKciqolzdrP0NIuMI/MSgJETCzsViuduNTR1S/xCzoMBdpYeK7N+TG+oJw61WUjTX+nPC3zXT6lhsie6Mf3Ox5UZ7xWQ/7nPrYLQlvBn22vRN/1V2vgDMsWzryXuz5GhUR9Krlt9YlWCax6AdcC9bk7M/jWrR1/QOoFhhH01Dbk01zdprjbpH8MN9CqTFMnwFahB+pty8rQmS668Wh/KPQDnlaJvH36bZv8r7Qecz0K+oS45WWHIRqcX+Ae5wqSsf3U21QLP2c3H3qVhyHGUlLuKxUUvGuVKw+gK8uymFoYH5vdzdZAFf8OPfsl4jLH1Iomydg4ovx+Ilehg5euINhO/rienkwWl8g6Ca+jNHzxBBM5R8ByCnCI4XmzYQZ7cGqaQ5HpRa59jcHuboDSduTF8BWG/UDPdDYnr/wP9rd8k+RypSiintiZxIYTV/e18hnf0DX/PaJbLtd4ECBcfLtd+MqBxFWyFwH1fEGeQrtZ1TjkvMMseY0EwstgbCnB+67ffJWYjupbOVn5GJFrUpx7yTzpo1Lu0O+Sg+Y34HXlYynrqGsb0VorKIpfIoLklkWSK3Q0kJ+JfHd3jtcmptpkxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(66476007)(316002)(8936002)(2906002)(6486002)(478600001)(66556008)(41300700001)(66946007)(110136005)(31686004)(8676002)(53546011)(6666004)(26005)(186003)(2616005)(6512007)(83380400001)(6506007)(86362001)(38100700002)(82960400001)(31696002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVh3eUhlWC8vclBNTC9lOHdRZUJ6MSsrSnJJajY5dXlhOHI2YU9VbUF1L3lL?=
 =?utf-8?B?WEI3NitKZmhQS1I2ZlJueTdub3RNVlFrdW9kbG5WbGN3TWRldThtUE5EVk4z?=
 =?utf-8?B?OWJDV0c0WkxlM0dBMWdKeFpieFJqenQ0cnBuTzRWZU5kTStEVkxCSDZGbGE4?=
 =?utf-8?B?MXE4VG9HZ0lyZTJzZkRLZkl6N2M1QUV3bWYxRE1MNUZnUHZrdGJYdHc4TTI2?=
 =?utf-8?B?TFN2bWJDc2hUdEVHemM5N3BLRE1NVHNITUtaUGVNS0JxQ3ViOURkVkVSYytK?=
 =?utf-8?B?VjdEVUo1Q0tNbWYyT3hkYjdWQ3c1S3ljeHk4TEFUVFhONFVKdWNEMElDU1hV?=
 =?utf-8?B?SlRkTzlScSsyTlZTVzRGWjRFVHk4NWJxUmlVR1ExQms4N3dscmozR0FSZ1lk?=
 =?utf-8?B?Z3R6YWRXNkdHb2k4dEozZnZzUVFIUWFEcWl5Mkd6QTdmR3RpbEhSUEFnd1k3?=
 =?utf-8?B?VEl2empqeDhuVUxnNFVrZy93OEc3dThzeGhYSXJTakZGOXU5bHJkaFdqYlZB?=
 =?utf-8?B?L1lMK0tvQlpVYm1uZk5rTWREM3BOZ2FPZHJtYWt6NGFITHNKZDJVZ3JLNFVK?=
 =?utf-8?B?S1Y5S3BrWlBuK04yWkd1NWR1cSs5Q1F4TlFkNHd1aVVYbktSVWZrOTlpN3NZ?=
 =?utf-8?B?aER3Zzh3TXJJQ2VRdXJCbG8ybXNkSjl5TlZEclRodmM3Vi96d1Z5NWRmWUNs?=
 =?utf-8?B?cGlqQ0VQeXduc1d4bStzZVZFMkZZVW92bm1kc1VucUoyMXhBZm1jUURiVlJn?=
 =?utf-8?B?dlhETEJTbkkwbVJCa21YdXlxZHNPMC9wOGxocTBrMjlxY0NLWUdTOEMwR1lj?=
 =?utf-8?B?dHk2RU1MQlRBa1ZaNmxjNzU3REJJeUVkaTNxbHZld3VPRjFVQUMyS1h4b1Jl?=
 =?utf-8?B?OTg2ODc2c2JIL25MY2E1dUMyTnRGVk9pcSt1T1c1UlZCcGp3VDdMWlNqY3VS?=
 =?utf-8?B?TWNVclp4dWZKc0pHb2owYjFjV2pvSVpqYjVkVm50TGtacWJpYmZsOXRVSDVB?=
 =?utf-8?B?akI4dFdOdzB2MU9ORk8xODlKOFpqTnN0aTBiNk5zcXRwM3ppUkZjK1YyWUF1?=
 =?utf-8?B?bm00UkZLaVZWU2hadHYwYVlFK3g3NjNmNkdnczVHV0VYTklMYThZc2hXS2Zo?=
 =?utf-8?B?Z2dPU29SdFo3N2VqTUdmdTIxWjB0a3gyR0dMTkRVdzFIbTNmQmd6dGdKbGt0?=
 =?utf-8?B?SldrZ0sxUVdQN0Q2Q1JNYTQrVnBDbmZWSHNPZ2hFY2QrUUNxQVRoOWVnaXBS?=
 =?utf-8?B?a0JnSEkvL0JZTXNRUFB6bVJkTE1WK3hTcDRkZUx2ODliN0hncEY2Q3NDMXdv?=
 =?utf-8?B?OUpLbkRsVWU1K0djUWwvbkdJT2Uyb2tkYTN1VmsvbHFSdlEwdDUvNVF0eUNu?=
 =?utf-8?B?OS9MczhYQjk5Ty8xV3owQkc2Q1VrMGxaMklQSWh1WktXT0tvMXd4dVptTElW?=
 =?utf-8?B?bXVPNVIvZUs1d0U4a0syUXoxU3V2bEFBeXBwd05QcjFSNnJTRWZFSDNtaVBQ?=
 =?utf-8?B?L2VGTDRNend4ZXVEVWlrRHpQVkNBc2NLTWxoV01FZXBwT0t2dG9wQ1hGcGJO?=
 =?utf-8?B?Nlh3aW5iK3RRREs2SDF0eCtLT1Y4N0VvM2pTV2tIWDNqYk1MUENqMVNZZGlq?=
 =?utf-8?B?Wm1GbmZHZkpURms3ZEQ1T0tUemM4alpmaEpuS09uSHU0S0c1cGR0bUpOK1Ni?=
 =?utf-8?B?VisxQWpEVFNZYjJJTzZJbEcrdVYyblVaS21IMXRlMHdpSGFZQU1TM0lTMGQr?=
 =?utf-8?B?MjNJYUhwdGFNUGxYL21WYXN5MFZTQ05HZVoxVFZ2S2F0Zno2dUFyNnZ5RzAw?=
 =?utf-8?B?QzdkcHVHQ1pCMzNZVDZaNjVNb1hoRkk4bHBuSnZ3QVdUWW1yNWZkaS95MWRB?=
 =?utf-8?B?ZzgyTThOcEhBK2sycXRTNVNUTjNQK1NGZGZnOC91MDgrWXk4TERVekJVMDI2?=
 =?utf-8?B?dHhBU3JVWjZPVTZiaWIwVlR6M29zZVU0WXJKRmQ0WWhHaUlURzZqc2M0WCtG?=
 =?utf-8?B?WENmblBaSHdsMjRzcjZhS3FSN2FxMXJtVW9mUXVSMldjZTRPYnlSVCtLalli?=
 =?utf-8?B?RHV0UHc3dzFjQjh4TWxmV0tSMERtUkh6dGZ5U2F1NVZYeVBUb292MWxZSmJp?=
 =?utf-8?B?LzJObFhBVC9aMDZaNlZYcnBKNmd2RnhWa3hBWm1FeE5QcEFlUEJ2ZUVyVitk?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b17f8dfb-5892-4661-ae4f-08db10219dfd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 13:27:57.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIccJibnmCq82nuE/A2o0uBvacBn6KIwCTQPvcOgty3DdoCpPmxzgahq+VDEQjMVuObTBToKQR+bRWMD9m5EzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex,

On 2/16/2023 4:14 PM, Alexandre Ghiti wrote:
> Hi Yin,
> 
> On 2/15/23 09:38, Yin, Fengwei wrote:
>> On Wed, 2023-02-15 at 00:04 +0000, Matthew Wilcox (Oracle) wrote:
>>> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
>>>
>>> The PG_dcache_clear flag changes from being a per-page bit to being a
>>> per-folio bit.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>   arch/riscv/include/asm/cacheflush.h | 19 +++++++++----------
>>>   arch/riscv/include/asm/pgtable.h    | 25 ++++++++++++++++++-------
>>>   arch/riscv/mm/cacheflush.c          | 11 ++---------
>>>   3 files changed, 29 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/cacheflush.h
>>> b/arch/riscv/include/asm/cacheflush.h
>>> index 03e3b95ae6da..10e5e96f09b5 100644
>>> --- a/arch/riscv/include/asm/cacheflush.h
>>> +++ b/arch/riscv/include/asm/cacheflush.h
>>> @@ -15,20 +15,19 @@ static inline void local_flush_icache_all(void)
>>>     #define PG_dcache_clean PG_arch_1
>>>   -static inline void flush_dcache_page(struct page *page)
>>> +static inline void flush_dcache_folio(struct folio *folio)
>>>   {
>>> -       /*
>>> -        * HugeTLB pages are always fully mapped and only head page
>>> will be
>>> -        * set PG_dcache_clean (see comments in flush_icache_pte()).
>>> -        */
>>> -       if (PageHuge(page))
>>> -               page = compound_head(page);
>>> -
>>> -       if (test_bit(PG_dcache_clean, &page->flags))
>>> -               clear_bit(PG_dcache_clean, &page->flags);
>>> +       if (test_bit(PG_dcache_clean, &folio->flags))
>>> +               clear_bit(PG_dcache_clean, &folio->flags);
>>>   }
>>> +#define flush_dcache_folio flush_dcache_folio
>>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>>>   +static inline void flush_dcache_page(struct page *page)
>>> +{
>>> +       flush_dcache_folio(page_folio(page));
>>> +}
>>> +
>>>   /*
>>>    * RISC-V doesn't have an instruction to flush parts of the
>>> instruction cache,
>>>    * so instead we just flush the whole thing.
>>> diff --git a/arch/riscv/include/asm/pgtable.h
>>> b/arch/riscv/include/asm/pgtable.h
>>> index 13222fd5c4b4..03706c833e70 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -405,8 +405,8 @@ static inline pte_t pte_modify(pte_t pte,
>>> pgprot_t newprot)
>>>       /* Commit new configuration to MMU hardware */
>>> -static inline void update_mmu_cache(struct vm_area_struct *vma,
>>> -       unsigned long address, pte_t *ptep)
>>> +static inline void update_mmu_cache_range(struct vm_area_struct
>>> *vma,
>>> +               unsigned long address, pte_t *ptep, unsigned int nr)
>>>   {
>>>          /*
>>>           * The kernel assumes that TLBs don't cache invalid entries,
>>> but
>>> @@ -415,8 +415,10 @@ static inline void update_mmu_cache(struct
>>> vm_area_struct *vma,
>>>           * Relying on flush_tlb_fix_spurious_fault would suffice, but
>>>           * the extra traps reduce performance.  So, eagerly
>>> SFENCE.VMA.
>>>           */
>>> -       flush_tlb_page(vma, address);
>>> +       flush_tlb_range(vma, address, address + nr * PAGE_SIZE);
>> The flush_tlb_range() of riscv is a little bit strange to me. It gives
>> __sbi_tlb_flush_range() stride PAGE_SIZE. That means if (end - start)
>> is larger than stride, it will trigger flush_tlb_all().
>>
>> So this change could trigger flush_tlb_all() while original
>> flush_tlb_page() just trigger flush_tlb_page().
> 
> 
> Maybe I'm missing something but update_mmu_cache behaviour is not changed here, it will always call flush_tlb_page as nr == 1, right?
Yes. This is my understanding too. Thanks.


Regards
Yin, Fengwei

> 
> update_mmu_cache_range though will likely call flush_tlb_all: I have to admit that I'm wondering why we don't only flush the range of pages instead of flushing everything, I'll look into that.
> 
> Alex
> 
> 
>>
>> My understanding is flush_tlb_page() should be better because
>> flush_pmd_tlb_range() has PMD_SIZE as stride to avoid flush_tlb_all().
>> I must miss something here.
>>
>> Regards
>> Yin, Fengwei
>>
>>>   }
>>> +#define update_mmu_cache(vma, addr, ptep) \
>>> +       update_mmu_cache_range(vma, addr, ptep, 1)
>>>     #define __HAVE_ARCH_UPDATE_MMU_TLB
>>>   #define update_mmu_tlb update_mmu_cache
>>> @@ -456,12 +458,21 @@ static inline void __set_pte_at(struct
>>> mm_struct *mm,
>>>          set_pte(ptep, pteval);
>>>   }
>>>   -static inline void set_pte_at(struct mm_struct *mm,
>>> -       unsigned long addr, pte_t *ptep, pte_t pteval)
>>> +static inline void set_ptes(struct mm_struct *mm, unsigned long
>>> addr,
>>> +               pte_t *ptep, pte_t pteval, unsigned int nr)
>>>   {
>>> -       page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
>>> -       __set_pte_at(mm, addr, ptep, pteval);
>>> +       page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
>>> +
>>> +       for (;;) {
>>> +               __set_pte_at(mm, addr, ptep, pteval);
>>> +               if (--nr == 0)
>>> +                       break;
>>> +               ptep++;
>>> +               addr += PAGE_SIZE;
>>> +               pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
>>> +       }
>>>   }
>>> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep,
>>> pte, 1)
>>>     static inline void pte_clear(struct mm_struct *mm,
>>>          unsigned long addr, pte_t *ptep)
>>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>>> index 3cc07ed45aeb..b725c3f6f57f 100644
>>> --- a/arch/riscv/mm/cacheflush.c
>>> +++ b/arch/riscv/mm/cacheflush.c
>>> @@ -81,16 +81,9 @@ void flush_icache_mm(struct mm_struct *mm, bool
>>> local)
>>>   #ifdef CONFIG_MMU
>>>   void flush_icache_pte(pte_t pte)
>>>   {
>>> -       struct page *page = pte_page(pte);
>>> +       struct folio *folio = page_folio(pte_page(pte));
>>>   -       /*
>>> -        * HugeTLB pages are always fully mapped, so only setting
>>> head page's
>>> -        * PG_dcache_clean flag is enough.
>>> -        */
>>> -       if (PageHuge(page))
>>> -               page = compound_head(page);
>>> -
>>> -       if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>>> +       if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
>>>                  flush_icache_all();
>>>   }
>>>   #endif /* CONFIG_MMU */
