Return-Path: <linux-arch+bounces-2549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F185D125
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 08:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962EB2823EF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8C3A8D8;
	Wed, 21 Feb 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="livul2WI"
X-Original-To: linux-arch@vger.kernel.org
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2132.outbound.protection.outlook.com [40.107.9.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8C3A8C1;
	Wed, 21 Feb 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500015; cv=fail; b=K0ZMVqNGstu119vjlElbtdYVriGz8s6hKaL8Btx+hF+93Ln0BMnsmS0iM5GgSVkQO/nlZbg526qYgVCJJ0lodpLxE0ZwxKPWQhCYixq7RK6KdfOlKBQ11guEyvfLPKcv58QYckQ+hz4Yv4V3i3toNyd+zEkZRuguBDdpTEKHxPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500015; c=relaxed/simple;
	bh=Vugcc3CJbj52FMPSPQwTUzb2Vi4gpJyifr0eyPS8gV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYi+Evo16FN2P1VLMXTO0Af8bTSIjPCw+HqFqd3vZUagVMVPfopZhGacyJTsIEDCToD5rLlrsXC498EZA+t+syBl5f169i6rNZZbk3yhcBKw3bUOrwgty1rS0CdkvtWABqf6lzSSL00+Zdd4VWf1VdoIeNpXFzMJJvFuXMnDBwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=livul2WI; arc=fail smtp.client-ip=40.107.9.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyifqikZvGPYio/WU/2hcROEGJoogl5NxWciKVlRZGdUbjLyQOIAVBLaDIQ15q6fcLE3X6FuQk6ULwwWcWvndao3A45NQcgls/c05Q8AlyFnc/TmRIQqyU744+L1OEX4S5vJT2NsvUHh4t0McnWxlTincPfMILZhQQ1HmO6/EVXo8+KsonDQE5PupnlxjOZmv6E4nFqg9hIjzISwZBR13hutKT8OqWCbla17x28910aQID+i+IOw1KiDZ/elD2Dukz5CEJHrtUwwcpveyQVSRB+o8AtVh6UemdNYTEQUpzz0LJQJXApKQPFw6Q80HwqMafgKpbQls2yqQGWneW+yDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vugcc3CJbj52FMPSPQwTUzb2Vi4gpJyifr0eyPS8gV4=;
 b=Iw6CjLtsE2HpcXGcCOawlTWEryhznt5BFw/dv63T6cGFN54K8jEMnAzNR6Gl0OnTAA0ZhBk0spb9CZ6BxAAA0fKDOwVP2jBSTXBK/B/IGX9AGw7U/eXb9pvfES8yijzyx0uuJQxo276AQ0uCkDIoGQgNUjDlpglEZR6s4xf8R18J6FrSSkka4aL+d8Y6LCUzRtMxiJTd4bmJwiuGd6kBfq1qqjPN8yH74mbyiHdAjSOBO5zbgIa4mdCzXwqAlf7J+/gtiXxHKQwjB61lUB6siO6Xl9nE4yp2oo78p0VNGAU0QatxfQPIyNaH9CI16Vxt5u9ezLr3lkSVxQNUfz7/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vugcc3CJbj52FMPSPQwTUzb2Vi4gpJyifr0eyPS8gV4=;
 b=livul2WIlWykg0kRK92vPcb73e369Doajp/HoXLzToPa+s4wguS+11qwPhHijq8WvSGwhKGeKWVG1qxNZevRruAbMVe/DkSium7IP71DZj0N2iqAwrK6XEDvfG1jFzLNNV6VOgz1RotvuPMYc13C6Zh+QOMPVxZ8cbXrUO/af2xj+3Q7Aw4Di2ws15FvjxzT7wVHR8YQwFe9mxn+Mi3DhpQY49LVmBUBGlbf+SGphmw5pXnCEU75553QG/Sf2F4VohLy5Oj8G/orluYwbw9zeivY/IkLl9R+2hqzbz5owDRkyzq8tAXSCIakmhKhO5sBrmPMQGVQb+Pvl9ab7XokpQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1567.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 07:20:10 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:20:09 +0000
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
Subject: Re: [PATCH 3/4] arm64: separate code and data virtual memory
 allocation
Thread-Topic: [PATCH 3/4] arm64: separate code and data virtual memory
 allocation
Thread-Index: AQHaZDwTLzm6aukIxEyL5imV7Y1QlLEUZFWA
Date: Wed, 21 Feb 2024 07:20:09 +0000
Message-ID: <dc1ebba5-c4a4-496d-8a46-1e58a796e4ad@csgroup.eu>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-4-mbland@motorola.com>
In-Reply-To: <20240220203256.31153-4-mbland@motorola.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1567:EE_
x-ms-office365-filtering-correlation-id: 36ac0533-bcbd-42cd-a326-08dc32ad8985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 537c8LDPSfW2V4lXJYHzDWvqG1y2+9FXpqVUesuaB+xLFF7ecjn/Y84r6ThpVU94c2mQ2thtilZr6idmgG2UgcEbYsYFFn/atEqd1MFlRM1NCIscWQ27/M/GwFc8XP35vgG0HCMA3WM1QhDuVz9kuYwGIJcmPWcCdcVbshZjn7wcq8wt00dXF3hdobqQ4H4K7OPBb5G1m1NHXbicQKMBIC4jM5Cmy3SxTAE6Jngklp7giHSoiuG2EjcwXIXZ2eeLViFV1n7c9ysw++2AfbQFFLX1UcftulQQdN/vcjP9brXnnnW2PawhNr3BB2ZlkRBXI3L398vJuIK3fR370vX4SUxzZL9WPBO2ipcwg+OXVtfPMaW5AwQXU3imMHiXbSOkygjcocwpLwWrw7QkHVOaLyN0U/4mZ2xOtFvXIvA76uAdHT+KvwYuA/AYFjgaX+XH2RcZeqA8kV8cr9miykmDmH9sQeN73wYv1h+8B6qPproxdTrLdRvhY8eNEliZNBNdOvUJLm8W2MkBy4c/u7Ot32MEFortsdEUYGysYcHP9R0JCxhQVbWKlZ9x6mq6OM+OI1orQvodqcbyKJ643Uf6pGzekn8OxFbGvSPrxWTn15Vfl/lRD/8EA/n4WSG3SSkQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkpsR2lhcGhucExPYXBqeUVPbEUwYjVBZUtMOFlmYmRseWJjUk5hUFBYcmJw?=
 =?utf-8?B?Yno0STlVM1BHRkdmb1ZXNFpnYnJJbkpWQlY4R2JGaldPeDQrUXUwVUVYTjlS?=
 =?utf-8?B?S0tId01VV2lIQUF0bHJ2bGw3eWpDc1FmRzl0U0dQdzJDZ3BPU1dJU1YyS1FB?=
 =?utf-8?B?MHUzeWxveGpzeUZQWDkwR0Z0UHlHN1BzNzd0NUx3VnVzUW5vTXRaMGR6djU2?=
 =?utf-8?B?UElmOEdPSy9NcHNIYXlzU0FyVFZZODNZQVJ0V0JnMFhYK1NiOFRIV2s0bnNj?=
 =?utf-8?B?Qlp5bkFydEd5YktEL1VhendDUnJaVXJMUisxWEFUY3Q2dldoeVhkcit4bzlr?=
 =?utf-8?B?UHFWV3NmRVcrUEd1SUdRZk1kTVlVVko1d1IwdDRpWkIxV2txcTQ4dXJoZncy?=
 =?utf-8?B?RnlOMWpyM3dkcnQrVnkvM250TEZCL3ZGTldkclRtN0dqSm94OUdIUzIrZ1hy?=
 =?utf-8?B?SnVpRWhTVkk3ZkVCZk01WGtoaXVuK0RFb2lxNmVHNkxKYTNCV3FxWTE4cDcz?=
 =?utf-8?B?eWJDbGFQMDN3TXhFYkk4STF0U1MxbEhKMHFTdEdxczZrRzY0MmpwMXdDbGJW?=
 =?utf-8?B?QmdIdmZ4NEs1bFdvQk9YODRZeE13SHlTaUhBUHNJaldkemJJTit6dGJXcjNr?=
 =?utf-8?B?RmhtTmJmZkZLMjdRMzR2cmUxZU1mY253eFpCazQrMFY4VUw4ekdGYnpwOWF5?=
 =?utf-8?B?REEvWnJVNWFlWUNIODg1YnpZbmVyb0plSG1BTlVmU1VFNFRNdkgyLzcrSXpz?=
 =?utf-8?B?aE9EMVI4ZXROOGdIYjFWMTVQMGhjV1gzZFFuMTFXeHBueWJMV2lQeklDazBi?=
 =?utf-8?B?UXNUOWpndyt2bEF6UTFkSU5zdng0WkMxWjFFVG5DZXdJUlltN3NRUlFvSXkv?=
 =?utf-8?B?cXdRM0tFVDFPVHpoTjF6VHZHejJuZTBnTXB3MElYREM0T0JLdG5paElkdlgx?=
 =?utf-8?B?aXRxelB3VlIxeDlyci9QQ0VoNkxJY0hkUkJ0WWNnUmNrNDErTXlkYUdnTkFZ?=
 =?utf-8?B?Z2pDWldYTS9VL1NJd2JIZG1DUS8yNzd1T3BHMldmRXhYS2FxQ3pZelZpcTRa?=
 =?utf-8?B?MC9wYWIxdTh0aUkvWEMxV1IvM0c5K3RVZlBOZ1lsQlpkV09FTE42U2N1cEN6?=
 =?utf-8?B?MmErZ0J4WGJUVHVYM0xsTXcvUC84UHNWMDFlYlk5RWE5OW1pMDVmMW43QjZK?=
 =?utf-8?B?MGdwbnd3Wm1NVDBuZUhRR0JjYTZkcm1UUkhyYm1CV28rSW54UndpdGQ3ckVn?=
 =?utf-8?B?YzZoVXZwNElyVW8rckZBNm9uSFlpNk4zN2JmbjQzd2NRV0wrSEZjWFJRWjNq?=
 =?utf-8?B?UjhWMkxLYXlRRWhiUnpueXZIdENYK0J6OUJaUlR4b245T1Q3Z201Y2kzcmUw?=
 =?utf-8?B?aWpWTUlnMklKWktvWkZMVmtOZ0xMaUxPVE1XVmZPcTVhN1Y3enNSR0NmVnVR?=
 =?utf-8?B?VlBkV3g3TGxLa1B5ZDFuaE0xVHpYNDRtYlNad1hqSzErbW16UmQxYUhqUmdm?=
 =?utf-8?B?VEJWMEhkUml1Qk5oaTlTSG42WG9DYjI5Q2kzaGpLL1VVL0RveXpEZzh2TEUv?=
 =?utf-8?B?OVNmakZjZ1R1aG5MRXZoTTgyRVo4Vm1zYkdRbmVZNngvOGdmQ3V4VFBVUzI3?=
 =?utf-8?B?dzZFalZIY1l5dGdFelJzT3h2c0Q5bVUzWm4wa2V1dVhXQ3QrS3JNZTFWWWdu?=
 =?utf-8?B?bXJsbkxkYmw3djRzandvVHREam9kVXJLYnlkbzd5NjAveWZtSmZidUJsbE9G?=
 =?utf-8?B?NEVBRlJUZWE4RHlWaUwvUE91ZEMwVmtBYlpqOUNaNHFtdm9pOFF4QjFHdUZh?=
 =?utf-8?B?UlNPYTVjY0dRZWtLZE0zK3VWNDNNYmNGWWlCS0JXZFpsSzlCVU5sdSs4R0lm?=
 =?utf-8?B?NEJGbmZ4NmhjUmFkNTVybzRoSXZoR2t3dWZhM3FXTStpTDYxM2hJNnRueno2?=
 =?utf-8?B?dG1keHRidTU0VkZsczBTZStzRzNJR3FMTUZNL2VGMi96UlRjZ0VyQzkzMFgy?=
 =?utf-8?B?L1lkdTk1SkI1d1hqRE5PZVE3eExaRjJGZU01LzYvR0JPRXpka0lPN09CclNB?=
 =?utf-8?B?WVJjR1F1YVpLV1V0K1k3bGNZWTREYmF2bmRtZS8xaHZ5elNtaEFnM3g0dzQ1?=
 =?utf-8?Q?eDK/oNAkakp6bTFWRZVSc70bv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE918AA4F859F04F9DB4BE5CE3EEA3AA@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac0533-bcbd-42cd-a326-08dc32ad8985
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:20:09.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OA76lf9T5Au5Q+oa7AhhnrGXk55/UMLPwJ4Y1VKRCQlLTbbDTimDaqjRLtsoOJIvZFqnsB3A564ApyS6vtGfO/ELIoWfbZvX5DL5lB4Kia4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1567

DQoNCkxlIDIwLzAyLzIwMjQgw6AgMjE6MzIsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgbWJsYW5kQG1vdG9y
b2xhLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEN1cnJlbnQg
QlBGIGFuZCBrcHJvYmUgaW5zdHJ1Y3Rpb24gYWxsb2NhdGlvbiBpbnRlcmZhY2VzIGRvIG5vdCBt
YXRjaA0KPiB0aGUgYmFzZSBrZXJuZWwgYW5kIGludGVybWluZ2xlIGNvZGUgYW5kIGRhdGEgcGFn
ZXMgd2l0aGluIHRoZSBzYW1lDQo+IHNlY3Rpb25zLiBJbiB0aGUgY2FzZSBvZiBCUEYsIHRoaXMg
YXBwZWFycyB0byBiZSBhIHJlc3VsdCBvZiBjb2RlDQo+IGR1cGxpY2F0aW9uIGJldHdlZW4gdGhl
IGtlcm5lbCdzIEpJVCBjb21waWxlciBhbmQgYXJtNjQncyBKSVQuICBIb3dldmVyLA0KPiBUaGlz
IGlzIG5vIGxvbmdlciBuZWNlc3NhcnkgZ2l2ZW4gdGhlIHBvc3NpYmlsaXR5IG9mIG92ZXJyaWRp
bmcgdm1hbGxvYw0KPiB3cmFwcGVyIGZ1bmN0aW9ucy4NCg0KV2h5IGRvIHlvdSBuZWVkIHRvIG92
ZXJyaWRlIHZtYWxsb2Mgd3JhcHBlciBmdW5jdGlvbnMgZm9yIHRoYXQgPw0KDQpTZWUgcG93ZXJw
YywgZm9yIGtwcm9iZXMsIGFsbG9jX2luc25fcGFnZSgpIHVzZXMgbW9kdWxlX2FsbG9jKCkuDQpP
biBwb3dlcnBjLCB0aGUgYXBwcm9hY2ggaXMgdGhhdCB2bWFsbG9jKCkgcHJvdmlkZXMgbm9uLWV4
ZWMgbWVtb3J5IA0Kd2hpbGUgbW9kdWxlX2FsbG9jKCkgcHJvdmlkZXMgZXhlY3V0YWJsZSBtZW1v
cnkuDQoNCkNocmlzdG9waGUNCg==

