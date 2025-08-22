Return-Path: <linux-arch+bounces-13250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D7B30BA4
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7534BB657AA
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA261DFCB;
	Fri, 22 Aug 2025 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GP2F+7uU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EN070D3W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F881A294;
	Fri, 22 Aug 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828597; cv=fail; b=ttyL0fCoXmZJBPByNm6KuR80OvUbqC0r/l1HI3k2B0zTQu6awm6Ns12hJiKKbQVCFJXb33DFU7BQOMa5rgA/wlI8ulXPleC7iCM3o/RR1evXJhzn8T3vVEYHuWiFJCrZoAwKCAr3NoxMsME/HPOUWV9DArn8LrZ+X0aaR3UjN7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828597; c=relaxed/simple;
	bh=Mwbdcn5qjDoyECrVqBZ5yLr0qruP0CBpbUkM9xGouXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnW7imhZxBcktOrWAQzNN5gmgs1rH29V3gt2lX+YA2y55sjmRRv76mtiRdhTF7lJw66flH6LmiQqDii4x7Y95h+wqFbi1oAinRfIBw5MCz9Q10aOzLQgUxdSf/T2ThvvXA6yS6P+mHKk0P7+jK80Jb6y+QVCJGXvvX60QMyZQZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GP2F+7uU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EN070D3W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M1h4ne023365;
	Fri, 22 Aug 2025 02:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UIVwOUiz1T0qBG9yLnk2gWikRHb5EWuiNzHp0FW3AoA=; b=
	GP2F+7uUHPfg6CUaFIrpoGnMFnImQv2RNEaE/ZxTNYrkXq7bwB9pLcEVXyPL1ssi
	RpNMFOHeyEmtVV7Xj6cahRkdD4lgfdUNAmqLDtVoke3DWrNGzbEzVQNTkJRAkTmZ
	G3C5JEFlZvqx97mBb0ylxAxfo0Ws9SDnwY2sgLFaY3XD+gK9n+Y3Esf7jG7adIYQ
	4idVgNMiVkhMWzrgMSNqsQF3yBOEHZARP+8uYlMkIy9TQ3c4lUI9lm3ZpyYvCwSW
	ZRhw5R6c13bUuVhdz0v1nygrOmdc29xjMXISdB52i8z9QXgE0ZPPvOixVuVDL2rz
	sP7QB3Jzmkutxm7FByu/cA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pa268dvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 02:08:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57M05NM4039485;
	Fri, 22 Aug 2025 02:08:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3stpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 02:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6CESWm4x1VfQMx90NkyA+31opolklpMldVbp+T+zDjYmBaXzTQdpFGSSWhKzFZcur/S+MNQxayQL6aNKHqa7pvTPUcCcRdIPkMisHIjF7foHs87+WL7mYhlxM2vknSqT8fGZPCiRujq7I2qlMmnnSfTleXEPPZVPRoO0g6Y9r2JUR5YcXCQqo4LSyFNNf0t9KA3SnQQiEpzYuAWBBRtUQ9cx08g3Jk34i/x9brwt2y7PL6NVFfpDk9q/UlZ4NgLKISMLufS9lM/RACdE6qfaD62BGcDCi0gCUcvQArV5Yo/6PLDHyIzTTSTFiZGYkD16CFAjBD4MAUjDjzYzzfy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIVwOUiz1T0qBG9yLnk2gWikRHb5EWuiNzHp0FW3AoA=;
 b=guW+UPoOy0VuX+l8A7pIgTnkPofeg0U0bEYk+8igYTBSd+u+OdK0n3I3YGSr2Gy3MOYopuT9eZ8fEGFgyrA5tp7O3DnKVdnCLTEw/tFD6gSLUf36Cd+QoVFan0X4ih+HiAsTMwsYZ9gq09854/QyvRzYE+eidrss3CoTJuTRtx1dQA1q+/4sE9/D3NNuUuoPIU1Zrl7pgWJKwNc+6uq2UWo195AGjoT0L3ENgUIWMW8puhZlGvkGAV1MYeURC0b0Kd10r8C0MfD11H7+LqcUXh1UVM78pbCCxrthfJmojOwwCD+Vmp8Z4Eq89za7CKGPZF5HvCeP+zq1sy0QKpmAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIVwOUiz1T0qBG9yLnk2gWikRHb5EWuiNzHp0FW3AoA=;
 b=EN070D3WWq5u61HIiuBgexN3e4aTkw84XqznoAcz4zBHHk8pTOohK+bGIz1TLlp0jH9R6v+U/WnQkjknUqClgOMCYRHkmdQK1xtv5I1pz8WfuNeQ7iHeAdFvn/BTylgBAMAKFBJnTlvt/b+n+cL/fLZS6NpXZ6oSQqO8HJGw+ww=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 02:07:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 02:07:49 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: harry.yoo@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn,
        mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
        peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
        ryabinin.a.a@gmail.com, ryan.roberts@arm.com, stable@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, thuth@redhat.com, tj@kernel.org,
        urezki@gmail.com, vbabka@suse.cz, vincenzo.frascino@arm.com,
        x86@kernel.org, zhengqi.arch@bytedance.com,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3] mm: fix KASAN build error due to p*d_populate_kernel()
Date: Fri, 22 Aug 2025 11:07:27 +0900
Message-ID: <20250822020727.202749-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818020206.4517-3-harry.yoo@oracle.com>
References: <20250818020206.4517-3-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0023.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: f972062c-5f1e-4c61-4f29-08dde120b150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P58DlVx7YWHkQS5d5646LFnwkgVETT4VYELbvh7e48ISbbXh9e74/3g3L4Tp?=
 =?us-ascii?Q?3JmI/NHq/7mqYvfsYyZEB6L3/DRjAl4DRElDciip77d1Gy+Nniz/M+srJbtk?=
 =?us-ascii?Q?e3Gv0ZLw/59+ZXbSM0OypBUMGGvTo85lkhTq7A8jffWb98z7p7IU0vmYDa/Q?=
 =?us-ascii?Q?PXSVUKhxwQLn3Fkrw/SOiaj6smxfTbRjvVmGO2gt/wL1wKRocXzZkdXCwxWR?=
 =?us-ascii?Q?kNRQpdSE+pjrRZLKnvwRx6EArvJEoQ+JZFLyGyBtPRE80ZtuO0chXBIRAQUO?=
 =?us-ascii?Q?T2x6b8OCmfjZZyg93zi1WIuUe5NZG6WwQeCXPY+d0LgQ8w3/lHeKEbFgTIuL?=
 =?us-ascii?Q?8p9yFqP2fu+I9JM4NgZ8kK5Tul2liQU1YL2GdITClSpsaX2B8q6ma+9MxTvj?=
 =?us-ascii?Q?1JMqL1U0ioHegrK7pHjGNf1TYtpGhwzia4N8qo+VBu6QYGG6WmfUzV6OSZ+L?=
 =?us-ascii?Q?8CDQejcKJb59p9dc0gD6mAvw3tVuWDBByGfz2cV9SQNMjmSZwOrR2jM3Zhhw?=
 =?us-ascii?Q?fwlHvIYPA2eWdiaz7cNee7E7yKqJ/UnTi0OxMpnK+7j/RgIz7Jg2cdTqAeYt?=
 =?us-ascii?Q?4aEPP2lWkMvoU1r89uJWKcbQLHVul8aIeufmTmAFnmJRu+qAtaO7xVCHt0UM?=
 =?us-ascii?Q?w5nB+ImrtjDsqUfN5JLwd8pSAP2+UnHH+A+8qZ89GtuCLr0EBc5vdZrytrzH?=
 =?us-ascii?Q?MJUvqK4gt3JQ3FAozCMnzhaJV5lJ20T8AhJrcugBHh7W1VVKBcCDA50rrbFN?=
 =?us-ascii?Q?VK0lz3PSHJHKvL8dPOGGwBZGCKgK6c6dyIcNveD5jcaBBMeUIEN8LQaXMFEv?=
 =?us-ascii?Q?Ykfy48MyLiWKHy1i5COYU5briPCQFTubAWXmLPf8PfWzQNMUN29Tuhl0uTS7?=
 =?us-ascii?Q?nN5TSvHdnuBpziAvc2q24NTq1/+lcVcOcMttaaZOcf+uwWHqOdDY/s92w303?=
 =?us-ascii?Q?lAIGuWQwyQ4r8EkZw9OceI0tKwRtlQi5Tn+nk4/kHYz+fA0h0wT5UkZaT3m4?=
 =?us-ascii?Q?xgCMjGopjR6xEqI4K7Etl5tbmrMOeG5hfjR0JeTjuH3QEmTjWXxq6E/4NmT5?=
 =?us-ascii?Q?hOzWV5W95SAQF/84AM2csTTJGCt5b6HHjT2s5PZWDkGo4AbKdNP3msLHx/69?=
 =?us-ascii?Q?vafAAF+0xB1AtmyNVTGi0c67omXJR2HDjVMIL8GVYGg2bvFdYKzzwD09q38e?=
 =?us-ascii?Q?6KPovEo4HKqz7I1UJmZbQxos7SYIER2k8tASTG3P9oUySjO+tfcxz7PZjDvY?=
 =?us-ascii?Q?DVm5ObBX2meHPCEk40upzuZ7D+/177g07rJT5hXQzmp5J7OF+TBFsyyGdsKt?=
 =?us-ascii?Q?l1aIv96VeYy85RWVT0yFpKSvZJ3mh6yVBB5GjGY/D8gL0Y2IayHm98b+rhbk?=
 =?us-ascii?Q?RdqVG1RWCiaLYuwszwj6jisj0rXiOJSdO6sULl1VlwYoTdwg6ZyWxyiSwFUO?=
 =?us-ascii?Q?wBMf9SduxII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ifPb/gUjlC/04hm3LlS6wxD4wB7Z5gW3ir8pVNhDX1G7x72+qOYS5epVC4q?=
 =?us-ascii?Q?kUSpyEH6Y3Kap+4MkwfDZi8p3NaG6kDI+Ln2GR6kO8bYMWvnLZ85sZVVdXOP?=
 =?us-ascii?Q?PuDWzL4uZSXNhGBl9ncBu8puDJY5niyLUexJPwH/pZtTMQvrklzalj1jcgv5?=
 =?us-ascii?Q?lIoXiCjQHMenkFQBPBcPUnoHR2jFYsoA7WEKn8aEMhXBqjDnNiVO1PQJxlPP?=
 =?us-ascii?Q?yOqSeE0R6q0egJWCP+5diAHI9ZC6M1mkmkunxw7PgOScacgBg7Zgfo9FDJxp?=
 =?us-ascii?Q?3jRu0XnCcfe8UJYiHA0i+YF4KvEJyKMTf5Lkuhdbr9IeWM+/8fQxLVfVQltK?=
 =?us-ascii?Q?9pCs1NjzLep4JkCqm9s43SPcticGAeMoAsJ838C6KtngF1xJw/4uLnqxaZei?=
 =?us-ascii?Q?pGGRF11ERnqVR+WmO+KtU5v5ybvyuKgE3HL0nCUlkqFGF74e2Y7kBnCL71tC?=
 =?us-ascii?Q?r+3NPWtZ6qJ1hb4VuoXrM1m2x1etCH+94NDbPX0JPanqc70OS/wUNmblknwU?=
 =?us-ascii?Q?/mKBkDtGT/+TMlOnWXcQRU0K3Q9oE+eWDay75vGD5MYE4nS4YYajW1aOvVQk?=
 =?us-ascii?Q?BBYwsMUmnDkuz5QfxDpLKP8w8PMpvJ0FOGWJq2SAGhIPvrbn36Es4vQdaQkx?=
 =?us-ascii?Q?lidvUuP4jTvlRVnAbPUM5GUaUOgmyzAlPrrOdWBFJgl0Rl+5tC8YvT1Poroi?=
 =?us-ascii?Q?deD6+Uhb3oJvYvwPk+LJ4wVFTiAUbfzhZ1+hIk0BAwiNMSLjI03HB+RPsPlr?=
 =?us-ascii?Q?+tScvMLOxnVCqk9CxCOL01fb1wC/WvAE4RTOpZvJO4lQxSy4tyMZgRUL7wyS?=
 =?us-ascii?Q?VBI25bFR6ASgAfPPjc4jbxlsR7+BgaIWL6q2nJ3AqnOcFVfyYvrcHUiSP4tA?=
 =?us-ascii?Q?IISZqJQlDg/PN9FRLsS3Wvmb3l8J/ee5pGU+gMvvjmtYC3ZnApIqCC7hsOJ8?=
 =?us-ascii?Q?5/LqfNFaJ/YXPKmB8C0HAl7JkJ6gsdRLZvqjm0/teDl3WXnuq2l2/QZCiELf?=
 =?us-ascii?Q?ces7PBGczJY3IeafQ6tBb2Br+vyxH8eUJjJgccQzvW23O5B2ruHsSf1cswi0?=
 =?us-ascii?Q?0DJnN5zqmW89HevVc81UTpQmt4iDtZ0j3n+fs8nJE3Fc7eEOIKGQNpvVm0iE?=
 =?us-ascii?Q?V//R/r6CZ0Pa+mplTUzxHFUeI7VicWR2gAo5ZdEMagGI9WKS9iZD5CXj9iwB?=
 =?us-ascii?Q?xjH6FxzZZlq0J3vAiYpxEcKsPlRBQS+nDGtX/HPHGn1rz0vvmKi85esk4JhN?=
 =?us-ascii?Q?nJRtfrMcYBAPSXrvkhWaJ2zxV8XfpKCnGt9/+mDvxV7dREMhIuANzg2IuLfQ?=
 =?us-ascii?Q?sT9Ecl/VTpk8i9c1RBO4wSYlQiysDoh/8GCaB+9ZeIkdohd0rXVRsFG5KslV?=
 =?us-ascii?Q?qgyQ2uVD4tBsMsOITnCIt4ukuBFwt6dJg8pRZ1MZXjJOIRJ9bbFzfmIrtsUv?=
 =?us-ascii?Q?Z+kUPWGR55fQeMKlrRKJHZMCmFNEsDwBJH4+CG4GbzZZtqYNNaUb7h5kSYad?=
 =?us-ascii?Q?DWU5C1bPFOzmBKGkhu/zoSAQ3LOma5IXyi4cTa59k81V4Ga4CdJyokduRc8b?=
 =?us-ascii?Q?oBNxgZitkyzReR2Uir8N/XcbA+c2Or5sA/q6V+P1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e2d+YawE3NCWJk1vpq4NvYxOYQHq1OsKoBfrlfFiHikgqKjGWoIgnZNxUuTE7juzzLtWg1nV6eSae3i+r2wraz3mp0STGa7dQ0c+prBKjUjw3AROPaqZYuIFzvyRELxPImAsv+VT2K6ireXo4rIIpHhYGD5rAgZtDA59vNJT/HlZdt12gbq+ZL86tn05DEB2lnW6Yp3wr9g6aM7CC0zKM4TqvOjIvEhXyj5xhjkAq3lHd3F5mcyr/m70LcNWwlnrRw/RP9vOqg2AlD5akV1oZOwlLFhaNQdsbaRDKr1tgsgFTQ17037A5f8eYziTh9DkRG0wLwoeY6ARjisJ37oMEssInpevHd4PkEX6nBvEVl1cWE0/9HPwKfsWVsy+2nOYeWIbhwmUxvP62phtXXwTZFwo/rYqOUSaHxFZAxiSvUxWG2pD/J8AJ8TuiWZ5t1mmkX2EFyP0XYBPxF1gcT8D4R8jGDpjJkvzk8tBx3AATpN9kdE+T25mtL7OxQyGN0eFG1WP0VT3aiFNZl1J0LjmdN2JXiyjtegL6lllq7iQEc1wt0O/OyhGO0AAOUhIiYvdEIUSzTDT8sCOtejJA5Gjep32uV+E3zymYJewXZAQBho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f972062c-5f1e-4c61-4f29-08dde120b150
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:07:48.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwK+yEbkF1l0MHnRi7720fDMwxSRdpdeetoGloJ2Bm6N5Xpb6/aEfyn6MINaYdn2Vjnf/WqnMV764/IaiPDIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220020
X-Authority-Analysis: v=2.4 cv=ZPiOWX7b c=1 sm=1 tr=0 ts=68a7d113 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=rOUgymgbAAAA:8
 a=yPCof4ZbAAAA:8 a=pm82dGgPEAq_89m0cqQA:9 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: fALMp4WEntOoEKc9rGYvNluclFbndQHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2OCBTYWx0ZWRfXyRAolDrssXII
 bvg160s4nQMQsTur4mtdnuoI9hYWTd327JM2z00ysC5ELuBJ+esnJXI/b1SGcGtcjX+Bgc+tQAy
 HtIXqMiHTGwrH6mnAOu6OvLyH8UE8hXnTHtBbUM5koz5OnMHju3LPuAJS9XbZyOEtzSNT7WFzdp
 sWTiCHmjwkt5rb4HeWYLqqOwWObSx+jXZqbDnGJ9j8vVCCAX5D7qJQnrv+IJK7kActEXsCjqxfo
 rMqJ8tlqN/b60r/muFdGJTJHwl+x6sRTmYzEl4iSdmk7jBCw97PXF+BqI6eRI162hCoAZzLRjhB
 3BtqpJT+HjV+uti28G+eo8isTdxNFXOYcKrTPXpyjYNDIdOajAzer0ufQvVe4vCUVpaMPH7m+TB
 97xil5RKK/NOOIx4RHRbY7ZNrzQRHw==
X-Proofpoint-ORIG-GUID: fALMp4WEntOoEKc9rGYvNluclFbndQHY

Address a linker error introduced by a patch currently in mm-hotfixes:
"mm: introduce and use {pgd,p4d}_populate_kernel" [1].

KASAN unconditionally references kasan_early_shadow_{p4d,pud}.
However, these global variables may not exist depending on the number of
page table levels. For example, if CONFIG_PGTABLE_LEVELS=3, both
variables do not exist. Although KASAN may refernce non-existent
variables, it didn't break builds because calls to {pgd,p4d}_populate()
are optimized away at compile time.

However, {pgd,p4d}_populate_kernel() is defined as a function regardless
of the number of page table levels, so the compiler may not optimize
them away. In this case, the following linker error occurs:

ld.lld: error: undefined symbol: kasan_early_shadow_p4d
>>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> did you mean: kasan_early_shadow_pmd
>>> defined in: vmlinux.a(mm/kasan/init.o)

ld.lld: error: undefined symbol: kasan_early_shadow_pud
>>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:200 (/home/hyeyoo/mm-new/mm/kasan/init.c:200)
>>>               mm/kasan/init.o:(zero_p4d_populate) in archive vmlinux.a
>>> referenced 1 more times

Therefore, to allow calls to {pgd,p4d}_populate_kernel() to be optimized
out at compile time, define {pgd,p4d}_populate_kernel() as macros.
This way, when pgd_populate() or p4d_populate() are simply empty macros,
the corresponding *_populate_kernel() functions can also be optimized
away.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508181636.0Rtk0T7x-lkp@intel.com
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20250821160515.611d191e@canb.auug.org.au
Link: https://lore.kernel.org/linux-mm/20250818020206.4517-3-harry.yoo@oracle.com [1]
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

This is intended to be fold-merged into the patch
"mm: introduce and use {pgd,p4d}_populate_kernel". 

v2 -> v3:
- Explained that this fixes a linker error of a patch in mm-hotfixes. 
- Added links to error reports (Closes:) and Reported-by:

 include/linux/pgalloc.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
index 290ab864320f..9174fa59bbc5 100644
--- a/include/linux/pgalloc.h
+++ b/include/linux/pgalloc.h
@@ -5,20 +5,25 @@
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
 
-static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
-				       p4d_t *p4d)
-{
-	pgd_populate(&init_mm, pgd, p4d);
-	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
-		arch_sync_kernel_mappings(addr, addr);
-}
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
 
-static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
-				       pud_t *pud)
-{
-	p4d_populate(&init_mm, p4d, pud);
-	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
-		arch_sync_kernel_mappings(addr, addr);
-}
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
 
 #endif /* _LINUX_PGALLOC_H */
-- 
2.43.0


