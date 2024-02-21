Return-Path: <linux-arch+bounces-2550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EED85D168
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 08:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D71F2440B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC863A8E9;
	Wed, 21 Feb 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="H3mXfIOs"
X-Original-To: linux-arch@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2118.outbound.protection.outlook.com [40.107.12.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB424B57;
	Wed, 21 Feb 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500734; cv=fail; b=P0UnhRKCCM8gQ/TK6zk3wVQwQCFre/N9i8OVaoQHbXgWrjAFph38FnQxEqzmxG0gXx0dv+8gS2LP3nNHMKZmnxUbHG7nUpGnVcMkYCTH0IRr915NvvT6/j8/xmKWEl4Yb1L6x9ZOLAFLWk73zKXW2HVfGdk6XEEfBQ+AElA2GFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500734; c=relaxed/simple;
	bh=myopBb3edsQIuwuiK+u4DVa5+NjagIv+wRUsTqlc9ao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RC29yUkIed5X1A9Z2hp9XcpmVttaG9cFceA8rEmJx4oBAlLuvacOSlIkIgvddUS9g6sELyQJ//UedKGKP/IttPZPpDplA/jbDLXpdHfQ7hP+LvG1YIUgg7WLw0CUM5dAVoMpRvZD3jNMA631EJp74rp7IY5cWYFf1UpYNjUbXXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=H3mXfIOs; arc=fail smtp.client-ip=40.107.12.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1bmX8Ce+l4FjBwbLlCCEJkdj8Svm7S8o0wmYD2l0YbBgLoe5PKedatp+CP0lEtlULOVzXSDQKozXZ3Cy6B/7/gI83bkXvbI29dFM1a6iqQcsJyFzRpfcO53t7f1yW1p8+xAQoiS1frsEt1jiOh6xOG86uza+l88xsQbKqpDoCghGUcJfRIWe4Mh4h9w32yfboZEZImU0yatzExMOERASXzx45XVhRdtEQ6hbEan2n2ilYadWG1bfkF5PHQWPaL8T87tBtxXztZkosmsvOmF7+lGaO1ItkhX5NyiO5qsLFCeqP7DpKDhChLj9ox/JAp0rezKnIEf8/iKClPQsXjnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myopBb3edsQIuwuiK+u4DVa5+NjagIv+wRUsTqlc9ao=;
 b=HbajcpleRD/j39bvBgXNfoO8AhKUqaSCW/pw6xtN/xweg2fDHoOh7gipxgRITsqqogozE7swRHL0ZsRyli2YXwo7rq9cDc6kbdmPAHDWb1CLILJymRroLEv/4PclalGlBwj1y/4G1B0E8CZfAEwiD4l2czxhvbTfOVg3hBJdRkuuwLlcPFn9p5G9ZCwHtFff3CeY19vZsH5RPRSHoTuqRJPlPec68YKKuUkbevM53c0ItcoWxFlPTgRy+ARRK4AU6TEcHrfzqsQG881twT/bQPJVdLsflVz6gav9q9CKA9b+vxWzoj/eU8Sb64OS+pFocxw2gBkYjkBjakFd4Z16aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myopBb3edsQIuwuiK+u4DVa5+NjagIv+wRUsTqlc9ao=;
 b=H3mXfIOsWSEi0E+NeQfg/tq5aRDfhOyY95Ps7pThwA7ZK+9dbQ+wXWAmD2ldVVk9GSc7iOUyVCU7QSTiwpIoNFnIxrcJcLmnWjiaxpH64UQy3T8LuBE3t6A9rwXRNEAnJVkhgJiQStJJZWi+QHEhxBJj5QxToJp0P5+vzHYViO4JYt0n6lISdP98pUik88ahm2THH0y7g0+PNy30MvXu/tx8Bs84yI/L3swyo5amjlN0GihZZYqKmm/PPPqfgPgdUCu0rQlrHlLFrnoQNiYxevpNS8vX45eGjmBUYIzRL0x7bAvYlD/dAQVGy3u5K/ARVeQiOxHUURvZb6fDtPH2Xg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2109.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 07:32:09 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:32:09 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Maxwell Bland <mbland@motorola.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "ardb@kernel.org"
	<ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org"
	<ast@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"cl@linux.com" <cl@linux.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "dennis@kernel.org"
	<dennis@kernel.org>, "dvyukov@google.com" <dvyukov@google.com>,
	"glider@google.com" <glider@google.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "hch@infradead.org" <hch@infradead.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"meted@linux.ibm.com" <meted@linux.ibm.com>, "michael.christie@oracle.com"
	<michael.christie@oracle.com>, "mjguzik@gmail.com" <mjguzik@gmail.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "mst@redhat.com" <mst@redhat.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_nprakash@quicinc.com"
	<quic_nprakash@quicinc.com>, "quic_pkondeti@quicinc.com"
	<quic_pkondeti@quicinc.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "ryabinin.a.a@gmail.com"
	<ryabinin.a.a@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "sdf@google.com"
	<sdf@google.com>, "song@kernel.org" <song@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"tj@kernel.org" <tj@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "will@kernel.org"
	<will@kernel.org>, "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "zlim.lnx@gmail.com"
	<zlim.lnx@gmail.com>, "awheeler@motorola.com" <awheeler@motorola.com>
Subject: Re: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd configuration
Thread-Topic: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd configuration
Thread-Index: AQHaZDwS5UJxmu/gN0awDwkY2kCoDLEUZ6+A
Date: Wed, 21 Feb 2024 07:32:09 +0000
Message-ID: <4368e86f-d6aa-4db8-b4cf-42174191dcf9@csgroup.eu>
References: <20240220203256.31153-1-mbland@motorola.com>
In-Reply-To: <20240220203256.31153-1-mbland@motorola.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2109:EE_
x-ms-office365-filtering-correlation-id: f23273f4-db2e-4c88-e1a9-08dc32af36ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k7+ekNLSaNiCmwoc9C+wCy19voCsyW0XgV1aYjzRxQA8Orsm3U9dpesJUzhZdK7sha8CuJvG0vZsDLVHsO7eJzAiS+y4gB3y7r/63RiKqmfzRUnxgwU/4uOmPFXuR4rKkL/atQwzhwg3zFLvUS7JJsFTW6wXhNJAu0/1pFAe2GaclidoIVjYOBOrZS57IfDBSgfUtkilBGLUDlw5+KpD9wzlJPRiBs+sBxSwj34Z3MfdaEjOnyiyu7v1VH4liSSrU1Yq9/wxcEd0riTjVb/+rYblEy/GjP+5NfVPzsrVbwoZI1Fk6rf1y6Zs7bB4/q3cOBDYSwQKIyyhoJw4JiPwc+JVPOdv49Jojd4qOQX98RVJoX8/vvQ1xr2TozIPjRcwIx6PCura5bpqQKVfOp4D1ZMKrJXUxHxsADi1l7xs7zATWyVQaALvx5ECunGvzT30MiYxqZpueltiyYxgmUBFnUqQuTwLwIuKR5xk+rWSv1FTNqnB8ChEjDSf1Pr4cKVqVypKBuTp8heyFI1yptuy1q/U/BGOcvRRVio7QmBzbMQYPxv9229Gaso8Thf/upsalL2X0G6dYb03fxpE5WlEga00M0mVSiwQCJ4+frok6QkGv9IFSqb76crkpZU0cjk9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3daQWQ1bWdFc3BySmpEZ21yVFlTRUcrYTFmOGpFMVJpUGxpWDBuaXNjUHNF?=
 =?utf-8?B?MU1PSnJMWHFZbnVGc1JYbm1odDZLdTVOaFQvWWY4RHVKRkhlTk1PV0xBQ1Zi?=
 =?utf-8?B?aWtUbmkrQmpoQUxBVVo2V1lwU096L1lWNUtuWmh5MlNZYnkvZ1k4WlpYZGR4?=
 =?utf-8?B?V3VOTmp5SEF2TDZVTnRweU05RXFlZDF0TFc0Z3dxZW42Q0lOVWV2ZE1WY3Iz?=
 =?utf-8?B?cnVSdXJRTWRNdytFeGtkMEdTSW5Ua0F1ZmwwTWdOeFBTQThkYm84cHRMczJ4?=
 =?utf-8?B?dDRhcUppQmFyb2I2NlBXRWdHZkc2UXgveUhmSktuVytGczVEd09DSzA0Q3dN?=
 =?utf-8?B?Q0k5amh1RDBjaDNGMHFmWUU1Z21pRUtUOFRNUkxYUkFjTzdqVXAxN3ZBMjdi?=
 =?utf-8?B?akV0MW5aMXh3WWN5dDZDRHN2YnFXNzlzWTJWMnJZQzVOWFE0Qmx1b3ZUd3Qx?=
 =?utf-8?B?eE9kdTdxUWplbWlTanR6Z0Q3WEVzOGhNVmVEVjRIdVA3TURadE01RGZlTkpQ?=
 =?utf-8?B?ZFdrUnp3blF4b3NVNytJalBMZUNrZXhFNTRUSEZaWXpKZjMwV3Q3OE9XLzRJ?=
 =?utf-8?B?cTZLbDdHWUxMQXZ6YUJPYW1hYnYvMXc5Y3lzZENDVDBDU2pUSXkrZEhyMU41?=
 =?utf-8?B?MkhnYkxKdmdQczJZS0NRZ3ZheUdzUHBBMjdkV1Ftak5acUc3Yjd5Y0J4Wmt5?=
 =?utf-8?B?VVVRZ3c1K3NOQjBLQXRsSUZzSHBzVVc3NzZQaUN6S2tnUFZINDMwL0lBbk1P?=
 =?utf-8?B?aUVhd3JhclAvTVFsMHhMUXNDb3M0OFlhQ3c0OXRZRS9VUWJnWFJGUzBXdEx6?=
 =?utf-8?B?aTBJM3h1V0h4U0orL3dGRUhHT0lOQytkQWM5UGY5UVdtM0JvelYxR3RqUU9V?=
 =?utf-8?B?WXhmdTVkQm8yQk90ZWx5eG9EVlVEbitndHpDOGhiZDhFRjNvTHZLRGRWaitQ?=
 =?utf-8?B?REM5RVBrQXMySFp2SVFpS054Q0hXbVZRWkwrQWxEMG5LSmxvWndNd0hNWVN3?=
 =?utf-8?B?aitGOGI4Z1ZmNHp4blRKWmhSeHVTWVBlTUZMK0pUZStmbXN4Qi9ENEYxNVlR?=
 =?utf-8?B?NWlXTjYxRjI0aFVpeFg0OTVmSlo2Zk15NlZ2a3Q5WC91Tm42d0NITWVwcVgr?=
 =?utf-8?B?WkNkNldnWnZhT09LM1ZId09LOUJ6L2dBc2pwWkhzV2pyNllhMzQzKzlGTWx0?=
 =?utf-8?B?UDRCVTU1SlNVb0dUS3F5UWZPcmJZK2pZMXkvSjhzV0dSSDE5RmJGYlJISklz?=
 =?utf-8?B?US9saXRxRWNqUGhuQURXS0UxNEdxT2h1dXFaekZiZXdRY3RXV0JSbDJkdjNL?=
 =?utf-8?B?WVV2WHNQc2M3M3JtN0RVY2JFYmdNTHdHK2dwRkZhdHNCN1QvVDlxbE5OOFJN?=
 =?utf-8?B?MjdKTGZXYlNaNHNya3NDdVFNdG9nN09qbEhmMHU5bzRBK3l2dmIxRDBUS3NS?=
 =?utf-8?B?VHVvU3hhVHdiWVhseWZkOW5hQzlvSEdUbzYzd3NuaUFMNHlwQmcwaEZhd3FT?=
 =?utf-8?B?a0VNdllXZGgzZjhneXRtTU5YRmw1MVZJQnZWZlRjUmMzUitpTlFMWHllL2c2?=
 =?utf-8?B?dzlST1BMb0czZUVHc2V6emlVOVNpeTBUVE5rcy9PbW9tQTBGTWlyZHhUem1V?=
 =?utf-8?B?ZndDejcrK2hYcndZS2FTVTNlODFUckoyVFpjQUlxdmRFKzN2dnZMTjJNMDh1?=
 =?utf-8?B?VEVDSlNsbjdEbkRoSHZPQTNSdThMb0lGWEIyZ2JsRHBtTzBTdUs2dnl1em5S?=
 =?utf-8?B?bmJYeEVCeXo2REwzM203bFJLM1J4NVIzcVZHbktzbmFFTU83VkU5UDRSV2h4?=
 =?utf-8?B?U0N4NGF0SjFZT1BoNVQxcVVpc0NuOW5PaDNHbjh6ZExVMTB3R25SU2NIUldk?=
 =?utf-8?B?SUFIU2RGbWcwV1dKQVg1UzlXRWhUMzgwZ3IvbExvdHp1dCtjdVpId21rbFVo?=
 =?utf-8?B?RkJTUWdRc2hQTlU0K3plMDF0YzJ4NDNSNzRvYlFJNGNMUVJTSzFGU0dEbXlh?=
 =?utf-8?B?MC82Si9OL2JibEhjV2ZNeis2dlFYZitqRTBUZ2hHVDFZcGxqdTBTTzlTaGdo?=
 =?utf-8?B?bVIxeHJuMzdtTHFNaTV6UlZwWFhuWFRHVVFFYXJaeUNUR1FUaFowZ0hwb2Za?=
 =?utf-8?Q?WLXugoi8kZUVnyiCLBXuAPOox?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4CF3C4C5DAEB14EB9859660BADFDF9C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f23273f4-db2e-4c88-e1a9-08dc32af36ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:32:09.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tci4GFI2Jf1hiYyW1khtOKki2yqiS6g4KMOybofoZ9UHzgk3uoxxse/khcOJFfKMPZadFaEV11P3p/ziFDYqFhCfdyblUCIT2lbcUvj+oUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2109

DQoNCkxlIDIwLzAyLzIwMjQgw6AgMjE6MzIsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgbWJsYW5kQG1vdG9y
b2xhLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IFJld29ya3Mg
QVJNJ3MgdmlydHVhbCBtZW1vcnkgYWxsb2NhdGlvbiBpbmZyYXN0cnVjdHVyZSB0byBzdXBwb3J0
DQo+IGR5bmFtaWMgZW5mb3JjZW1lbnQgb2YgcGFnZSBtaWRkbGUgZGlyZWN0b3J5IFBYTlRhYmxl
IHJlc3RyaWN0aW9ucw0KPiByYXRoZXIgdGhhbiBvbmx5IGR1cmluZyB0aGUgaW5pdGlhbCBtZW1v
cnkgbWFwcGluZy4gUnVudGltZSBlbmZvcmNlbWVudA0KPiBvZiB0aGlzIGJpdCBwcmV2ZW50cyB3
cml0ZS10aGVuLWV4ZWN1dGUgYXR0YWNrcywgd2hlcmUgbWFsaWNpb3VzIGNvZGUgaXMNCj4gc3Rh
Z2VkIGluIHZtYWxsb2MnZCBkYXRhIHJlZ2lvbnMsIGFuZCBsYXRlciB0aGUgcGFnZSB0YWJsZSBp
cyBjaGFuZ2VkIHRvDQo+IG1ha2UgdGhpcyBjb2RlIGV4ZWN1dGFibGUuDQo+IA0KPiBQcmV2aW91
c2x5IHRoZSBlbnRpcmUgcmVnaW9uIGZyb20gVk1BTExPQ19TVEFSVCB0byBWTUFMTE9DX0VORCB3
YXMNCj4gdnVsbmVyYWJsZSwgYnV0IG5vdyB0aGUgdnVsbmVyYWJsZSByZWdpb24gaXMgcmVzdHJp
Y3RlZCB0byB0aGUgMkdCDQo+IHJlc2VydmVkIGJ5IG1vZHVsZV9hbGxvYywgYSByZWdpb24gd2hp
Y2ggaXMgZ2VuZXJhbGx5IHJlYWQtb25seSBhbmQgbW9yZQ0KPiBkaWZmaWN1bHQgdG8gaW5qZWN0
IHN0YWdpbmcgY29kZSBpbnRvLCBlLmcuLCBkYXRhIG11c3QgcGFzcyB0aGUgQlBGDQo+IHZlcmlm
aWVyLiBUaGVzZSBjaGFuZ2VzIGFsc28gc2V0IHRoZSBzdGFnZSBmb3Igb3RoZXIgc3lzdGVtcywg
c3VjaCBhcw0KPiBLVk0tbGV2ZWwgKEVMMikgY2hhbmdlcyB0byBtYXJrIHBhZ2UgdGFibGVzIGlt
bXV0YWJsZSBhbmQgY29kZSBwYWdlDQo+IHZlcmlmaWNhdGlvbiBjaGFuZ2VzLCBmb3JnaW5nIGEg
cGF0aCB0b3dhcmQgY29tcGxldGUgbWl0aWdhdGlvbiBvZg0KPiBrZXJuZWwgZXhwbG9pdHMgb24g
QVJNLg0KPiANCj4gSW1wbGVtZW50aW5nIHRoaXMgcmVxdWlyZWQgbWluaW1hbCBjaGFuZ2VzIHRv
IHRoZSBnZW5lcmljIHZtYWxsb2MNCj4gaW50ZXJmYWNlIGluIHRoZSBrZXJuZWwgdG8gYWxsb3cg
YXJjaGl0ZWN0dXJlIG92ZXJyaWRlcyBvZiBzb21lIHZtYWxsb2MNCj4gd3JhcHBlciBmdW5jdGlv
bnMsIHJlZmFjdG9yaW5nIHZtYWxsb2MgY2FsbHMgdG8gdXNlIGEgc3RhbmRhcmQgaW50ZXJmYWNl
DQo+IGluIHRoZSBnZW5lcmljIGtlcm5lbCwgYW5kIHBhc3NpbmcgdGhlIGFkZHJlc3MgcGFyYW1l
dGVyIGFscmVhZHkgcGFzc2VkDQo+IGludG8gUFRFIGFsbG9jYXRpb24gdG8gdGhlIHB0ZV9hbGxv
Y2F0ZSBjaGlsZCBmdW5jdGlvbiBjYWxsLg0KPiANCj4gVGhlIG5ldyBhcm02NCB2bWFsbG9jIHdy
YXBwZXIgZnVuY3Rpb25zIGVuc3VyZSB2bWFsbG9jIGRhdGEgaXMgbm90DQo+IGFsbG9jYXRlZCBp
bnRvIHRoZSByZWdpb24gcmVzZXJ2ZWQgZm9yIG1vZHVsZV9hbGxvYy4gYXJtNjQgQlBGIGFuZA0K
PiBrcHJvYmUgY29kZSBhbHNvIHNlZSBhIHR3by1saW5lLWNoYW5nZSBlbnN1cmluZyB0aGVpciBh
bGxvY2F0aW9ucyBhYmlkZQ0KPiBieSB0aGUgc2VnbWVudGF0aW9uIG9mIGNvZGUgZnJvbSBkYXRh
LiBGaW5hbGx5LCBhcm02NCdzIHBtZF9wb3B1bGF0ZQ0KPiBmdW5jdGlvbiBpcyBtb2RpZmllZCB0
byBzZXQgdGhlIFBYTlRhYmxlIGJpdCBhcHByb3ByaWF0ZWx5Lg0KDQpPbiBwb3dlcnBjIChib29r
M3MvMzIpIHdlIGhhdmUgbW9yZSBvciBsZXNzIHRoZSBzYW1lIGFsdGhvdWdoIGl0IGlzIG5vdCAN
CmRpcmVjdGx5IGxpbmtlZCB0byBQTURzOiB0aGUgdmlydHVhbCA0RyBhZGRyZXNzIHNwYWNlIGlz
IHNwbGl0IGluIA0Kc2VnbWVudHMgb2YgMjU2TS4gT24gZWFjaCBzZWdtZW50IHRoZXJlJ3MgYSBi
aXQgY2FsbGVkIE5YIHRvIGZvcmJpdCANCmV4ZWN1dGlvbi4gVm1hbGxvYyBzcGFjZSBpcyBhbGxv
Y2F0ZWQgaW4gYSBzZWdtZW50IHdpdGggTlggYml0IHNldCB3aGlsZSANCk1vZHVsZSBzcGFyZSBp
cyBhbGxvY2F0ZWQgaW4gYSBzZWdtZW50IHdpdGggTlggYml0IHVuc2V0LiBXZSBuZXZlciBoYXZl
IA0KdG8gb3ZlcnJpZGUgdm1hbGxvYyB3cmFwcGVycy4gQWxsIGNvbnN1bWVycyBvZiBleGVjIG1l
bW9yeSBhbGxvY2F0ZSBpdCANCnVzaW5nIG1vZHVsZV9hbGxvYygpIHdoaWxlIHZtYWxsb2MoKSBw
cm92aWRlcyBub24tZXhlYyBtZW1vcnkuDQoNCkZvciBtb2R1bGVzLCBhbGwgeW91IGhhdmUgdG8g
ZG8gaXMgc2VsZWN0IA0KQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQyBhbmQgbW9k
dWxlIGRhdGEgd2lsbCBiZSBhbGxvY2F0ZWQgDQp1c2luZyB2bWFsbG9jKCkgaGVuY2Ugbm9uLWV4
ZWMgbWVtb3J5IGluIG91ciBjYXNlLg0KDQpDaHJpc3RvcGhlDQo=

