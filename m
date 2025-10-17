Return-Path: <linux-arch+bounces-14182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB5FBE6ADF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1163874293E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A63128C6;
	Fri, 17 Oct 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0Om5lJp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ThNb27u4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD83128AB;
	Fri, 17 Oct 2025 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681805; cv=fail; b=XSGlkGcGBdm+X1uvwuxAULpa+Wkk3Ik+hSafkO9ahvu+oJ+CYJmoD1AZLPJmX1KP5gEVi/u6b2OjFXKLy9Uu/hdJk7TtkzyqUCIUP5I7KUF0I3OBH/qL43LR2sWwwKRPXoW4G6XrmS02WyCmBRNmLFkUs1xkR2/X7UWRdI+4tyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681805; c=relaxed/simple;
	bh=BeoSOVBsnVe0OtSm/G3GKUi1WIHCex7vo8V5WseY7s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5kzJs+pCFXC7/IptSAgqm/O3+sV3cQGoxV01uiXE5JWoNV+JiUaJpJaGJnUq4XCxpkbQm103OXx7B22Aua3vsRnPpHUVYlVNvmUhM3bZrioTczUz23TvRovPBqcTviCCPrNO7ZJm/xiJtLQtEdA/8uLQdXDUPx20GxrU+Map+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D0Om5lJp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ThNb27u4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLu6Q9023298;
	Fri, 17 Oct 2025 06:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=; b=
	D0Om5lJpQhNGYdux9c0B0Xuoe4y/Kw3GFuLvJKaUSYytk+sDW5PvhV6H3oR6hEB0
	2PxitxPhPQK19yEiuVS+sRLgUBF7FRPKRyqM0xURr3OVVCEpLhaYhMTrhyyjo5QU
	ro+w+hJ6aRwqkXNcik2bw3Cwtfno8wf3Bi/1fe5IBkRU/zEFRzgQHs0JK7+RYyQn
	v4DuZfXuzwokYDBgeHak7MQZEHlC6NmzF2NtNJoUKsWj+RfBSzfc5HKKSvevPNSQ
	ITkPqrQVR0gUVQCXjO48Obn2ibpl+iWo+8IY9XZLgL6Hw71ULsqoWsx7CalDfDDq
	3wJLknHMr3NP0o9qS2/IQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59jcjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H45EAw000688;
	Fri, 17 Oct 2025 06:16:22 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcnsv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0PNq52j/VM9qf+DVBy9GmbQZKuJesZSKKWm3MzIUmISG1mX+/uQhh3P26V4f3uwh3kkytr41HcVw0/uRi9YxvNJuAmM64W3MUnOVUJEPzwC9lGgFVi7pAfJYCpeaPONZWN4SzEzuUod/9vcX+I3o4mrwf5zsmiaxAssCeAvCWBvepED3DOgeYEAQKpcMyS2eOIp8pLna/XeGrfiakOuCFqIh9AlgITRqqhKqKNf+IApL/1yPP7Figj4osqQTx3ljUY0SFMMsi+xj3Lzoapn/WEtLV22gdjzEDvqp39Rh4JGb0pzs/4lmqnvrhIUwikHxy8dY0WAvbG/pM3Jhuh9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=;
 b=b+3prxKXtOmjoKaFRu8h5L4AaGgc3DH2m2jg2sHirL0dKAVAVWi1C/5vIpvhUX7GjCt/iCuYBwH0klkCyKKPN9p4dAmY13U2G5sNoGLDiZlBI318kuHge76dkIFMO6uS/Dig8m9djX4WVoqs004qx+VyZPmoHjgUt9J3fniM8Z+r0GYTUFDPBj7hCnywXiakFKd2OhGs/x86JuFfx5jcMg4e2KK5v4iEmI7a4ei8Q9oZSODMUL/P51ZK/3OtbeA1VlhR7N4A20FaaIe8yhVNRaYp8MwmlWJy7A5nXAYyr67YMsqkc57pXfaO/6I9rPEqOwaeCOFKiKJumJOmI0mLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=;
 b=ThNb27u45phsG6aT3OkuBKHngiFDGkyp8fGwLGhiCbB9oEfBLvcqPy+b81CUBxJKoFHE2sxeqsaqx7fwnCYsgQk+gCdkX6eCZkOwjgfUXYHP8rLxnm+SLGG5aQ3LfdCMjCwfKBkv6+s0/HR2H4SsdaVQM/CttnVxf1NIJ1eyt3A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:18 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 5/7] atomic: Add atomic_cond_read_*_timeout()
Date: Thu, 16 Oct 2025 23:16:04 -0700
Message-Id: <20251017061606.455701-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: a62130e4-8006-438f-9c37-08de0d44aef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qfwMAu4t3gPgJLOzGGW6M5bF7Sb76Nru1FpGFF5KiNRTvm30JIKleHHp6Tls?=
 =?us-ascii?Q?8TWZeQd7GidTgv9ZIyYbM41BfrXEWNsp58icNKsa0fDW1023NfdrieygpwhX?=
 =?us-ascii?Q?xsPuBbs5JShi7VJkj9HljgZ9Gs7lxMu5evV2/1wdMjpyeKyQAefg75NhxhtJ?=
 =?us-ascii?Q?sMxr91U0qdWfHYaOrNpPWKL6ZAeObm2HOkR/UJ2V+XGitDd0xDj6qkyXJnkV?=
 =?us-ascii?Q?Ct4AXiqa1TwOOObkceTZWX6Zi83pXt9aFa4ugAckr1hO2n2k+a3WGLL5YW2a?=
 =?us-ascii?Q?bOrY8ryzhHZOo1C7x78QWXHV4L8y9ZpDjbtnE/7QpPhM2vSV2RFUxMAkjECm?=
 =?us-ascii?Q?CyzH8qYLg6d4amMeRWg0VgBdS2597l8pKpbqxXORI/8fLDUFRWjy7aTUDhg5?=
 =?us-ascii?Q?vn8JFOW1Max34mHau7EhuMdoe2wYNRt9a02G3ZgfRUkwOUEUBlxYRSrFuXS3?=
 =?us-ascii?Q?Vs7e/HCQEwyRn5zdzJ5hEwkw85I2zn1DefVZWCsZbsA/EIUnbOivEtMvCFzK?=
 =?us-ascii?Q?xcyA3rTuiIWofLBdC7ZWM9MKE//aFZHgHiICSjAgGDEQdyYe034jSh6y5HPl?=
 =?us-ascii?Q?OuDBUiIX8X8cLJFyieW30Gt/FC+6XPhNg6y5Y4LxhyntVrm9LjXM7lZsiDOX?=
 =?us-ascii?Q?rWLVdyPSBDlL4aaQZ6Wd8O9MbIBx4/TnjVkJJ/s92OWAJR/b2srk+kNKpMyq?=
 =?us-ascii?Q?0nA/GidS4UIRhpbeDJXeJ8Y7KI/UKLLf7PE9UsZU/L0sJ5suDrRePs+ADAMD?=
 =?us-ascii?Q?GU3ip3KrXtqsVvR/1UdB/wT31VJYEx9+0fProSbZzKBCwfrapKgTl2x/A9kq?=
 =?us-ascii?Q?l4eelKTH1P9NFJdqgJnOkDaHXicdB0W1ptD9LAoL0Jy7yYOiDFbHrl1Yr1nF?=
 =?us-ascii?Q?Q9tvF389srGSEljmjIV8/Swo93T2/1GTMGlVcXeq3OIDfdQBE35Kp31Mg6un?=
 =?us-ascii?Q?ewKbkQ7QDwHC+RZ28yusKAEAjoRqOfyFNXIyaKyuFW4/1+dwya7F8OwpPu24?=
 =?us-ascii?Q?N16UMXzf3tdsa4QO6OzTsrFLvY2MyQspRevNbzEIp1jRCpd4ntRrGkWHQXvO?=
 =?us-ascii?Q?oXj0Tsk+wdMpYqJx0+f+o0JOs55lREk3+ClA82PHwPkWJa9ABNV9TJijy7A2?=
 =?us-ascii?Q?KyDTJ6of/+lRQ6ZFJDCezJ58PZs12UOM8+X7YGvnGNQgaxeBH3QZNzW+vlDl?=
 =?us-ascii?Q?3A2c3BZDE0PoVMKdMbvWpDrDxgCq+EsDhM1Xh4sp60nP+x0ey6j2Y0A1FLPS?=
 =?us-ascii?Q?U441f4x+eN6QtkZv/gBGKG5o5quK3kRnxbsRF3ak5n4QqWqXIXl+TzcTbirK?=
 =?us-ascii?Q?I33uYMmqNqmY1ROIW7C8jpuSgtUDVoUHn1bioOH35Cg8M8ton/5tR6oWAwqs?=
 =?us-ascii?Q?EMuoVBXbH/bVwnnP2ts3xF79LS7Wu6UaX9O6yZenY8JP3XVOSK132UHs/vzS?=
 =?us-ascii?Q?b4I7ZN+n06C+0mbgSXnh2AF6rbGn1Sk5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ej5t5oXN98xldD+ROn4vIg1Z9AJFdGF0YFUzLQ9GR7qMQNOanskMpK9/9Ybx?=
 =?us-ascii?Q?EU3sgUc2n2kkq1w0zfLrqqvc7Vc29YhG+DpSHX/0ftjwDNouFjioyCQ6iWNL?=
 =?us-ascii?Q?VVDAHbaXZYsTYzBK7Ph3cUJyRMLNLCdlkXv94J6zhm11eEK0mNj52uu/bSTw?=
 =?us-ascii?Q?vCRtSuhK50BphUbogcKaaHtCcl6hE6Y2HXGUkk8KMavE0Jx11KbKXULm/TnL?=
 =?us-ascii?Q?eN4ytpHzQJA7LP/EbfX55BSvSQukHw37EjDR5TO+KeLccdYIhvMIS5jXOZ1b?=
 =?us-ascii?Q?ZycwnvGOL0fdRtSzUmrY4UnFPErlsyNzEkzbwH5+KIDlA+jOlY9ri9R3Y/1G?=
 =?us-ascii?Q?snJStAxSU355dHJl/gXJog+qbOV7NFr3Xe2c8cT+zIdF78ewH0tbUSsuz/9k?=
 =?us-ascii?Q?xo4ITadjh8rUBRKrXPFUmMfIzbF9ueb8gwqPqOcIwXR7OMJQ6Ml2qmn4LvDT?=
 =?us-ascii?Q?C0K2lEkZvg413FuoL4eGqYGHBt3YY6Rjizw8A9V6qIL/vz00tgm0tCcEfa4P?=
 =?us-ascii?Q?0U7LQpQbB9bV3pSOKrbHGhlThs9cunjoHuiBOwxHsjQt+irGsupaEcPgaywv?=
 =?us-ascii?Q?BVu+ig7rMwkp5GOJYaJA9b5i55WIDi2Ox+i78QwNUgSuTMOMDB6fIPfOqyEd?=
 =?us-ascii?Q?7j+KcJi7JT0/vu/Bi4j1QKlQI91nRLWrsU0KQgBwyXnsWTJo1S/PUxnDB2m+?=
 =?us-ascii?Q?AYgGrqhQB30Ro8o0oM97SCuUFJNb9nqjVm87uHK5fr7cUjv9fRi66Hja5eCY?=
 =?us-ascii?Q?/GiKv0kIKWMVT9khotQjwJXcsh7ysn/mxlCwHRONKIZJbHCJwyhoiYF5ETqu?=
 =?us-ascii?Q?tf2okZek2yzMxYmFP+d3SkCiXDTypfIU3PkA3qKwaw9dHcs+5vumc/jCDWf9?=
 =?us-ascii?Q?aTnzzo/N3tTNm6k0Fw+vcyeG33ILJbDyq7MoUrPeeyXoKeBwgzc1QWGVwyte?=
 =?us-ascii?Q?1B0AWE43UFXzRX9ItX0b/fqjR2eH2vQF9qJYztYla5phG3e7lH9Qbz1QdBhQ?=
 =?us-ascii?Q?2QpqVJt/x3Y77LSaPc81Q2SJApiQ/77PcbWlxU2/RkQGRHte/kGOO1Ky+67P?=
 =?us-ascii?Q?SEnxQKZSfgMmPC0pWSCW8oRKrkqDHTNHnW5pc8jClFdi4mcKI3RYU7Z8wEj/?=
 =?us-ascii?Q?bt7441Jl3AaWLConcfq47Q0O9P9yQSlL86PnbJCaGQBN3v25ltOMf6BSwgzl?=
 =?us-ascii?Q?ydxPPopduhr957siS0qHELEbw7KvWW2fycSP/EzVq2j3d6w6u/1cg7PWO5er?=
 =?us-ascii?Q?PTgG/f0nywW0K7daDEbOXGc398ziWB/Iu5NBXCtH9eAjhJIetuW7opInr34T?=
 =?us-ascii?Q?xFaKFD1cPL1CeS2Pu8sSqv3vD9f5DseGcyv0skg6515vD/RY49rzAY0PDMxo?=
 =?us-ascii?Q?wNopkdA9OsFtOqZcv4x7uCQIOOATQ9ha1mOYkZGIbyyTCbJNBflb/p34vUr3?=
 =?us-ascii?Q?y9oLDp61DW3I1vpbMdnKky+jD/KSY+LFv7dtVeE88jdRdSylYHZYO9V8H6ED?=
 =?us-ascii?Q?B6GMsUPhDqYu1foqIEo/hrGa5DpA/3m7Zoa85QFj8rg5Lbok/Z3UJK6hm0S1?=
 =?us-ascii?Q?AS7h0vWZCRwY+fn5Mv+0FIJfg0XSdWdqrEO4anOF9i/+RFVs0WDFgbo7FOZw?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7QpbTvR+Yl9RYyRKsRKFpcarG6wap1AYJsvCC7GHn1Vtq3Cu44A80k9LFK6PtYFaJYOrQFIQTygpcHpKHGTNcXUq8ehelmx+BKX0hD836LIX2N/S4Y6YgLEpfLRhs+5CV1G48AuPX/2zshsjrSui+aX6KPRv/NqUeyBKFMF2RrAq0+AH8awBwIu2Qd9g4wkYfXoPolmBavQ0u7iu3mJs8G+SoDXB1SyUbkShU9Wn0Shf+ltTPQ529sWgbqiJeN2thuxon4kF8VRdIG9hX6BvVDU3kye6aZ3NooFDlBMf5VXEUQ+nYfdCXuAcYU4bK/uEJRGNHj5dgEaj891E0psPKd6+gnPiDR1g2mFgxVhducouoVZRcfxDyZ+/7E7B2fcsNxEaguD3wOiMPFrW9D8qFHRPgzcgEqej0XBwrXEl6Z79UxYkVsSnfhUgs3+H2CyV3TuELRkaHyYkzNwFumrj3pz6VBmv6kIwk/vTI/KHe8eUEionrk8TZNtX4OVIfJr8l6kf5LeJ0gkgSdJ11/B9Egg7ZhW/yQOFt63zJFaBHAZhXeEHsBAiMqJxXk9V3oj0vnRybjNbwxkeKctJ6V061hCFQM9Moah+tUfIhj5PJR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62130e4-8006-438f-9c37-08de0d44aef5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:17.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCnt7XJ9KjG7AuGhjBJDzfnN6h0GRmFYEEwtM0B+nEDlmDJsMVsTHDyxnuaAFQv1AJly/UoJct27qbeX/cl/LKmmHF31BVYoCaVgbahMfiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfXz/s4xjql3d7x
 oBNBbF4/xDEQFZZ2pf2psTRMhFNW6VGB15+kIPq+b1UolKjUNq8Oyu7f0hvz9L+rqPSQkDaIG8F
 lEuq9Zstfc87sTftRfNK3N52lf5uFv99AbZYGt944d3tJyBjcAogsz0BG3SDORM+7MaHrN35HRl
 ROm3j+xp6JUPd+WUWpxVRsb4gftV2x43UwnvyLfaxrT2yEvLBLKLTEv+hIlpcl6dz0nIjOK1+u7
 6lb64g8BjnQeuJFsdleoAkoN2o1IhOZ7vp+Qy8FdVSFbZd1TgE47CicvP6prhtVsyKLsUgZ3LAE
 2Wd8fMj2mnmXQ+cXdFRPbVWdBJ3sqredxJYNRQhB7A5L175BF4kU79n1fMZfuhuvYj0yXwGXBq3
 GcpXPg1u/G6t1dNDuGv/ea6NDe9vew==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f1df36 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1qaWZlc5I0uanKkomNYA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: p04G1Qndbsamtt7ZqkRLTJTKFstbD78b
X-Proofpoint-GUID: p04G1Qndbsamtt7ZqkRLTJTKFstbD78b

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..49f8100ad8af 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.5


