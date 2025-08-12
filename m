Return-Path: <linux-arch+bounces-13139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8FEB22DF1
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F2118836D3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C624BC01;
	Tue, 12 Aug 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJ/VppHl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QyN7WfkP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947C2F658C;
	Tue, 12 Aug 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016636; cv=fail; b=lFglQAcrU5vbuKJs7B+sVyLt2ktGYuwzWOUT5GZn2t4ykyzABj+x5GRjfDLaPvqP/DTvgjzl3IvSSopLoXiBSKWXea2UJNtXmf21zw13zhBd8Ka8PwTFae/OvXQVxpxMzhWkMYRaIzs4VrXACtsC1xcYQh59iRJXRI//43JoFAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016636; c=relaxed/simple;
	bh=iRagc6GLh8C5NZxmr5ALVswlQKAb9kOkN40wPwx6SH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9nGk/bUfPE5Eig7uQca8iG7uBxuLYDIXRBZiMh+2cy3/yzoNc2sGxJB8bnmsvNwegb2i9tNyH5zb5hRXLuDrkrH/nPsfnYbowuh7dFd43q7+hP9SnKsK1g+qOROR3Ra7J7OmSS7CLeEyoDsLkswl/DTSQ7BxdUddmq5PvDKF3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJ/VppHl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QyN7WfkP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBxBO007852;
	Tue, 12 Aug 2025 16:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=49zvGBJMxE2ccpjw3+
	7u2huZLYolCe1JiIqXQoAkJAw=; b=AJ/VppHlJu0oXOhGmv0+rf5/m72Loh4lds
	o9YWFNjBRtxi9UM2pjikJTfCh9xopyQ77QhAKBit5f0y3bdwqDElYgwFnWvxsT5V
	Egov6ZkagoEZPycGInzVS48ilGC9y+X67iJaCJFNND2Mcqazexj+U03AhIu+VrgS
	gXdD6vDvK2ysxPxDusOUlqNtoGjJRZtodhrraPMebLuO+2mB0mQakOuOuQJ2HW15
	FQ+DlBrWkL7CqDOkQlUYoTStTLyFYo82xX91/u1knZ7uVg3LAiUnLdqGKp3S8Air
	N+kfGQgjFhDs6+V4AW2928cw2F1Q6OR0pXb3vGcC1Y2ghQx03trg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvww1mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:36:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGOkuw030234;
	Tue, 12 Aug 2025 16:36:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa721r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d23s5cCUsWeYe9mZR1P8FAUlxZSn+5Ilk6q+dKjyFDwlD8p+i8o0Li/3314TRN6qv2bxiFX2p7TcP0g3QDYYug9gfynrU9grV9Pg1ztKJOaAdEqVb+hKMzr1QCTHKCFuUDfnqhn+q1QumJKjasUs26yYb/zxoPTreoMistNcK89nFrJjuybfL9spcYpKuy/hyCPFLld0VeRh4brqlwcMAX9JySXavD1lFDa1tA5BbtOXte5S1iOFDkjSBZHVHWpn5cN+VXGmOAYlxfXp/GgRDh4cLH5YgQhJygOQu53DQBWznCTKSpMuSVTAtHsBvqakXqeomFQfN32fSRsenbkKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49zvGBJMxE2ccpjw3+7u2huZLYolCe1JiIqXQoAkJAw=;
 b=oCV5qpQnsZN5+0i4FDSJzy0EMyLyQ0rxxLMp5E9TOruwWQKFAyC3YIETmClZOyoynqC1JjB1dM8/1fR+GBf0Sqiv2GiGQq9zWOpZ8rpIUThNfd7kW68HfzBNpvaB7kW13El+GUW4FTa82ddoP6WYSe59SF90XRdCyaMnT4zf09qOc/Ib7VQmFN+llOyJ57xgTc3vLnOHnw4LEyYlkaYOLVVY3Da8KUT+8SLlHYpiPN6v3+E9lYk2amsi2ErhiAXZvyNAY0YoFZCHtyfXXljDlcs7pVUoH8uNyA1JzSsiYGv0BHuAJ3TuVyQTBMdi+faTn77qPv34qOWvl7WmdBvpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49zvGBJMxE2ccpjw3+7u2huZLYolCe1JiIqXQoAkJAw=;
 b=QyN7WfkPtDnnWk0emU4a3PhP11v5TQaFiY1iG4vCUrV5+O9vj798oev1mFqsKNC5LDUMWQNHAyleRFKFDaX/Eqw+VHpfuJcJ/sB/NjkcCQB+66oTKgpy8Y1LhLjaZMInUem3F0BBIcxal+zRDwTxav+lAS+KFJH0UAoqm1jWUFs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:36:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:36:23 +0000
Date: Tue, 12 Aug 2025 17:36:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 3/3] x86/mm/64: define
 ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
Message-ID: <ca172db4-be84-4f82-9bf7-c65de8d997d2@lucifer.local>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-4-harry.yoo@oracle.com>
 <9b57f325-2dc7-48a4-b2f0-d7daa2192925@lucifer.local>
 <aJsCVtgfIVxT6Z93@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsCVtgfIVxT6Z93@hyeyoo>
X-ClientProxiedBy: GVX0EPF00014AF6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff93a77-456f-4c08-91f4-08ddd9be5fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QvHGG09qtHMsgWEdl1uCwtieaFHx46Cd7Kt6AhwtJpoZ2n20/Z4fwwC3GUpj?=
 =?us-ascii?Q?VA64gqf/lTZc18hhADhishG0UxiIUwKzDgSurH3Szck0pHSqGsS4pUZJOinV?=
 =?us-ascii?Q?NCD9UeRFzTuwP6evDLPyFvRqDcKi1zhPwbclRS8+D/R6e5EIxc823Bi7Y6p+?=
 =?us-ascii?Q?epJZ59cnNci6IyXhLbxCRZ/CaG/xL0CE7SgegIpdzAzgU/rU5NjnnZXeO//B?=
 =?us-ascii?Q?iFlnzffB8R1ig3LaEv5APKETxz86riC15DOY8tnXOpKfDzuY8VYDmMbyr2lL?=
 =?us-ascii?Q?7SnDSux/LvwH7kNo4jBQH2gHOHiLeCxU2GxD7nr/VjX1wQbSdHtCwPD6RLmp?=
 =?us-ascii?Q?ehlP1w6sL7IffqmgR7RR/ZSHbwupS/9M8V1wbljQCDuI40oi8nz+gNMwmv21?=
 =?us-ascii?Q?jlb4qyRBLMxLeG2gg1mdRDkQplwe8+RIo9F5VqhfhDKEGJ7M3sngx0BfvsPz?=
 =?us-ascii?Q?T0+urLcXW1GmtzDvhAu1u5mKtOu5yJ0JgxnGRsb+yuC9KrawL8GcZZt1NnZ6?=
 =?us-ascii?Q?HTSGK1mYUSuKghm5ZJt5VtLbEnErMoDolbmVeQqerYkFJ8S4nPe0nRSGqviK?=
 =?us-ascii?Q?kTViX/c58bgZIis+w/uJnYK0n1u4hA6xFicoY4poKmjrqXHe0PVaa3RpIFto?=
 =?us-ascii?Q?wY0NXNCohe+WNjGRIJJihFEviiGhHHNnW5FcXsed6Ezu/J3eCXvney8PuYA1?=
 =?us-ascii?Q?MtGG+LLhYRvn5EzwX9lZKCFQ2jh2PaEhQudh9T//4eBpPAqygYdNOFh1zUlY?=
 =?us-ascii?Q?PSXVYGMaQLUTt3fNMW5p91lUkOIsU1gmeh2cVN3nT65fX1nPMS5LNiOGff7S?=
 =?us-ascii?Q?zbzsO/zw9JPWPmDJyz8le2nQrN6DeD9ws7qCczMuR7Lxh2P1x3kUgHgdenXu?=
 =?us-ascii?Q?/NduFAiYsPMzpA1w8/edcUDhK6HhszBA0OdEnnQ9wRMD0KzY/1eMgxTumjf2?=
 =?us-ascii?Q?ImaBM8QHfSENVTyfQkDoX4YR7iQ2pgdqHXUGTyMsvReBgg2n0N5Z1ofNxuHu?=
 =?us-ascii?Q?eS69fkpJ1OKbZZz914BYo+WCiUnsLbBQxyQ9bWfZqGYRUUJdizHWUSUCbCfw?=
 =?us-ascii?Q?0ciNQfVM1VDaW4D96ElLh7/EnecQFgZo/JfiS0znCJzWzTo5sfzY9Emc1lMa?=
 =?us-ascii?Q?q/37qcjcW/ty6k7+1+gmsEgSVNiUq97XzqMNf99TS0+yLLhKGFF6GkhdT3X/?=
 =?us-ascii?Q?8/FPOw32g6FnoJpfWz7KP2rKcPjcEWg2wlvSPhCMDpfgVKiQgkFN7mzOXRMx?=
 =?us-ascii?Q?+z44BRjZ0PthcqGoOh8N5PSwtZAtrQxJgsMFTg2RI8s69HFLmx+UjmmHAmjA?=
 =?us-ascii?Q?XFcm8oPfHZCv/TAkAPXTwTk5ZtcfOg0Kcnm2gehVHmgYd7d2FUctKDyZ/JUI?=
 =?us-ascii?Q?x1fg3TAnkp9weiYIPJFien8pgF9c8BaTQ+FrUdwc5BeFGYpNq61+W5YXix/q?=
 =?us-ascii?Q?YuzMuvjmmjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+LkMo/VeDFGo/SnjsMz9fX9qH8ge+zEnX1y2Wqyn8HQGBPtHnLkMjMi16aQl?=
 =?us-ascii?Q?cpEDdcUJ+7V6InANPBJkDd/Gs0N9DmwDJwoFeYgf4e6vUNlaKa506pKsC7B7?=
 =?us-ascii?Q?zWJJyp2bdcEHg9bcQqpO6pLNjZn6VuMtNjCyzZhEQqm67IvJgjdJTLc/FF86?=
 =?us-ascii?Q?Y4YdzXlCNTFFw5LtSI13iqDjrOCd7EJFih5bz2JgCna4QG8rmFiatHtVvUCW?=
 =?us-ascii?Q?fvj6D0Iheco8NyoH+wpzsGuIhyLKbuSma3OuooCZlv2OSjCTJ6ZxTGbkVIZb?=
 =?us-ascii?Q?neZ8xG7p1ITXFENY4hygiWMsd3Ib5vmeZMv0OUD2/vWaHBMB3AGLDMX5wBCB?=
 =?us-ascii?Q?IiLb9qsnhIyvA9sP1VeubhuvMVohGcJ+AFJfOjkueB/YTB6JCZ6uC9qpIIlG?=
 =?us-ascii?Q?ljN+52pXgevbU/Vr/r/ikbBiJjhv0IxsRHVrXZwKQ+nVykMlktfLC1hM/uqp?=
 =?us-ascii?Q?DQfWHwUuXVuMpyIZoMrJPG0rer/iRvJQVQ+Vs4ObMyBHoA3YY4CuidqFGRfY?=
 =?us-ascii?Q?C6ecofz9jsq7R6+6KFmxH8nGPhyNzS2Rc9Y4z0liRYwRidTPWYuStbwdCz/d?=
 =?us-ascii?Q?YpYsehdTqsoPJGHRyc6Z2GCJyHbsXYgQi74j7KsEkjR5PxRe0mflfzqchBTC?=
 =?us-ascii?Q?i74Gq40c0jQSnqIBhBeKpVMoS0EM6F0agcAOPek30PZ2g6NuV1s0SpzEFfeR?=
 =?us-ascii?Q?J4TE7DBuO0HuWvdUibce6OlOvjvOLbAk7VCiKxt8Uttx2Ykcn9JVPucxgU31?=
 =?us-ascii?Q?5x2Eoodx1e3uPwOXO7ErAzh0JxCkm1nc6H7cR0XgOlDK72F/X+qUGDck6V/m?=
 =?us-ascii?Q?+OBGCzp6u6/Fp5M234KSu3RPpA0K07NPEIQvFtn2MNxORL7i62DQRB+wvRvi?=
 =?us-ascii?Q?fimFRtRJ29uMhqcWcS0OodwMfxAoEI68EL9uhGLRF+LAqw69HxQuPcOc0+tZ?=
 =?us-ascii?Q?dnHHmh4acf7FymEu/Gf5odDe6NpSUkD9GjTTBQ5f/wzgze08Rdi+uETQaPPQ?=
 =?us-ascii?Q?Ych7J3OwfFbb4BRjnAW01M/Pg/GUUUKeTf2cvG9h9Dn3JLXz8C4xhkOeqGHs?=
 =?us-ascii?Q?twB7l19JdnRKGDsk5fG4XExjDkgUTR3MYkD/uFnClNN6onZgFp092UgzZIIh?=
 =?us-ascii?Q?Eju39eGvqY3UwB2kGVrmb3O6HK/O6qJhFa5ovLOF/f/e10l2aqBKoX8KFHks?=
 =?us-ascii?Q?Zcj/AfuGui72c2ihMEs6T7jMadE64//BS8sGth6TclJTlyZriRzH1Sk1WC8M?=
 =?us-ascii?Q?09Jm6bNcyuTtn9KhugC76msTosTqhWYIdGvdIe9cl3yktywesIVY4TE5dHOZ?=
 =?us-ascii?Q?1wjQsSQVKYSvYPhpYa3SQlfWo/ZJKgjKCB0+uMvQSWqp353bElpC4j+jFbAA?=
 =?us-ascii?Q?s6FPe2/A+SGCI3pO5ThJZUkbV7Zv+Yb8e1SLmn4azg8OW7GW3XnKf0WpnN+c?=
 =?us-ascii?Q?YPE9jiXIjovFfuGVoMrNPz1vxmOCaLAI3fqutv5ugU0x6pLGS3d+9UxkyCbn?=
 =?us-ascii?Q?zLpWQfbsKX6CJTwo/cZEDQmS13lnlolG3ek8LrIvli4B3W3Ho6ufgQUFKrd+?=
 =?us-ascii?Q?BB6RWRc9tnVXC5PHVMhd4ow3IDsNy3fET+LftdyOG579z85mbAfkBLgqVlW5?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SpkempXuKtg4MXfV/aejgJxqd+XSu5xee+2sNS/fkmoX1Dqf3wXy8cwp+oUcpU08Z+IVZUBLmLaL+CC//LaA9iUMTgEyMS9kEf3P5AX2pT1gikxFPHpUljoKP7tkFfvvm0Fm/Xb6xTpVk3KJ6s2UTpip9gGNR5Vnj3vxymlw8vULu5VX8RvX9Q/MzBki8oBECF7hm49JxHerqeUICrNQuKGlYDCHJRr/YlIMBcqVlAAaM4VA7YUlAHC3GXn7+8czY69YQjti0ICGBXab/sNAhOXqV6119s0+7eWA3wC8INCbwsoV5vBFvDLoK/8aqkivKygxIQ8ns6jNwzxzumFasIBt1m0sRFDW0ZP94p6y8KgeyrM9kZ34m2NhD5jQLosLLnJsi0q2uTkwKHlB6qFWYeueH3VEX6hk5Mwh4azElfiESH8ndwWKefM7patHq/zkQTpS97uBzqSM2P5G7y4PRluqdkM3dKbMKMlpIcVLUMPKp6X7V6v+2Vj4sIQz6e0c0KPo9wSDHHKbJZbqizEUc9XU7J/E7h4nlCKoLGQs7X667KPHldt93GNxexIooXOY/iBa9ZYS1/syNhtUECpvs2tSjWvnIBsVQCPdyKn9w44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff93a77-456f-4c08-91f4-08ddd9be5fc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:36:23.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gVIeFBb9PKlG45HY7zvtxAwJiruirnZY5LLibronvXOkj27ERF+HxFCySdaf5iSe5aAWwN+yCm338qUo1FmYF3XQ8jlWZo4LBrPBOgUV7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120158
X-Proofpoint-GUID: OMeiyPJLkJSOMUmF9KpSdehG6BN32xQx
X-Proofpoint-ORIG-GUID: OMeiyPJLkJSOMUmF9KpSdehG6BN32xQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1OSBTYWx0ZWRfX7k0T1uWEEAbe
 NhOeHcfhYjNZPmiWbW8qwUidZaqXCNhNCbmrwh02VOOAdx4V0KCr483fh9v/Cclbv+435PfkPqt
 5XLRHGJeWWWEZMs+L5MYgw8VxcPPx1/Tx0pnVC3nJVqngvMPw9+BYkKD4IB0L43xyjESU7pSrx8
 AyQAS9+H1r9fBnX8EKoPB3vWC5Osq9+9mDs205oGhkkbqmg8G9r52RF92z6jNV/UmT+HQvaUviy
 OLBvTJn67FtZIhDkC6MhtZOMbzOKG6oACpJTv7Jfv/DUw4TYD5Fw2BdIvrM1fuKvmVoZrd0X/yc
 xa86diGKhPkKDuXkRKNWBdhtczVAfHWcp5QQd/eveAdvdTPay4UGFmyIhASm/BNd/eS5C4sjwIl
 yZJlSMIP3xTagZyrsFsRu/pmjjRhgiXazlBpuyz8X1FXg0R9vm4lGYVdHULlVP+faMSvN8tT
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b6d8c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=WGoLGLEUZeYSAlKTZ5wA:9 a=CjuIK1q_8ugA:10

On Tue, Aug 12, 2025 at 05:59:02PM +0900, Harry Yoo wrote:
> On Mon, Aug 11, 2025 at 12:46:32PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Aug 11, 2025 at 02:34:20PM +0900, Harry Yoo wrote:
> > > Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
> > > page tables are properly synchronized when calling p*d_populate_kernel().
> > > It is inteneded to synchronize page tables via pgd_pouplate_kernel() when
> > > 5-level paging is in use and via p4d_pouplate_kernel() when 4-level paging
> > > is used.
> > >
> >
> > I think it's worth mentioning here that pgd_populate() is a no-op in 4-level
> > systems, so the sychronisation must occur at the P4D level, just to make this
> > clear.
>
> Yeah, that's indeed confusing and agree that it's worth mentioning.
> Will do. The new one:
>
> Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
> ensure page tables are properly synchronized when calling
> p*d_populate_kernel().
>
> For 5-level paging, synchronization is performed via pgd_populate_kernel().
> In 4-level paging, pgd_populate() is a no-op, so synchronization is instead
> performed at the P4D level via p4d_populate_kernel().

That's great thanks!

>
> > > This fixes intermittent boot failures on systems using 4-level paging
> > > and a large amount of persistent memory:
> > >
> > >   BUG: unable to handle page fault for address: ffffe70000000034
> > >   #PF: supervisor write access in kernel mode
> > >   #PF: error_code(0x0002) - not-present page
> > >   PGD 0 P4D 0
> > >   Oops: 0002 [#1] SMP NOPTI
> > >   RIP: 0010:__init_single_page+0x9/0x6d
> > >   Call Trace:
> > >    <TASK>
> > >    __init_zone_device_page+0x17/0x5d
> > >    memmap_init_zone_device+0x154/0x1bb
> > >    pagemap_range+0x2e0/0x40f
> > >    memremap_pages+0x10b/0x2f0
> > >    devm_memremap_pages+0x1e/0x60
> > >    dev_dax_probe+0xce/0x2ec [device_dax]
> > >    dax_bus_probe+0x6d/0xc9
> > >    [... snip ...]
> > >    </TASK>
> > >
> > > It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
> > > before sync_global_pgds() [1]:
> > >
> > >   BUG: unable to handle page fault for address: ffffeb3ff1200000
> > >   #PF: supervisor write access in kernel mode
> > >   #PF: error_code(0x0002) - not-present page
> > >   PGD 0 P4D 0
> > >   Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> > >   Tainted: [W]=WARN
> > >   RIP: 0010:vmemmap_set_pmd+0xff/0x230
> > >    <TASK>
> > >    vmemmap_populate_hugepages+0x176/0x180
> > >    vmemmap_populate+0x34/0x80
> > >    __populate_section_memmap+0x41/0x90
> > >    sparse_add_section+0x121/0x3e0
> > >    __add_pages+0xba/0x150
> > >    add_pages+0x1d/0x70
> > >    memremap_pages+0x3dc/0x810
> > >    devm_memremap_pages+0x1c/0x60
> > >    xe_devm_add+0x8b/0x100 [xe]
> > >    xe_tile_init_noalloc+0x6a/0x70 [xe]
> > >    xe_device_probe+0x48c/0x740 [xe]
> > >    [... snip ...]
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > > Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > Other than nitty comments, this looks good to me, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!
>
> > > ---
> > >  arch/x86/include/asm/pgtable_64_types.h | 3 +++
> > >  arch/x86/mm/init_64.c                   | 5 +++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> > > index 4604f924d8b8..7eb61ef6a185 100644
> > > --- a/arch/x86/include/asm/pgtable_64_types.h
> > > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > > @@ -36,6 +36,9 @@ static inline bool pgtable_l5_enabled(void)
> > >  #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
> > >  #endif /* USE_EARLY_PGTABLE_L5 */
> > >
> > > +#define ARCH_PAGE_TABLE_SYNC_MASK \
> > > +	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
> > > +
> > >  extern unsigned int pgdir_shift;
> > >  extern unsigned int ptrs_per_p4d;
> > >
> > > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > > index 76e33bd7c556..a78b498c0dc3 100644
> > > --- a/arch/x86/mm/init_64.c
> > > +++ b/arch/x86/mm/init_64.c
> > > @@ -223,6 +223,11 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
> > >  		sync_global_pgds_l4(start, end);
> > >  }
> > >
> >
> > Worth a comment to say 'if 4-level, then we synchronise at P4D level by
> > convention, however the same sync_global_pgds() applies'?
>
> Maybe:
>
> /*
>  * Make kernel mappings visible in all page tables in the system.
>  * This is necessary except when the init task populates kernel mappings
>  * during the boot process. In that case, all processes originating from
>  * the init task copies the kernel mappings, so there is no issue.
>  * Otherwise, missing synchronization could lead to kernel crashes due
>  * to missing page table entries for certain kernel mappings.
>  *
>  * Synchronization is performed at the top level, which is the PGD in
>  * 5-level paging systems. But in 4-level paging systems, however,
>  * pgd_populate() is a no-op, so synchronization is done at P4D level instead.
>  * sync_global_pgds() handles this difference between paging levels.
>  */
>

That's great also, thanks!

> --
> Cheers,
> Harry / Hyeonggon
>
> > > +void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> > > +{
> > > +	sync_global_pgds(start, end);
> > > +}
> > > +
> > >  /*
> > >   * NOTE: This function is marked __ref because it calls __init function
> > >   * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
> > > --
> > > 2.43.0
> > >
>

