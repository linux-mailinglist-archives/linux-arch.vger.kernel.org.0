Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC95A456526
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 22:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhKRVsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 16:48:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:32957 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhKRVsF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 16:48:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="258087215"
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="258087215"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 13:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,245,1631602800"; 
   d="scan'208";a="646955446"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2021 13:45:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 13:45:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 13:45:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 18 Nov 2021 13:45:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 18 Nov 2021 13:45:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQa8jZE/jpa+8lPKVomSGGcE/hzj9oDW4YQF6YpH2dxbHKIAGUmuJyOQXihV9u0DoBpRt6hdTW7eVExvcPRTuYepu36jLcP0xkfTyAkXyu7tvN4xXdSlditKwniZjQlsnV2Eun1t9APzqK5UArM8Yb8+7OkpPFjOdFOiEWpDxLP7doGWpH8A9ea7jHhc3/fSM1cPcFlTmC2EUsfjFUvbTiRH7ryFoYVBnnHVbqWRalkeLRqRBWP9B31GfX14NpjpC8UoOb/k04MaILqQyDVMA7Rs/dx46k81p8w84d2SNGBB/NmZxqd3/iTJ+pS7/teNfTxf9zkmONQYK8RmArbkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gtI7Y3NTcLebzxFLW133Xg43lDrHlNKDcCD98ybSvo=;
 b=n8fKVjG0cs6JdhBlm6qXh/Av6OOj5+YxDEFkpTqAsGP8MP2cmveXHUf+CEBui3ujEwJPzBwaXinabjOL5J/PaA2aeDqNQ2qjywlhbgtIRRjuSZ4IGsCm44LPHkG3Fwy2+ApugIuR8j9fhZ8jP1KIlVjF/cosFUEV4SDQrbizkgipsNTQCSCX+YOVcterEqBWtJtOHewJiRgBhovsVf5LntLrsKFUP2uXYhWDkbKKkey1pNcVhCSMeIViqSxL5qQbRR3BU7d9CsaNY9nZ2jnT4ExYeQyfi/qDgHsqmutl24n51MXevfTVycYBgKWNZ3IrdmjT5Soi2hfaL/MPcPVdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gtI7Y3NTcLebzxFLW133Xg43lDrHlNKDcCD98ybSvo=;
 b=dFN2ooGGztpTkTx5/zFNpF+eY//qZAqgjRWIhU4QAdxUAWiqutuyvmK/ZXqtQdJA5q0EqkF54VPWJsWs6t9iMp0dTTB8RGiQkwKE6+a9gzAdfGZS1CyGR5vzEkLinM/gWyUw5RKsosd22ja1fXhD8xftjJejEXXYW1f1vo3RrFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3045.namprd11.prod.outlook.com (2603:10b6:a03:88::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 18 Nov
 2021 21:44:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::8c17:ca7:7fd3:ce7d]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::8c17:ca7:7fd3:ce7d%6]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 21:44:58 +0000
Message-ID: <3918b4e8-d612-8394-dad3-78d13218b4cb@intel.com>
Date:   Thu, 18 Nov 2021 13:44:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Language: en-US
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
CC:     "x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        Linux API <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <D4A544CE-15E8-4C9A-9245-8B0146E272F3@oracle.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <D4A544CE-15E8-4C9A-9245-8B0146E272F3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Thu, 18 Nov 2021 21:44:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dbad686-aab4-4503-6233-08d9aadcaa54
X-MS-TrafficTypeDiagnostic: BYAPR11MB3045:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <BYAPR11MB30453D154123036545F26D41E59B9@BYAPR11MB3045.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMQIeoCUdoO2qwTv3MUCDy3lqynTV/MuI/0oy8ODCMzPH8qDUhm6bJMtJZUnjl6B6x2+3Bx//lr9sjPRpYIK9oxOfZb4XWReAaIrn0NF4ypbH5IA8BTsi4wLnkVAlZ/nJMT5TRxFRdzZ5fJtchQwlYbTVgxY8GZvliDjXXSroLFk5T5nViEFY1bN5vsR+e/4XrL4EUr4kGf6D9SGRZTcVNBmZFJ6V1GDOP3VDPr2O/6W3c6VnZ3ipJDwCRKcGghijflLZ6yKxWj2kUup6WM2g60gN9u1G7SsFEA3rSGNnBN8JzO4Lfop6bGWXtqiTlWyEQBOKzGhFE9tFcBN7EsCLilX9/k4v++C+2sPwQu8ZU6xFK+u5w5o9QQvu+WBJ9lRmA+GBLUqaEltjvoPTPfwa7G3RSjIM2TQmiItNzFBeYsbo8utTSmF8S2uRHKkl1IdjRD2W0RgAQdgyUbiV848gd5mLHyOeoN6jcX1DV3e6JaDxU/WImfKkdE4Guw93VH7Pm7zQAfnXDoeQu7H2DPTD01ZnHTRYFS93864T+73/Vz34GfocGznh366RpFQAnhn+Pk2dTFBAjXH6Dsm5+4GNzEttP4shrRpa/fGJA1cYfGsT6EgVtIFd7jdD6wstHEtp6ZuwV8VTnmltGbJcGFkUP+eeFY5KRlVBm/jdIsPF0ekpqgPj6nkzJnm1fY61ZAoC2qsphLgL5wZeb1JPQNXlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(31696002)(5660300002)(2906002)(82960400001)(44832011)(16576012)(38100700002)(8936002)(86362001)(316002)(8676002)(31686004)(6486002)(83380400001)(53546011)(508600001)(186003)(7416002)(66556008)(66946007)(66476007)(6916009)(26005)(2616005)(4326008)(36756003)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxhbW91MG1BOGxZZ0JiZkNub0lmcDhyMlZYUm1raUU0MjFsOXYwdit2SHVi?=
 =?utf-8?B?aUxzcWk5QlRYMjdvWktKL3o2NnF1blR4M0ZBY1A5bVNVM0M3ZmVIRDAyWXMw?=
 =?utf-8?B?azVkQy81cE1obFJrb2ZML0MxY1pja2JaeG95dXVZL0hnYjJPYnhMQkw5bW85?=
 =?utf-8?B?eVZGR1Foa3NJbElTOUZJMEJJL2hLalRTZ013UXJ3Z0ZMMk8ySzJ4OERkdG5K?=
 =?utf-8?B?eHJmOGRvckIzUGVsVjM0RGpYeWg3MmxoT2RqbGxwTkg3R0pRcjcxTjJDTE5o?=
 =?utf-8?B?RzlKMnphYU5PeW9RRjdBNnBXcnl1dWlDcUtoV3R3Mm5PSll2YndSUEtONjBo?=
 =?utf-8?B?a1VLUVNJQ3p6QUNHaEpjQ1BUS1NDTTR2dkVGWVEyQmpoMjVaZlo2a1VwQXJr?=
 =?utf-8?B?eTZYNC9TNlhydjlOblRNeDE4WjBZTll0RVJaaDA2bDNRYU52K1RJNGg4V28z?=
 =?utf-8?B?Q2hsYTJtOHd3YUNnU3BMdk5sOVdXVENNeEdDaEFCeHI0ZUwwb1RjN1dIQXl3?=
 =?utf-8?B?MFJtMlFnalhxN0lqelhlbmJ3ZHJTK01hQndjMTB6VWYzVlJmVHFMWGZEeEpt?=
 =?utf-8?B?NkQyNC9qV3pOMXl5TDV3NHN5L3hlMHVXNk91dHJVRGlhaTJSSDBDaWYyQXcr?=
 =?utf-8?B?M2lmbWhqQjZpLzdrVzliYmNxKzdMT1Q0WnB6V2JyWC9aenc3ajVpdjRZd0N3?=
 =?utf-8?B?ZDFUbTNKamtUazVFRE9YUkNwb0s4V3pDcFM4UDkvdVk3L05xaXlHVTg4UTVC?=
 =?utf-8?B?ZFA5N093cDBqT0xqa3hQbmVleDE4RmxHTGVXZ2VYZTJpajNnLzcrc3FlZ1lo?=
 =?utf-8?B?cFB3TXcxL3Ixb1NydGpxdkFPbTFWeUdWOStIb3oyeVJaVC9qVVRWZTZMV290?=
 =?utf-8?B?UUxDYUdialdkMTBJNFRlMVcwVnJrMzB4K3BRQXZvMmJUUnRWLzRNZGFidEhS?=
 =?utf-8?B?WmRFd3dlbGpMWldod2RXOWJYNjZPRzY3WExuek0xWHJkdmI3QjBTVDFycnUx?=
 =?utf-8?B?QkhMNXpDcStTMnpLdm1hbkIvOTlKNXQ2cGk1TjgyL2duT2VTRGpYajJSWWFP?=
 =?utf-8?B?Vkp3ZHhKUFE1dE9OR2Q5cnRSZVFPOUdYc1g2WWs5NGlnNVVtLzFvSHpvZkdk?=
 =?utf-8?B?c1NlU2dPelI3d255dERyV0VNRUFucmw1K0JPb0VPSFBoMWRYSGxTbHRSa0FW?=
 =?utf-8?B?UDZicDJwS1A3M1V0c201WUJBazYveFFLNVQ0V0Y3R0V1UkMzNDhpQ0dEQmxT?=
 =?utf-8?B?MkoyU2toa2tXcmY0bzRkZFhia0UvcHdPSWgyYlhLNVU5WkhVb1lRbGJRSEtH?=
 =?utf-8?B?T21qK0NEbSthb2JpN1RIZmduNVBjWTYrdzJMU05oMnFJVmJmSTZUK0IzQ3F0?=
 =?utf-8?B?NHFEVXg2cVBQazgyZnF6dDFtRjdVaHdXajE4dnAxOUdrSzFlNEZGdHRnMTVK?=
 =?utf-8?B?VUc3TDN3WWV2N2JGWVVGTkIxelZCNG9LZU5iTXdOV1ZGRVFqZ2VyUG1ud3BR?=
 =?utf-8?B?Rm9Vd2VKTXpGbGdNODE4clZhcTJhOGdwTnVRcUZEQ0Fsc3Jld0dPMkpHVnJK?=
 =?utf-8?B?bm9xR3lYaDQwTzlETmNXVkk4MVdWSU9FS25zWXQ5b3puTHNmK1lZWnRKeTZG?=
 =?utf-8?B?aklHV1FRcGhYTzBibFhGdUZFMWFBdE1KMm5sK2c4ZEVDTkJTbTdGTVlYT0hF?=
 =?utf-8?B?NHg1UE1YbWFWRExLa3llOGxHMWxvejNHaVB5Q20zamYvQkFhVGgwM29iWmU4?=
 =?utf-8?B?UHo4amxBcUNRTEJWb1hEZTArcUJTTElOanRwWHhpNDgzSlhYZkk0ZFVPTHFv?=
 =?utf-8?B?OXRWTWNnOC9zcCtyOUFkU0UxWk1PNHkrd2U2NFhPTHV5aU9Kd29mWDZoSVNp?=
 =?utf-8?B?YjRJZHVmWjR5ZzI3aklVWUlvdVJ3S0NaaWlVMkZUcGh6dklQZUg1Z1RERHMv?=
 =?utf-8?B?bWJBRnJHN0ZrV3hNZDhFK2hldXVyNjFNeWZmZVM3bzY1cU9tZXhjbEo1R1o4?=
 =?utf-8?B?OGdST2J6UER5K0NUdXMwY3RrWW9rUjVIeXFKVkJqaFpMc1QxTk9qVU5CZm13?=
 =?utf-8?B?UmZzUnZUMENjYlBJUnlwVU5xRldiWDVXL1VkSDh4RjJqNU9EYTR5eU92MHdQ?=
 =?utf-8?B?TnBMdmZ2M2lLR284R2ttMHR1anhjMUFzbGY2ZEthNjV6NFBZRlFOdnpkNFpH?=
 =?utf-8?Q?p9nXFu6qY+ka3NRYM16N9YQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbad686-aab4-4503-6233-08d9aadcaa54
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:44:58.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjEmyCj/bKf81ljpQVpqTyBxAmsM5f0un9/yqzWydj2hmEacoqeuPEvlH0QpPhi6K5VVCZaQ+qGEy8GVftMvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3045
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/15/2021 7:49 PM, Prakash Sangappa wrote:
> 

> Here are some use cases received from our Databases(Oracle) group.

Thank you Prakash for providing the potential use cases. This would 
really help with the design and validation of the UINTR APIs.

> 
> Aim is to use user interrupts as one mechanism, for fast IPC and to signal
> target thread blocked in the kernel in a system call.
> i.e replace use of signals with user interrupts.
> 

Mimicking this signal behavior would likely add some complexity to the 
implementation. Since there is interest, we'll work on prototyping this 
to evaluate tradeoffs and present them here.

> Following enhancements with respect to sharing UITT table will be beneficial.
> 
> Oracle DB creates large number of multithreaded processes. A thread in a
> process may need to communicate(using user interrupts) with another
> thread in any other process. Current proposal of receiver sending an FD
> per vector to each of the sender will be an overhead. Also every sender
> process/thread allocating a sender table for storing same receiver UPIDs
> will be duplication resulting in wasted memory.
> > In addition to the current FD based registration approach, having a way
> for a group of DB processes to share a sender(UITT) table and  allowing
> each of the receiver threads to directly register itself in the shared UITT
> table,  will be efficient. For this the receiver need not create an fd. The
> receiver’s UPID index in UITT got from the registration will  be shared
> with all senders via shared memory(IPC).
> 

Sharing the UITT between tasks of the same process would be relatively 
easier compared to the sharing the UITT across processes. We would need 
a scalable mechanism to authenticate the sharing of this kernel resource 
across the process boundary.

I am working on a proposal for this. I'll send it out once I have 
something concrete.

> DB maintains a process table of all the DB processes/threads in the shared
> memory. The receiver can register itself in the shared UITT table and store
> its UPID index in the process table. Sender will lookup target process from
> the process table to get the UITT index and send the user interrupt.
> 

Thanks,
Sohil

