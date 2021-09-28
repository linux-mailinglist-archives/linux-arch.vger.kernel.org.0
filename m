Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82941B87F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 22:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbhI1UmV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 16:42:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:19533 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242790AbhI1UmU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 16:42:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288459877"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="288459877"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 13:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="478888649"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2021 13:40:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 13:40:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 13:40:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 13:40:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOdNVVX/kCuqG8pQVYXbolNJ8qNgiA/Dh/pcVxBoAIW/iqPtggrC/5hrlZMHdIu9fwmOez+QNbFfP1Ny+oiBLPgidsmA+1uHfes54+skW4Jk+p87ePTqI3HSAO3yiEkJ5SIpViIGUZouyvZGkS9cJoKQrWrAhi795vIzE5YdAwYc6GDQtN/er5wsCk6+El4hRLYQIaQxPaehteKFMGTGOW2YvUIgPsSXKXQrJkSVSwZA5zC3nZ2hCklXdZAh0kMAyf6adIc05nllpeEpjAzBQ1kWdKApEg3MKxjmb6orIm88F9gQulQ1ZBix43teppjm+kVPPI/a1+6LyoPMkcS6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UhTz0Efumml7hzMHNzeknCaWUW/LLT9pOLmFFzIkizo=;
 b=PcVnCvJrYFh9iS4a9JJ6QvH0Myn8nEQser4oQKyBlD6MG26iwKH4MpHSkJSqhHi9D+9IRhKWGMQx/KjSDp6Rr7y0MYuHhzc/uNP2PhEIEZaQDuNzqB3IAB3vIHOlj+YpULVpj2DVrTj0AM9RYuvbmfgMqf/YqNnYFW4djsBscTqJ/2y3T7QLttjXz3mgqqrFVVxXJOV1S33mavvqhb/vo/NkhALtcHdlLIpHzM4gXKqtcARzudFbJydVM4FYoF8CaGKlu4FAVDOUgqVuTwUOhBHvGf0MGoEZOg5F77ouuOC8Nz2axB4gR4CRKPYO2+W+qszpnXunRaTKlf0q/+/JxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhTz0Efumml7hzMHNzeknCaWUW/LLT9pOLmFFzIkizo=;
 b=WU07+UB1ZlHNX1AbBFGLPsE2BVKPSPsZMu81XPGDDNlfvjIMdbPWiVVbB4Y5ULe3L8nHvbYtwqvEu60TU7xCgnIfk7Ji2qpHnlNxFhg4PN3NljJ3W8eR2kQSEp9XhhggP/2rbePc7z8hJAPsMW4L4O+a49/C2Qvh2EDWmHWUdIs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB4040.namprd11.prod.outlook.com (2603:10b6:a03:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 20:40:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 20:40:33 +0000
Subject: Re: [RFC PATCH 09/13] x86/uintr: Introduce vector registration and
 uintr_fd syscall
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <87wnn6dzzn.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <c2b50159-836f-2fd4-e469-938c9dd50166@intel.com>
Date:   Tue, 28 Sep 2021 13:40:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87wnn6dzzn.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:a03:100::41) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR08CA0028.namprd08.prod.outlook.com (2603:10b6:a03:100::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 20:40:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 947f314c-d618-4e7f-4b40-08d982c0378a
X-MS-TrafficTypeDiagnostic: BY5PR11MB4040:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR11MB4040E0CAF398D7D80803574DE5A89@BY5PR11MB4040.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h5tczE+DBA1BhKiB47nOfNMT1kEl55N4XfwYQBfQMfza/YZeX3Q1DRdsJeE3xPZJH2gy6AnPO9D149XALgnnmrJ6Q54JbjnaVaJmpzICMpAniWsBPJ/3Tg1wriHbjIbu7aMWNQ42JF/Pe8f0fiQZ5f2kgZzhz4FoXJk9gFNVNKvGedVgbKCFsMfG1Z8OkzKVFPh0Kl82tKM1xwkjdcGsMTHh+vgPManLlVkPnQVRfNAvGlKLLmE/P2xOPiSow7Yp8xJLwxOuvI9mslRjLuxj6jeFg62Wo6xGA7RuU/Z+RwUjz8Ip47bN2TXt6RDja1dlmWty36w8MQ0RDOdkH2uuTMh9G7VeDIL7DcIyYlE+dgd1QQVVjfgg9V3ukC95D5CRfsbdxwWORBc4YuMHuGD/F6DOx4v96c/07ynbDdxHbDba6HwNVR0SLPkGMa31tCCr8Cx1goseS35Y+DcsDePwFlt+j+1hSPzEqCjWLyfo+0fuRlMcKSBuzwDk3k6Cp9W0QdcJxphwjPCXgzhKcuEbFN/nUA8MAzl57FR9WF8oYrHPVoYSRFkr+i9RhsXnVMNpUeGkWDJfXid0Y+UPaOzaZ5WtDpq4B22lbImayeSdbpZustJ3tudy9zUqthBQ+UquYbZ3E/4cJB2fnYpYGWJPcB8yRRMfBn20pHy3vovHbDCM9J+FfD39dOIvUQhK/t3f+6xRNj9oV8gPbGM2mcijZu0WYIoEKeFOJmaxgRPFwmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2906002)(16576012)(38100700002)(86362001)(6486002)(316002)(31696002)(31686004)(4326008)(508600001)(36756003)(26005)(5660300002)(956004)(7416002)(53546011)(66556008)(66476007)(66946007)(186003)(44832011)(2616005)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cStseFlTZUxrTm8rSlI2WE1wUDZjT3EybmNSYTdYN2EzeVByNjdsVWxyV0JE?=
 =?utf-8?B?OFd2M0hIcG1QOGVoYnNUYTRPWlFheGNkbVJWcVV0SWtiZXdVV1ZaTkFuaGxk?=
 =?utf-8?B?OHVjVWUwQ1ZVN004Z0hDVytnaDFXNUQ0TmlGRFZtaG5HMnpkV2pOTTRTTnZu?=
 =?utf-8?B?YTg3RTB5VWV1Y3JaV3ZTMmpOZzRRUFp3RnU0eDhlZENYVG1pZFBqaTAyOHFL?=
 =?utf-8?B?TWROOVk0UTliaFdYVzVhZ00wSm5HSUFxdHhXMjJ5NUVPZGQvSTlFc0dRZjU5?=
 =?utf-8?B?YkEvMkxoRzMwWmxtU2p6MWJYSnpiV3BxaWk2NWsvaTRzT0s5ZVJCakNIK0Q4?=
 =?utf-8?B?ZkZrcGppTllmZ09NYStoWU5Ob0R4Tm9LbTF4QTZaRjdJaGJCMHlEdW5nTVV1?=
 =?utf-8?B?Q2pSVXB4YVlNZmk4VWdNUGpzTUlmQVRtUlhzUWpWOFo1U0JtY0xCRXNKeDNT?=
 =?utf-8?B?ekJEd1VlTzRHNDFnLzRINXkxa3VoOGpZQ09FVVNkeG1IYXVwWjh3blZpWmxh?=
 =?utf-8?B?MTZ6OElNOHJTWXdCYlJzeVN6RUJpQmQvd2xXYmY2Z05WWFFvUmtXQ3pyWmt3?=
 =?utf-8?B?eHdtejZ2djVhdGF6R0xqTDdrOVNSMHJidnRFZHQwbngxdi9GR1R0UFhwQVpB?=
 =?utf-8?B?RjZ2RjMxK3Awa1RmU2NwZ0l5NVRrNHZZeHF5ZmlqL1Q2UXNrOUVDOWZRWXph?=
 =?utf-8?B?d0VUQ2NZdytqNlhuRk5oTi9RREJENFZHTXNJZlNJSndpTk9DTGhYMXdadVRv?=
 =?utf-8?B?T3IySWRWcnRQRkJLcEEybVdEUzVHc1lxeUJQOGptM2FtUkdYZS9PTVdtSGZs?=
 =?utf-8?B?ckp3bW54Q0FNLzQ5Wms0M0ZzSlFoeUlBZVVFSmFPZU1haXdhbk9ueHJFZ1RI?=
 =?utf-8?B?d3RkaC93bkNWZGZtdHZXOXF3NDN0bU1iQ29qbmFHSVBZdVVCcnFTUmNrZjlt?=
 =?utf-8?B?TzFkYUExeGo5YTA1dVFEaEZKNTkxdzJQZTVuRVFHZXREQUVXVUdiQStLUUND?=
 =?utf-8?B?QTZkdUdCcmd2d3lBS1pBVVlJOEw2dWpLSVFwakNWRVFjbUwyM0ZZR0VMR2lF?=
 =?utf-8?B?bzVEVG9SdnV4UEY4cnJ4TlhUeGIxV3ZYNU5kMWVvVTUrUVpneE9qajMvVUsw?=
 =?utf-8?B?eCtyOEFWZ0JYMnRVS29kTUQ2TTBsUzBaNXlTQVUyUkpRTG1oaWdUUjFXbzJV?=
 =?utf-8?B?ZXNuTEFzMTJZbUNzMUFXWXlYcFFJdmlwSitXZzBEbnltNTFuWTYybTg4dDNz?=
 =?utf-8?B?QzNZZ2JjZE1JeE9RYWxoWGNtS2w1ZW5EL2htUy9ZeUJHTzNwVnlTOGJ4bVFk?=
 =?utf-8?B?Vk1BNzFTYjdPSnNhZ05ma09HL3hSMVZNMFZpMGx3QUV0dkJuSjVwMzZNaW5K?=
 =?utf-8?B?OUFvN0E2RkhYdWc5ZnJuU3B2eHo2Kzk4VEZicXp1bFFYaEFYQVNWK04wTmh1?=
 =?utf-8?B?aWEwMytJZXkzZGZ2b0Q0ZEpKWkdZK1VMNE4xUnVOYXlDeVFvWEFyOVNDVUxY?=
 =?utf-8?B?NkV4KzFDMTg2VUwxZ0Z2MzVzTDVqMGl3UDYwT3FpOStnZmNNRHIwQXdiNVpD?=
 =?utf-8?B?UjRkenJzWVUyMi9lbVZ2RHg5bkd6Ty9tYVFPalVDMTVENGxBKzE1bG9LY2VG?=
 =?utf-8?B?ME1jMXlyclg2ckRmT3NFb2VsaWZ0ZXg2WXVORVkrQis1THRVNFcySGdacmFU?=
 =?utf-8?B?MStLbnY5RlFwREFneGZHYnNaeG83MDNzdXZBYlBzaUlneXAyeG9XVmh1SUJR?=
 =?utf-8?Q?rQ9jLa+8gz5ZRKAXhpX1NTiHxkiQuFcOU7XL1Ze?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 947f314c-d618-4e7f-4b40-08d982c0378a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 20:40:33.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EviMVkDE959sS3cwLcOB+uTRiUU/WgApVodLeL8hJheQqxIcLjN3pG7kyRKc6sprgInYGjO4yMJPhqIEo+wLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4040
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/24/2021 3:33 AM, Thomas Gleixner wrote:
> If this ever comes back in some form, then I pretty please want the life
> time rules of this documented properly.

I'll document the life time rules for the UPID, vector and UITT next 
time. I realize now that they are quite convoluted in the current 
implementation.

I'll also fix the concurrency and serialization issues that you 
mentioned in this patch and the next one.


>
>> +	ret = task_work_add(r_info->upid_ctx->task, &r_info->twork, true);
> Care to look at the type of the third argument of task_work_add()?

Ah! I didn't realize the third argument changed a long time back.


>
>> +/*
>> + * sys_uintr_create_fd - Create a uintr_fd for the registered interrupt vector.
> So this creates a file descriptor for a vector which is already
> allocated and then it calls do_uintr_register_vector() which allocates
> the vector?

The syscall comment is misleading. Will fix it.

Vector allocation happens in userspace. The application is only expected 
to register the vector.

This syscall only creates an FD abstraction for the vector that is 
*being* registered.

>> + */
>> +SYSCALL_DEFINE2(uintr_create_fd, u64, vector, unsigned int, flags)
>> +{

Thanks,

Sohil

