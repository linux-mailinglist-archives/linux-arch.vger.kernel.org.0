Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E795A39BA92
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFDOHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 10:07:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58834 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhFDOHd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 10:07:33 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8EA63C0948;
        Fri,  4 Jun 2021 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622815547; bh=lDc1TXRmxaIu/J3fgNg1AIt0F9QtFw6WMkbSShzi5pU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IDcL8cPAYVE/evmH68aRvYq+1NPjdX4nR9aB0zBNwgZ+7QOEGoomDkwH+Q5JZSXt5
         wwFuBgNPNucib9nL9CfWmmpTfPUUQVPM7v4pDsPshH0fAz/+bFYw0HTw9hNnHbDGo9
         NOLP0zWXWoCf3st6K0xD3/cSFf8MguCDnRtBvXd7o0aIMom9ElDgTDWlkNFjLuaCE0
         HGOxpc67rHjoxfDE29v65HEu66wsOFqjFv4JqZUAx+OUd81ACUrLXhOlGjv8QDzr0y
         jBrlCFJX2fcvp492GXvbGr1/bE/7u82YMStIj+0xAseCfDJV9tof5wC0tw7P4t6Ia2
         bNat2dQ/Nv6Yg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D3329A0096;
        Fri,  4 Jun 2021 14:05:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0A2DB802D7;
        Fri,  4 Jun 2021 14:05:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EIfqmYGn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE+c4CEAWb07/XAqgCtBEq6Z54auUpBN0HCyrGKSVwXEpi4C/mke4Lx5lywul+zPQlSZiSK/gZA2RA6T1eZl7yoNlYWs7C2mUedk3PzZdqkkvFlOem2SHn4cNnJrIpS57lb621xXJy72CjYd/spFa/JKKIR41JsbeZ7dx14KZUezz+8Cc2VDBDIvbwDCxWOFa5uuTGQ4kJK7zOLFey0PSCeh+aTv0jWAyvfTz52s/a2KTQ1/imdcw1IOUuG3Y5k77P2YMTFUkk9Y8ytL91aa1KomBvnF2NqIIBsbn6lBaJhxPUAAjpffltwPo8kgS3jzIsYVG4CW0b/ESnslCwIDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDc1TXRmxaIu/J3fgNg1AIt0F9QtFw6WMkbSShzi5pU=;
 b=hqEWSHKl7WD91bUSH7/81bCNIKnbjIyUBh7mDVeg3LBVGoc2Td6YLX3EROhCECilLGkB/TUSHzJX8yiu2OJHYKsoSQ6qDztsAQzqjfeOVlYL180MdpEGMRnOphgVaGGd1V1Pqt+w3UmuwRnAMPyecwnirJx8+xQBclkYcumY5y2cbPHiVjGtCBHnFHClW42YuVVBCoopVuBBJ6TkNoXh5GtDAcbifCG9xoiaVmrl4GvrG9t1z+tlF2usR/myH5RTwvxGGTExK+e9V6VXPnNFJbo+8SmKx06LIN5qn+ohwiIAqdOeXHcg0+xrBToVDxDpXIS1zvcGKSxU1CJ0QirgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDc1TXRmxaIu/J3fgNg1AIt0F9QtFw6WMkbSShzi5pU=;
 b=EIfqmYGn+tPSE4EBSd5N5Mo/W2wS8KvGTY3jamO5svHMieI11ILFqd1aGhwaarm0xj2y4T/EYustdnf+OI8iVOQowaJoRbvAH2wOMKmEDkAiGTqXFoz1b86vvn4djM31DKkEsCiQyafV76Aj9jCHx8Ob2M3EtomSW3KshrwrdHM=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 14:05:29 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4173.033; Fri, 4 Jun 2021
 14:05:29 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] arc: update comment about HIGHMEM implementation
Thread-Topic: [PATCH v2 2/9] arc: update comment about HIGHMEM implementation
Thread-Index: AQHXWQ3SLXGjgTsRn0u+dr1cGNF2WqsD4z2A
Date:   Fri, 4 Jun 2021 14:05:29 +0000
Message-ID: <f8d4e27b-7b3e-8412-9897-ab3b6aed5725@synopsys.com>
References: <20210604064916.26580-1-rppt@kernel.org>
 <20210604064916.26580-3-rppt@kernel.org>
In-Reply-To: <20210604064916.26580-3-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bef1fea-83f5-4fe9-9116-08d92761cf60
x-ms-traffictypediagnostic: BY5PR12MB4919:
x-microsoft-antispam-prvs: <BY5PR12MB49190E8E88D86ADCA8373B9AB63B9@BY5PR12MB4919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjKz2Ldw4gomkfoFpCtLSFsQcV5+/7xWCJH+9FA++rEqrdvmFy/F7h09PEjWTjBK7tNlFBCFaefbv0ME+KnJsuq3QQliJgfWYCSc3sPxFb8XEiaXJBGez9BtuwqnFJjKnq/slYDcwSnStVQN6daWiMC2Nob34KnFyn0ozcwcd+VpMy0OR0ozDGItmr7zC5DsUbgRiuvUFD8JGNIJ4RJpor67vERhJqwwe1b8ToWT4KJiw8fylifbJhXV0A5uaG1lUmetqBrEChd6JF9kv4aBdAzoxea7xAkiE9XzNv9CXWLNCyVp4EvNcD6KVEwG+URaCPGT+2oYd9d3gL4TVAsDqPCrex5t+ZKQCPFdYRB91ZUVfu1lzMU0hLJ/96KOHph++nq8jQM1XX7c5mNmQiD4IagHzUDMZQgXAz1cfVE3cHTUzw92Royey0aoRpHoc4jRska7DnuexTf8IplJgyIZJUVW4Yh0vjk/Mlr0Em6M0lsleh7W4b3Y9CITChSrFZIMwWYmQ5rQ3BilGH4W+4s1lvTSsfSMpl3elqmymM53P5mJRzftn+yI8DUrNqhpWCRiaFCPK8JAXN88LbHIs20yFI3nABz5HZfKrcWeELVrfBjujnN3lA3O0ndeMfquTVdPScwYmC8v3aCm8VEIklzUsFDiy/sM3ZrwrXYtVBWourfoxTa8gO1wxOl7s6hE1/e8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(31686004)(6506007)(4326008)(66946007)(76116006)(7416002)(122000001)(6486002)(31696002)(86362001)(54906003)(38100700002)(83380400001)(316002)(36756003)(110136005)(71200400001)(478600001)(6512007)(8676002)(186003)(26005)(5660300002)(2616005)(2906002)(66476007)(66556008)(15650500001)(53546011)(66446008)(64756008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SDFJNGNjQWF2V3dLOXpOekwzZ09GMzQ0TENjRm54Y3YxVVdBWHBOWkNGZFU5?=
 =?utf-8?B?cW5ZNHl3UjFEVmVzQ0U3THp0K3NrTXJuSW1ndDVFM1BINXlSR3FUcFRMQ3NU?=
 =?utf-8?B?bmVlc0dEWmJxYWh0b2lta0FOVkM3ZWdXSk95V1dlLzkzbkJuYWdRSU9SOWhz?=
 =?utf-8?B?WUF4b29yK2tUazdBcVpQZU54R0RWVyt5T3ZXOUJBMjZ2OURwaEZORjYvSThI?=
 =?utf-8?B?UldITUgySmN2YnVFUzdaTkVKeFJCaEYxNzdsaGs0QlU4ZktFeUJtNEIyVXVN?=
 =?utf-8?B?K0h3MkhscXNibGNzaGZnMHdDcUFQamRjYXNta2JuTUZVeS9nNDY5b25uT2p0?=
 =?utf-8?B?T0dySnpJd3EvaTFKWFY0SEQ4akJRbXY4Y2dEZWdpRFVZZ2Jwd0c1SVhPc2gv?=
 =?utf-8?B?R3FsNGNObnVyM0hsamp2bU5MU0I3dVRtYXdseDc3dHJHK1FFUWtqcEFNWi9C?=
 =?utf-8?B?cTVNZ1FOeDRWbFNnQVpuK2wxRE9aMGUycklQV3pQRE5iZy9CRnR3V2VvM1pN?=
 =?utf-8?B?TlhJNTBqaG54Z2xDaTNqQ2pGeG1HaDkvMnhFc1A0U25rUXhtWlArR0czQUVq?=
 =?utf-8?B?d0IvVEp2eU4vd3dWT29QaWdxTktZSDdtZmJBYk10Q0d1L3ZCVWtiNW5WWHgw?=
 =?utf-8?B?enhlc0hvbnlOcDBKOFRqYms2YUc2QUUreG1MQ2hxZlFFQUFYTGZNdyszUjQv?=
 =?utf-8?B?WXBpRkdjdWtUeThkQUgxQTA3RlU3Nnc3bzhyK0tjS0NvRjJhenZEUTFGK0w1?=
 =?utf-8?B?MVY3QzlqZURFeFZWTTN2bDQ4Q2Y4YUF3b2RyYTFyQ3R5ZnF2ZWpqYmk5cjNP?=
 =?utf-8?B?WVlFeWRCMG9VTkRhUE1BNkM1RHgwOUdhS2J1NXVHTC9nTUowR0VyU05vN1Ji?=
 =?utf-8?B?V3YxYTFiV3JWaVpRTlBDUGpjYWt2c0hRQTVYMm1lWXBQaVlxNWU2QmduTEYz?=
 =?utf-8?B?WjlkMGlPbUwrSkwyd0VRUms5cGJ5SEJpRlNreUw0ZjNiOWI1Ny9HaktmenJI?=
 =?utf-8?B?Q3hVSW5YS2E5ZW5maWR3VXZSbURwT3pDekdpMFNueXJ1WC8vbjRPVWt6emVS?=
 =?utf-8?B?SW9GZzVDeDV2TUdyek9icjVjYm96Z05HcDFoamlLVjNGeG9LQlZnRWhQUDJT?=
 =?utf-8?B?UXNwaUZER002Y0tzQnZJcVVPTE0rS2p2UDg1M1BUUVU3bHRjQjg1TDBVSDBL?=
 =?utf-8?B?WGFCZ2FYYjhacHBmQ201OUxvczQ5dHY2MTZJQmFzVEhzbWJCY2ZxQU93UkxV?=
 =?utf-8?B?bXNRbFZITVo1UTRDaEhtbEFadHBESE5QNGFHSUMrU09RTmhqcFIrdHVJbmFO?=
 =?utf-8?B?V0srWm8vYnd1UEYyRndIMldtV1Bsakt4N1F3Y09KSEt4WGhwQ1hBY1ZlWEcr?=
 =?utf-8?B?Wld0enhsSEdVTUQya3ZxT0ZKZnpEVk80V2lveGQ4b3FrZGVzLzQwTkRFSkpI?=
 =?utf-8?B?bGFRWTM4ZVdZeXdERmczQkFJUEV4Sk9zR3l1WG1UNE9ORG9TeGFYSkFoclFr?=
 =?utf-8?B?QmhMRzhyUmZtai9pVFFHZWl3Q1RZTWdQZ012Vk5hR0ZjYklQZnNEUjdPNnJT?=
 =?utf-8?B?dlo0WGpQdjFTWW5MSnFwSzRXbXV4aDBGKzNhUk53Q1RCQUgwenBDREtsUVZp?=
 =?utf-8?B?SVZVR2JSY2tmb08yLzNHS0pyRXBjdk5uRmt3S3Vhek4ra1ZCSWpJd3IremxP?=
 =?utf-8?B?OFFTaW54czJWeVVReTllNVZTdDRjTnQxRzJBcVlTRmNBRnJ2VFBKMzJwZVp5?=
 =?utf-8?Q?zWhVVsxKaP/VGygzWejq4syepZxntFAIpPuIhfM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E3C551B69CF23418C2D5E10015FF616@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bef1fea-83f5-4fe9-9116-08d92761cf60
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:05:29.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3XhvvKnucGxpLE3grPWcFd4371K2+4B9HRXQRvZX1BlX+QOt/T6IWP1/ijOZ3T11ZyD4T64mYszpMzrds/Aqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNi8zLzIxIDExOjQ5IFBNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBGcm9tOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+DQo+IEFyYyBkb2VzIG5vdCB1c2UgRElTQ09O
VElHTUVNIHRvIGltcGxlbWVudCBoaWdoIG1lbW9yeSwgdXBkYXRlIHRoZSBjb21tZW50DQo+IGRl
c2NyaWJpbmcgaG93IGhpZ2ggbWVtb3J5IHdvcmtzIHRvIHJlZmxlY3QgdGhpcy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KDQpBY2tlZC1i
eTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KDQpUaHgsDQotVmluZWV0DQoN
Cj4gLS0tDQo+ICAgYXJjaC9hcmMvbW0vaW5pdC5jIHwgMTMgKysrKystLS0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FyYy9tbS9pbml0LmMgYi9hcmNoL2FyYy9tbS9pbml0LmMNCj4gaW5kZXgg
ZTJlZDM1NTQzOGM5Li4zOTdhMjAxYWRmZTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL21tL2lu
aXQuYw0KPiArKysgYi9hcmNoL2FyYy9tbS9pbml0LmMNCj4gQEAgLTEzOSwxNiArMTM5LDEzIEBA
IHZvaWQgX19pbml0IHNldHVwX2FyY2hfbWVtb3J5KHZvaWQpDQo+ICAgDQo+ICAgI2lmZGVmIENP
TkZJR19ISUdITUVNDQo+ICAgCS8qDQo+IC0JICogUG9wdWxhdGUgYSBuZXcgbm9kZSB3aXRoIGhp
Z2htZW0NCj4gLQkgKg0KPiAgIAkgKiBPbiBBUkMgKHcvbyBQQUUpIEhJR0hNRU0gYWRkcmVzc2Vz
IGFyZSBhY3R1YWxseSBzbWFsbGVyICgwIGJhc2VkKQ0KPiAtCSAqIHRoYW4gYWRkcmVzc2VzIGlu
IG5vcm1hbCBhbGEgbG93IG1lbW9yeSAoMHg4MDAwXzAwMDAgYmFzZWQpLg0KPiArCSAqIHRoYW4g
YWRkcmVzc2VzIGluIG5vcm1hbCBha2EgbG93IG1lbW9yeSAoMHg4MDAwXzAwMDAgYmFzZWQpLg0K
PiAgIAkgKiBFdmVuIHdpdGggUEFFLCB0aGUgaHVnZSBwZXJpcGhlcmFsIHNwYWNlIGhvbGUgd291
bGQgd2FzdGUgYSBsb3Qgb2YNCj4gLQkgKiBtZW0gd2l0aCBzaW5nbGUgbWVtX21hcFtdLiBUaGlz
IHdhcnJhbnRzIGEgbWVtX21hcCBwZXIgcmVnaW9uIGRlc2lnbi4NCj4gLQkgKiBUaHVzIEhJR0hN
RU0gb24gQVJDIGlzIGltbGVtZW50ZWQgd2l0aCBESVNDT05USUdNRU0uDQo+IC0JICoNCj4gLQkg
KiBESVNDT05USUdNRU0gaW4gdHVybnMgcmVxdWlyZXMgbXVsdGlwbGUgbm9kZXMuIG5vZGUgMCBh
Ym92ZSBpcw0KPiAtCSAqIHBvcHVsYXRlZCB3aXRoIG5vcm1hbCBtZW1vcnkgem9uZSB3aGlsZSBu
b2RlIDEgb25seSBoYXMgaGlnaG1lbQ0KPiArCSAqIG1lbSB3aXRoIHNpbmdsZSBjb250aWd1b3Vz
IG1lbV9tYXBbXS4NCj4gKwkgKiBUaHVzIHdoZW4gSElHSE1FTSBvbiBBUkMgaXMgZW5hYmxlZCB0
aGUgbWVtb3J5IG1hcCBjb3JyZXNwb25kaW5nDQo+ICsJICogdG8gdGhlIGhvbGUgaXMgZnJlZWQg
YW5kIEFSQyBzcGVjaWZpYyB2ZXJzaW9uIG9mIHBmbl92YWxpZCgpDQo+ICsJICogaGFuZGxlcyB0
aGUgaG9sZSBpbiB0aGUgbWVtb3J5IG1hcC4NCj4gICAJICovDQo+ICAgI2lmZGVmIENPTkZJR19E
SVNDT05USUdNRU0NCj4gICAJbm9kZV9zZXRfb25saW5lKDEpOw0KDQo=
