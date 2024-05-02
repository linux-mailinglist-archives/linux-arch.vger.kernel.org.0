Return-Path: <linux-arch+bounces-4135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96638B9A77
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512BB1F21F3D
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7003768F0;
	Thu,  2 May 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3k0aI6R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vvubaa2u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729B7580A;
	Thu,  2 May 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651893; cv=fail; b=CtEMkFH1VcJZtV4t8ClKL3R+dIpODKjrl9WvHaPNx59Mbd5XiXm9LR9MPmN8YoN60LuVbTW/SmdgCxla/WIU+d7sI8cX0gPYak6lc0z6MrL6R6BAT3c89CpK4rGRKRoFYjwBLiEzVD7GIQK689GQHWuBhHNUeo84aoYwrfqPa2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651893; c=relaxed/simple;
	bh=HNHKcIOksXR8DVO4cNSW7KCEDFd5yKetZiEZcAjPuic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LDIK+t7/yJHeA8LGEslidFE1djVmxIZ69GWxi1aYwfHXH66wq5L3RGbR8tYx+MDd4aU95acGsZ4AXsnctH0PrYmq32k1TkLix+GF7lM2FNkGgAm/rEGwg+ihaYt7yx0NXe/hm5OhMSRO/rrgRRwI+dzkjjiGx26LPpJLq23rurw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3k0aI6R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vvubaa2u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442842Ds013315;
	Thu, 2 May 2024 12:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WRz4cWlWZMzCJfh9iwrYT0akta/XfKd8uu9t/hYTDj8=;
 b=R3k0aI6R15uIyNcSGXLlc5r+Br5d/RB3/yFdIcEgTYSx8xAi/k/dJGe4HNpr1xIDZltP
 MpCg9M/95p640a4oqxai54wbjUfGAUn2sOByFa5LbE33XbNmgWDR49qAx1TI+HErjbVs
 rRFG5fs153BF2mfkpnDJNgiMbqstC/6fZtyDEMz8juAWlX/XchF3qbrAK/4MBeiwH7p4
 bhAjG4WbmEqAOJcBpPwdJjaRyslltGiHXAmlF3J9qXYT2jGmp3MKpgyxsJ28BTO95mTC
 DBQFxlRFusOc/MBunMVceoVALpxo1fhTaz6rKs/vxTlqvRGV55HW69vDqmyneJ8IOApm /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryveajn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 12:10:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442AU8FD039976;
	Thu, 2 May 2024 12:10:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtay8pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 12:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUYNoEHQ7YhMnnAIyXcLAOKSzOr3c3Xa3md5TkFi5+yscrt6LAqRb6X3SRNBzBIMUBO8PnfNolN7lHB9vACML0dqBdZBpxkGFafuzZe0eziWSILQPmbgaKAPPkXqYmXoHJxZVSNx0xSn0WxW2x7Gye+/Tm+wVXM1JZmfIWrGtSsSUeLt57DRlcHk098ppKKOYrXiLPlVAXfEACTeqJx2UaoYQE8ae4xR2sEVthgfvmik+MAHPir5d8KZd0KS243IDjGsIKm8mSbutv4V46IdLjeXG1UWQYQ8tnlr4KKCYMh55MF9M5sn+Sx6mfdDNLtHeSer8EabKNBekLVOh1kk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRz4cWlWZMzCJfh9iwrYT0akta/XfKd8uu9t/hYTDj8=;
 b=TeAh/5kWBqXSH1TL0kwmP8+iJGw7YH9o2/+mOcWvW4nQj1nSgA10tIV10UNl8JZF6mGWDLQ2T0nNBr8eR0vWJPGpn8dWNIClApcU0fisoB+PRxnoKpdZVWk09FiKTqEvaGgvdJm9wUquSjZ/zgvO4NCanbllNxkzwYJ+PAuNIyYUy1AXW2aADC5SzRAy8JH9kTEw3ssCNVtPZK+MuaJZzHkNrWgdB303Qdhh4BNcTGTOXk787y0StiDhjX/QdM9SOzzg9RjiBY/lujEgHNrNuEw5wz3kvRDGGeD4B/ECUOKecByUC4Ruf23g+Aue0vvl+zIu2H3auOOnjtfQicMKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRz4cWlWZMzCJfh9iwrYT0akta/XfKd8uu9t/hYTDj8=;
 b=Vvubaa2uvzVg+pqqWQDBS1hXFRbLjkFDYvF5PeDv9Ti7ac2dFCLYD3uWjr6t9XN+QrlgUc0rlLAra5uIyz4cJbZs8r0MMQMOie8g7hwkRHoLbSuAq2was3m82dV9u4G+yfqpS0+HwH9Y/TCpHWrJZLXfl+dWs66HkTCL9zxauMU=
Received: from CO6PR10MB5426.namprd10.prod.outlook.com (2603:10b6:5:35e::22)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 12:10:39 +0000
Received: from CO6PR10MB5426.namprd10.prod.outlook.com
 ([fe80::250a:29d3:cece:abf4]) by CO6PR10MB5426.namprd10.prod.outlook.com
 ([fe80::250a:29d3:cece:abf4%4]) with mapi id 15.20.7519.041; Thu, 2 May 2024
 12:10:39 +0000
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
        Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "justin.he@arm.com"
	<justin.he@arm.com>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Subject: Re: [PATCH v9 01/19] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
Thread-Topic: [PATCH v9 01/19] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
Thread-Index: AQHamwo7mwmZSVtyVE2+jzCcW0ULWrGD3V2A
Date: Thu, 2 May 2024 12:10:39 +0000
Message-ID: <7EC7B1F4-46D2-45D7-97EF-F75E83D44F7E@oracle.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240430142434.10471-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5426:EE_|SA2PR10MB4507:EE_
x-ms-office365-filtering-correlation-id: 709f8270-2e3f-4ae1-fac9-08dc6aa0e1cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NV5sVVz1np9sJCsA8niKa5yazQkjZbaHXRPndzr/UU/dp9094ZkZd5LWqVWr?=
 =?us-ascii?Q?Byi1Bkxa4cnO/W+KT7Ijxh9fB6YBzdyqY/HTbQoyV9abivv6hl8+KjZUBsPk?=
 =?us-ascii?Q?VQ8EF0kTHMEwR6FA+7ysy2vTnBug7Oi3fBvoFfOtM5mFLHx0mWPnVSkmFQEt?=
 =?us-ascii?Q?9xVfnUMEsZpT+SX/a0oReSMjJm4PoKE55oPZLfdvcrl+WdWm9ZfL59SsyBNj?=
 =?us-ascii?Q?CETMbJBaUllSQy9rxeMD7wIpI8sP6YHJ77QYX8sNtClzygTrPmM5x22mtqym?=
 =?us-ascii?Q?KGUtI0yiw9ckvSXm95k2WIBRwTsonqmclqSeE4tUrC8wetr6Ajf7tOL8FH0M?=
 =?us-ascii?Q?DouEHZAPMFhn5oh6q/yy599xSyt3hSZhqUfVr5eUDU+j6Uyp5RdQsjfoTOMb?=
 =?us-ascii?Q?JYLEVDba7PZV4GL2j9fu5eHEWw9rRvPm29lLuflb7Rha68zAR533VE4jtH5H?=
 =?us-ascii?Q?GYPSJNuX6GlZloI8x8rpsFnf44+9cMOZZEGYdqXeQdlWmnxB6IvXtmmzgcEM?=
 =?us-ascii?Q?LXhLsq7vH5CFThQL6OodqzUR2nV8YphjFmLeQaQOV4bj+BcDdQhKVQFbSHJJ?=
 =?us-ascii?Q?X6O5EBUcBKO/oRJNZKSezi0aRd/swkGXPokGZRgNxl7/6H5sAIRjnbBlXFk5?=
 =?us-ascii?Q?MD8FzfsmpZo1knXuZINeKOt4X0/OCNUzo62b3AcOFdD7vu3u8Pk0dxqP3Snj?=
 =?us-ascii?Q?d+Ifvd+MTUkxpc+/ibXcnnlYh5O2FQV5IiRp9pBzZ4GsoBzpMSDa0fLInDkM?=
 =?us-ascii?Q?PAz/7FRggg7WaCu+0NsdBZcNg2AC42aLZQHclkirXwjTyul3i7X7yLlHPTrN?=
 =?us-ascii?Q?J/ujU4741q2S8aowcwuJpuG51qth5asZUIx+gbcxmtGA2+cH1XF9W2P+HPr4?=
 =?us-ascii?Q?4DeBK5UJheoiWgFHw7x42nt8VbKXzJRy9TVEsNnUNf7ysNWnEig+iMk3H5mD?=
 =?us-ascii?Q?B0hEXrr/F8T+GsVVGlnVnnh/GIhgy1cScBuwO4kQ2RT+9M8F09CsFK34kkWG?=
 =?us-ascii?Q?pqU6t6OvkuWiRzseKz7ZVQhG9soomV6C4x9C+Rp7ZUfeLNjsBzuh2pRoLpZw?=
 =?us-ascii?Q?qsMRHK9BmobREIVKYquhZ2KmCf7DnHawEoFem2BOnAo7FTk0ujcf7lNJaEcJ?=
 =?us-ascii?Q?bJJa2zsw6TDnSK4BKr4mzlQrKy4QgNbq35N4Ka6SdwFI2xog1PYdyV+NTEt0?=
 =?us-ascii?Q?M7TZc/moenoLBW+BQR7yY3uaKe8eKyNpdUJn8traaV5dVexUnGU7TCkcW/TR?=
 =?us-ascii?Q?21WA1OgrTGzSvMxza9n04SnIFtJthcBoamTe5asoghhGdiASZKhdGhjYWtN6?=
 =?us-ascii?Q?4vtBCM36A8c5hZmUW7B/jLsBE/8FKygFyGEvdNiigaDVlQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5426.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?uMJekXTxVKvP4sLbAyxDRVJ7SmzjkxlQipDvqolr49DDLITDh1FLDkAdaWwx?=
 =?us-ascii?Q?5suklX3IbfL4QmhoNfnB8TGvIPl4fLFyz/zmmq1AjOOmE1RKq/ZNSo7ZlUq4?=
 =?us-ascii?Q?M/4iIj6xvMJanjRu/wEZPNd/5GKVPbFFZniN+lvkekesZWATF7xx3twmrEqP?=
 =?us-ascii?Q?ey4bepukyya8+J10xCblf7VuUrhSl4DrbFVeo7ROwZmmnibZBmfaGuJLur3M?=
 =?us-ascii?Q?rFPfyfQeJZjEMXVXs4fb9gr/pjBJ2dMOi6eu/BWvxZ1jYoWpV4iOQqrh1Uu9?=
 =?us-ascii?Q?4dBluSuHxEjK2ScJsAcmkRfq4uY/banqcZlzKUDFtONbghZsy95rjgSp+2Kd?=
 =?us-ascii?Q?4FO7nWEnW+w13wIYieSdmF2v3oN6icOqZ2DBYejJxIg3rVcDQMNzPoeOO0li?=
 =?us-ascii?Q?H9h8vqF4MNdDzgd6ry2lansn8FoyJKk50NrMSWxPRRKzK/lKadrb2DhS+GL0?=
 =?us-ascii?Q?jwzKVxz7IULrhFE3C0H2+Rb8cgQPXZ7rkr17fTN4podCfRUQerq+pPP2V/VL?=
 =?us-ascii?Q?sSUT23oZMrLOAPL9wxoc6e3auZiRTaCfmHTSUwt4LnErbebI1XbGbgyWQx4z?=
 =?us-ascii?Q?KpbRFPPQ2zohd+MlDl+Aa5sUQjk8i0AowplIa2rdUUbSR2tnWnpDq1+setKo?=
 =?us-ascii?Q?Fg1XeNVhaOxCsffgYACBu3FO03C7KUmdq6ETKuBVixQLOkOAS0hUiv+OwzXT?=
 =?us-ascii?Q?YhWCqijqrtJqWoB6qhatEUkaWB4W8ynlzIkPEeVLhCV3b9thTzfna6eZfGkL?=
 =?us-ascii?Q?oJUD113Ri+oZKD3S6iXWY3UTFyQ3pq3RF7x1UZx9mACkbGGiAqD0nVIzaK15?=
 =?us-ascii?Q?ZTacfiSZwpW1OuDoHZ1qLugfpg9U1B6idXZLpY/x9JBx5bp5aPN0jiMPSV3j?=
 =?us-ascii?Q?Em1PfzUps8pGPPzorBKk2hed/Yvv4eaN2FgypH4XGfqxMfMFhxiMsaVAF7bJ?=
 =?us-ascii?Q?n9ZwMi4W4LT+4nG7V4vjwNC02QUi9AEg+xGaUf0WdT0f0Q6iBB/l2OBlXW2V?=
 =?us-ascii?Q?jS+sHPya7LnR5y8b+NZi59nFu0JbRMzpfEG6E6ZssP1y8oKIVQQKCy21Zc1S?=
 =?us-ascii?Q?UX03PcPfswBvsBCxHPgGG1Dxrp2rla8SOLfFcUes+s+/Lo6vHlS5drtmGrqo?=
 =?us-ascii?Q?i9uPqAYlzuVDTpK+Q2T0uBkRkvOFHpWDSBZ8CcD/Bsh4PZryWjnRuLl/n5ZS?=
 =?us-ascii?Q?nhqFq7bEXIbXiNle4Hyr06JEkmyY0k7DEc89+bPqEv+LHBMO7KH45ZSMVBil?=
 =?us-ascii?Q?zSzdW+EBCzX+1wppDPvHc+Wcx9Wr8LGavJa4kysfF6kf0sIw1szXNaq5gxTY?=
 =?us-ascii?Q?uLUcnSipgbfxrTXWILDxsFYJI/SOkFknKKN0qxH/JGk703ZCY3RyaiE09FX3?=
 =?us-ascii?Q?Y9muRR+e2vlJBn6S2HCF5LNBTUlxR+4qaHC6widF1D2NXqclg6NASxA3YgWi?=
 =?us-ascii?Q?fO3StO2iZ2sCbGBqgcx33a6ix1q6BhepQWPHtMRZ0aeFEfaskG2K//GF1nKu?=
 =?us-ascii?Q?jjjluOgZdupT2Vp6SzkbqC8G17nwZj9adKk7qvqYWUGNsT8pn9AQ17bf3DvS?=
 =?us-ascii?Q?7aoIzcpbhiTtLnf1vKO5cCVO8oXND5gDRzVF3LbP8fB7h6grkyWbsvfCQLAF?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBB6D482D5B1094DA810A47DCED7AE57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KxZj4wjJhricEidGn712q093NOEPkgYPUatD1nps4ouv0dG9NK+SoaO5MTIfJBZabWwt0DccSlJAHzfTvQuN/LDpsDggwHBLqpzI2Tp/3ev/X90b0qpmcrDUbAftgCHhUKgV/Li/ZdDnOedhI7BpWIfXTcVPo1lm6xlMLb/Uj6tYsBYeI7lROdkHjRNLE3i2SyqWJk/wm5gkLsM7/5QtmZvTD4spbymtnS4vFKIK7hvns/pWTAJza8eq6idKRWh9GIujyFU9YdYbFTTvwAKI/A5ftinOJlubI77FXAQNiBRLGdaxMDXNmZt35ta3Z3LJnzTQx/Y9OqBejt25FX8cDAC22+n3F8AooC71OvanKBcTSSwpgji1rr74TW6Y2Y+0eKJGp/oQ1QjuTTODHzbgxVg5Lhy581EW03jaHYBaeAyBr7jqZRWlnPg5tQZ649S1lUrxoeJ/oOPgM77gh2jNzGTQS/3Ppc2E6SbeosCyuGMn32eNH7R0Zu4YI5CfDcuc3q4JAyH36/1a/ATP9p0iClZFiaYwNwkOlKdvEohI7F4ppzChfFQKvtt6Cpzia+qMEyD5ckWjcCjLdobGKrSGqmMu1Z/vkoivqGQRxXRq3Yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5426.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f8270-2e3f-4ae1-fac9-08dc6aa0e1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 12:10:39.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRslErDO5rcF30yu9qWRpPFOClggy0p/0LewWD6m8hJCW/icZMbIwUZ09IfXkojkxszExgsi2rK82qTQk3/UVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_01,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020076
X-Proofpoint-GUID: Y7lsyReFxk4QDTevaVNm9R31nV29vFre
X-Proofpoint-ORIG-GUID: Y7lsyReFxk4QDTevaVNm9R31nV29vFre



> On 30 Apr 2024, at 14:24, Jonathan Cameron <jonathan.cameron@huawei.com> =
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
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
> v9: Drop overly noisy pr_info() print and tidy up a stale comment about
>    the flag that no longer exists. Leave in place the note about delayed
>    init.
> ---
> drivers/acpi/acpi_processor.c   |  7 +++---
> drivers/acpi/processor_driver.c | 43 +++++++++------------------------
> include/acpi/processor.h        |  2 +-
> 3 files changed, 16 insertions(+), 36 deletions(-)
>=20

Looks good to me.

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

Thank you,
Miguel

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 7a0dd35d62c9..b2f0b6c19482 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -211,12 +211,11 @@ static int acpi_processor_hotadd_init(struct acpi_p=
rocessor *pr)
> }
>=20
> /*
> - * CPU got hot-added, but cpu_data is not initialized yet.  Set a flag
> - * to delay cpu_idle/throttling initialization and do it when the CPU
> - * gets online for the first time.
> + * CPU got hot-added, but cpu_data is not initialized yet. Do
> + * cpu_idle/throttling initialization when the CPU gets online for
> + * the first time.
> */
> pr_info("CPU%d has been hot-added\n", pr->id);
> - pr->flags.need_hotplug_init =3D 1;
>=20
> out:
> cpus_write_unlock();
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 67db60eda370..cb52dd000b95 100644
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
> @@ -115,12 +113,9 @@ static int acpi_soft_cpu_online(unsigned int cpu)
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
> ret =3D __acpi_processor_start(device);
> WARN(ret, "Failed to start CPU: %d\n", pr->id);
> } else {
> @@ -167,9 +162,6 @@ static int __acpi_processor_start(struct acpi_device =
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
> @@ -185,32 +177,21 @@ static int __acpi_processor_start(struct acpi_devic=
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
> @@ -279,9 +260,9 @@ static int __init acpi_processor_driver_init(void)
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
> };
>=20
> struct acpi_processor {
> --=20
> 2.39.2
>=20


