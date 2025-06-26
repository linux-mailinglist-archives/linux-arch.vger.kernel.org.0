Return-Path: <linux-arch+bounces-12474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90552AEA35A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EAC1C41CE9
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C105F1B3925;
	Thu, 26 Jun 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UUVoj4jV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G4ao2sbz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7D18871F;
	Thu, 26 Jun 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954768; cv=fail; b=tXWhbu7daSmehKLgK4gwGHjbYw2iMrQf9B9iDzmfbjc+HCtzY2+VyxJ+fdGh4irUa3YdeY7AMkuSVrQQteg9Wk+Y0Rvd6/IRnoyiUcHP2W1wZ5fdRLynBJSNwBGYtsqUWTmGz4bho+y7Zihf4FmVviKFQPmSJfEQuU/iY/y/occ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954768; c=relaxed/simple;
	bh=YElLwkWKzi/LdZ8GbjfNeIgXX2ucAW35qpIVPASiPRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiD7ze15JwHg3iHKKpGBHgDi1+9ArLK3Qlzjn250Pr8MPMTEJ4DTdU/kJBZEpBVN0TU1DZui5C/wqCho0fVuAP1t/XRTlpSiYV5xBHjRPSMpUUyZCgH+47YUiCCF2DypUm+vHqqsISShN7+PkCDwRcelPWi/+8WdEQmbRKjkl3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UUVoj4jV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G4ao2sbz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFtiMU013706;
	Thu, 26 Jun 2025 16:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YElLwkWKzi/LdZ8GbjfNeIgXX2ucAW35qpIVPASiPRs=; b=
	UUVoj4jV0weVgg2B57S3b3RDYpRZSsTm519Hk4ua3RPALw5rTeFywKkk1KQbQN+g
	WqjNkj+v1RCxKs4lIGJFkI/nyZ99+s83DsMkjAcN9TY+Ygu4gO2dZV03ZHj0cCWN
	QT6+YjzT/bJhPLA9Cj0LhVOgUMev7tDjttVN6lJIkcXD65RiXYU8EHE9gcjK5G3s
	DuivziwTftmIUSuLeh/oGq0r6JnnVTL2vQJkuC+Yt+DKwISCDgq+RctoF5RpzFpa
	RPAi+UrlfqDF8gEqtWozYuI2QnL15Js909fpAnJBtaIdBc6fkFuxg7gj9rdHkyuh
	UVHzSoBXX5d6UBbuhKyHEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8n24we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 16:19:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFiRQh019298;
	Thu, 26 Jun 2025 16:19:01 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehktqq0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 16:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfYbONCOvQg2iBzrZd+r3vkPSSvnBdHVB7CvNHUpzMi9oInoiTardkNJW2WvFiP6jki0PEXZj7KmzZlF3mXIjiLPWclIHPZWa48aaTwXbQhFUwnc/CyrTZDeuH9FUN4TWHJPmtJ0oKKs4B/5K/9hT4UplEA1JQo8T3umiHb3MYJF4GFNMqECWR6ZBauYWS4ZVUjH334BwIzyXhUTjIT7H9960Q2uYpeEYNiluHcOMgTZonUW/2wATwl4+niw1/heJfGt94/YcTEnsps+fOVZpz5kmeizfAUW5rU/v1knKYhwfpxGRBR16MJ/ljjDHwKOHvk2YYa9cKmaPHiVSdVfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YElLwkWKzi/LdZ8GbjfNeIgXX2ucAW35qpIVPASiPRs=;
 b=IooS1IIFlzd2Tdb4h/Zeg50Ppsjb9R+I5Ev2/Rwbd7njm9MKJg5bYTJBw9zib3wUCYxCd/IbV7bbn6sPJgyLDUuwPqEiTQpLgzy/TuN/MHaUH243io1n2O4px+pWLAF4wWDOrCF1cAiLYJ7fWPsUINul/L23y+eW6BDUBhFLkFmPZDGidROE2n0O18g1pklUFULNEzRwu3NlkcnIcOuyNKH004goq7bbxzj7wErD5tijwSAxqGU9NSAH24GN0jmoP381B6H5Qvb+LaCQcwkkWQJVSNb6m33Tp0IW73uv3GBHb4OQaH+/4HBb02ohVMCVVJAs+Dp71twJHaMPc8Zfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YElLwkWKzi/LdZ8GbjfNeIgXX2ucAW35qpIVPASiPRs=;
 b=G4ao2sbzKHKpUntGFGnl3Sh93dneZkUPUdMMH6P6UKS5e0d9obz9NI17yca8VJHlsfmflkVwrbzMuGua3N0E/SQL89W/NT0kVzcEfkm7RrvZQPIYaCKIfI76jNzQtDgL/7SPOUEw37JpJy2y2YuBu0EimpiNS4DdYhVko3kXaAk=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 16:18:59 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 16:18:59 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri
	<parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin
	<npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave
	<j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E.
 McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, Daniel
 Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>,
        "lkmm@lists.linux.dev" <lkmm@lists.linux.dev>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/1] docs/memory-barriers.txt: Add wait_event_cmd() and
 wait_event_exclusive_cmd()
Thread-Topic: [PATCH 1/1] docs/memory-barriers.txt: Add wait_event_cmd() and
 wait_event_exclusive_cmd()
Thread-Index: AQHb5qfOcJpd9PASU0SZR4uyUhVcxrQVjXSAgAAROgA=
Date: Thu, 26 Jun 2025 16:18:59 +0000
Message-ID: <DB1B2B27-F7D4-4C5F-B9E2-4B06F5258A83@oracle.com>
References: <20250626143707.1533808-1-haakon.bugge@oracle.com>
 <aF1kdYvCQQdIttoC@casper.infradead.org>
In-Reply-To: <aF1kdYvCQQdIttoC@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CY8PR10MB6851:EE_
x-ms-office365-filtering-correlation-id: e07ae794-6855-4023-8bb7-08ddb4cd2833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFhJYjhmYWwwa0s0MnAzbnV4d2EyL0NsbDNTMnl1Y0g1RlRqQ2o5ai9sbkd3?=
 =?utf-8?B?dTdDdmRWM0d1ZFZwMHE4Vnk1QnQ2a1JiV3I3T0Mzc2NieXhaVkE1VnZaM1hn?=
 =?utf-8?B?YS9PQlRIQkdMWWpRTFJxcTBGaDFNMmovaXBNTTdoakx0a0kyamQxaVdEVTR5?=
 =?utf-8?B?TE1MMVR3RW5PZVpXV2ZXcTdvbGpZZFdJM3o1VklmcThHS0NKeEdHUW14dWwx?=
 =?utf-8?B?dmxMb0tkZmpjSDh0M3EyWXFTcW1BOWllUVEyTjJEbkhZcWRNckhlczlldVl2?=
 =?utf-8?B?R2lNTVBRc0U5dmN4dkhqcWZoTWFQU2pFZ1RNMW9KSXRCcUpYeFBuSTZWZmZF?=
 =?utf-8?B?K0RYanJRYVplQ3VVYUU5cVFrbmlDZ2YyWmp6bnBkZDZ2S2Yva1JYd0JSb08z?=
 =?utf-8?B?QUJCaUN4SDBZMWhPRXlOUTIrOWhTNmhaeVFlTTE2bmNwemhmWEtkcUhJd09u?=
 =?utf-8?B?M1pSZnY3b25XVTYyaWVPdmhyQ0dKZ3ZDRmhBaS85aTRDNDVGLzJkWmdHVEtN?=
 =?utf-8?B?TTJ3WDZvY21RUzc3Y3UyVXhsZEZ5c0FzbFpkUmh0SkdSY2dRKzZGUmFpVjcx?=
 =?utf-8?B?WDIxSnZzSGxOMU9qYUNKemRrcGwzQ1lzYU8zRWRkUUJ6enNIM2x4SnFJRDN0?=
 =?utf-8?B?NTNwTDJZMEJUK2tCbTk4Wi84c0JHb25OdjJkd3NSUGRmVHE0cmFQL0s2UEtB?=
 =?utf-8?B?bTdQYnJmT0pMU3BFZXZOa05oeGtnbHpaVTViV1Z1TXZtVkkyM3UrcjVYdzA1?=
 =?utf-8?B?b29NK2pPcmZMSDQvTzVCN2RnUmk5RTNabWFXV003V0FZT1U4QU9yWDVHK2cw?=
 =?utf-8?B?QmVUdEp3NEsvaWlzWGlrQ1F5UFlPOFhOQ0tMUVZyNkNzak1UZ0xIZ1EzYzR5?=
 =?utf-8?B?dUE3aGNZRGgwYzhWV0w3ODdQekt3WXJFZ0k2TzhEY1Nja0UveVhaMTEyTk5p?=
 =?utf-8?B?MEgvYnVLbkhGbXQ4bkl6SEdnQWdmV05RNTlaWXlhRGk5RUpZYkMrUm1uTm9s?=
 =?utf-8?B?bi9KTGt0L0hkSy84Zlo0M2p4VGdUY2xSWTRKRzBLVUxUYkgxaitQT0JiQUNu?=
 =?utf-8?B?YzltNGJQQVZXSDRKYzJHUVRoTkMzNGhwQzYzMXc2dU5EbGx4Nkk3cEtLRWdi?=
 =?utf-8?B?ZFBlZjNmZ2R2M3B1RVB6RlY1dUF4cGZKWkNtVHNpMXptYmNGU2pnSGlGRnlZ?=
 =?utf-8?B?a0MvWlJqb1JaREFRMzRHOS9JTE8ramp6ZW54UXlEaVprTm0yNEFsNzBJK0xr?=
 =?utf-8?B?QkxtMGpuMVBIT1hlU3ZjTE1zVExZUTRYalo5RXBkOHRUSE5Fck9lYWtMaU5o?=
 =?utf-8?B?VWx6bWlMYUlOQnNyVmdnTWFqVytNOGNZNG9GOStlWFpRSmZiK3AvdnhFT25E?=
 =?utf-8?B?Tjk5UzlSK2MvSTFBc3QvR3NCalRBWlgxTnRZeE5xeHQ1STZxRUlTMjl1Tlhh?=
 =?utf-8?B?M3pPMUJZaXpId2dKR1FjR0IyYVJNNWRRTk1zNWdMNDZMQ0ViQndlWDh6ajlP?=
 =?utf-8?B?aVVlWnc4RjlzNE13MmdIdlNKbG12bjJFUDNsY0J0dmpGbTBnU3JUNDlMajZE?=
 =?utf-8?B?ODlBZTZhcmNjMTdQeXR5Tk9hcVl4MUh0ditEeVh6bld5K1VLN2ZQWTUvR2hP?=
 =?utf-8?B?Qy9xaERzVDJWbndlUm9sTDNrR0tKRnVQYjE2N2RZbi9QU1I1cXpZMzhvVEFE?=
 =?utf-8?B?azVKMm42dXh3YW83WXNoSWU4S3VVMEJGclFoRnI4NUxSUlBBS3laNDlqdlpG?=
 =?utf-8?B?Q3pPeVVyQWgwZXVYV2xNakVMUVZycWJIRHM2L0tLOVA5MjJkckp4VUhHeC9x?=
 =?utf-8?B?d1F2YmZLbkl6UEZ0Qnk2cGhEcmIzL2ZDdEJ3Y2lycjd3UnB0WUZ1YXk4NHQ5?=
 =?utf-8?B?OXBzblNZSVNkN0hEWHJYZXpMRjlYWW42THAxTmxxKzdmMGRKMkh1TXM2c3lJ?=
 =?utf-8?B?c21nb3YvcUhCM1h5bDQ5U3FHK1k4cWF6YW5SR01mNzBUcWc4eExZaXdBWUk4?=
 =?utf-8?B?bGYxeXpNZDJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3JQWmtvaysrV1lPUHFLQk5QTUFUSG42S1J4VHBIVXg0MW5ISit1V2JUMHlD?=
 =?utf-8?B?MG1DM2NDb1hsMUpiMnF2S1dkbVNldzg1QUVyYjhrTnNqVXVmRGo2cjBrVHBm?=
 =?utf-8?B?cCtzaE15MGoxNENmbTZqSlhNYzEyOVR0L0JZa0hGYVBnUEc2NjZCT3NLU0g5?=
 =?utf-8?B?YStPQlR4ZVAyWmt5a2xtTTE2NkY4QytFd3RWQVNObnBkOFZyUG1neEhYK0I2?=
 =?utf-8?B?MkdxQWM2dmg4cGVLTFVWd21Ma2kyZFVxT3JtOFFSZkRNalRtek5qVnJPSzZv?=
 =?utf-8?B?dC9BRTYxb3lqdnVDL1oxUGxVeko3M0FaUUpwUXhqdlBrNW1qRDExZDV5aTB5?=
 =?utf-8?B?NWRYR1NKN1lqbk1SSkh5NEJBODZobHNzWi9QOEFYYi9hQU9sb3h3c0I3R3dZ?=
 =?utf-8?B?T3NTck9vcTU3cDFHMWNBZHg4aWZiZTV5VTY2NzNHNWUwYlZzd2YrdGhNRkxz?=
 =?utf-8?B?dWVtTXFOZjhBcHFZeFUxUThFM1dCUjlJdHp3QWZEbmY5OEFiMDNUK0x5N1Y3?=
 =?utf-8?B?eWZQajQ4M1VtblhndlFEM3QvdXNpTVI2RjhiVUxFR1lPc3FlUmNQeEdCM2hO?=
 =?utf-8?B?OXRjczFJVW9vdnZTTkI5UWIwbmdqeW1zRVBaT0ErQmhHQVhBNWZaeC9vUEFM?=
 =?utf-8?B?a2pldWcyQ0VRcURxM1psNkJnUFVzNzBTZSt6dzJxK1o2bCtmYTlNbzNqME5B?=
 =?utf-8?B?UUVpVU0xL0tHY0xYWHFGZnljZmU2ZUVLUG9vRzhiRERvOVVyU1pxT0Z5QmhO?=
 =?utf-8?B?NkZ5dUtlUlNuMG1wMHM4cXUyWWtCeUVwT2tHVzVYWndjM2pQTEV5ZFlFRGVJ?=
 =?utf-8?B?NTUwR1g5OGRyck5wemFjazJkQUVrbm5XZ01tLzRwcmU1QUszdmtmZTc3eGtP?=
 =?utf-8?B?emFNTitXOE1HS3RveXQ1c2tzd3BsSmxVZU5MTGZDM0syVTZVdjlWNlFhbkJm?=
 =?utf-8?B?ZUh5KzVvUVJZeTBvaHhLR3JRdzhKbTJDa2d6SXV3QVhNL1d2Ym90dEE5K01a?=
 =?utf-8?B?OXNiWjk5dDJ0WGVlU3hvWFpkL0JlUjlaN3VGU0RiOWpsZ1JZa0ZMY3Y1RjFs?=
 =?utf-8?B?U1dmclZZaUhsdnYvdzV0dnNFT3BiUGRhMFlKdFB6dlJqMVN2RGVlVUdhMXNY?=
 =?utf-8?B?MXlnUUtOVDlqZUFtZXoyelpKc1JGTUxiUE5nSGxVL0JYdkt4SWFnK1FWZHpa?=
 =?utf-8?B?N1ljTkd6MlFNZXpwelJqWi9pYnI4MDc3RldNcCtOWDZCeGxhOXFKbWVyeDR5?=
 =?utf-8?B?KzNmZXMzVEJPd1dMS1V1RkpZa2U2SGRBZm1hV3diRnRnL2hGSkh3dUFNRC9F?=
 =?utf-8?B?WkUzSnlnSisvalZ0ZnBvUHBnVzJxWVo4WDdmMFpvMmV0WnJIRzdMUWZQSkVM?=
 =?utf-8?B?YW02S1FsUnFOSHIvQzJXR281ZUZUZm9JUkZxaWdCYTlYdks1c2I1VGVoMkV5?=
 =?utf-8?B?TmFyRjJQUy94bHQ2ZnhabFFxZytDRUNwcTJmeDdpR0R5ejRkZjREZFJaQTlq?=
 =?utf-8?B?WFhJVlkvQmY4OWVpSzhUc2VDbksrN1V2M2l5OVBhaFliZXBBbWZJS3FyU1ls?=
 =?utf-8?B?Sll6TWJkN09TbG5IMXZORUF2Nk1ab2pBeS84ZUErWXE3dHA1WDdKcXdkRGlG?=
 =?utf-8?B?VlM1TXF6bzNHZENGamYydU5yenZJLzlLRDFNaDZCd3NmVk5CdUU5cnhFblND?=
 =?utf-8?B?Ym5lSUVVcDkzT05jWkVKdkJCVCtISjdnU0pxSWJvQXVkRkNTd3ovREREMHhS?=
 =?utf-8?B?cFFicTZXS0IzcE1pZkZwNHRWSTM5OXR2L01XdVB1alo2RFJCL2xYR3Z6WXNB?=
 =?utf-8?B?dTJrbG5pa0lCeHI5dlpMdlNHR3A3ZXB1cXlyYm1iNkRoRzUxMS9PTGsydFNT?=
 =?utf-8?B?Y2Z0RVZpVVFFQS9ObktNMTdqVzR0S2x5UjM5Yys2VTd3WlYvRTZmei8va2pU?=
 =?utf-8?B?ZXlEcXpHaDdVRzNueGloZ20zcXUxQTNEbzkzU3QzSmgvM1BFc1NCbngveVRw?=
 =?utf-8?B?SkJBdjkwenpxUmtiQjI3RjFWU1VJczVvby9GYkxaMVdHWnlmb0dKTjVwRWMz?=
 =?utf-8?B?UnBWb2xKMk10NGZCdEFrY3FSU0xWRnI1bnJ5Zys0TWVtQ0NKQkpoTUdHRnlp?=
 =?utf-8?B?MnVrR0hCVDdKdFV6UTVNcnpNbkoxNzZoaFd5WHZxMU5hazBsNGZJVzVXU2tk?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49CC1A4EA60CE547821C16E92A1BFD0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qz2SOYdm5YzKd814ER5HPKniKVjdvrCYEQzhwes6slAtBvRLoPMa6xuvaMDeNwgfzGs9emG1iqZZ5Tjjy1ukpKUni7+YM1syT2axCqIepV3iOe6VQmlRuFkrzwEw1RW/WNsWaRwkkKhO3/ojwAwKw/Wzfa8HA2eIWAHgOrgvR8MdpYbCVMF86LPbfiVgSMUHCdB1tFyYOpd3ZQNaLCIelnMw4E0tfK127sm9DbKtHtwJ+5hYaCEyKUZDYewvpDZ1r2TphQS2UcH8ORZfCNGy4ma9kYmHqqNPvnm5cHflDHMOOsgYqqC7DxF19D4ssIqAts5bM7wGVVdao0ye7BD/izCINV8SIB792dUKwrFrIzBfkE7bfRvo7RplJCFZvtLPtLpHwFc+lkN5l9NdrwgMSOHwpawy5b9YRaHwKhZT46+In61CRBAFgNaau6Q7IXiA3lFhOPkvwbM6f5DBHfUg58NTNUONqD7zYuXsh8c/nLKVt3424FD0nfpgRTJIAc4SRnGf+sADMHZdakjsHJP4BXxtFP4sMrt1BiBoUKjNqu02yXdBqO3uxrytW+wDYWMbeVhwjeQv9OSqyuA3DnqlH8UzU39+pn5JzecXyCgz43o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07ae794-6855-4023-8bb7-08ddb4cd2833
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 16:18:59.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJW9D0BQpz1UWrROC3VxKsJIAonHETSzIpw7X9ic/kR+jtn95If59vC8PEHvfUrzFg0r0FIFxf+KOW9xbyFZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260139
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=685d72f7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=ooyaw1e9Rp2UU8blV4EA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: MIQU_XeESF2NkvaXY9Pn-pwrceM7Y50m
X-Proofpoint-GUID: MIQU_XeESF2NkvaXY9Pn-pwrceM7Y50m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzOCBTYWx0ZWRfX54HRJGSRJozS btuqY6L5BE0YlLD5k+WwIq5r9fowoAVYPJlwXGpDLgo+phJC0jPeygbjZp5Wh0llEP1ZGpVoXMq HHlr6oD5cafXsyUqk73k0iaGerBGLKXNEGXaSNuJgLRh3WnFYhhg6QPcs7Bk/NLxdVVhObkUQco
 sC4d7J28Csl+/HXeeo/zENRRBaZG6FGe7g7zaAMklSc2kNBEddZLQLGqelMXJ5WsUEkAcxtvjq8 SK7fEPaJxkDHB90TZH4uKMhnL0ZlfFEYiglZymXy4wUWVpr6rlxj7RkbPpafNYiXZ4cS48W6wFC OTzKSruTPXARdWo48L7x6jMKKbrvy5mItXD5zMVgTN7wKrOEiP2UBXCwNYu09JxLXQrNDZ4Yj+u
 Qq5eAOos4ie24OONghTwcSv3SbwVRgQWMeqP8O+F7UNgLTejYCTD9jj8K66/9UiNrTANyWnB

DQoNCj4gT24gMjYgSnVuIDIwMjUsIGF0IDE3OjE3LCBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAyNiwgMjAyNSBhdCAwNDozNzow
NVBNICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBBZGQgc2FpZCBmdW5jdGlvbnMgdG8g
dGhlIGRvY3VtZW50YXRpb24gYW5kIHJlbGF0ZSB0aGVtIHRvIHVzZXJzcGFjZSdzDQo+PiBwdGhy
ZWFkX2NvbmRfd2FpdCgpLiBUaGUgbGF0dGVyIGJlY2F1c2Ugd2hlbiBzZWFyY2hpbmcgZm9yDQo+
PiBmdW5jdGlvbmFsaXR5IGNvbXBhcmFibGUgdG8gcHRocmVhZF9jb25kX3dhaXQoKSwgaXQgaXMg
dmVyeSBoYXJkIHRvDQo+PiBmaW5kIHdhaXRfZXZlbnRfY21kKCkuDQo+IA0KPiBXb3VsZCBpdCBu
b3QgZ28gYmV0dGVyIGluIHRoZSBrZXJuZWwtZG9jIGZvciB3YWl0X2V2ZW50X2NtZCgpIGluDQo+
IGluY2x1ZGUvbGludXgvd2FpdC5oPw0KDQpXaGF0IGFib3V0IGJvdGg/IFRoZSBsaXN0IHdpdGgg
d2FpdF9mb29fYmFycygpIGluIERvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4dCBtaXNz
ZXMgd2FpdF9ldmVudF9jbWQoKSBhbmQgd2FpdF9ldmVudF9leGNsdXNpdmVfY21kKCkuDQoNCkJ1
dCBteSBwcm9zYWljIGV4cGxhbmF0aW9uIGNvdWxkIHZlcnkgd2VsbCBnbyBpbnRvIGluY2x1ZGUv
bGludXgvd2FpdC5oDQoNCj4+ICtOb3RlIHRoYXQgdGhlIHdhaXRfZXZlbnRfY21kKCkgYW5kIHdh
aXRfZXZlbnRfZXhjbHVzaXZlX2NtZCgpIGFyZSB0aGUNCj4+ICtrZXJuZWwncyBwb2x5bW9ycGhp
YyBpbXBsZW1lbnRhdGlvbiBvZiB1c2Vyc3BhY2Uncw0KPj4gK3B0aHJlYWRfY29uZF93YWl0KCku
DQo+IA0KPiBQZXQgcGVldmU6ICJOb3RlIHRoYXQiIGFkZHMgbm90aGluZyB0byB0aGlzIHNlbnRl
bmNlLiAgWW91IGNhbiBqdXN0DQo+IHdyaXRlOg0KPiANCj4gVGhlIHdhaXRfZXZlbnRfY21kKCkg
YW5kIHdhaXRfZXZlbnRfZXhjbHVzaXZlX2NtZCgpIGZ1bmN0aW9ucyBhcmUgdGhlDQo+IGtlcm5l
bCdzIHBvbHltb3JwaGljIGltcGxlbWVudGF0aW9uIG9mIHVzZXJzcGFjZSdzIHB0aHJlYWRfY29u
ZF93YWl0KCkuDQoNCk1lIGJsdXNoaW5nISArMQ0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4+ICtV
c2luZyB3YWl0X2V2ZW50X2NtZCgpIG9yIHdhaXRfZXZlbnRfZXhjbHVzaXZlX2NtZCgpLCBjbWQx
IGlzDQo+PiArdHlwaWNhbGx5IGEgbG9jay1yZWxlYXNlIGNhbGwgYW5kIGNtZDIgYSBsb2NrLWFj
cXVpcmUgY2FsbC4gVGhlDQo+PiArbG9ja2luZyBwcmltaXRpdmUgY2FuIGJlIGNob3NlbiwgY29u
dHJhcnkgdG8gcHRocmVhZF9jb25kX3dhaXQoKSwNCj4+ICt3aGVyZSB0aGUgbG9ja2luZyB0eXBl
IGlzIGNhc3QgaW4gc3RvbmUgYW5kIGlzIGEgcHRocmVhZF9tdXRleF90Lg0KPj4gKw0KPj4gDQo+
PiBNSVNDRUxMQU5FT1VTIEZVTkNUSU9OUw0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
IC0tIA0KPj4gMi40My41DQo+PiANCj4+IA0KDQo=

