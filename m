Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812F641A3FB
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhI0X7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 19:59:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:5506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhI0X7P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 19:59:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211838169"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="211838169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 16:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="437891971"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2021 16:57:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:57:35 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 16:57:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 16:57:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 16:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtKHAOlD7f9/11wfn2cCG2AgNHRqIm/fAXGGvCaTR+6dDxEfREPKuXrE38rG0Dom2SaSZ4FcIZFqa5A35U0Jy1XF154nqTF0R8GtFk6Dv++mrJNi9NrkfLlIxoNkU3RdcBxgmqoWO+dnJz7BWYiDlfC+kXeKHhFXqwwPlPrfvGGTRTwNuwGnbolKBCx/Fin7Wv/FCR5H2GOUzkMkPrCx02Mi/zr6G5/uq7HCIt/Ia7wCugoXq7AMsXFLLn+rvuLIMHb85M+oBFJGdQoDFxiKFQ8XQDtk4ZXfWxNTxHXlcxz75eXWr10y81m4Ak3SyCyMJfbJYXTc7u+3Lg/yFnzKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xXLepXz/gQ4U1+e/7Z1q7XGFxD3QN9MRzCbuW/LnHys=;
 b=RPDMSMExlcn/bD/fxjr3OEwpfikiDmjN5azEBbTanufbbf0t8o+Sw4VMNwswETKIE+l9WdntzBPXw13ZWEnvIRMpx4wFYEdZGjXVlndLMxkXcwHDz2jvIbIHioC9XCLOnuF0+BJ+TZyRpIL5LSVdhNJ/hTwlN8f1zqro2UGQ/CBelki6tZITr93yKldVyImHETI0B7QXHRxQ4HrYm/7tmwQg+Zo1dS3jlz85JHsLoFpW9vpqliGBdWQReKxqTv4fU+G9A9Q3HwCiLDZ3i/opGxiVk/7ibRjx+C8SfriajK8YN75oHBgLUFhWeHZVankqGOj6y1K/B5K6lQcTUgqRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXLepXz/gQ4U1+e/7Z1q7XGFxD3QN9MRzCbuW/LnHys=;
 b=LPwyOgeSQVB8hlFJKZE3tpJFLvmTotojw8EZNcrC6YoDZ8QKVR9HXGk/n6Z9mK78hTobGSoKumiaHdkXcTSYj/lrr/65899s29+4oHiArOn8RPROxBxSAE5QOE2PIJ6VInhDsuj41UkDEW8fnknkDTouFJFoOZETU5FJep1i04M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 23:57:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 23:57:31 +0000
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-7-sohil.mehta@intel.com> <87czoyg88k.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <0d809734-af87-cbf6-80b4-5b10bd819b35@intel.com>
Date:   Mon, 27 Sep 2021 16:57:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87czoyg88k.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 23:57:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa486b2-f12d-47a9-ddad-08d9821291b0
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4975:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4975BBE04049F24CC4ACAFB0E5A79@SJ0PR11MB4975.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIMMxbjBNqoSnJ8We0flOBGu7PednbF6XHQIsOBb3gWPQmGjbfH6l7l28e8CX7dfT0VSzuas3D6g04COCKT//PdSL0cguwf7g0VXSqT+7HgrWvAOewJOtCIKaFgmVbceoXfu7buWrEBm746ehd8kw8GktaQkDvz5ahyXHaXgi5B+PDhBtg5zBqe8y70BXVfg0EOTLtlQRjwZAbvjZ7ALo+o4gRDikPWtHCc8EkQN44T2so8Bj/S9KkguFrhnHde9fDCeWXMvbOkuYvJP1NhQFJdVk/204KjtB6/mqf0NUrups2mpqgx7Hn91F0a7V3+iqVIxx6U1wDo07mluEVNbkxsjhw+82aBhots2v79qHWtQ2Pbz5LARG0rCNKVXgUgWETKrnYG5f0b7MKvXXDAATzk1TCqpFKmaWnFilbmQIdoS0wfYRb2KW3qUELhmO1mN2CaklP76+7AoCh/tNgwLIyIYnlGZONegWyA1Nr8gYhVD4EZKLJpENs2HW1cJKbKQ/oaV3M0bw9NIkr3VOeKANnEyxgJiUz8rhHC/dkDy4ztvzsZ59JP/iCZS0SFLj0LQ/davS2JYODAk9wobtiMUJ5W9B+SKwwmXs1hTBi7LADnyHn/M1XjzxFzRrayNU9Oyo8qmKrA/vLw8ySx8kqMMedswkOXV8BHBI04eJcDv1B4fM7Eobm3tS5COyXqiqyg4YSe1lxu4GJysYBc0Ga+nEiVV/nGvKVgPw4xUcHx/d9PHim3zCBq+yRX9X1szSFeW+h4gEd+HubX4GV3KFaqTnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(31686004)(956004)(2616005)(4326008)(5660300002)(26005)(83380400001)(8936002)(86362001)(36756003)(8676002)(6486002)(53546011)(31696002)(7416002)(316002)(66476007)(66946007)(16576012)(54906003)(66556008)(44832011)(38100700002)(508600001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ozFVgRHZJnsyCU9ofrSMgMoD/JVez2vtAwN69iSXk924gThkinSD66S2DTIZqrMAncQJEbCdNI7HKZEc9zy6UQoHWfU348eJnoCCsouaI8q78MEmMOGysa+T2cxEZYpUqkF3kXyDV4pV0rZdaiWu/uh7kEdzPnUIeSJXe6UCbljLuJB54ea7RPo0gAO4OAAjIlutJrSuwfFlfyIVJSufRU18vwgBNNvSKq24GpUQWYk1j/YuIXHgXFQpPabzNLqaadMMleazHV3YCCb2K2OdxZFqEwQaljeVtT1xCpXGCrUS4pA2AXQ9h02ui+fgJe61h4OGyUP+1VxO+j3G4Q/Hye9p2lEoBbqpAasSPI6dpYVZBFnYmheBl5+cUE1sjrIjUC1KD8GR9AFjPY5Hxp9VB14XE0Ncxfz43QvSii6fn1oloBIgkcsb4g8YnAdGvFFfnLlSX/8gfzO81xPntu+5vjXgECV6VxjsWT2D/0QemHUWeVVxSn8i2R3TDdVThe15wmv6ahyQcYVSaQcQc65PezJBTfKBX4PHkmnKESCMbDeaAI2qCs1MTL5OfCO9X+hwGo96qABISorMEFXB0KaZBkYi8ya30EJPA9THjWCfCq34FUo8MhFdho9IWKLz9mcf0AKeJwIoctC7fky4CFKkgrraUYysf+7AByfSI5wPcjgXR7FPnBIOqbZLcoUNPLm8gz0VCQThLEmQK3Sk0IoTI7881hHjDz+DNlK1XdCk7VnIkqoEcMCa2vh6ZrDnq9dF
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa486b2-f12d-47a9-ddad-08d9821291b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 23:57:31.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzLUH36EpdRV1HCjRjr5/O+fZT4LZNNBQkyVjnFYO0DhDPZcY7Kq4quc2Dgq/mbwauXliepxlJ16YBLG6zlX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 4:52 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>
> +/* UPID Notification control status */
> +#define UPID_ON		0x0	/* Outstanding notification */
> +#define UPID_SN		0x1	/* Suppressed notification */
> Come on. This are bits in upid.status, right? So why can't the comment
> above these defines says so and why can't the names not reflect that?
I'll fix this.
>> +struct uintr_upid_ctx {
>> +	struct uintr_upid *upid;
>> +	refcount_t refs;
> Please use tabular format for struct members.
Will do.
>> +};
>> +
>> +struct uintr_receiver {
>> +	struct uintr_upid_ctx *upid_ctx;
>> +};
> So we need a struct to wrap a pointer to another struct. Why?

The struct will have more members added later.  Should the wrapper be 
created then?

I didn't want to add members that are not used in this patch.

>> +inline bool uintr_arch_enabled(void)
> What's this arch_enabled indirection for? Is this used anywhere in
> non-architecture code?


I'll remove this indirection.

It is a remnant of some older code that had uintr_fd managed outside of 
the x86 code.

>> +{
>> +	return static_cpu_has(X86_FEATURE_UINTR);
>> +}
>> +
>> +static inline bool is_uintr_receiver(struct task_struct *t)
>> +{
>> +	return !!t->thread.ui_recv;
>> +}
>> +
>> +static inline u32 cpu_to_ndst(int cpu)
>> +{
>> +	u32 apicid = (u32)apic->cpu_present_to_apicid(cpu);
>> +
>> +	WARN_ON_ONCE(apicid == BAD_APICID);
> Brilliant. If x2apic is not enabled then this case returns


I'll fix this.

>> +	if (!x2apic_enabled())
>> +		return (apicid << 8) & 0xFF00;
>    (BAD_APICID << 8) & 0xFF00 == 0xFF ....
>
>> +int do_uintr_unregister_handler(void)
>> +{
>> +	struct task_struct *t = current;
>> +	struct fpu *fpu = &t->thread.fpu;
>> +	struct uintr_receiver *ui_recv;
>> +	u64 msr64;
>> +
>> +	if (!is_uintr_receiver(t))
>> +		return -EINVAL;
>> +
>> +	pr_debug("recv: Unregister handler and clear MSRs for task=%d\n",
>> +		 t->pid);
>> +
>> +	/*
>> +	 * TODO: Evaluate usage of fpregs_lock() and get_xsave_addr(). Bugs
>> +	 * have been reported recently for PASID and WRPKRU.
> Again. Which bugs and why haven't they been evaluated before posting?
I apologize again. This comment is no longer valid.
>> +	 * UPID and ui_recv will be referenced during context switch. Need to
>> +	 * disable preemption while modifying the MSRs, UPID and ui_recv thread
>> +	 * struct.
>> +	 */
>> +	fpregs_lock();
> And because you need to disable preemption you need to use
> fpregs_lock(), right? That's not what fpregs_lock() is about.
>
Got it. I'll evaluate the use of fpregs_lock() at all places.
>> +		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
>> +		wrmsrl(MSR_IA32_UINTR_PD, 0ULL);
>> +		wrmsrl(MSR_IA32_UINTR_RR, 0ULL);
>> +		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 0ULL);
>> +		wrmsrl(MSR_IA32_UINTR_HANDLER, 0ULL);
>> +	} else {
>> +		struct uintr_state *p;
>> +
>> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
>> +		if (p) {
>> +			p->handler = 0;
>> +			p->stack_adjust = 0;
>> +			p->upid_addr = 0;
>> +			p->uinv = 0;
>> +			p->uirr = 0;
>> +		}
> So p == NULL is expected here?
I'll fix this and other usages of get_xsave_addr().

Thanks,

Sohil

