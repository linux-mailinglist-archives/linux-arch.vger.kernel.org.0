Return-Path: <linux-arch+bounces-15411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CADCBD4A3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 10:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07A730053CE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2332315761;
	Mon, 15 Dec 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/Em1kUK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lYpYjVj7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6A2E764C;
	Mon, 15 Dec 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792521; cv=fail; b=SsAJjiP6TURfGKc6TlbXk+Z3Mha3wciWZyPh2X3fPzESpIbm3nIVM9nniRQTroIn14ryjxSv4RpK6fUa+MMopbWksjRmsRNQfNZJ8PKquT0H6LD30PGMY7cR1YygmI8F1qZ5xK32SlRMaq5CLrElym4JB52NanYyw1LhbDmRoTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792521; c=relaxed/simple;
	bh=he1SlrqCBaV8I6/OPP7X34BDpxjrie6UrHPS6KSLJAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mglgF4PCxh0eZXa5eA5O7KeL1LEsvjZAGL8QQ4bBTBCaL+MUp/B9mOZcHi7pRM3Pnvqv5IxVKQ+BEoPLatHqcErsPjNya/3QqZ6bXUcqOpgpUERlemd2hqwnvLk4AoVoTqla583/7GU6lrOqS9X2qFpBSkmOO1sh0CIyOKAFbNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/Em1kUK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lYpYjVj7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF7uhwQ1694614;
	Mon, 15 Dec 2025 09:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6e3SeEbl5/fjUaPvGy
	ZenEpdV5FA80oCvg9VtxQVAYc=; b=b/Em1kUKbpuzbROsZ7/lv1CN4r5QI4/YPM
	SMHhL3l0miK8iTwpvLuoSkoeBOFUAt1J66edlZTzCS+xndO5et6Ov6deYYhp9d68
	IKNH19If19x4uVhF+JpsGe4Qj/WEnlZJRMPKSUPTQKoFHIAMQzgSfOuLGJH5Dv2L
	2GxMCFkO+sDzHc9GyOWTdCLZsA9mYN6X/MKWH+GgfEoCIIjP8Z4dK4TGI3Mmj2wn
	pCi2eKsQ8O4AbbOpwbtcwfGzAdbGDwd4UYqpjH1xFH3NS/Y4ZAfzzS962gXnJ2Im
	2jPlelHwlvAYauL3d9sqy64rYHB7oIJ/LZvKTWp0D3Iai+28fs4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx29qx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:54:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF8MJ5c022613;
	Mon, 15 Dec 2025 09:54:35 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkhrtbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBMV3iDL1OD9gkur2wd3TqJj8dIMadsHoEwvP2WHc3HeF4fKNNNy712BU/5f5OOq3VFfzXfhHAAXKBsOXovpuNxWJlxuIfCB0HrcKvakDKMfZwTnUh9XiPMUcJd+MSheICAUDHIu8AsRNnhBNRAMdBgOqND4gNwtTZrifm1BOrUmmoNHZyi4f8JsnpI0cjopgAzdIyEfTu9K13OXfdPktsu3qSCC29ASFTKx9KdXaGqLNk6K2v44mBzKYhqfqCFAU9xKVv5XvJ/0EZVeLM5sxUgub/R6nNZFmfUAaxe+Z2X0/lnN6vtp6DU7doN6MxIXyuKwPqK7BPVdgLYOgg+Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e3SeEbl5/fjUaPvGyZenEpdV5FA80oCvg9VtxQVAYc=;
 b=NxUMZRvJNWI4ptPEVzozU8V5UY8SLTUddn/9RYMoRjVwnquVKX9uc/Xk8KsAN2im0XmxKNf7/lq6RDR+Mi+Xu2KZK0iAD/e5yXljoGLczSJZvE8Oi6vgLC+o58fVWBVqlckd2srFnj1ItK2/lIiQUdONzz9OeXRh/cRQCCEcrYhx+zLpdT2dgSYlF5rXkWKIZmRpnm1fRYsXbLJ6zQ/zq8H4DgOFjQUlwzGwLD+mZNgwsDiAaDPDZDYD9f/91GHhTqjNnqSdUihhuB9A2A34Dr/zD/Aj9n2gugAy9qfxffZwbWCIW+DnDChSUXte6K6cjymdpIiHo/HrlbK2Gbo6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e3SeEbl5/fjUaPvGyZenEpdV5FA80oCvg9VtxQVAYc=;
 b=lYpYjVj70W6gJYZ/cRHrknxRw6fVT8CynaM9tF9R3lxSRntY9vaJH4bmJytE5g1K8H/SplF2NRXLU76mozYFCQ8rPdwcLRfPbY7Q9VF5ztkWrn0ZNvu7jaYBOFRsacca2uoIcznEo3j1YQrDkJI4/efvOxi1mIIr8c1yarPMFRM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4346.namprd10.prod.outlook.com (2603:10b6:5:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:54:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:54:33 +0000
Date: Mon, 15 Dec 2025 09:54:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
Message-ID: <8e732953-80f5-4e81-bd02-2949bda804d5@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-3-david@kernel.org>
 <834ec5ca-d43c-441d-a10b-ea268333e433@lucifer.local>
 <7b2f7f85-4790-4eeb-adea-6ff1d399bd28@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b2f7f85-4790-4eeb-adea-6ff1d399bd28@kernel.org>
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f8b04f-8671-4d00-16ad-08de3bbff290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+srYYND1yaDU658cLUGLnebwpCrdPEKGxyoYtN9JES8tO9Lbnd0MywL6jez?=
 =?us-ascii?Q?a8rfKYn1jfpKx8LnYUC4HWOaV53GvrPSgfyOU10sUTDHwPkxaSwCJROJZVQG?=
 =?us-ascii?Q?qFnRUglvfMCNLT+MS4Mz0hgRVq9hi5MrGx7fNOhjZU2TtR4HRXKAkaSSnaua?=
 =?us-ascii?Q?7WUI9FUHtWP6fl6DR1jpK+ipFJ1knC0+6ePQTrZ7OT7kcHtdrxa3AA3UzEPP?=
 =?us-ascii?Q?a0R2qpj3AN7UGp62YGdY9MH4G+qdI31EEokp+BUlkaSDlZ3qiOrU7L+vp6+n?=
 =?us-ascii?Q?+AG/S7IKAmcZyK4k7mfZoVtWQQ8UjdR8vqCMu7BqucT4k4EV0NVoTgf0I57h?=
 =?us-ascii?Q?76jca3zoMm/I7A9JzplDklcGrecHS7zRn5CQYyHqMmVSm+Cy8o9GxTpbJRGV?=
 =?us-ascii?Q?EbstazwdtWFZjXXI9tnySeZSGumfw1i6Mv3zaZN/o28eB+FJcUC3aZI6xXzR?=
 =?us-ascii?Q?2lEcmQQRpzSaj36plMHplZBqtdSWH6/1cpofCevPgv/TLItkTSQeKmGrZK3Y?=
 =?us-ascii?Q?W6gV66cIZmH5fr10MkrCnd07KFxD+C4IqbPddvV1p3/acjfAL9pe7bQhxheG?=
 =?us-ascii?Q?m3zdpWxSw9V+0t0ZeoiTw9xNGPSCdP8cBjYVCxrrzZncg7ez1LvrCcCCfGNZ?=
 =?us-ascii?Q?afmBi9vUawZTPPEdOaTXM7Mhw+/huoRoD+BIIj6sewUmPkPalHR/DtC+tlvh?=
 =?us-ascii?Q?8aaK1a+qLYlOm9jIRkxwACQhxawX66WsWVvPSvcIoRTh4WYt76sHj1+XZuM3?=
 =?us-ascii?Q?c6Jeqxe7snXI9fCjvt1eLKQ1QgAvTnXssB09v6qkmLLWt3h5fwA3Uk0af87j?=
 =?us-ascii?Q?X8xhSdB+A5GscbjPPiSqVwTIt5ouG+p1nFDKDKy2PBXN5IsVh57rDZtN+5Fl?=
 =?us-ascii?Q?rTR/BChVdn3cgDF4aSK7uJSko1/1O+K8tBBNJC9ElKRNtJdXqyb1du1t+c7Z?=
 =?us-ascii?Q?mK59I/AuAC4iOr7odZI0VBFWfNtJ7srCnDud+4Ql56YnreJXe9eNr14pleKj?=
 =?us-ascii?Q?2E4b00FURa1wNuEHAt/Ql6f/l/7GLqw2evU0Muf3loUSK8QrSFzxST5lX4IF?=
 =?us-ascii?Q?UhJrXvlIIJsdPesmRH9xQtYanxXKFvCe0m0iOhF0mOJvIsdSbIcrwT7oLEr1?=
 =?us-ascii?Q?lf4M1Sr1gyDN/938LfOPqFIrssBaneqyLo63j145/Km9/1Gn7W5KBQgMzSHf?=
 =?us-ascii?Q?uHn0KRKhgQrL76/cTpOT8aVs1gAn7yMJSRXdiNr25Xc8AlCPSKYMJaiPge8k?=
 =?us-ascii?Q?3+2yxaY4uCkpz9krjgh1MWeDKZdOm5Eg6sEMUB4ZsN47mwWJVua5mVohEMD5?=
 =?us-ascii?Q?5HQnA0ggFzG6vPiGp4PSeDGVRuIF05cI2TZfRnFl13MqCjspMCnWOlse5P57?=
 =?us-ascii?Q?xlEiwhjDCgpkzthRAiRkonPsJpIP4a6DJILnaUm/RGg3MkVEvkKxMovhB45v?=
 =?us-ascii?Q?19+a0Qs0vScArtthnwu3OkMOjpUYSOgI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drA6RqCYudd9nauyyKOtIZcbSVlon/kRc7L593xzbxr6/HvpvQIaJLbucaP0?=
 =?us-ascii?Q?+FBqjj7p39bjhwYHCu9GkiuVkbyMcZrQ6+4oIrkWPnlC3tTXUfVfInY+pOms?=
 =?us-ascii?Q?boXgnB5Qifc2i/mUE2YUkMVo7Jcb1fQ+DKOm3HDWTqmKWw+1khGvntsDhUpV?=
 =?us-ascii?Q?MAZvpW51AF1NwZvfZwQanp/i172LBH1dL+H07VzpOVJ/PkQr7QojQGWRV/Ss?=
 =?us-ascii?Q?OVlq9383X2tQWHR/EaRPY1JcSJ4mzDJ0crQM4VgybG4cbZuwgfJSCYD0z0Xb?=
 =?us-ascii?Q?eHujDXWNgpGaZlokCBCqjcfYCVu3Sb/GqXpJZ7COqiWWx3WYih9q6nMzQ1NT?=
 =?us-ascii?Q?ZO870+45oXxZ6+YViPNZoRJUJuGPpQa7lwstV829FPE+pWJpul7Xa6V96jfc?=
 =?us-ascii?Q?dP7nglAZDNo6yHfWBuo+00hZmvNpctyr0TpFWX/qdPM2nLCGfhrDc59pBCFX?=
 =?us-ascii?Q?mDvetxfyfrFbiGktH05PNrwsPUAVeogGDMkrUvHRapaoMMLBkPNuqemSduUx?=
 =?us-ascii?Q?s6ZDZxk3FSQEL4pF8I0jbO2Cp2zDNsJzjcjk9NIsCk0rkA32XQF6EmeT1//d?=
 =?us-ascii?Q?uEV1LcBLTKiHD/ZxBP1sngLGwqBHjgAycV/0VFm6Gz9Fb8EL9/MzW5EnzK7j?=
 =?us-ascii?Q?urMmiu30SzWpr7Ru0Rz9myHxoqSqMHIvL5yE+l5ohVBxtBwG5u39NVy/N3JP?=
 =?us-ascii?Q?sDyZSEMO1nAib4RDoGOYa/Mhz3cgEu4lfN4obXjVYqqmey0x9g2tkayoewjm?=
 =?us-ascii?Q?ruX4QCQDM4abEhT3tZu93X75tFOkWVtZdlWNQbXlj2m7+PjkiYIx4kkDX4EW?=
 =?us-ascii?Q?r8GckW0Rq4JIXS9HNIz1bPMWM18Hnm+uh83noPz6c7ZoSD05YzCkJVmATIre?=
 =?us-ascii?Q?dVip/dTw9WTScsEapcBm7seAmMw6+aFKEFGuCmPWaOL7AGvOC7DrMh3I9A/u?=
 =?us-ascii?Q?C99zPNs+cMnSSheDxIOU91Bfx4ahQ3sNK9hQc9hRWBxFnhWqHwzJPOgBBv0B?=
 =?us-ascii?Q?MTOKK/k0An8Q8rNuZg8D+VzFLmrgTzrrJxu/CL8wZbAxudjq4pYCwGlMMJ37?=
 =?us-ascii?Q?Xo1gtEvXUDoCkc1pUjlq8SPbIqWrbDf6JllsBmO7IqJ/SUv7HY5gFfLeNzQz?=
 =?us-ascii?Q?MAa72iDmU0gTwXygKcry65VsY8xn6MXW6a2nQ4NR1NsFkd8v5vTyblv5yOkB?=
 =?us-ascii?Q?zUt0N9u3i1pLDJiD4I82m7C7VH1yEiiTe1Jjl4KVZE54azfwhEGvx2q6GKF3?=
 =?us-ascii?Q?okcIom6urrg1Lcujd0KlQa2/Rs/JlwxO3MPqEdKW8XpR8kzWasfxD/88XKvm?=
 =?us-ascii?Q?UkOXP3Mc7TB0ahM0wmVZXDdzLuQRcJcUAvkOwFlE2XsqRJm62Rf30meBN6+J?=
 =?us-ascii?Q?o/bjIp1WO4LjykvQclMhlzlAM2hrlCxUF+yOkYY+TgU9+CcqOjFJyQTCOe5w?=
 =?us-ascii?Q?QgkXWf/aQ4TMTWZVwghcAt5/giQ0SKHCx5onDmzJ0fPZuYaf+H5D4ONhyP3e?=
 =?us-ascii?Q?XnPklXxCJNCM0gxMIRjpNprDeGCxv0tr2QBnvwCDax5Ne64cnAcCGjaClRD3?=
 =?us-ascii?Q?VtkIfib+S8ii9U1pHm0eGQwhmFFeY/DhzIijEh4Gm7ysnQTatULnZGATN50S?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4gJz0VYTzKY98KMrjrrbNexbmHdGSkXdKLjfZ9lmEOVtu68rsKTq50EuYT1uP4hdBO0dsWHZcKlorh8nVtDNPh3syxHh83M+5udfd70gCXKw172/2f7LI+kv7aWu4PvxJWCFjudQg+JzDsM+N0u3TvIz4tF8bZcivxUmmejAmWLVj7Bnd5yLqQqYUf5nrFvQ4xYEiQcffSmtlTicYGU2iq/JCKqy7iE+nn/K0PQjJ1PKsfaszL+FaedihYva8XLPJWRqxiCpt7mXj86kKU9UieTdOHX6EmkScrqDX5RKIKwKKJCwI3oGu/2DMtnQiV2sp38u9gfo/8pINE5hecsoEcO2ySfpDyHYyKa8wCwz3Yn9GzLtCNXDUjVrYAX8wqqdsbsJQ246bK9DPbUX3z8XyxKO7ghl1mhQuQ1n9nCmgyHRxg6yXt6WTD+tgpaky/LjaE7dfnTPwueW1seda/vKnZltTtCLAJKRNClw7p3cAGO0YgSH2zUveT7hqmZYBtUnDlEzk8MwOLZneOxGgzLfBxjFBiqQPWcfuUgtfZS1Dzkyp8MjMDWnx7uRkA5QIQ4u/n6B6ap0Ieg3f4bGZjvrTq6EFEJYOY6i4l7jWqER/V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f8b04f-8671-4d00-16ad-08de3bbff290
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:54:33.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX4q4pV4kCbggmvhvyr5cnCMDHuWlUU74MMuYLR6tUyQxmP9V6RXJE0+BrYRX3aR/kF/Nb3UurmxHCGYqdRE9XeuG2Pd/CiRO9hQ8AfWvX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150084
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=693fdadc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=0gEsU9oYc9aDxLQlqkYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: fowxNksoVeJswxlQSTwdKYPTPwUX6pFG
X-Proofpoint-GUID: fowxNksoVeJswxlQSTwdKYPTPwUX6pFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA4MyBTYWx0ZWRfXx/v6g+/Mxrzr
 1wJDySfcus/dZkYi0j5IQWOMe8eCT1iTlAIDc0mBi7a4q4VVjGGUbJ0rgoMApoEfqDDEllw2BHR
 EkWUD7sF/Tpj9YzUHNjIngqEIX8edPKaR1ctBZxqxdq0TifQ66whtVlIQPAX8hCS0w96XwMiN2F
 /lZuFAAqERQZCy0IERJ7DCoIvbGh4eYCvPBiNQ/s5nne+UQai4bJFdpYTBTmKJd1aODA52R3gkJ
 f4yPMAji3oBSxOgzwAyjju32j+hRGAvrAa71+XrjNrLqNzzhQ5qdiPNsbPGp/WopuaMeAOvTpOi
 qIeHNawezkogv4NyX9sf+FYfgDOXMjXUXX1TCAvFRstRaEO5IiQW+5XmfLaLuRpW0JAOgjLsTo4
 kuHABdtkyP+nhifMgIl8pTU0neV8qXWWEFUmb8zCE/t5i+ecCuI=

On Thu, Dec 11, 2025 at 02:58:51AM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/10/25 12:22, Lorenzo Stoakes wrote:
> > On Fri, Dec 05, 2025 at 10:35:56PM +0100, David Hildenbrand (Red Hat) wrote:
> > > Ever since we stopped using the page count to detect shared PMD
> > > page tables, these comments are outdated.
> > >
> > > The only reason we have to flush the TLB early is because once we drop
> > > the i_mmap_rwsem, the previously shared page table could get freed (to
> > > then get reallocated and used for other purpose). So we really have to
> > > flush the TLB before that could happen.
> > >
> > > So let's simplify the comments a bit.
> > >
> > > The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
> > > part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
> > > correctly after huge_pmd_unshare") was confusing: sure it is recorded
> > > in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
> > > anything. So let's drop that comment while at it as well.
> > >
> > > We'll centralize these comments in a single helper as we rework the code
> > > next.
> > >
> > > Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> > > Cc: Liu Shixin <liushixin2@huawei.com>
> > > Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> >
> > LGTM, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!
>
> >
> > > ---
> > >   mm/hugetlb.c | 24 ++++++++----------------
> > >   1 file changed, 8 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 51273baec9e5d..3c77cdef12a32 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > >   	tlb_end_vma(tlb, vma);
> > >
> > >   	/*
> > > -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
> > > -	 * could defer the flush until now, since by holding i_mmap_rwsem we
> > > -	 * guaranteed that the last reference would not be dropped. But we must
> > > -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
> > > -	 * dropped and the last reference to the shared PMDs page might be
> > > -	 * dropped as well.
> > > -	 *
> > > -	 * In theory we could defer the freeing of the PMD pages as well, but
> > > -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
> > > -	 * detect sharing, so we cannot defer the release of the page either.
> >
> > Was it this comment that led you to question the page_count issue? :)
>
> Heh, no, I know about the changed handling already. I stumbled over the
> page_count() remaining usage while working on some cleanups I previously had
> as part of this series :)

Ah :)

>
> --
> Cheers
>
> David

