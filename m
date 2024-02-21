Return-Path: <linux-arch+bounces-2592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB585E470
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07461C211DE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F383CAE;
	Wed, 21 Feb 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="YRjAyTGp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EF7FBDC;
	Wed, 21 Feb 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536043; cv=fail; b=dg4F73Y+H41Pz3mlAQ+gu5VMke3S15J4nELGqqSBwU3bwXw/XeBvTTfkeCJ6h5Qn4voMJ+R6yF7bLitNOxAv1Kw5B4XZi+39RHsni1lKbv2LMK9n2RAvlgk6+piqh2MvDTttSf1et/UzEhuqpeXlLZs8Jx9nLHUnYICuC89ELxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536043; c=relaxed/simple;
	bh=A16FWm2ylqNOU3f2uziRcCTYLkAP3hC2xgtH7xfVk8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aX1S4vBtgb237ap2eQ5nzrDpo/D2h9UZKogdV5xwIJ8orp+fgB6CHau4Z2zy3HAIYNMOX9yB0M2FrVFYuSU/jJ+UyTHRy+GkBDEY5qmUZGDJxb3yf/50DWUsEjXq54V0I03XV9zcpDYKkoPpL4axrrGgCjoDQZgnnxhDxDVmfGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=YRjAyTGp; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LH8G9C020266;
	Wed, 21 Feb 2024 17:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=A16FWm2ylqNOU3f2uziRcCTYLkAP3hC2xgtH7xfVk8I=; b=Y
	RjAyTGpsGwyX3fpP8bUDCsUI8bv4ri+bS5BcTOBybcl5tenQb8HLkcKoSJlkqOsZ
	0pYOTQ1SqZ13qF57AJufRAIUGh1zYUopComy7lWHm+pT2SYqww1PkIw5EV40HwIn
	cqM6xTp6QrxGFsn8iPo8fYIVsVFF4kqER0j+tZyPACtIO4iGaN2nZfi8WvgZITQW
	PilrzR4QqepLyDhPFdt7uClYVcIrMTkK0TnrdH6U8mQPcDQW4KmieZnLU3FdsaEe
	0P1LYkiJ+DMzyWgE5Sj7m9ZTlZpfPCZImJTxVZ+vHxJE8NtME+c/M7zECIr4Ka48
	mljeLn0mLU9JCB7mjU2ng==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3wda6dt1tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:19:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6KWxvvHlU0jWj2vbiDwmEfEaFfZRsKV9SZcAAA/oaQFwTXKGX5YAXpH1kikXwDKZi46NF3Cb8siyLfT+agJWylkT23iCls2CVSZmgORiCOqsP8U8ueAOO1v/i+WjJxr9PYirjWjgW+zcQvd/e1W3cJmkzwMSTV2L40DpiBAdWAGhLDmjXAgntmLOwzb8d9A6wF5McbqxR6utG2COo2aVuWMFSzTesHrkIlBzl0lkNb5cY0DTIT2m9763Cx8FLe+0LNA/zmg+Y+AuRdvjKkIl+H8YZEXFZ3atyOSVx3EX4++acGcymlnvNekcTedR42wlpcLlHZYd0QMNXwCASnmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A16FWm2ylqNOU3f2uziRcCTYLkAP3hC2xgtH7xfVk8I=;
 b=MGTcODYIFmAuCAI49fvDrL4NXE0Ie+i7tOMKoWFATIXd8slCTzRQnj+tTMp69quoqr6TpkwqgkdaW4mOmKDY229XP86B75nj/dofZ54cYkt/9sLVGREYTutUM9eA2k7jwbQ4bz7m2kHzwRCUUpGyWK4IQOIUwRTDHUBhQP5kqKbcm40OVuk6lk4cRpDtwGMgsYUnn8FY3P0v85pHQopRmgR0d2P/kWszyG6oEL1kqWXQ5G6JtTTMpX+DbQnfogxfTffWE6IeSwV29VAnIhxSHu+ixFyJBgG/6+tDzuIYvSw/We3m9Wv+2ZHpeUIhASG3aKR4lqegCHhf9pGA4baHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by SI6PR03MB9032.apcprd03.prod.outlook.com (2603:1096:4:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 17:19:53 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:19:53 +0000
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
Subject: Re: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Thread-Topic: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Thread-Index: AQHaZOovDm6xvxRBMUiuzkOVo5kMqw==
Date: Wed, 21 Feb 2024 17:19:53 +0000
Message-ID: 
 <SEZPR03MB67867ACC0D9AAD3A3AB19EBAB4572@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-2-mbland@motorola.com>
 <4026e0f4-f0f3-4386-b9e9-62834c823fc9@csgroup.eu>
In-Reply-To: <4026e0f4-f0f3-4386-b9e9-62834c823fc9@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|SI6PR03MB9032:EE_
x-ms-office365-filtering-correlation-id: 93a026fc-7063-4f6b-da50-08dc330151a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jNK41NW185C9Av48J6JIwOOAcGYr1P7xl/03poGw09xEkYOlInmAhZA2h1ZyikrYsnZUl/MTbtoCkOvAcA4U+/4zLDeur5RC91agxgm8/w08HH1XAaNFuiGz0vkWJKw7gUohL6InCSSr4RliC86cQiPkgFAFVWUO8++Ziv8OgwiSF4/rypBMu0PBcoRN6MGp48ZAWxIVz9+GeevU3ZERXuDEWUiy7cUJAoP4IhNlY/f91AjBbMYHHUyGT+DIa16mDz4nIXX/adGsShcTS30Xx0EHTA1aJ/Xp+SHvcSxlczFCeCObwG34tkYIL7Hzeq8x87nvl8NIvNL8c3ZnxrieXOuc7H0/uoWQv0N8dPGjrnTxQhYpHCrVp22W+XuRxrdcO+XfTAluKF+qJcM7PU9FdCnrZ6NV014YA7U9Qa0faQnhNLPC1F+r4NmAqcuZqxWNDdcyBY9yeB+Jjza0vGecBWDZgSof1Dul3B/1izDnlW4UqQyzPjak8edYUTro2y/kYapUtWYP9w7VsiEbVI5G7f4zvp46u6gQZycMTK2H3C8BQg+7tZtbHQVFKhGMB5Z3n26fKhS6lZ76SyhpRlFIR6yiboCn5ixyydobYcZqKrb1G1LuQ14xodrQbkaerdRH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MStISkhsOVo1YmpraXFUaDFmdHZXV1RUMUdyUXZ3WTRmbHhjMW5jVnBER2hq?=
 =?utf-8?B?cFhBK0doTUcyYUZvcXJWRWlPNVZ4QU1NQ0xDc1VucEhlaGNlTVFCcDFxb0lq?=
 =?utf-8?B?R1VhODFvNzRRQUZnaWFjc1J4VUFBdkJTMVBrZzN2Mnp0QngzNno3SU5qN2pW?=
 =?utf-8?B?ZWpuUlNiMXU0SDNuNDhBUGwwTWo4ZXB6WmZ6REV1eG5BQUJvNVpubW0zT2Rm?=
 =?utf-8?B?dC9LTzFFS3RScE16eGU3QUQvdzNYbEZUTE1mdlRLQnFzQm12TDVjMXc4Tklr?=
 =?utf-8?B?Vzd2aFBlTytoVGhlZkN0SG81MkVCN3Z5YzZabFVEMUhzUWxIZzRQcmVub0N3?=
 =?utf-8?B?OTRtQzZFbE1VYzBSU2thNjRMbnl6MzhDT1RFbUJqSVhBa1ZyNzJ0cFdJSjho?=
 =?utf-8?B?UEIvRm9Ca3RiMTdFNFpEcjNIMUpjSTdTV09HL1pLTERnTFBpQmxxdDdFVkpZ?=
 =?utf-8?B?ZFFQRlFMTTV1U2J0Q1VWNVRXT3Vzb29vMlFycjMxNDhYcGhDODFVdHYwZ2M1?=
 =?utf-8?B?ejdtQXN3Q1ZCTUN4eE5sS01YQzlSbWkrOGFxRHNSREIwQlFCMHpRUXZiZHhR?=
 =?utf-8?B?Z0VYVHV3SWRxMXhRNFlzY0tHYTFpOTBNZFRTRDBBcWc4OWJVL1VmZDMyT2Fr?=
 =?utf-8?B?RHVkSWxKSW1lbzJscUFBMEE5Z016YjRGV2I4YTRrZldDUVBwd3FuM1FaZUht?=
 =?utf-8?B?aUpZcUR1NHU4UmQwVVF5UzZVYmQvSjRwaTFCTzkyN0VucHQ1V0ZhRXNUUXBF?=
 =?utf-8?B?VDBXSGsrTFRVYTdYQVAzZ2czOXpLNXNWcUMzU0luYkp4ZXNsb1VVT01ZbG0y?=
 =?utf-8?B?STZ6RDQwYXFJWE5oVXhicklBSEVGVG9LenhVd1JYV3E3VmhXeDdSckdZQ3B5?=
 =?utf-8?B?LzNHWkJQT1lHYWlkTEluaGpYU3dDMlRJYXpnQkgzOWtweW56eCszQ3ZzcDFJ?=
 =?utf-8?B?T3lHM2R6S1dPWUVsM2dWZi9EVGZ3UW4ybUNobzFqZE4xc29rVFdUQllpakFT?=
 =?utf-8?B?cUkrb2xaMnhHTTJ5azRzbW5VSjJMR0cvNzFlT2FsS21HelcwcjA1MmxJZEE4?=
 =?utf-8?B?VGtocVNUeG9KOERFYXVnRjV6QlZSaVQvejFsNXpoVEN4VVoyVE9YQkg2dlJV?=
 =?utf-8?B?VUN6SXRNYUI3NHE5R1hQSXZ3VVI2c213bkZHelFBZWRxRjJMSFBxSWtLSkJp?=
 =?utf-8?B?d3lVWnB2ZkNFcHJWczlnM2EreG8rWURDQnV6Z2s0WkZTSXRLQnJRS3NwQVpK?=
 =?utf-8?B?Z25YUy9CcUJELzlLNkhRVGVsMi9uQThqNHlMcFZ6RjhKYVRReWplRXhCeXlu?=
 =?utf-8?B?c0c3SjZ6TzRyeU5IRnNLZ3pXSHZwdDNZRFVjT1gyS3pxdGdFSHU2WFhneWxV?=
 =?utf-8?B?K3BXaU1FYVM2cCtWL0Nwait5V3NhOHBiUGJJY0gwZE8wSVBGQmM0bjh0dVVS?=
 =?utf-8?B?djlXczAzMHh2YS8rV1ptM3BmVURFbWxxQUdKV1dNZFJhOW1PaklYWC9pUVNQ?=
 =?utf-8?B?L2pGOTYvNVdSd3N1UWt6b2k1S1Q5QzRUU1VkZGtITUxURFhGdFlFKzJTdVBE?=
 =?utf-8?B?RVJHRDJTVnNHUUI0VWI5eUlpWGhLb0lNbEQwV2xHN1pEMUNBMUpkQVVnN21T?=
 =?utf-8?B?WThNOU45S2VKQkIrcjAxU0VmNGt3WmVTTjNhQmhldjdTYVk5QkhwTit1MXc4?=
 =?utf-8?B?MHF3cjNlc1ZJekhTQXNXUWkveHAvb3ZIMC9vSVpHcGpQODkwUFkrdUtRM3Mr?=
 =?utf-8?B?a0xQOWQ4Um4wUVZoM2l2TFh5bWVYUS9iNTVRYkFpaE5Xeldwa3lxc3Jzcmpp?=
 =?utf-8?B?UlFrVEpua25vVmR0QUdLbDNBUnhsWkh3WS9LVW9FRzdLcENpQU9EaHVMRVpG?=
 =?utf-8?B?UDhSTEdQekh4NWh4QURTZ1BEaWQxbU44NXZrNGxUU056OEx5TVF0NXo1c0xJ?=
 =?utf-8?B?K1AySGM4c1l5ME1IY2VPTnpYVFROV2xYaE5BdGJDbmF3UENtcHBwQlFGNjhB?=
 =?utf-8?B?cDdDUExTZ2VpMThZYWFKNEowY29GSVR4dG1oazRVZlBKQnpneDYra2lwMGgr?=
 =?utf-8?B?eVpaQXZTODlnRlJUaHczTnNxd1gwK0N1VVpSTmJnZE53TlB4azNVUFU1ZERv?=
 =?utf-8?Q?eW+Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a026fc-7063-4f6b-da50-08dc330151a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 17:19:53.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72jIbILg8ZqP+TZn2CsrTBc3gBzdYzltZg5je2/0ag/Zwdz4+hXoD0wAqB33nEOinpWX1M0nk6VwDjXNVVJRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9032
X-Proofpoint-GUID: Anrb8UwrX8w3BZK-gnzrdoMgiKxQTAsp
X-Proofpoint-ORIG-GUID: Anrb8UwrX8w3BZK-gnzrdoMgiKxQTAsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=924
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210134

PiBPbiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDIxLCAyMDI0IDEyOjU5IEFNLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPiANCj4gSW4gdGhlIGNvZGUgeW91IGFkZCBfX3dlYWsgZm9yIHRoYXQuIEJ1
dCB5b3UgYWxzbyBhZGQgdGhlIGZsYWdzIHRvIHRoZQ0KPiBwYXJhbWV0ZXJzIGFuZCBJIGNhbid0
IHVuZGVyc3RhbmQgd2h5IHdoZW4gcmVhZGluZyB0aGUgYWJvdmUgZGVzY3JpcHRpb24uDQoNClRo
aXMgIGNoYW5nZSB3YXMgbWFkZSB0byBhbGxvdyBtb3N0IGtlcm5lbCBpbnRlcmZhY2VzIHVzZSB2
bWFsbG9jX25vZGUgYW5kDQplbmFibGUgdGhlIG92ZXJyaWRlcyB0byB3b3JrLiBJdCBhbHNvIHJl
ZHVjZXMgdGhlIG51bWJlciBvZiBrZXJuZWwgbG9jYXRpb25zDQp3aGljaCB3b3VsZCBuZWVkIHRv
IGJlIGNoYW5nZSBpZiB0aGVyZSB3YXMgZXZlciBhIGNoYW5nZSB0byB0aGUNCnZtYWxsb2Nfbm9k
ZV9yYW5nZSBpbnRlcmZhY2UuDQoNCkhvd2V2ZXIsIHRoZXJlIGlzIGEgcHVzaGJhY2sgdG8gb3Zl
cnJpZGluZyB0aGUgdm1hbGxvYyBpbnRlcmZhY2UsIHNvIHRoaXMgY2hhbmdlDQp3aWxsIGxpa2Vs
eSBub3Qgc2hvdyB1cCBpbiBteSBmaW5hbCBwYXRjaC4NCg0KUmVnYXJkcywNCk1heHdlbGwNCg0K

