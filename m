Return-Path: <linux-arch+bounces-9871-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773BEA1AA86
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 20:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37065188D825
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D41ADC89;
	Thu, 23 Jan 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KN9Qs3aR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ivt1Nrqz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB22166F34;
	Thu, 23 Jan 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661406; cv=fail; b=iaMl7WHV/xXlRM6YAg1R7pQg/00Nn6n10dFT3pGDsk5c4y0nvay8CmkN43ILIWaOL0XyiBciDypI59dWSAlZ1vRRMCBFJg6wBgE95DxbBU+hSJsekLfsOpO+OHAsRaLMoo/WTZIt0UfHOt/4mp7xHOqPV+jQTzs9xzIPTVrGVU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661406; c=relaxed/simple;
	bh=52H4/PCtaSoVA47QG+81NRt4i9Fr3VV5m5m+kLoTvt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gIkLHRlUYo+Rb4D+IzjEFGiDxbRTe7oWu44LBhiPTfhKY9JZ/+Cdq46eBQHDaYTu5QNJrzNlRFtHBDEBAy1mzZzVRCoTPzsWKlWAsF1p2X+suX3jFrbSXJsmM/C/IuqIqO2ZyO1NgiYMi5hNW/hTFwqPkOBi5kttmqNPr6hXJYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KN9Qs3aR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ivt1Nrqz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaJtS025452;
	Thu, 23 Jan 2025 19:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=DbHRHsZraAdbH8QUKK
	w9gBJl8xRnMs9eqpQPXc1tC2g=; b=KN9Qs3aR37HUARTugDaZdX0awEEc7iGinm
	XOIy6mRxkL6IvmZ4iUnicc3Pzw7riYw/823rpomIWph/Zp38pP8KJcRWNodQhDdL
	hdUSUqY+Hrugnj0PV8XQXSFuRCHhvBtecBy0lmVUdLdcJ0GpuUIdmYFaEYGK3qdL
	XRiHCTGa1w4skGjoANh9KklygkdNJsM4BjXvu2V9uf5CHyPnttTMER3WHwnHiw9r
	Oo56ecCkZklrXREQl5ufl4bW64uXKEq7gDS8KTFceb83mawPqQSo9ov/ptR95T96
	nnnjioyg+QSATJLSL8Mcf8RpmllsbykWELYVDTOejuhKfYowRz8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awufuhyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 19:43:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NJCXVQ038125;
	Thu, 23 Jan 2025 19:43:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a33rqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 19:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz++cu9koQx9p+UT07LaZXXU/+qNoMWKdJfSigAtUN+U2QycS4s80yH9tVB6PnXB+kHn0mEqLZN1GsUaD5l19asv4sTk/jN5taQ/ocnTKVJELtBp1JEutUyXFY+00mUC1RtTjQZD9CQGjtXDmQXFzCM1DMehvQIf9YDwvQtB0mQqs0+ZK4Df5o91k+CqHdrrIvhV2i6Al1p8urJgW2YbT86iYz4m/8oc7gEwD/QdO8qN2XLehZqOimuHHECl2GklTj8gwJNZe/2wo4sa9SN4mVfp3149p4fvO0jxmZD398VvBET5wFqxUCjcKCWkkbxcnWzfbYSYDfqJekMKdT8iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbHRHsZraAdbH8QUKKw9gBJl8xRnMs9eqpQPXc1tC2g=;
 b=Mys3UpX3n89fuudb5NB5yG5ZQPzC+Xno0cgehVEZOWtj1KLWosDj4n8k8OtkSVK80rYLwoSJ7bSiW1UwGb6wI0lNWqQdUy1l80TYTkwsaup4qbKqWOhwmBk9/tySYftLFCSW3wyt+gfLYnbLGxZ2ntL7aCNR0r43Ti+kSD2AwreDqJMDHNt0YC62oBv7iH2Ic7BL3otG3vTaFJVU20xD5OtAlXdu6jONgd+zdPX4cd61tGzbjdfLenMcU1tR0SB7kNemVxPetWBt1sd4f7bqLnbOJwlsR8wobppXOFv83nev01YP5HxW8K2JeaRCk3sYh15tAwoRj4JLwv00Jgi3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbHRHsZraAdbH8QUKKw9gBJl8xRnMs9eqpQPXc1tC2g=;
 b=Ivt1NrqzfVoqBlxJ0LL+gIHMgADK0EG24AAxlDScvE27jJGxEwtV7E5GLpDj1gDHXc19IMjKli1A6id0BXCAwrJPAoqQEs70Yl7slbpNyRUHhpeoyBW3cUmtCTUcNPiG5SYORtGZNMzGdbhAK4fFtiQ/ptynGF6iW2rVjF8ktoo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 19:42:59 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:42:59 +0000
Date: Thu, 23 Jan 2025 14:42:56 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <5bpibh7qkrcggyqsrathszfqrjckyaqspdons6cfkkyse4ub4b@2iu4sibbirxf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
	linux-arch@vger.kernel.org
References: <20250123164358.2384447-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123164358.2384447-1-roman.gushchin@linux.dev>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 025eab4f-5d21-4c26-271c-08dd3be62447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSLjAg3vzjeWvtTLClASdSZzuBYx+AX23lTdYusgunDa29VxuwLltS1721oA?=
 =?us-ascii?Q?mxq5XKjdYSH7g13MhK3LfeC+uZyaih+oQJsgObFta/ZK/sGTCVa9Z7flVv6t?=
 =?us-ascii?Q?6S3KF2aoTnXuY90pLxZpXQA/qV8hhwjn2pxHxdhzyHnm48fIoeYns92hLwPx?=
 =?us-ascii?Q?/af/jcfa/INoOmAcT08eiLCe8yBwvsweA/Eu0isSLXP1t3l6EhhMRU0bIBfC?=
 =?us-ascii?Q?oy1ZNi+nww9ZiDABm6gpSRVL1o8IZs81j0MraCEm9GuBnc9qhidjygKQ7zb7?=
 =?us-ascii?Q?VaGME4ra84Zs22MvUu60uldxlaerZbKPbIJBfjjU6kY7dEAh9a5lJbGgBUb0?=
 =?us-ascii?Q?jdTnWtZY3CS+8p/gTZc7jvm5wmhkg0IzONVT5LoGUX0DYrhxB0L2jp0jUlK2?=
 =?us-ascii?Q?ktOzbGzPeJCk+2bUGbjxzJsorNmtlhnsiqOi0q7y8W6CUuhZ3Ozgwi9zelhU?=
 =?us-ascii?Q?jhqZkfbWyj1K+LBpsozdeuXvnlTFbhvmqep6i26vMy7o2v3eRKDDf+lfGChi?=
 =?us-ascii?Q?HmHKhN6KRUQiyKpyZ0Iv059X5MczLIAo2UOxKsRXy0IZmDbwm2NNGWgE1eOK?=
 =?us-ascii?Q?Sa8bqdQAWPVcQLBD0MTvkdWcJC/L4lBHP3rE+f26ms0Z1cOUEyL+ZewJUwpO?=
 =?us-ascii?Q?Ry+T3QKGnOevCOLPGIcKOSFOWXtAR4zR3JYcbjmpgyVT15AuUSQ+A5pAspGs?=
 =?us-ascii?Q?MqAhkXJ3ylCwUivkS40vhoP7D5RdTGTnLMO07NMf0VphELrNqBjw+xMJtp44?=
 =?us-ascii?Q?5jCouZSmyyOKMjMh+Y5SCicf4SrpkQb3uO1uWPViU56o3lMiiumvUAPyDiCh?=
 =?us-ascii?Q?k0OT7oqLE161AWMmZi1NXyPwJ5KPSgOjhSnd5r5Dofzm9J6p2hBI1tXLNSM+?=
 =?us-ascii?Q?MV3bQk/puKrFRvWlRpkBSXQMS1XuGrLgEnnu/Xqx1kzcCVi+PK4stMwg5EYA?=
 =?us-ascii?Q?RjatUAFeva2MzFRJmwMobuSGDYuq+HJMwB8O1XCO8+KUaM+5Xn/+/lKzrGmJ?=
 =?us-ascii?Q?0I3uPsufc6s9cdBblW76lsbW0O6V+Y7ovDi1Oj3euyWhcLoZucWMi4URhv6z?=
 =?us-ascii?Q?8V5QKIoO/4U+e/9BMJmVXQ+nOYYSTViy+KPcN5F42PGgc/uc0bP39pFQrLra?=
 =?us-ascii?Q?BpMZbph2oqKqveKr3qJauAT1N8aJE9OK4SHJ6XoCoCr6vs9PgOgEH0WlGk+5?=
 =?us-ascii?Q?OQ6zBbxBWfepCfFIBwkmv2FsFWqnMYawoH+cc8eGR+26FqZ5Y+Dg86YiXk6Q?=
 =?us-ascii?Q?akJovilV8kgfyQRDmJeUc3zXzpNn2uERFlCWIneXKOZ5nboHzPRGV5EawSMe?=
 =?us-ascii?Q?WXLxYAB45ErAgSzfRNNVMGtGLnVr3I7w+5S5xgHj7Ez4JYWcYT093xBItmaJ?=
 =?us-ascii?Q?7/VBXDOYarlkt0vW0715inBsBOc5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oi/eY1Tjx8y9bgni214KHMtFRF8aAYQGdbjkRykgYtnFHV9PWRmOG2CvG5Jt?=
 =?us-ascii?Q?vbDr2QATuhXa19yb+p+rN4Wt99J77tEW4a+SJTWXupwWE78AKDoVJtz9KNSu?=
 =?us-ascii?Q?RwBucg4tPTflkBMOt3PKanYvEc0gy5gij+Qe+pE7nkogshrE8F4/KDXerOTy?=
 =?us-ascii?Q?/NNmSu3TBJGyWU5OzvPkBJ6cEYFGf1EC1aetTQN59OU0t8X4VIsTFE1Mqli2?=
 =?us-ascii?Q?xYUjzZDWZ18qJ3GgxDnIGJQzqb1Fh4S1Q7hHKCrU0ETb1Zgp9O9qMVJ+1Wj9?=
 =?us-ascii?Q?JitMC9fFmXDnJh2LS0a2Gmmluc/HAxgmvH+S8XUaCcNuwttPbsnlzI2QlNod?=
 =?us-ascii?Q?EUmtFVc4URFduNLLANA7wYwzGX+3AOQLPf8GN9hCnrtHogVuJpsv35QCf/tE?=
 =?us-ascii?Q?+jo+teyfBoE/M4PuCBR8OS52yNWwWBs0ErFCc4htqqdzgGEi8nmCxoTX3f8p?=
 =?us-ascii?Q?zsDQlpfRxEQkBPNz0zYaQGkkdEDYFYtmKwghhJAGfSxSoun8Vub/Eb+Xd50w?=
 =?us-ascii?Q?q8+ueLFAQeSec7QSPT6cJsYg8YeLCkhqz7WgiaM3hVpRgf+ULCEE9obIcXHk?=
 =?us-ascii?Q?OpnAHzC0zpoK5CFjrtrQCjixsINUf2D8iNBlutsZdcndsVY+v3Pvk2DsPY5I?=
 =?us-ascii?Q?jKYib4xwiuGN23xjyJZgJeSwbKiTFUJdcBqt/wWm6oVdhFTGyrxq4d1WMn5E?=
 =?us-ascii?Q?YU+soMUjP8sW/UPV+Awvz/LQPHL7LOPI126fvyUIuT2uMwnWg3WrleJn0lVb?=
 =?us-ascii?Q?nGSPBE4dvUkwwnRnjkJa1fPIEsuxsFERxgFQzZCVFsImE/zQ9ReMCN6uM9Mp?=
 =?us-ascii?Q?Iux3KrOIByH0fia5FSjKdES/qM9HxfscJKScFXaUYQxYIj2uz4h9fFbBX5i1?=
 =?us-ascii?Q?rZv0jMKvT8dn8o3EGUqVSzqwc6YxbnmOlxkXdQyrbOXk3Qj8A5SNVWoNTlBd?=
 =?us-ascii?Q?B6orFrCDyKDO6CeriKguFZiFx0pe3bHsVqS0bC7E/njc+QjJJgxKyoSCc0UE?=
 =?us-ascii?Q?ZHuPkMq8bTQb5GzoffQhQtI1z+O6Bu7UBYei1JZTfTiPKeODI2ESnsUrvVoH?=
 =?us-ascii?Q?EAwbSUidoEtbXA+kpewvWlBluciYqcdSoUHiRb5Q2TywHoaAYPi9Ifl9QDM2?=
 =?us-ascii?Q?6Rnt9UdaySaQRmXXcBu0aUleslm6UGmRW9wZvdygrbk8INal8Gm+cz9NtSAB?=
 =?us-ascii?Q?tHOMbLfa6XWFSmXggR/MurpbekRoCShLYtBuEmTkJI2rZQY0RrqZoITjQjf1?=
 =?us-ascii?Q?pv/FQSvaSB3IK9nifu94eCpdGvVIYucngQR3ul44CEA+3GBgQ36ZpQ4Bdtbj?=
 =?us-ascii?Q?d0MtsBOZge5rAjl684Da4ysBQVNaCvMWDFsjl4R77joxbme/U7Ano8vekBt5?=
 =?us-ascii?Q?5EzQRSKPjRu248mOgI+Kyy+63p6jPgERAqRWg0P7Nao1AMcFJ0tMs7cp51ci?=
 =?us-ascii?Q?6dlcD+14uJg/mZWvDpvZp4b0kRNokcONixtesLVfxZQH0kMSXdDaLE13o+P+?=
 =?us-ascii?Q?1IvjvzsyLcFlnyZKutrQagYfSTZGJs28IzOozIetyJ//Bf9wBc8336JGnZzx?=
 =?us-ascii?Q?TCjMDRdQDKjfiYKLrqZXyhmD6NN+k5VYZtqqZ836?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1ZHPQNIFA/ImP2+WlBSFor52GwwZSgrzD9ntYVHet60TgDk3hHaKugVRMMtMlOHakoHq1QGAYF2VhyLkNewb0QBj9GBL/38+v8WYETAlvUrPOh/zMQaBTXtsBCS9/KvmKDT+qLqgNjBAZwqrBVHlqNgyE807dumg7DWWoByJ9hWd9zQW4+79QiJxgHGiHaiXnWX3BT9TA/SHZyGa55pU7ZBDFIoV0kCbSvyCyfzIAYdCQ7XqbIijhdbMSPEE+3zqMKzUeFtgmWZqLbyd71va8vNjQkl8uximiFp0FYhJFlzr25w+ivq+Pl2fZW8PAYvwlBJDy2SVc9KQZ6FG0G2QYtiifI4lYcvfbtldlt2sWuG2NfuWcc5uySvSLl4e053VKvlxxojSB1WvFOf0j0cOFsvyStYgocME0aWsDp7XQo5ufcqig1nWQegURVJanOwfC5RdLtgyCbRcsw+yxFUChb8xWdMEWkd3vlt0aHulo5gU6c/+RkkC1H+7K6bFaU4H7+E9Gl07up7Cb+1QIQhaF3Kc+E/oXYVywWbhx13fsWI7YeCKhBF+6MCTAinzWJhAtlTmrtccs1bpRxMmB3WqWBWV+3SmAD4fc0xq+Mq7sLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025eab4f-5d21-4c26-271c-08dd3be62447
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:42:59.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b29JXmpX+OT3DYd7bb7JeepWDO8l7M18nH6jQzAHHCX/u0CEcnrHTW/aY6tIIt8Q9B2kL0ni6mmBOkGki/Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230142
X-Proofpoint-ORIG-GUID: qc2SE4uXNloi0A9wahmOLqBKz5mh_UCE
X-Proofpoint-GUID: qc2SE4uXNloi0A9wahmOLqBKz5mh_UCE

* Roman Gushchin <roman.gushchin@linux.dev> [250123 11:44]:
> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
> 
> Fix this by moving the tlb flush out of tlb_end_vma() into
> free_pgtables(), somewhat similar to the stable version of the
> original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> for PFNMAP mappings before unlink_file_vma()").
> 
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
> 
> ---

Hugh didn't mean to add a ---, he meant to move the version info between
the Cc list and the patch so that it's not in the git history.

You can find examples on the ML.

> 
> v3:
>   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
> 
> v2:
>   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
>   - added comments (by Peter Z.)
>   - fixed the vma_pfn flag setting (by Hugh D.)
> 


> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Link: some email discussion url lore.kernel.org..

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

v3...
v2...


>  include/asm-generic/tlb.h | 49 ++++++++++++++++++++++++++++-----------
>  mm/memory.c               |  7 ++++++
>  2 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 709830274b75..cdc95b69b91d 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -380,8 +380,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  	tlb->cleared_pmds = 0;
>  	tlb->cleared_puds = 0;
>  	tlb->cleared_p4ds = 0;
> +
> +	/*
> +	 * vma_pfn can only be set in tlb_start_vma(), so let's
> +	 * initialize it here. Also a tlb flush issued by
> +	 * tlb_flush_mmu_pfnmap() will cancel the vma_pfn state,
> +	 * so that unnecessary subsequent flushes are avoided.
> +	 */
> +	tlb->vma_pfn = 0;
>  	/*
> -	 * Do not reset mmu_gather::vma_* fields here, we do not
> +	 * Do not reset other mmu_gather::vma_* fields here, we do not
>  	 * call into tlb_start_vma() again to set them if there is an
>  	 * intermediate flush.
>  	 */
> @@ -449,7 +457,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  	 */
>  	tlb->vma_huge = is_vm_hugetlb_page(vma);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> -	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
> +
> +	/*
> +	 * vma_pfn is checked and cleared by tlb_flush_mmu_pfnmap()
> +	 * for a set of vma's, so it should be set if at least one vma
> +	 * has VM_PFNMAP or VM_MIXEDMAP flags set.
> +	 */
> +	if (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))
> +		tlb->vma_pfn = 1;
>  }
>  
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> @@ -466,6 +481,20 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	__tlb_reset_range(tlb);
>  }
>  
> +static inline void tlb_flush_mmu_pfnmap(struct mmu_gather *tlb)
> +{
> +	/*
> +	 * VM_PFNMAP and VM_MIXEDMAP maps are fragile because the core mm
> +	 * doesn't track the page mapcount -- there might not be page-frames
> +	 * for these PFNs after all. Force flush TLBs for such ranges to avoid
> +	 * munmap() vs unmap_mapping_range() races.
> +	 * Ensure we have no stale TLB entries by the time this mapping is
> +	 * removed from the rmap.
> +	 */
> +	if (unlikely(!tlb->fullmm && tlb->vma_pfn))
> +		tlb_flush_mmu_tlbonly(tlb);
> +}
> +
>  static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>  					struct page *page, int page_size)
>  {
> @@ -549,22 +578,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
>  
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
> -	if (tlb->fullmm)
> +	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
>  		return;
>  
>  	/*
> -	 * VM_PFNMAP is more fragile because the core mm will not track the
> -	 * page mapcount -- there might not be page-frames for these PFNs after
> -	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> -	 * unmap_mapping_range() races.
> +	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> +	 * the ranges growing with the unused space between consecutive VMAs.
>  	 */
> -	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> -		/*
> -		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> -		 * the ranges growing with the unused space between consecutive VMAs.
> -		 */
> -		tlb_flush_mmu_tlbonly(tlb);
> -	}
> +	tlb_flush_mmu_tlbonly(tlb);
>  }
>  
>  /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 398c031be9ba..c2a9effb2e32 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  {
>  	struct unlink_vma_file_batch vb;
>  
> +	/*
> +	 * VM_PFNMAP and VM_MIXEDMAP maps require a special handling here:
> +	 * force flush TLBs for such ranges to avoid munmap() vs
> +	 * unmap_mapping_range() races.
> +	 */
> +	tlb_flush_mmu_pfnmap(tlb);
> +
>  	do {
>  		unsigned long addr = vma->vm_start;
>  		struct vm_area_struct *next;
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 
> 

