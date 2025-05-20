Return-Path: <linux-arch+bounces-12012-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D5ABD532
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115931BA3545
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46752701C9;
	Tue, 20 May 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rOHa+XhY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KcN5nuOm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05612673BF;
	Tue, 20 May 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737384; cv=fail; b=fLZJBcfH8fxTCdrvz1goLxXJu02NP7SusyWsrXllC1uXr/c8XMunVNf6zulYy7ttE8QQNuYlXWdY9nzJaC3gj+LpJj0FS1UEhkiWHTtbaIbBzebjy/r6a80E2kYvefCJAS8FVXlap/6X5xBYirUvO1xGsccn15ygce/7UVw/Qm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737384; c=relaxed/simple;
	bh=84h5A/UR290n9GugNcUR57EINR9cMyljiYD8SEfvOvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPv1zIqZj7+AMwfiw+/Myq73Azy38uInB0A8KdAepXw1BLsZ1I6LScnj7JJgdO0IPI6dywfxW4ULc1dsvlm/xQuyFCLCph3GXyT8cJP277L3Fnp1X0Gp9mW5akvDBEuy3Wfgj//D1Khaq0FMd2OXQRAtLqCRBtzR+grWsNTBiQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rOHa+XhY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KcN5nuOm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9MtJV004959;
	Tue, 20 May 2025 10:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NFbITEv3nsr2ItnU7I
	jdte/kjoMEtmLe12RFfImX78c=; b=rOHa+XhYRJRtT0HgZvB/BBvA5l/NhQNQkI
	bLg14AloOlcHpSE4CRh2HHtYTLA7U32LV3TQZ5TnAbuOaqiPWNas6MnLqE5JzP6H
	uZsvjAOcAsn3xvXiX2m8phhl6oYmmGOKQWJcAJxFRw4v3ESlKoX/6qdeG5wm5tT0
	Qq4CaONdJ0GMJDkzEN7GPsAjF+2ne0l1d3HQmVfZnURGUOfGujzU+6UY6uL+xfAx
	OAjJtIcPJcjL2m79fJscNs0UuuKDPyRvWX5shuZypS9lx7LS9P4S3781ooknNttc
	7RfvkrOdrlMc/FA65QarlnhLhyJCnkrNx4Zohzk5mgxAibqPRs4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdtj8xam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:36:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KA6VWL017436;
	Tue, 20 May 2025 10:36:07 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw82py1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UokoMXsUPKb1wsm/UUVgQwPB2Isbk8LihOitiSPURDNoxbvm6n9h8yn1f4YjK4WgVDNZL++Nib19fakT4sBhaj1L9b7LljkIGhfKIHBYBn0faJt5KbT7cQoCCIEjhzeYO3RMR62nB1EYUwvuAMb8oUnTb0Ne8lSHX1Y5IIDLG10SgH25GJanIdgfoAv5nBik1XD6KZfTzXzkpAD6xFpHMd3xUHr/OZKWFTb+g97X7ZHydtLItALSJoG8LO6lF4rSKoNw4Hkz7gVg1j+YqZIP+wJsjtHZIRcZ94u5nGf3kCFQDTD8hDgHBBDZ1/nIxhlYlr+9KceS9fceUZop8EchZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFbITEv3nsr2ItnU7Ijdte/kjoMEtmLe12RFfImX78c=;
 b=ygp11PJNTKM8/5W2ssGV2dri7FqzlUkA2jLE3BWDggcyICWFNOo4rB+lI6WrLsyJJJ1VtMtfZ+DBc3CLif41gLS6cqJfHjDKhoMaQmK7MCyIsDT/zIEdaF6De53hS9N0wvSvuRG4YA8yZiin2NZpm08xo2AVAIN3vUM2cXpfllWr5i7TaegrVzmnZ+WhsuVsfgQHIR0cjoaQ9EwU897+nOLrzfZr8ueumVpwnNRkdNsvtaKDZawYSPxBOS+hvfYBvudxJzFnJZCS4Kmk9Yj5MJrPz/ZxphfB2KdzL9pvQ/IAmeR83WZRO5CXdhftRNFadYABtxj7+7AmEO29gLP9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFbITEv3nsr2ItnU7Ijdte/kjoMEtmLe12RFfImX78c=;
 b=KcN5nuOmnKcM4UyGeFqqvVPSDDgPV5PqsW7Xgmn1vTXTNcqCmcCWk8ufPi1QGQS2sOVZ88yFOrA59wSMRyIzZDhsZnJWlbKxswKyQUZgSb6vBSWtVX29oPalV2tqcU7JdQ18ARwmlDR5XnucyRZU88KnzPsqlI7Fi6dXtihon9g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 10:36:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:36:05 +0000
Date: Tue, 20 May 2025 11:36:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: madvise: refactor madvise_populate()
Message-ID: <ea17a0a6-fe19-4f0b-9899-56d39b9fbac3@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
 <becb11bd-e10c-4f59-9ff1-1f7acd2e1ee0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <becb11bd-e10c-4f59-9ff1-1f7acd2e1ee0@redhat.com>
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: c076cffd-63c4-450b-3689-08dd978a1fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LuD1dD5XNyLC0oSCXa1+9Q+3UySDmE1+R6ikUuQ4LKGvRrGhFCEiWfNxFofO?=
 =?us-ascii?Q?vFZ7sRt/oT93kppB9/oazKV1IPCf5JdcGG630DXQRwljEY8czB+tjgdlt8QL?=
 =?us-ascii?Q?Xe7krwPr822Ar5nkW/+4Iffi++POeNpoZ9bFHFXaD59ANFR0bCR1mFKzcjXa?=
 =?us-ascii?Q?UQrGIKHCV0vZKS5IQlZ8lWcN9KZUYT/Ji5aibyg8twSEQgujdhN7xovc8iuZ?=
 =?us-ascii?Q?LYV0tkO6Bnm5oIOE1C+rmSUaZ4w0GthB6eNdK+AcBeRGGYiEXTkGXXKmI7fN?=
 =?us-ascii?Q?ArA1p3I7LyI2VpYSryaFdJgRAtN7bjn5jTeGus/lghPXnYRsCtmZTj0mmz5/?=
 =?us-ascii?Q?Mm1dV5XdNPlpLfHeYW8CTGcNCH60DJNVz1uUwtrRCC/TrK4OOhLkZJ0cwH56?=
 =?us-ascii?Q?O8d5dHMQoziYJZn3NmJMO+rDsVDv2hMQq5TRq2os6hmtpZ4ZbHg3JuYjPueW?=
 =?us-ascii?Q?mWy0DngDq0oWgAQM2xy4Uq4ieDHuoXV8Ty+72PYekZB1TpPOYpg8cKpcVCjz?=
 =?us-ascii?Q?pZLf3orR95G2zngu/GjMwtl/TeeRPOz8V0Ggx4gf0Y92IRAGV3Yc7aNgfnsX?=
 =?us-ascii?Q?xxkELo+R2N9n55TpPuOG9Muh+5loBEr2YcRP8Wz6teOSN0cu+zws5QI+neRF?=
 =?us-ascii?Q?siawNDJ8avpZlFXyVuTZnmsz0uH4JetHAYW1IHNiqUXVpjdiHBxBjLjnr02/?=
 =?us-ascii?Q?cSX2tAYOnnYmVcZvAkwGEEWh4Kh2sjf22TVNIo28O5KQqUAxxj/p8wfhE7Ve?=
 =?us-ascii?Q?61GPJkWC2W4geb820Q4U6sVrd0cfPDoFB9keOkXTxsc+Sk8lpHQH9F+qtJ3f?=
 =?us-ascii?Q?sgcpGoVfHDNNWIK4/nfrDjGtk6QBzUNQ4lMLRQboUdWhCZOuLJB14+fS8Dap?=
 =?us-ascii?Q?/mI69MOW8GDy2pR4pXb8pQfVF7xVPI7lPcGF8HK4DWJ2+ZsQLyljXhgI0zzo?=
 =?us-ascii?Q?NdmIBl0MBjq9L3JwZmjJmVMiTJAsbj6qtjIShH8dDaMVcFpBcd7QJnHTaeXi?=
 =?us-ascii?Q?/5fuT8DffBAgSHXfDTl6bBrZ9+M0ot34Kv0fQCtpp5X8L+gEcQ8VdyOeYf5A?=
 =?us-ascii?Q?Yz4jyLwY8Ebx41UWPRSk3gg4FZePgIXBSi37RWjEBvr5SGGJBFNogdfecky7?=
 =?us-ascii?Q?L4xRDu1Vr6xgnZ6OqeS/DqIV57d44tEGF0uTU4NjKZtkNW/otSjNt3TlIFhA?=
 =?us-ascii?Q?op371bHxM18plCH5ajx5kb0FNy/+lTMtvB+9S4L9y003tp1994WVvJLpAW+r?=
 =?us-ascii?Q?33O598DWJGa3Ebb5GYRMK1Q4/ndNTUiaLOHwW+WlBfjOvZ+XyigDLXtnQL5c?=
 =?us-ascii?Q?duDFjWTJZvCK+P6Wbt3ppANJONgW+Z+URck2MKAkaTNk0c9AS2Rje87f3sbk?=
 =?us-ascii?Q?m6Oqqlulw/lNYdLd6zZE9Mzt9TIkkCZOvl1lRxtmh7Pj9b35e0FoFOJsO5eV?=
 =?us-ascii?Q?VwxioqlwKMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgYxwyAkIAySgCOB5py0wXiK2ukYcN+j6wrN/wKuaK8akh6Igj0/ReklX6sW?=
 =?us-ascii?Q?d688A1hgQqR+452i6lAU7YpHIKSX2vvIpymDPDwxcCQwqZR5qWvWKuoEOPJd?=
 =?us-ascii?Q?lHxlZ+cPoRJjSAfczRuqnuOAXJKu0vTIUlBLvwfOGKlBv/Nak5eNN3Er/ihU?=
 =?us-ascii?Q?bnIjV7EASLg7cqkG/W+WE0ARU61zFy1WatoFwhUXkZDKIyPr1y/ObgdwxL0x?=
 =?us-ascii?Q?Ne4Y4JXQfM8CHX9uaUbiPF80PHcv9XWzii27BHd7hhwDJiq0GEgGmn4ueuhC?=
 =?us-ascii?Q?bJ28HP/YItyRvFnRbugWID60uRW53HIryHgy91qEDuspSv8syA4DPozBtoqO?=
 =?us-ascii?Q?nTxzekg9ybOZB+uPlcPZdcOvUaoynwHNUrD1scDr/Q5WmBROB1+UVMratb4R?=
 =?us-ascii?Q?s+6VbsIHkmpgBUY6OPaMEtZJyWNeRH+4WdsVIv2iC7KWMA0ngci0TFu4WQWP?=
 =?us-ascii?Q?3EQLzDvBlkP9xKqhii1IzFHr3HZWxXFeDpNFF/Oj/7Kl74eJlUcnNpk1cbyr?=
 =?us-ascii?Q?Gfoyus8X5/vUO3ktf/7pmULXnK4Gg19vdmkZiD0xZjqzKampLNtE520bePNw?=
 =?us-ascii?Q?1mFh+Jr1tbNuPYgVWYLuMlUFSsM2YvBIlPWCtqR0319m/ZzajGsULEmH2jyT?=
 =?us-ascii?Q?3iRsZqY2XQotgkIfrepKsY1D4YPJo86V/Y5vGxag1LOzEE2IPV/L6l8KTpWh?=
 =?us-ascii?Q?8tZZnuxs9xMITsLZveyHNwENBFcnJ+ewOqMZtiS4oa1PW157iuNDqJpYtKbP?=
 =?us-ascii?Q?wHI8GRSFcZtRpN9e2iBUFiNG9DtMmXsVeSmz4F81ABeJtqtPxsN1UYB7SHc3?=
 =?us-ascii?Q?byoYsUQFAD3lKI6JFgSj3wxO/v98sIzUOnAABw+dxQ0MzMn4jYdcadaYvNuV?=
 =?us-ascii?Q?PSEysjQH9iyocYzbQ8BrxZrNKS5mTE0wsrpbVc/J+gsBz5xsTqSU8psPTFhW?=
 =?us-ascii?Q?KZVQJ1awZ3xtvISpI61UfwLRAC4UXfRnHuDl7SpgwFB8OuCsSFmJqFrAvsWu?=
 =?us-ascii?Q?H/7Pz5fwz9ev9IxcN412gBj+ip2pU4TbbubA/jyLbdm74BwrZOkcSq96I8Eg?=
 =?us-ascii?Q?o6cIsW/S22xVE9Q3h3E0XrPdROi0C36cYQVw1/tP6FcZm4gwHnLP8+Kj/gQi?=
 =?us-ascii?Q?fdK+D/nqvMBt+aq//QHKsaaPaRtNVJiWw1uy4aAQd/iTxC+DPPcsbQXvj1e7?=
 =?us-ascii?Q?XQgkpGbqY0Ch4Ppkl84ACzt7OAFlf/AtE/qkWPfbRPByWnb+yNytaEKZp+1D?=
 =?us-ascii?Q?RggV518gwfRs+ogVpFtk/UFYajQ8jCzV7PgFKo9l5Grv9O9NvsN9gj6PQC9G?=
 =?us-ascii?Q?iZJRKf5xD/2w4bYZcDCl/j9UwPVNetVP7fLBXm7uMT+O26Oii92MPzRxKJu0?=
 =?us-ascii?Q?m+Mg/vdMyOqRxWFptzf8GuiPd3yMTVQZfALklCsw6jMhBWeLRiCQ/8TCjQeF?=
 =?us-ascii?Q?8WgC+i2W+O1ACbDhnQfI0a0eeBm8NbmAc1rgqXM9FkTQE9XmJjLWcN+Scbb3?=
 =?us-ascii?Q?TJ3bSSBPCt4t0vzY0q6zlXUlL7FonGcuupqu7HEEyC6mq50vG83ersX9aO3N?=
 =?us-ascii?Q?rYQkfEohVHBQFJZ3bRRMMIHrN53M5Nkvl+zRAL9yLYLDhQSCJI+cI+DGAFrr?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eV+6W4S0FwNwsGS7cVVmSk9lCSniavR1/eHVJcRbbkN327ib4BkIaU8tk1svUFmZu1kRUmo+q/cb9mOPqp4RAayKANbcjVPjofUI+Oe16X7f7VXmxHpWuLhCblqtCL2In2iO3+uB8RMTpVskhzT77ZyE7Xsa1lMxZldKFXWJE8RO4Gk1BXsTViNtOFyQR3NJQVd3Wl81VmuJEDMFNIj+DOUh3DYyvciT6jB53PjiBZDrn0oMxcPUrbj5zFsXj7GF/iiza9DGnlS3cOSWTwI7dIO8iKQFMM0vbPsHpjrs56KyU0sDzHFvJMUyuqydjaEVE/5XG8s+0TUSWroh6ezn8rrxqT8E2iH3K8KwloD8+keJglRNbtJvSUL5+w8uoRgUJQlqSBulf2bxFzSTA1nglzt2707wH/uEbgriW2n4RlypbXrwGVdhywXqvehbrsjWHpj1EF4CphISYaXb4iULYHCl3R5yBOMieK4cbsSiD1hi2F+x01E+2jjUbMWRR5GEw26GyX/HYxDK3kipgbCdFH7+y/tdx4sUm7383PHD6v96FbctjgkWlF+/HuNpCWcUCBjWomPT7+ho9EUJzPRuFQImhsaUvteeK/4vFwZQzj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c076cffd-63c4-450b-3689-08dd978a1fa2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 10:36:04.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yTlUJ/YP0FmAkWBWoiVD0eZMlTCFpSEYwWIyxHv7aVnnncyw0KaZbmuxdgxS+tPegi4RR3KIxwUc8W5I05t/0qG10Yrcrmp0CJhCvKC/3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4NiBTYWx0ZWRfX1krQQJEi5G5e EXeZcr/DzjOrMBa2IN29v10jB48t+VLxsBe24Z+GqM/hVBKpeZqBT83VliE49eXKmLvgnBBJdzg iAvSE5JTNN/SPmomK0rXCZSz/xiNKQXPozbUaw7DdSTwv5e2RbfPj0UAXnTWsCWV+1ENV9klEEw
 xP8I3BnCHPW2YgcCxqukRNWJMhIZ0q4NhGJawNEqaA0CQ5iSFh3ASBpIx1GgBOs2wr4+kwYBqZG 3gVlhVncHdAThRAFFOF5irxhpn3GRCXbw7fuuiNdnd2v8yi9yB8QbNFOGb3ewxIME4M6pdGM+7F hhnZWBOemuvP8GobDbM9cCsU6zYLZPyGuNu6zGKmwLAMHSRriETb7uEVMFw1rvA2Y3W48Btw4zy
 cHZOIOK8JTfN5zCyeGy5kbPCafiahZCBTIn+7LWHksT84yVteV2ucQQ1nlWFsJ62hW9e5CA/
X-Proofpoint-ORIG-GUID: 8OKmzdGp5dIbShlVzw6paJB6JcWCcRKu
X-Authority-Analysis: v=2.4 cv=D+VHKuRj c=1 sm=1 tr=0 ts=682c5b18 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GHYklkeLqCeVKldQDUIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: 8OKmzdGp5dIbShlVzw6paJB6JcWCcRKu

On Tue, May 20, 2025 at 12:30:24PM +0200, David Hildenbrand wrote:
> On 19.05.25 22:52, Lorenzo Stoakes wrote:
> > Use a for-loop rather than a while with the update of the start argument at
> > the end of the while-loop.
> >
> > This is in preparation for a subsequent commit which modifies this
> > function, we therefore separate the refactoring from the actual change
> > cleanly by separating the two.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   mm/madvise.c | 39 ++++++++++++++++++++-------------------
> >   1 file changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 8433ac9b27e0..63cc69daa4c7 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -967,32 +967,33 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
> >   	int locked = 1;
> >   	long pages;
> > -	while (start < end) {
> > +	for (; start < end; start += pages * PAGE_SIZE) {
> >   		/* Populate (prefault) page tables readable/writable. */
> >   		pages = faultin_page_range(mm, start, end, write, &locked);
> >   		if (!locked) {
> >   			mmap_read_lock(mm);
> >   			locked = 1;
> >   		}
> > -		if (pages < 0) {
> > -			switch (pages) {
> > -			case -EINTR:
> > -				return -EINTR;
> > -			case -EINVAL: /* Incompatible mappings / permissions. */
> > -				return -EINVAL;
> > -			case -EHWPOISON:
> > -				return -EHWPOISON;
> > -			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> > -				return -EFAULT;
> > -			default:
> > -				pr_warn_once("%s: unhandled return value: %ld\n",
> > -					     __func__, pages);
> > -				fallthrough;
> > -			case -ENOMEM: /* No VMA or out of memory. */
> > -				return -ENOMEM;
> > -			}
> > +
> > +		if (pages >= 0)
> > +			continue;
> > +
> > +		switch (pages) {
> > +		case -EINTR:
> > +			return -EINTR;
> > +		case -EINVAL: /* Incompatible mappings / permissions. */
> > +			return -EINVAL;
> > +		case -EHWPOISON:
> > +			return -EHWPOISON;
> > +		case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> > +			return -EFAULT;
> > +		default:
> > +			pr_warn_once("%s: unhandled return value: %ld\n",
> > +				     __func__, pages);
> > +			fallthrough;
> > +		case -ENOMEM: /* No VMA or out of memory. */
> > +			return -ENOMEM;
>
> Can we limit it to what the patch description says? "Use a for-loop rather
> than a while", or will that be a problem for the follow-up patch?

Well, kind of the point is that we can remove a level of indentation also, which
then makes life easier in subsequent patch.

Happy to change description or break into two (but that seems a bit over the top
maybe? :>)

Idea is that we clearly separate out the refactoring bit from the actual change
to the logic so it's not a pain to bisect/review.

>
> --
> Cheers,
>
> David / dhildenb
>

