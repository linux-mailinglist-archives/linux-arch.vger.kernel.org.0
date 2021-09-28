Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9E41A490
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 03:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhI1BY7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 21:24:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:8976 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234467AbhI1BY5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 21:24:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224663991"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="224663991"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 18:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="scan'208";a="478434849"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2021 18:23:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 18:23:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 18:23:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 18:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ4Fl1rxA4eW7XFINdDKs2WOerCgIAJ7wO54orN7nh4wukEbtW3qKtb6fXfvs2o1/u1KedxNYDK9bup/uDpwriehMvEGEK8fNHpn42qi6+Q1Ij+i2285DAKYe+ZBt0GVOytwM0YedItQCYMsIWXjaFiQj+sJKnHXc2ZSBpCI06ya7l6A7YKNN+zvHR8c8Us6JJnna02OgAvhtqfZLMWCBshTyysZl4t6gFU0zUrM8qeP/8qu4B3P2DbdLJYqKeJapKcd0A/JeEZh0Vf7lP0E4RLdOVjnT56ynLpePAgWGP8v7xJVa42wfHp18YKSQna0AUY6ol8fDjbZ7pU+R2fr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uAvoAZ+M7PeSTT8hgxUfT0bLuEMvAwHJP/cDZbOjM+Y=;
 b=PU1sT9rkuqBgH1dpZ3R1LXq8s5DOBhbGQaDvxp8moK5lNY9A/ndunhocwj9msSn+bXmFQh5abeo+vOffnOgh7d4mzArrzIeTtqOa7bQyd85KPnBUmT+oVrLuSdDM293mgeyuIMVYrvzGJzd7vRQPY3REeJJCbisfrHR3Pwtz1uBEhnW1cLl4ThcbQy+11T2d44q/dDnOftGZz6uSHLvUIE4qlIO43QXA+//yILmnbOLVtToY/4KdvHScQpENwX8n6IU5ApOPsLZFaNRW9H3UtQaDwaZ3wGbG/f3hCmSVVgQXFq+3xAYryb0u/EzMd32YvkLjDT9Wdz1E7b8jNaPnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAvoAZ+M7PeSTT8hgxUfT0bLuEMvAwHJP/cDZbOjM+Y=;
 b=DmXzy8wvtGsVZFJ6ygnhfuI14bMgERJgRGxScQGi9VWzGbDHR3VMemQatYtnhT7llqcbsy2buba0uf1E+0PM/zA6idfWaac32IzJDU4IbXbU0idIxl3H+yjYmgj+ic0bSLfppXSuZPDHr+Z2V8hgGpycbUBbDpwx1nUKyniKW4M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3494.namprd11.prod.outlook.com (2603:10b6:a03:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Tue, 28 Sep
 2021 01:23:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 01:23:14 +0000
Subject: Re: [RFC PATCH 08/13] x86/process/64: Clean up uintr task fork and
 exit paths
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <20210913200132.3396598-9-sohil.mehta@intel.com> <8735pug50i.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <b58d369d-f4a7-f4e4-51ea-88cbfc0d8ac3@intel.com>
Date:   Mon, 27 Sep 2021 18:23:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <8735pug50i.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BY3PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:39b::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 01:23:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f5fd02-50ed-46cd-0bbf-08d9821e8ab9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3494:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB34946436CE69EF05C3B4CEB4E5A89@BYAPR11MB3494.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMSyIL9um9HjJ9VfedDeHcPerRjPMsbxBTi3rEkpnmJ/wkj+kv3VzYUqDZE0dAxmQYyjQvZPwLs4JQZbImsm+RwcOJan4oPbM6lQTOGBkig4uDydX7/TzvPLLLWVvFTv0QAKTYsZ3aLkicmv+iShxGbSOQYSG9YoOy1SYZ6FWwicTrB+37Zk2yCQ+ZCum20EkvLxDG7On7H79EFZHk/CCoh64shTgZ4STW3l1UZA2qvMPRilfONZfeGWAtLOtPGTdQ+wYHay6TyuRXnTwV6qoC4hYCApPRwWLEoWFfwicb0/ALGECukDj/VXbsh7h0Pl5JkospJyAlPYo6Xy7tidflL+LiCbv1zUAP2WMVYhqbZsp2YlLk+QMsjPKnLmIQt0sYEBAIm5PqNG6cbOzwBFWghZGn1A9GImyveZwN7NhI00zR7AErivNLIZTK35obmLVOb8QurCXCzaQWvlJOKYBNrlMJfjAjMI9VLjhjnO28FbcVhoiqFfara0t1z88zIzC0Q/WIz93dQaPOGvSGVNk+O1Ivcj02fSwO8u4Dfk4kutAF5aShFfT6piGsySGYp5rBqFiLFQjGMcJL2dKJUiaSZ/EpOJP9nogh/hk/xR+KxJH1wd50hVAYtmvuq7gIGdffjBtqjMdRzNoRXY/5vwbvWMY1pqNQsv2jmj/7s0+bROkUZ0t4yl0GrVmrXM05iuXx/rhp2H3Z7qBJR98k/lLHFvJZgv2hzTkzkYua085Tx8Wiu/DliRKEnP2f0Etgzv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(36756003)(6486002)(2616005)(16576012)(2906002)(54906003)(316002)(956004)(31686004)(508600001)(53546011)(38100700002)(31696002)(66476007)(66556008)(8936002)(5660300002)(7416002)(8676002)(44832011)(83380400001)(86362001)(186003)(26005)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllXNjJpSnN3b1Mrd25KaDlMdW1oRHhOdnpIQmE4aVJvZ3EvWTI5YUMvbit2?=
 =?utf-8?B?OUJnM2Q3YUhLY0lsTWI0LzNmZ2pFYjFWSXVJYy9qa0NDdEYwK2F3M0xtOTJQ?=
 =?utf-8?B?dmJQbVhtTXVpdUtOOG9SL2ZrTVJ2anY4RmRsM21TRjZjNVVodGhmUDZrUkdX?=
 =?utf-8?B?SU9RYWFDbVRMQUxhd3Z1K3dBdmcyZEtVNzJ1TFl2d3lnaHM4anVVaHJQUFpy?=
 =?utf-8?B?RGZ1N3ZiMUhGRmFjalhmQ2dJYWxBbFZkcFpMQnBHNkxrNno3VzZCb2dLNmRi?=
 =?utf-8?B?UStjaWVGNjBuWjFPM25NTWMyYnhXTnd4UVVxTmJXVnRMMUhDdGlxcmVFRzFt?=
 =?utf-8?B?WlJJd2pKT0NZbmpRai9jTEpTanczVmJDcUhuU0lnU3Zma0JHVTN6WTM1b2l3?=
 =?utf-8?B?b3AyenJiMDhnN2prU1NselNRZlFkOEU1ZUhsRkk0S0hIZ3k5aGduQ2VUU2hH?=
 =?utf-8?B?YkFiL0hCSDQrc21vcTQyOUxLZWNYS2xUOFVwSDFyd094cFE0NTlyZGVtYWN6?=
 =?utf-8?B?ek1XUTBkRW1nS0JoOTdvd3QrbGdSOE51R0tiT1g0OGpNbThPb0RTbEZWSFBp?=
 =?utf-8?B?NWMvUk1aemZxSDdxT0Z6R1RQVjgyakJPSVRscDVFSCtYdWszdmN3MFRtWGdU?=
 =?utf-8?B?bUV0WFNmWDNvOHhyVm9Mc1R5NGJaeXJ5SnV2L2wweFJBRW1acG4rd3FNUTBD?=
 =?utf-8?B?VCszamNCcGpGNzlwbStoN2lLVDA4SjZtcXg0OEFIeDZ3K0ZROTRBbzU3ZFJV?=
 =?utf-8?B?RE10YzNjdG42dFNHU3RXNkFGQThZRWRUT0dnYzZvVHpTcHdTTTk2Qm5vbW85?=
 =?utf-8?B?VXh5MmFxN0x4R3Y5N3g1dXh6UXlOd0lLR2YyOEd1TFlGVHR5SEgyME1ITFBh?=
 =?utf-8?B?N0s5dXE0UnFDdVZERk1pQUpxak4zM2ZkQnd2REh0eHRaQUdJaGxqWDlqUkJD?=
 =?utf-8?B?dHMyRlVvZmdaOW81dWNqbmZEcnIxUkRnbDh4alRMNk84a1oxbVNaMURHd2pS?=
 =?utf-8?B?SUUyK2t1cXVMK1BhWjNHekg5M0RlVEZMWklRL2IyNVpWaWQxTEJ0eEhpUmhS?=
 =?utf-8?B?WDduNUFNVjYyaHBOSkJGRWJTSlVqTUtTanNHUnBTODRyT3RkS2VMZEx3dlRz?=
 =?utf-8?B?RnpJZUtYZ3VnNEZ5bTdBWWFjMWRVSzlUV1FhMVdmdUlNbXpjZXhVNzBtZStp?=
 =?utf-8?B?bEhzSnF0WlJKTWd1R1dGVkozdzlSUHl2c2tTbTZOeFgzOXBYenBYWXlwTjNC?=
 =?utf-8?B?L2l4a0NRQnpKQ3QxMlVPU09mUzRFRXdJYVVIbUdTa1NlSk9HVUY1OFIxUStm?=
 =?utf-8?B?eWJOMU5mSkQ5bFRCemJhbGd6VkZzS1FIbFR5TDNFb1BMNGI2Q05oMkRWMndW?=
 =?utf-8?B?M2tsb2tWV0JuNnFXU3F3bmUyNEFrUk1Pb0tFNmo0U0JseUdQWldYcE43a2pK?=
 =?utf-8?B?dlE0VmF3MkgycStnRjZYQlY5K2FUWjE4aDhtNU04aXp6WnFtVDgxemR0cHBa?=
 =?utf-8?B?NE43SUNnZEsrR2liRi9zQmNadU16ZklnNE81cHFhTDM0TTFndW50MzhLYzZ3?=
 =?utf-8?B?ZENWUmkwQUdBREUrcURQUWRiVkVlV1IyNDZscmNWRkR6VTB3UHRCdy9neUEv?=
 =?utf-8?B?TFFMYXp1YmxtNHdWRnVSaSt0OEYwaTAvSlZjREtNd2hCMmNYWXVWUU5UcGE3?=
 =?utf-8?B?ZmRETi9zeGwrYnFXS3BFYTdRalRETi84N3Evd0phVVFEMnEwTTlEbXlsU1dS?=
 =?utf-8?Q?/9vfqqu23Y2OXwKJOx8Fzvmfb9qDTXtQF2qQ+n3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f5fd02-50ed-46cd-0bbf-08d9821e8ab9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 01:23:14.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X7A0NK07p1+ywWR7ZUudi8YMj0X7BjkPsik1KZrtgEWSDKKFw0Qinbbwy15iwLgKUhw39AzIYdk3lgubETrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3494
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 6:02 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>
>> The user interrupt MSRs and the user interrupt state is task specific.
>> During task fork and exit clear the task state, clear the MSRs and
>> dereference the shared resources.
>>
>> Some of the memory resources like the UPID are referenced in the file
>> descriptor and could be in use while the uintr_fd is still valid.
>> Instead of freeing up  the UPID just dereference it.
> Derefencing the UPID, i.e. accessing task->upid->foo helps in which way?
>
> You want to drop the reference count I assume. Then please write that
> so.


Ah! Not sure how I associated dereference to dropping the reference. 
Will update this.

>
>> @@ -260,6 +260,7 @@ int fpu_clone(struct task_struct *dst)
>>   {
>>   	struct fpu *src_fpu = &current->thread.fpu;
>>   	struct fpu *dst_fpu = &dst->thread.fpu;
>> +	struct uintr_state *uintr_state;
>>   
>>   	/* The new task's FPU state cannot be valid in the hardware. */
>>   	dst_fpu->last_cpu = -1;
>> @@ -284,6 +285,14 @@ int fpu_clone(struct task_struct *dst)
>>   
>>   	else
>>   		save_fpregs_to_fpstate(dst_fpu);
>> +
>> +	/* UINTR state is not expected to be inherited (in the current design). */
>> +	if (static_cpu_has(X86_FEATURE_UINTR)) {
>> +		uintr_state = get_xsave_addr(&dst_fpu->state.xsave, XFEATURE_UINTR);
>> +		if (uintr_state)
>> +			memset(uintr_state, 0, sizeof(*uintr_state));
>> +	}
> 1) If the FPU registers are up to date then this can be completely
>     avoided by excluding the UINTR component from XSAVES

You mentioned this in the other thread that the UINTR state must be 
invalidated during fpu_clone().

I am not sure if understand all the nuances here. Your suggestion seems 
valid to me. I'll have to think more about this.

> 2) If the task never used that muck then UINTR is in init state and
>     clearing that memory is a redunant exercise because it has been
>     cleared already

Yes. I'll add a check for that.

>> + * exit_thread() can happen in current context when the current thread is
>> + * exiting or it can happen for a new thread that is being created.
> A right that makes sense. If a new thread is created then it can call
> exit_thread(), right?


What I meant here is that exit_thread() can also be called during 
copy_process() if it runs into an issue.

bad_fork_cleanup_thread:

     exit_thread();

In this case is_uintr_receiver() will fail. I'll update the comments to 
reflect that.

>> + * For new threads is_uintr_receiver() should fail.
> Should fail?

Thanks,

Sohil

