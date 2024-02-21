Return-Path: <linux-arch+bounces-2587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63C85E22A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7EE1F23A7B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10283CD6;
	Wed, 21 Feb 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="V4Vmcbb/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31683CCA;
	Wed, 21 Feb 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530897; cv=fail; b=XelmDzi5AXgl8VlpGlt03WTRW/CfS1gQhRLc43tb70gcdssW8yWTmxiUipAodBlXZXUTo5spdSKPAEbW1CKj3tyQzYgCSK2Sjt48DwQfqrO0JEom75Zfjwe2f45VxRLyGXyy3NW5dQt4xr8te6zPPmFl6visCQm373p6HTOfR8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530897; c=relaxed/simple;
	bh=Ndv5CT0ope3GRC9NxF40lrKqbTEAg7f/d+wP18JLdi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e0tvv9dPrSRWrFwuV4yC7fVzEmco+yweLydC/BRv33aLRbKzR11OjLnv4RiTf1+8slZhwOWXqRHGEnhFYIpsNSGCHjSEJiuPDZNdddEciOz2GykVcIGft9Ny6zDotbehKmfwsbdRXqR5TYNKI0trW1NIh9SGwU+tZY+oRR4TU7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=V4Vmcbb/; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LBv8ea005111;
	Wed, 21 Feb 2024 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=Ndv5CT0ope3GRC9NxF40lrKqbTEAg7f/d+wP18JLdi4=; b=V
	4Vmcbb/xnuD7DGCc8p0LDulQncvq9gNFjEe8lMLftFsHFYb3DL9pVDJHliK05cZt
	7Xuurwog/1vibcjtHhmec/me00VKNVeQtD+a3Cpt4O1o6vjwVNN//4fCh0krwaGS
	yOmzee47yY25+j1jY+M1d6ActR24WqWRHjLZZNI19p7A2GcE90uA6nA+fwVzTpTV
	FGQYqpT3XB7uHm2yFnvW65USl6wAv99DQImZrBOy8nnRuXNNj6YMgbbfEEVzZbPC
	R68ECyoXe/bqo2BqtOlCXg6vAUoy8Xp4uiyUNPqBLX3stD3HmmbW1NF9877dF/mF
	ImQ71YN80XvUIPtgQPnTg==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3wd764t05s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 15:54:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UII3ZAwmlHdDEq3K7JkHbO7U70o4b74Z3VGFinEac9Po1gaXITmBbL/B3AtVuT/z5nh2YKF/3XmK9T9z+diiqmuYHMbF1qN/UDtHcnqPGQfegTnv4ZP3YJEmHDP1z1wD/VwkzXj+9iu3mlXIB4baVvU/C1cs918NYd8QJgbMdXBkGb5jg0EGy3zxMbk94mt5WS9X3kH672irrV3FMtO+vmSEthEKV/AqL2rYEnPbQwMk8rYCoKjS4EySo1nlZ951UKQut1l9TCZJ/upp0MRiI6bP5vYkJUtnKMo7MJ3rREFZwgHzyPSv858HGBGt06gAlPNzneHIsXr/3q2WZDjwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ndv5CT0ope3GRC9NxF40lrKqbTEAg7f/d+wP18JLdi4=;
 b=RtrPGxwHnG5Z2VBqJ0M+tmTRlvTp0CozH7cke2N1jijHQ+SL0GfYIuXu7xxpI58S3tRCNB8EojTeWKiTwOQ7PVNV8ITL+t2m5/C6scxhBFAn02KvV/fpWnS6rDwoGU4XjYtw9bVpbWyNvXSzR0HxN7nr03gxAhmTXWbiWU42XLBHQH0gnziYNU365fTDAN2apj11tZK6NQwDdp/z/77kb3pdQcS2lQPXrwswZ/n5Bq3jWCl5sGvXS7YVA3voDi+Y2+EQITt4ovwst50C8L/tZCW2mGQP19YWQFr1KQRlTMPY6zXxfTvJPcDvHzMSpV7Dppuq4x2686q+101poD/EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by PSAPR03MB5558.apcprd03.prod.outlook.com (2603:1096:301:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 15:54:38 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:54:38 +0000
From: Maxwell Bland <mbland@motorola.com>
To: David Hildenbrand <david@redhat.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "ardb@kernel.org"
	<ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "cl@linux.com" <cl@linux.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Subject: RE: [External] Re: [PATCH 2/4] mm: pgalloc: support
 address-conditional pmd allocation
Thread-Topic: [External] Re: [PATCH 2/4] mm: pgalloc: support
 address-conditional pmd allocation
Thread-Index: AQHaZDwOaIoKplpm30WfPRJTeTXuwrEUYmKAgAAlawCAAGuRkA==
Date: Wed, 21 Feb 2024 15:54:38 +0000
Message-ID: 
 <SEZPR03MB6786F9F84DBC9B5DD952C70AB4572@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-3-mbland@motorola.com>
 <838a05f0-568d-481d-b826-d2bb61908ace@csgroup.eu>
 <cf5409c3-254a-459b-8969-429db2ec6439@redhat.com>
In-Reply-To: <cf5409c3-254a-459b-8969-429db2ec6439@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|PSAPR03MB5558:EE_
x-ms-office365-filtering-correlation-id: 50a5abcd-fbf8-499f-ebf3-08dc32f56897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RB/tgIT3MafxK91gE1//hiiBG4JGFcf1CIoZ/s6O2aHLrM8qKGc6UU3BvOSst8ITwn5bGwqda4HlbjMjIbaRL9aTotmUqdqsiZpiyFTeqTKB/mpDDbvrHCGhNId5MixUfds1wtMvqFiPNdy0Cu1rI6zL6Sl3A5YGYxXzXdom1rRIcFLkTkoR24PeyIXLkj581meJelJiap5WNzet52ocGw+J+n+bvqtySH+lisEySJLSzwLHViyRcJijsY9XkLCCg6VJv1qw7eqoUtY8uLPxhY3fhQ6Vkvut6pQU0eJbkh0WpV309UYu0UtxWKmSx9VlKs2cBcbfWAregoIFnP9JnNvFdoTBM52pWvmeI8wAJWOrK6Z24uS9Hcb+GjRBi4uxwsL0qRT2wMtk+oWWehdLZt2qMF1He697ZOehdCryMKLc3OMhMs2owRZr3jhabS421HHRuMmKFt/s0WzOw5FoiUz4i84UVIfidpT90NCwmvTYkHyJba2nbW+R1777E6nkLFBNeRYlQI6NyupPt8T1Zqgr2CUvp3x4sExFKOF8WMXKcXp+tasHpvo3vgTjySQ0zl3ro59YaCPkXKlf84UfjZAbSVRsh+UFfpoIWijEUJ45pe5fkucXVBnFXfOVeSjU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d1FHK3hBZXdzM1RXbVlON01iSDRLdzV4ZkFoUnpVcy93NnF5QTE4YnY2Uzc0?=
 =?utf-8?B?bm56cUNZTUxpekFqN0tWT1hicU1QaGpxcUVKMGFQeURkN04zNVRUQkxCbmFr?=
 =?utf-8?B?ZjZpQ1lmYndURjVWMnRHRTl6VWErT1BnQ0taYUZkSkxmYk9NMExBWDc2OGdo?=
 =?utf-8?B?WFU4UHBEdXVVcUFpa2hnYmFGeUErcEgxdXhPUGRKQVFBczBld05GWWpwTEQ3?=
 =?utf-8?B?NDZhS3lYT0EyZGpETmdCUnNObitVV1pZdjk0MFIyOVNwaDlEZ2VlcXRydE1T?=
 =?utf-8?B?OFcrQ3FqNllKNjdsZ3ZDK0N1NVlmdVR2NFY3Vi8wYUM1ZCttRGd6bDVRNk14?=
 =?utf-8?B?c3MxcVM5V3haUXhKMTIwN1B4WndsYlo3WmpFL2s1dVhDSHZ4cTRPemdtWWlq?=
 =?utf-8?B?bjJOcW1IaUtGWnh5QS81dUkyZjllVDVvanlDRUhCZTJ0WGpwOVppSFVZZ0la?=
 =?utf-8?B?cGZsVFdLU01ab3FZUm9MaFlDa1crMXlReTRBLzlDbjV1VTZqKzUyUStMMDIv?=
 =?utf-8?B?bVoxODRKNmxJVkFEcTRNcGxqd04veFAwZ0xGWUFMZm1WRXd6Z3ZvMit0UExv?=
 =?utf-8?B?ZXprbkRKUzNWTVRtU3V4TVEyME1KaDl2WE5wMndkWFlINXlxUVZZU1JCYkFm?=
 =?utf-8?B?SVQ2VE9zWTRtSTBsY0RLa2RrNjZ1a29rd1Jld2dnRUdEejdyMUdzdHNmZGV5?=
 =?utf-8?B?aFFxSmFJY01zRzRuYUE2STNVeDRBRExMZlEreFN1ajRvV0dGWlFrRGpuUlJp?=
 =?utf-8?B?Y3RzRUdqdUJLdGw1WHdPNUZtT1Y1Q3lsekliWmVScmdzeDRVQ3YveFdBNTN5?=
 =?utf-8?B?WWhMc2xjdmFlYnpzTi9lMGxESll0am05aU1DVzZzUGxsbE1UL0lSSEtyTjlo?=
 =?utf-8?B?aG4rN1MxSm9hOGk0THVuV0k3RmxNY054MDhlNkdaWmxUOE4xTkxUU21WTnF5?=
 =?utf-8?B?N3V4TTBTOHZyR3MxOEo3cTZkQkYwWXQrdHNMWm8zbStOcjg5Q0ZrQWFxZTRD?=
 =?utf-8?B?OGI0U3FDcm83NXovTFdaQ0FXVzhnRHhhekowUmU0S3NNVkVXWWxtMWMwTSs2?=
 =?utf-8?B?cXUwb3JzZEVXUk0rR2JsT0ZMbU5qMlRZMHgrSWdkakNBQ241d3phTjQ0dUxt?=
 =?utf-8?B?UmY2OUhPOFZOY2V3Y2Zibk9BQStlUGQ1VGJRd2JVZG9wOTBsRWIrNk1KYW9u?=
 =?utf-8?B?Y2NMU0tFeUMxeVVFMFo1ZjZtaXo0R0JiQkJzemZkOE0xdDZQRUxIUC9ZMTlN?=
 =?utf-8?B?aVltMjVmd0p5ajh1UVF5MTBHT20yR1BKcDV4UDd5SWN4NWdkYjdOOFdvMjUz?=
 =?utf-8?B?ZmJNVElLSXlEVWx0ZktTemhIU1Fld1lieXlVREJ4dmhrc2ZSUEFXQ2laWU15?=
 =?utf-8?B?UlUzNEdEYmt5RWZNWUJEUnlUbW83eXJuZFZBdmNpcGdXZlkrbDdUNWhndnVF?=
 =?utf-8?B?VS9hN2VESW81N3IrNklsZEhBUkVKQnJiMk1qTUJYeDh4YXE1Q0k5M3FuQzRT?=
 =?utf-8?B?N2NRbiswczdSTnU0NUpSQVoxVFN6MElTSzBzQ01SQWZnYUlpb09lZERpZDBq?=
 =?utf-8?B?cW95RnAvVWFpNDd0SVNtVnRPZkRHVXk2VlJYbGFjNGhPWUlhcTc3Q1N1L3hJ?=
 =?utf-8?B?QW5pb0VLclpKZzU1VkNoS0VqRHBXSXIwR2hud0Fxa2lJR09PUVpISzFEdEhY?=
 =?utf-8?B?K3lqcVQ2aE5WNTJsVjV6K1hhSnJHVjNBN3E2ckpEcDRDanhMSTdhOTNxZUNp?=
 =?utf-8?B?VTFGbE5jcXNlVmhSRTQ4VEJFZFBINFJmaXRMNjdKMXpBb0NudWJHY3R4bGZY?=
 =?utf-8?B?amIya0cwYUhxZ2lseXNlaG5xUmJEYVBXajdVcXBwMjF2MW8xTnJZcWRSMmh6?=
 =?utf-8?B?YWVCdWd6amJwWHl1dDhCSjkyd0RVVE5hNUtYMDRiS3hTMXRaNjdEaHNYVVF4?=
 =?utf-8?B?bXNaM3AxSEk1VHhra3dDY1RJQ1VwWXZveFA5bWVHKy9mZlNvOGxkOEUrclF1?=
 =?utf-8?B?QkVmS2E0YlhpSFhMeC9EWlFoOUhvQkpJU3pSemNCK1dDbjV2N0pVbmg2MlNI?=
 =?utf-8?B?dnNiMXFPSjhNSGtxMndFc1pXWTg4SURib0QyY2c3SUJveGpOVFY1SDlDRjc5?=
 =?utf-8?Q?SMmk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a5abcd-fbf8-499f-ebf3-08dc32f56897
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 15:54:38.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZO63d4wdasEh+ilKMHhwVd+IuhRMTs+U8pfg1HPGCYEIeSkWmfrZafrs3mJoPzT/yOxhTCGJsa6Q7FaMrgkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5558
X-Proofpoint-GUID: 4noMEdWesuHzJEjFJ2n8AjKVuCDcOQaC
X-Proofpoint-ORIG-GUID: 4noMEdWesuHzJEjFJ2n8AjKVuCDcOQaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxlogscore=849 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210122

PiBPbiBGZWJydWFyeSAyMSwgMjAyNCAzOjI3IEFNIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlDQo+
IE9uIDIxLjAyLjI0IDA4OjEzLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiA+IExlIDIwLzAy
LzIwMjQgw6AgMjE6MzIsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4gPj4NCj4gPj4gV2hp
bGUgb3RoZXIgZGVzY3JpcHRvcnMgKGUuZy4gcHVkKSBhbGxvdyBhbGxvY2F0aW9ucyBjb25kaXRp
b25hbCBvbg0KPiA+PiB3aGljaCB2aXJ0dWFsIGFkZHJlc3MgaXMgYWxsb2NhdGVkLCBwbWQgZGVz
Y3JpcHRvciBhbGxvY2F0aW9ucyBkbyBub3QuDQo+ID4+IEhvd2V2ZXIsIGFkZGluZyBzdXBwb3J0
IGZvciB0aGlzIGlzIHN0cmFpZ2h0Zm9yd2FyZCBhbmQgaXMgYmVuZWZpY2lhbCB0bw0KPiA+PiBm
dXR1cmUga2VybmVsIGRldmVsb3BtZW50IHRhcmdldGluZyB0aGUgUE1EIG1lbW9yeSBncmFudWxh
cml0eS4NCj4gPj4NCj4gPj4gQXMgbWFueSBhcmNoaXRlY3R1cmVzIGFscmVhZHkgaW1wbGVtZW50
IHBtZF9wb3B1bGF0ZV9rZXJuZWwgaW4gYW4NCj4gPj4gYWRkcmVzcy1nZW5lcmljIG1hbm5lciwg
aXQgaXMgbmVjZXNzYXJ5IHRvIHJvbGwgb3V0IHN1cHBvcnQNCj4gPj4gaW5jcmVtZW50YWxseS4g
Rm9yIHRoaXMgcHVycG9zZSBhIHByZXByb2Nlc3NvciBmbGFnLA0KPiA+DQo+ID4gSXMgaXQgcmVh
bGx5IHdvcnRoIGl0ID8gSXQgaXMgb25seSA0OCBjYWxsIHNpdGVzIHRoYXQgbmVlZCB0byBiZQ0K
PiA+IHVwZGF0ZWQuIEl0IHdvdWxkIGF2b2lkIHRoYXQgcHJvY2Vzc29yIGZsYWcgYW5kIGF2b2lk
IGludHJvZHVjaW5nIHRoYXQNCj4gPiBwbWRfcG9wdWxhdGVfa2VybmVsX2F0KCkgaW4ga2VybmVs
IGNvcmUuDQo+IA0KPiArMSwgbGV0J3MgYXZvaWQgdGhhdCBpZiBwb3NzaWJsZS4NCg0KV2lsbCBm
aXgsIHRoYW5rIHlvdSENCg0KTWF4d2VsbA0K

