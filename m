Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA948702B
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 03:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbiAGCJK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 21:09:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:22242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344622AbiAGCJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jan 2022 21:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641521349; x=1673057349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7KBunWyMU1CQaFGVMRGZL0ok7GLmgWZwexA0qUbycxs=;
  b=bUuN13ee6RnheCzb6pA9BvP0jfiPgt+PMCMIDfLHK5fZ6q76TPLAoHPj
   Xfmch5/K68jPBBT73g4HhX8ygM8MhLDFL3fx+vHARLNHQ5GfroNdq7H2S
   W1jpSHqBXSy1xCgMs3T1YJqFTfnWKVxucOqJzgkce5BYK0bPWnjlNvyac
   zkwLa6etYEbh2b3V2RCrlW6xq24xv2uf1ZfHv/KZtXsc28n1s4RkCzyJv
   bGhNtUwKGcE/SDR2liuNHJe6IB0Rq613lZIb6HdW0NY3l8ino6GA+GD1+
   HjD0HGfbgKG9TZI0lIV/OybIMAWx0hbCFgpJ+D+yYhl3bY8Xtrqi5dVND
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="242989790"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="242989790"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 18:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="621737351"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 18:09:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 18:09:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 18:09:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 18:09:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auA+9f5b00kmMSVdKKnsOSCPHe/vCxqAnA+XxJItqrKUQGOOaVqC0fDnG21AEeFU5md4sZVs4CMCBwXs2zaCwtFhRSrIVyk53oyNDP07qKgbXCAxVrXr9B/a2SlMejvpafwuBNzCOHtd3otbfNchZ+YsoI1d5wxSfl1TTH5Rc+IUZusvyW51ffdwE6C0cWsmnm5oLP1OMZhHzoR8DL+0SVWgD7XasDVo0yNrdzlxi1/NPNui50G9rzCdxfENfoPbbzaSWArSZqCPn/1heE+lB+nVFQYOwcbDMvLzRAw3xsB+H0uxD/cGUKBwzZVPQJoEDQWCLl1stwM4Y3IB5rlgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb8THbfGFwDcRYph8nq0qEuGJ7zwWRwaFx5skam01Us=;
 b=h7vQUS8FP+XvoHh4BoN8SAu66zKFC3iHSZWJBhBFkPPUqVI0fL1Erxj52TxqdhfbUye3+e2RaewsY0VAKixKBc+nmvdJnazlfU0KrVhPK8V+BI2YjwRhZkKb3bXRA5g3yS1u+qbeI4Z0f44YD0C2ZoXlaOsMn0k9gcP7Bcm3ccekfzqPZTQxL+lnFzXG7nPhmi1MKjlIqgygts2m5uAB0MpXb1AoTT0VtvoRn2GDnth/C91yhb3hBFjyipXc+8vhOmKfbppFs1Cdd9LF1CKiZpq1F0l3iKzHq/xMkXFb36Sn/ZrywCIiol38xhCgU4i8kf6Vutfbg5bFvLhHI09zwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 02:08:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::75b4:ac84:e0e7:4051]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::75b4:ac84:e0e7:4051%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 02:08:57 +0000
Message-ID: <7c1038de-0bae-3b87-d4e4-8a30a910ebdd@intel.com>
Date:   Thu, 6 Jan 2022 18:08:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Language: en-US
To:     Chrisma Pakha <cpakha@andrew.cmu.edu>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <seth@cmu.edu>, <x86@kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <9b5a8cf9-5ce6-c6ba-951f-757135d74492@andrew.cmu.edu>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9b5a8cf9-5ce6-c6ba-951f-757135d74492@andrew.cmu.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 412a3162-862f-4369-0445-08d9d182a9cd
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5040:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5040FBC74AA92F05BC796AD4E54D9@SJ0PR11MB5040.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BirqWYj7n4dXzwDjtQzIdf13JS2Y4zfoRBXS1Xf2dGtDssGXKSxSB2OZPRYx8aMSVvjSAWyxyjJRDpXYpvttt6YuH2EH/J8TjUWH6vxw5bWijwvwwhm5PHjRrOpaeDhHKU5ITYAqevk6mePMw78agNMQOdeacDUVvlDCzIeK596tE3gRopWoPNKphLut1ckeUYUXVbNntZq6ncYZ4B44TRK2ScjcuZqt/NbDnmayKoGoEXlpI3Wofa4D6bnrr+uRG8s2n5Qo7Z++3t2j0NNf/M8XYhEbetMO6NAj3j7SoffqqHBktrugmldLT0wcTya8S5nWuAv2xvoLpchA0IMsOLABXCmvLTfBUmY1AtTSgpmVxrxmjM8ZLiGJc5xYs2Y5Ro8uO2tbLAUpWJgtaTVagBtpof+ZU7nFTACEpySkCPjd2JPChtXKE2PdH0Lw1Dvgv6VZRBNOGJYfqC63DuZcyzY/wHdL+7zmV0uzmVyrA237M9kP8Xk9aXKd2yUz6X6k73dI7Nfn6rI1qtsjplMSwgwO2mIe6m9ONb7BYVhcIpnMgAR0c21iOlAgFPGkCrcYFhd6HnzB1uqiXo6FsA9gFuSj5RLkQvCfoPDepE7gkJh+CkrCk//WWKopLwhYLHwFu8+Djn/kebLTidOR2sJB8od/dHnz1m9w3rltC6kS9M3EROIRDhIGtAtRqvht1pfC0msT7Q20UEdkPmnwQLovTi/lGc7V8i8J+dELnUDaxkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(54906003)(186003)(508600001)(31686004)(83380400001)(82960400001)(2906002)(31696002)(36756003)(38100700002)(6486002)(2616005)(5660300002)(26005)(30864003)(8676002)(66946007)(66556008)(66476007)(8936002)(44832011)(6512007)(86362001)(6506007)(7416002)(316002)(6916009)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9ZWGdJcGRFdzUvM0E4K2NiR1haZHNhRDRqNjBYVlNSeGxXZUFhZWluN0t1?=
 =?utf-8?B?cC80T25EME1JWXhYV0hsK1FyVHZBMFpwM1pWdVdrSHJmekNxT3pZMVFqNGpv?=
 =?utf-8?B?Zk9ERFR6WnI4YmlZVGNEU0cvM01ZVXEvVVc5N0JLQnBjL2VNZ1FiQ3MvWUo0?=
 =?utf-8?B?T1hhRGFUU0tWUlVtR2ZGT3JPU2w0ekJVN0ZvN0lmTi9GUENlVVQ1ZFdiLzZD?=
 =?utf-8?B?TkgrVEJzTnVkSzE5eUthQnhwK250cHdOa1ZKU0tUcHFZTVV0bmoyOW9aMTFx?=
 =?utf-8?B?ZmdNdHNXbzhOa0R5OWtJeHRnQlBqcHF3N1BtWVp0dXNzM3pLRW9pR0lrSE9O?=
 =?utf-8?B?cjQ5QVZadVlDVEtjOUtBMGxzZWlSblBUWmhFdzM3d21aS1NMTGhmSzF0L2hE?=
 =?utf-8?B?THVOdk1YOStNN2lnbldpWklCQnk1eHRLZlVmbmRXWFZuVXcxTnJGRDg3YkpY?=
 =?utf-8?B?dDZmMHM0TkRNSlpnSkJwRWJKejBOd204a05NTXYxZkNJMFZ3RVZ0NWtxbytW?=
 =?utf-8?B?am9vRERXL0FuSG5UaHY5c2JLSVZqTGZqM0sxcmJST0N4Z1VIUVh5b2VOakJW?=
 =?utf-8?B?c3E5akdONDB0K1FDdGlyck1yMTFwNE9HZHVDZmJHK2pCbmtucFBTOS95ejA0?=
 =?utf-8?B?Mjl0aGVPcmpNMUhvYVJWckt1eU1Sc2hWamhrd3lFTmpwZmQ0T2hkc0l5UnFp?=
 =?utf-8?B?Z3VKRkdWRzlrRUtEVDN1NXRxVWgzeG8zV1lsbjFlOFFzMWhiemplZDJQdGlu?=
 =?utf-8?B?bHVJOEVxanFMV2kybzdrbURPdW5HclBsdmwwWE8zbmNudFptSXpOL3M4K3g5?=
 =?utf-8?B?R3FVbEJEK01kQVpvNytEZHhlZndOSmlBVFErMyt4bjlpOVVyUE1GcUF6eXc0?=
 =?utf-8?B?WW03cGZVdktYbGgrZEpHV21MYlZSeUdyd2t0MVJXWUlXL0hYY2dUVUZneDI2?=
 =?utf-8?B?a0NBSm44NG5WbG1IRFppN0hFL293M2dVNzZ1VkVVUzJETVg2cFh3NlRIaXVG?=
 =?utf-8?B?U2tWRXFkdFhNSHphWXdJK29QSTZ5QjIzQS9wRkhwOG4zc2wzRHp5bldQbTFO?=
 =?utf-8?B?ZnFJSWM0eEh3MlZoSUhHWjZYZGZDaFBwdHBjSzFqZjdHVXJkajVteG13bnV1?=
 =?utf-8?B?L2wyWDZKVE1IMU9CMG1SUm1kZzh5NXRkSnFmcDEybUtLcjZ6K01jMWVPTnE4?=
 =?utf-8?B?NHJXQ2IxRCtteWZVcEhtRHdwUWRwbFFCVzFMRXlZcFgyNUZJZlJkeUNINXJW?=
 =?utf-8?B?N0lTOGpvQ2d5ZGlCdVMvUW1xekdiQ0xlUUI1OTJQeHcyYUhqcUdpZ1dmd3pG?=
 =?utf-8?B?SkV5ZnhRdG91UGszQXZteDBtWW1mS2ZDaGFrQ21qcGxjMmNyb1hrVVRsU3k1?=
 =?utf-8?B?U2crYTl0SXRQUU9GQzBtWmhTY1BXb3JVek02UlBYRUhQQllXeWp2OFBDalZN?=
 =?utf-8?B?eitjSFhseG00c09mME02TnlwR2JWMTREb0x5NkJ0djQvUGxRd3FZQUpWWkdY?=
 =?utf-8?B?MlBLODZvak1Fb1QrdGVQWlgxRFo3cmUwYW5mNUk4YkoyK09yblJpTjVaL3hK?=
 =?utf-8?B?d2FsSFZwd3VOZHpUVXozZEFEYkp5RW9CRkp3NGRibkE0MnJJTkRwa2lUQWhy?=
 =?utf-8?B?emFMemJJZUd4cTBtTERYTmhaaGhzRkRSaW9ScW1LZzZLdXdKNjFYUmxUN21L?=
 =?utf-8?B?UFdnQlNmdmpKR0lvL3RvZ2pjYTFyZDVHdXgwRmJzRzhKNmhKVkVMZ0podzBD?=
 =?utf-8?B?dURhNGlEdmJlTGpMTmlYUk4xZUFDVm1JTHpIVG1wWExwRzhnR0x3bnYxY211?=
 =?utf-8?B?OXdkL3Vzby9XSTFxWkIyRkx6NzhYNXVJOG8vdDRuVHI0U0FaYTRDTTdhOEdS?=
 =?utf-8?B?UHJXMVJLWlhDYU10MStOQzJwenNGS0lDRE5USmpkTmxiTVBoZGtHY3M3bGlS?=
 =?utf-8?B?UllLYXFIQzI5SE9KSnB3ZVhKamVVQ09RNXRBNlE2eWFwU1BVRVZxMll1SUY1?=
 =?utf-8?B?WWhNTHNKeVJWSDNsbVF1c1BFWFJqWkQwREpDOVZwNnVJdTltSHhVemFidlB4?=
 =?utf-8?B?OGdyYThTZWhWdTlxNDloUEtvY1owQkowaWJ3NEpkTDkzcUc0Y2tLRTJjeld0?=
 =?utf-8?B?NU5iaC9mMkpUMkRaSlJQcEZHeGhiK1JqWDhrRDB2TWdneWtSWXlOS1Z0Y1pH?=
 =?utf-8?Q?yRYYge2UQ3kp8qVsHIjeiB4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 412a3162-862f-4369-0445-08d9d182a9cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 02:08:57.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjfGDWlGVNp8b8Y7JuIU2p/VJKOzW9leuvei8FZEzXdKODT+ESsKGWov+ix0y2RA3PQ4WEJgI6xkUtmxzDOcIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Chrisma,

On 12/22/2021 8:17 AM, Chrisma Pakha wrote:
> 
> The following is our understanding of the proposed User Interrupt.
> 

Thank you for giving this some thought.

> 
> We have been exploring how user-level interrupts (UIs) can be used to
> improve performance and programmability in several different areas:
> e.g., parallel programming, memory management, I/O, and floating-point
> libraries.

Can you please share more details on this? It would really help improve 
the API design.

> 
> # Current Use Cases
> 
> The Current RFC is focused on sending an interrupt from one user-space
> thread (UST) to another user-space thread (UST2UST).  These threads
> could be in different processes, as long as the sender has access to
> the receiver's User Interrupt File Descriptor (uifd).  Based on our
> understanding, UIs are currently targeted as a low overhead
> alternative for the current IPC mechanisms.
> 

That's correct.

> # Preparing for future use cases
> > If someone could point out an example for Kernel to
> user-space thread (K2UST) UI, we would appreciate it.
> 

The idea here is improve the kernel-to-user event notification latency. 
Theoretically, this can be useful when the kernel sees event completion 
on one cpu but it want to signal (notify) a thread actively running on 
some other CPU. The receiver thread can save some cycles by avoiding 
ring transitions to receive the event.

IO_URING is one of the examples for kernel-to-user event notifications. 
We are evaluating whether providing a UINTR based completion mechanism 
can have benefit over eventfd based completions. The benefits in 
practice are yet to be measured and proven.

> In our work, we have also been exploring precise UIs from the
> currently running thread.  We call these CPU to UST (CPU2UST) UIs.
> For example, a SIGSEGV generated by writing to a read-only page, a
> SIGFPE generated by dividing a number by zero.
> 

It is definitely possible in future to delivery CPU events as User 
Interrupts. The hardware architecture for this is still being worked on 
internally.

Though our focus isn't on exceptions being delivered as User Interrupts. 
Do you have details on what type of benefit is expected?


> - QUESTION: Is there is a rough draft/plan that we can refer to that 
> describes the
> current thinking on these three cases.
> 
> - QUESTION: Are there use cases for K2UST, or is K2UST the same as CPU2UST?
> 

No, K2UST isn't the same as CPU2UST. We would expect limited benefits 
from K2UST but on the other hand CPU2UST can provide significant speedup 
since it avoids the kernel completely.

Unfortunately, due to the large scope of the feature, the hardware 
architecture development is happening in stages. I don't have detailed 
plans for each of the sources of User Interrupts.

Here is our rough plan:

1. Provide a common infrastructure to receive User Interrupts. This is 
independent of the source of the interrupt. The intention here is to 
keep the software APIs generic and extendable so that future sources can 
be added without causing much disturbance to the older APIs.

2. Introduce various sources of User Interrupts in stages:

UST2UST - This RFC. Available in the upcoming Sapphire Rapids processor.

K2UST - Also available in upcoming Sapphire Rapids. Working towards 
proving the value before sending something out.

D2UST - Future processor. Hardware architecture being worked on 
internally. Not much to share right now.

CPU2UST - Future processor. Hardware architecture being worked on 
internally. Not much to share right now.

> # Basic Understanding
> 

The overall description you have mentioned below looks good to me. I 
have added some minor comments for clarification.

Also, the abbreviations that you have used are somewhat different from 
the ones I have used in the patches.

> First, we would like to make sure that our understanding of the 
> terminology and the data structures is correct.
> 
> - User Interrupt Vector (UIV): The identity of the user interrupt.
> - User Interrupt Target Table (UITT):
>    This allows the sender to locate the "address" of the receiver 
> through the uifd.

The UITT refers to the 'UPID' address which is different from the uifd 
that you mention below.


> Below outlines our understanding of the current API for UIs.
> 

All of the statements below seem accurate.

However, some of the restrictions below are due to hardware design and 
some are mainly due to the software implementation. The software design 
and APIs might change significantly as this patch series evolves.

Please feel free to provide input wherever you think the APIs can be 
improved.

> - Each thread that can receive UIs has exactly one handler
>    registered with `uintr_register_handler` (a syscall).
> - Each thread that registers a handler calls `uintr_create_fd` for
>    every user-level interrupt vector (UIV) that they expect to receive.
> - The only information delivered to the handler is the UIV.
> - There are 64 UIVs that can be used per thread.

Though only one generic handler is registered with the hardware, an 
application can choose to implement 64 unique sub-handlers in user space 
based on each unique UIV.

> - A thread that wants to send a UI must register the receiver's uifd 
> with `uintr_register_sender`  (a syscall).
>    This returns an index the sender uses to locate the receiver.
> - `_senduipi(index)` sends a user interrupt to a particular destination.
>    The sender's UITT and index determine the destination.
> - A thread uses `_stui` (and `_clui`) to enable (and disable) the 
> reception of UIs.
> - As for now, there is no mechanism to mask a particular UIV.
> - A UI is delivered to the receiver immediately only if it is currently 
> running.
> - If a thread executes the `uintr_wait()`, it will be scheduled only 
> after receiving a UI.
>    There is no guarantee on the delay between the processor receiving 
> the UI and when the thread is scheduled.
> - If a thread is the target of a UI and another thread is running, or 
> the target thread is blocked in the kernel,
>    then the target thread will handle the UI when it is next scheduled.
> - Ordinary interrupts (interrupt delivered with CPL=0) have a higher 
> priority over user interrupts.
> - UI handler only saves general-purpose registers (e.g., do not save 
> floating-point registers).

The saving and restoring of the registers is done by gcc when the muintr 
flag along with the 'interrupt' attribute is used. Applications can 
choose to save floating point registers as part of the interrupt handler 
as well.

To make it easier for applications we are working on implementing a thin 
library that can help with some of this common functionality like saving 
floating point registers or redirecting to 64 sub-handlers.

> - User Interrupts with higher UIV are given a higher priority than those 
> with smaller UIV.
> 
> ## Private UITT
> 
> The Current RFC focuses on a private UITT where each thread has its own
> UITT.  Thus, different threads executing `_senduipi(index1)` with the
> same `index1` may cause different receiver threads to be interrupted.
> 

That's right.

> In many cases, the receiver of an interrupt needs to know which thread
> sent the interrupt. If we understand the proposal correctly, there are
> only 64 user-level interrupt vectors (UIVs), and the UIV is the only
> information transmitted to the receiver. The UIV itself allows the
> receiver to distinguish different senders through careful management
> of the receiver's UIV.
> 

That's correct. User Interrupts mainly provide a door bell mechanism 
with the actual data expected to be shared through some existing mechanism.

If multiple senders want to share the same interrupt vector then they 
would have to rely on some sort of shared memory (or similar) mechanism 
to relay the relevant information to the receiver. This would likely 
come with some latency cost.

> - QUESTION: Given the code below where the same UIV is registered twice:
> ```c
>    uintr_fd1 = uintr_create_fd(vector1, flags)
>    uintr_fd2 = uintr_create_fd(vector1, flags)
> ```
> Would `uintr_fd1` be the same as `uintr_fd2`, or would it be registered 
> with a different index in the UITT table?

In the current design, if the same thread tries to register the same 
vector again the second uintr_create_fd() would fail with a EBUSY error 
code.

> 
> - QUESTION: If it is registered in a different index, would the
>    receiver be able to distinguish the sender if `uintr_fd1` and
>    `uintr_fd2` are used from two different threads?
> 
> - QUESTION: What is the intended future use of the `flags` argument?
> 

In the uintr_create_fd() call, flags would be used to provide options 
such as O_CLOEXEC. In general, I added flags argument to all the system 
calls to keep them extendable when new boolean options need to be added.

> ## Shared UITT
> 
> In the case of the shared UITT model, all the threads share the same
> UITT and thus, if two different threads execute `_senduipi(index)`
> with the same index, they would both cause an interrupt in the
> same destination/receiver.
> 
> - QUESTION: Since both threads use the same entry (same
>    destination/receiver), does this mean that the receiver will not be
>    able to distinguish the sender of the interrupt?
> 

Yes. However this is true even in case of a private UITT. This isn't 
because the senders used the same UITT index rather it is the result of 
the senders generating the same UIVs.

For example, even if a receiver created 2 FDs with 2 unique vectors.

	uintr_fd1 = uintr_create_fd(vector1, flags)
	uintr_fd2 = uintr_create_fd(vector2, flags)

In case of the a private UITT, both sender threads can register 
themselves with uintr_fd1. They might get different uitt indexes 
returned to them. But when they generate a User interrupt using their 
respective index, the end result would be the same. The receiver will 
see the same vector1 being generated. There is no way for the receiver 
to distinguish the sender without some additional information being 
shared somewhere.


> # Multi-threaded parallel programming example
> 
> One of the uses for UIs that we have been exploring is combining the
> message-passing and shared memory models for parallel programming.  In
> our approach, message-passing is used for synchronization and shared
> memory for data sharing.  The message passing part of the programming
> pattern is based loosely on Active Messages (See ISCA92), where a
> particular thread can turn off/on interrupts to ignore incoming
> messages so they can execute critical sections without having to
> notify any other threads in the system.
> 

This look like a good fit for the User IPI (UST2UST) implementation in 
this RFC. Have you had a chance to evaluate the current API design for 
this usage?

Also, is any of the above work publicly available?

> - QUESTION: Is there any data on the performance impact of `_stui` and 
> `_clui`?
> 

_stui and _clui are expected to have very minimal overhead since they 
only modify a local flag. I'll try to measure this next time I am doing 
some performance measurement.

Thanks,
Sohil
