Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0041F7F5
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhJAXDX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 19:03:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:11235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhJAXDN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Oct 2021 19:03:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248178083"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="248178083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 16:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565352101"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 16:01:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 16:01:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 16:01:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 16:01:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 16:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYGT5l3EYxCiLcKmEEYGCisI1KBV4QtL/ZnkfAQnIVT752a/R7S8LCprwnHHEnYzMvcKVb6z7UVv5i00R32sxOt3Hl7J9parvS/no+CQw9xc3vXqYrfirmfWHGGbN8dG1Ga4G0CfwBQys0cGnFByPADy5gOs28qbKXqzqkrLWJizKkNgUcCJOO3jzI5XOAz2I682wvEW/fnNkeR/vgSX1Yhc1Dk1U+IMKlzGBOuoBNzE/v4YKKaNIdsUZCO7bQ988x8oKoCctcD5Wa3J5wthtmAxOffbxy4dHVR7Xv3NSnp8fa0RoBySJXUDlcrDf1bwt5tH8qUgM9BuCUMOQfkUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9YsXd5KA5VvvNa1bKzgGme0QJLYmi2lY0vrVje9qHk=;
 b=Vwz5109XVRNaCcKIV4ky7mc+rZ25Q5fvKd8rr/+I0D4q0xOQZ5iP2M7ToQhaORofWtXjzfj1y73gtzpi4p/ZjGNB3yeJq7S7PaW/P0fG6rdSaPfIfUV4HCQsLKg8cr2vdH+XjWrZVc5tXVbqti01gIFyEC4gXkbLkCmeKDv/eZK/pOQcytloUuwBXqAPyFEgCOcmcgeGhfGV216tPMHuNH5IwZpGzqGQ4Lg+UEUziWLym97vgLYNtvzsM2nW7Wur451csNO6XcndUxWjLlxL8XNcevkDubxBXQLQR6koSOI5TCJAqYFU/cHA/xI5aCz5Yr8Z+POsZ0ySLdz3TBYMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9YsXd5KA5VvvNa1bKzgGme0QJLYmi2lY0vrVje9qHk=;
 b=BGZk4U6GjRFispUhQHkVkTFqCnVrHpLzyoEyFHaXhL9PZ1P0v4PsSHIYITItckZxHNShBp6y7IYe62sKasIX6wBe5CBcPJX/4/Ty+lsvmhNB/xvFjYG1FHLX97WDtxybn7mKLOHPBDuPXjyVzGbHH3+G9UjTrces3cjdXYmiPNc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 23:00:47 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 23:00:47 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
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
 <0364c572-4bc2-4538-8d65-485dbfa81f0d@www.fastmail.com> <875yug4eos.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <410ccb21-49d8-4ec0-3f23-07e37c694bbe@intel.com>
Date:   Fri, 1 Oct 2021 16:00:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <875yug4eos.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:a03:39e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 23:00:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2f4270-7af8-4f9f-4ba6-08d9852f4e39
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5037:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5037B387CCB9632986B1FE4EE5AB9@SJ0PR11MB5037.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPTpM5Ma8/VXHqnChv71q8CuNESFTgfGIh2cBENxeC5fpl3q+pDVeSBTdNIBNNSDI828yXFyHqLLjv3VnM7EBPvV7476+/ipVJs6lc3WIO8fGHHAXZu8MkHFAKSeH0JbgIBTZBo0MLQ/+fi/Er4P5gom2LcKvvWo1yZjeYt/y9oYPZeThqyiN3d5e4gDlwVhAUYIPc0XZ1KSJ01YXMpq0c3RKDv1TM8KCWVad7IaYehpIqFmKtdYDV+yCB+5YnBXNsD5NJNLs3dMBYtH7jSAI/xg5p5dgoRnuNt9p27hbs2Bgb/fIcCh1RdHvEFcb/3t2bIqrXXsMxBIqUj+MU2314SkbF1ubpWudw6btQ5bOnLP8ZwlFyCCT0g+bTvCNOHx+LdtgnlecXvL80WANl90T1zTStSgZxQWDtjxE+3qusUbQvVVlh6ajBFvvFFN6UApQFuuP4ovckhp17hSKY/sHCoNbaF2ZEno82vZAs1J85ENza6bnWQ2IrC1YFFOrOaLDjYUnKRpNzH06eRcboclK6f40OL7VvbfcgmE1b1QUvmDbk48hzyHSKiLWSllcVnPL6QRrNvjJHJYyWsfeiAQoYhAwOBg4O2kfE/4w23dZV7RoVM9SlTXJtrPhQsiCfXWJ4+SFOUvS0aqZtzR0dLuB6+a8abIa4xQLRITYphTudSH3aNxUFs0hR1Z4M9HOWyQxuRSa68qaZUQe5hsVKQC1UI6R7i/iXuRrR4TJM5/5A1v0MEAJS4GomFMPU7ZEzx0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(86362001)(8936002)(2906002)(4326008)(66556008)(7416002)(2616005)(956004)(16576012)(110136005)(508600001)(83380400001)(8676002)(316002)(54906003)(5660300002)(66476007)(6486002)(53546011)(31696002)(26005)(36756003)(66946007)(38100700002)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlliNllSbmM2bWtHdFJFUXRLV3U5V0VEWG5Bc2xKMSt2UzdoNDlYYW9xNjhF?=
 =?utf-8?B?b0lNRTI4K200L1JqNEVkcFRKcGE0WUVGYkI0cndFb2ZNZ3pJRWpJRFZ0bEZM?=
 =?utf-8?B?WGh0VldacnpWMXFwMW10OUd3K2dzWDZQREdYeEFyNlpkR01RajhmbnZuVjVO?=
 =?utf-8?B?N0l4UmUxZjNjdGFnWHVCeUl3OUFLb3gzbmVUZEh5RDdOeDJ4M3c0L1dsY0Ji?=
 =?utf-8?B?N0hhK1Q2RDZUY2h2Tmp6RVYrS3E5cUhUdTVKNlNpUEI3ZmdSdUZHUTVNM0xj?=
 =?utf-8?B?NkNENW5MbE5pR1MxSmpFTnN6VUEwUE5naDkrRml5d05MUlZsZDFpaVBKR01w?=
 =?utf-8?B?eDQzWnBUWXdobWxnOUh5NWpRdExHb2xpYUxscHdEdHB5S3h2aEtYUW1jT2tN?=
 =?utf-8?B?N0dJYW9aOWlqM3N5U2twQU1mOEgva01MOHhGU1h0RUo0cHBsVEczQmI5cUJa?=
 =?utf-8?B?ODVOdkg1Qm9QZ1gyYlFzZXMwS3JnR1BGOGhZL2llY1RiYUpTanlQS2VLa1Rm?=
 =?utf-8?B?M0RaVUhRRkZLTGtzY3pkZmE4MHg2L1hBRDlhM2FNN1B6UnNGUjNnQTl2SDVP?=
 =?utf-8?B?RmRNa2czWklHb1MvNmJJOVNqR1lxUk5WWkpMVENYVjhqRXpZZm0zK3UwVlZi?=
 =?utf-8?B?bE1TaDVjSU50ckkyZnBYYVVxK21iNGNmQ1p2MWNpNldmT0pNTUlqWjE5UFBh?=
 =?utf-8?B?Q1FLK1k0UWhobFNtQ2hwM1BpTi9SbUlsQjcxN1dSQ1RXZVBLS3U4bXRTL0cw?=
 =?utf-8?B?RUI4Qmc3ZFVhOUkrbWE1Q0tsa3ZBMWNPd1BEd2RKU2ttOUtxNUh2bnEwdnJE?=
 =?utf-8?B?clVoVFNnQm5GNFQzRUlEZXVja0FFU3FseHluU0FJb0tuM003d2RPQ2ZEMDVZ?=
 =?utf-8?B?NHQ4TlBrSGpla3dEUGFVWU1LTVozbnBWODNUQmtOLy9KNGpXN0wxUUNkbWUv?=
 =?utf-8?B?YnYzZEFsTVNUWkN5aC94REg2UkNIb1ZUZENTaWgzd0RMaEJqNmpTSVZLUEZS?=
 =?utf-8?B?dklaSjQrQ0JaR0NZVXlBbS9jalN3T1o3UVVoUjRPMGhTT3lpSVdvdGNQZENY?=
 =?utf-8?B?anZZbS8zRGpoNnhZeUMzRGluemx5aXU0dUQvN2NmMXBsMTZPckZsdWFMQW9M?=
 =?utf-8?B?UUliNmJZMHo2dXZzKzRtc0R6RTkwTkxTemZmMjZpclJIVnIwRnlISXZrQWlB?=
 =?utf-8?B?dTNFd0lLN2dXM29rTnRHcU5ITUwzNTlwMW9Yc3JBb0o2REJ4enR4WSsxSUtM?=
 =?utf-8?B?SnAzNkhxZ3dVVlFMNTYySlJIVUE2c29tZ0pFSHVtMGdKSFNZL2pVQ2hsK3hn?=
 =?utf-8?B?VlRPMldYU25zaEg0V3R1cDJ1NmdnOTRCQnQ1OGhwMnM5MmhlaDd4ekg3WTc2?=
 =?utf-8?B?dTV4aWp6Q1JHK1Fid1VtSUtkcHJuZG4vOTRxU05pR3d1UWZqTHZWU1dKNXds?=
 =?utf-8?B?TUtxaWhrM3lhbEN1YjRoekpENm82VlVQOU1BTytaOFhTVks0VkdrSUI3VU92?=
 =?utf-8?B?Sk03aVk4dzBjdU5JQytGNjRmb3FVOTR4ekgzZUpDTmE2cW9YdWFrZGZaekVv?=
 =?utf-8?B?S212SFRnY0tyaHNWN0NtMWJUa1hnTUFQYnByUkJYQjd2TFl3c1JpTW9MdFhT?=
 =?utf-8?B?WTNJYjEzNlZnOWs0cHpLcFVMa29XWXhJMXB5S0pIZFZPaVk0L3dwYWZaeWRy?=
 =?utf-8?B?cWZhTkQvZVYxbUZYWFNRanZjQVVuK1NrZVpDaHZHSGJrb3hOdlI0SWgxYlRC?=
 =?utf-8?Q?k3AudYM0x1hERRaObsE7NS9cGFn8BkmlhuARK6l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2f4270-7af8-4f9f-4ba6-08d9852f4e39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 23:00:47.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxEBNaSe70ajGWMRih/t3d4/y1/OzOOxBDuvGHTrBjbVMz33VTobzpVrnKlF7IpKOhVn4mOlsUs9CN0sE1mKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/2021 2:29 PM, Thomas Gleixner wrote:
> So we'd end up with two XSAVES on context switch. We can simply do:
>          XSAVES();
>          fpu.state.xtsate.uintr.uinv = 0;


I am a bit confused. Do we need to set UINV to 0 explicitly?

If XSAVES gets called twice during context switch then the UINV in the 
XSTATE buffer automatically gets set to 0. Since XSAVES saves the 
current UINV value in the MISC_MSR which was already set to 0 by the 
previous XSAVES.

Though, this probably happens due to pure luck than intentional design :)

> which allows to do as many XRSTORS in a row as we want. Only the final
> one on the way to user space will have to restore the real vector if the
> register state is not valid:
>
>         if (fpu_state_valid()) {
>              if (needs_uinv(current)
>                 wrmsrl(UINV, vector);
>         } else {
>              if (needs_uinv(current)
>                 fpu.state.xtsate.uintr.uinv = vector;
>              XRSTORS();
>         }

I might have missed some subtle difference. Has this logic changed from 
what you previously suggested for arch_exit_to_user_mode_prepare()?

        if (xrstors_pending)) {
             // Update the saved xstate for xrstors
             // Unconditionally update the UINV since it could have been 
overwritten by calling XSAVES twice.
                current->xstate.uintr.uinv = UINTR_NOTIFICATION_VECTOR;
                 current->xstate.uintr.uirr |= pir;
         } else {
                 // Manually restore UIRR and UINV
                 rdmsrl(IA32_UINTR_RR, uirr);
                 wrmsrl(IA32_UINTR_RR, uirr | pir);

             misc.val64 = 0;
                 misc.uittsz = current->uintr->uittsz;
                 misc.uinv = UINTR_NOTIFICATION_VECTOR;
                 wrmsrl(IA32_UINTR_MISC, misc.val64);
         }

> Hmm?


The one case I can see this failing is if there was another XRSTORS 
after the "final" restore in arch_exit_to_user_mode_prepare()? I think 
that is not possible but I am not an expert on this. Did I misunderstand 
something?

Thanks,
Sohil

