Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4705441C6A1
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbhI2O3F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:29:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:25207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344428AbhI2O3E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:29:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="204439500"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="204439500"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 07:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="479281629"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 29 Sep 2021 07:27:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 07:27:20 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 07:27:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 29 Sep 2021 07:27:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 29 Sep 2021 07:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOR/tcqjE2X3ybgeZ50KZSt7We5ALuKG5yzr+6bqGGTaV8Q6DYXmpgmY/1n9gKnEUUUInT9hKN2SL0OEgloWRc+gIrEDufA6v0x+aqC4qLYEjN0vSZ0u0WrwJb9Wm3C7xxHhI/xGRajz4R8vFZPBntN+RgID6LPXkDpye/ywrttut8N6BdQfQKeDST6P8al56jxu8L76yxTMTjdzgOP5d13+xB5G9I43qAAk8BnMu7NEUUvqFMaA9lG9DtdWHytbMn78qSsO7H8uSq8GSxt0c0y4IUJz+Nk4G20x9CGWiLF2UPdLFg1MQyTM61g9v7+iGD5DIAkBhsmEqGjA2GBbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RA+R0870pba1PeDytuVoR3Nnm3NHRsnX/CXd2AmR8bI=;
 b=Rxc+8XZAn45ny/YHTcJ4d6qq1sSEiWMHLNlErtx9zdo2kv/EPfcWYCd2cpNTq+Tysle6MeZtrQSZ5JX0tVc9AWV2XrHM2F6YRjYaGkjDlcqXdcmUcqT3jEHnCse2j8H3SW5Xpy7O6OZ0UpMQ/saWCSjoH8uODWR3IsLFFI/VdAS93QrsYNNsLHIALvmqI1kuugTIHW/1InEZiOeTVjeRDgeya22GQM7sxR5tnObDGTzB6wGu/WNKChWeaxFO17qJEHaR333MWah79cgHBBuxM3kHuIt9C4e4j98KM1hZaMQZpF/b3lU9oS7QgfekUxIgBRA/ofm/XgPk7QekGpW8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA+R0870pba1PeDytuVoR3Nnm3NHRsnX/CXd2AmR8bI=;
 b=cstNRDnewUYlcvEXgU8VsnU/liwOpM4+iY+g8Yqda6IQ7eeogpJ+UHnMLzRWlrimD2CKaF2WBwNpfuPb8mkKyfrhxdO0XIEjOWKII3MC75Fgw60ax+o///SPnpNx4e9eWdhU0x6ddfUZjRlKaUCpff1WDRO+MmOn4C42196b6EA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3237.namprd11.prod.outlook.com (2603:10b6:a03:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Wed, 29 Sep
 2021 14:27:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 14:27:16 +0000
Subject: Re: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-11-sohil.mehta@intel.com>
 <YUxy6XqMB1+DYJtP@kroah.com> <4704e81d-a3d2-aedf-1c79-e45cc86826a5@intel.com>
 <YVQQFs4HC3tn2GiG@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <40eb2b51-b928-0bf4-aac7-abd7032af640@intel.com>
Date:   Wed, 29 Sep 2021 07:27:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YVQQFs4HC3tn2GiG@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.33] (73.222.31.188) by BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 14:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4f6cca-e1f4-4e90-388f-08d983553c68
X-MS-TrafficTypeDiagnostic: BYAPR11MB3237:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB3237C9A1223BC8FEE4EF4236E5A99@BYAPR11MB3237.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DylzvDEmgdbJGL7Y8NQ9/YKSojqPbBZ6Wc0JEt2cSZDYM9OkD0GQlPCi7Dv8bQZwY5Vb8VGpiOf2Q/fWQYgwRb8oyF6f9hgc6TkhKhG5laSsaHcfEfls2JfFa/tx2UqBQWij8WBpILHoMvMeGor4SlMR+G/kEhcsALQipXeLN8+IU6envZ1LpSkHqJ2AO6UUUmEurQwBkOR+FNtRSbuv3MYamyOGERg7UIc89PJ47SJaKzCGUfpSFf4J0m1KWtAoGbz6pNBiTwwVSsLAJ6mVt2luV2Kh7ZvZe3jJTvbdCfHekAlmHUJOBMV3suhuR9b6DcJQXqRN30QbegDG+lgpvmRWPJUMaCh/VZWXynck8qjenbapZXC5mm1qW9A8kWPlpsQe1TwxGDxu/XaKw7NzabeOeIjlNMRLXIJ4LbyNTqsFDhAPRVVmUrvdeEEUysoCqca/vaSM6eiJXN+pVZzYkCzkDjYFzvcsz5rPagMu4NS3el1aB7KbMZTzLNThfcFLCiXfXwnzTFcBtOTPyAht4qXpIQXxpKJTpjBGFuhQJc080ppIUQlEOeV/0Ho/RVTJyCw/LLePfjyS8DXGBUy2wKguLd1QtVC4zpMrPgWRgZpgWLSgC/DSrNVyAYgKQTANCnfZlHxF2EhIk8AE1xgp0cvQzePci6d/2tJxOnok7I3j4GctgaeZOg8EYsGyA/LWm/86bI3rYheuUOrLuIGcgFGjm7mhZbiC1iu2kwyr9NdX1nqA2JnsTSM2bcsOCmYH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(16576012)(7416002)(31696002)(86362001)(2616005)(31686004)(54906003)(5660300002)(956004)(44832011)(36756003)(53546011)(8936002)(186003)(4326008)(8676002)(26005)(66946007)(2906002)(4744005)(6916009)(6486002)(66556008)(66476007)(508600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0lnN3l6bnczZFpia3FXSmJxR0E2aFJIQ20vbU5tekhtb2R6SHM1cnBlQmlt?=
 =?utf-8?B?ZHBDZzlzL2tZMVA4QUVyblp4ZG9TSVk0cTRQL3VaZ2RRdDlva21vWW8zTi9n?=
 =?utf-8?B?SzFYM3d6NDNxVGxGcmlERlNvRUJoODlvUHY1M01OTklxYUM2T0g0QzRzYlVR?=
 =?utf-8?B?TEUrSDFYZCtEVUM4R05zTEZWSmx6UnpxUEx2WDZYeDFxM3dNZUJGNCtzbmJ1?=
 =?utf-8?B?U0pvMUVqeTMxZjlpV29COFVMREs3Tng1cjZKY0s4NkdNZmFzZUp2dTFUN2VN?=
 =?utf-8?B?cDRUQXk4bjVCM3VLT1N6YU9TL0FBVjRHZjVaZkoxNno1VEV1RGhUSnRQT1Br?=
 =?utf-8?B?M0RCWHVJNU9MSWJhelAwVWF4WGtBZXIwSm1vZjBBdjEzdVcwUFB5Ukc5RUx4?=
 =?utf-8?B?M3Vod1ZvTVhBM05WTnI4ZWlVeEQ0UjI0YktsMXN6Vk5ZYmJ3SXVLOGhnZW0x?=
 =?utf-8?B?SnRGWVFTTFVZV0E4ZWsxWmp2MEpXMDBuTDlwM1BlYzRpRHBDMmQ2Ny9aS2Rh?=
 =?utf-8?B?T29hSnp2eHlDUFFSaFN4UlJYNmJoMzBEMHpjYmNqdDJ3VWg2M2FTWWpGMVUx?=
 =?utf-8?B?enRtY2I0RzVseCtxTE1EVjMxTVNER05YTm5kNml3clFxeit6QnFaa1I4Zmx2?=
 =?utf-8?B?REhOODhjazlHbTZPc3lRajVLc0x6a05QVW5vVTRlbVN2dHdGb24wa1paRlk3?=
 =?utf-8?B?UEorQVRCQVNETmVWQ28vb25LYVE2ZXE2Q0tvTjArc2p3OEVQenJNSURGVVJT?=
 =?utf-8?B?U2Yzb1JHM256SXhIV0xLbkJTdXdkeU9BRFhZSVVQbVFvaWVHSG03aGM3ek15?=
 =?utf-8?B?ZU83M2EwK1pmcHdKVFZUN3poa1hYcG9tOEJ6RUMwV0luS0tFUm1PTURFVTN6?=
 =?utf-8?B?dUZ2S3VXZnFSZ1RDcUFPazBhS2JKc0ZWOXJubnF0cS9GSGo3ZDRQamNsMXl2?=
 =?utf-8?B?Q1loNVp0QmxUSTZPL1dSNzV4SXB3UmJ1RDdGQ1RTektWSzQ2anFGay9tYitF?=
 =?utf-8?B?ZERLUGJHUGp3M1JJQzZ3QkJwWlJyZ2ZhLy9Sdk1qWmFzeHNvTnMxamlGT3p0?=
 =?utf-8?B?eVdMb3RYdEt4QWl2RU9pTldqbStHZ2RHNnFkOW1QTGhBRjQ4eHZseHdVTnJ4?=
 =?utf-8?B?N2huQXNCZVlxTjhtc1Bzdm9XcjJFbzVNTkp4b0lZb0RNYnZpdy9vUlRleFEz?=
 =?utf-8?B?dEl1UmVydDlkU1UxTUZwVzBFS1lWRmczUEdzWHNLbytlUC9OQ0s5N1JhT0Jq?=
 =?utf-8?B?M0dzWldHOXZyMnJoTjNnOXNzWGVseXZmRGtzTnB0UE9uSTg2eGc0SWJiTXlz?=
 =?utf-8?B?SkRZOU15SFVCblpmMU1UU1k3R1UvZ1k4c3ZVamNDWld4UnpacW00ellEWWpS?=
 =?utf-8?B?SFRoNCtpZUpJVXp2UElIalRYcFlmR0ZITG1hRHlLNXpKOGdqQkJqOG9JYmVK?=
 =?utf-8?B?NjNjZ2NSQnNjWVF5RXhmYm9EWXhuM1FiaUxMQ05pLy9lamxHZmJ6K05vOEJx?=
 =?utf-8?B?anhSRS9PaTlTM0RvdU1senlXdHlKV01acUNQMFMwUEZzcWg5ZlZIV3lTdVQx?=
 =?utf-8?B?R2tCSGNrMHBYUThZbHQ1UElNcExETklWalpRM2t6ZTdiUnlZUGhoVVBTWFRM?=
 =?utf-8?B?VkJaZjhNampQUG5aWWRCSmNCUDhzelFhcWZRSnhUZFNiTFBnNXlSOTJ4N2t4?=
 =?utf-8?B?K0JrMFpWUllBY2J4MExUeG1XWVlhdDA5OUx6Ujk4M0F0Rk5INit1dXJRRzVs?=
 =?utf-8?Q?XDp4n4o/2PTBnGmzdccVghYGauKmENrf7ISJSma?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4f6cca-e1f4-4e90-388f-08d983553c68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 14:27:16.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt7eIc5AYVFLJ24AuOzCfFwHJR9rYCO6zL588oBtUUSk5tYIvEJZKgV6XeoeXMEZtoLdmcUx8NUflCEHueld3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3237
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/2021 12:04 AM, Greg KH wrote:
> On Tue, Sep 28, 2021 at 11:01:54AM -0700, Sohil Mehta wrote:
>>
>> Is this reasonable or would you still prefer a pointer?
> Ok, just document it really well that this is NOT a real address used by
> the kernel.  As it is, that's not obvious at all.


Thanks. I'll do that.

>
> And if this crosses the user/kernel boundry, it needs to be __u64 right?


This one doesn't cross the user/kernel boundary. The kernel programs a 
value in this struct for the hardware to consume.

But there might be other places where I have missed that. I'll fix those.

Thanks,
Sohil



