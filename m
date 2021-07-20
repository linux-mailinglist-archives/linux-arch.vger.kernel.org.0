Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34163CFFF8
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhGTQcm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 12:32:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:22751 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhGTQaQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 12:30:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211341487"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="211341487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="494927407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2021 10:10:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 10:10:02 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 10:10:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 20 Jul 2021 10:10:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 10:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keDmJuSDO4NnWePegwKSGAp8H+dbqIoeP39BHQ9rsV5WcSqUNteutHlns+Sr6fLUhG4P+6JgItFZbb8lBy0mMTUL/HymVI4q0ak9TF+E56fenGclHbtzddbA+SDSodDvCfCCE+rtoAbxzcZpaNEC0KoxKwf9Wb8YkSAtD0upfssoXXxK8rF4Jk54Fj0TSfsf4c7JImrcN7w5/hkHy7ocjJWk7yaT7p9WwyEbQgC/t7YYrbojJYtqKGSXrnr3maGdY5mRGTg3g9VtlkuEqrL/otd6/GY/LfzWVNlPOZmXelksRJg4oPxG93mF3PlLnONTKx/t1Pe19O9FncZ7aunVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5E5WVPhFYaCQYeG37mc7/JpCIvsCjrSJ+QQQV+Q+VA=;
 b=mRciFZVBbgD+n1zt9PGzkm1NTEj+JNa03p79P1RLXNeEZZafEpGf1N/oVI0LbxaXz85QfsJ1P7QyzAyTAY1/beeqUSh7Ossn90MzL1dAZeRZZ4YCkWcbs22qeGK2plbNw8Ia1v/9xd83nX2H9h2F36JLcsTLis6Ma8xwN0w3eYShucb2cyy9PANGxDED12cvTPeTuFgkxWl3tAjLgLrlcfT+msfrsXeJ/vuITV4019IAvhheJea32ZO2OYooYF6IRt7W853c2orZ4tND0yVGz9sEWZ7GLnMSgRDmraI8HBPuV3ar6RSGEp6BTJxy73zEdvt1/AiqDpV8EvtuqGFSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5E5WVPhFYaCQYeG37mc7/JpCIvsCjrSJ+QQQV+Q+VA=;
 b=k1o9n1XK5pbCCS6eoNqVqrs1EaeNpegIDTZ9yHBmUEqFoWQ11eT64pvb4mxmnvp1GXzWkyk7vLp4A/1bWaf++tILuS2ahl79ZGZBu6nQuEFnkabDJPWdNWWUBNdm15T24tGwATWLIpd6dJ4S42z0z2oPP6Y0/6VSDCaABtNHrHs=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB2987.namprd11.prod.outlook.com (2603:10b6:5:65::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.25; Tue, 20 Jul 2021 17:09:53 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 17:09:53 +0000
Subject: Re: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
 <20210521221531.30168-7-yu-cheng.yu@intel.com>
 <31008f559a7263d2a4042f9c061efcd4e86b5a69.camel@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <964c71f8-1dcf-4eb5-1858-e985e77e5b6d@intel.com>
Date:   Tue, 20 Jul 2021 10:09:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
In-Reply-To: <31008f559a7263d2a4042f9c061efcd4e86b5a69.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:301:4a::30) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR1201CA0020.namprd12.prod.outlook.com (2603:10b6:301:4a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 17:09:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46283d75-ff1b-4c84-2f08-08d94ba1310e
X-MS-TrafficTypeDiagnostic: DM6PR11MB2987:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB2987630C4BE24880B9386825ABE29@DM6PR11MB2987.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmmZmh0BXW4xTaZVka/S7hUrwEmePdmQEI8Ptp4NlNfo4aWKlBYayfDSyi20Nfn1pFtLCxqPHVhTnY8ag49hfHpiU/AQc9RbJDQWRFnLQDOasytqADV1leH4Dhsp1wxcWfA97tDFGzgRKgFE21mdEEWmFEVU9rFw5ry4TXBWnQdSzkEeE3L2o35QC9zV4aOMxYQYGBwPfIktOX02i3XvzZdFHQC7tDiZa1SRacyUesN3so5lAkXFzaVlOQw4bpIg5rwX8Llbk9wXoN3xUsUZnKWDQeGv15Ladd/OugckMSL+4w36arYRsxmKAu/k1reuzD5ASQfeAIk2RUSgynopxfrCUNDMa+kd6g/RpYf1AQRFaUZhL/E9mnM/w/vDfzvmoEwP6Pm4PgCc/b/CGy+IEd6K6xtirSclNmuqgHr8R965QexX8OOl5DbcF6kWdCCZB60uPjh8osf0ltXTgI5X2geD/dOQK06fyieTMYrAIrAXf+Wow3qq/MHEynDW3aqJgIcU3royEEvlFn0lFDD4udu3zXUOeE0lOE06jSljA62nb8OEQjO96J2zO1hxS6zEUBGTLC/Gl40gVIUXxyq1tNP23coSCMPQbrx8e5bK5IbFfalTaAL0gXM8twkJAGNh1pV6wAlsKD+fE3aXoRtPx/dyCs8J5ADBHMgIzNy59kGwD14sNXnnGEeH96I06I5hn4lHK96E2bL8DLp/b0AeOQ9PDmRG6qsUf2ugW32O0whDLlvMzLJNYfzDvL4Q0Qze
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(316002)(16576012)(66476007)(31686004)(5660300002)(15650500001)(6666004)(31696002)(66556008)(66946007)(186003)(956004)(86362001)(26005)(2906002)(110136005)(2616005)(6486002)(8936002)(478600001)(38100700002)(921005)(7416002)(36756003)(83380400001)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFp3aGFPWU5nMTVUaFRVZTJvYjVTOU9FbkpnQ0E1and0UHdLcXVGYlNoZm0w?=
 =?utf-8?B?dG1YaHR4a0k2WkZSbzlYckVYSXRRZ3JpUUdiaktjamxRVC9ZRXllYTJERGYx?=
 =?utf-8?B?cFhJS0pxZ1FHTmRic0RpTFhEZ1NUbSs0TlRQa2trd3haQ0dUaUJzSEx6OHUr?=
 =?utf-8?B?cWdCOFlPSWVtOXNyNi9XV2w2b2huTXViZjNDcTNSekl4QW1CZHdrQVNjUTVj?=
 =?utf-8?B?dkI1V0VPVktVeC9NbU9tV1pUa3RPN2JlR2xoMWNYVUhpSWxTaVRCbnJ0ZXIz?=
 =?utf-8?B?b2FSeTBvSFM0TU5RY2JRaXNpeGw0ZWplUmhPWm1wVm5na2huUW9la0lJTEJv?=
 =?utf-8?B?eW9aOWNxbXd0QTliY1lvb1QydjZrOEV1bjgvbURudDBDejd1LzhmRG5BZnl4?=
 =?utf-8?B?b0dsZ3dRYnF6c3pQaS9nWFMwZTlJcEJ5b3NqalBUdytYT0lIWWFlS05FY0tB?=
 =?utf-8?B?M3p3ODNGWkhEcFZJdUt5Rkx4S1Y1d09IRXR3YWhDYkZSaWFZYU80VnlQNVBJ?=
 =?utf-8?B?WGEvTHhjY3NEbWFxOE1KSFZGQ0h3cEVmRUZZbXRiMS9YMFRMczRPY0JhM01I?=
 =?utf-8?B?WER1TVZGMEhQSUZnL25ENDlWTnRKMlVPaER4MS9ZWkVaR0cyNzhTcHRvMGNz?=
 =?utf-8?B?RDJmT3hyZ3lnb3ZmU3F1Ly9ja1luYXJsYmhFZUR0NklvUGIvRk02WXlER2tN?=
 =?utf-8?B?RWhEbXFoUnBiL2hJUGxlVjJJSkF2QWRsNEo4QU02OHBFbS9SaGtFZ28vYm1t?=
 =?utf-8?B?K3diNEgxN1dPWUg4RmNLa0xhRHZ0N3ZJb09jTjRJUFRGOE1ZTlQ0ZWZ3VFRq?=
 =?utf-8?B?WUpOQ055bFhHNExXM1Q5cTNpK21HN3lNNitTK2dScENyUE5ESVNEVU9hZHJR?=
 =?utf-8?B?YnZFS0kwTjIzNG1LSmdWUktOYndIUlBzNU5HTmI3OHFpeDRGVWhVMXlhbHpi?=
 =?utf-8?B?U3VHMnU1SjczTXljUDVwUzBhMjJwRi9ncC92Tk9DblNQMEgwU1ZJejk5b1Ry?=
 =?utf-8?B?RUtLQkdZY1BhSFJMeVg3N2VXS0V4SUhuZDdpR2xBZlRGSU9sUDlyZDJhQnp6?=
 =?utf-8?B?Q1o3VkozUzFIdEVWZVppVlNBaVVFVHkwUk52ODBuV3gyRm9yTzBhUVVGUkFw?=
 =?utf-8?B?SkUxU2ltaUh1NmtWTERpd0NmYm12bnJNcmN0OGVtcDNEcis5RUNGWjFMa3Rs?=
 =?utf-8?B?K3EvMGtvbEtHdWxxZk9IZ3RiSHc2N0JSMzY0NmxFN1crdWptNXhtaWJjOGdt?=
 =?utf-8?B?SGlSeGU0eDJxeEN4WHpEa0RJbDBKR3QxRGpFSExBdEpUcWpXNFJjUm5MdnRo?=
 =?utf-8?B?Y0RDNTBLOUEvcStyUmx3M1V2UWVtc1o0bVVMRUdXc1RtTUN1RzllUHRKM0xo?=
 =?utf-8?B?RXE5Wi9NU0dmdmcxSGFJSHczaFcxamNER05EY1dKMmpmM2JMWWl1YkREeHRR?=
 =?utf-8?B?MWtJS0N4dGpIUFh1MDBWODhpTzVnUUJCeU9heEtPOHAwTENZd2czT2tXUTJj?=
 =?utf-8?B?dXhoa0V0ejJBbzdQbW1OaklDcHZUc2EzT2hmMzlVRTlXSVZEZWcwbVVwSC9v?=
 =?utf-8?B?dkhobmR1TVdCL0RLbEhqUldJZjB6MXpUOUJSNVRrSXB6aXhPUnpKSGtSYTFD?=
 =?utf-8?B?a3pvVTJtRU85NVFYSWtxNkdZc0hDVHFoRVhjYTc3Tlp5TEw1WE9KRDNuWGVv?=
 =?utf-8?B?TDkrOFJ0S0RoajQvWG1odWp6N1ZkZGQyM0YyUTlSZUlzWmNydXg4OFBKMEZJ?=
 =?utf-8?Q?fZDeYsVpLCUMB9QMDN6y16fbOJb9BbpGRNI5XN4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46283d75-ff1b-4c84-2f08-08d94ba1310e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 17:09:53.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qZRtkWY5+x3MCKCrJA9Ws/Bz3EuOooEeS/vwwPSFgntv6suEVf/4S7OtXhJw0Wm3QDg8f1dr0hCUVqb0N8Y8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2987
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/19/2021 11:21 AM, Edgecombe, Rick P wrote:
> On Fri, 2021-05-21 at 15:15 -0700, Yu-cheng Yu wrote:
>> From: "H.J. Lu" <hjl.tools@gmail.com>
>>
>> Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE for Indirect
>> Branch
>> Tracking.
>>
>> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/x86/kernel/cet_prctl.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cet_prctl.c
>> b/arch/x86/kernel/cet_prctl.c
>> index b426d200e070..bd3c80d402e7 100644
>> --- a/arch/x86/kernel/cet_prctl.c
>> +++ b/arch/x86/kernel/cet_prctl.c
>> @@ -22,6 +22,9 @@ static int cet_copy_status_to_user(struct
>> thread_shstk *shstk, u64 __user *ubuf)
>>                  buf[2] = shstk->size;
>>          }
>>   
>> +       if (shstk->ibt)
>> +               buf[0] |= GNU_PROPERTY_X86_FEATURE_1_IBT;
>> +
> Can you have IBT enabled but not shadow stack via kernel parameters?
> Outside this diff it has:
> if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> 	return -ENOTSUPP;

If shadow stack is disabled by the kernel parameter, IBT is also disabled.

> So if "no_user_shstk" is set, this can't be used for IBT. But the
> kernel would attempt to enable IBT.

It will not.

> Also if so, the CR4 bit enabling logic needs adjusting in this IBT
> series. If not, we should probably mention this in the docs and enforce
> it. It would then follow the logic in Kconfig, so maybe the simplest.
> Like maybe instead of no_user_shstk, just no_user_cet?

If shadow stack is disabled (from either Kconfig or kernel 
command-line), then IBT is also disabled.  However, we still need two 
kernel parameters because no_user_ibt can be useful sometimes.  I will 
add a sentence in the document to indicate that IBT depends on shadow 
stack.

Thanks,
Yu-cheng
