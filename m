Return-Path: <linux-arch+bounces-10533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE07A5441D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 08:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3908416E442
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D621DDC1A;
	Thu,  6 Mar 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aZmkPdb0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="neMh83SC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA701A238D;
	Thu,  6 Mar 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247992; cv=fail; b=iuAIiYj/YaIahxVPB8eT5F/nIVvVGfEfZDOAuAqMCa6djY4moCVTtzgsOMxheTa6Ug4vQcE7gCZ6FUcNy1ToTuUoLSu5Q+l0djgDrwuM4QoSk8aoXOa07BSadm3t1h/RRXzYpmnk6eIb6Sj8Vhh61wLJugF9Gg6ePTrt/ySGDDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247992; c=relaxed/simple;
	bh=166NcwtfRFNO+DZPi65EgNit6IVB8YcA+LD7Ge2MZXI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=IUz8+uW7RMgXWSBPMUBjm9lPN0fkA66ZRz2iiLMQW8Bd/jUn8ZqCBpCrCy4fBgKHO/uXgrULiUBVALfwPyRcNXw6Pc/wRHYD5/hBj6tOziJSSf7rNAvBrKNhM8JDKhANDvhyVwBrmIl60wz85MkVunZpHF1McNKkG9TjuXSBv8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aZmkPdb0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=neMh83SC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5261uCBf007089;
	Thu, 6 Mar 2025 07:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=XLYfOAtwF8eimBWiHC
	rxa7hve500W+QUIkplfH2S3dU=; b=aZmkPdb0Ovngp5CnY++56Xnprf2btA0L54
	lARGcu196J++UWjV/k7uF1nS6MeOQCu4xytl3GQaYPMtkCs/FAzdUyPWOuKoHa6E
	MCZA4fOtUZBp9JfZ9phr2Iw706X9kiu2jWpT0I7aWtGm2W6SWNFwInNP8qpEnv2I
	8EZQ3xH/n/SrIjcY6+sLmMcRZrXLUzgRgDv3QkygsxTdrrZ7XPVoFScjrO7t22Ue
	AZw+i7NNdPX+EYdmWcwWDrFAL0Tv/4yU1+qOgyV7tWvG1L9fTKkMnEieX0v2w5Lz
	WNJt+Da6NbnWKFvFxlzFhXHq5c4m/cH4xJXn+3CFr9enM0QcSDEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u821kq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 07:58:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5267dFFk038259;
	Thu, 6 Mar 2025 07:58:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rphy666-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 07:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYd++tZ69s4wflh4N4pLPhA9IYZxqVWQJFe15PEN3HU7UT450QqVpXc4SejVsbkdO8brN2xhnCxu92CG5j3SEq2PaLcmGzaCoj7k4Is1m6JUPRWOXsbc6CBjN15brzjCpuf4khHEMPYEYKnYjNT3r0YfRJN2yGe6VceWYJdtMzg/KiBiiYhSRrpApbfq+DCoMHaSh5FNSuskfnpqCV59hby/rbWCKjftpAJVBTEbNGQX7Xqab8EBkQ3yIxdGdfPy/3mv1ReyLgvYqnQ+Xvu/kBaC40dyNAcrsFEOWz6xkbpIwy5lNSNqXlY7VNujyPqsq/L9sYp1zHvRnuH4r4JgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLYfOAtwF8eimBWiHCrxa7hve500W+QUIkplfH2S3dU=;
 b=tVKnJxk/Y3pKj2KctCxTIyRf5tIYlhkWLyiLXQFAn3Q1fRK12Ee95K0uzKWHUAseroU6zT8pvy3Ix+Q2JRhqJp//JNT4EGktgEOEoF7medbfFgN+/jup6KekxKZ41BLvZZL4EBL4EXunK0aV+n4SNfR52aB7sOs6Qu4mPC1CF+TxOPsQTecdU9T7RdMezuKfLPRrxsHfwtQyW5zMJsQAMLxkpP+YB7xTEZfstLZpmWnkfzFupGOpdhk8qpBosF1vccvZiB71OgSztGxRRQBffpdHmtxMpy3x/AzbbXRgFV3IEvj+XTcoXao4sfOv535qPeOoYdHU8mej5z0cNLB8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLYfOAtwF8eimBWiHCrxa7hve500W+QUIkplfH2S3dU=;
 b=neMh83SCx2wZa0gSA49ST5f4epPhOJMHbvJtJA5DNLFR/Us5DvOI4fPS4jDd91bTJM8j2uTcb0hsQUqFdILcquZmjnLPdyJkAmUzhu4e+rqfPS2QK/Oid0Ka2MT2z7RTNDU97T46Di03YiLSYBisq3qZk1oqnzHO4h+8r9gDBvs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 07:58:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.028; Thu, 6 Mar 2025
 07:58:15 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-4-ankur.a.arora@oracle.com>
 <Z8dUg5zzclvDpPtZ@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 3/4] arm64: barrier: Add smp_cond_load_relaxed_timewait()
In-reply-to: <Z8dUg5zzclvDpPtZ@arm.com>
Date: Wed, 05 Mar 2025 23:58:14 -0800
Message-ID: <87bjuesi95.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: f8232431-b042-4bad-70c1-08dd5c84a68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWeW1mRqU2TfePGXRtTeq2W7x3XJsv/OHwTDBp5o6OavpPJsC+lLIUdGWW0D?=
 =?us-ascii?Q?ObuYeVe/yjaVLixiXiMO+dZxTq+ieQ62v815iqEtV7KGtTpL87CLzPEzgvAc?=
 =?us-ascii?Q?H0yZRd+8rg6NIL0xYzPmFPLVQpYdaIqmXLIp1bcRtW85H+PjxEowR+ZOFqH8?=
 =?us-ascii?Q?T9b1UiEkOkXmqkvMXZ9uNVZZFnr64a7WkSoYjKZ7IYGVodwUxA8UDrDra3cN?=
 =?us-ascii?Q?3BBl0Y2n9jCdIiQNGV34gCZf2z1u0DAsDToKUNtkjiKTMEsXizzrUnsG/pRr?=
 =?us-ascii?Q?xvuMtQk64ByFXdrX7PgBe+bWweru+FkmIt8l2E/z686DLKUREmpxJ7z9Kx2t?=
 =?us-ascii?Q?oJu1NHSfnmBRCFP9wpbk8KKMA+cd5z4QKfiY1jDglyx6/rzbynLbLuhoo9eM?=
 =?us-ascii?Q?vE7Ad8vsSmK3fZXf06kGXaVxqFV/Kj7t9eD233OoWvsYlAkF9MWLxxxEcxCa?=
 =?us-ascii?Q?VVuAMtqtZ/iCwSwWwjdLTfvJ0lQOXzUt7sq8t6hMYIxkH5PaGyvWv+jU1dmo?=
 =?us-ascii?Q?7okXH/QyX9Gi+JiOeMYZMTuM/HS8g1Ah3DryU08NjAR5AL/MfwsbLo1kwf0H?=
 =?us-ascii?Q?RfGQDl4OPi31TuO34o2tzHG3EWsXNW8/+/9GsQMMoEajhC7x7TCqkQP3/dKv?=
 =?us-ascii?Q?2+Ij4LgFZy4LuwFRES33iWRQS0lbHpTxiJ8pdptBrSFtqR9KtmapEv/Npqsm?=
 =?us-ascii?Q?ZiAKc96IfR5lu7e1KLVserqwXw9G4r5Op3dScXmrfHDObF/w6fKiy/6vR/72?=
 =?us-ascii?Q?WluM47fav2jb7AGJpLwGKqmOwZcnHQZFJTow1yLkARx/RBZ2xhCTHdlQW+t+?=
 =?us-ascii?Q?WCzFdkAG6SaxcIYjGRtH3/RjjUtxAQxogicryd1Z/Zl9JLRamOGj0F4EZcae?=
 =?us-ascii?Q?VanJ6EKRr/iGfb1XOn5smOXnxzQF0ijPSvWTKqv7oNKwv6Shja7woHtwN1EV?=
 =?us-ascii?Q?H/9O41eW792yjeOrCsCZchV2tE6XH9xQab109gD4Jg59+0qcbgMYHv+lej/p?=
 =?us-ascii?Q?0553TCj/8K9wEmjRoRQBnpFqSUr+hI7ChvTmn7fZtgYOHoWr1UKcE5slABSu?=
 =?us-ascii?Q?ugGt+gQrhbWTLNwvLZqzaMTrKWIdGVOddlsd4QuHOK9nsWOuMZfMifYgQNoU?=
 =?us-ascii?Q?AmYRNSGXmzqYw4540xPDkRwWu93vUeskcu5jD5XudiGHYgaP2K0FkX+xBbOj?=
 =?us-ascii?Q?+6dq48syYZrpOoxrbbgAe17v6HZt/1OBcM1Zb5RFCsJ5WtkcffSH6GVPYRnO?=
 =?us-ascii?Q?kvrcX9goHYDE02DmLf1nZxBBB8RduaPCiX2JxRrZdxuzbbu6C/I8XNGQ0sU8?=
 =?us-ascii?Q?vlqhH4v8oKhsTg9rnoatC7/rBx9OYSHEdQNEa/kaEQmIN9fQlFtZBQngGu8B?=
 =?us-ascii?Q?soVw3hNLS93uKNmU5cLusPa74vx9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQ9+rxFKIL7Xy2kDx1A5E98yTb9TNqwRcmtdz1QZ6d4JfDkBkD8nds/WbR9T?=
 =?us-ascii?Q?48P4DLCmUikRF0qqMwG0Zs9Abz56HExUczntRiNeKX9dEqNmSptCEPcEYADd?=
 =?us-ascii?Q?t1cW65TkALRrqbA5fmyArUenCrGpWbqpwdiU5u0T/LutjPGTea1W6Iv2XkPQ?=
 =?us-ascii?Q?E8fvmTW1CqTjT7rpV4FU+DwmJaJcpOzlR8mrciPkB+NB8RHhSyj7SO8/ZG4r?=
 =?us-ascii?Q?kXdBHCdbuUuxdrU2ctYXhnZOj003EA5da93Ow/bYbee5OtFwkzzTrB2bDFLv?=
 =?us-ascii?Q?MYAWArmKQDHG7KNSGUhu2kTvZ24bgJmhKp2GDsNfi06bYDPAQCQWgeYuxQxf?=
 =?us-ascii?Q?K1gbSt+NcWvuni7xz83694icUMy7FShmlRr1V4AFen20M5fNoFhir4KVFCey?=
 =?us-ascii?Q?Nwu1ioX7HutAqH94YC5wyy0N7ZqmxgqyfD7Rf/KVQy0eQQcpYandXDdW5H7N?=
 =?us-ascii?Q?MhnGFgUj/Z+6dDztO7Kv/dlDoDctGbAG9zRxM2qT7VTUi9BIYr3ZJHzRSpnI?=
 =?us-ascii?Q?JJ4hX5TfVGnhHgn0YceVwTJRB2jCiNiV3GmAdb468xs6Hze2VtLbscpSurYn?=
 =?us-ascii?Q?1VlsvbaK/LmENYXcS12p5JnCIIDxWPmg/5wYQ/yGVzNPOT17Hu3vQvu4RHTr?=
 =?us-ascii?Q?uIhH2+kFHwePJtO5OnYi98hbqoxaedf6xS1chtvamH7sT+ju4bYTmUfK8OTj?=
 =?us-ascii?Q?CMs3R0CO0NFm1scy+yEA1c+4cwYopKkrz3AhqMhnVLsn56CF5oUwKNPJIPqS?=
 =?us-ascii?Q?ANKExkHnwWHOQUhmxqjgD41apY5jeXgcIu/7RxQtc1cnkYDUVF6B6AD4/yqL?=
 =?us-ascii?Q?WrcYfxdv9bSQxbcqZEbGadGFcrgF36IIjsIPrLxggZex0swTAJeGYBnlSalD?=
 =?us-ascii?Q?mdg1l5qDpqUjJ/L8YujNpq5GuhJGOEdk2bA1EoVSQbH3Tzzi2TRS57kq2dNf?=
 =?us-ascii?Q?gtdW/eJ5Zt98roPhxE9gSlZX2nV5r3sKAcxcextkbnTYphC0+AtZuW4xtVG3?=
 =?us-ascii?Q?J7uZeOhWk7kMpR/BCfCZYC7WlxJptRl9QtmA2DJo+xuMR5y98kQfvPQ3SDXS?=
 =?us-ascii?Q?VkT3sRR1faDZwVxUUXsap2tPqBFem97rpPL1b9cbRLP0UWzTcygHrrgvmVas?=
 =?us-ascii?Q?G48siYXtkn3EBB9wIpFqit6vlCtDxXp6F8QWxPw6aTnDPdH59jyjqXH2Y2Es?=
 =?us-ascii?Q?c8wYFcMuLkv4x6yg1yEpwrXMM+dacAdKxwPmMpPiqi02/ka94zB7Fzj/ibHN?=
 =?us-ascii?Q?YkxenUz330/mOBDAwce0WVWrc2fwITToDqkYbFS9RtbSOTEsJA7f0Cyltcpv?=
 =?us-ascii?Q?taOzUBLiaUSN+ioXcPnJhs9LiEpsD0WwLJdnNjfw0FyK0tDXwKGjclGQ8f3J?=
 =?us-ascii?Q?f+B1O4iEYk+nQT04Dy3wauSx+xNfJpgnghpI0n7HL2qYRrPYcIG70/wXXCF+?=
 =?us-ascii?Q?huaxIV4tQP8RxYkhbV8vY4qrjs9KuVoz6QE0CnCVa1JolyznFZsF6bqctnlA?=
 =?us-ascii?Q?PawnkGRnVbnKxvQyZcgHGBrM8+f9Cu/1JuRhsQl9bVcRx+HmEKwlFVLAp9F9?=
 =?us-ascii?Q?i86KU+UzHp/t34tRenylm7NZXUqTqDZUUZiIjK3sE+jyCz43EqsAjYAsVPuv?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bxoAlBHsnhF87nirqwQEum7fZmfTGcyn7NuVAnPYxVSQwPcs0NSpWc+oAsssgvrXNM3aKY4dyKslVG776mzdY4XRTcNG5bbfhU0H03xYPb7MvMOLY1u+MxOsmO/uHCZy8DvuH0vxa7pHfwMBawdqhD9PWzxB8O/w2wqI6bVrDjFEHRtY0jrevVHfSRIz0LsxHchCgohvMBGMpZ1jG3+1HfyFtdBzBFFA5hNcuna4tWCvUNFFcWFfbFZT3gBjAccVlmxgXr0DKnC5YxJ3dBOTaOfjKwUWPbRMq5bj+JPY/s1qQIx68HnsS/UmP7ESPXEzBt9JykGlb8oi/abNLLGlclvyceUcov+wr6WVK7vuuV+kqmwOdl5/zZNOMLI9Exi3w6ZITS/KoQLYYgeTXdpLECvmMp8LgqYwoj7dQXJz2Bab9RgfX7R24aZZn8HlZ16ZYWUlaH8sFj5Blf4rLbjUDFJSNrb3+FITWY/CX8ToBUkhFE6vRbJSH0bhBrCCkONr63YoimyxDtBaCkVjfS5gi1lbRDrrfXVOCBkBINWu2UEosTaz1xRwNSXJyuRZKpD0LUycI6J8SxdvZtnigltgFtpa3hGRdq1uSYnvxoPzXNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8232431-b042-4bad-70c1-08dd5c84a68e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:58:15.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuyeWQfMRWAvfsST7R4YrhTw/apqs5qIaybM6VB3nnKaRAljwSlZgfn+SwlVojveRqkeQEbKaF9JWHaqDyoWxzd8+h/gx5OhRfZPwO6l8S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=871 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060059
X-Proofpoint-GUID: hquaDgzZiZVHjJGceRSuzkv3XIsdKzKp
X-Proofpoint-ORIG-GUID: hquaDgzZiZVHjJGceRSuzkv3XIsdKzKp


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Feb 03, 2025 at 01:49:10PM -0800, Ankur Arora wrote:
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 1ca947d5c939..25721275a5a2 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -216,6 +216,44 @@ do {									\
>>  	(typeof(*ptr))VAL;						\
>>  })
>>
>> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
>> +					 time_expr_ns, time_limit_ns)	\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		__cmpwait_relaxed(__PTR, VAL);				\
>> +		if ((time_expr_ns) >= (time_limit_ns))			\
>> +			break;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>
> Rename this to something like *_evstrm as this doesn't really work
> unless we have the event stream.

Ack.

> Another one would be *_wfet.

Hadn't sent out the WFET version yet.

Did you mean that this should be *_evtstrm or *_wfet?

>> +
>> +/*
>> + * For the unlikely case that the event-stream is unavailable,
>> + * ward off the possibility of waiting forever by falling back
>> + * to the generic spin-wait.
>> + */
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,			\
>> +				       time_expr_ns, time_limit_ns)	\
>> +({									\
>> +	__unqual_scalar_typeof(*ptr) _val;				\
>> +	int __wfe = arch_timer_evtstrm_available();			\
>
> This should be a bool.

Yeah. Will fix.

>> +									\
>> +	if (likely(__wfe))						\
>> +		_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,	\
>> +							time_expr_ns,	\
>> +							time_limit_ns);	\
>> +	else								\
>> +		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
>> +							time_expr_ns,	\
>> +							time_limit_ns);	\
>> +	(typeof(*ptr))_val;						\
>> +})
>
> Not sure there's much to say here, this depends on the actual interface
> introduced by patch 1. If we make some statements about granularity of
> some time_cond_expr check, we'll have to take that into account.

Agreed.

Thanks for the review!

--
ankur

