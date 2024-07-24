Return-Path: <linux-arch+bounces-5618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278793B93A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D628638E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D613C823;
	Wed, 24 Jul 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1Q1isxx"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DB13C9DE;
	Wed, 24 Jul 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861115; cv=fail; b=oafsD3oxs33VlfVmeegClUlTZNWEdNxO9GcT0lRYK9GOZaZ3PRmvOigNkAK+V0j3PvpbsyCoq8AT1hBCsaKUYIRDQ2tIN6HWHaCKRkY/xDufBFuM2Wp0ZBiczseEd5Cp7lqTer6cR6snNV2us06v/MlYwzXh7CmUCc3aHnkPs2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861115; c=relaxed/simple;
	bh=EOekb17m6JVE6/0BRhtXbCeopyHQGXIjGI89s+LAbxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0cXKezSbXT8WFs+p2HdvoBNcuh/kxnT8Lv25dVI15JKPonarZ0Alw8t/pfInQ7ZJg2Z3sUViigWJnJ9BjIq41ezVmahniEOLE1ZONVLjlJQGOeByLoBBuEBwOkWvDfOyNScZ+x68JvpZiIGpFK+e8cqII80tCVAsU0j0iVkLB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1Q1isxx; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuZSOt13W8n0cwBMxkPrpXWwTZ5k6VwALwN+Iw0kljrIaIEHHRPpq32cdJWA0z2aXemgbGEK9vHdCsxbYehmXzxz2E1y7WJc1wWohrFlXUXdRQQh2fxlDY2j1QJvaOsC/toPtwbcdDPg69jsshVS38fr5sEytY9AHVa97kU0/kZYQMgCM5WsADGgXXWxCIunudfDPrjE/dD3E/D8wuAAc/Lru0X2H7TJ7LKybFRbsBi8kuOJx3uNdgYtPmX5YHfZ2QgnR9qKktcNa08D0EHdKPhr25mbcO8JE9rrBFICfl1D9gcR5tZrfU9Qjgpcwlu1v7mRMqO9NDnEprUNxTbBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5LWaaL8xRcIR9T8oVAQwKhrOeH+BNTu2xi/MmdC9tM=;
 b=wszO5Bh9YoOH73JcqhqGuc54V1CPSYXr3s6p9y+8lldR1Q/pC3SNrm/GZFyTkv6NjujJsMMRTujmzWM1XN5qs4b+tAXBy8wVMp3zZJxcvs1NwJg0lHvYRYT26F3TY3vvQjKLQcTfN8S1OS/22xsmnJ10n1WDV3m1zKwxpDRwhYmz6tZbvzI/t9iBZoy53a1699lueRp994jUeB9EPZmH9eDlj1PdrLtTrhj2u1HIMprtNg2KhxLJ4u+jLvc6vxbYaK5OXoWYkSWQEq9uswdeuJLgo0A8poT/eoLQk3rMRDoGPEaLhk7moh6g5H4uiRxkyQpYy18Sz5wrtkIdtozX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5LWaaL8xRcIR9T8oVAQwKhrOeH+BNTu2xi/MmdC9tM=;
 b=g1Q1isxx6SDkHYiMXDNI/XecW7fWW/GLbOQWqV6DmU9bN1fAiW+u6/Tz1vmlnOPxYaB39ZuOHsJDaRxv2pvRfbRBpQI8tALlJYF10WnwbxaU0afoN2x3PWTIP0YzcUn/u1VfPGa+t4Dx5ERweRwYu26Wkcgx01Fo9Dnvc5WqVINgRq7GzYA/8FLvsYYqREGMbhw2lJgiAl2KQc9iq/ib4fmdssO2q36M/PTBVUA97XPZuHBxq2yGtJJ0jPj2zGZw4QK0LAKwYgXyUcnLT3ehk9e0x5ZRAfPmr4BvabcW08sIBa++tp3xw7ak+Yjw3nzbe0JYFckrMIK+yYPrIULqEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 22:45:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 22:45:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso <dave@stgolabs.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, nvdimm@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 00/25] mm: introduce numa_memblks
Date: Wed, 24 Jul 2024 18:44:55 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <1D474894-F8AC-427B-8F90-5A6808E77CC5@nvidia.com>
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_33325EA0-2D6B-47F3-B9A2-617690C62594_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de8bd77-3401-4cf2-defb-08dcac32404b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/hUWJ+tzqy0GTN7IZmJ0zLGKjaYbbEEuB2eWCSS8LgO4gmrtw/+x04PET/V?=
 =?us-ascii?Q?1Sol2EeZAMX+0cIxBZ+uRG+CfnL8InUxvqGvI3boY4HayTUemD6Tq0vY/KZ5?=
 =?us-ascii?Q?W0rrUMBKIPmqISvqPmQsTjXZFCHr/H73e5bVSiSi6iZpKuXgjUXGa123saJ+?=
 =?us-ascii?Q?UvjImvEVmTH1pN3MdCs7PfYci4FlxHtc0lF+E1mWo037d57GtcWkuOB3DpI8?=
 =?us-ascii?Q?nuTCHUH9sEX6g5qrRjPtkSfuYZmCont0l+WSXjhBeYKjmOnJ/6zA4ki2Tfgg?=
 =?us-ascii?Q?1E2HjGm3MwjJaHQjb3oxlJe9HRSL13+MO26uzK34w5FEbesLNy0EYjKAi/cv?=
 =?us-ascii?Q?+Jdo4YDEiGVOhp3lkbkXy/fC8DOthYIaxvzlyUh67aFTTd3mSocdYhCcuYjz?=
 =?us-ascii?Q?zGlX65hYG76tvpD10F8Hygmuhpemp50dO6UEARi7twvSo5gjIpoOv40658d1?=
 =?us-ascii?Q?ZDtpM/Y1bNZTzeyEubXLfkqqpONOnB7VNcjZ1elMJBnhVQjbGPoohrj9/CCu?=
 =?us-ascii?Q?EsSXYQ0l42IvsBNlElyYyrHAUJGBnBKosPujE2iwd8ltjjgmDFpIEBjZAIWi?=
 =?us-ascii?Q?QV9J1jp6YX9x5R/iXQ431DMu8GMwI065ya6bR1o+xWG71CHv7ka/MKELPCx9?=
 =?us-ascii?Q?hBDTEVDeHJM0bZyT3HqQ5iAsEqCZO8trT/1wed8EHhKay13I4B/ioDAsgGt8?=
 =?us-ascii?Q?XelucyMVLRAhyXwvj9jbum9BQYEQkqf2zy0m14zUMNAKOuhonspZgDNaDr6V?=
 =?us-ascii?Q?YA/gPZ62xp2w4vcniWy9SfL7R+qZ+4Dvdrdb6FLE2w1vb7sfrgtjjO1LRhBW?=
 =?us-ascii?Q?6svNqI/bJSCQE1LR1uN7+0joi/RD88x57StuAoeUJgq9zRKg9gHuxmRVRzhP?=
 =?us-ascii?Q?6VjuhJfsEE88FClWAnNcdicIgK/lskSumEauMebZC9QqZdU6isdDg8HjPCvV?=
 =?us-ascii?Q?FW2aV7D2unne2LJyaq+qtfy7X287utfdJ1hanA5eurhBuXZhoKv1rqZ4+Ya0?=
 =?us-ascii?Q?FP5JAgN3QIyZ5PVukDF9w+dbNlH0pKiNDC/34RUc/VMw2nO8VGw328TsPxAZ?=
 =?us-ascii?Q?QfS2Bw7efahy74MEGe20QOWPLQJVcVQ0e0L7naPTzubV4HPxNHSM9EyFRuFf?=
 =?us-ascii?Q?zyhvlPyS0A7Qc6HffwKA+00ClrVK1szCD+/RaZjbTpG6JMCmOjo9CsEvTLrg?=
 =?us-ascii?Q?tVOU9CQl4bGIRu/+erLMLzPTeG6x3+E6KzaJu5oiNS7hatVyVh/3tOqerLWN?=
 =?us-ascii?Q?X/lrffP18Kezvcz2IRe9Zuh46P+i1/MXLypI0mb8IN2vbvX2N8KdGhyjJbuY?=
 =?us-ascii?Q?X/mLtBpQEJqexhXxXHZ0/kc8wlIOn+8+8DbfSgXXV1v5SdG6fUSVxBVBeTFf?=
 =?us-ascii?Q?P2iCADg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nw76cI6rCj3UBFIS2F8RP231JThpCXPQuCtdBsdO9vM3EV95TKtJaoF0/TnE?=
 =?us-ascii?Q?17I0I3MxJtD5gc7QvahXk1By4+9TsunhYfFsWzdeNjIPZmuP9ADnm2MQi8vQ?=
 =?us-ascii?Q?Gol61zNNK3bVMpFRxRcGv4K3N4YOsG9qvpHv5umfoDKADEZG3+EFS/+g7GRo?=
 =?us-ascii?Q?Fsfu1lfDlT0LLrb8ien9zPOyaxL+ZFJgof7hmZG2GH98BobiIzdQc9XMS1oI?=
 =?us-ascii?Q?Dgxohrpt2Nf0fz4ac6MwXZxAD8rw0J7Tn2ji6Xf2sOM9P0R5lQncQaFMNh7t?=
 =?us-ascii?Q?zH3sFvypqgT3kwK/f2A+NcwFlEgXN8aTtE5t7+6XWaBC7Pr+97m3TYt1HZxp?=
 =?us-ascii?Q?UjEmbDcoVV1tkI90tleJYr9FWXFIb81uElUgjkPblXGBrKOJ0BpgNas92HVk?=
 =?us-ascii?Q?EP+U1vp4bdowWjRCagyxpu8FwxzMl9Zf3Umw515aDcH/VWI1RtSKVqLXt/8L?=
 =?us-ascii?Q?dH5B/dQahatcfWlwhGGo+q3OBswOKZWPmCKGTCo4t9ncRozIYlRod9SgI8Rp?=
 =?us-ascii?Q?9Udc/Gvv/45cktDulZCGSWqh6Gp3uSMsWz5XKGapblbmVGouiDYsB8ae/4hb?=
 =?us-ascii?Q?XI+XqSwcnfcg9tcoYN15GI4MsOA+/emH3qtgIuSQHZDMSneiBRI0CiC+jwqy?=
 =?us-ascii?Q?N8ZMuWGfJ6+kHEOrIXiBjNFEASfA5cDN1k1MLslyA1554dpr5rVEH+7uuvY8?=
 =?us-ascii?Q?2RHWnUgEqokS0HH6bpZ2MY6Z+CijxHhVGGZvzZ3hD7A2K5YJI15RY7iBGTzq?=
 =?us-ascii?Q?1Csv0VqX3rWQ7J3qUHJn3X/HPJwRreG9EjDZeE2RgDEp5Iav/l4Qj1VNrX5E?=
 =?us-ascii?Q?NbKWpZ8NCJFM4HjgmKCTj/5dV7HkkgmYk5tSoZU0Ix6DZL6e3w8BJgPNBXK0?=
 =?us-ascii?Q?dXqcHgmYXeQla87V8pgopFEgNK9GlOUIekz3IgbrO3nDLbylzVpTuHCpnywU?=
 =?us-ascii?Q?+/50Z0z9rhIlhS4mnBIuUnRoT6jw3bQ16+gIzZMEGXGEqMnhTFLSw/BgJL3+?=
 =?us-ascii?Q?tbhpv5fTHjGMsLxBYlihSoAlwBPflBs/vaddiuRhp+rV8OEkTyqDWsUkKrjQ?=
 =?us-ascii?Q?gF9XFGqhdLUXxUs/WojD+9wEMaw99XxpRSv0KQrS0tqLf/EFRO/Q2KJ7LFZi?=
 =?us-ascii?Q?Dp4/fivzlrIfrLKrwIi2b5qS+b2dIGS4ivhV36OKQv96D7MqztZBjqNe8eH5?=
 =?us-ascii?Q?DKgdjvnyXRK3D5B5s7EL68CMOH3FYWvhuvpd+zPChsLdj/TG8Oi5G3SMJjr1?=
 =?us-ascii?Q?kFmDPeHeQDU4s7ULhM0S5gjvJfs6sXAuQQin3u21oydbvPHf6Qgfu3bVvsZp?=
 =?us-ascii?Q?AiLHt7hmlWiqVPdajN09OpXi9mUbIl/v8APWbczPReMNYi0tF2STYWuvLDLY?=
 =?us-ascii?Q?+9C7ewQbQodDJZpAmBwC2Mg6kK3c5k6cuTvFN75JOnivwWa8lTNhCrlmQv4L?=
 =?us-ascii?Q?Rb/6Mkprk0+cAV2sJHoFtMT5jiSYO6WiUIUdhv0pbIRgsbBuOhN37i2Zb8U8?=
 =?us-ascii?Q?HwK9Bxw6tcXAU9cH489YpAPMxCpN98ZVLHG2EJIYdo+C9k0dCFr+Dme4nDqr?=
 =?us-ascii?Q?pVny4icyf26OwoDcKkI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de8bd77-3401-4cf2-defb-08dcac32404b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 22:45:00.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j773ymLKNxy/yHVSdRSxj+Rb3e+5E/aK2dP+o4NHbg/o+VeG6QL7MxrZDOx84ud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408

--=_MailMate_33325EA0-2D6B-47F3-B9A2-617690C62594_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_0395DBC4-D8CF-45A3-B7B7-FBAC5BC9D8D2_="


--=_MailMate_0395DBC4-D8CF-45A3-B7B7-FBAC5BC9D8D2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Jul 2024, at 2:41, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> Following the discussion about handling of CXL fixed memory windows on
> arm64 [1] I decided to bite the bullet and move numa_memblks from x86 t=
o
> the generic code so they will be available on arm64/riscv and maybe on
> loongarch sometime later.
>
> While it could be possible to use memblock to describe CXL memory windo=
ws,
> it currently lacks notion of unpopulated memory ranges and numa_memblks=

> does implement this.
>
> Another reason to make numa_memblks generic is that both arch_numa (arm=
64
> and riscv) and loongarch use trimmed copy of x86 code although there is=
 no
> fundamental reason why the same code cannot be used on all these platfo=
rms.
> Having numa_memblks in mm/ will make it's interaction with ACPI and FDT=

> more consistent and I believe will reduce maintenance burden.
>
> And with generic numa_memblks it is (almost) straightforward to enable =
NUMA
> emulation on arm64 and riscv.
>
> The first 9 commits in this series are cleanups that are not strictly
> related to numa_memblks.
> Commits 10-16 slightly reorder code in x86 to allow extracting numa_mem=
blks
> and NUMA emulation to the generic code.
> Commits 17-19 actually move the code from arch/x86/ to mm/ and commits =
20-22
> does some aftermath cleanups.
> Commit 23 switches arch_numa to numa_memblks.
> Commit 24 enables usage of phys_to_target_node() and
> memory_add_physaddr_to_nid() with numa_memblks.
> Commit 25 moves the description for numa=3Dfake from x86 to admin-guide=

>
> [1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Cameron=
@huawei.com/
>
> v1: https://lore.kernel.org/all/20240716111346.3676969-1-rppt@kernel.or=
g
> * add cleanup for arch_alloc_nodedata and HAVE_ARCH_NODEDATA_EXTENSION
> * add patch that moves description of numa=3Dfake kernel parameter from=

>   x86 to admin-guide
> * reduce rounding up of node_data allocations from PAGE_SIZE to
>   SMP_CACHE_BYTES
> * restore single allocation attempt of numa_distance
> * fix several comments
> * added review tags
>
> Mike Rapoport (Microsoft) (25):
>   mm: move kernel/numa.c to mm/
>   MIPS: sgi-ip27: make NODE_DATA() the same as on all other architectur=
es
>   MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
>   MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
>   MIPS: loongson64: rename __node_data to node_data
>   MIPS: loongson64: drop HAVE_ARCH_NODEDATA_EXTENSION
>   mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
>   arch, mm: move definition of node_data to generic code
>   arch, mm: pull out allocation of NODE_DATA to generic code
>   x86/numa: simplify numa_distance allocation
>   x86/numa: use get_pfn_range_for_nid to verify that node spans memory
>   x86/numa: move FAKE_NODE_* defines to numa_emu
>   x86/numa_emu: simplify allocation of phys_dist
>   x86/numa_emu: split __apicid_to_node update to a helper function
>   x86/numa_emu: use a helper function to get MAX_DMA32_PFN
>   x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
>   mm: introduce numa_memblks
>   mm: move numa_distance and related code from x86 to numa_memblks
>   mm: introduce numa_emulation
>   mm: numa_memblks: introduce numa_memblks_init
>   mm: numa_memblks: make several functions and variables static
>   mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing
>     meminfo
>   arch_numa: switch over to numa_memblks
>   mm: make range-to-target_node lookup facility a part of numa_memblks
>   docs: move numa=3Dfake description to kernel-parameters.txt
>
Hi,

I have tested this series on both x86_64 and arm64. It works fine on x86_=
64.
All numa=3Dfake=3D options work as they did before the series.

But I am not able to boot the kernel (no printout at all) on arm64 VM
(Mac mini M1 VMWare). By git bisecting, arch_numa: switch over to numa_me=
mblks
is the first patch causing the boot failure. I see the warning:

WARNING: modpost: vmlinux: section mismatch in reference: numa_add_cpu+0x=
1c (section: .text) -> early_cpu_to_node (section: .init.text)

I am not sure if it is red herring or not, since changing early_cpu_to_no=
de
to cpu_to_node in numa_add_cpu() from mm/numa_emulation.c did get rid of =
the
warning, but the system still failed to boot.

Please note that you need binutils 2.40 to build the arm64 kernel, since =
there
is a bug(https://sourceware.org/bugzilla/show_bug.cgi?id=3D31924) in 2.42=
 preventing
arm64 kernel from booting as well.

My config is attached.

--
Best Regards,
Yan, Zi

--=_MailMate_0395DBC4-D8CF-45A3-B7B7-FBAC5BC9D8D2_=
Content-Disposition: attachment; filename=arm64_config
Content-ID: <C4010906-6A14-4BAC-9FC6-824D0A1B2088@nvidia.com>
Content-Type: text/plain; name=arm64_config
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm64 6.10.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT=3D"gcc (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=3Dy
CONFIG_GCC_VERSION=3D120200
CONFIG_CLANG_VERSION=3D0
CONFIG_AS_IS_GNU=3Dy
CONFIG_AS_VERSION=3D24000
CONFIG_LD_IS_BFD=3Dy
CONFIG_LD_VERSION=3D24000
CONFIG_LLD_VERSION=3D0
CONFIG_CC_CAN_LINK=3Dy
CONFIG_CC_CAN_LINK_STATIC=3Dy
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=3Dy
CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND=3Dy
CONFIG_CC_HAS_ASM_INLINE=3Dy
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
CONFIG_PAHOLE_VERSION=3D124
CONFIG_IRQ_WORK=3Dy
CONFIG_BUILDTIME_TABLE_SORT=3Dy
CONFIG_THREAD_INFO_IN_TASK=3Dy

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=3D32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=3D""
CONFIG_DEFAULT_INIT=3D""
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_USELIB is not set
CONFIG_AUDIT=3Dy
CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
CONFIG_AUDITSYSCALL=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_GENERIC_IRQ_SHOW_LEVEL=3Dy
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
CONFIG_GENERIC_IRQ_MIGRATION=3Dy
CONFIG_HARDIRQS_SW_RESEND=3Dy
CONFIG_GENERIC_IRQ_CHIP=3Dy
CONFIG_IRQ_DOMAIN=3Dy
CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=3Dy
CONFIG_GENERIC_IRQ_IPI=3Dy
CONFIG_GENERIC_MSI_IRQ=3Dy
CONFIG_IRQ_MSI_IOMMU=3Dy
CONFIG_IRQ_FORCED_THREADING=3Dy
CONFIG_SPARSE_IRQ=3Dy
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_ARCH_HAS_TICK_BROADCAST=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
CONFIG_CONTEXT_TRACKING=3Dy
CONFIG_CONTEXT_TRACKING_IDLE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
CONFIG_CONTEXT_TRACKING_USER=3Dy
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=3Dy
# end of Timers subsystem

CONFIG_BPF=3Dy
CONFIG_HAVE_EBPF_JIT=3Dy
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=3Dy
CONFIG_BPF_JIT=3Dy
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=3Dy
CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy
# CONFIG_BPF_PRELOAD is not set
CONFIG_BPF_LSM=3Dy
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=3Dy
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=3Dy
CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_SCHED_HW_PRESSURE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_PSI=3Dy
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU_GENERIC=3Dy
CONFIG_NEED_TASKS_RCU=3Dy
CONFIG_TASKS_RUDE_RCU=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_NOCB_CPU=3Dy
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=3Dm
# CONFIG_IKCONFIG_PROC is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
# CONFIG_PRINTK_INDEX is not set
CONFIG_GENERIC_SCHED_CLOCK=3Dy

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
CONFIG_CC_HAS_INT128=3Dy
CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=3Dy
CONFIG_CC_NO_ARRAY_BOUNDS=3Dy
CONFIG_GCC_NO_STRINGOP_OVERFLOW=3Dy
CONFIG_CC_NO_STRINGOP_OVERFLOW=3Dy
CONFIG_ARCH_SUPPORTS_INT128=3Dy
CONFIG_NUMA_BALANCING=3Dy
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
CONFIG_SLAB_OBJ_EXT=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_PAGE_COUNTER=3Dy
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=3Dy
CONFIG_MEMCG_KMEM=3Dy
CONFIG_BLK_CGROUP=3Dy
CONFIG_CGROUP_WRITEBACK=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=3Dy
CONFIG_CGROUP_PIDS=3Dy
CONFIG_CGROUP_RDMA=3Dy
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_HUGETLB=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_CGROUP_PERF=3Dy
CONFIG_CGROUP_BPF=3Dy
CONFIG_CGROUP_MISC=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_TIME_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_USER_NS=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
CONFIG_CHECKPOINT_RESTORE=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_RD_LZ4=3Dy
CONFIG_RD_ZSTD=3Dy
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=3Dy
CONFIG_LD_ORPHAN_WARN_LEVEL=3D"warn"
CONFIG_SYSCTL=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
CONFIG_EXPERT=3Dy
CONFIG_UID16=3Dy
CONFIG_MULTIUSER=3Dy
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=3Dy
CONFIG_POSIX_TIMERS=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
# CONFIG_BASE_SMALL is not set
CONFIG_FUTEX=3Dy
CONFIG_FUTEX_PI=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_IO_URING=3Dy
CONFIG_ADVISE_SYSCALLS=3Dy
CONFIG_MEMBARRIER=3Dy
CONFIG_KCMP=3Dy
CONFIG_RSEQ=3Dy
# CONFIG_DEBUG_RSEQ is not set
CONFIG_CACHESTAT_SYSCALL=3Dy
# CONFIG_PC104 is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_SELFTEST is not set
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_GUEST_PERF_EVENTS=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy

#
# Kexec and crash features
#
CONFIG_CRASH_RESERVE=3Dy
CONFIG_VMCORE_INFO=3Dy
CONFIG_KEXEC_CORE=3Dy
CONFIG_KEXEC=3Dy
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=3Dy
# end of Kexec and crash features
# end of General setup

CONFIG_ARM64=3Dy
CONFIG_GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS=3Dy
CONFIG_64BIT=3Dy
CONFIG_MMU=3Dy
CONFIG_ARM64_CONT_PTE_SHIFT=3D4
CONFIG_ARM64_CONT_PMD_SHIFT=3D4
CONFIG_ARCH_MMAP_RND_BITS_MIN=3D18
CONFIG_ARCH_MMAP_RND_BITS_MAX=3D33
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D11
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CSUM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_SMP=3Dy
CONFIG_KERNEL_MODE_NEON=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_PGTABLE_LEVELS=3D4
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_BUILTIN_RETURN_ADDRESS_STRIPS_PAC=3Dy

#
# Platform selection
#
# CONFIG_ARCH_ACTIONS is not set
# CONFIG_ARCH_AIROHA is not set
CONFIG_ARCH_SUNXI=3Dy
# CONFIG_ARCH_ALPINE is not set
# CONFIG_ARCH_APPLE is not set
CONFIG_ARCH_BCM=3Dy
CONFIG_ARCH_BCM2835=3Dy
# CONFIG_ARCH_BCM_IPROC is not set
# CONFIG_ARCH_BCMBCA is not set
# CONFIG_ARCH_BRCMSTB is not set
# CONFIG_ARCH_BERLIN is not set
# CONFIG_ARCH_BITMAIN is not set
# CONFIG_ARCH_EXYNOS is not set
# CONFIG_ARCH_SPARX5 is not set
CONFIG_ARCH_K3=3Dy
# CONFIG_ARCH_LG1K is not set
CONFIG_ARCH_HISI=3Dy
# CONFIG_ARCH_KEEMBAY is not set
# CONFIG_ARCH_MEDIATEK is not set
CONFIG_ARCH_MESON=3Dy
CONFIG_ARCH_MVEBU=3Dy
CONFIG_ARCH_NXP=3Dy
CONFIG_ARCH_LAYERSCAPE=3Dy
CONFIG_ARCH_MXC=3Dy
# CONFIG_ARCH_S32 is not set
# CONFIG_ARCH_MA35 is not set
# CONFIG_ARCH_NPCM is not set
# CONFIG_ARCH_PENSANDO is not set
CONFIG_ARCH_QCOM=3Dy
# CONFIG_ARCH_REALTEK is not set
CONFIG_ARCH_RENESAS=3Dy
CONFIG_ARCH_ROCKCHIP=3Dy
CONFIG_ARCH_SEATTLE=3Dy
# CONFIG_ARCH_INTEL_SOCFPGA is not set
# CONFIG_ARCH_STM32 is not set
CONFIG_ARCH_SYNQUACER=3Dy
CONFIG_ARCH_TEGRA=3Dy
# CONFIG_ARCH_SPRD is not set
CONFIG_ARCH_THUNDER=3Dy
CONFIG_ARCH_THUNDER2=3Dy
# CONFIG_ARCH_UNIPHIER is not set
CONFIG_ARCH_VEXPRESS=3Dy
# CONFIG_ARCH_VISCONTI is not set
CONFIG_ARCH_XGENE=3Dy
CONFIG_ARCH_ZYNQMP=3Dy
# end of Platform selection

#
# Kernel Features
#

#
# ARM errata workarounds via the alternatives framework
#
CONFIG_AMPERE_ERRATUM_AC03_CPU_38=3Dy
CONFIG_ARM64_WORKAROUND_CLEAN_CACHE=3Dy
CONFIG_ARM64_ERRATUM_826319=3Dy
CONFIG_ARM64_ERRATUM_827319=3Dy
CONFIG_ARM64_ERRATUM_824069=3Dy
CONFIG_ARM64_ERRATUM_819472=3Dy
CONFIG_ARM64_ERRATUM_832075=3Dy
CONFIG_ARM64_ERRATUM_834220=3Dy
CONFIG_ARM64_ERRATUM_1742098=3Dy
CONFIG_ARM64_ERRATUM_845719=3Dy
CONFIG_ARM64_ERRATUM_843419=3Dy
CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419=3Dy
CONFIG_ARM64_ERRATUM_1024718=3Dy
CONFIG_ARM64_ERRATUM_1418040=3Dy
CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT=3Dy
CONFIG_ARM64_ERRATUM_1165522=3Dy
CONFIG_ARM64_ERRATUM_1319367=3Dy
CONFIG_ARM64_ERRATUM_1530923=3Dy
CONFIG_ARM64_WORKAROUND_REPEAT_TLBI=3Dy
CONFIG_ARM64_ERRATUM_2441007=3Dy
CONFIG_ARM64_ERRATUM_1286807=3Dy
CONFIG_ARM64_ERRATUM_1463225=3Dy
CONFIG_ARM64_ERRATUM_1542419=3Dy
CONFIG_ARM64_ERRATUM_1508412=3Dy
CONFIG_ARM64_ERRATUM_2051678=3Dy
CONFIG_ARM64_ERRATUM_2077057=3Dy
CONFIG_ARM64_ERRATUM_2658417=3Dy
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE=3Dy
CONFIG_ARM64_ERRATUM_2054223=3Dy
CONFIG_ARM64_ERRATUM_2067961=3Dy
CONFIG_ARM64_ERRATUM_2441009=3Dy
CONFIG_ARM64_ERRATUM_2457168=3Dy
CONFIG_ARM64_ERRATUM_2645198=3Dy
CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD=3Dy
CONFIG_ARM64_ERRATUM_2966298=3Dy
CONFIG_ARM64_ERRATUM_3117295=3Dy
CONFIG_ARM64_WORKAROUND_SPECULATIVE_SSBS=3Dy
CONFIG_ARM64_ERRATUM_3194386=3Dy
CONFIG_ARM64_ERRATUM_3312417=3Dy
CONFIG_CAVIUM_ERRATUM_22375=3Dy
CONFIG_CAVIUM_ERRATUM_23144=3Dy
CONFIG_CAVIUM_ERRATUM_23154=3Dy
CONFIG_CAVIUM_ERRATUM_27456=3Dy
CONFIG_CAVIUM_ERRATUM_30115=3Dy
CONFIG_CAVIUM_TX2_ERRATUM_219=3Dy
CONFIG_FUJITSU_ERRATUM_010001=3Dy
CONFIG_HISILICON_ERRATUM_161600802=3Dy
CONFIG_QCOM_FALKOR_ERRATUM_1003=3Dy
CONFIG_QCOM_FALKOR_ERRATUM_1009=3Dy
CONFIG_QCOM_QDF2400_ERRATUM_0065=3Dy
CONFIG_QCOM_FALKOR_ERRATUM_E1041=3Dy
CONFIG_NVIDIA_CARMEL_CNP_ERRATUM=3Dy
CONFIG_ROCKCHIP_ERRATUM_3588001=3Dy
CONFIG_SOCIONEXT_SYNQUACER_PREITS=3Dy
# end of ARM errata workarounds via the alternatives framework

CONFIG_ARM64_4K_PAGES=3Dy
# CONFIG_ARM64_16K_PAGES is not set
# CONFIG_ARM64_64K_PAGES is not set
# CONFIG_ARM64_VA_BITS_39 is not set
CONFIG_ARM64_VA_BITS_48=3Dy
# CONFIG_ARM64_VA_BITS_52 is not set
CONFIG_ARM64_VA_BITS=3D48
CONFIG_ARM64_PA_BITS_48=3Dy
CONFIG_ARM64_PA_BITS=3D48
# CONFIG_CPU_BIG_ENDIAN is not set
CONFIG_CPU_LITTLE_ENDIAN=3Dy
CONFIG_SCHED_MC=3Dy
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=3Dy
CONFIG_NR_CPUS=3D256
CONFIG_HOTPLUG_CPU=3Dy
CONFIG_NUMA=3Dy
CONFIG_NODES_SHIFT=3D4
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
CONFIG_SCHED_HRTICK=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_HW_PERF_EVENTS=3Dy
CONFIG_CC_HAVE_SHADOW_CALL_STACK=3Dy
CONFIG_PARAVIRT=3Dy
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_ARCH_SUPPORTS_KEXEC=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG=3Dy
CONFIG_ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG=3Dy
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=3Dy
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=3Dy
CONFIG_TRANS_TABLE=3Dy
CONFIG_XEN_DOM0=3Dy
CONFIG_XEN=3Dy
CONFIG_ARCH_FORCE_MAX_ORDER=3D10
CONFIG_UNMAP_KERNEL_AT_EL0=3Dy
CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY=3Dy
CONFIG_RODATA_FULL_DEFAULT_ENABLED=3Dy
# CONFIG_ARM64_SW_TTBR0_PAN is not set
CONFIG_ARM64_TAGGED_ADDR_ABI=3Dy
CONFIG_COMPAT=3Dy
CONFIG_KUSER_HELPERS=3Dy
CONFIG_COMPAT_ALIGNMENT_FIXUPS=3Dy
CONFIG_ARMV8_DEPRECATED=3Dy
CONFIG_SWP_EMULATION=3Dy
CONFIG_CP15_BARRIER_EMULATION=3Dy
CONFIG_SETEND_EMULATION=3Dy

#
# ARMv8.1 architectural features
#
CONFIG_ARM64_HW_AFDBM=3Dy
CONFIG_ARM64_PAN=3Dy
CONFIG_AS_HAS_LSE_ATOMICS=3Dy
CONFIG_ARM64_LSE_ATOMICS=3Dy
CONFIG_ARM64_USE_LSE_ATOMICS=3Dy
# end of ARMv8.1 architectural features

#
# ARMv8.2 architectural features
#
CONFIG_AS_HAS_ARMV8_2=3Dy
CONFIG_AS_HAS_SHA3=3Dy
CONFIG_ARM64_PMEM=3Dy
CONFIG_ARM64_RAS_EXTN=3Dy
CONFIG_ARM64_CNP=3Dy
# end of ARMv8.2 architectural features

#
# ARMv8.3 architectural features
#
CONFIG_ARM64_PTR_AUTH=3Dy
CONFIG_ARM64_PTR_AUTH_KERNEL=3Dy
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET=3Dy
CONFIG_CC_HAS_SIGN_RETURN_ADDRESS=3Dy
CONFIG_AS_HAS_ARMV8_3=3Dy
CONFIG_AS_HAS_CFI_NEGATE_RA_STATE=3Dy
CONFIG_AS_HAS_LDAPR=3Dy
# end of ARMv8.3 architectural features

#
# ARMv8.4 architectural features
#
CONFIG_ARM64_AMU_EXTN=3Dy
CONFIG_AS_HAS_ARMV8_4=3Dy
CONFIG_ARM64_TLB_RANGE=3Dy
# end of ARMv8.4 architectural features

#
# ARMv8.5 architectural features
#
CONFIG_AS_HAS_ARMV8_5=3Dy
CONFIG_ARM64_BTI=3Dy
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI=3Dy
CONFIG_ARM64_E0PD=3Dy
CONFIG_ARM64_AS_HAS_MTE=3Dy
CONFIG_ARM64_MTE=3Dy
# end of ARMv8.5 architectural features

#
# ARMv8.7 architectural features
#
CONFIG_ARM64_EPAN=3Dy
# end of ARMv8.7 architectural features

CONFIG_ARM64_SVE=3Dy
CONFIG_ARM64_SME=3Dy
# CONFIG_ARM64_PSEUDO_NMI is not set
CONFIG_RELOCATABLE=3Dy
CONFIG_RANDOMIZE_BASE=3Dy
CONFIG_RANDOMIZE_MODULE_REGION_FULL=3Dy
CONFIG_CC_HAVE_STACKPROTECTOR_SYSREG=3Dy
CONFIG_STACKPROTECTOR_PER_TASK=3Dy
CONFIG_ARM64_CONTPTE=3Dy
# end of Kernel Features

#
# Boot options
#
CONFIG_ARM64_ACPI_PARKING_PROTOCOL=3Dy
CONFIG_CMDLINE=3D""
CONFIG_EFI_STUB=3Dy
CONFIG_EFI=3Dy
CONFIG_DMI=3Dy
# end of Boot options

#
# Power management options
#
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
CONFIG_HIBERNATION_COMP_LZO=3Dy
CONFIG_HIBERNATION_DEF_COMP=3D"lzo"
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=3Dy
CONFIG_PM_DEBUG=3Dy
CONFIG_PM_ADVANCED_DEBUG=3Dy
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=3Dy
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_CLK=3Dy
CONFIG_PM_GENERIC_DOMAINS=3Dy
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
CONFIG_PM_GENERIC_DOMAINS_OF=3Dy
CONFIG_CPU_PM=3Dy
CONFIG_ENERGY_MODEL=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
# end of Power management options

#
# CPU Power Management
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_DT_IDLE_STATES=3Dy
CONFIG_DT_IDLE_GENPD=3Dy

#
# ARM CPU Idle Drivers
#
CONFIG_ARM_PSCI_CPUIDLE=3Dy
CONFIG_ARM_PSCI_CPUIDLE_DOMAIN=3Dy
# end of ARM CPU Idle Drivers
# end of CPU Idle

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_CPUFREQ_DT_PLATDEV=3Dy
# CONFIG_ARM_QCOM_CPUFREQ_HW is not set
# CONFIG_ARM_RASPBERRYPI_CPUFREQ is not set
# CONFIG_ARM_SCMI_CPUFREQ is not set
CONFIG_ARM_TI_CPUFREQ=3Dy
# CONFIG_QORIQ_CPUFREQ is not set
# CONFIG_ACPI_CPPC_CPUFREQ is not set
# end of CPU Frequency scaling
# end of CPU Power Management

CONFIG_ARCH_SUPPORTS_ACPI=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_GENERIC_GSI=3Dy
CONFIG_ACPI_CCA_REQUIRED=3Dy
CONFIG_ACPI_THERMAL_LIB=3Dy
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=3Dy
# CONFIG_ACPI_FPDT is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=3Dy
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR_IDLE=3Dy
CONFIG_ACPI_MCFG=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
CONFIG_ACPI_TABLE_UPGRADE=3Dy
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=3Dy
CONFIG_ACPI_CONTAINER=3Dy
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HED=3Dy
CONFIG_ACPI_BGRT=3Dy
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=3Dy
CONFIG_ACPI_NHLT=3Dy
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=3Dy
CONFIG_ACPI_HMAT=3Dy
CONFIG_HAVE_ACPI_APEI=3Dy
CONFIG_ACPI_APEI=3Dy
CONFIG_ACPI_APEI_GHES=3Dy
CONFIG_ACPI_APEI_PCIEAER=3Dy
CONFIG_ACPI_APEI_SEA=3Dy
CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_IORT=3Dy
CONFIG_ACPI_GTDT=3Dy
CONFIG_ACPI_APMT=3Dy
CONFIG_ACPI_PPTT=3Dy
CONFIG_ACPI_PCC=3Dy
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=3Dy
CONFIG_KVM_COMMON=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
CONFIG_HAVE_KVM_DIRTY_RING=3Dy
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=3Dy
CONFIG_NEED_KVM_DIRTY_RING_WITH_BITMAP=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_HAVE_KVM_MSI=3Dy
CONFIG_HAVE_KVM_READONLY_MEM=3Dy
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
CONFIG_KVM_VFIO=3Dy
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE=3Dy
CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=3Dy
CONFIG_KVM_GENERIC_MMU_NOTIFIER=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dy
# CONFIG_NVHE_EL2_DEBUG is not set
CONFIG_CPU_MITIGATIONS=3Dy

#
# General architecture-dependent options
#
CONFIG_ARCH_HAS_SUBPAGE_FAULTS=3Dy
CONFIG_HOTPLUG_CORE_SYNC=3Dy
CONFIG_HOTPLUG_CORE_SYNC_DEAD=3Dy
CONFIG_KPROBES=3Dy
CONFIG_JUMP_LABEL=3Dy
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=3Dy
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
CONFIG_HAVE_NMI=3Dy
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_GENERIC_IDLE_POLL_SETUP=3Dy
CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
CONFIG_ARCH_HAS_KEEPINITRD=3Dy
CONFIG_ARCH_HAS_SET_MEMORY=3Dy
CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
CONFIG_ARCH_WANTS_NO_INSTR=3Dy
CONFIG_HAVE_ASM_MODVERSIONS=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_RSEQ=3Dy
CONFIG_HAVE_RUST=3Dy
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_PERF_REGS=3Dy
CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
CONFIG_MMU_GATHER_TABLE_FREE=3Dy
CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_HAVE_ARCH_SECCOMP=3Dy
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
CONFIG_SECCOMP=3Dy
CONFIG_SECCOMP_FILTER=3Dy
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=3Dy
CONFIG_HAVE_STACKPROTECTOR=3Dy
CONFIG_STACKPROTECTOR=3Dy
CONFIG_STACKPROTECTOR_STRONG=3Dy
CONFIG_ARCH_SUPPORTS_SHADOW_CALL_STACK=3Dy
# CONFIG_SHADOW_CALL_STACK is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
CONFIG_LTO_NONE=3Dy
CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy
CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_HAVE_MOVE_PUD=3Dy
CONFIG_HAVE_MOVE_PMD=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
CONFIG_ARCH_WANT_PMD_MKWRITE=3Dy
CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_ARCH_WANTS_EXECMEM_LATE=3Dy
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy
CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
CONFIG_ARCH_MMAP_RND_BITS=3D18
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D11
CONFIG_HAVE_PAGE_SIZE_4KB=3Dy
CONFIG_PAGE_SIZE_4KB=3Dy
CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
CONFIG_PAGE_SHIFT=3D12
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=3Dy
CONFIG_CLONE_BACKWARDS=3Dy
CONFIG_OLD_SIGSUSPEND3=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy
CONFIG_COMPAT_32BIT_TIME=3Dy
CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
CONFIG_VMAP_STACK=3Dy
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=3Dy
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
CONFIG_STRICT_KERNEL_RWX=3Dy
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
CONFIG_STRICT_MODULE_RWX=3Dy
CONFIG_HAVE_ARCH_COMPILER_H=3Dy
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_RELR=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC_KEY=3Dy
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
CONFIG_ARCH_HAVE_TRACE_MMIO_ACCESS=3Dy
CONFIG_ARCH_HAS_HW_PTE_YOUNG=3Dy
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=3Dy
CONFIG_FUNCTION_ALIGNMENT_4B=3Dy
CONFIG_FUNCTION_ALIGNMENT_8B=3Dy
CONFIG_FUNCTION_ALIGNMENT=3D8
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=3Dy
CONFIG_MODULE_SIG_FORMAT=3Dy
CONFIG_MODULES=3Dy
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
CONFIG_MODVERSIONS=3Dy
CONFIG_ASM_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=3Dy
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=3Dy
# CONFIG_MODULE_SIG_SHA1 is not set
CONFIG_MODULE_SIG_SHA256=3Dy
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
# CONFIG_MODULE_SIG_SHA3_256 is not set
# CONFIG_MODULE_SIG_SHA3_384 is not set
# CONFIG_MODULE_SIG_SHA3_512 is not set
CONFIG_MODULE_SIG_HASH=3D"sha256"
CONFIG_MODULE_COMPRESS_NONE=3Dy
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
CONFIG_BLK_RQ_ALLOC_TIME=3Dy
CONFIG_BLK_CGROUP_RWSTAT=3Dy
CONFIG_BLK_DEV_BSG_COMMON=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
CONFIG_BLK_DEV_INTEGRITY_T10=3Dm
CONFIG_BLK_DEV_WRITE_MOUNTED=3Dy
CONFIG_BLK_DEV_ZONED=3Dy
CONFIG_BLK_DEV_THROTTLING=3Dy
CONFIG_BLK_WBT=3Dy
CONFIG_BLK_WBT_MQ=3Dy
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_IOCOST=3Dy
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=3Dy
CONFIG_BLK_SED_OPAL=3Dy
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=3Dy
CONFIG_BLK_MQ_VIRTIO=3Dy
CONFIG_BLK_PM=3Dy
CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
CONFIG_BLK_MQ_STACKING=3Dy

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_PADATA=3Dy
CONFIG_ASN1=3Dy
CONFIG_ARCH_INLINE_SPIN_TRYLOCK=3Dy
CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH=3Dy
CONFIG_ARCH_INLINE_SPIN_LOCK=3Dy
CONFIG_ARCH_INLINE_SPIN_LOCK_BH=3Dy
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE=3Dy
CONFIG_ARCH_INLINE_SPIN_UNLOCK=3Dy
CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH=3Dy
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE=3Dy
CONFIG_ARCH_INLINE_READ_LOCK=3Dy
CONFIG_ARCH_INLINE_READ_LOCK_BH=3Dy
CONFIG_ARCH_INLINE_READ_LOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=3Dy
CONFIG_ARCH_INLINE_READ_UNLOCK=3Dy
CONFIG_ARCH_INLINE_READ_UNLOCK_BH=3Dy
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=3Dy
CONFIG_ARCH_INLINE_WRITE_LOCK=3Dy
CONFIG_ARCH_INLINE_WRITE_LOCK_BH=3Dy
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE=3Dy
CONFIG_ARCH_INLINE_WRITE_UNLOCK=3Dy
CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH=3Dy
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ=3Dy
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE=3Dy
CONFIG_INLINE_SPIN_TRYLOCK=3Dy
CONFIG_INLINE_SPIN_TRYLOCK_BH=3Dy
CONFIG_INLINE_SPIN_LOCK=3Dy
CONFIG_INLINE_SPIN_LOCK_BH=3Dy
CONFIG_INLINE_SPIN_LOCK_IRQ=3Dy
CONFIG_INLINE_SPIN_LOCK_IRQSAVE=3Dy
CONFIG_INLINE_SPIN_UNLOCK_BH=3Dy
CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE=3Dy
CONFIG_INLINE_READ_LOCK=3Dy
CONFIG_INLINE_READ_LOCK_BH=3Dy
CONFIG_INLINE_READ_LOCK_IRQ=3Dy
CONFIG_INLINE_READ_LOCK_IRQSAVE=3Dy
CONFIG_INLINE_READ_UNLOCK=3Dy
CONFIG_INLINE_READ_UNLOCK_BH=3Dy
CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
CONFIG_INLINE_READ_UNLOCK_IRQRESTORE=3Dy
CONFIG_INLINE_WRITE_LOCK=3Dy
CONFIG_INLINE_WRITE_LOCK_BH=3Dy
CONFIG_INLINE_WRITE_LOCK_IRQ=3Dy
CONFIG_INLINE_WRITE_LOCK_IRQSAVE=3Dy
CONFIG_INLINE_WRITE_UNLOCK=3Dy
CONFIG_INLINE_WRITE_UNLOCK_BH=3Dy
CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE=3Dy
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
CONFIG_LOCK_SPIN_ON_OWNER=3Dy
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
CONFIG_QUEUED_SPINLOCKS=3Dy
CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
CONFIG_QUEUED_RWLOCKS=3Dy
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
CONFIG_FREEZER=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_ARCH_BINFMT_ELF_STATE=3Dy
CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS=3Dy
CONFIG_ARCH_HAVE_ELF_PROT=3Dy
CONFIG_ARCH_USE_GNU_PROPERTY=3Dy
CONFIG_ELFCORE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=3Dy
CONFIG_SWAP=3Dy
CONFIG_ZSWAP=3Dy
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_SHRINKER_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
CONFIG_ZBUD=3Dy
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set

#
# Slab allocator options
#
CONFIG_SLUB=3Dy
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=3Dy
CONFIG_SLAB_FREELIST_RANDOM=3Dy
CONFIG_SLAB_FREELIST_HARDENED=3Dy
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=3Dy
# CONFIG_RANDOM_KMALLOC_CACHES is not set
# end of Slab allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_GUP_FAST=3Dy
CONFIG_ARCH_KEEP_MEMBLOCK=3Dy
CONFIG_NUMA_KEEP_MEMINFO=3Dy
CONFIG_MEMORY_ISOLATION=3Dy
CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_MEMORY_HOTPLUG=3Dy
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=3Dy
CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
CONFIG_COMPACTION=3Dy
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=3D1
CONFIG_PAGE_REPORTING=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
CONFIG_CONTIG_ALLOC=3Dy
CONFIG_PCP_BATCH_SCALE_MAX=3D5
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_MMU_NOTIFIER=3Dy
CONFIG_KSM=3Dy
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_MEMORY_FAILURE=3Dy
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANTS_THP_SWAP=3Dy
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
CONFIG_THP_SWAP=3Dy
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_PGTABLE_HAS_HUGE_LEAVES=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_CMA=3Dy
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=3D19
CONFIG_GENERIC_EARLY_IOREMAP=3Dy
CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy
CONFIG_ZONE_DMA=3Dy
CONFIG_ZONE_DMA32=3Dy
# CONFIG_ZONE_DEVICE is not set
CONFIG_GET_FREE_REGION=3Dy
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
CONFIG_ARCH_USES_PG_ARCH_X=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
CONFIG_MAPPING_DIRTY_HELPERS=3Dy
CONFIG_MEMFD_CREATE=3Dy
CONFIG_SECRETMEM=3Dy
# CONFIG_ANON_VMA_NAME is not set
CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
CONFIG_USERFAULTFD=3Dy
CONFIG_PTE_MARKER_UFFD_WP=3Dy
CONFIG_LRU_GEN=3Dy
# CONFIG_LRU_GEN_ENABLED is not set
# CONFIG_LRU_GEN_STATS is not set
CONFIG_LRU_GEN_WALKS_MMU=3Dy
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=3Dy
CONFIG_PER_VMA_LOCK=3Dy
CONFIG_LOCK_MM_AND_FIND_VMA=3Dy
CONFIG_EXECMEM=3Dy
CONFIG_NUMA_MEMBLKS=3Dy
CONFIG_NUMA_EMU=3Dy

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=3Dy
CONFIG_NET_INGRESS=3Dy
CONFIG_NET_EGRESS=3Dy
CONFIG_NET_XGRESS=3Dy
CONFIG_SKB_EXTENSIONS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=3Dy
CONFIG_AF_UNIX_OOB=3Dy
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
CONFIG_XFRM_STATISTICS=3Dy
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=3Dy
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_FIB_TRIE_STATS=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE_COMMON=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_SYN_COOKIES=3Dy
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=3D16
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=3Dy
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=3Dy
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_SIGPOOL=3Dy
# CONFIG_TCP_AO is not set
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_IPV6_MIP6=3Dy
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
CONFIG_IPV6_SEG6_HMAC=3Dy
CONFIG_IPV6_SEG6_BPF=3Dy
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=3Dy
CONFIG_MPTCP=3Dy
CONFIG_MPTCP_IPV6=3Dy
CONFIG_NETWORK_SECMARK=3Dy
CONFIG_NET_PTP_CLASSIFY=3Dy
CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_ADVANCED=3Dy

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=3Dy
CONFIG_NETFILTER_EGRESS=3Dy
CONFIG_NETFILTER_SKIP_EGRESS=3Dy
CONFIG_NETFILTER_BPF_LINK=3Dy
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_SYSLOG is not set
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=3Dm
CONFIG_NETFILTER_XTABLES_COMPAT=3Dy

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
# CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
# CONFIG_NETFILTER_XT_TARGET_TEE is not set
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_BPF is not set
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_HL is not set
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_IPTABLES_LEGACY=3Dm
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
CONFIG_IP_NF_IPTABLES=3Dm
# CONFIG_IP_NF_MATCH_AH is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_TTL is not set
CONFIG_IP_NF_FILTER=3Dm
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPFILTER is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=3Dy
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=3Dy
CONFIG_DEFAULT_FQ_CODEL=3Dy
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH=3D"fq_codel"

#
# Classification
#
CONFIG_NET_CLS=3Dy
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
# CONFIG_NET_EMATCH_CMP is not set
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=3Dy
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=3Dm
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=3Dm
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=3Dy
CONFIG_NET_MPLS_GSO=3Dy
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=3Dy
CONFIG_NET_L3_MASTER_DEV=3Dy
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=3Dy
CONFIG_MAX_SKB_FRAGS=3D17
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
CONFIG_XPS=3Dy
CONFIG_CGROUP_NET_PRIO=3Dy
CONFIG_CGROUP_NET_CLASSID=3Dy
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
CONFIG_BPF_STREAM_PARSER=3Dy
CONFIG_NET_FLOW_LIMIT=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=3Dy
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=3Dy
CONFIG_LWTUNNEL_BPF=3Dy
CONFIG_DST_CACHE=3Dy
CONFIG_GRO_CELLS=3Dy
CONFIG_NET_SOCK_MSG=3Dy
CONFIG_PAGE_POOL=3Dy
CONFIG_PAGE_POOL_STATS=3Dy
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=3Dy

#
# Device Drivers
#
CONFIG_ARM_AMBA=3Dy
CONFIG_TEGRA_AHB=3Dy
CONFIG_HAVE_PCI=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_DOMAINS_GENERIC=3Dy
CONFIG_PCI_SYSCALL=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy
CONFIG_PCIEAER=3Dy
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=3Dy
CONFIG_PCIEASPM_DEFAULT=3Dy
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=3Dy
CONFIG_PCIE_DPC=3Dy
CONFIG_PCIE_PTM=3Dy
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_DOE=3Dy
CONFIG_PCI_ECAM=3Dy
CONFIG_PCI_BRIDGE_EMUL=3Dy
CONFIG_PCI_IOV=3Dy
CONFIG_PCI_PRI=3Dy
CONFIG_PCI_PASID=3Dy
CONFIG_PCI_LABEL=3Dy
# CONFIG_PCI_DYNAMIC_OF_NODES is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=3Dy
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D16
CONFIG_HOTPLUG_PCI=3Dy
CONFIG_HOTPLUG_PCI_ACPI=3Dy
# CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA is not set
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=3Dy
CONFIG_HOTPLUG_PCI_SHPC=3Dy

#
# PCI controller drivers
#
CONFIG_PCI_AARDVARK=3Dy
# CONFIG_PCIE_ALTERA is not set
CONFIG_PCIE_BRCMSTB=3Dy
CONFIG_PCI_HOST_THUNDER_PEM=3Dy
CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=3Dy
CONFIG_PCI_HOST_GENERIC=3Dy
# CONFIG_PCIE_HISI_ERR is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set
CONFIG_PCI_TEGRA=3Dy
# CONFIG_PCIE_RCAR_HOST is not set
CONFIG_PCIE_ROCKCHIP=3Dy
CONFIG_PCIE_ROCKCHIP_HOST=3Dy
CONFIG_PCI_XGENE=3Dy
CONFIG_PCI_XGENE_MSI=3Dy
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_DMA_PL is not set
CONFIG_PCIE_XILINX_NWL=3Dy
# CONFIG_PCIE_XILINX_CPM is not set

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=3Dy
CONFIG_PCIE_CADENCE_HOST=3Dy
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
CONFIG_PCI_J721E=3Dy
CONFIG_PCI_J721E_HOST=3Dy
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=3Dy
CONFIG_PCIE_DW_HOST=3Dy
# CONFIG_PCIE_AL is not set
# CONFIG_PCI_MESON is not set
# CONFIG_PCI_IMX6_HOST is not set
CONFIG_PCI_LAYERSCAPE=3Dy
CONFIG_PCI_HISI=3Dy
CONFIG_PCIE_KIRIN=3Dy
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCIE_ARMADA_8K=3Dy
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_QCOM=3Dy
# CONFIG_PCIE_RCAR_GEN4_HOST is not set
CONFIG_PCIE_ROCKCHIP_DW_HOST=3Dy
# CONFIG_PCI_KEYSTONE_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=3Dy
# CONFIG_CXL_PCI is not set
# CONFIG_CXL_ACPI is not set
CONFIG_CXL_PORT=3Dy
CONFIG_CXL_REGION=3Dy
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=3Dy
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy

#
# Firmware loader
#
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_DEBUG=3Dy
CONFIG_FW_LOADER_PAGED_BUF=3Dy
CONFIG_FW_LOADER_SYSFS=3Dy
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=3Dy
CONFIG_FW_LOADER_COMPRESS_XZ=3Dy
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=3Dy
CONFIG_FW_UPLOAD=3Dy
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=3Dy
CONFIG_ALLOW_DEV_COREDUMP=3Dy
CONFIG_DEV_COREDUMP=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=3Dy
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=3Dy
CONFIG_GENERIC_CPU_DEVICES=3Dy
CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
CONFIG_SOC_BUS=3Dy
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dy
CONFIG_REGMAP_SPMI=3Dy
CONFIG_REGMAP_MMIO=3Dy
CONFIG_REGMAP_IRQ=3Dy
CONFIG_DMA_SHARED_BUFFER=3Dy
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_GENERIC_ARCH_TOPOLOGY=3Dy
CONFIG_GENERIC_ARCH_NUMA=3Dy
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_CCI=3Dy
CONFIG_ARM_CCI400_COMMON=3Dy
# CONFIG_MOXTET is not set
CONFIG_HISILICON_LPC=3Dy
# CONFIG_IMX_WEIM is not set
CONFIG_QCOM_EBI2=3Dy
# CONFIG_QCOM_SSC_BLOCK_BUS is not set
CONFIG_SUN50I_DE2_BUS=3Dy
CONFIG_SUNXI_RSB=3Dy
CONFIG_TEGRA_ACONNECT=3Dy
# CONFIG_TEGRA_GMI is not set
CONFIG_TI_SYSC=3Dy
CONFIG_VEXPRESS_CONFIG=3Dy
CONFIG_FSL_MC_BUS=3Dy
CONFIG_FSL_MC_UAPI_SUPPORT=3Dy
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=3Dy
# CONFIG_ARM_SCMI_RAW_MODE_SUPPORT is not set
CONFIG_ARM_SCMI_HAVE_TRANSPORT=3Dy
CONFIG_ARM_SCMI_HAVE_SHMEM=3Dy
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=3Dy
CONFIG_ARM_SCMI_TRANSPORT_SMC=3Dy
# CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE is not set
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
# CONFIG_ARM_SDE_INTERFACE is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=3Dy
CONFIG_DMI_SYSFS=3Dy
# CONFIG_ISCSI_IBFT is not set
CONFIG_RASPBERRYPI_FIRMWARE=3Dy
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=3Dy
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_TI_SCI_PROTOCOL=3Dy
# CONFIG_TURRIS_MOX_RWTM is not set
# CONFIG_ARM_FFA_TRANSPORT is not set
CONFIG_GOOGLE_FIRMWARE=3Dy
# CONFIG_GOOGLE_CBMEM is not set
CONFIG_GOOGLE_COREBOOT_TABLE=3Dy
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=3Dy
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=3Dy
CONFIG_EFI_VARS_PSTORE=3Dm
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_SOFT_RESERVE=3Dy
CONFIG_EFI_PARAMS_FROM_FDT=3Dy
CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
CONFIG_EFI_GENERIC_STUB=3Dy
# CONFIG_EFI_ZBOOT is not set
CONFIG_EFI_ARMSTUB_DTB_LOADER=3Dy
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_RESET_ATTACK_MITIGATION=3Dy
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=3Dy
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=3Dy
CONFIG_UEFI_CPER_ARM=3Dy
CONFIG_MESON_SM=3Dy
CONFIG_ARM_PSCI_FW=3Dy
# CONFIG_ARM_PSCI_CHECKER is not set

#
# Qualcomm firmware drivers
#
CONFIG_QCOM_SCM=3Dy
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
# CONFIG_QCOM_QSEECOM is not set
# end of Qualcomm firmware drivers

CONFIG_HAVE_ARM_SMCCC=3Dy
CONFIG_HAVE_ARM_SMCCC_DISCOVERY=3Dy
CONFIG_ARM_SMCCC_SOC_ID=3Dy

#
# Tegra firmware driver
#
# CONFIG_TEGRA_IVC is not set
# end of Tegra firmware driver

#
# Zynq MPSoC Firmware Drivers
#
CONFIG_ZYNQMP_FIRMWARE=3Dy
# CONFIG_ZYNQMP_FIRMWARE_DEBUG is not set
# end of Zynq MPSoC Firmware Drivers
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=3Dy
CONFIG_OF=3Dy
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=3Dy
CONFIG_OF_EARLY_FLATTREE=3Dy
CONFIG_OF_KOBJ=3Dy
CONFIG_OF_ADDRESS=3Dy
CONFIG_OF_IRQ=3Dy
CONFIG_OF_RESERVED_MEM=3Dy
# CONFIG_OF_OVERLAY is not set
CONFIG_OF_NUMA=3Dy
# CONFIG_PARPORT is not set
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_CDROM=3Dm
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XEN_BLKDEV_FRONTEND is not set
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=3Dm
CONFIG_BLK_DEV_NVME=3Dm
CONFIG_NVME_MULTIPATH=3Dy
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=3Dy
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_HOST_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=3Dy
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_NSM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dm
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=3Dm
CONFIG_SCSI=3Dm
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_CHR_DEV_SG=3Dm
CONFIG_BLK_DEV_BSG=3Dy
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=3Dy
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_HISI_SAS is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_DH=3Dy
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=3Dm
CONFIG_SATA_HOST=3Dy
CONFIG_PATA_TIMINGS=3Dy
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_ATA_FORCE=3Dy
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_ZPODD=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dm
CONFIG_SATA_MOBILE_LPM_POLICY=3D3
CONFIG_SATA_AHCI_PLATFORM=3Dm
CONFIG_AHCI_DWC=3Dm
# CONFIG_AHCI_IMX is not set
CONFIG_AHCI_CEVA=3Dm
CONFIG_AHCI_MVEBU=3Dm
# CONFIG_AHCI_SUNXI is not set
CONFIG_AHCI_TEGRA=3Dm
CONFIG_AHCI_XGENE=3Dm
CONFIG_AHCI_QORIQ=3Dm
CONFIG_SATA_AHCI_SEATTLE=3Dm
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=3Dm
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_RCAR is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IMX is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OF_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=3Dy
# CONFIG_BLK_DEV_MD is not set
CONFIG_MD_BITMAP_FILE=3Dy
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=3Dy
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=3Dy
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=3Dy
# CONFIG_DM_VDO is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=3Dy
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=3D128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_PFCP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_NETKIT is not set
# CONFIG_NET_VRF is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=3Dy
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=3Dy
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=3Dy
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALLWINNER=3Dy
# CONFIG_SUN4I_EMAC is not set
CONFIG_NET_VENDOR_ALTEON=3Dy
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=3Dy
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=3Dy
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_PDS_CORE is not set
# CONFIG_NET_XGENE is not set
# CONFIG_NET_XGENE_V2 is not set
CONFIG_NET_VENDOR_AQUANTIA=3Dy
# CONFIG_AQTION is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=3Dy
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=3Dy
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=3Dy
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=3Dy
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=3Dy
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=3Dy
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=3Dy
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=3Dy
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=3Dy
CONFIG_NET_TULIP=3Dy
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
CONFIG_NET_VENDOR_DLINK=3Dy
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=3Dy
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=3Dy
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=3Dy
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FREESCALE=3Dy
# CONFIG_FEC is not set
# CONFIG_FSL_FMAN is not set
# CONFIG_FSL_PQ_MDIO is not set
# CONFIG_FSL_XGMAC_MDIO is not set
# CONFIG_GIANFAR is not set
# CONFIG_FSL_DPAA2_SWITCH is not set
# CONFIG_FSL_ENETC is not set
# CONFIG_FSL_ENETC_VF is not set
# CONFIG_FSL_ENETC_IERB is not set
CONFIG_NET_VENDOR_FUNGIBLE=3Dy
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=3Dy
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HISILICON=3Dy
# CONFIG_HIX5HD2_GMAC is not set
# CONFIG_HISI_FEMAC is not set
# CONFIG_HIP04_ETH is not set
# CONFIG_HNS_DSAF is not set
# CONFIG_HNS_ENET is not set
# CONFIG_HNS3 is not set
CONFIG_NET_VENDOR_HUAWEI=3Dy
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=3Dy
CONFIG_NET_VENDOR_INTEL=3Dy
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=3Dm
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_IDPF is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=3Dy
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=3Dy
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=3Dy
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA is not set
# CONFIG_MVPP2 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEONTX2_AF is not set
# CONFIG_OCTEONTX2_PF is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_OCTEON_EP_VF is not set
CONFIG_NET_VENDOR_MELLANOX=3Dy
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_MLXBF_GIGE is not set
CONFIG_NET_VENDOR_MICREL=3Dy
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=3Dy
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_LAN966X_SWITCH is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=3Dy
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=3Dy
CONFIG_NET_VENDOR_MYRI=3Dy
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=3Dy
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=3Dy
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=3Dy
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=3Dy
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=3Dy
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=3Dy
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=3Dy
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=3Dy
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=3Dy
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=3Dy
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=3Dy
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=3Dy
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=3Dy
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=3Dy
# CONFIG_SH_ETH is not set
# CONFIG_RAVB is not set
# CONFIG_RENESAS_ETHER_SWITCH is not set
CONFIG_NET_VENDOR_ROCKER=3Dy
CONFIG_NET_VENDOR_SAMSUNG=3Dy
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SILAN=3Dy
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=3Dy
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=3Dy
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=3Dy
# CONFIG_SMC91X is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=3Dy
# CONFIG_SNI_NETSEC is not set
CONFIG_NET_VENDOR_STMICRO=3Dy
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=3Dy
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=3Dy
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=3Dy
# CONFIG_TI_DAVINCI_MDIO is not set
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_K3_AM65_CPSW_NUSS is not set
# CONFIG_TI_K3_AM65_CPTS is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=3Dy
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=3Dy
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=3Dy
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=3Dy
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=3Dy
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_FDDI=3Dy
# CONFIG_DEFXX is not set
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=3Dy
CONFIG_WLAN_VENDOR_ADMTEK=3Dy
CONFIG_WLAN_VENDOR_ATH=3Dy
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K_PCI=3Dy
CONFIG_WLAN_VENDOR_ATMEL=3Dy
CONFIG_WLAN_VENDOR_BROADCOM=3Dy
CONFIG_WLAN_VENDOR_INTEL=3Dy
CONFIG_WLAN_VENDOR_INTERSIL=3Dy
CONFIG_WLAN_VENDOR_MARVELL=3Dy
CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
CONFIG_WLAN_VENDOR_MICROCHIP=3Dy
CONFIG_WLAN_VENDOR_PURELIFI=3Dy
CONFIG_WLAN_VENDOR_RALINK=3Dy
CONFIG_WLAN_VENDOR_REALTEK=3Dy
CONFIG_WLAN_VENDOR_RSI=3Dy
CONFIG_WLAN_VENDOR_SILABS=3Dy
CONFIG_WLAN_VENDOR_ST=3Dy
CONFIG_WLAN_VENDOR_TI=3Dy
CONFIG_WLAN_VENDOR_ZYDAS=3Dy
CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_XEN_NETDEV_FRONTEND is not set
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_LEDS=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
# CONFIG_KEYBOARD_IMX is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_TEGRA is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_SUN4I_LRADC is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_BYD=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
CONFIG_MOUSE_PS2_CYPRESS=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
CONFIG_MOUSE_PS2_SENTELIC=3Dy
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=3Dy
CONFIG_MOUSE_PS2_SMBUS=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=3Dy
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=3Dy
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
# CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUN4I is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_IQS7211 is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BBNSM_PWRKEY is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IBM_PANEL is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dy
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_HISI_POWERKEY is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_AMBAKMI is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=3Dy
CONFIG_LDISC_AUTOLOAD=3Dy

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=3Dy
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=3Dy
CONFIG_SERIAL_8250_16550A_VARIANTS=3Dy
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_DMA=3Dy
CONFIG_SERIAL_8250_PCILIB=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
# CONFIG_SERIAL_8250_EXAR is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=3Dy
CONFIG_SERIAL_8250_BCM2835AUX=3Dy
CONFIG_SERIAL_8250_FSL=3Dy
CONFIG_SERIAL_8250_DW=3Dy
# CONFIG_SERIAL_8250_EM is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_OMAP=3Dy
CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=3Dy
CONFIG_SERIAL_8250_PERICOM=3Dy
CONFIG_SERIAL_8250_TEGRA=3Dy
CONFIG_SERIAL_OF_PLATFORM=3Dy

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=3Dy
CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
CONFIG_SERIAL_AMBA_PL011=3Dy
CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
# CONFIG_SERIAL_EARLYCON_SEMIHOST is not set
CONFIG_SERIAL_MESON=3Dy
CONFIG_SERIAL_MESON_CONSOLE=3Dy
CONFIG_SERIAL_TEGRA=3Dy
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_IMX=3Dy
CONFIG_SERIAL_IMX_CONSOLE=3Dy
CONFIG_SERIAL_IMX_EARLYCON=3Dy
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_SH_SCI=3Dy
CONFIG_SERIAL_SH_SCI_NR_UARTS=3D18
CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
CONFIG_SERIAL_SH_SCI_EARLYCON=3Dy
CONFIG_SERIAL_SH_SCI_DMA=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_MSM=3Dy
CONFIG_SERIAL_MSM_CONSOLE=3Dy
CONFIG_SERIAL_QCOM_GENI=3Dy
CONFIG_SERIAL_QCOM_GENI_CONSOLE=3Dy
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=3Dy
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=3Dy
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=3Dy
CONFIG_SERIAL_FSL_LPUART_CONSOLE=3Dy
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_SPRD is not set
CONFIG_SERIAL_MVEBU_UART=3Dy
CONFIG_SERIAL_MVEBU_CONSOLE=3Dy
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=3Dy
CONFIG_HVC_IRQ=3Dy
CONFIG_HVC_XEN=3Dy
CONFIG_HVC_XEN_FRONTEND=3Dy
# CONFIG_HVC_DCC is not set
CONFIG_SERIAL_DEV_BUS=3Dy
CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_SSIF_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=3Dy
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_BCM2835 is not set
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
# CONFIG_HW_RANDOM_OMAP is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_HISI is not set
CONFIG_HW_RANDOM_HISTB=3Dy
# CONFIG_HW_RANDOM_XGENE is not set
# CONFIG_HW_RANDOM_MESON is not set
# CONFIG_HW_RANDOM_CAVIUM is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_HW_RANDOM_ARM_SMCCC_TRNG is not set
# CONFIG_HW_RANDOM_CN10K is not set
# CONFIG_APPLICOM is not set
CONFIG_DEVMEM=3Dy
CONFIG_DEVPORT=3Dy
CONFIG_TCG_TPM=3Dy
# CONFIG_TCG_TPM2_HMAC is not set
CONFIG_HW_RANDOM_TPM=3Dy
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_SYNQUACER is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=3Dy
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_ACPI_I2C_OPREGION=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=3Dy

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_HIX5HD2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_ZHAOXIN is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_BCM2835 is not set
CONFIG_I2C_BRCMSTB=3Dy
# CONFIG_I2C_CADENCE is not set
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_NOMADIK is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QCOM_GENI is not set
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_SH_MOBILE is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SYNQUACER is not set
# CONFIG_I2C_TEGRA is not set
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_THUNDERX is not set
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_XGENE_SLIMPRO is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=3Dy
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy
CONFIG_SPI_MEM=3Dy

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AMLOGIC_SPIFC_A1 is not set
# CONFIG_SPI_ARMADA_3700 is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM_QSPI is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_FSL_LPSPI is not set
# CONFIG_SPI_FSL_QUADSPI is not set
# CONFIG_SPI_HISI_KUNPENG is not set
# CONFIG_SPI_HISI_SFC_V3XX is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_IMX is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_ORION is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PL022 is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
# CONFIG_SPI_RZV2M_CSI is not set
# CONFIG_SPI_QCOM_QSPI is not set
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_QCOM_GENI is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SH_MSIOF is not set
# CONFIG_SPI_SH_HSPI is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_SN_F_OSPI is not set
# CONFIG_SPI_SUN4I is not set
# CONFIG_SPI_SUN6I is not set
# CONFIG_SPI_SYNQUACER is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TEGRA210_QUAD is not set
# CONFIG_SPI_TEGRA114 is not set
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
# CONFIG_SPI_THUNDERX is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_XLP is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=3Dy
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=3Dy
CONFIG_SPMI=3Dy
# CONFIG_SPMI_HISI3670 is not set
CONFIG_SPMI_MSM_PMIC_ARB=3Dy
# CONFIG_HSI is not set
CONFIG_PPS=3Dy
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dy
CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks=
=2E
#
CONFIG_PTP_1588_CLOCK_KVM=3Dy
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_FC3W is not set
# CONFIG_PTP_1588_CLOCK_MOCK is not set
# end of PTP clock support

CONFIG_PINCTRL=3Dy
CONFIG_GENERIC_PINCTRL_GROUPS=3Dy
CONFIG_PINMUX=3Dy
CONFIG_GENERIC_PINMUX_FUNCTIONS=3Dy
CONFIG_PINCONF=3Dy
CONFIG_GENERIC_PINCONF=3Dy
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=3Dy
# CONFIG_PINCTRL_AW9523 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_MAX77620=3Dy
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_ROCKCHIP=3Dy
# CONFIG_PINCTRL_SCMI is not set
CONFIG_PINCTRL_SINGLE=3Dy
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_ZYNQMP=3Dy
CONFIG_PINCTRL_BCM2835=3Dy
CONFIG_PINCTRL_IMX=3Dy
CONFIG_PINCTRL_IMX8MM=3Dy
CONFIG_PINCTRL_IMX8MN=3Dy
CONFIG_PINCTRL_IMX8MP=3Dy
CONFIG_PINCTRL_IMX8MQ=3Dy
# CONFIG_PINCTRL_IMX8ULP is not set
# CONFIG_PINCTRL_IMXRT1050 is not set
# CONFIG_PINCTRL_IMX93 is not set
# CONFIG_PINCTRL_IMXRT1170 is not set
CONFIG_PINCTRL_MESON=3Dy
CONFIG_PINCTRL_MESON_GXBB=3Dy
CONFIG_PINCTRL_MESON_GXL=3Dy
CONFIG_PINCTRL_MESON8_PMX=3Dy
CONFIG_PINCTRL_MESON_AXG=3Dy
CONFIG_PINCTRL_MESON_AXG_PMX=3Dy
CONFIG_PINCTRL_MESON_G12A=3Dy
CONFIG_PINCTRL_MESON_A1=3Dy
CONFIG_PINCTRL_MESON_S4=3Dy
CONFIG_PINCTRL_AMLOGIC_C3=3Dy
CONFIG_PINCTRL_AMLOGIC_T7=3Dy
CONFIG_PINCTRL_MVEBU=3Dy
CONFIG_PINCTRL_ARMADA_AP806=3Dy
CONFIG_PINCTRL_ARMADA_CP110=3Dy
CONFIG_PINCTRL_AC5=3Dy
CONFIG_PINCTRL_ARMADA_37XX=3Dy
CONFIG_PINCTRL_MSM=3Dy
# CONFIG_PINCTRL_IPQ5018 is not set
# CONFIG_PINCTRL_IPQ5332 is not set
# CONFIG_PINCTRL_IPQ8074 is not set
# CONFIG_PINCTRL_IPQ6018 is not set
# CONFIG_PINCTRL_IPQ9574 is not set
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MSM8916=3Dy
# CONFIG_PINCTRL_MSM8953 is not set
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
CONFIG_PINCTRL_MSM8996=3Dy
# CONFIG_PINCTRL_MSM8998 is not set
# CONFIG_PINCTRL_QCM2290 is not set
# CONFIG_PINCTRL_QCS404 is not set
# CONFIG_PINCTRL_QDF2XXX is not set
# CONFIG_PINCTRL_QDU1000 is not set
# CONFIG_PINCTRL_SA8775P is not set
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SC7280 is not set
# CONFIG_PINCTRL_SC8180X is not set
# CONFIG_PINCTRL_SC8280XP is not set
# CONFIG_PINCTRL_SDM660 is not set
# CONFIG_PINCTRL_SDM670 is not set
CONFIG_PINCTRL_SDM845=3Dy
# CONFIG_PINCTRL_SDX75 is not set
# CONFIG_PINCTRL_SM4450 is not set
# CONFIG_PINCTRL_SM6115 is not set
# CONFIG_PINCTRL_SM6125 is not set
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SM6375 is not set
# CONFIG_PINCTRL_SM7150 is not set
# CONFIG_PINCTRL_SM8150 is not set
# CONFIG_PINCTRL_SM8250 is not set
# CONFIG_PINCTRL_SM8350 is not set
# CONFIG_PINCTRL_SM8450 is not set
# CONFIG_PINCTRL_SM8550 is not set
# CONFIG_PINCTRL_SM8650 is not set
# CONFIG_PINCTRL_X1E80100 is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=3Dy
CONFIG_PINCTRL_QCOM_SSBI_PMIC=3Dy
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=3Dy
CONFIG_PINCTRL_SH_PFC=3Dy
CONFIG_PINCTRL_PFC_R8A774A1=3Dy
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SUNXI=3Dy
# CONFIG_PINCTRL_SUN4I_A10 is not set
# CONFIG_PINCTRL_SUN5I is not set
# CONFIG_PINCTRL_SUN6I_A31 is not set
# CONFIG_PINCTRL_SUN6I_A31_R is not set
# CONFIG_PINCTRL_SUN8I_A23 is not set
# CONFIG_PINCTRL_SUN8I_A33 is not set
# CONFIG_PINCTRL_SUN8I_A83T is not set
# CONFIG_PINCTRL_SUN8I_A83T_R is not set
# CONFIG_PINCTRL_SUN8I_A23_R is not set
# CONFIG_PINCTRL_SUN8I_H3 is not set
CONFIG_PINCTRL_SUN8I_H3_R=3Dy
# CONFIG_PINCTRL_SUN8I_V3S is not set
# CONFIG_PINCTRL_SUN9I_A80 is not set
# CONFIG_PINCTRL_SUN9I_A80_R is not set
# CONFIG_PINCTRL_SUN20I_D1 is not set
CONFIG_PINCTRL_SUN50I_A64=3Dy
CONFIG_PINCTRL_SUN50I_A64_R=3Dy
CONFIG_PINCTRL_SUN50I_A100=3Dy
CONFIG_PINCTRL_SUN50I_A100_R=3Dy
CONFIG_PINCTRL_SUN50I_H5=3Dy
CONFIG_PINCTRL_SUN50I_H6=3Dy
CONFIG_PINCTRL_SUN50I_H6_R=3Dy
CONFIG_PINCTRL_SUN50I_H616=3Dy
CONFIG_PINCTRL_SUN50I_H616_R=3Dy
CONFIG_PINCTRL_TEGRA=3Dy
CONFIG_PINCTRL_TEGRA124=3Dy
CONFIG_PINCTRL_TEGRA210=3Dy
CONFIG_PINCTRL_TEGRA_XUSB=3Dy
CONFIG_GPIOLIB=3Dy
CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
CONFIG_OF_GPIO=3Dy
CONFIG_GPIO_ACPI=3Dy
CONFIG_GPIOLIB_IRQCHIP=3Dy
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_CDEV=3Dy
CONFIG_GPIO_CDEV_V1=3Dy
CONFIG_GPIO_GENERIC=3Dy

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_RASPBERRYPI_EXP=3Dy
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DAVINCI=3Dy
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=3Dy
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MPC8XXX=3Dy
CONFIG_GPIO_MVEBU=3Dy
CONFIG_GPIO_MXC=3Dy
CONFIG_GPIO_PL061=3Dy
# CONFIG_GPIO_RCAR is not set
CONFIG_GPIO_ROCKCHIP=3Dy
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_TEGRA=3Dy
# CONFIG_GPIO_THUNDERX is not set
# CONFIG_GPIO_VF610 is not set
CONFIG_GPIO_XGENE=3Dy
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_XLP=3Dy
# CONFIG_GPIO_ZYNQ is not set
CONFIG_GPIO_ZYNQMP_MODEPIN=3Dy
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=3Dy
CONFIG_GPIO_PCA953X_IRQ=3Dy
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_MAX77620=3Dy
# CONFIG_GPIO_SL28CPLD is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=3Dy
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_HISI=3Dy
CONFIG_POWER_RESET_MSM=3Dy
# CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_VEXPRESS=3Dy
CONFIG_POWER_RESET_XGENE=3Dy
CONFIG_POWER_RESET_SYSCON=3Dy
CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=3Dy
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_FUEL_GAUGE_MM8013 is not set
CONFIG_HWMON=3Dy
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_ARM_SCMI is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CHIPCAP2 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GIGABYTE_WATERFORCE is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_HS3001 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWERZ is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2991 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_LTC4282 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_MAX31827 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_KRAKEN3 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PT5161L is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VEXPRESS is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_THERMAL=3Dy
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=3Dy
# CONFIG_THERMAL_DEBUGFS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
CONFIG_THERMAL_HWMON=3Dy
CONFIG_THERMAL_OF=3Dy
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_DEFAULT_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
CONFIG_THERMAL_GOV_STEP_WISE=3Dy
CONFIG_THERMAL_GOV_BANG_BANG=3Dy
CONFIG_THERMAL_GOV_USER_SPACE=3Dy
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
CONFIG_CPU_THERMAL=3Dy
CONFIG_CPU_FREQ_THERMAL=3Dy
CONFIG_DEVFREQ_THERMAL=3Dy
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_HISI_THERMAL is not set
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
# CONFIG_K3_THERMAL is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
# CONFIG_RCAR_THERMAL is not set
# CONFIG_RCAR_GEN3_THERMAL is not set
# CONFIG_RZG2L_THERMAL is not set
# CONFIG_ARMADA_THERMAL is not set
CONFIG_AMLOGIC_THERMAL=3Dy

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
# CONFIG_BCM2835_THERMAL is not set
# end of Broadcom thermal drivers

#
# NVIDIA Tegra thermal drivers
#
CONFIG_TEGRA_SOCTHERM=3Dy
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
# CONFIG_QCOM_LMH is not set
# end of Qualcomm thermal drivers

CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
CONFIG_WATCHDOG_SYSFS=3Dy
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=3Dy

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=3Dy
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=3Dy
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=3Dy

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_XILINX_WINDOW_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_ARM_SP805_WATCHDOG is not set
# CONFIG_ARM_SBSA_WATCHDOG is not set
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_K3_RTI_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_IMX2_WDT is not set
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_TEGRA_WATCHDOG is not set
# CONFIG_QCOM_WDT is not set
# CONFIG_MESON_GXBB_WATCHDOG is not set
# CONFIG_MESON_WATCHDOG is not set
# CONFIG_ARM_SMC_WATCHDOG is not set
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_MARVELL_GTI_WDT=3Dy
# CONFIG_BCM2835_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=3Dy
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dy
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AC100 is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_AXP20X_RSB is not set
# CONFIG_MFD_CS42L43_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_MAX5970 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77541 is not set
CONFIG_MFD_MAX77620=3Dy
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_QCOM_RPM is not set
# CONFIG_MFD_SPMI_PMIC is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK8XX_I2C is not set
# CONFIG_MFD_RK8XX_SPI is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=3Dy
CONFIG_MFD_SL28CPLD=3Dy
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=3Dy
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65219 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS6594_I2C is not set
# CONFIG_MFD_TPS6594_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_VEXPRESS_SYSREG=3Dy
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_NETLINK_EVENTS is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_ARM_SCMI is not set
# CONFIG_REGULATOR_AW37503 is not set
# CONFIG_REGULATOR_DA9121 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77503 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77857 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
# CONFIG_REGULATOR_MAX77826 is not set
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_REFGEN is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RAA215300 is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4803 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_RTQ2208 is not set
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SUN20I=3Dy
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS6287X is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_VEXPRESS is not set
# CONFIG_REGULATOR_VQMMC_IPQ4019 is not set
# CONFIG_REGULATOR_QCOM_LABIBB is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=3Dy
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_MESON_AO is not set
# CONFIG_CEC_MESON_G12A_AO is not set
# CONFIG_CEC_TEGRA is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=3Dy
CONFIG_SCREEN_INFO=3Dy
CONFIG_VIDEO=3Dy
# CONFIG_AUXDISPLAY is not set
# CONFIG_TEGRA_HOST1X is not set
CONFIG_DRM=3Dm
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=3Dm
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=3Dy
CONFIG_DRM_FBDEV_OVERALLOC=3D100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
CONFIG_DRM_TTM=3Dm
CONFIG_DRM_TTM_HELPER=3Dm

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_HDLCD is not set
# CONFIG_DRM_MALI_DISPLAY is not set
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_XE is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_ROCKCHIP is not set
CONFIG_DRM_VMWGFX=3Dm
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DU is not set
# CONFIG_DRM_RZG2L_MIPI_DSI is not set
# CONFIG_DRM_SHMOBILE is not set
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_VIRTIO_GPU is not set
# CONFIG_DRM_MSM is not set
# CONFIG_DRM_TEGRA is not set
CONFIG_DRM_PANEL=3Dy

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=3Dy
CONFIG_DRM_PANEL_BRIDGE=3Dy

#
# Display Interface Bridges
#
# CONFIG_DRM_CHIPONE_ICN6211 is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_FSL_LDB is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NWL_MIPI_DSI is not set
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SAMSUNG_DSIM is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_DLPC3433 is not set
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI83 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE is not set
# CONFIG_DRM_IMX8MP_HDMI_PVI is not set
# CONFIG_DRM_IMX8QM_LDB is not set
# CONFIG_DRM_IMX8QXP_LDB is not set
# CONFIG_DRM_IMX8QXP_PIXEL_COMBINER is not set
# CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI is not set
# CONFIG_DRM_IMX93_MIPI_DSI is not set
# end of Display Interface Bridges

# CONFIG_DRM_IMX_DCSS is not set
# CONFIG_DRM_IMX_LCDC is not set
# CONFIG_DRM_V3D is not set
# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_HISI_KIRIN is not set
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_IMX_LCDIF is not set
# CONFIG_DRM_MESON is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_PL111 is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_LIMA is not set
# CONFIG_DRM_PANFROST is not set
# CONFIG_DRM_PANTHOR is not set
# CONFIG_DRM_TIDSS is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_POWERVR is not set
# CONFIG_DRM_WERROR is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy

#
# Frame buffer Devices
#
CONFIG_FB=3Dy
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_IMX is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_EFI=3Dy
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_XILINX is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=3Dy
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=3Dy
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=3Dy
CONFIG_FB_NOTIFY=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_DEVICE=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_SYS_FILLRECT=3Dy
CONFIG_FB_SYS_COPYAREA=3Dy
CONFIG_FB_SYS_IMAGEBLIT=3Dy
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYSMEM_FOPS=3Dy
CONFIG_FB_DEFERRED_IO=3Dy
CONFIG_FB_IOMEM_FOPS=3Dy
CONFIG_FB_IOMEM_HELPERS=3Dy
CONFIG_FB_SYSMEM_HELPERS=3Dy
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTD2801 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_MP3309C is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_HDMI=3Dy

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
CONFIG_DUMMY_CONSOLE_ROWS=3D25
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_JACK_INPUT_DEV=3Dy
CONFIG_SND_OSSEMUL=3Dy
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=3Dy
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_MAX_CARDS=3D32
CONFIG_SND_SUPPORT_OLD_API=3Dy
CONFIG_SND_PROC_FS=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=3Dy
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=3Dy
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_PCMTEST is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_SERIAL_GENERIC is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=3Dy
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=3Dm
CONFIG_SND_HDA_INTEL=3Dm
# CONFIG_SND_HDA_TEGRA is not set
CONFIG_SND_HDA_HWDEP=3Dy
CONFIG_SND_HDA_RECONFIG=3Dy
CONFIG_SND_HDA_INPUT_BEEP=3Dy
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
CONFIG_SND_HDA_PATCH_LOADER=3Dy
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=3Dm
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D1
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# CONFIG_SND_HDA_CTL_DEV_ID is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=3Dm
CONFIG_SND_HDA_PREALLOC_SIZE=3D2048
CONFIG_SND_INTEL_NHLT=3Dy
CONFIG_SND_INTEL_DSP_CONFIG=3Dm
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dm
CONFIG_SND_SPI=3Dy
CONFIG_SND_USB=3Dy
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_XEN_FRONTEND is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_HID_SUPPORT=3Dy
CONFIG_HID=3Dm
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_STADIA_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_WINWING is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2200 is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=3Dm
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

CONFIG_I2C_HID=3Dm
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dm
CONFIG_USB_LED_TRIG=3Dy
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dm
CONFIG_USB_PCI=3Dy
# CONFIG_USB_PCI_AMD is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=3Dy
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=3D2
CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=3D1
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=3Dm
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=3Dm
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
# CONFIG_USB_XHCI_MVEBU is not set
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_EHCI_PCI=3Dm
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_ORION is not set
# CONFIG_USB_EHCI_TEGRA is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_QCOM_EUD is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_LJCA is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ONBOARD_DEV is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_MXS_PHY is not set
# CONFIG_USB_TEGRA_PHY is not set
CONFIG_USB_ULPI=3Dy
CONFIG_USB_ULPI_VIEWPORT=3Dy
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=3Dy
CONFIG_PWRSEQ_EMMC=3Dy
CONFIG_PWRSEQ_SIMPLE=3Dy
CONFIG_MMC_BLOCK=3Dy
CONFIG_MMC_BLOCK_MINORS=3D256
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_ARMMMCI is not set
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_MESON_GX is not set
# CONFIG_MMC_MESON_MX_SDIO is not set
# CONFIG_MMC_MXC is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_SDHI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_DW is not set
# CONFIG_MMC_SH_MMCIF is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_SUNXI is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_BCM2835 is not set
# CONFIG_MMC_MTK is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=3Dy

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_AW200XX is not set
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_PCA995X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_LM3697 is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=3Dy
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=3Dy
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=3Dy
CONFIG_A11Y_BRAILLE_CONSOLE=3Dy

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_SUPPORT=3Dy
CONFIG_EDAC=3Dy
CONFIG_EDAC_LEGACY_SYSFS=3Dy
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_GHES is not set
# CONFIG_EDAC_LAYERSCAPE is not set
# CONFIG_EDAC_THUNDERX is not set
# CONFIG_EDAC_SYNOPSYS is not set
# CONFIG_EDAC_XGENE is not set
# CONFIG_EDAC_DMC520 is not set
# CONFIG_EDAC_ZYNQMP is not set
# CONFIG_EDAC_VERSAL is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=3Dy

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=3Dy
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX31335 is not set
CONFIG_RTC_DRV_MAX77686=3Dy
# CONFIG_RTC_DRV_NCT3018Y is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=3Dy
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=3Dy
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8111 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=3Dy

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_EFI=3Dy
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_IMXDI is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
# CONFIG_RTC_DRV_MESON_VRTC is not set
# CONFIG_RTC_DRV_SH is not set
# CONFIG_RTC_DRV_PL030 is not set
CONFIG_RTC_DRV_PL031=3Dy
CONFIG_RTC_DRV_SUN6I=3Dy
# CONFIG_RTC_DRV_MV is not set
# CONFIG_RTC_DRV_ARMADA38X is not set
# CONFIG_RTC_DRV_CADENCE is not set
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_TEGRA=3Dy
# CONFIG_RTC_DRV_MXC is not set
# CONFIG_RTC_DRV_MXC_V2 is not set
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_BBNSM is not set
CONFIG_RTC_DRV_XGENE=3Dy
# CONFIG_RTC_DRV_R7301 is not set
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=3Dy
CONFIG_DMA_ENGINE=3Dy
CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
CONFIG_DMA_ACPI=3Dy
CONFIG_DMA_OF=3Dy
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_AMBA_PL08X is not set
# CONFIG_AXI_DMAC is not set
CONFIG_DMA_BCM2835=3Dy
# CONFIG_DMA_SUN6I is not set
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
# CONFIG_FSL_QDMA is not set
# CONFIG_HISI_DMA is not set
# CONFIG_IMX_DMA is not set
# CONFIG_IMX_SDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_K3_DMA is not set
CONFIG_MV_XOR=3Dy
CONFIG_MV_XOR_V2=3Dy
# CONFIG_MXS_DMA is not set
# CONFIG_PL330_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_TEGRA186_GPC_DMA is not set
CONFIG_TEGRA20_APB_DMA=3Dy
CONFIG_TEGRA210_ADMA=3Dy
# CONFIG_XGENE_DMA is not set
# CONFIG_XILINX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_XILINX_ZYNQMP_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_BAM_DMA is not set
# CONFIG_QCOM_GPI_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_DW_EDMA is not set
# CONFIG_SF_PDMA is not set
# CONFIG_RCAR_DMAC is not set
# CONFIG_RENESAS_USB_DMAC is not set
CONFIG_TI_K3_UDMA=3Dy
CONFIG_TI_K3_UDMA_GLUE_LAYER=3Dy
CONFIG_TI_K3_PSIL=3Dy

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=3Dy
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=3Dy

#
# DMABUF options
#
CONFIG_SYNC_FILE=3Dy
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=3Dy
CONFIG_VIRT_DRIVERS=3Dy
CONFIG_VMGENID=3Dy
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=3Dy
CONFIG_VIRTIO=3Dy
CONFIG_VIRTIO_MENU=3Dy
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_MEM is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VIRTIO_DEBUG is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=3Dy
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_VSOCK is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=3Dy
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=3Dy
CONFIG_XEN_SCRUB_PAGES_DEFAULT=3Dy
# CONFIG_XEN_DEV_EVTCHN is not set
CONFIG_XEN_BACKEND=3Dy
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=3Dy
CONFIG_XEN_XENBUS_FRONTEND=3Dy
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=3Dy
# CONFIG_XEN_PCIDEV_STUB is not set
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_PRIVCMD is not set
CONFIG_XEN_EFI=3Dy
CONFIG_XEN_AUTO_XLATE=3Dy
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=3Dy
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_MFD_NVEC is not set
CONFIG_STAGING_MEDIA=3Dy
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
CONFIG_BCM_VIDEOCORE=3Dy
# CONFIG_BCM2835_VCHIQ is not set
# CONFIG_SND_BCM2835 is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_VME_BUS is not set
# CONFIG_GOLDFISH is not set
CONFIG_CHROME_PLATFORMS=3Dy
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CROS_HPS_I2C is not set
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=3Dy
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_ARM64_PLATFORM_DEVICES=3Dy
# CONFIG_EC_ACER_ASPIRE1 is not set
CONFIG_HAVE_CLK=3Dy
CONFIG_HAVE_CLK_PREPARE=3Dy
CONFIG_COMMON_CLK=3Dy

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
CONFIG_CLK_VEXPRESS_OSC=3Dy
# end of Clock driver for ARM Reference designs

# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SCMI=3Dy
CONFIG_COMMON_CLK_SI5341=3Dy
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
CONFIG_COMMON_CLK_FSL_SAI=3Dy
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=3Dy
CONFIG_CLK_LS1028A_PLLDIG=3Dy
CONFIG_COMMON_CLK_XGENE=3Dy
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_SI521XX is not set
# CONFIG_COMMON_CLK_VC3 is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_VC7 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_BCM2711_DVP=3Dy
CONFIG_CLK_BCM2835=3Dy
CONFIG_CLK_RASPBERRYPI=3Dy
CONFIG_COMMON_CLK_HI3516CV300=3Dy
CONFIG_COMMON_CLK_HI3519=3Dy
CONFIG_COMMON_CLK_HI3559A=3Dy
CONFIG_COMMON_CLK_HI3660=3Dy
CONFIG_COMMON_CLK_HI3670=3Dy
CONFIG_COMMON_CLK_HI3798CV200=3Dy
CONFIG_COMMON_CLK_HI6220=3Dy
CONFIG_RESET_HISI=3Dy
CONFIG_STUB_CLK_HI6220=3Dy
CONFIG_STUB_CLK_HI3660=3Dy
CONFIG_MXC_CLK=3Dy
CONFIG_CLK_IMX8MM=3Dy
CONFIG_CLK_IMX8MN=3Dy
CONFIG_CLK_IMX8MP=3Dy
CONFIG_CLK_IMX8MQ=3Dy
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set
# CONFIG_CLK_IMX95_BLK_CTL is not set
CONFIG_TI_SCI_CLK=3Dy
# CONFIG_TI_SCI_CLK_PROBE_FROM_FW is not set
CONFIG_TI_SYSCON_CLK=3Dy

#
# Clock support for Amlogic platforms
#
CONFIG_COMMON_CLK_MESON_REGMAP=3Dy
CONFIG_COMMON_CLK_MESON_DUALDIV=3Dy
CONFIG_COMMON_CLK_MESON_MPLL=3Dy
CONFIG_COMMON_CLK_MESON_PLL=3Dy
CONFIG_COMMON_CLK_MESON_VID_PLL_DIV=3Dy
CONFIG_COMMON_CLK_MESON_VCLK=3Dy
CONFIG_COMMON_CLK_MESON_CLKC_UTILS=3Dy
CONFIG_COMMON_CLK_MESON_AO_CLKC=3Dy
CONFIG_COMMON_CLK_MESON_EE_CLKC=3Dy
CONFIG_COMMON_CLK_MESON_CPU_DYNDIV=3Dy
CONFIG_COMMON_CLK_GXBB=3Dy
CONFIG_COMMON_CLK_AXG=3Dy
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# CONFIG_COMMON_CLK_A1_PLL is not set
# CONFIG_COMMON_CLK_A1_PERIPHERALS is not set
CONFIG_COMMON_CLK_G12A=3Dy
CONFIG_COMMON_CLK_S4_PLL=3Dy
CONFIG_COMMON_CLK_S4_PERIPHERALS=3Dy
# end of Clock support for Amlogic platforms

CONFIG_ARMADA_AP_CP_HELPER=3Dy
CONFIG_ARMADA_37XX_CLK=3Dy
CONFIG_ARMADA_AP806_SYSCON=3Dy
CONFIG_ARMADA_CP110_SYSCON=3Dy
CONFIG_QCOM_GDSC=3Dy
CONFIG_COMMON_CLK_QCOM=3Dy
# CONFIG_CLK_X1E80100_CAMCC is not set
# CONFIG_CLK_X1E80100_DISPCC is not set
# CONFIG_CLK_X1E80100_GCC is not set
# CONFIG_CLK_X1E80100_GPUCC is not set
# CONFIG_CLK_X1E80100_TCSRCC is not set
# CONFIG_QCOM_A53PLL is not set
# CONFIG_QCOM_A7PLL is not set
# CONFIG_QCOM_CLK_APCC_MSM8996 is not set
CONFIG_QCOM_CLK_RPMH=3Dy
# CONFIG_IPQ_APSS_PLL is not set
# CONFIG_IPQ_GCC_4019 is not set
# CONFIG_IPQ_GCC_5018 is not set
# CONFIG_IPQ_GCC_5332 is not set
# CONFIG_IPQ_GCC_6018 is not set
# CONFIG_IPQ_GCC_8074 is not set
# CONFIG_IPQ_GCC_9574 is not set
CONFIG_MSM_GCC_8916=3Dy
# CONFIG_MSM_GCC_8917 is not set
# CONFIG_MSM_GCC_8939 is not set
# CONFIG_MSM_GCC_8953 is not set
# CONFIG_MSM_GCC_8976 is not set
# CONFIG_MSM_MMCC_8994 is not set
# CONFIG_MSM_GCC_8994 is not set
CONFIG_MSM_GCC_8996=3Dy
CONFIG_MSM_MMCC_8996=3Dy
# CONFIG_MSM_GCC_8998 is not set
# CONFIG_MSM_GPUCC_8998 is not set
# CONFIG_MSM_MMCC_8998 is not set
# CONFIG_QCM_GCC_2290 is not set
# CONFIG_QCM_DISPCC_2290 is not set
# CONFIG_QCS_GCC_404 is not set
# CONFIG_SC_CAMCC_7180 is not set
# CONFIG_SC_CAMCC_7280 is not set
# CONFIG_SC_CAMCC_8280XP is not set
# CONFIG_SC_DISPCC_7180 is not set
# CONFIG_SC_DISPCC_7280 is not set
# CONFIG_SC_DISPCC_8280XP is not set
# CONFIG_SA_GCC_8775P is not set
# CONFIG_SA_GPUCC_8775P is not set
# CONFIG_SC_GCC_7180 is not set
# CONFIG_SC_GCC_7280 is not set
# CONFIG_SC_GCC_8180X is not set
# CONFIG_SC_GCC_8280XP is not set
# CONFIG_SC_GPUCC_7180 is not set
# CONFIG_SC_GPUCC_7280 is not set
# CONFIG_SC_GPUCC_8280XP is not set
# CONFIG_SC_LPASSCC_7280 is not set
# CONFIG_SC_LPASSCC_8280XP is not set
# CONFIG_SC_LPASS_CORECC_7180 is not set
# CONFIG_SC_LPASS_CORECC_7280 is not set
# CONFIG_SC_VIDEOCC_7180 is not set
# CONFIG_SC_VIDEOCC_7280 is not set
# CONFIG_SDM_CAMCC_845 is not set
# CONFIG_SDM_GCC_660 is not set
# CONFIG_SDM_MMCC_660 is not set
# CONFIG_SDM_GPUCC_660 is not set
# CONFIG_QCS_TURING_404 is not set
# CONFIG_QCS_Q6SSTOP_404 is not set
# CONFIG_QDU_GCC_1000 is not set
# CONFIG_QDU_ECPRICC_1000 is not set
CONFIG_SDM_GCC_845=3Dy
# CONFIG_SDM_GPUCC_845 is not set
# CONFIG_SDM_VIDEOCC_845 is not set
# CONFIG_SDM_DISPCC_845 is not set
# CONFIG_SDM_LPASSCC_845 is not set
# CONFIG_SDX_GCC_75 is not set
# CONFIG_SM_CAMCC_6350 is not set
# CONFIG_SM_CAMCC_8250 is not set
# CONFIG_SM_CAMCC_8450 is not set
# CONFIG_SM_CAMCC_8550 is not set
# CONFIG_SM_DISPCC_8650 is not set
# CONFIG_SM_GCC_4450 is not set
# CONFIG_SM_GCC_6115 is not set
# CONFIG_SM_GCC_6125 is not set
# CONFIG_SM_GCC_6350 is not set
# CONFIG_SM_GCC_6375 is not set
# CONFIG_SM_GCC_7150 is not set
# CONFIG_SM_GCC_8150 is not set
# CONFIG_SM_GCC_8250 is not set
# CONFIG_SM_GCC_8350 is not set
# CONFIG_SM_GCC_8450 is not set
# CONFIG_SM_GCC_8550 is not set
# CONFIG_SM_GCC_8650 is not set
# CONFIG_SM_GPUCC_6115 is not set
# CONFIG_SM_GPUCC_6125 is not set
# CONFIG_SM_GPUCC_6375 is not set
# CONFIG_SM_GPUCC_6350 is not set
# CONFIG_SM_GPUCC_8150 is not set
# CONFIG_SM_GPUCC_8250 is not set
# CONFIG_SM_GPUCC_8350 is not set
# CONFIG_SM_GPUCC_8450 is not set
# CONFIG_SM_GPUCC_8550 is not set
# CONFIG_SM_GPUCC_8650 is not set
# CONFIG_SM_TCSRCC_8550 is not set
# CONFIG_SM_TCSRCC_8650 is not set
# CONFIG_SM_VIDEOCC_8150 is not set
# CONFIG_SM_VIDEOCC_8250 is not set
# CONFIG_SM_VIDEOCC_8350 is not set
# CONFIG_SM_VIDEOCC_8550 is not set
# CONFIG_SPMI_PMIC_CLKDIV is not set
CONFIG_QCOM_HFPLL=3Dy
# CONFIG_KPSS_XCC is not set
# CONFIG_CLK_GFM_LPASS_SM8250 is not set
# CONFIG_SM_VIDEOCC_8450 is not set
CONFIG_CLK_RENESAS=3Dy
CONFIG_CLK_R8A774A1=3Dy
CONFIG_CLK_RCAR_CPG_LIB=3Dy
CONFIG_CLK_RCAR_GEN3_CPG=3Dy
# CONFIG_CLK_RCAR_USB2_CLOCK_SEL is not set
CONFIG_CLK_RENESAS_CPG_MSSR=3Dy
CONFIG_CLK_RENESAS_DIV6=3Dy
CONFIG_COMMON_CLK_ROCKCHIP=3Dy
CONFIG_CLK_PX30=3Dy
CONFIG_CLK_RK3308=3Dy
CONFIG_CLK_RK3328=3Dy
CONFIG_CLK_RK3368=3Dy
CONFIG_CLK_RK3399=3Dy
CONFIG_CLK_RK3568=3Dy
CONFIG_CLK_RK3588=3Dy
CONFIG_SUNXI_CCU=3Dy
CONFIG_SUN50I_A64_CCU=3Dy
CONFIG_SUN50I_A100_CCU=3Dy
CONFIG_SUN50I_A100_R_CCU=3Dy
CONFIG_SUN50I_H6_CCU=3Dy
CONFIG_SUN50I_H616_CCU=3Dy
CONFIG_SUN50I_H6_R_CCU=3Dy
CONFIG_SUN6I_RTC_CCU=3Dy
CONFIG_SUN8I_H3_CCU=3Dy
CONFIG_SUN8I_DE2_CCU=3Dy
CONFIG_SUN8I_R_CCU=3Dy
CONFIG_TEGRA_CLK_DFLL=3Dy
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_COMMON_CLK_ZYNQMP=3Dy
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=3Dy
CONFIG_TIMER_ACPI=3Dy
CONFIG_TIMER_PROBE=3Dy
CONFIG_CLKSRC_MMIO=3Dy
CONFIG_OMAP_DM_TIMER=3Dy
CONFIG_ROCKCHIP_TIMER=3Dy
CONFIG_SUN4I_TIMER=3Dy
CONFIG_TEGRA_TIMER=3Dy
# CONFIG_TEGRA186_TIMER is not set
CONFIG_ARM_ARCH_TIMER=3Dy
CONFIG_ARM_ARCH_TIMER_EVTSTREAM=3Dy
CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND=3Dy
CONFIG_FSL_ERRATUM_A008585=3Dy
CONFIG_HISILICON_ERRATUM_161010101=3Dy
CONFIG_ARM64_ERRATUM_858921=3Dy
CONFIG_SUN50I_ERRATUM_UNKNOWN1=3Dy
CONFIG_ARM_TIMER_SP804=3Dy
CONFIG_SYS_SUPPORTS_SH_CMT=3Dy
CONFIG_SYS_SUPPORTS_SH_TMU=3Dy
CONFIG_SH_TIMER_CMT=3Dy
# CONFIG_RENESAS_OSTM is not set
CONFIG_SH_TIMER_TMU=3Dy
CONFIG_TIMER_IMX_SYS_CTR=3Dy
# end of Clock Source drivers

CONFIG_MAILBOX=3Dy
# CONFIG_ARM_MHU is not set
# CONFIG_ARM_MHU_V2 is not set
# CONFIG_ARM_MHU_V3 is not set
# CONFIG_IMX_MBOX is not set
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PL320_MBOX is not set
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
CONFIG_OMAP2PLUS_MBOX=3Dy
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_PCC=3Dy
# CONFIG_ALTERA_MBOX is not set
CONFIG_BCM2835_MBOX=3Dy
CONFIG_TI_MESSAGE_MANAGER=3Dy
CONFIG_HI3660_MBOX=3Dy
CONFIG_HI6220_MBOX=3Dy
# CONFIG_MAILBOX_TEST is not set
# CONFIG_QCOM_APCS_IPC is not set
# CONFIG_TEGRA_HSP_MBOX is not set
# CONFIG_XGENE_SLIMPRO_MBOX is not set
CONFIG_ZYNQMP_IPI_MBOX=3Dy
CONFIG_SUN6I_MSGBOX=3Dy
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_IOVA=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=3Dy
CONFIG_IOMMU_IO_PGTABLE_LPAE=3Dy
# CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST is not set
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
# CONFIG_IOMMU_IO_PGTABLE_DART is not set
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=3Dy
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=3Dy
CONFIG_IOMMU_DMA=3Dy
# CONFIG_IOMMUFD is not set
CONFIG_ROCKCHIP_IOMMU=3Dy
# CONFIG_SUN50I_IOMMU is not set
CONFIG_TEGRA_IOMMU_SMMU=3Dy
# CONFIG_IPMMU_VMSA is not set
CONFIG_ARM_SMMU=3Dy
# CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS is not set
CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=3Dy
CONFIG_ARM_SMMU_QCOM=3Dy
# CONFIG_ARM_SMMU_QCOM_DEBUG is not set
CONFIG_ARM_SMMU_V3=3Dy
# CONFIG_ARM_SMMU_V3_SVA is not set
CONFIG_QCOM_IOMMU=3Dy
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=3Dy
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_IMX_REMOTEPROC is not set
# CONFIG_IMX_DSP_REMOTEPROC is not set
# CONFIG_RCAR_REMOTEPROC is not set
# CONFIG_TI_K3_DSP_REMOTEPROC is not set
# CONFIG_TI_K3_R5_REMOTEPROC is not set
# CONFIG_XLNX_R5_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
CONFIG_MESON_CLK_MEASURE=3Dy
CONFIG_MESON_GX_SOCINFO=3Dy
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_FSL_DPAA is not set
# CONFIG_QUICC_ENGINE is not set
# CONFIG_FSL_MC_DPIO is not set
# CONFIG_DPAA2_CONSOLE is not set
# CONFIG_FSL_RCPM is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# CONFIG_A64FX_DIAG is not set
# end of fujitsu SoC drivers

#
# Hisilicon SoC drivers
#
# CONFIG_KUNPENG_HCCS is not set
# end of Hisilicon SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=3Dy
CONFIG_SOC_IMX9=3Dy
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_AOSS_QMP=3Dy
CONFIG_QCOM_COMMAND_DB=3Dy
CONFIG_QCOM_GENI_SE=3Dy
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_KRYO_L2_ACCESSORS=3Dy
# CONFIG_QCOM_OCMEM is not set
# CONFIG_QCOM_RAMP_CTRL is not set
# CONFIG_QCOM_RMTFS_MEM is not set
# CONFIG_QCOM_RPM_MASTER_STATS is not set
CONFIG_QCOM_RPMH=3Dy
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_ICC_BWMON is not set
# CONFIG_QCOM_PBS is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=3Dy
CONFIG_ARCH_RCAR_GEN3=3Dy
# CONFIG_ARCH_R8A77995 is not set
# CONFIG_ARCH_R8A77990 is not set
# CONFIG_ARCH_R8A77951 is not set
# CONFIG_ARCH_R8A77965 is not set
# CONFIG_ARCH_R8A77960 is not set
# CONFIG_ARCH_R8A77961 is not set
# CONFIG_ARCH_R8A779F0 is not set
# CONFIG_ARCH_R8A77980 is not set
# CONFIG_ARCH_R8A77970 is not set
# CONFIG_ARCH_R8A779A0 is not set
# CONFIG_ARCH_R8A779G0 is not set
# CONFIG_ARCH_R8A779H0 is not set
# CONFIG_ARCH_R8A774C0 is not set
# CONFIG_ARCH_R8A774E1 is not set
CONFIG_ARCH_R8A774A1=3Dy
# CONFIG_ARCH_R8A774B1 is not set
# CONFIG_ARCH_R9A07G043 is not set
# CONFIG_ARCH_R9A07G044 is not set
# CONFIG_ARCH_R9A07G054 is not set
# CONFIG_ARCH_R9A08G045 is not set
# CONFIG_ARCH_R9A09G011 is not set
# CONFIG_ARCH_R9A09G057 is not set
CONFIG_RST_RCAR=3Dy
CONFIG_ROCKCHIP_GRF=3Dy
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_SUNXI_MBUS=3Dy
CONFIG_SUNXI_SRAM=3Dy
CONFIG_ARCH_TEGRA_132_SOC=3Dy
CONFIG_ARCH_TEGRA_210_SOC=3Dy
# CONFIG_ARCH_TEGRA_186_SOC is not set
# CONFIG_ARCH_TEGRA_194_SOC is not set
# CONFIG_ARCH_TEGRA_234_SOC is not set
# CONFIG_ARCH_TEGRA_241_SOC is not set
CONFIG_SOC_TEGRA_FUSE=3Dy
CONFIG_SOC_TEGRA_FLOWCTRL=3Dy
CONFIG_SOC_TEGRA_PMC=3Dy
CONFIG_SOC_TI=3Dy
CONFIG_TI_K3_RINGACC=3Dy
CONFIG_TI_K3_SOCINFO=3Dy
# CONFIG_TI_PRUSS is not set
CONFIG_TI_SCI_INTA_MSI_DOMAIN=3Dy

#
# Xilinx SoC drivers
#
CONFIG_ZYNQMP_POWER=3Dy
CONFIG_XLNX_EVENT_MANAGER=3Dy
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
CONFIG_MESON_GX_PM_DOMAINS=3Dy
CONFIG_MESON_EE_PM_DOMAINS=3Dy
CONFIG_MESON_SECURE_PM_DOMAINS=3Dy
# end of Amlogic PM Domains

CONFIG_ARM_SCMI_PERF_DOMAIN=3Dy
CONFIG_ARM_SCMI_POWER_DOMAIN=3Dy

#
# Broadcom PM Domains
#
CONFIG_BCM2835_POWER=3Dy
CONFIG_RASPBERRYPI_POWER=3Dy
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
CONFIG_IMX_GPCV2_PM_DOMAINS=3Dy
CONFIG_IMX8M_BLK_CTRL=3Dy
CONFIG_IMX9_BLK_CTRL=3Dy
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# CONFIG_QCOM_CPR is not set
CONFIG_QCOM_RPMHPD=3Dy
# end of Qualcomm PM Domains

CONFIG_SYSC_RCAR=3Dy
CONFIG_SYSC_R8A774A1=3Dy
CONFIG_ROCKCHIP_PM_DOMAINS=3Dy
# CONFIG_SUN20I_PPU is not set
CONFIG_TI_SCI_PM_DOMAINS=3Dy
CONFIG_ZYNQMP_PM_DOMAINS=3Dy
# end of PM Domains

CONFIG_PM_DEVFREQ=3Dy

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX8M_DDRC_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_RK3399_DMC_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=3Dy
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=3Dy

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=3Dy
# CONFIG_ARM_PL172_MPMC is not set
# CONFIG_OMAP_GPMC is not set
# CONFIG_RENESAS_RPCIF is not set
CONFIG_TEGRA_MC=3Dy
# CONFIG_TEGRA210_EMC is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=3Dy
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_HIBVT is not set
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=3Dy
CONFIG_ARM_GIC=3Dy
CONFIG_ARM_GIC_PM=3Dy
CONFIG_ARM_GIC_MAX_NR=3D1
CONFIG_ARM_GIC_V2M=3Dy
CONFIG_ARM_GIC_V3=3Dy
CONFIG_ARM_GIC_V3_ITS=3Dy
CONFIG_ARM_GIC_V3_ITS_PCI=3Dy
CONFIG_ARM_GIC_V3_ITS_FSL_MC=3Dy
# CONFIG_AL_FIC is not set
CONFIG_BRCMSTB_L2_IRQ=3Dy
CONFIG_HISILICON_IRQ_MBIGEN=3Dy
CONFIG_RENESAS_IRQC=3Dy
CONFIG_SL28CPLD_INTC=3Dy
CONFIG_SUN6I_R_INTC=3Dy
CONFIG_SUNXI_NMI_INTC=3Dy
# CONFIG_XILINX_INTC is not set
CONFIG_IMX_GPCV2=3Dy
CONFIG_MVEBU_GICP=3Dy
CONFIG_MVEBU_ICU=3Dy
CONFIG_MVEBU_ODMI=3Dy
CONFIG_MVEBU_PIC=3Dy
CONFIG_MVEBU_SEI=3Dy
CONFIG_LS_EXTIRQ=3Dy
CONFIG_LS_SCFG_MSI=3Dy
CONFIG_PARTITION_PERCPU=3Dy
CONFIG_QCOM_IRQ_COMBINER=3Dy
CONFIG_MESON_IRQ_GPIO=3Dy
CONFIG_QCOM_PDC=3Dy
# CONFIG_QCOM_MPM is not set
CONFIG_IMX_IRQSTEER=3Dy
CONFIG_IMX_INTMUX=3Dy
# CONFIG_IMX_MU_MSI is not set
CONFIG_TI_SCI_INTR_IRQCHIP=3Dy
CONFIG_TI_SCI_INTA_IRQCHIP=3Dy
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_ARCH_HAS_RESET_CONTROLLER=3Dy
CONFIG_RESET_CONTROLLER=3Dy
# CONFIG_RESET_GPIO is not set
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_MESON=3Dy
# CONFIG_RESET_MESON_AUDIO_ARB is not set
CONFIG_RESET_QCOM_AOSS=3Dy
# CONFIG_RESET_QCOM_PDC is not set
# CONFIG_RESET_RASPBERRYPI is not set
CONFIG_RESET_SCMI=3Dy
CONFIG_RESET_SIMPLE=3Dy
CONFIG_RESET_SUNXI=3Dy
CONFIG_RESET_TI_SCI=3Dy
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set
CONFIG_COMMON_RESET_HI3660=3Dy
CONFIG_COMMON_RESET_HI6220=3Dy

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=3Dy
CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
CONFIG_PHY_XGENE=3Dm
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN4I_USB is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8B_USB2 is not set
CONFIG_PHY_MESON_GXL_USB2=3Dy
CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG=3Dy
CONFIG_PHY_MESON_G12A_USB2=3Dy
CONFIG_PHY_MESON_G12A_USB3_PCIE=3Dy
CONFIG_PHY_MESON_AXG_PCIE=3Dy
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=3Dy
CONFIG_PHY_MESON_AXG_MIPI_DPHY=3Dy

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_MVEBU_A3700_COMPHY is not set
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_UTMI is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_QCOM_APQ8064_SATA is not set
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_IPQ806X_SATA is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_SNPS_EUSB2 is not set
# CONFIG_PHY_QCOM_EUSB2_REPEATER is not set
# CONFIG_PHY_QCOM_M31_USB is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
# CONFIG_PHY_QCOM_SGMII_ETH is not set
# CONFIG_PHY_R8A779F0_ETHERNET_SERDES is not set
# CONFIG_PHY_RCAR_GEN2 is not set
# CONFIG_PHY_RCAR_GEN3_PCIE is not set
# CONFIG_PHY_RCAR_GEN3_USB2 is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DP is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_EMMC is not set
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_ROCKCHIP_USB is not set
# CONFIG_PHY_TEGRA_XUSB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
# CONFIG_OMAP_USB2 is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_ARM_CCI_PMU=3Dy
CONFIG_ARM_CCI400_PMU=3Dy
CONFIG_ARM_CCI5xx_PMU=3Dy
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
CONFIG_ARM_PMU=3Dy
CONFIG_ARM_PMU_ACPI=3Dy
# CONFIG_ARM_SMMU_V3_PMU is not set
CONFIG_ARM_PMUV3=3Dy
# CONFIG_ARM_DSU_PMU is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_FSL_IMX9_DDR_PMU is not set
CONFIG_QCOM_L2_PMU=3Dy
CONFIG_QCOM_L3_PMU=3Dy
# CONFIG_THUNDERX2_PMU is not set
CONFIG_XGENE_PMU=3Dy
# CONFIG_ARM_SPE_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
CONFIG_HISI_PMU=3Dy
# CONFIG_HISI_PCIE_PMU is not set
# CONFIG_HNS3_PMU is not set
# CONFIG_MARVELL_CN10K_DDR_PMU is not set
# CONFIG_DWC_PCIE_PMU is not set
# CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is not set
# CONFIG_MESON_DDR_PMU is not set
# CONFIG_CXL_PMU is not set
# end of Performance monitor support

CONFIG_RAS=3Dy
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=3Dm
# CONFIG_DEV_DAX is not set
# CONFIG_DEV_DAX_HMEM is not set
CONFIG_NVMEM=3Dy
CONFIG_NVMEM_SYSFS=3Dy
CONFIG_NVMEM_LAYOUTS=3Dy

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_IMX_OCOTP_ELE is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_MESON_EFUSE is not set
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_QCOM_QFPROM is not set
# CONFIG_NVMEM_QCOM_SEC_QFPROM is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_NVMEM_SUNXI_SID is not set
# CONFIG_NVMEM_ZYNQMP is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# CONFIG_HISI_PTT is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=3Dy
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=3Dy
# CONFIG_INTERCONNECT_IMX is not set
CONFIG_INTERCONNECT_QCOM=3Dy
CONFIG_INTERCONNECT_QCOM_BCM_VOTER=3Dy
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_QCOM_QDU1000 is not set
CONFIG_INTERCONNECT_QCOM_RPMH_POSSIBLE=3Dy
CONFIG_INTERCONNECT_QCOM_RPMH=3Dy
# CONFIG_INTERCONNECT_QCOM_SA8775P is not set
# CONFIG_INTERCONNECT_QCOM_SC7180 is not set
# CONFIG_INTERCONNECT_QCOM_SC7280 is not set
# CONFIG_INTERCONNECT_QCOM_SC8180X is not set
# CONFIG_INTERCONNECT_QCOM_SC8280XP is not set
# CONFIG_INTERCONNECT_QCOM_SDM670 is not set
CONFIG_INTERCONNECT_QCOM_SDM845=3Dy
# CONFIG_INTERCONNECT_QCOM_SDX55 is not set
# CONFIG_INTERCONNECT_QCOM_SDX65 is not set
# CONFIG_INTERCONNECT_QCOM_SDX75 is not set
# CONFIG_INTERCONNECT_QCOM_SM6350 is not set
# CONFIG_INTERCONNECT_QCOM_SM7150 is not set
# CONFIG_INTERCONNECT_QCOM_SM8150 is not set
# CONFIG_INTERCONNECT_QCOM_SM8250 is not set
# CONFIG_INTERCONNECT_QCOM_SM8350 is not set
# CONFIG_INTERCONNECT_QCOM_SM8450 is not set
# CONFIG_INTERCONNECT_QCOM_SM8550 is not set
# CONFIG_INTERCONNECT_QCOM_SM8650 is not set
# CONFIG_INTERCONNECT_QCOM_X1E80100 is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# CONFIG_CDX_BUS is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=3Dy
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=3Dy
CONFIG_FS_STACK=3Dy
CONFIG_BUFFER_HEAD=3Dy
CONFIG_LEGACY_DIRECT_IO=3Dy
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_BCACHEFS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_EXPORTFS_BLOCK_OPS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FS_ENCRYPTION=3Dy
CONFIG_FS_ENCRYPTION_ALGS=3Dm
CONFIG_FS_VERITY=3Dy
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_FUSE_FS=3Dm
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_FUSE_PASSTHROUGH=3Dy
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
CONFIG_FAT_DEFAULT_UTF8=3Dy
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS3_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_VMCORE=3Dy
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_PROC_CHILDREN=3Dy
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_TMPFS_INODE64=3Dy
# CONFIG_TMPFS_QUOTA is not set
CONFIG_ARCH_SUPPORTS_HUGETLBFS=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm
CONFIG_EFIVAR_FS=3Dm
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=3Dy
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
CONFIG_PSTORE_COMPRESS=3Dy
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_SMB_SERVER is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=3Dm
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=3Dy
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=3Dy
# end of File systems

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=3Dy
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=3Dy
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=3Dy
CONFIG_SECURITY_DMESG_RESTRICT=3Dy
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_PATH=3Dy
CONFIG_LSM_MMAP_MIN_ADDR=3D32768
CONFIG_HARDENED_USERCOPY=3Dy
CONFIG_FORTIFY_SOURCE=3Dy
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=3Dy
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
# CONFIG_SECURITY_SELINUX_DEBUG is not set
# CONFIG_SECURITY_SMACK is not set
CONFIG_SECURITY_TOMOYO=3Dy
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/init"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=3Dy
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=3Dy
CONFIG_SECURITY_APPARMOR_HASH=3Dy
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=3Dy
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=3Dy
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=3Dy
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=3Dy
CONFIG_INTEGRITY=3Dy
CONFIG_INTEGRITY_SIGNATURE=3Dy
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
# CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy
CONFIG_INTEGRITY_MACHINE_KEYRING=3Dy
# CONFIG_INTEGRITY_CA_MACHINE_KEYRING is not set
CONFIG_LOAD_UEFI_KEYS=3Dy
CONFIG_INTEGRITY_AUDIT=3Dy
CONFIG_IMA=3Dy
CONFIG_IMA_MEASURE_PCR_IDX=3D10
CONFIG_IMA_LSM_RULES=3Dy
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=3Dy
CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-sig"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
CONFIG_IMA_DEFAULT_HASH=3D"sha256"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=3Dy
CONFIG_IMA_ARCH_POLICY=3Dy
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
# CONFIG_IMA_APPRAISE_MODSIG is not set
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=3Dy
CONFIG_EVM_ATTR_FSUUID=3Dy
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=3Dy
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor=
,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=3Dy
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=3Dy
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=3Dy
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=3Dy
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=3Dy
CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=3Dy
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_SIG=3Dy
CONFIG_CRYPTO_SIG2=3Dy
CONFIG_CRYPTO_SKCIPHER=3Dy
CONFIG_CRYPTO_SKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_AKCIPHER2=3Dy
CONFIG_CRYPTO_AKCIPHER=3Dy
CONFIG_CRYPTO_KPP2=3Dy
CONFIG_CRYPTO_KPP=3Dy
CONFIG_CRYPTO_ACOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=3Dy
CONFIG_CRYPTO_DH=3Dy
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=3Dy
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=3Dy
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_HMAC=3Dy
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dy
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=3Dm
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_SHA3=3Dm
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=3Dm
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=3Dm
CONFIG_CRYPTO_CRC64_ROCKSOFT=3Dm
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_LZO=3Dy
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_JITTERENTROPY is not set
CONFIG_CRYPTO_KDF800108_CTR=3Dy
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=3Dy
# CONFIG_CRYPTO_NHPOLY1305_NEON is not set
# CONFIG_CRYPTO_CHACHA20_NEON is not set

#
# Accelerated Cryptographic Algorithms for CPU (arm64)
#
CONFIG_CRYPTO_GHASH_ARM64_CE=3Dm
# CONFIG_CRYPTO_POLY1305_NEON is not set
CONFIG_CRYPTO_SHA1_ARM64_CE=3Dm
CONFIG_CRYPTO_SHA256_ARM64=3Dm
CONFIG_CRYPTO_SHA2_ARM64_CE=3Dm
CONFIG_CRYPTO_SHA512_ARM64=3Dm
CONFIG_CRYPTO_SHA512_ARM64_CE=3Dm
CONFIG_CRYPTO_SHA3_ARM64=3Dm
# CONFIG_CRYPTO_SM3_NEON is not set
# CONFIG_CRYPTO_SM3_ARM64_CE is not set
CONFIG_CRYPTO_POLYVAL_ARM64_CE=3Dm
# CONFIG_CRYPTO_AES_ARM64 is not set
CONFIG_CRYPTO_AES_ARM64_CE=3Dm
CONFIG_CRYPTO_AES_ARM64_CE_BLK=3Dm
# CONFIG_CRYPTO_AES_ARM64_NEON_BLK is not set
# CONFIG_CRYPTO_AES_ARM64_BS is not set
# CONFIG_CRYPTO_SM4_ARM64_CE is not set
# CONFIG_CRYPTO_SM4_ARM64_CE_BLK is not set
# CONFIG_CRYPTO_SM4_ARM64_NEON_BLK is not set
# CONFIG_CRYPTO_AES_ARM64_CE_CCM is not set
# CONFIG_CRYPTO_SM4_ARM64_CE_CCM is not set
# CONFIG_CRYPTO_SM4_ARM64_CE_GCM is not set
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=3Dm
# end of Accelerated Cryptographic Algorithms for CPU (arm64)

CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_ALLWINNER=3Dy
# CONFIG_CRYPTO_DEV_SUN4I_SS is not set
# CONFIG_CRYPTO_DEV_SUN8I_CE is not set
# CONFIG_CRYPTO_DEV_SUN8I_SS is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM is not set
# CONFIG_CRYPTO_DEV_SAHARA is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_MXS_DCP is not set
# CONFIG_CAVIUM_CPT is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_MARVELL_CESA is not set
# CONFIG_CRYPTO_DEV_OCTEONTX_CPT is not set
# CONFIG_CRYPTO_DEV_OCTEONTX2_CPT is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_420XX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_CAVIUM_ZIP is not set
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_ROCKCHIP is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_HISI_SEC2 is not set
# CONFIG_CRYPTO_DEV_HISI_ZIP is not set
# CONFIG_CRYPTO_DEV_HISI_HPRE is not set
# CONFIG_CRYPTO_DEV_HISI_TRNG is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_CRYPTO_DEV_SA2UL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
CONFIG_X509_CERTIFICATE_PARSER=3Dy
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=3Dy
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy
CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
CONFIG_SYSTEM_TRUSTED_KEYS=3D""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
# CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_LINEAR_RANGES=3Dy
CONFIG_PACKING=3Dy
CONFIG_BITREVERSE=3Dy
CONFIG_HAVE_ARCH_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
# CONFIG_CORDIC is not set
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=3Dy
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
CONFIG_INDIRECT_PIO=3Dy
# CONFIG_TRACE_MMIO_ACCESS is not set

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=3Dy
CONFIG_CRYPTO_LIB_AES=3Dy
CONFIG_CRYPTO_LIB_GF128MUL=3Dm
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D9
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=3Dy
CONFIG_CRYPTO_LIB_SHA256=3Dy
# end of Crypto library routines

CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dm
CONFIG_CRC_T10DIF=3Dm
CONFIG_CRC64_ROCKSOFT=3Dm
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=3Dm
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=3Dy
CONFIG_XXHASH=3Dy
CONFIG_AUDIT_GENERIC=3Dy
CONFIG_AUDIT_ARCH_COMPAT_GENERIC=3Dy
CONFIG_AUDIT_COMPAT_GENERIC=3Dy
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_LZ4_DECOMPRESS=3Dy
CONFIG_ZSTD_COMMON=3Dy
CONFIG_ZSTD_COMPRESS=3Dy
CONFIG_ZSTD_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_DECOMPRESS_LZ4=3Dy
CONFIG_DECOMPRESS_ZSTD=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_INTERVAL_TREE=3Dy
CONFIG_XARRAY_MULTI=3Dy
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_DMA_OPS=3Dy
CONFIG_NEED_SG_DMA_FLAGS=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_DMA_DECLARE_COHERENT=3Dy
CONFIG_ARCH_HAS_SETUP_DMA_OPS=3Dy
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=3Dy
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=3Dy
CONFIG_ARCH_HAS_DMA_PREP_COHERENT=3Dy
CONFIG_SWIOTLB=3Dy
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC=3Dy
CONFIG_DMA_NEED_SYNC=3Dy
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_NONCOHERENT_MMAP=3Dy
CONFIG_DMA_COHERENT_POOL=3Dy
CONFIG_DMA_DIRECT_REMAP=3Dy
CONFIG_DMA_CMA=3Dy
# CONFIG_DMA_NUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=3D64
CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=3D8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_GLOB=3Dy
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=3Dy
CONFIG_CLZ_TAB=3Dy
CONFIG_IRQ_POLL=3Dy
CONFIG_MPILIB=3Dy
CONFIG_SIGNATURE=3Dy
CONFIG_LIBFDT=3Dy
CONFIG_OID_REGISTRY=3Dy
CONFIG_UCS2_STRING=3Dy
CONFIG_HAVE_GENERIC_VDSO=3Dy
CONFIG_GENERIC_GETTIMEOFDAY=3Dy
CONFIG_GENERIC_VDSO_TIME_NS=3Dy
CONFIG_FONT_SUPPORT=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=3Dy
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=3Dy
CONFIG_ARCH_HAS_PMEM_API=3Dy
CONFIG_MEMREGION=3Dy
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
CONFIG_ARCH_STACKWALK=3Dy
CONFIG_STACKDEPOT=3Dy
CONFIG_STACKDEPOT_MAX_FRAMES=3D64
CONFIG_SBITMAP=3Dy
# CONFIG_LWQ_TEST is not set
# end of Library routines

CONFIG_GENERIC_IOREMAP=3Dy
CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=3Dy
CONFIG_FIRMWARE_TABLE=3Dy

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
CONFIG_BOOT_PRINTK_DELAY=3Dy
CONFIG_DYNAMIC_DEBUG=3Dy
CONFIG_DYNAMIC_DEBUG_CORE=3Dy
CONFIG_SYMBOLIC_ERRNAME=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_MISC=3Dy

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=3Dy
CONFIG_AS_HAS_NON_CONST_ULEB128=3Dy
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=3D2048
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy
CONFIG_FRAME_POINTER=3Dy
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x01b6
CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
CONFIG_DEBUG_FS=3Dy
CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN=3Dy
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=3Dy
CONFIG_HAVE_KCSAN_COMPILER=3Dy
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=3Dy
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=3Dy
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=3Dy
CONFIG_DEBUG_WX=3Dy
CONFIG_GENERIC_PTDUMP=3Dy
CONFIG_PTDUMP_CORE=3Dy
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=3Dy
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_MEM_ALLOC_PROFILING is not set
CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_HAVE_ARCH_KASAN_SW_TAGS=3Dy
CONFIG_HAVE_ARCH_KASAN_HW_TAGS=3Dy
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
CONFIG_CC_HAS_KASAN_SW_TAGS=3Dy
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=3Dy
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_PANIC_TIMEOUT=3D0
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=3Dy
CONFIG_SCHED_INFO=3Dy
CONFIG_SCHEDSTATS=3Dy
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=3Dy
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACER_MAX_TRACE=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
# CONFIG_FUNCTION_GRAPH_RETVAL is not set
CONFIG_DYNAMIC_FTRACE=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=3Dy
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=3Dy
CONFIG_TRACER_SNAPSHOT=3Dy
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_PROBE_EVENTS_BTF_ARGS=3Dy
CONFIG_KPROBE_EVENTS=3Dy
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=3Dy
CONFIG_BPF_EVENTS=3Dy
CONFIG_DYNAMIC_EVENTS=3Dy
CONFIG_PROBE_EVENTS=3Dy
CONFIG_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY=3Dy
CONFIG_TRACING_MAP=3Dy
CONFIG_SYNTH_EVENTS=3Dy
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=3Dy
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
CONFIG_STRICT_DEVMEM=3Dy
CONFIG_IO_STRICT_DEVMEM=3Dy

#
# arm64 Debugging
#
CONFIG_PID_IN_CONTEXTIDR=3Dy
# CONFIG_DEBUG_EFI is not set
# CONFIG_ARM64_RELOC_TEST is not set
# CONFIG_CORESIGHT is not set
# end of arm64 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FUNCTION_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=3Dy
CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=3Dy
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_OBJPOOL is not set
CONFIG_ARCH_USE_MEMTEST=3Dy
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--=_MailMate_0395DBC4-D8CF-45A3-B7B7-FBAC5BC9D8D2_=--

--=_MailMate_33325EA0-2D6B-47F3-B9A2-617690C62594_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmahg+cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUnJEP+wQgp5y8s+DWBKzngvbc8cZBbgk0AxZhN8E1
M8ych/hIdDOtFHmGA0ncj8R+L6rwIieehibknQU3c71JCfFG44yXB7jHn0tGYKWG
frVxDx3wON5AMJ3pMHIAIVAORIdyuUfAphLhMclej+GZexuVsYreh2Itccp47jS+
GnrKRAKfgtoB77/O2Fq0ui9eupTRTKqO5LUAGQqVUj07yAFKziPDoAcOPzWSlpm3
J9y5evrJSaVm+dQxqhHcFj6AYNdDFKzPatLQ0yAoNf0DJpMrY/5thhNC5xPUHDro
8wrplGPdqmbpjrQlvV8vxwodaJTgiuOsrBrxX99q9wZvbNEsI3LSKHflnFRwhtMW
zDDqL0Dm+CGBXrpnF+hVRmEcCDSomx7gbPiRIZPM3q3Yawg21NVkrCDDMBtOa1H4
gZHhUcO/UXWWlv4y74y379lZ1jLmElaccpz2s5fBVM+gP4cuGonpvZnK7ndQmmBM
JnvSMlZZY9zRIsYdzaQ3y9Tt21rGPfSAHyIzCOGE98CTaxmwj0IEYTksBqwNgk0W
wxse1isSB4cXHxiXz3NxsLYVt7TqigFUx8zfPFvQ2QGJyf2LIDmoB6kPNoURufeP
EFKUn3f6JMFF9IbYCXDOjvsPoEK+VAp7+x9zN5fdb0e+qAGuksFWSvmoke1BVioI
RuFd2bfz
=UPdo
-----END PGP SIGNATURE-----

--=_MailMate_33325EA0-2D6B-47F3-B9A2-617690C62594_=--

