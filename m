Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0A41F44F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhJASGn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:06:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:23676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhJASGm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 14:06:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="223618288"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="223618288"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 11:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="710069217"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2021 11:04:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 11:04:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 11:04:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 11:04:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 11:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4uTdiEAGPJuaqGLe2+xH1hWiQc6VEnD8XvD7RtP8Cejtji0K5kaS8SEJQS7P4vFkiPdRLJaBw1mRu6DWBX9DaurgM280KjXjH/wPqaaXw4oDoo1z5BZqMe6Am/pFp8l79pmPKUX7UaIuz2clgJXr2se16RXuUqxiKUePV1I1q0UtraS4nE2OZIC4Zst780iG1kdTiIg3C/ThAsSxMeZqJnvFyAfFb1sg8OwcSYwfQwMRMvBapR4nWKlGxFfAhvUBbHB1X+q2K1ryGXr078WElWsucOZosPC2u8ffurNkCdpUDs8wW/lvj2YcZ+a58ok5cjGnKLqFAdNqs4iZFpozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=694OsMqbNw+F1LYcy2RPic5ojPA2PXMo0xi79fzFJjU=;
 b=Kug/ygOJCt8qh1ZQv51Ll7zeK+EX3uGzQ3/ahBIxLRBfPG7cRvXlbf0A6wBV2740B5st9GGPVZmFwPPCUYbBbvNN6nmH9Vo5pV9s/83JkythmDurrjb+6wEMD1eN8wpnKy9aD5SlJMWd7EpGmcyVOjSYtmEEI40L5mPrnHGC+8hqFd0iIvHfXURx61Zk97YS3/hj5rN+5jWjOCLGv8SS24wk9ogzdcgt7cvSyw/LsPHufzql6szMiEF/gnBl8bRhftkOKC6Chxlww0+TTgMd36tWTKPQl9Lit9SGrhT+vEaJY/MwybHTYtZlQfY4Rmt+Pxmy1gYFDeF/EKz1BpVOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=694OsMqbNw+F1LYcy2RPic5ojPA2PXMo0xi79fzFJjU=;
 b=SSSAAArqFoG9SybfbgN8xALCJIf64j976PfRcXQvWQrR6ikfLh9OgWOx61XzSkx7vBQbPxhSyfPY9aLRHBc20VpOwIQPzY0mvYeZepAkJkELMLVU/MJJZxc1bHY8YFaLOF3nz7WUbQvI47ksIyO2eQqgndA3Ive8LJ4XZflSg/A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2936.namprd11.prod.outlook.com (2603:10b6:a03:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 18:04:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 18:04:24 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
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
 <c6e83d0e-6551-4e16-0822-0abbc4d656c4@intel.com>
 <fd54f257-fa02-4ec3-a81b-b5e60f24bf94@www.fastmail.com> <877dex7tgj.ffs@tglx>
 <b537a890-4b9f-462e-8c17-5c7aa9b60138@www.fastmail.com> <87tui162am.ffs@tglx>
 <25ba1e1f-c05b-4b67-b547-6b5dbc958a2f@www.fastmail.com> <87pmsp5aqx.ffs@tglx>
 <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <d9515c72-d8c5-eba4-56d1-1779fb751908@intel.com>
Date:   Fri, 1 Oct 2021 11:04:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BY5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:1e0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 18:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 216b2c30-a73e-4c9d-da5f-08d98505e6c5
X-MS-TrafficTypeDiagnostic: BYAPR11MB2936:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB2936233F43CC2CC00206136DE5AB9@BYAPR11MB2936.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DKGG9qc9+Gz4s7nrXTSDOm/rSsT28NklhgGdSBovzCsPUp8Ecuhb7TzMOjjTws2p27LzDjK6c73OIHw2bslLsGOaD0XSlaPqs+KC/Fh3OiSGbGqQvSk5fY53q8dWOhuPQsBXIb3tReAk/yMTtoqgYC/Vn4/WtgRVrbmfs18N6tzKFmCnhWxcaNE8psQfsIdwmsqWUbtolq/blGyY66uMGrjv2/fSp2kZAb/vlhrKYzKijhR5X1Aor27J3NaUJ36HQ0lxBcV+xS8z5VpSHjWkGg5Zg4Kuw8raOUpyBRtiy5mjGHtOstLGjlXGzjRy5o9E4TWWYKqBY5Wsc3OEnBPagyl5HF6Av8I4nOn6kNAUgi320TjiRxrUYSRdmWQiAM+Ys+WzMmHI/DSwpkSOTIIdFHnMCu1kE89/1+kmPc4x8VTKhmokaeU+a9rng/d9bj1Gig0e4RnYW+uSz5dOwz87hVJ8WEjQymIGLHTY8TjIFzma/o/nHOk6OWQt2bYlubOCvPCJT2oolL9aiUf4U7GnRlVcQxhe0ZLP7T/MRgVMS02YYW4II+6qXAWGHFAa7YiQcuSDcX90UlsN67ptPj6RRBDXYt6uTNeV8ZnTS2u5Xyx5uQNI6Y7+0cPatYNkhIpUMeV/30VY97IwHvD1gShf/f69YkvE4AI8YkP0gNyE+qcvGg4LY4AknsNYQB8pnacY3fHEo7pSC/EHnltVN9DEF1M1FDVje9Xy5Ic51Jg2aZY6Zhho8YEX6JzNslZ5GWnumvY57hPGKD3lsbez2x5XEf0XJfzyC3dgzHcGwd8h8chmpY3bG992cVP3VvEnrwL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(38100700002)(7416002)(2616005)(86362001)(508600001)(956004)(83380400001)(316002)(31696002)(16576012)(186003)(2906002)(110136005)(54906003)(36756003)(26005)(66946007)(4326008)(31686004)(6486002)(66476007)(8676002)(66556008)(966005)(44832011)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2k4OUpRWUVFS2dpTC9iQ25yV29sWG9UVjZsTkVVd1dvVDE4Snc5VXZ0L0V5?=
 =?utf-8?B?ZGNwY0tUWGx1Y1pBcXI4VmdHWm95QWxrdDFuUytEOUV3MUFaajRTR2dDQVFM?=
 =?utf-8?B?a01BRHlVWkZOb2NtN1I4S1ZSOVo1VUFaajQ4bkp6UHQ0azNnWXMwWms2c1pw?=
 =?utf-8?B?TkNUTEhzYnRFdzFEdElUZjhYclVNZHJHZzUvV29vN3pvRjFoQlpUb3lRclU1?=
 =?utf-8?B?SXhPU3NHQldCSm13eXhVZjhVNE5sVWtLajdjb05UdUpOd2Vva0NuenUzaE5R?=
 =?utf-8?B?ZVdZUEFyYVZWNGQ2ZlAvNkJMN1hmaDdIOWlDVUpVcmdFMVpFVEkzc1NhRklV?=
 =?utf-8?B?eG1tbHFRN1lCQmVRZzNWcHBzVzBqVHFtS2hNV1pmbVZLLzJ6S1JrZFU0Zk1W?=
 =?utf-8?B?bFl4WjZrTWViZ2cyUU0wWWxLZXFOL0NjVlFGT1lWR2VjbkN6UVh3RUlNNDJV?=
 =?utf-8?B?ckFiOTBxaUFhRmxBMnVMRHE3azcrNHAweWhtUXM0RWc4VldpeGIzTG9xanZV?=
 =?utf-8?B?dSt2dkppcmVTUnJ0ejlwSW5jMWtHQm9sKzc1bDY4T3B0a3lOUlVTTkNYQXBP?=
 =?utf-8?B?V05wS0EwcmtURnV4cWVyQjMxbW9FZmRDc0JncjhOWm1aL0d2b0MvRkVtSWg0?=
 =?utf-8?B?bnN4eGlmU1lPZU55VjhWWDh3eHJ0clVjT3VPazdoMitSTjV0SzlXc211elBL?=
 =?utf-8?B?M2xkR1pzNFpIVzNlMlFwZTVEOHk3MFNjYm05SzdDUEhLdGtiSTRUNzFYSUVt?=
 =?utf-8?B?VDZhNVZUOTNJUjFOV09jQWpjWEJuMDZTbmEzMERPdFJmMWxQcmRmR083QUlC?=
 =?utf-8?B?cGllaGRJWGFqa1pUVHJWS3NRRUgraDhUbVkyUUY1YVc5SWhBUFZncS9saU9T?=
 =?utf-8?B?K1BGQkw0UGMycjhmTGJNa2wwV0lXTU5TcTAybWllK3RaQlAyNDFoNWNuNDBB?=
 =?utf-8?B?WStySjQ3QVZ1dU5vczVuQXhIR0pidGgzQk9ZbmlnckVJd0xWR1dzcjVhc3pJ?=
 =?utf-8?B?TFFielkzSk5IMmp2cTJoSjBEWnplZzBLejIvUTNXdkhkcjlqVTgxNWdIRzBo?=
 =?utf-8?B?RGJLaDlOVkRnRDhlQlBWOWZ0VTRtVTZqNDY5K3dudFJIZUpDZGRQeW40SHZx?=
 =?utf-8?B?MkRpc2JZZ0xJQk42b3ZOT0VXdHc3M2lSZE1aSlY3Vk5mZklpdVhuOEZiMUg5?=
 =?utf-8?B?VkY3d1ZyeWhZQTU5QUtqcGR2dUg2SWZRd2U2d2p6VFJoTGdvMUd2V2ZSQkdB?=
 =?utf-8?B?ZHZ2ZVJlN0QrS2kzUlFXWGtzaWdFY1RFa1RGbWl4RHI1bm91cEdTTWNvak40?=
 =?utf-8?B?RC8zWi81a2RoTW8vSklxM2FvU2U2MW5qRGNiK1lHVjZWMlVaOVBmUEF6ckNM?=
 =?utf-8?B?cENPUGEvQ0h6ZlR3ZVZ0eWdodlRZTlplSkJnTXYzTXMrNVIzRUdzVGpzWGRG?=
 =?utf-8?B?NGlWb0ZnM1BlMGtqTEtJTXlhR1FHUGdiWW5oMmdhWmxWMi9yaytPck13bTA2?=
 =?utf-8?B?dmwwcERRSXhXZlFwV09QZW9CVXFnS2J6dG0wNFhUcld4VFo2NFlXSWcyRHds?=
 =?utf-8?B?VEFvWGF0eUwvL0dNdHlpVktYS283Ry9RSktYcGNCeHR5LzZLcUxiT3U2eVFo?=
 =?utf-8?B?a2cxU2ZtQWNiTWxWb3d6Z1ViT3RtMnNWM05mUmRtbTdrbU9xRGE5UFBVM0I4?=
 =?utf-8?B?UnBxMWYyWGIvYlcxMlR2MGFYN1VwZ0l1bnRyTm1nd0ZNdVU5U0g5ZzkvL0Rn?=
 =?utf-8?Q?1kmBps8xfapdgrgAHBGAsB6L7Fatg9H19QsvgKi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 216b2c30-a73e-4c9d-da5f-08d98505e6c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 18:04:24.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S99FOFHTUwVtnJ2PmtWvBpT+S5Axj2MhGEL+8nc1q7Ev7wEjy8RiuKpxB5pNLxjEXw8eCZLRXBLPjvZ6hpj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2936
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/2021 8:13 AM, Andy Lutomirski wrote:
>
> I'm just reading TFM, which is some kind of dystopian fantasy.
>
> 11.8.2.4 XRSTORS
>
> Before restoring the user-interrupt state component, XRSTORS verifies that UINV is 0. If it is not, XRSTORS
> causes a general-protection fault (#GP) before loading any part of the user-interrupt state component. (UINV
> is IA32_UINTR_MISC[39:32]; XRSTORS does not check the contents of the remainder of that MSR.)
>
> So if UINV is set in the memory image and you XRSTORS five times in a row, the first one will work assuming UINV was zero.  The second one will #GP.  And:
>
> 11.8.2.3 XSAVES
> After saving the user-interrupt state component, XSAVES clears UINV. (UINV is IA32_UINTR_MISC[39:32];
> XSAVES does not modify the remainder of that MSR.)
>
> So if we're running a UPID-enabled user task and we switch to a kernel thread, we do XSAVES and UINV is cleared.  Then we switch back to the same task and don't do XRSTORS (or otherwise write IA32_UINTR_MISC) and UINV is still clear.

Andy,

I am still catching up with the rest of the discussion but I wanted to 
provide some input here.

Have you had a chance to look at the discussion on this topic in patch 5?
https://lore.kernel.org/lkml/87bl4fcxz8.ffs@tglx/
The pseudo code Thomas provided and my comments on the same cover the 
above situation.

The UINV bits in the IA32_UINTR_MISC act as an on/off switch for 
detecting user interrupts (i.e. moving them from UPID.PIR to UIRR). When 
XSAVES saves UIRR into memory we want the switch to atomically turn off 
to stop detecting additional interrupts. When we restore the state back 
the hardware wants to be sure the switch is off before writing to UIRR. 
If not, the UIRR state could potentially be overwritten.

That's how I understand the XSAVES/XRSTORS behavior. I can confirm with 
the hardware architects if you want more details here.

Regarding the #GP trick proposal, I am planning to get some feedback 
from the hardware folks to see if any potential issues could arise.

I am on a pre-planned break next week. I apologize (in advance) for the 
delay in responding.

Thanks,
Sohil


