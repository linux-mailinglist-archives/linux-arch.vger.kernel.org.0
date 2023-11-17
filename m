Return-Path: <linux-arch+bounces-235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB747EEB3B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 03:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFE81C20503
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224B469E;
	Fri, 17 Nov 2023 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="gj070oFD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE7D4B;
	Thu, 16 Nov 2023 18:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er1qCVCjDN3ARmTkRi5jSD4KCq6mijDTbMjxy2jM7m3T8ndT7zsPedb3rmDs+t3Bnj/6sLeKPOeAmYO3WQhcVVqJ/NBfYrfiYVWG2cBHfhR2C8QUVVqKU33Jhv9O+81aGwWedSHufddPLAGsohZmoMeB17MRkzUniliVCUdqTTQqvewsdQzEVjAGkcM623eL8nVBDL9aW6vBEBdtgVtKHICjZUkx467ksvMz2bnwMKTGJx6YQNcyY9VqBoRrFVSS5KGrUgSjIlYhOPBiGcYxg2tUY/v5BRnS72EgMVIaaHFGBNt7wEXWewQPx995XouwNlCuRxq2sFWVDY7quXqrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTxbRgFWDP9ErtPUrpvo4zC1hzEz4oil7w5gij+KUVk=;
 b=UY+bQdo9oPpwkCRq6XcB2lAb9yxh7Fzls6lFsdmNr299eXMEwR+C6ewP9nVaohMbYFpocF168l3/zWCPZ8WlEiFFaUQi7HIbo8ZIEty4UiSBrUs0j4Sa+U7Fj/xdsNHHbsA9H3bR0giC+yC0LS6Vw92AEoJMch2+Q5WyU5jNi3M0lv01CktCvaOFkd7M4KQaWzehEy4eageRYU6KPRHtoI9LZucvwOcvJTW9qFZHa7lVqsj+vkG+DczviXdSKcQyFHHNWlXOO0ELUMYksaioiTDTKecYo/1XgjTpM1xahO+N9DdJvoSOz+JuAi9X1uS0wi7JxNOuaabIyaHo+isQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTxbRgFWDP9ErtPUrpvo4zC1hzEz4oil7w5gij+KUVk=;
 b=gj070oFDSSwpQYkyGfQZjCx/xRzVOrEn2t9VxLjVhdMlevSzx+cO6FLt2LQspyrMqYWNLsuOrM34kQ1/t4LwBxhzVFOXz0v+Mwwll6Wa9NicdsgRsbt2n9d0/tmJ/iokKJd+m6hnfgZJu4MF4mMMGdhFxk2vNTJtDQw+cpNxcn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.28; Fri, 17 Nov 2023 02:51:11 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.6977.028; Fri, 17 Nov 2023
 02:51:11 +0000
Message-ID: <fb86a4c9-1fcb-41c8-bcda-c7b1e9a949ed@amperemail.onmicrosoft.com>
Date: Fri, 17 Nov 2023 10:50:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: irq: set the correct node for VMAP stack
To: Catalin Marinas <catalin.marinas@arm.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: will@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 arnd@arndb.de, mark.rutland@arm.com, broonie@kernel.org,
 keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 patches@amperecomputing.com
References: <20231114091643.59530-1-shijie@os.amperecomputing.com>
 <ZVZO55IjQSbzWnfG@arm.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZVZO55IjQSbzWnfG@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:610:51::38) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH7PR01MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a41879-a5a3-49d6-f200-08dbe7180e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dboS5QgYc+PvV0jV2mKp0vJRD5xHJ+hFxL+Dg0ZyJMdp7WX+9Kb08pyQklJ92jRaQxOn1oQUvvGi1IisFOuUum4zgmlhkAeN5alInJcG++eQ9En06B/Gwu3TwsL3KCP3GyLKjotfaz+vI3MMwCnceEz08rIT24pp2GqGNlegteyNjlVVms7h8TuAsCRlUnosmGH0MavL9VCMXt+jCWceW+/mK9pyTEC3kEtGOZJNGWZrmQzgjGmvNQS8TfC623jWVaDOoQ3Dch/0A1WUq6NfiwUa4mzFzjMAXJL8u20Q8TlXLm+iBQTKqUDhB9U4Em1PXMSg+6g3SkvWMHdwihSj0WX6aJEaq9E3qOuWpDfRUuf7ikpkiQ6ygBL0BsO/DLw8sImiVMTPCUFs5M+f1nnA72+AHN/nlYm/seSisoU6hPYA8RqI4Qk86ZUjM96Hu84UA5eXG0GyC8dixVqclbsLCz4iGfBkD42TGuBP8ycdYmSFu6mLJ6bwC2hUV+2WNOoeBaljgVIW3vbSU3TWr1JQPx511syjphns4CCaGiJ7s5hpQdi4NEkK10mFr6JA6qaCqne6/ZXuZeWQxjDwuyzcj5zJiyM1SSbCG97JbGMBHfOiFRSEU6raIX/Oa3SItO6x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(42882007)(66946007)(2906002)(6486002)(31696002)(38100700002)(316002)(83170400001)(66556008)(8676002)(110136005)(41300700001)(66476007)(8936002)(4326008)(478600001)(2616005)(107886003)(5660300002)(31686004)(7416002)(6512007)(6506007)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3dyMjMwZmVOZ09qUG5HRHNIQm52WlZGYitYVFl5Nm05SGlvMGU4TGl3MTZK?=
 =?utf-8?B?MU5oV0VjODNOa2tJQmZOMTErZ3Q4R2Q1UzJ1WWpScWpJVyt0WVVkeXlYYVZM?=
 =?utf-8?B?R1paaXhWQzRrd0hkcDRnTlduNm9yWGppaHRFU1N3ay9zM2swS1h0Y1REMHBa?=
 =?utf-8?B?elZWUmJrVVdhNmpGQllWZ09DeVM5QmJrQ0syUEhrRVh0Q2xnc3ZvVXB2ZVUw?=
 =?utf-8?B?bTNmaTM0WVhpTmF6Z2NOQnlhbGI5c085NkFpQzVQRFh4NHlrS0UwR3h5ZDFS?=
 =?utf-8?B?Z3BGaWpWbi9YcHJyaDJUSEpUUUJ0b1ZnRGEvNzNGM3ZCa2hzOEd3Mm90SHFk?=
 =?utf-8?B?RmhVUWg2QnM5ZzdDanVDeUtBQkpZZGI2b2pISG82amRWZ0hGQWthamgrVDVL?=
 =?utf-8?B?UHlJdDVvYVVHcjNoVnNxQTEwY0hiU3VTT0plOGpZRWdVRVdDZVZVRVIxT2c3?=
 =?utf-8?B?eWQxcDFHMDJRcksxaDNuY0VHb0xzTHBDL1JiZmx0M2FhNk15NThZSlIzcEFF?=
 =?utf-8?B?NGN1RTJZbW1FUFl2UytFMlBFRDBpWDRZWlF0YUZBR0dXZWFLRG5DVFF4N0Jv?=
 =?utf-8?B?MFgwdVQ5ZFlOVVBJbXd4eEh2RmRUSS9DeTFDZmJseGQ1OWZUbnAyRVloTGdD?=
 =?utf-8?B?SDBwelFLTDQvYmhPRlFGR1VxTnJsOHJ1UzM1TStmT1NIYnpOU3lZWmVwamZ3?=
 =?utf-8?B?MEhjMU1jK0NoTXZHUkFTUmNWdU16ODMrWVF6YjdPM3BGcFNkcS9HVVZuVUd2?=
 =?utf-8?B?ajRxR2hlL0oyMlNUcEthWTlUbm1YNUhKZGtnSFI5UVZhTFJMVkkvVG1mVHc5?=
 =?utf-8?B?UEU4NXJrZzBENzh1Z2dBckJ5cEJpdGQwSnJYMHdnS3F2VWdPM1lJaUtMYWNI?=
 =?utf-8?B?MDdIUTNtb0xOcDQyT0gvUm5XQmFuMFl0Vk1OaU0wamZVM3VYZWViVllYRGJi?=
 =?utf-8?B?K1lodVgyTGp0WmRtZUxPbm1GeGEyeFBPS1l2YldIVllpRXVMSmJ6SU55Z0Mr?=
 =?utf-8?B?MmJqZzRNTXZ1bzNWMDNnOHc5cFBGaitLMUlTSjhRUGhSQ2pta3RVWUFWc1BX?=
 =?utf-8?B?UFhrU2VtaHY1V1k0bHpQZDVBRjdRYXN1UDhQenc3MXlEZ1NpaXdYRW01Qlgx?=
 =?utf-8?B?UzhTcWttTVN6dHdzY2s3Qk5pdmN5YmNJdy9wbWt1eVFDRVVSVW5pRURxbDA0?=
 =?utf-8?B?SmhWMzhFL3h6V2lCNmVCVGdsczl6YXdWMnRnVlRLR3Z5ckVlV1NLck1TNmJG?=
 =?utf-8?B?T3VmSlVQUTYwZDROVnJGZjJNNjNPdllPelBKSkF3b3ZqY2JSTm1wQ1YvcXBs?=
 =?utf-8?B?MEtCMmU5UEcvL0hqdyttb1Zic2hkK2gxOThEaVhrbkhwZlp3ajBINUR6cjh1?=
 =?utf-8?B?YXEzOFF2emRPMTBEUGpWc1NVK29QS1RWeGR6RURML3JOV2JXQlRRb0lTaUhQ?=
 =?utf-8?B?QzU3NmlndVRjK3FvV2hkYWgrbUhmdFR6WGpxbTRKTG5TTm9kdElnN0hvd2hl?=
 =?utf-8?B?dHNCYW84TjZEQ3IzcFh1TWs4VVJkMmFUVnR2STU4NkxyNEY3NGRkMmIyUGRr?=
 =?utf-8?B?d2hSVC9sV2ZBMnppcXNOTUtVMFdGZUY2MFJUbElLTk41UEI4N0F1dHhEVmJQ?=
 =?utf-8?B?SGFHR3FQTDB2cnh3T2dvQVNxMUxxWXlVc2pOWjJqVHhxcVN6aDRoSTVyRE9z?=
 =?utf-8?B?ZXVPUm9WZGpRS0FBNlh6aGE4aGdJVldJaEpIMzZDcVJBeWxwcHRmRUdseEZK?=
 =?utf-8?B?WUhqWnFSdjVCRjZzQzJMNW94QzRBSUdkdWJjSnVrcnprZyszYXQxZVZGYVpX?=
 =?utf-8?B?d3FybWQrSlEzcGIxTVpjbTNSSnhsV1VxdWlZTEpFam1YeFREdk5wUnI4cURn?=
 =?utf-8?B?VnhvNDlva3grdXBhVHRvNjZDS0xzM1BNMDRCQXFJbWlQRUNuSFhoRnRBYjBi?=
 =?utf-8?B?bENrRC9ZWDEwWlh4REhCUXkrYlFPcXBQcFBRTUZGR0JqY1JMeW56dVNyVmtO?=
 =?utf-8?B?VHhmRitCb29SaGd2Z0czNHlaODAyWUxOTFQvOFM4VURORWozQzAzZnNhUm1a?=
 =?utf-8?B?eDVkb2FiTGJoYXZQRzlSTXh1RXJiUGZQaXo0M2RFeFZ0Q3BmOVhXZXdHNWZO?=
 =?utf-8?B?ZWFBL2txZ1d3SnFONnhSbVlnTnU3SDBkYmNnZGpORHRZTUZVSmlJb3ZRNDIz?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a41879-a5a3-49d6-f200-08dbe7180e1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:51:10.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATZmuhS3I7+1mbnog8TqKu23jJDZ6xy46sG7u3qRqgNjpJ1485fCofl/iKx7GFmUe7Uz83ODBGiFVj0wRAdaEQ1ebQ+sdFdqA1tMh95Hx1RJcBRwFV9MzQd1XPGDkN2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931

Hi Catalin,

在 2023/11/17 1:18, Catalin Marinas 写道:
> On Tue, Nov 14, 2023 at 05:16:43PM +0800, Huang Shijie wrote:
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index 6ad5c6ef5329..e62d3cb3f74c 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -57,7 +57,7 @@ static void init_irq_stacks(void)
>>   	unsigned long *p;
>>   
>>   	for_each_possible_cpu(cpu) {
>> -		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
>> +		p = arch_alloc_vmap_stack(IRQ_STACK_SIZE, early_cpu_to_node(cpu));
>>   		per_cpu(irq_stack_ptr, cpu) = p;
>>   	}
>>   }
> This looks alright to me, I don't have a better suggestion. The generic
> code already has the cpu_to_node_map[] array populated by
> early_map_cpu_to_node(), so let's reuse it.
>
>> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
>> index eaa31e567d1e..90519d981471 100644
>> --- a/drivers/base/arch_numa.c
>> +++ b/drivers/base/arch_numa.c
>> @@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>>   unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
>>   EXPORT_SYMBOL(__per_cpu_offset);
>>   
>> -static int __init early_cpu_to_node(int cpu)
>> +int early_cpu_to_node(int cpu)
>>   {
>>   	return cpu_to_node_map[cpu];
>>   }
>> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
>> index 1a3ad6d29833..fc8a9bd6a444 100644
>> --- a/include/asm-generic/numa.h
>> +++ b/include/asm-generic/numa.h
>> @@ -38,6 +38,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid);
>>   void numa_store_cpu_info(unsigned int cpu);
>>   void numa_add_cpu(unsigned int cpu);
>>   void numa_remove_cpu(unsigned int cpu);
>> +int early_cpu_to_node(int cpu);
> Here I'd move this just below early_map_cpu_to_node() and, for
> completeness, also add the dummy static inline for the !NUMA case.

Thanks a lot.  It seems there is no need for me to send the V2 for this.


Thanks

Huang Shijie



