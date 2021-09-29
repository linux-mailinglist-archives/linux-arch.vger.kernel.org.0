Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D326E41BC10
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhI2BK5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 21:10:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:1085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243507AbhI2BK4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 21:10:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224875272"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="224875272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="587760773"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2021 18:09:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 18:09:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 18:09:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 18:09:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 18:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVhnV0Ka6A4FKFByKX1D6OwSSWsbogghRfa1tPdCgcaeZKP1JeestAb0oLWpbjRHfxZVvgpxcY7xyuEIVYXzYi9M/PBQ0P3wSfy2AYmjFUAh/iSA7qY5XubWZEVPq9ABSvG3JddGFRDubwDpoegq+laz2SBnE2K7XSTBCEoCcDU9nkE8zu+mXy4JnpoLK3rq50sGayj3gp26+6roJUV+MCVy8oef9Mi7P1Hg8I2U84ARkLstgmuCPgtfbXvrSTgOmmVAnB0rWSUz1FIaxTXbf0gJO2hXTD8flJZ1bzC65O4batJjr3xhjFkfPDNzwoXe9263tgX+CHO5uco40K19CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vH6aHT2OAItDW62P5WSCzkjh93WyS50UoGpRu4YyxR0=;
 b=OBc44vky4N8enuNvVy4jm6Xg/J0rUe3civ8Ke+9zXFMD1hKet75/w0/h0InasE62pxLSGLqcpzV0vaeOSMbBlKdkuwJXfmg0fRDNEWLa6Cj/NDUdh5yANKcgP+yssmFtxXSD04L6acTCvfo5s2lS4Xf9q65OLTcaZtE8lj8yRo5AcrmCOzCWfmN6xi+qSvNNCXTt3EnynRQ1u2JFSOnBUn3QgLus8NiYsmT116QW682D9KUMRccFMZ1bT1bLTuqtYYoYb3chdOVKrggR6y8sErI5Ibt0EQBJsmB9BNT/RZ88iBrAT5PMKKEiQqdNOXYKUL7SGTq5/ue5g1Otfcf0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH6aHT2OAItDW62P5WSCzkjh93WyS50UoGpRu4YyxR0=;
 b=D+bcOc3LFXjVzudKvHmT+FDxZeUO5xMIKOqk4ScaJahvnfT8S9V3dPVWDZAENaaLa1a64zYdh0U3UP6OgtYqmGUbnWC96yfhJkcuVwYixfteWDddKuLGGzZrwfJFYfvfTLzLyAFSdgnCCi+qWpyyBpy/LWwagvE9R0rkWCRjoZw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2582.namprd11.prod.outlook.com (2603:10b6:a02:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 01:09:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 01:09:13 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
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
 <20210913200132.3396598-12-sohil.mehta@intel.com> <874ka7csce.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <c937b960-66c5-292c-d020-bef447e02250@intel.com>
Date:   Tue, 28 Sep 2021 18:09:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <874ka7csce.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:33f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.12 via Frontend Transport; Wed, 29 Sep 2021 01:09:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6811b5ce-4da2-471a-9972-08d982e5c00d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2582:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB258248EC6CD54E4F9DFAA1A5E5A99@BYAPR11MB2582.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiS8eoLsrWrcXhaL0qHiR7HN0fGGZshuJkGTHpCLe0q++Lt1ePEuADFiJPs64Iapf2WD0dy05nmRlOOPNjRDV2eTocssIMfwyh1iKCH5ArtlWHgSrT1V/ACUhKciZDmOHppZlRi7eakeA4XIMUmdlFS9YeFXgkMid2hhgEbVYHnOMs/hCRrERP8mx5+NheznHf9p3CIanUNR+8R+llueYEuv8kc8YebW05g3X3untoUc1wsrZ6g2PNRpH+cx2DEPiFAxbVm+dDtwKE2lgPT4EAHFhX+uK9uB+z9SIzcCT9gneq5cF7MixKv6oXWV/Pdu1OuorcoM7/5voyeAo47pCdczCfsTVtZx0VKi2dJMpVrgHfLzLZp2tpveNu3byIMQzm4TkbklqCpOpCAukqKT2mpPnEhfCqllqkMaVH81wFRC9ttnIznjtoEgTGKx+rAWZG0puJrvp6mdTDYMEUBw4wiyiv7xav04QakE46AZ81HWSSM7pbsBL9LoZ2hlRz/d17hCBBMA9sSjM34E7g+pma0VF0rJ96dS98qOIsp7FuQKIBYQtQ3zcXPWJ0YEaEF3RTgBAcA7SiEIXiV/Kz6aVQgGsc5Q86fBFR9Siiivmvz8raXHFo86LPMhrEefEMbMAo3i6fG9QJe8wKcNrYCkOYYZO/6cUMtUpfXUZxAzZ4r/Ys5ScVaBfOYb0duphON6PFtoBZ3etOS39JIRV0dAqPsbqifsHII6CXQVx2SqGDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(53546011)(31696002)(83380400001)(7416002)(66946007)(86362001)(66556008)(66476007)(2906002)(44832011)(54906003)(5660300002)(36756003)(186003)(8936002)(316002)(956004)(6486002)(2616005)(26005)(31686004)(8676002)(16576012)(38100700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVcwS0dQbk5lajkwZUJCazNoaGpUV3ZpeElKUC9EMHZBL2t3SzBiWkRpZVVY?=
 =?utf-8?B?REl5NnpHUkVSbngrT1UxeDJTalNNL1FxQ2VaZmpWM3VLTlp1WjluUkFITE1q?=
 =?utf-8?B?a3BwMDVjNjA2Tk1adDNmazI5S0Y0b2I1WWl6aHVDRGxQZ2Y4bVd2dG45VE9E?=
 =?utf-8?B?TVljc0ZiVW5MZXNTQzRBTGlJbVdIOHNLTEdrSDZQWlFvbjB2NVlYNlkwcEJR?=
 =?utf-8?B?Zm1yTEZUenY5dUpPaUR4OUExT0JYbk5STllINitYeDg3TG55alRwZE5GaGtI?=
 =?utf-8?B?Vmd0cE51eFd1UTFQZEhSV1o1MlA1UVBOdk1oRHFXNmhIQ2ZpallCbGFoRStP?=
 =?utf-8?B?ODl5VG9ZTzRVTkNFeDF3WTNrNkJSdHNHcWZJNStuRWpjY1FSQkdtTDEzQm1O?=
 =?utf-8?B?WitQTDB0QkNlTi9KNUloVnNiYnFyK0dTZzhoOHJlOXk5cTU3QjdCMkJ3RXpw?=
 =?utf-8?B?b28vMUgrWjIzK3JNRjBPcHhYWTJpUS9FaUliKzdaNGx1c2U1L1lha3V4RDk2?=
 =?utf-8?B?V2o4a3NSL0xRUkxtNENISWVRaTlEN2FnajI1My9peGFJMFh2WkgyampBUnVZ?=
 =?utf-8?B?ZzhqS2Fod2tSdE80d3BubVBDQUJRV1VXWWwrczJIN3JFRTZvLzZDTk9jSWxv?=
 =?utf-8?B?aTZnMzFkeXMxY2VHNWd0QS8zS3doOUtDOUptWUNZaC9KK3ZiQ0VlRnNpalVa?=
 =?utf-8?B?dkdXbTBwTlk0dSttUm1FR2h1TmdFUi9Id3N3QU9UM1BpTEdKMG5RM2tldmhP?=
 =?utf-8?B?VlZuSXJaNG5zeWdwUWpTMFBEd2taTlV4eitWb2x6aDlRRnBUQzVDU01zeEdB?=
 =?utf-8?B?Y1VlWUcwd25GS3hIeDl6NEU3Mk9RbWM2ZURtRmcwYUpHM0FvdzJIb0pLYzI1?=
 =?utf-8?B?enN1WFZ1b3JJNjNUcWdsNHYvZGNQM1pMWG5QdU5JYXp0YjRzRmdOdGhNV0Fl?=
 =?utf-8?B?a0ZqdmRybG1vZHFteWs3NCtabDNOWWNOV2ozK1JwbXZTVVo0N05Cc3JIeGtB?=
 =?utf-8?B?K1cwTzBxVk9rWlFaRTIzUXRlcWV2QTJ2bDFjZHFOYWs0REIzZ3JMQUR5Kzky?=
 =?utf-8?B?UDNtdEkwVGtLYlJNcUFIeWg5VlVoQ2JOeWZ4eUt0cC8ramI5OEY1RURDMXpG?=
 =?utf-8?B?Z3Y0TEVrVk1UZjdWenVjWjZrc1JoZk5wbm90MWlsMVNvU2tHcnNOdmtwaDI3?=
 =?utf-8?B?K1ZLYUlFb2JTV0lla2NDUzd1a1dvSTZOVUJ4NE9Ka0R6SlFQa05HcmI4TjZW?=
 =?utf-8?B?cVFjRGp4QnpienJhSHM0am8wUkVaZEhzUU5RM1dwdHM1SG5BbkVDdXdIMlNG?=
 =?utf-8?B?b3BSVXltTVhZV3ZNRVUvQ3ZBL3V3NnBHVUx1USt5SWhUNnIrOW5vWVlWYUpI?=
 =?utf-8?B?WDhyUEhOWUZ3OGFpaEJUSnIvYWJyTkRWRWpMZ2U3dGxkcTVkTUsvVkY1aHhR?=
 =?utf-8?B?Uis4WG9Zd3pqemJVdkRwRmV0bmtlRUMzZFhEL0N0YXRSZ1VTL3FaMEkwODhT?=
 =?utf-8?B?S2VCSHV3U2EyeEluNVJudTFvdmkvWnNrT1pxcHYzbzY4V3o5NXlxaVlGWUxr?=
 =?utf-8?B?bEF5cHpCL2VQSEdrZnphSlc3cDR3eVZvL2pDQis2RklUQ0lpYi83dW5aMUVC?=
 =?utf-8?B?VHE3andyNjJNcHpydjZWa2xySEhsNC8zbWZMT1QySXFoMVhSZnIyYmY3blRS?=
 =?utf-8?B?S0ZYZnVxcDA1N3dMSlZiOFdBYWk5bTdmU3N3WFVsM1RBUWtFOERuVkZob0R3?=
 =?utf-8?Q?0Gum43wIGb2Qvej9y/zs/QTAjdy+VAiWhSmK4w+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6811b5ce-4da2-471a-9972-08d982e5c00d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 01:09:13.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIhGAgxTMTBFd1PFDIGsQdA/zTy1U5Y8Ll7uoNI4rQMRXz/nxKEU21vdMW8Z/r5ZducnpwqjZkFjg8nVT42MhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2582
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/26/2021 7:41 AM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> Add a new system call to allow applications to block in the kernel and
>> wait for user interrupts.
>>
>> <The current implementation doesn't support waking up from other
>> blocking system calls like sleep(), read(), epoll(), etc.
>>
>> uintr_wait() is a placeholder syscall while we decide on that
>> behaviour.>
> Which behaviour? You cannot integrate this into [clock_]nanosleep() by
> any means or wakeup something which is blocked in read(somefd) via
> SENDUIPI.

That is the (wishful) desire.

The idea is to have a behavior similar to signals for all or a subset of 
system calls. i.e. return an EINTR by interrupting the blocked syscall 
and possibly have a SA_RESTART type of mechanism.

Can we use the existing signal infrastructure to generate a temporary 
in-kernel signal upon detection of an pending user interrupt? The 
temporary signal doesn't need to be delivered to application but it 
would just be a mechanism to interrupt the blocked syscall.

I don't know anything about the signaling subsystem nor have I tried 
prototyping this. So, all this might be completely baseless.


> What you can do is implement read() and poll() support for the
> uintrfd. Anything else is just not going to fly.
>
> Adding support for read/poll is pretty much a straight forward variant
> of a correctly implemented wait()/wakeup() mechanism.

I tried doing this but I ran into a couple of issues.

1) uintrfd is mapped to a single vector (out of 64). But there is no 
easy hardware mechanism to wait for specific vectors. Waiting for one 
vector might mean waiting for all.

2) The scope of uintrfd is process wide. Also, it would be shared with 
senders. But the wait/wake mechanism is specific to the task that 
created the fd and has a UPID allocated.
As you mentioned below, relaying the pending interrupt information of 
another task would be very tricky.


> While poll()/read() support might be useful and poll() also provides a
> timeout, having an explicit (timed) wait mechanism might be interesting.

I prototyped uintr_wait() with the same intention to have an explicit 
timed yield mechanism. There is very little ambiguity about who is 
waiting for what and how we would deliver the interrupts.


> But that brings me to an interesting question. There are two cases:
>
>   1) The task installed a user space interrupt handler. Now it
>      want's to play nice and yield the CPU while waiting.
>
>      So it needs to reinstall the UINV vector on return to user and
>      update UIRR, but that'd be covered by the existing mechanism. Fine.
>
>   2) Task has no user space interrupt handler installed and just want's
>      to use that wait mechanism.
>
>      What is consuming the pending bit(s)?
>
>      If that's not a valid use case, then the wait has to check for that
>      and reject the syscall with EINVAL.

Yeah. I feel this is not a valid use case. But I am no application 
developer. I will try to seek more opinions here.


>      If it is valid, then how are the pending bits consumed and relayed to
>      user space?

This is very tricky. Because a task that owns the UPID might be 
consuming interrupts while the kernel tries to relay the pending 
interrupt information to another task.


> The same questions arise when you think about implementing poll/read
> support simply because the regular poll/read semantics are:
>
>    poll waits for the event and read consumes the event
> which would be similar to #2 above, but with an installed user space
> interrupt handler the return from the poll system call would consume the
> event immediately (assumed that UIF is set).
>

Yup. There is no read data associated with uintrfd. This might be 
confusing for the application.

Overall, I feel signal handler semantics fit better with User interrupts 
handlers. But as you mentioned there might be no easy way to achieve that.

Thanks again for providing your input on this.

Sohil

