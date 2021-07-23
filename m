Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C03D401A
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhGWRVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 13:21:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:6242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGWRVB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 13:21:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="199188806"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="199188806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 11:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="463233089"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2021 11:01:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 11:01:33 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 11:01:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 23 Jul 2021 11:01:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 23 Jul 2021 11:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEtgA4L5e/5NM438GS6jf83tsYv1wJUSo+Zq1V47Hi+vGz/wv3+4orS/o2QWaYFIzfK+s2J+W75Ue/i8i+tF117FPlToxvF2ldas274Eyyxw2tdGYrmL0SMFThntpTJdMEXK6n/6SGqI9CvvR/x5uAysFNObZIWym/Gh+BMKPyTWWNo/8EmPqy286xbnvsNCqbhi7gctNmJDhG6NbulJQYoPcYmmNWU0bCnAFpIuw/+3WkYNXK/0mMZvcVFAWMqi3elYq2dyDOKIlHeCp/JYiP9d8YcFE2XFzvXLMzjgO2gXCiXf/ln9KQkcMRQUPyaNgqF6OmnvTgI3NxeDvOpxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EnAbY9Ijl2PZz+XxR/48pKddXw+iSg+WcNkr6MkSR8=;
 b=kKWEr+Q2BbPQvEjfxxAZtZD2v38MDx7tkmMMmEhTCdcYk5jeaYo8YLEASBhWsf7VT3zwDZfshyStj/8W9VL29m55UtFvLvgZFeCsRaBqGznBE6lNMzfVrGJjDAD7o2n75FKQcLvstuTFsOyHTm87FpmYwiT+2HCFzbokQ3UQ5pmNHeyfFkaJWCbH1fas8954bxD1OPl9xV1Cj9R4U3ArTe9WhJw1Rsm/kBHDcqfGkVreyjDMejzOvvLZZ5k1/ZjYsrBZrZfDwy2+hBukruiwLQekvdiAlXqmBUFG4Ycx5N7dUKM4guDGOeq+KoRhrdDJVpfXlRvDP6zuFy4DTdHV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EnAbY9Ijl2PZz+XxR/48pKddXw+iSg+WcNkr6MkSR8=;
 b=qofPYDLjmKs3mBuUwXkzCNtWkDNGKBZ/iadlJsdOsMGuQJdrhG0Ma0zpnHTlAkQSLOknhjW6WMiwIqlyRcVywMokuViqmcnqajPxlRt/gndeYx8bkzgvyf2wFWsj9IBjB+FTQ+KIyxBhhDyvXkIYG8X9iH7dyHcHUJJiIQK/IxM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB3995.namprd11.prod.outlook.com (2603:10b6:5:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Fri, 23 Jul 2021 18:01:30 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 18:01:30 +0000
Subject: Re: [PATCH v28 26/32] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-27-yu-cheng.yu@intel.com>
 <6cff5396-dff3-8db2-0883-62125252741c@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <4f8d98ac-69a9-273f-bf23-bb5e06dd0ec9@intel.com>
Date:   Fri, 23 Jul 2021 11:01:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <6cff5396-dff3-8db2-0883-62125252741c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR1701CA0015.namprd17.prod.outlook.com (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 18:01:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e813ef1f-090c-4a57-dd99-08d94e03e5d8
X-MS-TrafficTypeDiagnostic: DM6PR11MB3995:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3995E8188A01D3037B4E26A2ABE59@DM6PR11MB3995.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNO4nPBQy52J158vuw5vIw884FISk3g82Klua0+qkdR5qpLzUZqfWDiDnglzUmtEmvtE9gta0Kv3BouhAS0nU93dKuatvs9Woh83PLa7CBD3bSrkPB8Za2xAaIdwT4+mLFv8aBZI/FO5lnrDS5tjoMnvmeOyX9Qr/2UkrcgBnEQU58WHwMdLFesDK9pv/6yCQrffn2LfHYt3sPUwjW1rqzBqX11VtRd6htIaayWi7OmZyQ4opTA5//TQCc1ieE11LrhONxIeAFSMymw3OZEm6MfncegAsR6BlSJXLJTh11MjbWAkMqb4ni5Eqn0Gd63ViaBj2fk1qzooj8U7FGg3Anwe1mlR0zFSUoq23yKmkPeAU0SRMJRKW7jFg4fvDSrbqf7U8x9QLuehh2ci6yCGei6NDm3z+lhQSsR4oVmE6Shxkg9YPiX4KQcQrj63uR3cCvmzdvPoMzhN+3aN/NmJU3YbhdUKx8eLwVi3K51/HkQXEND+FN1nJE3eBmMzlguYcuPA0HJbFOLa+7BgmXkD/zrlO3MfXDLU4h/FypRdaaHYPfC6yoFI2vVIfgE/iySi5jpNEHPGaxvLlJEdIAsfShg4J4wioqTqhGOjF+rWRNqvwLcv0c1kI6lC5ke9wJficOT0LEX3y3L0SyhWXVmUOuqB0BZeQbL2rB2mFRsKGg1c1IjCbO1TLFm3O8Vgh21lB62eLrczRdNPxya0FBeTfCfcmTdzJ1Yr3tBbNN1Vv+fPVVfEYzsWdYyUJH7w6yJQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(7416002)(4744005)(31686004)(2906002)(15650500001)(8676002)(2616005)(956004)(66946007)(66556008)(6486002)(478600001)(66476007)(5660300002)(6636002)(316002)(16576012)(110136005)(36756003)(8936002)(186003)(38100700002)(86362001)(53546011)(31696002)(921005)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElEQVhPVmZhQ2xGeVFVdXFXRzd1cXRweGZKRk9RbXRQMi91M3Q0dUZPRWNF?=
 =?utf-8?B?YmppMHRjdlAybzN4MGFTdTY3ZkRZUXVoa1JjMFJEdnlsMkZQcG40dmZWRHF3?=
 =?utf-8?B?RnI0ZnZXSW1xWElHT0lFOW03UGxIQ0Fva0c0QTIxcHhIMEI4M0lvdU9mU3d6?=
 =?utf-8?B?WVc5NTJGSnpCRk5BSElRR3phR2pYVXhHeXVjL2J6UjA3Q0I5VEpQaWlZN1VZ?=
 =?utf-8?B?SlVEeXJQWGJRRDZqdzUwSTlDd2FhVlhWK2Y0WFArOGxEenFDSG0wT2lIeHlL?=
 =?utf-8?B?Y0ROMTgwN1Z2akkwQ3JLYTRubzlKM1FTOCs5ZHRldlpZOStVdjlWVTZvZHdi?=
 =?utf-8?B?M0d5Zm8rMG8zTzZsbXpDMDZlUTRuOC9MbTFtS3hlUFBHTzA1ZFZSK0JOeE9y?=
 =?utf-8?B?VVBSR2NuTGFvdndUS2VRMU9aSno2MzNubjlPUzErYVZMWnN2SThoKzJya0pQ?=
 =?utf-8?B?d25WbEhpTjVxSllrb2FXUXVDS1V3OG1QSElKb3lKaDdJek9kWm5VMnptNWJW?=
 =?utf-8?B?RzJXQXZsQW9pdDFqRnlpbVFaWjFkVlN6MjVub2Q2bHFaZVQ1VncyTkQ4N2tX?=
 =?utf-8?B?MWxoNTZVOXhuajR0dzA2bURJRm4zRW45RjFPdDN6ZG1Xd25YNFJNakNvdGk3?=
 =?utf-8?B?TldEWnRsQ0dkcjlxQXJwTG1Scnd1MWVlS2NyM1NwbjBXbVlmU2w1d3hLVkVz?=
 =?utf-8?B?WlRzNnVlZU96YjdQSnRrK29BUkZ4ekVtTHorNHZyMWkxMStoa3d4bW4rbm1k?=
 =?utf-8?B?RnlLQnBtRk1Pb3o1bktkM3l1ckNmRW1GSHgzK2ZrRWUvelpMYUhhRUFvSHJE?=
 =?utf-8?B?K0N3Zytoa1FCczdJa1NPQ3N0OGpnRVQ1MnhmMVJoSW1TN2lYdFRXT3VpWWhy?=
 =?utf-8?B?dmJtV2lrSWZaSllxNkpaM3NPSkpMNlpMeVFWVUwvdjRtRFN4R0NQVldoS1ZW?=
 =?utf-8?B?SkQ4c0ZLd3dOS0VGd3BnOXlXK2gxUTl6RmtJVjgwUEhON1I0RUNBeFM0NERT?=
 =?utf-8?B?VGJSMTNmQ0wyNGRLRWNVVGVoVHQrVmQyZjNYWWJUR3B2SXZ1MUY5NkhYN0sx?=
 =?utf-8?B?dktyNkRrYjRYbHNvUGxidEZIdGUvL29oZ3ZraFpIQkR6Z3lycVVzSDNlWCtP?=
 =?utf-8?B?bFZzanlndUlrZ2phcE8wcEF0TjBCNWk4aG92VFIzZzdFa0xPLzdmNk9aditn?=
 =?utf-8?B?akJBd052QXdLK3R4SEgwMDBkL01rRmhVeXYxeWI5VkM4a0RUaWlkUEZKYjcx?=
 =?utf-8?B?dFVYUC8yWUF2MG5lRnJOallPNnhJd3d0VFpkVFQ0TUpqTHlESGZkUmU2cWtM?=
 =?utf-8?B?bFlZcXFlNDE4RUVaSlQ3R1VBRDJsTHpoNnRPMk1KZUcrdVRySEE0a1l3bzBH?=
 =?utf-8?B?YTVNNkwzWFRkbW9YMWVNZXRra003YzBsc3hEUksxaGtrMHVjdXZ5VGdSa3RS?=
 =?utf-8?B?OUJmdHNRckRVamlNVWhoYko1U1pPSi84ZXlqdTVJTUxxd1JRR3dTNkJWdGJQ?=
 =?utf-8?B?cG5FQ3lpSzhXOGRWVnQ2dGprODR1Snl5R1VsbWtGa0xZZk5GZnFmTVpEMGd0?=
 =?utf-8?B?SDBCRjR4bXpnZ2JsZWo2MlJncWtqQ0NaN3BGYTVMRzhYWjgwR1IvZXlKUUZE?=
 =?utf-8?B?U04rNlhzZXJPVU1NWmRodFFZNnE2UlZmR0k1aXU0UHVzcVNVMWpndVcvT2RD?=
 =?utf-8?B?bXAzeEdKdWpIcXhQTFdRaTZHSUxBUER5dkI2V2REREJLbzN0STN4UEdQUENw?=
 =?utf-8?Q?PVUdnE9PUTEJKQe2n4CBdSmx25WsD6gpW9Drnf2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e813ef1f-090c-4a57-dd99-08d94e03e5d8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 18:01:30.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8AJiA4+AfSQOFLQvqh/9YgYrs5yzMJoWeZj3qR3LQyi/FQYmtIL06WQeDP+U10g67PMpQwdNVlwMIMpiEob4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3995
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/22/2021 2:15 PM, Dave Hansen wrote:
> On 7/22/21 1:52 PM, Yu-cheng Yu wrote:
>> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
>> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
>> +	} else {
>> +		struct cet_user_state *p;
>> +
>> +		/*
>> +		 * When !fpregs_state_valid() and get_xsave_addr() returns
>> +		 * null, XFEAUTRE_CET_USER is in init state.  Shadow stack
>> +		 * pointer is null in this case, so return zero.
>> +		 */
>> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>> +		if (p)
>> +			ssp = p->user_ssp;
>> +	}
>> +
>> +	fpregs_unlock();
> 
> Why are we even calling into this code if shadow stacks might be
> disabled?  Seems like we should have just errored out long before
> getting here.
> 

That is true.  When this function is called, shadow stack is enabled. 
If get_xsave_addr() returns null, it is possible xstates is messed up. 
Maybe I can update the comments to explain it?

Thanks,
Yu-cheng
