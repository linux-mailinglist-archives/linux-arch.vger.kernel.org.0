Return-Path: <linux-arch+bounces-13192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B125FB2B15B
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 21:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B3A7A16CA
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A317C21E;
	Mon, 18 Aug 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NbrZaNIt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zd1Ue0zJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F771FBE87;
	Mon, 18 Aug 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544571; cv=fail; b=YcEDxfguf9lYXC5jefWKqK2gwSFMr2VqBFZZ6kp+d3lHk9yB3bnn4tO8daFL9HUQQrwFhLBWER23NSMW4w6wO/Xhyj0DIZNARPZPZT7UF5K60TnTQxIKYf9SMY/4aQoDLM4UfPkCepA3ENfh/yPuU1BC6Gf1seiZ5dwtRrDXLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544571; c=relaxed/simple;
	bh=P9irikIY8BZr2txHWCltXyY9BWAF/UJq6G9I4Ae9DFo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XPIR5acil3Bk9oN9Ob8M+q/69Hz8BUgsAvWxLBU0ShYCRpG6NYFCaS7KF5DHUfhNDnC272ZbUazlzhB2Th9y11oRSlvurY5YsoYbdfiAskv8rTa62LyRcfWPSV+aJFkv5/0662jrJJgRd34lwp7FHmeQNsuQMYJih5BsUO1oqd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NbrZaNIt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zd1Ue0zJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IJC0ow030920;
	Mon, 18 Aug 2025 19:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EshRcVt8FPJ30GpR5N
	AlCqfnjkVUfQ5C4FsE9n0GBtA=; b=NbrZaNIt37teBX4MduUGYMmxmOrgnHPl2b
	dQ1AQys6YQclb7W754dWr9W7Sk7z/1k/BNLCIkdDsJLDjyAOGCnv7bT12FOvZiNa
	R6jxrFaCLFIb6AKku6uC8e5tW/HeFovTWOsPGaIdK/ZCIVDOr6LBwtC1QwaPatmS
	API15f2yRWI4kauMgH4k/HKetwpbE8599zQGl6vtOw6vRNT9qDqcWe1Xu4pKXbB8
	xsYq3fpQyDBCxtvqFGeDpzWp1Okbp3yyF8Xw3QHeAfV9cP5dLAf2fwtaPI55QjSr
	uvC1e4GDWrrsr9JPBXeoNu8qItEygGrNHBJSKiA7aCp9lRJx1b/Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5kuwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57II0Loj036730;
	Mon, 18 Aug 2025 19:15:41 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9x4jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECDFJUXNNqF10RQB85hXvszq3+0jhvFwFkXYL7u5soFax1bIC/yB/6jsLNEkyOYJdENUQrGNB60xx0+YzxAy+uYPvV8I6dIc334dQUeksBlcOx9EYMWi+yQg/HmjcGgLavkfUz/gljRLkehM/eG+o7b5A1i4gPl/u3Vrm4TeuZ7M+u6zwBwsR/UERcOqyfrExM7k7CIv5b7k62yKa3+mzC1ghEDREKwcGYCsULOmv5b9I00ale6FhrkDteBeSnfkyibdxKH4RRLqTB1Mt3x1gi0zwUekOQa/pli2oLru8fUrMiLxNkTcX07skieX6tkAav/wBpe6V2hA9vvQ5l1wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EshRcVt8FPJ30GpR5NAlCqfnjkVUfQ5C4FsE9n0GBtA=;
 b=L5d5++fHzFElUM/4/uSj1ymmT9WVo8P6mGWRbdXOTNpPeXW+D2NL16DQq44ImVpZNZHxFjVrj4E+vsT048qufmvBZSWvUvi2ouDKKclHe3HWfSWNPPOCk9epVyg80NasaVFGX6DOSZ2BB0QnPEb2avqMGyxIw20aiIvw9CsiRoeojK0Y9RXmWpl+XrzrPnXW3QpY00HZnX4LUqtVe/LJdyAtOVfP3vM3tHXei72R+EdTn5AVJh77k0S/iV6fIIhvA/OWG4xMrun0fHbtnhet2KsOKH4ZBkkubhiWkGt9Uh+Qq2rXYGEobhwvOrAFD63Lh/bsAdyYGoqhgid5iZnG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EshRcVt8FPJ30GpR5NAlCqfnjkVUfQ5C4FsE9n0GBtA=;
 b=Zd1Ue0zJETjqap79uOOKMUN6uCsUARVVQOYr/3y/cl5CauHtZkGVN/Nu52W6sH+PfKThdCVfvKS9wyyeq3mewcfWusp1kh6XLv6/3i504paJZ9jhXdYdRK/8rnuhcQm/kx+xioKLKTgikeSBjtVyx0UwB94vElrViCbRq+/ek1E=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 19:15:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9009.018; Mon, 18 Aug 2025
 19:15:30 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com> <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com> <87bjoi2wdf.fsf@oracle.com>
 <aJ3K4tQCztOXF6hO@arm.com> <87plctwq7x.fsf@oracle.com>
 <aKNo9pxx2w9sjJjc@arm.com>
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
        konrad.wilk@oracle.com, rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aKNo9pxx2w9sjJjc@arm.com>
Date: Mon, 18 Aug 2025 12:15:29 -0700
Message-ID: <87sehotp9q.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca41c73-4013-4718-ccd8-08ddde8b98cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZjKVvmVnONBYzgJS3+L1A5jQvr/s+Me/CyOE862JtoGD3OCznjNGpG5uL0m?=
 =?us-ascii?Q?raUseMimat/f+VO23RD72pfbJ7H77+yxS8k0PewHZM+ta5FlAVEQ+bbne49U?=
 =?us-ascii?Q?khFEwJoCtMjgCmj4IwKOYfSwQrKShcS0hUuQD8vu241LPgCcXL8DgV6fq1U+?=
 =?us-ascii?Q?FMcoV600+uQwB3rY9T01A2K0hZRNnYej1K/faEc2Sk9JEy2pNH+MmaAZ+feJ?=
 =?us-ascii?Q?NTWOO1bqp5YNCaDvUUJy7svhjuWBTpkYbXf4uqSl/BLnTJwGF87lU2o0QFCI?=
 =?us-ascii?Q?duzRGjk/DNq8hNyuBBE7OdLWF5TTpkzDz3p4Y6FJjUqPfX/VlAFOCD9AouSr?=
 =?us-ascii?Q?9R07BA9Wn3NBHWK8i2hg9i5dyB/dXEy2ti6t5ZIxFqxq8UGw+UDpYI6OBP7n?=
 =?us-ascii?Q?hkoFWsGy+/KLUEFiqB+7JZX2VLkfpLqrHWxnpwhz4L8PmPMZZIc6XpSEWV7t?=
 =?us-ascii?Q?wh7JUlujXEMlr8D7PhfYTJSiIP8IGtnCO6BCM09g/adL43i46xbMU9okah0D?=
 =?us-ascii?Q?oXf0HgQXpxwNmkOdrMaDJdNyFD1nYIeauV2mF+119VjK5PscR0nM6prb6RWy?=
 =?us-ascii?Q?DeZQBX68ZAu70o3aR0CVussTLabPotZmZT7jKGCP5rrpi+n+Nm8C8cPhl2AM?=
 =?us-ascii?Q?oEj6S+8gW7D8VfvkFk6oSdGaZZ1ItpilwgLKvl/hIyJsl9P4dpuvyas2Fe6F?=
 =?us-ascii?Q?n75U3KIS3DzbQjbvFR82ODreYTcrcLYsnvAaGQ1BEyPPV3nKhLOxdH3odfgJ?=
 =?us-ascii?Q?lll1qXvY0xigX0vackEqzXlOPZIujMNYKcFyDRgQpUzBraWe819/uuylKH4W?=
 =?us-ascii?Q?ydeHRvWHD9cGMLVSJjRHD/ulTuNLufxARJnVrnUnEyznNV0kDpmHIw2Gj2E6?=
 =?us-ascii?Q?2y25dZi5czVEs3hrB4eZUNhXQ/R3H3iS3k2fqv9u9iN/PYqkaHzdPOQSPmSJ?=
 =?us-ascii?Q?t/vgjMEqkWzQyxqqgW+5S9IdtK8WnG61B3i5OfR3XLW3ZZGkQgIvibr+B8JL?=
 =?us-ascii?Q?9Rg7MnYnN1wRKE/Xqv9ZBB9Xi1YPRHQPvB+Gmu9s4SVcK8RB7X7Cx/OG7HkX?=
 =?us-ascii?Q?oeG8xKindMLaidIQIWIT09aLK24WMRDlr4zdOoxRvmDhdzaQUssW2KijmxA7?=
 =?us-ascii?Q?p+DQ6G/QEdOaX9SYMC4K06by1GEKCquuRZTsmH5B7IaZizLj/ochrQXdl6Wu?=
 =?us-ascii?Q?8mWlMYS7POk345c925/ENdwtYuEf+2oFegSVcslENxZNQktKCod9AA8Ymz98?=
 =?us-ascii?Q?voIaHK1XYGJRxr8Z/ahlU9he2/xE23OXi/WwsIVBPaDijiagFc9sqFMtK+Gd?=
 =?us-ascii?Q?cFCcGyOJ7+c3Vvn3RsdbOh5+PLYVvt3nlq0MNCGw2qQ3X51Fv9jAHRE2sLCN?=
 =?us-ascii?Q?cX/CLsB5vPyXw4WzgCQVw0Ry1Xv+EmyUTJ12q4+lgVoht9o9REDVyTLB/KGl?=
 =?us-ascii?Q?/8oMfFe9fL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Asn0i+AKYhi5SrfQewxK1oSB3avN0KVYr/peePy7nqFH/aNeokF1THt0dOba?=
 =?us-ascii?Q?b0GlCfsmWn8A9N+QXCk50bb7D1+/9Aj8VqgXqRzy2sueefXyED28unWELEX8?=
 =?us-ascii?Q?Q8e1237TE9Fu9UEJF0tQzo4JvdGY7dtPw4xE+ysaFIUO2+YbItlVrWb/Uozm?=
 =?us-ascii?Q?bVj3WosMSBKQUhfW5QI28kd35SoCm+2S65owyEW0JHu1UxCd+e9ejklj+V2t?=
 =?us-ascii?Q?ObTSoVYE+1YwVbNAKIXfqYdanNVV2+7DkjxXyRGpYBNsbNbV2hlYw42ELNg6?=
 =?us-ascii?Q?UtFqVlJ3XCApEZeVeM4F18XUMcoaMF38DIzBEUBqFmwKwqTYSbWZ523sb91P?=
 =?us-ascii?Q?UJ622x636L3CfTmjRnKf3Y/TDlk9Xm3u/umZYR1eT1bJXdC0doZjNzPJCA9Y?=
 =?us-ascii?Q?44CrnSaOy3qs/0EcFGH0jYebEohoDQYPmOncaUxskmaa0ozsXBunEtRHYj2j?=
 =?us-ascii?Q?5726bbo4OS4MzXA1yzry7EhUjNQ879DHHeVwu9+Oi7p458zQlMDtkQ6mLk5w?=
 =?us-ascii?Q?Vz2/NsT7Z7LXASAOb9O21PiOH4eABAPCw1/5qrYTC8aIre5+wnCrWl2D0g9X?=
 =?us-ascii?Q?QQlkuUmwN9y+z+6vMJwzFhH92xroFC5aOaSRm/mSPVI5Mp2lR9WNBhJikH3z?=
 =?us-ascii?Q?06mQSt94RUqPJruikzHD7O5xCsssEysUMWEDsMXIIx61647h15fH5p2ifVc5?=
 =?us-ascii?Q?Jml1MrXtpo2jx7m8YCt2W5nHPBQNRKYB9mX5NRXRmHkx976wDYqrDWEL3OCx?=
 =?us-ascii?Q?QYsD9EcKqLaiNfC4+2iMiQ/U1nkhLmbrwj0buFW96yj0sfzDz798sSaQJJ51?=
 =?us-ascii?Q?cYAb+EFYkPFbxTgmnhvXuhZlpkxJ5OyOvByLLQumg2yCRVFHMbUy9ANicZe6?=
 =?us-ascii?Q?YbDWCb8qCMuuHdjGroZgy0OCAxxiZm6/zIQQnOa3x7rZNpzEfGvxMleOtuEq?=
 =?us-ascii?Q?TgJALW/PJNCrWs4ytfLNYX2K4X2v6jH4ei+jzxr4OIrB5mhpVscO3hBpEKot?=
 =?us-ascii?Q?Ll7LxG2MLYff5058O6NVKQ7Ty0/DatlJ6jcJZeiUvk3utmctLbGNwTXBll26?=
 =?us-ascii?Q?k//KVaY4QahVJjqAGObdAMEcQTuA3wWZCunlYDSWk3deXXldeWhoULIzoIu/?=
 =?us-ascii?Q?/WcrFc98+H8HIBTuuJbC1v/Xuhu3248RcdoiQcMb4YH5xoRCgOAF78M/fPC4?=
 =?us-ascii?Q?V9cwsoJ074LEQH/17UmWk0pcsHu9nDB8GnKN+FWQEY+F2PazlBCJdkSv/7lE?=
 =?us-ascii?Q?GixcACDFWEYil0tJMiw2eVXpJx5IK7+FpgUeUXrBZ+Wn2cgHd2sOQ+9/EmaY?=
 =?us-ascii?Q?wLVxG4U+eJhxC+hd0fpKVrPKf7p+EVJuEO/5tC7NEzeFqLdYn418rAfoiUPL?=
 =?us-ascii?Q?sbFFL7Qdz3acApxTr66FC5DietU8kvVtNNVxlqALefhbuESWXqQjr5A+kvAW?=
 =?us-ascii?Q?vkk//ZgIjgljk37xCBinKucC/AaZISG4QdbLf4eZLSmDxFi3A21n1+RTQFlA?=
 =?us-ascii?Q?TfCaMogI5tJyVWKMEnjYoTLDEiVR6nRdoXO7qidGy0L/9WCQc+tCHXT3Jx6P?=
 =?us-ascii?Q?UhZQa4nSIVaPoYNm/jVXvkUNM0pqDQpyd8hj/Qj9Npe/OBK01/5CkJQiZ+YW?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CpJz4eVyHmtg+rbBhqhzuFAcUqpX5ikIR8eF8iYJQP4xSMUGLj/PpZBIbWmbSH0v0cY+DFwxBe0wgBRpZYKCisw1yg43Tx5Lhf5qnGGYNk1/EhCNXeZ4FXpFaQr1yjInKy05625Qj7gQR+tIh24dkOZ68zWAV4yUsTk996P79Jrt1g2vDyRYu59/NBQ1ZJMgJmkP6eP9raPX0CMV0JrYjfihu8bc3opS+KLC/NG/ou7QJFF71rXKcE+zRCvb5iMmZ8OK+hMhariW46sajwCz04dCRgAP7hKVREFmvAAjPRrJiPLFIgm54vzXJTXnipoMW/7jE8oyZG3wFGkcGAKWuSzKZkXSOqmzyq8reidViPE+gH/cBezz13IQ6Q0SKWMS24z2gBv4QhyMvY2C922z0dG5YP9vPCDWA46VdbtOm/QvRGaefazWeew68fSAmHjPEJmmGIZwVRuFqYmLAQP6rmr3f5y6lNFb3Si6eZbNUUienm7ab+CvvxksMoqT/QZLL86tGoOVhwxScOwuNyiM+zdH1JUw37e+LKAoX7LezaOipdYGye+35o5RTlwEGGMGqNLWxCFLPV3Gtb+vTsWaF7Etm/pTe6FewvGIqpN1QFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca41c73-4013-4718-ccd8-08ddde8b98cb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 19:15:30.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3MvtT4ASU7+dbcKm93swNkrVDv6qeMmMXawLuUS8fLPCDa1hvZ+gmLsZydhuIqXlwGGkBZf6mGe3Ma76gz6YXkGHJ8R24ensWJGK9YjLGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180179
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a37bde b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=Uez9x1D810Z3miX8Nc0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3OSBTYWx0ZWRfXzwZacMlOsLI3
 tKkPc3qJu00AEj/L1ZUZhplkwSv2I4cMYxT/AcGqM+rQenC0c7eaUbUiNwGfXuQaWo4gAEsaArh
 7Di7nwjLTJ/LLz4vArkkKKHJt21LCkqvJHWVnTVtLrMdO9vg13X0rIiwpFyGTTKiETZLhuurMhd
 DFTkcvQlpE/0MMD7SQlVItLkQZuBjawTGGHz66IxFr3SOKJcaOm0S+gsZdfw7s9y+oipUuDaKNI
 OdlwqlghUrZJZbVlOP3YhYIrKXOkQNIjVhUkFERACKUAuHK0M6apSosOAfGuk9R5HfB2S0CRfUN
 TfRY1I886BZ46b68U45go2AQi25Sw14JiCU9sHmP5XKe0eqp5o5/3Y+YbUXHsnzZt3t6WrBZexI
 bEtRsBtuxHhnW7Wz0c7dI47E88KtNhytkehwYiJ26uVRAGyz4tfgMHrn73Nqcds5YsUP2Gbu
X-Proofpoint-ORIG-GUID: 8yg0FgZRmbBSmohTjo2b8ZW2PZOL6NJ-
X-Proofpoint-GUID: 8yg0FgZRmbBSmohTjo2b8ZW2PZOL6NJ-


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sun, Aug 17, 2025 at 03:14:26PM -0700, Ankur Arora wrote:
>> So, I tried to pare back the code and the following (untested) is
>> what I came up with. Given the straight-forward rate-limiting, and the
>> current users not needing accurate timekeeping, this uses a
>> bool time_check_expr. Figured I'd keep it simple until someone actually
>> needs greater complexity as you suggested.
>>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..e8793347a395 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,34 @@ do {                                                                       \
>>  })
>>  #endif
>>
>> +
>> +#ifndef SMP_TIMEWAIT_SPIN_COUNT
>> +#define SMP_TIMEWAIT_SPIN_COUNT                200
>> +#endif
>> +
>> +#ifndef smp_cond_load_relaxed_timewait
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
>> +                                       time_check_expr)                \
>> +({                                                                     \
>> +       typeof(ptr) __PTR = (ptr);                                      \
>> +       __unqual_scalar_typeof(*ptr) VAL;                               \
>> +       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_COUNT;                  \
>> +                                                                       \
>> +       for (;;) {                                                      \
>> +               VAL = READ_ONCE(*__PTR);                                \
>> +               if (cond_expr)                                          \
>> +                       break;                                          \
>> +               cpu_relax();                                            \
>> +               if (++__n < __spin)                                     \
>> +                       continue;                                       \
>> +               if ((time_check_expr))                                  \
>> +                       break;                                          \
>> +               __n = 0;                                                \
>> +       }                                                               \
>> +       (typeof(*ptr))VAL;                                              \
>> +})
>> +#endif
>
> This looks fine, at least as it would be used by poll_idle(). The only
> reason for not folding time_check_expr into cond_expr is the poll_idle()
> requirement to avoid calling time_check_expr too often.

Yeah. Exactly.

>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index f5801b0ba9e9..c9934ab68da2 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -219,6 +219,43 @@ do {                                                                       \
>>         (typeof(*ptr))VAL;                                              \
>>  })
>>
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +#ifndef SMP_TIMEWAIT_SPIN_COUNT
>> +#define SMP_TIMEWAIT_SPIN_COUNT                200
>> +#endif
>> +
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
>> +                                         time_check_expr)              \
>> +({                                                                     \
>> +       typeof(ptr) __PTR = (ptr);                                      \
>> +       __unqual_scalar_typeof(*ptr) VAL;                               \
>> +       u32 __n = 0, __spin = 0;                                        \
>> +       bool __wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);     \
>> +       bool __wfe = arch_timer_evtstrm_available();                    \
>> +       bool __wait = false;                                            \
>> +                                                                       \
>> +       if (__wfet || __wfe)                                            \
>> +               __wait = true;                                          \
>> +       else                                                            \
>> +               __spin = SMP_TIMEWAIT_SPIN_COUNT;                       \
>> +                                                                       \
>> +       for (;;) {                                                      \
>> +               VAL = READ_ONCE(*__PTR);                                \
>> +               if (cond_expr)                                          \
>> +                       break;                                          \
>> +               cpu_relax();                                            \
>> +               if (++__n < __spin)                                     \
>> +                       continue;                                       \
>> +               if ((time_check_expr))                                  \
>> +                       break;                                          \
>> +               if (__wait)                                             \
>> +                       __cmpwait_relaxed(__PTR, VAL);                  \
>> +               __n = 0;                                                \
>> +       }                                                               \
>> +       (typeof(*ptr))VAL;                                              \
>> +})
>
> For arm64, I wouldn't bother with the spin count. Since cpu_relax()
> doesn't do anything, I doubt it makes any difference, especially as we
> are likely to use WFE anyway. If we do add one, I'd like it backed by
> some numbers to show it makes a difference in practice.

Okay. That makes sense.

> The question is whether 100us granularity is good enough for poll_idle()
> (I came to the conclusion it's fine for rqspinlock, given their 1ms
> deadlock check).
>
>>  #include <asm-generic/barrier.h>
>>
>> __cmpwait_relaxed() will need adjustment to set a deadline for WFET.
>
> Yeah, __cmpwait_relaxed() doesn't use WFET as it doesn't need a timeout
> (it just happens to have one with the event stream).
>
> We could extend this or create a new one that uses WFET and takes an
> argument. If extending this one, for example a timeout argument of 0
> means WFE, non-zero means WFET cycles. This adds a couple of more
> instructions.

Though then we would need an ALTERNATIVE for WFET to fallback to WFE where
not available. This is a minor point, but how about just always using
WFE or WFET appropriately instead of choosing between the two based on
etime.

  static inline void __cmpwait_case_##sz(volatile void *ptr,              \
                                  unsigned long val,                      \
                                  unsigned long etime)                    \
                                                                          \
          unsigned long tmp;                                              \
                                                                          \
          const unsigned long ecycles = xloops_to_cycles(nsecs_to_xloops(etime)); \
          asm volatile(                                                   \
          "       sevl\ n"                                                \
          "       wfe\ n"                                                 \
          "       ldxr" #sfx "\ t%" #w "[tmp], %[v]\n"                    \
          "       eor     %" #w "[tmp], %" #w "[tmp], %" #w "[val]\ n"    \
          "       cbnz    %" #w "[tmp], 1f\ n"                            \
          ALTERNATIVE("wfe\ n",                                           \
                  "msr s0_3_c1_c0_0, %[ecycles]\ n",                      \
                  ARM64_HAS_WFXT)                                         \
          "1:"                                                            \
          : [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)                   \
          : [val] "r" (val), [ecycles] "r" (ecycles));                    \
  }

This would cause us to compute the end time unnecessarily for WFE but,
given that nothing will use the output of that computation, wouldn't
WFE be able to execute before the result of that computation is available?
(Though I guess WFE is somewhat special, so the usual rules might not
apply.)

> What I had in mind of time_expr was a ktime_t would be something like:
>
> 	for (;;) {
> 		VAL = READ_ONCE(*__PTR);
> 		if (cond_expr)
> 			break;
>
> 		cycles = some_func_of(time_expr);	// see __udelay()
> 		if (cycles <= 0)
> 			break;
>
> 		if (__wfet) {
> 			__cmpwait_relaxed(__PTR, VAL, get_cycles() + cycles);
> 		} else if (__wfe && cycles >= timer_evt_period) {
> 			__cmpwait_relaxed(__PTR, VAL, 0);
> 		} else {
> 			cpu_relax();
> 		}
> 	}
>
> Now, if we don't care about the time check granularity (for now) and
> time_check_expr is a bool (this seems to work better for rqspinlock), I
> think we could do something like:
>
> 	for (;;) {
> 		VAL = READ_ONCE(*__PTR);
> 		if (cond_expr)
> 			break;
> 		if (time_check_expr)
> 			break;
>
> 		if (__wfe) {
> 			__cmpwait_relaxed(__PTR, VAL, 0);
> 		} else if (__wfet) {
> 			__cmpwait_relaxed(__PTR, VAL, get_cycles() + timer_evt_period);
> 		} else {
> 			cpu_relax();
> 		}
> 	}

Yeah. This is simpler.

> We go with WFE first in this case to avoid get_cycles() unnecessarily.

Agreed.

> I'd suggest we add the WFET support in __cmpwait_relaxed() (or a
> different function) as a separate patch, doesn't even need to be part of
> this series. WFE is good enough to get things moving. WFET will only

Agreed.

> make a difference if (1) we disable the event stream or (2) we need
> better accuracy of the timeout.
>
>> AFAICT the rqspinlock code should be able to work by specifying something
>> like:
>>   ((ktime_get_mono_fast_ns() > tval)) || (deadlock_check(&lock_context)))
>> as the time_check_expr.
>
> Why not the whole RES_CHECK_TIMEOUT(...) as in rqspinlock.c? It does the
> deadlock check only after a timeout over a millisecond. Just follow the
> res_atomic_cond_read_acquire() calls but replace '||' with a comma.

Yeah, for this series that's exactly what I was looking to do.

For later I think the rqspinlock code can be simplified so there
are fewer layers of checking.

>> I think they also want to rate limit how often deadlock_check() is
>> called, so they can redefine SMP_TIMEWAIT_SPIN_COUNT to some large
>> value for arm64.
>
> Everyone would want a different rate of checking other stuff, so I think
> this needs to go in their time_check_expr.

Yeah that makes a lot of sense. Trying to address all of that in this
interface just makes that more complicated.

Thanks for all the comments!

--
ankur

