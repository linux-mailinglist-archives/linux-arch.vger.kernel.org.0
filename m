Return-Path: <linux-arch+bounces-9613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5BFA03753
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 06:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411DF160FAD
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05D158520;
	Tue,  7 Jan 2025 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="om4LrtRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NbGvYn/C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0266A95C;
	Tue,  7 Jan 2025 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227505; cv=fail; b=Ymr0rRw7K7JEZo4/LtrvGiMyVKK9urpQ/JJXhgv2iEGEjeVChmw+1h+uncu5PaNzWvc5SOB2E8aSUoDKQcnvLe45QEgQNmNe1g9Z8UCJ0mSf9h/5EXYp46u+qvBmAfJMhcf0lA/gRVNE6SDPvi5xriCKtO8f3vTVheIYlvbZ4sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227505; c=relaxed/simple;
	bh=5NotK9BWFMqzl8OpSHqzoxHbUQzePhV1d9imtl/Vyv8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=tTg+9YEBjFXWCqlDkw63ru+Qz1iaQZ+ONssimi3bh/uybeTiDhbhQqx+MFcvHQApKw8LY5HUEG/nUZA8NpBPt45V8gmw1Xk7rxv7UcT1Ac+WKXNZZrMKc6T+oLKiAncIB43vMMk1u19Jp5yhD9FYdWkYGziaMOuCEExnqFoFdkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=om4LrtRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NbGvYn/C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5072tuM7008338;
	Tue, 7 Jan 2025 05:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fptIRt6q5Ok79vSCEF
	PO7UBR54COSOhTRnhWaB2u5EM=; b=om4LrtRlA6NnipBdLQ9p4uFEthqZ2Zsoy0
	cpRUb8BTc/A9V7TAqdJ8Rr7TqrNAooseI0XG3kFhCa6Z6X+5omEQCiIENsSCVT1a
	m7I3MF1WBKkNuW9oLiv2x2rRCE2QefQCYBkkJReMDaDCVDcNXXEnh6DQSk5MEOyl
	NlMub4+rb515G0TmFPwG74uNtVDfQsRGMpRwFilWuif9upNWbABXyzUIGZd83U8c
	F+0sepm/kS5hizGkHM7tNroevx+XrK4UdgQ7p72k2wHxf+cLOdNHgwrF8tL7qUo9
	JvSCNAtM1s62R5SErv1r+Z6hdJuqiXTAQQkZACIXOXwtS2F36CCg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus2bxe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 05:23:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5074iKaa004858;
	Tue, 7 Jan 2025 05:23:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue82yqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 05:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRSlFd91cfHECPJzPZqyDx4/nyS81FKPdPcTQDsGL5ubn6xGTeLap78G/0aFOhJwP83JoBw9yGwJNSfN+jDjFQsBZq3ZUKov92CY8RMXRl8C+WSkbxEMRm3M/1zJDGrA6zrRFOrQIMpC3S2XbelcYmHSuwUmoD9pb5ByBTBXrxz4Ie5LEY+aecQqAh4B17YAc4C/fY+3OtzTdQIeptxTIhEvnX3tH6lCfxczgbSepB1hFrMHdp3d8qkTCxQVBuApaUA7vHja3hsdmyc8qqv6ekav/cSk7Fc0TPcRy4Op57eETmZrBmtp2SrvB8/zk6drAoJ6Odh3S3YjBVWVJ3ygHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fptIRt6q5Ok79vSCEFPO7UBR54COSOhTRnhWaB2u5EM=;
 b=g1r5Zjm/yjEBcM4GqfrxqWAIxGEpq6nwqkJKbxW/n5+iUgH5n/cF1TEKLZAibSscWjmPbvFbaLsX7avxgtggPFAwV0C4hh20T3vwFqeyx9Hcx1j0E1JwZoIcQo+kOtKhmP4MV+zh9sicOYKGMwlBU+ZxMcPUxdDsBSMzINc5gZNKucfBDxKF0QrW/bdS3DJOk/wwjjrTtbuVHbiO/zXskhmGkeEMnJoXnVDRRlOrc4k9rDrk5qZZJVOVB9S1SpbWd+AGG4OsTAxHBD8H+CbSH2sqIbKGVTABQFmjt3nGb6a5dd62bgTLGm7nq5rvJH0B4V3R5NOZ3/GzDoxvrqK6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fptIRt6q5Ok79vSCEFPO7UBR54COSOhTRnhWaB2u5EM=;
 b=NbGvYn/CwUdb8uKQXxoFRfR5OgKQEPaImRM/2zBe6Gtosftr3Ds2BpM/eTlZmMO8TWCEjdb25KmBddbiiCCFpgvGp9OHxRmXx1nyIwuo6vW9JmTjp10KdYb9Ozjz6MbBB2AJmYr/3EveE4xe5eMNlY4R0XbWjdNO1kW5gJ2bQ5k=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 05:23:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 05:23:46 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
        lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
        mtosatti@redhat.com, sudeep.holla@arm.com, cl@gentwo.org,
        maz@kernel.org, misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 00/15] arm64: support poll_idle()
In-reply-to: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Date: Mon, 06 Jan 2025 21:23:40 -0800
Message-ID: <87h66bdwo3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: c8782634-19ba-4d19-730a-08dd2edb7586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grHte3Y751FJzBKK+xAAcGlFq675DRAOygZUui4bjbQD+5S2/5RZDPudG6YQ?=
 =?us-ascii?Q?2iawGo+1RPlMCTuQdzTEgyqDmdMNi0TJ4CjDMw5WYTKOXbAkWaOIgg7NXHQa?=
 =?us-ascii?Q?A7ilKj0D7KsUBT13kDuH9CvHu9renWWoMhTA9ulUpPMtSkWLEncEcX4YtXtH?=
 =?us-ascii?Q?lGei5l3CAAb16ZwfH638N7mOWKHihe3SRA2/mFaIvkVdujXRPBCsyVcUnesy?=
 =?us-ascii?Q?jUQPRBnwKiovGmr1ZrqsK4B3oNaqNEL9UkeGSIgMaB+B9ufWrzrat0F+YU5Y?=
 =?us-ascii?Q?o0it8ZpSZbKZN06fbqtxqN1iH7iUClfMrzQmZYvGLL+uKZ1DRCNJdQv31jGq?=
 =?us-ascii?Q?nek/hVUlU0Lw6kmtN2CFiXWELVgvCMknNQyP2/EiyefaJOZSyuQnsl5mrrj3?=
 =?us-ascii?Q?w+GTt5D67UG75xbbHQ8HSirYrwwE1l41rN8ov9elIQHxElZWi15/BPelkLRa?=
 =?us-ascii?Q?SyBJ+xsd4jzCAqMBY85VSZrdSzs+poBcOtJnSUhVHcjWy787yPtqh+j8vnDK?=
 =?us-ascii?Q?NJ7vxFmVwJCZFzciGArf5h8LgW92ibz8WaPG8Tfn7Y1luFDgsKH4BIPbGOLS?=
 =?us-ascii?Q?OcAG4TN9mLzTxyil0mrI/oP+UJVV7zIZv45i4y3yrTMhfqr5DYHamsP2bG54?=
 =?us-ascii?Q?dAo1BYCZMNFfBFpL4TRccsxbMJvfCIyhPfAQ2gdKBfixbgbc7y+IZmfPIhBo?=
 =?us-ascii?Q?YXRFS5rbY3pLWreX+fthegSFKI0nQB5lDFTEx4NnX9Qy7ejynk1PilurV6D8?=
 =?us-ascii?Q?1xwIHQ4yh3LaoCwPW3vXG48Wii2an76NI4/2g9hjvvCzb/d67W4JjtrVbmZG?=
 =?us-ascii?Q?1bc0XRi5RwO1tdO/CJa9xpXScmymJLHbVo3etc1vKShQ03dBtVD8xr1WzIrv?=
 =?us-ascii?Q?2yz0qtu3hOUFlyV7xS01wu9o7zZDuewJWXneu25MZ+Db0ar9rMtl2KjXcIsU?=
 =?us-ascii?Q?vY/BpAZ69U4wlxxFxYCmmy7NRzrTLKX7tf3Pd9MvsfWcNuISpJUykCGNdRoD?=
 =?us-ascii?Q?mhJFYGbUMD5+XOemCGAnlYoPb5hPQtSOa+nuPOo0bUpzYfeoj45ByJJmBcXT?=
 =?us-ascii?Q?SFkQdzffQPHaTcVjKIIIZPU+Rm+dI1VtKd3MwAm1QIlOZkGroKkFM4i6Gcnb?=
 =?us-ascii?Q?PwaulSffkIVEKXzv8ylLKmMjvMIA6uVLtvDuLYQq7ix14QT3C4DGNG0j610W?=
 =?us-ascii?Q?KAqCTuznORoAUHNymsxvdCbNEto/QelZC4G6AyaDPuuLK6/SrFSr5dKXUbeb?=
 =?us-ascii?Q?PSFjoRRobw5UnFJ3YVgdlhME0+IqjVXtYHaqqbJvKycyC6O3CCOSXiw8W+il?=
 =?us-ascii?Q?kq6qebuKrx3OqfzRyxe1Fi61cfyMTPsq5CAIiNFeftVUFASu9oNYKBwtFHbs?=
 =?us-ascii?Q?uWculKPakSZnXJCZMgJObbKfOiolEFZCM2prbYyyWHutSXjIdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNE79GN7pNd0OF6NZ76LGYw4Ijdj7HXCFq3cn6DtivDPyHuOOJg2JCYbIfhh?=
 =?us-ascii?Q?J2exdnu+RwLlKuiVNZJP9bEaw6DSlfFxqWZVoa8G5a0YgcFHW+3HQ7IfHjFt?=
 =?us-ascii?Q?kvb6/WZaJSIOu9CMp4ZFPolBKzbUFBK618rwuhWh2DKo0Fhk6B5+4V7B9a/I?=
 =?us-ascii?Q?lVdzc9D0TLapltifj7rlRKUUw7RByObFUz3Otp9stxdXCnl2n2c6u8AMxLBI?=
 =?us-ascii?Q?Y/TM7jKgM4/yZgaY8q60XBcv1pvZIEIIh+ReJqCHRdVEY8XMexiEBX/t6O2c?=
 =?us-ascii?Q?xzT2AYOS0Q4OZ/8z12rMlp67qtEfhLkOf30HfWWJlC+/9p3LZfJkU5R3pfVU?=
 =?us-ascii?Q?PKs3tq/NeaJ6D6+bJrEBHNa/wT7QhqPqDFgkG1qVjVDqdPuAlaC0pA14qJ+b?=
 =?us-ascii?Q?XHwPgtl1WIuxQSTMxCj/iw5Cmd3kUC8wG40I3Q/9YpmNpKCB0xu6OIuOiD6J?=
 =?us-ascii?Q?HYodgsNAtbXBfIG49VrTTFUxwEx2EnU+T3hJ130/4XqFqMcYUMBE1WpRMbnU?=
 =?us-ascii?Q?YvkgS53y3+P+QoVN3aUqdl3LKQGU45ShbfngU80k8Hs1Mgpfnplkc7+ZT6g9?=
 =?us-ascii?Q?zXTDhtVMORh7FldfdugzlUNYt+mlmPoX0OAQLTepfzhsnI70GXLa7ike3MMm?=
 =?us-ascii?Q?fVfxN7BkO9t8XFrn/joQ/18wv0r6ILQ9MCvtMkC0T+fstD0YwNGYtUB3S691?=
 =?us-ascii?Q?dQIRHKvtwH3Cx9G8O275d5ed5BrsD5MOkp+xJxq0LmMxv8TrVC/3m4UNwAgU?=
 =?us-ascii?Q?peMANUnMDr6l3MRvxQYxH9QIGi2QJaJkNWOFHtt0LhCRD/WVpyauj7YlhUBg?=
 =?us-ascii?Q?Py9VorTIOIFFctiLBj+XPKw62nhyAmrMmHujhyfGOL6+FRMhamJZ79/FNpBa?=
 =?us-ascii?Q?KQsxiILGKiVKY3EvE8pnuVeGWk+PENwzkobHTSivdBfugW23InmZWKKyI9Se?=
 =?us-ascii?Q?Z/xo7OJdngSz2AXdj4ue3F/Q+nGnag071nJV2YLAQIVSkmYnPBPHUWo2nKl6?=
 =?us-ascii?Q?kKUnwYC3VBOTGF7cc7OOBV7nCnC20/thu5TkiYQj4PF3FzmwDpjes5i1XfPV?=
 =?us-ascii?Q?8W8lTnrrPghqbZ5jk9BCQ2jpmr2ssrUGvH3ZREGVhzsKj410rfwnnTVGdiw7?=
 =?us-ascii?Q?wC6OpQ9bwTkQHyMF2E+UqV9w5kQFCQxhhc3fbqv2wyRJWSsOGVRb+JdacfCi?=
 =?us-ascii?Q?jmAgIrgvtqKBuFx7ro57XAo0qFkBH0RHFODlWp2ppgp32v7MJha/Vj1RmRNn?=
 =?us-ascii?Q?qhdRF36yXqviyMThyk0lWf5ER2++XRKyodfQ0UxXUBssBHqHK2Y3OYYJ6QzK?=
 =?us-ascii?Q?0gdc5P3W1RuTql7p4XziyaKYcD6cPzyvpWjVrW3gL1HDWJvGLIKlFA0bmo3t?=
 =?us-ascii?Q?p0qk7JuDpSamY6V/7XHDcGn2bjROABJRshWaKwFglXf9opSgLESNap8oXF37?=
 =?us-ascii?Q?cwojvIzMqRI3E6c6CONq5qkHWyrj9VY4hYPWQgGchcadnta93N00ih6cW06r?=
 =?us-ascii?Q?rbgMpqN+8AJjM4eGGu+j8JMgTyXXUqGv5DBa8VmRkGMdV8YeSCzn63cX2UDb?=
 =?us-ascii?Q?33ijxR96jVdOg08aA2/jHqy0Emr9efqNwtnVIWI8EKtKF/dYQy6CLH9kntqH?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q0lc2yNK8BFbqVb32PyieDILa+zjFUtmj3BRj9jxxlX7qJvxj6xiMN/kS2RNicfiN87+mJhqxmBHQD3fyNmsInEKirfvj/mcTR5MFU/Tb2MAzAMSyORVl4Ee+HFg5tZee1rOB3DgCKHG6706wiYleKCVLXtP+4yeLBh0yczF4Ex/98qElzI7UiOdj0lWygSF2wMUCj9jVJHPrWGMjWMp0396d5c6o6b9PEqF+f7TafNrBFigWt/IoFkL964gC0YlsO3IhaQ7NxojeqkCqcTmeJtftZahBHLmaoWUWtWAty2+JQp8gGgS8cUrWVmr7rm7DjlbyqU5ngcNWBY8zPt26eYZHSpcxtpaHtnyk2bG7O8V92ofqDAQESgUxjZMejQiiuo5+JOYfYtGEEuPbPYfntLneWTVJ+IMhFoH34sE5lZq3tyUQIK/dCOZjQK6h8/vSk8I2kklzCKQdpGx30fIfAQaYCP34eQrXw/CFwEFizF6IgIqYJCMwzFmZRIC5SeKP64/LgrTaTgSJ23uCGSXNooHxqcN50DtypPUl/k9OEBNs67SGaE6RTRsFGr2jRYIlAVXJd1X8nsq9zeLAWlXICN7MMTLXa7OYAQe2Whx2yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8782634-19ba-4d19-730a-08dd2edb7586
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:23:46.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odkfc1giiZGreEwMnJW0fTT/fqpey7P1JmdgEZMrzF4xIWbwDv+4ew+YgMdq72VdXctTDc5NLRjRKaPA2kul1/F0BZ4EBWtcyDr/YNj2104=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070041
X-Proofpoint-ORIG-GUID: 7u35qhxai67roPylFT1MU9rxqRAUn4AZ
X-Proofpoint-GUID: 7u35qhxai67roPylFT1MU9rxqRAUn4AZ


Just a ping on this to see if there are any further comments.

Thanks
Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> This patchset adds support for polling in idle via poll_idle() on
> arm64.
>
> There are two main changes in this version:
>
> 1. rework the series to take Catalin Marinas' comments on the semantics
>    of smp_cond_load_relaxed() (and how earlier versions of this
>    series were abusing them) into account.
>
>    This also allows dropping of the somewhat strained connections
>    between haltpoll and the event-stream.
>
> 2. earlier versions of this series were adding support for poll_idle()
>    but only using it in the haltpoll driver. Add Lifeng's patch to
>    broaden it out by also polling in acpi-idle.
>
> The benefit of polling in idle is to reduce the cost of remote wakeups.
> When enabled, these can be done just by setting the need-resched bit,
> instead of sending an IPI, and incurring the cost of handling the
> interrupt on the receiver side. When running on a VM it also saves
> the cost of WFE trapping (when enabled.)
>
> Comparing sched-pipe performance on a guest VM:
>
> # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>   perf bench sched pipe -l 1000000 -c 4
>
> # no polling in idle
>
>  Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>
>             12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>
>
> # polling in idle (with haltpoll):
>
>  Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>
>              7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>
> Tomohiro Misono and Haris Okanovic also report similar latency
> improvements on Grace and Graviton systems (for v7) [1] [2].
> Lifeng also reports improved context switch latency on a bare-metal
> machine with acpi-idle [3].
>
> The series is in four parts:
>
>  - patches 1-4,
>
>     "asm-generic: add barrier smp_cond_load_relaxed_timeout()"
>     "cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()"
>     "cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL"
>     "Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig"
>
>    add smp_cond_load_relaxed_timeout() and switch poll_idle() to
>    using it. Also, do some munging of related kconfig options.
>
>  - patches 5-7,
>
>     "arm64: barrier: add support for smp_cond_relaxed_timeout()"
>     "arm64: define TIF_POLLING_NRFLAG"
>     "arm64: add support for polling in idle"
>
>    add support for the new barrier, the polling flag and enable
>    poll_idle() support.
>
>  - patches 8, 9-13,
>
>     "ACPI: processor_idle: Support polling state for LPI"
>
>     "cpuidle-haltpoll: define arch_haltpoll_want()"
>     "governors/haltpoll: drop kvm_para_available() check"
>     "cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL"
>     "arm64: idle: export arch_cpu_idle"
>     "arm64: support cpuidle-haltpoll"
>
>     add support for polling via acpi-idle, and cpuidle-haltpoll.
>
>   - patches 14, 15,
>      "arm64/delay: move some constants out to a separate header"
>      "arm64: support WFET in smp_cond_relaxed_timeout()"
>
>     are RFC patches to enable WFET support.
>
> Changelog:
>
> v9:
>
>  - reworked the series to address a comment from Catalin Marinas
>    about how v8 was abusing semantics of smp_cond_load_relaxed().
>  - add poll_idle() support in acpi-idle (Lifeng Zheng)
>  - dropped some earlier "Tested-by", "Reviewed-by" due to the
>    above rework.
>
> v8: No logic changes. Largely respin of v7, with changes
> noted below:
>
>  - move selection of ARCH_HAS_OPTIMIZED_POLL on arm64 to its
>    own patch.
>    (patch-9 "arm64: select ARCH_HAS_OPTIMIZED_POLL")
>
>  - address comments simplifying arm64 support (Will Deacon)
>    (patch-11 "arm64: support cpuidle-haltpoll")
>
> v7: No significant logic changes. Mostly a respin of v6.
>
>  - minor cleanup in poll_idle() (Christoph Lameter)
>  - fixes conflicts due to code movement in arch/arm64/kernel/cpuidle.c
>    (Tomohiro Misono)
>
> v6:
>
>  - reordered the patches to keep poll_idle() and ARCH_HAS_OPTIMIZED_POLL
>    changes together (comment from Christoph Lameter)
>  - threshes out the commit messages a bit more (comments from Christoph
>    Lameter, Sudeep Holla)
>  - also rework selection of cpuidle-haltpoll. Now selected based
>    on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
>  - moved back to arch_haltpoll_want() (comment from Joao Martins)
>    Also, arch_haltpoll_want() now takes the force parameter and is
>    now responsible for the complete selection (or not) of haltpoll.
>  - fixes the build breakage on i386
>  - fixes the cpuidle-haltpoll module breakage on arm64 (comment from
>    Tomohiro Misono, Haris Okanovic)
>
> v5:
>  - rework the poll_idle() loop around smp_cond_load_relaxed() (review
>    comment from Tomohiro Misono.)
>  - also rework selection of cpuidle-haltpoll. Now selected based
>    on the architectural selection of ARCH_CPUIDLE_HALTPOLL.
>  - arch_haltpoll_supported() (renamed from arch_haltpoll_want()) on
>    arm64 now depends on the event-stream being enabled.
>  - limit POLL_IDLE_RELAX_COUNT on arm64 (review comment from Haris Okanovic)
>  - ARCH_HAS_CPU_RELAX is now renamed to ARCH_HAS_OPTIMIZED_POLL.
>
> v4 changes from v3:
>  - change 7/8 per Rafael input: drop the parens and use ret for the final check
>  - add 8/8 which renames the guard for building poll_state
>
> v3 changes from v2:
>  - fix 1/7 per Petr Mladek - remove ARCH_HAS_CPU_RELAX from arch/x86/Kconfig
>  - add Ack-by from Rafael Wysocki on 2/7
>
> v2 changes from v1:
>  - added patch 7 where we change cpu_relax with smp_cond_load_relaxed per PeterZ
>    (this improves by 50% at least the CPU cycles consumed in the tests above:
>    10,716,881,137 now vs 14,503,014,257 before)
>  - removed the ifdef from patch 1 per RafaelW
>
> Please review.
>
> [1] https://lore.kernel.org/lkml/TY3PR01MB111481E9B0AF263ACC8EA5D4AE5BA2@TY3PR01MB11148.jpnprd01.prod.outlook.com/
> [2] https://lore.kernel.org/lkml/104d0ec31cb45477e27273e089402d4205ee4042.camel@amazon.com/
> [3] https://lore.kernel.org/lkml/f8a1f85b-c4bf-4c38-81bf-728f72a4f2fe@huawei.com/
>
> Ankur Arora (10):
>   asm-generic: add barrier smp_cond_load_relaxed_timeout()
>   cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()
>   cpuidle: rename ARCH_HAS_CPU_RELAX to ARCH_HAS_OPTIMIZED_POLL
>   arm64: barrier: add support for smp_cond_relaxed_timeout()
>   arm64: add support for polling in idle
>   cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL
>   arm64: idle: export arch_cpu_idle
>   arm64: support cpuidle-haltpoll
>   arm64/delay: move some constants out to a separate header
>   arm64: support WFET in smp_cond_relaxed_timeout()
>
> Joao Martins (4):
>   Kconfig: move ARCH_HAS_OPTIMIZED_POLL to arch/Kconfig
>   arm64: define TIF_POLLING_NRFLAG
>   cpuidle-haltpoll: define arch_haltpoll_want()
>   governors/haltpoll: drop kvm_para_available() check
>
> Lifeng Zheng (1):
>   ACPI: processor_idle: Support polling state for LPI
>
>  arch/Kconfig                              |  3 ++
>  arch/arm64/Kconfig                        |  7 +++
>  arch/arm64/include/asm/barrier.h          | 62 ++++++++++++++++++++++-
>  arch/arm64/include/asm/cmpxchg.h          | 26 ++++++----
>  arch/arm64/include/asm/cpuidle_haltpoll.h | 20 ++++++++
>  arch/arm64/include/asm/delay-const.h      | 25 +++++++++
>  arch/arm64/include/asm/thread_info.h      |  2 +
>  arch/arm64/kernel/idle.c                  |  1 +
>  arch/arm64/lib/delay.c                    | 13 ++---
>  arch/x86/Kconfig                          |  5 +-
>  arch/x86/include/asm/cpuidle_haltpoll.h   |  1 +
>  arch/x86/kernel/kvm.c                     | 13 +++++
>  drivers/acpi/processor_idle.c             | 43 +++++++++++++---
>  drivers/cpuidle/Kconfig                   |  5 +-
>  drivers/cpuidle/Makefile                  |  2 +-
>  drivers/cpuidle/cpuidle-haltpoll.c        | 12 +----
>  drivers/cpuidle/governors/haltpoll.c      |  6 +--
>  drivers/cpuidle/poll_state.c              | 27 +++-------
>  drivers/idle/Kconfig                      |  1 +
>  include/asm-generic/barrier.h             | 42 +++++++++++++++
>  include/linux/cpuidle.h                   |  2 +-
>  include/linux/cpuidle_haltpoll.h          |  5 ++
>  22 files changed, 252 insertions(+), 71 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cpuidle_haltpoll.h
>  create mode 100644 arch/arm64/include/asm/delay-const.h


--
ankur

