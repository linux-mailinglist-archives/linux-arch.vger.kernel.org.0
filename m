Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035A53797FB
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhEJTvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 15:51:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59912 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhEJTvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 15:51:32 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ADC3DC008F;
        Mon, 10 May 2021 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620676226; bh=V/B3H9b89XGwRVkqiJGuuytp2ct2lLq9NLwtelJDzv8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CYax9Ed2za7alErfxGwEmdUhHgSWUsn15ZDR1g+EkSvRS5CbTOtTeIlTuc7M4xd6Z
         kIbniMKn4Hw1vKcYIwozn8lNVnEXxs5lF/cF9I8pb5h4tiISwhzxDVi4YH2E5jQHA9
         LtprBaRpVRma+Tcu2EqK+oYFEkTCvSxGS7xEQGa3CIWT8vOEeLCUw7mKiFRFTYkGyV
         ucNLgaul8J7M18NORwS4y74jLcG7/Kx3b0+9utm3sd226BJTgmfdFsDwJbusI8Vx+B
         bPw+MrKJBY3Iq5govx0Y8B03k6a+4jCecRizBlrA1jMWr8rGisA1DiRm++m6mTnAzB
         yrs7/ZGocHQbw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0809EA0082;
        Mon, 10 May 2021 19:50:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B44140139;
        Mon, 10 May 2021 19:50:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MGF7I7ts";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMTD1AMTMDCa20TL8h1JEenJCtz/v16CifnVsaSBkEs2X5AxOCi21DOvFArd/jm6ZFj2vmyhRgyDvgJRTmLmhsuuqsQ55HHYCBIsBwkb/Cw4lIXT9xU7Ch5BnJH+P2JY5OTU6G0i1Qrcj7xfo5WeGLEL8a56VN/Y1Q/UUVJu+TShqws8MIViwGky980l3sdToyEo2VNyq7gfeoG7i7N+vx5XP/C4xAFa3Tcg9vdHiISo8pc7Ig3RwgbAJto2UAk7XOa0kz7FL1bvSeKQDswSx/wZFjtJM/sQj9lWLeZCIpSTFGAz/QGqL6TTCXfWc5oDYAUoxc8bX2/kbaDBvdy6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/B3H9b89XGwRVkqiJGuuytp2ct2lLq9NLwtelJDzv8=;
 b=J+xqLJ477KKb87S2FuWhzC6lU8lyJ+yHds3TihAwdZApv6gx/Zqc6jmkKlAkXBdYWtm3ANBPH675efs0/7SDKPkFWyXa1GdKJenN2mli0RQ6zMUBQsQ3GNwICOZS/dSSBHdVgwL2V4ZsZNpy5vm78oMByiPo2xKFcpU4E3SQw/hXJv/HqCX8UlfRi8enTkyZmfdSmuMHKmwhvIcUDMBMF/cePwJfQHH4bi6HpdPBW28FtTA4kDUejFbr3hs939/tUxYlitD3KCRd3+gJamhfRBhv+aSdCB8cuTMKe5g2NpnTl7FfwyqFrZMSeoJfK32coJZgIw8LJSMZ8/wzEdvTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/B3H9b89XGwRVkqiJGuuytp2ct2lLq9NLwtelJDzv8=;
 b=MGF7I7tsxJRJXQnAkyJ6bPdnE+TRTCfy8P4nTGNAmZJxcXam3prfaPdfDGLKu8/CFuw3/5ma73UeTbDDfi59AhfHFnDdI5ADK+qLBzdAv4UFtP8qlwK37iM7anwj11Xn0SZo+qFeOpmk3acnW7gwSPBz/WtU1xHPtsERykEqXWI=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 19:50:21 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:50:19 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: Re: [PATCH v2] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Topic: [PATCH v2] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Index: AQHXO17U9EKC/PUqp0SIMA02pFtr1KrdNKuA
Date:   Mon, 10 May 2021 19:50:19 +0000
Message-ID: <a6786e4e-e1aa-e84d-3b08-509a90513077@synopsys.com>
References: <20210427121354.3620-1-isaev@synopsys.com>
In-Reply-To: <20210427121354.3620-1-isaev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd718a7-9f8c-44b8-1769-08d913ecd797
x-ms-traffictypediagnostic: BY5PR12MB4052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40522280C395D034861225AEB6549@BY5PR12MB4052.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:225;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsc5zuZYJ9YEqVxyNc3ZpvPHAvyfRRm4F2Zepr5jY+XB6JcWHE3MR9aILckaA6YB7HHeiGW8HozwP8x5Rzx5iOaLuIwKddPopjb66oTmSQl1TlXso5/zCR0oFsVJZg6jtr5awNSpXV2yunzSnHYs+placbLwcfdWnkAZK+tgfNu5DnK9ZPpgcGHEwjFbCBIBh2braPMinFkWrX+6RFcuQmJ3td+FFkKgswj0Zihgl9dx0+fVYuuRRuJgmzYTXUY/V7rm6g+0yrDBWuA8ZwExEM54clIcsOI9k/oU0f+REWM6mtb7dAaMGJtuL3rhtfa3fNis7iou6Fgs8+fpxsublpJXpTTg8KKx2KgTRq8UJQm8gCuCRkaoMtYhNJj5pLu5ut4oXHB3UfJPR7oO7EmG/HBg7gU/5HMQj/BSpO0fIteeMJ4q6StnNiSaUgb9+FTxbZZmt9T5vUir7y7IynQ37wJV3DNgkRVyyJRydxkWEG72YX8Li4v4XtLCRWg+F+ZDeslUYAIkTTC1UfFFAwBNOsNmLDotdFG3+OJqqmw467kC+CU6HeoOLXEdB7ZpWX5rk3L4e/1+yKWVncZg23ladeN6ErVzRgp6w8K78OLOjaPjPPVUaqxUk5OzbuOzdqoC/5jqpPY/GkEiDQQfgUkB9ukBRqrHWdnyuIK/Tx7KLIqLQgJqgZ9RAIRBjL+SV8Q6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(186003)(2906002)(54906003)(66476007)(66556008)(71200400001)(66446008)(110136005)(8676002)(66946007)(31686004)(31696002)(76116006)(6512007)(86362001)(64756008)(6486002)(316002)(83380400001)(4326008)(5660300002)(53546011)(26005)(36756003)(122000001)(38100700002)(2616005)(478600001)(6506007)(45080400002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SXduRTBqUjZKSmRlc0xEbzVPSDEzVWJoakRKTTJlbEhTMDZyWVNPczdmZFhj?=
 =?utf-8?B?SVZIYW9jMGtBeTYzR2FFMzJpYUVEUE10bklXTk5GT29TSHBBVDRXVWxEMElG?=
 =?utf-8?B?KzhtNHFuNmdrWGlZdnJtSFhZOFlTQ3RkcU9TOExPOUtRREUzQmxhYnRXaUU0?=
 =?utf-8?B?ZHpBRkFPZmZkTXl0aDFBUU9iMi8vM2JwWlpzRmNUTlZpN3lQWnk1dVd4cmpI?=
 =?utf-8?B?cm05TFJYaFVjY0JNbFVWRmRaZVRLQUFaeGpsRnVQZTByS0huZUxDK21MS3dz?=
 =?utf-8?B?YStlbjh4SVFCbkQzMDRjSkxHM2VUWTYvNGY1UStBVzR5eHpuK2JmaDBEQ0Rw?=
 =?utf-8?B?NXBxS0xXbEZwK0xtQVVjTHhnUVhhMGNMRGIrcGlDNkFOakUwaUxPWERJRTVt?=
 =?utf-8?B?MWc4dWdpNEVGaGN2RFROVmZuY2pMMUVpSXU0SkNJVDNJMlZjTFlKSEh4MWR2?=
 =?utf-8?B?b2VoRXMxUCtjdXRwZDFxMjIzbW5BRmN6cXVQQlgzdmNPSFRCblFya1kvdnhl?=
 =?utf-8?B?WWFtUXpIWmVEOFpORUVidExscVArMWFRbXZqOWdkNkxrZXc0aEJFL0pLU0xZ?=
 =?utf-8?B?SFV0SnFLM2VGZ0V5N0dWWncyQ0xqZEJZQ2hOR3Bjcmgwb1Z1ZmlkN3dUc01X?=
 =?utf-8?B?R05nN0M1Y0VVcDhVZCszWUxWSHdUbXJmSjltanNUd3VZNVpGOTFleHVsKy9N?=
 =?utf-8?B?VXR4Qnk3VnFVQ1dWdERUazZISWhzRjdBb1grZDdrWEpVMnNtQUw4ZjdBdzIw?=
 =?utf-8?B?RnN3WnJsU2RZdFJRNERHZFdtYjlmVDRjNmF5aVRFREh1Z0wwcDNaWE1YOUYw?=
 =?utf-8?B?TUI0REs4c1BzUHpWK0IzeXV1T3hOcldTK2l6dXFYS2lhdHpEMkIwcEZ2VGRH?=
 =?utf-8?B?TC9ZS2VHNGI5Q2dmSk1LL21ka0pHQmxFMkZZZ1NueldMYlhTekFZSld1WTRl?=
 =?utf-8?B?YkE0VEZIcmRGVjYwUURDUVNlRm0zVklHNlhXTzhlS1E5enJhTkpHUlYrVGdi?=
 =?utf-8?B?VHJIQTRFVE0vMkgraUp3MjVYNFlPdTdUNWVUMWNKV2YwT3RyaStqeWczSTFB?=
 =?utf-8?B?QmFJWC8wMW5paU5KL3JTRFlHT29qL0g3MGpCMTQvMHVFVWxNTVRFdUZscUpM?=
 =?utf-8?B?TWNVMjlWSUd4cnJKK3dINklnbTQ5Q0JpYzhXWStWRmIzVll1bzBEM0E3b2FP?=
 =?utf-8?B?K0RsVy9wV1I1UGtXZ1pDb3M5aysvS3dpSUs1OWtZckpSWk1Bd3ZNNGhBRks4?=
 =?utf-8?B?ekVWM3I4UDRVdkM2R0xsQjlGaVJHbHhGTlBHYmI3NG8rNFE5SnZNRmJqOVBP?=
 =?utf-8?B?WUpSaVExQ1FTRk9iTVdyMnBub2N2TDQ3MDhIQkN0UDRsenBYbnpRZWpJMmpo?=
 =?utf-8?B?K3FIZW5BOURTdEhZekxXQjVOSEdFUjZna0d6VEVHOHJZbmtSTzIwQUUxc1NY?=
 =?utf-8?B?cmNhUzFqcWZjSmwwaTJablkxS3VYYjhMb1VMUEpMT3NKZEtVRHQyRlJVMGFK?=
 =?utf-8?B?V1luYjBGTllGbDE4aytaYUdsRDZ6TkVIUW5OMjI4Mm5GS1c4MlcyT1dYbHM1?=
 =?utf-8?B?WFBVMTFIWi9qdWhKWkVXZ090OElRNE8wVnA4aTZLbGtob2pQMDZxNUtCSGEy?=
 =?utf-8?B?RTYyYVJWeTY1WTRaN0NwV2h6SklnMkxDVGd4Yy9pWlh3YklFV3VraFZtcHU4?=
 =?utf-8?B?eU5mYm95WmtOejNkQk1RQ242bEwzYXJvazF4dDBvM0hsVW1VbmNwblEyTzRN?=
 =?utf-8?Q?/F+vKkOU2Zb/0DSGKA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588BA5BAC13ECF47A3E5C9E94781A4A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd718a7-9f8c-44b8-1769-08d913ecd797
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 19:50:19.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zm8iyFOb02IB9pzCkj+QNqBvZFTXXU010QyZBxmtqH+X/w3fZnDQZkhoUK8VYEE1t7OZlSNi+rQz8aWT6yaf3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNC8yNy8yMSA1OjEzIEFNLCBWbGFkaW1pciBJc2FldiB3cm90ZToNCj4gQ29tbWl0IDRhZjIy
ZGVkMGVjZiAoImFyYzogZml4IG1lbW9yeSBpbml0aWFsaXphdGlvbiBmb3Igc3lzdGVtcw0KPiB3
aXRoIHR3byBtZW1vcnkgYmFua3MiKSBmaXhlZCBoaWdobWVtLCBidXQgZm9yIHRoZSBQQUUgY2Fz
ZSBpdCBjYXVzZXMNCj4gYnVnIG1lc3NhZ2VzOg0KPg0KPiBCVUc6IEJhZCBwYWdlIHN0YXRlIGlu
IHByb2Nlc3Mgc3dhcHBlciAgcGZuOjgwMDAwDQo+IHBhZ2U6KHB0cnZhbCkgcmVmY291bnQ6MCBt
YXBjb3VudDoxIG1hcHBpbmc6MDAwMDAwMDAgaW5kZXg6MHgwIHBmbjoweDgwMDAwDQo+IGZsYWdz
OiAweDAoKQ0KPiByYXc6IDAwMDAwMDAwIDAwMDAwMTAwIDAwMDAwMTIyIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo+IHJhdzogMDAwMDAwMDANCj4gcGFnZSBk
dW1wZWQgYmVjYXVzZTogbm9uemVybyBtYXBjb3VudA0KPiBNb2R1bGVzIGxpbmtlZCBpbjoNCj4g
Q1BVOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyIE5vdCB0YWludGVkIDUuMTIuMC1yYzUtMDAwMDMt
ZzFlNDNjMzc3YTc5ZiAjMQ0KPg0KPiBTdGFjayBUcmFjZToNCj4gICAgYXJjX3Vud2luZF9jb3Jl
KzB4ZTgvMHgxMTgNCj4gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5nIGR1ZSB0byBrZXJuZWwgdGFp
bnQNCj4NCj4gVGhpcyBpcyBiZWNhdXNlIHRoZSBmaXggZXhwZWN0cyBoaWdobWVtIHRvIGJlIGFs
d2F5cyBsZXNzIHRoYW4NCj4gbG93bWVtIGFuZCB1c2VzIG1pbl9sb3dfcGZuIGFzIGFuIHVwcGVy
IHpvbmUgYm9yZGVyIGZvciBoaWdobWVtLg0KPg0KPiBtYXhfaGlnaF9wZm4gc2hvdWxkIGJlIG9r
IGZvciBib3RoIGhpZ2htZW0gYW5kIGhpZ2htZW0rUEFFIGNhc2VzLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBJc2FldiA8aXNhZXZAc3lub3BzeXMuY29tPg0KPiBDYzogTWlrZSBSYXBv
cG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiBDYzogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lu
b3BzeXMuY29tPg0KDQpBcHBsaWVkIHRvIGZvci1jdXJyLg0KDQpUaHgsDQotVmluZWV0DQoNCj4g
LS0tDQo+IENoYW5nZXMgZm9yIHYyOg0KPiAgIC0gUmV2aXNlZCBjb21taXQgbWVzc2FnZSBhbmQg
YWRkZWQgY29tbWVudCB0byBjb2RlDQo+IC0tLQ0KPiAgIGFyY2gvYXJjL21tL2luaXQuYyB8IDEx
ICsrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL21tL2luaXQuYyBiL2FyY2gvYXJj
L21tL2luaXQuYw0KPiBpbmRleCBjZTA3ZTY5NzkxNmMuLjFiY2M2OTg1YjlhMCAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcmMvbW0vaW5pdC5jDQo+ICsrKyBiL2FyY2gvYXJjL21tL2luaXQuYw0KPiBA
QCAtMTU3LDcgKzE1NywxNiBAQCB2b2lkIF9faW5pdCBzZXR1cF9hcmNoX21lbW9yeSh2b2lkKQ0K
PiAgIAltaW5faGlnaF9wZm4gPSBQRk5fRE9XTihoaWdoX21lbV9zdGFydCk7DQo+ICAgCW1heF9o
aWdoX3BmbiA9IFBGTl9ET1dOKGhpZ2hfbWVtX3N0YXJ0ICsgaGlnaF9tZW1fc3opOw0KPiAgIA0K
PiAtCW1heF96b25lX3BmbltaT05FX0hJR0hNRU1dID0gbWluX2xvd19wZm47DQo+ICsJLyoNCj4g
KwkgKiBtYXhfaGlnaF9wZm4gc2hvdWxkIGJlIG9rIGhlcmUgZm9yIGJvdGggSElHSE1FTSBhbmQg
SElHSE1FTStQQUUuDQo+ICsJICogRm9yIEhJR0hNRU0gd2l0aG91dCBQQUUgbWF4X2hpZ2hfcGZu
IHNob3VsZCBiZSBsZXNzIHRoYW4NCj4gKwkgKiBtaW5fbG93X3BmbiB0byBndWFyYW50ZWUgdGhh
dCB0aGVzZSB0d28gcmVnaW9ucyBkb24ndCBvdmVybGFwLg0KPiArCSAqIEZvciBQQUUgY2FzZSBo
aWdobWVtIGlzIGdyZWF0ZXIgdGhhbiBsb3dtZW0sIHNvIGl0IGlzIG5hdHVyYWwNCj4gKwkgKiB0
byB1c2UgbWF4X2hpZ2hfcGZuLg0KPiArCSAqDQo+ICsJICogSW4gYm90aCBjYXNlcywgaG9sZXMg
c2hvdWxkIGJlIGhhbmRsZWQgYnkgcGZuX3ZhbGlkKCkuDQo+ICsJICovDQo+ICsJbWF4X3pvbmVf
cGZuW1pPTkVfSElHSE1FTV0gPSBtYXhfaGlnaF9wZm47DQo+ICAgDQo+ICAgCWhpZ2hfbWVtb3J5
ID0gKHZvaWQgKikobWluX2hpZ2hfcGZuIDw8IFBBR0VfU0hJRlQpOw0KPiAgIA0KDQo=
