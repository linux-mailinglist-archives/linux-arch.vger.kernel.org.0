Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C4179440
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDQCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:02:38 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50844 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgCDQCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:02:38 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G0PoR020321;
        Wed, 4 Mar 2020 08:01:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5kpW+UgYGGdv88Br5LkJ2AQlUzcHXE9yHIyiOTAWvwE=;
 b=X1cGBUzbGd0iRzwaMJ0idlPEXhS5bL9tq8OZay+WvCVu8n6HaWT9aB1X6oNJtI0INgmh
 h9kBs8EpeB2ihaO8ydVhksulSaY6Zlb8mE8moEbvtrJLgnK23WFauBbtIINZkbyuAMU3
 CQRDWRGXApSsWzwzMQ9IF9rgAeq+9kNG3XTrFsxtH/y7mD6mBZl+tfQHsDfc+i67Wvl1
 wGCL60GU0zkjEOdYTDIbW6vULuKcVkB+sUj/3lN/sejpdt8iku64kcsyjz3NzAJKnmk0
 3Z3gSrT52t1KX6EVaeDPuiOpqC0wHLCimzDX2CSIvUFTWakYWErxdlTwAjFc6lCZTX71 Vw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4d68j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:01:56 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:01:55 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:01:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:01:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3E5RlMve8YhGBu8gXa+VVckPkcA4WGKvFB/Q3MBhLU+o6ls6hx17Mscq7ZpFkA2iDRaxMPcJondIPrdkuNL2nai+13Xt6mCCBJ+lzS91/8c7rt7ZbTQa8eWLFdTL4e4Kdjem12yu5dL/aodShxCHRJGEyz1YlQayixGdE+54xw9T7qEA25hXMNvwgVWq67HaikmZ9GfidzUx7rR95nDKqBEvo0EKvwXoXCSETvEf4Yf1avcsqpz7Vz1whFBA4/U8l2Gvhpd+1qWiUW+UfTc2yZFwQPtX6GAEjqK988mHha2xsEsIW7OxSD6tKgs2Jt7wutVzwWD5lT0O5iQUPtquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kpW+UgYGGdv88Br5LkJ2AQlUzcHXE9yHIyiOTAWvwE=;
 b=K3nQOBRSejFywOY/SQRKL6uR1WY65a+WwTpuS5HpqMB6MG92e6DeXfsz3KOgluCqr8zFbS+/m1ePfwTmrvj9Nt+NZUGZqd6+wwqg3n/focZrRg/E8ZURTeQXTrugVlPXKb+o2VlCGpt3rErLVqOyfL0qiDnsfepdqLra9fDPSNosgGdYx6gesxnFPpiFFdI2mnZY9mjfM7nc3zr/pYRwEzAwgCqWRKQojfIYg3jU/HWETax7a3SkDDdQFktbiINFQ7QpW/gEgPTqvcqARMve0AGHdO8aKx3Tb89DAL+/BVxFTLbv2nKLB0topaNugYBxN74alveMYYYygs2c3AFBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kpW+UgYGGdv88Br5LkJ2AQlUzcHXE9yHIyiOTAWvwE=;
 b=hshPDtqXGQbkWUmHe/Xc6Tj6pUV8Go/XM1ul4Eyq3QBUZt4FAuvrY2uaHozEfqJkzJGLcgr1wHiMvRGMgQQJaWbW6P3qsorC01MSbquFCFBfe7yHX0dhD8XHDtKo/7G3xycvnI3XuVchdO851TtOx0x2C/hIajiCCaZnN/lvgwM=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB3061.namprd18.prod.outlook.com (2603:10b6:a03:10e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:01:53 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:01:53 +0000
From:   Alex Belits <abelits@marvell.com>
To:     "frederic@kernel.org" <frederic@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 00/12] "Task_isolation" mode
Thread-Topic: [PATCH 00/12] "Task_isolation" mode
Thread-Index: AQHV8j44Zkht9giOXkalDj1LJqryKg==
Date:   Wed, 4 Mar 2020 16:01:53 +0000
Message-ID: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef02f80-da35-402d-16b0-08d7c0555b7d
x-ms-traffictypediagnostic: BYAPR18MB3061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB3061FFA4C90182C47E64B29EBCE50@BYAPR18MB3061.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(66556008)(6506007)(2906002)(71200400001)(66476007)(64756008)(478600001)(54906003)(66446008)(2616005)(110136005)(8936002)(966005)(6512007)(66946007)(81156014)(81166006)(91956017)(8676002)(76116006)(4326008)(26005)(86362001)(36756003)(5660300002)(186003)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB3061;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y6F6Hz+CJ6/NEvT6748rEz/aoeKnPFPrb5I5hn4cZ1ErpRrFkviA7tr0Rod0ULo3uSAFTzLs5Zuo03c2lw589o/lA3pPASOV+Wwnmqa4tao/jfQ8at/eAwb92ewc6QoYkkfZrrheqNmUYsggRv2mebW22YoZ1CvHWiqb7998qmpU8LrxelYBjaW7HoO4m+td396IP3KO79pvl2aHn9qM+JSFaxAbpIDTN1JrvbIvClV/T9TZFMVbaZ2/z4GGuEsfltfELab/beV1LrPKMxTWo+Dsm+cC4aSDoUYdsyslBt7F4qI/MDXYhqlEXUPwFK22lcl8Og17fbuggcjx24FKenHcU4Ry5VCfj8sQXE7SeTCLEk0Eb1JnhnvvtVcVOzxf4OH1s7xADYQrF/AU6pLKWqfzELAYzRy0YCn1UtkaqybS7kMYHTQCwkwvcTlV0F/6YW7vsRnpibhvA0eYyvBrPsDwohMIwFevMURHKffLbM1Wnfk0bvoCs52Zu/Rwv7db9F32NAJCHRckRm/ZahNxrg==
x-ms-exchange-antispam-messagedata: 9lgP/pCNTo66KQmoA/9Chnx4SLB/ybnFz58OrfRdk8WafMgROzE5Lz9Lzs14bMi8U9hAjPPXiB6yFL/I/obu5og3Enk0TG7ufNR5fA5prffmNaRfFTkwurBc9de4vcSxsREMHiq4g7chhzd4Jlt1Fw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8E586B7573DC4A9C9686774D4DD920@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef02f80-da35-402d-16b0-08d7c0555b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:01:53.3513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYlDbrdXTXlLIYgwKNnQxS6M3QAgVpW2UqnLL5aUWzqReJocHI7QfSqW/2VgNtpm00BqW68uWx972SzO8ygVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB3061
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhpcyBpcyBhbiB1cGRhdGUgb2YgdGFzayBpc29sYXRpb24gd29yayB0aGF0IHdhcyBvcmlnaW5h
bGx5IGRvbmUgYnkNCkNocmlzIE1ldGNhbGYgPGNtZXRjYWxmQG1lbGxhbm94LmNvbT4gYW5kIG1h
aW50YWluZWQgYnkgaGltIHVudGlsDQpOb3ZlbWJlciAyMDE3LiBJdCBpcyBhZGFwdGVkIHRvIHRo
ZSBjdXJyZW50IGtlcm5lbCBhbmQgY2xlYW5lZCB1cCB0bw0KbWFrZSB0aGlzIGZ1bmN0aW9uYWxp
dHkgYm90aCBtb3JlIGNvbXBsZXRlIChhcyBpbiwgcHJldmVudCBpc29sYXRpb24NCmJyZWFraW5n
IGluIHNpdHVhdGlvbnMgdGhhdCB3ZXJlIG5vdCBjb3ZlcmVkIGJlZm9yZSkgYW5kIGNsZWFuZXIg
KGFzDQppbiwgYXZvaWQgYW55IGR1YmlvdXMgb3IgZnJhZ2lsZSB1c2Ugb2Yga2VybmVsIGludGVy
ZmFjZXMsIGFuZCBwcm92aWRlDQpjbGVhbiBhbmQgcmVsaWFibGUgaXNvbGF0aW9uIGJyZWFraW5n
IHByb2NlZHVyZSkuDQoNCkkgZ3Vlc3MsIEkgaGF2ZSB0byBleHBsYWluIHdoeSBzdWNoIGEgdGhp
bmcgZXhpc3RzLg0KDQpUaGlzIGlzIHRoZSByZXN1bHQgb2YgZGV2ZWxvcG1lbnQgYW5kIG1haW50
ZW5hbmNlIG9mIHRhc2sgaXNvbGF0aW9uDQpmdW5jdGlvbmFsaXR5IHRoYXQgb3JpZ2luYWxseSBz
dGFydGVkIGJhc2VkIG9uIHRhc2sgaXNvbGF0aW9uIHBhdGNoDQp2MTUgYW5kIHdhcyBsYXRlciB1
cGRhdGVkIHRvIGluY2x1ZGUgdjE2LiBJdCBwcm92aWRlZCBSVE9TLWxpa2UNCnByZWRpY3RhYmxl
IGVudmlyb25tZW50IGZvciB1c2Vyc3BhY2UgdGFza3MgcnVubmluZyBvbiBhcm02NA0KcHJvY2Vz
c29ycyBhbG9uZ3NpZGUgd2l0aCBmdWxsLWZlYXR1cmVkIExpbnV4IGVudmlyb25tZW50LiBJdCBp
cw0KaW50ZW5kZWQgdG8gcHJvdmlkZSByZWxpYWJsZSBpbnRlcnJ1cHRpb24tZnJlZSBlbnZpcm9u
bWVudCBmcm9tIHRoZQ0KcG9pbnQgd2hlbiBhIHVzZXJzcGFjZSB0YXNrIGVudGVycyBpc29sYXRp
b24gYW5kIHVudGlsIHRoZSBtb21lbnQgaXQNCmxlYXZlcyBpc29sYXRpb24gb3IgcmVjZWl2ZXMg
YSBzaWduYWwgaW50ZW50aW9uYWxseSBzZW50IHRvIGl0LCBhbmQNCndhcyBzdWNjZXNzZnVsbHkg
dXNlZCBmb3IgdGhpcyBwdXJwb3NlLiBXaGlsZSBDUFUgaXNvbGF0aW9uIHdpdGggbm9oeg0KcHJv
dmlkZXMgYW4gZW52aXJvbm1lbnQgdGhhdCBpcyBjbG9zZSB0byB0aGlzIHJlcXVpcmVtZW50LCB0
aGUNCnJlbWFpbmluZyBJUElzIGFuZCBvdGhlciBkaXN0dXJiYW5jZXMga2VlcCBpdCBmcm9tIGJl
aW5nIHVzYWJsZSBmb3INCnRhc2tzIHRoYXQgcmVxdWlyZSBjb21wbGV0ZSBwcmVkaWN0YWJpbGl0
eSBvZiBDUFUgdGltaW5nLg0KDQpJdCBpcyBjbGVhciB0aGF0IHN1Y2ggaXNvbGF0aW9uIGlzIG5l
aXRoZXIgcG9zc2libGUgbm9yIG5lY2Vzc2FyeQ0Kd2hpbGUgYSBDUFUgaXMgcnVubmluZyBrZXJu
ZWwsIHVzZXJzcGFjZSBpbml0aWFsaXphdGlvbiBvciBjbGVhbnVwLCBzbw0KdGhlcmUgaXMgYSBu
ZWVkIGZvciBhIHNlcGFyYXRlIGlzb2xhdGVkIHN0YXRlIHRoYXQgYSB1c2Vyc3BhY2UgdGFzaw0K
Y2FuIGVudGVyIGFuZCBleGl0LiBUaGlzIHdhcyB0aGUgcmVhc29uIGZvciB1c2luZyB0aGUgb3Jp
Z2luYWwgdGFzaw0KaXNvbGF0aW9uLCBhbmQgc3VjaCByZWFzb24gc3RpbGwgZXhpc3RzIG5vdy4g
VGhlIGFsdGVybmF0aXZlLCBydW5uaW5nDQpSVE9TIGluc3RlYWQgb2YgTGludXgsIGlzIGJlY29t
aW5nIG1vcmUgYW5kIG1vcmUgbGFib3ItY29uc3VtaW5nDQpiZWNhdXNlIG1vZGVybiBDUFVzIGFu
ZCBTb0NzIGhhdmUgdmVyeSBjb21wbGV4IGRldmljZS9yZXNvdXJjZQ0KY29uZmlndXJhdGlvbiBh
bmQgbWFuYWdlbWVudCBwcm9jZWR1cmVzLCBhbmQgYXQgdGhpcyBwb2ludCBmb3Igc29tZQ0KaGFy
ZHdhcmUgaXQgaXMgY2xlYXJseSBpbiB0aGUgcmVhbG0gb2YgaW1wcmFjdGljYWwgdG8gbWFpbnRh
aW4gYW4gUlRPUw0Kd2l0aCBoYXJkd2FyZSBzdXBwb3J0IG9uIHBhciB3aXRoIExpbnV4IGtlcm5l
bCwgcmVsaWFibGUgYW5kIHNlY3VyZSBhdA0KdGhlIHNhbWUgdGltZS4NCg0KT24gdGhlIG90aGVy
IGhhbmQsIGRldmVsb3BtZW50IG9mIG1vZGVybiBlbWJlZGRlZC1vcmllbnRlZCBTb0NzIGhhZA0K
c2hvd24gdGhhdCBudW1lcm91cyBDUFUgY29yZXMgbWF5IG9yIG1heSBub3Qgc2hhcmUgYW55IGhh
cmR3YXJlDQpyZXNvdXJjZXMgYmFzZWQgb24gU29DIGRlc2lnbmVycycgaW50ZW50aW9uLiBUaGVy
ZWZvcmUgT1MgYWJpbGl0eSB0bw0Kc3dpdGNoIGEgQ1BVIGNvcmUgaW50byBSVE9TLWlzaCBtb2Rl
IGFuZCB0cnVseSwgcmVhbGx5LCBhdCBhbGwgbGV2ZWxzLA0KbGVhdmUgaXQgYWxvbmUgdW50aWwg
T1MgaXMgbmVlZGVkIHRoZXJlIGFnYWluLCBpcyBhbiBpbXBvcnRhbnQgZmVhdHVyZQ0KZm9yIG1v
ZGVybiBlbWJlZGRlZCBzeXN0ZW1zIGRldmVsb3BtZW50LiBQcm9iYWJseSBtb3JlIGltcG9ydGFu
dCB0aGFuDQpldmVuIHJlYWwtdGltZSBpbnRlcnJ1cHRzIGxhdGVuY3kgYW5kIHByZWVtcHRpb24s
IG5vdyB0aGF0IHBlb3BsZSwNCndoZW4gdGhleSBkb24ndCBsaWtlIGhvdyB0aGVpciBpbnRlcnJ1
cHRzIGFyZSBoYW5kbGVkLCBjYW4ganVzdCBhZGQNCkNQVSBjb3Jlcy4gVGhpcyBpcyB3aHkgd2Ug
aGFkIHRvIG1haW50YWluIHRhc2sgaXNvbGF0aW9uLCBhbmQgSQ0KYmVsaWV2ZSwgYWZ0ZXIgYWxs
IGltcHJvdmVtZW50cyBpbiBDUFUgaXNvbGF0aW9uLCB0aW1lciBhbmQgaW50ZXJydXB0DQptYW5h
Z2VtZW50IHRoYXQgd2FzIGRvbmUgaW4gTGludXggc2luY2UgMjAxNywgaXQgaXMgbmVlZGVkIGV2
ZW4gbW9yZSwNCmFzIG9wcG9zZWQgdG8gbGVzcy4NCg0KVGhpcyBzZXQgb2YgcGF0Y2hlcyBvbmx5
IGNvdmVycyB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGFzayBpc29sYXRpb24sDQpob3dldmVyIHRo
ZSBuZWVkIGZvciBhZGRpdGlvbmFsIGZ1bmN0aW9uYWxpdHksIHN1Y2ggYXMgc2VsZWN0aXZlIFRM
Qg0KZmx1c2hlcywgaXMgb25lIG9mIHRoZSByZWFzb25zIGJlaGluZCB0YXNrX2lzb2xhdGlvbl9v
bl9jcHUoKSBhdm9pZGluZw0KYW55IG5vbi1pc29sYXRpb24tc3BlY2lmaWMgZGF0YSBzdHJ1Y3R1
cmVzIGFuZCB0aGUgZXhpc3RlbmNlIG9mDQpmYXN0X3Rhc2tfaXNvbGF0aW9uX2NwdV9jbGVhbnVw
KCkgZnVuY3Rpb24sIHRoYXQgaXMgYWx3YXlzIGNhbGxlZCBvbg0KdGhlIENQVSB3aGVyZSBpc29s
YXRlZCB0YXNrIGlzIHJ1bm5pbmcuDQoNClJlcG9ydGluZyB0YXNrIGlzb2xhdGlvbiBicmVha2lu
ZyBpbiBrZXJuZWwgbG9nIGlzIG5vdyBtb3JlDQppbmZvcm1hdGl2ZSBhbmQsIGlmIG5lY2Vzc2Fy
eSwgY2FuIGJlIGFkYXB0ZWQgdG8gcHJvdmlkZSBtZWFuaW5nZnVsDQpjYXVzZSBpbmZvcm1hdGlv
biB0byB1c2Vyc3BhY2Ugc29mdHdhcmUuIEkgYW0gbm90IHN1cmUgaWYgc3VjaA0KbWVjaGFuaXNt
IGlzIG5lZWRlZCAtLSBkZXZlbG9wbWVudCBhbmQgcmVwb3J0aW5nIGZhaWx1cmVzIGluDQpwcm9k
dWN0aW9uIHVzdWFsbHkgcmVsaWVzIG9uIGtlcm5lbCBsb2dzLCBhbmQgaW4gcHJvZHVjdGlvbiBp
dCBpcw0KYXNzdW1lZCB0aGF0IGlzb2xhdGlvbiBicmVha2luZyBzaG91bGQgbm90IGhhcHBlbiBv
biBpdHMgb3duLiBPbiB0aGUNCm90aGVyIGhhbmQsIGlmIGFwcGxpY2F0aW9uIGNhbiBjb2xsZWN0
IGEgbWVhbmluZ2Z1bCBsb2cgd2hlcmUgaXRzDQpldmVudHMgYXJlIG1hdGNoZWQgdG8gaXNvbGF0
aW9uIGZhaWx1cmVzLCB0aGlzIG1heSBiZSBiZXR0ZXIgZm9yDQpkZXZlbG9wZXJzIHRoYW4gbWF0
Y2hpbmcgdGltaW5nIG9mIHJlY29yZHMgZnJvbSBtdWx0aXBsZSBzb3VyY2VzLiBGb3INCm5vdywg
b25seSBsb2cgc2hvd3MgZGV0YWlsZWQgZGVzY3JpcHRpb25zLg0KDQpUaGUgdXNlcnNwYWNlIHN1
cHBvcnQgYW5kIHRlc3QgcHJvZ3JhbSBpcyBub3cgYXQNCmh0dHBzOi8vZ2l0aHViLmNvbS9hYmVs
aXRzL2xpYnRtYyAuIEl0IHdhcyBvcmlnaW5hbGx5IGRldmVsb3BlZCBmb3INCmVhcmxpZXIgaW1w
bGVtZW50YXRpb24sIHNvIGl0IGhhcyBzb21lIGNoZWNrcyB0aGF0IG1heSBiZSByZWR1bmRhbnQN
Cm5vdyBidXQga2VwdCBmb3IgY29tcGF0aWJpbGl0eS4NCg0KTXkgdGhhbmtzIHRvIENocmlzIE1l
dGNhbGYgZm9yIGRlc2lnbiBhbmQgbWFpbnRlbmFuY2Ugb2YgdGhlIG9yaWdpbmFsDQp0YXNrIGlz
b2xhdGlvbiBwYXRjaCwgRnJhbmNpcyBHaXJhbGRlYXUgPGZyYW5jaXMuZ2lyYWxkZWF1QGdtYWls
LmNvbT4NCmFuZCBZdXJpIE5vcm92IDx5bm9yb3ZAbWFydmVsbC5jb20+IGZvciB2YXJpb3VzIGNv
bnRyaWJ1dGlvbnMgdG8gdGhpcw0Kd29yaywgYW5kIEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRl
cmljQGtlcm5lbC5vcmc+IGZvciBoaXMgd29yayBvbg0KQ1BVIGlzb2xhdGlvbiBhbmQgaG91c2Vr
ZWVwaW5nIHRoYXQgbWFkZSBwb3NzaWJsZSB0byByZW1vdmUgc29tZSBsZXNzDQplbGVnYW50IHNv
bHV0aW9ucyB0aGF0IEkgaGFkIHRvIGRldmlzZSBmb3IgZWFybGllciwgPDQuMTcga2VybmVscy4N
Cg0KVGhlIHByZXZpb3VzIHBhdGNoICh2MTYgYnkgQ2hyaXMgTWV0Y2FsZikgaXMgYXQ6DQoNCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTUwOTcyODY5Mi0xMDQ2MC0xLWdpdC1zZW5kLWVt
YWlsLWNtZXRjYWxmQG1lbGxhbm94LmNvbQ0KDQotLSANCkFsZXgNCg==
