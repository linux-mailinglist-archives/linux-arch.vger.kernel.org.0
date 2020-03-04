Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5691794AD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDQN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:13:58 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50422 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgCDQN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:13:58 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G54tn008170;
        Wed, 4 Mar 2020 08:13:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=vbdbXD6Bwvm/bFD/nJ248UyXbmnxQxWO/BA2xn9lGc0=;
 b=SuHKEEUUGbpGt5cd+qzUFlBoMQKa6vHb2GpRu4V2VOq+FxLgWBMfeHydXf9l99MoAw9v
 myGDGq7I/yau8h5Coq9uJF8Si4vGm+lP9OtRBa2bHc362KgiT33H6bHLmf3scU58uHnT
 Y/ni0xknvWx5TVeGfJFrL+tXcu0izaiWb4hxuVYSz2HlHIYtYYOTllww+Nznzhd+5Ttc
 CuI1D2SndK8TYWoKMWh84Ur6vKbAwsKUth3F/jzyPEnnregvKOUn8mNa/muuiIsqdDkc
 Jxwz7rn2uKUPyIkORQXtujqjJ5x3DqIcowfyslDHA25vGzyVftQQEaNznP/zbuQbzBn1 ng== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0y0er1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:13:36 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:13:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1zEDu4pgZfTtS8Sy/ny004OuZQGCK1vJQaCGu7PHFexsa+7NYj+Fh48djt9qQ1iIeJ2g9Wz50MclCtJzDBGU2ULlVtdmI1XNURlgqVmkMIYvKFU0jLd48C1Vuxp1tivIj7esajd6juAkn6l9pTJ6PQ02T6nQLzMPYwjNhZKlrfz7//mMH472Mux9zMQG1XnzEKgiw/VRYHtqb4jpUyR668eU1YcNFdhPxPtZGLbpito7QC97qGDfkVc11ZcJFizg8qfqg3aR4DcmrHCY3qftWzBaj/QunNyaB8LBUjeslCGQP/WxcorW+vTg72iFbVqkfXh1lZqt5ooJSRyA41JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbdbXD6Bwvm/bFD/nJ248UyXbmnxQxWO/BA2xn9lGc0=;
 b=ZY/fZLMABpW8dQFLmNMq3lT4kOR+lNgnvnOa9/Mvx2TLrhylyU/kWuzWNHiR08vRaz/x9esrHhY+d5h4dTE5btId6VJ4jfwojzzD8LVq+J0uoUNgNirwrdQJVFsBq+QJ6XbX99bIsihEjq3Iv6ZWtQq7inshFV97jiHJV6WqfxcuiPk4rERgTxBr8+p6XbXPZzZzBDdctfa8zWQcITpCj1rDAEPdcn41Me1x3bfGE7K5cntF8UmaOfajt+R/Cb9Ozz1IvLsJvLAs4nXqC8/rmgJaaMjN99i8d0SpbnTqc662XJeYsjSCai3lSMNkQvouzM1NKc29hnGwHHimcW881Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbdbXD6Bwvm/bFD/nJ248UyXbmnxQxWO/BA2xn9lGc0=;
 b=m0DH40kpJ3sJ3M543/F5gklkoTpHco7ix53rO456CRCf0iq8HX08eryAfndS+dtWi6VZjK3LhZnftVFkSNJGPwKhJT8w+onY9CDNp7K/NHTLo6fTppkzs5WnX/DisQynmbP4UXmS2b/j5diSoYK7ZkTKgSAsW47H2zta3reHoxU=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2727.namprd18.prod.outlook.com (2603:10b6:a03:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:13:33 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:13:33 +0000
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
Subject: [PATCH 09/12] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Thread-Topic: [PATCH 09/12] task_isolation: net: don't flush backlog on CPUs
 running isolated tasks
Thread-Index: AQHV8j/ZELDwdTDMWky5I+gAZoA3aQ==
Date:   Wed, 4 Mar 2020 16:13:32 +0000
Message-ID: <fe14905b3ba8501d0120c29483fc2780a2b86517.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d74235-bd45-4813-7a31-08d7c056fc71
x-ms-traffictypediagnostic: BYAPR18MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2727AD16241A0EC8B825ECFCBCE50@BYAPR18MB2727.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(498600001)(4326008)(26005)(36756003)(6486002)(8676002)(6512007)(8936002)(86362001)(81156014)(6506007)(71200400001)(186003)(81166006)(2616005)(64756008)(66556008)(66476007)(54906003)(110136005)(91956017)(66946007)(4744005)(76116006)(66446008)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2727;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptr+3+pCl5d7Fd007hNnbSmsCQudR/fR6R7WwTIWVXA+OYfvuY9wGX+m8kitMUQ5bMwCe6vWwQrhqEQWg8K2ytwsS5SMoQV6qSTUILTZ8QqggtvB0NBdY8UV+CZ72dw10cZ9Xmr/4PwNggYsFJ7QOQVAPWQQwj7nrMpdkY7iB0IULfMv6XFHXMWJmx5fNWww9G4SD/1wKgaeXxqpHIvUNcRkBUI/A+GffqO1VjgGbuIRJGv7rw8At+YhPIjjWt6CjWmNeNAC5tt7S2SpEE2UphW8m1IQ2X1VK2fiRaGMNQhTWJwIcwgqzq2M0aOYA0HZ8ybywAk1mdsZIqta5XuiSft0jT82b36NnoGuCcIrcQPHRew4bPn3uBBcfA9D2DOzLAZvcl9fguErrHwm3FI25PNGEaie3e9JPtB+JlRpSxAwARm/zydV8TUd/LZkmu8K
x-ms-exchange-antispam-messagedata: 60L8/BFzpVJjFIc+JWGBgTauogNA9Fk7/raR20aKhnBubzLrD+Q5IVVDQditYQivsT7fAB9tmEBugMtoR1dMRlzCvkyDahq8IzzVgicBOitxbsymphXiIk3ViEDmlyset1+Wsqewa7M2e7T/zD3nDQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <35F281CA22FE5D4C8E7A7D853F5CF0C5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d74235-bd45-4813-7a31-08d7c056fc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:13:32.8861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RAUs7BVDHgEH4t8TcFga1DpLzy2ebUQqQ50jh6lQwXs/IQ69KtBZSyHasl6Myeptm0oWj6Yer02srQ7VZ5qAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2727
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpJZiBDUFUgcnVucyBpc29s
YXRlZCB0YXNrLCB0aGVyZSdzIG5vIGFueSBiYWNrbG9nIG9uIGl0LCBhbmQNCnNvIHdlIGRvbid0
IG5lZWQgdG8gZmx1c2ggaXQuIEN1cnJlbnRseSBmbHVzaF9hbGxfYmFja2xvZ3MoKQ0KZW5xdWV1
ZXMgY29ycmVzcG9uZGluZyB3b3JrIG9uIGFsbCBDUFVzIGluY2x1ZGluZyBvbmVzIHRoYXQgcnVu
DQppc29sYXRlZCB0YXNrcy4gSXQgbGVhZHMgdG8gYnJlYWtpbmcgdGFzayBpc29sYXRpb24gZm9y
IG5vdGhpbmcuDQoNCkluIHRoaXMgcGF0Y2gsIGJhY2tsb2cgZmx1c2hpbmcgaXMgZW5xdWV1ZWQg
b25seSBvbiBub24taXNvbGF0ZWQgQ1BVcy4NCg0KU2lnbmVkLW9mZi1ieTogQWxleCBCZWxpdHMg
PGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBuZXQvY29yZS9kZXYuYyB8IDYgKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYw0KaW5kZXggYzZjOTg1ZmU3YjFi
Li42ZDMyYWJiMWYwNmQgMTAwNjQ0DQotLS0gYS9uZXQvY29yZS9kZXYuYw0KKysrIGIvbmV0L2Nv
cmUvZGV2LmMNCkBAIC03NCw2ICs3NCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KICNp
bmNsdWRlIDxsaW51eC90eXBlcy5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCisjaW5j
bHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1ZGUgPGxpbnV4L2hhc2guaD4NCiAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KQEAgLTU1MTgs
OSArNTUxOSwxMiBAQCBzdGF0aWMgdm9pZCBmbHVzaF9hbGxfYmFja2xvZ3Modm9pZCkNCiANCiAJ
Z2V0X29ubGluZV9jcHVzKCk7DQogDQotCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQ0KKwlmb3Jf
ZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KKwkJaWYgKHRhc2tfaXNvbGF0aW9uX29uX2NwdShjcHUp
KQ0KKwkJCWNvbnRpbnVlOw0KIAkJcXVldWVfd29ya19vbihjcHUsIHN5c3RlbV9oaWdocHJpX3dx
LA0KIAkJCSAgICAgIHBlcl9jcHVfcHRyKCZmbHVzaF93b3JrcywgY3B1KSk7DQorCX0NCiANCiAJ
Zm9yX2VhY2hfb25saW5lX2NwdShjcHUpDQogCQlmbHVzaF93b3JrKHBlcl9jcHVfcHRyKCZmbHVz
aF93b3JrcywgY3B1KSk7DQotLSANCjIuMjAuMQ0KDQo=
