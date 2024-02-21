Return-Path: <linux-arch+bounces-2585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0B85E1B6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD4E28762F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAD80BE4;
	Wed, 21 Feb 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="hKq+HNNu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393857FBC0;
	Wed, 21 Feb 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530351; cv=fail; b=dDv//9AKtiImmSdJRbE11ES3fZUMPbv5rOEdp6aDe8VjrRHdrlrQCKadB4I2doKEUcsZD6vIgPPmWoX5d84lWmX27P7lWJw9hwS3MLpKffg5QWNE2rwOtEm5/2ecFhV62c9m1zAG7iVDhSCfCM+30RPtKGGEDhxxoBTH+yTWuLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530351; c=relaxed/simple;
	bh=001nv3w1nCax1VFqAppcvmEoIQEaObOZ6q27qzGokMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRLNA8IgLjKsxtgLMO1r1YyDRWP2aa3J4mkKMSwmSDl+m2IMo4E+jOs+WNrU3Kh445myhup6jCqB7js385lcaB1ZOB9tkisdeKzsiiiC8VN2XSneTpaGLtoyn+33do0qwO/Ui2Mn95U2/paLBcJGIphlr+vJF+50uUGItQZMRrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=hKq+HNNu; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 41LCfC8i003869;
	Wed, 21 Feb 2024 15:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=001nv3w1nCax1VFqAppcvmEoIQEaObOZ6q27qzGokMU=; b=h
	Kq+HNNu7cZO8jlhAnjASk58yKfLTIyp10TgEmnPe+NxSt58bEqE+eJZMg4sYwkSu
	EhTh30gk0x3FSkLsCKgOGUZ9hdmYfIVTcVn4c8KtDyPv0V3YEASOnE/25Em5PJnI
	a+zSM/rrEVaesKarhS9SAYbve/IDBtmJH9pF5pnh5FhPpkA9dDBLiu1cmDnXABkz
	15QtNUCxczplyCTW5MmGQQfXSTsTJWtk3REk/xXQv7IK3VxMzBifRXxIVQAzGnue
	FcLxMpjUjF1L/GMwNPqYRlj3xVff3Xz+MwVBEVrHvudUcfOALpFcsdWs88yDQMMr
	P5tt5OuPwBwXa6BJnQuoQ==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
	by m0355088.ppops.net (PPS) with ESMTPS id 3wd21x2sy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 15:42:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6OWsc1itzUuLyeWVeTIB8Rf92jJtaEN7tq3WOEm3cmySd9/qFPZivY7H9jG/aTB2iuJ+GoSTyOR7r2YXsO1/AbnG5LyB99mZW59KlOmT+3uIiMJBPGsIaKrZ+v4zVffWPi8FdZvNfnKcMl9yFhSDbfuApYRQjkEk45hhVxJMWV7t+1LOCBQg9/qSFCq3Qw6qa3+nksLpTecXNz1q5ox/48q7euyXg+QchUYB46/k2P3zq3+Tx+r42mXcjLaFjfW8W6gzD0rFkUH1rFfR+wzGAxPpSVFnXNJ1bqR20bOSzjpVbDwUaQ7OybAHumLLZPp6YdAfDwhwyxV+u6wse9nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=001nv3w1nCax1VFqAppcvmEoIQEaObOZ6q27qzGokMU=;
 b=LXxfoNZqwRHRhBxiz1Gs1+KpTp56b+Nt+rPK0rdrNKycCd8EjntUchj89UnmhHHtlmLz81971TBiUOO//L7bxOXSeFn4kaP1O/EV/oTsu6f50FDiZ705WrgCx8mvDWW9tvNmQ5+bexPm0Vu6xCcdpslSlyNsGuGTHlmduwY5+Qtdl8lwbuR9UJP1qkSy3XiZODGuMwTq3UROLteCpkqXrNlQ0qL3MHNjTwrXoDvXc9zp1F1UbrajlGqXUBlkOx6/cNX2td/HoTdYsBA3IQw7ESa29qMRAnJ/jjqp5PluWS1DqbSeX7Oylgnnps6kYyjyJP+gQFyN5BriG8Z+P2LkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR03MB7106.apcprd03.prod.outlook.com (2603:1096:820:d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Wed, 21 Feb
 2024 15:42:31 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:42:31 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "ast@kernel.org" <ast@kernel.org>,
        "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>,
        "cl@linux.com" <cl@linux.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "dvyukov@google.com"
	<dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "guoren@kernel.org"
	<guoren@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "hch@infradead.org"
	<hch@infradead.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "meted@linux.ibm.com" <meted@linux.ibm.com>,
        "michael.christie@oracle.com"
	<michael.christie@oracle.com>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mst@redhat.com" <mst@redhat.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>,
        "quic_nprakash@quicinc.com"
	<quic_nprakash@quicinc.com>,
        "quic_pkondeti@quicinc.com"
	<quic_pkondeti@quicinc.com>,
        "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>,
        "ryabinin.a.a@gmail.com"
	<ryabinin.a.a@gmail.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "sdf@google.com"
	<sdf@google.com>,
        "song@kernel.org" <song@kernel.org>,
        "surenb@google.com"
	<surenb@google.com>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "will@kernel.org"
	<will@kernel.org>,
        "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        "zlim.lnx@gmail.com"
	<zlim.lnx@gmail.com>,
        Andrew Wheeler <awheeler@motorola.com>
Subject: RE: [External] Re: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd
 configuration
Thread-Topic: [External] Re: [PATCH 0/4] arm64: mm: support dynamic
 vmalloc/pmd configuration
Thread-Index: AQHaZDwWYaEUphdXfk6h1XMsSOUd1LEU4kGAgAAM4XA=
Date: Wed, 21 Feb 2024 15:42:31 +0000
Message-ID: 
 <SEZPR03MB6786CCB9C8071EAA143C246EB4572@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240221-ipod-uneaten-4da8b229f4a4@spud>
In-Reply-To: <20240221-ipod-uneaten-4da8b229f4a4@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR03MB7106:EE_
x-ms-office365-filtering-correlation-id: af590ce6-111e-4bd4-9e7d-08dc32f3b776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /Yv06vKHWKs7wI49yiVin9RGAI1xBkhgNCULBiL+rIQxhVgPi1k2b6jvXOUqwJpl1oNt8zr2whqYj6bUGlhhXy+6cEAhTaAYrlcyUsCatlLk99z/n7D0oFO666gHQ7KakIjmA4qUhy1/Edx5t65WjgmzbBgsdbUd/mBTrQFdJoowjGKHkP+fWscznT0dOBD2zmbMHG/+hTop4Wphhtq6n4Wpi9nvjEQN7dxLYF5x8mQdx/HO4hznXFiObdepwvhtqlAX/Se0gHVFQi4zem5Rzf8gFJ3xf9f4m3nao6eYZdrTj35tOSjQ+xfki7f7apHdBwpqbu1IX2EiDIjNE6dHVhmhimjzSguwX6XHMZPEoTl8fYb88OsmbCT8G0RNZ2Z08GE30ApkgUQ8uhfgVuUQzePGym4FFA2azvsBnCRV+cZKhbBmtw7r5b0nIvdingSWqsX07O8GpYWC40wDgITdXfQaeRXIIvI5HvLUdS4HETJWdCVImpNlzUVjglwzMwbZRkLczJtXZE1vs56/fwAXFqgsf8wt+0MXCAkkkAFYgGhD+37WrnWdr6aby1WojTUPaJXwWxAX/LSw4Ykix9aZLIoF83WONvWXukDL2kachHFHpeSfI8TOtW3BWCuIo7lS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Qm01eTRFOVNxQUZiQWQ1UGV0WnVsWlZKcnpqdUJJSXhuR1RONWJKeVNDcVFX?=
 =?utf-8?B?dXFHMnVoeENTQms5RS9nSUZlZ3cxa3VPbmxYYWRvc1FtaEh4R1MrWHVNVk5V?=
 =?utf-8?B?dzhESkg1RGxuMWlqWFkxaDY1RjNTSFVkemhmblZaT0dxWjA2YXdmMWJWWnlE?=
 =?utf-8?B?Q1kxYTFzbmdMeUExRGdlWGdySjZOM2tHWFhhYklGbmNnMFdQTGdsRldTY3Q3?=
 =?utf-8?B?eE5haTZwK1NJVDdZSnpTaEdaMVVVNXN0MlNvUUxBdUZiWTQ2Q2VJbndjdnBj?=
 =?utf-8?B?STM3ZnoyWkk2cldmczB5bXRhS1M0TW1UcjVRTTZudExYUlpxckxyL1cwQ3JW?=
 =?utf-8?B?L0N1MWluZzVKQ3NmM2phYmRoNVFGUVphOWRlb2lRNUxkMGZoYXYyb0c1bjVY?=
 =?utf-8?B?bUFQQyt1RHhsNXAwUnJtVy9IenJVUmtBSHBsYXZoQmpycXN3QUFmQU03K3Ev?=
 =?utf-8?B?a0sxUWE3QUE5YXdqQWJRT1N3NmZWR3FJbXFSQTZVMElGUTVwUnA3Y0t0eFV3?=
 =?utf-8?B?NHQ2VFd3a3VERTZrM3hVZkJzMTZWT25JQUFFU05tYU5NUXFFUkgwKzFPZUlM?=
 =?utf-8?B?WUo3TXVTdEs0YWtrNVNvVlhTcWVaQUxmc0N1aTZmU1hLT0lBNWR5YXlNRlU4?=
 =?utf-8?B?aGdKK0l0RUJmQjB1dTh6VDlHR0VNV0c3VlRLbFJLTWNIN1lTemtvNTM5dWNx?=
 =?utf-8?B?bGZjUVljWXdsaDgxamdTWDRUL3ZrbEdSTDAyTlJpQS9wTHRqd21TYlBwOE1O?=
 =?utf-8?B?OS9Dd1c2a1Q1OUNBWEltSmd5dU13Zm1WdU51QzhMaVhtOGpUKzIyT09JMlp4?=
 =?utf-8?B?am9WRStUR2I0Snc3TFlqRUloR2duTzhKc2RrOHBldm1EMmsyVWJJUW9aWE80?=
 =?utf-8?B?eUZoWHpKbVRGZTFDQmI1aThGaktsRUpNMVVZa0J5QWxXTUhQVGZMSkJtLzBK?=
 =?utf-8?B?UkE0QVFqR1VwWTdGNnBDM0MvUnFNRHhNZGNRak8vazRET2QvUjVMVUc0ODdB?=
 =?utf-8?B?aEZiZlNsaFdieEQ2NnA4UjFjSWFuZFZWOUNnYjlMMFdxVlU5OWVrcXBxYUV3?=
 =?utf-8?B?aHpqWlNGZThzclRnTkE1RjB4UUFCd1NTYnNDSGJIb3hwQ3FnTnRYeTczbTRL?=
 =?utf-8?B?WW4wcXNQY0hVVWRIbUx1Szh1UjBQOTBLbEo2QmV6UXVzNTVJcWxLQ2d3QThp?=
 =?utf-8?B?QTF4eUlESUVtendLZXEwdkpMZDlEQ0pIcEcyamsvazVCV3Q5YlRqekxBdE5X?=
 =?utf-8?B?RlpPWkl6OGQ3bHUrbDNXQXl4SXZweEl1SmsyYkJLM2g2R0JCWDVBVkwyaW0z?=
 =?utf-8?B?WStHQlBxekJrcERUcFQ2TkhlbHNPSFhBeUdFVnJidmI5RUVabUE0M0gzSE1x?=
 =?utf-8?B?NFpZdlA5VitTMGQ5cTBzQjNRRHdnR29NNzFTNzNDT3cydk1RNjVSOGQ0d0FH?=
 =?utf-8?B?ajhHZG9RdHYyQi9zYkpsZHBadjBmTFRLb2RvUy9TbHplOFJnNFhYY3ArbWNv?=
 =?utf-8?B?d2U4WXZnQ2Z2ZnVwUkh2aE9LQ0hFWGE0SkNjNTUrNjR0MVhVemRsNitTYkxD?=
 =?utf-8?B?eXAxL012ejREaXBpT3Z3dnVUNDBOeCtWaVhwYXBEemlkeStCQjY0a1lBU1c1?=
 =?utf-8?B?MnhiQzBHRHZFTkJYeitPOHFLR2F3WjZYOGdVcXJBY2RSZms2dmJvcG9wMGpH?=
 =?utf-8?B?dVlVeEJKendFaGJpeS9KbjFyKytjNmxTejV5N1lac1RsYlpTdnZ3NWtSeldk?=
 =?utf-8?B?K29FNUExUmsyMFRodTBtMFpJTGJGank0NXMyRFV5THZBeXFJNitzUC9kSG1I?=
 =?utf-8?B?WjN5a3pGYXpaeDJBazR1b0xIbjBDV1Q5b0dhcjJxcXIzbCtJNUljMUxFMGFB?=
 =?utf-8?B?NDJLcTlkaS9IelNDbVdzbFJNZE52RThqT1RNYXhOVnY3R01VYnZUeFJTSjVs?=
 =?utf-8?B?LzMzNnZzUHloL08xZlp2V1dwSDMrdHZ0WGFjaHRSeVFpNlR1Q1N4QXYzSk1z?=
 =?utf-8?B?SEFjYitWOENCS2JtNDdRQUNtT1dHS0NJTlhoRnRMbHFMYlYxWFg2VFVPello?=
 =?utf-8?B?cjBBNEh6U2VnZWRuQWs0UXQwdWlPaHcxRVpKNmhUMlVYcVV4TWZVM1JmVEhU?=
 =?utf-8?Q?/mZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af590ce6-111e-4bd4-9e7d-08dc32f3b776
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 15:42:31.5953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I02FLoE/179LVLp7WiDF/PAC1nWUqGpbW6SrnF6b19HYGX+T7Qv+ZCNNLeRMR9rJHtpzjIS7ceaSbXo6dp3mzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7106
X-Proofpoint-ORIG-GUID: 8e7kxaKy7R84tzDdYam3XybMEgvXrbl2
X-Proofpoint-GUID: 8e7kxaKy7R84tzDdYam3XybMEgvXrbl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_02,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=751 clxscore=1011 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210120

PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+IEZZSToNCj4gDQo+ID4g
ICBtbS92bWFsbG9jOiBhbGxvdyBhcmNoLXNwZWNpZmljIHZtYWxsb2Nfbm9kZSBvdmVycmlkZXMN
Cj4gPiAgIG1tOiBwZ2FsbG9jOiBzdXBwb3J0IGFkZHJlc3MtY29uZGl0aW9uYWwgcG1kIGFsbG9j
YXRpb24NCj4gDQo+IFdpdGggdGhlc2UgdHdvIGFyY2gvcmlzY3YvY29uZmlncy8qIGFyZSBicm9r
ZW4gd2l0aCBjYWxscyB0byB1bmRlY2xhcmVkDQo+IGZ1bmN0aW9ucy4NCg0KV2lsbCBmaXgsIHRo
YW5rcyEgSSB3aWxsIGFsc28gZmlndXJlIG91dCBob3cgdG8gbWFrZSBzdXJlIHRoaXMgZG9lc24n
dCBoYXBwZW4gYWdhaW4gZm9yIHNvbWUgb3RoZXIgYXJjaGl0ZWN0dXJlLg0KDQo+ID4gICBhcm02
NDogc2VwYXJhdGUgY29kZSBhbmQgZGF0YSB2aXJ0dWFsIG1lbW9yeSBhbGxvY2F0aW9uDQo+ID4g
ICBhcm02NDogZHluYW1pYyBlbmZvcmNlbWVudCBvZiBwbWQtbGV2ZWwgUFhOVGFibGUNCj4gDQo+
IEFuZCB3aXRoIHRoZXNlIHR3byB0aGUgMzItYml0IGFuZCBub21tdSBidWlsZHMgYXJlIGJyb2tl
bi4NCg0KV2FzIG5vdCBhd2FyZSB0aGVyZSB3YXMgYSBkZXBlbmRlbmN5IGhlcmUuIEkgd2lsbCBz
ZWUgd2hhdCBJIGNhbiBkby4NCg0KVGhhbmsgeW91LA0KTWF4d2VsbA0K

