Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4165740A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 09:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiL1IlV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiL1IlA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 03:41:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2438DFE0;
        Wed, 28 Dec 2022 00:40:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkf5j7l8W1I0G+yANME1v6wQ98VFY4eUVPU/sqOxyAo95ZhB/kzMfK+Hl2nIINq3i+nUXQl7L028dNBodegIlt5a4CQZhuIMLwmVMtSc30mK37oh907lBzH92Fp6amOQPK/6fRP87TwbQSZbDmz2MiBuwcGzq1UCve71M02wFIGnGQQvlcVx+aKSDK1/9vQ2ZGgdhuVMFnPid4k/P1sA2w0QSeI8ptdAGIMC1teii3yP924F0N6bsih7m6cgXB7SmL7KaoyhTy0qq9sYpL6mdIF3zIlrG19QMJlkpTaZXmXRBLN/CkV7cbdu2eLFPLrLsHmoUd92yY8ii2wo2XOGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwZValWt4+KqfdFptlpYaq/Ag9shX1Qa6HFjpwh3SLA=;
 b=O2QtZO00miKkdhOe2SZNCm+xUVi989xtLoGk8Y69gy45wVtThH28gsEqC6+oJMzP7n6e6XcO9BEYcbGJ4cQwoXq7mVibDOTtH8Gai7iCFbqRu65DA4JM7X5i/Ej9TVHpDUILQf7NFkQ4jKY5b5MODgVhJJHuEx+2Q5dI9SXS/2n8+EKKjI6LFR4P3AQh7qFvLx74M78UE/OZyKuNeoTh6FakbfzZX9+WZfpUvwAU80+Zqtn+Gd4xjQgPVYjzBdNMXbMvAVStl2rOdXKNe0QAqpylGT1RNvU/C7W4HUTC0RJltH3ptLLPD9MMIU79sh2VoBqsVQOlzkkTGFv0ztAYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwZValWt4+KqfdFptlpYaq/Ag9shX1Qa6HFjpwh3SLA=;
 b=iuGEfRxCAMTcNmvpzSW1Wm93eiuc2+Z0KWX4rDVJItuLiJINT3TfcwH0Xfr0BWwuJ8chMWINV7kp3c0hzwao90ThDxWOqQJotCX9GF7dFYLUAJdL3tIDDLk7JKhSTE5NNY7RPPNTmzMizIgg8rOvhhJMvP6D440yxolcPsL6oHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 08:40:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%5]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 08:40:52 +0000
Message-ID: <cb1b1042-6bc5-d294-4fa7-26534b921e42@amd.com>
Date:   Wed, 28 Dec 2022 14:10:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC][PATCH 09/12] x86,amd_iommu: Replace cmpxchg_double()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
References: <20221219153525.632521981@infradead.org>
 <20221219154119.419176389@infradead.org>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20221219154119.419176389@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b8e80-ce92-4cdd-4538-08dae8af3a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7DyXmXM+zorboNo0B/jwMtwF+V1ntV9GwnAi8JMb+RJ33sE72lIyLRATFsj5moL/7KdY9V7MQZCGBlsLbKXBGkpuEgZFaAvZQb4WR6JQiFgOoGigF62ArjDmuW4E3RrCKcRXcNrAJIli4X9UHKeVHNJTWQGiv45ou0s4EBmZOHxtbuJNIsa3WKcBZE/ymgLODlvusJHhLxNHrkx1WJn8+9UAJLplcoKWjt71c7syY4zkz5PxcN+eu+rj8ldAiUIA59Z1AeU0ASwObqsAifsSigzWmv7XnAKJyYlNizwwGvqKuDSmAJgt8mXFRrhLcwVVQHDvn/baTLKib244vE8GgHMRVIKLZMldpp14StUcTfj23B0hbxnoS85Al+IGouOVYcpwvReWz4sf4YHXX+4kNZDj96lvz1F9mJDSAzBMo4Hn0U8vim9kkuG0C95P2RSZtcIvcnp7Lq2rVYYnHn7QV8DYhVXwPtFB62hdLkHzMG1WZYOOiINFpFnmRyfuHMwJNwdymNll4vhm7n/SygD6qV2TMqOEbvtSnKpvg+firqU+7x1OaaernVagiOIzsn7DVP0tIt5qZ4LBYz1S4vItOpwcypQTjYdaJJlXYwlNsLh1TqtydsLj3q+aVEY8bdrPeEcgfN61hBiPcwyqyTawIwUUmCfKbNstSNy/qNvD7L+Gq7CU5FcwQOl8XRs8B5BjRddOTsZGCU10eT9wifC3qBw0tEIo1WCxf40iKTnGXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(8676002)(4326008)(66946007)(66476007)(66556008)(8936002)(6512007)(44832011)(5660300002)(31686004)(7416002)(7406005)(41300700001)(83380400001)(2906002)(54906003)(36756003)(6486002)(478600001)(316002)(6666004)(31696002)(6506007)(53546011)(26005)(2616005)(186003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJGUHVhME1wNENTem54VXAydWZ2OWRVdGhUOHp5RGdiMjhUa1NLelc1VFA0?=
 =?utf-8?B?R1I5MFA3OFErVjNCSi9nUi8yWkg0U2RPTGdrdWQ2ZHhhaW8vYk9xUzJPSGkv?=
 =?utf-8?B?WHlOcW5ueTBMdVFGSWgrazZTZ0dwc2sxWGVicXY5YS9FVHZNZm9xUEg2STZl?=
 =?utf-8?B?NVY4dzhXdmRUbEkyQmNIV0RrOXhSblNFK28yMXRIQVYxQVFxdzZPNlVzWExk?=
 =?utf-8?B?dzlmL3lqT0lBU2E3aXN5UzhSUXRna3dqMGlUaTV1cE0zOG1vM2xBRFp6WW45?=
 =?utf-8?B?YXBqMXpSV0pCOWZDaFN5VWFBZmVwZnJDSGo3MmsvNGtSVlZrWnNIZ1E5MUZz?=
 =?utf-8?B?emlHbTVXU3VxRUlGZks3QVorclYrTW9tTGQ0Y1cwbVY5dXl3aUJQOGlBaHI5?=
 =?utf-8?B?YThZbVErV1JFQnpXV0VBazRNMnBNQkhJN2M1RUJ4eFBrYW9tVjRyczNkL3dD?=
 =?utf-8?B?cFljOGY2OXAzY29pLythUlpzbjVWZmcrKythOE5GYVh4RW12QnFIeVk5Z3lo?=
 =?utf-8?B?SG50S1IwOGF5SzdhaUVUWmo5YVpyRjBlblZPNFlNK0RQWVArVTcvQ01CU1dJ?=
 =?utf-8?B?SVJ1d2hHNEh6bUpUa3lEUTcwMHoreEpaR0VNVVdFY0Q3Y05VY05JZG1GNjJJ?=
 =?utf-8?B?RFdEUytzVi9lcmdLd2NRbElnNzh5MkJzZnFQQ1JwTUdPMytLb2xHVjR0Uml3?=
 =?utf-8?B?MzZCcGFEaTlrcDJyaDkrTlRuR01UOWlLKzc1ODd5Q0hPRVF3QncvQUs3YWp1?=
 =?utf-8?B?bG1EOUg1d3gwS29lN01RM3BHOVNXcnRrNk1CMmFxbU1Ud1BLOXRhd0RTVmEx?=
 =?utf-8?B?RDhjb042RjNVZEpSQ2ZxZ3hOSFBvU3NLMUIwaFNVaHZIUG1mblVhbjVRSm5x?=
 =?utf-8?B?aUhoa3RXbldrRlFRc2w4REQ1cXJDbDN5U0pxTGx4VVprbzVzQlNvUEtpK1NB?=
 =?utf-8?B?dVJTNXlxVU9UVzJHSmdQVUgrWE9kWGxpbm9hZXR3RWJCZmJlUDN2U2M1ZEdW?=
 =?utf-8?B?aWVCM3lheEpjN0VaclVHSVNJbXVnT3VvYjhkY25jSng0MlpBUmVLdjJweVBs?=
 =?utf-8?B?cUNVdTNCb1FTTVFuUGJyWUFLeUFuTnlrYnYvM3BDWEZEdGVWcmp3eFVDN0M0?=
 =?utf-8?B?UGdaOXZzU1RaRVRtdG4wT25nYldWY2xBVGdya0puUXJ4U3dzQjhLTVpua1Ja?=
 =?utf-8?B?WkNQVnVkakRQbm5tMWFhL3d2Z2pYNDNwUkZieUNPZGxUZzBHL2FRWXBkQjkv?=
 =?utf-8?B?S1NycEw3MFVVcm9kelZLei9DZktuRXY0MDg4THZsdHdGelh3OUkrQTZ4OGl1?=
 =?utf-8?B?UndrYWYyaGhKN2paMXJ2WCtHYS9UVnRGZ1RDVDY1aFJzSm5pV0trNzUzUHhk?=
 =?utf-8?B?QVhBTHF3ZW1vQU1jQkdGTHhCVHVqdE9IV0RpMytESUJZbG0vWElnTHhZUHQ3?=
 =?utf-8?B?bG5sSWs0NFVqbVFHdlhyNlNtRUFqYVJqYUE4eDNXOFJRMnUwd2lDMWxDZ1p3?=
 =?utf-8?B?WHFlQ2JIbkNsdFJ5MEFIS2Nhb3g5bmwzNy91UHhZK1ZjcDdxMkt3MFhEYnJl?=
 =?utf-8?B?TERmemVYMGh2WmlRcmh2TTlGUURRT3FuUkY1aFhUM0ZHT3JkK1QwTEJ1MVpH?=
 =?utf-8?B?VHZCSExKUW1hNHFraTZIQ2ttNEhONjZnNm5HTStXUHU1SHFlL0l2aldOMEE1?=
 =?utf-8?B?WUNhTEVQa1FRejBYeE5ONjZSUWFpKy9rTW1Dc0pyNjNzMTRqYmoyU3J5UjZk?=
 =?utf-8?B?TmZRTlQ5L0pmeTZmV1ZhTVloUFdhNG9hdnZhb2VzUncveVM0eW9wL3lSV2Jq?=
 =?utf-8?B?c3VYbjc4UFl5MityRWY2NzI5K2trZG5DTzg1MnRTbDZaSElCZXpmZWU1a2VX?=
 =?utf-8?B?QWZKdmI5UE0vSFdMd2RTd1kveGtJMVM1V0R4cFpqYkhtMGg2WmxTNmI0OHJs?=
 =?utf-8?B?UDBQdWVFY3dnUzVFRVpDTUltTzJ1WlZDcUlCTmZYQ25UQ0FpakhYd3NyM1hV?=
 =?utf-8?B?VVE4cXdwYUd4c0l1S1FrNUFWeHNra0tHWEhadUJXVWx4OTRaY0RwMHRReHI3?=
 =?utf-8?B?cUZCa2FOaVZPUXovd2svVlJoSExwdTI2ekhNclJtQU9idm5naVg2Y1FpeStq?=
 =?utf-8?Q?VG+s2Vu+/ZUUM78I1rIS87Tte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b8e80-ce92-4cdd-4538-08dae8af3a18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 08:40:52.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq0kKngDfuE+f/qGhiLucn+/+yKhlB5YnkRnBjzWVG4iXQt248Dc+s0ExIBdaw5xzhybdwpwq/SsIIJtMqmWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/19/2022 9:05 PM, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
>  drivers/iommu/amd/iommu.c           |   10 ++++------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -979,8 +979,13 @@ union irte_ga_hi {
>  };
>  
>  struct irte_ga {
> -	union irte_ga_lo lo;
> -	union irte_ga_hi hi;
> +	union {
> +		struct {
> +			union irte_ga_lo lo;
> +			union irte_ga_hi hi;
> +		};
> +		u128 irte;
> +	};
>  };
>  
>  struct irq_2_irte {
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2992,10 +2992,10 @@ static int alloc_irq_index(struct amd_io
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  			  struct irte_ga *irte, struct amd_ir_data *data)
>  {
> -	bool ret;
>  	struct irq_remap_table *table;
> -	unsigned long flags;
>  	struct irte_ga *entry;
> +	unsigned long flags;
> +	u128 old;
>  
>  	table = get_irq_table(iommu, devid);
>  	if (!table)
> @@ -3006,16 +3006,14 @@ static int modify_irte_ga(struct amd_iom
>  	entry = (struct irte_ga *)table->table;
>  	entry = &entry[index];
>  
> -	ret = cmpxchg_double(&entry->lo.val, &entry->hi.val,
> -			     entry->lo.val, entry->hi.val,
> -			     irte->lo.val, irte->hi.val);
>  	/*
>  	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
>  	 * and it cannot be updated by the hardware or other processors
>  	 * behind us, so the return value of cmpxchg16 should be the
>  	 * same as the old value.
>  	 */
> -	WARN_ON(!ret);
> +	old = entry->irte;
> +	WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));

Changes looks good to me. I have tested it on AMD system and it works fine.

-Vasant

