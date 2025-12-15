Return-Path: <linux-arch+bounces-15398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C552CBC802
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4DF301461B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A993203B6;
	Mon, 15 Dec 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QGDxgxYE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zho425n0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAD256C9E;
	Mon, 15 Dec 2025 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774273; cv=fail; b=rl4QRjWtf/Iz7bdxSZQJgxwcTjjmbhJLXfnRAN9RxFBX1TlBhvaNi9GOvk8FaSqvoSB1maULZJh+ADXNaTHI+vRe31YQxnECLEUvCySereRXIXqVbxax9nGMmkV20Tk7i3NpLKL2MAqCqNJVtcpO/oYsaPZaLirO5Ddw3kBl+kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774273; c=relaxed/simple;
	bh=zHuyIHS164copvweGYAiuq9vMXET15p2pXOOyUpyDi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdeMu92Lvp9hAl6hmKiWMZHJEXiV3n3WqOL9WqL/AAi/dHx4rAGwycRLeregpE6OyhPKO/sys2Jil5t/ESVntY3QSUg5tBLkU0KV61pm0E5OL/ftZjxfXRHzLL8dCMwVYDyNMDI1p8crH3nZaW53rw5pdHJ2EQp873y3ifF7CXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QGDxgxYE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zho425n0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0HMBb954172;
	Mon, 15 Dec 2025 04:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3rCGIU4l9cUr5AQIvr2FPjLPVqn70/rkM6Hzc12fias=; b=
	QGDxgxYEpdM4dNO1yGyGugZYdbTiUpc+I6p7TBz5PZeb5S/lQWaLrVQWWB9vSA35
	05GxxBN4m2FZ2UUXTKwR9pRljVYrhG61/sNc2uiqL7ddY8JAb3kw5klJCBXQm2pw
	TMloLerBGxeLN8bKMW1/64TvsJxaZD3Ufg1j6iQU2ke/zBmqShnFOyW/Z2CTRG3Z
	6bUBNQLmnV22xv9LMEIIoSzea2UYTbEIkocnmSXALZppaAsY1fPcOGx9/r5vjOhQ
	M5ksQue97CIk7c0aEYq/C7nvwEqnGzyk4lsum+hDWYI6RrQ4mY/Z5X3DZQwwPlBw
	HPs48uoCKgfju5yAGuRyOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx29b2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF4jQZl005878;
	Mon, 15 Dec 2025 04:49:31 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkbgu79-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0PY2lZr7yrpJOj31QKxx9cC7U58hr9SMpEQl8PcdLXnBeucfIyvlk+HyXtiI0QdaW+IQRLv3MEL68/3SK+RSfK8a8OqT2pkbbnQ904r7Pwa74eq/sNMoA/bPkhMtIpCy+pFirQtxXN4ddVhfm7B+E+3ytotlU0omQdrJx0O7GcmSzc+MbkJrRCKSpXiHzBHDDkhwRZen4FWJQwXTaR3wMVxAu2dgvKe6o0hYU4taI73P/2YrDEKmXrJGM1yCnZI5BZ1JJKCI33FatXUMuq7Mgw3qjDgKLduK3BCRUhshuzFtE7HU2dhxLQFik8sCRva1QN+cn3E4yBhKPrr2Y5saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rCGIU4l9cUr5AQIvr2FPjLPVqn70/rkM6Hzc12fias=;
 b=bh14MA1d00ZGDLjL5A1RvoQq6nzFzdDJGw4xA3BHlPtwTLW3/TpDasRMa3zRdodXJTW7KWBCdTr5umLyABLF1+MY14avVAZnNeHxbAB+FS9qibEmh+kxTzqg/Uhi0Bf5WO1kA/Luuvq5vseKlwF+rt3LJkQrFDm6qGjWLt8/+tdh6EIk4eeficQCO0Q6MrhrLFQgOeIygzLKWsRuD3nnBfNYhsJs/2wPS1TYeKbXoP68VNu6gx0HJxG+nwXrYgfM0pLBVlpRs0b5V5vTmC4Q6ShSheeOn3VJcj4xe2ZZFm0Biii20LbwKnCbG42HlA5K19mijjALKLnr5jiarK6iUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rCGIU4l9cUr5AQIvr2FPjLPVqn70/rkM6Hzc12fias=;
 b=zho425n0eBM1Go4k1PXY3UE/qfBnjZk5iKdpVxgx9/ZUs+Zd164yw44MaiZbF5rtRnaUi5wsIu2Wvh0g0Li3GS0DlH3oSDB9tSNWfjTPiIoc4nWiUJv2LhnZXZO5PCB2LPCIeXhnQf4XmaVDELOZN/Pkn7rNASXoHlClgRgqyVk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:28 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 04/12] arm64: support WFET in smp_cond_relaxed_timeout()
Date: Sun, 14 Dec 2025 20:49:11 -0800
Message-Id: <20251215044919.460086-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 832f4dcd-033b-47b8-c2ba-08de3b95544e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O7vyquMwi8Esn+g+xbpZO8WZ9kx2IMZrlFnVyTEqTVb+G3BAbGpF13g0sq+8?=
 =?us-ascii?Q?pPAFhM42O1xKvQnd9/8TeNHFLFwMaZV59GAMRHrr1SudhtOqpXdb0pHd/XLM?=
 =?us-ascii?Q?7wU4N98jhhvVOoZhATUFNzl7nwNJpVqxJtTa1MP1TsBqz9SM1R3JHBrk07mn?=
 =?us-ascii?Q?1qC1+a5heztZtcWzpfTEr+N1e8rhipWw6wFX3qasVuL4DiF7xRJh5okL1DhP?=
 =?us-ascii?Q?hEAuZKH9dwwrm2vNmr/GLzLunojnKnmBxPpxyQcr16dXfTXpux5yuv3oDbfc?=
 =?us-ascii?Q?QZmw6VNvoOqEveAYsHLglAJAdEA7R3+b/62GQkTlsttWmj0YstqdMdlMoe/G?=
 =?us-ascii?Q?t51p1vgSQduShgkVkMZa5CC9mJt0cLATwTxPU6dKK43uHXnJEkeZRvnck3vs?=
 =?us-ascii?Q?KNUqkeTjVc6IVxWNeJucmAFHlqtMPcH6MV8XHzsTuh9NZOdgOQpjgEkx0pja?=
 =?us-ascii?Q?bXUEny3G4EpLS/dwZeUQKkFmWAije8Mhg6QoOkLOr3nfALgOSJrtVSjfdLU/?=
 =?us-ascii?Q?ZtpsIlF0uWKD5vgNRMS7Qsnh6Gs4VGjlo/qQhFZQ17SvZsFkytGmMxBvHaNS?=
 =?us-ascii?Q?NZE17SC411eCplNwnHtDat/CNjzPSK8tuR4AhhCefvVXNZFELfiTJP+pzXYH?=
 =?us-ascii?Q?wbnMPBB3qQ3EILc1woDM5wcu53aYqEqUGvKu5VUPTp/P0ZSM0blCaJkXqkLL?=
 =?us-ascii?Q?Z8p8HiIxca1qhYabNca3NNPYEVNZ9o4Zri/vXna3W/689oQpHGPo2FqyDYjr?=
 =?us-ascii?Q?uOf79G0Ot0m1ZSaoFwGOYYfLI0beUXUMWSSXZf1JpsrMAI2xhWUwcFBI+ayz?=
 =?us-ascii?Q?FGVoWAU2w56b6gpC7fLtaReaKD1y670iLT/EB1gKSwsfOZ2GvnwII4Jf4n94?=
 =?us-ascii?Q?2EgqFxruebGrFAajnARNvMqRqqT0VWJUM4+V7hv7OTo9vmxvu0fnK58Ainwg?=
 =?us-ascii?Q?ANIiytKKnR9IJGBrm6Q9tFRNqoLdQdm4/h1htKWx5rUw7DzmwQxGQryT9Gvb?=
 =?us-ascii?Q?g5qNCrLM47h+qJvFcC0ZZd1nQLF754N4raGGrc96cfNefB61R1kqPbZppsl7?=
 =?us-ascii?Q?P80sQI5eOPuqQjcOQAGemDZ3oekWk/fNuIedBn9J4YTDsc3JrzgSFMWuBzLE?=
 =?us-ascii?Q?oMjDP9MRfMbl4ZaAjlstazzhmjqTq+D/+KYd0GeZy95zKWJ39dp1c1Wr17y+?=
 =?us-ascii?Q?4+UsLSvjYTyKUmDpgJ0RQr+TDRQhG+Wi0ZgfaWoyAYosD3QdCznLgcr3mz82?=
 =?us-ascii?Q?f1sBMxn3mKP0rKJzbZTJaTMUG8DvzFtXtf8jqr8oG31u25vmcMaNSqE+k8IA?=
 =?us-ascii?Q?+iKZ1Zy7NF/t9Rhr8L1FG76lrEF/6QOAi9i6Ao7pjFvb1DRH0c4/p3Vx+ggN?=
 =?us-ascii?Q?22RCUYi+uRFnN/SOHuOs0FJI/2rpEkCnz5Qc5jxk0jpyRTzPHcqEJK+J9mQ2?=
 =?us-ascii?Q?IR3UgGEe0TOZMHtC1/AgCoCohgbSYZGo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFQLMXcGpL4LhZtuXD+VkwBDOrRYI+aKj8XElgnQ/gMy42WwKw4Pkha2e+b2?=
 =?us-ascii?Q?mFYCuSVxI525tcvsJP7fw5PoqoYevBBImYnVQpUBa8nez0ctmj+lpQQdQY8a?=
 =?us-ascii?Q?8H84wSvEJZ0ya4mf79hoR/pDyAgwsLftDNQpMm2OEONSEILWLYBVx8+0grcn?=
 =?us-ascii?Q?N+ILqMpyrhiEWBt5CjbAj/E0N2+WXH28JwVEJQta/RkWSBMGAwjYgEftyUEA?=
 =?us-ascii?Q?qr0meSUrVt322WC7UkXMpBO2G7+s+kU2575AgINMeKceWpWlhk8zjwiU8Cz1?=
 =?us-ascii?Q?N+CBY3XUfOmcOp4Ywo9gSRZZDgStoykp7eBSi22zm5qVPV0NfKRXpqHTfjPT?=
 =?us-ascii?Q?Io7Km8yjNGdmc0+y0hNlr7YtoUYKJms0RwcGIULpyevjpHyOCrX2vQSToxSB?=
 =?us-ascii?Q?+yarGqupUuzxK+hwvYHilDX8VmtMEZMt8JVQ8y6F3ySIek7UIIjaP70xwxOC?=
 =?us-ascii?Q?BcJmAtuH6I6p2AZHGhpKtvbs2YG9qUieOcvQDq99e6372qZVsc+c4tIFAa7g?=
 =?us-ascii?Q?S2M5fKo+2e10n0qXWvSMGre774/eR7os8GBfpBp1iwKAV4OwjUDYYiI+e6wM?=
 =?us-ascii?Q?dTB/UiVi4oblFtaUvdwa2uzx7e3H0CkGOmhcuyLHqTtpstPWECVgnUT4A0PY?=
 =?us-ascii?Q?XCSQxUb5jSXQdIRd7cscJc7Ks+dB+DIpu564VhcqobNUrrCSSZ879vxUz0lK?=
 =?us-ascii?Q?zg7Ip+uyOBDbzPgBqhgdhUiJAi2zE8So2yhLu0QA6AYRh7Smy85SPAKBetn5?=
 =?us-ascii?Q?9E1+AEW0TbLtq7eVZCFiatM23AS2+kzsiZpYpHp9ofKvgjJ2VWn95nzwV+Yw?=
 =?us-ascii?Q?XmrVeGmvYPT0jkZZq7leaZrKVI1DR2SPnwXee8q/H5xZnvP7RTpDbYtf0ttJ?=
 =?us-ascii?Q?mTchoLFRSe9JIwz0UU6aXfs07jpWMz+uOyr8jsVyGO9wXMY24Svqb1BILqtq?=
 =?us-ascii?Q?1efHkWx/IDRU0ahXDHDuUDYgOJVVpF5kXjyCZAiNaU6tdiz72+u0iX/qNyVC?=
 =?us-ascii?Q?4r/TcooEIdCwFH+7LZIdTeDmlsVsjthFK/bsAKn2r6u2YKzxfB6rEQ0z7R71?=
 =?us-ascii?Q?d81/p9n6ZqXPLyRqCjEy4vRizds2dGGrXNbc77yJU+s0PhCQINsxkJctpEHO?=
 =?us-ascii?Q?CCig4egNa0EMGHGj/6NrClSucDkbcycjmqReGRkNEWi11O2K16JYdFZ+4pZj?=
 =?us-ascii?Q?8vM5y+24xti6NAIh5DAC50VsnRElMJozwZiF9jL2ogWaAXNpuYGSKZPTJmFu?=
 =?us-ascii?Q?b21RcBy+I20pJ0dyY0JuPStYWLCiPLeXIV/oGJPftNCJjkmn1kdiLGujjTKQ?=
 =?us-ascii?Q?4nPAlx4wAEFz8v0HrQC7RIyOSWWoPPcTL0jv16v4i/Z1iIHIB77xesPNYRi3?=
 =?us-ascii?Q?5bbqBeVel5JDCGZNr7qwpD7uh0GHF3QR1yuTiqvysDLM+3XieFceOJBXlHCx?=
 =?us-ascii?Q?XT1v5lEKk9YLWczxSZsSYVtSFwANps9LjL0mF02DTUavH4aDoB2z25w0/t1n?=
 =?us-ascii?Q?NTaOyVBqeWBCNur7JdS+l6KzIfqqx2v5EfIhHr54DAI5QPkWd1rOkLMPi36V?=
 =?us-ascii?Q?e/UMbMLQl94J9Mlvd0ScPQg+bYtGZpWUQej1l/rYWTg00ETE92aRtbAnhPaV?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M0UFbN/Dl9heviRGqGRzQWVf28cvmn/mKiEdJcM2YwmwJI6zMuDzBM4Y9Pe6/4TaBhoP5IQkNx842484a/GbphPKwHQRp75JJS8wojz7uvo+CnF5HRBvHcYNKr5pL98q8tah/pcWxN5J270lNranVNlGmmCNbkD2a0R5dkFZAtG/qe/IykUkT+iGpvGrqYcPrsR7t/MyNVNB79qYIIOGklRLccDk/dstSvp9O4FoVPNXBnMidA8DW1STc4Ydc3bGOPA5HpUPOMhevM98UjWXMl+LRoTllSlNy4n5JT2gpdpAbeSbps9DiQ/da5rFoH008kNNaH6hhikkWmR4B+dD45X1rI+NL4gh5ILoNre/srkPflaSGpCk/8JI0TARk1aaj0/xaejVUqnO3xdQGMhXpCpvJqHbIVqI4TXBbjVPA66Hwy6/4luRPkdkt2wnwzJlg6hys88QaodFq2dz5DGFEm4hgainyGwqGMtAFYbqJIKZ8c4QLcsMZ8UaCLOWS/sB52RXshI6oN37vxzxnZkA0Fn+b3aRpD4UQcCnFbMy+zeS2Y57gDDA/wbuMS11lXkjzUNIYJKlxTOSeGEaMDf2Jtj1UjxSpH1bxWQcvAs6Eps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832f4dcd-033b-47b8-c2ba-08de3b95544e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:28.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcM9LlKEf5c3bE8UGPLZmxtCVhHeF64kaSBy6O6HHg06t/Gh6tyQ7WUm2AIZctrTcjNNf+h+Hhi2v6MASy8D9GF6PPP0qs74HyuqRJn/Asw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=693f935b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=nhvTsVnh4RFXrASZcgsA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: Qk--z39Ozf1lXmY6nO6MJD9yfHTI9qlm
X-Proofpoint-GUID: Qk--z39Ozf1lXmY6nO6MJD9yfHTI9qlm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX76317XWyGfPk
 jhZXithzTwHmchs/qTtTYuF1VTIRHrO9MCTM9Pw2dqW4ORqx0qZ5qVz4wu5+3prT8l6p8FbzkkJ
 vjDR6/A7rK58Zg8TsagcX9wJFBuuNGAgQqSEqVio44JcTZhCc/4X6QcgrV5CcLKxE9ejC3bXCyB
 6Ja/xYP0FlKeO6EmLtZOcV4a8ilrF1DfXxybIqsoYF0Sogpbs1KSphQAipCgipByX9JlUFeGl03
 HPmSp95BSC0tna0worR3o1TvgPQd698Z1txMpR8LxP/YqY0mIH4oArRchRHip1UjQ6kUuwj8NKM
 PGyvmIBpoOFShLrU+JvAB4XXDHBrLUg2qD2S5lyI9QMbmSDH6IxEQRl+KV/QslOae+974a3cBWp
 lhBMDTT5Fk8cE76HxSSUBE/ruvJbboJc8Si7QLGQo97VqKSBLO0=

Extend __cmpwait_relaxed() to __cmpwait_relaxed_timeout() which takes
an additional timeout value in ns.

Lacking WFET, or with zero or negative value of timeout we fallback
to WFE.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h |  8 ++--
 arch/arm64/include/asm/cmpxchg.h | 72 ++++++++++++++++++++++----------
 2 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index d7a540736741..acd01a203b62 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -208,22 +209,41 @@ __CMPXCHG_GEN(_mb)
 	__cmpxchg128((ptr), (o), (n));						\
 })
 
-#define __CMPWAIT_CASE(w, sfx, sz)					\
-static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
-{									\
-	unsigned long tmp;						\
-									\
-	asm volatile(							\
-	"	sevl\n"							\
-	"	wfe\n"							\
-	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
-	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
-	"	cbnz	%" #w "[tmp], 1f\n"				\
-	"	wfe\n"							\
-	"1:"								\
-	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
-	: [val] "r" (val));						\
+/* Re-declared here to avoid include dependency. */
+extern u64 (*arch_timer_read_counter)(void);
+
+#define __CMPWAIT_CASE(w, sfx, sz)						\
+static inline void __cmpwait_case_##sz(volatile void *ptr,			\
+				       unsigned long val,			\
+				       s64 timeout_ns)				\
+{										\
+	unsigned long tmp;							\
+										\
+	if (!alternative_has_cap_unlikely(ARM64_HAS_WFXT) || timeout_ns <= 0) {	\
+		asm volatile(							\
+		"	sevl\n"							\
+		"	wfe\n"							\
+		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+		"	cbnz	%" #w "[tmp], 1f\n"				\
+		"	wfe\n"							\
+		"1:"								\
+		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+		: [val] "r" (val));						\
+	} else {								\
+		u64 ecycles = arch_timer_read_counter() +			\
+				NSECS_TO_CYCLES(timeout_ns);			\
+		asm volatile(							\
+		"	sevl\n"							\
+		"	wfe\n"							\
+		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+		"	cbnz	%" #w "[tmp], 2f\n"				\
+		"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+		"2:"								\
+		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+		: [val] "r" (val), [ecycles] "r" (ecycles));			\
+	}									\
 }
 
 __CMPWAIT_CASE(w, b, 8);
@@ -236,17 +256,22 @@ __CMPWAIT_CASE( ,  , 64);
 #define __CMPWAIT_GEN(sfx)						\
 static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 				  unsigned long val,			\
+				  s64 timeout_ns,			\
 				  int size)				\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##sfx##_8(ptr, (u8)val,		\
+					       timeout_ns);		\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##sfx##_16(ptr, (u16)val,		\
+					       timeout_ns);		\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##sfx##_32(ptr, val,		\
+					       timeout_ns);		\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##sfx##_64(ptr, val,		\
+					       timeout_ns);		\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -258,7 +283,10 @@ __CMPWAIT_GEN()
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait_relaxed_timeout(ptr, val, 0)
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.31.1


