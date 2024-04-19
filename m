Return-Path: <linux-arch+bounces-3824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B028AB22B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE1286167
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA9130AEB;
	Fri, 19 Apr 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aEhkGfy/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nrGWD8Q4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC9130A6B;
	Fri, 19 Apr 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541264; cv=fail; b=I4vfKZnstfPFCiQq4Cn5umU2Bye7OeFOwzD8n+qwnL5YuTNUlsJBGCvGgnAsGBq9tH+iIhzjGf0zTlnx3rp8uHcjMa1zvoQ1J/OUpaDg3G8Uk9ZbbUT+S6R1tDSpXUrjDd5xlyNe/jb4Nypcg2i3RPUoGz2paYWqEZc7Gftarw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541264; c=relaxed/simple;
	bh=sdQIzrimCCTuIzS4fQj+8U9rRSGFtzeQE+DnI36WyUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVWe7KNaWWn3IzvxdqqUVAHWegaalJBfknLlbfQsi4GTa1m8QHhQJX3NLzyIS8YsnLAFsgKRaoZGF7b0Fvsy4f9YGsJcR/3R1FZ2CtEehtWZYoIrOjT38nsnWerWjDqVEwgY2Py599jVl7gaX8ZOqvW/pkWhcf3NpQLUg+bT8/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aEhkGfy/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nrGWD8Q4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JFVENV023402;
	Fri, 19 Apr 2024 15:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4nLsAtZIOsmDYMbDhCqg9CBUrF/5x7cTocrwealOTwc=;
 b=aEhkGfy/u7tlMitwjeA4ADDpLBy9MHy/bziuWYbpUdgBHRliz9L8Y6icKB3BLIWwHllz
 stp03bqBiOSVp5n/ig7zZynwznMWzCk+4XoXb0RYZGavzVRNc7N4Xgp5btU2IwtL6seh
 G05LxLAgCvvqXe6EZlNumAB/sp2iS+7whpIIhqpmlRWrrCIsXRyWBgF2ztn7XftQ80/k
 my453eksAs9zCtzr4h6esQP1FaLk5bZ7Snz7RhO254RzaLMLxLnw15u9XyP2YelASAcq
 AdllGW+mgzA6hsdpuMO3RTq3WCgXdXitKI/Jv86QR7kjdlvvXhY4KpqHNjasLtann58H 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffn3sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 15:39:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JF0raO016794;
	Fri, 19 Apr 2024 15:39:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbjc9fyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 15:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQhiNHa9Rw+GxbIX8Qg7C+6R8b83x1QFrjZFsb57vXbQN7LwcdyDdonYuh0tOWcDOziNmNUtZ+3DT6SVHassSjQ5k1QCBhYdB07vwVgZVXlN9+spUBmSqnzEh12Rn3pGm7G4pzUPx3ZhGJlHTK0x3sBJpiji1LtmF7SpJMrkUXbko+4hFrzsCFYGUUe91p8yR4cJ99Q98IGbFHRhLmAPd30G1a7bZJ1N2410g52wyJRrkFHZScGMTdaOvhVwXtppJkr/0UW7wj+rsV0Spa9doXEkJUhu2XhQogrH9i+qF0K9Gtig6FsDudrwv8S1xja/2C7WPpUBPf2HZVVB8tkPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nLsAtZIOsmDYMbDhCqg9CBUrF/5x7cTocrwealOTwc=;
 b=gALLEfSgNnX16Uz0MrWtmqW5LVJLaxBAOgs0wOQ4vGrORnOKMowRHMxEHY7BGIn2fhlZrD/Z4Fm9/7kRytn+WdBDg7PUZST3eS6OQl8NGJ8pBjMUOPI2LoGrjS/IdmtXKLY6MNa7wd5rOYS0pHznaHdgsEMwM1I+nCGpBUSiC6Qlt2zrbNmJQPyqttSROb9fD9nF0Af/ByvPKNgKqXwLL3Z3vpoxI2LStJ4GBGPg127A+YQx5HbD8qwd04vCrr/l5J16An+Qr8qUs4gZzwpyu8vucbgtwjp4dza72i/AGnhpk18rArPzBRgi2F6AlghB3LKsRdPB/1PL7JKOVkvenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nLsAtZIOsmDYMbDhCqg9CBUrF/5x7cTocrwealOTwc=;
 b=nrGWD8Q4TQs4LBpIm5hn2KdDbhRSxnVmUWl0Vn2/vsd+mzLF9i4Jl2GSR9L4W1fT37Xd9rqsAVEBAm5Z2v/9rg6kb2nJvYrKLnC+GKOVEVn869o07oXQPdn2znZhgCvmz1y0cm/M2e3he+H8pxL1JO/ODgR7ty1cu5R/fLD2dhs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ2PR10MB7705.namprd10.prod.outlook.com (2603:10b6:a03:57b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 15:39:49 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:39:49 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
        Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 00/16] ACPI/arm64: add support for virtual cpu hotplug
Thread-Topic: [PATCH v7 00/16] ACPI/arm64: add support for virtual cpu hotplug
Thread-Index: AQHakZfwjry87/k2C0WgIabvGeGD4bFvvGGA
Date: Fri, 19 Apr 2024 15:39:49 +0000
Message-ID: <42DA9E8E-FFE0-4409-A604-6D56284FDFC5@oracle.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ2PR10MB7705:EE_
x-ms-office365-filtering-correlation-id: 72c29d97-2910-49f1-dd2f-08dc6086f2a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JjOqNmjQQ3z9v/V8B7/wxxIrqyUXtUYxqCtqOmu1Ru0z/OZcVe0Mov8kNZjt0ke+OsCP7XwUA3yEyDgoZSnc90EX/RwmuXjuP+7rRz5bi7F6TIpokc6ruzgGO1xQ1eovwGpF1m1Jg7p7XbZIGSUSYq6WMUY+L+h3O36sWu+WmC79BVRMx1efEzKAL74iUs6KRKqPTfkVS/r0Hp+VkpNVAtK2m3GmEY92qtOrdqsxZIZqMfnmLYkYC0O/VdtVhLCy28ApGZBqwtgzvSCI1j6MBNrsnHiCLFW5P7wF9EHMty5imj6SoGvXj2RkODgasiWv1PT/wgrTSyKdwplid5AzYZIIUEXmArRKhiKX6cOYxs1RbHloWGX5o1QsO2eQxRoa25jtz2XJNeLK8U6Fed0jVQHTJL21MiYFUdyVi+hPWcJ+HheZ+36d6fW/NcOqjsgc+uflNNXaArbX2J5fGb3ewRN66rH2iHDBSwuysnuuLiuwqLUvWulyLPrtVjWXkUtUm14dL2ZsGymUmMALDvJMf6vzCxvh7LjlrlWWXbrrkeYTEbg1X0JnMiH/JQOiQVp7/14UDdao3uMK1U6DuLFiFMgbFd5gSBMUO8rCsQQR8n3O15V0xjoVwt6wHZXeychhhQ5PCFaoXy+fqgBMH5p/rs1JxonnR/RiDNK2fVbzDYzSU9m3iXFkRSq0DHk30BPetwdlVbQ3YxUTk5MEaHjLiw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?voEh+wk9cI/e1oAdFtfBej4yfSpRWCBswa+1Wb4AtplbDnyTSTNtOqEMwTZ4?=
 =?us-ascii?Q?nqEEGH/hqIR0JqgEC0t59evLWnz6E+sRUW+NGptL5nXkSgJU5KjxMMeEOngO?=
 =?us-ascii?Q?vzDq3UNgakKORjhWiMkp4meXpsCs2pASKt6AOXtPFDUF4DBveVoaKHlHq51q?=
 =?us-ascii?Q?4yr/KHQ0GnbBqUHHAujmpEY9HEBZ7T2HQDbbDvvQRnMKRFq188oAD5A1sahm?=
 =?us-ascii?Q?8sHtKW3i6gAQqA8+adqBvutL1TpQaVoABYhdz2BkXHRbKhIja9ndMoKhWZLI?=
 =?us-ascii?Q?IYn8warHgea532yyk30SquRowuDdpkAlm4XKPvK9q6q2K3er4+t3oCHGR3t8?=
 =?us-ascii?Q?W/yw6MaODJmkdkTfH0RI+zxOz7XQYxursgMCF4MoUsJ5T54mec9FSVXkRPEB?=
 =?us-ascii?Q?wusj6h2x4UVPrr2AhZXDhkD7uz98caCYMbkiNW5DidE3aPkN36CaIsBrhU14?=
 =?us-ascii?Q?QuHvd3EPSxsoBgAeLlz2yhLl3xdIaU08EcrqGmPbJPLDnC1R3DlZr/bARxLG?=
 =?us-ascii?Q?+SoJFNJ+4p7YksbM74YXn/+bUjjgpatXX61JhQQdSLR/PTB1dsClrtyU255i?=
 =?us-ascii?Q?mqQbBmBZ49Uns7mul16P5K3xeEYL85uVH7pBjcDIAUnm74AIsjliKwYwGiQy?=
 =?us-ascii?Q?aQGpneVzk9zn2oxdaaViUcUGF+LKxM4HPZJU5qcsMrWcIIPorfZI6uODoxUB?=
 =?us-ascii?Q?YUd2qRFpFJdgPxuyc5zzurFfJ8gvM5b5i4V6MM9cjN6gsRkJIZbkDtYCnwTk?=
 =?us-ascii?Q?N0UM5mcKyT5EVZwR9pvJx+ehILRCK80zTBMf7vJ5aSICjG2Z8IHCuoflRc6l?=
 =?us-ascii?Q?vGzffbyoDfEinFED3R8KuhzS06rx/iloA89JnHl2SFwRHEAfs4TWDFKN8Eqn?=
 =?us-ascii?Q?WuSFSR7g+t8ZK631gsmJhJycTTzqMwAUutP0uT2pBL9N2fKATbMeyxTNnvyS?=
 =?us-ascii?Q?OCucGMLoSHFYLalahr7IQZi3Q13xY2diX/MtovnyfNhg5IyJlqqp0SJCJJ4J?=
 =?us-ascii?Q?jjU6GHuR6NxQmlzA37yDf+dJ/4aKN2TNW8eAcdIWLOSxZ+0dVNnpTlhXeTg/?=
 =?us-ascii?Q?b3Dap3AFwviVzYnoWc9cyCJPtxv0o7OjAeKn+iPjeBr35negiGUulYc00gWY?=
 =?us-ascii?Q?cEIVT5fraJ/EiBN4GM5WG3D6WwOLVP6zqByIV+DZWk+lOhorxigWfFpEcNZU?=
 =?us-ascii?Q?pnpPO29nvPDvJiFhqxDhrG59ZpNI9WxHhDaLgWcEW+I8CSEng0tBjAQtJ1Ep?=
 =?us-ascii?Q?/6TdXLMEPX6qYfEcgb9juSnzJ0NkdyCeXvN6/YpYOlOMlLqrB2smDMzc6OzA?=
 =?us-ascii?Q?Sk3vdMqAnvaZN2wukEjMJVS6BJ4l8hQHB7M0ZoOo/E6Zn7ZPdRzvY9NhiZvi?=
 =?us-ascii?Q?Ax6FnoNP10XYUojL4vUH6pGF7Uf0nMT3zbaqTh0dWbUawOQ2o24ENdhTjZem?=
 =?us-ascii?Q?9CidODlwf1gP9y9KoGhgzer1Z/o7D6OebYV37bMUZ6KAlP023JRGDxEl0B/2?=
 =?us-ascii?Q?z9792oJ/WTYCRMgQZL43Ou0dnsEUgNzzxicvW3juQMuREKe6wzKqM3p2BZ8z?=
 =?us-ascii?Q?zCMjharVYj5qLZICUsN/iI9qcx2yZyDTiT7Emi4XanjcS8LU4tU89EllduvC?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C00F7FCC2D372B418247E87CAF63CF40@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+SJ5NXfY8XXhBH0dI0dN2LkoIt0tZEiQw9EWBp4r+dKLMzMqAEAJc2+RdjZlEGepAQGkcdRg+G2c5YBZhUOvTvybWStxnpCkCnTBOykwl5w+iQYpkY/FRpgk6qBUcpvq3uZnxJzkNnUJNN6ngJt0OSsAjhpJaJvvbnpfC06VBfc0ElKnFVg8gfxwu9GCciURzLIQhXOkMZz0EvkpwkmPknMHc7ORCI/fV19ZfxzaikuLoAElbVjlYtbMvMY15Hst10niDrXVqhGo8nNt8hADihfYUIyyOenqGSoALhURovZQA888lZyF8BtmBhjNvffyiRHTfscTbbReuZZtgBU2te6X9ULPs+aCJzNjqVpAGR/hBwa6OTggzY63jpJ/kR7GSFknAKDyAtMc8x2UHG8BMpuZnAYDvmbDDSzrH6EUpBiVRuCqcX+AQElRprXFdbAihI3dEyK2JThhlhCmO2lOu2kRIBk146D/ng0BDs1B9F8LJeIHm6kkGRu/R+lDpUAERAvFHMwCsRCuP90QuZ3lTNCDvIiFld/g5AQNuJkmuI0tP21jhAeEuj+WTYGgCarn6QgcZAPwfr1pSpiNbkMPlE2GCgm9Qt316mjSd5Opk3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c29d97-2910-49f1-dd2f-08dc6086f2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:39:49.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6fVk0kF+YURCnWZ63zng63A4U+Er8b1+QdnL/Gf5HcNOPaF1ilSrQLAGKbmkr4zprUcTzpXVVVau7zNXPMgag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190118
X-Proofpoint-ORIG-GUID: KPhPhMMrg9dG4J4nZNWS12Fo3DsoQt0i
X-Proofpoint-GUID: KPhPhMMrg9dG4J4nZNWS12Fo3DsoQt0i



> On 18 Apr 2024, at 13:53, Jonathan Cameron <jonathan.cameron@huawei.com> =
wrote:
>=20
> Whilst it is a bit quick after v6, a couple of critical issues
> were pointed out by Russell, Salil and Rafael + one build issue
> had been missed, so it seems sensible to make sure those conducting
> testing or further review have access to a fixed version.
>=20
> v7:
>  - Fix misplaced config guard that broke bisection.
>  - Greatly simplify the condition on which we call
>    acpi_processor_hotadd_init().
>  - Improve teardown ordering.
>=20

Hi Jonathan,

I've tested v7 on an arm64 machine running QEMU from
https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2, with KVM.

- boot
- hotplug up to 'maxcpus'
- hotunplug down to the number of boot cpus
- hotplug vcpus and migrate with vcpus offline
- hotplug vcpus and migrate with vcpus online
- hotplug vcpus then unplug vcpus then migrate
- successive live migrations

Feel free to add:
Tested-by: Miguel Luis <miguel.luis@oracle.com>

Thank you
Miguel

> Fundamental change v6+: At the level of common ACPI infrastructure, use
> the existing hotplug path for arm64 even though what needs to be
> done at the architecture specific level is quite different.
>=20
> An explicit check in arch_register_cpu() for arm64 prevents
> this code doing anything if Physical CPU Hotplug is signalled.
>=20
> This should resolve any concerns about treating virtual CPU
> hotplug as if it were physical and potential unwanted side effects
> if physical CPU hotplug is added to the ARM architecture in the
> future.
>=20
> v6: Thanks to Rafael for extensive help with the approach + reviews.
> Specific changes:
> - Do not differentiate wrt code flow between traditional CPU HP
>   and the new ARM flow.  The conditions on performing hotplug actions
>   do need to be adjusted though to incorporate the slightly different
>   state transition
>     Added PRESENT + !ENABLED -> PRESENT + ENABLED
>     to existing !PRESENT + !ENABLED -> PRESENT + ENABLED
> - Enable ACPI_HOTPLUG_CPU on arm64 and drop the earlier patches that
>   took various code out of the protection of that.  Now the paths
> - New patch to drop unnecessary _STA check in hotplug code. This
>   code cannot be entered unless ENABLED + PRESENT are set.
> - New patch to unify the flow of already onlined (at time of driver
>   load) and hotplugged CPUs in acpi/processor_driver.c.
>   This change is necessary because we can't easily distinguish the
>   2 cases of deferred vs hotplug calls of register_cpu() on arm64.
>   It is also a nice simplification.
> - Use flags rather than a structure for the extra parameter to
>   acpi_scan_check_and_detach() - Thank to Shameer for offline feedback.
>=20
> Updated version of James' original introduction.
>=20
> This series adds what looks like cpuhotplug support to arm64 for use in
> virtual machines. It does this by moving the cpu_register() calls for
> architectures that support ACPI into an arch specific call made from
> the ACPI processor driver.
>=20
> The kubernetes folk really want to be able to add CPUs to an existing VM,
> in exactly the same way they do on x86. The use-case is pre-booting guest=
s
> with one CPU, then adding the number that were actually needed when the
> workload is provisioned.
>=20
> Wait? Doesn't arm64 support cpuhotplug already!?
> In the arm world, cpuhotplug gets used to mean removing the power from a =
CPU.
> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
> has the additional step of physically removing the CPU, so that it isn't
> present anymore.
>=20
> Arm64 doesn't support this, and can't support it: CPUs are really a slice
> of the SoC, and there is not enough information in the existing ACPI tabl=
es
> to describe which bits of the slice also got removed. Without a reference
> machine: adding this support to the spec is a wild goose chase.
>=20
> Critically: everything described in the firmware tables must remain prese=
nt.
>=20
> For a virtual machine this is easy as all the other bits of 'virtual SoC'
> are emulated, so they can (and do) remain present when a vCPU is 'removed=
'.
>=20
> On a system that supports cpuhotplug the MADT has to describe every possi=
ble
> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU =
before
> the guest is started.
> With these constraints, virtual-cpuhotplug is really just a hypervisor/fi=
rmware
> policy about which CPUs can be brought online.
>=20
> This series adds support for virtual-cpuhotplug as exactly that: firmware
> policy. This may even work on a physical machine too; for a guest the par=
t of
> firmware is played by the VMM. (typically Qemu).
>=20
> PSCI support is modified to return 'DENIED' if the CPU can't be brought
> online/enabled yet. The CPU object's _STA method's enabled bit is used to
> indicate firmware's current disposition. If the CPU has its enabled bit c=
lear,
> it will not be registered with sysfs, and attempts to bring it online wil=
l
> fail. The notifications that _STA has changed its value then work in the =
same
> way as physical hotplug, and firmware can cause the CPU to be registered =
some
> time later, allowing it to be brought online.
>=20
> This creates something that looks like cpuhotplug to user-space and the
> kernel beyond arm64 architecture specific code, as the sysfs
> files appear and disappear, and the udev notifications look the same.
>=20
> One notable difference is the CPU present mask, which is exposed via sysf=
s.
> Because the CPUs remain present throughout, they can still be seen in tha=
t mask.
> This value does get used by webbrowsers to estimate the number of CPUs
> as the CPU online mask is constantly changed on mobile phones.
>=20
> Linux is tolerant of PSCI returning errors, as its always been allowed to=
 do
> that. To avoid confusing OS that can't tolerate this, we needed an additi=
onal
> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE, =
which
> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE a=
s it
> has a different bit position in the GICC.
>=20
> This code is unconditionally enabled for all ACPI architectures, though f=
or
> now only arm64 will have deferred the cpu_register() calls.
>=20
> If folk want to play along at home, you'll need a copy of Qemu that suppo=
rts this.
> https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
>=20
> Replace your '-smp' argument with something like:
> | -smp cpus=3D1,maxcpus=3D3,cores=3D3,threads=3D1,sockets=3D1
>=20
> then feed the following to the Qemu montior;
> | (qemu) device_add driver=3Dhost-arm-cpu,core-id=3D1,id=3Dcpu1
> | (qemu) device_del cpu1
>=20
> James Morse (7):
>  ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
>  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>  arm64: acpi: Move get_cpu_for_acpi_id() to a header
>  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>    CPUs
>  arm64: document virtual CPU hotplug's expectations
>  cpumask: Add enabled cpumask for present CPUs that can be brought
>    online
>=20
> Jean-Philippe Brucker (1):
>  arm64: psci: Ignore DENIED CPUs
>=20
> Jonathan Cameron (8):
>  ACPI: processor: Simplify initial onlining to use same path for cold
>    and hotplug
>  cpu: Do not warn on arch_register_cpu() returning -EPROBE_DEFER
>  ACPI: processor: Drop duplicated check on _STA (enabled + present)
>  ACPI: processor: Move checks and availability of acpi_processor
>    earlier
>  ACPI: processor: Add acpi_get_processor_handle() helper
>  ACPI: scan: switch to flags for acpi_scan_check_and_detach()
>  arm64: arch_register_cpu() variant to check if an ACPI handle is now
>    available.
>  arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is
>    enabled.
>=20
> .../ABI/testing/sysfs-devices-system-cpu      |   6 +
> Documentation/arch/arm64/cpu-hotplug.rst      |  79 ++++++++++++
> Documentation/arch/arm64/index.rst            |   1 +
> arch/arm64/Kconfig                            |   1 +
> arch/arm64/include/asm/acpi.h                 |  11 ++
> arch/arm64/kernel/acpi.c                      |  16 +++
> arch/arm64/kernel/acpi_numa.c                 |  11 --
> arch/arm64/kernel/psci.c                      |   2 +-
> arch/arm64/kernel/smp.c                       |  56 ++++++++-
> drivers/acpi/acpi_processor.c                 | 113 ++++++++++--------
> drivers/acpi/processor_driver.c               |  44 ++-----
> drivers/acpi/scan.c                           |  47 ++++++--
> drivers/base/cpu.c                            |  12 +-
> drivers/irqchip/irq-gic-v3.c                  |  32 +++--
> include/acpi/acpi_bus.h                       |   1 +
> include/acpi/processor.h                      |   2 +-
> include/linux/acpi.h                          |  10 +-
> include/linux/cpumask.h                       |  25 ++++
> kernel/cpu.c                                  |   3 +
> 19 files changed, 357 insertions(+), 115 deletions(-)
> create mode 100644 Documentation/arch/arm64/cpu-hotplug.rst
>=20
> --=20
> 2.39.2
>=20


