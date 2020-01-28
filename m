Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1965B14C117
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 20:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgA1Tfp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 14:35:45 -0500
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:16352
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgA1Tfo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jan 2020 14:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcF4mqFnZk/XUT2aGpfXJEmQ6U45kuCk7tV1MJhqLsnK0RBwNfR1e7cayu8SPGITvzZIz5x0yeaUrLCWTNOSgXQ1S7xn+NupM9gMusd11q4AegQcLarhd9qV8f4DF2sgHoxrOlnBwHaLgmfaX1R1/s1FoB4y+adVw40QKuQhTckRIxv2OFlsaN/ovJ/pvFvJC5H7qH6o2mpvUziKaVLWsPFlBz5he4wJPrhpGrOm1EtoLkXBfYghjwDfR+pUp9G+YwLnG1picAo3z8uKF0Gt5b/GxcuZqFCzzf8KIYNB4WkIKn0L3zk0kz8JrIUUIa7j1kB6dsFU6DyW59wZhKroMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckjDaMseEr8tjiNEb5FxiP6iDw0crNsTT9WFY8qhIJA=;
 b=gLw0cfwNMWYBJYvGZotwrWEqZElIhBSxS4f/iTZNSsuY+rt7CDo9xdWxz9xxJMz/2mGKf6igjKtIdV5Vh3Ol7TwbHnqNnLgsTpXbAFryOOrk6MZU65Ui8wVpR+Ktu9Ib7U2l+GnzjWlNrxSHq8vBMXqHRJoiN6QlOKmgfK6xTmQODRU0s4YhYlEK2hfAEXh4tQOEbP0LNE2BZ9BtrHjc/YY7uQP083ibtTraUVsRR76JemHrYmO8YXTmV5DIkHr5O3omLqIZ1GFfCDIOZStL5Ip1XgMi4UwHxU8Hx6PwSGhVrdwsUPvLdAnKrTiQPTLk6CkRTqatJc+HS02OjraQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=gmail.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckjDaMseEr8tjiNEb5FxiP6iDw0crNsTT9WFY8qhIJA=;
 b=vFz1DmAmcTVRpFAmgh4pXV75vkRVoXbC2l9sX/GhwZtjYzML8nOrosVPQUui8IdMw8jW+jOnFbY+0JDcDzfS5BJLugHd1/tKyAZDpDsdJjEHSLCXWYmTxurPnqcBhkbXI2j2wMMKhXPiPvH4J2cR7xM07poAyl7ClRm0j83Xz84=
Received: from DM5PR13CA0038.namprd13.prod.outlook.com (2603:10b6:3:7b::24) by
 BYAPR13MB2535.namprd13.prod.outlook.com (2603:10b6:a02:c0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.14; Tue, 28 Jan 2020 19:35:41 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM5PR13CA0038.outlook.office365.com
 (2603:10b6:3:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.18 via Frontend
 Transport; Tue, 28 Jan 2020 19:35:40 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Tue, 28 Jan 2020 19:35:40 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id 00SJZdVn009995;
        Tue, 28 Jan 2020 19:35:39 GMT
Received: from USCULXHUB08V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.169])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id 00SJZcuk001152;
        Tue, 28 Jan 2020 19:35:38 GMT
Received: from USCULXMSG17.am.sony.com ([146.215.231.83]) by
 USCULXHUB08V.am.sony.com ([146.215.231.169]) with mapi id 14.03.0439.000;
 Tue, 28 Jan 2020 14:35:37 -0500
From:   <Tim.Bird@sony.com>
To:     <frowand.list@gmail.com>, <brendanhiggins@google.com>
CC:     <mcgrof@kernel.org>, <jdike@addtoit.com>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <arnd@arndb.de>,
        <keescook@chromium.org>, <skhan@linuxfoundation.org>,
        <alan.maguire@oracle.com>, <yzaikin@google.com>,
        <davidgow@google.com>, <akpm@linux-foundation.org>,
        <rppt@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <logang@deltatee.com>, <knut.omang@oracle.com>,
        <linux-um@lists.infradead.org>, <linux-arch@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
Thread-Topic: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
Thread-Index: AQHVxOJdmky63MdyM0ynfLJLDg5Ekqf5RkiAgAX1ZACAAOTtgIAAvUGA//+z/cA=
Date:   Tue, 28 Jan 2020 19:35:36 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
In-Reply-To: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(316002)(70206006)(8676002)(336012)(246002)(110136005)(54906003)(7696005)(26005)(70586007)(478600001)(86362001)(7416002)(4326008)(33656002)(55846006)(2906002)(53546011)(186003)(8936002)(2876002)(55016002)(426003)(956004)(5660300002)(37786003)(356004)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR13MB2535;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf45af0-4f3c-4edd-c44a-08d7a429422f
X-MS-TrafficTypeDiagnostic: BYAPR13MB2535:
X-Microsoft-Antispam-PRVS: <BYAPR13MB253589FC302C1CBEFA39C8B0FD0A0@BYAPR13MB2535.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9XdkSa6zlIaCoDocneK/G8DuravTpCOSs/+/1E9rRxRa8nRT/FJoGOeP8C/proR+GVu1xPkd1h3dlnG+n+eGy1a7LOmhU1hC9wXImafVv5Y2o6LPjsn4v+O8Af8fPqr22hlV3lhX4+JymabHrdYQ3HIZYofVtq4nqQNbYer3cpyPj+GKGdMbdp/RoC2lxAC1wZhKLmO+sYYXEtV2Y9lOr94l2OeJKQ0RubvNyNwD4zNrwsUgMAzmkJ0I/WZVXWKez+Ij0E8ovNqZJJZwgEgCJF5dXRb+rW5WIR17sGlvQ65v7Z+pyGWI07jw5x1uW9hf1jidLrKSluYbitE5IwFY9Ten1yKOOu1AaNnD8hubNU+MEk4Y1sB10jUgR1cjhtAyjeeQK6TT+3299fJ8AenTpbtD1b+Tpdev2YfOZCayUw1pFVEKKZN2F4T/31Ls9Kn/lNKec/SaTvDe6XO8nDJQh/kuUbbv2A4PPMQFYceE2jb5cfbBpkf3SeaOYI6ITWl
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 19:35:40.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf45af0-4f3c-4edd-c44a-08d7a429422f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2535
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogIEZyYW5rIFJvd2FuZCBv
biBKYW51YXJ5IDI4LCAyMDIwIDExOjM3IEFNDQo+IA0KPiBPbiAxLzI4LzIwIDE6MTkgQU0sIEJy
ZW5kYW4gSGlnZ2lucyB3cm90ZToNCj4gPiBPbiBNb24sIEphbiAyNywgMjAyMCBhdCA5OjQwIEFN
IEZyYW5rIFJvd2FuZCA8ZnJvd2FuZC5saXN0QGdtYWlsLmNvbT4gd3JvdGU6DQouLi4NCj4gPiB3
ZSBjb3VsZCBhZGQgS2NvbmZpZ3MgdG8gY29udHJvbCB0aGlzLCBidXQgdGhlIGNvbXBpbGVyIG5l
dmVydGhlbGVzcw0KPiA+IGNvbXBsYWlucyBiZWNhdXNlIGl0IGRvZXNuJ3Qga25vdyB3aGF0IHBo
YXNlIEtVbml0IHJ1bnMgaW4uDQo+ID4NCj4gPiBJcyB0aGVyZSBhbnkgd2F5IHRvIHRlbGwgdGhl
IGNvbXBpbGVyIHRoYXQgaXQgaXMgb2theSBmb3Igbm9uIF9faW5pdA0KPiA+IGNvZGUgdG8gY2Fs
bCBfX2luaXQgY29kZT8gSSB3b3VsZCBwcmVmZXIgbm90IHRvIGhhdmUgYSBkdXBsaWNhdGUNCj4g
PiB2ZXJzaW9uIG9mIGFsbCB0aGUgS1VuaXQgbGlicmFyaWVzIHdpdGggYWxsIHRoZSBzeW1ib2xz
IG1hcmtlZCBfX2luaXQuDQo+IA0KPiBJJ20gbm90IHN1cmUuICBUaGUgYnVpbGQgbWVzc2FnZXMg
aGF2ZSBhbHdheXMgYmVlbiB1c2VmdWwgYW5kIHZhbGlkIGluDQo+IG15IGNvbnRleHQsIHNvIEkg
bmV2ZXIgdGhvdWdodCB0byBjb25zaWRlciB0aGF0IHBvc3NpYmlsaXR5Lg0KPiANCj4gPiBUaG91
Z2h0cz8NCg0KSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYSByZXN0cmljdGlvbiBvbiBub24gX19pbml0
IGNvZGUgY2FsbGluZyBfX2luaXQNCmNvZGUuICBJbiBpbml0L21haW4uYyBhcmNoX2NhbGxfcmVz
ZXRfaW5pdCgpIGlzIGluIF9faW5pdCwgYW5kIGl0IGNhbGxzDQpyZXN0X2luaXQgd2hpY2ggaXMg
bm9uIF9faW5pdCwgd2l0aG91dCBhbnkgc3BlY2lhbCBoYW5kbGluZy4NCg0KSXMgdGhlIGNvbXBp
bGVyIGNvbXBsYWludCBtZW50aW9uZWQgYWJvdmUgcmVsYXRlZCB0byAgY2FsbGluZw0KaW50byBf
X2luaXQgY29kZSwgb3Igd2l0aCBzb21lIG90aGVyIGlzc3VlPw0KIC0tIFRpbQ0KDQo=
