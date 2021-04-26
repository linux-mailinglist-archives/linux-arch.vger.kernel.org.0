Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4056936B6CD
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhDZQag (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 12:30:36 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59832 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234257AbhDZQaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 12:30:35 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 922A140775;
        Mon, 26 Apr 2021 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619454594; bh=gtGHIibvEtBL1PbPk/kfrCYVDSCQ1ER3fZuVsPvVZ3I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TTRauFG1Ymw2iVEiTS0M3cvj3wrW1Gm2nYrcFevF8V81clp8asG9OFlcwhcNwtOFH
         4JaTpsCNyJqXi8OGhF8Y2cHeKLkD+Xvb5dIEMOlElKe4ISJmBFwVI5qO/nYZvmGhJG
         U5LxATP/15gbQp3ORelyeY6lsi1y2Zpush/QSOik034A7vXyDrP2qTFtZj5Kf9rbg9
         h9GVOfaaucz9GLf0s26imC2fImAZt4JA+0dvsDvy+RL+aorUfvQuZXcs4sGUxEqnX8
         +CNpyqJGs2nwJlSA7vUBZF+IOZebivXedTIgDlZ3JTEQQcX8n6iDERoA+VbsHe1lDd
         VLtZDbvKw5uJA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 84D70A006A;
        Mon, 26 Apr 2021 16:29:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 866ED800BE;
        Mon, 26 Apr 2021 16:29:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FFurdxKv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGnY0HM8xmhNr7jv/G8xEkjXkQ2ptoELgd0YR6p3SjLW46OuRfQFw1Gs6ml8hMUkX27+1kqA2MHkkYAV6ZwGpRDGtzS+k6kiRhoz5TJ1eTUyF8tUuIPpzpDi+8gs+c0BzSlBBlMWHAF+OXcSh9Lb7tAIq/cGieDUYFgaX7c9H2HTwPO6CH6HumpeGGKdgkB5vgarDxUpcIeJxOmd6TvKOjAz86emW5jFEIcqewBPdxXzd0krJ7L3uMfUJwLHofPNdQ3oENIkmwu7vSbtIs6X6NwNBatCWxWhDDoeMXCyVemVQ1Fw/PHastNe1ymRohheCxHKGXKaFbQ0MasY7OXbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtGHIibvEtBL1PbPk/kfrCYVDSCQ1ER3fZuVsPvVZ3I=;
 b=UTRIw3OTDW5gNxS2tTsTzHNK3uKPR9U/jx/NNSIBCjYbcYDCbH0mFvvrKlkhof516JQLkT9WBYx2+KZi3F9gYxXPMODyFQVIhRhPE48NKQrb35R53h4I1y0gHocbcybW0EQZ3kPbn6emTIHJWrciXnVaEcyLPg6r1RQuoENQyMwhNnM55pbWixNi2Af1BD+ux9XhXGoke0E0En5Otmghy2nbQIryRdVXcgRfGrnL84rta30srQQa1bv7fsdFpSKK54gVKObdHopCG3KJ3xYsXc22Qqh9wSokEImxbhfBIgl32ZtPDcpD9zRcauaYoDgMKdlAjmdUfSY0qyvU7QF1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtGHIibvEtBL1PbPk/kfrCYVDSCQ1ER3fZuVsPvVZ3I=;
 b=FFurdxKvRSQSWrO7SJpDsVLhINApwxVtIbfij+88PEPgSqYrW0e1z3LjSlDvmBzqTCKLwG0Blk1UR9bv6HSIIZgYzi1zX3aQP8Hee/7W8oJxKsbNLzcGiBVm7IUslYwpnAPeQp22EKXbGyDFDcfaYHBAEylMZuWvJ2+AlhcvijE=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4641.namprd12.prod.outlook.com (2603:10b6:a03:1f7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 16:29:49 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 16:29:49 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] ARC: Use 40-bit physical page mask for PAE
Thread-Topic: [PATCH] ARC: Use 40-bit physical page mask for PAE
Thread-Index: AQHXOoQeRoAsdo9ybEqvN+qAfiw8IKrG/bcA
Date:   Mon, 26 Apr 2021 16:29:49 +0000
Message-ID: <5010e4f4-c881-6c9f-b24c-4a87d9a4d55f@synopsys.com>
References: <20210426100801.41308-1-isaev@synopsys.com>
In-Reply-To: <20210426100801.41308-1-isaev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b3ea9ac-fb7c-4388-57be-08d908d08303
x-ms-traffictypediagnostic: BY5PR12MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4641653B878EA9F86D7781B2B6429@BY5PR12MB4641.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGweKZW0S7L9aqtiMFlQExeG4kHUXOES9btLoOGPFol0SqxdsE0i2m4kiGX2v66+D/Tc1IxlhPi3LNVBe6Zp8IszUqyP1W8+CZCy0WeKf5rOc6d9AbqHgo045LgNECu6BeJIHs++YrQ2iAlGQ1WyqVTFNfEnRbx6D3pGG/E4AAy/H5NohpbbdOf+KjX79ZeNs3bjaIg4bJa5KlF5UmL4fWJTa1buWPf4htt3STiT8w4SBih01sgxscH2kCx6Htb/MqnYfyfvFhELAwPkkvhL9mjNuwKEG/fjMS3PU5n0MDGIWJSzFsJV92qb+ngsCAQuR+0xIa9uY5ifJrrZwZ1KoUMi9BZTlwxfafs4UE3Gd1sf7Ig2ixdMBMaTd3SSEjXmxNnXT0SE/OSS4t0043ohnLmzbyJ8N3P0+xVhkIlMC9rY+CykeDoOrUUaulvbtYMZjRbENmx8ulECAGlHIij5n46q5nCxbmSp0TvkhRQI/bKXw3W1h4gNCASR6hANvKRXWTBzWcFZzz2TKk4C5yn5Jn1b/OTceJKewZrNmWOOgps+Qx2VnINAxJ5cxNFXqE+w1mXjdsXuWilJvUje+gclSPWZGm0qQdRtwL28DUGp1f/I9dDJCxMm4Z06qRaAGdj76tzB9c0MNUIdqCb+qnLkPz8h4JROrsgYyBWneFK/cJwMvwiu5jTwLk8qrLNhEhB6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(53546011)(6506007)(31696002)(64756008)(26005)(186003)(2616005)(36756003)(122000001)(316002)(66446008)(86362001)(110136005)(66556008)(478600001)(5660300002)(38100700002)(6512007)(54906003)(2906002)(71200400001)(4326008)(66476007)(8676002)(31686004)(83380400001)(76116006)(8936002)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QTNkMU80SldqL1dOME1ITlczMkMzMERwSXRJQXU4Umppb0Z2Y0JVOVRGRzRC?=
 =?utf-8?B?RU9NKzlSZm1WV2M1WUtHMHdaOHdZUnFoZzFISlVSZCtMRitCbTFMTHdYMk1G?=
 =?utf-8?B?MVNIYnZoc1RCYWdLU0xDYnJaOTB6TjRCcVRrVEFOUVoxZUp3MGNSTDc0MU9S?=
 =?utf-8?B?N3dkbnF2K1FaR0tDblg3bTNjMWlTbTlCbkFaVEJHQThBeldoRW1PSEVCdDBm?=
 =?utf-8?B?T1o4THllQkxKT3plWkxHNDZPcVkvcHBqRmhXMkg4WE1qb3RldUVkRDY4TXAr?=
 =?utf-8?B?V2tyTlEwTjBOMlZUdFViUlc4NmpONUM4VTEyUlRXc2poZWNoN2l5TXhBdzJQ?=
 =?utf-8?B?cGo0MWdlSEVxOHhLd2tINTgveDhIcThYMXpkMVZBWFllOS9ETDF0clQ0RVhK?=
 =?utf-8?B?VkNQZTdER2ZtZEpVMHgwT09CQUpaUEtKNlNHa1B4NUlFRWJmTm1ubWF4ei9L?=
 =?utf-8?B?dDlhdjhSZVo2aG5LUmdJTEdrZm81VS9jbkdYOU9HTlpPTk1WT2VIbzF3R3BY?=
 =?utf-8?B?M2dNRXg3WnRkeTBKTjhYYThUdno5UzRHaHdrMWVLZFc4KzJBdzI4SW92dXA5?=
 =?utf-8?B?Wm1YNU8yNlhST2FRTWpwK3JTelJndWUwU20xNHVtdWd5bG9jdTJKeG5sc1Ft?=
 =?utf-8?B?NHpwM1BuUEp3eGhzY3Vrc3hOZjZwaHB1TytDd3F1MFhrRHZsanZzRkM1dEox?=
 =?utf-8?B?ZmVLNEpFR3B3enptaEtLYlpaWVd6bUVSUEFlL3I2SGdNNUdpZVd3K3BXWlhT?=
 =?utf-8?B?RzdlQnpyT1dLeDVoTzRkWURab3VpRDcyWkE0YTVzbGlYcmwzT3lkdElEU3RP?=
 =?utf-8?B?NnJJZHVHcFd6VFJHam5qSk1LVjFYbUZUQW56K1h0QkF5WVZiTDhwaHB6WlBk?=
 =?utf-8?B?ajdCcXJEWjJGU0hwejN3d1FzaUFxTXJOa1ZBenM3QWFJUHV4azAyQXc4K2d5?=
 =?utf-8?B?YkZ1Q0RuSlcrZFMyNFZJNXgrUXBKWUFBVVVvQzFIZ0hQKzZJS3BxK1RqcW42?=
 =?utf-8?B?S2d0am5FUDVOcyt5SlNMc0JMV0FkUkNVeTI3ajZjdjhOUUtFTC81QzIyQUhT?=
 =?utf-8?B?MXhrb1FDZGx1V0dPTERzeGVtM0JkdGpSRml3cFlMY01XTkNCaVBSNjVlbjBn?=
 =?utf-8?B?b0d4M1k4T3A0OTFWWDhuL0RiVnVjdGFrZFBRc3g2OXB1d2FpYm9COW1LM0xt?=
 =?utf-8?B?amY1b2U2SVhaQmFpakhxcW10bmMzbDZmSGpyMnk1cFVJVHcrV0pJK3VzQVBC?=
 =?utf-8?B?cTRTclNTb0t0RHZhajJMa0pWRU1iRnZoMXM4QTI3N0dnc20waytEOHhGZkV3?=
 =?utf-8?B?dk1IckRiOU9RUkN4aWpqeC8va0w2NG1rMVBrbCtEbnowR1BacFZWNE5OV0Fi?=
 =?utf-8?B?QVdJd3liK0oxeDZjSm5xMTNKN0hWcFAvZDZlZE85N1pMNldiSTViU3ZscWZh?=
 =?utf-8?B?YVYzZmtleUhWcVhCQmZSRmdJblluR3YySVVRNXp0SlJZbGN0V1FlVS91akZu?=
 =?utf-8?B?Zm1yY3h5cFBaNEFaajZhYjBhN0NNSXV6QTlZMzJXL2U0VGdPcjl3Z1pNTnVs?=
 =?utf-8?B?L0VXb01ZbXNWVVU5Y29uOEpCTEVSQnFpaXI0WDRVV29ham01VlY2NmVpTndS?=
 =?utf-8?B?L0IyWXNzOU8vaU9JdFJoQS96V2ZGd0FQRUdDSEVOZWJ4emF0Yys0WTBpM0F5?=
 =?utf-8?B?S3FLbFFHWUxEKzBlbVptSEZ3bnV1UVlmWmw2SWExUjlzMi9Xb1JxUzFnY2lU?=
 =?utf-8?Q?fIyj2mJTeaOui3MgJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EEBFC917976FE43AA7719F7A6FD8389@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ea9ac-fb7c-4388-57be-08d908d08303
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 16:29:49.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYnEacBob5gdRfd6HdmUErKDRxS3mUlpJ97OLOEhIgg9myrDvUk8Pe37GLvyp9eQXSbI7QfCkU/7aZwAhpR0QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4641
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

K0NDIEFybmQNCg0KT24gNC8yNi8yMSAzOjA4IEFNLCBWbGFkaW1pciBJc2FldiB3cm90ZToNCj4g
MzItYml0IFBBR0VfTUFTSyBjYW4gbm90IGJlIHVzZWQgYXMgYSBtYXNrIGZvciBwaHlzaWNhbCBh
ZGRyZXNzZXMNCj4gd2hlbiBQQUUgaXMgZW5hYmxlZC4gUEhZU0lDQUxfUEFHRV9NQVNLIG11c3Qg
YmUgdXNlZCBmb3IgcGh5c2ljYWwNCj4gYWRkcmVzc2VzIGluc3RlYWQgb2YgUEFHRV9NQVNLLg0K
DQpDYW4geW91IHByb3ZpZGUgYSBiaXQgbW9yZSBjb250ZXh0IDogbGlrZSB3L28gdGhpcyBleGl0
L211bm1hcCBvbiA1LnggDQprZXJuZWxzIHdhcyBjcmFzaGluZyAtIHdpdGggdGhlIGFjdHVhbCBz
dGFjayB0cmFjZS4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIElzYWV2IDxpc2FldkBz
eW5vcHN5cy5jb20+DQoNClRoaXMgYWxzbyBuZWVkcyB0byBiZSBDQyA8c3RhYmxlPg0KDQo+IC0t
LQ0KPiAgIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3BndGFibGUuaCAgIHwgMTIgKysrLS0tLS0tLS0t
DQo+ICAgYXJjaC9hcmMvaW5jbHVkZS91YXBpL2FzbS9wYWdlLmggfCAgNyArKysrKysrDQo+ICAg
YXJjaC9hcmMvbW0vaW9yZW1hcC5jICAgICAgICAgICAgfCAgNCArKy0tDQo+ICAgYXJjaC9hcmMv
bW0vdGxiLmMgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTMg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
Yy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgN
Cj4gaW5kZXggMTYzNjQxNzI2YTJiLi4yNWM5NWZiYzcwMjEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJjL2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9w
Z3RhYmxlLmgNCj4gQEAgLTEwNyw4ICsxMDcsOCBAQA0KPiAgICNkZWZpbmUgX19fREVGIChfUEFH
RV9QUkVTRU5UIHwgX1BBR0VfQ0FDSEVBQkxFKQ0KPiAgIA0KPiAgIC8qIFNldCBvZiBiaXRzIG5v
dCBjaGFuZ2VkIGluIHB0ZV9tb2RpZnkgKi8NCj4gLSNkZWZpbmUgX1BBR0VfQ0hHX01BU0sJKFBB
R0VfTUFTSyB8IF9QQUdFX0FDQ0VTU0VEIHwgX1BBR0VfRElSVFkgfCBfUEFHRV9TUEVDSUFMKQ0K
PiAtDQo+ICsjZGVmaW5lIF9QQUdFX0NIR19NQVNLCShQSFlTSUNBTF9QQUdFX01BU0sgfCBfUEFH
RV9BQ0NFU1NFRCB8IF9QQUdFX0RJUlRZIHwgXA0KPiArCQkJCQkJCSAgICAgICBfUEFHRV9TUEVD
SUFMKQ0KDQpCaWtlIHNoZWQ6IENhbiB3ZSBjYWxsIHRoaXMgUEFHRV9NQVNLX1BIWVMNCg0KPiAg
IC8qIE1vcmUgQWJicmV2YWl0ZWQgaGVscGVycyAqLw0KPiAgICNkZWZpbmUgUEFHRV9VX05PTkUg
ICAgIF9fcGdwcm90KF9fX0RFRikNCj4gICAjZGVmaW5lIFBBR0VfVV9SICAgICAgICBfX3BncHJv
dChfX19ERUYgfCBfUEFHRV9SRUFEKQ0KPiBAQCAtMTMyLDEzICsxMzIsNyBAQA0KPiAgICNkZWZp
bmUgUFRFX0JJVFNfSU5fUEQwCQkoX1BBR0VfR0xPQkFMIHwgX1BBR0VfUFJFU0VOVCB8IF9QQUdF
X0hXX1NaKQ0KPiAgICNkZWZpbmUgUFRFX0JJVFNfUldYCQkoX1BBR0VfRVhFQ1VURSB8IF9QQUdF
X1dSSVRFIHwgX1BBR0VfUkVBRCkNCj4gICANCj4gLSNpZmRlZiBDT05GSUdfQVJDX0hBU19QQUU0
MA0KPiAtI2RlZmluZSBQVEVfQklUU19OT05fUldYX0lOX1BEMQkoMHhmZjAwMDAwMDAwIHwgUEFH
RV9NQVNLIHwgX1BBR0VfQ0FDSEVBQkxFKQ0KPiAtI2RlZmluZSBNQVhfUE9TU0lCTEVfUEhZU01F
TV9CSVRTIDQwDQo+IC0jZWxzZQ0KPiAtI2RlZmluZSBQVEVfQklUU19OT05fUldYX0lOX1BEMQko
UEFHRV9NQVNLIHwgX1BBR0VfQ0FDSEVBQkxFKQ0KPiAtI2RlZmluZSBNQVhfUE9TU0lCTEVfUEhZ
U01FTV9CSVRTIDMyDQo+IC0jZW5kaWYNCj4gKyNkZWZpbmUgUFRFX0JJVFNfTk9OX1JXWF9JTl9Q
RDEJKFBIWVNJQ0FMX1BBR0VfTUFTSyB8IF9QQUdFX0NBQ0hFQUJMRSkNCj4gICANCj4gICAvKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCj4gICAgKiBNYXBwaW5nIG9mIHZtX2ZsYWdzIChHZW5lcmljIFZNKSB0
byBQVEUgZmxhZ3MgKGFyY2ggc3BlY2lmaWMpDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9pbmNs
dWRlL3VhcGkvYXNtL3BhZ2UuaCBiL2FyY2gvYXJjL2luY2x1ZGUvdWFwaS9hc20vcGFnZS5oDQo+
IGluZGV4IDJhOTdlMjcxOGEyMS4uOGZlY2YyYTJiNTkyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
Yy9pbmNsdWRlL3VhcGkvYXNtL3BhZ2UuaA0KPiArKysgYi9hcmNoL2FyYy9pbmNsdWRlL3VhcGkv
YXNtL3BhZ2UuaA0KPiBAQCAtMzMsNSArMzMsMTIgQEANCj4gICANCj4gICAjZGVmaW5lIFBBR0Vf
TUFTSwkofihQQUdFX1NJWkUtMSkpDQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX0FSQ19IQVNfUEFF
NDANCj4gKyNkZWZpbmUgTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklUUyA0MA0KPiArI2RlZmluZSBQ
SFlTSUNBTF9QQUdFX01BU0sJKDB4ZmYwMDAwMDAwMHVsbCB8IFBBR0VfTUFTSykNCj4gKyNlbHNl
DQo+ICsjZGVmaW5lIE1BWF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMgMzINCj4gKyNkZWZpbmUgUEhZ
U0lDQUxfUEFHRV9NQVNLCVBBR0VfTUFTSw0KPiArI2VuZGlmDQoNCk5vdCBhIGdvb2QgaWRlYSBh
cyB5b3UgYWxyZWFkeSBzYXcgdGhlIGtlcm5lbCBidWlsdCBib3QgY29tcGxhaW5pbmcuIA0KR3Jh
bnRlZCB3ZSBoYXZlIHRoZSBvbGQgUEFHRV9TSVpFIGNydWZ0IHRoZXJlLCBidXQgdGhhdCdzIG5v
dCB0aGUgDQpwcmVjZWRlbnQgZm9yIGFkZGluZyBtb3JlLg0KDQo+ICAgDQo+ICAgI2VuZGlmIC8q
IF9VQVBJX19BU01fQVJDX1BBR0VfSCAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvbW0vaW9y
ZW1hcC5jIGIvYXJjaC9hcmMvbW0vaW9yZW1hcC5jDQo+IGluZGV4IGZhYzRhZGM5MDIwNC4uZWIx
MDlkNTdkNTQ0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9tbS9pb3JlbWFwLmMNCj4gKysrIGIv
YXJjaC9hcmMvbW0vaW9yZW1hcC5jDQo+IEBAIC03MSw4ICs3MSw4IEBAIHZvaWQgX19pb21lbSAq
aW9yZW1hcF9wcm90KHBoeXNfYWRkcl90IHBhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUsDQo+ICAg
CXByb3QgPSBwZ3Byb3Rfbm9uY2FjaGVkKHByb3QpOw0KPiAgIA0KPiAgIAkvKiBNYXBwaW5ncyBo
YXZlIHRvIGJlIHBhZ2UtYWxpZ25lZCAqLw0KPiAtCW9mZiA9IHBhZGRyICYgflBBR0VfTUFTSzsN
Cg0KVGhpcyBpcyBvZmZzZXQgKndpdGhpbiogYSBwYWdlIHNvIHVwcGVyIGJpdHMgbXVzdCBub3Qg
bWF0dGVyLiBJbiBmYWN0LCANCndpdGggdGhpcyBhIGJvZ3VzIG9mZnNldCBsaWtlIDB4RkZfRkZG
RkZGRkYgY2FuIHR1cm4gaW50byBzb21ldGhpbmcgDQp3ZWlyZCBzdWNoIGFzIDB4RkZfMDAwMDAw
MDANCg0KPiAtCXBhZGRyICY9IFBBR0VfTUFTSzsNCj4gKwlvZmYgPSBwYWRkciAmIH5QSFlTSUNB
TF9QQUdFX01BU0s7DQo+ICsJcGFkZHIgJj0gUEhZU0lDQUxfUEFHRV9NQVNLOw0KDQpUaGlzIGNo
YW5nZSBpcyBPSyBidXQgZmVlbHMgd2VpcmQgbm9uZXRoZWxlc3MuIGlvcmVtYXAgaXMgaW50ZW5k
ZWQgZm9yIA0KYWN0dWFsIElPIHJlZ2lvbnMgYW5kIG5vdCBqdXN0IG1ha2luZyBtYWtpbmcgbm9y
bWFsIHBhZ2VzIHVuY2FjaGVkLiBJIA0Ka25vdyB5b3UgdHJpZWQgdGhlIGRldm1lbSB0cmljayB0
byBkbyB0aGlzIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgYSANCiJwcm9kdWN0aW9uIiB3YXkg
dG8gcmVuZGVyIHVuY2FjaGVkIHBhZ2VzIGluIFBBRSByZWdpb24uDQoNCj4gICAJc2l6ZSA9IFBB
R0VfQUxJR04oZW5kICsgMSkgLSBwYWRkcjsNCj4gICANCj4gICAJLyoNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJjL21tL3RsYi5jIGIvYXJjaC9hcmMvbW0vdGxiLmMNCj4gaW5kZXggOWJiM2MyNGYz
Njc3Li4xNWEzYjkyZTllNzIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL21tL3RsYi5jDQo+ICsr
KyBiL2FyY2gvYXJjL21tL3RsYi5jDQo+IEBAIC01NzYsNyArNTc2LDcgQEAgdm9pZCB1cGRhdGVf
bW11X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIHZhZGRy
X3VuYWxpZ25lZCwNCj4gICAJCSAgICAgIHB0ZV90ICpwdGVwKQ0KPiAgIHsNCj4gICAJdW5zaWdu
ZWQgbG9uZyB2YWRkciA9IHZhZGRyX3VuYWxpZ25lZCAmIFBBR0VfTUFTSzsNCj4gLQlwaHlzX2Fk
ZHJfdCBwYWRkciA9IHB0ZV92YWwoKnB0ZXApICYgUEFHRV9NQVNLOw0KPiArCXBoeXNfYWRkcl90
IHBhZGRyID0gcHRlX3ZhbCgqcHRlcCkgJiBQSFlTSUNBTF9QQUdFX01BU0s7DQo+ICAgCXN0cnVj
dCBwYWdlICpwYWdlID0gcGZuX3RvX3BhZ2UocHRlX3BmbigqcHRlcCkpOw0KPiAgIA0KPiAgIAlj
cmVhdGVfdGxiKHZtYSwgdmFkZHIsIHB0ZXApOw0KDQo=
