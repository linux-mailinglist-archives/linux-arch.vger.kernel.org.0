Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722105E354
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCL6Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 07:58:25 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:61372 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfGCL6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 07:58:24 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63Bt09a026724;
        Wed, 3 Jul 2019 04:58:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=7Fv0VG5SSm+s3bd+HZk4c05+u0Iyu4jTk/vjl0mx7mM=;
 b=bM+AKOe5U2EYvh6JtLsWBD556s3qCXGMk7LFkLCGzsa/hGTxEoarY8jZ+gzJJifJRMjU
 BC9oEja7c00LW4JKXEHmLY8ffBNHeD/sxKCjm1dzRmUCRty1Ruyg2ARomVR4Zd5m+nwx
 p/AZ7ASKN/rFXknF1LazdoLhovUKcVeI4Tl7rFmi/KaFLukNv8u5dRJYQ7QLa9kuXsIB
 7bI4YbbyIpYPf2nHqSj43/Wt8R1URWVaacsopyOSG+iVSiAf/BWfEWAcqOMTOxn24AAZ
 mYbn580TAK8aMnth7N93D8XUxnrrkDBgUlw3CZUCF7QA01njy0mbRtyB593Z0V1jVQH9 WQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tgrv18qj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 04:58:22 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 3 Jul
 2019 04:58:21 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 3 Jul 2019 04:58:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fv0VG5SSm+s3bd+HZk4c05+u0Iyu4jTk/vjl0mx7mM=;
 b=GDd54pFkLV9tjN0pIACvii+iLc2sMIdPAOEFEe/xqX2oOMWQ5G7eKbooIuCEHhfUc3m3CSbOkkBmLXViV5LZItOUOqwSRrxyeDiu7tB2RfB1R33u3c7Fr8MgwipGteJWahSVSIPtSm7hnXl5ZZpGGYPjL26T6ZcfpxcEqRBoyy0=
Received: from BL0PR18MB2339.namprd18.prod.outlook.com (52.132.30.139) by
 BL0PR18MB2258.namprd18.prod.outlook.com (52.132.30.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Wed, 3 Jul 2019 11:58:11 +0000
Received: from BL0PR18MB2339.namprd18.prod.outlook.com
 ([fe80::430:a80b:100e:f333]) by BL0PR18MB2339.namprd18.prod.outlook.com
 ([fe80::430:a80b:100e:f333%3]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 11:58:11 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Alex Kogan <alex.kogan@oracle.com>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "dave.dice@oracle.com" <dave.dice@oracle.com>,
        "rahul.x.yadav@oracle.com" <rahul.x.yadav@oracle.com>
Subject: Re: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
Thread-Topic: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
Thread-Index: AQHVMZV8Ybm4k+/XekihBdJkMbnADw==
Date:   Wed, 3 Jul 2019 11:58:11 +0000
Message-ID: <CAEiAFz238Ywgn6iDAz9gM_3PgPhs-YuAVDptehUBv7MRRPx8Cw@mail.gmail.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0050.eurprd09.prod.outlook.com
 (2603:10a6:3:45::18) To BL0PR18MB2339.namprd18.prod.outlook.com
 (2603:10b6:207:44::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAX6ZqUOATr2jyA3JrXRCmRtuaj5UYjsy+lTOXVpFQT3BccyeNQA
        ue+ygWBdeXifaSfioQ9eE8K5UT4TbAhjwzh6G2A=
x-google-smtp-source: APXvYqyuwkmwHuWs/zk31Xg3Lr0aqtta+9e2gekCu7t9V2nQEduDWodzih6Lza+B9cu85LLSsIR5XwAVjLA2VYgrUQs=
x-received: by 2002:ac2:5212:: with SMTP id a18mr17620705lfl.50.1562154631397;
 Wed, 03 Jul 2019 04:50:31 -0700 (PDT)
x-gmail-original-message-id: <CAEiAFz238Ywgn6iDAz9gM_3PgPhs-YuAVDptehUBv7MRRPx8Cw@mail.gmail.com>
x-originating-ip: [209.85.167.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd5f3996-0480-4dc4-bac7-08d6ffadb879
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR18MB2258;
x-ms-traffictypediagnostic: BL0PR18MB2258:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR18MB22582FB782F80189A8CC2EFFD8FB0@BL0PR18MB2258.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(14454004)(305945005)(61266001)(6486002)(446003)(3846002)(26005)(476003)(66066001)(6116002)(81156014)(81166006)(68736007)(6306002)(316002)(61726006)(52116002)(229853002)(498394004)(54906003)(6436002)(102836004)(386003)(6506007)(53936002)(99286004)(9686003)(6512007)(11346002)(95326003)(966005)(86362001)(76176011)(6246003)(7736002)(486006)(2906002)(8676002)(14444005)(5660300002)(478600001)(256004)(66574012)(66476007)(107886003)(73956011)(450100002)(25786009)(66446008)(64756008)(66556008)(4326008)(6862004)(66946007)(71190400001)(71200400001)(186003)(8936002)(55446002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2258;H:BL0PR18MB2339.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7SPSwTlHH2tIgBnX+GZcjzCI3k1BAXHXurZ2iNnhXuRcy9tICMm1arJuUSoCcvWOM1zQxyeXeaCnKdSIiwBu9tE6yCbsXSvxZtjgPXKnWd1MFb9+eU9rcrsiqxkM7pMTIHBJ4E7VC2R3ocr45AMJCzkE21Ml081GcxLuGQrCpC16ery1V932/AqA89nI/BoNBPjB2IFxpl546OWsk1hPhoNovLG44krwHf/A3o0pnhm+QSNIgAmkhOsH3Bky1wGRojuy4p1iORXLOYaY9TYVK1DwhgxeLHdb6Ba/vP2YVOe3vtrA0QmrxepLhZ2qCJLZKTIBdyCPyntg5w/d1blxubZMo0uYclt+188TZ5HSlz/U9iSKvl0/0r0Ni5PQaPJEy9yckEI0M2T2QVDft31neHVdhAhT/RvQd/yKJNkE8C8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8618D8E8C9EDB64B8668D41F2E521ECB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5f3996-0480-4dc4-bac7-08d6ffadb879
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 11:58:11.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jglauber@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2258
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgQWxleCwNCkkndmUgdHJpZWQgdGhpcyBzZXJpZXMgb24gYXJtNjQgKFRodW5kZXJYMiB3aXRo
IHVwIHRvIFNNVD00ICBhbmQgMjI0IENQVXMpDQp3aXRoIHRoZSBib3JkZXJsaW5lIHRlc3RjYXNl
IG9mIGFjY2Vzc2luZyBhIHNpbmdsZSBmaWxlIGZyb20gYWxsDQp0aHJlYWRzLiBXaXRoIHRoYXQN
CnRlc3RjYXNlIHRoZSBxc3BpbmxvY2sgc2xvd3BhdGggaXMgdGhlIHRvcCBzcG90IGluIHRoZSBr
ZXJuZWwuDQoNClRoZSByZXN1bHRzIGxvb2sgcmVhbGx5IHByb21pc2luZzoNCg0KQ1BVcyAgICBu
b3JtYWwgICAgbnVtYS1xc3BpbmxvY2tzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCjU2ICAgICAgICAxNDkuNDEgICAgICAgICAgNzMuOTANCjIyNCAgICAg
IDU3Ni45NSAgICAgICAgICAyOTAuMzENCg0KQWxzbyBmcm9udGVuZC1zdGFsbHMgYXJlIHJlZHVj
ZWQgdG8gNTAlIGFuZCBpbnRlcmNvbm5lY3QgdHJhZmZpYyBpcw0KZ3JlYXRseSByZWR1Y2VkLg0K
VGVzdGVkLWJ5OiBKYW4gR2xhdWJlciA8amdsYXViZXJAbWFydmVsbC5jb20+DQoNCi0tSmFuDQoN
CkFtIEZyLiwgMjkuIE3DpHJ6IDIwMTkgdW0gMTY6MjMgVWhyIHNjaHJpZWIgQWxleCBLb2dhbiA8
YWxleC5rb2dhbkBvcmFjbGUuY29tPjoNCj4NCj4gVGhpcyB2ZXJzaW9uIGFkZHJlc3NlcyBmZWVk
YmFjayBmcm9tIFBldGVyIGFuZCBXYWltYW4uIEluIHBhcnRpY3VsYXIsDQo+IHRoZSBDTkEgZnVu
Y3Rpb25hbGl0eSBoYXMgYmVlbiBtb3ZlZCB0byBhIHNlcGFyYXRlIGZpbGUsIGFuZCBpcyBjb250
cm9sbGVkDQo+IGJ5IGEgY29uZmlnIG9wdGlvbiAoZW5hYmxlZCBieSBkZWZhdWx0IGlmIE5VTUEg
aXMgZW5hYmxlZCkuDQo+IEFuIG9wdGltaXphdGlvbiBoYXMgYmVlbiBpbnRyb2R1Y2VkIHRvIHJl
ZHVjZSB0aGUgb3ZlcmhlYWQgb2Ygc2h1ZmZsaW5nDQo+IHRocmVhZHMgYmV0d2VlbiB3YWl0aW5n
IHF1ZXVlcyB3aGVuIHRoZSBsb2NrIGlzIG9ubHkgbGlnaHRseSBjb250ZW5kZWQuDQo+DQo+IFN1
bW1hcnkNCj4gLS0tLS0tLQ0KPg0KPiBMb2NrIHRocm91Z2hwdXQgY2FuIGJlIGluY3JlYXNlZCBi
eSBoYW5kaW5nIGEgbG9jayB0byBhIHdhaXRlciBvbiB0aGUNCj4gc2FtZSBOVU1BIG5vZGUgYXMg
dGhlIGxvY2sgaG9sZGVyLCBwcm92aWRlZCBjYXJlIGlzIHRha2VuIHRvIGF2b2lkDQo+IHN0YXJ2
YXRpb24gb2Ygd2FpdGVycyBvbiBvdGhlciBOVU1BIG5vZGVzLiBUaGlzIHBhdGNoIGludHJvZHVj
ZXMgQ05BDQo+IChjb21wYWN0IE5VTUEtYXdhcmUgbG9jaykgYXMgdGhlIHNsb3cgcGF0aCBmb3Ig
cXNwaW5sb2NrLiBJdCBjYW4gYmUNCj4gZW5hYmxlZCB0aHJvdWdoIGEgY29uZmlndXJhdGlvbiBv
cHRpb24gKE5VTUFfQVdBUkVfU1BJTkxPQ0tTKS4NCj4NCj4gQ05BIGlzIGEgTlVNQS1hd2FyZSB2
ZXJzaW9uIG9mIHRoZSBNQ1Mgc3Bpbi1sb2NrLiBTcGlubmluZyB0aHJlYWRzIGFyZQ0KPiBvcmdh
bml6ZWQgaW4gdHdvIHF1ZXVlcywgYSBtYWluIHF1ZXVlIGZvciB0aHJlYWRzIHJ1bm5pbmcgb24g
dGhlIHNhbWUNCj4gbm9kZSBhcyB0aGUgY3VycmVudCBsb2NrIGhvbGRlciwgYW5kIGEgc2Vjb25k
YXJ5IHF1ZXVlIGZvciB0aHJlYWRzDQo+IHJ1bm5pbmcgb24gb3RoZXIgbm9kZXMuIFRocmVhZHMg
c3RvcmUgdGhlIElEIG9mIHRoZSBub2RlIG9uIHdoaWNoDQo+IHRoZXkgYXJlIHJ1bm5pbmcgaW4g
dGhlaXIgcXVldWUgbm9kZXMuIEF0IHRoZSB1bmxvY2sgdGltZSwgdGhlIGxvY2sNCj4gaG9sZGVy
IHNjYW5zIHRoZSBtYWluIHF1ZXVlIGxvb2tpbmcgZm9yIGEgdGhyZWFkIHJ1bm5pbmcgb24gdGhl
IHNhbWUNCj4gbm9kZS4gSWYgZm91bmQgKGNhbGwgaXQgdGhyZWFkIFQpLCBhbGwgdGhyZWFkcyBp
biB0aGUgbWFpbiBxdWV1ZQ0KPiBiZXR3ZWVuIHRoZSBjdXJyZW50IGxvY2sgaG9sZGVyIGFuZCBU
IGFyZSBtb3ZlZCB0byB0aGUgZW5kIG9mIHRoZQ0KPiBzZWNvbmRhcnkgcXVldWUsIGFuZCB0aGUg
bG9jayBpcyBwYXNzZWQgdG8gVC4gSWYgc3VjaCBUIGlzIG5vdCBmb3VuZCwgdGhlDQo+IGxvY2sg
aXMgcGFzc2VkIHRvIHRoZSBmaXJzdCBub2RlIGluIHRoZSBzZWNvbmRhcnkgcXVldWUuIEZpbmFs
bHksIGlmIHRoZQ0KPiBzZWNvbmRhcnkgcXVldWUgaXMgZW1wdHksIHRoZSBsb2NrIGlzIHBhc3Nl
ZCB0byB0aGUgbmV4dCB0aHJlYWQgaW4gdGhlDQo+IG1haW4gcXVldWUuIFRvIGF2b2lkIHN0YXJ2
YXRpb24gb2YgdGhyZWFkcyBpbiB0aGUgc2Vjb25kYXJ5IHF1ZXVlLA0KPiB0aG9zZSB0aHJlYWRz
IGFyZSBtb3ZlZCBiYWNrIHRvIHRoZSBoZWFkIG9mIHRoZSBtYWluIHF1ZXVlDQo+IGFmdGVyIGEg
Y2VydGFpbiBleHBlY3RlZCBudW1iZXIgb2YgaW50cmEtbm9kZSBsb2NrIGhhbmQtb2Zmcy4NCj4N
Cj4gTW9yZSBkZXRhaWxzIGFyZSBhdmFpbGFibGUgYXQgaHR0cHM6Ly9hcnhpdi5vcmcvYWJzLzE4
MTAuMDU2MDAuDQo+DQo+IFdlIGhhdmUgZG9uZSBzb21lIHBlcmZvcm1hbmNlIGV2YWx1YXRpb24g
d2l0aCB0aGUgbG9ja3RvcnR1cmUgbW9kdWxlDQo+IGFzIHdlbGwgYXMgd2l0aCBzZXZlcmFsIGJl
bmNobWFya3MgZnJvbSB0aGUgd2lsbC1pdC1zY2FsZSByZXBvLg0KPiBUaGUgZm9sbG93aW5nIGxv
Y2t0b3J0dXJlIHJlc3VsdHMgYXJlIGZyb20gYW4gT3JhY2xlIFg1LTQgc2VydmVyDQo+IChmb3Vy
IEludGVsIFhlb24gRTctODg5NSB2MyBAIDIuNjBHSHogc29ja2V0cyB3aXRoIDE4IGh5cGVydGhy
ZWFkZWQNCj4gY29yZXMgZWFjaCkuIEVhY2ggbnVtYmVyIHJlcHJlc2VudHMgYW4gYXZlcmFnZSAo
b3ZlciAyNSBydW5zKSBvZiB0aGUNCj4gdG90YWwgbnVtYmVyIG9mIG9wcyAoeDEwXjcpIHJlcG9y
dGVkIGF0IHRoZSBlbmQgb2YgZWFjaCBydW4uIFRoZQ0KPiBzdGFuZGFyZCBkZXZpYXRpb24gaXMg
YWxzbyByZXBvcnRlZCBpbiAoKSwgYW5kIGluIGdlbmVyYWwsIHdpdGggYSBmZXcNCj4gZXhjZXB0
aW9ucywgaXMgYWJvdXQgMyUuIFRoZSAnc3RvY2snIGtlcm5lbCBpcyB2NS4wLXJjOCwNCj4gY29t
bWl0IDI4ZDQ5ZTI4MjY2NSAoImxvY2tpbmcvbG9ja2RlcDogU2hyaW5rIHN0cnVjdCBsb2NrX2Ns
YXNzX2tleSIpLA0KPiBjb21waWxlZCBpbiB0aGUgZGVmYXVsdCBjb25maWd1cmF0aW9uLiAncGF0
Y2gnIGlzIHRoZSBtb2RpZmllZA0KPiBrZXJuZWwgY29tcGlsZWQgd2l0aCBOVU1BX0FXQVJFX1NQ
SU5MT0NLUyBub3Qgc2V0OyBpdCBpcyBpbmNsdWRlZCB0byBzaG93DQo+IHRoYXQgYW55IHBlcmZv
cm1hbmNlIGNoYW5nZXMgdG8gdGhlIGV4aXN0aW5nIHFzcGlubG9jayBpbXBsZW1lbnRhdGlvbiBh
cmUNCj4gZXNzZW50aWFsbHkgbm9pc2UuICdwYXRjaC1DTkEnIGlzIHRoZSBtb2RpZmllZCBrZXJu
ZWwgd2l0aA0KPiBOVU1BX0FXQVJFX1NQSU5MT0NLUyBzZXQ7IHRoZSBzcGVlZHVwIGlzIGNhbGN1
bGF0ZWQgZGl2aWRpbmcNCj4gJ3BhdGNoLUNOQScgYnkgJ3N0b2NrJy4NCj4NCj4gI3RociAgICAg
c3RvY2sgICAgICAgICAgcGF0Y2ggICAgICAgIHBhdGNoLUNOQSAgIHNwZWVkdXAgKHBhdGNoLUNO
QS9zdG9jaykNCj4gICAxICAyLjczMSAoMC4xMDIpICAyLjczMiAoMC4wOTMpICAgMi43MTYgKDAu
MDgyKSAgMC45OTUNCj4gICAyICAzLjA3MSAoMC4xMjQpICAzLjA4NCAoMC4xMDkpICAgMy4wNzkg
KDAuMTEzKSAgMS4wMDMNCj4gICA0ICA0LjIyMSAoMC4xMzgpICA0LjIyOSAoMC4wODcpICAgNC40
MDggKDAuMTAzKSAgMS4wNDQNCj4gICA4ICA1LjM2NiAoMC4xNTQpICA1LjI3NCAoMC4wOTQpICAg
Ni45NTggKDAuMjMzKSAgMS4yOTcNCj4gIDE2ICA2LjY3MyAoMC4xNjQpICA2LjY4OSAoMC4wOTUp
ICAgOC41NDcgKDAuMTQ1KSAgMS4yODENCj4gIDMyICA3LjM2NSAoMC4xNzcpICA3LjM1MyAoMC4x
ODMpICAgOS4zMDUgKDAuMjAyKSAgMS4yNjMNCj4gIDM2ICA3LjQ3MyAoMC4xOTgpICA3LjQyMiAo
MC4xODEpICAgOS40NDEgKDAuMTk2KSAgMS4yNjMNCj4gIDcyICA2LjgwNSAoMC4xODIpICA2LjY5
OSAoMC4xNzApICAxMC4wMjAgKDAuMjE4KSAgMS40NzINCj4gMTA4ICA2LjUwOSAoMC4wODIpICA2
LjQ4MCAoMC4xMTUpICAxMC4wMjcgKDAuMTk0KSAgMS41NDANCj4gMTQyICA2LjIyMyAoMC4xMDkp
ICA2LjI5NCAoMC4xMDApICAgOS44NzQgKDAuMTgzKSAgMS41ODcNCj4NCj4gVGhlIGZvbGxvd2lu
ZyB0YWJsZXMgY29udGFpbiB0aHJvdWdocHV0IHJlc3VsdHMgKG9wcy91cykgZnJvbSB0aGUgc2Ft
ZQ0KPiBzZXR1cCBmb3Igd2lsbC1pdC1zY2FsZS9vcGVuMV90aHJlYWRzOg0KPg0KPiAjdGhyICAg
ICBzdG9jayAgICAgICAgICBwYXRjaCAgICAgICAgcGF0Y2gtQ05BICAgc3BlZWR1cCAocGF0Y2gt
Q05BL3N0b2NrKQ0KPiAgIDEgIDAuNTY1ICgwLjAwNCkgIDAuNTY3ICgwLjAwMSkgIDAuNTY1ICgw
LjAwMykgIDAuOTk5DQo+ICAgMiAgMC44OTIgKDAuMDIxKSAgMC44OTkgKDAuMDIyKSAgMC45MDAg
KDAuMDE4KSAgMS4wMDkNCj4gICA0ICAxLjUwMyAoMC4wMzEpICAxLjUyNyAoMC4wMzgpICAxLjQ4
MSAoMC4wMjUpICAwLjk4NQ0KPiAgIDggIDEuNzU1ICgwLjEwNSkgIDEuNzE0ICgwLjA3OSkgIDEu
NjgzICgwLjEwNikgIDAuOTU5DQo+ICAxNiAgMS43NDAgKDAuMDk1KSAgMS43NTIgKDAuMDg3KSAg
MS42OTMgKDAuMDk4KSAgMC45NzMNCj4gIDMyICAwLjg4NCAoMC4wODApICAwLjkwOCAoMC4wOTAp
ICAxLjY4NiAoMC4wOTIpICAxLjkwNg0KPiAgMzYgIDAuOTA3ICgwLjA5NSkgIDAuODk0ICgwLjA4
OCkgIDEuNzA5ICgwLjA4MSkgIDEuODg1DQo+ICA3MiAgMC44NTYgKDAuMDQxKSAgMC44NTggKDAu
MDQzKSAgMS43MDcgKDAuMDgyKSAgMS45OTQNCj4gMTA4ICAwLjg1OCAoMC4wMzkpICAwLjg2OSAo
MC4wMzcpICAxLjczMiAoMC4wNzYpICAyLjAyMA0KPiAxNDIgIDAuODA5ICgwLjA0NCkgIDAuODU0
ICgwLjA0NCkgIDEuNzI4ICgwLjA4MykgIDIuMTM1DQo+DQo+IGFuZCB3aWxsLWl0LXNjYWxlL2xv
Y2syX3RocmVhZHM6DQo+DQo+ICN0aHIgICAgIHN0b2NrICAgICAgICAgIHBhdGNoICAgICAgICBw
YXRjaC1DTkEgICBzcGVlZHVwIChwYXRjaC1DTkEvc3RvY2spDQo+ICAgMSAgMS43MTMgKDAuMDA0
KSAgMS43MTUgKDAuMDA0KSAgMS43MTEgKDAuMDA0KSAgMC45OTkNCj4gICAyICAyLjg4OSAoMC4w
NTcpICAyLjg2NCAoMC4wNzgpICAyLjg3NiAoMC4wNjYpICAwLjk5NQ0KPiAgIDQgIDQuNTgyICgx
LjAzMikgIDUuMDY2ICgwLjc4NykgIDQuNzI1ICgwLjk1OSkgIDEuMDMxDQo+ICAgOCAgNC4yMjcg
KDAuMTk2KSAgNC4xMDQgKDAuMjc0KSAgNC4wOTIgKDAuMzY1KSAgMC45NjgNCj4gIDE2ICA0LjEw
OCAoMC4xNDEpICA0LjA1NyAoMC4xMzgpICA0LjAxMCAoMC4xNjgpICAwLjk3Ng0KPiAgMzIgIDIu
Njc0ICgwLjEyNSkgIDIuNjI1ICgwLjE3MSkgIDMuOTU4ICgwLjE1NikgIDEuNDgwDQo+ICAzNiAg
Mi42MjIgKDAuMTA3KSAgMi41NTMgKDAuMTUwKSAgMy45NzggKDAuMTE2KSAgMS41MTcNCj4gIDcy
ICAyLjAwOSAoMC4wOTApICAxLjk5OCAoMC4wOTIpICAzLjkzMiAoMC4xMTQpICAxLjk1Nw0KPiAx
MDggIDIuMTU0ICgwLjA2OSkgIDIuMDg5ICgwLjA5MCkgIDMuODcwICgwLjA4MSkgIDEuNzk3DQo+
IDE0MiAgMS45NTMgKDAuMTA2KSAgMS45NDMgKDAuMTExKSAgMy44NTMgKDAuMTAwKSAgMS45NzMN
Cj4NCj4gRnVydGhlciBjb21tZW50cyBhcmUgd2VsY29tZSBhbmQgYXBwcmVjaWF0ZWQuDQo+DQo+
IEFsZXggS29nYW4gKDUpOg0KPiAgIGxvY2tpbmcvcXNwaW5sb2NrOiBNYWtlIGFyY2hfbWNzX3Nw
aW5fdW5sb2NrX2NvbnRlbmRlZCBtb3JlIGdlbmVyaWMNCj4gICBsb2NraW5nL3FzcGlubG9jazog
UmVmYWN0b3IgdGhlIHFzcGlubG9jayBzbG93IHBhdGgNCj4gICBsb2NraW5nL3FzcGlubG9jazog
SW50cm9kdWNlIENOQSBpbnRvIHRoZSBzbG93IHBhdGggb2YgcXNwaW5sb2NrDQo+ICAgbG9ja2lu
Zy9xc3BpbmxvY2s6IEludHJvZHVjZSBzdGFydmF0aW9uIGF2b2lkYW5jZSBpbnRvIENOQQ0KPiAg
IGxvY2tpbmcvcXNwaW5sb2NrOiBJbnRyb2R1Y2UgdGhlIHNodWZmbGUgcmVkdWN0aW9uIG9wdGlt
aXphdGlvbiBpbnRvDQo+ICAgICBDTkENCj4NCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL21jc19z
cGlubG9jay5oICAgfCAgIDQgKy0NCj4gIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTQgKysNCj4gIGluY2x1ZGUvYXNtLWdlbmVyaWMvcXNwaW5sb2NrX3R5cGVzLmgg
fCAgMTMgKysNCj4gIGtlcm5lbC9sb2NraW5nL21jc19zcGlubG9jay5oICAgICAgICAgfCAgMTYg
KystDQo+ICBrZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyAgICAgICAgICAgIHwgIDc3ICsrKysr
KysrKy0tDQo+ICBrZXJuZWwvbG9ja2luZy9xc3BpbmxvY2tfY25hLmggICAgICAgIHwgMjQ1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMzU0
IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGtl
cm5lbC9sb2NraW5nL3FzcGlubG9ja19jbmEuaA0KPg0KPiAtLQ0KPiAyLjExLjAgKEFwcGxlIEdp
dC04MSkNCj4NCg==
