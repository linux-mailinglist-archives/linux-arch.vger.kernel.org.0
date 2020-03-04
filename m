Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AF1794BB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDQPt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:15:49 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64310 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387969AbgCDQPt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:15:49 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G6KLM027592;
        Wed, 4 Mar 2020 08:15:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=A35GkThBI5AFP+we25wxjVlcEW7bwWRoXkvf3twCzaE=;
 b=SFlnmHCmXXwPEBWf6EiKmIYi5RIwXqR7uYwblXb6ENuEX0EoyM7UB7OtPM+Rs+zmjHor
 cVeVt09gWTSeiPZYxr5a67pczpiGyZV5TeU1AvKjTozRLofDxDdH5rb4Gm05424Yghkh
 qsyNReklyh3hKj9NcpXUl/OgJ/urX7OmNk2FUXXx3KmKWHWcV0Kmtc81qmi9Z+QO/AmP
 NeGdBRLzluOi2piX6hD9kc+qZy70SoCM43TBfSZJMu8rD7EAo8uwXJDtzXLmBcU2q22W
 jmLc7qWdWOzYq+LYy1dvaJoXQo2j3/a0+kaFwhz306XGsaeCiCNy9JhEAVTElJUXQwi/ cA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4dac7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:15:27 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:15:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:15:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuBTcNZQXzau8rlU+IrmIcwI4onc9NK2JAsV69dGhPGm3PtqTJ6bF9FrRI6oAIdzeQUnQyUJu+25K9tj2mMOtatZFgnzJIenACoaQuJHx7ilE2/RPdhiv2+pKIN9PTnR6EX1rib8WppjvqXZzckqTAqcghwZB0T9ZMO5bpJR3V1/lluSS6REk+Lfl1oiOvZOZKu8ieEkpGXskxs526xDTd5b9Ztg7DXX2SWYXuBqu7Fbo6mLulDwHMvuVLyHp5DbPBtesj4hi8qrEXO47NILcOGm4mMz+7unZntELR76wFCa+s8kVAIR+hkJrozYupVl3SFPz0PcmhIB6ZtBeC6eUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A35GkThBI5AFP+we25wxjVlcEW7bwWRoXkvf3twCzaE=;
 b=CE/Y4+UduJ2tuhX8xwtsqTnmG/G652HCyJYrYs53x2Ez6zlN/Qfq31hl57YnZKKypUR/kKEiYhorIphs+Aq2rAVtE41kfePBceu0kHoGn+ihSErtE2LkjKtbpJosvofJjjCbGNWh10oH3ssDq8neoMPZ7HjreQUprbH/g6kvz6U6bwiH/6WNqu7zVVKlJhS3LhULSAmgEqbpmCWIHflXKBl6/HnqwOmhfLjtT4cR3znUwbR6wBYiRXkxs/+IEn1zzTu7VGZEAbJaJj+yDgqg+wW1WKRdyi7OZ8GSR/PBSv0mSVb0M3HGl/bfxgcKItlfVMLLB09Fayv08CixvVXOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A35GkThBI5AFP+we25wxjVlcEW7bwWRoXkvf3twCzaE=;
 b=HY5gTr75ufpDU0PZ0tAk15RrWEb/8oae8bSahvgt7ZAcO0+7xoyjM6POrOXrrS+buSHF9BhSLxj9g+y7dbyWSfHUQp4D112KvXKtgOR6z5PbGZHEbSjW/vC4TTFVcbCKTmvJjwkkyUHVGAZOI0fdTmaCxOK1Oqz48utstAna6Ow=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2727.namprd18.prod.outlook.com (2603:10b6:a03:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:15:24 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:15:24 +0000
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
Subject: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't kick isolated
 cpus
Thread-Topic: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't kick
 isolated cpus
Thread-Index: AQHV8kAcdftBA0b3gky17yT7q2R3yA==
Date:   Wed, 4 Mar 2020 16:15:24 +0000
Message-ID: <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f150ba4d-f5a4-4249-a0b0-08d7c0573edc
x-ms-traffictypediagnostic: BYAPR18MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2727F542DCDFA39CDA59EB49BCE50@BYAPR18MB2727.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(478600001)(4326008)(26005)(36756003)(6486002)(8676002)(6512007)(8936002)(86362001)(81156014)(6506007)(71200400001)(186003)(81166006)(2616005)(64756008)(66556008)(66476007)(54906003)(110136005)(91956017)(66946007)(4744005)(76116006)(316002)(66446008)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2727;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIiDz/6tCVG4WCa6OjakqvK8DIguoDRz0Rmd/1KZdJBF4A3SD7aGOBZHX30WoK1ROePfBSEYIiBLI6kfWb0v04QCi9L1DU+0pOpb92tkbzzVj+yCoQerb2Ex0z+F/+5SqQU7mV17nYdlj3qVh/MLZImozGknqBKOelg3k9Y42TyY8sECbcW+NShj8yaeovVV3RWYzdt9oVbWRBtki3yJ+0fpUdGzIyI0Qh8WhFnmdetE/PplriQbQ2PTVHUBNVBTAx7lvdcho6u358CArjIJ2XX+PIaSJ5PpQoWgbEnxhLhSRnH6d9fb1OVU3JXDRSLpOvGdOBtmslD7c2SqQgHXv24F6AUXMabP7rdnf67hEEPntgjC/+CKHJ+eA2jYm9PVmNgOrTCuHEUVx/AdPHnDBZiEP/C2n/MpYVqwGFMXqyPAfAURyN8uwdw4CRrsPKQ8
x-ms-exchange-antispam-messagedata: USHlLrMFHrINerK1P987LMvw1TgxqS/3LbVEm8iHKXaKSL2hBJhYxp9LAkPMEoTSV8rD3hWD4uBL88dTu+d+g9VtDaUEYLdpMA08H18kyEkkFXcG3zJYqrxb/3qBe1W8uSwE73EuqUfKmBm0QRIgug==
Content-Type: text/plain; charset="utf-8"
Content-ID: <14B15D3A246B5A4FAE528257CD802742@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f150ba4d-f5a4-4249-a0b0-08d7c0573edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:15:24.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLnq1y8LnUjR1EDEJYo0NrYCrpPmzORcQa0VK1WDQ77ulCPipqR6XycGFBmxTZZe4kAYBAFRs2MktYPN0jOUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2727
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpNYWtlIHN1cmUgdGhhdCBr
aWNrX2FsbF9jcHVzX3N5bmMoKSBkb2VzIG5vdCBjYWxsIENQVXMgdGhhdCBhcmUgcnVubmluZw0K
aXNvbGF0ZWQgdGFza3MuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXggQmVsaXRzIDxhYmVsaXRzQG1h
cnZlbGwuY29tPg0KLS0tDQoga2VybmVsL3NtcC5jIHwgMTQgKysrKysrKysrKysrKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEva2VybmVsL3NtcC5jIGIva2VybmVsL3NtcC5jDQppbmRleCAzYThiY2JkZDRjZTYuLmQ5YjRi
MmZlZGZlZCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zbXAuYw0KKysrIGIva2VybmVsL3NtcC5jDQpA
QCAtNzMxLDkgKzczMSwyMSBAQCBzdGF0aWMgdm9pZCBkb19ub3RoaW5nKHZvaWQgKnVudXNlZCkN
CiAgKi8NCiB2b2lkIGtpY2tfYWxsX2NwdXNfc3luYyh2b2lkKQ0KIHsNCisJc3RydWN0IGNwdW1h
c2sgbWFzazsNCisNCiAJLyogTWFrZSBzdXJlIHRoZSBjaGFuZ2UgaXMgdmlzaWJsZSBiZWZvcmUg
d2Uga2ljayB0aGUgY3B1cyAqLw0KIAlzbXBfbWIoKTsNCi0Jc21wX2NhbGxfZnVuY3Rpb24oZG9f
bm90aGluZywgTlVMTCwgMSk7DQorDQorCXByZWVtcHRfZGlzYWJsZSgpOw0KKyNpZmRlZiBDT05G
SUdfVEFTS19JU09MQVRJT04NCisJY3B1bWFza19jbGVhcigmbWFzayk7DQorCXRhc2tfaXNvbGF0
aW9uX2NwdW1hc2soJm1hc2spOw0KKwljcHVtYXNrX2NvbXBsZW1lbnQoJm1hc2ssICZtYXNrKTsN
CisjZWxzZQ0KKwljcHVtYXNrX3NldGFsbCgmbWFzayk7DQorI2VuZGlmDQorCXNtcF9jYWxsX2Z1
bmN0aW9uX21hbnkoJm1hc2ssIGRvX25vdGhpbmcsIE5VTEwsIDEpOw0KKwlwcmVlbXB0X2VuYWJs
ZSgpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChraWNrX2FsbF9jcHVzX3N5bmMpOw0KIA0KLS0g
DQoyLjIwLjENCg0K
