Return-Path: <linux-arch+bounces-14493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5926C2E12C
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDE6A4E1005
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 21:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1252C15B7;
	Mon,  3 Nov 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hwOqE8Rt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TLeSbOUn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063DA285068;
	Mon,  3 Nov 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203697; cv=fail; b=mt0NxDRQWhjq0VGVTihQcETBWjl52kGwi/ka+J088zSjbxdlmiJ/xSpip0npvmOIm/5jq90UUxTbhibkxzNHCcMkLQ00GSYqqdcMrHY5leXIS1uiQ1VAIilZr4AkWvRYJLeBq3KOIL1T1jUUWnutnF+KvkmdwxyObvVmDto4jAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203697; c=relaxed/simple;
	bh=45PNxSLwMZ6EuWc42zs0zk3B296yGpGQmyxGLjuoSgM=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=sgkSahFOMu2xeihc/YZkHWRMHcdcj+yA+11DG8bTa6H5uDNHcBNDA//g1yYwXjZFULtbJzC8VP3acRU1vUjwgnUfyH5D6VasCSGbiwrR4jMq1/RDIGcnlHU2WoCZ4v4dy3/A4+zObsiblJHATas4nL1uPO0in5f7A2VvKKLNJoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hwOqE8Rt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TLeSbOUn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KxlNA018430;
	Mon, 3 Nov 2025 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OAurcg/BZPpDDyYkk/4KiK3JUR+nhmPKERnKJxfqVvI=; b=
	hwOqE8RtfTYmaHY9MKe9g0VJTj22d75sz7PVKZs+akW24z/kJM7vWAp+22nbNZnl
	sbFTV4Fi2mGGXd4YdNZ77zVIQc6QuyNGLoGhqs7CbgFp3qLyhSHPAZS1Cx8y9LQB
	bwESbwwziKgWbZYWKVsu+a/ngfgKjgtaKAFJFqsp7I7LPO+IITcaxrIu+r3J+nuW
	bwtT6+fx4LK0g03VY18hsBUOOk9FjnOWjYMMHE2xBRUulb4ptvh4RDJT81Vp6/gK
	33g1MUrzI6mNFM3J/iQFypMR3l5sjF2GH3d0EfVjwXB/O3xZDFblgC1uOQ/+WIi/
	pJA14Fl9S04QWDhyr+h4eQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73wq8012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:00:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Ip5aP020962;
	Mon, 3 Nov 2025 21:00:46 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n8pt8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAvq9A7vVv/yI3ysTtMlLXKh7g7xTfOeK4i2bQ0zWk2bQjCOCQya5OmNoMxny+3A+QPRjmsM9XlYUK9J3dKd7THHbgg74pTcQFsCpYIojry645qAThmJWxnuVC9YbEh154YP7GP0m8gPfrp3n/PBHZrfMgmyWPUyYDrY+oH0tYkTwAvMzitmwrG99xbvJU0yH2bZ4SaBAkDfPg1kCh8ne0kDcBh7aCsbB3YPtWaLrXmvNgiDB+SwpnbK9Kvsr9cYxy+fCcP1jwJSvgO3Gna/ySYGFiM+00XRJKL1IcEHoRRmfuaHvfPTqpytKahEnINgGk2VW/MN4IPGXQS5EdhU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAurcg/BZPpDDyYkk/4KiK3JUR+nhmPKERnKJxfqVvI=;
 b=ijwlCe2vFyB0XI891JdBDbt3s0fkpAEEdwp3yYFllV8PML48yUqtW+2br16U+GfX6I/une8uYMJTOOClnAv/QsxYa7m9X5BIRJeX4zN7GY9G0+fpU/PwbAasACO3ROyZXTcHr+NryirkYWnN6wYWfAmKKyh9EVYw3ONK4Oe1Y+2kqmsIkC8I6cwmj55G6SOBmgWokG7nCOULGSTC9cqZypf2EVoBkaDH6Tt1DzxrAUjT5SfmOxJqA0y9B40m5MWJDPOUuSBp35sYCNtEkdVjkWQ39nNRwD7X/TSPS7Y+cpJpdvVOon+6g/Szw5Q23T+iTIAEKWF6Nyz/LZcKxzD97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAurcg/BZPpDDyYkk/4KiK3JUR+nhmPKERnKJxfqVvI=;
 b=TLeSbOUnHhpJlEnQ7YQ8lTZakHZoWtL0Uq5ETJhhYRiwzE6/LuIWiGofmO7EoO3QXZrLeZjUeG9pBAB9BtJR76TJDlWTsHJEbOhC34wC//xV0DGYuPL+2OU40zXc1d2X4fx69uhy8073+5H4AiNRw5s7/qEVpbAEVJSy5XyXsR8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPFF3A3AE169.namprd10.prod.outlook.com (2603:10b6:f:fc00::d59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:00:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:00:38 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-3-ankur.a.arora@oracle.com>
 <3642cfd1-7da6-4a75-80b7-00c21ab6955f@app.fastmail.com>
 <87qzumq51p.fsf@oracle.com> <aQEy6ObvE0s2Gfbg@arm.com>
 <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        Linux-Arch
 <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon
 <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Haris
 Okanovic <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 2/7] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <746c2de4-7613-4f13-911c-c2c4e071ed73@app.fastmail.com>
Message-ID: <87ikfqesr2.fsf@oracle.com>
Date: Mon, 03 Nov 2025 13:00:33 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPFF3A3AE169:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e0b99e-377b-4a85-a15f-08de1b1c0846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uyt0YU5wNVN3QlluRkZGMGFoVndUbTB5S3dleHl4ZWxWVmk3Lzljb2hGWVQ3?=
 =?utf-8?B?TEJZM0JaV1ozYlZUcVc3QzljNnhwUkkwMVVjTzM0OS9vV3Vtdi8wSmhRSVlX?=
 =?utf-8?B?c2JqdE9mYlp0NWVTV2l6UTdGQ0NtZE1TeFdJTEVSb28ra2Z0em9ObklCRFk4?=
 =?utf-8?B?S2QvWFBkc0tXTHdxckduQXdyOVlGSSthRndKejBOQmhqYlBQSVFwWUdlaWdi?=
 =?utf-8?B?MkgxaGtYZU9qb3ZoR1ZMa25BZmpyMXlpQUlyVXoydVZITWxGTkdPN0dtMCsy?=
 =?utf-8?B?VmNLTUdibkFjZDFCMmptRmFlOUVIV3JoV1RvcEk4MEVLR0hBRG5aZ3R0NXJZ?=
 =?utf-8?B?TXNnVElmQy9GVXV3WnZuRllJWTZsSzdtbjZKS2ZaeUNmSzlsWjkyemU4TU1E?=
 =?utf-8?B?ZFl3ODArZlBzeUpWeFVXTE9tbENrdnNQL1Q0VXN3M3R5eEdtWG5vNWtzUy8r?=
 =?utf-8?B?VDFvbzlyQU5GZU1jbXB3T3FtWFJBQzV0a1RuZll1ZE1aZXgveGYvUzdWSEx6?=
 =?utf-8?B?YjhHM2lXbm5XSGVyMXJLRU02U2FJMElDai9Vd0VISlBrL3J4d0E5ZGM2OXFO?=
 =?utf-8?B?dldhNzE5YnRMaVNWbGdSZXBnaGJvQ25VbGZWT3h4V0x5bnVkaHZrTFRGN1B5?=
 =?utf-8?B?bFUySkFidVl1UXUxSHFMb2RWblJDSnZuNzFHYjkxdWszbDJYYkZ0SWxkckI3?=
 =?utf-8?B?Rm4zTGw2cHVNTldEYXF6WEFTcWxWaHJEQVlRSmhkckNhcSt4WG9iZDd3dHFt?=
 =?utf-8?B?MmRsM0tCak1UZTFXZHhPR2FGOEdpc3l2REwxVTBaV1ZNYVpZUW9PT0YwOWhF?=
 =?utf-8?B?SWVIbERUVmwzK2F4TmRwVFYxa1ptU2MxVUVqdjlxUExBU2J6YTVIdDFqL0hZ?=
 =?utf-8?B?N2VzOTduY1p2NzlweTN4dGNrQnEyeWJXMWx0a3ZhN0EyaFl2OThaNVpYVnRE?=
 =?utf-8?B?SXRhODlKaE1yQTZLalNiRjIxOXo3VWp1QkQ4dDFURzl1YzFHaThObXdvOUdR?=
 =?utf-8?B?cHpydjJJT3YwUDdHUDRWWVRYNldNSFd0RDdTVldBRlV6dklwT1hmaUR0dzJQ?=
 =?utf-8?B?djhZY1hRZVAyb1hWalIra2p6dmNoM0s3NWI1ZzdqWDhvUVFuc0FPMWlkRVRi?=
 =?utf-8?B?WVh1Znk4THo4dDRYNVdKQVdYOHUydWRJZGFJMW9QNXJvc2NaRWRKODhTSWVT?=
 =?utf-8?B?aEx0WFNIVk05clVvVzl2MXZrVE9VNEk1Sm0vTHhhZ3FCRXRTOUh0TlF6T0sx?=
 =?utf-8?B?NzR2eVQ1YnhLbFpMTlQyZ3UzeWxFd2dzSTRnVE96alNrTHNpNjFaZ3d3N3cv?=
 =?utf-8?B?VDE4MUFyUGZxNmZWd3grdEdPS2MyOUFZZkZ1Z1MwYmRmSlhpR25mSC9KMWJM?=
 =?utf-8?B?SEZpV1RzTWFjRmY0ZHlMNkl2aUlhUDkyTWx0ZmZva2xZNEx4djZjRXlBbmYz?=
 =?utf-8?B?aUNFdE5EL1BnSnZVcnFCYlgyOXIvcElCN3JVZGRvYWgrcTMzZE9SbW5YYmt4?=
 =?utf-8?B?NHZaT1R4d3EyalZ3T3g4RGFPR09qbDIyTHY2ellrV1plb2dWYW5UMzNJYm5k?=
 =?utf-8?B?L3JjeUZlZVlQWDhCdVJ3YXJpWURrRE9TZmVkOE1Rbk1aSEp6SStRSzYvRC91?=
 =?utf-8?B?T1p0SDJrR2ZVYWlBc3FMK1U2UDkzUHFtRTJ1MXlxdTV3R3lhN1Z3c3BlanBM?=
 =?utf-8?B?NDZVYVpIclZ4b21VNlhHaXdibmVpaGtWS1Zhc2pocG04eW1xckRBaFdrbm9u?=
 =?utf-8?B?cUhKemp6Snk1bGcwaFJnNWVUNTVBN0NoV201NUF5SlpyaTVmQWR5U0ZoWWN4?=
 =?utf-8?B?SXBha2psQkhqOGJtZDVRVGZyQmNlbmZtblo2SkdiVHAyVlArK2wyMkhEWS9L?=
 =?utf-8?B?NHRWeGNqSi9ZNGluVU50WUQrZmFIbmtQK1B5T3VGUEh6WDVYRjl1dEVhallX?=
 =?utf-8?B?dU4xc0xLQ0lRQTBJQXBqUksvSVZEb2U0bGMwQVRENVNmRHl3dGdCa1BDQ01h?=
 =?utf-8?B?dExxd1RiSUNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlMeFFvbTdsQUp4VWtnQzUvdkdRSk1QVEFicG1ONld2VDd5TVNod2wyWjNU?=
 =?utf-8?B?cHdhZ2pMREpCQWVBaU5nRTFaekFZUVdzeklsZTczY2pCcExLVmRJcGNneW8v?=
 =?utf-8?B?dWs2U3pQSUs4aFF5ek1IUzJZb1VHZStZTjVockt6UVdVMFdOWllrUE53Qjl6?=
 =?utf-8?B?KzBQQXhvbG8rVDFYekNFQUVIb0x6a0Y2eE1oRmFhU1JKMzdaRDdWNzZvS0No?=
 =?utf-8?B?YU1xZ2FESGlpTUFyanE0by92bmxYQzFEUTQwWVJHNEVOdVlpSVBSNXNrRnpy?=
 =?utf-8?B?a2hhdUR1RnRadm5uWGRyQXp0R3dVQjhvK2l4MHQ2WHl1eVU4T2NMUDk1N3pJ?=
 =?utf-8?B?a0dHNFIxd1FlUjZBTGV0R0JtT0pRWlZiVkd3a3IwOHp2czN5V0xLNko0a3d3?=
 =?utf-8?B?RGlyN3p6d0Ztc3lpVURLZE82RlBxTWJBNHdPNXNRdVJ6QlBuQkppT2tMOVBh?=
 =?utf-8?B?bWFuOGtnTXFiZkI3WjFkYkM1N1htaXFKUzI4dU9rK3NoUGF3TE02bVVDTWRJ?=
 =?utf-8?B?MDhmOUJzeUtRYWh3YnJocGV6KzVuREhnOFo0SnowM3BsY3g5RHUzZ3R6Q1RF?=
 =?utf-8?B?SzErUGI2MFlSQ0JuSzBtcDBOemZnMi9NV1A5Yk42QXFzUW5nekMyME54SEFV?=
 =?utf-8?B?SGlwKzcrcEJzL0Q5UkU5OEF3WG5nRmJTUG5leHQwS2hjZlhzNGgrTWRBUk0x?=
 =?utf-8?B?aUNyaHF1VFNYSmNpSnNnTHZaekF4RVdhQURaSitYUVIzUVlWeDA2YitCMnNS?=
 =?utf-8?B?SXB6bTloblJGSlBpbkFDKzUxOTE1c3JUY25YUmNOWEJEVWk2MTlDUE80bFVB?=
 =?utf-8?B?d3NUWThIbTdHRG1DcnlWbHJDZ0ZWdFFsdjVFUVhiaC91aG9vVWVzaVFaRFk5?=
 =?utf-8?B?S0FQbEFGa1IxWHFFdjBmWTZNYW5xRDVRQWZwWmV4TWczU2pCamxwbC9rMW83?=
 =?utf-8?B?bmQ3OUFNWW8vQml3eXdibytZd1JNYUQ2aFlnd0srWmtKL3BLUEFtZGNMT1Nn?=
 =?utf-8?B?b01aVDlVZEV1b1RLWkgyK1dRaXhpVDhzd1hGWnVIa3RpNVhKSVRHYjc4dUhV?=
 =?utf-8?B?VGRwNjlGMTVWcUhlRFF2Zi9ac2VYZXNSQnBuMXFycjRrbFEvUUlXcTl2dGVT?=
 =?utf-8?B?enRyeWFNOHd0cldGS3RwbjZQZ3ZpWmRTRUdnNFMwdDVMZnNYSHZtSk5QbXk5?=
 =?utf-8?B?OE14U2IzRGY5WHppbVhvTU1EU1RRUzZXU1dRWFRCeTZaUllVOFJPZXprYjZT?=
 =?utf-8?B?WFE1cnc3Q0cyd1l0QTdTTXd3UGo5bjVHVk9ZSVdFbHBndUs2MlNGNnM3MGZR?=
 =?utf-8?B?MElVNkQvY2FQbkJ5bkU3cXM3b2hRQkVwWjQvTisyKy9ZS01OVHZUemVveC9L?=
 =?utf-8?B?S0xxY2Nrek1YalYzOWtlQ0ZKdEx4UEFWNUtFamp1UlhUTjJ0SWs1Nm9rc0JO?=
 =?utf-8?B?dml4QTdkRisvbFpJaGtmQzhTbVlyWjhlUncyRGFLcXdNM2xyTlZWd2JnUXhT?=
 =?utf-8?B?cGg1RkN1YUhKUjBMS1RSeWt1QXdkb1VmYzRGWEFtQkRBMjR1aFpzMkt1bTgw?=
 =?utf-8?B?anBaenI2SmpHT0p4UXpMMG5KVkFmTFplZDlrZCs5cTJIZGlucFYrdmN6V1Uv?=
 =?utf-8?B?cW96L1RMUXlTZTJPd1VzSlcyT2xKdks0OUlOL2MzcElRK0JqQ3dCMW11dHhH?=
 =?utf-8?B?TEN4WnJWWEJmUHcxQVZiUkZhRjNNeWN3eWZIaERVenE2RjhhOHN3ZFhmNUR0?=
 =?utf-8?B?ZUJIOFRnbkkzb3ZQdnRSMnVjMFpjQWJNcXcrVlJrT0YyRTVRUWxBR3VQK21o?=
 =?utf-8?B?SDUrcDBzV2xvaE1xQjVManBUbUlEUllJTU1SZHg0bWt5QkZRR1dtdGliWUJz?=
 =?utf-8?B?eTFtMmpwRS9aSmVaR3RseUh1VXNaQm1haTNCcjUyV1ZmSG01QTB5VU1sMW13?=
 =?utf-8?B?TytMTXJTR21Rb3MxTFpYd0VjV2RLUnFxRzhHSDdmVU91aTdHY1pYMVNOWWVq?=
 =?utf-8?B?d3RleFlmMEo2ZDgwa1J3UjB0OFM5VXlKUU9aUGJPUlQzTnE0VlpLRlpldzJK?=
 =?utf-8?B?amM3RFBUdzkyQ0VUZVNVKzk1Zk42OW0wUVVRdFpzU1ZoSWFqd0YzcjZhYUN6?=
 =?utf-8?B?anUxNTVjWmptdGE0dHNOMktUYnZUUU5lUEhEODg5eSt6c2lXV3IrTkw5cEhv?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9j/M7z1076CJc2ExenlEeHfQfaH8kQcDkGOFLEQThgkJn+vY9D/EQF2KKV9+x3ohdzK22rNeU0kIsnDYSwZZNwUzZS/PygGTBVoeTYpN8DTirmGrvHkdMpG15hvhduuxzPQfepw/8zQd01/rPtpp4QHQq50a/z5SXI17QpuuGTqs+eLWoxQkQPdtijk7jKLypv1e/l6bDQ6gwRovEuXOca7/yAV/2KJD/mTOK3Fl+mCEqUTOklYAHD24FZKI6Ewka7wvlTOM9Tl9QKUeFGqPfzy00e1jiKNIDOCiwF4mX7wvAcZA0h5mMBVgzRObqEwpsw8p6EeXuXC/KpB2gVOtZSA2ZG73tRJF67PaBb1AT8kAvWNcI6rTQzMvjCXHIaFlCeuCBhPvN4c+zSL8QZgXWpGZ7Pr4J7XlwRxSrGdzyNJF1lTF2MK5zVUExkcDc0PqOHBvKTHe7Jno7TZpK3Kz9ArqZszErjwM9tP/FjTRUJN8qQMGAxrmQVIqg4y3UaV68qnlczWVQkr1G+jeVl6hahLs5W4SFsbaoTPRoRzXjxgBLV4y0117De4sg+zs2Yh5jSR3NJfvPDngZOOTWp2OOQ8DklNsQVNw5rkvY8wGH2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0b99e-377b-4a85-a15f-08de1b1c0846
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:00:38.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K47HlQoVqURps0niTKNhUXUBI9bLFT6NcK8hPHm26Iq3NzEEKrI6Wf5vsd1HKhbI892RRw+jQnDB6dIFzi8HcRzcbHi9YH8KGc8R1LHhn1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF3A3AE169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030187
X-Proofpoint-ORIG-GUID: ZJg3Nr-ijcEAeT6TenSWrEc2ffQjjmIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4NyBTYWx0ZWRfX/JbP5P+ov0wn
 3LW88rdc18+WppshLAgcsI48llW4nFBTDBJVBi5KPSFxAnvBDbvQmaQtTn8fworarHd9L+SmO40
 hSW+uOFk/ZIPM4TA4Vktam9h3BCxpIBM2GI0/AB11gDHQPFwsWdcglLTeu9/cnExVVuIoJDmKvQ
 KKNU3PuEH5bdL0MU7r8N8efmCSQHCwKKYmHSrzk+k04+18QMjr3B0LkwQWRLkLSdbndLmmTIzXQ
 1duxhb/9U+C6Iv8KaHdJ2D71W48EfXvsSFP6mD28nfh5Za/H2b3nbdqFIB7/8Xz1bU7C2hAmndJ
 X+hrhk6dtr1QsRZboVAmzfSgaNVQKUE/AtXtPfbd8KLBFx6c+xL01zoOcBx6H+PXkxaTk2vui1r
 w4+rA80RMUAZb08rQwwtx8o0qfTpRw==
X-Proofpoint-GUID: ZJg3Nr-ijcEAeT6TenSWrEc2ffQjjmIk
X-Authority-Analysis: v=2.4 cv=Ft8IPmrq c=1 sm=1 tr=0 ts=690917ff cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=aovI93sUCckBJ56wFnsA:9
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22


Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Oct 28, 2025, at 22:17, Catalin Marinas wrote:
>> On Tue, Oct 28, 2025 at 11:01:22AM -0700, Ankur Arora wrote:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>> > On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
>>> >> +
>>> >
>>> > Since the caller knows exactly how long it wants to wait for,
>>> > we should be able to fit a 'wfet' based primitive in here and
>>> > pass the timeout as another argument.
>>>
>>> Per se, I don't disagree with this when it comes to WFET.
>>>
>>> Handling a timeout, however, is messier when we use other mechanisms.
>>>
>>> Some problems that came up in my earlier discussions with Catalin:
>>>
>>>   - when using WFE, we also need some notion of slack
>>>     - and if a caller specifies only a small or no slack, then we need
>>>       to combine WFE+cpu_relax()
>
> I don't see the difference to what you have: with the event stream,
> you implicitly define a slack to be the programmed event stream rate
> of ~100=C2=B5s.

True. The thinking was that an adding an explicit timeout just begs the
question of how closely the interface adheres to the timeout and I guess
the final interface tried to sidestep all of that.

> I'm not asking for anything better in this case, only for machines
> with WFET but no event stream to also avoid the spin loop.

That makes sense. It's a good point that the WFET+event-stream-off case
would just end up using the spin lock which is quite suboptimal.

>>>   - for platforms that only use a polling primitive, we want to check
>>>     the clock only intermittently for power reasons.
>
> Right, I missed that bit.
>
>>>     Now, this could be done with an architecture specific spin-count.
>>>     However, if the caller specifies a small slack, then we might need
>>>     to we check the clock more often as we get closer to the deadline e=
tc.
>
> Again, I think this is solved by defining the slack as architecture
> specific as well rather than an explicit argument, which is essentially
> what we already have.

Great. I think that means that I can keep more or less the same interface
with an explicit time_end. Which allows WFET to do the right thing.
And, WFE can have an architecture specific slack (event-stream period).

>>> A smaller problem was that different users want different clocks and so
>>> folding the timeout in a 'timeout_cond_expr' lets us do away with the
>>> interface having to handle any of that.
>>>
>>> I had earlier versions [v2] [v3] which had rather elaborate policies fo=
r
>>> handling timeout, slack etc. But, given that the current users of the
>>> interface don't actually care about precision, all of that seemed
>>> a little overengineered.
>>
>> Indeed, we've been through all these options and without a concrete user
>> that needs a more precise timeout, we decided it's not worth it. It can,
>> however, be improved later if such users appear.
>
> The main worry I have is that we get too many users of cpu_poll_relax()
> hardcoding the use of the event stream without a timeout argument, it
> becomes too hard to change later without introducing regressions
> from the behavior change.

True.

> As far as I can tell, the only place that currently uses the
> event stream on a functional level is the delay() loop, and that
> has a working wfet based version.

Will send out the next version with an interface on the following lines:

    /**
    * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no orderi=
ng
    * guarantees until a timeout expires.
    * @ptr: pointer to the variable to wait on
    * @cond: boolean expression to wait for
    * @time_expr: time expression in caller's preferred clock
    * @time_end: end time in nanosecond (compared against time_expr;
    * might also be used for setting up a future event.)
    *
    * Equivalent to using READ_ONCE() on the condition variable.
    *
    * Note that the expiration of the timeout might have an architecture sp=
ecific
    * delay.
    */
    #ifndef smp_cond_load_relaxed_timeout
    #define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, time_e=
nd_ns)	\
    ({									\
            typeof(ptr) __PTR =3D (ptr);					\
            __unqual_scalar_typeof(*ptr) VAL;				\
            u32 __n =3D 0, __spin =3D SMP_TIMEOUT_POLL_COUNT;		\
            u64 __time_end_ns =3D (time_end_ns);				\
                                                                        \
            for (;;) {							\
                    VAL =3D READ_ONCE(*__PTR);				\
                    if (cond_expr)					\
                            break;					\
                    cpu_poll_relax(__PTR, VAL, __time_end_ns);		\
                    if (++__n < __spin)				\
                            continue;					\
                    if ((time_expr) >=3D __time_end_ns) {		\
                            VAL =3D READ_ONCE(*__PTR);			\
                            break;					\
                    }							\
                    __n =3D 0;						\
            }								\
            (typeof(*ptr))VAL;						\
    })
    #endif

That allows for a __cmpwait_timeout() as you had outlined and similar to
these two patches:

 https://lore.kernel.org/lkml/20241107190818.522639-15-ankur.a.arora@oracle=
.com/
 https://lore.kernel.org/lkml/20241107190818.522639-16-ankur.a.arora@oracle=
.com/
 (this one incorporating some changes that Catalin had suggested:
  https://lore.kernel.org/lkml/aKRTRyQAaWFtRvDv@arm.com/)

--
ankur

