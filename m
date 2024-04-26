Return-Path: <linux-arch+bounces-4017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE08B3DCF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663591C22504
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E115ECDB;
	Fri, 26 Apr 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VjO6HRVI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/XqJZ9o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8015AAC3;
	Fri, 26 Apr 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152153; cv=fail; b=FWjXk/GOdALpASCPly54lSVrUIE0hBT6vaInRNdmi/2BAa3KfCzQYgCwNrEIT+JTfJ9LeEwTjzlNm1xoyBZPwunbC1RhjvXZU6G1rT81unBeMf4vqCpEZYK9blZyNy3jMoiLV615wk8W5e19PbTuIw5Rj5t080/K/WSU/21y+o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152153; c=relaxed/simple;
	bh=mDcCpyxTxIkzhZr/OOpiv6Z3JigfB8oFxawB/YIMeCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFW91B3mJUGu2gZor9vnmeXLj8AEsS66YwG9xtkJeDp4YW69GELdOtWLP9OH6/Y2DgNcfcEWq5PDMZfcqwZsJW6NWJmXgu+FdeW7KTEX+Hd+R12x8r/PrfTZmpk5by8VdNhQZxL6+0id6IXzsFsjj1P1JkpCNXipSTY9Vzoh54I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VjO6HRVI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/XqJZ9o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8SjHC014185;
	Fri, 26 Apr 2024 17:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a+ledprrXZGUZwkbFVmWbwaMUD33xYryy/16Il5lnKw=;
 b=VjO6HRVIE3vlXmOLXz8CVbXhATckALwZ4qJHRZrOkgmPM18VIbIC5znL5pB2IiogG1Gr
 9j/Gcu4cSULBUOcp0/gX9WsFoVAqUwnCrHAZFvmk22oNNE1/pmTQwH18l2CFPcnqbHKC
 sB4Qdy4EwucArfi+j8oGLzzqiahZihjbajJIyDvWqpIIjTh52QQDEt66CVAU5b0g0Nsg
 xvdS/fvxj3vP0cqMoUpxARLUDne4gzLR4cKxoKeJkWHLVgDSwl3oo9natj/bej72UURx
 Lsu5XwbIBXt1U24tNBc73kDdxuODI+AnxGJkjPrcc4WhytRIyVEATXDM3R8jT9Xy6tkt tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5re62g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:21:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QGC9Gv006120;
	Fri, 26 Apr 2024 17:21:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45byhee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 17:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7TmCbFRK053qG2/NOKxh7xlKwzZP7SxeYmbmsq3it+XphwNaLw3OWAkXk/zS7YMmcTsu4l6NN5V9ac+rYqlpdSBNTPeIDuiajrjOnmkU4aUNp4JeIuG1J68eRIRL64+96KxPmR+itqV3760zFFjX7rArv8PznR3cJU7DvoVRx0mUAsoya6WW6OqtUiRD1+PxsMPQLJ1ILouDYPAkV8LrGNb+Q0/Ckn996bnzBzf1KPYT8icSi6ov4XlkQkskplelmzjH8vNJYzfyA5/W8zpQjH83wQshKv+WrfOVNC6Tna0NvZLnSJ3EaamBi5tPof2EyzVKeiR+tJ+4XPGw3BpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+ledprrXZGUZwkbFVmWbwaMUD33xYryy/16Il5lnKw=;
 b=UU7S4m8THUdhPVfMdRSwpnAiDRqAXpqoB75q9jakmJgTNeatr7xe9xK/cySFmJE5eW0xrJeoF+tKRF9K1L2wHZtR/ZclX45Y64ImqVRvkq2GuRM45WKG2PuM22pZR2nlTrXNCQdlFv6k7a7sVWqk4dNghtncgepTmkuXcpCSqAv8E+8/lenVx1twgVtJqZruud36mi5+A7X6o4e2ANnXvngm8auaNhmvrbP//4jrYIUEr6kIzq/o6jhRMErdNJnMOZYgBZrtY8vhKua9Tig/LlaWA0SWj8MWlff+oyGT1Pw5xklFeAsdDlxh7r1NkcwlGuB4RDXHUbRG57JJ6UM2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ledprrXZGUZwkbFVmWbwaMUD33xYryy/16Il5lnKw=;
 b=E/XqJZ9oeOeW+kQB2S59ypmwLMf9PfxOamRK/UEstil2EcrryPloD5v7TaheWbrSsQeRzWF0ElDlViQb9mPJKPVC3spaZZYXA8p0PNS1Vm91nWZNBPIFPHfFawQEAF2tM3K51XqvFjjbMssOlC39QFkHUuFTyH1Set0S5vHkGj4=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 17:21:41 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 17:21:41 +0000
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
Thread-Index: AQHal+Dr1mTgxKWXZUKWLSudUXZBd7F6tzsAgAAVXIA=
Date: Fri, 26 Apr 2024 17:21:41 +0000
Message-ID: <2E688E98-F57F-444F-B326-5206FB6F5C1E@oracle.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-2-Jonathan.Cameron@huawei.com>
 <6347020E-CB49-44ED-87B2-3BB2AA2F59E0@oracle.com>
In-Reply-To: <6347020E-CB49-44ED-87B2-3BB2AA2F59E0@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA0PR10MB7157:EE_
x-ms-office365-filtering-correlation-id: f1c0cdd9-6739-4d01-8538-08dc661556d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?iLq537XPT5Y+KX0KO58fhL8lYGMroskYftcB+xbquUi9m0h4mIg8F5/O9mdi?=
 =?us-ascii?Q?fLQeAHIF8c/InW4yvSqRmCITwiiKlKcHnf+/qaZ2pUdhMoT0GKZCWTizGawE?=
 =?us-ascii?Q?g7RzXbMVl/E+uaxwI1RPwAlYPNqDyRdz9tVNgnvc52NaQJeVYk2FhL2T/nmQ?=
 =?us-ascii?Q?rDcUydv7qegeTcH78N1tJoN4kRDGxGaKUbwCzuL4RmNtCPSzU4+7oZzToFcK?=
 =?us-ascii?Q?607TJw1XqOY8i/eF2eQFOHrqToQDOMuYUu6hC+8BxcyaVubNKLUI3j/5GnHf?=
 =?us-ascii?Q?qTw1LfJ7intmeefS0fYrRkLfwkNkcfQlA8OK6hFFTnjzn9tajux6+1sV7SVg?=
 =?us-ascii?Q?CgRzIFjClKgUGDxMFwPrvx+eOHmDaNn+Kj/uE4Z9UIZ+zpF8QwAwuXVjvQgr?=
 =?us-ascii?Q?4iaYwJZbGB++fL3uCNfDggujofToiFRyXipNZzwBJQXeygue2RLIUQHiz5q4?=
 =?us-ascii?Q?WTbBRtATbpOG/QTUJkUg5SlPKoZ7wFbUHYipPgF60eTJV6KHgRXloo+7Zjgq?=
 =?us-ascii?Q?njOoduSviYONtoa+2vj0MTlFweP6UZta2ntyIVyAKyUGme5h+7qpDm2upxeG?=
 =?us-ascii?Q?FoIpMxUm9sOI0MX8jCsd9x2K+ZA2JlDcVybkqL/zt4FDLnfgARbpedS3dnZm?=
 =?us-ascii?Q?paXg7AaTTTGQ7higwwHV0hcy8p+dqrXhs/hORCM5u0yYWY/qXi0dFUINI7ix?=
 =?us-ascii?Q?1zPWImvKRtGjNFXokYEnTM85UluP5J+iR3S+1FfbK+0gqymvLxwN3/2X5ffh?=
 =?us-ascii?Q?Q80xanW1b+7Q3uJ4dqo+PIWkn21oghMVBLwtEZNXeSf576lq2vCHbIPSg550?=
 =?us-ascii?Q?QJSIKmQZS5N012ZAPDshAJmQxIzY08e4/yA/BbtOfwU895PFa8vNXVxQrOV3?=
 =?us-ascii?Q?UE2lUTe/iqjUz9w93FNuQlOjRwwLeiKtvBam0SFJ3Dr59A/9Jsf12MZH5czS?=
 =?us-ascii?Q?TNyvnNcvJc0hqC+rkMu79AbjRcd7f1ckSi846ab2VZljFqmZaF1hBjKVQZAo?=
 =?us-ascii?Q?s/ALNKygHWFca+MGQ8j8mZ2FHlTY30Lk5x4KPIzwIXtvYQvHGGYOI9lJiJN7?=
 =?us-ascii?Q?ALgOOjkfWX9J5rJPKNHGcBDAGMhUfZf0QyUZMWv6+qWmMwheC54JO6lO6bYT?=
 =?us-ascii?Q?ktdlY/QJ8C8xxjSmpLhrxnEqZ6LpYpEuaPbQL/hPrDaGChW4gfA1IOsCOBoB?=
 =?us-ascii?Q?hMxH5JT8aVxcBbjQ8n3gvP3NaFncZzBe1wC0prZK4OPUbqx33MwzhVz9XVsP?=
 =?us-ascii?Q?aApikvSzy0EkZ8BTbip4SjjAl98TAWDbOlqLxPqfoyZn4QzRCr8m4cK5US27?=
 =?us-ascii?Q?GaPQGyOvc90Wb2wWuqAIg3V+Zd6KT+b0qbnQ8MKSWklpTA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aRZRZvvnX/QM28Z86VvMPUqo7rU8ropOUjqK+mshng3T3bT0hPizgvHjlbAb?=
 =?us-ascii?Q?YjQdWr/7OK/MwRnGqys5+kZAFbSyRS4lfI+TEjzj5as3iAP0CSP4x0nX/nOm?=
 =?us-ascii?Q?A6S2RYRQbHxXkW5oPegO6mMj5Mm48H0njbcGYfp0DCrMMBpXBogGp7lwpBHM?=
 =?us-ascii?Q?v8uq3p7cy48yrGFwlGm/pFW3mf5eOXQXQLziOxcYfYRVtkxwfIVFnLYIkgJm?=
 =?us-ascii?Q?Ckajv8p25kFcw+e/dPRNqsTxRiQapCzdJpCHsCRYOMveE5YmaLf0oi0quZFW?=
 =?us-ascii?Q?BhRdBVHuNj7Ujvx+Kezk4A/ifFddcgEK43K3wJvRPHw9YBlzm1Nnfoklmq6v?=
 =?us-ascii?Q?lM7DQrpVtna9cZv9MvEWs2m/oau9rg8Zy9lEyJHUw6AC7DtSidg6NO4EDKC/?=
 =?us-ascii?Q?+hf9pjXsXJUwGA/0d7vgOei6OHwWeneOsB4phtu5ctKgT7zHEJLST5BxZnTD?=
 =?us-ascii?Q?++hxloDQwryDejDbMY8ob3dRBtNDhBYIdklw86ynrw+m83WKM8vQsC/UYb8s?=
 =?us-ascii?Q?uPNtikzq37r5C0JKZT5s70yCEZOH95rlCAhTQVFXoQGG5T+AdXOPNHsUg7bg?=
 =?us-ascii?Q?LNGdEYvRvh2jmHJNW0ZCCfY8TzzeizD5vu+p/c4zTzt2wzCRIOm5PVonD7rM?=
 =?us-ascii?Q?JtMDNLzxw66GHEogLAL8NhaH1vS6/+nMx2ar5ZgmfGwW1zkuqEsbtrByoh3R?=
 =?us-ascii?Q?eWDzW+TYmCsTvBv1oZ73TtClfHlvZB86ivl63vFozAqXqT3ymZ/bYPu629aA?=
 =?us-ascii?Q?BsJBvHuCEPOT+tlXUe5e/KmwP25u/AGBMPDsX1UNrfVymDp3HNVnqc2dpEeo?=
 =?us-ascii?Q?nR51ZViqRljsNctbuMuI9yAf4IA/T0g+3TUnS/hOFr/5tjFAgP9Hk2eoldhz?=
 =?us-ascii?Q?hXM5ylPW802FVDJLmC8gKzRl+qDchXsUwvCWZFoTNWdJZnje0Xq+hTQxguMw?=
 =?us-ascii?Q?42np3wt1nLh6g4YKsxfLeFtZgy9FxU2aKvBl/k7b+Lqeenj2PTLbKFCjeF2I?=
 =?us-ascii?Q?NxMDdTb5wJOwcWXp5R+aqpiMnMWN/czQSatfnZk8E+RrEQZTcUsXqjpAeHf4?=
 =?us-ascii?Q?vrDqa5fJEFlxH+YHnMpk/5CK1/YEuN46NjngpcFcbiBc4ja+2TbmeL1LRIRU?=
 =?us-ascii?Q?UoH/aM7EtMQYndZiG8H7GKWmJHIHtMt/lwWKHZNlsywKd4LRyDhDGiFXcwVZ?=
 =?us-ascii?Q?V8Nmb7zC4u/siTswId7QVF54lap2ZXOQXW+Lk+l0ZXAjhBitv8wszdRLhG/s?=
 =?us-ascii?Q?QcCRUxqyi0j4hh+Pu+2QiMmQj4t7SjOQbk5FDAHL4jIXnSP0iM+FvKi4oF+9?=
 =?us-ascii?Q?U57enWSNmK6Nbm0GFJthqwNVtCpKyIuXu4kuESbDYOLQ6kgyyabDsPe25qsP?=
 =?us-ascii?Q?ha3E6GGnTX7SF1T+ilAamKiqsBzUIHUcPZpNR65SGT9hFJ8r4A5FPqA+Iw6P?=
 =?us-ascii?Q?ry74pXLkTMrHKeSYIcZQBDiTnAgH4FBWALz/dEbWYLfXHfyVzF5dbNdipy3U?=
 =?us-ascii?Q?SsMN8JJzVFm/4lu9kERxRzHGmLJC3Fu8Js9yeBKtaBucGvNJ5MT6f/bqu/XX?=
 =?us-ascii?Q?Zio1OuyCpQ/LzDmPfnMde0cH5zfYFtt9WA2qlVdj7ZVncoCelXgXYwDP58YG?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8D300D5EAD6DC40B070E3665F10803C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5KMlUMuMpnk9ZorreiTHDXRsvm+H99tEHxssIHE/CxtdDmBmPJDmN37TnWEATzCIMNGsZg7/N7/JU0LU+lfk7OyyNBnaiJvdU1DorbKu4KTpSaJ40KuYFxc0jJzgBXl7gqE5cyr8yRXI+BaDpu/eC1Rr7062Wd1qKqdRxsaPzfMLIZi+dWgMfnGV6IBxIxOxwSD40qmbw9b5tK0GRa2XlbOZQ+LhFCxYuDcguK9cke01S2uPmF4JOfW3Z+ydnLctFRmyb3oXfICcKH6JJBKBqpYox6eU011i8MwsAx9p2bPdXoF+2/R074c59UJ+tu2m/0tvxnGmqLyYmhFROWc5QF9qouVUPC62vVKFxUI0ao9Oyy41LCNtSsTX6eXzOrQo5zNoX4uEUNCTCCDjV76Xoa8sMmx6CfecivlM0CM+TQojyOxuCyIu182x1DEZVFyiXVuHh8SCVHMMwDz/8YoST89ztMRBF7Z63bkaXKTw4XQojwI7yxom1RWjlG4dthpY4GA3VEuJAQ03ELNr+eUmVUkR+quk9bXgJ43XSnG5nMqZjjet9kkn3bL9KudzH49bVByc0kG9yagV0eaxNGGM+UYEByqq50egJ+C8kCuiUKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0cdd9-6739-4d01-8538-08dc661556d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 17:21:41.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgYzDNnX1pmDoH1RIcsZ8FahVkMlaCmTgK/I1WgwD0RhWejdeU3M/EkGpzBU7e88yNFbriwUyIRqVcN3XTcmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260117
X-Proofpoint-ORIG-GUID: aGuefirpL25eHyIVJtQdy_gNHVHFz2tm
X-Proofpoint-GUID: aGuefirpL25eHyIVJtQdy_gNHVHFz2tm

Hi Jonathan,=20

> On 26 Apr 2024, at 16:05, Miguel Luis <miguel.luis@oracle.com> wrote:
>=20
>=20
>=20
>> On 26 Apr 2024, at 13:51, Jonathan Cameron <Jonathan.Cameron@huawei.com>=
 wrote:
>>=20
>> Separate code paths, combined with a flag set in acpi_processor.c to
>> indicate a struct acpi_processor was for a hotplugged CPU ensured that
>> per CPU data was only set up the first time that a CPU was initialized.
>> This appears to be unnecessary as the paths can be combined by letting
>> the online logic also handle any CPUs online at the time of driver load.
>>=20
>> Motivation for this change, beyond simplification, is that ARM64
>> virtual CPU HP uses the same code paths for hotplug and cold path in
>> acpi_processor.c so had no easy way to set the flag for hotplug only.
>> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
>> code paths.
>>=20
>> Leave noisy pr_info() in place but update it to not state the CPU
>> was hotplugged.

On a second thought, do we want to keep it? Can't we just assume that no=20
news is good news while keeping the warn right after __acpi_processor_start=
 ?

Miguel

>>=20
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>=20
>> ---
>> v8: No change
>> ---
>> drivers/acpi/acpi_processor.c   |  1 -
>> drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
>> include/acpi/processor.h        |  2 +-
>> 3 files changed, 14 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor=
.c
>> index 7a0dd35d62c9..7fc924aeeed0 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -216,7 +216,6 @@ static int acpi_processor_hotadd_init(struct acpi_pr=
ocessor *pr)
>> * gets online for the first time.
>> */
>> pr_info("CPU%d has been hot-added\n", pr->id);
>> - pr->flags.need_hotplug_init =3D 1;
>>=20
>> out:
>> cpus_write_unlock();
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dr=
iver.c
>> index 67db60eda370..55782eac3ff1 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -33,7 +33,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>> MODULE_DESCRIPTION("ACPI Processor Driver");
>> MODULE_LICENSE("GPL");
>>=20
>> -static int acpi_processor_start(struct device *dev);
>> static int acpi_processor_stop(struct device *dev);
>>=20
>> static const struct acpi_device_id processor_device_ids[] =3D {
>> @@ -47,7 +46,6 @@ static struct device_driver acpi_processor_driver =3D =
{
>> .name =3D "processor",
>> .bus =3D &cpu_subsys,
>> .acpi_match_table =3D processor_device_ids,
>> - .probe =3D acpi_processor_start,
>> .remove =3D acpi_processor_stop,
>> };
>>=20
>> @@ -115,12 +113,10 @@ static int acpi_soft_cpu_online(unsigned int cpu)
>> * CPU got physically hotplugged and onlined for the first time:
>> * Initialize missing things.
>> */
>> - if (pr->flags.need_hotplug_init) {
>> + if (!pr->flags.previously_online) {
>> int ret;
>>=20
>> - pr_info("Will online and init hotplugged CPU: %d\n",
>> - pr->id);
>> - pr->flags.need_hotplug_init =3D 0;
>> + pr_info("Will online and init CPU: %d\n", pr->id);
>> ret =3D __acpi_processor_start(device);
>> WARN(ret, "Failed to start CPU: %d\n", pr->id);
>> } else {
>> @@ -167,9 +163,6 @@ static int __acpi_processor_start(struct acpi_device=
 *device)
>> if (!pr)
>> return -ENODEV;
>>=20
>> - if (pr->flags.need_hotplug_init)
>> - return 0;
>> -
>> result =3D acpi_cppc_processor_probe(pr);
>> if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>> dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>> @@ -185,32 +178,21 @@ static int __acpi_processor_start(struct acpi_devi=
ce *device)
>>=20
>> status =3D acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIF=
Y,
>>    acpi_processor_notify, device);
>> - if (ACPI_SUCCESS(status))
>> - return 0;
>> + if (!ACPI_SUCCESS(status)) {
>> + result =3D -ENODEV;
>> + goto err_thermal_exit;
>> + }
>> + pr->flags.previously_online =3D 1;
>>=20
>> - result =3D -ENODEV;
>> - acpi_processor_thermal_exit(pr, device);
>> + return 0;
>>=20
>> +err_thermal_exit:
>> + acpi_processor_thermal_exit(pr, device);
>> err_power_exit:
>> acpi_processor_power_exit(pr);
>> return result;
>> }
>>=20
>> -static int acpi_processor_start(struct device *dev)
>> -{
>> - struct acpi_device *device =3D ACPI_COMPANION(dev);
>> - int ret;
>> -
>> - if (!device)
>> - return -ENODEV;
>> -
>> - /* Protect against concurrent CPU hotplug operations */
>> - cpu_hotplug_disable();
>> - ret =3D __acpi_processor_start(device);
>> - cpu_hotplug_enable();
>> - return ret;
>> -}
>> -
>> static int acpi_processor_stop(struct device *dev)
>> {
>> struct acpi_device *device =3D ACPI_COMPANION(dev);
>> @@ -279,9 +261,9 @@ static int __init acpi_processor_driver_init(void)
>> if (result < 0)
>> return result;
>>=20
>> - result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> -   "acpi/cpu-drv:online",
>> -   acpi_soft_cpu_online, NULL);
>> + result =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>> +   "acpi/cpu-drv:online",
>> +   acpi_soft_cpu_online, NULL);
>> if (result < 0)
>> goto err;
>> hp_online =3D result;
>> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
>> index 3f34ebb27525..e6f6074eadbf 100644
>> --- a/include/acpi/processor.h
>> +++ b/include/acpi/processor.h
>> @@ -217,7 +217,7 @@ struct acpi_processor_flags {
>> u8 has_lpi:1;
>> u8 power_setup_done:1;
>> u8 bm_rld_set:1;
>> - u8 need_hotplug_init:1;
>> + u8 previously_online:1;
>=20
> Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
>=20
> Miguel
>=20
>> };
>>=20
>> struct acpi_processor {
>> --=20
>> 2.39.2
>>=20
>=20


