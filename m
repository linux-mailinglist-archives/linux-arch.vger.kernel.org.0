Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD5E41E51B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 01:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbhI3Xxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 19:53:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63124 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350111AbhI3Xxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 19:53:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UMYlmu032383;
        Thu, 30 Sep 2021 23:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ytQY5uBv+NtJb7V+Bf6gZRFFbwg60Ox4VihLiiNrZrU=;
 b=LkX0+6VU9UwvStUbhXjPKYa2snbrgm+5iZzYUZYzhKz+iYqQM6QuYSFxzGJdrXzlpJa8
 OuSBGhbyEQ9kcDUP/v5shdJNYj7/0kFrn7Rc+mYfT/vxuos2ncbeicGyWG3iOj2HRjzY
 O3heZ6/eUYfeBHF9UCn3N3GoLABWX8WE6wLzha9XlBtK7KsRq2EyAH7dwuHqYV+IIGgf
 HxgTw/wrjuQ3q3NoBa/dTQwfwYD3b8NuCM1bvPENz8TO0kQi/0c1IYIRW7RF7fvJvp1V
 M5vAxgLkA7dh1rPAxasqxzLvFzljqQKDAucSvwlPOontkRB3zywQ3SORCHTGa/ntYdWR mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3cc9ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 23:51:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UMuIfe048279;
        Thu, 30 Sep 2021 23:51:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3bc3cgqhf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 23:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqILrOnopJMCf6Y0PH738TUbYrp25e3pCfFLflRIvKe2U7p0jvAVQMOEsC5q/Or6fXethf25zMndmcDDGra8oLsBgtwB6104RH9A6orZOfqYG3GBURXCSN/jChDEEvBqqHXcN4ZoSlMtQZw9hnCMczgx0IXLubnSzpFFqZzGdgUoWEwT2gpR639zHREiKxzZaD6C1BDmu5nEuENvEN1CNblyiRaGv9uGoJkpBLKycQj72hKhd0ybzM6Rh+LesncCAA8ngLnkHlMcCeBJ4qyO1D6hfK3ObpxBWxYoYX8frYrpUdwhnkp9UGORnqaDMiFkgkto6+rH3tPa5uysTRrWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytQY5uBv+NtJb7V+Bf6gZRFFbwg60Ox4VihLiiNrZrU=;
 b=HkWdP5yUHIDUX2mLuAf9btH8W8cOeC23B/pkF6bjO9DttX+x1cq5HndEhfcgSC500uiPJjjDSochCmjNcKCpcROeTzX6Sv6gJdcaCyd8nJ1JVrkTw5mfxSLuojF5cQKWP5LvKpXhGyeDrmSWz19bSvA4m4V6SIgHrB8XLjd1Y59FQP5OS80tNvc3PXih6r9RXvaCNC2aSGBfOgz+TB7RIHs/itmdO3Uck5uLsGkQst9C44Gsr6mu9hwbRK4ahBXNyBodBucNsI+Z3og5zxTV/qUO21NwVPwPphjMF0YCziLPZq+t7+/IZWhUzXlH9OkHqCwACfmHerWdlKHkbOxCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytQY5uBv+NtJb7V+Bf6gZRFFbwg60Ox4VihLiiNrZrU=;
 b=uLlM68dgYCJiVB9sVRBknxPIpqQFQyd2zvuqVw5pb97Bem0Mt6WtV2nQtTqEEew121OxHbUU8mUq3hmUqV/kcXjRzGvLDDHRccgh1sJVIpaRX+uf1F0mK4uHqTTSkBmWXhTed46CkIsEcRUXN+pxhAu0IGAygF+FsMkAP2sczDE=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by BLAPR10MB4963.namprd10.prod.outlook.com (2603:10b6:208:326::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 23:51:11 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::f48b:4908:d953:a163]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::f48b:4908:d953:a163%5]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 23:51:11 +0000
From:   Alex Kogan <alex.kogan@oracle.com>
To:     Barry Song <21cnbao@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Dice <dave.dice@oracle.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jglauber@marvell.com" <jglauber@marvell.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "longman@redhat.com" <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Thread-Topic: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Thread-Index: AQHXtd/cItDmpDT0R0WUWd+2hoaJ1Ku9QFYA
Date:   Thu, 30 Sep 2021 23:51:11 +0000
Message-ID: <0FF6E325-3490-4A8B-BB04-D36CCBFA1D19@oracle.com>
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210930094447.9719-1-21cnbao@gmail.com>
In-Reply-To: <20210930094447.9719-1-21cnbao@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41e85e41-39d0-4b4d-f452-08d9846d2e87
x-ms-traffictypediagnostic: BLAPR10MB4963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR10MB496398A6689643B9A94C7A26F1AA9@BLAPR10MB4963.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2jK1Yo4fbpaIHJfFLGFq0Ld69gMQ9/740bWGGkfQ9D6VRvM2BdZt4cx2beBb0D8/1Ck2DJScqUNah+Sg55kfQvDrHTzKVcrUTTWtTQ6MfTC0X4sKi++R+CYoCaLucZP+JUUzMSYbnQu6kLeF61Iua/tAZqyb3fS0UrPlBGdIPpIa1fPIXBLhMhRQrniCrkwDoV00vQE9GXNUxgs7dgNdqsyy/hAmLQq4NjQn0VG4cIVsGHsZmLgJr9VzHq5qlq2IXzO4YkBmVyMm4iNG2Ip+i/eP0YcX4MJ2LYP2XSSE90Dxvl6IHLWeykNBKXkyvl/OmYibEtdzqto6c3VDu39mGYE4LRTX97E/tLDb64REegb2QyrlNqaEbrvWZuiX/uVUuuSIZVUoOLjB2VNWc6KMrO/69APuWWW4jZOsVGAk9BiY8x2OedV4cboI5ldtF16m5tPqD6RVxEvcZHKlSweIK+NYbjpGzIBUiEKVLN96x13h9vFBgwdb+eFsogVwrknkIsw737gWgtTROvOROuAegoeWk65Y3GHmAkt1HVaIeLxHKFJp7Emv/CMS4Y4Pj6bZjgWGWbMkLS/COqRJaZ4O9Ntju/OAKA9aOKWlE76PdH7Dhc1+T1NbeIqH53I0/+itvVLk1zh0z+7+rGB7B98H8kYz5KeCsLfxswMylRkorLLFFS8YvaCkdBNDbvcQcms9rnVOC1gvehiVOCJE1wOWK53i+mJAHJPvJCGT8CGYvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(64756008)(91956017)(76116006)(2616005)(66946007)(508600001)(36756003)(86362001)(66476007)(66556008)(8676002)(2906002)(8936002)(6486002)(33656002)(316002)(54906003)(7416002)(6916009)(4326008)(53546011)(44832011)(5660300002)(6506007)(38070700005)(6512007)(122000001)(38100700002)(186003)(83380400001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUlOQnlNTG1hcWkvV2NVc0tBdmYyRlk4SzJQK0RlUm9pYlF3Zm95bWowL2Jm?=
 =?utf-8?B?SkdHVzFnblNUL1lIU1BjV1ViU1AyRGtkME1ycGxkNXcrbzU0OEFFekFKSDZC?=
 =?utf-8?B?cnJtL3hGWVBOaVpPWHlxZEIxeDc3TndCSDkwUGZiR01EckJFM3RySmpMd2g1?=
 =?utf-8?B?aHhuOUVoRWdzOVF5VUdPeFBueHRaak1taTVUeStrV3ZTZ3FQb1RZamtzYzVt?=
 =?utf-8?B?ZGZKcTR5QzBaQk5LbXNEdFVuTjloSXRZWXFJLzBrOFUrdDRKSDBOZkRyNjFz?=
 =?utf-8?B?aGUwQ00vb29qVzV2VmZEWG9jOTZsYjhUYzBuaUZnc0x2c0JNUHpsZkpzc3Nh?=
 =?utf-8?B?Qkc1VjI1czVveWJ5TUFsRjFhUE5zbjhUalZYc1dJeU5DSk11TXI0Mzl4N2hG?=
 =?utf-8?B?aEtBR1BoS0RlMUpiUHMxS3FBV0I0MWVtdkgvWWhmb0FTcEY0VEYrc2JRT3A0?=
 =?utf-8?B?NDd1VEtKekxkSEVUV2pTVVZ2WWxWaGZvNmx2UG8rSXJQS2kycGFwNmFnckR6?=
 =?utf-8?B?R3BZUDRVWEN0YlFibEs4Zml6aXd0c2p1cmk5djFHOEZZcXllK2FFb0d5VjBh?=
 =?utf-8?B?Z1A0am9tOFVURFVWTW9uR3NtdUpWTEtLU1d2OTE1ZjQ4SVBlZ0R3dTdYaDJH?=
 =?utf-8?B?RXN1MUdENEZaRC9RaHlHRFRZZ1g4eVFqc044eWxMYjczUGVLMEhoVEtTajEz?=
 =?utf-8?B?NU1DTEs1TU5uS1p5Y05XNGVETDRhaFpyZS9KelBHYmtRTUU5ak4wOVdQQ0hQ?=
 =?utf-8?B?NFNDMUNvV2IzRkJDcVRBZlhlbythbjAyeTFQRmpKOFBHeHlJOGRpNEx5azlD?=
 =?utf-8?B?N3JsWVJHREdkc2VSb1VMUjc2bk1lWkcvSStlRzRoSVRPNTR1eVc0aEU5dVI3?=
 =?utf-8?B?ZndVaG9xcm5uZ2NFdGg2QVZUVmhnT3NnUzNJNUZLTGNiYjVUZWZENkF2SkZI?=
 =?utf-8?B?Q0N4SllkV0tMZXdwMmxIblZLK2NubkE2azV4WkNPV3M2L0FVL21tMHZUZDZW?=
 =?utf-8?B?RFhGN3BWd1FCcVJzUkNuanRtNkhOQmdKYnJuMmp1Z0YrbFpqYUI0dDNtY0pQ?=
 =?utf-8?B?NmJrZUhobGpld0g2VjkwaUlJQk5oZTlpd2hka3NuRk1PaHdES3NFQUxTRXdO?=
 =?utf-8?B?NndMbXAwaWpQSTJML0srNElXVERrTjI5UlRaUXRweUpGWHNjdHk0b3pSTVNp?=
 =?utf-8?B?eWZ4QmxpVlNHLzFDTmh6cGdCZjE4LzFOWW1pd2JCbkMvdGlMb3dWMWJydkZp?=
 =?utf-8?B?RHIzSkZHYmVldGVsUWFrb0orNEoyWGtEWTR1TW5ES1hzQk9JOUdJK3JHYmZF?=
 =?utf-8?B?enA3eGdOTTAyMElrZGxwVStMOWhQT1FjSHFRUTFkM2VPbU9qWXg5a1JiM0JH?=
 =?utf-8?B?SDRzR1pLMVVJSTBYeHpoZkxFVHJUS1RrZUJkTC9NdEJ5QXd4cnh5QnY3dy9L?=
 =?utf-8?B?MCtlU2pZSnlKNUhSMmVOQkR5aU05SjVHdmt6RU5YU0JMTWpNUytuS2ZwdS8y?=
 =?utf-8?B?N1Z1L3hhQnNuZVVSVE01d2tUZVl0K1YySGU3VEdPV3B5OFdXWkVQUW1vNDQ2?=
 =?utf-8?B?RFpqL0JuUDRJL2VNSTRwemJ3b0h0V01FY09tZjZoVWlQMXRkamRFVFJaSU54?=
 =?utf-8?B?QnZUdnFabk5PVFdhQVZJQ205bm16bGoxcWdUZEJMZU5yalYyTHA1YmxvT3ZH?=
 =?utf-8?B?enk1YVdZWk9MVHFyR2x4MTdJd3pINUllbkhJSmlaQlZQSEdHY1A4VVM2eGNS?=
 =?utf-8?B?RFZiS3IrSUM1WVYraTFPOTR2MkRNV3k1RGdkcWRqY29lb2drSURVaDVNbUZC?=
 =?utf-8?Q?6aTsmI5x1cym4MUU2rsMdoEIlskxiVxwiQR+0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <988B683F2F08F04F80FC6BF4BD43D041@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e85e41-39d0-4b4d-f452-08d9846d2e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 23:51:11.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/3EOt+i4GMPEWuMISVc8KbSb90DGjKGwZjNZo3xyH63I1zRTcq+VNWvOrScA4KKjfsmc8VdrkJXw7vkzvmOyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4963
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300141
X-Proofpoint-GUID: ITVxbb_fzmr7LPa4M26r44dq3tvqBuuO
X-Proofpoint-ORIG-GUID: ITVxbb_fzmr7LPa4M26r44dq3tvqBuuO
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gT24gU2VwIDMwLCAyMDIxLCBhdCA1OjQ0IEFNLCBCYXJyeSBTb25nIDwyMWNuYmFvQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gV2UgaGF2ZSBkb25lIHNvbWUgcGVyZm9ybWFuY2UgZXZh
bHVhdGlvbiB3aXRoIHRoZSBsb2NrdG9ydHVyZSBtb2R1bGUNCj4+IGFzIHdlbGwgYXMgd2l0aCBz
ZXZlcmFsIGJlbmNobWFya3MgZnJvbSB0aGUgd2lsbC1pdC1zY2FsZSByZXBvLg0KPj4gVGhlIGZv
bGxvd2luZyBsb2NrdG9ydHVyZSByZXN1bHRzIGFyZSBmcm9tIGFuIE9yYWNsZSBYNS00IHNlcnZl
cg0KPj4gKGZvdXIgSW50ZWwgWGVvbiBFNy04ODk1IHYzIEAgMi42MEdIeiBzb2NrZXRzIHdpdGgg
MTggaHlwZXJ0aHJlYWRlZA0KPj4gY29yZXMgZWFjaCkuIEVhY2ggbnVtYmVyIHJlcHJlc2VudHMg
YW4gYXZlcmFnZSAob3ZlciAyNSBydW5zKSBvZiB0aGUNCj4+IHRvdGFsIG51bWJlciBvZiBvcHMg
KHgxMF43KSByZXBvcnRlZCBhdCB0aGUgZW5kIG9mIGVhY2ggcnVuLiBUaGUgDQo+PiBzdGFuZGFy
ZCBkZXZpYXRpb24gaXMgYWxzbyByZXBvcnRlZCBpbiAoKSwgYW5kIGluIGdlbmVyYWwgaXMgYWJv
dXQgMyUNCj4+IGZyb20gdGhlIGF2ZXJhZ2UuIFRoZSAnc3RvY2snIGtlcm5lbCBpcyB2NS4xMi4w
LA0KPiANCj4gSSBhc3N1bWUgeDUtNCBzZXJ2ZXIgaGFzIHRoZSBjcm9zc2JhciB0b3BvbG9neSBh
bmQgaXRzIG51bWEgZGlhbWV0ZXIgaXMNCj4gMWhvcCwgYW5kIGFsbCB0ZXN0cyB3ZXJlIGRvbmUg
b24gdGhpcyBraW5kIG9mIHN5bW1ldHJpY2FsIHRvcG9sb2d5LiBBbQ0KPiBJIHJpZ2h0PyANCj4g
DQo+ICAgIOKUjOKUgOKUkCAgICAgICAgICAgICAgICAg4pSM4pSA4pSQDQo+ICAgIOKUgiDilJzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQg4pSC
DQo+ICAgIOKUlOKUgOKUpDEgICAgICAgICAgICAgICAx4pSU4pSs4pSYDQo+ICAgICAg4pSCICAx
ICAgICAgICAgICAxICAg4pSCDQo+ICAgICAg4pSCICAgIDEgICAgICAgMSAgICAg4pSCDQo+ICAg
ICAg4pSCICAgICAgMSAgIDEgICAgICAg4pSCDQo+ICAgICAg4pSCICAgICAgICAxICAgICAgICAg
4pSCDQo+ICAgICAg4pSCICAgICAgMSAgIDEgICAgICAg4pSCDQo+ICAgICAg4pSCICAgICAxICAg
ICAgMSAgICAg4pSCDQo+ICAgICAg4pSCICAgMSAgICAgICAgIDEgICAg4pSCDQo+ICAgICDilIzi
lLzilJAxICAgICAgICAgICAgIDEgIOKUnOKUgOKUkA0KPiAgICAg4pSC4pS84pS84pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkIOKUgg0KPiAgICAg
4pSU4pSA4pSYICAgICAgICAgICAgICAgICDilJTilIDilJgNCj4gDQo+IA0KPiB3aGF0IGlmIHRo
ZSBoYXJkd2FyZSBpcyB1c2luZyB0aGUgcmluZyB0b3BvbG9neSBhbmQgb3RoZXIgdG9wb2xvZ2ll
cw0KRm9yIGJldHRlciBvciB3b3JzZSwgQ05BIGlzIHByZXR0eSBtdWNoIGFnbm9zdGljIHRvIHRo
ZSBwaHlzaWNhbCB0b3BvbG9neS4NClNvIGl0IGlzIHRydWUgdGhhdCB3ZSBtaWdodCBkbyBiZXR0
ZXIgYnkgdHJhbnNmZXJyaW5nIE5VTUEgbm9kZSBwcmVmZXJlbmNlDQp0byBhIOKAnGNsb3NlcuKA
nSBub2RlLCBidXQgaXQgd291bGQgcHJvYmFibHkgcmVxdWlyZSBzb21lIHNvcGhpc3RpY2F0ZWQg
bG9naWMgDQp0byBpZGVudGlmeSBzdWNoIGEgbm9kZS4gQXMgZGlzY3Vzc2VkIG9uIGFub3RoZXIg
dGhyZWFkLCB3ZSBhcmUgb3B0aW5nDQpmb3IgYSBzaW1wbGUgc29sdXRpb24gdGhhdCBtaWdodCBi
ZSByZWZpbmVkIGxhdGVyIGlmIG5lZWRlZC4NCg0KQmVzdCByZWdhcmRzLA0K4oCUIEFsZXgNCg0K
DQo=
