Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A524AF936D
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfKLO4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 09:56:54 -0500
Received: from mail-eopbgr1310088.outbound.protection.outlook.com ([40.107.131.88]:3520
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbfKLO4y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 09:56:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBbYJMtH5kCysrEV0d40nnltSUpGIfk/FFqjaX5k3OjQ0XyVIjln/NSjA20vRCIuAyTjcE38N8ktEI4zciaiJFUGQtTz62YxHWHZ3bULP7ZCv0beHztwZ2bYFOOzocpzi8N6+jl4e7jjbsbacwNxNhNuQMlddaZSaqv3QFkr2OpPd9GfaXgeP+y2SH9pFkdG5fH/GHedTE8z4rxuIIRM+t0bmPkFkALLPmTE4DbQ5vEFdzqYzP8iJt61nmVsNtQDcJx3qzbfM4P1k8YRggD/dHfe+WeLmp9ur8EACHXMa4lKaSSgZUozcH6RRSyyXcZKYSY22Ahq8LwfH4PlZgt/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJk0GU250nrR5/HeqLoiSSgrZSiNRxwQgrPt8ZNvfv8=;
 b=JppLNnL6IwtUWgnkrnxSQeHnV5X4NATxqnV4z+2FlI2+Uc4E690+Eiaq9H/WUov0ojJFonQo1RCGPjuI/1Lv29FX97+1GixXiQxyz1DoN3hcFeKyJmVPC7ZWuEmVs+ZxdWM7sLG9T6rXHSLcXasTKsdNAqxn8HrFyoJMB70dwTZ3tIZzJWBMTo6ZU+5b6BLD+F7wAs5xLjvAPhR9mt/y2YbHkFnRVQvJmlbuDsHjQI9pZbxpHjAWgXlxldaGXFldtSykgxZCO+CpPxNs+hR6cEpEz4/bYzaAyZd6o02RvPYeHJKKrq/gHiWqgfy/l284aiAB3tXXye8FHDtQnX27bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJk0GU250nrR5/HeqLoiSSgrZSiNRxwQgrPt8ZNvfv8=;
 b=T7M9wf4pPzKhziJ0FPrrrVm0LgooisFFJDnlppLLMO0UMBJsJNQjYl6XaflYKdryK9uV4nZVojpb4HtsPSBZwtD9qB24JpKuiDNVYYkcoBwy+fzLGSdFGq9JkbGECSKBJLRvpCBMAS1NqhLDJOBi/XhckCHF9UIs1VKwkti9kkA=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3030.apcprd01.prod.exchangelabs.com (20.177.94.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 14:56:47 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 14:56:46 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I just got to know another 2 Singaporeans who were denied/refused
 government jobs because of their remarks on the Singapore Government
Thread-Topic: I just got to know another 2 Singaporeans who were
 denied/refused government jobs because of their remarks on the Singapore
 Government
Thread-Index: AdWZaWCiYAslJKKvQWi0lVvrQkBJEA==
Date:   Tue, 12 Nov 2019 14:56:46 +0000
Message-ID: <SG2PR01MB214193BA12640FBE088BC7FE87770@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07ce450-e36c-4396-274f-08d767808a4b
x-ms-traffictypediagnostic: SG2PR01MB3030:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB30301F4B1241EFD59AF2F37F87770@SG2PR01MB3030.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39830400003)(199004)(189003)(4326008)(102836004)(66476007)(52536014)(71200400001)(186003)(66066001)(2906002)(26005)(6116002)(71190400001)(7696005)(74316002)(9686003)(486006)(6506007)(476003)(86362001)(107886003)(33656002)(99286004)(3846002)(55016002)(6306002)(14454004)(508600001)(2501003)(966005)(76116006)(66946007)(2351001)(305945005)(8936002)(316002)(6916009)(66446008)(5640700003)(8676002)(6436002)(7736002)(5660300002)(66556008)(14444005)(256004)(64756008)(81156014)(25786009)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3030;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmO1E+ogMsj8rlMCEYDFhf9E/k3Vf7NB2JbJ8ndyA1UegEqciAdC9DkjQpb7s1Um4pw7IeQ2WLQN2SRQSgy4AWUQ8S23guio6oDKEObH2QeNQgVAZLVqRZ1uDLkKJRvzX/14eIJgDkepSZWi2YzvM007q9erX4qBVFHD5L9PmycpBmYqLHFR5LrQUZ/s4p2Qy1VG/tO6Oi927uNUqyKd3TQHljwhwAE2IXp2T2gMsgAitaf6+BCTHywp8s9p6vvQaeVHMGfKwwa9BD5KUpvj66DqtwoUr7q0kVeqoxgJT7vj1p/+rSv1rHdkd2Q5Y2erPpuvJAurj4yzEuFKITRGtStmyij8+YcIQYBZGc3RsfWo7EERaN5tXcj5Rb1E5JhjeIZTluHq+XYGUu7Y8toAL/BzpIR6uQOKaGcPKWIZ6Dr+9Hr8oQ8U7CoKhDazIyi0EhHUTMCRqVkU80S0wnVDqmlIpl4WFbpwzMBXwzHRpTY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07ce450-e36c-4396-274f-08d767808a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:56:46.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxcpag7Zyow3kU5fLegWa31UQTPls/dFZZjZlPHmaRd+ZKDuktrCaSbP9YfQo67TtD/VnbiQe4HBDmE6yPgKVSPbVibghQxdiERuSzMn93E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3030
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Subject: I just got to know another 2 Singaporeans who were denied/refused =
government jobs because of their remarks on the Singapore Government

Today, 12 November 2019 Tuesday Singapore Time, I got to know another 2 Sin=
gaporeans who were denied/refused government jobs because of their remarks =
on the Singapore Government.

Donald Trump (not his real name of course), who is a recruitment consultant=
 at job agency Nanotechnology Infocomms (not the real name of the job agenc=
y of course) in Singapore, communicated to me he is aware of another 2 Sing=
aporeans who were denied/refused government jobs because of their remarks o=
n the Singapore Government.

According to Donald Trump, the 1st Singaporean passed the first round of se=
curity clearance but failed the second round of security clearance. On furt=
her thoughts, the 1st Singaporean thought he may have been denied/refused t=
he government job because of his remarks on the Singapore Government.

According to Donald Trump, the 2nd Singaporean was working in a semi-govern=
ment job involving classified information of government ministers in Singap=
ore. According to Donald Trump, the 2nd Singaporean refused to sign Non-Dis=
closure Agreement (NDA) because he argued that government ministers in Sing=
apore are public figures. The 2nd Singaporean was subsequently forced to re=
sign or terminated from employment.

Due to privacy laws in Singapore (Personal Data Protection Act (PDPA)), Don=
ald Trump cannot reveal the names of the two Singaporean Targeted Individua=
ls to me. Privacy laws also exist in the European Union and the United Stat=
es.

The General Data Protection Regulation (EU) 2016/679 (GDPR) is a regulation=
 in EU law on data protection and privacy for all individual citizens of th=
e European Union (EU) and the European Economic Area (EEA). It also address=
es the transfer of personal data outside the EU and EEA areas. The GDPR aim=
s primarily to give control to individuals over their personal data and to =
simplify the regulatory environment for international business by unifying =
the regulation within the EU.[1] Superseding the Data Protection Directive =
95/46/EC, the regulation contains provisions and requirements related to th=
e processing of personal data of individuals (formally called data subjects=
 in the GDPR) inside the EEA, and applies to any enterprise established in =
the EEA or-regardless of its location and the data subjects' citizenship-th=
at is processing the personal information of data subjects inside the EEA.

The Privacy Act of 1974 (Pub.L. 93-579, 88 Stat. 1896, enacted December 31,=
 1974, Title 5 United States Code Section =A7 552a), a United States federa=
l law, establishes a Code of Fair Information Practice that governs the col=
lection, maintenance, use, and dissemination of personally identifiable inf=
ormation about individuals that is maintained in systems of records by fede=
ral agencies. A system of records is a group of records under the control o=
f an agency from which information is retrieved by the name of the individu=
al or by some identifier assigned to the individual. The Privacy Act requir=
es that agencies give the public notice of their systems of records by publ=
ication in the Federal Register. The Privacy Act prohibits the disclosure o=
f information from a system of records absent of the written consent of the=
 subject individual, unless the disclosure is pursuant to one of twelve sta=
tutory exceptions. The Act also provides individuals with a means by which =
to seek access to and amendment of their records and sets forth various age=
ncy record-keeping requirements. Additionally, with people granted the righ=
t to review what was documented with their name, they are also able to find=
 out if the "records have been disclosed".. and are also given the rights t=
o make corrections.[1]

I am now aware I am definitely not alone and I am definitely not the only T=
argeted Individual (TI) in Singapore. So far Donald Trump is the only recru=
itment consultant from only one job agency in Singapore whom I have spoken =
to. Hence there could be a lot more Targeted Individuals out there in Singa=
pore whom I am not aware of yet.







-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

