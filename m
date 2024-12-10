Return-Path: <linux-arch+bounces-9355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DF9EBAB1
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648D01666BA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF15226888;
	Tue, 10 Dec 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixC3Uco/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DxG2UiSV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4D8633A;
	Tue, 10 Dec 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861699; cv=fail; b=BUHyAIX8dbgJCney36HS6Oqb35uMStaQTkq77bIEnFsv3d7F1lexfTxwVMLWZiMca+MGJzyv6SxvLZPxPdfl39GBlzsuSUjXWHV/1EyTaJYUETUyb5i65qi48lL/NNTdR7ZyiXVdihZYeBbHUu0HFja+qHb1cfI/PxEOgKi16pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861699; c=relaxed/simple;
	bh=5BouSDfJUs3CuDdrJ2qGU8YZ0gnYGKcWaP9fGu+YWPw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=DVCZBSWcRQBLz1FjIXfg5MV2yNYutgz3YUfjCS+wkqUlOs84OkO06lqSxdeu4UIKnqbAdfY8/CeZoPFouE/wjHQL8WnTyP3WSFBBT5ONcYcp1FXUgPs1Dwlu9D5jKMT5JYxVZYqCODzdXe3y59cl2k8pCobg8bUF/5UiVK2PmJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixC3Uco/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DxG2UiSV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJJJKi019123;
	Tue, 10 Dec 2024 20:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=EAtSV4hnYHtksUDHbr
	KgTUdsSmwz/sbq0Nfhrup685M=; b=ixC3Uco/RQ8aW0rrS9BjXyx9f16fjdYygo
	OP0Fv8dMdcMJ6N3Mvo1YpXnc4Fw42JLCc7uNlUEsSsLsyTrnoNZylbeiLF/NOU9X
	obYciIE6WHHp6jzIhB+CL8B45OAb9SaLNzBj4T+R7WNWVsgBQFbGYhm3rJ/X9Oyb
	mc6Og7wLJVHJlqL1Blr3XiZzyXUU7Cl/qo1jfPmtfwv8F0i+3Vr7PJbdG8SAVHKd
	95VgcOLbyrjdQkjJ7dbQzZKTqDi/hOuFWzCFRIPNE3c5Ix0SWry4bF+PDHFRylA/
	ZmOI4hTJGltTS86wjV+hkRn+AtHXgu2ugoY3ClVjdgdaIFOcpKDQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt6udt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 20:14:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJALqD008623;
	Tue, 10 Dec 2024 20:14:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8uy0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 20:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRafTKZ5Wl0XyiB1KmoMLHiQ0mu8woYmLW6pX8blkD6fTzyc6ofLahV+gYWl71a3qxIYET7miUCiUhETZfQoKJCUF9AoyoXYZWXDqj/+Je91Q7Rc+d42XLFFlvb2jYI9xiiGgtXG8i3A+XJdjXAy92u63Dma2+ZeTARdk+xzUxvdD/A4ENMreuL4/4r/ss5kdyfMk7+lJjIJufq/dMjoqG6QkAwBe+TBIE9jJZnbFljbtOSRNE5i3CDGBkoNNU3dTJeyIqllGBJh7zv7kFVv0uyYQQQ5Nlcob6+JfJp9KI3jmI8PW1aNos6d/lOpgNy3Z6KcOiXQByzRfsrZHEGypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAtSV4hnYHtksUDHbrKgTUdsSmwz/sbq0Nfhrup685M=;
 b=zIYr6FQWNzeLwMj0HIIuV2HPEihOitUdx1gFu2r/muszLDExP2NmX/BXI5FTUWvstQlr/tnZxpu1j0SQDzlGn4ynhY4wCRLLZeIfpTKrrCi9Dkf0Q2d7bf+b6QD6uGeq4dDB4oOZuNXqIiBBW5S7bGVeu0u1spX8xxchngxhe+DqCGu3uaRMrA0O41gGFviqAd9QicLSoRJ+nbYnaav3iBlHYRASKwb5X6fuu9vSgXU2TBA3HcclhC0fgJERKA7ZrXP4OlLtij6M5FrQoDeTHq+PuRsULVQ4Z8pU6kb/P0cWjpye/8hOpYFWwZ9gE81eCm9DHaYHUhltOI7JA8He+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAtSV4hnYHtksUDHbrKgTUdsSmwz/sbq0Nfhrup685M=;
 b=DxG2UiSVX3g9D/UQM0NcggvE6eLlUAn7lXojJD3ZqPVH5AjetZmVQU+/X/aV5zF7jgaa0evf11cI0YnuEb9WlblxFwQ7ma2BUtzFp7HcytSGVTCN9NfcihLtz6lZjXLTXBT6dl1fpZlmb3dvlEnJJef4Gaa4FBw9uy8H1nZ158s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6536.namprd10.prod.outlook.com (2603:10b6:303:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 20:14:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 20:14:02 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-6-ankur.a.arora@oracle.com>
 <20241210135052.GB15607@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, pbonzini@redhat.com, vkuznets@redhat.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, peterz@infradead.org,
        arnd@arndb.de, lenb@kernel.org, mark.rutland@arm.com,
        harisokn@amazon.com, mtosatti@redhat.com, sudeep.holla@arm.com,
        cl@gentwo.org, maz@kernel.org, misono.tomohiro@fujitsu.com,
        maobibo@loongson.cn, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 05/15] arm64: barrier: add support for
 smp_cond_relaxed_timeout()
In-reply-to: <20241210135052.GB15607@willie-the-truck>
Date: Tue, 10 Dec 2024 12:14:00 -0800
Message-ID: <878qsn9tyv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 913b8812-344e-4139-7342-08dd19573068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nsTiJP5J3oiQ79cPgTzoo+pBMdaRg8ciC1lGvtYgXwH2mGfrN3TqcI8o5n7M?=
 =?us-ascii?Q?5zB4ZsGlUc/7NfHhut0ojdO1DhRa1TR4brV/DD7m40YTexsnoQ0Q8nHflqfX?=
 =?us-ascii?Q?yRgLGVFYr52WEW0sVr2UozMUo8jNWZalboMgKICs81atr3Cug4M/xzJ5FWM2?=
 =?us-ascii?Q?wZZCVvJhHtdjwZKXM6X+JtTIBAN2GTjYpd/8FRacQFNyfvlNpN2Itn1cgCeA?=
 =?us-ascii?Q?bv9u2YLTvguCOB/ENR02u9lPNrQft5OMX9MjWQ5NhDhFz/gcVpBzLNWryRfb?=
 =?us-ascii?Q?M19MZREESU4/4YN+QmmbvtGoThr8CUvBvUdWK5pdPW95CFCdi2UdQhMbykNT?=
 =?us-ascii?Q?735EjzAPjHvo8vnfQCNBNX0+TcvjwVwh2tFn3L2sHO3NY4ZnwgFapDWoUGs6?=
 =?us-ascii?Q?L+hDZcu6f3JAoPqdPSGXD3IRxdqmuqgXHnbsU1Ffu0y24dyK379gNMpiXLgB?=
 =?us-ascii?Q?8lNkrYzSEw9tpZov374LI7v/cjOQ8hYYH4QICqXFNV+eMbNwoLyeAfAUhWgW?=
 =?us-ascii?Q?xkNyGcFQzjDGyTNBpgu+6MPzDOCLeTvSndKXHG8bTi+6XQeiqNHmZ2E4vAfd?=
 =?us-ascii?Q?EL9wQVLsiH4vQYlXwwZP+RBLk6NC5o/Oz0ofg/f6hTqyswbVkCGQYzvtbbQb?=
 =?us-ascii?Q?ARKiBsNHIZAF/7b8zU1o7wtUrQY5eomd0rFG6B1j1a8Abopujnw30MWmd5VL?=
 =?us-ascii?Q?xLn02ubrq3TJesyXkIvf63li1ZWYxhvkz6HpObuWd2eUTjgCCfOm6zqxUVi5?=
 =?us-ascii?Q?BavpIw8+r12+kbuNw3XzT5dx6YLXCWtjfVMp6OGsQwjXgRT5V5M/6tiov4WE?=
 =?us-ascii?Q?iivloFUpPfZNwqxoVnukLgR/Ubgxk7CHM27U5X0+0KQywTAWvs8Svp/tb6XT?=
 =?us-ascii?Q?fEUceyetYm7yjFkrx8FCDaF1liLwV4N1Ma2i6YHVvvWaP0sszXTW9hepslgO?=
 =?us-ascii?Q?weMgsbNrDxQiALJZ0YfO9iIlRdPPIlAJuSTgGwlDGUsisAloB89ewz5KklOP?=
 =?us-ascii?Q?HBVQaWIRVAFUb24dv5hpqxwRQiRMZTxtwgPjy3Ua2eZqzkDGlG+YEmNuJ+li?=
 =?us-ascii?Q?Pne+TKFpKWhajF5U5tuB84Q1cxe2acuJyDImbhMijHtKalSzyQmdBDf/J8sc?=
 =?us-ascii?Q?Cmb+BWdeCWgJWaA/nq+DlZiSzamxziuQY3jKf5Y6pbpx2pkKGn0lcTmQZdHn?=
 =?us-ascii?Q?eMhidw5V/2VNB7HmOTsCo/RcecvrvVhTnMSIRlSZybZM2WHxADp/S+uDZ/6r?=
 =?us-ascii?Q?/QfQC3bGxrlcIWCJqpzhhcJHrLKKZnxpe7bENZxzJs3chGVZYSpSkWHPtBDH?=
 =?us-ascii?Q?OnRmbRmbkuXIiXqF200qLbuQPJEeYwrjeShUAmrH7VjBKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DbNxkzWUpKSJIpNsMSr17iDWBKZ2JScky9WoDGv6WJm29vwTGGJXSZZE5cMj?=
 =?us-ascii?Q?TMxxH857zibensz6DNtqX2DWchj32Rq97MJtgcPNl4+3APLppknGCF2LpdFV?=
 =?us-ascii?Q?czBkax3ClGSAFGSFX1vrRwHsg658OD3wSqcpAfaDxvYLjNkW0EEFPhddqa14?=
 =?us-ascii?Q?DaGCr6kZzR2XgAb8zQbfHGdnATaB69M/CKK00uw4k1ND0qag9tjESWNXukke?=
 =?us-ascii?Q?5Bc1Fl694WHm00aFm8kpU2yApUNvWzdR0i1b7nvRmnDHYlp6KdV83HMoW6bP?=
 =?us-ascii?Q?7EHr/sUWFMM+5eMNjCjTIwZuucs0JqZ7411Mqjt0JiS2wR3LQ5+bx+SRmDwY?=
 =?us-ascii?Q?OusklLFN0+eA3+aAR6TDWRPzkawAKSzDKPlfOE4pwqOjpGUpjvGq3vxCfLn5?=
 =?us-ascii?Q?braa/oSJlFySh2jcqh4wLKlc5WA5qcBOXIvYFUk0ORl+hehk7+VZmsDuDJQd?=
 =?us-ascii?Q?3lxvARVbeTBq+FVXWXFF5NOs/08mIZSQCY6+Rm8DX5sY5VibTzKljSGbzP7X?=
 =?us-ascii?Q?ofLaVD9Ded9rtlh/KMv+t7VSgVgZMq/FaqEODPk7K/HfX7r4E/9ZreKruzeK?=
 =?us-ascii?Q?qQ3TBNPYEBRPEpLIbmg0RdUnIXheUw1MWcF8jaDvP2YZs1k1YwnEkjDwLDxT?=
 =?us-ascii?Q?Er5nVWxRz+ALGwQmxRfu8Gw/hT8fl+N064NyQv0R1DMuz3W2rzCpF/9PA5Qi?=
 =?us-ascii?Q?VjaJmcTyMlWEOJ+4YuDInxrV/DDw9agek1QqfYHqslVjM2//64EzFzd8N8Xt?=
 =?us-ascii?Q?sNqRAoszMfjYNwMR6r8BwA/wnI6/Ro8e3XWzL/3MSEnJqw9afL7/LTlRqUp/?=
 =?us-ascii?Q?9R2BBrmIqAkvUftGBZJ2FK6Hxkiwf3WHOgI2OGAVIkbXbx3RzzdDz13ksX1r?=
 =?us-ascii?Q?4hn55HUBHnaAkKYLpNgyfOjdZYCktcvSlEce73QH9X8pOXzhR1HsUzWieH9a?=
 =?us-ascii?Q?yF+cudpa2x6zQKr8MGW4bvtpDoDYYBcfHbIE8Hi/cjmczOhsabjiFUlXDO5/?=
 =?us-ascii?Q?jVeLkAhdmmQEYQZsQf4ScJ+oen53KdusMmvb8UrpNFjQyWJ2Xfq95zNNUbGh?=
 =?us-ascii?Q?cNBV5Ed5dZQ7s7m3V0AMmAgdCy/cGqgPUgy+jr8huCjQYig7gL3nMybG+2aW?=
 =?us-ascii?Q?kwHZcP5iU9esBGi//9Pk0ijB4qnDcRFyLDVP04JfOHdBuv+Ht/9vhuUiAbVY?=
 =?us-ascii?Q?DnXJtcvKuGgFsZIvD3gM2iR5fD+xudnCg18NW++ak7q5jpUQTMI7LIz48xpI?=
 =?us-ascii?Q?2J4q1pjQbk+KABRM517y7yroQRWjqR4r9hooGBA0SSbW11FRk5Qd2o2+w9nu?=
 =?us-ascii?Q?jWTPEA113NeQC429jcc34HQpup0Tj8UdIJliMpr6ALligaeh179TzfxE7NfM?=
 =?us-ascii?Q?Q2Hc17mZ7gMmxX2zkoWSnWzSfKLbNyEvsoLxnLE5bUugqK0Y5jAB0fCdYP31?=
 =?us-ascii?Q?vgmh3bnzbA1Xxu9LnGld+y5rSzvqySi7am36C53ygUGEehxEt9tqs1DoMCP9?=
 =?us-ascii?Q?yBu+RHa3fRVSe4eLgnVfV6YAUo8GIS56Px8TUzftPM8elSat56QlxahSdrwE?=
 =?us-ascii?Q?03DLV0fIdrTnp9atmMSMLaeNh5g0QoVYp/5yLvqNOwqPSBOdZ/2eONFrfoTq?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+OK7gZLyT1frRWLApURgZ8W3y9oT7MRTLKsIphI1NIZV7I9Og+AVnX+RzEK7sC2WEuOQSLNdO6delg7iRBE2Q2ZULOimewYC0buc52y4V3naNarhXKVZJLSPlulQnBVT+okkN45aBbnuQcMWVfSLErE7wbcKQEPpPhFVnJtYLOcF9yfaYp9lNWQ9mGg9F6pIF9v0m6O+0rv8sSFO+uQNOGKlEtJ5G+Dv8CiMFrb8Hams9e9CzxTempviG9Eev14qAblPfULrn9A/Q8k9eJDC47eKoaw2/H237nrOfslhP323dHEIV4PwZyRH30W3Ml/CJiSA6mb2gXZ7Rm4988urC8SZ0v1XG0VZDdldE7e28IeFuemWWkQPYZFYMYdE6xO7bDHkQ+hq51+R8aYQquKG2vtjVVlX3ardeXc/qAetJAGYWXfve+X0PkMWOM4VncjKLixALBDHQ77Xid0F8GfsqV8PlufVrBYxPO202uTWKBSYSrtyZRSjy4DetlwttKmdgGS7CDwb5xP2yABcHuwvFLE4GlBw6IiWMdYUF7EAPasV+VLe8b1529kxVldNL5IsI9fSczpScn5EYtblsRQv/ihWlG0oUosVSDqcNUBbHyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913b8812-344e-4139-7342-08dd19573068
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:14:02.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UVZCt9G9Wt35o/epmYd5pDQ0ywXCYGZFpwnoZzSr7GhW/wuiauus8zenVqsiYH9UgDrXoUThogLHzk92H3oNEDwf1/jNeytX6ENV9FEun0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100146
X-Proofpoint-ORIG-GUID: 1vZraNKsAPDauMQ976n2SqP_3dtihJd5
X-Proofpoint-GUID: 1vZraNKsAPDauMQ976n2SqP_3dtihJd5


Will Deacon <will@kernel.org> writes:

> On Thu, Nov 07, 2024 at 11:08:08AM -0800, Ankur Arora wrote:
>> Support a waited variant of polling on a conditional variable
>> via smp_cond_relaxed_timeout().
>>
>> This uses the __cmpwait_relaxed() primitive to do the actual
>> waiting, when the wait can be guaranteed to not block forever
>> (in case there are no stores to the waited for cacheline.)
>> For this we depend on the availability of the event-stream.
>>
>> For cases when the event-stream is unavailable, we fallback to
>> a spin-waited implementation which is identical to the generic
>> variant.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/arm64/include/asm/barrier.h | 54 ++++++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 1ca947d5c939..ab2515ecd6ca 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -216,6 +216,60 @@ do {									\
>>  	(typeof(*ptr))VAL;						\
>>  })
>>
>> +#define __smp_cond_load_timeout_spin(ptr, cond_expr,			\
>> +				     time_expr_ns, time_limit_ns)	\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	unsigned int __count = 0;					\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (__count++ < smp_cond_time_check_count)		\
>> +			continue;					\
>> +		if ((time_expr_ns) >= time_limit_ns)			\
>> +			break;						\
>> +		__count = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>
> This is a carbon-copy of the asm-generic timeout implementation. Please
> can you avoid duplicating that in the arch code?

Yeah I realized a bit late that I could avoid the duplication quite
simply. Will fix.

Thanks

--
ankur

