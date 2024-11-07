Return-Path: <linux-arch+bounces-8907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434B9C0EA2
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A398C281F0F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0E21FDA0;
	Thu,  7 Nov 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ak8pQiLu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2Ubfc2s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5F21F4D9;
	Thu,  7 Nov 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006589; cv=fail; b=Psfac6ZbxP26XP3W+fHI32GHLrFLRfppFh8kH7F2R2PrKsTGs13wcxSmQtLNb0gQH76na2ou9nkTib15uP0PSOcG/jh1610UxVGZzwyz3TrUVkTYNTiSaQUxphJel/9HYx+gkYsNU0lwp/Wk1v6A+ggWwIWD80YaiNpuvzPFWrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006589; c=relaxed/simple;
	bh=MY1WUyiG3MlGsF9zGtV+TOUyfeJkWNCFZTQDiZEjs58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGP73ZEbG+hjCBw9GcBA1o9HdRNLB7oJU6kjzPgSsXP1RrxcWB3Pm1mn3edxc2nYp8mcUunxFQFgAL73RBJ0MWMNrmbp7Vb6/34kDBXj7Gy/4aySPiCvFLgds6px22aYLrhp/OS2MBwSWpRrdNgV2C7noUxUSvGSMDYVjcEojhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ak8pQiLu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2Ubfc2s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBZ9u024688;
	Thu, 7 Nov 2024 19:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KCpMsJmZCRizv1HK7VHHQLxW3ArzQmimptLDQTbndr0=; b=
	ak8pQiLuJbvexQ7OGSN7ay//bTPfi+pOQAPjXleZkndcESYLSFc6+nMyoGdZu+Tz
	Bq34nl46WySsQYd352MqYukJ0Mw3UFmZVVL6xIyBpfB4WW+SAvTfzFUWrTIWUGl3
	wrhTO4VOA1d5AMgtX31EpWOPPkthP8TgwoDMd9brjuBT05Bz+4QowHHRFg5zsWB0
	EeOKalGchOpdstxWTgzoORQ+8aK0mPGLcfsdDVfN8HDRnxSS5G76aM5Uwc8wk8T8
	zvQaJp9STz+Sne3VJ9iLsEcxHnZtCQiUx2ayLzEaW3KnXiBW6ExaJVb4/7vXnzQQ
	bpric7OnZT+VQMD2OKeozQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcbc1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7I2sU6008426;
	Thu, 7 Nov 2024 19:09:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaercn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9rrfYFLjxt50I6Lmac5FiP8uUFY4kHBI4saKamlSIvPa4OyNkVedw7EbzGZE7SuuK8GOEd60B2jX6viduVKFKAbJxmoBPeVXppMf84UpM4FucbxmXniQ8vEUA4Xvc1VfDZvzwJXClxSSc25rdyRMoDUgyF9N8BfGwGDtyYr/fhcHcdiMtgOQNI3oPzlxAAmfRQ/aT7wSUfQ0MxQC6Rw1CuYPMMy1Q+DT1XIdKBPIBb1CQW+zAnmGimuVU50wCgAA+ur0RkCX0810BRQzQkU7xVyHuxh6WL3O9ncqZ2x7B7byDgwSCiH0LYvt/Ipa+FSRlMvOro5UkyszsCyJ6Mh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCpMsJmZCRizv1HK7VHHQLxW3ArzQmimptLDQTbndr0=;
 b=hxI2a9pG9ieIjQvo84I51gv71esLa9MIzTts5dG17lQxYzrFOx8m9gPpMoi1irgjkIu/fdjbHnjqI/NaqN4yQpJ/n+xx2h/qzXOVJ1YD1erp8xpXlSyxllzhOVgu3wVatXFgR+6s5rKpizNdNLvGF+446mbFvNfqEvehreddUbxHQwhHkomM/tkNCjgrprl08mUBCKQaXO02wsdzhMB8n6GBiuhk4IufET6acQQDec0Wr7z6tM2ko8V4J4WmLGB6J6ARCGsXUyV22jCuD0ggR1GzlIckZnL6vny9Hvuydlo0WwsLX3jWOf+JUXe0hBNEeDCM/A3DXj+5jyHD2U5/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCpMsJmZCRizv1HK7VHHQLxW3ArzQmimptLDQTbndr0=;
 b=u2Ubfc2s1wjtYcJ5MeuuDHFR31s4X925cKVvHpI4MB7xOwMuViYmCEvRos8nJ9cP3J9HTWhO+AVrm1b5Pcd9Hu4noseFP8wk5/sOHLlQ3cNb0Iei5b17B/AJi43TuNegy8D5eoHMKBl1CgzTpn7IBNTYnv2DFi7QJlqOe4Tx2tA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 19:09:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:09:04 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RFC PATCH v9 15/15] arm64: support WFET in smp_cond_relaxed_timeout()
Date: Thu,  7 Nov 2024 11:08:18 -0800
Message-Id: <20241107190818.522639-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5438fedb-214c-43a5-5b82-08dcff5fa5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYAWn1pUScq8HbbTR9vmDOBVkI96IXbZtC821AOvfX3hk52tctCxEcUrHKbb?=
 =?us-ascii?Q?J+mky8fqdA/Mx2/o64BW47TTtzd/C9OYxQUzeUJX9Dl3q1ybNUN0ZvqVFtzp?=
 =?us-ascii?Q?GPBHlv/YV+zwpzUAJJoJ4s2GxxIZ+83BCMl+lqZs0O1UbZUoBnnsyck7Et5X?=
 =?us-ascii?Q?o7I7Vm5/8QK+ImI2nAMUKYJngNXrRKGvLLZVXDhDy06IWWlJ9Vn0RNnRm783?=
 =?us-ascii?Q?zuEI1GHVZwdSc3TiqJaaKN5JhjPPexo4VVFYOIpVJQ/CCj5MRPOFMCa38oLw?=
 =?us-ascii?Q?GMW1tTczIjzsoM8ivdc0aMnpmR6I8FR67qbmiXZtLnsj/fEkcDWerh3VlZGG?=
 =?us-ascii?Q?qrwe1AULySHpy6VAvOWnt5rvcACEJBlkeaYvBZipioRMnFYX+hp4m2I7R8if?=
 =?us-ascii?Q?RUOhhZBMRyAc6XrpPpPzZdkH/5hdh5mYw0R5XjjU/Th6Jnb+HN7mN3maHNWG?=
 =?us-ascii?Q?3QYoo1knjcdX8Yk2gwRs0B3RiVMNXAeAkzsbKUg/ZXlQErl0+7Z1HujA7Ckz?=
 =?us-ascii?Q?5k/UM1rGwoLsB60NQVqO1lG9dFAi6MUGtzjlvkIJNtG97s+LhZ7Go/z+O/Rg?=
 =?us-ascii?Q?AmlqEkfcxS69o78bAAJHFraq9meSPuDgQkyOdTWKzMrmlovRVW9CrvH8lRSG?=
 =?us-ascii?Q?A8WWIjii7N0K5bIAG6rgI/6Bo0Kfc5WasYtqBAB2pOqhDxLflb7IPmruuvJ+?=
 =?us-ascii?Q?wsAzA/fMh3ihm6orvHyraYmqJFq6OF1g5bf7TkpCDok+QDf8eF4G4Uf0zMv8?=
 =?us-ascii?Q?wMxjiGC2JGdTo+K3EN7bZDaGQmciabDgNuW9Hia4XUQEsmuF6EF1lISsR3Bq?=
 =?us-ascii?Q?JV4h2yiN8Mo+ceKvqFflbXInuo/dWCeTh4Jvo9dFhrnWd3J0vbAhDU4sNqsC?=
 =?us-ascii?Q?EwDWfILdMsN463JFRahfmPLEWj/bBkweud6Wezn33k0EABvWkyb8IIZlYcEe?=
 =?us-ascii?Q?8ri6GpBJ45T20XAnkGuJdMBR8xjduEgCMxpzcx1seouWnIBpkmC+MHvigsLW?=
 =?us-ascii?Q?+XDc17fsjKTorLZg6h0WpjWOV2QUyN1VJM+6aXNPlyetmT8Emu/OMYDhCJSh?=
 =?us-ascii?Q?pG6Gc9H5L0B3LxELQ6pNGW+rTW8zG8bxHZv28Dz8E2aVaGpMFnsxa8pWdpgP?=
 =?us-ascii?Q?ZcUNOz+kaROqvKh8tiGi8bUNPY2qBUomZbIsegga/a9bo9TtVmJK4F+84qyA?=
 =?us-ascii?Q?QMQC3ipwmY8xRHSHPDAuJJPRinnbrrTI+4aHyj/fvn3Ju9CDTp5UJy9320rv?=
 =?us-ascii?Q?9S75HiNuRCABQoqoNibjWk3eyR+yIR25/kLPdfi+KDRo7HcwEC++yHLzwfRq?=
 =?us-ascii?Q?IEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?boZVpkwl2LPYemiwlo6Un7QLeWzOxOOZzhp+CE/8SGEN9gGVXMBO8Fl5tQFt?=
 =?us-ascii?Q?Xc8NoQ64ywzmA3TVrGzUPcSSN7fQv1vBjcA3Br4Ms7m4KlCqlOOa8uPAw7pT?=
 =?us-ascii?Q?WeUqcSjLnWJ5blx6bDhbFOhVlsJUWHg0aayYxEhKyG488ZiFWieDz1nxi3Oy?=
 =?us-ascii?Q?lsedSjkvrikVCm0FdfkXxYnxRTLpNjwoOECt92gaxSkor/4YdIq9oDNDTR1L?=
 =?us-ascii?Q?iNtL+dh33NwUROK4Pw4rlf9fvFdXZYfVaqgBQrH2tH3DC5Ghcbf843I3T6Or?=
 =?us-ascii?Q?4/kA2DbzQBjYUQMHNAz5Yh++ugpPtYPYs1Ak83YMmsgRIJccWGx/aj7k6PPJ?=
 =?us-ascii?Q?5uVQdJXaspTryyBO10JI81DtaoRzSOklp1YCx92WNRLdltC9CsPzyGzDqG9c?=
 =?us-ascii?Q?2OfNgU2yAgSp5gtOyGBTPMXm4XUY7kT+UqcaOjQUFQjWSP7m6jNGDdKFmSa4?=
 =?us-ascii?Q?2AFdzGuu3xDPE0z2tRoMqOTkHzXBNJO77yAviMvdoDbwa/15oWg7mC3BdPeQ?=
 =?us-ascii?Q?wkhaqzQ12zZPhzAC/Zn1QbRo4bKt8a/FnWKRRyf/Vtek42YMlWnrrM18bcQ9?=
 =?us-ascii?Q?rYPh8Tj/kdLIptjxvWlbTdaLe6piMjxTd3+6eH7T2b2yGEKPQZZO/Ga5bmHI?=
 =?us-ascii?Q?6/1nIcPBmNJbclRJTLVYz9BrqI8H4GnM9e0yiFI9J6e2tptEH4sv/jOXIezz?=
 =?us-ascii?Q?bvrNsKlhetvKHp1ogkw6y9GNSF5wClUXSfirlQ8mylrfhWEzW2mKx1Ghi9Es?=
 =?us-ascii?Q?ZhI/mZzQ5kxQ+Dd/dkhWR3oF805h/Pjn4Ho0lnyXvTL4UdIHgPbXs3s5oCrx?=
 =?us-ascii?Q?a88PPalgmST0OGftieQZ57FA1UEjMzC5HalBNHJemzxLxv82xOrXCpNGRq57?=
 =?us-ascii?Q?ktbEi4XP4IkocnP8KnL8/7kscrqBIzqkIlAfuIxLZpfMtWHIL0s4Mh2V5q9t?=
 =?us-ascii?Q?BvdMg59or+NMbvKuGQcUqP+PJl3r/X4i0bcHXmLS3GUEWyndHrBYVt6vm9Eq?=
 =?us-ascii?Q?7auVFfrXaU+mrKiF+ij2Ly0zUtY6/zTwDnVsHASffHRHuDu19HKRFVdnA2au?=
 =?us-ascii?Q?rhs8nQcM/O6TP2Ppv4TUvdsLXYhK9eK8uj/43P4xSWW5i1FmYET7IFiSk75V?=
 =?us-ascii?Q?l70K1Yxi5hXKi6UYXoS7dneuIfDdl3cnDoJm981le8Aad9eyBJpJ5NA5SBwH?=
 =?us-ascii?Q?FYxYcWj0176AnL7zFdcm74atvIHsrO6I1H/Na2n6exzBD6igZAw4H+7peSZp?=
 =?us-ascii?Q?C6tR95eYI3jCqcF7ZMtLUrqqFf96Q1/SgwyKNFjzbv4C4SNglllaO+xoz1Qw?=
 =?us-ascii?Q?Vz3JsRWVKckz6ZHes6d6n4Lhm3+ZU/tzyDflJusA65gKBr4Dk1gyIS5dqNJ5?=
 =?us-ascii?Q?UXGOcTDoCtKJRQJdFcgPLRxxTPveDIJrZFwhsTN0RqoYTig02wkGGnIFYM2S?=
 =?us-ascii?Q?jiXaxbeACcrfAy4rwKow6lftpmPwafrZm6MZhtj/BOYLVOV9LwWZrwFINNQW?=
 =?us-ascii?Q?tySsU/VUZv+U/jnk7klqjAMmYdNvyjPGqETdnpzJnY2CKLtAws3JafYgWp+L?=
 =?us-ascii?Q?4QY12HzDr8XyOJbr1ml29H+NpTXAPUC9HeLPf4AXNf5+BZNuRaUH7Xvjvkce?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QqHW91sCpLQub1GK4qI1X9y586EIPiou+54IfagUSB5C6WJ1wPWeUFVTHnXPPn1OCZeoLH3kOqg3eXfYgU6VZa4GI9mOLGQUQ/Fk2+HMnHorC2t+FN2U+Thvl/KX0570rNQuQZjDrCHyi5VgJ3RyrOll/0W162L4H/4PK9j5MEqWanpWQuo6FRAKlOQlAstIc8wtWDNEsuBF0xyuTUOBMFsw+hPnnlut9FULweuNWxAVQw29SZ2BbtGktmRUzPR1lztsCySxJTTmzRdJQuvVDbaA/oNr1LcAaMe/Ohp1o+aMysLLgcagHzd/hEfBi5DY8lFh0b/HXDbAYDU0VABUovprpqEThVNsO3bMLTY6kD0RYyh0s4+Ho84qoEqrnkTQ08aL8U2jG/VzfWT6xBfMP27DQH4iTsqsScLmAtN6tJL2SnF48MRTdcgH8prdjd9C80tX0fUXZ+0Gx+ro2etiijbcavX0RecPprDVIE4HhArKsCg4MDJrrP16FGC3COyb6fM/0JF3wLcsySsTK9mncWbZHISoBgxqOE0jNox2HbA8/hHNy1ZKLL+0aPrK/EuUKst7QwWkvwL6MWMcj7HOlPriEqG5WUv/DquhNP67osk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5438fedb-214c-43a5-5b82-08dcff5fa5b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:09:04.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbwoBMTYz20pQQaaVXIOp7NSO3VmLObnk9tiltkb7ZtHh78R2Bm6fn1exkzKAaaO/wNaSjspjB58afVmMqR3LxmaikouolYCuNR9BC5Aig0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: iWoBOumy3YHu1D3dDDRF7lMFulrb7bHm
X-Proofpoint-GUID: iWoBOumy3YHu1D3dDDRF7lMFulrb7bHm

Support a WFET based implementation of the waited variant of
smp_cond_load_relaxed_timeout().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 12 ++++++++----
 arch/arm64/include/asm/cmpxchg.h | 26 +++++++++++++++++---------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index ab2515ecd6ca..6fcec5c12c4d 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/delay-const.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -198,7 +199,7 @@ do {									\
 		VAL = READ_ONCE(*__PTR);				\
 		if (cond_expr)						\
 			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
+		__cmpwait_relaxed(__PTR, VAL, ~0UL);			\
 	}								\
 	(typeof(*ptr))VAL;						\
 })
@@ -211,7 +212,7 @@ do {									\
 		VAL = smp_load_acquire(__PTR);				\
 		if (cond_expr)						\
 			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
+		__cmpwait_relaxed(__PTR, VAL, ~0UL);			\
 	}								\
 	(typeof(*ptr))VAL;						\
 })
@@ -241,11 +242,13 @@ do {									\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
 	__unqual_scalar_typeof(*ptr) VAL;				\
+	const unsigned long __time_limit_cycles =			\
+					NSECS_TO_CYCLES(time_limit_ns);	\
 	for (;;) {							\
 		VAL = READ_ONCE(*__PTR);				\
 		if (cond_expr)						\
 			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
+		__cmpwait_relaxed(__PTR, VAL, __time_limit_cycles);	\
 		if ((time_expr_ns) >= time_limit_ns)			\
 			break;						\
 	}								\
@@ -257,7 +260,8 @@ do {									\
 ({									\
 	__unqual_scalar_typeof(*ptr) _val;				\
 									\
-	int __wfe = arch_timer_evtstrm_available();			\
+	int __wfe = arch_timer_evtstrm_available() ||			\
+	           alternative_has_cap_unlikely(ARM64_HAS_WFXT);	\
 	if (likely(__wfe))						\
 		_val = __smp_cond_load_timeout_wait(ptr, cond_expr,	\
 						   time_expr_ns,	\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d7a540736741..bb842dab5d0e 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -210,7 +210,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       unsigned long time_limit_cycles)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -220,10 +221,12 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,		\
 	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
 	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
 	"	cbnz	%" #w "[tmp], 1f\n"				\
-	"	wfe\n"							\
+	ALTERNATIVE("wfe\n",						\
+		    "msr s0_3_c1_c0_0, %[time_limit_cycles]\n",		\
+		    ARM64_HAS_WFXT)					\
 	"1:"								\
 	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
-	: [val] "r" (val));						\
+	: [val] "r" (val), [time_limit_cycles] "r" (time_limit_cycles));\
 }
 
 __CMPWAIT_CASE(w, b, 8);
@@ -236,17 +239,22 @@ __CMPWAIT_CASE( ,  , 64);
 #define __CMPWAIT_GEN(sfx)						\
 static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 				  unsigned long val,			\
+				  unsigned long time_limit_cycles,	\
 				  int size)				\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##sfx##_8(ptr, (u8)val,		\
+					       time_limit_cycles);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##sfx##_16(ptr, (u16)val,		\
+						time_limit_cycles);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##sfx##_32(ptr, val,		\
+						time_limit_cycles);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##sfx##_64(ptr, val,		\
+						time_limit_cycles);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -258,7 +266,7 @@ __CMPWAIT_GEN()
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed(ptr, val, time_limit_cycles) \
+	__cmpwait((ptr), (unsigned long)(val), time_limit_cycles, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.43.5


