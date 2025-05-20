Return-Path: <linux-arch+bounces-12032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B198ABE299
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 20:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE344C27BA
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF6280019;
	Tue, 20 May 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+iW2z2b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q0Sod95+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EF270570;
	Tue, 20 May 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765544; cv=fail; b=KjKh3iYoJmPtlIj7OHY/ABk9mqYfWlF1z/ZKwh+Upl+9ZGLQSJM/nWP0OBfJcJgj07vcacRJogEr9LT/w2ONa91Z3aKjnXyGIkZ78UHV+Tm0ZOGwOBCfbky+MMc4OMr+vsGqCH2m4fXqGeEbAyTf7Tyii3Jkig5ZaI6rlWsQPPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765544; c=relaxed/simple;
	bh=f19oBLcCxvk5SFhRZ0FsqlsYyKdWFE2zUzylhOF0pXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eKFm52nozW8s1PtJTDYdxig79x3R5qkDBatWk2lgE1pXz4siUGkPZwr9pwszcIpUawyNEfgdMbfP9dNuW1Q0pUZzT0Vxk/6Rq8Sn6Tike4sdNHqbOoSjIDGPbwdOtQE7Vbk5m5Lccr3aejuG5PU7S2IPI7IKEUKSmbJfxRmz3cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+iW2z2b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q0Sod95+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KIMrDM012049;
	Tue, 20 May 2025 18:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f19oBLcCxvk5SFhRZ0
	FsqlsYyKdWFE2zUzylhOF0pXM=; b=m+iW2z2bOym1uxTrUzBbrKlAufO6FoUjLV
	uCtM5szfkrGTH4L31hhVkM/74lI2nuqtB6IJ/bQepjp6cW9HxBQfRQDQSnT5ZXW8
	/yNj7YcW+/6Cvn2E2O/7VcaMzjTkdA8/HQ9IXLEg0lMUY1OqfVRNmQO1CR8LJ9Ag
	rQNLN9HaHX5wj7d92zKElKD4WOgd4+w46XwhZSTVKEHc3CBjab+ybekQI52Qj7e+
	79ZbFwteKThylEXtojVeEe2cxPZtAZ+zfkU/lBEk89tuGyOwP3NZBvvwJ2xfPeny
	hYES2HVHlPf+QWQbYiGK9nfJK9q979z/cJmX69QzIVbY6mxpX8EA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rxmw011e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 18:25:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KI6vHS015567;
	Tue, 20 May 2025 18:25:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwenvmtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 18:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkrvYwfkvjm/XF3lflU3QyWvwJLqBQwRC+uZrpoxKsbqu7YH/8GUWEwHKMzk1QPUdEXwMCPPd2mFEYaVGMo0EMZVlUEn13cvm56NOZXJvz+CtXi9moVor8VtD7pEmK5ahG8DIv3w33eYLRg1QwOTd+C6KwIsCalJkSV19L4k00YUWSAAzYGSsmp379DPccJlp3T6kbpinoTh/VmOrn6oMmL+bZyCU0jFaEXj7kn8Sl/E3THoP4f2V8Y3EiONcMaCTBlCYQWokAZo/73cVDXWq3VewmbWRGCfd16yLkS/qijzZD0MZCHUqElMuIflH8oXaLH0b8oUeK3iVkqo+Wo37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f19oBLcCxvk5SFhRZ0FsqlsYyKdWFE2zUzylhOF0pXM=;
 b=yMj1NxPgz//gokg50aIS9fmIuYxvTEOwzSA+QJriulaUXLs8snI2+RHMtqVdMHocjTI5aNn/Dl01dSaoJhsXon9B+aOCdiWkzxcC8+tQRvPlZj761B89EGXmQ9V7CLSTcMDORcJId3RFXsX3J/Ra7Sj/x1MMCmZ+QxVbf53/s++KEncAevbSqVY/ROq+/BE5Umk5GF85CCKZaGHDe9tY1cSM4CLw/F3x3N+jkdAqzxCf2XhsmpCj3/25PU/KTGhCnR6dUmHjIs5jM4QVfE8kHOLBQCvOkcwbPSUaGjMAzrZs/u4hMKN8YyXZxcz+YnMhFjDEzxAXjKeJlysqY4ovQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f19oBLcCxvk5SFhRZ0FsqlsYyKdWFE2zUzylhOF0pXM=;
 b=q0Sod95+bAhwiGv7ti6Sv9j2y8Zj598BdMnN9bRiMavphu4C+W8oQD9x2MFg3iUfJ5JvD+fCIzmVZcWH3utTx1E+AScrntb5IYX5UsS7MkHBaJAIhnNMlT1nv4KAO0uFQQRqM1lBDpIYzbg7QqtitB0BSsxjyAAmYUh8Ds0VvIw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6059.namprd10.prod.outlook.com (2603:10b6:510:1fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 18:25:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 18:25:23 +0000
Date: Tue, 20 May 2025 19:25:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <bbf64de9-3b15-40b8-8b9a-dbf05fa3b4c9@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <dd062c92-faa9-46a6-99a8-bcc46209e102@redhat.com>
 <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54d2c5b-e061-4e77-ac10-3c29d5ccf419@lucifer.local>
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: fc640012-4d5c-4c8e-7ea3-08dd97cbaf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfOon4GBEAG74zSlL2SX7SH42ig39KDJ4tOj1k71vo6wczUV37qY0N8RJAHS?=
 =?us-ascii?Q?YBtG/jZ8H/OB9WH2NSO7/T8X1R3t6+hvXXgNyQ6f8g4d02KHMtNR51SC8JMD?=
 =?us-ascii?Q?Cqjh3uMp/JmO2eGJ0BjSiRMKzN51cMZQtUDkmnU2X2a74WrzreWVhNeN8fci?=
 =?us-ascii?Q?hVYK4hk4Lj1riYD9efSAF0+WNXHEbkTBznRHn5ZHd15buK+AAcBJaukQSGiW?=
 =?us-ascii?Q?83CPQAVxB1s2oAOvEpc+kH4EYITZ9URiS30Xg780pIZV3utRwa4zL3lekCVM?=
 =?us-ascii?Q?SPblyIhXFYjOUhQFm8oHN1Nu/ZjvtPUfHR0oEcMpVCKRctPoknvZxK7/BRNg?=
 =?us-ascii?Q?ZRMacNvD1+rdqJlPncjhovVY+qAdcO8Tidcol5Eh7zlAdQpopHrx/vAkKci5?=
 =?us-ascii?Q?Fgb6HoRujelm4oS23hFkQfmSAphh/iJ4rAz9GahkQ5RyfVtOOnQGirrWnEYV?=
 =?us-ascii?Q?BTWyeabyML2gyPy4EBgAybpL2AVamIXsfOz5EeDdKRqx67B7v45QB3QAF4KU?=
 =?us-ascii?Q?k/Hvh/YHPPfo0Cp28RGrhE1Wq3VJJtj9Oj8lNLwKGuzcM7/czB3wc/hhvqgG?=
 =?us-ascii?Q?X1JX5phVGKxW5oQ3Pikf20byUiT+yonn8oZeO2n7hcZ81kLzQ0psi2OesPg6?=
 =?us-ascii?Q?6YzIYEJqt6tK2h0vtZBAh4nflK/vibLvQG+o0Z8Vf+XhQZM/mpnlpY9j4Zov?=
 =?us-ascii?Q?N7n/PHUchdEKoUyuQnwJoM3RfXMhMvvmuXPZVEYtRIWm8wEJKj7KpsB5NCEi?=
 =?us-ascii?Q?yYX09B015u3Lp3Y6UcpddZ4Icr3InuRl06Afcp734Pkzy5BpLAxdpf9HpHMB?=
 =?us-ascii?Q?/HJYwWcWueZkDmm3j0/rEQG4lQV7kI+aoTC8WcrnLndq1GMfZ8yt0pd6tajQ?=
 =?us-ascii?Q?v5WANmCo4tY6Nzwo93X5l3LhK6uby1d0K6fV3EUDplSVhSGUc3zrjTGoBEFj?=
 =?us-ascii?Q?2czryUQNTLiJNLxvoeu2P6TT+ty6wLAQQdxCEPAnkF9JDX93qo5QBZ55TsPw?=
 =?us-ascii?Q?CASvQY1YaN502c9TWeVL0T+8nssX4wAs8s/AnNBjVZcJV7tKd9odgq5okGHC?=
 =?us-ascii?Q?8WMt3bs6hyfrDPMud4jM7bLb4ER+vAHKpKCUrLc3Ba9QhP/P8MLwECxqaPiK?=
 =?us-ascii?Q?NgFbkB1sORcwFr/IAwqwW1kzTkUpKTxW8uHUxMEdXg7cRqROk8xrSfpw98tW?=
 =?us-ascii?Q?hXngnsMdmAblT2ncwk+yIZj/uuSEspJOb3x2m53X6DaH/ZdlLIIU0Ni3ClXk?=
 =?us-ascii?Q?AqPyVnK2tKmUISIBhYtcYMs6sxrnekNokZrSbOqS2eq50oHEIZusAuhmj3UT?=
 =?us-ascii?Q?eyKNrYR6ZvzZjq4RFjUaS6T+KGZoLZXsnhHJwV0KBUMcmW0gben2+1YwXHzw?=
 =?us-ascii?Q?f8MbZ4y1bv8xZz8LcQZQCV+/XrcYhJDrVLCvJvvjABnUYw6PFgsyrl4Ungv4?=
 =?us-ascii?Q?EmLdH8xDgIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgObn/kJMNiNeLLOeUmB6x3CUYs1ErMw0pFTSZZfIJ9E8sVMnxXmr0Dz6U4O?=
 =?us-ascii?Q?nkFFcdx75sVXOer5jjCNIapwWKEnwzFYn8zvegJ/zpxYSKD+jKUJ15eeBXfn?=
 =?us-ascii?Q?fFemxgHchMdPfmr0ri6AjF0gegWXHg3WIE8CIKI+aBzGBP05BHS2DZFsmzMX?=
 =?us-ascii?Q?mt2siOx6GtfiE7eNIQe2F5hu1ruOhrJTCZiJrw79U6O5H+YFWRoOhUDfzeEm?=
 =?us-ascii?Q?CGYNyRwYPf0smLpP5MhBXoGTgp+LOYoVZU1CYYrVZrVffJfVNnrD8uyPgqUn?=
 =?us-ascii?Q?g7XumvmZ3HeBW2xyF1onLDqHwMGn3Sd1MrhSpWP/l9eREZb3Ui1hK5sScoBy?=
 =?us-ascii?Q?ibCm3l9iuAZR37i7TWqtlrTvbq11F9YCGu4yEma3RjDHgqaxqqL5xdt7wQ6G?=
 =?us-ascii?Q?lYXq9/XFoqaPWmEMCXIjFMh7HEcKeChHDkOMw/wnxWGsYfEzLkwvS8hw6/yU?=
 =?us-ascii?Q?goNFldITBGc/ondr2d30oVg9T2vaiOwdkuNLmYig2gsaG11eJIP5q2jMtRln?=
 =?us-ascii?Q?zYRl3Dn4U51zJabZ7jeEeuS2+kS0QFKA0rX9zx6M2TCu9k4v5Kvy68pa1wPI?=
 =?us-ascii?Q?BHUteVMOBtaqT1R443Bse5FtTfk6LxBd40zVcTjcD1Xfir5cSptwexqV4DGH?=
 =?us-ascii?Q?eGI0UNoQRTD+powKFOfPPJKBMSodoNwcomrnNyQl9FotLnpo0UVn98HhkrcV?=
 =?us-ascii?Q?Q7KHOmUpVWZafqiWkMuhGSF5MSmIpiSXSMeQgMV6bMOKJfA/JLPz5jM1By9n?=
 =?us-ascii?Q?T38yfyZ6JXeieCL5uwTLSzreLLSwJdyt07d7pe6cQuEd8szaa+As+WnzmhiG?=
 =?us-ascii?Q?JNRhCxYDjvWNGtY6HTppSGRnVqvsVozbvMMg4URsVst+v6SvI9XmdZn8rvmq?=
 =?us-ascii?Q?guQUb86SRQunnFj8uhmFjoWxJWbMoAGW4TSztNKhgG5K0cVkA+utC2sXBf/p?=
 =?us-ascii?Q?68ZusYGEenW9eLYJHMV7KAbouDd5RdKGmhvaAh52Uq/gODkfRP1S8AEZzp/8?=
 =?us-ascii?Q?YHAabf7lSxCcK0PSsA+QkExmzWs83YP5YRLidtGeuqFwqTquUp2sHqtia7Tq?=
 =?us-ascii?Q?SXf7jweTjTwW0/a1AtIOownD/LZTLU6IpFr0FvY1ISpcXgkjA/NBKPPY1G6P?=
 =?us-ascii?Q?WQ0h0no19Zpo4TFhS4VOofxLGHnwIFje0l9ZuS5DGPK0YKiilrs6v7nniIpW?=
 =?us-ascii?Q?XSHBgujgQcOt386zHg2zSL5jROtTXEh6C4C+FJVUQpnEpsTTvBVpO/ec2D0v?=
 =?us-ascii?Q?GaD9Y8JG2+KxWS/vq69fuIZM53YFmVnZyLWGx3Cmx309ghALzuwa2K9Iv0ua?=
 =?us-ascii?Q?rq08CTQZk+PLZhgQxjXCgZIjfBNPLktto1rDzp1xkjKYPkudzPGoZTH8PxFL?=
 =?us-ascii?Q?vfC3uSjdkHRB7wYJ67nvByEeF6rauIPP5ySyzlQcvfGgVgRyuQget2pIyvFe?=
 =?us-ascii?Q?8jRzc7dddwZ8Tnqqzpjly3PsqVy56xGq0KtB+28x9PzwguXclU1OlOt9/vAc?=
 =?us-ascii?Q?eZUx+T3xSy9UVjjnxUYoWRaYXN5/ysFR50vsAWjPMnjkVQCB08W4MIcAAPdF?=
 =?us-ascii?Q?ZHNdfIO4tuX0oWeGeWwKLWBed3hNJOW5LsA54nrdMp/AfB0RXzJpmJn7Vq8e?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Glo26iu9Mb6MqLRwUNkuLSVYyQSAJMd1BTtKM4GmI/MmJCpl7/JdOs5L42/41RtPPFqfyFgHQkTDVaVkzffaA3U/69FaNguYJYZnLBjWWf7jZ7BKNVcGLBvcpXI6MxWypuPa2xMeYfn2PTRYzEVM6mqOw1PF828tbWc1IdbK9LoMaXXI2TZvPcSWA3Z2IrhCTiN1HmXyLCDFa4eYQvxk3UwkM1EGPtd9JhQlUv+tEPWgX54e5JXJG7Ya9SN1+zyKOtL7jqBGhHhipIKeT+/CB8ocuhMXxW//9WVXi+WNZ0Jb82xkuqvUFaX6mJaNEkKGg0cAiLCtN+OIFlbvQHe7IJx0UZU0snVTGnhDwG5tB1+u176oY6BwIezWHJCfecN5XarMukdk5d+xjEDJumdYhb4XWOIo7vx7afFAjl7LE830MIGzjRxbCMuy8e0IBLZzsd5h+garHbx2uy8L8eaF75+CMUrMyUrWDmR0FOyIwBpPZFnOokeujbB8w37DrBKAuSMk5QSIhy5g/Dclo6Zbo2BO7Qk+vtTwbd8ypnyJHll7BR/JaB6AdGkX2/hbcLdL0hK5DaS7yPzePRS5zk5DPzuXBtR4ggkDvDFnsfUeTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc640012-4d5c-4c8e-7ea3-08dd97cbaf86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:25:23.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlaXeie4nwMG4BBvsRwTGNgTw+Sp46Bk4k1emPVUak2YOpDSSSNdD9tef45P3rg+x4KIFVkhZ3JF7dGjxPBf2oe66FtK6tzNtzu5DxAaAXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=792
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505200153
X-Proofpoint-ORIG-GUID: wdEfyJ8uuQ2PdXDe0ebcW9wdbQNmC-Ds
X-Authority-Analysis: v=2.4 cv=LPVmQIW9 c=1 sm=1 tr=0 ts=682cc917 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=AbH0yz07RfWZiPX3FVMA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13188
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE1MyBTYWx0ZWRfX2iAZcY1j3Lqw 9VnFUW6877sALZTI88dre54PADvBjj1C1By2cVvM5Jp43LUKIhexprlBvNfPLMC+nK4ZqNAhl0H EyGeeUNuPakm2qGbUW6bruW9L0Nxf5Wn6Cf7m8pMWNnVaOKkSBmHPkdL6kr+iK2iZW+IgdOGzCG
 YCczhWzuY++YwyHQdpKUn8xJtjkBdDikXU8M8BmjBzyYezr+LqNem89pppKuJEyRZAy7Hq1QPSY wPo4Y35xQgB38IaYaQud/m+REQCwpLlOxqeepyV7LrjAxHF9/nt3zUf12iPZ5iomcFraEyW2a54 OMkeBPAQhnlfOnSno79rFAUUbdrtf8Tcat9OAAjColfkLD4eAbw1eF3nNnBe0TRHivYtsnTYydj
 3Ru0Gy3rsMb8Mce0WfA2ed7yT1POAxtaDTOj5QnTYBs3S5Nkk9yq24+mH/6DkeBaqxdec/vu
X-Proofpoint-GUID: wdEfyJ8uuQ2PdXDe0ebcW9wdbQNmC-Ds

On Tue, May 20, 2025 at 06:47:48PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 05:28:35PM +0200, David Hildenbrand wrote:
[snip]
> > > 3. PMADV_SET_FORK_EXEC_DEFAULT
> > >
> > > It may be desirable for a user to specify that all VMAs mapped in a process
> > > address space default to having an madvise() behaviour established by
> > > default, in such a fashion as that this persists across fork/exec.
> >
> > This is very specific for MADV_HUGEPAGE only, so I wonder how we could
> > either avoid that flag or just make it clear that it shall stick around ...
> >

Sorry missed this bit.

I don't really like the idea of only for MADV_HUGEPAGE (and MADV_NOHUGEPAGE)
defaulting to doing this, I think that's far less clear than a user explicitly
asking for it, plus most users using process_madvise() wouldn't expect it.

So restricting this to these flags only and rejecting all others should cover
this off fine I think.

[snip]

