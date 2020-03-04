Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19911794A4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Mar 2020 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDQNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Mar 2020 11:13:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16520 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgCDQNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:13:05 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024G51x9008117;
        Wed, 4 Mar 2020 08:12:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=SZU4o2Y3dNifRc6zEo4hRIXQaNJIIC5FiVAv8/2ihbE=;
 b=bRueCIfi/XOSQ3/AJmgrDJo1VlKEW5M9kfRLx342pIRDbBXtYJ38LtairyK3XUo+xHLx
 9xNhHKajwtT0SZBmZO5XVfivSRvfEb2rhqsHYbLtLKBrtWRxfi70F7mDNEmTsgCycnVD
 r0oI3rWzEAuHHNNRCc3z6rxkGE6mlq6rOhhMtkTTTTQ1Mp0G8hJXqWDHrSsFZboslMQH
 eqRao0Hdl7zZcT6BH0P44yMsF1vcwzQObqKs9iBqjbQE2CB8yuUE7iaQ1ygRPvtoU0pm
 o4gjvAsHA/dcvWeVfOZQyhrfjid023GEJhN84ofPt0jxKT+OM+oZLn+IJzQ8jQ/URXGc BA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0y0ehg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 08:12:43 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 08:12:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 4 Mar 2020 08:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7XU0/ImqMHPbjwnvOgzo/ofAvey2Qimr7sToc3szbMxOjZ4UgCCbFGOxVhNybfftOVdpwZQMabVt4EqiKHPlI45yrPHQhvkYeljL4CFlN/guyXzSkRj3uVc14rzIAG3E3tI6TWX4Fv2tUnRcpbbUa2EOL+7IFTg0SWLg/zCS2A1bTXboFQyIZTSIwcOpmyftpyJOoeAirUDY/sCNDINZ9JC3U2wpHvkz58z3M5uZFS01UMeGt7oA853gT1UWGwsAhUoAaIguwF94lKWdocFzDeZQMw3zXbMVYdZti6i+I5FHPjSHgKie1EZrrhLB9IBmPXYPotf3fv1hWZ1d24vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZU4o2Y3dNifRc6zEo4hRIXQaNJIIC5FiVAv8/2ihbE=;
 b=culzDx9+pGcrCwXsjoz0K6bfd9FAwCUVxyjq+g73E/T6NNMh79I/c5fp9iYgxVWU282ie63jTaVwrCxzbhD58iNWNdvydTabU++Oy44q+c2IwYWcz9i8CiO3hVdeRKoR+XO9oe7v9CQxUkxn7GpNMHDYBxDSDs9TwddPG79J5wtkwped5U9m/dkf8AHbPTCY/InKnSmMj16zZpEd8cB6phfAOARU1FNAoE/2pZ4zizI26HbzF6uGlLP6NGs7n2vaWkja0UkoBz2uVJ+6qohYdvVl96Uqx8J+3EwkGsVXSdcpkg3/pNJDLpkfha/ugF5x7COz4FEmQEXAp0jBdWpvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZU4o2Y3dNifRc6zEo4hRIXQaNJIIC5FiVAv8/2ihbE=;
 b=XKL1cCmEpOvhaZMeTKqjWzg/0i1QmbhhSLHqL82oqnFDFyY/SZ0emoeDpbZ+9hZWXIWMeR2EvaPTav5tdwLcElTNq8j78tKO8lOHhG+AyIyRPlyOAxKqlHYaoHAxWA7oqiUXnFqi/cizB5aBZL6DE+mBbmUQAfTUYWVA6emPYLU=
Received: from BYAPR18MB2535.namprd18.prod.outlook.com (2603:10b6:a03:137::17)
 by BYAPR18MB2727.namprd18.prod.outlook.com (2603:10b6:a03:107::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 16:12:40 +0000
Received: from BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23]) by BYAPR18MB2535.namprd18.prod.outlook.com
 ([fe80::8cd1:1741:8d2d:1c23%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:12:40 +0000
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
Subject: [PATCH 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Thread-Topic: [PATCH 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Thread-Index: AQHV8j+6YdQrrVvjWUOq9zKJGSyO3w==
Date:   Wed, 4 Mar 2020 16:12:40 +0000
Message-ID: <d7ce01e57d4a35b126e1cb96a63109eaa9781cb6.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fafe9a8-cdff-45a5-ca8b-08d7c056dd0c
x-ms-traffictypediagnostic: BYAPR18MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR18MB2727FE517E908E4FD21085D5BCE50@BYAPR18MB2727.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(478600001)(4326008)(26005)(36756003)(6486002)(8676002)(6512007)(8936002)(86362001)(81156014)(6506007)(71200400001)(186003)(81166006)(2616005)(64756008)(66556008)(66476007)(54906003)(110136005)(91956017)(66946007)(4744005)(76116006)(316002)(66446008)(5660300002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2727;H:BYAPR18MB2535.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpUlBw1wE3zQB1UB8h01DUtZ+PsT8i3Sq0QdT8b7C4ejEVua88qCsfytWOsRSSbGIXi8AXurb+32WaswTCp6h1Q9tzqXe2PkzPwBv8s+QMyxsmv7kWcOyh/wsSqiR3CwA69w/9aHZbsB4dhsbh7IZXU3Yk5pHj5wslqW3T4S4TW1ydbtXqdk8b/UoJxkqeak9nq/FMDk+RXjuqEsfb0fwDoMeTfrjfbjbcXeNDAaFq1zkbuWOfvCxM6sYw4KJj0J/YRk7EJbFe2rUkBqI9ZgJnWFdIaEW2P1AbP3X8A3lCb4IugVair37Ul8dc9eMDzyLhH6NxGY/cAwQ8fPC1dgogBokYWXJiqY0Cgnf0AGbPt0dmuwN8/YcOL77Vp/81t/3cU3v9lyABGSl6barVFXpPgcbSMtJ4e5JJnsfRZvjFmAXR2SmCOcdjtDoUm5MHz4
x-ms-exchange-antispam-messagedata: woCjdRVtcli+3zEuzhwVzvtR9/QIkb/OWy577e3zYzx2gWzCKloDZmOsNYobAfFRBhAdhDukIaJhkU8iLyZVwvB217K7/A5zcaDFVFLxjr23U+PZnXP080A+YZICXCTRPAUQDkBsxn4nJYdjUlcB3Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8565AD33C6E2A4469EBC5A691FE0CC5A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fafe9a8-cdff-45a5-ca8b-08d7c056dd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 16:12:40.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiqkT/j3OgKNMazQA0JToOmPGZSeR7BuszdSYdG0ataoW11dlOgwqMx/QUS/zjzETo5V3EuQbO+rsN5d24bl/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2727
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpGb3Igbm9oel9mdWxsIENQ
VXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpcyB0byByZWNlaXZlIGludGVycnVwdHMNCmdlbmVy
YXRlZCBieSB0aWNrX25vaHpfZnVsbF9raWNrX2NwdSgpLiBCdXQgZm9yIGhhcmQgaXNvbGF0aW9u
IGl0J3MNCm9idmlvdXNseSBub3QgZGVzaXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlv
bi4NCg0KVGhpcyBwYXRjaCBhZGRzIGNoZWNrIGZvciBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQWxl
eCBCZWxpdHMgPGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBrZXJuZWwvdGltZS90aWNrLXNj
aGVkLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYyBiL2tlcm5lbC90
aW1lL3RpY2stc2NoZWQuYw0KaW5kZXggMWQ0ZGVjOWQzZWU3Li5mZTQ1MDNiYTEzMTYgMTAwNjQ0
DQotLS0gYS9rZXJuZWwvdGltZS90aWNrLXNjaGVkLmMNCisrKyBiL2tlcm5lbC90aW1lL3RpY2st
c2NoZWQuYw0KQEAgLTIwLDYgKzIwLDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2NoZWQvY2xvY2su
aD4NCiAjaW5jbHVkZSA8bGludXgvc2NoZWQvc3RhdC5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC9ub2h6Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcG9zaXgtdGltZXJzLmg+DQpAQCAtMjYyLDcgKzI2Myw3IEBAIHN0YXRpYyB2b2lkIHRpY2tf
bm9oel9mdWxsX2tpY2sodm9pZCkNCiAgKi8NCiB2b2lkIHRpY2tfbm9oel9mdWxsX2tpY2tfY3B1
KGludCBjcHUpDQogew0KLQlpZiAoIXRpY2tfbm9oel9mdWxsX2NwdShjcHUpKQ0KKwlpZiAoIXRp
Y2tfbm9oel9mdWxsX2NwdShjcHUpIHx8IHRhc2tfaXNvbGF0aW9uX29uX2NwdShjcHUpKQ0KIAkJ
cmV0dXJuOw0KIA0KIAlpcnFfd29ya19xdWV1ZV9vbigmcGVyX2NwdShub2h6X2Z1bGxfa2lja193
b3JrLCBjcHUpLCBjcHUpOw0KLS0gDQoyLjIwLjENCg0K
