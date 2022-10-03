Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5011F5F361E
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJCTHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJCTHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:07:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F340561;
        Mon,  3 Oct 2022 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664824050; x=1696360050;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zafDxq0OqRGwMfCJcI1Io5lt/Z1tQ22Wtna6lDJTc3w=;
  b=J1Xgcus3nRkg+6/ClAgCdGp13cVV6gNm1dSaVDUws2s9G4BFSyQR/A86
   hUMdt0ClEetn8Funfade9RzkxNSV0QqdIl7xZ00Deb0jE0LQJOAnwHZO5
   8f+AneIj5GlWVkZkrKrBDErTBbV6fOffhuzq2naHM4BUrtkNEsVVQ2gSr
   CUmrfUwYGMFA3NNPmv+FVBjcEfusLcqmE3in4TTOSvfY8OA/D4ERzGTzL
   yhGHGmWMKq4g/JPtQC2YtkAKtUKouOL09oZdcG2bA1MxSo+Unaiz+EpHG
   2kAHsf4CeyLyjYSl0zzI0fPvC6xl5+snGo9cs2h0bBhr4cAwjrVMUXzCz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="282448294"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="282448294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654492595"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="654492595"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2022 12:07:28 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:07:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 12:07:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 12:07:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 12:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGahc+5TCPsrmbBe/Cu4pENAWkOCOuJ/4Mj0JChZNJHaum4EhDk/FVwAwyKG6BXuO9F2iuiNO04dFwPoAQNanKLOKWKrPc94cODh20m9QIomc8bNJbRSBiGvMbpqn2LqMaYD1t7EsHyy04RoWFyD0BO8CrSpg9otUCPv+nz77ohZjrWxAtBsZcoGSH9vsNhDmUsE/2MLi8bbyL7aFNCAmxsLrWFNgsmQ1bRe8oEt+FDaMPvMYZsiorDBrWyMrVT+ios38iRLPWQ7XX3ZW4bkuQD7yJ1nSplk/L/2WstJZgty8aNMsWUIdMXFoHeCtvBeXMUW+B1wTjB/T5EQZrtKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpxgdc7L0s9zCXIVTW06BYWKNThhtr66M0VB06SymHA=;
 b=gQRVW6MBKkPsLu80a90ZEp2layqEeywCHnnaZj6oHlbmI2hBHd6W+C2yXFHPiS4NZU2hXHAAg3O5wOGxNYddbLHLVVaD6xZP1Fw6wIYnj7ClymF1u3q8qWVngKiu9vsaHtG8P30dWx4jYEQXl3nH+tjo0ejEBhNhx2nvT2yut7ZQfHEhxoYVrwOmGXc/Ix7yrGmZ8wvaoGANvbEmIgrDDcfyKLYjnJRqjjWZTFhECp9wUoxTdOxU1q8tnrrUTXawxrQ0g3oxIwmNR07qUfvONQcCaKkvN9knCBKc7ociCY2xSzxrXZpOQqjzU+17hyFyqb9x4iTd/JommnRGd1Vz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 19:07:22 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%7]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 19:07:22 +0000
Message-ID: <8c1d2951-1f95-774f-cc8a-35b7d69c521e@intel.com>
Date:   Mon, 3 Oct 2022 12:07:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [OPTIONAL/RFC v2 36/39] x86/fpu: Add helper for initing features
Content-Language: en-CA
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <joao.moreira@intel.com>, John Allen <john.allen@amd.com>,
        <kcc@google.com>, <eranian@google.com>, <rppt@kernel.org>,
        <jamorris@linux.microsoft.com>, <dethoma@microsoft.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-37-rick.p.edgecombe@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20220929222936.14584-37-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4810845f-174f-4dbe-e2b0-08daa5727fef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1esnTGSNd0O7shD/q3rWlArZiEbEJETqBZaBih7i8kBsmj65kCL1R1u4loRjyAM8sTszwbd/MOHW1oA7VrdfH6vw8n+AtSZXHUVW1iHRG8/gkyTWGOGRBYb7WZokb2EErK9BzLW2GP/XzOrMJBHZwnc4QusqJMFCCOtJZSb2OKwhiGpcllwVPPPC+qYRzEm5UVqje+FoX+320JlN316Jf2dRNM6WEDPVeJbIJS/H0jSP6HXLGV4Ksejhw1DRAP8qVmSem/xzIREihDoXYDfAeWAbR7tWPHKEgpkheKh11IYfdZRQYHQpoK1Xf2YaY3v6iqn9Co1l8DmRKg060bbJtXKUrlSPqGIohgLxzFb5CYq/QlGsriFtWcp8O/lnzk8rTG1zMG6qakLh5iQXnj5vKC21k5C0ZqL4FKzVd0bSqJSJxpJnt3kzoQQAfyOWjT1LcTEd95pzXXRWBJ0wMo0zTmAMq4Lu4fKxJrdSYDG/D9dV2KG9Bz8Kqlp7jAwimnJFSGddb5hchdZ22QCuaXW0Z0msQbrgYN4Rlj97wmjy599FpbMB6itghfcW+5UUqjnwyRQPM+sg5+DfJVK6R7S+nEerJWW/K+22aPd4TUreemZ9Wk+7hHRqYNoZ4zNgvbgSGIyhXL4to33XvYecJ++xy/zxoGmF54wDmr0BN7nRepTmDrQPVmZN8kArdCEVqI7ACaQsTChPgORSSgRIwz/GZHVdd7iYdKzB0RLPzNjBhXn98ceXSwQIFMAovsA80COvsIwkpvP9kGOqwfLPdN4tZ0oIBks5Lvo/hAFQMWuepwPlAmI2pct9FZnyQhP0XO0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(7406005)(31686004)(8936002)(2906002)(7416002)(316002)(36756003)(110136005)(478600001)(66946007)(31696002)(66556008)(86362001)(6486002)(66476007)(8676002)(41300700001)(5660300002)(26005)(83380400001)(2616005)(53546011)(6512007)(6506007)(186003)(82960400001)(6666004)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJ2NGlpMVpERU1yNnBEVHpLSGxVa250blcyMC9kelY3dG1xOHJnRnE1SDdS?=
 =?utf-8?B?WnlqckZ2U3I4MXRPd2YwL3FBVHFxYXo0VlBONm1RTldZSFcwemRKUzJUd3kx?=
 =?utf-8?B?dWIyTmlpOWpYUzZJWjc4YWFoclExTG4zaXhiZEdOZ0dKT2xlbzVzTGszdzY5?=
 =?utf-8?B?clZUZ1Z5cm9raXRyM0hvcmk1TUFIWGJabUFPd2plRTdGUDM0dG45Z2VSZXhx?=
 =?utf-8?B?YkRjUWhsV044NWpnU0dQcHI0bFFncmdoQUUwaXJvZGJSNlllM0tyU0luRzFC?=
 =?utf-8?B?dDJXNVJqaFgyaFd2SmZtNUNjT3ZZMjhkSlhvSllsQTh0MTNMOFlhYm5nTng4?=
 =?utf-8?B?OWRSdXQvSGZTV051U1cxcC9vWW40NmN3Wko4UHhTWTd4UzhkYnA1bWtZWmhV?=
 =?utf-8?B?enBIbXRrcGw3U2thSzZTTjREcUZ2bitXdGtHSWZHckVUV2hpNTRqc2JQb0k2?=
 =?utf-8?B?M29vRmtvK2J2NlRDM1VDRnlCWjZHZmZuRTk5ZE5IRTBEMEpwY0tGNTJTNmQx?=
 =?utf-8?B?UGhFdDNVS01pcFpOYnQ1emU2SmxWdVA0ejYwMndwSHcrZlFZWXVsN1JmdVFx?=
 =?utf-8?B?Snd6a3A2ajFKaGpRV0ZCdXNKcGk5UTVJU201cWNsdmx3dkhiQ1A4YmxXZExx?=
 =?utf-8?B?Zm9VMVd6L1R5NDhPdER4Y21QVHBnZitOWUU3cWNLeGpkelN3NEFKZTdweGxq?=
 =?utf-8?B?aWdTcUcxZlR3dGlDaEtzaURUcDdMNjJHRGphcGVVaDZwQkt6RXhUdDN5WmFB?=
 =?utf-8?B?OW40amJ3OExWUnNobXVDcUdJM2krWFdkMERPY0NLM0VhenhoRUdHSFFwdE0w?=
 =?utf-8?B?Qjh5NEk1ZHFZR2J1cnF0VlpsMTdKYlJhTGVuNHN6OUdNM0ZhWGVOSmdwcE9y?=
 =?utf-8?B?QVBLTWc0eXJTV2tGaHpQMDZLQktoZ3ZzTUJVcjUxRmQ2czBCQjdibXRxcjhy?=
 =?utf-8?B?TDROWTlGbU1rbVZxQVRpQXRwa2JmeUpiTkYzN2F1Y1NSTVo1N1gyZ3hoUFJP?=
 =?utf-8?B?UTdWNEFJZXdId2J3QVZISVZsaE1BaFExLzRUU3dTNit1dDV2QlIwMkh0T214?=
 =?utf-8?B?UWpiOUxlWFlkSFg2UWhObUs5SzZnL2RJRGFWK1hMcTRVNmxaZnhMQTdZSjVu?=
 =?utf-8?B?WkpkV3I2dWdmakV0UFlUQnBVMXB5NEw2REo0bWZxRkVtQzZsaElrSVUxcjh0?=
 =?utf-8?B?NGRHaVZEa2hHWFVEa0haZGFYSDRQdVRGK2ErRW5QODhNR24xTU5IUjdaQVRT?=
 =?utf-8?B?aE0xbnhDVE1reWlOMTllRGhQSWVIOU1iNFRreENodUI3aTJjcmpzd0xVTDE5?=
 =?utf-8?B?S2E2U2ozRVB3dEJyV2dkS3hqV05RQlFvL3FkcjJIYVB1MkR4Rm0zbG9GY2xL?=
 =?utf-8?B?Y1REakY5TmZGT2NmT3ZRSHE4ZjNXeUY4eDJFVXFZam43SzU4c1NYYkxHaUNp?=
 =?utf-8?B?eTFUTVJkODZ3ZlhFWS8yZUhhRExOY2JqUzNMVFo1V0o0T2ZZTTdqZkpVemFp?=
 =?utf-8?B?WGZleDlZQ3VObWxZQW40T0JBbWEvSzZBeC9iQm5VYUYwd2ZsaUc0TUl3S3lw?=
 =?utf-8?B?SWFYUkczYXM2b2JGeDN6eGVRNy9ZWWMrTDRvMFR2ckF4RmVuUW9kc3lWK3cx?=
 =?utf-8?B?ZkpYUjFLWDEwNzkxRlF6ZHp6UCt0cTQ1QUtUN3BRU0xiN2xVUEZYSnQwYzJJ?=
 =?utf-8?B?TEJWU0RSMVd0TTNYcXRhbmtwb0JJT1ZMWmdoc2FzZHNraERudzZSWVJkTmY2?=
 =?utf-8?B?a3YrTVA0UnRVcXRrNHhsSFB4aTNRRlFOWkg3SGFxMlpDTHRnRGhwOC8vQ3l6?=
 =?utf-8?B?eExYbzFsTlY5bFdlc2hmcFFZYkQvbjlBcG9JQ0MybzZpSTBCN2hndGV6NCtO?=
 =?utf-8?B?dEJUU1N5TzR1bjRybDFJSVluOVh3RDNVUjJIRjliR1dZSmRnR0FSbFc2ZnlW?=
 =?utf-8?B?ZzhNL1ZlbzNJY3pRdDZOckdBTjV2dXBYaHhvd1ltU3d5aEZ3cGVTUW1VOHB1?=
 =?utf-8?B?QjdkUVo1RnFtbDNjZkpQV3c1WmxEWmV2RGFjT3NXVnkyZ2NHSG1BLzhYU0pn?=
 =?utf-8?B?T0ViaWJ0NUNSK2tHS21ZY2tabXpaWUJPWmE3akZwNlRaTDZ6QnB1a0QvUVhO?=
 =?utf-8?B?djRBc1Bmd0JuSSthOXR6UExNeVE4QWp5S3N0bDhGbG5IdnBpUUxYV1d0Sjlu?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4810845f-174f-4dbe-e2b0-08daa5727fef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 19:07:21.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV+5mUgSM2F5B4WEgcBuwYk4LeL5rwZVlcERxzKetfr45cOm+rgLujh8Nf4JhidM255LZgxfRd3mUEwJx2k8Iw5Kk1rml3ux+x/cwCWZSpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/2022 3:29 PM, Rick Edgecombe wrote:
> If an xfeature is saved in a buffer, the xfeature's bit will be set in
> xsave->header.xfeatures. The CPU may opt to not save the xfeature if it
> is in it's init state. In this case the xfeature buffer address cannot
> be retrieved with get_xsave_addr().
> 
> Future patches will need to handle the case of writing to an xfeature
> that may not be saved. So provide helpers to init an xfeature in an
> xsave buffer.
> 
> This could of course be done directly by reaching into the xsave buffer,
> however this would not be robust against future changes to optimize the
> xsave buffer by compacting it. In that case the xsave buffer would need
> to be re-arranged as well. So the logic properly belongs encapsulated
> in a helper where the logic can be unified.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> v2:
>   - New patch
> 
>   arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++-------
>   arch/x86/kernel/fpu/xstate.h |  6 ++++
>   2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 9258fc1169cc..82cee1f2f0c8 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -942,6 +942,24 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
>   }
>   
> +static int xsave_buffer_access_checks(int xfeature_nr)
> +{
> +	/*
> +	 * Do we even *have* xsave state?
> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_XSAVE))
> +		return 1;
> +
> +	/*
> +	 * We should not ever be requesting features that we
> +	 * have not enabled.
> +	 */
> +	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
> +		return 1;
> +
> +	return 0;
> +}
> +
>   /*
>    * Given the xsave area and a state inside, this function returns the
>    * address of the state.
> @@ -962,17 +980,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>    */
>   void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   {
> -	/*
> -	 * Do we even *have* xsave state?
> -	 */
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE))
> -		return NULL;
> -
> -	/*
> -	 * We should not ever be requesting features that we
> -	 * have not enabled.
> -	 */
> -	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
> +	if (xsave_buffer_access_checks(xfeature_nr))
>   		return NULL;
>   
>   	/*
> @@ -992,6 +1000,34 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>   	return __raw_xsave_addr(xsave, xfeature_nr);
>   }
>   
> +/*
> + * Given the xsave area and a state inside, this function
> + * initializes an xfeature in the buffer.

But, this function sets XSTATE_BV bits in the buffer. That does not 
*initialize* the state, right?

> + *
> + * get_xsave_addr() will return NULL if the feature bit is
> + * not present in the header. This function will make it so
> + * the xfeature buffer address is ready to be retrieved by
> + * get_xsave_addr().

Looks like this is used in the next patch to help ptracer().

We have the state copy function -- copy_uabi_to_xstate() that retrieves 
the address using __raw_xsave_addr() instead of get_xsave_addr(), copies 
the state, and then updates XSTATE_BV.

__raw_xsave_addr() also ensures whether the state is in the compacted 
format or not. I think you can use it.

Also, I'm curious about the reason why you want to update XSTATE_BV 
first with this new helper.

Overall, I'm not sure these new helpers are necessary.

Thanks,
Chang
