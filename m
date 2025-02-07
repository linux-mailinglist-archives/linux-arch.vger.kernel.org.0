Return-Path: <linux-arch+bounces-10046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C7A2B7C6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 02:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A6D3A195E
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 01:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07A814830F;
	Fri,  7 Feb 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVm+U47O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nN+olkCX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBE145A0B;
	Fri,  7 Feb 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891291; cv=fail; b=SR/5UBoP2TryDNE1hBQCJdIP8q5/qADkPe19keCXCyBKYFHlZrp7pAkdnA/gIdcmhYV27DVZNfXPB/5HNpILTobfEC1Zq+si/CQhVoH59iZFZfnpGwZaSEt+tO2pKZFbizpi+6IYHIs6n5i99+veT8bxJbXn7FR48On82r/mXto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891291; c=relaxed/simple;
	bh=duUBN6DSjldSXhtF3wj833SmCBK0G5GWzHZ7/BV4XPk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uWlo/Rkh10wHlO39B+GzeEKayRSwFf+vQ5Wwzz1OvEBfaqFSvZXz8vp+ymE23OBVpN27qU5DhSinu06Jq1JGfZdQTOcHOG4j/bNL16KEBkUg1zZH4UZ5gJkenm2CUvlFXyEuYK2Ip+w2SU0Mr5KS28Zk7vImUBweOiOoFZWcmf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVm+U47O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nN+olkCX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5170NNpv027223;
	Fri, 7 Feb 2025 01:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=So1lTruI/jhS8LmJ
	jS7OYhwNfTWABr7xz/YNkdASmLw=; b=RVm+U47O1FYFbnihCkGjCtrHI1gosUDw
	gR6C0QLq9XyLYFXznP0KD9aSA2CJIRg0vgDcKxInnpar2+4l9HNw7c49IsXcIO+7
	z85MP4n1ZyhQHxRnL9fByscWQZaatAKj/Vzl9w7gmu3YGMglPVe2/oXl6EsZWK1A
	069RjFqaD5I5+VaDLUqdermY0yDcLcys7RZgUvyj+gGXNqg44/cWobvRzMPfPYl5
	xQ80FgbfnwpVa4/PDmIosFLJQaSvFie2PmhB+najrCQZjH2JkEq1iqmVj1V52AlD
	YhvB2pfJNFt8qS23/i2DdsqcAmVZ2szR6fUBQhxvlKgMp1B5z8HzTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44mwwph8ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5171DGah022556;
	Fri, 7 Feb 2025 01:20:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ebae9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8FWbrGYlx0LUOjOMljWov8zcXz7DB+gaJJDUeWrGdWx1+Bwf/xvc6p6V2a2NGHt3kT1Gkg8jdb/54pvdRCC3o4iJ1Rvz1gsSoygDy0hvHK1wB2VwA61atNg7eGhtz+2SYsavowcxjHawsZchqbGELaPpldFX4+zbcujlneDY899QNyIT3TqjInAOhn/dVUOYnDGjACWCH1gs5y7eULVTrIgyp7jWLMENTJ0H6f/zuufJXO+vqYvEwRuVDU+X2+XksPLz8ubMAqLAHIMxE1ipiuGCOGdwRHfNFk2cHw1f5e+1zY1f63aYk4vG/ov44yP4bpEHuakZ1FXN2oeSgfAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So1lTruI/jhS8LmJjS7OYhwNfTWABr7xz/YNkdASmLw=;
 b=yFLMh7TNX9NZLQCxpTyNax9lEcZiCpNA6UP+euhhUGzcu8k7PLkKYauQmD8JQi16q6LE/KWBj4JgLkxrFPwHN0k8oegTvHRq6kfSvyIecA4xE1Q8Q4kRWo7tVRpyMyhOYTsfygbCPIwFJod3Oee+Nyxlj1TyD1SOf+5RhYLhfMd0/JhI6GC570+oMd9JEFCQQQD4GBZYtylzyiYUazpBaZS/LOTMEVE67gRpg9Epf/HbE2YkN+t8V9wTGpT0I6M0foxUGOHo3iYLb+oWdPHq+xFaloU8Htp4Hxi99/ILglESNU5HLU7IQwsft22+c7cvQ/oTeEYrnyUSy1SRUCNT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So1lTruI/jhS8LmJjS7OYhwNfTWABr7xz/YNkdASmLw=;
 b=nN+olkCXISy9ebODgtnao7km/WS8kbMJhvTfLKO+n8bIw5j10TRFcI0SorcJnvHc+x+CGjNKp2EpMzPasBiQU62ZYJ3KXeAvwp6OwYRwEKT1WMqMPZgCBI6NdHp8igZIe8gAc1wb/DEacWypcZ/GFCB33BWCYBcjy9q3Zr6o4/4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 01:20:46 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 01:20:46 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <kees@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 0/2] Add option for generating BTF types of global variables
Date: Thu,  6 Feb 2025 17:20:42 -0800
Message-ID: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5ba7d-5bf8-4abe-72eb-08dd4715a62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWUgtN3Zs4AcuSxSiQmjNngy87tSzOLXncZ0lI/oGiZL8FiRVC89ZOl4idXm?=
 =?us-ascii?Q?AFqIEoQQFj6jtwthP5jEo4zhZ1q02SIoR0toP1wZIrLlvm+ZMEEfRmAy3E+9?=
 =?us-ascii?Q?g5WL41RRUhVXyoUyfoxsaIN0EVG7n12Vwi0FyRTZZos047NmP/doc8gOII7n?=
 =?us-ascii?Q?pPY5SBtLRhwmv5jzPIzlSbMPzPxrIg7rMIdwJS5gyjrauLuHG8MRo+d/yQkr?=
 =?us-ascii?Q?gle8HYyLPf6d8ImsnB0qFJ8h3USpnebnGK42txi1mSqBM9Y/ef+9oq117IwU?=
 =?us-ascii?Q?Gbn/+4Bnf3IQyP619ICoebkF3zffYCx9zinlnTX1t41SovFzc6okEM7DCIsP?=
 =?us-ascii?Q?kDfB+jHe50Rgv7KeZUClbUh40Fa+PCy5oCxJq/+vfTa5cr3+4PDhTh0jWaJb?=
 =?us-ascii?Q?YfalltnQjg/MH+6kERdb0t5nlpm3CRhUC0s6zJQJsvAZ9eNyMMa90S371OYR?=
 =?us-ascii?Q?zOwltzbQY54BMgq6nVLIe8Zzp0IcJM353YHq7iIgbEOXxDDAzRInIcBIoOVQ?=
 =?us-ascii?Q?3ctLuJZcKaTfCKExTZa4K41uWyGuAbwS+d3PIL8n8HZuNfrLucNhJI3V5bZe?=
 =?us-ascii?Q?6Oeqq2ZqZhrBe6wycB+qjvEgktYjJ6T43PPwkxHMbBjjyoB+0FfRT+RP6pQW?=
 =?us-ascii?Q?73vPHPjXN1wLRxx6jNexi03RFDWIqig3Wd+6idJ3u4azNEcUn5dBds3j0jzW?=
 =?us-ascii?Q?F/VYU0ZLx+EKnhnbw5grxK/vXCDA+yYDLURTIlShrS6LyRZomNS9dUUuIJ0o?=
 =?us-ascii?Q?nycwOdhM9SF/xXXuaACn0feZfLLYCXPF03Y5t7TdyUiDQX59kLhVAdwRUgRX?=
 =?us-ascii?Q?DzntsY70EV4iz//PtcHcfkdPEsD9l27B0d+o8Eh6TIqEGUFNL64MIp+7fxqP?=
 =?us-ascii?Q?eIHgpbRrvx+Nrxm49Av/8vmc/H0UUneE0Vu1OSiAGoBk6PPkd9JW1ZNqcvQa?=
 =?us-ascii?Q?yTmx8DZGwxBrl8L3tez/raRueggE573sVMHPhVMlK12+s8WClHlpQT+qw+pO?=
 =?us-ascii?Q?liEmE/eyCZOtaxATwHzborl2e5U1214ju9YW4DVGCJzVKRQK0tUhCqOlbrQZ?=
 =?us-ascii?Q?+N5CRFc/YkspVu8Qkzr0RDTCV4+jfQrle/DkTsiSHVbWAD4bL85/vl9BeLxa?=
 =?us-ascii?Q?Z+eAgtCZl/td3qT8DzUzN0Qyjh+SKSAmGnmvUcVRZT6lcwlZPKLDL+E05PHp?=
 =?us-ascii?Q?gYk0cHNDwkqbsfkdbug10wPuDxYWY7w7d/scJgLfbfFAJ6qaqZMYZhxoxuAC?=
 =?us-ascii?Q?20IBI6VQOnk9++EGJZWtXmD5oIw/+B79po380pjowzlC3APL/7mPJCt/b7hl?=
 =?us-ascii?Q?UxGrzMTEBs89vAYi0EZM2aqiC74RAYjLrkUR1f6Ve0PHHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQ1AU3XDmvKj8xhbYgYJGmXGkrr0zNo1w5WTVBsztSKcmJ5KFIY3pCYwvCoD?=
 =?us-ascii?Q?EkjRl5BGsZIFsnw7abyjT+gPBRNxdjcxx4EBLp0eiKXZMYtwjUqnSm8nzBIs?=
 =?us-ascii?Q?Wy7Z/Ydf13ZtirrZpMJqKmomZxAAYvp9KEAYh4CWr+e1QtNfAo9IiuBt8NMm?=
 =?us-ascii?Q?RfWv8t1ZysjqLB7x0kRilHdkQ7Um26yWCczjBvJxicPURiNBSueeq3BeZKNG?=
 =?us-ascii?Q?lN79Pb3kyewGZWiDIACj1CguJsjvdj3TTTKooNgWpXEsZSCm5ScA9ws+e2p1?=
 =?us-ascii?Q?OiFu5y6LdcEgjMvt7dXZTTDzujTWz1cGazh213KkKvVuA8VXaATcKc0LOKHO?=
 =?us-ascii?Q?SOCNSlCqdiM0JgazKbXH28f/O1/G2903gc6oXzLEwOI7XTHQIjTfEl6wCIVK?=
 =?us-ascii?Q?7OiJRAJvo525cW5sSPwoKr6G+ENGqXbtflKhgQGCAu03sKz3styvl6r5h3YM?=
 =?us-ascii?Q?ZyS7qG9+XCXkeu+XnWaecA6m1oBynDpJPjelOkJnu9BGbEJS2h7t3AEF9dWE?=
 =?us-ascii?Q?kJURH8MfwZ1SvI2vypIvkGRrbZ4Ork6IxzWbVq4TCke9FpUUgEya8eZLwnmr?=
 =?us-ascii?Q?CKh4ER/XkKbPvkN6PkWw9fVCCwgUXv1pZoWH1zfuwF3/Gfaaomz9u55ZsizM?=
 =?us-ascii?Q?mnDSBE3CLJZneFJ8LXmXomEksRE4w4Uut987nmuR5guKXTDVwwlxO8JNoZUY?=
 =?us-ascii?Q?o/PW0QRB1mhn0wkbI75Hlfkk8gEgy0DxtP9BgeIAYoWpqoKAi6luYmaDBFPA?=
 =?us-ascii?Q?PlY73yE8L+EMB05oSXwvRYzLIMvD6LorQnvG/799sZEK0knRV1jZM3ZAVYHP?=
 =?us-ascii?Q?i0+JScTRiRQFv8iZRAtuuBBVitFA2GkNKlWvrVRT+vsR2T6essu0BxPXd0pW?=
 =?us-ascii?Q?sIxHbwTaLeS7s0AjNSeIpOXyh8yNUS+8bcY4v4u/zOEuIowZvdgWNtNJu1w9?=
 =?us-ascii?Q?oyVgEo3VxL+hOwJtK8m3AfLyJORAI6YT9CeuhbG2Es/4WKnoVGMbVQnHeN4D?=
 =?us-ascii?Q?+ZgOQAmZudpZeO48MbulJgr67r2tMpuAMdnoNXo1XvigdmhYXIPZQGNU085e?=
 =?us-ascii?Q?9Rlp3BGffFVAV6dc85oEWXDEBkDvfFCujDMzKXqp1BU+yuAdKUrTO2O7wo/P?=
 =?us-ascii?Q?gaIucSR7vNI/HEo7v2dyVK943nJRQzyLo9VttjRHr7X9pW+BdV5R1iUypw+a?=
 =?us-ascii?Q?KG2aO3PX0/w/v/wfW46zluaJiuTfUsU6pON6teC/G/d1iURQICCgIb8zRlF0?=
 =?us-ascii?Q?AhH9TyeyfWtplxrbD1P+LyNCM8POSpQ3z+8zajaKEMMnlkai52R76RG0QhU7?=
 =?us-ascii?Q?uhOKSuA0WS5QJiGYTkEAte+6euCP2uZvtspM0vXmgj6qCW7i937lYXL9W50f?=
 =?us-ascii?Q?K2scndaQesv+rAskIQfuf3C0e4WMW0cSQc/fPVGYjPV2AGPadc66o77eLgDL?=
 =?us-ascii?Q?qaPyIS2KlK9f8jcJXVmo9ifEmIf8y9O70zUqkfPCEoa5HfmQVx/sNdWxBLVW?=
 =?us-ascii?Q?6nAAG1+ETuWQPqPbbGziXgLuYUZpqJlqGhiVhxQZdsApsGVPTSa2iHwW2V0j?=
 =?us-ascii?Q?dvvxlgKvf83NLE2MK583ku70yWmtWB8KVw8yZQeLC70VtdCXJr3cjZFh/R84?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/k/aaLEGzDZuBT/k5WbAEafcZRQ3EimFIwvLlG5bRc2RsMik+hCbytgc0u0hnWU/a8SbD2EbjgmtWZ6dLVIqrgtwIQemrmFMuBuqO7/M5fJUSGkrsPixyaOW6bcVC/RMj0iIO0qcKHC09tw846C8NrMHjjRw2gPVcpQ+QLbmD2FFyrd9VkouPZWYNSgO2ssGdHavexv6mD/8MNtJWVzk14wHslkL+/f4zWrhGgefCdumvoneNk6XYxXuFN4lsTjb9b1u1YkfspzBjz2OqyfDvcP0pAQd56HslmyLBtCh8+OZ2aM8VT7kSvO5dSLeD/GAkHgVzMr0QVtjp2CFhSCJROBHPMkllnoNiv97c048VQ53hhhukP/iTNzGiWQGPtHO4BRSNbDtYkU8wYLQpmxg77B8mhs+hev/wf3jJgbZ108by+buig24SwjfUCrzt26LQ+teUh0XJTeqWhVy7lhnfy29SjDilR5nSwioiK3ZsmaCMSFjXCMWP3iRs6mGHuIqTSyD3MLt1DNm5Vwx3uzunbhk7ba8jYUVVXQAbI30vuGkEDnw0HvJzDLl/J8gqoDxUy6ef05uC4SZvaEozeTfTf/07YxKEjx5m3AI5xxcIr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5ba7d-5bf8-4abe-72eb-08dd4715a62a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 01:20:46.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQonEjQi/H1QK2nodlRGNhQkzqZ3x9WWK32chRvS8JIL+y1AkJ9H7wMyqOA5OnJMWYfzToCw7OZgHp6L5cNlFgjCPehdAoO/9HVYsozmLds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502070008
X-Proofpoint-ORIG-GUID: LpDIjldC_5wdt74Vw3Hymyedp6Qs5n3Y
X-Proofpoint-GUID: LpDIjldC_5wdt74Vw3Hymyedp6Qs5n3Y

Hello everyone,

These patches add the CONFIG_DEBUG_INFO_BTF_GLOBAL_VARS option, which instructs
pahole to include types of global variables. Pahole >= 1.28 is required. More
context for what this feature enables can be seen in patch 2, as well as the
series which introduced this feature to pahole [1].

To demonstrate the functionality, my "btf_2024" branch of drgn (the current
development branch for the BTF debugging feature, despite the name) can be used
as below to debug a running kernel with these patches enabled.

    git clone https://github.com/brenns10/drgn -b btf_2024
    cd drgn
    python setup.py build_ext -i
    sudo python -m drgn --no-default-symbols --btf -k

The "--no-default-symbols" ensures that drgn doesn't accidentially find & use
your DWARF debuginfo :)

The resulting debugging session supports a similar level of capability as drgn
with DWARF debuginfo: variable & function types are available, stack traces may
be unwound (using ORC), and the kallsyms symbol table is available. You can also
try various drgn "contrib" scripts which implement useful utilities. All of the
ones I could readily test are working with BTF, for example:

    sudo python -m drgn --no-default-symbols --btf -k contrib/slabinfo.py

[1] https://lore.kernel.org/all/20241002235253.487251-1-stephen.s.brennan@oracle.com/#t

Stephen Brennan (2):
  kallsyms: output rodata to ".kallsyms_rodata"
  btf: Add the option to include global variable types

 include/asm-generic/vmlinux.lds.h |  1 +
 lib/Kconfig.debug                 | 10 ++++++++++
 scripts/Makefile.btf              |  3 +++
 scripts/kallsyms.c                |  2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.43.5


