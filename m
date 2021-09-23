Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03000416872
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhIWX0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:26:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:41208 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235628AbhIWX0M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 19:26:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223993374"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="223993374"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 16:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="455299727"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2021 16:24:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 16:24:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 16:24:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 16:24:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 16:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6qKwodXDE6RgoKe+rCskahxA0i1kutk04dGad1/Yn7cgl2qGCOgGcCF0MwaLG7Q9dr8MLwxso9dI5HMb3LIktmjZvv62bYSpx/78eLJqws3Kzhjcr54bzkUxeCTe+03IASIy1ewb8h+yDV4U0wT4zgaHoxUFRRE4apgixvvU3LEiUavead6jXSjNlMgxR0hHUtfFYdsGpP/xrqkhMaYsPBwopTWzWnv7fkGBTRvLo5vuqLo4MEP8hzf/EriGg2WRyt8vQSSgt7L4RlFttlyDKOyqVWkvFVCJ82FyGFxfQ1uX6o3Zl78QCdL4BA400VP9UcqF8lJoWaDuTbls8dAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kg4vl/IAb8QQ9OosI9czN9yYSzQKINp8nxvToMtmeU0=;
 b=kbiAyZ7YQoV0AJZ4isErtBSIhnrNF36lzIN5jkQkPog7oE/ngK3w6a4xbWpTKNwIKBFaxBQcKykKKKs/yCohA3HSKXMIUL8ScQfFn2KuD19Tbwuozp6Z0c3oa7Io+vWxTe0OcEaSlanN2VFg3/bXjULJCBoC7SzniS4PC1b9r5/XOWRdSNB+brg7G+Yk+rg9+Jwx+cICD+dEQy4GwXQgt3pJKuEuZygG81z1QrmZVJlo0YVJ4R4fqx/b8YuERtY5V6SAJUIVDSX8HR5cSzL/dbh+ZAR5eFVoYJxzuyyaqnsJ6/3nK+uBk8UdHsOw2Mkmas5Ba9NaEaZWmMYxTX0D7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg4vl/IAb8QQ9OosI9czN9yYSzQKINp8nxvToMtmeU0=;
 b=eYnzgVBw5EvL1LJlLZBSXxhjyrNFV+/QzT2l50bs4YEXiUyTpX1lR5g1puLtbZGYJWRXIJj1iDEWl3aiWs8VVWsSdXwX8qr9mMPWKhL7YBozkj3wcgQ/GsFmgXs2GZ161b1Ip/qsNqr/K/yW0GlyfqI/iEQnwljUz9R+4sr03CM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB3864.namprd11.prod.outlook.com (2603:10b6:a03:18f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 23:24:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c%7]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 23:24:34 +0000
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Witt, Randy E" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
 <BYAPR11MB33203044CD5D7413846655F9E5DA9@BYAPR11MB3320.namprd11.prod.outlook.com>
 <YUxwuR4V+kwk1L34@kroah.com> <YUyKqmKR0pOcP/NA@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <469f2dd7-15c5-276e-49ba-93e1b78dd9db@intel.com>
Date:   Thu, 23 Sep 2021 16:24:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YUyKqmKR0pOcP/NA@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:a02:a8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:24:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac828ce-586f-4d8f-879f-08d97ee94daa
X-MS-TrafficTypeDiagnostic: BY5PR11MB3864:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR11MB38643E29436373D82A5AA754E5A39@BY5PR11MB3864.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQ1lp8h3wLnwhH0fL8vbfJL4u1xY75MjJcDAe+cNQOh+evBuC/ArwELq44GvXIPkT2oLpHem+eoiQjnMijhCCeR0sskO1aRmihcRE/XQQs4DiYo/+F8crTDNZu7fPkYLWB3j/h+oTzNvgjY9mcHSrXC8KjqEqLsISnxvJ5Bgj7d+jB2DYtI2GDCoOAWrLLFLiy832pp4lwGM62mVhHKcvobkdzC2v/otJuAYaksYiecIJCePG6TA9ZycFAOOT8syT5T0jP3+dNZGIFmRejqx2q+FK5X8j7ka0ot0jalPalpRHN665IzqpD2sm3b9Gwn/av3TSvbePfgfqHBSblZY7MAoMbDT4QEDvDhdnXZBbH2TFhFuP8IoDfshs+sNpQjwd3eDxscLdMR0tq8iWwk8Tw2noU9syfl2t2KFQhOjyi5buMVdaDB0jLjky2ZpnE4lo/JtgAQsNYhHx1siiQ10oFkdZqm5GIIOrPW1Oe0BNYor+botBkLtZsgPjmL4fglTPruD8udrZ9Xooy5IC5J1PH6yAXWeoyBHafXeQ+BuYVTFhAFSl+8EmSJiVPU/piCRaOq9xmC4KW4gwNeBJcszIMov9GvZmENOi5j6T2oPb3W4AX3qIEiX3S4LiapkTb/yLSerxrGXiUqZIi4B2VL4w3o2B0Fl+2zFaiaWcANuonTcAU+u6Ec0ZrboKlrLuUaW//j6kALZiOfFVi122n4oTsvghkziq1Kz1995dqQvrjrBStAB8WW9LmPENROYglRniswC1NueZndp4toEifI7uXtvKw+XgxFaVzHwkNSsBjUi/UPnn7QzDLE4CLWISGOJ6rhHAH5OwBBD+qF/1Q7lMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(53546011)(2906002)(5660300002)(66556008)(316002)(44832011)(966005)(8936002)(16576012)(31686004)(6916009)(31696002)(4326008)(66476007)(66946007)(4744005)(86362001)(7416002)(186003)(2616005)(54906003)(8676002)(508600001)(26005)(36756003)(6486002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lDWG0vMGxSaXpYZk1XbVR0aXN0cmlsRjN0Y01rWWR2NEVlQzRpUzltODVZ?=
 =?utf-8?B?RWRoZDFXbnFtSDEvR0ZyOFV5OUdBc2RjOElLc01CV0RINVpFTXY4cW85elc5?=
 =?utf-8?B?WnFRTVVpenRrWEFzRVVXTS9pTUp6UmRZSy9DS3I5eDFrb1BTODhjWmM0YXpB?=
 =?utf-8?B?ZDI3Z25sWTBCZHFCT3VyTnU1K2hYcXRPem5GZnBMT1NXcEpFOUZhODlqL3dS?=
 =?utf-8?B?bWxTNGNrTTNhd01CaEltUjhmVnp0Y0s0N2JEaGl3SjNhMTVwbG5IcFI1RUJl?=
 =?utf-8?B?THhVa0hCNUZNK3RUL25UZVBpME9mdDhnaG40bXBuL0puZ29GUG44cTdCQytG?=
 =?utf-8?B?Q3dkZnJCdndmTnV5aklkeHFSdDBuWWxJTlYyVTI2YXB0WTNCOVF4QnZORnB1?=
 =?utf-8?B?WjZYYlczbGNLUDRtdGU2dXFxNjBuOEd3bXAvVkxCYUczNDlaL09PK1N3Ni93?=
 =?utf-8?B?cFVDd1pyK1pEcnl1ZkRReXBzK2FjUlE2VUN0NFZ3SHZPQTlWZWhEeE1paUhV?=
 =?utf-8?B?SDgzWjBDZHVXN05wVFE1NG5ENFl4OHAzcEhWRnh3TlorOHo3WFJNVEF0MllL?=
 =?utf-8?B?MCtFUkZXYk04K05kVTBvdjZMQ0ZrcXdsbWVubEM5VTJvVldyQW9oYmJoWmZ5?=
 =?utf-8?B?Tzl2OHR1OXVUaDdPQk9KbXN0R0U3bWFid2tiTGcyRUNZaUlrWEZFcUxrQ1dX?=
 =?utf-8?B?YnQyTytrM0ZWQ3U5b3pIQkNDd0xVMmpqZXFSbm5tVDk5eEtyQzVjSDNyeEJz?=
 =?utf-8?B?V2dvdXdWalVLTUpOZ1Q2aHN2RjUxSzB5WXMyOExrdS9lUVZaSXo2VjEyQWFv?=
 =?utf-8?B?V2hRelorV2UzYVBsNVdPUXU4L1NZYklJVnNaVUc2aUdMdFhEdCtacFQyeGFs?=
 =?utf-8?B?TXlLL0VrS25nZmFnbmczQUFRU3d1VEVjRTVMZGJTbUF0YkNhdGkzMWxrZWNj?=
 =?utf-8?B?NWhRUENJb29VWkF2RlBLWmxVRk5MWFF1V21oU3R4U29sNkF3MG01WHJrR1NI?=
 =?utf-8?B?bk9hSDBZU0dlR1VXVm14clIwYlR1MjFKamt3dFlQV2JPTTEwbkNmQTRUL0gv?=
 =?utf-8?B?VEZqNkNIRTIwKzRVMVpEN05IdmxEaDdzQmxGNWJGSElkTVhiM3kwMUhISmUr?=
 =?utf-8?B?NitsWGwxOGMrYTlHMnZuU0c1cTAxb1Vtcnl5cElsMGkwZFZhWE05MklEWGZH?=
 =?utf-8?B?UDNWQ3dodi9sUHpQeVQyOEJkYUM2QWhzUmxHeUR1ZnMxeHVVTkdrOGJBcFVZ?=
 =?utf-8?B?RmNLTUlrbGVHQUN0VlVSOGZ5cXBMaU1Bd0NFUURPdjRTenVoN2llWEpKbHlr?=
 =?utf-8?B?S0d3Z3N0OFkwSkQxbUN4Vkd6SUxrcHE0MHlHUm96MXd5NEJyOVZzWWdUZHZz?=
 =?utf-8?B?cVNkNmkrbys3dUtkdHVXc3JNVjFlNGJEeTQxU1NjTjlxU05aOTh3YnNsejdL?=
 =?utf-8?B?aFJLVnJLZ2JxdGRzaHlXUGovUVVsaEt4a0pHVkVGaDlBdHEreXpkVEloMEpk?=
 =?utf-8?B?eGdSY1J6MjJXUVAwREZWZUxLTTJHYVFMYUE1M280WllzZnhYZVA5bmdaVnY0?=
 =?utf-8?B?QnQ2M01wcE5ZaUhESHBVdXFuZi9sTnR2TTFTWEZUVkxHYTlJaEJUZm1pTGJB?=
 =?utf-8?B?enBwMU1MR0xBbkFTY2daS1RnVWdvS0F2Y2VwK1J1SVI1VVdnTzQ4ZVhLTVdz?=
 =?utf-8?B?ZzJVVnhNRUtqU05kOVFMU2dhMkVIR1JBaWlnUFRHK0dTRjlER2VxVGdwakhy?=
 =?utf-8?Q?PsIhOCmZL63TRC5qMLeohbHzATAWav9925rgPDN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dac828ce-586f-4d8f-879f-08d97ee94daa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:24:34.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn/mnVKNMcc5VcGGpGPztaua5/hFSP6MW23XnelR6NbSeGKojr9GeQhDh8ySo1TMZL3qqyCDm8+xnBc6PCc13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3864
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 7:09 AM, Greg KH wrote:
> Also, you forgot to list Binder in the above IPC type.
>
Thanks for pointing that out. In the LPC discussion today there was also 
a suggestion to compare this with Futex wake.

I'll include a comparison with Binder and Futex next time.

I used this IPC benchmark this time but it doesn't include Binder and Futex.

https://github.com/goldsborough/ipc-bench

Would you know if there is anything out there that is more comprehensive 
for benchmarking IPC?

Thanks,

Sohil



