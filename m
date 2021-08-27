Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B934B3F9EF6
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhH0Sig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 14:38:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:38578 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhH0Sig (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Aug 2021 14:38:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="214881722"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="214881722"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 11:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528398088"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2021 11:37:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 11:37:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 27 Aug 2021 11:37:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 27 Aug 2021 11:37:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhYeMAHdS7Txh9CMX/iPZmywuadGEREE0667Yyl0H45SDK06ibjdtjZLu0h2pdSNxC9DCTSzVp3pn9KrxT1Hjw8kLC+r6Zwueih1JR0LUdFf2spA0Xw7SBi4X/3uSQ1g+qlKHpqkZ+ZAq3AMX1+ucE/VGqrYIYofDhY7knV3d0NMOLIiuRqxYzEJ7BQwFLzjKSLtqs9BnTgZR4wkF7mexZSuSNegO/KQ+KXsSFeQsyoMYSj+5fjjGgNAw0wWc14nAOnTLnSbJ1JBh9BAqdh4gTUJrX2bExZUUBePEXUdlqreLPBFYue/T9YeatjPHAGt4+FhCG21wuhjCJwpdEJ3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuJGp7PsnVg1h9Am3U0zumx2KSt45vQYoVeyk4Reu6M=;
 b=WziX1sLVzy7Mrk0aWii7tg7zw8rRM09McuuZeWePyyP9me7+CmN/LOxDIrL/7Xvsp2z01+/TspP6rwELslvzq4539kVSr8otEe7khw5puPH3GEjE31G1KGfaQTv+OuwzPJAEdLrIzZMw6bPzMpglhrWCNI1+u60qrO4bnR8ZkJx5XAsU+RSpzthekhm3/Dk7eBftwWeRWsGMjbUSndUd0Gb6YyBv0RA0irer71wuNdf3H/s5oyzMmy3WccToiVdI7VbEpSpqKvtw5yW1iTornqYA1zY1b6q4AG7OKSM/vv4QfrA0RuGXn0AVAR9SRxzN2kUVbLWSEX5EXykHGOiPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuJGp7PsnVg1h9Am3U0zumx2KSt45vQYoVeyk4Reu6M=;
 b=SUvuf/Ys9K35TeOONdQrzeRr0+8hrYmGfNbRBhvA69aWslGGLXCuJ6kMXAM4+HArkyrD35osJyk8V3DviiwE2mcJarYIkJI7beHWejs41SZhXpJ8clZNjb9IxfAFcBt1TGHzCMOwnzkMwFB9dID4yGbeZUGVwfWURkhpHTsnYL0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5742.namprd11.prod.outlook.com (2603:10b6:408:162::18)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 18:37:41 +0000
Received: from BN0PR11MB5742.namprd11.prod.outlook.com
 ([fe80::f884:d0c6:ad57:5922]) by BN0PR11MB5742.namprd11.prod.outlook.com
 ([fe80::f884:d0c6:ad57:5922%3]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 18:37:41 +0000
Subject: Re: [PATCH v29 23/32] x86/cet/shstk: Add user-mode shadow stack
 support
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-24-yu-cheng.yu@intel.com> <YSfAbaMxQegvmN2p@zn.tnic>
 <fa372ba8-7019-46d6-3520-03859e44cad9@intel.com> <YSktDrcJIAo9mQBV@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <c876d0aa-865d-e48d-0b56-f9d66762f869@intel.com>
Date:   Fri, 27 Aug 2021 11:37:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YSktDrcJIAo9mQBV@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To BN0PR11MB5742.namprd11.prod.outlook.com
 (2603:10b6:408:162::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by BYAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:c0::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 18:37:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81be55cd-bb9c-4bda-1ed8-08d96989c04b
X-MS-TrafficTypeDiagnostic: BN9PR11MB5306:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB53066970AA13B54949A93BEAABC89@BN9PR11MB5306.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT+hfoCMPz4E3PSqxa9oZAAm25yyec+H/leoDptwmK6nQS3JYCxa+h/QRyg5Nr1q7K+gUwPCO7PMN2ecj0LiJKdkWuvHJ6rYDxkm+MzLvRsTM9oRcOT33QypwRKSs5lp881rEBfeft6tD4VTrA8UGUSRBEhYh5WCT6N0qm9SO7KsZPrLg+dUKADETlTK1hOm+MsP7u3hOQj/iTyIzGsht9GdhvSKg/cWDc0dMQWSormaGVFzreP1s9MRtg6/a+kCIhWILNG6M10D8c1ApZRDuixeKBju6pIUHIelYNB0J11sDWqLatjd1H0VDtsiCpCkAzjSYksdw1Bj1wq9sER6LVnNm8O+cdzaNpZ7siQUGhDHolQz46uIwqkyy2xyWOTgT6k2zqBd+jOBRn+r13oZJX5+rp1C/9hh4Xy5seNUrYqvBFP2xpbxF63SfJ6GLnfvHV7uyQquuGYLFB9y68vxa9zjXarshB0KnM3QIuIZRcUIy3R0EFoEoOvrwCagtCPbXzDkWXtF3OoDPrErdU9dHMkPujPaS2o8XuABpg8l8I1YOWPUV6yrS9OJ/fzFzBCOueoliGHf3Vq5Q7//J3P09PwKIY+9ZW7539XIBuq0BDqchxttj+VQuca9uYv2Tm5Gc9lEmbzdA/hh/fFV2+cWd136vZxYIYoMSeNF0I+l1iMXElQTGmqK2vZln/n1+HzU4OYn16TSUgA+wYSDNOvJNLpOnH31QRb0BeI+uA/GTNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(478600001)(16576012)(38100700002)(6486002)(4744005)(6666004)(54906003)(4326008)(186003)(8936002)(66556008)(2616005)(2906002)(66946007)(8676002)(66476007)(31686004)(5660300002)(31696002)(36756003)(316002)(86362001)(53546011)(7416002)(26005)(956004)(6916009)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZsT2M5S0UxVElPNXJlaWFHLzlpbTJURWpJT2ROeXVHN24zZFd3em11Z3Ex?=
 =?utf-8?B?WTQzUnRhaDhaby8wNXpWTGh1SGJqTUtta0lKRG15Q2NtVnVNbUdMajBGdkxq?=
 =?utf-8?B?L3BMd3hSaWl4bjM2R0tGaVlBVThDcm5BQzRHWGZoRWErR1M1VDMrZm40OW1O?=
 =?utf-8?B?MHNZem5EYXZmN2JOeTF6UFZoaG1qcUtrdzNwUWY3WWNrNjUxM1F6Ymh3NklJ?=
 =?utf-8?B?ZTkxMjlxczFoRGNyMkRCbGF6dVRUYkpBbFZkMHY1V3VJekZEaTNVampxaU9Q?=
 =?utf-8?B?cnZFUVZQZTN4N2dzYVRwZnZsTDFtcStlaHA2ODNLTG83dnJpdEZLZ2kzNkI4?=
 =?utf-8?B?N0l6b0FFVzQ3Q01LNzVyRHRkRCtxTHRiUHlJTEJrZ29SMjFveXlvZDJwbFJG?=
 =?utf-8?B?bHhwWFFCMGNWUW9FRi9xSnVXdi96eFNGd0E1MExhYnBvTFA5TTBWVnpVWGpz?=
 =?utf-8?B?cFIvTy9SWkZjOXhVdmpzMTJid1U4d09QRitmcmo3b1JVcC9JNWppU3pPRWtJ?=
 =?utf-8?B?TlVNdFdmNWJxbDh4eWdXZEl3d0JZZUZaMDZHbXkySG82azlUbFlxVnFMeW1N?=
 =?utf-8?B?RFlSVS9ZOENtR2J0Rzl6eU9PYkg4ZkV6c1NUaFRzc09qUG1yOEYzMHU0N1My?=
 =?utf-8?B?Vm0vR25ZVXFRVzd3aEd6a2oxdm5McVE5Q3ZFZXZJRi9uVmcwbnVHYzdYL2JB?=
 =?utf-8?B?eHJQMlJOK0VHS1didENJR3A1SHVmMGRJcjA2V3E1ZXJrd2RyalZkUXMyM2Yv?=
 =?utf-8?B?KzdEMnBxb0pRNnhzNmFJQ0FkSWd4bjhnSmFQZ2RDTnR4eVZZMmE0cDBKUmtH?=
 =?utf-8?B?ejY1ZEd0ZndhL0phQU9hU21waXdtSUNPY0xkYWxOOEx2QlpLUm1pOHVyU3Bx?=
 =?utf-8?B?NFNoeVk4RU5wNEdGdzd3c2NTc1RHREgrTWNZUHB0VEs1NEpUQ0VScTlXYXNl?=
 =?utf-8?B?UndBc21zMTFVVERwRlhjT2NvWnAzU21UTk5rTDdEVzZleU9QREZ1V2I0MXM1?=
 =?utf-8?B?VWNzOWxRVVYxandZTlZjczVhQkhjWTJ0a3hKazRwdm1odUlmOE1ZdFpESnlr?=
 =?utf-8?B?UFV0aTlickZwbXZRRGZBWEtPK3phNlEzS3hIb3g3ZEZtRDg5OUJyVkgxNTc3?=
 =?utf-8?B?UnpTcE8yOUVYTTY3OHYrZXdUS2pVMGVhRHJnUDFoMmdUMjBPWkszZXBvdU0r?=
 =?utf-8?B?UE9tTFZodmZJMm1PNWk3cUxodEtQQmo1bjc3ZnFNRUxuRUtZbE9UNmlQOTBY?=
 =?utf-8?B?R1hqUy9JdFVCQ0xxR1lDdTV5WEVqZnFydnlCTWo2QnQ2WG5XMlV1OVlqTW1W?=
 =?utf-8?B?WnFFL3NFUzJqQi9XeEVGbnRhUUFZRGlIR3ZxbUMrTGRNaHgxT2JKVWtsQmJn?=
 =?utf-8?B?a3N5YmhtOFVPK29zNVBTRHR1Q0JFT0tWWW5sWHFjSHNzMFVZai9SSEVsV0RT?=
 =?utf-8?B?U1VlL1ZINmFNdGFsa3ZvNE12UTV5cU03Um1qc0pINTdzazVUWGhuaWdsUUtB?=
 =?utf-8?B?dW9yelJ2TXBlcXk5UENFYk84M1BhREdDTE9TeXUrcGdtUTBhNFlFNUZKNUpM?=
 =?utf-8?B?RmVhWGM0c2xiNEthdDRxMXlRTkNFdWdnRVhoOFJsU3dNMjdMWkZmVlZQUnJC?=
 =?utf-8?B?SUdjNkUwemlVVnIwNGk3MXJTbGlqNDN4YXZYdXRWMHF6OWpxOVU3V3FjQlU0?=
 =?utf-8?B?cG8wSDlqd0xyT2hINzFsWjlEMUF0MGJ6SG01Q1N2K2tFN000TEpyTmpSa1NI?=
 =?utf-8?Q?4kRqvVaqh562g5Y/Smr/d0A68JNkN4QvXRKe5hI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be55cd-bb9c-4bda-1ed8-08d96989c04b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:37:40.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycv4C03H3xhcFArjtX9HgzFhbuPVwPTMayGeYaEmFEtOTU2pF/yvYbmhj5MKcXi0XrUwAh586Bq5fF/VZkYybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/27/2021 11:21 AM, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 11:10:31AM -0700, Yu, Yu-cheng wrote:
>> Because on context switches the whole xstates are switched together,
>> we need to make sure all are in registers.
> 
> There's context switch code which does that already.
> 
> Why would shstk_setup() be responsible for switching the whole extended
> states buffer instead of only the shadow stack stuff only?
> 

Right now, the kernel does lazy restore, and it waits until right before 
a task goes back to ring-3 to restore xstates.  If a task needs to write 
to any xstate registers before that (e.g. for signals), it restores the 
whole xstates first and clears TIF_NEED_FPU_LOAD, which will prevent 
xstates being restored again later.
