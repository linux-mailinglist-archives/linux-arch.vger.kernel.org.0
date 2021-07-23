Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6C3D3EAE
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhGWQuE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 12:50:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:14167 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhGWQuD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 12:50:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="297494197"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="297494197"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 10:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="496430867"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2021 10:30:34 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 10:30:34 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 10:30:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 23 Jul 2021 10:30:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 23 Jul 2021 10:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv36WAWGjbagP4Jhi9rKFaQp8NxZZK8aKx5rtSUHmgD2d+CV/iS4xiY2sXg2Nk/+Db6HwsujFIn8zudDx7PsMLvA2aQpqeMxrjLn6zg43FukyXzAu/WSLR+3cjp2HGjwvSZHfiNirLGe8T47W6rntrff9zGJ2z2+HLJcaCLNxGEzcYqhZ1j9C0/jyXdox5HkMsOURV98dLZWcFcREt/EsIMLWDNOU4axQ/eTYdbqZRGtN+Zex09pxlfFxR65DqSAQ+EpudWeeu9D3JIRYBKvCysDTX2OTBsw5gYobkOE/vXwJYiQXoxT40f4TAY2g0PzzKZxMHGkyyr0itXSohuHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ZWf6csw781H+OrsDJWtXcykBMWFtq8cS9iKyX9SIs=;
 b=oAukq8EfWkR8wzA/3Ax3cRxt0tGxIhNFr3fSdIkbrUbm40BUkWsQaydIatavhbudEAVDJCB8AxDlGVQJ3wY4uFGGWmqh8i8/joC032THhHGdcfoHnudqVp/UypiA0DJfO1ztjlrOtoSnzxPdGEZG/XSeiswKGS/Rp9HtswoYhu4dlF5/LrHH1IRmYRcjUCsHAzsmWZAFOlPL4fd99KA1VeRTLZ0E1tsXVr8qGpXcRSPtciZWGTIfmfUh8zr3tlzVG9/7z2cVxzJ9xV46qiUfRvFBi4b9ws37r4lPHhreBX7BnogKZykvfMAjBRDIW0JpPhyq2vRpmP9MK70e0/uPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9ZWf6csw781H+OrsDJWtXcykBMWFtq8cS9iKyX9SIs=;
 b=ccqcfbZglOuMvWWGcON3VIs6ahMU0enhfwLzvaR38dPgmbVijUJzAxBzMMAIC91Uk2KNV5jTrj9Pox7uANO2e3OC2eH5oQSHrH2eeSXrUv7B47zNeW0Lne1pSqIWsLryYHemU+MZarkB3ex4j/UudJj2cdmwb7FOcTQ38tnN+uk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM5PR11MB1675.namprd11.prod.outlook.com (2603:10b6:4:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Fri, 23 Jul 2021 17:30:31 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 17:30:31 +0000
Subject: Re: [PATCH v28 25/32] x86/cet/shstk: Handle thread shadow stack
To:     Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-26-yu-cheng.yu@intel.com>
 <9b5eb1a8-fc75-d1e4-36c4-e83ab0ce682b@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a4cd9b79-6628-27b5-e06c-bd8034bc21da@intel.com>
Date:   Fri, 23 Jul 2021 10:30:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <9b5eb1a8-fc75-d1e4-36c4-e83ab0ce682b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.10 via Frontend Transport; Fri, 23 Jul 2021 17:30:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2112c9a3-84d1-4c7c-412c-08d94dff91f3
X-MS-TrafficTypeDiagnostic: DM5PR11MB1675:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB16754662C30F45555FAB1DC9ABE59@DM5PR11MB1675.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CI+p+pjqsrrssRYxg8t7VS+7Jv+sjQbaCQ00cOWGLlcYi3EZgMINSmqK4p4d+V7Q1y5P0sOulaMnSgLiSdWpWWZqiKfYOyUX92AEV6K6lnf6PdM8Lk7vE8NEiVSZNqXsnX/n8vYlW6Xg9ji8LSBmlju7bM8PhW7Yp2Ha8hwjOAATCMGl6GHCJvJ1XpBfgZwEM+rEsC9SISNK7SR/f+6inF8eceWZhFYdy3Ub7pbJvwQboc7j1KcgbyrRetEsJxB5MvE9uzGwogi6scPj2EbBuxu35FzwpqO714GcH/ZPX0AFCHacDgbt0Kb44ezkvT1H5f8Mmsx5Pv4KLuYXQvc7rjxHaaufMk2xr5UbL3OR/DD3jugv8eocLDkIayPQ6zRSTxyaa793G2xpFl/nFIiqxzqHYqvMrE2sJNUO1bDgRgOCiQKmGgKXjP/pGgLkL2iEhifXmw8efwxS498pIa/0FG7hfuS7mt4/Bqwrek2hhERnUTI/d5+WNNmYwYIweb6kW0cvmZJkTsT7IvMPRXxNykDQqYYuHpAoA0p4anLKiAL7oNlXGJnmssnNxLOKGsKXjA2gIQrRwUwAz1IQ3XDkS0JI+ic3QiOiHnZZk6xo+BwCeaJovYdy2HfaKdCupt8klmXAjlu1uDNohebYqUhq1UNEO6Jhd9ON0Hv7VLnjFGwpOPfs5LnEfsky3VAX6dsi+UcFc47yRzTFiv/lW73Hh6QuIG2hs/D3x/vqSzja3VtAW/wZAzJavI+XGF6vMbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(66946007)(8936002)(6486002)(956004)(66476007)(2616005)(2906002)(16576012)(36756003)(8676002)(66556008)(31686004)(110136005)(31696002)(921005)(316002)(478600001)(86362001)(83380400001)(26005)(38100700002)(6636002)(186003)(7416002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJDODdVbjkyaERaUHpRSG8xMTNBbFkyL3l0engvWHhXeEVYNjhIUUdVMzNk?=
 =?utf-8?B?Z1daVjRFUnorN1RuUHVXaStlbTBDUURqWkJTVkFQRFFkZWROYmhzdHl1U3Y5?=
 =?utf-8?B?dm9qTjNpcE01bzRTUnpYbHFGNGhoaXZ1aFpyUFpHVU4zVVFjWUV6c3JyUkVt?=
 =?utf-8?B?eithaEEvWFRVdnk1OHA4WmhtVmZjV0w0QWh5SmdIeXBNcUNXOGVtaDNUR0hp?=
 =?utf-8?B?YW81NlJIdFNCUjFjWmpidmNMMnZGZkFvWWxMQ2FhZWdiSytYK1hrZ1RRV0FW?=
 =?utf-8?B?SGhnU3hLemJOQ0tPRTBSSjNqQVRxdWhpUURRcG5seDNBWiswNFNkeVVBL2dF?=
 =?utf-8?B?RE45dnVIbmNIRjlSaXZKUDJ1dkdIVUZneHNrWnlCVU9HZWFxSkpjUndTcVov?=
 =?utf-8?B?dlRTeERzZ05iTnBON1RNdGpNeUZMZGgzZlhBZjRJd1hNazZUV2Fpa0psbGhr?=
 =?utf-8?B?aDlQWC9EblFiazNVYzV2S1gxazZOSG9FZ3R0Vk5xQmg4ZlkzeisxR2k0ck91?=
 =?utf-8?B?VWNLMVdiYWR4N25qcVRVcTMzWVQwdGJSZE1oU1NVcnRPWkJXQWxXRGZRaWkx?=
 =?utf-8?B?bWtaMU1sZ1orcHdyUWQ0dGFOV0hpZWQ2QWwwZUFraFVjenBNdjZJUjFJMFFF?=
 =?utf-8?B?SUhxd29XdC9TOXdYVVJxOXBWU3ozaDRlYU01ejlZNjN4dWhMeXB2Y29qeWtl?=
 =?utf-8?B?QUFuL0V2QnNEeWs3OWJJaEFnb1RtcFF2NzlpR25zRm8wQmQrUm05cmNEdVhI?=
 =?utf-8?B?M09CQnJGamVGcHBxYmR5aTZjTTltM3dyNitaUk1GaTV4YmlrMTNVbUQ3MFk3?=
 =?utf-8?B?bWlIV1gxQ0ZTSjhoMllUb0RIYm8wcnUvT0VGU1c3S05jUWU1VmhjY3VFT0Iw?=
 =?utf-8?B?S205YnRtZ0MwMy9KUnlTQTl0bEdRUzRWNjh6UVFPM3lYQnhYTFA2Z21aaVFx?=
 =?utf-8?B?d2RJbHZTbC9sK2s1QnVRL0srRUZVZC9oTlR1QnpTWTNyNHRnNEtLOFV4ZjBC?=
 =?utf-8?B?ZHVXOWpzN2dCWG85NEVscEdZNHhkTkQ5OUZoeFNvWWZuT0crYWtlbHc5NlMr?=
 =?utf-8?B?WnR4TWRWQ1F5NXdFQXV1dW1wMEFlbW4xTDFLUExrN1c4ay9YMldXY2pIMmRK?=
 =?utf-8?B?dFY4cnpMVlJLRWc2STRIdW9hYm9EclRuaHExemVZdTFHS21UcHlKZGdxV3dW?=
 =?utf-8?B?cFo1bk1Cdng1OHBXblhuMGNUNEN2L0FmbHJqRnlsUlFoeUxRNHY1UXIwMFMv?=
 =?utf-8?B?d21MaUJkNXgxam44aUVUTUFlQnhNQTZJbGZiYmx5aXduajFUNVdrazFYZWdv?=
 =?utf-8?B?cE9BWThKMG8wb2FrV28vNGlsbnpaTHV3eldWdXRGc1FrWXRSOGx1dWhqckN5?=
 =?utf-8?B?cGhCYnN2bzZMa1ljY0orUENNbGJ3OE9INVVRM1RWeE5aTWhCczFTdm1yRFpZ?=
 =?utf-8?B?ZnFUTG0rS3BoanhoY3Rxa0NGSEVWTExydmo0L3FTZTNzTlhCTGd5L3VLcGVm?=
 =?utf-8?B?dis5a3pEb0dVbnprNmFhRnNxSXRZUGFmWEl0Mk5qdzcyNjNibTk2d1ZYQ1Rr?=
 =?utf-8?B?OFVRK2dMYmZJSzBBNk0xSm9TRnJHbU80Q08xMFVrTDMyc1BBZEcyMFhwcDVj?=
 =?utf-8?B?NzBmbVpESXdmV255YVQ4M2Y0REtpVkZDQnBSa0l0TnRTWkVjTFlmUXZUV0VP?=
 =?utf-8?B?WktOQ09qS0VsQUtHbHdLR0VCTC9KeG9KWE1QRmlhLzdSQlZYL0Y0YkdJTEIw?=
 =?utf-8?Q?6P+W2ft+/YZ/qtUPA4RtlPsE95tHcI55CZ88oOn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2112c9a3-84d1-4c7c-412c-08d94dff91f3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 17:30:31.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U++EYK/Y/rAUrjYrs32AioUXHFQmSIC5sRegXzZXdytqjkdzkd6tRnnETRF9y8+Ckmv6Z6D5fy0zuq1N+eTmHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/22/2021 2:05 PM, Dave Hansen wrote:
> On 7/22/21 1:52 PM, Yu-cheng Yu wrote:
>> +	if (!stack_size)
>> +		stack_size = min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G);
>> +
>> +	if (!shstk->size)
>> +		return 0;
>> +
>> +	/*
>> +	 * For CLONE_VM, except vfork, the child needs a separate shadow
>> +	 * stack.
>> +	 */
>> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
>> +		return 0;
>> +
>> +	/*
>> +	 * This is in clone() syscall and fpu__copy() already copies xstates
>> +	 * from the parent.  If get_xsave_addr() returns null, then XFEATURE_
>> +	 * CET_USER is still in init state, which certainly is an error.
>> +	 */
>> +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave, XFEATURE_CET_USER);
>> +	if (!state)
>> +		return -EINVAL;
> 
> I don't care much for that comment.
> 
> This code is meant to copy shadow stack config information into children
> when it is already enabled.  We *just* checked for that above in the
> "shstk->size" check.  The fact that this is called from clone() is
> irrelevant.  The shadow stack enabling status *is*.
> 
> I think I'd rather this be more along the lines of:
> 
> 	/*
> 	 * 'tsk' is configured with a shadow stack and the fpu.state is
> 	 * up to date since it was just copied from the parent.  There
> 	 * must be a valid non-init CET state location in the buffer.
> 	 */
> 
> There is also a strong enough assumption violation that I'd probably
> WARN() in addition to returning -EINVAL.
> 

Yes, I will update the comment and put in the WARN().

Thanks,
Yu-cheng
