Return-Path: <linux-arch+bounces-8903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB29C0E91
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DFC1C21120
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F821B441;
	Thu,  7 Nov 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqNQqGAq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPvGv8nW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB221A71C;
	Thu,  7 Nov 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006575; cv=fail; b=VJF2Bq8jUjCWEFXUo/z4SFiFBv8OTvK2e32ZWYNzYYH6IogfWZUPIWiLqqdkleKRgY9SmjGrqLFxkDnGOde22GYXurXV9udjRT1UU0GZjWitRex88ALBeCt+0YkDi5Aa4XTnXeQeAaSeHJ6RoUkq/ppYW9X03l+1pgrU+JLoYEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006575; c=relaxed/simple;
	bh=Yyb1NPNDFQmIjFeFqIjoUZ3foLaSLksfAmQDnFnTm10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTYxDHulwFcFQzJVSOjRsAOyb0EEzenvnWXypyvhKAyA8dSffYKDdo/lcS+r3rIzIO3drc3f60423DZWKHWMhfxymPY/jpPOIQsk8b5X3LsmTjqEm+luNc+RCWfEJpOdqH6pA4rlOcbY6Cj4p4bamCgBO8k9C55MtwJtVJmMBik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gqNQqGAq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPvGv8nW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBaMF025221;
	Thu, 7 Nov 2024 19:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H/q7eDW/ZTZz/lYx9cMAlhBkSvRSCxOpz53k9yto33k=; b=
	gqNQqGAqt/CWQqJQrHRIQsR8WpHPMgup6OqdpcQ/E+S1lnEtI2bw2yIIimTHmP+U
	rdWZeyixBD3qfzfX+/BPpEh+1iamVjkg17vGa3sdxfWwrN61mlwfcgVOqZFTbIIF
	SCdi1yzjpWMLqQs2l4MN8Zu458fIg1EhzA3cijxvEXS9PNrmxmsAqSEzw8aRS/rm
	gBIO6PwDS5kFjWizTopG38VdpIjjeKOy6jmCzBjuQM0SfQjb9ra8DrKXTV3CxOBR
	m7IgHsxNgiyD25Bbcf/Gtz4doa+kmuEV+ibWPrQ5Zu0mPHb/q+iyl1HC5kfYUIyQ
	Y7LJvaUkkTUBY+jZATQ/qw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav2beda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HwLT0009736;
	Thu, 7 Nov 2024 19:08:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgt619-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru5VmeB1QXiwQ2l5Ms9NvUVnSyBITbafE9LrNplMygIdq5GRfTFeu2GVsurbKHBXnicbmVeXLijTGR1LbHJJIzf2XfPu6W+fKzTdg8SKmZqDiukHr+82BCBiXggICmJo+qJm3Uj6nQ3L2BmsgMXRARWp9RuW1YlWkAeI7NBYCNx9R9BGAq7mCpREf47M0yoqdnf8hp2TSWwcu/06o5a5vzjOUGtm57jO1EGoqUY7x6tApKnToUivhVwLHesWWbeSBRAhUWHwJjcsz4dB2VokoXxfGe/zdxdy6f1s0+nAElfStCj3LWIgI8c6Xfv2zlLHYosmGvK9DxMmnmjlURudkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/q7eDW/ZTZz/lYx9cMAlhBkSvRSCxOpz53k9yto33k=;
 b=J6zK5KDniGABtXlE/o2mSYoENzbRS4hb8RrYek2m+FDIEiSpAZUXxl7iL7f25Od/VyAYaZ8Uie4+RtN2zvxf/cL6tNBmteMn4QY0DjKY3yRZh8VwAZPNEXu1P2s0Sx9pPvB1IrVVhHUNJGBbH7IjCxSZL69Xsv5ENsunPdnHcg3EIgf3xQ2KCOCD5XNcjUHUl+TJU4CTa+3y+o2Sb8dIhjDfHhLKKD8QYs2/KO3MnV6l2dHrnT4O8+TG7vjG96AezHhkURdFn2iwWihhNqbynrCWzWDU55i/W7BCOaw8oXpXhASmaTlKSkKxIvGD5oulCnT1ABfTF9zFIDA8S1Axjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/q7eDW/ZTZz/lYx9cMAlhBkSvRSCxOpz53k9yto33k=;
 b=hPvGv8nWJ8KpqUuf3V0n6hTvpaepgjGSvcVkkWQUw5OOjPeFqwNmQuO6WbMg0HpPNCJkfQymGyxHjsBPxZUnD/JNr/H9rJmtKB/MdNXHmShLfGbDVu1SPfJOmhcebBlpM00om0rd4iaEoKFatap5sNvJwy+9p2o/nihIq0vHRww=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:42 +0000
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
Subject: [PATCH v9 08/15] ACPI: processor_idle: Support polling state for LPI
Date: Thu,  7 Nov 2024 11:08:11 -0800
Message-Id: <20241107190818.522639-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 6521b7d1-605f-4d09-4b6f-08dcff5f9858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Okli0EHdgFuCgTYIDNkzqSi4bYC9eHI3xBxNU1kyA94cfJqRkdF912aYIV7h?=
 =?us-ascii?Q?2ocJXtYzwvsIG1FntGi+TsZyP1qouTLvQ7KOEq9RbTD4kt1QUT0DQJfdoXc3?=
 =?us-ascii?Q?k6d8LVgugZWgPpW/Ct8DdQoq0sjvkvM7sto6gwCyMKdy4sVO8KJW176KU1j8?=
 =?us-ascii?Q?YFShyvdX8p4sGw/2xHb/vgF5LErQdeFXw5wHqWdekjV7quwEJ5Cy8IN4GJuj?=
 =?us-ascii?Q?VhD2KgJa7dJvGqahYfRhLvFvm1aqds68NxXL8xB/L5oKBVvlZIubR8RI2bAm?=
 =?us-ascii?Q?ozqxpzEDvAM1RKd0qWMlJfsY5EYm3xzkE8dykBxJmLIAgRlViQag/suP9uvf?=
 =?us-ascii?Q?mKqAMjWHLCuYEk8LcqXHhYCvJk0OJ2umv0tpDz2iBiWvYiFXYzD720pjTQTw?=
 =?us-ascii?Q?nl3qhiDyxhFWGYuxnV2A6xXcq313+KP53cUK/tOLDXqiMza8P1bLkCXuA5d/?=
 =?us-ascii?Q?zRxLp/djzXvld1CfODbhcndiK9t0m2dZess1JGUyK95OqQE/km3UgpHWw+GB?=
 =?us-ascii?Q?VHaIjMjR2OdqPopQgRMankUj5OYyG7lDGNKiuemtRIHSpGQQ1O4uj2MNGX61?=
 =?us-ascii?Q?hUdujBCPYMxMts2NqMtr4rErjh0hDXqg+LX9+KUT0fIYoL98CDZwMlvEz4Z8?=
 =?us-ascii?Q?TSfKWE/3VNGJFAqbsq/jrjqI+skhqNbyf7r9cqPgo6LQ4OSbaTCdQp/ITG6e?=
 =?us-ascii?Q?NIVqfMAfQQpec/ieSLNUu+ddFHBk8kfKEAJfhJ+9N7IppXuiuxXgn6nBeEN8?=
 =?us-ascii?Q?2pREGtFabSyKBuRb/D4lOvbZWqzyjrmziLNw8V5BRFWg1jgjk8XR4Qtt5aw9?=
 =?us-ascii?Q?c/MdNvQGt1pn9V62zeHad7vSoMm4cIwM7vHXKL3jmhJ5SGWYsS4H0UTrQmON?=
 =?us-ascii?Q?ud4eIQz8IZHxHe6vbxqDaRe2SbjCK7xik+6MMgKPjSbUUxiRLRRu5F8IuZQu?=
 =?us-ascii?Q?SCA7VRVLkfVVJSTxwLjycXYxs3HfKrZMPv9vkLGRP89GwGheJRq9hActK58V?=
 =?us-ascii?Q?2JgZaJyidc32BruNXjgvZCc+S44kOw17xPoMO6oNWYuLt4OPbr96iDdbNa+z?=
 =?us-ascii?Q?3aIdERHmaEXbOKuC79MB34oRsQp1jpv8/yGER0hPfi1xmSz8TmT/EOh6FfnU?=
 =?us-ascii?Q?Ii8sVyPz3WIbQjFcmsCEB7wJSUNhQdmKA5MgOsqRcbwCeQjc+88BUlzhvgvd?=
 =?us-ascii?Q?Yi/OM0zWh4ODfcU7wg039XsYYMbE3KGzrgpjC5bthYDxbvJ/uE/JCiwkJAPa?=
 =?us-ascii?Q?xILAExIHvaceTIpwavpMPsy50pHHyJmTHQEBtfE5uqEt3pDtkC48q4gZNpoK?=
 =?us-ascii?Q?H74pdRAt0j/qVpruvQgkvqz/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hK+gYJZhKt12RKxn9waiHd/dO/BUGDxTwqxozldiXpkRO1os1qNvOL5VMft?=
 =?us-ascii?Q?w7noeCYCav8DyH8UpUVQfjgt2JWC60D8NK5zDwWugx405afvGwax2w8HPSpW?=
 =?us-ascii?Q?3109mgw1mYu6AIEnD+P2jAE4R0z8Ap2jvL79Nf8MOsSo0uPrTGrEf52CwDuv?=
 =?us-ascii?Q?9aSKt/TgybZP0D63H7IFr2zkjVsadtdX7OHWeXIEYydk/UmHzAQOKUjG+9eF?=
 =?us-ascii?Q?J9goB2Pwvxz5D0qnH19xq3m8WwBRNGFQ8yTqLMjiJjIptgHbjJ7vvJzIOh0y?=
 =?us-ascii?Q?kReApSWdXdl7ObdbR5L7857W+VrT9W+35XMM65J250QXKkMqPv+ZSQfWlPeB?=
 =?us-ascii?Q?q3SJQ2auxgnsamvjgDXeiKPXNQt5wbBniIibPJRNsV7IqDB3Ukj8NKKPRGa4?=
 =?us-ascii?Q?HXJeQpC914go8Xd0s420TDLAYixUpZq8lT4It60CsV+hXIoaNaB/OXJ+IVs2?=
 =?us-ascii?Q?xuNTVmSJGP3E579iZi8hX78xtd7XUiBRQw9ByETEVPfIoA+LXF8wsfcBEeDN?=
 =?us-ascii?Q?nT/J75rnSlAyCoP6McNVvZ9SaGpZ8XtcZVPKUDuN8wzEoSxGfCWXaaWgiGQP?=
 =?us-ascii?Q?01H7S0KFYg3mwl9gRjn0UI1pGzID5e02KaiMG9FgYxNpkZxqCwCN1r+QryeQ?=
 =?us-ascii?Q?Q/P6G+p+OZ4WjKkoLiNQtzMM4mCfM/t90e8mz16k2c5pIK1SsGH2tf2H/3Df?=
 =?us-ascii?Q?umH0eY1YQzJvfJvBMStn0+I6o8N+n7UasCbCmA8mNUdo7ZSADxJWlubVcDpl?=
 =?us-ascii?Q?gGXm8I5EI/m84c4vDZMINORzdvOnvmHa7HVVfEK6UQrUfFZlnNvwtpoerIuM?=
 =?us-ascii?Q?I2Oj1q3WAknmeuih/xFvysZoL04Eqq1wF6UZ1c1F5UV/O/CP6XdMamSBnVZ8?=
 =?us-ascii?Q?IzC2HtErXSYKzJDyPh89doesBSC9SuUBLIF3Q+MEqIayNb5IEn1/4BwtC+lW?=
 =?us-ascii?Q?03uZkxxCVviHwohSTyYKiqc9zwMDpOaIV60iJtrOv/RC1mOqIH4qAUDujNNN?=
 =?us-ascii?Q?Xh1PnjEm+wygGBNzSfmYPENCXEMveMe7oiHbL5qBRAMwYqs4E8u7mEnPjkEe?=
 =?us-ascii?Q?vJg//aULX9mBBPoM6nH6QEvVG2Om/ML1o0MctnWscQ0gwsz7og/ymwFtExkb?=
 =?us-ascii?Q?zWxcPtezIe170PhnD5Eg9m8BE3Q2QG7W7vDQl9pmkB0oatLcWiuBjRP/6uiH?=
 =?us-ascii?Q?X76O4MMl599YzGvgkmxsmU5Udt0AGLCYZ6FATJzL0XLFUIL1S6de3V1HoZ4H?=
 =?us-ascii?Q?f0dJLEEfZPCfLxLWNYFpd1COhi9Iv2L8tlFajB5aWAA2BKiaH8wg4mtdF9TG?=
 =?us-ascii?Q?P9h3EXH9bbHZSIANcdfG+PujHdQYCASduTa6mFVPnqaNomvDLneNLq7K3jr2?=
 =?us-ascii?Q?30IXnlKFce2D8uxHtW1x/rf6MZ3Ck3G/pGKLUTmMBoJrftiiThf5gWoZkrZL?=
 =?us-ascii?Q?9DFPSurnCfDCF3MQVsAYRKUcVizQBehF42yJVVm9eiEZXo8yykad52yBlflC?=
 =?us-ascii?Q?wqsobux0uuphDDillb4uJNdgmWZ9NG40suKrZbKzilz4h3Ys+UWO9wOhZLwS?=
 =?us-ascii?Q?ZlcqB29TZ04bVSqTfOR4PSS0jNuSzAhkD6nGwPeBPa38Nb4oHJGHqXdB3KGR?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BZfo9BVFIqKOttCLcU/7w4SLlogvRdktllShf5AiPTNtnyNF8YwNVBFZxyzVEO+AZmpcvKsrvZ+lbJnQCTqE3CRaBTd02Oilq0S//dVZQTF3nkcenGtSnf+9KawmqwViQxbF9BJ62v6y45IIozYrJXJ7jnLkwWnRjA5BvHqbcaLzvfpqK7Nm8mP1BXL5lhQ3cLf2b0TC/vbNXEJi1DVMlw4fxpbZ82IndjO0/Ia3ZNaTLTypcML+xrId3RAiMPkJJ1W22/ITe6InB1xqbQsYwD6jm1hmtBhfkZcAwrByNTnjhzjvHZ5jP3z6ThrekR0JoU1Xr96fjuxID839mK1wP5XBzHBnJP0hONXG0QwmBqkK4yNq3s+n08o+yXh2fuB9xWmKkBWUrB0TzWGLuCh+1G5N5dah7jUQlUBG1OsY+Z18rYnuTUL76NMluo77xu7unZm7C8V3hsb/XQj/1iHJLb+PfUXlYmvcjh0AL4m6mqLuNYxMdgG0EdR/sLbtCH4J1qDWPF9NOkAAr6v+p/1Eif1lbnWkt7KFCrcUPkk0y6suobRtR5tCVtnjjKiiWG7lrUf04ryuZirq1dESek6DCtpMEGFcvzxkv18M8u+ZO/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6521b7d1-605f-4d09-4b6f-08dcff5f9858
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:42.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uycSn3V+2FW5WwAvGqWc65I4Yo1/aLhf71m+JxipN/UPqFNii6veaRydg1jdwpQpRyn0cl6ou5jJr5ADS99JrIw7fwmkXg1kYgBCNNF8LAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070150
X-Proofpoint-GUID: M7SmEWZiPkj0hDBLZYlG7S7Y98kPcCId
X-Proofpoint-ORIG-GUID: M7SmEWZiPkj0hDBLZYlG7S7Y98kPcCId

From: Lifeng Zheng <zhenglifeng1@huawei.com>

Initialize an optional polling state besides LPI states.

Wrap up a new enter method to correctly reflect the actual entered state
when the polling state is enabled.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/acpi/processor_idle.c | 39 ++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 44096406d65d..d154b5d77328 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1194,20 +1194,46 @@ static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
 	return -EINVAL;
 }
 
+/* To correctly reflect the entered state if the poll state is enabled. */
+static int acpi_idle_lpi_enter_with_poll_state(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index)
+{
+	int entered_state;
+
+	if (unlikely(index < 1))
+		return -EINVAL;
+
+	entered_state = acpi_idle_lpi_enter(dev, drv, index - 1);
+	if (entered_state < 0)
+		return entered_state;
+
+	return entered_state + 1;
+}
+
 static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 {
-	int i;
+	int i, count;
 	struct acpi_lpi_state *lpi;
 	struct cpuidle_state *state;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
+	typeof(state->enter) enter_method;
 
 	if (!pr->flags.has_lpi)
 		return -EOPNOTSUPP;
 
+	if (IS_ENABLED(CONFIG_ARCH_HAS_OPTIMIZED_POLL)) {
+		cpuidle_poll_state_init(drv);
+		count = 1;
+		enter_method = acpi_idle_lpi_enter_with_poll_state;
+	} else {
+		count = 0;
+		enter_method = acpi_idle_lpi_enter;
+	}
+
 	for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
 		lpi = &pr->power.lpi_states[i];
 
-		state = &drv->states[i];
+		state = &drv->states[count];
 		snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
 		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = lpi->wake_latency;
@@ -1215,11 +1241,14 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
-		state->enter = acpi_idle_lpi_enter;
-		drv->safe_state_index = i;
+		state->enter = enter_method;
+		drv->safe_state_index = count;
+		count++;
+		if (count == CPUIDLE_STATE_MAX)
+			break;
 	}
 
-	drv->state_count = i;
+	drv->state_count = count;
 
 	return 0;
 }
-- 
2.43.5


