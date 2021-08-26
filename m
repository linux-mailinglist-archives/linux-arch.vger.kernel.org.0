Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3B3F8CF4
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhHZR06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 13:26:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:24526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhHZR05 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 13:26:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="217798494"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="217798494"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 10:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="516871992"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2021 10:26:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 26 Aug 2021 10:26:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 26 Aug 2021 10:26:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 26 Aug 2021 10:26:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 26 Aug 2021 10:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVROjGn83lsPF7amnnKTtkn6qOIHKOceaChkVUQ9D6fIhdvxEFgj+OZvgAi8WEVyPyQEbyUOEtshtD8/SaONNGUvjJsEBpBn/i/2aSwzps16lvt31dV18OaVIwKAWLsCRSmW5FaI2ufSvZ4zltTiijWwfdnIGIKWc5VYgrGxyNrHyLJer6qeuzOwaZDf6FHw4LOeVuHb0f+zpO61C4yavCcYl1h2FzUoAk8zVy9Js7P920h0PFYFMhKYsjJRzsPnca/wuOGVGOECYY9ItM7y+5hbesFW2byW14zP2LigVptzEOjdM5Es6xbFDGCsZj2d7Tb4ZqDyzeeNA+M4Mb1Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb2EpmyJ2NrLtyx5nmzrykX6e45kAda1ClXyI029w5I=;
 b=OrrmziudgpHG6+gvCEadf1vQMammq1yp4y9fxqfRXtV1LZUY+nl96pyi6ynCdHXoj+xMK0hLfFlf6rjuYQvk/tMuUJ6yROPgCvXGRnkv2VrYuTy4F2AcDSyVEJ269ntVaNYN8RgKlkiTxW5PhLTZkWD49/LAbqsFbM6S4dfPhLqNfESfERFgBYxAnV9LOX/KCkguUm7YAYH4BNWiwAoxIC1/iF07MvugDNH0EVBxPSNgxNF6fIO3/yBDKAirR8zKVlCs+yqK1b3xrfp52Vy9f7BJ0dc7Ft49/TqC7exbmt1OjiiR9KvLz5n9iyI9W+M46pDlezvAPfQ0l3UJt36thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb2EpmyJ2NrLtyx5nmzrykX6e45kAda1ClXyI029w5I=;
 b=TaEIAZiB1trdo16jmVq3C6qecu4b0DzGHcIIId2LVx4HpkF7+f3CW4SeC9qRmdVSkK0z9XqjyFxMQtQqboquibiLlqpEte7IANs8zL+2nwcKp3+IuqkJqsJ0p0DzKdsqYtd+zrq1GGJs/AwsnuUCX5fUjC2zfB17tafRdn8SJsM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3996.namprd11.prod.outlook.com (2603:10b6:5:196::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Thu, 26 Aug 2021 17:26:02 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%4]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 17:26:02 +0000
Subject: Re: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
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
 <20210820181201.31490-26-yu-cheng.yu@intel.com> <YSfGUlGJdV/5EcBs@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <44092e74-ce00-1518-5bc3-64657513329c@intel.com>
Date:   Thu, 26 Aug 2021 10:25:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YSfGUlGJdV/5EcBs@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by BYAPR21CA0014.namprd21.prod.outlook.com (2603:10b6:a03:114::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 17:26:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eddd90cb-359a-4452-55fb-08d968b693ba
X-MS-TrafficTypeDiagnostic: DM6PR11MB3996:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3996CB25C79143A4B2CD9C39ABC79@DM6PR11MB3996.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiFtb71c3vRlrTqNC4NgeAbmc4Lu9yPNBL+0dr9O3ruhCjYPHWQvZAxjaoJQIG4nkQR773xq6x4yTAxu7MV9anL6+smpJ194tJVnQhCN0EOvXYtxnM4QI6lNHFbrWfIsM+VaD8qXk24Q146Oh6fe/wcS1vTHyS0P1lBRM7GJASKcP2WKRZxMv5PqSSQE1rfu5h4h50Ku/Xe1jyDkvFZtc4eTdPIw9Sim+tbZcBp8kLtXW1hFJaREDlawI04eSZQwzeivnSVAdw1nee1H+Z47rUIstmQrJWpSCXw4Sduiv58Z9lQhqNk+lbsyOjm+6cLOcODQUjoWnHvON7ZwW2DJ8Em8r2BMWVk90cfRn1TkOGbVNJgYjYma4w08CLl2POvbXp2lQvGuFOHBuOobYm2dbAXio2IAfSBfkOb3P1FU2yvuGlv3orbNmzqpoCL61LkRmu0E2w9x6JHn08wuNKAOp+wHONzYJxfLjdlpCPhGqt60AssSgVui29IxIKaUgWohcFT1788u8L8eJHmxS5MvAIQNZdLI+9ItUMVrdRxIi0Qu77OAlidDfc3mL0rMSqgDqjg3qDAPeQr/gC0lyBJhOvAs8tWHa+/4meKYfiJTkFionDwQBK9NrGy3Tub1kIsgxSRbdqI/d8mYFMmTJ3ZXy5KAG8kx6hTsEDLsI7NEs7Kt3t+GCgEPqKheslP5c6+Kv2PNmLTTrfa/1O07HJS+SMhayiYX8wlPzZ3/v+qvQzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(6486002)(31696002)(478600001)(4744005)(16576012)(36756003)(2616005)(2906002)(83380400001)(31686004)(53546011)(38100700002)(86362001)(316002)(956004)(6916009)(7416002)(66476007)(186003)(5660300002)(26005)(4326008)(54906003)(66946007)(8936002)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tJZmQ4RlJmSzdHTmg4djd4LzFWUnpDVVAwWHNrK2xqWHRZNVZ6NDNxOXNF?=
 =?utf-8?B?cHRISjY0dkdEaXdKSys2M0RzeWVzNDZ1elh4cU9NVy80SnZLd0lQY1FxSlVC?=
 =?utf-8?B?VkZlbEszTWJDMnRPeHVMeENFYXFRODdEempaWUhEQTJ4d0poTHdTektwY3lE?=
 =?utf-8?B?UzlSR0MyVUdRMmNkL0RFRkljUEpCZDRjL1RTZ3NlU3RNRHdKTHhKK0V3MTlQ?=
 =?utf-8?B?d2xna0dJNSs4dUdLekx4ZXUwZkFVSmpnYU1Ca1FQaHpDNXVuY3liUjYvWUJ0?=
 =?utf-8?B?UWt6MnNRMWxBYm9sQTdPSEFIYWs1cFBLYjE0OHQzS2M5RStrVldIbjZNWm1J?=
 =?utf-8?B?bDBCRFZnd0xOUGlab1ZvVnU3TXByOHBwUHV2bDY1YUo4N1IzODgyZjhGWTZM?=
 =?utf-8?B?dS9MclJXLzBlS2dwUlBWdThSK3RFL1p0UUlNOVVlSjZWT1JLSXpkRmNCL2hM?=
 =?utf-8?B?L1h6M3ZPN1ZpWUF4VDBMSlN6WmRyelRkQ0ZlbXE1RjRtM1JCbWhobnZjcTF5?=
 =?utf-8?B?cld1NFRpL04ybit3S2FNR3J3dXNjS3NaV3cxSVdtcnVoczZLekpsa2hLTys1?=
 =?utf-8?B?alBNQ2ZXa0Y3b3liMkFQVG8rV0d1cktmU3U3MXF0Y3FKN1lzbDBSMVFMcGI0?=
 =?utf-8?B?a1BvKy9DblFIcGlrOHhCRGpoYTBpQ3llaitKOGJWYjJubE4xbklycWFGY0l4?=
 =?utf-8?B?NlBKVlBnWTBiZW1WY0ZZaUloY0MxTWlXekxjclBHV1dUZzJ3dDJyMTM3bXpN?=
 =?utf-8?B?Zm5oRDloM2txVlozdFNJeSt1MkhSOXdRbmNhYms4eDhTNklJZm9ZODV4dEtl?=
 =?utf-8?B?VkN4cnRxdWhzOHVSVEZWQ1N3azUzRnF3b3NJOEM3T09vK25PLyt0ZWJXSGI2?=
 =?utf-8?B?d1dVanFCRzJmVDdLSVdmQ3VJN2dUUVVRRlBObHFlQnhYUG5OWDRHQVU5THVt?=
 =?utf-8?B?eWtPdkRiUTUxQ2YyRWpta3A2V05XcXg3U3liWHhXbnBCOHRlb3M2R1U4QThK?=
 =?utf-8?B?M21ZRSswS1cyQzVHMCtNbnV1eUN0eUJkR3FlSmtzUGFSRElXL3NKVXhVKzZF?=
 =?utf-8?B?Tzlaajd3WlRBTS9MM09tb25BVmF4ZlhiRDVYdVpLZHpNQlVoYVR2REVCc29J?=
 =?utf-8?B?SXVVMTRKS0dRaW5peTEweHRIeU90ZGlleXgzdWY2ekRVZW9PZFQxOVZjSEg3?=
 =?utf-8?B?dHZOeVczaGVkSDRtZVNIRzZPT1RMZW5xMEg0RUl5VWdkejBDaGdwaGxCZVZQ?=
 =?utf-8?B?TnRlVU9XRjZINmhEQTA5ek5GcW1jY01BY2RTUjFkOU5FRklnYk1nOW1ST2Zj?=
 =?utf-8?B?ZHBiTE5jMmFLTVdhMGhXQVA2NWlrYnJBNGUzQ05IRVU0UTNLcW5XZUlWdEdY?=
 =?utf-8?B?bFVvZXRVeld3d1JiVDZrcnZuUzR6MnZKU092NklWY3NxWXBFV3NhcUpjZ21K?=
 =?utf-8?B?UFZzVUVTRmlSbDNadVJUeGd6MTE2NlBuQWp1d2o2RkZ5ZHlIei9qd09aMW1l?=
 =?utf-8?B?ZzF4ZjY3SFlsRm0rclNKaFptSURhT0VrR09reEF0Sk1CWUxQd3JqaXZYb2tR?=
 =?utf-8?B?ZWkxQkJmNlRaQVQ4Q29pU0orcTlGT2diUWgwaEFRdUk3TTJRT2d4bzlJSWpW?=
 =?utf-8?B?VGRtTVFRaks0Z0Mvb2J0R2lPdEgrOXk0cm9RLzkvd1JBSTd1cnd3TTZxaGRG?=
 =?utf-8?B?UGZ3NktRVTgxdUJER3hPd3FUVlljWDJnZFdmOFhHZm56cHowa0M0VG1uN0lD?=
 =?utf-8?Q?PWLozKqpz9FjEPlEa5jtv+MySVX0uJ/k+a1+/wl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eddd90cb-359a-4452-55fb-08d968b693ba
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 17:26:02.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh/CrrMzg6WW0nrHyVzPKP8uLVWRWyO2knytGOrQgkju1VUwzodxN/8MgrzGl47kQERV/mOrwOY4IcsJrEBx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3996
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/26/2021 9:50 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 11:11:54AM -0700, Yu-cheng Yu wrote:
>> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>> index 5993aa8db338..7c1ca2476a5e 100644
>> --- a/arch/x86/kernel/shstk.c
>> +++ b/arch/x86/kernel/shstk.c
>> @@ -75,6 +75,61 @@ int shstk_setup(void)
>>   	return err;
>>   }
>>   
>> +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
>> +			     unsigned long stack_size)
>> +{
>> +	struct thread_shstk *shstk = &tsk->thread.shstk;
>> +	struct cet_user_state *state;
>> +	unsigned long addr;
>> +
>> +	if (!shstk->size)
>> +		return 0;
>> +
>> +	/*
>> +	 * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and
> 
> What is "earlier clone()"? >

I will make it just "clone()".

Thanks,
Yu-cheng
