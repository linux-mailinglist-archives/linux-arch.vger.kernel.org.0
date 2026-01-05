Return-Path: <linux-arch+bounces-15654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D4CF2EAB
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0ED3006ABB
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89E2F4A0C;
	Mon,  5 Jan 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eJvHN9Bt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vjy8lq0m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14582D6E73;
	Mon,  5 Jan 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607644; cv=fail; b=AzrP5O74TaWh9o6DrIRVsT4cxuXilGt9jPHqS7HZtWP8zcM3kC3wPnHmL2/sd3EPQEPop3cO5u5M+dx0dxbaHO2CjvcaKaJtrGl23h0cju+RAlIXzBdYYp5GXzToJmYfmiaZ8w7tHXnzj1q0CxpmtHmWRkzTP6lJqQIP9t4ZPpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607644; c=relaxed/simple;
	bh=7iTm7DsSHXseLKTAls/RHlM9gf/2K9WinTZrkZWusE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sn/9PueWQE1mj9NEPdO8UNtvAbhcpQavZGSzKSCZZL0Yi+wv/537etbp9vVg4QX3KKfqjS2LUExkrhL+6SxEtXTLw8I8qmzNzhF3e1O1Yb/E3gMCBGwZLT3MU/L7SMLrv1YL4s5fakDBlv/MePzuN+f6D3AypPOBcOboLltmu/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eJvHN9Bt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vjy8lq0m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Nd6ux157703;
	Mon, 5 Jan 2026 10:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=zVIxod1fik+BBKPF
	n6haOrsJi0NPDeH06AC7H3wBizA=; b=eJvHN9BtPCCrcS7gSYLbO2O/GHxQBff3
	3kFIBur0RwlIdDmCjVq2KYb0BRDYYVFJuICAJ5GzK6sV3dH53D8fmHhOIULZEQ+A
	vjjXmjml77iDcUaK57SZcmxpw5yUGE/Jd34PuSJwg4TdTYThIcCEZwSx49XAT2wy
	9Sz6cTwgOlsjQDKyM27yKgtBG/sxohh0B6V7MyrxeyZzhl80tW9mVz9NoIXpcWCX
	d1xu358vtrZaxXzdzWjjRu68TNZCU+yUum7p2RfI7LpgyDO/rMn/Yo2qT3utkD3c
	WKmmIIC7Hws4pROKHNMVwdwZRmHQGSB01pSdXtdxSoVq1NqH+64R1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37sgeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605A3SfM026793;
	Mon, 5 Jan 2026 10:06:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj6y34w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCxGcyuGf7I8sXq541bICKWpudv201hw6shD1jzxMgBcUDSTr/cloei/ePkM3d4pYNuPeNW3muaexX8kFxTtXfTUc9RKJ0tdGLk4pvXMMegSfGmuUzSpKCvg5hHBy80XHK3GXbfSUW3IBfUHPZFxFsXc8zKe85BNM+rSr/0q+190btA8OfWSvzkxZvVcWGSWrD9KIHegR04GWv6EJlng0IQ3sjZVEqaLG7HoavMgfXqNvylbut4Y5mh2kpFehtItBvWo/YrMFihkYA/XcY5i6TZwK7eELkWHkAFDCIGzJalFGu3YOu3mp8hYtfNaklJrYuhyGcJlQzJHDaTewy1Y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVIxod1fik+BBKPFn6haOrsJi0NPDeH06AC7H3wBizA=;
 b=qiFm/V/QsarHX4sCakmpF2gj3utdSdooWU86IHvFJDWg7+lrQfgN1WNJzE5gOgJiDWf13XVqALp/HQJZHyXER1/Wq0y0KwXd7wd8eyvEZKsHmdfJzWxoBKuuqGepBCSrczVzQi74nsNNE3d+gvgjeGfrLSJqXR3fGebsRH6TluACTo172o4KWqamqvLQwOT5HDA3joJD3xhebwbcAOiYKLONMEotn3Mccw30ghum/dGxxsxfXhZlHpFZV0GKVpyB+LLHB00KlfQQfWpuvooZWzmqOnIzld2ckfrJRnwagaYxiUPUYG5LZP2S3VOxwgU+TyZI2BaWjB4V4JArPAWvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVIxod1fik+BBKPFn6haOrsJi0NPDeH06AC7H3wBizA=;
 b=Vjy8lq0meNkC4KqZnwMgUqULkqsuTa8jzJLLbaB3uops04omuaKjAduihUqcOltNbXK/YRuZe4v354WIHsCHbYo/p1YQRtC0QkiLrK6L95ntN9/Qp5hvoDATxIVJkfPQJrRJRqmNud6Ka3eYlUsOwMlXUuXqmIQY8odL0s9vmbE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8076.namprd10.prod.outlook.com
 (2603:10b6:610:247::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:06:30 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:06:30 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/4] Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Mon,  5 Jan 2026 10:05:43 +0000
Message-ID: <20260105100547.287332-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0154.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::35) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: b94ae7db-ecca-44f1-7d02-08de4c421914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0G8vO08/XdEtUyJtz1HnZUWxkWxAX/Z0qlrmDrzG//PQbU5+NOXXxTouFpu?=
 =?us-ascii?Q?jjZiyWvZLYeyya9hE/nDWtve3b+4VqNDvNL94s8tOwf0cGq+8fpfvB9acRZv?=
 =?us-ascii?Q?IVXpnz1Vv5ei2nLicc9JwFNNN3bf9nnmf52dCdY7yX03+tsJkdGIsjtgfsLN?=
 =?us-ascii?Q?Xf8ZuJIzi2Cxq7wJmdWsbvPUC74jh8KEgTddGXiyoOuat8Qa7Edo4FkouzwN?=
 =?us-ascii?Q?+oR5KuPsV0LNSMeHALlHq+AnQtI9sH/KP2mJYXY2Pt5r4bUIEmv9J1dHiP/c?=
 =?us-ascii?Q?9lLZozCv0QPU8D1FzSm/zzG0gyeHqGSs3gGxXWKHqd8sWGVRHr62ugYZeSJJ?=
 =?us-ascii?Q?rg9Csl3Hub0e3qb5x/RmVJTzUsGZFqZ+m4ftVaZyw2bTk/daVf5Xg3RIwTFn?=
 =?us-ascii?Q?pcN3rYalWuXI8kHAVxqH6cCwd/uj1ndAN/OhHJfDvx71AFJiWwpa3rPxhxns?=
 =?us-ascii?Q?0eOgFfEGksbFvSfLSpAJEOrZSEWjNMD+qIDBKiVGVwlFHm9H+977sRbWV9vX?=
 =?us-ascii?Q?6j6QlHTo6LRZJnhNTgd35W6y7plBsAMGKRDx7dtL1hMJaaQKSQyWmyElJfQc?=
 =?us-ascii?Q?AGPB6fWesNw2l0U6VEj6ObvvlsSUVDMttSFZwE3qf4G23HqkL0e8za/ehYMb?=
 =?us-ascii?Q?cYr5a6W34m8fFBFQTj14t7urcagd5Q/2obTRB8U35Xa9/Pzuk80FzCTVO1mu?=
 =?us-ascii?Q?wQn41V4PrSMY9G/9ab3lKxJluYfw1jHiouptV6lBlgI+Xfs/bN4mJQ+69Rqs?=
 =?us-ascii?Q?3nH00MtUjXCBdVaNIFaTXvpzSPsb8+9/nu4E6yfqREAjueeLkt+Orf/xmyse?=
 =?us-ascii?Q?5FCMKz31UNVwEGtI0v/BM9S4V1tv28E6f0GxfHm9gmy52Y2oKAFHiVgNleLq?=
 =?us-ascii?Q?7T1ps0cIeezHfSbtye6THWKiTsEhTc3Lk2hwg+7lo5cdD/nsoe73xd/VMYeQ?=
 =?us-ascii?Q?wmsCFuQYHF/d7/t0abTxoyfJ7GEA2UozG7xS8m66uUnUT58VBt0kdwsJUDzv?=
 =?us-ascii?Q?5wzN+gzgSsiF3OfYVyOUXgS/7HBPe+aJdnuEmjOmZ4Ot5LgnNySJPXPGXuAO?=
 =?us-ascii?Q?hojws2cxglHcX0Q8+8phAotXiKfw/mRUHn5WflnSND9C3wXyxuomzmSnmQKn?=
 =?us-ascii?Q?NyMqF0xVzQA3mqUotASUF7RT9k+XaViPttNyQlaUKxPfmRTahPg7c+k17Qc/?=
 =?us-ascii?Q?YC7PFvuPO38Y72jgVktP5y/6oWrR/Ls32cy83tmycjCJp7XGJNBxh9m+qge/?=
 =?us-ascii?Q?QDzXjiNyvfkrRUxDOZ7lHWJTFiXXL6irE9dw3eaX4jX8Dveqs4MuXfnk7C0x?=
 =?us-ascii?Q?2Dp6pmyRmhBlL3fHv9wL0xMWH4H55m9Fjn3evQJgrKF9o/291nVxhRRcaK3S?=
 =?us-ascii?Q?mObzq3e6STLkG6HUnSLDbEchwWK5JfrEIuNNjgHbCDyynxnpo/G20wDHhdCb?=
 =?us-ascii?Q?dZvXB1T0B0w+YLfwcuaOrrWXC0IF2y+yHnqLDdttrzjl4SZ5oV7dgffpfFFL?=
 =?us-ascii?Q?5gLrYme/Kf3LbXdRrEpdaMf1WbUM9RSnyKJU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fmhww603hONUjc3QZSAFy5tVC5ZRlR5E91NQFBPrO0oGlmsd3RvTWqcjgHl9?=
 =?us-ascii?Q?for6vFTR9c8SIMSUfHkyZfiLzoBXxtBayjt3OUmNwG0Bp/ZN0T89WR9MFiWC?=
 =?us-ascii?Q?dsqwmjQxdecJgitCtJK4NAXs/Dn35V5lebGugigL3Q9YdIyLwe9Dce7R9mrf?=
 =?us-ascii?Q?WZKs3tHLK3YkLDP0iY1UDEVs3fTNsfrXU6zNVydQxu6ngcMTVRZ4ozY38akr?=
 =?us-ascii?Q?wJF8po66K8/0qWP9oq8BSNu01gULMmc1SfxY1Ba20gG2FSbrnp2Rlb6J0Xib?=
 =?us-ascii?Q?auiEtleVdQFHhciYR3yM4N2HAtE+XJV4hPrxOgB2rjneJpPYazc6Jce96BJW?=
 =?us-ascii?Q?8cRKyH/yiDgoZrbwXy1+EbTTaZIh4fKE1VOkTUxdFTloS3vWWqFIhiC7F2M7?=
 =?us-ascii?Q?jd5i55e2D/3MrsgAOmlTY8TMUJCLsTdZxuAvVzQp1Xjzgeza8+HDO3bBXsV+?=
 =?us-ascii?Q?S3VvA6CRD2BxwqrIyTuGSJTuH9IS/XA+5SePTV76yZC4W/EZ0TrIfcaaXjCA?=
 =?us-ascii?Q?O05KOXS1vKGHERo8OoQXWMXgs0PI5N7Tc5e53r/+A3h6BwN0ivw/OYr08zlK?=
 =?us-ascii?Q?B6LsSLVvrMoIumdVJkxvdDpQa0ofVxDo2wukVqVHSggILdumjYqyL9SVpcrh?=
 =?us-ascii?Q?3gDg/QFkqYGgtdQbA9/6Z90Ap9XIZfIEK5bEX44XhVt1egfSTIVZJ8s+8MrR?=
 =?us-ascii?Q?p58GQ53RB5A80l4lFivB65+rIK+wcMNrBEnF7Iv3d9V6jbjFigFZU9dTM+2L?=
 =?us-ascii?Q?mps88uUW0q3eagDGYB7795+mNRCcH/H7A5fgVB/hevIYXnH5+kGsq7dxmv18?=
 =?us-ascii?Q?+U0wMV7CU15M4cqwoQcPDSJ0rE/quZI5cQSSnb2HBL5Vf12XrGCCLJNKBWto?=
 =?us-ascii?Q?24qa4/2ipcvNcd0Ld8lbh+8kP3nLuHTtUb2ZgFn9W40BxqWtN1wHWYKWtiCN?=
 =?us-ascii?Q?7S5oIuZi/MmZmPBF0/o1HVs5S7/6Ru0yKllVAFNqbmksNHNqWEpuYfwh5+PE?=
 =?us-ascii?Q?gYGf5ShBJqhKvjEcGSlcBMMkYMkTkBXVw4VD8JtE0EAixhNuPEqDIz+hxH44?=
 =?us-ascii?Q?sRQTDufYHY2YeaIbKhhvheeFUSKATa6z4IGPREs8nziC1b1yEisLOfreX5UR?=
 =?us-ascii?Q?RCQnyIG9Iey16LTjCWriPCx9SwpEcaX/3S+2VkxqmbVot3kce/0RGksvvp/F?=
 =?us-ascii?Q?HvIlbp7H4SzJ9pq8xZK8IkH/inZWoiSXAgN5TMwQCXprfQ19ptql6t7n4OfI?=
 =?us-ascii?Q?Bql8vqOmbgAnAPQePfIDZG32K0cSWiJJ+RXlhdamw/M1KyUYv8mVvsLrGnFw?=
 =?us-ascii?Q?lGy83z/gXPgb1Xl4WPNmH9lrj7l9qQQZAnWFky0D8bcWhpmTfJ3c6rQS/1gJ?=
 =?us-ascii?Q?itfmLLw0iLESe8QolF/Zfo/9kSaQtYOeh7rm8NSlbflUIAg3vfE2dZV4bm/P?=
 =?us-ascii?Q?fQ4TgXqtAuFbvawhPW443kU1dZRFjJrl/ajy7wK/GHYzlUEvyZj7FcOuuTzg?=
 =?us-ascii?Q?MhQALuNNO8f4zqeJ4QUlaH5stYstODdUm6AES7n4z5dyyglijSMY3XETKIOJ?=
 =?us-ascii?Q?lHQEWSUjZy5ddER0XmKsPlibvbr3MSW4KEw4D6cmvW7ws4zsMhotdcnNMlOe?=
 =?us-ascii?Q?L98zChcDYgKBil3N9jCeCZUh6FMCRxt6ADKSAI5lxI62qnFkkviTcmQ3Mr58?=
 =?us-ascii?Q?9kTu+mIsAsxwG0tO/tGWQbj+BrhSbhlEwUkiJ9bdgg/fdMGU5/NAw0IdAjQM?=
 =?us-ascii?Q?MYjbQT8dHQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V1gVTvvPucHdImzYIy3WAIuaRlawmFPeH3Dgglusfy1ZlJNF3EWGdynWT5727cig96XyYa8e6LoUKCfLcj18w1xZnqyJJeGIquewRpAYwpjdMqSWoJHsa5plNlvwvORmQOc3IDAK6y7Sht6CvgJsh05/WEsKXhkH9YOLYgXS8zJlZ6yCR60Invift4eO0HeDAX2MUUS0ktelGSUdn3wG+JXclOa51Ug8NVv4Mm8crXsjWDYXmeyhQ9i0xRJ07IqMsdwRj39oY8F4L8Kzoxspm0Q/SmbX+Xc91voQveD2lpW8kys1wnZzLZnF25Q8F5cNJHecUCW5MlMouJhjJZF65OL+uENqkxcWmu/utEln8S2PXxtS3+WGt4VQYaWjyfJNEGuROlCELpb1G2APlGIBkS3IkXkhRD5CPEA97mgW/DO/Jxv0lT/6hhMVwSZV2J/s9my8Pa65QZkyBmouu4/7w+PRAbSyB43+s4pERf1FXWIosjpEdiR796E7r/2ETbhAX+QHfOGfvta8jldtMlTPEZjyQU9iu9i558Ff0/Q/ZP91hF45X4R8zEDKCVJ0+cxgvKnt93L9cwE49uHh/yiuwH9LgUudxr789JGzFP5BEPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94ae7db-ecca-44f1-7d02-08de4c421914
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:06:30.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxQ1e2m7vk8cIx8dnEviI/0HhrbPJGbBI2yHaITjQUrLr+mNOzUZzzHL745tkJBwP2psG03ExnkUJEX/ViQHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4OSBTYWx0ZWRfX3lYJm0yRCvut
 d+OnPf1vAllxhLt0jPzMMqkgUbrZim3epox9O66c8Yljd3Fo/8ArC+HDMl/699AT4o1uIfLpIvA
 U5bhLPfcDEukQDkA7zN6Ulnr8IJmqAw/74QLE24Yemj97I5wHp6/Y7uzpV0kY8C6hY+2wxycUNt
 W+EwrBNealWe4aohel0/v2i+dYBnnRUjZZopoF8BZoQq4h1Y7BStuq5v8Hje+d3hZPgfSuVmVJ9
 jjPrWgost2odGFMBZ/T7NFDQul67EsxHtIneTJDZoK+hh/HFR38HtuWIO4bCvyV9MRmVQ3Yd2nH
 7S3//GU2coPl5jf7hyKFKrlRCgrXcvI1kvI7ovqLo/6bAdI4QUv1KMxVdS3/vXjn/GlaaHjgG46
 /4QnVSzRYN60UDYElYf8wu6lY1Kv6kSNDVfgLPhb09/M8cGzMA6I34NtJ7SA08fTZmtz/r+MUQ6
 aCMez6ezvKIj2/kmdkA==
X-Proofpoint-GUID: yFLcoaDmnuj9tpxcAA6LdFC8tzC9LLiz
X-Proofpoint-ORIG-GUID: yFLcoaDmnuj9tpxcAA6LdFC8tzC9LLiz
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695b8d2a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=PYnjg3YJAAAA:8 a=eZ1SEBxhpaY0cYSqAbIA:9

This series aims to remedy an issue that not all per-arch versions of
cpumask_of_node() are robust against NUMA_NO_NODE.

In my view, cpumask_of_node() should be able to handle NUMA_NO_NODE. This
is because NUMA_NO_NODE is a valid index from the following flow, where
the device NUMA node is not set (from default):

device_initialize(dev)
	set_dev_node(dev, NUMA_NO_NODE);

mask = cpumask_of_node(dev_to_node(dev));

The CONFIG_DEBUG_PER_CPU_MAPS=n x86 version cpumask_of_node() would
produce an array out-of-index issue (when passed NUMA_NO_NODE), which I
think is attempted to be worked around here:
https://lore.kernel.org/linux-scsi/cf0f9085-6c87-4dd5-9114-925723e68495@oracle.com/T/#mdedb68052e419b4bfca9ce45bb33b58988018945

I also see a CVE which also looks related:
https://nvd.nist.gov/vuln/detail/cve-2024-39277

Each per-arch version could be picked up separately, as can the
asm-generic change.

John Garry (4):
  include/asm-generic/topology.h: Remove unused definition of
    cpumask_of_node()
  LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
  MIPS: Loongson: Make cpumask_of_node() robust against NUMA_NO_NODE
  x86/cpu/topology: Make cpumask_of_node() robust against NUMA_NO_NODE

 arch/loongarch/include/asm/topology.h            | 4 +++-
 arch/mips/include/asm/mach-loongson64/topology.h | 4 +++-
 arch/x86/include/asm/topology.h                  | 2 ++
 arch/x86/mm/numa.c                               | 2 ++
 include/asm-generic/topology.h                   | 8 ++------
 5 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.43.5


