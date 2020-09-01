Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B1259E1B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIASc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 14:32:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43638 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgIASc0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 14:32:26 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C04A040122;
        Tue,  1 Sep 2020 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598985146; bh=cjZVIFpGE3M28JHhN917Qp/6auNhqB++Z+Azs78hsIE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=csh1rWScPyWVcD4A17f+qqjbUOccmsJMkZSFtJ4o7Mz1EFmVJyeAKjjxqIevWOW/v
         ITGchiG8NFofjW3jEw/llKa9HPdGsOklZzmkvAp54MrVyRijyavGmBsLMgxAlELxye
         Tx+lTjmkdCJ3jk93nc2D806RxxlMK8ySZyMEoksG7Pj3nctf91vcYnI7+vMmNoMsI1
         8jFbmFGYFl7+W9xABSt9oS6agKqahU5XJj6cVAuBalqnzbuuK/1s6ujOwqpUDZHbU4
         c+ndLvpdNgtXebtSvHho4RoJ3nA2fo/FJ23HPcE3udRAdgiiXpVTXGFE/SMl7EUto5
         hpPPR1I+GeSaw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 076ACA0062;
        Tue,  1 Sep 2020 18:32:22 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C44D980002;
        Tue,  1 Sep 2020 18:32:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="v4GUQ98k";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVyQTTpmG8CEptNnBKMbXDlSnBcsk4DDRiMFfbRveTpCOnoO5B7cneeXH8ZKJRlXyn9vxTFIpYa/tg2Dug2o/4s+l4JLFOpv3slUI42Hl0XffY7OqwMUkxwXy1YHGgJI220PZTWdohCo4OvNnn6dkXhSv1BqQ93/PbQlzGUU1vvR7s5Nn4QpGB78oIK+wmgplJ5Gh/VmidUzq8GLFOEXU5ExQl3m3pgZftzVlE/HFGqwp1P/eWZRfUAMCHIM8ytyn0qcL8GmkVPFmz/aCdEg/76dIXNANADAKChEzxSaUDC2QvJ9ybjCxv2XcwhJlyvPIuQVqnkvVde/j90JQfhCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjZVIFpGE3M28JHhN917Qp/6auNhqB++Z+Azs78hsIE=;
 b=oaQCZGON1fWu1RqubvYdroNeC8x8HKzijUEsAgMAf6u3cSkNkhVocLV7vkVGzLQfM2Gl8Rg+Z4UylUjrt7cNkQ1WIgzsl7BwLBTUCLv5ZYl57HM+eBwnW+Z39jjhUHoux/2WOLFV9owQ6itB10/903PfZx6lOSp8OaQkwroV6YekqpQqtEu1qJ0IWYMBMM+aVzO3VHye8SW4Rb3sHL4T2fZxzqoCZxhc5a5GtvfcAd6VBc7TssxL5HD+HwGX1i3hEw/m1TWZrfHrk99KMpIMRnMuDL2l620rFH4ijVaOVEwJYqtRZjT4ibRdXUK/CzHvNaaBqha6+k/I6JkaWILIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjZVIFpGE3M28JHhN917Qp/6auNhqB++Z+Azs78hsIE=;
 b=v4GUQ98kiAuV3TtA1YEW7Fs9GjETK/r8gtZ+u3qy7GOP1flQI49VJ6tDoJoZYbSlXNvYxswCsuPrnIIeihAPE+2AovAAD3UJ1k+YEzLCtuXPGiR2f5cExeZ16e/hPr+v7v1XsosSFEd4EVxzWg/NzjG6BRHbaq016nDsUTHCC3o=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2950.namprd12.prod.outlook.com (2603:10b6:a03:131::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 18:32:15 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e%5]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 18:32:15 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v3 03/23] arc: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Topic: [PATCH v3 03/23] arc: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Index: AQHWgGptsa+/2AtHFk2qGtGyl0DqlalUG5cA
Date:   Tue, 1 Sep 2020 18:32:15 +0000
Message-ID: <d6d24a21-dd08-73ad-9707-0ee341ecda7b@synopsys.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
 <20200901141539.1757549-4-npiggin@gmail.com>
In-Reply-To: <20200901141539.1757549-4-npiggin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:b9:9593:5cb1:ebc3:8ee9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cab67210-6b7b-43a1-1ded-08d84ea559b2
x-ms-traffictypediagnostic: BYAPR12MB2950:
x-microsoft-antispam-prvs: <BYAPR12MB295006ECF4B796F5ECFBEEC6B62E0@BYAPR12MB2950.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9u3cyod/36AYHWdt/bfh3PnXnccZo1PtFgTVoFnnWp+KiS0BKfhv7IsGEywmHA5tkowXPQpl7UEhtEXOv/rj8vFlbXUBqQtK14sRwK9ln5CBbkytnMHkp2Xd07T7AB7BUvifTsCVbTT9daGSu1H+ERqDxTxrNEHWd0ouOhiaI51YLnw2++esj+y9v9xcBdSq4yz/hiMzvoOTNyVC/CxQYqXTUl4SIo/usEl5hpEepEHr9MWFSAvlwvBE6IhK8Ql+m/QPZR20r81IwyiC/Opyuy1S9v3IxLpAG0HU3NLX4exDvveQG/qy+xsFEFnSYI8N2VN+Zf4KqsMhFgpsnC1eQcJcnK1hMnS9ox6V71xDufd8pjhDTjiYe+VXoklAqgCgXxIIiuvmArA/QWF8gkZyBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(366004)(136003)(66946007)(66476007)(66556008)(64756008)(83380400001)(6486002)(478600001)(8676002)(76116006)(66446008)(8936002)(110136005)(5660300002)(71200400001)(6512007)(4326008)(2616005)(86362001)(2906002)(31686004)(186003)(6506007)(53546011)(54906003)(316002)(31696002)(36756003)(41533002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ppzIP7AFm7VYlIRbH9iJSUlN199bda6JtBGBSmr3o/Z4R5JNtthEqtVe+dE8cNpNh8WTQ6sWwWEbFFq9UbcDwdxtcGiNX2tZ4RnBtznmEXgb0YMdEfhyIQvzdb9i1HYIOcW95Qm7kseEKMcyibSrQsjHVOczBLAkTQA7ccJx5HZApJ+clJTLXQQuVGeePWYMW0NmcDjw4gU8VxJGXQ/rHhUwbkwSDl/rkU5cf/FmIew6V4ajjEdg7JbVlHY0LqLBguFY3YUkT3xbse6nKa8X81A3S9+/PwWVaQCj6KAYlZ8ikBdq8iqSCuGC312vEPHZM9z+fVm7WQh6sHY1Vr4P3qFsQICruG73jfLhqaTu9AwFBH32Amv1wG9n9/WiRoyV4cTwEicX1GHTZo9SFwumA4WawrNEKtsfWHXacl18AUFJLMqOkBliahjxd4fZM/Iu0PfO7bcW8LUSW22z/iQjvEFKeadl1gWAYUuOPOdMtSe9ex1ulCCZD+mWEUR9YFHXKY/gBI8xHs38juZrna/dRj4O7BG0/exNPxbzQ3wUM4fYt2bBVyU2Vv5owPWCZYhK7N2/GedoVp9WWLWt+sAYjDVZE7aBm6ZOyPNFgcOBvgGxo4knObQvET7A4rYFQ009azHOfTBeuDvq/BlqMd4iSxsEL8wLs9XSgt+VEcK2SljZMVqWwWiM84QT3v4WzUkQdA41gyQhieOi+b2wnFo+1A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <09D99B04AA97B24484D08876FD111B8F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab67210-6b7b-43a1-1ded-08d84ea559b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 18:32:15.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVvaGp6SKKdEfOYz5UcEQrk3k28cKbtaMKFZ6KXldoPT+q+lOEmwuHMp+JSj8gCNOaO8BZ3gpsMXpffgfqAJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gOS8xLzIwIDc6MTUgQU0sIE5pY2hvbGFzIFBpZ2dpbiB3cm90ZToNCj4gQ2M6IFZpbmVldCBH
dXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IGxpbnV4LXNucHMtYXJjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdt
YWlsLmNvbT4NCg0KQWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4g
ICAjYXJjaC9hcmMNCg0KVGh4LA0KLVZpbmVldA0KDQo+IC0tLQ0KPiANCj4gUGxlYXNlIGFjayBv
ciBuYWNrIGlmIHlvdSBvYmplY3QgdG8gdGhpcyBiZWluZyBtZXJlZCB2aWENCj4gQXJuZCdzIHRy
ZWUuDQo+IA0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCB8IDE3ICsrKysr
KysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL21tdV9jb250
ZXh0LmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oDQo+IGluZGV4IDNhNWU2
YTViOWVkNi4uZGYxNjQwNjZlMTcyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9pbmNsdWRlL2Fz
bS9tbXVfY29udGV4dC5oDQo+ICsrKyBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0
LmgNCj4gQEAgLTEwMiw2ICsxMDIsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2V0X25ld19tbXVf
Y29udGV4dChzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCj4gICAqIEluaXRpYWxpemUgdGhlIGNvbnRl
eHQgcmVsYXRlZCBpbmZvIGZvciBhIG5ldyBtbV9zdHJ1Y3QNCj4gICAqIGluc3RhbmNlLg0KPiAg
ICovDQo+ICsjZGVmaW5lIGluaXRfbmV3X2NvbnRleHQgaW5pdF9uZXdfY29udGV4dA0KPiAgc3Rh
dGljIGlubGluZSBpbnQNCj4gIGluaXRfbmV3X2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0ICp0
c2ssIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiAgew0KPiBAQCAtMTEzLDYgKzExNCw3IEBAIGlu
aXRfbmV3X2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICsjZGVmaW5lIGRlc3Ryb3lfY29udGV4
dCBkZXN0cm95X2NvbnRleHQNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBkZXN0cm95X2NvbnRleHQo
c3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4g
QEAgLTE1MywxMyArMTU1LDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzd2l0Y2hfbW0oc3RydWN0
IG1tX3N0cnVjdCAqcHJldiwgc3RydWN0IG1tX3N0cnVjdCAqbmV4dCwNCj4gIH0NCj4gIA0KPiAg
LyoNCj4gLSAqIENhbGxlZCBhdCB0aGUgdGltZSBvZiBleGVjdmUoKSB0byBnZXQgYSBuZXcgQVNJ
RA0KPiAtICogTm90ZSB0aGUgc3VidGxldHkgaGVyZTogZ2V0X25ld19tbXVfY29udGV4dCgpIGJl
aGF2ZXMgZGlmZmVyZW50bHkgaGVyZQ0KPiAtICogdnMuIGluIHN3aXRjaF9tbSgpLiBIZXJlIGl0
IGFsd2F5cyByZXR1cm5zIGEgbmV3IEFTSUQsIGJlY2F1c2UgbW0gaGFzDQo+IC0gKiBhbiB1bmFs
bG9jYXRlZCAiaW5pdGlhbCIgdmFsdWUsIHdoaWxlIGluIGxhdHRlciwgaXQgbW92ZXMgdG8gYSBu
ZXcgQVNJRCwNCj4gLSAqIG9ubHkgaWYgaXQgd2FzIHVuYWxsb2NhdGVkDQo+ICsgKiBhY3RpdmF0
ZV9tbSBkZWZhdWx0cyAoaW4gYXNtLWdlbmVyaWMpIHRvIHN3aXRjaF9tbSBhbmQgaXMgY2FsbGVk
IGF0IHRoZQ0KPiArICogdGltZSBvZiBleGVjdmUoKSB0byBnZXQgYSBuZXcgQVNJRCBOb3RlIHRo
ZSBzdWJ0bGV0eSBoZXJlOg0KPiArICogZ2V0X25ld19tbXVfY29udGV4dCgpIGJlaGF2ZXMgZGlm
ZmVyZW50bHkgaGVyZSB2cy4gaW4gc3dpdGNoX21tKCkuIEhlcmUNCj4gKyAqIGl0IGFsd2F5cyBy
ZXR1cm5zIGEgbmV3IEFTSUQsIGJlY2F1c2UgbW0gaGFzIGFuIHVuYWxsb2NhdGVkICJpbml0aWFs
Ig0KPiArICogdmFsdWUsIHdoaWxlIGluIGxhdHRlciwgaXQgbW92ZXMgdG8gYSBuZXcgQVNJRCwg
b25seSBpZiBpdCB3YXMNCj4gKyAqIHVuYWxsb2NhdGVkDQo+ICAgKi8NCj4gLSNkZWZpbmUgYWN0
aXZhdGVfbW0ocHJldiwgbmV4dCkJCXN3aXRjaF9tbShwcmV2LCBuZXh0LCBOVUxMKQ0KPiAgDQo+
ICAvKiBpdCBzZWVtZWQgdGhhdCBkZWFjdGl2YXRlX21tKCApIGlzIGEgcmVhc29uYWJsZSBwbGFj
ZSB0byBkbyBib29rLWtlZXBpbmcNCj4gICAqIGZvciByZXRpcmluZy1tbS4gSG93ZXZlciBkZXN0
cm95X2NvbnRleHQoICkgc3RpbGwgbmVlZHMgdG8gZG8gdGhhdCBiZWNhdXNlDQo+IEBAIC0xNjgs
OCArMTcwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHN3aXRjaF9tbShzdHJ1Y3QgbW1fc3RydWN0
ICpwcmV2LCBzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0LA0KPiAgICogdGhlcmUgaXMgYSBnb29kIGNo
YW5jZSB0aGF0IHRhc2sgZ2V0cyBzY2hlZC1vdXQvaW4sIG1ha2luZyBpdCdzIEFTSUQgdmFsaWQN
Cj4gICAqIGFnYWluICh0aGlzIHRlYXNlZCBtZSBmb3IgYSB3aG9sZSBkYXkpLg0KPiAgICovDQo+
IC0jZGVmaW5lIGRlYWN0aXZhdGVfbW0odHNrLCBtbSkgICBkbyB7IH0gd2hpbGUgKDApDQo+ICAN
Cj4gLSNkZWZpbmUgZW50ZXJfbGF6eV90bGIobW0sIHRzaykNCj4gKyNpbmNsdWRlIDxhc20tZ2Vu
ZXJpYy9tbXVfY29udGV4dC5oPg0KPiAgDQo+ICAjZW5kaWYgLyogX19BU01fQVJDX01NVV9DT05U
RVhUX0ggKi8NCj4gDQoNCg==
