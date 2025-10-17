Return-Path: <linux-arch+bounces-14184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BFBE69FB
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB34FCFFF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE9314A74;
	Fri, 17 Oct 2025 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O2vjuTbU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="afxdgCO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A0313546;
	Fri, 17 Oct 2025 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681811; cv=fail; b=u6aOEbiiSWK6Fgt8a5VE6/N4Rdbq4J0oI/gKQvcVHI44j0sVdZyKRMAstsrpSkUnQlonKwZLNAkWbp9QWOoMH6++kVDN4OT845IZa6/cuwE9+ZQASQHhXK5Z+rQ4i0e2EeicGrHjxcSZuw4x/z9NJPE01DMSeB9mZPs+LsR4mQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681811; c=relaxed/simple;
	bh=pnT2b4FL8OiWvv+d8uW4SDFvsytiussyvW8sZfnt2t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHVNVKdIKhEHYEdMly6L6gAoE3pz8iPH9ItSQtjxi/xtrWmqekOnaIdWvj0k8FZJFecu3T4TtAaOldsKKArSNP8w9R8EfuSOIv86LGIuP4L/aVaoY+4PWMlbcPzDW5gN6Bxmvysc4nftAcgc8Z3bNsC7gDbRkhzW5Ls4Cyzea1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O2vjuTbU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=afxdgCO8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLuAjU032270;
	Fri, 17 Oct 2025 06:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=; b=
	O2vjuTbUqLQoW2q1BjhoJL/ekeazCzZJMmRi0XkFklzMPKsDMgk3MaNWiZr1OzR1
	aqQFZc287gtZ0yAJ3qFJgeSosTlzb9pgKvloAC1LYIDgG8xdY6S3/rcQ0+vWdS4x
	xXLdl+5FUSJZT4p7UwqUmf3XNkqq039rLGq+Onz7u52sLSd0TcK9jX5C0sqT06ND
	L9i4Ub37odiOTY/e5m/lksv0j76rI4wPsGqitITz+SLDZ0+V6cJOvXnFrfz8hCgu
	DDm7t2Q3bi4qX+3J7fzfWao1VCCg2TkXwbkpfhaKQhAz6pXatglw6c5iVFk0jaH6
	SYjJHvS8PHPujLecpZ3m8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qhdd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H3VDHL002266;
	Fri, 17 Oct 2025 06:16:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpjnaup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwzItstqorSdDOFB/8Ir/qJp7v7W1g8bHlKowTkLsFYkAxbJIc/irM0e+X4dTq1TQAwp5+QHWpgpP1Fw32GIRitf3iVMCC96Z7Lkk5+rsrfvUzHsejqngqAWZDVd1uWWnh/Pe0lD/FbxipzOzRnG+tl33ml2YPAOFVWSCbLS84lOYCuTFdaTdRn8F2kczVmlOALTgHxRQA/ROvZEHq4MVOn2/fN4BHAGejdgwUprRcoO7OO76s+ohoGcPaYk58Se2GM4pH7DutQosbpgWwhv67YLvKbeyP4fAFmFUiB+pzX9dw2dpG2jpObPbR7Aomf4kHL9RKXxvHbxB/2oj8oxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=FYlWRQ2j+XhUmeiCttwITUd3mQ+dsQg6gB8oevmCpkHeHXW+W09ZrGDxZnMBO0ickQoVIaNHnBn6i/l9UYh9Y0L7/8mv3MdsySWEbGpKyUu1uwX5nRR85elbg8immBaccbaMYKa+oe5xrpj1A1ehbsdKAkwEMmyZUztHEFyQ6lexreTSWLAUxvdKdLQI3gQNwdErwU1y5tWsuwEgLrYs0kvsuN1b5OfapbF9tcoQr26tQRlA54LwybSwJf1P1KsH82NWPlpg6uZwCiXrWNvyc06tV3EI1JfVcF81in1jNvWnLxVI3miOLQ5FIb0/iWZiVAZ30RQ5EXaWCjs6G770og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=afxdgCO8hE8dp8OWlC8XLoNnQK9gaj0iWixaPnYgC4HlPfIV+O2nr3sflmn8jScoyF8pNOxOV7rA1x+UtL6NKs+ZAz1BrSkRGMi6i9pifVtkHmliXg0ChqoqytZjRVkbA3VvHeAuB6oApP32bx2YXmvhZlEvS5s10Ry4J25yJTM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:16 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 4/7] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Thu, 16 Oct 2025 23:16:03 -0700
Message-Id: <20251017061606.455701-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: efd60b4f-125e-4454-57d3-08de0d44ae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bE1afYQMaftI0CBLxsN6VL7RTdyNIBta4jIq/JLtP7aXbDFmRvWXcIoecEL8?=
 =?us-ascii?Q?q/3Jbh1XZHco8JWn3THptQp7Y3IsFfscE1awOVh3aKlaHum8buyoBzkOnaK+?=
 =?us-ascii?Q?dwVNPI+WzaSgUC4FLPyWJrIcP7lAzNwgPlqqW27AUNQzU5aoTTGeVQORX93Y?=
 =?us-ascii?Q?RXV5UpfbqIX7UrsZKeOeZzLPskbWpB8wis+nMEmwD35anz5ZJJ8dHPA1sLmw?=
 =?us-ascii?Q?FFWaIdfboUqsduW4i6CFchOPvkjhSH1b30+q2f29FUBBpEOLcKgl4IieqUfi?=
 =?us-ascii?Q?dNkMcHVhfkYIWA4MhKDuw8P3X4AEDws6CHZUWEU4IhU26luezCCgnpSTCoE0?=
 =?us-ascii?Q?ppIKLiRWJYe5owH2GdLsPaOBU/4JSncN9zxH2vDbcegKb9ut80H92ab7i379?=
 =?us-ascii?Q?h1D5PymsbcehTwXwxh4b8AnDdWOahsVcBrkDFS4+dIaEiuLme2hKWPVJp0br?=
 =?us-ascii?Q?6lp+Z5ID3N78HlpyNBVYnnfAbT9r8G847VUbAH37zVUskcelBajoleqRb9Hh?=
 =?us-ascii?Q?GbnQhkSdNAl8xJdE26wIl1vG+QrWd9Xd/+XPmJCrOijU0creesNRxFdG2T3c?=
 =?us-ascii?Q?Bc0tcElnpgfINwX+21INmeSoJ724VWqbajJuJnwYz2pM6YOx0BsYE+Qe8oNk?=
 =?us-ascii?Q?h64QVm8cQrElbGPaxY1iPtHOJoMyIP2ljjik4WeDzNSSykfRryta4ZtnoLX0?=
 =?us-ascii?Q?ROeX7G9fgcH+A++XNuQS5pK3ZzCga3D432yZyvuEGHFW+LlOXep6CWh1r4bv?=
 =?us-ascii?Q?q10vg3RzF9CXGJyOsg746LD1+9d2aqQ6VZemEubwlWQFYX0gn1p0medxK3du?=
 =?us-ascii?Q?ZrHOQQ8V7leSuW58v9BOsqzIa5jd8viZ6sAVcbxMc9qfXFEP8S2OjDp2vKBh?=
 =?us-ascii?Q?aQs18ZmuUa2VVIc3k/G7UPYRynVLxnKxkZuf9CTNFD7PwV4z9krLbzUPd7mh?=
 =?us-ascii?Q?vrXDzc01CawOMvWgl8Gpj168jqsVMRLKQwkgluUIut/6uze0cNxBbtnxkW8a?=
 =?us-ascii?Q?DUIoaO9PMLMB+VPB3uMbJaFRMpSWjBcp6Vcv+1191QK6rff9K+b9RnorluSw?=
 =?us-ascii?Q?MqblIupSnUQnOUDxNW4rgA44+IXswCDYy18rFRsofST6AJ273trIFNLbHe5q?=
 =?us-ascii?Q?Y0khxrZRdL503yDGa8HAP/2wo3LhuhJBLoYTEfA7r7ffNkachPyOWxQT9BaS?=
 =?us-ascii?Q?Xbn/WoZ5HA2Adw6LUeq0F4xEGdCkwnz4raGX/egtXPXODLc+dEz5GFabYQD9?=
 =?us-ascii?Q?5vZ5T+N0/FQPvxJM5Rk3Fk8yYWqdLvZCOADQ+nHcb7PSv6TmXGT0dhxilkeD?=
 =?us-ascii?Q?2pVSTPW6/9+HYHqGeqLZ/Fv4MdPU8UyT/dYFtaWfZdQikWTRhki2JQumlDry?=
 =?us-ascii?Q?9oAp7fdV9b7Aw+h8aiWtKXvKnvkb++Pc6P1SGxZrKTyddIzbi1EZ8GpHs9FB?=
 =?us-ascii?Q?Bmu1GG+Cwg0TTsbgxmxIsnyxrzwPO6+u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IeS5wL6/K4MT2D2t/TCV05rZvsDfEy214vACllNldvwbynuzj4y38TI8s+x?=
 =?us-ascii?Q?eL+/fXv8OEBf3W4RPjY28SLYErASxsliEHY7DgiW6rQR94MEUk24ejR3XJ9V?=
 =?us-ascii?Q?V3dj8PWiJbK5967WCkl1C6kEl6msZBBH5dwIdsghigtLRbFazKH/NW/utjK/?=
 =?us-ascii?Q?MQhCLGBpBzgIRT8LWzAexzsBfuALqEewlt+154HWvfuPU8Wst1az3sF3cDkP?=
 =?us-ascii?Q?a+fZS9cZ6SvoCQd2f6Yg1BB7k8Pemr1klipVocBWmcmyKqDKwoFZflajtLAY?=
 =?us-ascii?Q?KwThlr98O3QkAIboO5iM+k6L1RwpdoUQuA9iWcULkMPdmOgNFTNQmIqHjWdv?=
 =?us-ascii?Q?7jAf6yw3PnxZsnU1Y+q6aRiec9P5kemMu5ayZvM+zO8Id7bZplBjXRDaH6zn?=
 =?us-ascii?Q?5wNsKlXMfzHzm2cwXp7Sy4THYRGrlYjXFpenKE/kZ40iP2KjyPvKCP4sjCa/?=
 =?us-ascii?Q?ldMqL8oBEl7t3aGzVyp/4f25f+0Gjth14Al40gjxpwm9qqWwmoslesfJ4lRt?=
 =?us-ascii?Q?Y4AvTnNh7poMArkIXgKZoBAkYszjPb/HHZJ61XKjKFtIAMXdOwGimx6sonpr?=
 =?us-ascii?Q?PW8m5Qkafs2csWB721XMvANE/6I1NUGtHgZB0GDWTG5Pfyw32fHeNXwu2X9C?=
 =?us-ascii?Q?5OMT6J8F9faDxLu9DkaIFb29MnwIbHoi1q1GcV3o8di3F7gGtuDh8mGvmDj0?=
 =?us-ascii?Q?t4H3UW8oc9Er/nlFBUjV7z4dTc1rzJlG0+ZxjcdRBQ2s43to+x6vdcavkdde?=
 =?us-ascii?Q?IB6ZwOHlJDSqrEY0SYQ86MkbMY7QBtd6an68BV7Q+qHo4u9fWggvyi2aO7dt?=
 =?us-ascii?Q?+907nF9UsTVtpqGOSmF4FmC0VrR2U529cpA/Je9MVWjFYzoqbTzBgsIB9cvK?=
 =?us-ascii?Q?7M5i5bbdNlY96SBpyhrrSpBXA9XeV8KYiX8yGi+XKmMH/AEp7dVXVldtB8xj?=
 =?us-ascii?Q?yWegkAUCbQeeFiWdc5SYpHFZWPJeZ5kr2JKcMFN2++cT34ICE9mNm1tMwg3L?=
 =?us-ascii?Q?40AdKsk9N20HQJ8CMDyVnRnWX1OT9BnoG4yDimGnxw/dkXMzGpm7oq25+f+Q?=
 =?us-ascii?Q?2am9TFy4V9t/KPDHWL3KprXl8akQ5gQ0CyercjkFokTQgdYVrtlDiqEhVPuY?=
 =?us-ascii?Q?E8MzH/XIT0BaksfE3Lt1wsfLEUTly+lCM5LTfWgT8twemlt9VpWHfi7mSiBF?=
 =?us-ascii?Q?54ukNUfoBIiqwvc5voYPVoMdDksWP2NYpmug00CWXJvL25akLEXDXmU56ImW?=
 =?us-ascii?Q?FeZv2DVORBIY21lxKg3LKfxJ7qr2WofD3uCTkAx3b7pTIBLNHbmhaYvRc+9a?=
 =?us-ascii?Q?dj2SEQvREPy+dLQzH3FYNlikZ/ACk7jFbi2L4jLENsXyha0l4UdWQIvZhoBQ?=
 =?us-ascii?Q?Xia2B8b6S4oqUSfiCLpDj1HXjo+H9uw76byUCZeGu3nIemVtmSmt8W50f3/5?=
 =?us-ascii?Q?/pV/adq302xT6Cd2W62IHYFsOh6AJ9OwisvpoAPnq9NStCKipy9AN2U5d9Ol?=
 =?us-ascii?Q?zwnGhe3tdmeS/v/CvMDjLOh6HEWdognEj2lnAKhcO4361jyhOoEXbWV0RHtw?=
 =?us-ascii?Q?yu+TsCsoldrXAMLsgec8keCEQ77764s3N9kzb8A/xZ0/mXrUJwX5Fyr+DkfN?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v6vayQJ4QYs2tGrvQoPITspCSafbywqnTuAwQFFukTS49F3+5US/7khr/YCGYWAhx9wzH0gZxO3ScbI3QlswuV3Yocv83WpjOFdrFlvQkQH0zuH1nXCGbwYvTKK8SOrMizdqLGyEKnwObFPFk9YxOkSNV0PSkkangHOBb+EnCDjbAupm2bSdoVmBDzHOf0CkN5A2CTRI20ydAf8N677HS17/zJN4fhlaSuxKl1IT45DjZ/LeVGGMgKL1ZSgd+5aT3WgiYmFYs0dAvBRYAv5agRiVWmHooLajx7LLvF0edCxJ2yF49hn/7g7CGJITw8Dol4sqvd8aQkJ2J+/XZDeVwOXt3+1877QzBCPIyQEvm0OJTDGtUIOhOex+7YkH/Usvn3hLJLV852dQCBxliK72kwshVWiWoWpHwIbD8VBVrfmapU1Tajx98PVAhX6MXxYR49X1ArT9vYz2PtT5A/sQ/9ekBS0k+/9tc4gfZZEEwJ+cFsI581RWltZx3ABBw8/TDIsC5T1zVlayqo4OXuFj7SiouF+n6EmF1XNUSb/z1GiXaVRosE6pFGxDYuct4seww6PThmofDj6M5qPKTsbSDeRo/ASEDdpc/XAWMsCghz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd60b4f-125e-4454-57d3-08de0d44ae29
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:16.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw26c96XzSqNBJennLHVdwEPqXIuVGptdDZTToFKS9pQqQdKRXlALjOF/C9Dl9hKLi2CA1D6gYaLGMVdB46/J6Z2n2B2XeUmyTnr9D9J6ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX8ttIxOkMrion
 y/UAmjAgIAHb47UMx2Kob9snqWBt37qtcEsCbc6gBzSj6PN1injlQeEfL+lA1T3VGaCQjsEQ4Sk
 Q8te5JN3wx4HqIORJ3qD38OtvvDykNQDhm0weRG2zyFJAzIKMh2avr3JcSC8/tXueZwsBbmwcyX
 o8bIoSaarcsqtbZbu8mfT5m6ZhX9nVljwJQNT8NmO8PW4qFDtMUPZOIpfnrIGkG6OIEooS2jnOP
 HTR+blAv6Rcs1TwKNg5AIKPxfUpC/Rzdp6t522l8WCMbhCX0y1ro8PGr0GhsPHzyQdo9ky2ybYd
 t5knj0uro2cHDLcEmEclLcWflxuv8ntHYMABcDDE9ky/uEAU7mW3dWnoKmCYnRWC4NuavGJ4K6x
 jsWK+YdNUGo8bR5lYLqIST2Vb/E8McYwgVfBVW5LygejsKlR90w=
X-Proofpoint-GUID: 589RgPbxJZg5ovgRGn_zQOLh-BP73QLt
X-Proofpoint-ORIG-GUID: 589RgPbxJZg5ovgRGn_zQOLh-BP73QLt
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f1df35 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=_t6Qa8hZe8VChzH1jgAA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12092

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with an additional LOAD->LOAD
ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0063b46ec065..9a218f558c5c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -314,6 +314,28 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ *
+ * Arguments: same as smp_cond_load_relaxed_timeout().
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					      time_check_expr);		\
+									\
+	/* Depends on the control dependency of the wait above. */	\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


