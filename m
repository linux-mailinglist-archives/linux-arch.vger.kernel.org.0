Return-Path: <linux-arch+bounces-4014-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C28B3C67
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9148B1F232EF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4415217A;
	Fri, 26 Apr 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZ1dmQ9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U9iUGCNX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C014D452;
	Fri, 26 Apr 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147594; cv=fail; b=uUpe+iZXs3q4zNZYGHAZ1i33aj+2OrUd6GZcXi6BLtlTKIZzP11FPwLKVhhPZ/yGWsxiiSTxfTHPdJ8jcMh4VjTjdb5F76y5IwZrqxfh2zUYs3k5WGsauYU9Ee09Fl5+b/g83E1YwJ2hmAjAhXktzZq3mhy2i9a/LiEhZ5Fwxmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147594; c=relaxed/simple;
	bh=e2CufykDjIK2vUHolHRUpJ6FUBnHdQsdSydY9csxvy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LoNRf8+n+SSHp/zsi0BLpjY5pvHuAzLHBejgnokaw8CtpoKdNpLhUGhDyeqfbLyJztxQv7otixA3yTY1DhrO2xUgYWyfeaXKm3Oyltx2kGMT93c2sn/aj4hrslIIL1XhROMbfPDYdM4snezoUCv/GE2yf7li87hNm/zR0C0Hg34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZ1dmQ9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U9iUGCNX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8SwIk000487;
	Fri, 26 Apr 2024 16:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CpHAHguCcb37TLJQtHme9P6/r9xSuwvq9fdaQbakU7c=;
 b=mZ1dmQ9EkwBZLf2YtYebBx3RGPffF2PARrXwT2CDwhcr7Ql9Bx3NEClJfDy7nwS7OZLg
 lT+wFe5FuuZxbm30k+A5WSic3htlv0Z5wc3kLfVQOQXO0mz8KcOh/MAXehQy/EJRSxnF
 sHk5yM61jb9uyrNhgyET3QKv+njSbN+f+IQXqRFYwWO8DlO1LuG+JAsQnXybjc6kgoDa
 PIntT7LmuET+Ttu1BPEx9SNtIr76hgLIr5tEPkwtMtdsNy+GC6G0ZDSkRbpul01uTBfo
 PN5Lnl9pTr38UuEYOcWMlylR4jYGRejixvkGYzphzRMABx+44JWDuZ2UpAu8y+EGlcXN JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f5jbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 16:05:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QFmNNk019663;
	Fri, 26 Apr 2024 16:05:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf7uu66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 16:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnr/B4POO/04rIdAcV5sQdYak0BtchbkFPVflvoZQEQ+EqJMOBilBsIBnsMZuVht6w9BGzN6H3l0x3HVgG+p8QUkr0fZY8XsD5mLhy6koWEwidIKlNxcdUZxy15gvU73XlcAsKVgGyaIDNLCENQT8D/SCNzoA8GzYBY+hEVyEMoRvdVwGVi9zGcwysTL82jm1CReM/KunbSOWq3A8MfRNsUS6Zn1Dtm1tVuPF+ph3esbzAj5ZxGojhzHK/RT8DZIxZMG6+qzunaCBY34VAMyGPyGORl5EJV5btG9VGA/6Pzjt2jLikA5LN+YJ5Lg6bdspw8WccQTj1HMYDnz2f+STw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpHAHguCcb37TLJQtHme9P6/r9xSuwvq9fdaQbakU7c=;
 b=GSGHD+EjOGz5pFKRR0dlqAYpVB9DJCoRbsuPvVdKt9Av8t43qR6hfAnIdhKeYYXnqT9WmDG4/xbWt2TA3Lz06uZFVC4F2+mBuCwgxCm2TCaw4MlekiMzcASx8qtQ6/7uDynnBLWj702f1ZHZ+EnmwYMaroD+u4RlEQLcxUmQ9/gLObgNWmrKPBXrNIOAVfzNm8f2gnXa3aRoe1qrYYuX/9izX/pb+8d2q0P8YeDEnuBq2QNjRiaOf0OSR31brZcmtZjTYLJWQRxt+t+oj3VYAaAJ5W4UpBlaJ7INUK3nW7gplt4zC2ErmnRUMuhky/15xEu3kI2zNlR6hXUxO7w6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpHAHguCcb37TLJQtHme9P6/r9xSuwvq9fdaQbakU7c=;
 b=U9iUGCNXMTyD6dXvAqLHzhO49dqmjlGvaZdYRyqHqySoyCeu7ikpnNUbMj2N4UulnawuX684WZGHHrvUoLjs4GUVksZmgIXZhZMALMisTp/LZ5TSC4IQKwcStba10jtU8z0OPWqVuXIRum/WkhwEyirNTZoZEbPDERmHJz+O46Q=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 16:05:16 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 16:05:16 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        Russell King
	<linux@armlinux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James
 Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep
 Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
Thread-Topic: [PATCH v8 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
Thread-Index: AQHal+Dr1mTgxKWXZUKWLSudUXZBd7F6tzsA
Date: Fri, 26 Apr 2024 16:05:16 +0000
Message-ID: <6347020E-CB49-44ED-87B2-3BB2AA2F59E0@oracle.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240426135126.12802-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA1PR10MB7214:EE_
x-ms-office365-filtering-correlation-id: 47c22e6e-288c-47a6-dc23-08dc660aa9aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?yxa/RYLmQvS1/t27XzHTHVWBiLtk/bvy6mGKPOs9zYdrw/1QAVAD5JI9XoZx?=
 =?us-ascii?Q?hhUs7PjYBYEZomTMQyXBHGvFrnpalS1BaHp4QQZu2RXgkW48RNQtxsruMo9A?=
 =?us-ascii?Q?aECRiI6Oj1V8w7TrPfioSiCJCY0nVDHCPWkVMNPWomJL/8bjRfKo1ENYy5UM?=
 =?us-ascii?Q?UdD9UXl1UP+zLRCbtEGlujD1vSMCl9MnbXaD0An57FHyhIg/66cHazpbtq8j?=
 =?us-ascii?Q?8y2W4NJPzwLYRayJ9yzLaq0rlYW12Zsa+ZPEOnPR2SpcfK/jn0rIqJTJu016?=
 =?us-ascii?Q?8fhC+tDavGYRZIOjaUfL6yItSr3aRElA7ZuAXl4IjffZReCK1CmEeERrU52z?=
 =?us-ascii?Q?5SzH2HffU8xXIKhQJ8o2aXA3Tdgt6k2bTw8ObVrnB13r4uEGzPSIoPgUDopD?=
 =?us-ascii?Q?DF4kjzN7ieuQA1EwpMBfcQbv4B/0U0N8ndvxTZFANwnkJpo0lLrnPCsYSem9?=
 =?us-ascii?Q?YMoqZlqkJm0jz6EV6lqB2Kp/WxWwW/nGceZdpB1MHw6/IHnHHumZumn+8Ybz?=
 =?us-ascii?Q?gGXUbJj0utbrk4GlOF+2+pJfLHCSwJ/7IgpW8jZZwxJWprfXrUUQYdmAW0b2?=
 =?us-ascii?Q?DpiAe+C0I5HIqaGxRK1UkZtj1toHWLFKPuPs0ZBK14bXSehQM295zJDRDsaq?=
 =?us-ascii?Q?mT0/4Yk35QcoF8G+YKxnmvO3RoC1zi6QRBQGalsXzuJZi0hBxFuZM7xAjZYm?=
 =?us-ascii?Q?Dh6raae7AZCS/4a5l4s/4KqLyu/7ZUNv6fyvxFb1pZ6ZNaIkc3Hl4y983GDy?=
 =?us-ascii?Q?OLCVNd+Tm8vFVoqLn0hVG/SjDEVIwVJCsqebiUPEct7/U6w8rv1aXX0Csa/k?=
 =?us-ascii?Q?FzPAqF1MatfzH3XEi3XBpnNxV/vB9nje2iTUjXFlMy1C3j+sAwh4ixzhuKRx?=
 =?us-ascii?Q?uhzjA9gWPDdRoQHBWMxCFHN5HAabu9k1Db7Oq6lBG8r5oxZPkoLPg0whkT28?=
 =?us-ascii?Q?R8/hNrlhwu1PkVvEvycyaHAqvORdvgtD2i/5fW0g+t6kd0GGwiwjn37G1o3z?=
 =?us-ascii?Q?dcuxEV1SHsUDYhhaKbxopobu5M3Y9DCeev9OTiWRFnwLg6k80tTfru+1NVtY?=
 =?us-ascii?Q?O8nWOlZw8zgYm3f6x73SCmPDtoWeMvlIHXm8FCJhLd6nTVVmnmb/Cp3ynPxx?=
 =?us-ascii?Q?Ju5s4/9oiHGFB2jmcS8ZMkU393x4g6dH40A2FfOscVPRHlrtZDalnLYUIpOM?=
 =?us-ascii?Q?HG9OBqCYo8eeJRJI6ZaL+3AGIILPxo/w9ms68lP4VowgibVDebr5I836eHa+?=
 =?us-ascii?Q?CBbjMBa3STtywmC4Qt3vWvKS3SQlYDaPnwuAlyzCdD16jbDuIoIbLAQYUDkq?=
 =?us-ascii?Q?7XT0h/oCAME4ORfq0aL0jrWMb2xWuAxiExqxzHfyb+2Qlg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1wqTIlg3cFNKA4YLxjmMzosBl5jCfG2d3zoqpYF2kxUEp6AYkysvH2u+qJYq?=
 =?us-ascii?Q?jzHIFMAU07/6BxzL4YIQv395c6RDxfpmYV3+OMVnGX8VLQO2sTM/P9pXGAWV?=
 =?us-ascii?Q?mFzEQr+eCisY3Hpcnc5UTBPZUqicgznZJTFYCrFRNUFDhVpWoav1GL4A1k2I?=
 =?us-ascii?Q?J83R9UrNvC+95NsbRkvZtIJnv4DODpItBbpkjm1NG4TPwC84xA/tMNOSVeni?=
 =?us-ascii?Q?vz6y9GkjVdrBEPz18tArA+71mFslUwr/p2iTEDqF08iWMIJws72xpW/S6S9d?=
 =?us-ascii?Q?LOJWG501CnEZ5E7rovd28Vz1egZzIjbE/Ejy5989PxW/j+1/wM8iwYwrJth9?=
 =?us-ascii?Q?ZwKs35OZdThytKsf+k21Q3k3h4vIX6Oi1y5fqWwNRFCCVaONwzhrqv1obhl+?=
 =?us-ascii?Q?9KiJbBvijyA4Tn9ilQj3bDLvUYqqOkpjwAHArNV2vTxdWT7BYrslX7JLaFw0?=
 =?us-ascii?Q?ZbmG9l4G87IYJ03cb7Jnrs4/BwW0Se/DGK0LwB2YGzgqUsAxMp1UAWb15789?=
 =?us-ascii?Q?pd0Ce5z3HvxHR9jIhCPwaNtsratKjtG3u8LnbidwETtmHcAsOuyxTNJPKSXz?=
 =?us-ascii?Q?t+MBEGohQifukzPO3n82Fn3Ufh8rzGo6/VQHMLBjBzqaoIFhYdVP9O15iVOp?=
 =?us-ascii?Q?qmMt60WPo8JHfHqiujwHrZSPydhpZr0yOYcXcf5A57KjSB6HKoiXFsYCakhT?=
 =?us-ascii?Q?oXhOeHgjGjPQwFR64XeI7lmUyL51tVP3F0M7zU7Pab8tQ9LxRWoajPU55c98?=
 =?us-ascii?Q?DJVO2ZQvG2ad726dgkGYjeOkc/qQqr5XK14oJLXaeTnExWqwTDg3/W0pVkqs?=
 =?us-ascii?Q?ZKHz75g+395d+NqQu578OP7YwgAKIg27aUquBJ7wRKVz7qZfYElp5xNHmqvz?=
 =?us-ascii?Q?7JC8OepxbGTa5iXEr8K/JG3aGtHvvbysl2fZYhNXW9Hwr9V9t/stfF6W8LNL?=
 =?us-ascii?Q?PIJICPuDL7VYGazlk5Tshv3X87FSTI9ZuGXAmdiXN3+zjuo4lMgh2dMO6/FZ?=
 =?us-ascii?Q?Jd7az3yExgpjFS7IOo1Tzjv0tkYYrutR4T1I0Hy8cOKoCLUovTb/Q+geLxP/?=
 =?us-ascii?Q?7Jgy/mNFXmKG+ZU20a/8gTxElPSmqQwNireAmH8ki1zDdgf9+zkOa31mD0yq?=
 =?us-ascii?Q?XDV2lLQLmsSBIRL6xGtnJD51qjGBZnFPvIqCtkUa9mq5fpuavLl6CN6qi21n?=
 =?us-ascii?Q?KPCCmbvbWg2rJlO/f6OOI1X1kdCw56IzDwhVtCYZwp5fpzsB4jVCXQFMJPLO?=
 =?us-ascii?Q?fQjHj2bjUkJogUoMRpYrO/5y4ozU+df//maAU9uqS+Nsi0WWEUkViGafuoqI?=
 =?us-ascii?Q?m3B1huYPEko4sGP1hOm4X7uvXdifUvrYqeRwZaqeCG030rCAFlmwPLdzSg5x?=
 =?us-ascii?Q?vUsxDRZ0wmKKyi9HG2W43sZ+Q5YawvLZYAezs3Ppuc2UXeZsA5uecb+ZDoUZ?=
 =?us-ascii?Q?CdTB+Hly3iQySfbXPgSdsklC0w7UacKPI0f36jZsBw0Lt2wdDE+oYqeZvalN?=
 =?us-ascii?Q?gK5kDFwGjyC9Thx/R6V4V2Y/cZvzAYRED+yr0nq1cBLTVha0aJKDxlPMGFig?=
 =?us-ascii?Q?JbYbARkmWol3hE2/hu3xPUbyRpEKtZksNktSuBUO0OeyrNf8s+a+uRK+tEdn?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8408F30C4093594EBB7D49702D082FF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WBx0hzflgfJjcuWODwHr58p1iUkxMJ1pOLKc2EAvHkXwnyNymie7TGIxWhMNB6DtDRxBEwra3ZILRocNerrCRYxvdkGaQt3h9LALS9x4TNpJyxPB8Bd0ZFcGq+PMeXaZYsR6g/EWpSZU7rgmVbPrcQInRgYOAOshn12sR8zvTRckhISP8fotWiH5c+gq/WViKtkURpE+UhYs/OZb5o0XVqz8ajPYyvmNbszrSJTBS6K5TnZ4ZkRsBENUA7KT50p25/KIHUZCIRjUpZqz6tMZ0xpJXJizMXc1xt5leDTKl59b6Fs6Fg1JvDn+/WVqLg+KA0Jf3sHoQgegmlTctC1sfz95uZsTBA7XLQQ+bDDc+Qsl8hnu1E4PJLlHwxkFDNxpMqNIVXOeztqeqJf10E802EGQoOGjTJ5N+Xuj8didsEDKVqGYCxmbra+WjuaPDkajA7WfHZAQl2uzOXUNwDMejfMGODc6bleacewYDxxt8135Y6iTaPMVOeUCngt9HX1bRkU1RHTl5YDbHftorzfYDIf6RMb7tS99bPR7N307SnorW8gbXoL6AKndp8J0q824aI5UpGEHpak8f+O4tT6pION8uU12I6kXnN2pNx0xeAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c22e6e-288c-47a6-dc23-08dc660aa9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 16:05:16.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCYJsQXsEhCfVjI14zmJfzl1hgU9B0lzOA30KtRkk0d5oOKWmpkOUktuBBSDV1NqNamJFs0N73iugPGnXYMO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_13,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260109
X-Proofpoint-ORIG-GUID: rnGKI61nGwnwYzr7jd0gOMgd7VT3HGdb
X-Proofpoint-GUID: rnGKI61nGwnwYzr7jd0gOMgd7VT3HGdb



> On 26 Apr 2024, at 13:51, Jonathan Cameron <Jonathan.Cameron@huawei.com> =
wrote:
>=20
> Separate code paths, combined with a flag set in acpi_processor.c to
> indicate a struct acpi_processor was for a hotplugged CPU ensured that
> per CPU data was only set up the first time that a CPU was initialized.
> This appears to be unnecessary as the paths can be combined by letting
> the online logic also handle any CPUs online at the time of driver load.
>=20
> Motivation for this change, beyond simplification, is that ARM64
> virtual CPU HP uses the same code paths for hotplug and cold path in
> acpi_processor.c so had no easy way to set the flag for hotplug only.
> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> code paths.
>=20
> Leave noisy pr_info() in place but update it to not state the CPU
> was hotplugged.
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
> v8: No change
> ---
> drivers/acpi/acpi_processor.c   |  1 -
> drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
> include/acpi/processor.h        |  2 +-
> 3 files changed, 14 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..7fc924aeeed0 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -216,7 +216,6 @@ static int acpi_processor_hotadd_init(struct acpi_pro=
cessor *pr)
> * gets online for the first time.
> */
> pr_info("CPU%d has been hot-added\n", pr->id);
> - pr->flags.need_hotplug_init =3D 1;
>=20
> out:
> cpus_write_unlock();
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 67db60eda370..55782eac3ff1 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,7 +33,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
> MODULE_DESCRIPTION("ACPI Processor Driver");
> MODULE_LICENSE("GPL");
>=20
> -static int acpi_processor_start(struct device *dev);
> static int acpi_processor_stop(struct device *dev);
>=20
> static const struct acpi_device_id processor_device_ids[] =3D {
> @@ -47,7 +46,6 @@ static struct device_driver acpi_processor_driver =3D {
> .name =3D "processor",
> .bus =3D &cpu_subsys,
> .acpi_match_table =3D processor_device_ids,
> - .probe =3D acpi_processor_start,
> .remove =3D acpi_processor_stop,
> };
>=20
> @@ -115,12 +113,10 @@ static int acpi_soft_cpu_online(unsigned int cpu)
> * CPU got physically hotplugged and onlined for the first time:
> * Initialize missing things.
> */
> - if (pr->flags.need_hotplug_init) {
> + if (!pr->flags.previously_online) {
> int ret;
>=20
> - pr_info("Will online and init hotplugged CPU: %d\n",
> - pr->id);
> - pr->flags.need_hotplug_init =3D 0;
> + pr_info("Will online and init CPU: %d\n", pr->id);
> ret =3D __acpi_processor_start(device);
> WARN(ret, "Failed to start CPU: %d\n", pr->id);
> } else {
> @@ -167,9 +163,6 @@ static int __acpi_processor_start(struct acpi_device =
*device)
> if (!pr)
> return -ENODEV;
>=20
> - if (pr->flags.need_hotplug_init)
> - return 0;
> -
> result =3D acpi_cppc_processor_probe(pr);
> if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> dev_dbg(&device->dev, "CPPC data invalid or not present\n");
> @@ -185,32 +178,21 @@ static int __acpi_processor_start(struct acpi_devic=
e *device)
>=20
> status =3D acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY=
,
>     acpi_processor_notify, device);
> - if (ACPI_SUCCESS(status))
> - return 0;
> + if (!ACPI_SUCCESS(status)) {
> + result =3D -ENODEV;
> + goto err_thermal_exit;
> + }
> + pr->flags.previously_online =3D 1;
>=20
> - result =3D -ENODEV;
> - acpi_processor_thermal_exit(pr, device);
> + return 0;
>=20
> +err_thermal_exit:
> + acpi_processor_thermal_exit(pr, device);
> err_power_exit:
> acpi_processor_power_exit(pr);
> return result;
> }
>=20
> -static int acpi_processor_start(struct device *dev)
> -{
> - struct acpi_device *device =3D ACPI_COMPANION(dev);
> - int ret;
> -
> - if (!device)
> - return -ENODEV;
> -
> - /* Protect against concurrent CPU hotplug operations */
> - cpu_hotplug_disable();
> - ret =3D __acpi_processor_start(device);
> - cpu_hotplug_enable();
> - return ret;
> -}
> -
> static int acpi_processor_stop(struct device *dev)
> {
> struct acpi_device *device =3D ACPI_COMPANION(dev);
> @@ -279,9 +261,9 @@ static int __init acpi_processor_driver_init(void)
> if (result < 0)
> return result;
>=20
> - result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -   "acpi/cpu-drv:online",
> -   acpi_soft_cpu_online, NULL);
> + result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +   "acpi/cpu-drv:online",
> +   acpi_soft_cpu_online, NULL);
> if (result < 0)
> goto err;
> hp_online =3D result;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 3f34ebb27525..e6f6074eadbf 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -217,7 +217,7 @@ struct acpi_processor_flags {
> u8 has_lpi:1;
> u8 power_setup_done:1;
> u8 bm_rld_set:1;
> - u8 need_hotplug_init:1;
> + u8 previously_online:1;

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

Miguel

> };
>=20
> struct acpi_processor {
> --=20
> 2.39.2
>=20


