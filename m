Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6441A2E4
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbhI0W1Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 18:27:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:1213 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237444AbhI0W1X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 18:27:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="221371277"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="221371277"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 15:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="537858223"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2021 15:25:44 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 15:25:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 15:25:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 15:25:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 15:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM5GZ+6nEnSIbA3VpmddhAOH3K7D+YwDLsRyFA2ccwlZYEjiELGzQ3UbZ3nvRO3QHYCm3F9qBBbcau5wSXmEk3psZB/bVfroYL0ZgmXXTvw99AsFf0wA9mEh08i0OjDSH3WN0xxEegnlRttfUxLkQWAxN48J+M9hvXlLAwbkSlKTsS5APsTePzFMfRTMHWa7I9Z6PKOolempeO2wyDylnZCawrcf8flVzgQQ9qSf0loHbczbxexpju0h+Bw1mdP8zKN4Py3rHO3EIFAPVrWop31C6xj+rRwQ56TLvwR8voUIrFN/3cOKMYSznSp9rYrmh2kkSwntV0G7fPO+vwRISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jFC8cAMbmiKOfo+5hFTaZbvbT+KDgNhlmzcNdVt3vak=;
 b=Dfe45+Fd2UQPAE0fquREaim8ps+XBNdx6LgNdpz7S8s+elYGNy/TUnhBJreW1zttgBzWYU18Fphb+t9rr7fwR69RkI/yU5ByzTYfgFzjYtR5hlpDY85UfPG1xGm4O7K4ZxmH7GJbJVv21INKMB1AHP9/T69OoeNORnXCy3N9UMiXq13nnQyYfqeb7rthElWwyC3b/Z+P0YJZFmxw3moPZNqF7XX2RvXYoKqPc8+Wb7oD4loWTFv4itLTtB/9oeVfJ9kT8Oe81kwRcUhFwa5u5sVv2svE8HdWIC6VT99tlvpqIOqqibR7E/B8l9bDo/7IWEjgkONvBqYSdyNLuilhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFC8cAMbmiKOfo+5hFTaZbvbT+KDgNhlmzcNdVt3vak=;
 b=tNnpTUg87nLvAQv9xf3iAfIzFeL7lPD3n/nHWjeumpUrHuMWbQpFjijczlCJOfFxOAbzEP/rJZ6lGG0G9ruGpxCxbhzIrxIZauy34IyGHuS+kN8E7uYgV7VHrnz/oJtkaAj5OPeWzvM/ToOZWxEtocPWInEf/xPMUJnACmIEHSM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 22:25:36 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 22:25:36 +0000
Subject: Re: [RFC PATCH 04/13] x86/fpu/xstate: Enumerate User Interrupts
 supervisor state
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
 <20210913200132.3396598-5-sohil.mehta@intel.com> <87ilyqgbvn.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <c364342a-833d-0c68-c496-97a843e512a5@intel.com>
Date:   Mon, 27 Sep 2021 15:25:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87ilyqgbvn.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR06CA0026.namprd06.prod.outlook.com (2603:10b6:a03:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 22:25:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43639e69-4f41-49dd-8515-08d98205ba42
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5214A65486296D7F739C77FEE5A79@SJ0PR11MB5214.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU+CTkDT0DKofFNSYenGpIIv6Lb3AmWAoibanhp80+OIEu5eCVFsQ6wsDF/iKR117TtYYdb80GblBtpZq5RgOPNIxP/ZtunkGPd9zhU5HUVnfUFh5NAB89hU5N4ncxnulyhWhWW9LSXIH4heMyluHmiOHa6PhTE+dmS7eDu7N4XMr6y5Ye8KYLAp7yVPDFslg6uYCRQ/+QQidtSTsKoyjasMdrIv0uOXMhSChWHTTFkahgljCuPs8lOMQgjFvAFTbIL8L3nTBJcCdcTwfMbESL0tWZsSOYQwu0KjkiBdOM4LoPfk9TTr130NEGeR+C4Y3VSOpC0yew3aTc2W6F0sRxQgsa+hXrBo0aQXuYxOz/6L4vb/miOIOJoJfQ8sA2BCWOfxWqARsJXwR3b0wxIYr2EgRprUIwWcIfKp8hQywm8DJhVpacTz7GcjMEHqUuAoIs8r0eqduGQFaLeCCceiXmlXpe7aok9nKtSmeheAvpV2NG5iJTN18mCkkcnQIq4QkZCUbXwJX/C+FJMAoO6R5s8yVcyIvWcNc9LgRQTsHQnhJ3nVMhnjn3P6tX6GKlUzdK5uK4s0TPgjVq2hfMwlzcurRl9jQax2fdYMj/REiBYLquDiW0TlX8PSAnhWKafDXUYcLNjd+q/yCK4xsdRl0ExKkYDQhIfVDQiZXVBX+zqNmTGki7IBrkAfModvESXelDICkOlLST+ku8C1Y2U0cDAz/THbjNoVYvoF9IPe6uo9lCru1OYoROFuFzMl/cTt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(38100700002)(4326008)(6486002)(66946007)(8936002)(26005)(5660300002)(2616005)(956004)(508600001)(186003)(53546011)(44832011)(7416002)(66476007)(316002)(66556008)(54906003)(16576012)(2906002)(83380400001)(36756003)(8676002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxZajIzbjc4eTJUcGkrNDlnbno3U2U4SFAwNnJNM0k3QWp5TlhiZ20xc2Vw?=
 =?utf-8?B?d0pGcmNUSWMyOEpZVTkrMkJFU01HemFVdmtJNFNOdmtJNDQ2eThpVkNaTUFh?=
 =?utf-8?B?TmhPZEt4Y0JxVmFWSnM0TXR4eERobXVKak5IZndJQ21XZisyZzA0cGxpdkNS?=
 =?utf-8?B?UHJENVFtTDRPQVQ1UHdxTFJXRTNESC82dXhVQjNOei9NN0x2bHBUSkVXdWY2?=
 =?utf-8?B?Nk16eGVpa3N5SldpVloxTkliTURBek1LU0JiTitQejM1ZjVhd29rMWs3M1M4?=
 =?utf-8?B?UUdsWFIxVXV3eUJSZElFVEtSNEp4N0xWek5SNlFZVnlnRld5MFdtRjJzZnZ1?=
 =?utf-8?B?Y0RiNG9xb2loNlhPeUlOMGlpOFZrRVpFNSt2cHN6ZU9jSnRvdFBDd0xKODl2?=
 =?utf-8?B?WERtRW12MjdhSVlSWFVxWlNSeWhUK09MN0VQcG9PVWEzT0tOOVJOYXZiZE1i?=
 =?utf-8?B?amJSV1NxU1pXMk9lZXNQTmZvSjM0Q29PRU9hV214ZTRBUTRreUYvZnB3SVho?=
 =?utf-8?B?OWtUaktub1BTU2hYQTUzN0VqaC9sT29VM28veDNqTmR5UzlKaC80SnBkaTdM?=
 =?utf-8?B?bWtUOGt2N0llWWIrM1FabTBYZE5taVFFZU5DMC9rRzd1ZldpdDJUeC9reEwx?=
 =?utf-8?B?b0RsY0U3Mk9zeWxJbmxQTTI3N29sVm9EMFZ6elJaZjJ1VjdiVjU4cWNRbUhE?=
 =?utf-8?B?ZFlYQVJ3VG0yWUgvV2g5a1NEZGZRZVpYWThrZXMwQktjSyt5WlNWOWVJVkZI?=
 =?utf-8?B?VDBRUnk5YmVIVmhQajNwT0NHNEpBcnpUNHVrTVVYWDg0SWFaQnM4WXNzWXYx?=
 =?utf-8?B?N0huZEZBQnFjU3YvYS96b013cFlzb0hjYXF4UXp0ZHN6N08vSGY3WlpPTlpH?=
 =?utf-8?B?eHhleGUwTVlxMnhlMU5qZ29YNForR0R0YWZuaUoyWHR0d1FONGpxSXU0ajFr?=
 =?utf-8?B?U3B3NWlLZXY0aWxBZTZyaExLdFhpSHROdjJPaHJ0MkxXVnRVbktzMWEwRXJE?=
 =?utf-8?B?ZndycS9VY3I1Mk9JaHM3MUNCRitLWXBpaW9UbDNaY1FmZUZhblpiR2NaS29O?=
 =?utf-8?B?bVU5NnBrS0R0NjhLWDFyb083ZFBScEkvdDlKSXduTytFUDlsd2hkRW12OEtJ?=
 =?utf-8?B?aEo2VjBrZmhkbUoyRTlsZmZuandDQVJETVFxZGZMcmdCWCtDNGFZTXMwKzVB?=
 =?utf-8?B?K3FyMVFzbmRJd1JQNHI5WGEybDQ1eGM0Uzg3WlQ3ekZIWGdmejJjUGNMWVRq?=
 =?utf-8?B?d3FhS0RMVGgrMTI2NmpGL3lNenFLVVdLTGxsRDNQY3IvSmJiUEJwbmxsSGxG?=
 =?utf-8?B?OGVpeGFTYnN2QW90TjYvS1M1VXB5VzJWVlpDTEJJdlVnK0hPRmc2QkJqZy9w?=
 =?utf-8?B?TVlvTFgrbHJBS01xQUw3OTBUK3RrOUo2V0NZb0JvVWpvRXE5Q05LNVh1dFZS?=
 =?utf-8?B?MjBOMmkzaGFTTldSZTZxc2pCZmVISDhDQnRxVDR6RFBkRjA0bmpXS2pXY01p?=
 =?utf-8?B?d3RDa24xMzIvUDJDN2dHNjlUN2UrMHFEZW1HeisxWTFBbDExek1JOXFzZ3p3?=
 =?utf-8?B?M2gzTFJwTE5RTFdNcFh4L2VHZ2JHOGdFb3d5RTYrMG9TSlFOWE41eUFNNjFa?=
 =?utf-8?B?SWJKVXBRNVNCVnBKU3RJRm02ZnRNWWJ3ZU1pdmNSZ0dsWDNkRXNjcEpCYysw?=
 =?utf-8?B?UTB4cnJJSVl5YTczU0lMWUxnUkQ3WXVIeHpMeUlVbFhLYVg1UTdzTndtY3Fw?=
 =?utf-8?Q?eZGJnQaqjSXFjM+Cxeu/w8TWwrXzk53Va/kAU0R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43639e69-4f41-49dd-8515-08d98205ba42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 22:25:36.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri+v75fpmOlxHFjtxpypDXDapNNYBrDhjJuXbBs45a/nN7Zhe7xAxpZTeEnzklN3oUjW8t6sgArxm2cbUxRaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 3:34 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> Enable xstate supervisor support for User Interrupts by default.
> What means enabled by default? It's enabled when available and not
> disabled on the command line.

I'll remove it.

>> The user interrupt state for a task consists of the MSR state and the
>> User Interrupt Flag (UIF) value. XSAVES and XRSTORS handle saving and
>> restoring both of these states.
>>
>> <The supervisor XSTATE code might be reworked based on issues reported
>> in the past. The Uintr context switching code would also need rework and
>> additional testing in that regard.>
> What? Which issues were reported and if they have been reported then how
> is the provided code correct?


I apologize for causing this confusion. This comment was added a few 
months back when the PKRU and FPU code was being reworked. This comment 
is no longer valid.

>> +/*
>> + * State component 14 is supervisor state used for User Interrupts state.
>> + * The size of this state is 48 bytes
>> + */
>> +struct uintr_state {
>> +	u64 handler;
>> +	u64 stack_adjust;
>> +	u32 uitt_size;
>> +	u8  uinv;
>> +	u8  pad1;
>> +	u8  pad2;
>> +	u8  uif_pad3;		/* bit 7 - UIF, bits 6:0 - reserved */
> Please do not use tail comments. Also what kind of name is uif_pad3?
> Bitfields exist for a reason.


An internal version of this used bitfields. I was suggested that use of 
bitfields is not recommended for x86 code.

The name uif_pad3 is really ugly though. I'll change it to a bitfield 
next time.


Thanks,

Sohil

