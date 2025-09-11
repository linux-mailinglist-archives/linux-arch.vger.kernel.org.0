Return-Path: <linux-arch+bounces-13509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9552DB53E41
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12CCAA6885
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B92E2F13;
	Thu, 11 Sep 2025 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IkG4upID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TyMqO7ye"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C642E0B58;
	Thu, 11 Sep 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627902; cv=fail; b=WCwgTz0r/GEz3dw2wRgfg9iBYDFrpfM0z1wLuJmLTvmbI3y5FMMHZR8CIntU4T817UIh3uwLTdWwdrNeEYSy9nZwj9SgPAM17gSiiSQUxHTpE6VzyxJOqr3mEBbbVhSAlxOYzQiiUFr1pLWsBcZWKbC2YfFhQKFRUOD9o5jgRi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627902; c=relaxed/simple;
	bh=XzGfnx+BN/F5SKwXUtGAFkiyaH+btySnWU/aWz7Iwro=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=U6JH9OpYqQ9x3+VdjyUO1df1cMluMnZKZRKU77GZiq8rvuyCriIcpDV90DggTGoUCBuJ+tYnsi2cvrvHUaR5C67AWQA+L9pVZ//B7cwBVRm0CPa0ng0iJ8UCMzE1GKkJXsXC+hId8sexBbgd+5QQYRnQY0QOO+XE+KWz9/70ruw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IkG4upID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TyMqO7ye; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BLE2N9016829;
	Thu, 11 Sep 2025 21:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cico36RzyoDNrLIV4Z
	9U0lEsjctPPR9FUW7wKGhUzEE=; b=IkG4upIDR8a+AhJ2EjPnSU8AStAikO2CHK
	kEDA015M9ghZkkV+VEd07IxryoGDJd4cx593JLr7MON+ty7zKAqAIfC4XBt0WAma
	aYgxf/AYHV32TpW7Ij8aO5ri5geHrlARDqzKnQGfqD4EtFXhs8W7aaz3+rQhRh66
	9qXa7XOjRpsZBvCPhBgILs+XM8dEAYFHugzcbFkNzdiSachwi/169FVX2aN47HXM
	BdWLK2rT0QWuOtyAAIdsRl+ilWd43mTHib/+OzGPBmtTSTUopAUf6usIMh02ruCi
	/uTuWpJ1q713taEpDQvQBIRp2zJjSCVw4kxuoJEnz1lDMxqiqZtw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x974n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:57:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKEhUS002816;
	Thu, 11 Sep 2025 21:57:56 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdkk1tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTw5sMD5gpxzl726Nn9ekr5KYBgnjdFuTrCyU6hCXKRP9Ho/8HgNyKDV9mJ2AeNdKDCDjwje8FVxRVxYDH+woE/n/y8GTdfY3TZDpz4/aXoEV279e3oSAjMCkUMTDdA9a1mLjRFnfw/eqBw80ciCch74epXFZRdg+Efr++yntTmmRkzqZtpyaUA+ZyyJrKH1+i1aWZfY0BUHY65vesGcX4hoQfMqHwsNBoMK0eDRwY9lZqQvbcasK5cyT0D0+GL2P2LhcBeMqi9WhgjN98wpxp1QCStWNFWC9AsN568bbLrikfvC1mhsMCZ/VbJdeziUFEezF8n69cWDiGNUmxufCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cico36RzyoDNrLIV4Z9U0lEsjctPPR9FUW7wKGhUzEE=;
 b=xePqbCUxLZqMpsVguwSo++KrTL26XbETd82Ro6wJmDV88hrdnTtkOtOwAvC9N08qZ1r7oeZPwaGwYWDwX0XYKH+8gyl/qOS21LuqBXP7CA6nh8IfqxXwzmrxlR6J3fWf28iK59sEEL84CLsvEQ9nZQMhl+JDInplIyJ+fo+YpMBzTHaAr8UNO8HY2Ljs3/A2MOEkUxfEHgiOYa6boN1bzuQeZ9kULNpzSBcIvXB5ekLwedOqboPK2SfRpn1HnFTksmDE6O/nmNlWphIPsQB7DCHd8mYeteFsqSKb7cERTHevTikQ8uFyNM99sRgp2PaCyp1BRIKo91+q4b50PHct0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cico36RzyoDNrLIV4Z9U0lEsjctPPR9FUW7wKGhUzEE=;
 b=TyMqO7yeX6fYx1ANgUCAIV3DTunkCwZQmncoecb8JWRyBm8UYli5piU8f+HhGhWadT+k857/kj+tvFkOI/0B7ddAw/7adT1i96eF75FczXQ3u+hp7IqvkA3kgHihctnODIdMWpYPci4oeSd6N/l6fEle8bP28jf6FF9e4no1ZnY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8176.namprd10.prod.outlook.com (2603:10b6:8:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:57:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 21:57:53 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <aMLd2QOFrZnaKcWf@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v5 0/5] barrier: Add smp_cond_load_*_timeout()
In-reply-to: <aMLd2QOFrZnaKcWf@arm.com>
Message-ID: <87tt18k5y7.fsf@oracle.com>
Date: Thu, 11 Sep 2025 14:57:52 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a14e830-c091-441a-bf78-08ddf17e4200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hemgB1C5wOc7X9vKpuaBspUlhT6lfZHawqLt2/ad6A7gwuJGtXd+4jCVt4Ym?=
 =?us-ascii?Q?fb1C9oAFxChaC3pYNozPNKhUzZjy+Eir01yP5tWsFF6CLldR0BL33cngbO4Z?=
 =?us-ascii?Q?7V2WPeJp0qCQ+5WITi+t33nuDwZttRN41s9C/21feHSnNg3OVdAXSwzjc2Un?=
 =?us-ascii?Q?ynJ/VZGOAnw+wHKQAcgo/W6ubb/4E/2fTY/18ecmYUK4IcrsLBNh4uyKqrW4?=
 =?us-ascii?Q?iiL4wu49++cL8sakdOKh0V2xSvP83Q/TNKoPkTztdxyuEGNHMJoXzJM3EOTo?=
 =?us-ascii?Q?eW1f/TIV7ETT4sWiMJ2wIL/G6j6/N3HXrJUXgHx5TD/R7UkyWd6lTwOUAl4j?=
 =?us-ascii?Q?RakEh5cJORJYqmQS2PyEXIapo/3PLvcWAqKXKKsur3T6P066c2FOSBn1exF8?=
 =?us-ascii?Q?x5CJn7fzNgqW135Ebdnpbj8sBpYO1E4mhjzEAVKW9+PF+ra/a9Om0p/4pNsu?=
 =?us-ascii?Q?rZp/ueyWB73t6eCQNvgJvygq8C0TIpnpyM7yVM2P8vXdvMMmDRTZIqJS9bPK?=
 =?us-ascii?Q?5XrqOV0ubpiHaweuF+w+RKS9ZhHo7h/YA+XXOaItKrbI4PJQ5lggsn8jqJTi?=
 =?us-ascii?Q?ocurq1hjBJD7KoFLwzEOT9N1bKVR6Lq5wCokuqxrnkbn26BaWGgiGf0rJsxr?=
 =?us-ascii?Q?aiUITdcuHPg16CFHt6XBtxfyimKk7gSYBnM+a7ImGg4w0BMSfimz3wpPZTAh?=
 =?us-ascii?Q?jHmptOSiAB79SIcSaIXTXythVTxkBklzQS/wo9xOk28Y+3QrHY6oQt/Jxwcr?=
 =?us-ascii?Q?F3s9a4Ms+LP+T6LsftxpIo71xXWUhmbS6pV1ux2ItbuwbswTelyQavNiP1c9?=
 =?us-ascii?Q?WWJmybdIu3rvVkMVAB8pN/49SSJUNn4+/vRSbMaKnlNVzyT+foi1fvnS/AmY?=
 =?us-ascii?Q?lnwYZkA5LzUH/KeGz/96rUaxLh/87lyoiqCXP+iM6mwtNs3XFNpwUxZ96hxk?=
 =?us-ascii?Q?f8VHJUvvd+mxBMQDx7PddnavWgxecvfYwngmVxt37ijYgDYGISHjIoIhw6zP?=
 =?us-ascii?Q?6YokMeBi/Fg0I0wGNVRxXeHEDYeI1UteJEUKzKHQgSVpGhPV2OQnr9XbklIc?=
 =?us-ascii?Q?WwJrEUKmBRqkEepYMwkZInA4aThUoTbkBcbXDRi0LZIyqz+2lPWB13iVcxkf?=
 =?us-ascii?Q?mi7tohRwPuQ+iEY0W/SHd5pYMlxenfyEEswMMFw2L8qfJOxnYZu+h8yuyBwz?=
 =?us-ascii?Q?dF8j0WxikZK2fPX4Evea6OQuSImOcSeEmGl2QhYwi0p4lcgnfdjq8cXewldy?=
 =?us-ascii?Q?6+ajsDJaKNjkhvOS4scdIHthHMGFzz0974UJ8UbarrmU3i5c1Op11JhVSUmg?=
 =?us-ascii?Q?w51Y4Y5w6fv3dAvJm/a6OHjPeLCScVbG7wOH0EWyfHLNAEdlcq+UlAvPLiyQ?=
 =?us-ascii?Q?aAPmWCrbEkmb7X2CAdY+xdteuzr1MEDckHX/0gf6eLLxFq8NWXkUpMkPNYwT?=
 =?us-ascii?Q?is1I4WJSJSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72nwwzBRRhh8TAgjmNeA15HBnV+n0Hg51YAaC1JPmJHkRoJdpNTFjrnakQQB?=
 =?us-ascii?Q?qrR7k75AbqedfrPhSL52dzZnzH0LsJUkgkYlfAopn7bVhLNwlE4tjXU5iYFC?=
 =?us-ascii?Q?dDKeCpgmdm8SsYnZvwYY1lYdGC3sl/dpleUXGlvP8q7xCw6U4l2oyVIcIrgR?=
 =?us-ascii?Q?ahiJAkRPn5U/jdZfPFHCljav0xNyEKmLJuF57Ls8JknwMVCxtgjBWn9I+QQD?=
 =?us-ascii?Q?p/TgdwU8IZzg38hxgqufwjgWDECxrQWBj4VzWn9vMYLnkaJEYUbOrKXC6Su6?=
 =?us-ascii?Q?OD8IqRDHI2uxTMpZv4rUMc3Teimsd6+z+gxl/bmXh2MxvmfryinXWmvyL9bV?=
 =?us-ascii?Q?xQ3tXMOAy3kwTWotUhNJyBQMlwe1ksg9KHvuXnxn64E059CJxmb2RNNB00Zy?=
 =?us-ascii?Q?76BUseWdlyWTWOCR8V7zp4Rrof35v/WCnQuXRvqyY2Rq9HI9XSvMfumESd+X?=
 =?us-ascii?Q?rKshlHDZ5l2BrvxlwJ9jsSzu538qi6vqBn3uGh/Lemy5WxI65270761kTYck?=
 =?us-ascii?Q?PlLGA4wjesuSrs8e35zQJbyiRxJlogVeOW3ZAlI07m7eWg4dUjtHfWsKYy1Q?=
 =?us-ascii?Q?ZBVniEtN6Rmg+kynGoz1nW1rqf3Bv0Rd8CuVQvkJnC67J4MoAue1kJKdlD5o?=
 =?us-ascii?Q?WvlMISZ9ynTuCr+uvVpzAoEu0u3VZ1nZ4f73oGXvN+YY5DvJwrjE8tv/CUuh?=
 =?us-ascii?Q?htKEYw9U13rC1qzkKXNHh+U/ePqL77oPd960z/GekUXSN5wvGssE5mRmVFY1?=
 =?us-ascii?Q?JQT89h0OsenTLonl7/7E6YAtsDUgApztoi/ltVdmndEkHlCHfJJwG2DfCfQl?=
 =?us-ascii?Q?gvKMm+EbxLP3PZio1wzvvwCJXvCKJ4Xnh6/db68wUuKS0iwHDXty6hSH+TJQ?=
 =?us-ascii?Q?q83+TiX1qw29Hr+FRpZMNLP27KsZzSPffvPxw1/2QkxJLt4v7wlhzq9hzNKJ?=
 =?us-ascii?Q?az8u4qjhrH5hfiur3vC+noueLE02RBPl3ldYxecq2lbkXtW8VRKZK+5BjjsF?=
 =?us-ascii?Q?lds2sWfSGRayXboqRNasQEcr4XyVPYVgSkgRAfUYN+nlqzD5pk8+qSsBCi8T?=
 =?us-ascii?Q?AJKHTHlim2VMHDSj8kj3hLfVjxtTeFAEdm1TsIvm50CINFaZzA6cXbcO5hpN?=
 =?us-ascii?Q?CoE5/IYkQ9Hbk6DuZXCQuo5DfhHuaKH7k4c0/soQqWGCyIZcjEaVJ8RppwpV?=
 =?us-ascii?Q?hQJIvELlOjAZFC9V7Njeb5R9MVgLcT5AnWIMjtMq1RqRxDWW3qUKUXePTkiK?=
 =?us-ascii?Q?YBIfzBcVACn+8SdIYLxpg8XtY8bRn5aDLwJuVmZuVnL9Qa+vbFGWrBHstHbV?=
 =?us-ascii?Q?qqe3hb+o2TOPmTx11nx1ObcZA3Ya4Arug+N7MKvjrNorR6q5jvjuSKP3sVSO?=
 =?us-ascii?Q?u2YCYDSB/wn3qm9l1HA8Dyew3l+ni/KnunWjupBK6kb1+2WsjpWydWyl2IXr?=
 =?us-ascii?Q?EZmbPetcocQkpAbJFN04urzw8oanQiVxX5wT7R6Ja6zrA/CN33CkuyBVY13E?=
 =?us-ascii?Q?TN7d0aPuU/uM3Z4wIpl90VNJxmNcEozVS4l2VYZWlkEpRNsC2/HJDq3V2EVP?=
 =?us-ascii?Q?VR9CWdgG74kiAHLQXgxpGbb7Z3nXbw6U7+Y9vZI44cFNcpjxSZmoV0rqBCXh?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igR7hTkMiSJ/gYTO0oRoDfQ81fJtWsgGStp5JZoa38uY/PxnT7oQEgka8zdqPqxbEEwtSwNjWhWUZDIKldwrDEAv64/0UBbZlPVckFvmu/URK8SGtHSbLDY0UW2F6iubBgEFiwE6zaZvcILWbu8lYMevuCOzgYuFAsUoaZ4JzuIX+IA9kEOEMlncmthxo/RjKjSWmyhGnJ6uR0x1OttDCQ/LcdRC+eMEGEB52ZoJ6HYNq/V3N0W6C0/V7FALuYNGFtSZ4TWgVNTpJ25YOTtqwpnX/9WZkaplUJUY1FOVDkzaQ7Zj8CTJsfy5yO4J/v5ThgMGGNiruKFuajDJ63YQ0PgHW6s936ba1esJpkxbDgVRhMt2cO0o2AvTrkAT+cu8ZqqvVxw3a87IDa4J0SIwuIsOVnPrmtAJI4agmRPuseIlvDXTGwOpsLZ8h86g0EkqYyOXI4BlSEwZV6kdEzIxIjR31PA5O+cKSPHxoKwvdO4ZDWXGyplJ6HBm1QZnO4AbJdxXulbsxUPENNKYS6g8RyW11LaAm5ChOUqoXB1zAVpv7i3z2qRYP7RmLUePrDqvp+qa4VksiHNlmghrXtiq96wo/WBSNecYK4LbbdKzPg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a14e830-c091-441a-bf78-08ddf17e4200
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:57:53.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9Y0xTDsr32+WctYYp6WizW54livEPAs9tDI4IoWuWJYaA8OC3lY5aIY8ReCcrKHGqs2KUcEjzTYHJ7oprAHPCnuA7NYMPElarjbVo+9LTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=956 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110196
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXwc3Ilty1nndm
 0GzvE4Ra417O7F7AQz7XjtwWf3Q8ICIyxSTOLQKeYDl0vasQB6orBNb8Wu2LAAhx+Dj0Jd76zoS
 G6coBThirHtCkM4wElY7WsW+lQh6u2jL8COkuT9bOeg5CD4XdBkYCjK1ZUQ9Mm8Dhv2sQTojM6M
 hEzecnCsJTXjlCdl4muQv54Fesz5I/rm+SC4Wti4LHrDs9+XFGnmLgCCQoelJrx9LQV9dOb8BZv
 f/lX5zYmNIbEW5wsW4PoQqZq4ERjlSz4hU7MMQgsYqzOIDgY3WGdL58etwNtTRmMa/mxhk0rNA7
 4Mt+lPeUcESKbv3izlsNSQjnADewJZoukdzMHouD3ImASc74rajWNQoeHxzasENbu2amTxbdUNy
 cH/3AvSrzVJl17MpU7bQ+Z58USR9tQ==
X-Proofpoint-GUID: E292H2WSLhIrXDnFM8mzAb_-9fd26V1B
X-Proofpoint-ORIG-GUID: E292H2WSLhIrXDnFM8mzAb_-9fd26V1B
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c345e6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=xu2nqw_Wz6yuDEWY3U0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12084


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Sep 10, 2025 at 08:46:50PM -0700, Ankur Arora wrote:
>> This series adds waited variants of the smp_cond_load() primitives:
>> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>>
>> As the name suggests, the new interfaces are meant for contexts where
>> you want to wait on a condition variable for a finite duration. This
>> is easy enough to do with a loop around cpu_relax() and a periodic
>> timeout check (pretty much what we do in poll_idle(). However, some
>> architectures (ex. arm64) also allow waiting on a cacheline. So,
>>
>>   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
>>   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)
>>
>> do a mixture of spin/wait with a smp_cond_load() thrown in.
>>
>> The added parameter, time_check_expr, determines the bail out condition.
>>
>> There are two current users for these interfaces. poll_idle() with
>> the change:
>>
>>   poll_idle() {
>>       ...
>>       time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
>>
>>       raw_local_irq_enable();
>>       if (!current_set_polling_and_test())
>>       	 flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
>>       					(VAL & _TIF_NEED_RESCHED),
>>       					((local_clock_noinstr() >= time_end)));
>>       dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
>>       raw_local_irq_disable();
>>       ...
>>   }
>
> You should have added this as a patch in the series than include the
> implementation in the cover letter.

This was probably an overkill but I wanted to not add another subsystem
to this series.
Will take care of the cpuidle changes in the arm64 polling in idle series.

--
ankur

