Return-Path: <linux-arch+bounces-562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D8C7FF466
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 17:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B6228168F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Nov 2023 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F954BDF;
	Thu, 30 Nov 2023 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="yC9Z/qD9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061290;
	Thu, 30 Nov 2023 08:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngu0jTSjqNFk1qifX0En3KJwmaNOtGGU1VixxQcaiZOihlioF0ExwGfpWsCpgjisH9ZFaCtHJfJEMvAqlFz5U9V95FrLRmTS10iE1hx6mkRvOtgHX66OKg8BEb6ISFosfvlE/lfUkzwxKd0La2HTtNphkQFrDDoNuJl0IzcHqtBYGDc5sWK/Z+cHRB/p9ixp/STLrAPVM0SCOtLkr8coLH9TWCUlxSh3qFcnfXtAVTgb5ilvFe8DAvJjX1DOr1ZI+obMrAVQP3c+wmP4ELhzUSsb6uyn2LX/8cyou9NBnsViRtm6xOmAgy5mnDXi2eruQzo7TPOoQKrkLx0aaU39hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t7gQnNDOYvyQ621jnLJLPSU+g12cU27tJ+eOQ9aFoI=;
 b=T20kLSbNLvohqoUDUADgvw50TR/pZX1Q4o0KCWFHu1WArx/t+ghtPVWwEdRt5a8jq7+wfum8I/n7NSf04nvzQTgKOor/Yx7qxQunxmJWlVaEMDQSyYgpEZbS4FIydREntDySlzFSEvXtlQgt9nnG9IRzyaWEiv5WigEP6aBQnAJKDwUqqZ4Yexz0QMiISejyXDrpAgx7AZwVSSVPUjkZuUptWMYI5UPa4hvQ4zyvnCCTnC2pe9l6EIdNOHj0dDJAtLNk+lUTRwdLU2ZAXbNQ4DI9T3hutQ2KVhb22mCg9Z1G4Rt4iAzdYzSwVEWLg4FxKVwPRpfwWt2go3m/A5ljEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t7gQnNDOYvyQ621jnLJLPSU+g12cU27tJ+eOQ9aFoI=;
 b=yC9Z/qD9NNzAJ+jE25AmQM1sAC27DvMMRPWwcOTGPYoPZ/1QOJU5PEQc+uqNA5MKmClsTeAcm8/YjW/7ZZ1ifTNO+rTWLnN0z2W7mXnRetGby22WFy3seRy8KnTZl8S0dMpfR5K4s1G4fe8TtPkgP9ZziDvyOfc2Ei5rqcHBRug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB6954.namprd17.prod.outlook.com (2603:10b6:8:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 16:08:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 16:07:59 +0000
Date: Thu, 30 Nov 2023 11:07:44 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Vinicius Petrucci <vpetrucci@gmail.com>, akpm@linux-foundation.org,
	linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, minchan@kernel.org,
	dave.hansen@linux.intel.com, x86@kernel.org,
	Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
	ying.huang@intel.com, dan.j.williams@intel.com, fvdl@google.com,
	surenb@google.com, rientjes@google.com, hannes@cmpxchg.org,
	mhocko@suse.com, Hasan.Maruf@amd.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, vtavarespetr@micron.com
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-ID: <ZWizUEd/rsxSc0fW@memverge.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
 <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
 <ZV/HSFMmv3xwkNPL@memverge.com>
 <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 422f3940-7478-4ae9-13c0-08dbf1be85d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w465u5lFbE7yGTsyMBjnicYaxvtZBxNRxHM62Y6fWUw6yt/G1q+NI7nyxFtUQ8rBAyhNNuhMr00kHDbFJg4v7ieRtJIeVM+wFX5dWACfC1FxMW+QkdGAACLdwXMYPvtToh1hTW4kfw76aMDmgLZtbYxiPLENjC3LnZjHPuSXRxFZgwFX2hQ2VdEndAc53a4eHb4tMlU2VDTuUX4iRgkjN+9r4DBtt1xmP2FqpbpXA6cKy484DnY4v9I0q68rVrCudT41dra7BJ1ESzkASw/e47xiJoK+0PZ8dhUoyNQ1Co+mLmMo5357LoEcruUJNbybWEmpVLK5WjdynZbTVFCuqTpcCsUBfXBwTnztSZZyEnTiurHYnN5ZykVtvq16QptkFkTQM1t8T2ErBr1ADBdBOa3r0h86i27QBbH9eVC+o4gbBFkXF/b8zwkdRJIXzbT4xivmRYE+eIjqGSnerc2S5ggm5OsNblA5ulh04NcRMgcvjPk0mMi3KCKsmgXoZtdG0lhk1bgH0F4jZdHpHzC1HYuIf9OmQYfOMlpMZ1m4+88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39840400004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(8676002)(66476007)(2906002)(44832011)(86362001)(8936002)(4326008)(5660300002)(66556008)(316002)(7416002)(66946007)(6486002)(966005)(478600001)(36756003)(6916009)(6506007)(41300700001)(6512007)(6666004)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K29hZUpNaGhGd1RiSDgvMURCOVB4WXVVSEV1N0lyRXJDd080Q0tyRHNlRGIx?=
 =?utf-8?B?SnM0T3FxbEZhQ1Z2VUdqUEhPRVdVVFVJTmE2QndOM0xlT3c0a1Ixb2V6encr?=
 =?utf-8?B?enBrRWlrZ0Z0eGZTREdwSGV6N1JqQWc5OVQwSWFLejZ5d3NBR0JqcmRBODRU?=
 =?utf-8?B?bXJUNG9qeit0L3ZidXNmNnBYd3pyb09YV1hZRlpPdUk4SmV2bDlZczNxT1p2?=
 =?utf-8?B?NTBxa1p3ZVRDdXVvbFpvcU14TXpsWkg5Y2piRlRVT3FKTE54N0x6cHhYL1lG?=
 =?utf-8?B?ZmpPZzJpZGluRU9IMkp6M1EzWk9mUFRqSGwwUnU0aDQrVVFQN0hSbGVBcVlI?=
 =?utf-8?B?ck00ZFZXeVJjOEtQMm9KeU1SNkVCMEFISldYeXFTWDBldFhoTS9EZFRRcXJx?=
 =?utf-8?B?eEFvVkl3TmV4U2RILytacDFOS2tKTENYNWNsZmxScXRtZ0wyN1M3U1F2WEsx?=
 =?utf-8?B?VkozVmpSdGtmcFdpbUZnWDVmLzVrY2FuREVqRDN6K1hQWktzVTJtMHdRL3pa?=
 =?utf-8?B?VXdZQU9OZHpINVUveUhTUk4xSUwwajIxOTBSOWZYd3VYeDNVZHFrMVZTSnhW?=
 =?utf-8?B?U3FRVDhiUVhtMFZqcGhxLzBNNlpBV0dTTEE5NndFSlBMT2lEaWU3blIreGtM?=
 =?utf-8?B?K0JLUVBVRnBZeXVCZk1oR0FWQXJGRU9ESDdPUCs3WFg5cUxwRGZWaEd3alcx?=
 =?utf-8?B?S09oVG9KNnJndFNWcU5DMFdxdGJmUU9KQ094a0djOS9rMjQxS2pSdUJ3bFRP?=
 =?utf-8?B?MXd1bDEvUVBpQmNsQjN5ZWVvWkVrWFdLNlFkZW11NkVqUmZaSEw4YmdNNVpO?=
 =?utf-8?B?RE53QklGUmVzQUM2VGdQUUZIZmdGVmJaYnBKMkpNNWFuNE5waEk0QTk5bEhu?=
 =?utf-8?B?U3M2T2hUaDMydGFOVzExbDVwV3lENXdVSjF5VVRmYVpGM21vRXNoWjAwUkhq?=
 =?utf-8?B?T1c5Q25LNFBBWkRESHE1bEE2OStidWIvNE1IVHNXc05WR2gySVRod1dsb0Fz?=
 =?utf-8?B?dEQwdmNFS21pdm1EVlRJbHd4UzZzcnFERHZyNENJVWRIL0hJTGpFeGJ1YnlH?=
 =?utf-8?B?cVFyNlJwMkRDUDVyRWJ1b2NDakl2T0daaTFyL0dmQmFDU2x2ZDc0V3JLQUJH?=
 =?utf-8?B?SnVvWlM1cHlNTlU3M1dXTnl0TXZWS0tYd0lyWnoxOWVsTWVjd2JvQnB3TGNB?=
 =?utf-8?B?VkoyanlJQW9jdWFGb0hXTlRYYlQ1aDZwTnZNVEVrQXVWZzNyNTFXSy9wUTcy?=
 =?utf-8?B?K3UxWjA1eEYzRjNaL1J1RTZaOXROaFQwOHk3d2xzSnAxUHRmOWZrRHYrS0Jx?=
 =?utf-8?B?R3V6ZElhQ0tRT3BVdWFMRTNFdU5FQ25KUGRkMDg3YnRkV0t1RnlnVEkrUXd2?=
 =?utf-8?B?WmtKb1MxQkErbXVWVWg0OUZVRkx3L0sreXFGTlFieE5aOEJrWjJ6bzBDd2lE?=
 =?utf-8?B?bVp0UXNmQ1hvdUFHWnF1eFVFRTdpcityTk9qM0RtbHN3a1lOdEQrNkk2TGFU?=
 =?utf-8?B?dVJ6VHZuQ1RoNlZwb3lIaWZtYzd6ZFVMMnhQdmh2NG1ZNjJTTjhIano4alFP?=
 =?utf-8?B?Nkd0UTFLMnNadGJmRmgzYUpodjVZK2Q5MGIwaGxYL2lDbmFPYWRjZy9ZUzg1?=
 =?utf-8?B?bGc0MDQ3SUxjUFh6RTNrdGVBN3E3aUhCczBWU3JpaTJLUHh1L243ZzNlcUJ4?=
 =?utf-8?B?ay90UlBJZjJVV2FNaE91REdFdFdpZUV2RDZYNUk2emR4eENRTnliMjc2by9m?=
 =?utf-8?B?TCtYT3YxTytwbUZ5YkwxNnNXMW1ONGtvSXh4c3phZklUb0NkTU9ON0dPMm0z?=
 =?utf-8?B?WWdnSjU5UVZ5OXJHZXVUb040NHdOSUJXbFBtdDR2UVBvWVZkU25LMU9uT3hn?=
 =?utf-8?B?WFduQUFTTjZTdjBxdWJKYWswZkdudFlaSnRPcHJZemN2Z1Z6RHU3eHlYS3gz?=
 =?utf-8?B?TThPZHNBK2MrajFWeTZYejZ5NWYvYmFCTWt6NjRGNk1ZWVZ1YzAzUSsrZEh6?=
 =?utf-8?B?dEFNWndmR01DdVRRRVBuT1Q5Z1cxK0JhWVhkQVRvNGg4cGE2UUZTczNzSndj?=
 =?utf-8?B?Q2ZXZkg1NzJCcTlhTDFwekNOOWVQM1QzU2lTSktiZ2ltMGNEdUk3a0JtbWly?=
 =?utf-8?B?dUsxeHNVSExIVjNWVzNFZC9rUEp5TnF1Wkw0NTdxV1lvbkZOOFhKVVJJZVVM?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422f3940-7478-4ae9-13c0-08dbf1be85d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:07:59.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXYRxDyVvGRunDKB1Ic1lgWpJNIfOOq4Lwb6ElrgmYQQY+JkQM35q17AazrvNo5eFpKpj4CS4hUS82DTCRMl5vz4+ZU3x3qX0pcTJcYjPk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6954

On Thu, Nov 30, 2023 at 05:34:04PM +0800, Zhongkun He wrote:
> Hi Gregory, sorry for the late reply.
> 
> I tried pidfd_set_mempolicy(suggested by michal) about a year ago.
> There is a problem here that may need attention.
> 
> A mempolicy can be either associated with a process or with a VMA.
> All vma manipulation is somewhat protected by a down_read on
> mmap_lock.In process context(in alloc_pages()) there is no locking
> because only the process accesses its own state.
> 
> Now  we need to change the process context mempolicy specified
> in pidfd. the mempolicy may about to be freed by
> pidfd_set_mempolicy() while alloc_pages() is using it,
> The race condition appears.
> 
> Say something like the following：
> 
> pidfd_set_mempolicy()        target task stack:
>                                                alloc_pages:
>                                              mpol = p->mempolicy;
>   task_lock(task);
>   old = task->mempolicy;
>   task->mempolicy = new;
>   task_unlock(task);
>   mpol_put(old);
>                                            /*old mpol has been freed.*/
>                                            policy_node(...., mpol)
>                                           __alloc_pages();
> 
> To reduce the use of locks and atomic operations(mpol_get/put)
> in the hot path, there are no references or lock protections here
> for task mempolicy.
> 
> It would be great if your refactoring has a good solution.
> 
> Thanks.
> 

Hi ZhongKun!

I actually just sent out a more general RFC to mempolicy updates that
discuss this more completely:

https://lore.kernel.org/linux-mm/ZWezcQk+BYEq%2FWiI@memverge.com/

and another post on even more issues with pidfd modifications to vma
mempolicies:

https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/

We may have to slow-walk the changes to vma policies due to there being
many more hidden accesses to (current) than expected. It's a rather
nasty rats nest of mempolicy-vma-cpusets-shmem callbacks that obscure
these current-task accesses, it will take time to work through.

As for hot-path reference counting - we may need to change the way
mempolicy is managed, possibly we could leverage RCU to manage mempolicy
references in the hot path, rather than using locks.  In this scenario,
we would likely need to change the way the default policy is applied
(maybe not, I haven't fully explored it).

Do you have thoughts on this?  Would very much like additional comments
before I go through the refactor work.

Regards,
Gregory

