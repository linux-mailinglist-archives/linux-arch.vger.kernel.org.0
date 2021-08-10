Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A83E7D24
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhHJQHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 12:07:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:56511 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHJQHf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Aug 2021 12:07:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="213080330"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="213080330"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 09:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="675056678"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2021 09:06:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 09:06:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 09:06:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 09:06:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 09:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzPFfUUOK56riao2+ZXIj9h1qwVoGVpC9FyB4squ7JkCsp5+Bjo4HuAQeAQDCmcAkodUYm946MMe8Hyfy3uNSVQ8vJx+a8cJWFqKLoB0W7f1AJGS8b1iNheadPc0COKiryvkr/C8pbTazn0vIMED5buYgK6+ydfL0nnxDZyNXRRXY7OgJizR5+fQNC8US1gKxp1IIDCvh+WhoZ3ySKfuBT8pab8dQaCfKC1W0WhmGYcEPyiuc8x83pY48qxt8nWPDBKJ22Jg6DVARqkw4hHXS7KkO1d35kTghlCdhfXOlnZK8YtEZZwWlOHcyCSaHklHA0B1Ad9gsA0jcyB1B0eC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/Dvys3PvD0MmdYAb2hgAu65qo91FyDUSTzDDjuzUz0=;
 b=mdo9bLe8kdv5cZ3VcH9qIQsHHLnUZnocxDWHbAwCshXPdIjpWFtKpgnrgw34hROcli23CBJ75i8RAVTVtbA3QfFbrKCanhDPs58PcUKOpshtLu0xliNUMupzRTnxOWiAwt84V+DTRMRd2PEOk3CTQBriHu7yi2Hga3dhSYtWHIgigmsZi+Y7Pp/B3KFtLQTMONoxCDlTpUnt9TzjcwTwDOfSO3Z5+hMvvZPx4N0TOnJ3sOmPGD/TET4hqTiH0PRClSZ5fSkQxSLB/hrq0wazrhuwWPVuY5NvNHvj0WTR/AlJaF9gSgMCIEjeGCDLxudza86+w5W+WpX9XhVkd7glwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/Dvys3PvD0MmdYAb2hgAu65qo91FyDUSTzDDjuzUz0=;
 b=llwn9tCHRSwXXQyk7RS76nYY82bK6oNbj6L63zkqa9TTrk9QVL/4vqOAlnWGnWNnJGP/QsrCLfm0E1Z1ORKmj8XD5dgir3kN+90BBbHeHt0p8vlpkYAi/+lA3rEbuN+Mvj9KlUd1HBLvA5felKuW2pEsKPRxGf4f1TmwMWLaEN0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3593.namprd11.prod.outlook.com (2603:10b6:5:138::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.21; Tue, 10 Aug 2021 16:06:47 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:06:47 +0000
Subject: Re: [PATCH v28 06/32] x86/cet: Add control-protection fault handler
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-7-yu-cheng.yu@intel.com> <YRFrECvCESC4Irlk@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <5fd82507-a67a-4420-d3f2-92a0a6cc355a@intel.com>
Date:   Tue, 10 Aug 2021 09:06:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRFrECvCESC4Irlk@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 16:06:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b2e169-26ee-4acc-19c1-08d95c18daaa
X-MS-TrafficTypeDiagnostic: DM6PR11MB3593:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3593A0E2A0882526000B7F4CABF79@DM6PR11MB3593.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUwp7YZOfN78PsAgExKPPrp1BCC9K2aO26wBhqV4fEB1TKEtBdzerdlug2He1TbENs0pbFUMAR/IVw+O9JSSRV3xpw3sesxN1X6/uccvjcOyQrsTJ7Mr+7NtvFvsG/XO/xkegNCQqOYxPDqtklt+yOH3uGOFZG6O5T7sC9Os/WnP09tG7eYUKUpKYINL5fNkI9CNf8B9lTdmW6imUkE9ixy5JJH4yNPePlXX8G2RULACj7fGsc/svmkN1LsSsljFIevDb8gWWi4bMzDJTsANxHwcSEjewFOETUyjjKY0bGdERKVhqvZ9dMEfZSNlnt/5bt/Par20CpddvMJO+9B/Uf5rbErOXzJ56PBi0uyLRGicLqq77ICt3HjpGmFvxtZHvtyBF3j+aS9v0WCxXX1AzOy2+yO0LYTJmBTXXoqPDrP6Svt4Ge5TFlhcxg/DoT8BYx2HdPgQkdk0KquoWOEdtYw/BGY+ke9PCUaJk/jLSzJQ9F5cSIIjrwr1oLgyrwPApwWEOavrypyfZfwZkZzaVMz+Fluj1isP1h7N69afU92TS2n8+tX2/qlOvm5iEabOoAUzLYAxsAB213uGbp9dSPf+6/E37lEvBZTzhL+boGDxnuJnbtYXAkXZDj3s7r1LHCkaLtA2Gtmq9Mf2QtbGsEUad+z3eOqibMdiz23kBXbu7xojtXlTfxbiuTPbvBeuJmSxNjObvz56aFDPAN8pHZmgPN+Cop0YjQiDIOC3+1zR0OIqfxIbuVBq6XfyqCeJEWV7m/q2WmbBjCwd721qhmoAwTdkomPbcrzFtSZ+MziDYk1RkAclh5dtd1VQXouB22cyfNQPouSGszU+oOtL2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(186003)(2906002)(2616005)(956004)(31696002)(6916009)(26005)(66946007)(66476007)(16576012)(38100700002)(66556008)(54906003)(966005)(478600001)(5660300002)(316002)(53546011)(36756003)(8936002)(6486002)(31686004)(4744005)(8676002)(4326008)(86362001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0xpSVIwSWRsZ3ExNmZKSXdsZDVUaTdsb3MxTVNhWGZUUHVKc0hxUHJJWXQ5?=
 =?utf-8?B?ZzFYVjdlT050ZUdLaDZ1bzlQa1RNMkNYK2hBRTZBK1IvNllsekMxYU1NNmdP?=
 =?utf-8?B?NkIwOWM2QVdEbGxGcHF2WTJFYVNKczRINm1vRnRYWC9VZ0doZDU4UFNpamQz?=
 =?utf-8?B?cEJtU0ZlQ0NHbVYrc0ZSNU1hMC85bE1xMXZ0ODFYOG42eEpML1BYbnE2ZTRw?=
 =?utf-8?B?SVpLdnV6V2NEN0dCZUovVnR6STRoUFdpb1BGUC9JY3NJckJMYUlzMVdxaUYv?=
 =?utf-8?B?Q2dJajJKMW4rNFp3VUMzYzh6aFM0TkVFdG5BcVUvTFI4R1g2YVh3U1hzMmEx?=
 =?utf-8?B?RkNNeGIrNkJXd0ZJbERCRWlTUk9pekpaRXo4cVNOQW5iUHRERTRqdU5ETHg3?=
 =?utf-8?B?Lzlxek9LV2xNM1YrSTNmc0tjSTJab0wyOFRvdDNmTU1zN28zZ21Td1NIMHM3?=
 =?utf-8?B?anRQeis1QmlSNGd5YzQvbllDdmZ2L2tXMDRlUmFVSUI0Z3UvNXFGdFhHTjRF?=
 =?utf-8?B?YVI4a1dVL2ZQR2ZuV21UYjFXUVZ1NVVxYWVDOEU2MUE0YlpwL3lzMlZybnNy?=
 =?utf-8?B?RENId1V6R1k1TkpmL0c4ZzV4dS91dEY2Rklkb3BiYTdJcmdqV2tIazdnQzNO?=
 =?utf-8?B?SGl1bEViQVRqb0hxcWp2WjFNcnNXZkllZGRKM25HTzh2RTBMQVR2bkJvaWQ1?=
 =?utf-8?B?N2NDSzY1RWtnWEFnc2xxNDB0ODJET1VVN1UzYWF1aTZPQkRFZjh2YXRySDJx?=
 =?utf-8?B?NnMyOERzZG9EVFY0SWIwRjhITm8za2NPcDBOWktsOHI4WlBZVmU5eFg4azB3?=
 =?utf-8?B?VWlLQWFFVzczb01QVGMyUDJ0N0dlNE9oeFNKNjlzRGRJR2pxa3I5bDBBOFla?=
 =?utf-8?B?anZCOExVTUJpVmtWZ3NwS2o3UGliU0hOVndBZHN1YndGQWwyYnVxTlQxUWNM?=
 =?utf-8?B?YUVJc1RDdHlGc3FYUU9CTnVpNjRwWVgzYlhwL25IZjJXcmZOejA0UGt6SU50?=
 =?utf-8?B?MThoUkN6TE4yR0R6UlNsU2JKQ2tCWFAxaHFJMUM5Y0NGYS9aRTBMdU5QcWw2?=
 =?utf-8?B?SS8wb0lwMXRLTXZYY0lqTlFMMVNvL2ZydlBoS1pzbEJLUVlxS29LU3UzL00w?=
 =?utf-8?B?OVRIUVVkdWFvZnR0S0hGRStnU1VCYkpGVGUwaktpaitseHViVG5hRTFTdVB2?=
 =?utf-8?B?TlQ2ZUtiWWs3SjFpNUF5QjA0WElzMlRtbmVXa3QzL0tNanRISGJ6QnNyMmtm?=
 =?utf-8?B?UHp4ZkZTR2ptd0Z0QVFpd3pDNmI5TXVNbDNjMXRsVkE3MEN4ZFFIckVMWUVS?=
 =?utf-8?B?a2d4NFZFVjRJVzNKT1hvbEZLZTJNMStHc29iYWZSMVVIOHEwZ3ZzaGZ5MTNq?=
 =?utf-8?B?T2RNblFYOHBhNHdMblJtWUF6RkdxY05IWHR2dmp5ZkdXSWpGeStGdENBQ05O?=
 =?utf-8?B?dmEyRzE4YVA0NkFuR05JV0h1VEM3ci9iTUVaYWt2UTI4UzZQU3EwU0NVeWs5?=
 =?utf-8?B?TGd3VUt0VC9XUDhWZG1VRlBRQXo5dDExc2d3SmRNaVIvSGVlaC9aUURFdzln?=
 =?utf-8?B?VjJQR05qSkw2dWE1R2xuVGE3eExtVnpZeFdTSitRbUl5dlFSNzRnSzAyKzRO?=
 =?utf-8?B?czkramJmaFRPamhxbS9DOUkwRm1ld0RQTys3dDNHbnBoYndaR0VkTU94ZEVn?=
 =?utf-8?B?b3gzMTZCN3pTL21mMVhmYTYrc2dnZStlTkdhbDJVWkV2eEZFVldRd29TTk9l?=
 =?utf-8?Q?lKZsi4ChZh2i8R9GEkkvW99lbVQqtAz0D8/8xDY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2e169-26ee-4acc-19c1-08d95c18daaa
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 16:06:46.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdHRCZrbq5GLmkD9zPkZU7keYCEsK3h/Bj0JK7fu8wQkcQP63JgOFvF1vOQRu+SRF1sa1U0XiJnLcTE0mrB0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3593
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/9/2021 10:51 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:51:53PM -0700, Yu-cheng Yu wrote:
[...]
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index 5a3c221f4c9d..a1a153ea3cc3 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -235,7 +235,8 @@ typedef struct siginfo {
>>   #define SEGV_ADIPERR	7	/* Precise MCD exception */
>>   #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>>   #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
>> -#define NSIGSEGV	9
>> +#define SEGV_CPERR	10	/* Control protection fault */
>> +#define NSIGSEGV	10
>>   
>>   /*
>>    * SIGBUS si_codes
>> -- 
> 
> Was there a manpage patch for the user-visible bits?
> 
> I seem to remember something flying by very vaguely ...
> 

Yes, man page patches:

https://lore.kernel.org/linux-man/20210226172634.26905-1-yu-cheng.yu@intel.com/
