Return-Path: <linux-arch+bounces-10599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BAA5807A
	for <lists+linux-arch@lfdr.de>; Sun,  9 Mar 2025 04:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521203AFA6B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Mar 2025 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C82556E;
	Sun,  9 Mar 2025 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXwRQdPV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wqfIbvng"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1521AAC4;
	Sun,  9 Mar 2025 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741490833; cv=fail; b=ILsgouUxmnNYCD9WDmU7ZBIA/BMeJ3sWzxPpEniVrJE1YViunZG4ZJymJgOl1LWuqANQb2DA0o3gxZPZZzvrvYfCw2EBLPEQpNJwtL0Fe9KA1bH3TvnGgEBVf5u3ZZdlk3nOYiLt6NYGDW6XPQXn/dwGunqesP3xa9izYoHTNXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741490833; c=relaxed/simple;
	bh=cuAyYvGvmYhF/SisRbXdtBY4h8EuipaL5Peof+lkhUE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Odw/M62APPaSVe5qKDGsYtaZ8Em3DeW4cPTqCKy8fZR+1x6h/1pUZ83n9tbdDaD2lsvfPrbVh3CbwOMN/s6AsSU16OvxmazYTT++xb7WJ8iur28uWtO8rBt2jjhaDddIzpynG3nwzVlzZGKP4bNe6Fn4ntYAenJIjuvorOgQJ+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXwRQdPV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wqfIbvng; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5291pHRL000955;
	Sun, 9 Mar 2025 03:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=cuAyYvGvmYhF/SisRb
	XdtBY4h8EuipaL5Peof+lkhUE=; b=TXwRQdPV28jmsyfTjgo94PzZ/NYXCNapbi
	72TLJThGEaoVyqAujT8R+4dZzGY9F6yQTgSyLtTIzy03B3c6SuoPef6FYhclae/g
	NHJMnzyMkZoaErnZSvll6DwcwjibNsLomjCDDXqHNkbjfVAqgSwfLhMz1wwQotzz
	A7TQLKEq0XHjjkkgKvIXIPbCtityt/ka57aezbzCRFew/7DTSpo2xRfWKyifdcQS
	jkNymi8HKhaDJneZsdBbuVK4tkeFAaeA7H70d4VBa3yVkKRxRlVhoT3QZoEUh4b3
	ulzk7smkm/Fpt7sI1a7a7p0r4zNM0LBGRXTJkib98csVYSE5yFSw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb0s6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Mar 2025 03:26:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5291HsX9026274;
	Sun, 9 Mar 2025 03:26:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb6dmbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Mar 2025 03:26:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZPW8xzpM1IFKO/C3ETSU7cmiGV45Q3Uu0/DP0ztw8vxx/OsagSSLezgmtO/votKESFa6/siii9Ywznk3gK4W0hBsuTTYOJzmF6dIu8QunwajFmrBVjjurKy/AJXK3LmYU50TyRSy1Ol1+8ut5V0G4IXCpCFbZJa73Qosp+Yw+IwI75qArQNlezqIJcwkK/to5JLFEzXIs9/xdt0yFJRjBd720zWSujjObvg0QDz6giC5Dw66bRm968vB5dlg9j5unX+MPpmjOdYH0Qjy1FHIl2GDGSDdtCaU1v3E+e7x+zU4xatAgxCLXLCjnj/TopC5fc9WOoDdvUHpLKWuPhiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuAyYvGvmYhF/SisRbXdtBY4h8EuipaL5Peof+lkhUE=;
 b=Fq/CVabfcok+NTISxC3e+Zg+GTr4yEsQikTkFU5/6hrreIvKtJ9vMzY0wu64gCRtTdLa71+eN88GOsLxsi594aH+AoHWNcuZxFQtmM9Wu6YN3sw870LDZl9OHvHS+barCkc7ECcp1uvLfCGSBS5evbAHOGASau77/BRxOAJmYxTSt4joX2iIcVj93C6xwNWS0cW1F3FbSHvQqUPhYUSia3CCxuc++35zlrHq0Vey9M6wcpbRjmCf3enailV0Qh4+ftGB7kKtYEXapke1uQy9sgd2T2DbcsIk1VxQz6H/we064YhU3FnUMTqw1kzJoSH730JkmpHBwJZ9KHth9EOohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuAyYvGvmYhF/SisRbXdtBY4h8EuipaL5Peof+lkhUE=;
 b=wqfIbvngZhJj5mzbUp7XoVSEq3eXeiXpJgAhUtHnAtmxm3q9sQjLZD2gym4IDsOEermKhWDnR5T8k6P/dx+839DJMR0APOuXB5r3y9EJmSbb/ACQOinHWdvd4pgPIMLwsAQLqYcOyb7UCLAuqwnlyta3vEy1jASMk+UT1mp8ETE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 03:26:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.028; Sun, 9 Mar 2025
 03:26:18 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-2-ankur.a.arora@oracle.com>
 <Z8dRalfxYcJIcLGj@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/4] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <Z8dRalfxYcJIcLGj@arm.com>
Date: Sat, 08 Mar 2025 19:26:16 -0800
Message-ID: <874j02rijr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd4ebcf-fe39-4abb-0a3b-08dd5eba27b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXAfHqskV1pPeDVqALRErJp9VUWllKcJYo0riyk/a3F0DzOub/E8DcQdy3fS?=
 =?us-ascii?Q?7p5QdYjt6Jv/+sdttDxn1OiAqZBgmlT0nzNP3JhMHRIhlqfwvLQDgEmZQUMG?=
 =?us-ascii?Q?Ro/qOZsPXWePtvmPKXZquaBKGhIYOip978YPxNnKfFd3zk4+3OWDyGDL9nDf?=
 =?us-ascii?Q?UZC14ry+ND0mee2NRgB/yDXMDYi2mihxGyJ4kuMGGKbZocf9bWCAR0UyU7eA?=
 =?us-ascii?Q?gm3KqHcx+JX0M4Yt3hGc8o15q1Ck6R6hJ4cQUgi3t2SS00PRmzQdQUg9GCnL?=
 =?us-ascii?Q?4OJGBk3NDwqXErrw6Q+jtgzTAkw1LG2PxuAqXuSzRsaOOWudnRbaxJ/PKNeU?=
 =?us-ascii?Q?yei8nUFm3YadAXfP61HOyjkfCfN0Yk+C+BZMGWAsfKdPX2ZOW1KpVTxaoxJ1?=
 =?us-ascii?Q?U27jUtZ38A6aF9coG0J9ZpDxVVb3Wty+gpiOaOUYyXkyVzAFckJbjQjeZ7bJ?=
 =?us-ascii?Q?9gTjvfNIizSMFH9+9o8N3BBmfswHOHxPfr4eCg3Wl1mR8HrzmfHEU4gDz4H4?=
 =?us-ascii?Q?kS8LFM6QCbfc/y14KrnsAKoXrwzXT06mI5mZj/W/Xh7/5SLF9u/DTxpRYjb2?=
 =?us-ascii?Q?Qfwlp2B9JR+kE4ltqfJlXlnAj6P54bs54wEP/bz1m1R89ryZQTxHfT+qUp84?=
 =?us-ascii?Q?My+iEqhkrfzHE7oFy+MjqUJEMdHG0kuJ2SR4ErcCR8jnLxL2k7juSCtRvXBS?=
 =?us-ascii?Q?87rhfft7Vg+R6d2zBajRqHJJheTMPIatr42mALSuF9zsifpj4ONJ59LYpKQa?=
 =?us-ascii?Q?5pbg1vXnxUXor4f2JxAe8RxQCGABirxMpZRGkOuPWyOAwhz244s3eaQwflZA?=
 =?us-ascii?Q?jbsziXYDgzprPm/SgHwGSNJ4HIyrqDDjaHkxww1GLDIzhUgv9EFCuWrV8bAE?=
 =?us-ascii?Q?2dbmChThbkYZLKcKt04VOzQIyI8RGEtEKIjN8vQglLPP4HOufNf2WaVg+bt2?=
 =?us-ascii?Q?BlWXDQEl1+6/RAD4ksIQ1bqSURpmwRuE0CVMOnskKlc2SX5W8HWV39x7aK6s?=
 =?us-ascii?Q?5Hl+aod7AvYaUx8D6K38IMYzZ5rRZNmfeCTPDkoAP5Se7czP7dyxGEz0p/0n?=
 =?us-ascii?Q?BNe3TYrflYSqVS+2klKVJkmJOzlUUGBUaEmPENhSyW0K/G3VulTbqJoVZDm2?=
 =?us-ascii?Q?QzeUNV2DGJEMFHs9qUqPuHSAuKEm0GbgCVgFVD5TURcCKDQljeCTr+6K2V+W?=
 =?us-ascii?Q?WwM7VdCfiHbzL2zTYppH6hC0ASOaZ4eXFwenPmeSEDsGLh8bLTnGyJMfxfWP?=
 =?us-ascii?Q?qtSiTGFVgrqjGXOUPJDM4AcghQK1hBZG9MFvWtLzTqhkTJqAnbaXMZoSBUZm?=
 =?us-ascii?Q?cOl1NzeVT62VZ1J45wsR/SfeFFmiTb9SpHwkjcTJA8o7w768sSwXPEYIL9D3?=
 =?us-ascii?Q?1MGIAXwzhdN8nw//PDtgWwu43xBy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVuyrvAUQHsuHKzfwWmVNyfDbo+TOHszUOb+adZUmfOZQyTMHZ7nvttR5MHI?=
 =?us-ascii?Q?K1dkvL/vIy+MN9PuaVklFexwZMeyBn4i1UCOjOPXjVsNEABtSk+MGL8JhRIp?=
 =?us-ascii?Q?L0x5cKr5ja2pWbt+rA7HJ/JiRQYmERkgrruJQ5zayGYISwSzD7mmfl60Ru32?=
 =?us-ascii?Q?AZRTRcJiPhesia/tsxN/xX7dfEeIMoe0tssaIgajPxDlRnAZmmR7NkLHwBJc?=
 =?us-ascii?Q?kbfI2oFPelJTh3nT9VYPFwgTElpO0jApjJlTEI+ED/VOHzBNSQZti13YFNTE?=
 =?us-ascii?Q?ZVFYixRBfbwnY1+umr09sukna/WMKn34XUhss0s8jv0Jn0X4hRli/HJd4e4R?=
 =?us-ascii?Q?m6FeieeKX/DeyoXTJNIZEJZnUQEbTCFnAewMHLHKiEKBJuRUsEkcVFzqw2DC?=
 =?us-ascii?Q?tjgbKxexM4la062jaqzvwS0VwJO2956BWxUWzcJFAdOTCT9WxySY3A6NdlyL?=
 =?us-ascii?Q?f5MhRyd45g3jRLVqSU70Qst1tseZw84+SJc3dB3pE7rxCVlj0FX++p6ajtn2?=
 =?us-ascii?Q?6mGOFk+SeTwa+rAR19+27Tq+8FrUM6HG3knDThhpGxDdDkak7DBUmxHbLujK?=
 =?us-ascii?Q?zADl3Xry80bMuBdzT1rCITGXgAA2e0p0EjXT14/WO36NoESRLnJeuHVOfmTY?=
 =?us-ascii?Q?zm++AG5MYgjrROEyfjzffo57OjWUCItcV11fFhZsd4RxtGEfw/EnNhOoXmkZ?=
 =?us-ascii?Q?kPNF0MTGXCCmQ96QCNSmPO2ZMDq82kEQcq89bJJlcA6lbjKeQGUDy5xweV6U?=
 =?us-ascii?Q?FyJKFpvfkL88C8MOULxLqjDQGvCgkGFMuTijpcYhjekM7YSCCdUh5XKFT6Kr?=
 =?us-ascii?Q?XJD3IoI3JZW2pd2cl+7Oag0uW9jTl0raRUutTxDiUNnmZb034MimNjASMMrI?=
 =?us-ascii?Q?So1RIfcNSMpBLG4pv4KGVaYnMj+jhmGegqIk/bTmw1+PRUs/nnIQZsqwVJPe?=
 =?us-ascii?Q?mhcsdSYZMFhfuF37DPvTd99YyiPE4i3fSvrl4cdTUyTN1yMwKAQaB1d5x2M0?=
 =?us-ascii?Q?ERO+M3V84AxXFxNpn52ejYlsBP+l1ftAGnQaqrLpDlOLPPDH7zlLqQlEgy2p?=
 =?us-ascii?Q?P+YZRvHG8V+pr23KZBf25I0Hu+qStRyXSE0u/8hqNBOxl+dq1VmRSZrMzU/E?=
 =?us-ascii?Q?GVyi9VgwvWXkrp8x9ISPhsAHRfl+btaqX7kcWw6YCOprRD6FlvjsFGHdsLqG?=
 =?us-ascii?Q?BtYsxjsKAtJXfBIA8BOsduwBiiYIcpSW5MLiLzxKxSD+/tfWTNmqJTNHIPCs?=
 =?us-ascii?Q?o8L8mKH9OylrS8LZrTglRdSV08zFQDmPyMe9qL4p2iP9Lhua/FQqfCw7w8E6?=
 =?us-ascii?Q?Tkgeu6egAqyjHbjk0Sr3B4INL605gtwM3tU/GgVwtkOy1ni7uri8E3Qj0D/1?=
 =?us-ascii?Q?0spcPG2ofUfM2tHSDBiHsYGxMffjie0Q4evY3alzGN5PUe56XEb7TTajdWOB?=
 =?us-ascii?Q?E0NGnukfcgIP82BjAmqLAXAXMbv2vZprPiWNGAipLcb2scE2AmuspwpZyJDS?=
 =?us-ascii?Q?Q3DamJOpGyHb2kBpcWtsOfrvMjyOu5KWftvqbA0ciPdK80jVs3mOfsYyWbFq?=
 =?us-ascii?Q?yZMZKlKUl8XGWNp1U5Ie8YFNRIpoEVFu/sEqKq4nJfGTHhQGRxrly57wUlin?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y19xFLykC5KUe0hpM9zY2oPiFh0jGnGkZX2sSr/fUpw53DQyhcyN3b8Oyj13qWn2f2YUVFFh8pJdQYJ2YRhXI6n3sDXQmrLjpTwZWfcbR01TgxJbY82CRh8gveOa8wkz/YQmbJzLm5pbBiF9lCcB1Z3oTuZs9laQmWhFW2oMFYxprExCxkDMfhfFEEDMTtFmFfcgvCcWnlauXmUUQCUlGZUou1/Cd+BF5H18leTjmlhRF0YWOeKLxrLir0MTR45+1xpFHfpuZSEucZCZ9MrpxIMxSCvoTubNhUTZ1bG8YIXESUQGOJddOgXmNnE6CpWBUPEXEIkbJtoraa2KlpJMHRasu69j8zuXLZh/u23a/KUdLGLVE8Blr7h0aab9Alg6yEA496MJMyYl8cU12za4rXQytJvvV61KbQkNwqxO3L61lkU3HxNSU7csqmT/DW1v7FcQYpvaxAenf+RZrXu7pUyIxCfk4s3oSvWYaoZrbVAJTahQWLh/BWRSX9LdX05a5pZ4X8/pl0wU1/JJoI6UugZzhmeOtG4lg5y09FarzqrvQJv+aZXla3z6DL1Tgl4YfvP5zkO3d/3OYC9B8KR5UNge1+LYcH+AtmkYjTljKmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd4ebcf-fe39-4abb-0a3b-08dd5eba27b9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 03:26:18.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zuwjdezan3o1SstDWJqIl4QUi/NJdVdfVo9SqcK0ZplvaY7EAmy/fruGZC4CweguNpcLm2t2vzoNyvBl5nKMHR+qSc9cbxo1vtkbh5RVqG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503090024
X-Proofpoint-GUID: qsZxY3truxNtUQ2RxbyaTIlE2E32cSjm
X-Proofpoint-ORIG-GUID: qsZxY3truxNtUQ2RxbyaTIlE2E32cSjm


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Feb 03, 2025 at 01:49:08PM -0800, Ankur Arora wrote:
>> Add smp_cond_load_relaxed_timewait(), a timed variant of
>> smp_cond_load_relaxed(). This is useful for cases where we want to
>> wait on a conditional variable but don't want to wait indefinitely.

[ ... ]

> What I don't particularly like about this interface is (1) no idea of
> what time granularity it offers, how much it can slip past the deadline,
> even though there's some nanoseconds implied and (2) time_expr_ns leaves
> the caller to figure out why time function to use for tracking the time.
> Well, I can be ok with (2) if we make it a bit more generic.

So I thought about it some more, and on (1), I still feel that a too
specific value of granularity might not be ideal:

Consider that in cpuidle_poll_time() gives 110us, and we derive a
minimum granularity argument of 100us from that.

On arm64, with an event stream period of 100us, that might mean that we
spend part of the time taking the WFE path, and the remaining in the
cpu_relax() portion.

Now, depending on how this call aligns with the event-stream, this
this might mean we spend anywhere from say 100us to 10us in WFE and
10us to 100us in the cpu_relax() loop.

At least for the poll_idle() power consumption, this seems bad.

If, however, the granularity did not depend on an actual time value,
but just a representation of what the caller can tolerate (as I argue
in the other mail), then poll_idle() could just specify granularity=coarse
and we would always take the WFE path.

But, maybe you were thinking of other cases where a integer value
of granularity might be useful?

[...]
> We could add a slack range argument like the
> delta_ns for some of the hrtimer API and let the arch code decide
> whether to honour it.

If there are cases like that, then a slack range could serve both
purposes with slack tolerant cases like idle/resilient spilocks
specifying a large value and more constrained users specifying a
lower value.

However, I don't see how arch code can choose not to honour this.


Thanks

--
ankur

