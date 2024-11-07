Return-Path: <linux-arch+bounces-8893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F249C0E67
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93401C20CF3
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B692178E5;
	Thu,  7 Nov 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZL9Fo+y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eiAB0pCg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B0215033;
	Thu,  7 Nov 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006560; cv=fail; b=dUHBn2+1WJRbDX5G7122xpspITBbAEVhBEfNMjGVQU/9AftPGhiTjBplTj33jxZkGR/xUk5PR3VAExauLnxrGw33GJ5+47mbeGTiiH4BmHicb9Ml5FFCghj2tXo38852GReTv6uY8MNPOSoG8n/8T61YOL+h95mLcSlifms/doI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006560; c=relaxed/simple;
	bh=PwVyUlZdbIDBF1/bUbXmwuOydrkBDC/BFxP00H3+CzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSmUM96+0o2yiSK5JK8lk3rM9YKtMziImOlm1udnRRXv6xHknJEAwN+uETJfyCdlhcV/1i88vbdemTpo+BaYama6982fSzMqqdvsZsOt5mKH0or2X16pHJjee95OhpiqGTBgIXRfk9mkXE03oxrhLY0GdXxzS2JcrL6jb37ISDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZL9Fo+y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eiAB0pCg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBgId004757;
	Thu, 7 Nov 2024 19:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B6fLm9OqSkSyvw9TBx1v5GU+/szIZK9hzT9YLCixq4A=; b=
	ZZL9Fo+y/YCoZ/j4OwPmLqj6uMsaVW5oBJcabiIyifEi/tHcoJuoJCT4lmqTZtTZ
	3occdQ1ijW5+fH6FZ0ZUwXb6NjXsobM+EIJTuXJ6EX2DVvDXMqzBtYObON/duvN0
	CfNYO+St11386qvNtIMY8Zl3FatPX2lVuLMuaQQp4YpgD0gOxtSE+x93qEStvzWI
	mNj34pN9JmPfFfkrFJZA2+TiYC0BzV1sdcEKZMy7FTuTVetHx6gKp3ubC231WCXc
	BbDGNsE+if1JIYSC2x/Es9DA+9ArwGeQn0D0Xq6YuquDhQMsk+88sBmGVwiRMT2e
	uUJZS8fHEJ/1VGw0dceTAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap03d7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ivawg031517;
	Thu, 7 Nov 2024 19:08:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6cbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFMoF2hv8vhw9VEhzAu1MvxxUTEKCOHmlHotI6M/2s0L46HAr6fsekCdfZo/pCGUaf3v4ckMtLcPqXjZ/Xhn7549RcIFlpCtux2+eGnobUV4j2TdggiZGNnKbgqRtHeTbjUsGXc9ZwYun4SvAp1zdCa670pdjyTut/dca7HfpaZMf714SwsmlVLw8p9xUqEnDelvxWQ5dVkEHNKrLwZZpAgrIpq6Zpy//oNf4LJ68/RMwf6xuD3trXYzZYwLLlSxw1pwIbctmDXlf1f+2H8QC7/GugN3lobFGK7db+MBsqS0mRpmSzaK3lWAU7lnoXlI+bMeDxP1//01OOn0nUL+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6fLm9OqSkSyvw9TBx1v5GU+/szIZK9hzT9YLCixq4A=;
 b=OZ9aQTskzYjUGIS5HWQJq0onngmrnpDzoeZ6V/3AGvD6pwgZxmnjq888bgFujP1tgzs3PeaStpF9c5eP/5uOHslLmMGgav4Tx0xoSCH2X10uWW3h3pn0IEww70rHcIs2cv5sW09qL5YTQuU7eFLToxHnNEpDnzWwgPdcEPdUaCk/DuFAVfD7AD/ZVvik57HC0tNbGq0jMQuSJeUFQEARrzov9vQsOfwg6upp6xZnxYXaOzIqJzQ08m0o49TtX1NnONmDGWbQTT5ZFctK43fJB975pCHWSIMUpb1gqBnRutPyq0XnNmICUiLXM1IeHCLQjibkm7T6GYB15e5bUHyPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6fLm9OqSkSyvw9TBx1v5GU+/szIZK9hzT9YLCixq4A=;
 b=eiAB0pCg5NpZZ3i0fF6j2JAXI6yV5YM2gCfiutNqnCPJPN/MfzgqGpdjn7siPbnJvsi9FexqcGgAEIUEMhXko7TTSNDni3VEDjAbWqbcARNTw8i3mreslyfR22a+z9Hetu72g3IdihbgMAMznoyKahyWnCGgcCSV483QQsdrf8E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:29 +0000
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
Subject: [PATCH v9 03/15] cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL
Date: Thu,  7 Nov 2024 11:08:06 -0800
Message-Id: <20241107190818.522639-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: d10348a3-4941-4d8b-4751-08dcff5f908c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MS+3T1y7OBib6UMi6vYmV9jZsQENBacWVrB75YeEr7Xs1emR3GWgGere0TM?=
 =?us-ascii?Q?IIEHC6vNawlAdfTK7ilZr20DBYQMeZ7hdalzL2dNvghLnlSg8F+IBGtIYvS7?=
 =?us-ascii?Q?1AXNcO4DN9K+Cz26rG2jARXnAsOTnJiAMzXkIws6EykDperziKZtSD+xF6UP?=
 =?us-ascii?Q?udKx0W6adpwvXMOHfxHi7Y5nHjVJQjPhqvh9+iGabl/30ckxVAtmJzDngDws?=
 =?us-ascii?Q?bAhhrCCZ0XV2geDu4MzkQaVeZbieX0CAJZRrJDJ8xeJGO3uufp16Ci3pyiPv?=
 =?us-ascii?Q?h4pOcOc+ghQn3TggGkZAkqXhrD/7H3k/bTo8BHvVjjLe5+2Mr90ZSpARE9ku?=
 =?us-ascii?Q?buAnCF9TeVwxJ3IYZQLQ+wbbozMSYu52hGhs54PUn0EAJHnWJOeQlXM8M+22?=
 =?us-ascii?Q?OA3B7fxm3tyqkEkgS8sjluv0bFTUMaLgSq6rlqp8/b4QVS3S7QrHt1YXrnnZ?=
 =?us-ascii?Q?JSMBnOuWpfttQ1hN4PjEhpEaY77lqSOmvyZismVOzn/KgKVL3FNtBIEcafVb?=
 =?us-ascii?Q?uDqJtJcS5ok/1wpVAUn/joSMv8NPQdS7hRwlJAWqY+8NK61A4m2y2AWvwysq?=
 =?us-ascii?Q?C8a2HgYln3DK2pb6GA/l+Fk5xE8P+oqymxFrUlaFJ9vcmn9uKVPC3Tl5D+fx?=
 =?us-ascii?Q?qNUz/w9YbXjA7PMKw74nggDbRFJBxHD6OCZV3cFZeD77qVVuOrFmhrNdSTJc?=
 =?us-ascii?Q?AigG5ovbwhjW4dlswOhtpciT5njrErsqcxEeIyxLDsGPzZUPbpKSJkkWo1Hx?=
 =?us-ascii?Q?d3ZXPCS1FI27aldT/VIGfn0y2t8XMhZbJ2poy7at2aOFLbdluAN34/Dm8o3C?=
 =?us-ascii?Q?5oBcJcBY0xiDCbeFIH5ZMrsVl+TFTFTKkZ2WEFIXgO57FXMNjImsjHyUEMW2?=
 =?us-ascii?Q?6Ia8b8oqE4FcAv1Kti2xf477qmQS/n7joG45VGcgshR4RLRsHN6ikjP0HhvI?=
 =?us-ascii?Q?sCUfkWtOlZTXpIzgdRc+wasofVq18VOnWKLD+Yd0N6txJWqim+tnpYt3b7G4?=
 =?us-ascii?Q?QCwj4/tyh+OwvyFbFkG1/a7Qvi/bK5jcJAS/RS5/MId5vKoujz6fJzsdKHU6?=
 =?us-ascii?Q?so/FPAPYbRYMQlaCcL2JjY4ebyq9yfwBMZrrG4IpRshZujd348z5bUJcT+Et?=
 =?us-ascii?Q?cefu0XpNA2Um7ae16i3Mc1VbbstBBLKCXECYnEEtpbtqrRZpHP4nL3sfqgXY?=
 =?us-ascii?Q?PkPo/bwjxUPfjDUuCS9x93LVod0j6qzrhYQ9iefnqkuea2jtliQt81N20pwA?=
 =?us-ascii?Q?enniMHVy1/SiNvnfROHFEBkysWMw+JXZ7zI8gT8SSboQCaNsPnO4VPoTTW21?=
 =?us-ascii?Q?O+BfAXKdra8I2f3a7VQ8NO5y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5xfwZnYZP65GigmSqa+A6kOkapMSk3PI4i0ePQN/KdpcJk0wJliwHAJdBzf?=
 =?us-ascii?Q?z0DKv/t3c5OwA9YwihEn5z9kTpX+wfR4wpmhxt8WKMBG1sdmm1N61Aw7jowM?=
 =?us-ascii?Q?VHvKqSUq1V3iGXEEWmrGTpYt+b2dErkp/nLRqRPMfrT6Ib0289KD5MyK0ZKa?=
 =?us-ascii?Q?d6vjmhQ0I/R5J+9i5iz3wHl/TgzlMZL6bikJigrAnjyIIfvzJir0yxENW1vJ?=
 =?us-ascii?Q?NoALRMV34CaGdUdnJnTKmgV61ILFEKW43rrC5/d6knCRKbu+SwRf/91mMaTs?=
 =?us-ascii?Q?zsHY5G1e0l+DlrgQh+b5n53XHpfCObe7KuS8GiIXn56zuh1mPmDTWBXxxDEr?=
 =?us-ascii?Q?gBhhl7xu00BEYVMyu9Hfod6jBAAathMSJSEIhB9aAEHltKx9TUKXU7pvIP4i?=
 =?us-ascii?Q?LzHg2eajikSpZ9QNPHtS/9MTXTAwgzFUr5iI9E2VRYO/JNO3WC5XqdgZUhIG?=
 =?us-ascii?Q?R+HARX24CAHd5SXHLR3pYQ6hKFGRIRjVWH9nVnTHy9ei90OVuWgSmG6/+qHF?=
 =?us-ascii?Q?WWG4TTE+O26Rqt0VC8YN5RrrYs5I2mMlwJ1dp1UG8dEcvzReXEZ905QVeMGn?=
 =?us-ascii?Q?zYPBMv7W8GrKWDQ+3/6gDVdYZ6fW7CezwfAtp6RDFIyoTK38J/NPuGLt/MlO?=
 =?us-ascii?Q?x6tZiUuiE5npZoVUIt8mGNq7g5ljWGvoe5yB6l6IfWvp/IE+OlMq/ONcns1w?=
 =?us-ascii?Q?XqzEp3VgKyU2exY+5KscYTHWcr5vNUAvcOYO5gx+57ZsN5442qQCKI4Pm2az?=
 =?us-ascii?Q?sEpr2myFZkCQE+QZqVKpeiDzQ25wuEYuVJcrUUijh4+Bqvo/11IPnz3i+Xmb?=
 =?us-ascii?Q?vBtSHzDpZ2K7Td0BAWGEEVRNkTGJh7MZUsJUEKEEKmHgu6RNriNu+8C39Z9J?=
 =?us-ascii?Q?+axqxN+mvUec+lKQPBCxnf1HLCgm+PsuLupGiBN3/bVySBV/v5QVFyX0oDko?=
 =?us-ascii?Q?Vxf+vrqY2YW53NtNkae49Ddw7tM+P6c0FdH+wfn1qCAUyP//a149+moGHuaD?=
 =?us-ascii?Q?DLESy6IBoouM3KaCE0ZJGYY0SdBZP6IkqxTJP/GxqMNoJqJGeykrGZ+9B1Ty?=
 =?us-ascii?Q?8KoJjJXO25rnNMW5AHz9DgdtwI9jeHjsMZNnNmog9ddmFRr+yVLu3QoG/fek?=
 =?us-ascii?Q?27PAMID55sYuOcZQRBkrXvFzxCq+UrcGUHY4jYlhN0wdcbIIQE+Xm3krhCEo?=
 =?us-ascii?Q?/6k9rn1JoV5Y1qWyT0Pl6MIqfR6Rh9KzXMJJYiFUmumep2TUPV4a0+50FJD0?=
 =?us-ascii?Q?OT6O6xFTiiC1s7SqqJOz0zuW3QoQBx3f+l4YHi0hwgjSaNlueozGfyeKOnoH?=
 =?us-ascii?Q?lBw8UKEoAqVT/mJxVxof41rgaze0nLe9s00u99ADcdKF1WdfiIRcFvnnXS8g?=
 =?us-ascii?Q?u8yv004KFTRcVPQCG04XhBwTNS2CZseaCtOSZXtZH4M/QW2k79vxjJPxpolY?=
 =?us-ascii?Q?a6QAZvm00AZUc23qwT69HJf5zcl7D3yJuMLSnwlslMS1JpiW3+Li+7ocCuPv?=
 =?us-ascii?Q?16N6V0eY2oF8dKJwmKDTRJmradR2UqQOKBQ5JHIqQ0oloZSdAyqZWinwvBJO?=
 =?us-ascii?Q?gNhFyXI3vwSU65HVrxT9L8w1PtY3c20kv1XtQUaz9u4mNQLZvuudvAR5Rt3v?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QAoTSH45JQZUMFZ0GaUDB/YHU7rPzDArTYa3SzhNprk8PgwVYUfTaiII6jZ8dhiUMOCNnZS35zE/9PzbJYtpaiOOE7307XZB7m9y3H9GuviW5wVIu1GM8S5yBLiWULuhxtw1Q8F9l2HZjyBHjfeOsyazGJmO9pW7kqgQxVa6c5/DlncbFU2FHtZDar3bWgO5ex5lUlysRSRa1n944b5NrCrkxzCJzZ8a6pPOJTsv1XqKlD2jyJ8B0+t7TI0AKb+5iuMtiSPa9Ss95fYUhNITCZUeYM6/bmwTi/OotuVB0v8nfAs6qQ+7DBxkqDlIrHDpoTfvZCAnYe0Rs3MDjXCQTGz/Pi+fhx/QuTa+y1pF64rvYw93Vi3ggKlCEp4lzvMFv+n4uvdX3d0EDHLb1P3fOdSTBWJ/i95uv6OlV+64snnQeMuVh/ZiN2+KiFnPhyt7hMNBin1Lnyw7M0KYyOO2BMBi6EB4uqXYUkFlBEf5+i12ZrV4/Pwachx0PrJfbvUuCP1fFSI9ntT+zr2V6Bv9DSYr7GPPwEoz3jiy7Apy9+XPh4KkP8AkP08Ix7F1TaY0M4mEReWOuAoNJwSzLqRObv1w96hZSjO/JxexAxT9SNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10348a3-4941-4d8b-4751-08dcff5f908c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:29.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAgJI52or50C/025PDhNpMrwka2b5uKHpatSoq+3Uv38hWn8A1KSiRMDpM349pC4cgaQnVqnB8EnqILw66WVyOUZzW6SM32NV5zbh7Kt4iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: 9ej_sRjuyeQsq4-bgCB1cu4XLkKaJPGU
X-Proofpoint-GUID: 9ej_sRjuyeQsq4-bgCB1cu4XLkKaJPGU

ARCH_HAS_CPU_RELAX is defined on architectures that provide an
primitive (via cpu_relax()) that can be used as part of a polling
mechanism -- one that would be cheaper than spinning in a tight
loop.

However, recent changes in poll_idle() mean that a higher level
primitive -- smp_cond_load_relaxed() is used for polling. This would
in-turn use cpu_relax() or an architecture specific implementation.
On ARM64 in particular this turns into a WFE which waits on a store
to a cacheline instead of a busy poll.

Accordingly condition the polling drivers on ARCH_HAS_OPTIMIZED_POLL
instead of ARCH_HAS_CPU_RELAX. While at it, make both intel-idle
and cpuidle-haltpoll explicitly depend on ARCH_HAS_CPU_RELAX.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig              | 2 +-
 drivers/acpi/processor_idle.c | 4 ++--
 drivers/cpuidle/Kconfig       | 2 +-
 drivers/cpuidle/Makefile      | 2 +-
 drivers/idle/Kconfig          | 1 +
 include/linux/cpuidle.h       | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16354dfa6d96..3fa741dc0445 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -378,7 +378,7 @@ config ARCH_MAY_HAVE_PC_FDC
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
-config ARCH_HAS_CPU_RELAX
+config ARCH_HAS_OPTIMIZED_POLL
 	def_bool y
 
 config ARCH_HIBERNATION_POSSIBLE
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 831fa4a12159..44096406d65d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -35,7 +35,7 @@
 #include <asm/cpu.h>
 #endif
 
-#define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
+#define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_OPTIMIZED_POLL) ? 1 : 0)
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0400);
@@ -782,7 +782,7 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 	if (max_cstate == 0)
 		max_cstate = 1;
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX)) {
+	if (IS_ENABLED(CONFIG_ARCH_HAS_OPTIMIZED_POLL)) {
 		cpuidle_poll_state_init(drv);
 		count = 1;
 	} else {
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index cac5997dca50..75f6e176bbc8 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -73,7 +73,7 @@ endmenu
 
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
-	depends on X86 && KVM_GUEST
+	depends on X86 && KVM_GUEST && ARCH_HAS_OPTIMIZED_POLL
 	select CPU_IDLE_GOV_HALTPOLL
 	default y
 	help
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d103342b7cfc..f29dfd1525b0 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,7 +7,7 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 obj-$(CONFIG_DT_IDLE_GENPD)		  += dt_idle_genpd.o
-obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
+obj-$(CONFIG_ARCH_HAS_OPTIMIZED_POLL)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
 
 ##################################################################################
diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index 6707d2539fc4..6f9b1d48fede 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -4,6 +4,7 @@ config INTEL_IDLE
 	depends on CPU_IDLE
 	depends on X86
 	depends on CPU_SUP_INTEL
+	depends on ARCH_HAS_OPTIMIZED_POLL
 	help
 	  Enable intel_idle, a cpuidle driver that includes knowledge of
 	  native Intel hardware idle features.  The acpi_idle driver
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..7e7e58a17b07 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -275,7 +275,7 @@ static inline void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev,
 }
 #endif
 
-#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_CPU_RELAX)
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_ARCH_HAS_OPTIMIZED_POLL)
 void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #else
 static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
-- 
2.43.5


