Return-Path: <linux-arch+bounces-2595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8785E50D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F6B24693
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE585280;
	Wed, 21 Feb 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="fdTtH0q3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF885270;
	Wed, 21 Feb 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538249; cv=fail; b=cBSP2a/hv1y9DxT6oM5unXZjrU9hsGBYN2QfTn18yNBr4dwd1p6JYSX7O6Je8hIMxRdgzLIN30sY7Urc4rxvi/oDjGJQ4NRnKDoVlTQjfqG6/RzB0JV/VamEAfAZ/ePEgkg83N14xvgFq+z4I87VxRSUJMuezjBsAbGXcJZhayY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538249; c=relaxed/simple;
	bh=ohdBdAmRjzn/ur1B1BUK4Ux1Xy+rpyuKbSwdnqUhuWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a9ZUmC9fOsovWnwXZSzYQmggsqSf/KO7SLKDaeHiBaovLsMXPLhRZgnqI+MYNdkL+syaxRojvJ9+l9W1RF3JsnKrZPYfOt64yCXpJJCfDmZD2MLuqB6oVpMgvvbmrza+CSxsmGOKKA6SURtnPxhhEfMndCIZgCxVm9EgZtcDgls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=fdTtH0q3; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEiEDV020144;
	Wed, 21 Feb 2024 17:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=ohdBdAmRjzn/ur1B1BUK4Ux1Xy+rpyuKbSwdnqUhuWg=; b=f
	dTtH0q3ZY6IpYl5V8g81DtyXM5ei4YERSVSOS1+fsGhjlfeCrz1/y7KiLTOCToSe
	5rmC6CFAXjSCpUjoXkRdliy0C/9R2+2USBc7URGI5w4e0rfRFhtVgVsexUxEGX4L
	2HjljtwFxswLb/K/HlDeZJf+E9oaJyEB2W7JwRqMnhJAycXWO+sVAw2f391PZ9yh
	P23nUl7CdX3FxC3ezA3FVWGJ8pSskHYl3AumrneFlam6B/FEUK3sx/gxr0cvngcS
	Ddr6bIT/mBtf4Hv3UuyeptEKCLm+hjHEvaJDVigVm1qvPWIfMYQreDa3BxupHLtr
	5MJ1f5acZ34YwLdL96oAA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3wda6dt3hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:57:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJAqPp7I2/x0U7z/WH+JEVKGhZw21OoDA5H70BsaDTOh/XQk7lRx0S0CljPBqDKkvTT9R0zU+gXOemIayv6/Nf+mgNIeeWXU9EXu0c9cxK0/qZnbkSaTt9R44ApQesSFbe5AxMUicwj93kfj2lDvAT62qUZ3XYYS/qV+Kptw9Xn9su0XnMBy1N9SipzgVI117OZfJSuoe5WGTRvh179C+0/tBV7W4xgRHi/TJwwChejeNo8Hwkm4QP55AyXH1HFgpPuBF174ogisfXCF41Y2PQfuSc6EHFCQprKKr4lwRhNcc/4lutGfAXCHfThiBqwcg7Kf6H3aQt+mnGbhtpzBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohdBdAmRjzn/ur1B1BUK4Ux1Xy+rpyuKbSwdnqUhuWg=;
 b=TfIzPVOLga6zuLvOhHK5d2HTkHgVFYQE/Buuwy31BV4y6I3C111MRnhRRwwnNZ/gRuyzbcgVMcL69fxfY86Iwt6BDYrzar+1830HS/cuJULcHGJmlV4X3D2jVumNqmWrv0esiyWWrR9mBgziO6iHzSgZ5GHK5Gm0X2i2E9RBnWRJdsay6C4If4+Ji6ZrYAfvpHfUYxoYaUjnpFB5763efQLgM9PH1Hbw5gfnMEKBfhisHJhfw4Z3WAWeKbhyCqDa6wK5BCpZD5tqC37RIFXP9X/Pi87AUzmnZBVLhD7fQUWbxA2+1Sl1Mwpx4VoAdjhWuThutveyCKS9frhvu0vcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by PUZPR03MB6101.apcprd03.prod.outlook.com (2603:1096:301:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 17:57:05 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:57:05 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
        "david@redhat.com" <david@redhat.com>,
        "dennis@kernel.org"
	<dennis@kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "gor@linux.ibm.com"
	<gor@linux.ibm.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "hca@linux.ibm.com"
	<hca@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jolsa@kernel.org"
	<jolsa@kernel.org>,
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
Subject: Re: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd configuration
Thread-Topic: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd configuration
Thread-Index: AQHaZO9h6psKGO7SGk25OSRe9qGB2A==
Date: Wed, 21 Feb 2024 17:57:05 +0000
Message-ID: 
 <SEZPR03MB6786142493B476B96F46081BB4572@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: <20240220203256.31153-1-mbland@motorola.com>
 <4368e86f-d6aa-4db8-b4cf-42174191dcf9@csgroup.eu>
In-Reply-To: <4368e86f-d6aa-4db8-b4cf-42174191dcf9@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|PUZPR03MB6101:EE_
x-ms-office365-filtering-correlation-id: 9d9aa498-b3b2-4238-42ef-08dc330683e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EHZlv0SDyyBCswKHz8QhE6+fKjEQfTEOEOnsfEw8WEdafdcTxkcxZBO2/vj6FFUY2v9/9trYiQ6ovPZrHiLJRt0AYlbyDtvArwJM8Pfm8CQ5jYEjeE1tZwtXD05V5CIw5SHjSlz1Yy3e9xCLSCB0AXbwDq6ZJEdTY2XRxV9DwabpXTcJTE6s9SM3szosTeRI4kH/l9HiEoPpq6l3XOMqylPfo1GnRoNxPyb03Amwn2a8RlHgbQUG694iehl8XtHLPjP7S6BVy6mVilX7MgyDk+u47GjmaC4xNnCbrLfAG5p9MKDnXYsFXuej2a69o4viRvs2xDrjQ3z+uSAfX8hG43l/7pT5F9UQ+oNptrSSiJgD9KQFRV4Z+/Be/hcwGm0dgXQ7AIj4DzbYdms/ea+d58bFLMg5QDMT993ljeu9kyj+EBq/ycwVZSpMx9aU2wPkYtQzAcaeot9XMivuQSmQPoDjEnZj1IANgS91tY27ATWnzHCaESeO8t6Z7Cag88jsqB3Wvb0ZswuW9YMal2BkUKTfkZARtarjcU8/Fj56yIBqDDmAMxNmZjwqTHo/TvqPbvCPRMSp2P47w3npSvC4MkqC5aKgl3+sYOSY+Bro06Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RDJlSTlhVzdGcnRNVC9PdWlqSTl1R2JlQi9BcW5LTW9sME51VG94SmtpdkdF?=
 =?utf-8?B?azRDOHRvSHI5VS96b1Jld1lEcTZRZitZTndxaUZDS29ueFk5RWg1SEFleU9K?=
 =?utf-8?B?WE9MZUVBTGdDZm9qSDdSUHV5QnhDeGgrTDM5STRyR1JzSGFURm8wN0lOYnpM?=
 =?utf-8?B?SEZCSGIrZUJtS2dUaHhYZ0JqVk40ZnNrcTRUd29CQUNpckY2TmpTdHJTTkh1?=
 =?utf-8?B?YzlyU1AzdnZaUGlaMXdXTllEc0xOWE5laUM2aDZPVDYxOThlM1hmbFJ0NWIw?=
 =?utf-8?B?Y3JCU000NkZBMTVnM0FHaWIzVDd4aUtqRWxKdFJsWmN1cWV0Q1BYQlFBOUth?=
 =?utf-8?B?M29iaFFQbUhKYnh3c04rK20xc1I2U3BFdXdvbUIrYU1oV3I1akU0eW1odFQ2?=
 =?utf-8?B?Q3F0dEZERk44M2xjQ0FoN0hxeFc2YUE4ZkFKOG9IYnNBUll5bVBRNVZVTmN6?=
 =?utf-8?B?Tkh1UW5XRUVXZkF3Y3hwZkd3MjNUOWJHdldDUG13Q3lmZy9aL2tkSEdOb2tK?=
 =?utf-8?B?M3U5bnpZNnRyZVRadzY3c29TT2lCTU9HYjA1OWxRS0lUZFpHM2dvVE9ZSklH?=
 =?utf-8?B?eTBPd21EQ0xjZC9IQkpPUVZ5elduZVpnejFIUFJKNXlFQ2xmRW5YclBtN09N?=
 =?utf-8?B?aDRxdGlzMzZ0MVZERU1tZzVFTERnMXhQbVNoODRocU05cEZZbXBXcDJXTi8x?=
 =?utf-8?B?dnJuZFQzYmNBb3J2U0c0S3lBeG4wMEhmNzM5ZThlYmNscVR4eUF0aVh4M3hV?=
 =?utf-8?B?M0cvUExwZmp1eE55VEJ4NUlsTWpqcjB5U1M1V1NVZ2V2dHpVb3NBMjlXQTh5?=
 =?utf-8?B?NkxvOUdjK280Z2pYakF3VE5jL3JxYUJjNTF4U0dickhwM3JRRjcxVktkTUFW?=
 =?utf-8?B?R1MyTU53T0E3MFdUeXRRaWxMNXR6ekRhNnBLVHZVZ1pkMG0wNXlURnk5YnJq?=
 =?utf-8?B?N0hlM1YzNEVNNTUyNDM3N1NZV2hUNlNTaS90eE5EZXdBNVRIY043aFgwQTBk?=
 =?utf-8?B?VkhkRVV0cnJZcm8wQkZuMTZnWE5aUzJjZmhwcjUyRm9EMDFwQ2N0QUFMc2dv?=
 =?utf-8?B?bUhvNHZkc2N3OXR6VXFkVnFRZ1k0YlR6SnFEZzF3WkVYU1N1WTk4U3B0U2Zk?=
 =?utf-8?B?aW9kdjB4RGFqd1pPTVJkeDVmSmJiVnR1UTl3UWY1WmpOZGNSQ0cvNW9xUzJ3?=
 =?utf-8?B?S0FrZmJVUko1UHdaTXBCZUY0ZDlPS2M5eVB0Q2hQdDZnNGhOcTUwTDdHcEkr?=
 =?utf-8?B?NlVkMll6QTQwTk83TWU3QVk0SE9nTjByWk52c0FUQmVZcURuYTh5MXptODda?=
 =?utf-8?B?WkRFd3JsdkFUQ3FkQmlUSkpsUGRYSU5RODNoM29pQmFLUDNaTS9xY3hlSEJK?=
 =?utf-8?B?NUR5U2lVU1ZHVU5tZTBITGp2WWlINTNnTnpoY0dqODRhSHlHcGVBMERQQ3R1?=
 =?utf-8?B?UEthYWpVRmZxMkI5MXhJNWlMZHYyd0VSMldmeGNlOXd4ZUFjQk5DUkVGNmUy?=
 =?utf-8?B?THpkL1FLU29VOEpPMmlralQ2VUdGTkl4R0JvK3Yva20rLzltWmtnbFdyZFdI?=
 =?utf-8?B?WXFLRElwMkZRKzI4TDZITjU4UWh2MnhOWmVSNkNMZ1UwNXlCNjdYRXdmb3Zl?=
 =?utf-8?B?cnVxaUtJbk45WlVVcm14N2paQlN4VHZxbWFCTzFpbncxRE1USzgxVWFNNHZt?=
 =?utf-8?B?VDdjaXl6Q1lQbzJqMWF2Z0dBdmxDcVY5eUdGTHdlZW1GWlZBNHVoMFlvcU45?=
 =?utf-8?B?Wm5wRjVLSFZ3VkxaeDZuOGwxOHBVK3pyTjBZL2NMYjdXUWFzT1F3OWtiWjJT?=
 =?utf-8?B?ZDgrbWNlWmZ3OWlmOTdmS29vcG5kS2UxTlV6SUpvMzBBN05TRlRIQ1loZjBz?=
 =?utf-8?B?SGw2cmE0LzFnMCtTcXVRZjlTYWJIK0lZZlBvbnM1aGNDN2d1aXRIT3hwMy8x?=
 =?utf-8?B?NFlkN202b25UQjFINm1qckJpQitZMS9zb2dhUzhNUlcrTXg0RXFnSE9pUjZO?=
 =?utf-8?B?WTFaazdVR29zSkJXMTRqSER0MVhQZ1l5Slg3dEs1Vk9yek16Zlh5OElxLy9l?=
 =?utf-8?B?amZ0UHJlSWlyYmtMQkdVeGhWSTBSSElzcmt1Z1UyMmFnQnc0a0Z1bUR3eEJk?=
 =?utf-8?Q?KjjA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9aa498-b3b2-4238-42ef-08dc330683e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 17:57:05.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPFU8MGPpDCKjjZb95ddjheCAP3uJp6GUxYh1ARNI5BJGmk2nK4mXgKhdZbUBsjkzKFz3ru8xaW7USi2mSF6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6101
X-Proofpoint-GUID: t_vz-c102zLvZ-9DS63pGkPli8NM-ato
X-Proofpoint-ORIG-GUID: t_vz-c102zLvZ-9DS63pGkPli8NM-ato
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_05,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210139

PiBPbiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDIxLCAyMDI0IGF0IDE6MzIgQU0sIENocmlzdG9waGUg
TGVyb3kgd3JvdGU6DQo+IA0KPiBPbiBwb3dlcnBjIChib29rM3MvMzIpIHdlIGhhdmUgbW9yZSBv
ciBsZXNzIHRoZSBzYW1lIGFsdGhvdWdoIGl0IGlzIG5vdA0KPiBkaXJlY3RseSBsaW5rZWQgdG8g
UE1EczogdGhlIHZpcnR1YWwgNEcgYWRkcmVzcyBzcGFjZSBpcyBzcGxpdCBpbg0KPiBzZWdtZW50
cyBvZiAyNTZNLiBPbiBlYWNoIHNlZ21lbnQgdGhlcmUncyBhIGJpdCBjYWxsZWQgTlggdG8gZm9y
Yml0DQo+IGV4ZWN1dGlvbi4gVm1hbGxvYyBzcGFjZSBpcyBhbGxvY2F0ZWQgaW4gYSBzZWdtZW50
IHdpdGggTlggYml0IHNldCB3aGlsZQ0KPiBNb2R1bGUgc3BhcmUgaXMgYWxsb2NhdGVkIGluIGEg
c2VnbWVudCB3aXRoIE5YIGJpdCB1bnNldC4gV2UgbmV2ZXIgaGF2ZQ0KPiB0byBvdmVycmlkZSB2
bWFsbG9jIHdyYXBwZXJzLiBBbGwgY29uc3VtZXJzIG9mIGV4ZWMgbWVtb3J5IGFsbG9jYXRlIGl0
DQo+IHVzaW5nIG1vZHVsZV9hbGxvYygpIHdoaWxlIHZtYWxsb2MoKSBwcm92aWRlcyBub24tZXhl
YyBtZW1vcnkuDQo+IA0KPiBGb3IgbW9kdWxlcywgYWxsIHlvdSBoYXZlIHRvIGRvIGlzIHNlbGVj
dA0KPiBBUkNIX1dBTlRTX01PRFVMRVNfREFUQV9JTl9WTUFMTE9DIGFuZCBtb2R1bGUgZGF0YSB3
aWxsIGJlIGFsbG9jYXRlZA0KPiB1c2luZyB2bWFsbG9jKCkgaGVuY2Ugbm9uLWV4ZWMgbWVtb3J5
IGluIG91ciBjYXNlLg0KDQpUaGlzIGNyaXRpcXVlIGhhcyBsZWQgbWUgdG8gc29tZSB2YWx1YWJs
ZSBpZGVhcywgYW5kIEkgY2FuIGRlZmluaXRlbHkgZmluZCBhIHNpbXBsZXINCmFwcHJvYWNoIHdp
dGhvdXQgb3ZlcnJpZGVzLg0KDQpJIGRvIHdhbnQgdG8gbWVudGlvbiBjaGFuZ2VzIHRvIGhvdyBW
TUFMTE9DXyogYW5kIE1PRFVMRV8qIGNvbnN0YW50cw0KYXJlIHVzZWQgb24gYXJtNjQgbWF5IGlu
dHJvZHVjZSBvdGhlciBpc3N1ZXMuIFNlZSBkaXNjdXNzaW9uL2NvZGUgb24gdGhlIHBhdGNoDQp0
aGF0IG1vdGl2YXRlZCB0aGlzIHBhdGNoIGF0Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvQ0FQNU12K3lkaGs9T2I0YjQwWmFoR01nVC01Ky1WRUh4dG1BPS1Ma0ppRU9PVStLNmh3QG1h
aWwuZ21haWwuY29tLw0KDQpJbiBzaG9ydCwgbWF5YmUgdGhlIGlzc3VlIG9mIGNvZGUvZGF0YSBp
bnRlcm1peGluZyByZXF1aXJlcyBhIHJld29yayBvZiBhcm02NA0KbWVtb3J5IGluZnJhc3RydWN0
dXJlLCBidXQgSSBzZWUgYSBwb3RlbnRpYWxseSBlbGVnYW50IHNvbHV0aW9uIGhlcmUgYmFzZWQg
b24gdGhlDQpjb21tZW50cyBnaXZlbiBvbiB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpNYXh3ZWxs
DQoNCg==

