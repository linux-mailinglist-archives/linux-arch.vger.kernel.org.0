Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD5258860
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAGmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:42:15 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:12351
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbgIAGmO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 02:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsaoD0bZL0EFWMjqswnQi2Ifn/Zwd197uBWy7lLbJZcxeRFt28o9Fh39jW690mHxj1xLsdDi2ZNtTQD56CoYj2U7BHjroWANWcbxjNEkE1o2L5OW7K0qGEfKvVLlw5M7k8B0QBs+kYXAwIfE+4312LX3N+40zCZz7lmhGNpMH/kBYnyJEQ77clUKPwaEQDXcOqS4oRxektd3X0GktGBsKhblCFzpLNYcT6zcKmIuFUZAC4s87k4rVG7CdFO/lol+Q0rwfajnLZCcyiYhjPxVm571ZldpWmuPI3I+AZqWopcG9B0WuM8YKDYRZq/5p/6lxBxwv8ZmeNs9fWAE+7/pBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxR8vbG3uB66SK+rRqdw1J4COgSgvOLmgWQsaGheoJM=;
 b=B7SnEfnVx+W8GoV0U/fN5zgKxgw7HSEDwpTOyR8OMXcbquPpQN9/XPfjSghOS7gM/z0lz00L/TeA0ESBIFF8GI2PPYPt5Y+i4fK+11FXaXEyHkRx1RMlgAPkhzm2yCui525ztvUr7fXw+u892TTXOwc9JsG3j50Sfgua3k8jKQYtGIR5v1J0Z80vGYKCzHDp0DYSS6HNblKvmzTi0vIIHgaMLTLqQmXSo9aoupAdMM+WZPTuFvXOeiIqMQSOwZYykt7tGZJ2FPfeEVBDtsjWvhVTS41dAhn5So3WxFMvpglFueAQEyKdn1gY83x9zguH/+ZTA1sFdsJVWZe6/7H5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kvack.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxR8vbG3uB66SK+rRqdw1J4COgSgvOLmgWQsaGheoJM=;
 b=rWx5VASPVt32CFE07xq12QKM8prApC4nxq9P2sO1ZhprrtEm6h8mvkNPyTWLHAoowU3x+vx5FoR4vHns/1xT/aGSDT0t/FtvSTQ5yoZyQf55PAJVFhwODRhXpCAMkFmMaqG7c55QXLpoNtHdXjFW66XLYYIWR5sEdCsLpELu0oI=
Received: from SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15)
 by BL0PR02MB5571.namprd02.prod.outlook.com (2603:10b6:208:84::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:42:09 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::5a) by SA9PR10CA0010.outlook.office365.com
 (2603:10b6:806:a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Tue, 1 Sep 2020 06:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:42:09
 +0000
Received: from [149.199.38.66] (port=39458 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kCzza-0004K3-Fw; Mon, 31 Aug 2020 23:42:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kCzzd-0003S7-8b; Mon, 31 Aug 2020 23:42:09 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kCzzT-0003GB-0h; Mon, 31 Aug 2020 23:41:59 -0700
Subject: Re: [PATCH v2 10/23] microblaze: use asm-generic/mmu_context.h for
 no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Simek <michal.simek@xilinx.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200826145249.745432-11-npiggin@gmail.com>
 <4d2bdc87-f39c-3737-0aa8-b2efe7b2d93e@monstr.eu>
 <1598940875.v2bbea400c.astroid@bobo.none>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <2daa0a52-5e48-8078-cfeb-bd8ff29cc992@xilinx.com>
Date:   Tue, 1 Sep 2020 08:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1598940875.v2bbea400c.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cfe3c1-46d1-4458-2c54-08d84e42269d
X-MS-TrafficTypeDiagnostic: BL0PR02MB5571:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR02MB5571F275E6166A90A90CBBE7C62E0@BL0PR02MB5571.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3WJeBs5ui+bJvY4QFafwaei40+fmNv26QE9Dj0n/qTeSXcWzg16VEyQk/3T2rst8wOsntkIyiA+trH0+rgyQ6bjA4NnhEMirwcxwjyN7H59Vlnuna/YSuI5aj0levBtIBLzt8Lh5d1Pd8kx5XhFKbJAXlSSPnlZW5JHWiKXll3j4aXG1DOT0ZMb1Lo9uXGRXEwoVT81bbzs3jhyB9T/8VlpB1vx91ZlpFRHmZZ6d9wkRLQ/ARc5dWl4c6IS2AgB5nPGknw8GobgVRDJdawIJA0UqlH18efmfV5lZvNlwQcel5Nf7qdnvrSdPNnWg7MRvSZj80VujahGvSUKxiLB/tDMjQgVnET6pMfwajr1F2Zn7kA8EdQ1IVeieWohlp0FTqG4Sz9O0hY7TMfLkFjrdCt+1pftQGN+SY5WyEHulO482xLMW2AZjN/od85AHrL+rP6iEnV0BdW37I3ai5UeFA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(46966005)(31696002)(2906002)(8676002)(83380400001)(356005)(107886003)(36756003)(70206006)(70586007)(9786002)(4326008)(316002)(478600001)(2616005)(186003)(5660300002)(26005)(31686004)(82740400003)(336012)(110136005)(54906003)(44832011)(6666004)(47076004)(81166007)(82310400003)(426003)(8936002)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:42:09.5487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfe3c1-46d1-4458-2c54-08d84e42269d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5571
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 01. 09. 20 8:15, Nicholas Piggin wrote:
> Excerpts from Michal Simek's message of September 1, 2020 12:15 am:
>>
>>
>> On 26. 08. 20 16:52, Nicholas Piggin wrote:
>>> Cc: Michal Simek <monstr@monstr.eu>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>  arch/microblaze/include/asm/mmu_context_mm.h | 8 ++++----
>>>  arch/microblaze/include/asm/processor.h      | 3 ---
>>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
>>> index a1c7dd48454c..c2c77f708455 100644
>>> --- a/arch/microblaze/include/asm/mmu_context_mm.h
>>> +++ b/arch/microblaze/include/asm/mmu_context_mm.h
>>> @@ -33,10 +33,6 @@
>>>     to represent all kernel pages as shared among all contexts.
>>>   */
>>>  
>>> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>>> -{
>>> -}
>>> -
>>>  # define NO_CONTEXT	256
>>>  # define LAST_CONTEXT	255
>>>  # define FIRST_CONTEXT	1
>>> @@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
>>>  /*
>>>   * We're finished using the context for an address space.
>>>   */
>>> +#define destroy_context destroy_context
>>>  static inline void destroy_context(struct mm_struct *mm)
>>>  {
>>>  	if (mm->context != NO_CONTEXT) {
>>> @@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>>   * After we have set current->mm to a new value, this activates
>>>   * the context for the new mm so we see the new mappings.
>>>   */
>>> +#define activate_mm activate_mm
>>>  static inline void activate_mm(struct mm_struct *active_mm,
>>>  			struct mm_struct *mm)
>>>  {
>>> @@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
>>>  
>>>  extern void mmu_context_init(void);
>>>  
>>> +#include <asm-generic/mmu_context.h>
>>> +
>>>  # endif /* __KERNEL__ */
>>>  #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
>>> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
>>> index 1ff5a82b76b6..616211871a6e 100644
>>> --- a/arch/microblaze/include/asm/processor.h
>>> +++ b/arch/microblaze/include/asm/processor.h
>>> @@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
>>>  #  define KSTK_EIP(task)	(task_pc(task))
>>>  #  define KSTK_ESP(task)	(task_sp(task))
>>>  
>>> -/* FIXME */
>>> -#  define deactivate_mm(tsk, mm)	do { } while (0)
>>> -
>>>  #  define STACK_TOP	TASK_SIZE
>>>  #  define STACK_TOP_MAX	STACK_TOP
>>>  
>>>
>>
>> I am fine with the patch but I pretty much don't like that commit
>> message is empty and there is only subject.
>> With fixing that you can add my:
>> Acked-by: Michal Simek <monstr@monstr.eu>
> 
> Thanks for the review, will do. Any suggestion for a useful commit message?

What about?
Wire asm-generic/mmu_context.h to provide generic empty hooks for arch
code simplification.

Thanks,
Michal
