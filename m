Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE94B230067
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG1D6g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:58:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgG1D6g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 23:58:36 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D24B0C00AD;
        Tue, 28 Jul 2020 03:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595908715; bh=IAl7K3B41JaE3eRFg2+RB+w+Zr7UPO4FrGHHRjmprwc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cz3hnmN9W/DfwufuiVC7YYXoho6OxqD3JnR1fD69vCwRc3JIsdbDbfbGIL/qjvIWx
         dpRqXvlkGnlbc6kurOVkVGhFYNow15bFsWje4NHpURsqcTr9mDzEEV7cAoCuJJ7gdj
         FN+ivUlT/D5qeshFfxYh1xGqBuW511oKtl92ZkImNsgFQ32RcWWRwwz6wXrtdnPztH
         8Fi0sS321DXAgHY1/zBL2+ymsUtvfM9rSZ7kPD9lSOPNSiacS4jWN46RYwH0k6a8EL
         Oao9iAK4ohHndB3DMOaCsysioKXuxvEJ3yYZnxPUyLq3dCaNLtR730quKZskEiQGXS
         fnei1VBjAZOhw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 78B70A0068;
        Tue, 28 Jul 2020 03:58:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 19D4D400BE;
        Tue, 28 Jul 2020 03:58:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Dnir9b70";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh18bOYFf2f0sPbWWLB75WMdCoSqsUSJcCbzVQdAEct38SNX810RJkNYWseXY2tcEkUezLrugxx+eLKaCG4FH3o7Yrys0/tilUHrDeZjU/29zFfWT54EuzgCy4z56BbpVOvBrKSVEGNnSQokwl7vCM9vjU5sungQS4fqjX7L21oQiKmRQkKowQcTK0hWH5rHjzLYF1ffiDuoPHuLjmkd0Vfz1MuwwxWROnb6W7OfPEZyBHEsO9M6HZ/PG0/0F+4S3ziDSvAS2VjnpX7YYRg+GhvRYGBXtI+3Vh6HYB9fq0tye7n6jwGT5i1CukMLkdqrra1AF6UdmWKEf7kjJ1Rnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAl7K3B41JaE3eRFg2+RB+w+Zr7UPO4FrGHHRjmprwc=;
 b=kY+M6eC8a4tiqgiL2loQGHCudpZ3Tmn09gYvrrXAkIJiAYzFoxjqPu8s+wEZIzrOiyMtvZjSbvr+mRwqKL06a5fKG4f2GLxyqRD3KLgLMBDjWMc+gfuKyNv6xdJDb+cF+tqiwssmc1+b1un2OJZ30XThdNAaCWBSP0INiJ/kjYRteQTaxRd9X4BUJPMJTH/jOjaqhUIX8U2sFdsZwkGQG7UHnRRg5Mw4YZK8tUOS1p8mV4plTmYFzGfyj7HXKSrcZ+HLjzmUJSjvOTFhJ5OYgh5oRnFqw2e+Aq0JEb86liWFOnz+NBd5m4xhtq6yPUZ8Bk+RDKnDOoOGzIxgpTz/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAl7K3B41JaE3eRFg2+RB+w+Zr7UPO4FrGHHRjmprwc=;
 b=Dnir9b70is3ccrnT4se5/u4uDpJ0zb6Y86bsqQka1Ld8rI15yqK6uycwX5q2fRpm7wG53dT8mF0clbxmDqIKzwZDfGRh7OK0GRv9BRvqTU3clzyyREwbD+3pSX53dttN6psBhwDYF4MZtVf1Sqt2wEDa5jl4apzmKt5W6fvG/wE=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3938.namprd12.prod.outlook.com (2603:10b6:a03:1af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 03:58:25 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 03:58:25 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 03/24] arc: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Topic: [PATCH 03/24] arc: use asm-generic/mmu_context.h for no-op
 implementations
Thread-Index: AQHWZJADsknRIKY1fkK0FgCGpMpua6kcXY2A
Date:   Tue, 28 Jul 2020 03:58:25 +0000
Message-ID: <04b9872c-e9d8-2221-0bf6-595dbd15d8eb@synopsys.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
 <20200728033405.78469-4-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-4-npiggin@gmail.com>
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
x-ms-office365-filtering-correlation-id: 6ecf330e-391f-43d9-891a-08d832aa7a8f
x-ms-traffictypediagnostic: BY5PR12MB3938:
x-microsoft-antispam-prvs: <BY5PR12MB3938F7E1BE03ED32CF471CABB6730@BY5PR12MB3938.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Szit7jZZF/F1woIkZIbCsI6NmRHDIUWobXf+brVoh4XSJ2O7jV+yk0+SnQ4YmCiMHVGGczmKSMli8lmZorOuqxBd+SVBs90M3SK68ghzWerkRwO8teTnJec5e3bAzk0WSc9iSNhntTI0BW9p+eiuSufbURfRio+q4HbOVH6en7n/CeAlOX8PNsmxNhXxzDiufmirml/MiZRVZ+pBOqhStVahyndrQhCBO9vh56nfYMs9Qb7DEP+ZfZSqjvHX16LZivwVPJvUjw2/TSwUW+gXSDVi4u6XBTWJQ7ciwI1qGtxqLNzE7n/Q7mVQklnfGDU/LbaUE21+doSth5Q+srgls6uZdq0aLImsY9sqI9DcVA/R5IoiPRMSfn0KngM8LO1JSgoVzQW9nx6wCrPiEjsuuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(5660300002)(316002)(54906003)(6512007)(110136005)(6486002)(4326008)(83380400001)(8936002)(8676002)(36756003)(71200400001)(2616005)(26005)(86362001)(53546011)(6506007)(31696002)(2906002)(66556008)(31686004)(64756008)(66476007)(66446008)(186003)(76116006)(478600001)(66946007)(41533002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ROp8ekgVp9lI4M3/NAlakrqLF9e3z8E9LBOn9sCwBf2PceYcDy85Vy1GkMm5hr/VHOKFUrZtFJevy71pmP1UgMSZTuDwvFWVkKv4MCm7RlNLCe6iXbdFM+Qd8klfLetGa6vB1MuM6cFZfYXgIsC+6A18jr1PC46rFsC2ekUDegBFyLPY6DvMuXF8NaIq4gpT6G3Wf4sbczHFVp7eWMjyBS2w3hGEyEn7hO8e7IOzLxk/5U0ReyLJIC7Al9vvbDLRlJM/TmEMsyhEf4xM23/eBp/1QpYqZ+hDaFW9Xvrpx4JVTW7rS6dX93Sw6wpB8Vn3C4Y7tOZ01PGIAaMxGsrJdbL+U9Ar+Uncwqg9efh1LZpVe5ny66xG0wrRCPixS7ph/2anDqhQxgmVW8nt+FjLzqFtHbGaF+foP7DBitrDCiqqbqFOP3VTCNbPc8g+SeJF5xErBLA0p0xFcSCDjn/P97XXTXDF8jn+VXzzzMhxlx0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5326CEBC1A9364D90F83A08A49FA43D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecf330e-391f-43d9-891a-08d832aa7a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 03:58:25.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ymrAdFH1ZvUPKPq7LAAQslD7Xx43k4eNgGDav2nWMarDC6zH6+bqFKu586fRWPnDtvinRHZLkZxt53HebUKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3938
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNy8yNy8yMCA4OjMzIFBNLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQoNCj4gIC8qDQo+IC0g
KiBDYWxsZWQgYXQgdGhlIHRpbWUgb2YgZXhlY3ZlKCkgdG8gZ2V0IGEgbmV3IEFTSUQNCj4gLSAq
IE5vdGUgdGhlIHN1YnRsZXR5IGhlcmU6IGdldF9uZXdfbW11X2NvbnRleHQoKSBiZWhhdmVzIGRp
ZmZlcmVudGx5IGhlcmUNCj4gLSAqIHZzLiBpbiBzd2l0Y2hfbW0oKS4gSGVyZSBpdCBhbHdheXMg
cmV0dXJucyBhIG5ldyBBU0lELCBiZWNhdXNlIG1tIGhhcw0KPiAtICogYW4gdW5hbGxvY2F0ZWQg
ImluaXRpYWwiIHZhbHVlLCB3aGlsZSBpbiBsYXR0ZXIsIGl0IG1vdmVzIHRvIGEgbmV3IEFTSUQs
DQo+IC0gKiBvbmx5IGlmIGl0IHdhcyB1bmFsbG9jYXRlZA0KPiArICogYWN0aXZhdGVfbW0gZGVm
YXVsdHMgdG8gc3dpdGNoX21tIGFuZCBpcyBjYWxsZWQgYXQgdGhlIHRpbWUgb2YgZXhlY3ZlKCkg
dG8NCg0KV2l0aCBhY3RpdmF0ZV9tbSgpIGRlZmluaXRpb24gYWN0dWFsbHkgZ29uZSwgcGVyaGFw
cyBhZGQgImFjdGl2YXRlX21tKCkgY29tZXMgZnJvbQ0KZ2VuZXJpYyBjb2RlLi4uIiB0byBwcm92
aWRlIG5leHQgcmVhZGVyIGFib3V0IHRoZSAic3B1cmlvdXMgbG9va2luZyBjb21tZW50Ig0KDQo+
ICsgKiBnZXQgYSBuZXcgQVNJRCBOb3RlIHRoZSBzdWJ0bGV0eSBoZXJlOiBnZXRfbmV3X21tdV9j
b250ZXh0KCkgYmVoYXZlcw0KPiArICogZGlmZmVyZW50bHkgaGVyZSB2cy4gaW4gc3dpdGNoX21t
KCkuIEhlcmUgaXQgYWx3YXlzIHJldHVybnMgYSBuZXcgQVNJRCwNCj4gKyAqIGJlY2F1c2UgbW0g
aGFzIGFuIHVuYWxsb2NhdGVkICJpbml0aWFsIiB2YWx1ZSwgd2hpbGUgaW4gbGF0dGVyLCBpdCBt
b3ZlcyB0bw0KPiArICogYSBuZXcgQVNJRCwgb25seSBpZiBpdCB3YXMgdW5hbGxvY2F0ZWQNCj4g
ICAqLw0KPiAtI2RlZmluZSBhY3RpdmF0ZV9tbShwcmV2LCBuZXh0KQkJc3dpdGNoX21tKHByZXYs
IG5leHQsIE5VTEwpDQo+ICANCj4gIC8qIGl0IHNlZW1lZCB0aGF0IGRlYWN0aXZhdGVfbW0oICkg
aXMgYSByZWFzb25hYmxlIHBsYWNlIHRvIGRvIGJvb2sta2VlcGluZw0KPiAgICogZm9yIHJldGly
aW5nLW1tLiBIb3dldmVyIGRlc3Ryb3lfY29udGV4dCggKSBzdGlsbCBuZWVkcyB0byBkbyB0aGF0
IGJlY2F1c2UNCj4gQEAgLTE2OCw4ICsxNjksNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3dpdGNo
X21tKHN0cnVjdCBtbV9zdHJ1Y3QgKnByZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHQsDQo+ICAg
KiB0aGVyZSBpcyBhIGdvb2QgY2hhbmNlIHRoYXQgdGFzayBnZXRzIHNjaGVkLW91dC9pbiwgbWFr
aW5nIGl0J3MgQVNJRCB2YWxpZA0KPiAgICogYWdhaW4gKHRoaXMgdGVhc2VkIG1lIGZvciBhIHdo
b2xlIGRheSkuDQo+ICAgKi8NCj4gLSNkZWZpbmUgZGVhY3RpdmF0ZV9tbSh0c2ssIG1tKSAgIGRv
IHsgfSB3aGlsZSAoMCkNCg0Kc2FtZSBmb3IgZGVhY3RpdmF0ZV9tbSgpDQo=
