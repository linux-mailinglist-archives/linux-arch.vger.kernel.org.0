Return-Path: <linux-arch+bounces-6634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7506C95FB7E
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B955FB20971
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090119D89E;
	Mon, 26 Aug 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gzu+6qi0"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC25F873;
	Mon, 26 Aug 2024 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706946; cv=fail; b=J2VTDvK7nVDXvKvuuD8MxM2Q5Sw/Sh+Gj9+IANjQcuJFa8rbulzgZJrpvMYouhcxR+80sm2cKMXKqRylrbKy9J7gKblxd8OCaOhFrr7Ueo3xQ60jzLAm7VYfi/JyyLKWplbnfG7XE9WLn6E0zqfwPsbM+PFdWwW6719PurATm+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706946; c=relaxed/simple;
	bh=rTjPMSXEDVWXnuZLip2tQnrRfWYTiSX0ISeCPx+KWcM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SaQhSg6v8LIZhMhKY8gs/HkPgwbBFL2RAd4yoYow1H8XVfOfI/b3T9vmMN1np5dO5hJpQvRYneYpVbs/k/W7tHSdQdUSNMVakEBySXF+3VFYULbMwMIMIr0438fSpb8V2obykE3yWx9Tw0ptt0KcJZwe+41e7nDf4JOAtCzotBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gzu+6qi0; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+GQn5XbfUkws29U+Ubpzd54g2uywgJgkOliGjslR5BqhW+0wCOawGGNdj33jNMLTVVbiuJ+GzwHeLC+d7lX+k3n2PoFeB7/F93HZKhJ3RTg8mgztPiiveGecobi3s3/8M8AxdmWV9F+9iz1D7be0uB3RHoziAaH0U6+9nN8IAh3PMMcVX+MotgF+wy+zIp+xXdsbuFTXReekQoAsCoXF8CDkh7z/xHTFlul0khXmVSlzzEqHVn5NFJxM85h/2tyjMHkcRsqnR/Bohv94g+sU/oTsggPUD21dYP7q9YStppH+4ZaD8052gN7cDOOPhY+H9+OHlhdR5vFoZmt/yC3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTjPMSXEDVWXnuZLip2tQnrRfWYTiSX0ISeCPx+KWcM=;
 b=xv6JvROCwLsr0Q1PDOMNSSEyXPYJQT9OX3mGkvMXLV5myRFjnfK2WKKIlHLs4dOSU1RKf5c1hEY7kEYQvulqIAbfZwULT2cHcT2ApDJAKiy4zRyQ0WwfO6pUf37Cp9q7oBoOaRQSVV5qmopf41qZN17c7C+O2qqKocYxoP9SHwj8xg1evJ7p3Pl5X388Z9o3QLIggOIfViSPyAG1ADA6Dqh3r7E+XYS4SMd+lDWEuPcaO3xjvxhBfwp6H4qL2Bpi3qnolm6ldPDqrFb0wLb1mbN2w8JEaiDbfGMa2rv7O9M2EYyVnn5OpCtIcMqXEcPitBR7pOD8kYcoe6lcVWIStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTjPMSXEDVWXnuZLip2tQnrRfWYTiSX0ISeCPx+KWcM=;
 b=Gzu+6qi0HNE1LqPBXs3nwx3Al9xp2Fnp4y6iIzVf077VxLWWqWE82+9PBGYxu/dTm56oLZSSdfbqTRwh+bRikIwMABfSfsLYD0kz9TMMOBFySowtunGgrdV72C4Kb3MFXzP3WVXeNavF7mcmFklCUUnJInWF19ieWWXFTrZqMfEqKs/fI9sD3wxqTdSNlyXQv/nwcaMjx46rZpg+ig/L6qkNlsW4YZQ2UGMYQZzvLwQCo6VUFHtlxcKz+Rt5iivMCyUFEUZ0otwoulQ8QXnzG6aXErOPqc9j0DQzYVGvCNeM+6DCse4A5m+9t7UUSpLMQHAkvlyliNb2cPcMUnkvuw==
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 21:15:40 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:15:40 +0000
From: Bruno Faccini <bfaccini@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Williams
	<dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Heiko Carstens <hca@linux.ibm.com>, Huacai Chen
	<chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Jonathan Corbet <corbet@lwn.net>, Michael
 Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Samuel
 Holland <samuel.holland@sifive.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Thread-Topic: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Thread-Index: AQHa9/0a7es2eLyRGkG9+lne4kWHMw==
Date: Mon, 26 Aug 2024 21:15:40 +0000
Message-ID: <DD73CF88-F809-42AB-A134-1A0D77C96BE2@nvidia.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7261:EE_|IA1PR12MB6604:EE_
x-ms-office365-filtering-correlation-id: ba6a85ac-f2b2-4fc7-64b6-08dcc6143d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3Rodml1MTRKVklTTStBNU9mTmhmdm1SZy9jZHZ1MFdvRDQ0bkRXMVFjVFMy?=
 =?utf-8?B?ckJQc0Y4NkEwZ2QzOUZTV3F4bjk2eE9valNSNlc0NFF6cDVFMXdXZTJTa3lR?=
 =?utf-8?B?L1N5dVJwQW1UMlhQcVdhUUhIeGp0d3E3RERwOXFXZG5ERFJZaWRCUkVDV2tW?=
 =?utf-8?B?dk85QTUxMnhReHNnT0t1VHFYYkZkK2M5SXp0aHFKT0IwVVlWa0JxYTJIUVRO?=
 =?utf-8?B?bHBkSnhKelhPK1pzbGNRU29NMVdUY01mcHhHajVvazcrR21lUUhTZjlEUnBE?=
 =?utf-8?B?WU9RbGluRHVqdmN5RTZxRThueXZVUDlYeCt0SFFDYlp1WTZTQVpBeDllZFIx?=
 =?utf-8?B?eG5lUnlqQk9LSUVaK2IrS1crcVc3Wm9leHhtTHNUNCtlWjE1NVpyR01EVVBo?=
 =?utf-8?B?bll1RWVITXFFYUMwb0p0ZExUMTJtQi9MT2tmTzBNRUlrRXg0N054K3R0OFE3?=
 =?utf-8?B?R080aURVNUNQRENXNmVDdEplRXpodFZ6ZGtrQ3RDV2FEU2dwOTdaZlYycEFi?=
 =?utf-8?B?eGx0ZkNyaWpDcUlpN1dqOVhnTmR3VW5FblBDRHVtS3psR0FnL2RibHByWXAr?=
 =?utf-8?B?Y0EzNWc2Q3pOUzRaN2FnUlBBUy8rVjVxclRtbW1SOGxZZm5jRUY5VE51bUx3?=
 =?utf-8?B?YWhrNHJmK1M1UEo5eWt6MjB3YllXYU5tQnM1S3BNTVdVMzU2RXJtaTg4ZUhv?=
 =?utf-8?B?eWtFdmhLK05xbnJRNUNFZDU1dVptS3ZFUm4vZEd1U25BcStoaFFIa3duSCsr?=
 =?utf-8?B?NktyTWtCNit3ZDBoVjZRcTFNRTU2b2diKzd3UVdKaDdwVXJ2dC93SEY3cU5X?=
 =?utf-8?B?dTBDVEtQc29SMXRJdFpvZ1MyaENYQnU4c2RjL3RadzkvNUlxeTRKcVR2eHRj?=
 =?utf-8?B?anBkRFpxTEFOMjBwL2NCZkpCNmVzcGY0QTBTZVFWZlJLQ3UyalpLaHNxc2JN?=
 =?utf-8?B?cFdKZVdSdjAyTkVsb1pKOTFJOFR0alRMemVLS2xzZ1YyRllwekJOOVpkQTdF?=
 =?utf-8?B?aHRGTnp4NXl6K2UySis1SzhtYW52RDNMWWNqcjBsSm0zMXYycG5pWHBnSStz?=
 =?utf-8?B?RncxcS9HNnd4ZUJSVzJWN21vUkRlSy96RGRsOUdpeWxROSthd1orSVR1ekJo?=
 =?utf-8?B?TVJHempLVVRZVU0yelRKcUo5TEx6TkI1NUVUMHVoNWp3WE9nekZ3dm1tWjhq?=
 =?utf-8?B?dHdBTDdTVFZNaExyV041UkdCeVhoQWdGT0M2U0E2TWIyYXU5dUJFc1Q1bUlE?=
 =?utf-8?B?S0QxSXB6RnpFREJ2b2lmZEY2bjhYYlUvZ2FkYW9uUHlIU3MyY1RBVzZNbWNM?=
 =?utf-8?B?QklpQzlOV1l6emU0eXRtY0NIb1liTVpZclB1bStISVRiSFYwVnhwS0J4Y2Zz?=
 =?utf-8?B?cDZaUC9iUUl5WjZKbnUyNzd1VjFRQStwL2wvaU5adW9pVzFaMitEbW55OVpN?=
 =?utf-8?B?WDJIT2JQZjRJSTBFZTJYcEpuL3V1MUtFN25xTExvbzJvTGw0a0ovTFZvVXBX?=
 =?utf-8?B?RDNsc0U2VnF6RDVEdG40Q2x6LzE3TmNGUVBCMVF6bkVkSEN3aHdmQmYwSUs0?=
 =?utf-8?B?dWE4L0xmNXR6Vi9udkdQSUNKZDlUejNmSElHSWJJaGl6cmV4ak5kdVFpbWRO?=
 =?utf-8?B?bEZwbzV6d2RLOVBhR2Y2QURNZ092MGQrZTZHZVV5YWhvU20rV3FSTHhZaFl6?=
 =?utf-8?B?KzJvK3lBQnhOTnk4eFMwQmpINXl4VjJlaE5yWmg4NjlCVmlaNm5rU0xMQkt2?=
 =?utf-8?B?bTd0a1dmNStSb3BYYnQzNGxBMVZMd1UyaVhveDZrcFB3bExyWkdBMVhKSXlO?=
 =?utf-8?B?UTZhNFlWeEY1Z1JTM2VZbWEybldIdnlkSFhiZkFXMk9SMEUxaFB4WTFneWNp?=
 =?utf-8?B?MWl1TjhMVi8zQUVGZFMvOS9YcXdPZjI2MlpIZ09WS0I2emc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUhic3hEeHpkZkd1WU5MQW9GUjc5VXdwOXVnZ0pnVk1na0crcW14bk5PSVVI?=
 =?utf-8?B?bzdIZDlwdEt6L2lPM1piLzVYSEdlV0dMT0RBczJYN2NPVEdCT2lzMHZJWlRY?=
 =?utf-8?B?dG90V2V2VHZhaE95SzI1NEZtZXV6aDBxYlk0cFplMXZUU3hZTFRRVHBJc3h1?=
 =?utf-8?B?NFVIVVMxTWhkaXJDWjIvMkc2cW5TTERrTlJlK1krcDg3TkVZTEF5K01hZkM1?=
 =?utf-8?B?NEx3YldwZnFNWDlWUnJkdzcyVHFwb0oyNXEzY1NndFdvdEtUcFFQVzIranA3?=
 =?utf-8?B?THVNMlM2eENkQVhuQ2dqUUlJUVkyYlZKcUFYM2gwY3JFNmZrTnRoSDVacWNT?=
 =?utf-8?B?d0wvZFJ6alF4VkljM1ROR25WRFNHcnYwODhqUFFKWXpJNmtTSlB2WndabFc0?=
 =?utf-8?B?aUtZQUorYmcwQVhqZ3hyYnBpT1p6Z2pTbkE5TDZFbTcvaDNiN3hmMmNUSU1m?=
 =?utf-8?B?WDlYSlZZMlF2c0RRanUvK29GRjkxNVBGa0FuTDlHYTJiNjNab1B0dkV4WGRX?=
 =?utf-8?B?MVBoQ1djUldBS0Q4ODQ1Ym8xcDloK3F2bXFwWVdKUFJKYmEyQXJJd0VaVlhI?=
 =?utf-8?B?aVQ0c2JhNGpaV0RzYmJKS1oxaW1aMmNsZnUwbzV6YmY2dllKMnRDRXNxdEh5?=
 =?utf-8?B?a3EzcWRaTTJtK1QzcU1XT3BSQ3NtbmU5RWlRRXFjK0FmWWlYeEtEZ3Q4MDNs?=
 =?utf-8?B?V2FIUjFqMjJxcnhSTXhoZERRQnVnRnVRaWVqTnZUSjh4ZVlnWVZiNFZXUUpy?=
 =?utf-8?B?MFVZT3dEai9vaTB5d0tuNXM2eE93VU1GM1IzeVl1ckdvbXExYTdJdGhWZGhk?=
 =?utf-8?B?T2JxWnFKMEVIV25VcVRhTlJsRXY4RTJpYXhPUXB0Rnc0S082ZWFLTWZES2xN?=
 =?utf-8?B?RlQ4ZTZ4b055V2FwNTB0OUh0a3IyZFB4MjQ2UjBGOVhqUUMxVUZ2MTFteVlV?=
 =?utf-8?B?bmtQQjNqOFE0UitVclN0ZFFSQWpBbE5La1RlT2RLWnkyV3VLL21oK2RqajFj?=
 =?utf-8?B?SkIremhFREhEbmV6NXRSb0NEWUY3MTNWeXZFRytzMGhtajhaNHd5NFpud2g4?=
 =?utf-8?B?ay9qNnZDOXhKTmI1Z3VIRjFibGd3N0hBU1FPV2FlbGM0bzVVUmdCWGZNcWxX?=
 =?utf-8?B?aEt5Y2U1SlA5ZUZvalRwSTNzUU0rdGVmYmZBeCtCbGdUbFlRQTJDSk8wdVZJ?=
 =?utf-8?B?bTJEVEQ4VWtVSzRscllxaHpLSHJiWFB1bmJBL2MyUkFVWnZJOWlXOEVqV1hP?=
 =?utf-8?B?ZVFTSkRpMiswWEF0UTB5Vmwvckw4OUlKWEZ3dnE1M25KM1p6Rjc1VFc1eC8w?=
 =?utf-8?B?cTNjMnBOYUFSTnFZdGRvQjJJZ1Z6QUlVL2pXZWZSVVBGeXRJUnFyL3cyL0Zt?=
 =?utf-8?B?ZzB4bGNJNWNnTnhtcWVuejdIR0xqclByazlyelZRdEpoWHh4RlltRUlRT2E0?=
 =?utf-8?B?S25QRWkxQ3ptMkY1UnZTZEF3dVpzYlN0cGo0U1RFc1ZiekNIV1VLajFvd3hC?=
 =?utf-8?B?YnR0bEFmM3I5dkY5bGRoUGRzLzV5T01sYVdRU2dCVTJIZENJcFhuaEdVcjYy?=
 =?utf-8?B?WmZUQVhKWWh0Y3lFMHdqU290MHJzWCsyQ3pxcXoxNnVUL3JlQkZ2VmFsUGpG?=
 =?utf-8?B?Z0tTTEZKZUlsNmpjTllzSjk1TGpNcTJwZ3djMUhtbkg4WmI3czFzbmJQSjdm?=
 =?utf-8?B?WnBXSW5jUU9zUzAwZEpIcURlQ1Y1YzZtZlFTbkhjUHpiZmt5dnc5WTZ2UFhP?=
 =?utf-8?B?bE5hVW5sQzVpVjAwTzFKS2VNTkZoeVBTMHByRHE1SjFkamdhb1F0dDFZcVlC?=
 =?utf-8?B?eFI4M0daMCtsdkhzLzVpbFo0OU9uN1BBWE5DcmRMc0lnQ0E0NDNEc1lzNG5y?=
 =?utf-8?B?cGZPRGxHa2FtNm5CSUNnYlNnbmw1TlF3TkhZR1BpQlhKR0l3ejlhb3J0Qnlw?=
 =?utf-8?B?QVZla3ZHTjAyL0dMQ05DajduNmowUXkrL3ZOM2tNQVFPc2VGaWhybmpORXUz?=
 =?utf-8?B?cFFabk1hcXlXZWtsOTFibXBVZDRUWGZqUXNTMlJDQmdWemxMcENHNjBDL3FQ?=
 =?utf-8?B?LzliTGRpT2tRM0RZWTlYQ1VmSUs2dm5HNzFhbDNlbFFiZ3ZFMEZPdkszVGc3?=
 =?utf-8?Q?MeFZ5MzMJOdPFVJir7WxLo0cB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AF46B345CB41042A1232F71A0C9EEE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6a85ac-f2b2-4fc7-64b6-08dcc6143d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 21:15:40.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXzyMgNLwY0QXR4k9ihX5/VNzcZ3NjBGbRtjPKX8V5l9pgU85Hc8yKR4XNHu1Q+7nGI5Ybn+0rue1yiCIvp6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

T24gNyBBdWcgMjAyNCwgYXQgMjo0MSwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCiANCkZyb206ICJN
aWtlIFJhcG9wb3J0IChNaWNyb3NvZnQpIiA8cnBwdEBrZXJuZWwub3JnPg0KIA0KVW50aWwgbm93
IGFyY2hfbnVtYSB3YXMgZGlyZWN0bHkgdHJhbnNsYXRpbmcgZmlybXdhcmUgTlVNQSBpbmZvcm1h
dGlvbg0KdG8gbWVtYmxvY2suDQogDQpVc2luZyBudW1hX21lbWJsa3MgYXMgYW4gaW50ZXJtZWRp
YXRlIHN0ZXAgaGFzIGEgZmV3IGFkdmFudGFnZXM6DQoqIGFsaWdubWVudCB3aXRoIG1vcmUgYmF0
dGxlIHRlc3RlZCB4ODYgaW1wbGVtZW50YXRpb24NCiogYXZhaWxhYmlsaXR5IG9mIE5VTUEgZW11
bGF0aW9uDQoqIG1haW50YWluaW5nIG5vZGUgaW5mb3JtYXRpb24gZm9yIG5vdCB5ZXQgcG9wdWxh
dGVkIG1lbW9yeQ0KIA0KQWRqdXN0IGEgZmV3IHBsYWNlcyBpbiBudW1hX21lbWJsa3MgdG8gY29t
cGlsZSB3aXRoIDMyLWJpdCBwaHlzX2FkZHJfdA0KYW5kIHJlcGxhY2UgY3VycmVudCBmdW5jdGlv
bmFsaXR5IHJlbGF0ZWQgdG8gbnVtYV9hZGRfbWVtYmxrKCkgYW5kDQpfX25vZGVfZGlzdGFuY2Uo
KSBpbiBhcmNoX251bWEgd2l0aCB0aGUgaW1wbGVtZW50YXRpb24gYmFzZWQgb24NCm51bWFfbWVt
YmxrcyBhbmQgYWRkIGZ1bmN0aW9ucyByZXF1aXJlZCBieSBudW1hX2VtdWxhdGlvbi4NCiANClNp
Z25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgKE1pY3Jvc29mdCkgPHJwcHRAa2VybmVsLm9yZz4N
ClRlc3RlZC1ieTogWmkgWWFuIDx6aXlAbnZpZGlhLmNvbT4gIyBmb3IgeDg2XzY0IGFuZCBhcm02
NA0KUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4NClRlc3RlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3
ZWkuY29tPiBbYXJtNjQgKyBDWEwgdmlhIFFFTVVdDQpBY2tlZC1ieTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQpBY2tlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+DQotLS0NCiAgZHJpdmVycy9iYXNlL0tjb25maWcgICAgICAgfCAgIDEg
Kw0KICBkcml2ZXJzL2Jhc2UvYXJjaF9udW1hLmMgICB8IDIwMSArKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQogIGluY2x1ZGUvYXNtLWdlbmVyaWMvbnVtYS5oIHwgICA2ICst
DQogIG1tL251bWFfbWVtYmxrcy5jICAgICAgICAgIHwgIDE3ICsrLS0NCiAgNCBmaWxlcyBjaGFu
Z2VkLCA3NSBpbnNlcnRpb25zKCspLCAxNTAgZGVsZXRpb25zKC0pDQogDQogDQo8c25pcD4NCiAN
CisNCit1NjQgX19pbml0IG51bWFfZW11X2RtYV9lbmQodm9pZCkNCit7DQorICAgICAgICAgICAg
IHJldHVybiBQRk5fUEhZUyhtZW1ibG9ja19zdGFydF9vZl9EUkFNKCkgKyBTWl80Ryk7DQorfQ0K
Kw0KIA0KUEZOX1BIWVMoKSB0cmFuc2xhdGlvbiBpcyB1bm5lY2Vzc2FyeSBoZXJlLCBhcw0KbWVt
YmxvY2tfc3RhcnRfb2ZfRFJBTSgpICsgU1pfNEcgaXMgYWxyZWFkeSBhDQptZW1vcnkgc2l6ZS4N
CiANClRoaXMgc2hvdWxkIGZpeCBpdDoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvYXJjaF9udW1h
LmMgYi9kcml2ZXJzL2Jhc2UvYXJjaF9udW1hLmMNCmluZGV4IDhkNDk4OTNjMGU5NC4uZTE4NzAx
Njc2NDI2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jDQorKysgYi9kcml2
ZXJzL2Jhc2UvYXJjaF9udW1hLmMNCkBAIC0zNDYsNyArMzQ2LDcgQEAgdm9pZCBfX2luaXQgbnVt
YV9lbXVfdXBkYXRlX2NwdV90b19ub2RlKGludCAqZW11X25pZF90b19waHlzLA0KIA0KdTY0IF9f
aW5pdCBudW1hX2VtdV9kbWFfZW5kKHZvaWQpDQp7DQotICAgICAgICAgICAgICByZXR1cm4gUEZO
X1BIWVMobWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpICsgU1pfNEcpOw0KKyAgICAgICAgICAgICBy
ZXR1cm4gbWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpICsgU1pfNEc7DQp9DQogDQp2b2lkIGRlYnVn
X2NwdW1hc2tfc2V0X2NwdSh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgbm9kZSwgYm9vbCBlbmFibGUp
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoN
Cg0K

