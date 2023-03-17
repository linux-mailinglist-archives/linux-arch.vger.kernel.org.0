Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0A6BEA68
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCQNpY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCQNpR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 09:45:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6F6FFF8;
        Fri, 17 Mar 2023 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679060715; x=1710596715;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oY30iikGPUZZ3dHGHtvUCE+5I9a4qXjvmww1qcfwSo0=;
  b=NfINEin/5u37aoIMmWuDnBDFC+yYmtcPocqQiOG+SfjbA300GRWGiDIj
   mnOfXYIXyge2m6qL+jt4RM7NVUaw5CVlWK9RnZG2gfKFc2JC1LaCoT/s+
   d3AewWqAhZZ78akHL7Ai3rFyBI0BqQu6QM8yDocyR0d8q5gltEY7KWeKO
   cr0VJAdD4D0EUge6QxBYm2GlhV1rwZWUjvSEVlrP9bhTQdT3yCrlG4VX7
   xqehtxlYeCFwIFSNy/1AnKfI8R8Ui8ce4r4AT/V/kI31lLDVd9IBVpoHq
   fkrlI69tL6i/jt96l+vHByivxiL+zpAjvF+1C92+NRp0+xq8wXszpAK7w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="322108713"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="322108713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 06:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="710500676"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="710500676"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2023 06:45:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 06:45:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 06:45:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 06:45:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 06:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhFC6E+9+/9exFvgZJv9mK54/180TlERtzc8TpV8RPoFh3VHEjlhCdFbmWmtFHB5HA8BPGRKUiFmhm7TqnpKKxuciDvF2RhV9XYxf2hwyEAlT6KCJy3enoS0c9I0OWQLSNRw/T0FjAtExz6zjujAmM/vSBwA23P6oKZexlF6QXBufd7+hV6JzkkCtJtpQ3loxhMFhH56OEdjSRngm5jb0vQ3487HNA7T8ospv16hUhfMX6W//6fAGjo3J2U+C4KAE/G7egQZPBE04JacWF3AdIP3AgbloVhR0gV/oKz64qSKi3hrjDaxkfIzIfRL7Yq3ZNIiF+GaJFzhA5VpvgVXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dtV2bz/hNvdIC9ZvZrQ1omU/xJwfpZTuQhoQUYIYko=;
 b=e5zbjPocZh/nHWP204gS8J0wqDtdDF5BAogbv64L/ZikvnKvJUuDsbZrmLQ4X7mMkhh8e+J76Qcu8YQXf8Jd67kTr17S+KOkKKyceUrysg0rQ6DO8n7xKVKUB0opKbUGOcOhPRSurR/CdPOg5UPmMDT6I6VQheMbreEg9SHWhEKfiQbeRmPTwN3/xoN2Ck/TK4BXl8bjc1pAI+zCNZ3MBLb8F8gQkMPpkAozEpIIF/eH8ZtFEVcwzehq2RHsksno5vTvDISJpDhe0icMZ7OFnYyvQO3D2F1IKp0Ox06Wx8pbOpd8MHB2hxOSO765hnTqUPEAfARAxk7za9OqmeVmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 13:45:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 13:45:12 +0000
Message-ID: <f5777eeb-6ae2-623a-8639-450e88529f18@intel.com>
Date:   Fri, 17 Mar 2023 21:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-arch@vger.kernel.org>, <will@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
 <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
 <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
 <01df1870-8e2f-0e86-6dbc-728353cdd224@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <01df1870-8e2f-0e86-6dbc-728353cdd224@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a46774-960b-4e57-1bfa-08db26edd473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qd37e8yxqw2fNBoBrUBDxJzjBdFPDD7UFaTNsFUlrY37g8lsM2tXaYM8S2pvZsbSTgTYedCPq4wsF5FxeO8urbvedpgkHNm7Vw8rpiusHkp9bSp7EmgY42267lEHQWna+M6Fh0Y1PY2BnZW9sa7qrp8koBi/2OtLTvtxg7UxnrvVR7/JJlcceGFhDdzF6hyY4P/z34WrZYo5pymAT9TwB7B6f//cb9+vRhEdiXeH1hejrDOjJVM7sxx/qUIP/ndijIzjKYyYeScNoH1ahdWFGjqvLzGXT3muNbfDox9EVbkB/ZG4W9vHL6kR4Hxnlt3miU9kj4mgJVjkp9YWKnzA+0GHcpmBnq+c+60K1T/NGpdwIwNOLMtgZpOiYfcBa3/1SM5i0qdiiGQ/Tn67ctIRR+6kLuoyxcnpNZTItbtIybMZ6WBJwdje+zjTqfo3tPKJft2HQkCrWKrphFQisCn3FAshOuPVbNm1Pof3MmJN9l71/nZvpbneu4i3gsB7alg0w5+NYt3VV3NhJJxjiMbxIHnbIIKnKgQjpYPTzBY0e0mOSRGUMGw6dNgiPAZVyEqSsLfxjqgrNeAtD/Z72hYC7yj/Yk6gAhDqg8EQ/N/L8FMnYxJO2ghCWT9NMQIY7LAqMssKrIHIXn5kxg4TRJAUSmoEfscVZin5mtIPDLjsqw3nFHsfMiYNLcRRPekmbbmjihd/ycWbwL88IsslXo3nUhbuQMrNGTMghj7RtBiPoQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(31686004)(36756003)(41300700001)(5660300002)(8936002)(2906002)(31696002)(38100700002)(86362001)(82960400001)(478600001)(66476007)(8676002)(6486002)(6666004)(66946007)(66556008)(4326008)(110136005)(26005)(316002)(83380400001)(186003)(6512007)(2616005)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpqTWZROERMeTNqbC83VHFrYU5vOUZ2ZGh3bFJ3NU5ON1hjc0VwbGoweW8z?=
 =?utf-8?B?bEJNeEF1MmpxcE04bzBkWDVXSnpXZk40K2djTXZzazh5bG1sSGR1U0R2MVVZ?=
 =?utf-8?B?K01QZGhLOTduR1VRdVNnNFI5Q1JnL2Q5dDdFYm5BMFdXM1ZSZUM1YTZ1ekg0?=
 =?utf-8?B?bktBeEhpbjYya3IwWXY5VmRYSGI3ZGpPbG5YdENpS3IzZVIzZmFpRnB4NFBP?=
 =?utf-8?B?b09GZlFkMjhRRTZmaDFGK2dMN2VDai9RWnBnREQrdUxGV21jQlpIRzhockpl?=
 =?utf-8?B?dWFCaW5qK0RRa0dja2UvZWlLSFBJTWlRY3VQRy8yOTlOTThKTkpsMDhBcEg3?=
 =?utf-8?B?Vkt2UWliTURwbVd5c1NHeUk2ZURDeVIyYXlONml5SEF2Q3BBNnAvUnNhRnlT?=
 =?utf-8?B?bXprbHFNUnF5d2tlRmhRYmh2NTVLVDB1Y2FwcExMVkFtOEtNVGJiSExuZ29s?=
 =?utf-8?B?Lzc5bWFiam15MmJOM05iZ1I1VHJmWi8wVmlPcXZqc1FCenJXTHR1VzdDck5a?=
 =?utf-8?B?MWNPaE9mNitLeUQwNml0L3gxZC9jSmNUVVk5ejZYNi82ZTR5RDNnMFJnbmJz?=
 =?utf-8?B?YndOSDFmT243V2RSeEZPaGRVWWNIeHJNSGpMUDY3MHJIbHp1dHowSUIvWEdK?=
 =?utf-8?B?Qi82aU45REVTenI3UW1GYnR6VmJobTBqRkxXbkVQd09CRm9rTW01dDJEK3N6?=
 =?utf-8?B?OEVXWVhFamtEQVdnTFNzL0dTS2lURzZXZUUvSVFKZ1dLZ1lJWjlhclBaSi9o?=
 =?utf-8?B?T1RZUXBKcTQ2cTg5TitKczdxcnZENmhjcGprRk1WZGRWOFhvZ0tnS3lKcjQ4?=
 =?utf-8?B?enFrWWJyWk1uQ0hIdW5oS2ZHRG5US2N5Lzc0QmUzN1dVbnU4c1VVdVh3TDJr?=
 =?utf-8?B?ZWFmQk1zQTVKaklsdHcxMnJGOHo0YmJPdHJHRCsyM2JoT1R2RkxyVmJQSnN5?=
 =?utf-8?B?TC82RnoxcHlRZkx6UjltaEVnU1BUeFQ1R2RXOUxyU0F0aWdOTFpFQWVKSXlS?=
 =?utf-8?B?czA4YlMxbFNFdisrTFJzb2tacDNPZFloSmpRQ21KZjRvSFFrRUFIRlZLbkgx?=
 =?utf-8?B?a3AvWit6OFFkS3ViV2lLdzNwd0d3THpoRDF0dithY0MwdWMrM0g3aHk3Nzk4?=
 =?utf-8?B?Z1U0OHlkdmVuTjRYc2VRSTFEazRnYWNreDhMOFBwZkJxQ2FZY0U2blVmRjYv?=
 =?utf-8?B?azB3bTY3Q1g3a3NJY1RIU1laVS80NnZlZzB3eGR2WGVkcFE5MHhVM1h6dnA2?=
 =?utf-8?B?OStCVWdTeUFKbDcwTUVrTTNSSlgvaklZUytNS3pIeFRvRzBpa1hwUUxQVWd2?=
 =?utf-8?B?dXhVbHZFL2lSQmhBalNXTHRUaW1BRVRkc0h0Q0FZVUwzbFI0Z0FWWkQzK1M4?=
 =?utf-8?B?NEFPRGVaQ0hneEhYNFdPbGpHUkhxeEVLVk9yeUdOMXhLSEQvaW50dEY2NjFU?=
 =?utf-8?B?Q25kbFdnVkp6WEZHcXFXcXBNK21CcThxTTgwYUE1d0NQUGVQK1cyOGY2Q2R0?=
 =?utf-8?B?WWZxNGJSeUdFVXFWcGZUTzRQKzR6L2NxMEovRmZKK1dRd3ZCY1Z1bytHUHhU?=
 =?utf-8?B?RFFIMUJWanpEdTdRci9Zc0RkSGo0VlFQM2VmSTlKbFZDV2dDTjB6dHcrT3Vm?=
 =?utf-8?B?eTlQM0ZoSnlPdld4Z05BRkNQTFh0aDBoR1l0V1Z6clU1Q1VZMGdnSytVczdo?=
 =?utf-8?B?andvK3ZackNCVnprUklaQXZzS1J4a0VNM3A4dmdMK0FRNnZvZTNEbHA5K1RR?=
 =?utf-8?B?UTc1TllHaGlZNDhSSEpiQXlDQXFsdXBlRFMrSC9ubHM4SlVtL2JxRCt2UjBk?=
 =?utf-8?B?VDdGTkRZM09CZksxTk5kdkhVNk9Db3RYdjh6dU5oZ0NITDdGSFk3Y0o2Y3FD?=
 =?utf-8?B?d3hiL0NpcnlmN1FtbElIMGZ6cXYxUXJtdnM2eE4zKzY4YW1RRXIxSno5dzVw?=
 =?utf-8?B?QWhteC9zM1Q5ZTZqNW1QdjRZYkVrbE5ncFl2Z3pFRUpxcHpid2YyV2FWZnly?=
 =?utf-8?B?YTRoZHQwY0NkQ21ZRXFObWRFQVE1MUFwZ2U1SlNjViswWUhrWlZQYXZydUZE?=
 =?utf-8?B?UGVaSW1vSm9PYTRORTZXQ3dJR3o5RDl4UW5veTVrUHBtM1dRWFBURlFRU2ZC?=
 =?utf-8?B?ZUJUT2h6UWNPeWJ6QWp0ZHBDSGc5YUJncDViWllnWTg5NEJjTWd6eGxweUlz?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a46774-960b-4e57-1bfa-08db26edd473
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 13:45:11.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAWO2U+FlukjknzGDvjbqMYuiOWoyT25ptlmFyuZLDc4BWf5fDaV7yib/nHxh+5J/rte87G3dVUw6lCDEfEMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
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



On 3/17/2023 9:00 PM, Ryan Roberts wrote:
> On 17/03/2023 08:19, Yin, Fengwei wrote:
>>
>>
>> On 3/17/2023 4:00 PM, Ryan Roberts wrote:
>>> On 17/03/2023 06:33, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 3/17/2023 11:44 AM, Matthew Wilcox wrote:
>>>>> On Fri, Mar 17, 2023 at 09:58:17AM +0800, Yin, Fengwei wrote:
>>>>>>
>>>>>>
>>>>>> On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
>>>>>>> On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
>>>>>>>> On 16/03/2023 16:23, Yin, Fengwei wrote:
>>>>>>>>>> I think you are changing behavior here - is this intentional? Previously this
>>>>>>>>>> would be evaluated per page, now its evaluated once for the whole range. The
>>>>>>>>>> intention below is that directly faulted pages are mapped young and prefaulted
>>>>>>>>>> pages are mapped old. But now a whole range will be mapped the same.
>>>>>>>>>
>>>>>>>>> Yes. You are right here.
>>>>>>>>>
>>>>>>>>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
>>>>>>>>> can avoid to handle vmf->address == addr specially. It's OK to 
>>>>>>>>> drop prefault and change the logic here a little bit to:
>>>>>>>>>   if (arch_wants_old_prefaulted_pte())
>>>>>>>>>       entry = pte_mkold(entry);
>>>>>>>>>   else
>>>>>>>>>       entry = pte_sw_mkyong(entry);
>>>>>>>>>
>>>>>>>>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
>>>>>>>>> because HW will set the ACCESS bit in page table entry.
>>>>>>>>>
>>>>>>>>> Add Will Deacon in case I missed something here. Thanks.
>>>>>>>>
>>>>>>>> I'll defer to Will's response, but not all arm HW supports HW access flag
>>>>>>>> management. In that case it's done by SW, so I would imagine that by setting
>>>>>>>> this to old initially, we will get a second fault to set the access bit, which
>>>>>>>> will slow things down. I wonder if you will need to split this into (up to) 3
>>>>>>>> calls to set_ptes()?
>>>>>>>
>>>>>>> I don't think we should do that.  The limited information I have from
>>>>>>> various microarchitectures is that the PTEs must differ only in their
>>>>>>> PFN bits in order to use larger TLB entries.  That includes the Accessed
>>>>>>> bit (or equivalent).  So we should mkyoung all the PTEs in the same
>>>>>>> folio, at least initially.
>>>>>>>
>>>>>>> That said, we should still do this conditionally.  We'll prefault some
>>>>>>> other folios too.  So I think this should be:
>>>>>>>
>>>>>>>         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
>>>>>>>
>>>>>> According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
>>>>>> flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
>>>>>> If we change prefault like above, the PTEs is set as "yong" which loose benefit
>>>>>> on ARM64 with hardware access flag.
>>>>>>
>>>>>> ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
>>>>>> and let hardware to update it to "yong"?
>>>>>
>>>>> Because we're tracking the entire folio as a single entity.  So we're
>>>>> better off avoiding the extra pagefaults to update the accessed bit,
>>>>> which won't actually give us any information (vmscan needs to know "were
>>>>> any of the accessed bits set", not "how many of them were set").
>>>> There is no extra pagefaults to update the accessed bit. There are three cases here:
>>>> 1. hardware support access flag and cheap from "old" to "yong" without extra fault
>>>> 2. hardware support access flag and expensive from "old" to "yong" without extra fault
>>>> 3. no hardware support access flag (extra pagefaults from "old" to "yong". Expensive)
>>>>
>>>> For #2 and #3, it's expensive from "old" to "yong", so we always set PTEs "yong" in
>>>> page fault.
>>>> For #1, It's cheap from "old" to "yong", so it's OK to set PTEs "old" in page fault.
>>>> And hardware will set it to "yong" when access memory. Actually, ARM64 with hardware
>>>> access bit requires to set PTEs "old".
>>>
>>> Your logic makes sense, but it doesn't take into account the HPA
>>> micro-architectural feature present in some ARM CPUs. HPA can transparently
>>> coalesce multiple pages into a single TLB entry when certain conditions are met
>>> (roughly; upto 4 pages physically and virtually contiguous and all within a
>>> 4-page natural alignment). But as Matthew says, this works out better when all
>>> pte attributes (including access and dirty) match. Given the reason for setting
>>> the prefault pages to old is so that vmscan can do a better job of finding cold
>>> pages, and given vmscan will now be looking for folios and not individual pages
>>> (I assume?), I agree with Matthew that we should make whole folios young or old.
>>> It will marginally increase our chances of the access and dirty bits being
>>> consistent across the whole 4-page block that the HW tries to coalesce. If we
>>> unconditionally make everything old, the hw will set accessed for the single
>>> page that faulted, and we therefore don't have consistency for that 4-page block.
>> My concern was that the benefit of "old" PTEs for ARM64 with hardware access bit
>> will be lost. The workloads (application launch latency and direct reclaim according
>> to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80) can show regression with this
>> series. Thanks.
> 
> My (potentially incorrect) understanding of the reason that marking the
> prefaulted ptes as old was because it made it easier/quicker for vmscan to
> identify those prefaulted pages and reclaim them under memory pressure. I
> _assume_ now that we have large folios, that vmscan will be trying to pick
> folios for reclaim, not individual subpages within the folio? In which case,
> vmscan will only consider the folio as old if _all_ pages within are old. So
> marking all the pages of a folio young vs marking 1 page in the folio young
> won't make a difference from this perspective. But it will make a difference
> from the perspective a HPA. (Please Matthew or somebody else, correct me if my
> understanding is incorrect!)
Thanks a lot for your patient explanation. I got the point here. For the first
access, we mark the all PTEs of folio "yong". So later access will get large TLB.


Regards
Yin, Fengwei

> 
>>
>> BTW, with TLB merge feature, should hardware update coalesce multiple pages access
>> bit together? otherwise, it's avoidable that only one page access is set by hardware
>> finally.
> 
> No, the HW will only update the access flag for the single page that is
> accessed. So yes, in the long run the value of the flags across the 4-page block
> will diverge - that's why I said "marginal" above.
> 
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>>>
>>>>> Anyway, hopefully Ryan can test this and let us know if it fixes the
>>>>> regression he sees.
>>>> I highly suspect the regression Ryan saw is not related with this but another my
>>>> stupid work. I will send out the testing patch soon. Thanks.
>>>
>>> I tested a version of this where I made everything unconditionally young,
>>> thinking it might be the source of the perf regression, before I reported it. It
>>> doesn't make any difference. So I agree the regression is somewhere else.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>
> 
