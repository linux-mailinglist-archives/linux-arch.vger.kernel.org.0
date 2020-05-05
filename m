Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11C91C5FAB
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgEESIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 14:08:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:47848 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729315AbgEESIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 14:08:39 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E96654065A;
        Tue,  5 May 2020 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588702118; bh=6OzICyelUhAnSArTm9ZBI0YOjhMDHv3qtyFZFxx0h78=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KCrYtWbQKFKvSkM4VMCFTPaZ2HfMT6OHpJgd5hzDJO8dKkXZdthi+E7mjvio43cLk
         kstV1EdExVDQzZwtZ6mdC+iU7fpzCn2WUcN+wTjso0oRCmm/eLMBkDmQ2Ur8NjcJsR
         xsXfpS80xcNyD763MZLkkDUo6qh8b3r8EJOm6Y+LXpUqUPtxSu4g7UQYyjyP4Qd7cR
         VyZf1TyISaYc3Os0f9zipoorHlLJazxlUdf7s5+4cFlQE8MCs3NxHbWywf/EGeefls
         Jbe442UY57qtMpmK1EBbZl8oEibtIzob3kbpZb5c6xRP4+P1UivKivimyJZfkgxzom
         998lUqdChSruQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 54F1DA007F;
        Tue,  5 May 2020 18:08:05 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 May 2020 11:07:48 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 5 May 2020 11:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc3evdPaqM/aZYsSDDtetJYUIJI2L0jKf0YIRIV/z1Sgfoytua1/+wy4Pa8Imb8o5JFAvO56RBSSvSxHe4t/zyEeqa31l3RncRlE4tRmNcWBG0bFWop4Q7XNPCR2/Gf7wEgyFGvRiLPXlaPALz3JJul8urPrPLl63GbecexkBwrJqGwWEcr7oGhIIkldjT2T8z0PysgQC47UwFKhzATIQHuJY14bf0jjxZAco/1p+SFWOwaIHOyDNNImEWQlnhTOrhOb3aZEmE7zwPJFlNEbsI7ZIUfGDl8FfpR7Sotz4pP2aWx5G3Ow7q+HpdgT/Nock+jis7C2UINGWH5lg29avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OzICyelUhAnSArTm9ZBI0YOjhMDHv3qtyFZFxx0h78=;
 b=oDgDryvcNKwiiziv5QGoSH3U9bE6o9wRvIW3TH01Lm0dZKmXtSZECZ1oJxbj9f3GqWFdGaIlVrNMuvqj0EyfQiUm7uSzhtrsQN4XxbfiYsC7P3RT3C6nTLcOES5KruRoZju7KqOOwJ/3TbTX8aVP0lhccrU/pMuAVPFYlodwQTsmo8NruhrnGRGj7fordOfRfNeizwhs/FV1Lf2YrjrPvTscq/bI9fh//oMpQW6KNtdTBjX9aB0M4kbPuNp7LH51y6lmMA5jLtTlmGO/jfmRrHAoQbgv2v8lbUiXOLmLnWFw79H6jzQfnecY4Avy222G6izfb1i31nVTAXGeBnzj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OzICyelUhAnSArTm9ZBI0YOjhMDHv3qtyFZFxx0h78=;
 b=AlR+b4sXqbc23H6D6fiPXM6V+JuQqdQCoqoiFliBGGbXVO4mMYcVv69MPbCbQhT9uzYXLHyzn/c/K7NpDfFXfj5qfBh+1sU2a0Zu0qvKAlFgmsMEi4Ye2t5eRndSOmh/5PTwA/ysk5SWSatoSCcLJ1r/DQFPpuFaukpSm9Q52Ag=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 18:07:46 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 18:07:46 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Thread-Topic: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Thread-Index: AQHWHiAFM1CeaVL9XUmgz0SxoJ1XgqiWp/EAgAARJQCAAV7ugIAA9yYAgAAxOACAAJOFgA==
Date:   Tue, 5 May 2020 18:07:46 +0000
Message-ID: <88b9465b-6e6d-86ca-3776-ccb7a5b60b7f@synopsys.com>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
 <20200503174138.GA114085@roeck-us.net> <20200503184300.GA154219@roeck-us.net>
 <20200504153901.GM14260@kernel.org>
 <a0b20e15-fddb-aa9c-fd67-f1c8e735b4a4@synopsys.com>
 <20200505091946.GG342687@linux.ibm.com>
In-Reply-To: <20200505091946.GG342687@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:83a0:fee2:8ed0:e900:96d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f61f34-dd39-432f-9daa-08d7f11f3729
x-ms-traffictypediagnostic: BYAPR12MB3576:
x-microsoft-antispam-prvs: <BYAPR12MB3576F09E9D3BFB772B54CD7DB6A70@BYAPR12MB3576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bj8oIxoB389le/4NfVeQB4ehz82G/eiVTpAyTc+8XsV6yYsMAqrqf5MzoLRP5qwOmyLd5siL8hR5ewNHRvhBebQcZGUt9btAgHGqmd3sVWQdb6TOFjp7afR2/8KBhVFWEdHa8BXQ1v5DXt2n3kFKDeY+ydko0PA/1tMDhgBi2BDw5Rmw/avGO9aRi0mAeif2/0bzlXsO2mY3g3RwHqfN2J87MLU7S/UBWLxdWKzlPCrcmXzJgGLK8A+4sT5LJO6vwV4g4125lsQsNERQgATsWL05T40LUtwt0mPJgD2CAnuo2LvsLHXftHu5zajOyRPbwZiHkgShDSCDeb8bezVKrIQY5vwsDRTkqt75VmXlo+zLiznz8Gw64CyYBD35oj69NXlSjaIGsbi3rBO4yyRR67OCe8SgHG46TXF45tE58CY55YmU85Rtn04tUPBJOhJLwhrXnbYLq9/r8UvqN6+j8zfj22aWLgnHxwN4NumJ7b8SONmRclPd55yqt7XLN7eFiwMwyJ588tJGSobU5Em1J+maNi7BtNrlglyniv4U6UmQhzuUByJh5XKB2M8bxNP6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(33430700001)(478600001)(6506007)(2906002)(53546011)(2616005)(4326008)(316002)(54906003)(6916009)(33440700001)(7416002)(31686004)(5660300002)(186003)(31696002)(8676002)(6512007)(36756003)(71200400001)(8936002)(86362001)(76116006)(66446008)(6486002)(66476007)(66556008)(66946007)(4744005)(64756008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: c6vW9kqdVe9D04F4LtsHuraCskltSLhFrstqK8Lxdbsf3n39iNiELygaxRnHQFDovp9a/RG/XnnWfWmZ29HLnL0N0CuIuSr63E9JjQgqMxwMLAig0Awsi43rK9eRfGHNfW65ygVVQmayYi+uI8ET+5fAlIHgx+I4MdaA0ASg5npJZVYHW1D/jUIbhAMKU3MPz+5IvfDJw5Q8mbM7LbG0Gof14CNknxSozbtvyFseKLVC4re4xr8XoseFqFvmXGumRnvgyTjh1nq3ianilk4cVfyrmZaTKD0gW3A8Jduz0oPeMg8doLgkiAD3A+l8aGPUjMv+fpFb+JQyAldhdbXLvNg2Rfd7jAR2hHNuOSOR6OpZpa6nzPYm0926hDSGmSwqFLT+AOTxkwrcYj7WIaeiZD79MYuvS3EK0cngt4jKW13nBaoJE3ih6Oh4D7TVp+NipdhvEmjlILZp1hsIroPOIYZ94xLv8L1V8cr8nDKatpwWu69doRSOHLBX3DbBplkRhsbFzhpRXWjJuGzVJdWpa8ZGNJVfP/0u3FamluudU4P5MsdV6P6tNFIJKsHLH4jLJaFMJ8bfOg2Y8B9m7Ebg6PGyIi7JW+Df81D0/IjJ0bXm5rUYYSEkJdVhNT4YcOLMHUgdhgI7Djoeu2aDwGVmBvdPSfnxpq7sdLU2dqacf0urEKBKlX5ggrfp29iF/D7p/yeJoB+DUdFYQuxxqZymwPj3SbKZVfMs99Csm+Dna/hgtheh/bQx9S+ATVHFTOAGycyMRz4me+4cpM6f2nQTTAees/vILhhDEXpy4cVRyE3PBWBM00zzdd3ZVp4xBbTBjpHEghRTaAlEVBcmYmxXFEf978+tphdCJ3MkD3PwfHk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C25EB48EA9FC849929696E7D5B3FBF8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f61f34-dd39-432f-9daa-08d7f11f3729
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 18:07:46.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5RyUXBXLb3y7td0C5/WOd1PXnUEQaEQeNUACbRfuVrVImKqSu9MPJOIiOliKmk79sCksQiCUiDZUs8d2Xklzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNS81LzIwIDI6MTkgQU0sIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IEZyb20gdGhlIGNvZGUg
SSd2ZSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCBpdCBpcyBlaXRoZXIgb25lIG9mIHRoZW0uIEku
ZQ0KPiB0aGUgcGh5c2ljYWwgbWVtb3J5IGlzIGVpdGhlciBhdA0KPg0KPiAweDgwMDBfMDAwMCAt
IDxlbmQgb2YgRERSIDAgYmFuaz4NCj4gMHgwMDAwXzAwMDAgLSA8ZW5kIG9mIEREUiAxIGJhbms+
DQo+DQo+IG9yDQo+DQo+IDB4MF84MDAwXzAwMDAgLSA8ZW5kIG9mIEREUiAwIGJhbms+DQo+IDB4
MV8wMDAwXzAwMDAgLSA8ZW5kIG9mIEREUiAxIGJhbms+DQo+DQo+IElzIHRoaXMgcG9zc2libGUg
dG8gaGF2ZSBhIHN5c3RlbSB3aXRoIHRocmVlIGxpdmUgcmFuZ2VzPyBMaWtlDQo+DQo+IDB4MF8w
MDAwXzAwMDAgLSA8ZW5kIG9mIEREUiAxIGJhbms+DQo+IDB4MF84MDAwXzAwMDAgLSA8ZW5kIG9m
IEREUiAwIGJhbms+DQo+IDB4MV8wMDAwXzAwMDAgLSA8ZW5kIG9mIEREUiAyIGJhbms+DQoNCldl
IGRvbid0IGhhdmUgc3VjaCBhIHN5c3RlbSwgYnV0IGl0IGlzIGluZGVlZCBwb3NzaWJsZSBpbiB0
aGVvcnkuIFRoZSBxdWVzdGlvbiBpcw0KwqAtIENhbiBvdGhlciBhcmNoZXMgaGF2ZSBzdWNoIGEg
c2V0dXAgdG9vDQrCoC0gSXMgaXQgbm90IGJldHRlciB0byBoYXZlIHRoZSBjb3JlIHJldGFpbiB0
aGUgZmxleGliaWxpdHkganVzdCBpbiBjYXNlDQoNClRoeCwNCi1WaW5lZXQNCg==
