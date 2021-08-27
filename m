Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D915A3F9E8C
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhH0SLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 14:11:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:28403 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhH0SLb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Aug 2021 14:11:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="240226566"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="240226566"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 11:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="685556186"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2021 11:10:41 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 27 Aug 2021 11:10:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 27 Aug 2021 11:10:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 27 Aug 2021 11:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fShaIt7KoipIkOmtyNYGIHpb0hbgcWuATjsgI7O755/aMQKnrzaHmiIb4KgiLVtJSGg685SkB/u5UsFNubUjHPWiqqKGjd+6Vr7HhDDNaSC5xDEoO+rJhLqAY7+omq7YN78TbZ/URSK6tnn9+MG9pNdsCuuvtqQpke/eAk8gI2FlUTKOnhe4M6fOHzlOVC4BGVP40DnRtrfhZT3Fl45Gj1n7v+bs4/g9/rv5rsZqsTSBtdG4yF1Ca6H7s6elx+Om8ki0aA3hAFsdMN0IQRuqzxopOzzjGeV6WipCKTKQPW/akn9qqGf6W8vg9otdWtdqdR3/bapLwv1uFGugfFs3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EENXGAE2PCcDL71X/mq3fo21eEplu3LhWUL9e8TEvmw=;
 b=JEWfAbsCpNDr5yJ/o9dBeuJLz3gqbMr9wJ1A+6ci5zkcTaoxWUOlPPF+hsOrWZZA5xHTGql//a8ya2ggGAiZ13WoJrZoJ+GBMj4QQgrJK45eHb8IMkPO2PzKsoWSqDFncz+TbjyId4GUoJtjJalO4yNqbKKLp/8PgOK42Ki6zHsy7B3ZnL1soxmOunoRGHgOd8fjuucJDSgCuL2tuS17gjmG9jvFPO5KzdH+aZgcPyMuqthh+s5bEYkOxK87ZvDdWmXwq7amwb6fqiZTYQtUUqqhragvSiyPiza93uajFCkVZ+LmF3KfOunQyJmfhE2f3qr/35qFrn3MDKdxmAD8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EENXGAE2PCcDL71X/mq3fo21eEplu3LhWUL9e8TEvmw=;
 b=Ayonq7NK/Fcr2FHpnV12KW4Ia97qA84JmE1OHuoI8+LIn2x0YHWZ6DHs+vyjEju0284zlA550tmI6ADiXkSRp/RWmcjZw6MKBrpzV2ElwXVPygTDy7j7jRbR9+/F32o1+bGGI7u8thopXH6j3gfqhRW5EDc7TZRj21VtlVuZ1kk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5742.namprd11.prod.outlook.com (2603:10b6:408:162::18)
 by BN0PR11MB5741.namprd11.prod.outlook.com (2603:10b6:408:161::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 18:10:38 +0000
Received: from BN0PR11MB5742.namprd11.prod.outlook.com
 ([fe80::f884:d0c6:ad57:5922]) by BN0PR11MB5742.namprd11.prod.outlook.com
 ([fe80::f884:d0c6:ad57:5922%3]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 18:10:38 +0000
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <fa372ba8-7019-46d6-3520-03859e44cad9@intel.com>
Date:   Fri, 27 Aug 2021 11:10:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YSfAbaMxQegvmN2p@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:a03:100::18) To BN0PR11MB5742.namprd11.prod.outlook.com
 (2603:10b6:408:162::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by BYAPR08CA0005.namprd08.prod.outlook.com (2603:10b6:a03:100::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 18:10:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb59b9e-3fbd-446b-4312-08d96985f8fa
X-MS-TrafficTypeDiagnostic: BN0PR11MB5741:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR11MB57418063941950B8946F7E63ABC89@BN0PR11MB5741.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hP7RBzJQ1Kn7xKtfBTMzpAzjqVWhzJuvRr/n3fhE2qMhFyizwIiYZCkujheEP5tMkggOgJ9smFA59IO53iA8OnZWApYUuuIZzQVEzC8Wx10hTDhxTx0arkORy/1mgN/qBar8/amXZg72Ixt7ol8ouw/fRfnH80eOemPjNt7OQKdAufE1pKiBfmC26gr0gISndntwZMSlb76CL3+Azqy7KESo6PNs9NBuWVBnat2vjqwRZw/7TXN2Q4X9j/0VEftr4aMqSzW/Tn0N5sD/5o4uKFMgeCWnAePzWAj39waUOMlnyh5j6THZbEkIGeA0wB8H6Z1T7FoxtYT/MujhjRM71q+CGTG80oqYNEe+hrxci/g+33OCZSLEUmd4GdcEpZuq1RZnZaypsfhky6Fdz0GbTtVgTHbvNDsACErSCaD78AMiDcpZ1aYaQWqYVMUPSFMXphfbIfVJTyViEhbpyTX1njkeRGwZULtAewi4zz7qQjwRrnMOozYaZObQIyxx2Ke8Zcxxuv79kxM2CSzCXAyKDE6PkajELvgBl6ZAzo5Tmh9lXjPgTcYlL/QknmW8INoB+PP5feIytj1EZ3PpNQueP0jYzr87bI8z1AAfBem8+DnN1hfe5HjARIJ4eA8MxFQkyCvz5PY53y3cwLI646UNpjepE+wxNLCADpfet88KLVazO/aQfm6s9yWEJJGMTdUTlrzKI5U+vet/+h9oicU0jCBbgu8xUeToAmm+iIkreN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(26005)(54906003)(478600001)(2616005)(66476007)(4326008)(186003)(316002)(956004)(16576012)(53546011)(6916009)(2906002)(7416002)(31686004)(83380400001)(8676002)(38100700002)(6486002)(31696002)(36756003)(8936002)(86362001)(66946007)(5660300002)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJiMHdmOUhyaE1OMzNHOEcyakFqMU9NVytjNXBSU3JNTHhSZzhNMXlTbFY3?=
 =?utf-8?B?NlhnbmdGdFN5Uy9vMTQ4dENrblVjRVZjSHBQZ2RQOXBCbTRVd1kxajVwUUNS?=
 =?utf-8?B?bmd6QVRwU0FOR2Zick44djJoUkJxREZDR1lBbEFkNjRYVHE4ZzhuVkFYY2d0?=
 =?utf-8?B?cG04VTZQU1E3aGN2U1ZOR3ZjRlQzaVRLK0RpVkpSVnRheVV5c2puV0VtREVl?=
 =?utf-8?B?dkJNbzdWSnpTRGp3OTNTZldzamJPU1lMUXFKWForRHJxa0N6bnFVcTd5Rmsw?=
 =?utf-8?B?bUZYb2d3THpQRFY3UFdObmJPaVpndVB2YVg2WHVVVEUzNU9ac0JGaXZoWFln?=
 =?utf-8?B?RFhUSERvUmhIdzI5eC9RVTF4Z0N4QlQvRDJsNVpUeHd4NGY0ZWI4ek4zaXlH?=
 =?utf-8?B?Q2xqSlZEcFpSN0h0QTcvUFcvYVFXZ1B4RlRWajVxdXdGRWl2eUUxcWtaWmQv?=
 =?utf-8?B?bURuYTVqYWtUbmczSkFZOWJRVno5S0NNb1hFUysvV3JNdEJiOGdUYzd6ejla?=
 =?utf-8?B?dnVIRzljMzBsM0VlM3RuaTFmVmZ3dWY4K0pQVkNoSWtKeC9JK0VUV25FM3o3?=
 =?utf-8?B?dENHcDllN0dlbHltRTIreEUyelRFeVVXc1VuRGtQRkpWMGlKSVVURVRBbzNJ?=
 =?utf-8?B?dXNDYjRidzVwUEZ4WTRMWWFnRlVOQmJBYUdaMkV3ZE1jMjd0ZVpEYitKeGd1?=
 =?utf-8?B?QnlpbTJnOWV4SjErSHI3MWVqQWRLWTVDWFVrVlljdU5JK2lQOUtyV0ZlZGpY?=
 =?utf-8?B?S25iZXE3VlhVb1ZRYnZCNUdlcUpDMk1oVUtIbVNEak0rT0ZZaysrSndoZmRQ?=
 =?utf-8?B?YXlhVDJNaHNHTTdUeFdWakFDczAxYzFQbTErTWQvWGFkaTJxeEZkQ09XTTVs?=
 =?utf-8?B?WEVSYnpxODZ5MUxvK01hRWN4OElvWmhaT2ZnM0ozVzB4djFTSGlCNW9KbWlI?=
 =?utf-8?B?Z0t5RS9BbVdCZjBKYWxVOFJPSUdISzhwSlk2WXE4dzhMUm9iWjhMOHkxTDRS?=
 =?utf-8?B?MUlGR3ZtS0YzNEtidUpNaStwbU56WFpVZHBtdUlCZEwxM2FCZWZTUXZUZlNr?=
 =?utf-8?B?U2RQSllpeCtIY2xVNzlVYkh3QWV0UkhxZHdpdnQzaFppeDlZMUlmSTgxakdp?=
 =?utf-8?B?ZjR2Z250bVN6eWIzejQyOE15MVN3WXpHVlYvME9qM1NyYmtDT2pDeEhLeHdY?=
 =?utf-8?B?U0VrMkhRQlJFNGpkS3F4MTMrZzNmb2VDeHRZM0pBeTFnWFlrdm5IK2ZMaWF3?=
 =?utf-8?B?WlN0eFdKTkNiK1kvSHpXRkhBaVU2K0sydGR4UmZnVDhOM3ZyZGthMjdDelBL?=
 =?utf-8?B?YkxvVEtFeU1YaUxhV3NYb3dmL2UyV0FyNEo3TFNTQmpSSmtRK29SNXUyYjhZ?=
 =?utf-8?B?cTRCM25YVWJrMEQ5SHp1WGwwTzBVb3VyK1EvVjAwdndFN3R0bytiUDJHaGJU?=
 =?utf-8?B?RjFHVXVhN0dmYmdvT2dIbFZhZ0dFWWJoTUdnSml0bi83Yk0vM3haLzhRT09y?=
 =?utf-8?B?U2U2SElMelVrbDBxRk1BZ1J4V2JxOXdEME8vSGNwRHFaUHJ3ZGlXTjBqN21G?=
 =?utf-8?B?M1JWc3lDSW1sNzNmbnVHM3puTnBtRTJGNUhYbTVuaGRqa3hDTmlYUXhFMFlS?=
 =?utf-8?B?cE9VempzOXpkcXJpZm03ek5LMW0rT1RXcy8weDJGblRBODhNeldnS2pDRW10?=
 =?utf-8?B?YmRTZTdFSjQ3NUxDWDdoQWZZRmlpVEdsaDBmeE0wSzdSa0tuNXZzdlRrVklG?=
 =?utf-8?Q?MgE3eSKHHiJedhCcnJyWXjVgnOB8xFna5RZGlFN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb59b9e-3fbd-446b-4312-08d96985f8fa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:10:38.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUwbgMecOOmdMRYVGANRLx/4nMP3q/2bby/4gjPtQ6l4AiPv65f9UCPgxHOONDfY6oOL8AxPbUYpynMxNzuKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5741
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/26/2021 9:25 AM, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 11:11:52AM -0700, Yu-cheng Yu wrote:
[...]
>> +
>> +int shstk_setup(void)
>> +{
>> +	struct thread_shstk *shstk = &current->thread.shstk;
>> +	unsigned long addr, size;
>> +	int err;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
>> +		return 0;
>> +
>> +	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
>> +	addr = alloc_shstk(size);
>> +	if (IS_ERR_VALUE(addr))
>> +		return PTR_ERR((void *)addr);
>> +
>> +	start_update_msrs();
> 
> You're setting CET_U with the MSR writes below. Why do you need to do
> XRSTOR here? To zero out PL[012]_SSP?
> 
> If so, you can WRMSR those too - no need for a full XRSTOR...
> 

Because on context switches the whole xstates are switched together, we 
need to make sure all are in registers.

>> +	err = wrmsrl_safe(MSR_IA32_PL3_SSP, addr + size);
>> +	if (!err)
>> +		wrmsrl_safe(MSR_IA32_U_CET, CET_SHSTK_EN);
>> +	end_update_msrs();
>> +
>> +	if (!err) {
>> +		shstk->base = addr;
>> +		shstk->size = size;
>> +	}
>> +
>> +	return err;
>> +}
> 
