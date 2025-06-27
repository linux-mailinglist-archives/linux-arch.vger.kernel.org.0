Return-Path: <linux-arch+bounces-12476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08955AEAE14
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F224A6A56
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191D1D5CF2;
	Fri, 27 Jun 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4SKCba2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPUafBNn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FA2AF1D;
	Fri, 27 Jun 2025 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999741; cv=fail; b=LhLSBAKA5UA6nGBJ4ayAIegESGYT2Ve6vq32BGrxv9UWJg7z9u15x7mS8WJmb0fcAeWlZwrZc2tGb58SC6Nyvg2KSrH89VfnIX7ServzDe5yFwLDmmV+kmAw+fybDKvwKJDxCF11CIGziAjpYaCIs2ACP1C6ZnoC8MAyq22WmLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999741; c=relaxed/simple;
	bh=T7YbnSeuku5cRnWVQxDwoerdOm1ggLpXDKPvDvTxAm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMJ1dvjH5PLyI9QuLN1wZCZPt6MZADOyTN5SHjIzhZhKrO4C3rdLJdOkBkKvULcbZu9CUXZwpA++tAdPQ0eFpT0jbpNT3iKxf98bOQZ6mkdQw+718GCK6RZYO4pQNEXP3nesS/YYGLiES/ZU+PDF/eI8YVlhTvSq1Z+cQ47haQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4SKCba2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPUafBNn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFtlRk008344;
	Fri, 27 Jun 2025 04:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4DGaY6BqZWj+zyTfk/h5ijvK4OC8kjnSLoGT/+hEOPU=; b=
	h4SKCba2ECiaf/PV9Caax9yqaU84h+vqLuhbJNn7CMcnA2I9vz+20JM/VqxKZo7p
	5rXC5m+bc4Unlj7YwaIIipnODIFvX0WJyTgIUay+5k+l7iBwmOOLdRYzF3j/8872
	i7oyHT8vUVUcSJf6upw8LwU1nTvk8axHwqUI4fXi9l/6GFzbnOPohc0L4PzGSMSz
	kX6mgfEnLxXDBP253z5Fz6VdC7v+ouj9ULcGCIZQoiUaFZceYyDKK0pBQkbwxdxc
	uoBoB9eMlW3yhSy0WIymfoeJwWm/pcW34D8jVd6UV23y6WG5DWuwFII0Q5GylYmy
	QD24S6U8aFgWQ9wYilWjhw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8yb6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3tESf002527;
	Fri, 27 Jun 2025 04:48:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt5dm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Flu4Zv+JL5z4kjXC7pnbSp4yHXhHYZ2grTlFur1BfEIyLy70CChX6/opKOVbgOGJ9Wkf/rZyrMM5u4EwCFVhXahM/0Q6t18z1LbMWmgIdXbC4cfPaM9UE/8MsS4mjjBZtdVzIlqcGTlBJ4374lW0sm3SQbC1lf8XmK9PH4Jtpo95jBbZYqVtdHHRpW6LnIgDhityXEW6T4ydVffD2DAvNSMSvscCAc8nduyKGtno7OvDmqnUoxf0nj7NVZ65nXq+IEduRnfsnv8u1HqcSEnkPEKJapkIJBTy3tEUDs6/Fnisv0ojuTgGoYXsBH18SrqPB5fL68+HAjrfjB1Tfq6WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DGaY6BqZWj+zyTfk/h5ijvK4OC8kjnSLoGT/+hEOPU=;
 b=qeHiMIriEfA8R0DbiHdSFcmzYYF4cxOvsRQ6qHF1tknx0McYes8gPIBOYKVdXsRqq1n4tNij9atIYTtVo1KzR9jdpoqdvJJz/72Y5Rgi/ygQBQMbZ47wQddlcflQWPyG5heOdZCkJKCvKJnKE62+1gdulJXorCn/H4+4VGc4jM6ibSqgQ9qBD9RVRR3bWZ8yCYlXQjPVx4h238uU7TlkC1p+HYM0sV0Vzf82/DKLkNAHkCL3cZ8Tfd32vylzd3duVIjRkUPPJistsY6s/Z6N22BQTRebGQaYwKa5t+KBhSXQLTSF+E3s7fqltDZdzZSwhaQrZT5AnbEzb8iwC77eNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DGaY6BqZWj+zyTfk/h5ijvK4OC8kjnSLoGT/+hEOPU=;
 b=NPUafBNn4XDRY6Yu9QTUlWmUT5aYeBKAFyZNWSCy7g/ijZVLGnsaSwh1PsvTSx3RWEmUAqRnMsii9qgkk3FEtnU6X/RoLCowiP310EGRI+G+58mqGX0S7B8kMAyMObV9Ed4c0iBeaODHKgtTZjoSRke1Z9bCmM1seILOBPGOCeU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:09 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 2/5] asm-generic: barrier: Handle spin-wait in smp_cond_load_relaxed_timewait()
Date: Thu, 26 Jun 2025 21:48:02 -0700
Message-Id: <20250627044805.945491-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627044805.945491-1-ankur.a.arora@oracle.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 870b3ce3-8fa5-49ea-fbc1-08ddb535d0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ncACqmcFgqUtvlFl3icKCBzpOCL4dZRD4R4FaNjKMCdt3DzInXl1gGQfXNH?=
 =?us-ascii?Q?TWw7L8vS9FjAhkY1yxgSnch9F4mLhEiZjH2dbB4ZiOH2wAUPl4hXtJJTRyoi?=
 =?us-ascii?Q?TuKLvGCiprEoxh5vIEgHcOVRNktdPLzuNlQ/w/GudYVjFRAu51z6QChxWpPg?=
 =?us-ascii?Q?dWUIF1EQOFt9WWoNbn/HyWwmdOHsqHkzwAhKO4HDoHUyX3B+Bp7O9QguaKzL?=
 =?us-ascii?Q?xaIoCILGjagRemNO5rGDJLnegwa4ur+Q8AE3ZmFJG/G1WtQ71X//903kmoi/?=
 =?us-ascii?Q?f1Rdu+k58Li4l+a6ewHVttlFHYB+omNJbmwzi88zFDVQf4V79J3LpEzwvsiU?=
 =?us-ascii?Q?3zozRfNG7XQ/c44s6EP2tPrt99PH78OWAstVBt+wRwvmqM53Z0mk7QoHaDv3?=
 =?us-ascii?Q?Ev9F2eUOYRuJnpS2FDutPr/JiFpkWuFJ7/qyj2Wye+1iTkez3YNFqxvp3Boa?=
 =?us-ascii?Q?Ljhct/cxTFfnHmAp+mFQVwI/2Ye22BSk5kuvbF0ZNSAOVyNN6AdWBLtTUPLd?=
 =?us-ascii?Q?eDn7bgmnBXqKiypPmBB7hfxozGER68OB5As//9vJDVOTfGwe4PjCPJ8NP2eh?=
 =?us-ascii?Q?Cx5vOM0LeiECSiL/wVScliJWe16WHtK4FqNFONmVu1xtUxytSqSXOpea36dr?=
 =?us-ascii?Q?yRrOAUZ8Y2xWUjnNsudwAbWmYKsrBZCpDAq44aHwW0vJoMaK/I8JoeCEOARD?=
 =?us-ascii?Q?fgJFDAjEavFLMDwXxOslFAvyft2uxCCliMZMklM3HwJYj/xvo9iYAOHQb29n?=
 =?us-ascii?Q?KSAQt6uO1zP1f+aYCoxdRkiSOwo2BZ0CGe90tEs7LUMX0bHjbxJtLNpX5Jhh?=
 =?us-ascii?Q?+HMwkDMmrLTtv51tl+wqynL1ZwCRdrCNAQxbFmtuUTpgbsLEpM99+fvK8ojs?=
 =?us-ascii?Q?PV8sAcZxHhSzE/RJ4ePjU3YPX5QL9Rajr0JZzGRxCQNP70FV42wkNsEFvqG/?=
 =?us-ascii?Q?WwpBwLaRq3kZfl9iFKpFxttijTEjh1lTnWtxfs9Rez4XdQDc1axbzNc58iCA?=
 =?us-ascii?Q?5UaOEBz/rQFhbUj6q7VrubjCTRAGjw8psNh0Wyt+IuCDWuat4Adah2k3tuPY?=
 =?us-ascii?Q?xVg7QFoTa287djOb5GOOuHYQlQZCmyCjWi4+F78Op6xndsW/ED+VWxMGk7CJ?=
 =?us-ascii?Q?xwQC0sv5kE6A8AXIadX8vcsa/SvdfoepcE2plJlFMpNBVJn4Cjv2k6dJej6M?=
 =?us-ascii?Q?jUSIocica9ZC2Vf+2g73XYaLuC6LkY6uOYjgNWQHTIPIqi3a4ShF52iJ1NZx?=
 =?us-ascii?Q?YXz173+Pi+3gm4gE4qOiTYMj0TCwY5kK7exwSDq+E19MMl4nNOowXcTC8l5x?=
 =?us-ascii?Q?hJJjOkLYo7jtiNnVpVRV80S3YBiFKDwbaIwtmibYWF4XMUKdMxYGIlBdVk4m?=
 =?us-ascii?Q?ddFhWFoNpyu/DLXEBpPINp1fP03tcTBHSOoo266UHPP/G+BEvkm4vuJWXsjL?=
 =?us-ascii?Q?xxMoBKdkWdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xCvstoIH18huL+cKqjFdWFVZBxKzEuE5wXrvTmaa910z6DQvylG9pRrW2W6?=
 =?us-ascii?Q?qhGt2bDX9/Hg8U7zIQjXjF7Q4yZHEIc+SgCiLLthOQw5dBcJY04qVtY1Dwoj?=
 =?us-ascii?Q?IvCxouXxuNWfumPHpL+tdlscCHaif+pXLUKpJ5R4n7lwMnS6nFFJmQOcDESA?=
 =?us-ascii?Q?0GXz6ORK7hobqd3RlaoXG5qRo/UouX+uIz82uMj3krQ3v2IlxIsHCot4/5Gi?=
 =?us-ascii?Q?QKLKopdUaUzjPigMdeEUruqJ41vnXQQGyJeXUuWDMki2/O4TRsrZU7Cw0FSR?=
 =?us-ascii?Q?J9vsCA7u8xoM2UX9RTmX4xKRPC84Rf0TvOAGfUHlzbQWGBKWunvwl6m9y+wh?=
 =?us-ascii?Q?lfphmxnXMGC8C3xMf0Go/H7HDn/50ewa4mSATXwZppcIo/wc8z7t5UI821qT?=
 =?us-ascii?Q?NTgJPPDLIFoAn63NWw9yBvqgY87XCcj5dpj3g5L93dTmiu4eJx+bCpOgl/a0?=
 =?us-ascii?Q?ZO3tAFnVvYZXjj9pduOowP9ip/9x4o4UkvGXfpbmSzw7YJyElaN1DF7cmZNQ?=
 =?us-ascii?Q?mym6LeNRhkn6iJMEQyE8xcRoMdwwo3e/Ty9YvtiUrhqFW+UH4aAABfw0AQDP?=
 =?us-ascii?Q?AmYYRJIsQ2IHSjkLQi8TzDKoBbKZUF8KEuUmhRvN0nMaOb3YuosrAnpzRkNX?=
 =?us-ascii?Q?4+d6LZaV50nwPFcqGFJJBI6p3GeI8jXda9NHZv56gRd9oGnCbinRexe1ogKn?=
 =?us-ascii?Q?Fd5PHe20Lekk6NvuZ3V/b1CWUorj6787FZRz6LNOK1oswkGo5Lrn3t5+ATmw?=
 =?us-ascii?Q?hJt7eKr8Dlb+/14jE0yzue4jOMFfsaT7l7CRQ2Z1T9DuzcfWubpEDG6RI5lx?=
 =?us-ascii?Q?mALlQ6Pl83UimiEy4gF4jCJo+GWLieCs4i05i8l2JN/hSHvN8RZS/nx7x9qF?=
 =?us-ascii?Q?1AdElZLnypeFfxmRpRXvP0afKt5nFjD9/vzPDlKlRMtIlAU9XPIneBB6kSWZ?=
 =?us-ascii?Q?GeW0qmLB/dfnLAKghpdwXBhDzSk75qvdq2jNKMAeWjTyZ+Xc4xKa2qXwkh/7?=
 =?us-ascii?Q?/E5SzKc4TZ/ga7aozbthYaVWGHaaCda1s+Rnu1n9dXIFKUPzylroYSW/0KHl?=
 =?us-ascii?Q?aPPeZUG/fqGwPU16BtufB8ILbSEKLF2KJYwO8a/bj3QMWlEfPZbPagMh0zfS?=
 =?us-ascii?Q?JIirz0Esi1skFgUrVcmEIGQ3lLYNFvvWJ2C6h/ksDJfRUOD5cBW4kuo3Hh/O?=
 =?us-ascii?Q?B+2vSXSXQwzJF7d8yuw01EWt9ArFVcGPjOh5EqFYnkQb75kPt/4nQTJARJ1s?=
 =?us-ascii?Q?LXmo+NXJmMPYa6LwLaxSEOKXfCWCxZ7T4HBLPLNAMiSjW1DYUa4aTZFloWoK?=
 =?us-ascii?Q?KJOahxh0RiJghp+2xjSH2RukAWqXTgbzXODFXhtR9rIYnIi4tT/ATlYjNadP?=
 =?us-ascii?Q?F43mMRP0M9fiLTSYxoXDEwP9esT806DeyDE7iyc3nfODBmGuoUXxObfJeF65?=
 =?us-ascii?Q?dTtJLNOFWoU/vzvKz1v4+GIK2PfT/1QNvWM8rTwfwMTtDTOldC00y5Wlia9G?=
 =?us-ascii?Q?V8TH6RqH9K8NePuzerpkfp/2bAhvSpSYCdCllsLrQSNxjGg4+cbOdH8T9/6Z?=
 =?us-ascii?Q?il5QchxvUyrF04oZb3ffWSnlkrdcotFe4JT+7lMdMRmvgRvL3o9oC6CbHhFw?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9g2g3d26pFJ5noBwedwmoOhPNgT0mO6Tg6Y+xtHfmE+5d4arYXvkKQKQkXV4u1YRUoSFUTQ0WPCyHTc3ioweTdWcC11+Tv5gEzIGdzfseSU+A8265m8TORXEzjH6gLmbiT3AjUnBq9qu/djGGk0hTEKAUr4Q0qx/Fzb9iFYMH6lfBODSFUEvJLXNA+NzZa2pLLkuNaBxu4OBygCElyoKjuCC5G9tuhbWEzkrwUKZZCm10AeknWbfuZn+PwWcvLfYQzlH2mwocOBINZL0ICrd5JqPVfCug7l9DKQWoKS0mk8ZYc4LH+i18JcXUBwjUQNFsnqkumr87AxOtucfWUIkgxLMQeOmTqzJNAclpotX1ok4X+ncaeJayEYtc7sLypbu/VnbNJRIJi0dh/fiL8+/MHy4ndOUZWr66nGq4liMPkjIu+Om57ZT53xfVsNWQdoY1yuKLJMsArndg2pesmVgZTqV1Z7UgnivL+ro4SgxcBoHEas8+vZl8eRfoynOcxiJJIKAfNCcNhd0YneEEjGlFQHHIKc2U2iev00q6k839yILRburHVg+cXFuVVI9turNgZz+7NnMXt0oeHqGT2BJ4WYyUB+Q8pgmawtBsdzceAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b3ce3-8fa5-49ea-fbc1-08ddb535d0cf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:09.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueJpcMJ4sd3g4bhVwnoLilAnkSpDtlctnk3nMKcaEncziyzNBG3Dth3bq/llOiljRB/gdcfyvw/Dq/CSCgOXCsaXAY91ia4FmOj7E1uOdK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Proofpoint-ORIG-GUID: 0IirCiD357wiYJ-tn8jv7cVSDllYm49v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfX1feogJmyjs/d BU9RJ108NcjPPsrAgPcNc3RUdRSLSvON0c0jwmldcnD0SrhwbADRWThc27e/odpX6yixAVSdeWz PL0u4d/DlMpuMz5459aK2HB+/xU8p5oLnqD2CFdEKB69yuuqJhd/XETxLatzr8Wxn6jjcvM+Q9o
 TZbfs8w1Bn34mvsvl8E7U7MXR2Pgs4uAby6VlnMBcNUOwHrOnnYj+/TncCCZfStcX+ne7Usi7A+ acWrd3nZmgYcldkksTJHWa8gE8Q4WAHLZAYNhjvZstunu9cGqPIJ5OZ2QWglK8lYis725EWtkUY RVS67EzLfzDqMH1gZ+GCKTDyHX70pSC6H4ZNYKfRE47G/uk+B7usVuooroYBSUAoM4WdSHIHtBy
 9+Ru7PgCU/JcZjLhkBMIr8OvzCHPh5HYhoJjQwRP9aNDogExBNZ3DSOqtRpmDKcbTj6jAbmR
X-Proofpoint-GUID: 0IirCiD357wiYJ-tn8jv7cVSDllYm49v
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=685e2297 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=luRVYIaq7LDw4LXNCHgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22

smp_cond_load_relaxed_timewait() waits on a conditional variable,
while watching the clock.

The generic code presents the simple case where the waiting is done
via a cpu_relax() spin-wait loop. To keep the pipeline as idle as
possible, we want to do the relatively expensive time check only
intermittently.

Add ___smp_cond_spinwait() which handles adjustments to the spin-count
based on the deadline.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d33c2701c9ee..8299c57d1110 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -15,6 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
+#include <linux/minmax.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
@@ -286,11 +287,30 @@ do {									\
 static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
 				       u32 *spin, bool *wait, u64 slack)
 {
+	u64 time_check;
+	u64 remaining = end - now;
+
 	if (now >= end)
 		return 0;
-
-	*spin = SMP_TIMEWAIT_SPIN_BASE;
+	/*
+	 * Use a floor spin-count as it might be artificially low if we are
+	 * transitioning from wait to spin, or because we got interrupted.
+	 */
+	*spin = min(*spin, SMP_TIMEWAIT_SPIN_BASE);
 	*wait = false;
+
+	/*
+	 * We will map the time_check interval to the spin-count by scaling
+	 * based on the previous time-check interval. This is imprecise, so
+	 * use a safety margin.
+	 */
+	time_check = min(remaining/4, 1UL);
+
+	if ((now - prev) < time_check)
+		*spin <<= 1;
+	else
+		*spin = ((*spin >> 1) + (*spin >> 2));
+
 	return now;
 }
 
-- 
2.43.5


