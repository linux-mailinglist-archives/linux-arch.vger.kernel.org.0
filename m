Return-Path: <linux-arch+bounces-14369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC829C12F52
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FFEA503218
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DE2D592D;
	Tue, 28 Oct 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOmIpIxf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n52p8C87"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF92D3737;
	Tue, 28 Oct 2025 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629550; cv=fail; b=WV8c/MiDuUoir2lcOaDKZfTOHqSzPTQ5lQpvAXvMvJxovchTw43oXFiTQ3Klmo5gXSRWDtBRvzWswY6wfgEsw9fw6FrxGEV6whTIeTCi971V66vusMwbZkN4YlLScp0vRLfGUj6fObi6Qw508e5PBK0jx+m8zOVg/hX2ATt1J3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629550; c=relaxed/simple;
	bh=9662pNQYRpnMH6s43L4bZiNEHjuQxkb9nANkTR5BUys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gDa7uDwDY9IEykzGl6bwlz/6ouCwv/5UpAQnWBsNimfLafn49t5cVQK92G0iHODl8GjhIPkAC9rqNNygpygLl76HN68hvBSfR3mS5ENw9qkc7kL6/ye82ANHYcf5XKp0wj2uj6a41X6O5rgpreYwMYXM7ALyDx24ngwgj6WZv1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WOmIpIxf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n52p8C87; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NRQB029241;
	Tue, 28 Oct 2025 05:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=; b=
	WOmIpIxfAiTfDhMep/yw/4jxqQ8c5pp2ogr/baMlPdAzx4QPTdID/pqCKwIbXQtj
	iMwDjO/rU9YtlKdsRgtYr8dkxiu7aK4qkQvh7BptLhGF23cSJy+YPLZCfjEpJNGs
	4NwgPaiaDRBqayd7YcAC+aGPc3602o2h0mThXHXAOtoKPd3sTDfs5MEs0Q9v5MvN
	pPqk8kRYQ0H1cWppyXhsBeueK5fMF3rGZMWGZ1JqFDnOibEZIrb61WZBqZW+9d6A
	COIDPliOTkxU+AGmFephHZEFaAtCqvFyWFEmlZqXnT9gBkNKSenY0g0SOcVmYjGP
	j42UUUSaxRtbPDPpdgSOhQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwjjnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S32RNn016883;
	Tue, 28 Oct 2025 05:32:04 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07pjem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1ojzUrrajV7BmprOiRqXp3vaqMKinc8hEoh2iGaj78G7aMORevoSq9GMz14VGoXJ2C0jxTCiuerYg5a7RkTWqC0TDPHDHedI9itye3DFfYQ9YLfugfjeYKGH2NaHOGPU0gS7+9Pzpcrt4t0j/SdQeCTzzqakZ8pBIcLlVHB4zJ1yWQjONY+NT2nRIlED6ift8l+Hijol7/j4ImFavNgKe49TWTYRaFEILUCH9icJKbRpbsmoL6FARiNItXB+fDL26g60dtQTll8r4pDzqoVYQiDr4erayQMZzro1QRw/xn5VGPWVavUdWP7iRDWWmXuSrRW5n/XKskhd7U+g5xjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=;
 b=QSYGl/57HiQ6OT4cgdMygZJB/hMQI7rx11YiT3IF+5Jz+2nXvuubt/Rz1982K0EHj69Myy0EOXACPkV0ir1ySgzigSxZ4nrf0sOMZAaszGxEWDMGlcm0jQ8muaH+H+59+n+W0UtVLyVp96MwhfPTjsLn2Vxq06YYzP1nSHq9uJgjr8LrjFmc3a7QzaDsQQs5tGLiN2WOHUWOnhRfLGGKbb1KI4qyi24uuUfIyQfEksRXy3ro3vbcbMsyEtDPZaa0w9esD7g4QaThdFyJvQgoGTnKgTTpN961gNTRxkfVs4LsZt2FcStYKKk03DlwdC8rzxISBs2c97P0vgo4yVviHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=;
 b=n52p8C87CGvBBWlj98O+YB7by+zPL0kF6fmWoRzPbHEpi9ouovD0Kv5UFkBTzAxcQXT2j1EIe+cni/F7eLwtc2Odps1p/B6hL0vVC6pialneMARK/w2vUkIL4BNmHVkeRgepPn7TQRqlSBf0aIRAIXvM4fqwaVt/m5ssVxTGT1Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:32:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:59 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 7/7] cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()
Date: Mon, 27 Oct 2025 22:31:36 -0700
Message-Id: <20251028053136.692462-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfa5a89-ef1e-4137-178e-08de15e35114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtpK8yzs+H9Czz4FghV2D9uL5UiqKnwhm/cLL1jImjkdk+uCjF1Y4VTAtO9J?=
 =?us-ascii?Q?RhaiSpPuC7G06uS0hs/h9/W8mWF8AxkTqtmIW5djMjqIG3wZI0YTlIADlCTB?=
 =?us-ascii?Q?f0ZJ3M6Gtyou6gyTyeADEPYGKCexl4yR/R2GgoTwmwLFz0GZr6xCipWeUnUz?=
 =?us-ascii?Q?bQ2Madp5FAxWJEF/QqNT7U+u8skrFqV9Vy1692IclD14ymW54wRMOhjMq7x0?=
 =?us-ascii?Q?OtNSvyvG3zaHsUEcxqpcb5KKPrrii+BBVaz68ZKMVmZhljrTrdHUf4JPcYZ1?=
 =?us-ascii?Q?aVyOMq52Wuugl4I7ycAsWkO0k3j0nmzHHPCnIOExvs3Lp2Ix6nphT7sygeDQ?=
 =?us-ascii?Q?LFNmy+3YRLDGCAWwraTgLYO0QMMjzGXwdqcKIBPMJMF8ArOsuytPUBhBg4mU?=
 =?us-ascii?Q?IFl2e3JFBMYMCQB1znOgoCJ8mRLeHmo0NwTOOFxZbq7IKD+wzWjn6MvccR81?=
 =?us-ascii?Q?nuEl4GoF0pzws1gmbriIF/uuijoRLhWZO0tHCxQqioiHwCGvVT1/pDpqlB0C?=
 =?us-ascii?Q?bigut5dtJNpHK/P+r37IxUCaverle/NltYFz7gLw4EpzPCYaQg9aADeIfjrT?=
 =?us-ascii?Q?kgVyn71rES+WgDGnUcMbYtx+AX9QghzW7NBH5ciqnSY/kTvWeNIzUcnn3rq3?=
 =?us-ascii?Q?PMRfpYxJJ88/+KIASEi9/Xn/ktXrqgYDIp7Z0xvIrNRIVn/ANMDxZRTh3/O7?=
 =?us-ascii?Q?N+Jo+F9hqb/Ks5OVZldo7+izLJ4S5a1UN7bjv/8hb8aq6ibPh1tPh2KkI3Fs?=
 =?us-ascii?Q?Oe/mj1LhMWwk7MzzGgF88fnfILkDj6AvXGawvZS5F7670msL6cqwKUmw9SLZ?=
 =?us-ascii?Q?H+lP1sPl+Dxzomy4yPDV2Rmuv4YrlbTug8CmGmxTiR4Yrm7UlUfIZe23mG1u?=
 =?us-ascii?Q?cU7WCR2P5f6rT9s0TKg9XFf4AQGvTREUCxNrrmyau2oRVKicQIXYhQHN0dlt?=
 =?us-ascii?Q?ByX1W4Sxz0wh0FQGs02OMFK7em9p15QWcSEH5BXdn/WWTOtT5mbgWA0MObQl?=
 =?us-ascii?Q?viUcbBw3c7l+xlbKTYQldSZWDww8X7y7Uy5rnRL/ZPr/89PdyNp8mLLbQsrf?=
 =?us-ascii?Q?muHclePJcSrHNDBzgWur1MzfcuQVYJ8L8YVri/8f+AnA+fiZn7GHhePfE7CL?=
 =?us-ascii?Q?5isedgQSjdp1Gyhh2fPphbW8lrarHdZh970bDTMbaGSNthOJcAM6IImnUY/I?=
 =?us-ascii?Q?wl13d2nCDPODO164uzLmdUDk6U82E7bCtI3CdYtGxDvpvMyjArgKUOhBch8x?=
 =?us-ascii?Q?yYjC2HpcKE/HkQd6UqnWYY5YU+7n0e/aUxiHP/SezHpvPTRcM4QdY3HNayfh?=
 =?us-ascii?Q?zC6c3He2mW2H9VDjqSTG/b74ynbeDHZ8gRlCxT+vtfpEkOD/nZXE6/GbrjO+?=
 =?us-ascii?Q?l0pTkzNKuhLgHOyl3Rg/+wf7XWXU+fB4hcZGTSautDHW9hbSQAcgG7tXbKPy?=
 =?us-ascii?Q?pJ6yZbco8sF5iqI90zPBoFlQ2W4A5IrL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ia2AIgCJRF7MhfVW4iWdSpRhb8kOwgqVYUP5uVHxQOpCyxIc+J/Gfra6j7y?=
 =?us-ascii?Q?Cbmdd9osyjhTXPAAZKZyB5SjvzWNdp3IaMo3uulw0qMfLTLUmYm/rUnUMuqi?=
 =?us-ascii?Q?2XRmVDwiXSXA8l8F90SrgGcI3AVGImStoooN3VdxPvoFMBXlWKYAvnmqa/fS?=
 =?us-ascii?Q?NyooLLx5Cqva/N32MgagKoNBsib0rQsr+5rNS/PJtA9+0E51R10Vowsaw+It?=
 =?us-ascii?Q?1chQafXYcDZF/sHR3fIo1F8XtfvBNUglIHl6DIMV7H2PEmqkB5xrax6YpIyQ?=
 =?us-ascii?Q?hyqbaHIe6Vin17rCZlTI4Q3fSBpp6T0yGubVXVgiwlsalLe28oVYa7mNSUM3?=
 =?us-ascii?Q?osSiAdjREbzC6s+11hxvP0/Jy3Y3pmtMopAp3/tmKNDmm+zWXcn2aGQ3dijg?=
 =?us-ascii?Q?+KfGZq5gZL+swbLULKbsItekVXCBSMdy/u+2nLh386/L0GyY/3sb7s1Nbaro?=
 =?us-ascii?Q?/QnzWkxzPZQAQi/L7iJbSjTwqPz7UiBDKn6uLomYNPJLq2bwei33xWJy2Zei?=
 =?us-ascii?Q?4YGH0sd3C6AjLklOwnjz6GCMFcjXuCoF6nICf/HOKXvawL8auASYkBLm9/OL?=
 =?us-ascii?Q?yaB4BJ2hiJJ+VvYd66jug3OtZ2nCrHkAxM/tYOLbAxUnAAXP4PafvKy/g9ea?=
 =?us-ascii?Q?1iXNi9coWuYl/4j1Gn5KI8+MOx59hnyMyJpvrvmiDE6TPQOwExZqoNxWQWbB?=
 =?us-ascii?Q?HOcQib5sRs6Uc8IRCCqy/KM1Ogk4RZjLV+9Xz7q9JWjev1NyalzSn4rVBMei?=
 =?us-ascii?Q?k7OoCBAg1KKikpl3/FroC+Km2q6gDyjbIPCwW8iNJQcYM7hG4elpmbRdaNY/?=
 =?us-ascii?Q?UGznNlgMHUF8mQ1oZXRvifq0ds1hZa9f6JUjEosDSIu0D8IZXcbpXjhSCFCj?=
 =?us-ascii?Q?QPxmW1PkSyeYitRlK995uWN5eqMQPy9Zdy4Bhegs30t4vhB7VTrBbgdelQAH?=
 =?us-ascii?Q?R31HbcH6l2wWzebtzRY9kty/XdE9nwDeZJOxSMyBaYHgaeQlF3E4iLOT7Pde?=
 =?us-ascii?Q?PPZgoeJN2LPm5xvalGztVz+J/PE+JtGh53j0dN5S3C4Nn6muq3A0qdu2g83e?=
 =?us-ascii?Q?GgkfYFoigLbaq6FzOVtz4/qDKI7HtkQEv+efodWvEUmkaH7NF6k71kSxKFre?=
 =?us-ascii?Q?DDMoogSLHmUWsL00GAMD/+3746GR9xC9faCSRdGgr/3N6dkRh6GlRF0qjeWJ?=
 =?us-ascii?Q?YH/eKi9DS59Q4pNNRj1kLYDdxbvr9lXz8rbvuy2ELQq/9XyYuJ2DxkH1oBcV?=
 =?us-ascii?Q?iEi/Is7e2QfY1ONiWtSeY5czUBkwoIbGMfaSyCd3+h68KvhzeIhMz+f++wCa?=
 =?us-ascii?Q?UyBKxiZgF6O17fbWU7Qr93b5SIcmSMFM4n6pyyeRoHb2FgQW+FPZbVNri10H?=
 =?us-ascii?Q?UBRomdH6GHJdqyn2L5Nr6ZME7cZ7MgVDXq9hYYhEi21o4NJ0ZcAgYAW+Xc0i?=
 =?us-ascii?Q?N92GyKL+WKION5ZghiOOYUfDNisofViQgjvN+CmgBKz5LalPillu1zcTWrc7?=
 =?us-ascii?Q?sJnBS7S0oYFObgqQn97jZPnsm5eZAEEVRlIQIFPOAz3hDodZcWYXlr082M2H?=
 =?us-ascii?Q?82H/44IBMLpvYAHNudv0lqLbo8WP6nYSG3FO+POMSC9AA9Z7jlf6tp8E4TT5?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KsyQNapNoUXBCfK5TUDRFNVKkksGDnS4j0NrRslMtXTKND4DgxrNquAWk61Mt8SGk/3zv/1UYu6D3cVB0geI3oOEsuoDNuWK2MZetISkPvz3Jw8ts7V+WO1xs2650d+BzXFY6ZncLfusQ4yxcNMp/akuYESoRFfHMyk4PimMh3PYNUbv2pubpnwlt8WEwWdRPUneJDX5f2eyy8QnZ3imnXo36InUeChvemnsyGMOrZgxlLRTDlpqhs+CUioloIsPRl8tBxtfFb25Xoxrn9Rv67XXrUqnmXuO/cKA7jcRG1zNPAyHaCg1SLBRh60DDKN3xBJP2tgfzWOkVDAedm9kqnSIB3tjJMxChGsoca9UBBBFYr8tBCXWkAQVbz6ymEPKNZBGgrIXmRcuQH2Hs4Sug1BuvNQOdw46/vLXjo3iMxpKOtUhlXSVU/JLEWSRcZLbvc6iJkqXD7r2RNfV04c4GoqCOZQPfPpYa7PANcdtZ3/oOOOhnvl/9IT9T4jYnkE+SlqasviHbd3TZTTFjk6oY1xTpZ3V2LlZ8nLaDZkiT1nZL8sRut8vo9TSfNGBNfMY1Ue6LxlTyDFnjIgRyZZbuEM9NFgBdppdTN4enW36XaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfa5a89-ef1e-4137-178e-08de15e35114
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:59.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agTelbHzAjvmmuqJ5DRul9rEWtFDyf6IgvTA295DUuwcZyDvSVKSN+OowIsdD962vOZpYUkvEs9uCdH5nnnFAd8B2xKv7ZB6PN2ff2nD2jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280046
X-Proofpoint-GUID: -AoYGC4W98O-5jNFVYu3b4yC9HoS9uuZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfXxNvnOHRiG+Z3
 9Xfegm+949mCDBQclCAr1ShiODGgHsVZTK+9mMuQsxAN5gWXklcSGQ6EoczZJ5U+Ye2UwDY1Pn0
 OBD7xjCI9dEnxiRSRA/AbTe9BIroiHPwowrsLBbooKdlhL8qLWDyh0MjzQB5x2MdPTzBiANIRZs
 s9bU2UMMKV4piIQmI3G8o6uLzNCdM5hevW9r6RCDuGyXTOQhrmFGIOnIyEfBQhAgiwmbYw6xiNL
 SDhhM2psrUzmq/CTfa1FvI6g+S6zRduBjzx7huPtLJ9R83oa62x13vuHdtgGmCbHfIyZUYiLWng
 u6jDmYFHxdsN3WVlYQQne9NgFsZfp/Y7x8dQbLfhNd53HlauKSGSJpfanHyAfdGzYYOWsLvHPB8
 xBt9LEwozQooEZ+oB68UsFxM4qY0yg==
X-Proofpoint-ORIG-GUID: -AoYGC4W98O-5jNFVYu3b4yC9HoS9uuZ
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=69005555 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=M3kmbseIx2tHGidxfxIA:9 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is done only intermittently (once every
POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

This is close to what smp_cond_load_relaxed_timeout() provides. So,
restructure the loop and fold the loop condition and the timeout check
in smp_cond_load_relaxed_timeout().

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..dc7f4b424fec 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -8,35 +8,22 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	u64 time_end;
+	u32 flags = 0;
 
 	dev->poll_time_limit = false;
 
+	time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
+
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
-
-		limit = cpuidle_poll_time(drv, dev);
-
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+						      (VAL & _TIF_NEED_RESCHED),
+						      (local_clock_noinstr() >= time_end));
+		dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
 	}
 	raw_local_irq_disable();
 
-- 
2.43.5


