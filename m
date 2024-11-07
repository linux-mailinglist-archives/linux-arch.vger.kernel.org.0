Return-Path: <linux-arch+bounces-8895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE49C0E6D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3ED1F21B99
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D0217F2B;
	Thu,  7 Nov 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UhO9K/3Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GrQXl++7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCE216E03;
	Thu,  7 Nov 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006560; cv=fail; b=mshnkLxtRTy49gsMZpQ6mWIfZKM17LLvaz4aDJbgQ77zkN+nFpLkCHbo0VxRoLVV7eiWNK5hu175YEhEMzpHWEwb2epwk+WhwirFgCZHzXlnXkQlfz66iv1IKIJn8ApqCCkCgMloOFISyXyL3rPnVbeD5ds4NgAGwu1WKYdBAd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006560; c=relaxed/simple;
	bh=10yyhlOuBctFd/tb93zLnEZ8u6uTcAb96k/5bjEK4Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BPoxPrJxEd1gVT250k/v4/g9mdAJfA9K3/VJ30NkeSPLv+SzW54GE/Ra3kGQOylQ+3VQlc1EFP52fgoLobdKs3yMKl1Zid6vwfYvN4MH/KHZg3B+CEsTWXItzfbITf2ZoSJFEQvOqsKfDxvxtNtM9hbwHloWkirD4yow8svkmUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UhO9K/3Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GrQXl++7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBemQ029187;
	Thu, 7 Nov 2024 19:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=fOd2FN0XaENVPXKa
	MzJ+bwyd1/74lbiSez01NTWEEI0=; b=UhO9K/3ZsFdA2J/SIMOACyKm8Y3RbEki
	74KtxqTEaqNksvy/Uf4h5ZdjUFn+0cgKxBaX+OuFGJXEFmPftaa0Y2JvQVKZu0Ll
	lRE6rglYalntdsOqhNcGc7JpG0RRxg0A1yFNlh8atlvwRJ4MmT8aHAJdMVr3W6M8
	voA7bTJ6qFCZWmwRErO3ZZdX2RMZ68351HKXES0HuTrjqFnEI0oO/hGZCmGYOzpG
	ZLi4iurgPdhkqOEOsZBu8ODZsE8tEoXJwQWluWG87ckpoL5fNCDigG+A2tVWgxNI
	70x2+9y+fO1o75kwlj11RMzZfYdcWlcYGfJTUN0mdREeKg+euWAFhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42qh03efe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HotYY031469;
	Thu, 7 Nov 2024 19:08:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6c5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNsFAgpacMH4MQgDx1lBUNoesgAN8/HOdYh7CFp6d60DT+Lxfm4xHO+mTPesGHf4s9d2P4cEPgwdVwQ5ehXZz7uy/Rp2jq+MX4nI9O46+Tfnqatohpb7Mv/LmyuwtuLP7b1XgBGATD9554CbwQNkclSZXSkxN72iogbNExLSKQ/pEAWoZUzcatwmaYxAa9TRC6SZ1dAWA9qwdwjoSZwLN0653n8weQ5nVd4gvuwwpvzihKY05f1Qzin+T9u052xercXL5ZJJQov9eAm67zQg59jEykNqz+fnK1y67eTkR5K00h4E0BA42a6geFGmQWypfjhUn2myJfo+lmwtY2vcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOd2FN0XaENVPXKaMzJ+bwyd1/74lbiSez01NTWEEI0=;
 b=XT0hNtZtNxPF7gyhUhOoeJTIH1hj/Nh8SjwWlbXNbrFs28OrNhJpTVIcnau78gooDsCol7ISDK27GCLBTzJK3duA2tDTPY/qTTS8QXgdm8j1ey9owkpQKA/uktK6cJhuQd9W5bfRfYbmFOslB8vow936JTQ4yLvy/0D7+xY/tf6tRGRPpSVLnVTMRnfx0lKlxf0eI4aucdrNjmUvs8fTHr010v746sKNS49XDLye71DY+4J2YbYXqTXzW55GYF3dAhlFkYnvBEN1bGL63AO9Y4EXfaHsb3xKDFTX+vr5Je4dKEJvgzyS05lGeTyEcvXd9s+ttHRH7PxCbChANQajrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOd2FN0XaENVPXKaMzJ+bwyd1/74lbiSez01NTWEEI0=;
 b=GrQXl++7hYIzt7lZfIurHTHeh/l40LchakeSa7WVyZlMFng6BTjhOa9Zb/PVMw+U7kMrn9xicr7nLq3muMWF+8t92ushgUMB9T6SqOvqm20QakRkrqX1py5o/AFgbzG205dOi5uUmjxUvwtNNRUjRqqCxpeDVURFxPc+rR3v3IM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:20 +0000
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
Subject: [PATCH v9 00/15] arm64: support poll_idle()
Date: Thu,  7 Nov 2024 11:08:03 -0800
Message-Id: <20241107190818.522639-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df49dcd-7d84-40e7-a167-08dcff5f8b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jj0rkSTf0EfEOGZXgfSgvBYYBD8N96Z+cv6JnhU0VMwoBsP58VD5s2VzfK+A?=
 =?us-ascii?Q?C5X60zsWXNJvZHv2JhBoJ94e6ifnbglUmgKW36OWk7fUUXhti18zf56NWnrX?=
 =?us-ascii?Q?SENGCqIz/xcRFbRBqhJc92BxCnasQajcCaHrq4BlVLOXi3eJZbLsvwWQzn3M?=
 =?us-ascii?Q?mRKo03bwutkd6r8/INBCStbGGpPToUnwSeSYRTZRTsxqwXgC7r4G9zTjQHpH?=
 =?us-ascii?Q?tPaMjPupTq3IBiW6ViEYEt2CjZxZZVZZ6WhHPPW4YM5OmUQUbsNtZ5PQ442C?=
 =?us-ascii?Q?bAmRxZoZz+IR6k9rg7Mi2F7CpJ1iTggAEhHMS05rJ91FFo4HecWI8hEfFrRe?=
 =?us-ascii?Q?RGkaU878pflSnaZlSk+PnGMc5UihPvabWMqC6h6ds0oOaDwg8nbwnRH+lbBY?=
 =?us-ascii?Q?DKuDeEjTsKiZMPJDgnROmx0dEE7fALFwL42+zUUpIFZh0nsaiZvLAtx0kMhC?=
 =?us-ascii?Q?EAC66GkVvVciibqsvXwQw+ef/NQszTqKIYeCLvcWWLywwzFqdN2pPTGAcFR8?=
 =?us-ascii?Q?25+WhHYM9RVfFRn0/zgHeO6cUpOnJtXJnQNAoxojNelaWf/oZ/1fIoZaEhgW?=
 =?us-ascii?Q?G0rVUFCpGTmJbGybTLdXaXzx75Rs6rc3bFnJR/qx5JDFf83OGXDJpJgWJ2bg?=
 =?us-ascii?Q?7xCpm2Fh5B5SJdCpaa6heb+W3GXPOFJwCRBkPyHrwgqABXvQoP5SKXcymEZ4?=
 =?us-ascii?Q?Hu9lqTdc8xeWesji6+EkvuECnM43Cd9i5YCiOFSz5+pIHSzSyRvb0CdAW4+f?=
 =?us-ascii?Q?j6V7zj8iKD0JnzyW/0/S+W2bi36bKXkvOqXQGbhOEQn8SacEUi7NeTbX7Hac?=
 =?us-ascii?Q?C+VgE1gijCGMdTOlHnmRI0PA9zb61waD8hV6ycxeoRpoLAOT8cfQgw8UQngC?=
 =?us-ascii?Q?lYq+MStYgWCwCZN3szeK4Y05GeGD9x1Gt9awFaVEiXQBUWS+Md5qG2URqQSf?=
 =?us-ascii?Q?4Qe+rQNcUrAJQlSDJTP+eFdZekI+QeWkN6iXcVBQyYVF9Vfb8QVKjJmRtQlF?=
 =?us-ascii?Q?RDw+jMR/uGFswFjEEoVrcGPuWNs3wd0tUe7dsWIEoMC7b+CJcnpXO55VkfJp?=
 =?us-ascii?Q?FYw8+YBVkt8GcuEq+FFeisb7v6MPRjzGXqDCjxQvikmyjOFtI3FpOKO7VTOp?=
 =?us-ascii?Q?ht0WEF/VBM6lh7YMTSIGZAR5+2EEUjDEVrsdhuWZDt4JS3r/iSYi+lfWohmJ?=
 =?us-ascii?Q?bKZ0Q2raUcRPkZ8P1v1AEeDHyjeiSYG65E5f+3CGieNkPIgThx1Mleuu+Z2O?=
 =?us-ascii?Q?nvwdMxU4GYITNGgRbbtNmnaYbUUqmNop2VCdwY8YvNV2gHP/sLV2NIqA+NjG?=
 =?us-ascii?Q?KBkpYM0rm3EUMkUkFrmKPYb4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPYn9LsX4OcNz68sq7gii6UvrZSEoOQTlJeEW+uD8YoCXNZZhM72nX7a6cEI?=
 =?us-ascii?Q?d6wM+lSPUKdAIcTRw1qmq60wFGwIXK/jICNN1hpdB2uP3XeKZhTsruTvP8zg?=
 =?us-ascii?Q?V7FWhWLBE4Ec3htY2uZZqBoH7iAaoQV2OBhvFKDUziMP3wEQXB6U/T1oV9ua?=
 =?us-ascii?Q?yHANHXfIuwnvftAx07nj5FEGEfS5Er5JyuC5pIrjzLJBpuaM4rayx3XJmVb6?=
 =?us-ascii?Q?A2E/g6HmCjmLkP+OUdJLTRuWeNPKx/j46Yrk9B1Q7QdpH4tcYIDQr8eE6bky?=
 =?us-ascii?Q?3q+RydQZtOlun4rvuBO6nwZSL1lupk5/PVjh5K6Go4Qo8RAzzXKtazx3O9H5?=
 =?us-ascii?Q?Ym5iw3ddOtbYKfiFHY3rDqsEKF57KRRw78ykgsC80YyQd6hYNBIhYErjT78H?=
 =?us-ascii?Q?bGLMm0rG3PfnjgGWrQHXipaP+05RkfXuPFevNHM/5cfdo36ZDGoRRsQcvKlx?=
 =?us-ascii?Q?g3CftmrNgNNtI83nnEVaXvViUahITjI9QmTP2KC0LVAhWcXHv2hwFZdPty0R?=
 =?us-ascii?Q?N/usweI+c0WMTheXOfxQPg8ocmwFWsBbDpWXtGc2gdGIPMO1/y5GFKZZ6nf3?=
 =?us-ascii?Q?+XKyuetyR0d0vr3/E54N4s5G+AyByTP7rZxYLvmD1lfGE2avqULGVM4DeTRF?=
 =?us-ascii?Q?xb5QHy2bAfjLUgI32hGziT/mgPYBpiiosQwxx55mu+CEB8ysMJBO3eVktv74?=
 =?us-ascii?Q?os9tZ/k+crxaVRMiGFnhVS97RWVS3CwNd4oXbOKnh9ShskwUowRl9VNKgLNx?=
 =?us-ascii?Q?kBeXebMbqRJ6ZM2ynVU5N0BlAKoNoK7qF7aJwc0p8kSWtBkpMsYRO6xmvkNx?=
 =?us-ascii?Q?wJ64A/cP4AdjlR4YiBQ4FutemlYVOrt6PaGoqGeziY739v5aS52o+msW7586?=
 =?us-ascii?Q?Y/uKek1F6yHDHdnn0N3zAuRPayLNkhTmrR8ZSRNHs8HgC8qV3VJoFlhrbpyp?=
 =?us-ascii?Q?78xNrBKqCxztKhvf7PhgLxBx75Oka//2aO6TAk0pt6XKJ518PytIfSrkQs12?=
 =?us-ascii?Q?WuYrnymMvSgxaL5cbWY733Fk7KiSoirm2aJsr7NVsN/cic55tPjH4qBMnDE2?=
 =?us-ascii?Q?v7khTIOlIgtr2U2urE00HE/SEpOWL3lfipIhZWsDOW1uIy297DcILTb9eKuj?=
 =?us-ascii?Q?Ve3kVFxibFs8aK9hYmBJDIMKabCOtB2wZPkug322c3Y4PolOWXPC/I/CNkiL?=
 =?us-ascii?Q?b2bzc9eo3L3TXBYNtNmhWtlzsRLrj8yJfP6Jn0Dpt+glkOp7OrjGInqDLQLk?=
 =?us-ascii?Q?sDOmpO0otno11hkZWt4rQ+KhqSIdEcZcloV4xtW0mvIhy76dgV5BVxH0VH3X?=
 =?us-ascii?Q?G8aG5UGemgxqN23Hu2lTSK3l1P1bE4j75n/MJGhVyURr9NMgGdrs0cZlUejq?=
 =?us-ascii?Q?o/k9zNxvOfXIm34nCw8EL+CpsmZbSB6R5KYOxyQuWO2Oum0Mmsh/wokaOVNG?=
 =?us-ascii?Q?lw5aIjkoe9pkePV1fy6Nbu0I+wPdlWjQViisMFD8eHfeicgZy5Q/9Ez+u9Tu?=
 =?us-ascii?Q?ucS7x6DpSJ3V+K909LWJ6FbYIgYXOXEPwSVsO6eT7JQkIKIaj/clS3F3Mx32?=
 =?us-ascii?Q?+nHWy8ZjIFtj4aFFmPq7yyOW2z8v0BUXTEHkAjVdg8V08/brRqwl0YYHnoY8?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U0Qje9CN+C9zkGsJPiL0Pckbitb7YW1plLEWIW/vNz91HLFcOPFIQq4H5LKPwOuJOOr4hP17hfc3Mrw7Up5jQgp1qOojUU0+FG8S2d/0XyZ11uw/RV0OuFK/JA+F35i/Ncsn6pbQpGDCJZd0ZlK5+bKBq3anKYev/Tsw3iZqBdtKjzzX/wOXNjt41cWC8GHjnm7FpoprBbJ2G1ps79qY7mbIq4PirkOZHiX6JH+4c1A2tgHvPqsnW2jTEHbFZs3rhCEMC1NlZrUeZduiYAVoKjirIXf7hiiOcYOie6rr5N5xHXz9AdLeSmIsrc52QhxIu9EDMEcL3zhCus44OMljSgGU9sBkyHzU7YSfqU/cwCZSZkRUgZWqGFpZzoqLhg8vDQv2Xe3nXGNBu+TzohOmTSt/pIMG4MMtX/Fd1WbdlN5SokFU4hp3bNztyV4UBU8nPkS4wTzIwaMY/5Nz0bRFycVThWm4NXVD1RdloNtEK29TD8MErLUlitUKidwQO3GdO0hPk1jPqyu+SQ7CVQTpkFpPT48uCEvV5a/RIktHqo6eJa2+2HvDfC33uZkYFm+m7u0rdOwLPOhUo4QMiKFno4pvgBHM9ZVFqmd2T76SHyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df49dcd-7d84-40e7-a167-08dcff5f8b35
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:20.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8vilVgQnJ8z/pSzoBaWVcy/dK8mwp3MnvJlKSm5TbjNrZJQ8mM0Inj+OT6N9uQ4AzuxQgxNFR9lQlyitWuWul68QtdzApTDJEoOmDQ0bk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-GUID: PAAwsCPC0xUPkx-yJT_0wMtA9K4WOHkv
X-Proofpoint-ORIG-GUID: PAAwsCPC0xUPkx-yJT_0wMtA9K4WOHkv

This patchset adds support for polling in idle via poll_idle() on
arm64.

There are two main changes in this version:

1. rework the series to take Catalin Marinas' comments on the semantics
   of smp_cond_load_relaxed() (and how earlier versions of this
   series were abusing them) into account.

   This also allows dropping of the somewhat strained connections
   between haltpoll and the event-stream.

2. earlier versions of this series were adding support for poll_idle()
   but only using it in the haltpoll driver. Add Lifeng's patch to
   broaden it out by also polling in acpi-idle.

The benefit of polling in idle is to reduce the cost of remote wakeups.
When enabled, these can be done just by setting the need-resched bit,
instead of sending an IPI, and incurring the cost of handling the
interrupt on the receiver side. When running on a VM it also saves
the cost of WFE trapping (when enabled.)

Comparing sched-pipe performance on a guest VM:

# perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

# no polling in idle

 Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

            12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


# polling in idle (with haltpoll):

 Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

             7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

Tomohiro Misono and Haris Okanovic also report similar latency
improvements on Grace and Graviton systems (for v7) [1] [2].
Lifeng also reports improved context switch latency on a bare-metal
machine with acpi-idle [3].

The series is in four parts:

 - patches 1-4,

    "asm-generic: add barrier smp_cond_load_relaxed_timeout()"
    "cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()"
    "cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL"
    "Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig"

   add smp_cond_load_relaxed_timeout() and switch poll_idle() to
   using it. Also, do some munging of related kconfig options.

 - patches 5-7,

    "arm64: barrier: add support for smp_cond_relaxed_timeout()"
    "arm64: define TIF_POLLING_NRFLAG"
    "arm64: add support for polling in idle"

   add support for the new barrier, the polling flag and enable
   poll_idle() support.

 - patches 8, 9-13,

    "ACPI: processor_idle: Support polling state for LPI"

    "cpuidle-haltpoll: define arch_haltpoll_want()"
    "governors/haltpoll: drop kvm_para_available() check"
    "cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL"
    "arm64: idle: export arch_cpu_idle"
    "arm64: support cpuidle-haltpoll"

    add support for polling via acpi-idle, and cpuidle-haltpoll.

  - patches 14, 15,
     "arm64/delay: move some constants out to a separate header"
     "arm64: support WFET in smp_cond_relaxed_timeout()"

    are RFC patches to enable WFET support.

Changelog:

v9:

 - reworked the series to address a comment from Catalin Marinas
   about how v8 was abusing semantics of smp_cond_load_relaxed().
 - add poll_idle() support in acpi-idle (Lifeng Zheng)
 - dropped some earlier "Tested-by", "Reviewed-by" due to the
   above rework.

v8: No logic changes. Largely respin of v7, with changes
noted below:

 - move selection of ARCH_HAS_OPTIMIZED_POLL on arm64 to its
   own patch.
   (patch-9 "arm64: select ARCH_HAS_OPTIMIZED_POLL")
   
 - address comments simplifying arm64 support (Will Deacon)
   (patch-11 "arm64: support cpuidle-haltpoll")

v7: No significant logic changes. Mostly a respin of v6.

 - minor cleanup in poll_idle() (Christoph Lameter)
 - fixes conflicts due to code movement in arch/arm64/kernel/cpuidle.c
   (Tomohiro Misono)

v6:

 - reordered the patches to keep poll_idle() and ARCH_HAS_OPTIMIZED_POLL
   changes together (comment from Christoph Lameter)
 - threshes out the commit messages a bit more (comments from Christoph
   Lameter, Sudeep Holla)
 - also rework selection of cpuidle-haltpoll. Now selected based
   on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
 - moved back to arch_haltpoll_want() (comment from Joao Martins)
   Also, arch_haltpoll_want() now takes the force parameter and is
   now responsible for the complete selection (or not) of haltpoll.
 - fixes the build breakage on i386
 - fixes the cpuidle-haltpoll module breakage on arm64 (comment from
   Tomohiro Misono, Haris Okanovic)

v5:
 - rework the poll_idle() loop around smp_cond_load_relaxed() (review
   comment from Tomohiro Misono.)
 - also rework selection of cpuidle-haltpoll. Now selected based
   on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
 - arch_haltpoll_supported() (renamed from arch_haltpoll_want()) on
   arm64 now depends on the event-stream being enabled.
 - limit POLL_IDLE_RELAX_COUNT on arm64 (review comment from Haris Okanovic)
 - ARCH_HAS_CPU_RELAX is now renamed to ARCH_HAS_OPTIMIZED_POLL.

v4 changes from v3:
 - change 7/8 per Rafael input: drop the parens and use ret for the final check
 - add 8/8 which renames the guard for building poll_state

v3 changes from v2:
 - fix 1/7 per Petr Mladek - remove ARCH_HAS_CPU_RELAX from arch/x86/Kconfig
 - add Ack-by from Rafael Wysocki on 2/7

v2 changes from v1:
 - added patch 7 where we change cpu_relax with smp_cond_load_relaxed per PeterZ
   (this improves by 50% at least the CPU cycles consumed in the tests above:
   10,716,881,137 now vs 14,503,014,257 before)
 - removed the ifdef from patch 1 per RafaelW

Please review.

[1] https://lore.kernel.org/lkml/TY3PR01MB111481E9B0AF263ACC8EA5D4AE5BA2@TY3PR01MB11148.jpnprd01.prod.outlook.com/
[2] https://lore.kernel.org/lkml/104d0ec31cb45477e27273e089402d4205ee4042.camel@amazon.com/
[3] https://lore.kernel.org/lkml/f8a1f85b-c4bf-4c38-81bf-728f72a4f2fe@huawei.com/

Ankur Arora (10):
  asm-generic: add barrier smp_cond_load_relaxed_timeout()
  cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()
  cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL
  arm64: barrier: add support for smp_cond_relaxed_timeout()
  arm64: add support for polling in idle
  cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL
  arm64: idle: export arch_cpu_idle
  arm64: support cpuidle-haltpoll
  arm64/delay: move some constants out to a separate header
  arm64: support WFET in smp_cond_relaxed_timeout()

Joao Martins (4):
  Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig
  arm64: define TIF_POLLING_NRFLAG
  cpuidle-haltpoll: define arch_haltpoll_want()
  governors/haltpoll: drop kvm_para_available() check

Lifeng Zheng (1):
  ACPI: processor_idle: Support polling state for LPI

 arch/Kconfig                              |  3 ++
 arch/arm64/Kconfig                        |  7 +++
 arch/arm64/include/asm/barrier.h          | 62 ++++++++++++++++++++++-
 arch/arm64/include/asm/cmpxchg.h          | 26 ++++++----
 arch/arm64/include/asm/cpuidle_haltpoll.h | 20 ++++++++
 arch/arm64/include/asm/delay-const.h      | 25 +++++++++
 arch/arm64/include/asm/thread_info.h      |  2 +
 arch/arm64/kernel/idle.c                  |  1 +
 arch/arm64/lib/delay.c                    | 13 ++---
 arch/x86/Kconfig                          |  5 +-
 arch/x86/include/asm/cpuidle_haltpoll.h   |  1 +
 arch/x86/kernel/kvm.c                     | 13 +++++
 drivers/acpi/processor_idle.c             | 43 +++++++++++++---
 drivers/cpuidle/Kconfig                   |  5 +-
 drivers/cpuidle/Makefile                  |  2 +-
 drivers/cpuidle/cpuidle-haltpoll.c        | 12 +----
 drivers/cpuidle/governors/haltpoll.c      |  6 +--
 drivers/cpuidle/poll_state.c              | 27 +++-------
 drivers/idle/Kconfig                      |  1 +
 include/asm-generic/barrier.h             | 42 +++++++++++++++
 include/linux/cpuidle.h                   |  2 +-
 include/linux/cpuidle_haltpoll.h          |  5 ++
 22 files changed, 252 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpuidle_haltpoll.h
 create mode 100644 arch/arm64/include/asm/delay-const.h

-- 
2.43.5


