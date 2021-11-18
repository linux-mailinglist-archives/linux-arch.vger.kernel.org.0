Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8F456587
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhKRWWn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 17:22:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:21077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhKRWWm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 17:22:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233025769"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233025769"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 14:19:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="495595727"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2021 14:19:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 14:19:40 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 14:19:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 18 Nov 2021 14:19:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 18 Nov 2021 14:19:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clu1qEXmrkcVQ3OAkghV5NKxoEEdyS46Mvapc1IcqEz5dAAk+2PaFLXpAkUg0bza04Grp7Qb9IZymyhumBFWoaiN5fNuLEtzCy3L3hRoukPmu3kKV9CiJiBOhqbg15CNkbxaCxGdYT7wJd5xfdk3GapAHEt0WRdPteDc4azuxV/fsxLmuFlF7ow8gLjINKJyi6XIyy63KIyjQjxK93iWOZdUJHjF7UD9YQw6QQ0sUTTuBYieXWZvx5qYT3i7iBCd/I4oBJVoj1U4RooqdWI/FZ60kkMw1AZo6XWDK+OMeswDv90TZbLWEPgZfelCUqOKebgM6Cfa7lUFZER6KuE4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EalPoB1/q15ZDrRmAdh5hcIhPS6flWR3h14khVLatX0=;
 b=dP9lXGgsTEE3vcbItNa/0c3UnsBBCO/ju5sb9DJtWy8DodyJ7Zjp7DKaI24JDHvez723s2jfMpDnG74WhQCVDE8noBxInWfdN3mHaRg9qJao3iq38GOiJGP0KQqT1DUsiCZw/MjnIkFApGbtGVyiH6BLEefaALPGYWOAOOccbFM8iHUBnnTciNXBCa5CFOTDtfpnVpxe0xYoJgw8y+Du9QbAK/btwguLmn6h1vGDnqZgsnsPURu6smrAyrkJrg48dtfFns1TS0Xq6ajkDpJVExsCKSGCXr73K73E58L6EBKP1XugZi3Qq0TLfAGOisXn4zPtT+oxAEkklxG/7yeWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EalPoB1/q15ZDrRmAdh5hcIhPS6flWR3h14khVLatX0=;
 b=O9ZUCb2EIrdLlj0hygs+YPmtqb+NMHXhqUWAGWC+6oKLG1JBiktph+DLfFYyB+2FD6Grs0tnWPh19f9bgYuPX4dY+jiSlmUOhhKFSaVZBH3AnBOtJtSY6ll62fDxK8hFg33MzFpLzLjngq7bqOUQwWDrIkEk6Jop5BjbM2lqRA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3382.namprd11.prod.outlook.com (2603:10b6:a03:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 18 Nov
 2021 22:19:34 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::8c17:ca7:7fd3:ce7d]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::8c17:ca7:7fd3:ce7d%6]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 22:19:34 +0000
Message-ID: <97b12c99-60e4-e3d9-a728-e7d1a7c09e41@intel.com>
Date:   Thu, 18 Nov 2021 14:19:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
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
 <20211001081903.GA18962@amd>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20211001081903.GA18962@amd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend Transport; Thu, 18 Nov 2021 22:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8de9bac-1437-4aea-75f1-08d9aae17ffa
X-MS-TrafficTypeDiagnostic: BYAPR11MB3382:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <BYAPR11MB33824FD801BB5920170D4E96E59B9@BYAPR11MB3382.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EQLiK4WX9BVEHtr1bnE7tJnmZdOijoS3j4QGRk8QVC5hXs3rlpRrfiKDpvS19VIx8a6MtbkObuzZ8B7bYgtt+03b7C5JlZkwG1ojpiqvPQ2JjrHVFhMcUv/k75BE6cMefRlf50aMiUw+iK74/duLq6/0zNH3cLgKD2i0Ah5gnF/5bbM5C07T1LytXIw/DLrfI1W3HBL+2mchk+kc7exBLl7VCXR/LXNBOMcQzQhgbrwEargDND7kYacCyKZ/RDNoBf4//kFvNRGhMv2SrOYVKQI2QvHOydUduLGC//mqjRCnlqVZ3edBu3TxUXfSUnGytttk93IQgn4BVDQZYnaPDmlDNqXIUJbWk6lVAJqGlKWza9K45I+nbeAxKPn7ZCsp5wNVgWv98dGpZW8xn375tPU6go/a7UuGBgMY3MgS3jh1cKWnBR+gjZatNUICbxxrjL1MADovQrhinRTr8RRW33sQjdetmz6LNxRvRIdBbbDjf6+I0ijWMuy0Z3KirDi3rdphIor1yfzSemB8AFMLOK/JwsURq1xGhAYwYhB9d65It7/YvBH7+1WO7tNC6FFRTHNpYiqHzoRF9BMbGU13z2Kre1i770vf01ynHfoMYIZ0PevJmOrrgMeDdHfTpW/uQ79Hmvm/PL4EaOcI3Y9QGZWzaPpbLTkp5c2pgM8BN+XzLgaF/ctkLe9UDL0GbKMP5vdhcF1JWvv2LHANp+CFgu2xP+74U9qx/fyiDos1DLxc7jjUttIeMLsN+bsWOCx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(8936002)(508600001)(86362001)(66476007)(186003)(66946007)(54906003)(316002)(956004)(31696002)(7416002)(44832011)(16576012)(31686004)(38100700002)(2616005)(36756003)(8676002)(26005)(5660300002)(6916009)(66556008)(53546011)(82960400001)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmh3R2JRZTF6RWY2ajM3aFFhSy90eURsUDR5K2xGNlhSUzRpOGFKclU3RnBM?=
 =?utf-8?B?MEVtVnNCWkhTbjVqeHc2T0R0dnZGY0Nuc0Rybm5pUHF0c0NXdkFOZ1habU03?=
 =?utf-8?B?WUN1dzQ2bWJKVEJEWmtSbUg3S2ZPTHBKYkZ4RVhIZGZ2RGlWaDhrTFFGbGpW?=
 =?utf-8?B?LzgvSHh1UUhUTVNlLzBodXhRZU4rK0N1SlZKUUdrOVUrZUg2ZDkwL0RPdnp1?=
 =?utf-8?B?eFRZR01YQ0dRUkYyUmRkTnpubzFvT2lEd0hobDNQNTdZVFVON1FXUkNSNXRE?=
 =?utf-8?B?OTMwaHFWVHJNWHM5SjhKUG1reHRMQW9icDE4VVZMVXlUSGFNc25JM0dyQnVh?=
 =?utf-8?B?REYzSzlOTGRKSXFCallMUkxUUTBQdER2VVNxbmdmamx5cnp1dUpkSml3ZjM0?=
 =?utf-8?B?UmwyZFdpcWpXcEYzQ0NBNndyVFY2MHlGdk1iQTU3dGhNRHFIY2ptWEpTZXpl?=
 =?utf-8?B?a0x1M3A1VUFnU0Q5UGdZRGdxZ1FKd0dKZDcwQkVCWS95ditqcVh3VWdkejRF?=
 =?utf-8?B?QUNEUkF5MmNIM2FnQmJVOUU5WHI5eFhuVG05VnBDNWQ4U0o0YkprRTBuR2Jv?=
 =?utf-8?B?TGdzNnVIWFQ0ZVc0UFhSM2lPQlJZaVlHSVQwV0UzbXlhRmxXOW9sMHRpSTVX?=
 =?utf-8?B?d2RaMFBTZWl0cHVIR2tkSmVvUlg2OWE3QVRYeEpMbjkyc0FMb1VBbG1DQk81?=
 =?utf-8?B?TE51NStobGk3ZUNOZE4rbWVYcTExZTFtMDdhR2k2Q1Q5YXVrWmw4QjFreWlq?=
 =?utf-8?B?Yy9Xcjgzc01BNEVwWnU2cTBFbzdwaU16MFNXaGw3RkpmRXM4Y2IvdG11RmJk?=
 =?utf-8?B?Vlp1QjBYbFpuUkRtN04xYkg1YkphN2VNZkxzOEdKWHBaaVhKbFNYaGlhZWpG?=
 =?utf-8?B?ekV0Z1NOdUJVdkNpZ29mT0pNUE5wd2ppckY1U0lCbGRjT083c1hScXVvdFBa?=
 =?utf-8?B?Y1JXa0FMbVRZSUNhZ21vbmRzNVEvLzdObFV1UlhmaDNadjdGWm5OZ290WkdO?=
 =?utf-8?B?U0RjV2Fzeit2N2pJQktIaUtNNkx5SEYwcy9ldGhpdnRJSXMyZ3JBNkEvbWFM?=
 =?utf-8?B?VzROM0w2dlhvcjdwTis1OE9FbG9MRzNZSXNoZDB1UU5KdzFOSCtMSXozazFO?=
 =?utf-8?B?KzlrWWFlS2o1cTRGbWJXSC9hZnpkWmoxb1VYcVg3MWw2bUFkT0tUNFp5bXV3?=
 =?utf-8?B?TzdodC83YTFjck1sUEQwc0FBWkFHZ2cycUk2VHgrMW5DWXRwNHNiNWNWeEVO?=
 =?utf-8?B?REwzUDVOQzFYOEoraVhEZHd4UnZCbUx2MzhOdjdNcnZMaG90WnE3OVVvdmFk?=
 =?utf-8?B?c3lrYXBqQlp5TWZYSFlwdXo3QUZTbFNPRE9qOCs2blFacGRrbTQ1bVkxY2FT?=
 =?utf-8?B?WUJqY25ZMWlSekJ3aThGNTE3c0NobEszbGp1N0pKNjlvVlVYRjVaaU82NVd0?=
 =?utf-8?B?NloweWhCQ0F6SkYwOTg4cS96V01Dc01OVWpQaU02cHVNd2dGM2xZMjdkZmds?=
 =?utf-8?B?ZTNHK1VqWHlqNWpFWTgwUHJmaTRYN0VJSmNGKzRxN243L0RFdTZFMnhnVExh?=
 =?utf-8?B?UWlCR3ZMbklqUStyL2NvWVBoL0ttdUpFRHA3MEo4OG9Jb2N6MExRUVpVNFhh?=
 =?utf-8?B?SFVKcXZta21SejBCbjQwMjhWVTRZRW1RYkoxZS9INjA2Qmo1QTNSZVFxZ3BO?=
 =?utf-8?B?VDYxQ0R5UzIwcEhaVGVhY1VzTVhCSWVkYUl4U1dtZ2wrQjRZZVc4ajVKTSsv?=
 =?utf-8?B?MXViL1lNOWd0Q2JMKzRMRlZRNzIvS1Zaa2ZBSm4vVlVtQTgyOGw1VDFobG13?=
 =?utf-8?B?OS82VDFPVTA0NzY2cE43bDc3S0h3MUczR3d6VGlJZnRic29SRFhUOFJINDdK?=
 =?utf-8?B?WnRibTBVTzVBd01sMEdtM3VaVFVkSDZHL1l2clhoZnRGOFhxTUsxSlNHRVhj?=
 =?utf-8?B?TEpIdkhDVEgxaUhWTTN4ckZPV0lQQ3BVNWFzdW55Z3JyY3NMT1RUUGp5ZjI1?=
 =?utf-8?B?a0Qvb3ZBcmg5OS83dUU1SHBoTnhhZTgrK3oxVjVqSE0xRXZ4RjNSckVEVW1o?=
 =?utf-8?B?Zzk2Tzh4cHcrS0dnMWVUQWIrRTBCdE9zT29hcTAyby84Z2YwbXp1aEl5bnRJ?=
 =?utf-8?B?L3VzTVczdW15WWRKbEJoYUNjdmdnU1hiSUREQm1FeUg4bmxhOWdnWUt3RmFY?=
 =?utf-8?Q?XkpxW9Sy8yJvddA1UBRpCOU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8de9bac-1437-4aea-75f1-08d9aae17ffa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 22:19:34.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4rfJQ0qjnkbdku8cOnAfFZ6DmQxK6Pbh9ttf8Mjd3RMrbgM37Oh1jTjKgB0q7icY3f3ykSij7M+06A9isGFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3382
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/2021 1:19 AM, Pavel Machek wrote:
> Hi!
> 

Thank you for reviewing the patches!

>> Instructions
>> ------------
>> senduipi <index> - send a user IPI to a target task based on the UITT index.
>>
>> clui - Mask user interrupts by clearing UIF (User Interrupt Flag).
>>
>> stui - Unmask user interrupts by setting UIF.
>>
>> testui - Test current value of UIF.
>>
>> uiret - return from a user interrupt handler.
> 
> Are other CPU vendors allowed to implement compatible instructions?
> 
> If not, we should probably have VDSO entries so kernel can abstract
> differences between CPUs.
> 

Yes, we are evaluating VDSO support for this.

>> Untrusted processes
>> -------------------
>> The current implementation expects only trusted and cooperating processes to
>> communicate using user interrupts. Coordination is expected between processes
>> for a connection teardown. In situations where coordination doesn't happen
>> (say, due to abrupt process exit), the kernel would end up keeping shared
>> resources (like UPID) allocated to avoid faults.
> 
> Keeping resources allocated after process exit is a no-no.
> 

I meant the resource is still tracked via the shared file descriptor, so 
it will eventually get freed when the FD release happens. I am planning 
to include better documentation on lifetime rules of these shared 
resources next time.

Thanks,
Sohil
