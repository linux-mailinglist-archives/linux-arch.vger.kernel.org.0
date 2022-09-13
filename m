Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610E5B6D0E
	for <lists+linux-arch@lfdr.de>; Tue, 13 Sep 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIMMVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Sep 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMMVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2022 08:21:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554532C647;
        Tue, 13 Sep 2022 05:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEHfI3iE+w2VkYhq7p+U/zUOMjdW3pRbeFpy3d5zsg3+vzttvWPBsbxD7vkdMnixF2/odEecqPsdnpQV4+Jyo8ceowZ79ifHp0VIOvHbvHwZ9vCgw1Z+B4glA+xlluaRgERARm9zufQOP4wZcmqlN775NQQSMBfzpiJrqt9YDOit9GaaH06t2SHzyOnMF0hCu/CKa+f2D8UBcf8IVGG3Sy+PbxA1H5Z8YZUnTtOMRRh9gwv8bEJS7tb2L4h1DrMGTK3b1IecqYJqGZ0cgukUm11+yis+2ilb/W3cHpRHdbkXjRDT59v2kEvSudwQca7kkSIQuMPEdLiZ0KPLvbn5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TtMl/a0EKCOXIeIHU2V22xEwbiagDH43GtTHvmPq4w=;
 b=jy2ywbNQY4LFCRA8b/cM41Sgznwl7y7Ovm9ccEzB5HbCRTz9Rs7PNhd1iYz2RFbI6EDKG1N0SU0qnA0UXOQIEuWsQ0O9HTiNNjLYBYDkahChGNWZhonVrmBr7MP55k8BmQV7f6JfdJlNh5U3oZrfNK55WxUlbf8aSG847nGIaiqt3W2JvCtxkhNOt2ZM7bwV6EBeJjXg67yk0pthddlDWT1EQW9oTjhUryM7i5V360oCI/DWTb/ngIlP4yLnP89ux69pHi+NJr6pqwijaq7SKRoYOL42GBxigQ9nayNpM8OEJ4/c0QIDLLdrK1mSm57yKb3LpewAM0F7M4475uutZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TtMl/a0EKCOXIeIHU2V22xEwbiagDH43GtTHvmPq4w=;
 b=lU5yyi6+dqrlKepaGamcF/SFDXYIYcrRPb2rLHj2ac/7MnmUO3obriPIdXN1b0h9ruflbmDNd/TIieacicb03M4HSUpYmVKVYaeqeEmAdRrIC6bmf0W6+Ndgcusci47sbFt3hB+yEB4TQ8Wy/omYHV1taWLT50efxU1+PlxJgg5is7EKcRf/2sOm5obc20tDOeLS5Cxkv6PDxzSijkzvkyeVcR8PE7iFHImbtst7uo3T8UH+d15ahV4WNMeRjJ6moKfN/Da0WuLrzOo4erKrl6/1R8kh/2AL/vq5fOQgX8zP87KSBlkWNlEn6VxN9mSqfdrky3faALion0DZklfzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3432.namprd12.prod.outlook.com (2603:10b6:a03:ac::22)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 12:21:09 +0000
Received: from BYAPR12MB3432.namprd12.prod.outlook.com
 ([fe80::99b2:edac:3ee3:64bc]) by BYAPR12MB3432.namprd12.prod.outlook.com
 ([fe80::99b2:edac:3ee3:64bc%5]) with mapi id 15.20.5588.012; Tue, 13 Sep 2022
 12:21:09 +0000
Message-ID: <e0e83886-457b-2f55-8019-899acfd81e99@nvidia.com>
Date:   Tue, 13 Sep 2022 08:21:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory
 Models"
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <20220826204219.GX6159@paulmck-ThinkPad-P17-Gen-1>
 <20220913112416.GC3752@willie-the-truck>
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <20220913112416.GC3752@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To BYAPR12MB3432.namprd12.prod.outlook.com
 (2603:10b6:a03:ac::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5651c2-45e9-471f-4f1e-08da95827034
X-MS-TrafficTypeDiagnostic: LV2PR12MB5749:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOcg1XkfBPLYM9fAy57+FS8T1W+L7JOVAjk9qtdoO3oFN5GBlaLxKP2OuTxJhcCfcpSdUSJeicEpiEPvBze23DH3pNLKI/in9kz7vTIxZVrGpAl+vRJVoxpL2b5Cv2N/Euy9TrDegygWGOS+b6aes3yTvKuIUPG5xPqs46nUjEE7kT2NnplpUFIVK+S8ytAki9sqcPe8iHVbSwm+9wnLpEnxHzfBac9CrORSpIn4oK20I08DphmchXmWe6+3qoS+CmINJUoq9d8o2SM9/Kj/dF0c1T/0x32nNMRMh7CQ203EJi13gHA8+YcTTYv7w1fAd0zDowpv2+/8yan8Y2xLUfDbQXiWlXerkptl5oDTIVlNABJHWnmQRyUdkgHEMW8HW+aYCAqAX2QL8y7XvO4xMq5CxVNtZSb3RcVVD70MgZthPuvudLJwyngpLufQX1Bl40nHmEL014c4ELdmkddRXr1/mCbCofxT64oj2DCYxjZY1vi2MV+8tgtAYusqmSzNLmraz4O/l47y+Wx7JdwKiSB4oLfd7sLR92NJC77OBqrlmMxaztCOD5jLCxcZBE8i+rL5UJa3lrdYmyAk/4R10WWD8nTdIla/i7E3TvkI5nuBcdsuCorZCguSaL7nKjrY8TmbG8H3VWmADtsWSDbicmTJeeHOMoZuZL7J1T5gCGoJFHxPauLYsAR4UBR5sdN6pDJEkaQM9XUFL2hf9u5xfRegjpqfJm6HgM4smJwmSFtMpWWRHZvymospEfdtsAf1ZhBhhIXAPB3Kw9mzADeQvlZfpIEhOcbjygpDESv038hdXD3jBDS+P4FhWp/AdQu0PIAnhYZ3ATCGvpGC4J+RBJbuDtGGedhiouWVF6aARF9TNK9MCuZa6JLI8aWJAqBt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(186003)(2616005)(66574015)(6512007)(26005)(53546011)(36756003)(15650500001)(316002)(8936002)(66556008)(6506007)(6666004)(5660300002)(478600001)(966005)(6486002)(110136005)(86362001)(31686004)(38100700002)(66946007)(41300700001)(66476007)(83380400001)(4326008)(2906002)(7416002)(54906003)(31696002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkvTTR0ZXlwTlhLWWhsUGVOYzhYUkFNa0pDVjdqY21CdXdWQ0RhZ2VJem5W?=
 =?utf-8?B?Nk14eVNuOTRWcUNQOGt0MEtyVWE5SUpGMnVrSjNwMlkrYkR4bTlCbVpFVlFx?=
 =?utf-8?B?d1d5cmFPTEQwL0ZLWUlQOXpuQ0Z0SFR3NzI3SlRpTVNhS0E1K3lhbGpqSU1a?=
 =?utf-8?B?OVBnRTkza2Y5MFFCRDlVYml6WjFOWGZwSWlYL2xoWUQ2Qm9Da3pZSW53WHBH?=
 =?utf-8?B?VURYTmZRWUh0VXA4SVZLa3ZERHlybldsb1F2U0R2dStCQTZwa0R6Y0llZFBq?=
 =?utf-8?B?Um5TeGJJVDZzNzk5a2hqVVprUk5DQ1pzZiswaTBMQVVnZTZ1eGhFMUR2T3NB?=
 =?utf-8?B?RnFDc2U5NmJsZG40a0pkWC9uSmdDdGwzb0VjYWxwQjBtYTNvZmRET0VPaDZ6?=
 =?utf-8?B?MitZY3dJYnJDMlpuWlNCSDI0V1ZaY09FbERpUVhXanh2OXdQaGZMeXhCb1RN?=
 =?utf-8?B?OVB2SmNoTklBdStlb0s1VzdMWFhzNTFRRkRuSHVHellQbTBUelRTejB3NkMz?=
 =?utf-8?B?ZDRGTlN4TmpORGQxckNMenVqZ0xERXBaNDJmYUVtaS9vZWJOb2lhaWZtUVdp?=
 =?utf-8?B?QUp0MGpTL3hiQnZMS1RKUUhuZmdqRWJhc2U5Qkh2VGpTeXlUbkJvb0pxaWNV?=
 =?utf-8?B?WWkvdUVMVVg3bVdQTXc0QVJLTWZ5dVMzaU0xRGtLV0dMMk9tMi9UbEs1aExx?=
 =?utf-8?B?bzlvSlZDbGlIblFIYjJSTFJidkRjRTZOUHorTVJnVVQzaXR6bVhmMERNUHFV?=
 =?utf-8?B?dmdzcExhb1M0aHZDSzdHd3VLd1hrcDgzY3h2SVJSbG9xRy9wTmM4czhKWlUy?=
 =?utf-8?B?RDVIbjVkSm5mY0ViYUUrQmx4OHVTS0FURGl4dDlrZUxjYmNmUUhIZDlUUjI1?=
 =?utf-8?B?NDlTMUkzUW51U2t5Q0EzSFpxQmxWT0F3b1AzZTl5Slp5dklRbXg5Tk5ZK3Q4?=
 =?utf-8?B?bm1NYzVFWE5KODllTTFGQ3dWanZoWnpra1ZkY1R3bUVnS2cvNWhOQ3ZibndG?=
 =?utf-8?B?MDZFZytpamRONVlLSzQ4bXhBZGVVMkJ2TERzNmV0WmxwWW9XMElLZ29XYXR0?=
 =?utf-8?B?Mk0rR2FwcEplQUZza0dPa2lnTU43cG1YVjZObUZkK2w1eHZkdmNPRjR2c0VE?=
 =?utf-8?B?NUllUDlId2Flbk5ZKzJoSEJpY2lYc01CL09rMXRLOUg5cFdyWk53d2g2ZkF1?=
 =?utf-8?B?eFBKOVZzaUE5T2xKUjhFQ0dScFg3eGZqaUNDYXhocXhqTTBTN3VRMytDTGVQ?=
 =?utf-8?B?Z2tTdzVnYTU4UURHb2E4MjV1bG13Wno5ZkhqZmwxZ3N2Z0p1Z2tlQ0pYd1h0?=
 =?utf-8?B?NnJhRUpacWxHN25NbVJlaXh0M2RGRWlzM2xrTEN4L3RZMU92NFpkYWdaREJW?=
 =?utf-8?B?M0p0UFZQV1Zsem5vdnRkZmlvVHIzbDNMaGJnN0FHa2VydTJPc2p1Q0hxWGRY?=
 =?utf-8?B?Ynd0cWdzNlk5bEQ4SG5vN05SbG5NWDZCeUtEMVBwY1ZkTE1ya3RxMEc0L0hH?=
 =?utf-8?B?SVQvMGlYQ256anQ2SlhDY1VWeDFJZkxqNDd4TWQyeUQ4dUVHMTFrSG5INFVz?=
 =?utf-8?B?WWZLWE5BOEZnczE3STVzVm9qZWVNaTYyeUFzVWIwZm1YZGxlaElKTFlnbnR0?=
 =?utf-8?B?ajVkaDdmR0ppYjhEanNuSGVRdjF4ZWJKMllGR1czVkM2cHpmV0Q3MGl4TmY0?=
 =?utf-8?B?YmlwWGoxQUVWR3BPSExJQlZydGU2Z0p0TkdZNHlsaStBR1NiOEFCSDVaWjF6?=
 =?utf-8?B?U0srQTFaV080M29Vd0xBcVJjN0lSY0I3OUt6bTQ4NVUvMHBZZ2pZck41aitt?=
 =?utf-8?B?Vms5RXVzaGk1MUdFVHJPWmxoUko0Vlh6Yi95aWJPNDNGNkswcnd4YkFvcFBB?=
 =?utf-8?B?MGJBSEw4OXhvMjg0cGEzaTJ4c24zWitqWUxpMEUwZXpDT2cza1ZIVGhmRlZz?=
 =?utf-8?B?Q3p3aytrai9BanJZcER4OW9nOG5Fd1ZySVFTeUpSbnJMdjlPMldXSllOZ3g5?=
 =?utf-8?B?T2ZKQ1NBNFdxSEVqYlNCZFdqc2VGV0YwUzFTcjYrZUdzQ1JkZGlpQkF3ZzJQ?=
 =?utf-8?B?WFBPRExjS2NESWR4WUkzdmtWbWtEWHpQc1ZJY3R4VllFSXA1bSt5MEs3RGs0?=
 =?utf-8?Q?Z/KWO+wWwtjOa5r9qN/B/TejT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5651c2-45e9-471f-4f1e-08da95827034
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 12:21:08.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ8ofEUABn8prQaeRszDrd3TasIawRWXuYCSOMKr+35MTw6aLeLwUoUIFZHO09Zn4qneNz7kug5rmJq88zm7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/13/2022 7:24 AM, Will Deacon wrote:
> On Fri, Aug 26, 2022 at 01:42:19PM -0700, Paul E. McKenney wrote:
>> On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
>>> On Fri, Aug 26, 2022 at 06:23:24PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
>>>>> Hello!
>>>>>
>>>>> I have not yet done more than glance at this one, but figured I should
>>>>> send it along sooner rather than later.
>>>>>
>>>>> "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
>>>>> Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
>>>>> Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
>>>>> https://arxiv.org/abs/2111.15240
>>>>>
>>>>> The claim is that the queued spinlocks implementation with CNA violates
>>>>> LKMM but actually works on all architectures having a formal hardware
>>>>> memory model.
>>>>>
>>>>> Thoughts?
>>>>
>>>> So the paper mentions the following defects:
>>>>
>>>>  - LKMM doesn't carry a release-acquire chain across a relaxed op
>>>
>>> That's right, although I'm not so sure this should be considered a 
>>> defect...
>>>
>>>>  - some babbling about a missing propagation -- ISTR Linux if stuffed
>>>>    full of them, specifically we require stores to auto propagate
>>>>    without help from barriers
>>>
>>> Not a missing propagation; a late one.
>>>
>>> Don't understand what you mean by "auto propagate without help from 
>>> barriers".
>>>
>>>>  - some handoff that is CNA specific and I've not looked too hard at
>>>>    presently.
>>>>
>>>>
>>>> I think we should address that first one in LKMM, it seems very weird to
>>>> me a RmW would break the chain like that.
>>>
>>> An explicitly relaxed RMW (atomic_cmpxchg_relaxed(), to be precise).
>>>
>>> If the authors wanted to keep the release-acquire chain intact, why not 
>>> use a cmpxchg version that has release semantics instead of going out of 
>>> their way to use a relaxed version?
>>>
>>> To put it another way, RMW accesses and release-acquire accesses are 
>>> unrelated concepts.  You can have one without the other (in principle, 
>>> anyway).  So a relaxed RMW is just as capable of breaking a 
>>> release-acquire chain as any other relaxed operation is.
>>>
>>>>  Is there actual hardware that
>>>> doesn't behave?
>>>
>>> Not as far as I know, although that isn't very far.  Certainly an 
>>> other-multicopy-atomic architecture would make the litmus test succeed.  
>>> But the LKMM does not require other-multicopy-atomicity.
>>
>> My first attempt with ppcmem suggests that powerpc does -not- behave
>> this way.  But that surprises me, just on general principles.  Most likely
>> I blew the litmus test shown below.
>>
>> Thoughts?
>>
>> 							Thanx, Paul
>>
>> ------------------------------------------------------------------------
>>
>> PPC MP+lwsyncs+atomic
>> "LwSyncdWW Rfe LwSyncdRR Fre"
>> Cycle=Rfe LwSyncdRR Fre LwSyncdWW
>> {
>> 0:r2=x; 0:r4=y;
>> 1:r2=y; 1:r5=2;
>> 2:r2=y; 2:r4=x;
>> }
>>  P0           | P1              | P2           ;
>>  li r1,1      | lwarx r1,r0,r2  | lwz r1,0(r2) ;
>>  stw r1,0(r2) | stwcx. r5,r0,r2 | lwsync       ;
>>  lwsync       |                 | lwz r3,0(r4) ;
>>  li r3,1      |                 |              ;
>>  stw r3,0(r4) |                 |              ;
>> exists (1:r1=1 /\ 2:r1=2 /\ 2:r3=0)
> 
> Just catching up on this, but one possible gotcha here is if you have an
> architecture with native load-acquire on P2 and then you move P2 to the end
> of P1. e.g. at a high-level:
> 
> 
>   P0		P1
>   Wx = 1	RmW(y) // xchg() 1 => 2
>   WyRel = 1	RyAcq = 2
> 		Rx = 0
> 
> arm64 forbids this, but it's not "natural" to the hardware and I don't
> know what e.g. risc-v would say about it.
> 
> Will

RISC-V doesn't currently have native load-acquire instructions other than
load-reserve-acquire, but if it did, it would forbid this outcome as well.

To the broader question, RISC-V is other-multi-copy-atomic, so questions
about propagation order and B-cumulativity and so on aren't generally
problematic, just like they generally aren't an issue for ARMv8.

Dan
