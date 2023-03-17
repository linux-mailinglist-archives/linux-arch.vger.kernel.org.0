Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9F6BE2F5
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCQIUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCQIUl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:20:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D213B84E;
        Fri, 17 Mar 2023 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679041219; x=1710577219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wPffIQhrq8gd09UZdaubU5muybYUvXYOyL1kTkTb1g4=;
  b=VjmF+WC0NLp5I83801rFJWUOXaxCM0zL1j+QDLf+N9vfIlfto0uRm00C
   TwTFKVIMAWd7r+hYKXizXCk7JftpOW2ihp1hqqwYlVDMy1XnrJ9ny6wUX
   Neij+R76b62ee0DJdgKd3FzgQs1Mdi+E5Gn+pI8AvtAn8Ql3nI+ec9crO
   WHe4+DJW5CM4ig05LgtFQZzyYu9uzbOFOltQMfTRNrrnbBbNTXupin3DL
   sfh2M8Irnw9IudFg0/zWa4b67HDNuANPlEMHZ5AZsJZzndllD0KYETQSw
   mTm4f1rc2/yx/mhrDJYrOnv+HtulrqAjy8cXe7RbLPvPJTscBH/jEAqNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424481091"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424481091"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854363407"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="854363407"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2023 01:19:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 01:19:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 01:19:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 01:19:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 01:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB4XMCLJQldcBZ3IggtxcrwbPMXquBksVwVrWVbaEOoGP3CXw3RHEAcT5Ev6MDT5+Qwt1cMzOrOsGXZGo3LGg7TL8ZSPduiqlECzXP8QpgWk137Pj19pJUnDlTngUBvPPKgiNnhbwdQBKivNvgxrypZKXmopBEzl12AfT3F7h2qICXylS0f5NxijXbmyDpA+BMtYnTYXo95sNSEo0jQAgwYiCJKtP3kd8L4baqhCtlEJijugWMVtGoTWABqJWYHwglRpIStCWLRdXvzXxef84LIFQOoWZ9N0PKvl/JzesrqvqLEiE0lXVzpWl74gtv194Tcs4WvCjkJEvsqmqPVJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7biVvtJHcNAEGTqZZk7E03g2chcrzit3yYZDsTLHFCw=;
 b=K8G72at1n0KGyEK73HIdlkt31FmMtFLPxHxvX6ldzvklXk+0kjMDXsqQKvSVjFYdA4GN3FRUER8aO+Ro/tvaaN1HlxlnrwFDqYCRJUAk/dQGQGTwg3dtdQA9/f/TykjnEUka9rMBnTXUgC/98xhfVKgpfbtnfNUDjX6UCquSRmJ0qGj04s3rZz35wX4rXy2EAuRI9TECNES5qFO7M17N9jzSN3v14MKxY8i0/H4CAsomIL6Ddf9h9VlxZUQGBzDwuDETqJdfh2NMhvb0INsXTIQps0gqaZndO/scu9kYw6NMoeFROyepu9lP0XvSj5qlTviYZlLZwYjS8GTHbkDfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 08:19:53 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::b974:36b0:e768:1b21]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::b974:36b0:e768:1b21%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 08:19:53 +0000
Message-ID: <d2e90338-6200-f005-110d-4626fda067a2@intel.com>
Date:   Fri, 17 Mar 2023 16:19:44 +0800
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
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|CO1PR11MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd8b163-b959-476e-097a-08db26c06268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOWN9a1tZ0it8Mt6TARZGQbQ78x0o2++/ARCg/Qnh25Ww3YH7PlBye5SuIYd26/oknhJve4YdmWZNdUZjlaKy28QScJimle7H8aKEpddSMN3K6bB9Op7j6uZ9mQHz2xK1P0za5aMOKqmiH3I3rYf17HzYGwPAymluf/F8OQhpt3dElvd5Le8/idkzMAe5ih35PJg8/+cHMLwaXgxJNSkAFXMEcKPnaeZ0lY0dEpT0pyeRaI4/Hr0vkh74TIi1/9Dt7GmVip9UiHrqKsL+p8pMn/mbM5e2x1yA4Bgh7ZwVihTUr4zax3YIHTS2sEreTIY7pKiFSJiOGrzjDhiczPeP1lLc/4obEjTRNgsV5Q4a2jhbBnA/GtFg8f+J8xcayY5A6BA+crbSccsVWZnCf8mNbn1qOfgEL5XqFsXXbln2M/YTMlSbyYjcNwlbD1ElUstv2R4HMachmaEY5mqIviJIgZeWS9ztll666nW0IdCR/gC5s4wGoBMpap3O3emwhZB7TnzVxPY9rettbCnYHJE5cYZ3vVKYa6FUf9ot85qvr5rVgFIP4f1PreRW3pkckeoI9vu0bFoEUh4L/LtCUaS0/MFmAnPuI64+s9Ot/sXQsfF/pFsZ5C1n8tT90QJfOAwMtUAyeORPvKvF8nUmXN8/hgn4Ph9dvqgfPfC7kzYhp7s3OqXRoTz3H6R3XtDzA9G4+4vyLAEwnRvB7nJNGo3Fh8F+oJ6JHV6f5zMTLHGN1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(86362001)(82960400001)(41300700001)(5660300002)(2906002)(8936002)(36756003)(31696002)(4326008)(66946007)(26005)(6486002)(6512007)(6506007)(2616005)(316002)(83380400001)(38100700002)(186003)(53546011)(66556008)(6666004)(478600001)(110136005)(8676002)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVwOXp0V0FjTVQzaElweFJROC9qaTlqUVVvU3IvTStxaWg1K2J0ZGRIVlhp?=
 =?utf-8?B?K1VCbU9kaGdpalMrNnpzMHBxSDBsQkFEUTR0azNLYkhVZmpRVitXS3pRRC9k?=
 =?utf-8?B?V3RhQVNEMHVGclJXZDc4SUExZVhoTGtKUGc2V1BoYzlWcEQ1UWk1d2RqVDRn?=
 =?utf-8?B?LzduNUhUK3lnVWEvaTR3STNHTlFPdUY3ZWJHWjFaMzR2WWMzdlIwcWFKMmNu?=
 =?utf-8?B?NGlRYmVsVFI4MFZRN0M3WWt4QzJGZ2c2NXU2UDVkUUwxUzYzcU92S3ZhMlpQ?=
 =?utf-8?B?U1BHVFEzZExUZzlZYTl2MGdzL0xlZ28xNzNBU1dUSXhTM0tyMEhvdi9RQ2JH?=
 =?utf-8?B?UU5FdFhNc3RWMnBqWDdYQ0d4ektyVzZlQVFMRlh1NUd6VVZIQ29ETXBzRSth?=
 =?utf-8?B?ZUZReWZMU2g3b2FISUd2YTZpcjA2OE43ODFiZmFGUGJNTUpzWFg5dTdOc0VL?=
 =?utf-8?B?bllyYkkzL1NjVThCVy9UREo3Y0pmT2dCRTBNeXhJQWV6VmR2VVRSaFBMSndl?=
 =?utf-8?B?QlpCZnd0VXlRYlhIUGlTZ05vd252VVdJaWxjVDZHUUc2QmpGZ04waTh6K3R2?=
 =?utf-8?B?NEorWmtydS9Nc2xRRXg4Ti9sUjIyT3p0MjVvT0lWLzJ3dWRHbXlmeFQ2Q20x?=
 =?utf-8?B?U1JIS2RHS3k1WmM1TUpNWTFLbkZNcEdmeDFKVzc5RzVhQXJwV0NmWWhNeHRq?=
 =?utf-8?B?TVNaZUtMSVJMd2hrMElOSW14enp6OUNTemQ0bXcvYnVPUGtFV3dhd05GRDhF?=
 =?utf-8?B?cW1VTFg3cGdBMktMNTBwU2k1S1A4VGFTbFlQOVpvcllsU0xYay9QbEU1S21B?=
 =?utf-8?B?Y3RFMFYrSldBTjdjbTlTYnFyVFpkK2xTOEZKc1MvdFRRWC8zQ1J6UDJJMWdw?=
 =?utf-8?B?M24zdkRGT1RBeDJDUWdkREFBR2dRUE1MNzZUaVJ3RUlWN3AwKzZMSHJ4cTNT?=
 =?utf-8?B?RDBnc2U1akFWdjh4V1FlcCt6WVlRVVJXZFhCVTBIUURHZ3lCdFgvdEs2b1d6?=
 =?utf-8?B?MXVnb1NQdEdpM09idGpnRmQxdm04MGMzcVdYdlFmcHJjeTNQNmJjY2F4OVJq?=
 =?utf-8?B?bmlRZjhQalZrOEtoUWZMZ1M2VnA3dzFvVlBaQVQ1SkZRQzBlbE1wUkozZmhR?=
 =?utf-8?B?VkgwZUFpM3hkR3JPWFB0c1I4Q1VjQ2dtSUY5ZHNHbHRKZGRmM1JkdjZ1ZUU4?=
 =?utf-8?B?SzFVRkpZdE5Ed0V3Ym9WcDk3Z2drOVhhWkFTR0FDTkMzQXhoLzdab2lONHJZ?=
 =?utf-8?B?RTVmVWo4MGppOGNQVklKQVNxVmloZVVxZmxybDZjMWlHbUZTeUR5K3dsTGs1?=
 =?utf-8?B?WGJXMUhlK21UTDlKajc1S3d3K2tnNVAwZjM4QmlMczM1SENOblZuejVRV0I2?=
 =?utf-8?B?Y2h6R1VIVmZ3VExlU1hFcDhIbndDRlM3K1l4cXhEVmlRMGh3UDVLdDBONTVQ?=
 =?utf-8?B?VnNVbmVxNnEyZE5sTHplMFpMVU04WHlvWllHRi9iMzE5S1FLcHdsOGMzTmIx?=
 =?utf-8?B?SURDMnh6MnNJTzZTcHM4Z3VuSWJkRlQyRXdpL0FyOC95bzJoR2dKV2F5cnhB?=
 =?utf-8?B?TmhROGNJbW9USXBqNEUxWVVCcVJ0KzBOZFM4bFlnY3VOZlBsQVB5dlJYMSs4?=
 =?utf-8?B?UC92NFRuQ2c5WmNPSXhEWFl5dVBOK1UxdnZuZm1mOGFXYWhZN3VvVU43WmNK?=
 =?utf-8?B?WGkvbHYzWkRwcFB6aDVmby9ycEI3cVErY0hIWkVGLzBZNVEvWU12RmhXR0h2?=
 =?utf-8?B?Q1NjME81WVljMWY2WXdmYlhXdW50SWZ0RHAyK21MRXptWVRqcHFRSHowYXly?=
 =?utf-8?B?aGo4WVNrK2JuQkVZWThtYTBuSXBwWFZJNGw1bnRJMnBPaHc3OFN6N0xlekdZ?=
 =?utf-8?B?OGx2bERlYVV0SDVWbC9MV1hSaDkraStOYjJjcEhiVkhobGZhZmlYN1BLMUlS?=
 =?utf-8?B?VmdjREdYU3owd3NrL1BHWk1JV0xERFpNcnl5TGQ3ZEpTYk1KUHF2NktsQVZH?=
 =?utf-8?B?UTdYcVhlejdwdm5mTytsTEYydGFzZnQ5N2NFazFZNzdDcmtOemtlN3d0VHdJ?=
 =?utf-8?B?QlY3cjczbm1XRTczTTRqMWRBQzVPREljcGozMXZ5RHRTcTJCQTI5THFwd3Fo?=
 =?utf-8?B?Zi83b21UTXRwcWV3UWFZZXR5MWxkZ1dELzYyV3h6VG9Za3hGU3VnZDJvZU1Y?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd8b163-b959-476e-097a-08db26c06268
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 08:19:53.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j76dJ3IfpdwTzNiiafznzSValdDQVOx7N5m1pSw5H788BDSLUK4GHW53QzZCQUf6p+aKG04CQXrASDSD2IA4uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
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



On 3/17/2023 4:00 PM, Ryan Roberts wrote:
> On 17/03/2023 06:33, Yin, Fengwei wrote:
>>
>>
>> On 3/17/2023 11:44 AM, Matthew Wilcox wrote:
>>> On Fri, Mar 17, 2023 at 09:58:17AM +0800, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
>>>>> On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
>>>>>> On 16/03/2023 16:23, Yin, Fengwei wrote:
>>>>>>>> I think you are changing behavior here - is this intentional? Previously this
>>>>>>>> would be evaluated per page, now its evaluated once for the whole range. The
>>>>>>>> intention below is that directly faulted pages are mapped young and prefaulted
>>>>>>>> pages are mapped old. But now a whole range will be mapped the same.
>>>>>>>
>>>>>>> Yes. You are right here.
>>>>>>>
>>>>>>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
>>>>>>> can avoid to handle vmf->address == addr specially. It's OK to 
>>>>>>> drop prefault and change the logic here a little bit to:
>>>>>>>   if (arch_wants_old_prefaulted_pte())
>>>>>>>       entry = pte_mkold(entry);
>>>>>>>   else
>>>>>>>       entry = pte_sw_mkyong(entry);
>>>>>>>
>>>>>>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
>>>>>>> because HW will set the ACCESS bit in page table entry.
>>>>>>>
>>>>>>> Add Will Deacon in case I missed something here. Thanks.
>>>>>>
>>>>>> I'll defer to Will's response, but not all arm HW supports HW access flag
>>>>>> management. In that case it's done by SW, so I would imagine that by setting
>>>>>> this to old initially, we will get a second fault to set the access bit, which
>>>>>> will slow things down. I wonder if you will need to split this into (up to) 3
>>>>>> calls to set_ptes()?
>>>>>
>>>>> I don't think we should do that.  The limited information I have from
>>>>> various microarchitectures is that the PTEs must differ only in their
>>>>> PFN bits in order to use larger TLB entries.  That includes the Accessed
>>>>> bit (or equivalent).  So we should mkyoung all the PTEs in the same
>>>>> folio, at least initially.
>>>>>
>>>>> That said, we should still do this conditionally.  We'll prefault some
>>>>> other folios too.  So I think this should be:
>>>>>
>>>>>         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
>>>>>
>>>> According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
>>>> flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
>>>> If we change prefault like above, the PTEs is set as "yong" which loose benefit
>>>> on ARM64 with hardware access flag.
>>>>
>>>> ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
>>>> and let hardware to update it to "yong"?
>>>
>>> Because we're tracking the entire folio as a single entity.  So we're
>>> better off avoiding the extra pagefaults to update the accessed bit,
>>> which won't actually give us any information (vmscan needs to know "were
>>> any of the accessed bits set", not "how many of them were set").
>> There is no extra pagefaults to update the accessed bit. There are three cases here:
>> 1. hardware support access flag and cheap from "old" to "yong" without extra fault
>> 2. hardware support access flag and expensive from "old" to "yong" without extra fault
>> 3. no hardware support access flag (extra pagefaults from "old" to "yong". Expensive)
>>
>> For #2 and #3, it's expensive from "old" to "yong", so we always set PTEs "yong" in
>> page fault.
>> For #1, It's cheap from "old" to "yong", so it's OK to set PTEs "old" in page fault.
>> And hardware will set it to "yong" when access memory. Actually, ARM64 with hardware
>> access bit requires to set PTEs "old".
> 
> Your logic makes sense, but it doesn't take into account the HPA
> micro-architectural feature present in some ARM CPUs. HPA can transparently
> coalesce multiple pages into a single TLB entry when certain conditions are met
> (roughly; upto 4 pages physically and virtually contiguous and all within a
> 4-page natural alignment). But as Matthew says, this works out better when all
> pte attributes (including access and dirty) match. Given the reason for setting
> the prefault pages to old is so that vmscan can do a better job of finding cold
> pages, and given vmscan will now be looking for folios and not individual pages
> (I assume?), I agree with Matthew that we should make whole folios young or old.
> It will marginally increase our chances of the access and dirty bits being
> consistent across the whole 4-page block that the HW tries to coalesce. If we
> unconditionally make everything old, the hw will set accessed for the single
> page that faulted, and we therefore don't have consistency for that 4-page block.
My concern was that the benefit of "old" PTEs for ARM64 with hardware access bit
will be lost. The workloads (application launch latency and direct reclaim according
to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80) can show regression with this
series. Thanks.

BTW, with TLB merge feature, should hardware update coalesce multiple pages access
bit together? otherwise, it's avoidable that only one page access is set by hardware
finally.

Regards
Yin, Fengwei

> 
>>
>>>
>>> Anyway, hopefully Ryan can test this and let us know if it fixes the
>>> regression he sees.
>> I highly suspect the regression Ryan saw is not related with this but another my
>> stupid work. I will send out the testing patch soon. Thanks.
> 
> I tested a version of this where I made everything unconditionally young,
> thinking it might be the source of the perf regression, before I reported it. It
> doesn't make any difference. So I agree the regression is somewhere else.
> 
> Thanks,
> Ryan
> 
>>
>>
>> Regards
>> Yin, Fengwei
> 
