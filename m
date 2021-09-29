Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2682641BE83
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbhI2E6A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 00:58:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:44345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242323AbhI2E6A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 00:58:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285875580"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="285875580"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 21:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; 
   d="scan'208";a="476522432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2021 21:56:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 21:56:19 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 21:56:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 21:56:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 21:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3StPj7osNp7V8aA838LyqQv3GplU52rB97gzoQPUErs63juEnWWrq6kIoVNslFyWAD31BaKysd3BFxqf1Qif8nHMsF7fdTbff5cRz3jmmT0Px9+jlDPRsGKeFnrUCTstueLYsG8QBra/IQF2gIrDcioh6Iccjr1r7wkL2R1smER93BxnFcSIQa9+ijxA2k2voiBCq/lGQ4vx7UL39xEfzRZOvoSrf8+aW54kswYYdLyuJOcFdIp3OZRGjYt40lZP/WQZ14oooTn+Ycqwr4ZXmN/S0NcBrWd7yBu7dNVn6aY9anzmjXymbC5HbayR5xscccyrg1AO19+NLHWXqR69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9eHoo2yJxHTj8c2iXwmSitMyZiEEpaIo8DeMZW12rL4=;
 b=oQ5LOZ1hIIz+5uHLdFIGqoliUB/JrKt3Bkvvt1u6PA6y0CnWOYjD3QqWTtA0AtI30Llg159+6csYbw32tOztVoH/4kdJUBJMnJkjsiyBUSm9cCfSl+OSgHTpnCkePX5cXJSMVaTRi6jR0G7lCHgLi4miPt1SM6P1toLThp0KN6omXUutd/J1dzy63u2lvIjJiYJKAS/Htk1CCfwYWMQHx0Torzne5k1Qj4SZWidFDgXrW2Tmm6xuODZeWezTI0vjfVNfXRc7GJ085Ui81ytjLGDoAGdhW2zm1jBNBAhEvcihVa2airwZOUIsmCDIBXJ9jK1xu1VLHksMVhOCgMBEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eHoo2yJxHTj8c2iXwmSitMyZiEEpaIo8DeMZW12rL4=;
 b=ax7ZcEirVFcuV/53WHJmuGXt4PrXVj4VzIMhu6eh5cZES9D5AxQO/P6s475nrH6uqQJSLPgymK9Xn4doN/qyFHy/Cwv4klqnnoHG/zx1Ja/qF9ETY5I9KligbYI71NWsD7a6YSLGAg8ySm2Tv9QbWjOtdLRTgiRL7jXH5ehUU24=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4797.namprd11.prod.outlook.com (2603:10b6:a03:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 04:56:11 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 04:56:11 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
To:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
 <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
Date:   Tue, 28 Sep 2021 21:56:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <f5a971e4-6b0d-477f-992c-89110a2ceb03@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.33] (73.222.31.188) by BYAPR02CA0025.namprd02.prod.outlook.com (2603:10b6:a02:ee::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 04:56:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 248e4fdd-4ce7-46b4-be2e-08d9830574d2
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4797:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4797C3E7A7ED90561FA6EE02E5A99@SJ0PR11MB4797.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSrXa27At+7QeWj2J0gx6pgdZHiSU99I9jwNOmImPJhweKpwFf071Uzw8AxDH7dJJyXD4w+DgcTbdgJraz6F16eC7iyeumg5aZ4f0kpJjFI+K+wfpa+71bMaR7GFhwYPOjluvHuppISYnrT0/s1O0tpnXS3YJjAaSeo/dwcATVlL4OMW4HQjg/8HXx+LKiXMGVaDV6mEycPPd3p69pSp7xyK1JwQUjbPuyLk4QnLvMiNf7JKRxmdfT85apBYdkunAtoo/nUU/En4iq+d3rEfKEnN6boxFSo7pOxJ59T0y3UzhcIRb1Bihk5nXg8H7V6NDo56ILD/sNh8NNmO9npFMZPlLmSSJop9uRR3pHolwXfEBQGbLeQ52ibf+AW3GhnKJtHpGEPyAHY9zN3hiRMYjtLU9fCn6xEjqRkZQDfiyn2Fpf21quzqjrS7XLWuPw/h1GqjcvxwNREe3GhQtquBi6F/Kx/ptKk2CXLRtadxvK1DrYoOYr/2fAJ3krhmoNigvL7xXpdWC9FUgMf1MNiVEIZ4GEtSZ1dvgd1Quck20rhd4L1p1WflG6iy0Mo2O7zipOMRh5qJ7sQVTScObwr7ulDg/HTsO0g3skvqbnemyhJbmruy0cCe0O5Pvij7j5LKJGqFVPcs0VUgWiXNFD4SFMtFeA/TnT6OTBM+Yj5/n9Zu6ChUI5hP0zzXVRsviuUPE6BH+qjY5DFCGtidFHbPpDHQ0XlBsqDC8Sb9kMb45eXWbm+VXWbUH819t97G4WBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(31696002)(2906002)(44832011)(7416002)(186003)(508600001)(8676002)(86362001)(36756003)(83380400001)(956004)(2616005)(16576012)(66476007)(316002)(66556008)(54906003)(110136005)(53546011)(26005)(66946007)(8936002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZOUmhGNjMxWWJkT0pwZEdib292akx1MDVNNUltSXMzMUMxSTF3VHFJd3hx?=
 =?utf-8?B?VEJMNXpYMWMyZThTOG44NXpINTM0VE1Hb2dvTHJia0g2UFhDNk1wNko2YkV5?=
 =?utf-8?B?MGR2WXVOc2pTeFFSOG5HQ1BhemM4SnE5T0xGQUNFcFJxR3YrcTdGcVdCazFB?=
 =?utf-8?B?djZFazV4UGIzbWU5MVNYbnJRQVBxNzAvRWpwc2hQeW1iSkdZem9SS0NiOURQ?=
 =?utf-8?B?SXR1MktacnJHVUdhc0RJazRHdmpkeitZeGtON1EyOEpjU0IzVWU1cTJLMTNi?=
 =?utf-8?B?akx2Q25UYkhhWm9STXk0KzRvcng0SVZZZUQ3bU1GZzhtUmJ5YkIzN0JlWU5j?=
 =?utf-8?B?cnl1aVhPeWVzekU5NDJwU1hPTzJEQURVcVE1ZlNMeHk4VFNYWkVIQkNhT04w?=
 =?utf-8?B?Vkx5UURZb1hsdVlYaXNDbWx4c1pLcGxSTGVIYml1UWdJSTU1RENkMHBoMTRJ?=
 =?utf-8?B?NXFQUEpMZHI0TmF2cWNVOTFldm5pMTU0K2RpaVRacXk1U1V4TXpqUDhHQll5?=
 =?utf-8?B?ZXVmc3NrVm91bGVJOHVYZDh3eWxpWEllSzd5cG1PczNsdzArQnYvTHJ1Q2ha?=
 =?utf-8?B?NENId1NRcVZGSGUrSXdzRUg3bmRBVFhPVFVJTWNyMElYNE1rcDBSUEF4bmx0?=
 =?utf-8?B?Zld0MjZPRW83QXJqSUNOdSsrUXBJYk5qZlN4bnhSK2theVNwWkdaYnM3UVpT?=
 =?utf-8?B?Y0Z3dGppMHdkU3VrOWVOUlk4cjVYRkkxcUs2Yk5QdGgrVFY3N3lwUjd1cTVy?=
 =?utf-8?B?Q2creUlQVkp2S2Q1OXhOUHdiMjVpR1NrVXVzbDRjcTNCSUxoeFUwYmpkeE9a?=
 =?utf-8?B?N2cyRlBoQ2kvRnpLc0lVL1hzZy9POVZKdHpTYm15NVpNU2VHTDBIMkU1N2pK?=
 =?utf-8?B?cEc2bnNjSExvV3pPUTBwTyt1VXhwbUxZVUNxL01Fa3hkdVdNSnU4bjB2Ynlm?=
 =?utf-8?B?T25Ia0NWWHJ4d2ZvamNOdVVMb3E0UmVBVkRyRnJuZ09YcWhudnJlTnQvT2N1?=
 =?utf-8?B?eVI5eGliY2JEa2h4ZHZkREZmNjUzUm5aOTJ0SnROd0F5allTRGUvNXE2dS9n?=
 =?utf-8?B?V1BJYzNPRlJMVndBVlRtNUhrd285NUh5WHlXcys3cjlySmhpNjlBenZtaWk2?=
 =?utf-8?B?L0xGWHNIbHFmSjNNY1FrUHFxYm1KTFBBSGxPamtRKzZ1NFVxb1RPVkcxWE5w?=
 =?utf-8?B?bzQ3dktHT3hWcEc4TGZ5OWplQlh0SlZRR0g4ZmNxUW9TNHg4V0pXbE5jQ25u?=
 =?utf-8?B?TTYzd2dHTG04R3k5TXNsZld3TktYdkpQWTQ4ZTNHRHFSMmVYSUVmNUxpNDNp?=
 =?utf-8?B?NlE3YjcxTTAvN0NNcktkYmJMTWZSdkEvVVJCNVA5eWFCR2VzY0V3c05rVEts?=
 =?utf-8?B?MWtvUyt6c0xVcE4vcmQ1R2ZkS3BRNEtwQXkyTHBuZjlWMEY3NjdmenJVSTlD?=
 =?utf-8?B?NURuQks3S3p1Rmc4Y0NDK2JuQ0V0NG5EVDNFcElDRFVsdGN2NTNEZDM3alAx?=
 =?utf-8?B?R3VaWDdZZ0Z4ZElWanpkdGpaRFlpdXlZd2M5c0RoWXRKQXJtQ0ZyamVQekFI?=
 =?utf-8?B?OEhTRkhKbGcvaHR0UzFLYUJ0azBCSVV5ZHY5SXArMEhwYnpWdDIyaFFQWU9F?=
 =?utf-8?B?TUFTeEd2ZW0rdWlRKzA5c2pBdFBkSjUwdmZXMjBGOFZ0YUJ3ZTdkN1RTVXQ1?=
 =?utf-8?B?NC9BTnBRb1BQZ1g3UUV3c0F0NlVFOEErYS85aC9mZ0pkSjg0R0VxYzBpVmFx?=
 =?utf-8?Q?ezgQY2hI2rydY46aXa/wMlZRsSGh4RCu9X6R4Sa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 248e4fdd-4ce7-46b4-be2e-08d9830574d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 04:56:11.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ7RRFh6mxA8iStN3DA3AtLd2Oh/EG2ymdJhQpSJbZUzBWyu3zadWtWqbrrszHhP6EMwx+tb2gaH/qOQJAvrbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4797
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/28/2021 8:30 PM, Andy Lutomirski wrote:
> On Mon, Sep 13, 2021, at 1:01 PM, Sohil Mehta wrote:
>> Add a new system call to allow applications to block in the kernel and
>> wait for user interrupts.
>>
> ...
>
>> When the application makes this syscall the notification vector is
>> switched to a new kernel vector. Any new SENDUIPI will invoke the kernel
>> interrupt which is then used to wake up the process.
> Any new SENDUIPI that happens to hit the target CPU's ucode at a time when the kernel vector is enabled will deliver the interrupt.  Any new SENDUIPI that happens to hit the target CPU's ucode at a time when a different UIPI-using task is running will *not* deliver the interrupt, unless I'm missing some magic.  Which means that wakeups will be missed, which I think makes this whole idea a nonstarter.
>
> Am I missing something?


The current kernel implementation reserves 2 notification vectors (NV) 
for the 2 states of a thread (running vs blocked).

NV-1 – used only for tasks that are running. (results in a user 
interrupt or a spurious kernel interrupt)

NV-2 – used only for a tasks that are blocked in the kernel. (always 
results in a kernel interrupt)

The UPID.UINV bits are switched between NV-1 and NV-2 based on the state 
of the task.

However, NV-1 is also programmed in the running task's MISC_MSR UINV 
bits. This is what tells the ucode that the notification vector received 
is for the user instead of the kernel.

NV-2 is never programmed in the MISC_MSR of a task. When NV-2 arrives on 
any cpu there is never a possibility of it being detected as a User 
Interrupt. It will always be delivered to the kernel.

Does this help clarify the above?


I just realized, we need to be careful when the notification vectors are 
switched in the UPID. Any pending vectors detected after the switch 
should abort the blocking call. The current code is wrong in a lot of 
places where it touches the UPID.

Thanks,
Sohil

