Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545AB23006C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 06:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgG1EBb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 00:01:31 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48386 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgG1EBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 00:01:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF6E3C00AD;
        Tue, 28 Jul 2020 04:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595908889; bh=zQi761jxVlYMdQqahia57ddps2ro+pWMcrzduDqKrpc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WVUelUyzA5FdT2EatuXhrUrPuXqG04mAzF0TeMfceHfiEbAS7RzgqZ3CAHE81s2Uo
         2E1hQFylvKHBEm7RxZqWNlVanKF/7Jvmg5GG7tCR2oH0DnobptKqTCUlMlUQsa30KC
         jQBiA4hZLrJ93evUSe2IRYIY8QjVIFFVn4DOezmRtWSud9twGhO1ZDn3uxZv3nO2DG
         wDNiftGQb2ANfmjcWUirxxcRy4jnJ9QBKC9H7yWSe2BQ6/VmCFtW8qBJl+l4GZw61r
         wjNnA86wFVNbTu8yotiWF13yAXCxcuvJMbwUPoRy3mwQQ44o/g4DZsa51jBl+qiT5R
         C2lLv4WDIJGYQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0E0E5A0071;
        Tue, 28 Jul 2020 04:01:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 822BB800D0;
        Tue, 28 Jul 2020 04:01:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Y3fhRrKc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLoe3bpyI92E6zNBFhflYg46bKYg7MOaBqnfDhnY6xq5nDG0YAqqs+vZzfpuVXn4uHjFRxN1PCLJiHKCLxmi/IZlQmGWe2j3GGgg1V5C4HV6LjK7mxsC4Cc7jjd92/ZXVhTF0w4st7ENQ68FhQiLdXLLhsE+xV0VLV72UjaPYXuzJ59NuauiqPeVFm3fYvUlnCa1LvkbxAfidgVjUNzot1Tdsp1VKgkE9dfkG+87nbHV91OZutduMGH1b+oIfiy44XBrkJ8tPVuIFJX/T6i8mZSF2u8Tkp73qYC0Lr+XsQgoUZVoczGlm9MNLwFIcKitET/zWDLHPmr+LGat6VjQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQi761jxVlYMdQqahia57ddps2ro+pWMcrzduDqKrpc=;
 b=MNuuS47K0l0pl9lCJsyA7J9Rcio2HH5ZowlPv/lfr+U+SMUdvzgRkUScXzd92MilARH5U7D9hPTjFLxzsHxUMBsKGbe+Wsv9LGyfZc323lndQfn/VXwlheSqMcqGHhBRJPynMZEwzJZYBLZVd5UtqlTO+BjaA/iC7ZsskQ8BWMudPbLEKNACLirMhe6LY3zNGcoq9dDRBcHg+PuIGksvB2E6AQetmk3EhRELhYtVke/cGnRqlcwQk7S6uh1fhp8t4vZIhRGsQbjH2CTOL5bmJzEDRT7nQE6FqKi8VvVW8nsttKEDuIvwW7GvvKbtUE2QR0HXg+7fkXfLXClOOIL+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQi761jxVlYMdQqahia57ddps2ro+pWMcrzduDqKrpc=;
 b=Y3fhRrKcVrZBeoEwxsugE/kcsHjh7h2mc9Y+uLmwsgLDIxd+3FcIt/EU0CQY54kAdZUzulV+m7mJwO4iuWDLQrCemj5ei84r6uniELdeWfbuhjGFLSYJTPkebcUGcwGAXA0E78ipEKLveTYf81QW4HkJANMcNXza8K0ZFodkRtQ=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3206.namprd12.prod.outlook.com (2603:10b6:a03:130::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Tue, 28 Jul
 2020 04:01:24 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 04:01:24 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
Thread-Topic: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
Thread-Index: AQHWZJPCLUlaSDgrc0ehlB1MGFmAIg==
Date:   Tue, 28 Jul 2020 04:01:24 +0000
Message-ID: <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-2-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-2-npiggin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2f48786-622e-4899-25a9-08d832aae54b
x-ms-traffictypediagnostic: BYAPR12MB3206:
x-microsoft-antispam-prvs: <BYAPR12MB320665CBFC16D00FA3F30CB3B6730@BYAPR12MB3206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXLPyvgUgZw0BJPKNBXWjPWGHsCXnfCdfLrxsKDkPSCZQwydQJXGfoSaNjsP2Jw/ZErR90vDV/Zj/Blzd4W3WCyw8z51/9bUL68/s/pDCcY5UAP4lAu1xiF9kzbFB5v3lKO8v6R3MSlfX+Rvofz/PvC0DNNdwlpy7KWmiuBpzVlwEVXKElTUhxX0/YJaK1G6yI/PYr9vH1S+KAoxCvCfn+1j4g7jrBQ+m8vpfza70MFCfIE3PTGfGPoVKHEc5oh1/M1klDPNc4+jSF+D/OevMrvphmBjjNCcrXI/lIrvS4jCZUabN9UodmE1r1qgPQnFI81rfQt8TBdDQE7hTFc3aDZ1ISMl2F+jzuY9CtEPvhXHxo4iV9wErtIDWqdFXLU3XOjQ+laM+Kzogwnfq1rWsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(4744005)(110136005)(66446008)(2616005)(54906003)(6512007)(76116006)(83380400001)(64756008)(66946007)(66556008)(316002)(66476007)(186003)(478600001)(8676002)(26005)(4326008)(71200400001)(53546011)(6506007)(5660300002)(8936002)(36756003)(31696002)(31686004)(6486002)(86362001)(2906002)(41533002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kJbd+8NxtGsQpGyqbrcW42o2imqHi4hS9Js5dR8pWAC9dG8C9N6J+amVyIiU0Dy5gnPTQ7tw/e5UzbpskcBpWoM/yGvkrGvoM+WDxd0Gv0qVgq1KFNZTK4oZkH2EYclk01tlGfCApN61a9+QxZOYbti1Sy3riTzGoFvyqcUNWCD9T22bDsD/wjgc1zK6zSbjjKKoXJAXmCtHrGB8P0sRJShzn4FRxYuugpbCEhONJKEn6eAlH63HN7DRVGqQHVsVErVLDutQdt4q/OQTtjDANVDwc4O4uYAAQ8IFtfnaJTIGAe81GMArICLmCwQfymBlsbAVAoDH7oLXc7m8qN/3ZPJzsgpWHEJkI+xizJVvdD7D1iPJXvZsRy4mDGlbzxpGW6cNfKYqa234Xk4dN3HutMTOLNL7WeAeGP0abMvnWqxarcW6UNYBmmm2TDKZF7E5Sf7iGFBzp2LJ3emhiMgBVgz3SJb5+O/GWtfDX7ff9u4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B282E90BF3D1C4B9CB1389407D1C8EE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f48786-622e-4899-25a9-08d832aae54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 04:01:24.4902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqI1Uv44Tc7iUWnt7rJycds5Cj+OZGYoc4V5tf3vmoMxcbrhPgZQWQUMMbjQmIf5fZTbNZKESpMMpf5saTHcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNy8yNy8yMCA4OjMzIFBNLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQo+IE1hbnkgb2YgdGhl
c2UgYXJlIG5vLW9wcyBvbiBtYW55IGFyY2hpdGVjdHVyZXMsIHNvIGV4dGVuZCBtbXVfY29udGV4
dC5oDQo+IHRvIGNvdmVyIE1NVSBhbmQgTk9NTVUsIGFuZCBzcGxpdCB0aGUgTk9NTVUgYml0cyBv
dXQgdG8gbm9tbXVfY29udGV4dC5oDQo+IA0KDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNo
X21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsDQo+IC0JCQlzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0
LA0KPiAtCQkJc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ICsvKioNCj4gKyAqIGFjdGl2YXRl
X21tIC0gY2FsbGVkIGFmdGVyIGV4ZWMgc3dpdGNoZXMgdGhlIGN1cnJlbnQgdGFzayB0byBhIG5l
dyBtbSwgdG8gc3dpdGNoIHRvIGl0DQo+ICsgKiBAcHJldl9tbTogcHJldmlvdXMgbW0gb2YgdGhp
cyB0YXNrDQo+ICsgKiBAbmV4dF9tbTogbmV3IG1tDQo+ICsgKi8NCj4gKyNpZm5kZWYgYWN0aXZh
dGVfbW0NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhY3RpdmF0ZV9tbShzdHJ1Y3QgbW1fc3RydWN0
ICpwcmV2X21tLA0KPiArCQkJICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHRfbW0pDQo+ICB7
DQo+ICsJc3dpdGNoX21tKHByZXZfbW0sIG5leHRfbW0sIGN1cnJlbnQpOw0KPiAgfQ0KPiArI2Vu
ZGlmDQoNCklzIGFjdGl2YXRlX21tKCkgcmVhbGx5IG5lZWRlZCBub3cuIEl0IHNlZW1zIG1vc3Qg
YXJjaGVzIGhhdmUNCiAgIGFjdGl2YXRlX21tKHAsIG4pIC0+IHN3aXRjaF9tbShwLCBuLCBOVUxM
KQ0KDQpBbmQgaWYgd2UgYXJlIHBhc3NpbmcgY3VycmVudCwgdGhhdCBjYW4gYmUgcHVzaGVkIGlu
c2lkZSBzd2l0Y2hfbW0oKQ0KDQo+ICANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhY3RpdmF0ZV9t
bShzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2X21tLA0KPiAtCQkJICAgICAgIHN0cnVjdCBtbV9zdHJ1
Y3QgKm5leHRfbW0pDQo=
