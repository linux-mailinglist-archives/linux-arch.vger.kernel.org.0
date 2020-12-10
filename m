Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497C2D6B3D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgLJW57 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Dec 2020 17:57:59 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:8608
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbgLJW5T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Dec 2020 17:57:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8Y54o6ObIBYyyhXNYzbsBzScoJRB6TKsDE1In0F5gejLEBD+402aoTSD94wemyHKKq7je7Q1PxeVZ/d1JlZjWd1aoWeAv/rKclx7cnpCNe4gPI6AchwXwOrWJqdTmSD0zQbyvz99LQLddz+5IscLqi6yN4DbE33YJOUOjAjNS/TARD1FugOa4xI642FQcj31l9ta9PieNh14LkzXy0GosUssKS5v6NJlGZjG+GmaG+jkxFdHGOIJm/y0PsI4V4RcGuaGHHSZrD/xEPA/0Q4DfgXCeUlHXPSfgQgXrLzB+AMzhqdNHKmul2HG44hS+V6gJqRCJ7gl2SsHN6a+utr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv+iaRfAkLEPmSNSUCy+YbXMUTgL1uGJdqFsUKkRgd8=;
 b=htyvu7vhqO2cXCe7YDv/tw4RQj9PPwULrvCMQ6n9MZ9UdxAvfrLw5BrK73jBhGYspJblZx55winUzHTpoS7sjiGHU/5Vl6Q7NvVZMM1YccX0U8DZeML5OD0tvov4lpNP6MRdKaKrGPOsmbomKr6y2g/1QuNDosshPN3Qxzsix28hyHukM5Q/83a2QqZJEDVV5pX4ai2D5e8wVkQLfXNl3+XN40j0pKTWB30RJee2wtoxzxlyLVPYuLaCWjYMiX3Mu3a1bQwLRPnTyLf1wWWQzEutWnnpB+XWrTsyd97r8B8ILwZinvCK+ICa1F9zr58kzdvUcaYT//DyF3CxIToyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv+iaRfAkLEPmSNSUCy+YbXMUTgL1uGJdqFsUKkRgd8=;
 b=mSXX2nnr+RK6J/aFgq3bmutwpLGpd3fOovqw0wxNFi5bW/AXt6gAfMWnJdGgiPlXJz3xIicTWiDfbz0zOnYZxVgDuOCGmp4cTA4Uhajz5iAqQ4ehX0ecupOskk/tUk6MKFADhX253i0Rzoo/vb0ERY50436RGzkODNLV0m8kCo4=
Received: from VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:7c::28)
 by VE1PR10MB3039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 10 Dec
 2020 22:37:40 +0000
Received: from VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4f9:99d0:c75:bc2f]) by VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4f9:99d0:c75:bc2f%7]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 22:37:39 +0000
From:   "Geva, Erez" <erez.geva.ext@siemens.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jon Rosen <jrosen@cisco.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Martin KaFai Lau <kafai@fb.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Or Cohen <orcohen@paloaltonetworks.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Xie He <xie.he.0141@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladis Dronov <vdronov@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Sudler, Simon" <simon.sudler@siemens.com>,
        "Meisinger, Andreas" <andreas.meisinger@siemens.com>,
        "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "Zirkler, Andreas" <andreas.zirkler@siemens.com>
Subject: Re: [PATCH 1/3] Add TX sending hardware timestamp.
Thread-Topic: [PATCH 1/3] Add TX sending hardware timestamp.
Thread-Index: AQHWzjjS+JtwwiLyJkKEw3ObDmZ1g6nu2GGAgAAIlICAACaHgIAAFaqAgAGXBoCAAAn5AA==
Date:   Thu, 10 Dec 2020 22:37:39 +0000
Message-ID: <VI1PR10MB24460D805E8091EB09F81199ABCB0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
References: <20201209143707.13503-1-erez.geva.ext@siemens.com>
 <20201209143707.13503-2-erez.geva.ext@siemens.com>
 <CA+FuTScWkYn0Ur+aSuz1cREbQJO0fB6powOm8PFxze4v8JwBaw@mail.gmail.com>
 <VI1PR10MB244654C4B42E47DB5EBE0B05ABCC0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
 <CA+FuTSd7oB0qO707W6htvs=FOJn10cgSQ4_iGFz4Sk9URXtZiw@mail.gmail.com>
 <VI1PR10MB2446ACEACAE1F3671682407FABCC0@VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM>
 <CAF=yD-LkknU3GwJgG_OiMPFONZtO3ECHEX0QfTaUTTX_N0i-KA@mail.gmail.com>
In-Reply-To: <CAF=yD-LkknU3GwJgG_OiMPFONZtO3ECHEX0QfTaUTTX_N0i-KA@mail.gmail.com>
Accept-Language: en-GB, en-DE, he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2020-12-10T22:37:37Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=231155e1-008d-444c-abce-e743c0ad701c;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=siemens.com;
x-originating-ip: [165.225.26.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35ab0cd3-a652-4b4c-939f-08d89d5c3384
x-ms-traffictypediagnostic: VE1PR10MB3039:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB3039D03CC516ABE520ECEF50ABCB0@VE1PR10MB3039.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mrjufn5DoXGzI+y1lLp+zqeWJv61L2KsHsDUC7J8mkSFZBIKGTKc8EvOKhTJo3dh2zU9BCNPdD5XlbRA7CzMDsAHxZh/A8R5W2t1C7vQkg0rIP63I4/RupVoPMS7wpuQVT+BR+2ODvP9svooxzH3TAw51XILCEhuzBIidD4+kcZsZ7tt+XTcyKMyQGx4TMFQjBxrvcHEGyRKrry7Aq5uyK7f9Kc3AIzuGjj9E668rpisdhWl6/k/ptrTj48rUOfCg/V/xiqBMuzscsqoUBKkdG6vt+48M02vgEHBhRTxk2S+aQ36L8c3gUUfVtspz05Ant9YYCBb0d5ouqhniCksLUKSLVb81x3EpeW+x/m1xyQKOLcOFb1Hy31dbh+/Qt2DakQkkjoXQWSu+xUdhqDZGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(186003)(55236004)(86362001)(30864003)(9686003)(316002)(6506007)(53546011)(55016002)(71200400001)(7416002)(6916009)(7406005)(54906003)(107886003)(966005)(76116006)(7696005)(8676002)(52536014)(66946007)(8936002)(64756008)(5660300002)(2906002)(4326008)(66476007)(478600001)(26005)(83380400001)(66446008)(66556008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHNFSlNJM0lXQkxSRUJMOVBLWkR3R2tSTzBWU29hYXJneERSUGRxYUlQVU5h?=
 =?utf-8?B?djJ5WEhITlh6VHFVbmRQTjYxK2RlMmtqVjhNVXFKbjBVT0l5cGViNzR6bTF2?=
 =?utf-8?B?djFaQWRaNVM2S0U0SmdOdXpsWUw0am9ocGViWUowNFY4Y1B5QmdLRjdyNTVX?=
 =?utf-8?B?dkV1RmNBTnlBQ0NmTUsxZXFRdHRvVEJmQ2d2NVpxTFVJV3B2V1F4bUl3SWpH?=
 =?utf-8?B?Um40bUFtaHdwRmxHa3M3bUFFTHcwVG9ITGkvS0V5T0xLTUx6c0JjM1NvT1VR?=
 =?utf-8?B?VE1XallvdmxES2t2aDh5Q1JCSVUzTDVHc2U2TE83RHZEajl1QzNTZ20rZ3ZI?=
 =?utf-8?B?VW1oaDBEbnkreVBjQ096QTJTVk40MllRZzhaZ1NoUC9LdEFQenFOdWdLdWxR?=
 =?utf-8?B?anFZbmlzNUtYS1AzK0RPRmcvMEI3TUxJSTRkczRWaHF4SVFmc0p2VHp6cXhB?=
 =?utf-8?B?a1l5MzJnQ3dZVTZQU2VjeU9QRkFBekpOd0xWZzlHZFVCRWtoamZlTHB5aGFT?=
 =?utf-8?B?STlQek1GMWQ5YURDR29pWEhYZlhCTThzNlpyRFRxeFR6eWFQV2ozNitRZm91?=
 =?utf-8?B?dmluUnpRQ1I1TDlROGhqM290aEZFVjMvYSs1RkNydzdyNUU1OFJMQWJWOEcr?=
 =?utf-8?B?RXJ5WDFNeFRkOHNEKzVBMTJiRTZjb2pCSC8rM2NaNGE5VGVWWWxtSkI4QWtD?=
 =?utf-8?B?akJHZVVOL0RqbVlCYUIyS3YvWm9SajVoZXdQRGx0VExaaHF6aUlhbmdtWE4w?=
 =?utf-8?B?SVU3bFlUcGxka1ZsRm1aYVVUS2c4aG55TnFlb21UaHZkTzNKYS82emxLenYw?=
 =?utf-8?B?MnY3NmlTWFZtQzRLWjJLZXBHREtpMVlZdWJwYTlmbW5zbE50MlhpdHRKYlVx?=
 =?utf-8?B?aDFLSXQ3bjdIeUVyMS9RNGU1YXVjZHVITEMwajRjcW9XWXB6eFAzanVucnJr?=
 =?utf-8?B?dmdoMUJWOHVXeVh6TEc2TFdNenJId2lTU3dueXBmeTV2dEY1NHlNMzB4aUtl?=
 =?utf-8?B?N0xlejh4a3gzeE9uVTRNb285SmkxVC9wYXJ1dHdsbElqYzVld053YjFSK1Mx?=
 =?utf-8?B?Q0tPWmc2R0dPdk9GRjZacE9zV0UxM1krY21WamxMUVBUbmlTNzVpU0VMbkN1?=
 =?utf-8?B?Y1RSU3l5bFl6ZDVTUmNBbEdGMTBjeGZVbFIzN0ZrZlFmazI5RTRIMGFIaGtF?=
 =?utf-8?B?UTl1NGxRMC9NMnM3c1hMZHR4YzN5Y2t4L20wd1UweDNuOHg0T0drSHJ5SThq?=
 =?utf-8?B?c0FPSjJSMkVESnFFN0Z2TnFoWjgrdXBjV25GenFjOUsyMHZLV0RpcE1Pc3F4?=
 =?utf-8?Q?xwxSqn4TPBNWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE32727B3F16DA4F8970A406D3C10999@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2446.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ab0cd3-a652-4b4c-939f-08d89d5c3384
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 22:37:39.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKPD9nUAReo7xGwF7zbnZsZ/xdxckk4ZymurlQPLrj8jAtBxFrvkPTCqZFLkckkMRJtF39jgfC8xtJtfQtdiTwPkzt+P2U9JacgBbcmqeIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3039
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQpPbiAxMC8xMi8yMDIwIDIwOjExLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPiBPbiBXZWQs
IERlYyA5LCAyMDIwIGF0IDM6MTggUE0gR2V2YSwgRXJleiA8ZXJlei5nZXZhLmV4dEBzaWVtZW5z
LmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDA5LzEyLzIwMjAgMTg6MzcsIFdpbGxlbSBkZSBC
cnVpam4gd3JvdGU6DQo+Pj4gT24gV2VkLCBEZWMgOSwgMjAyMCBhdCAxMDoyNSBBTSBHZXZhLCBF
cmV6IDxlcmV6LmdldmEuZXh0QHNpZW1lbnMuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4g
T24gMDkvMTIvMjAyMCAxNTo0OCwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToNCj4+Pj4+IE9uIFdl
ZCwgRGVjIDksIDIwMjAgYXQgOTozNyBBTSBFcmV6IEdldmEgPGVyZXouZ2V2YS5leHRAc2llbWVu
cy5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gQ29uZmlndXJlIGFuZCBzZW5kIFRYIHNlbmRp
bmcgaGFyZHdhcmUgdGltZXN0YW1wIGZyb20NCj4+Pj4+PiAgICAgdXNlciBzcGFjZSBhcHBsaWNh
dGlvbiB0byB0aGUgc29ja2V0IGxheWVyLA0KPj4+Pj4+ICAgICB0byBwcm92aWRlIHRvIHRoZSBU
QyBFVEMgUWRpc2MsIGFuZCBwYXNzIGl0IHRvDQo+Pj4+Pj4gICAgIHRoZSBpbnRlcmZhY2UgbmV0
d29yayBkcml2ZXIuDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgLSBOZXcgZmxhZyBmb3IgdGhlIFNPX1RY
VElNRSBzb2NrZXQgb3B0aW9uLg0KPj4+Pj4+ICAgICAtIE5ldyBhY2Nlc3MgYXV4aWxpYXJ5IGRh
dGEgaGVhZGVyIHRvIHBhc3MgdGhlDQo+Pj4+Pj4gICAgICAgVFggc2VuZGluZyBoYXJkd2FyZSB0
aW1lc3RhbXAuDQo+Pj4+Pj4gICAgIC0gQWRkIHRoZSBoYXJkd2FyZSB0aW1lc3RhbXAgdG8gdGhl
IHNvY2tldCBjb29raWUuDQo+Pj4+Pj4gICAgIC0gQ29weSB0aGUgVFggc2VuZGluZyBoYXJkd2Fy
ZSB0aW1lc3RhbXAgdG8gdGhlIHNvY2tldCBjb29raWUuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBFcmV6IEdldmEgPGVyZXouZ2V2YS5leHRAc2llbWVucy5jb20+DQo+Pj4+Pg0KPj4+
Pj4gSGFyZHdhcmUgb2ZmbG9hZCBvZiBwYWNpbmcgaXMgZGVmaW5pdGVseSB1c2VmdWwuDQo+Pj4+
Pg0KPj4+PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCj4+Pj4gSSBhZ3JlZSwgaXQgaXMgbm90
IGxpbWl0ZWQgb2YgdXNlLg0KPj4+Pg0KPj4+Pj4gSSBkb24ndCB0aGluayB0aGlzIG5lZWRzIGEg
bmV3IHNlcGFyYXRlIGgvdyB2YXJpYW50IG9mIFNPX1RYVElNRS4NCj4+Pj4+DQo+Pj4+IEkgb25s
eSBleHRlbmQgU09fVFhUSU1FLg0KPj4+DQo+Pj4gVGhlIHBhdGNoc2V0IHBhc3NlcyBhIHNlcGFy
YXRlIHRpbWVzdGFtcCBmcm9tIHNrYi0+dHN0YW1wIGFsb25nDQo+Pj4gdGhyb3VnaCB0aGUgaXAg
Y29va2llLCBjb3JrICh0cmFuc21pdF9od190aW1lKSBhbmQgd2l0aCB0aGUgc2tiIGluDQo+Pj4g
c2hpbmZvLg0KPj4+DQo+Pj4gSSBkb24ndCBzZWUgdGhlIG5lZWQgZm9yIHR3byB0aW1lc3RhbXBz
LCBvbmUgdGllZCB0byBzb2Z0d2FyZSBhbmQgb25lDQo+Pj4gdG8gaGFyZHdhcmUuIFdoZW4gd291
bGQgd2Ugd2FudCB0byBwYWNlIHR3aWNlPw0KPj4NCj4+IEFzIHRoZSBOZXQtTGluayB1c2VzIHN5
c3RlbSBjbG9jayBhbmQgdGhlIG5ldHdvcmsgaW50ZXJmYWNlIGhhcmR3YXJlIHVzZXMgaXQncyBv
d24gUEhDLg0KPj4gVGhlIGN1cnJlbnQgRVRGIGRlcGVuZHMgb24gc3luY2hyb25pemluZyB0aGUg
c3lzdGVtIGNsb2NrIGFuZCB0aGUgUEhDLg0KPiANCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3Rs
eSwgeW91IGFyZSB0cnlpbmcgdG8gYWNoaWV2ZSBhIHNpbmdsZSBkZWxpdmVyeSB0aW1lLg0KPiBU
aGUgbmVlZCBmb3IgdHdvIHNlcGFyYXRlIHRpbWVzdGFtcHMgcGFzc2VkIGFsb25nIGlzIG9ubHkg
YmVjYXVzZSB0aGUNCj4ga2VybmVsIGlzIHVuYWJsZSB0byBkbyB0aGUgdGltZSBiYXNlIGNvbnZl
cnNpb24uDQoNClllcywgYSBjb3JyZWN0IHBvaW50Lg0KDQo+IA0KPiBFbHNlLCBFVEYgY291bGQg
cHJvZ3JhbSB0aGUgcWRpc2Mgd2F0Y2hkb2cgaW4gc3lzdGVtIHRpbWUgYW5kIGxhdGVyLA0KPiBv
biBkZXF1ZXVlLCBjb252ZXJ0IHNrYi0+dHN0YW1wIHRvIHRoZSBoL3cgdGltZSBiYXNlIGJlZm9y
ZQ0KPiBwYXNzaW5nIGl0IHRvIHRoZSBkZXZpY2UuDQoNCk9yIHRoZSBza2ItPnRzdGFtcCBpcyBI
VyB0aW1lLXN0YW1wIGFuZCB0aGUgRVRGIGNvbnZlcnQgaXQgdG8gc3lzdGVtIGNsb2NrIGJhc2Vk
Lg0KDQo+IA0KPiBJdCdzIHN0aWxsIG5vdCBlbnRpcmVseSBjbGVhciB0byBtZSB3aHkgdGhlIHBh
Y2tldCBoYXMgdG8gYmUgaGVsZCBieQ0KPiBFVEYgaW5pdGlhbGx5IGZpcnN0LCBpZiBpdCBpcyBo
ZWxkIHVudGlsIGRlbGl2ZXJ5IHRpbWUgYnkgaGFyZHdhcmUNCj4gbGF0ZXIuIEJ1dCBtb3JlIG9u
IHRoYXQgYmVsb3cuDQoNCkxldCBwbG90IGEgc2ltcGxlIHNjZW5hcmlvLg0KQXBwIEEgc2VuZCBh
IHBhY2tldCB3aXRoIHRpbWUtc3RhbXAgMTAwLg0KQWZ0ZXIgYXJyaXZlIGEgc2Vjb25kIHBhY2tl
dCBmcm9tIEFwcCBCIHdpdGggdGltZS1zdGFtcCA5MC4NCldpdGhvdXQgRVRGLCB0aGUgc2Vjb25k
IHBhY2tldCB3aWxsIGhhdmUgdG8gd2FpdCB0aWxsIHRoZSBpbnRlcmZhY2UgaGFyZHdhcmUgc2Vu
ZCB0aGUgZmlyc3QgcGFja2V0IG9uIDEwMC4NCk1ha2luZyB0aGUgc2Vjb25kIHBhY2tldCBsYXRl
IGJ5IDEwICsgZmlyc3QgcGFja2V0IHNlbmQgdGltZS4NCk9idmlvdXNseSBvdGhlciAibm9ybWFs
IiBwYWNrZXRzIGFyZSBzZW5kIHRvIHRoZSBub24tRVRGIHF1ZXVlLCB0aG91Z2ggdGhleSBkbyBu
b3QgYmxvY2sgRVRGIHBhY2tldHMg8J+Yig0KDQpUaGUgRVRGIGRlbHRhIGlzIGEgYmFycmllciB0
aGF0IHRoZSBhcHBsaWNhdGlvbiBoYXZlIHRvIHNlbmQgdGhlIHBhY2tldCBiZWZvcmUgdG8gZW5z
dXJlIHRoZSBwYWNrZXQgZG8gbm90IHRvc3NlZC4NCg0KPiANCj4gU28gZmFyLCB0aGUgdXNlIGNh
c2Ugc291bmRzIGEgYml0IG5hcnJvdyBhbmQgdGhlIHVzZSBvZiB0d28gdGltZXN0YW1wDQo+IGZp
ZWxkcyBmb3IgYSBzaW5nbGUgZGVsaXZlcnkgZXZlbnQgYSBiaXQgb2YgYSBoYWNrLg0KDQpUaGUg
ZGVmaW5pdGlvbiBvZiBhIGhhY2sgaXMgdXAgdG8geW91IPCfmIoNCg0KPiANCj4gQW5kIG9uZSB0
aGF0IGRvZXMgaW1wb3NlIGEgY29zdCBpbiB0aGUgaG90IHBhdGggb2YgbWFueSB3b3JrbG9hZHMN
Cj4gYnkgYWRkaW5nIGEgZmllbGQgdGhlIGlwIGNvb2tpZSwgY29yayBhbmQgd3JpdGluZyB0byAo
cG9zc2libHkgY29sZCkNCj4gc2tiX3NoaW5mbyBmb3IgZXZlcnkgcGFja2V0Lg0KDQpNb3N0IHBh
Y2tldHMgZG8gbm90IHVzZSBza2ItPnRzdGFtcCBlaXRoZXIsIHByb2JhYmx5IHRoZSBjb3N0IG9m
IHRlc3RpbmcgaXMgaGlnaGVyIHRoZW4ganVzdCBjb3B5aW5nLg0KQnV0IHBlcmhhcHMgaWYgd2Ug
Y29weSAyIHRpbWUtc3RhbXAgd2UgY2FuIGFkZCBhIGNvbmRpdGlvbiBmb3IgYm90aC4NCldoYXQg
ZG8geW91IHRoaW5rPw0KDQpUaGUgY29va2llIGFuZCB0aGUgY29yayBhcmUganVzdCBpbnRlcm1l
ZGlhdGUgZnJvbSBhcHBsaWNhdGlvbiB0byBTS0IsIEkgZG8gbm90IHRoaW5rIHRoZXkgY29zdCBt
dWNoLg0KQm90aCB3cml0ZXMgb2YgdGltZSBzdGFtcCB0byB0aGUgY29va2llIGFuZCB0aGUgY29y
ayBhcmUgY29uZGl0aW9uZWQuDQoNCj4gDQo+Pj4+PiBJbmRlZWQsIHdlIHdhbnQgcGFjaW5nIG9m
ZmxvYWQgdG8gd29yayBmb3IgZXhpc3RpbmcgYXBwbGljYXRpb25zLg0KPj4+Pj4NCj4+Pj4gQXMg
dGhlIGNvbnZlcnNpb24gb2YgdGhlIFBIQyBhbmQgdGhlIHN5c3RlbSBjbG9jayBpcyBkeW5hbWlj
IG92ZXIgdGltZS4NCj4+Pj4gSG93IGRvIHlvdSBwcm9wc2UgdG8gYWNoaXZlIGl0Pw0KPj4+DQo+
Pj4gQ2FuIHlvdSBlbGFib3JhdGUgb24gdGhpcyBjb25jZXJuPw0KPj4NCj4+IFVzaW5nIHNpbmds
ZSB0aW1lIHN0YW1wIGhhdmUgMyBwb3NzaWJsZSBzb2x1dGlvbnM6DQo+Pg0KPj4gMS4gQ3VycmVu
dCBzb2x1dGlvbiwgc3luY2hyb25pemUgdGhlIHN5c3RlbSBjbG9jayBhbmQgdGhlIFBIQy4NCj4+
ICAgICAgQXBwbGljYXRpb24gdXNlcyB0aGUgc3lzdGVtIGNsb2NrLg0KPj4gICAgICBUaGUgRVRG
IGNhbiB1c2UgdGhlIHN5c3RlbSBjbG9jayBmb3Igb3JkZXJpbmcgYW5kIHBhc3MgdGhlIHBhY2tl
dCB0byB0aGUgZHJpdmVyIG9uIHRpbWUNCj4+ICAgICAgVGhlIG5ldHdvcmsgaW50ZXJmYWNlIGhh
cmR3YXJlIGNvbXBhcmUgdGhlIHRpbWUtc3RhbXAgdG8gdGhlIFBIQy4NCj4+DQo+PiAyLiBUaGUg
YXBwbGljYXRpb24gY29udmVydCB0aGUgUEhDIHRpbWUtc3RhbXAgdG8gc3lzdGVtIGNsb2NrIGJh
c2VkLg0KPj4gICAgICAgVGhlIEVURiB3b3JrcyBhcyBzb2x1dGlvbiAxDQo+PiAgICAgICBUaGUg
bmV0d29yayBkcml2ZXIgY29udmVydCB0aGUgc3lzdGVtIGNsb2NrIHRpbWUtc3RhbXAgYmFjayB0
byBQSEMgdGltZS1zdGFtcC4NCj4+ICAgICAgIFRoaXMgc29sdXRpb24gbmVlZCBhIG5ldyBOZXQt
TGluayBmbGFnIGFuZCBtb2RpZnkgdGhlIHJlbGV2YW50IG5ldHdvcmsgZHJpdmVycy4NCj4+ICAg
ICAgIFlldCB0aGlzIHNvbHV0aW9uIGhhdmUgMiBwcm9ibGVtczoNCj4+ICAgICAgICogQXMgYXBw
bGljYXRpb25zIHRvZGF5IGFyZSBub3QgYXdhcmUgdGhhdCBzeXN0ZW0gY2xvY2sgYW5kIFBIQyBh
cmUgbm90IHN5bmNocm9uaXplZCBhbmQNCj4+ICAgICAgICAgIHRoZXJlZm9yZSBkbyBub3QgcGVy
Zm9ybSBhbnkgY29udmVyc2lvbiwgbW9zdCBvZiB0aGVtIG9ubHkgdXNlIHRoZSBzeXN0ZW0gY2xv
Y2suDQo+PiAgICAgICAqIEFzIHRoZSBjb252ZXJzaW9uIGluIHRoZSBuZXR3b3JrIGRyaXZlciBo
YXBwZW5zIH4zMDAgLSA2MDAgbWljcm9zZWNvbmRzIGFmdGVyDQo+PiAgICAgICAgICB0aGUgYXBw
bGljYXRpb24gc2VuZCB0aGUgcGFja2V0Lg0KPj4gICAgICAgICAgQW5kIGFzIHRoZSBQSEMgYW5k
IHN5c3RlbSBjbG9jayBmcmVxdWVuY2llcyBhbmQgb2Zmc2V0IGNhbiBjaGFuZ2UgZHVyaW5nIHRo
aXMgcGVyaW9kLg0KPj4gICAgICAgICAgVGhlIGNvbnZlcnNpb24gd2lsbCBwcm9kdWNlIGEgZGlm
ZmVyZW50IFBIQyB0aW1lLXN0YW1wIGZyb20gdGhlIGFwcGxpY2F0aW9uIG9yaWdpbmFsIHRpbWUt
c3RhbXAuDQo+PiAgICAgICAgICBXZSByZXF1aXJlIGEgcHJlY2Vzc2lvbiBvZiAxIG5hbm9zZWNv
bmRzIG9mIHRoZSBQSEMgdGltZS1zdGFtcC4NCj4+DQo+PiAzLiBUaGUgYXBwbGljYXRpb24gdXNl
cyBQSEMgdGltZS1zdGFtcCBmb3Igc2tiLT50c3RhbXANCj4+ICAgICAgVGhlIEVURiBjb252ZXJ0
IHRoZSAgUEhDIHRpbWUtc3RhbXAgdG8gc3lzdGVtIGNsb2NrIHRpbWUtc3RhbXAuDQo+PiAgICAg
IFRoaXMgc29sdXRpb24gcmVxdWlyZSBpbXBsZW1lbnRhdGlvbnMgb24gc3VwcG9ydGluZyByZWFk
aW5nIFBIQyBjbG9ja3MNCj4+ICAgICAgZnJvbSBJUlEva2VybmVsIHRocmVhZCBjb250ZXh0IGlu
IGtlcm5lbCBzcGFjZS4NCj4gDQo+IEVURiBoYXMgdG8gcmVsZWFzZSB0aGUgcGFja2V0IHdlbGwg
aW4gYWR2YW5jZSBvZiB0aGUgaGFyZHdhcmUNCj4gdGltZXN0YW1wIGZvciB0aGUgcGFja2V0IHRv
IGFycml2ZSBhdCB0aGUgZGV2aWNlIG9uIHRpbWUuIEluIHByYWN0aWNlDQo+IEkgd291bGQgZXhw
ZWN0IHRoaXMgZGVsdGEgcGFyYW1ldGVyIHRvIGJlIGF0IGxlYXN0IGF0IHVzZWMgdGltZXNjYWxl
Lg0KPiBUaGF0IGdpdmVzIHNvbWUgd2lnZ2xlIHJvb20gd2l0aCByZWdhcmQgdG8gcy93IHRzdGFt
cCwgYXQgbGVhc3QuDQoNClllcywgdGhlIGF1dGhvciBvZiB0aGUgRVRGIHVzZXMgYSBkZWx0YSBv
ZiAzMDAgdXNlYy4NClRoZSBpbnRlcmZhY2UgSSB1c2UgZm9yIHRlc3RpbmcsIEludGVsIEkyMTAg
bmVlZCBhcm91bmQgMTAwIHVzZWMgdG8gMTUwIHVzZWMuDQpJIGJlbGlldmUgaXQgaXMgcmVsYXRl
ZCB0byBQQ0llIHNwZWVkIG9mIHRyYW5zZmVycmluZyB0aGUgZGF0YSBvbiB0aW1lIGFuZCBwcm9i
YWJseSBzaW1pbGFyIHRvIG90aGVyIGludGVyZmFjZXMgdXNpbmcgUENJZS4NCklmIHlvdSBvdmVy
ZmxvdyB0aGUgaW50ZXJmYWNlIGhhcmR3YXJlIHdpdGggaGlnaCB0cmFmZmljIHRoZSBkZWx0YSBp
cyBtdWNoIGhpZ2hlci4NClRoZSBjbG9ja3MgY29udmVyc2lvbiBlcnJvciBvZiB0aGUgYXBwbGlj
YXRpb24gaXMgY2hhcmFjdGVyaXN0aWMgYXJvdW5kIH4xIHVzZWMgdG8gNSB1c2VjIGZvciB1cCB0
byAxMCBtcyBzZW5kaW5nIGEgaGVhZC4NCg0KPiANCj4gSWYgY2hhbmdlcyBpbiBjbG9jayBkaXN0
YW5jZSBhcmUgcmVsYXRpdmVseSBpbmZyZXF1ZW50LCBjb3VsZCB0aGlzDQo+IGNsb2NrIGRpZmYg
YmUgYSBxZGlzYyBwYXJhbWV0ZXIsIHVwZGF0ZWQgaW5mcmVxdWVudGx5IG91dHNpZGUgdGhlDQo+
IHBhY2tldCBwYXRoPw0KDQpBcyB0aGUgY2xvY2tzIGFyZSB1cGRhdGluZyBvZiBib3RoIGZyZXF1
ZW5jeSBhbmQgb2Zmc2V0IGR5bmFtaWNhbGx5IG1ha2UgaXQgdmVyeSBoYXJkIHRvIHBlcmZvcm0u
DQpUaGUgcmF0ZSBvZiB0aGUgdXBkYXRlIG9mIHRoZSBQSEMgZGVwZW5kcyBvbiBQVFAgc2V0dGlu
ZyAodXN1YWxseSBhcm91bmQgMSBzZWNvbmQpLg0KVGhlIHJhdGUgb2YgdGhlIHVwZGF0ZSBvZiB0
aGUgc3lzdGVtIGNsb2NrIGRlcGVuZHMgaG93IHlvdSBzeW5jaHJvbml6ZSBpdCAoIEkgYXNzdW1l
IGl0IGlzIHNpbWlsYXIgb3Igc2xvd2VyKS4NCkJ1dCB1c2VyIG1heSByZXF1aXJlIGFuZCB1c2Ug
aGlnaGVyIHJhdGVzLiBJdCBpcyBvbmx5IHBlbmFsdHkgYnkgbW9yZSB0cmFmZmljIGFuZCBDUFUu
DQpCYXJlIGluIG1pbmQgdGhlIDIgY2xvY2tzIHN5bmNocm9uaXphdGlvbiBhcmUgaW5kZXBlbmRl
bnQsIHRoZSBjcm9zcyBjYW4gYmUgdW5wcmVkaWN0YWJsZS4NCg0KVGhlIEVURiB3b3VsZCBoYXZl
IHRvICJrbm93IiBvbiB3aGljaCBwYWNrZXRzIHdlIHVzZSB0aGUgcHJldmlvdXMgdXBkYXRlIGFu
ZCB3aGljaCBhcmUgdGhlIGxhc3QgdXBkYXRlLg0KQW5kIGhvcGUgd2UgZG8gbm90ICJtaXNzIiB1
cGRhdGVzLg0KDQpBbmQgd2Ugd291bGQgbmVlZCBhICJzZXJ2aWNlIiB0byB1cGRhdGUgdGhlc2Ug
dmFsdWVzIHdpdGggcHJvcGVyIGNvbmZpZ3VyYXRpb24sIHNvdW5kIGxpa2Ugb3ZlcmhlYWQgdG8g
bWUuDQoNCkFub3RoZXIgcG9pbnQuDQpUaGUgZGVsdGEgaW5jbHVkZXMgdGhlIFBDSWUgRE1BIHRy
YW5zZmVyIHNwZWVkLCB0aGlzIGlzIGEgaGFyZHdhcmUgbGltaXRhdGlvbi4NClRoZSBpZGVhIG9m
IFRTTiBpcyB0aGF0IHRoZSBhcHBsaWNhdGlvbiBzZW5kIHRoZSBwYWNrZXQgYXMgY2xvc2VyIGFz
IHBvc3NpYmxlIHRvIHRoZSBoYXJkd2FyZSBzZW5kLg0KSW5jcmVhc2UgdGhlIGVycm9yIG9mIHRo
ZSBjbG9ja3MgY29udmVyc2lvbiBkZWZ5IHRoZSBwdXJwb3NlIG9mIFRTTi4NCg0KQSBtb3JlIHJl
YXNvbmFibGUgaXMgdG8gdHJhY2sgdGhlIGNsb2NrcyBpbnNpZGUgdGhlIGtlcm5lbC4NCkFzIHdl
IG1lbnRpb24gb24gc29sdXRpb24gMy4NCg0KPiANCj4gSXQgd291bGQgZXZlbiBiZSBwcmVmZXJh
YmxlIGlmIHRoZSBxZGlzYyBhbmQgY29yZSBzdGFjayBjb3VsZCBiZQ0KPiBpZ25vcmFudCBvZiBz
dWNoIGhhcmR3YXJlIGNsb2NrcyBhbmQgdGhlIHRpbWUgYmFzZSBpcyBjb252ZXJ0ZWQgYnkgdGhl
DQo+IGRldmljZSBkcml2ZXIgd2hlbiBlbmNvZGluZyBza2ItPnRzdGFtcCBpbnRvIHRoZSB0eCBk
ZXNjcmlwdG9yLiBJcyB0aGUNCj4gZGV2aWNlIGhhcmR3YXJlIGNsb2NrIHJlYWRhYmxlIGJ5IHRo
ZSBkcml2ZXI/DQoNCkFsbCBkcml2ZXJzIHRoYXQgc3VwcG9ydCBQVFAgKElFRUUgMTU1OCkgaGF2
ZSB0byByZWFkIHRoZSBQSEMuDQpQVFAgaXMgbWFuZGF0b3J5IGZvciBUU04uDQpCdXQgc29tZSBk
cml2ZXJzIG1pZ2h0IGJlIGxpbWl0ZWQgb24gd2hpY2ggY29udGV4dCB0aGV5IGNhbiByZWFkIHRo
ZSBQSEMuDQpUaGlzIGlzIGEgcXVlc3Rpb24gdG8gdGhlIHZlbmRvcnMuDQpGb3IgZXhhbXBsZSBJ
bnRlbCBJMjEwIGFsbG93IHJlYWRpbmcgdGhlIFBIQy4NCg0KSG93ZXZlciB0aGUga2VybmVsIFBP
U0lYIGxheWVyIHVzZXMgYXBwbGljYXRpb24gY29udGV4dCBsb2NraW5ncy4NCg0KPiANCj4gIEZy
b20gdGhlIGFib3ZlLCBpdCBzb3VuZHMgbGlrZSB0aGlzIGlzIG5vdCB0cml2aWFsLg0KDQpJIGFt
IG5vdCBzdXJlIGlmIGl0IHNvIGNvbXBsaWNhdGVkLg0KQnV0IGFzIHRoZSBMaW51eCBtYWludGFp
bmVycyB3YW50IHRvIGtlZXAgdGhlIExpbnV4IGtlcm5lbCB3aXRoIGEgc2luZ2xlIHN5c3RlbSBj
bG9jay4NCkl0IG1pZ2h0IGJlIG1vcmUgb2YgYSBwb2xpdGljYWwgcXVlc3Rpb24sIG9yIHBlcmhh
cHMgYSBiZXR0ZXIgcGxhbm5pbmcgdGhlbiBJIGRpZC4NCg0KPiANCj4gSSBkb24ndCBrbm93IHdo
aWNoIGV4YWN0IGRldmljZSB5b3UncmUgdGFyZ2V0aW5nLiBJcyBpdCBhbiBpbi10cmVlIGRyaXZl
cj8NCg0KRVRGIHVzZXMgZXRoZXJuZXQgaW50ZXJmYWNlcyB3aXRoIElFRUUgMTU1OCBhbmQgODAy
LjFRYnYgb3IgODAyLjFRYnUuDQpJbnRlcmZhY2VzIHRoYXQgc3VwcG9ydCBUU04sIGh0dHBzOi8v
ZW4ud2lraXBlZGlhLm9yZy93aWtpL1RpbWUtU2Vuc2l0aXZlX05ldHdvcmtpbmcNCkkgdXNlIElu
dGVsIEkyMTAgYXQgdGhlIG1vbWVudC4NCkFzIG9mIDUuMTAtcmM2LCB0aGVyZSBhcmUgNCBkcml2
ZXJzDQprZXJuZWwtZXRmL2RyaXZlcnMvbmV0L2V0aGVybmV0IChldGYtNS4xMC1yYzYpJCBmaW5k
IC1uYW1lICcqLmMnIHwgeGFyZ3MgZ3JlcCAtciBUQ19TRVRVUF9RRElTQ19FVEYNCi4vZnJlZXNj
YWxlL2VuZXRjL2VuZXRjLmM6CQljYXNlIFRDX1NFVFVQX1FESVNDX0VURjoNCi4vc3RtaWNyby9z
dG1tYWMvc3RtbWFjX21haW4uYzoJY2FzZSBUQ19TRVRVUF9RRElTQ19FVEY6DQouL2ludGVsL2ln
Yy9pZ2NfbWFpbi5jOgkJCWNhc2UgVENfU0VUVVBfUURJU0NfRVRGOg0KLi9pbnRlbC9pZ2IvaWdi
X21haW4uYzoJCQljYXNlIFRDX1NFVFVQX1FESVNDX0VURjoNClRoZXJlIGFyZSBtb3JlIHZlbmRv
cnMgbGlrZQ0KICBSZW5lc2FzIHRoYXQgaGF2ZSBhIGRyaXZlciBmb3IgdGhlIFJaLUcgU09DLg0K
ICBCcm9hZGNvbSBoYXZlIGNoaXBzIHRoYXQgc3VwcG9ydCBUU04sIGJ1dCB0aGV5IGRvIG5vdCBw
dWJsaXNoIHRoZSBjb2RlLg0KSSBiZWxpZXZlIHRoYXQgb3RoZXIgdmVuZG9ycyB3aWxsIGFkZCBU
U04gc3VwcG9ydCBhcyBpdCBiZWNvbWVzIG1vcmUgcG9wdWxhci4NCg0KPiANCj4+IEp1c3QgZm9y
IGNsYXJpZmljYXRpb246DQo+PiBFVEYgYXMgYWxsIE5ldC1MaW5rLCBvbmx5IHVzZXMgc3lzdGVt
IGNsb2NrICh0aGUgVEFJKQ0KPj4gVGhlIG5ldHdvcmsgaW50ZXJmYWNlIGhhcmR3YXJlIG9ubHkg
dXNlcyB0aGUgUEhDLg0KPj4gTm9yIE5ldC1MaW5rIG5laXRoZXIgdGhlIGRyaXZlciBwZXJmb3Jt
IGFueSBjb252ZXJzaW9ucy4NCj4+IFRoZSBLZXJuZWwgZG9lcyBub3QgcHJvdmlkZSBhbmQgY2xv
Y2sgY29udmVyc2lvbiBiZXNpZGUgc3lzdGVtIGNsb2NrLg0KPj4gTGludXgga2VybmVsIGlzIGEg
c2luZ2xlIGNsb2NrIHN5c3RlbS4NCj4+DQo+Pj4NCj4+PiBUaGUgc2ltcGxlc3Qgc29sdXRpb24g
Zm9yIG9mZmxvYWRpbmcgcGFjaW5nIHdvdWxkIGJlIHRvIGludGVycHJldA0KPj4+IHNrYi0+dHN0
YW1wIGVpdGhlciBmb3Igc29mdHdhcmUgcGFjaW5nLCBvciBza2lwIHNvZnR3YXJlIHBhY2luZyBp
ZiB0aGUNCj4+PiBkZXZpY2UgYWR2ZXJ0aXNlcyBhIE5FVElGX0YgaGFyZHdhcmUgcGFjaW5nIGZl
YXR1cmUuDQo+Pg0KPj4gVGhhdCB3aWxsIGRlZnkgdGhlIHB1cnBvc2Ugb2YgRVRGLg0KPj4gRVRG
IGV4aXN0IGZvciBvcmRlcmluZyBwYWNrZXRzLg0KPj4gV2h5IHNob3VsZCB0aGUgZGV2aWNlIGRy
aXZlciBkZWZlciBpdD8NCj4+IFNpbXBseSBkbyBub3QgdXNlIHRoZSBRRElTQyBmb3IgdGhpcyBp
bnRlcmZhY2UuDQo+IA0KPiBFVEYgcXVldWVzIHBhY2tldHMgdW50aWwgdGhlaXIgZGVsaXZlcnkg
dGltZSBpcyByZWFjaGVkLiBJdCBkb2VzIG5vdA0KPiBvcmRlciBmb3IgYW55IG90aGVyIHJlYXNv
biB0aGFuIHRvIGNhbGN1bGF0ZSB0aGUgbmV4dCBxZGlzYyB3YXRjaGRvZw0KPiBldmVudCwgcmVh
bGx5Lg0KDQpObywgRVRGIGFsc28gb3JkZXIgdGhlIHBhY2tldHMgb24gLmVucXVldWUgPSBldGZf
ZW5xdWV1ZV90aW1lc29ydGVkbGlzdCgpDQpPdXIgcGF0Y2ggc3VnZ2VzdCB0byBvcmRlciB0aGVt
IGJ5IGhhcmR3YXJlIHRpbWUgc3RhbXAuDQpBbmQgbGVhdmUgdGhlIHdhdGNoZG9nIHNldHRpbmcg
dXNpbmcgc2tiLT50c3RhbXAgdGhhdCBob2xkIHN5c3RlbSBjbG9jayBUQUkgdGltZS1zdGFtcC4N
Cg0KPiANCj4gSWYgaC93IGNhbiBkbyB0aGUgc2FtZSBhbmQgdGhlIGRyaXZlciBjYW4gY29udmVy
dCBza2ItPnRzdGFtcCB0byB0aGUNCj4gcmlnaHQgdGltZWJhc2UsIGluZGVlZCBubyBxZGlzYyBp
cyBuZWVkZWQgZm9yIHBhY2luZy4gQnV0IHRoZXJlIG1heSBiZQ0KPiBhIG5lZWQgZm9yIHNlbGVj
dGl2ZSBoL3cgb2ZmbG9hZCBpZiBoL3cgaGFzIGFkZGl0aW9uYWwgY29uc3RyYWludHMsDQo+IHN1
Y2ggYXMgb24gdGhlIG51bWJlciBvZiBwYWNrZXRzIG91dHN0YW5kaW5nIG9yIHRpbWUgaG9yaXpv
bi4NCg0KVGhlIGRyaXZlciBkbyBub3Qgb3JkZXIgdGhlIHBhY2tldHMsIGl0IHNlbmQgcGFja2V0
cyBpbiB0aGUgb3JkZXIgb2YgYXJyaXZhbC4NCldlIGNhbiBhZGQgRVRGIGNvbXBvbmVudCB0byBl
YWNoIHJlbGV2YW50IGRyaXZlciwgYnV0IGRvIHdlIHdhbnQgdG8gYWRkIE5ldC1MaW5rIGZlYXR1
cmVzIHRvIGRyaXZlcnM/DQpJIHRoaW5rIHRoZSBwdXJwb3NlIGlzIHRvIG1ha2UgdGhlIGRyaXZl
cnMgYXMgc21hbGwgYXMgcG9zc2libGUgYW5kIGxlYXZlIGNvbW1vbiBpbnRlbGxpZ2VuY2UgaW4g
dGhlIE5ldC1MaW5rIGxheWVyLg0KDQo+IA0KPj4+DQo+Pj4gQ2xvY2tiYXNlIGlzIGFuIGlzc3Vl
LiBUaGUgZGV2aWNlIGRyaXZlciBtYXkgaGF2ZSB0byBjb252ZXJ0IHRvDQo+Pj4gd2hhdGV2ZXIg
Zm9ybWF0IHRoZSBkZXZpY2UgZXhwZWN0cyB3aGVuIGNvcHlpbmcgc2tiLT50c3RhbXAgaW4gdGhl
DQo+Pj4gZGV2aWNlIHR4IGRlc2NyaXB0b3IuDQo+Pg0KPj4gV2UgZG8gaG9wZSBvdXIgZGVmaW5p
dGlvbiBpcyBjbGVhci4NCj4+IEluIHRoZSBjdXJyZW50IGtlcm5lbCBza2ItPnRzdGFtcCB1c2Vz
IHN5c3RlbSBjbG9jay4NCj4+IFRoZSBoYXJkd2FyZSB0aW1lLXN0YW1wIGlzIFBIQyBiYXNlZCwg
YXMgaXQgaXMgdXNlZCB0b2RheSBmb3IgUFRQIHR3byBzdGVwcy4NCj4+IFdlIG9ubHkgcHJvcG9z
ZSB0byB1c2UgdGhlIHNhbWUgaGFyZHdhcmUgdGltZS1zdGFtcC4NCj4+DQo+PiBQYXNzaW5nIHRo
ZSBoYXJkd2FyZSB0aW1lLXN0YW1wIHRvIHRoZSBza2ItPnRzdGFtcCBtaWdodCBzZWVtcyBhIGJp
dCB0cmlja3kNCj4+IFRoZSBnYW9sIGlzIHRoZSBsZWF2ZSB0aGUgZHJpdmVyIHVuYXdhcmUgdG8g
d2hldGhlciB3ZQ0KPj4gKiBTeW5jaHJvbml6aW5nIHRoZSBQSEMgYW5kIHN5c3RlbSBjbG9jaw0K
Pj4gKiBUaGUgRVRGIHBhc3MgdGhlIGhhcmR3YXJlIHRpbWUtc3RhbXAgdG8gc2tiLT50c3RhbXAN
Cj4+IE9ubHkgdGhlIGFwcGxpY2F0aW9ucyBhbmQgdGhlIEVURiBhcmUgYXdhcmUuDQo+PiBUaGUg
YXBwbGljYXRpb24gY2FuIGRldGVjdCBieSBjaGVja2luZyB0aGUgRVRGIGZsYWcuDQo+PiBUaGUg
RVRGIGZsYWdzIGFyZSBwYXJ0IG9mIHRoZSBuZXR3b3JrIGFkbWluaXN0cmF0aW9uLg0KPj4gVGhh
dCBhbHNvIGNvbmZpZ3VyZSB0aGUgUFRQIGFuZCB0aGUgc3lzdGVtIGNsb2NrIHN5bmNocm9uaXph
dGlvbi4NCj4+DQo+Pj4NCj4+Pj4NCj4+Pj4+IEl0IG9ubHkgcmVxdWlyZXMgdGhhdCBwYWNpbmcg
cWRpc2NzLCBib3RoIHNjaF9ldGYgYW5kIHNjaF9mcSwNCj4+Pj4+IG9wdGlvbmFsbHkgc2tpcCBx
dWV1aW5nIGluIHRoZWlyIC5lbnF1ZXVlIGNhbGxiYWNrIGFuZCBpbnN0ZWFkIGFsbG93DQo+Pj4+
PiB0aGUgc2tiIHRvIHBhc3MgdG8gdGhlIGRldmljZSBkcml2ZXIgYXMgaXMsIHdpdGggc2tiLT50
c3RhbXAgc2V0LiBPbmx5DQo+Pj4+PiB0byBkZXZpY2VzIHRoYXQgYWR2ZXJ0aXNlIHN1cHBvcnQg
Zm9yIGgvdyBwYWNpbmcgb2ZmbG9hZC4NCj4+Pj4+DQo+Pj4+IEkgZGlkIG5vdCB1c2UgIkZhaXIg
UXVldWUgdHJhZmZpYyBwb2xpY2luZyIuDQo+Pj4+IEFzIGZvciBFVEYsIGl0IGlzIGFsbCBhYm91
dCBvcmRlcmluZyBwYWNrZXRzIGZyb20gZGlmZmVyZW50IGFwcGxpY2F0aW9ucy4NCj4+Pj4gSG93
IGNhbiB3ZSBhY2hpdmUgaXQgd2l0aCBza2lwaW5nIHF1ZXVpbmc/DQo+Pj4+IENvdWxkIHlvdSBl
bGFib3JhdGUgb24gdGhpcyBwb2ludD8NCj4+Pg0KPj4+IFRoZSBxZGlzYyBjYW4gb25seSBkZWZl
ciBwYWNpbmcgdG8gaGFyZHdhcmUgaWYgaGFyZHdhcmUgY2FuIGVuc3VyZSB0aGUNCj4+PiBzYW1l
IGludmFyaWFudHMgb24gb3JkZXJpbmcsIG9mIGNvdXJzZS4NCj4+DQo+PiBZZXMsIHRoaXMgaXMg
d2h5IHdlIHN1Z2dlc3QgRVRGIG9yZGVyIHBhY2tldHMgdXNpbmcgdGhlIGhhcmR3YXJlIHRpbWUt
c3RhbXAuDQo+PiBBbmQgcGFzcyB0aGUgcGFja2V0IGJhc2VkIG9uIHN5c3RlbSB0aW1lLg0KPj4g
U28gRVRGIHF1ZXJ5IHRoZSBzeXN0ZW0gY2xvY2sgb25seSBhbmQgbm90IHRoZSBQSEMuDQo+IA0K
PiBPbiB3aGljaCBub3RlOiB3aXRoIHRoaXMgcGF0Y2ggc2V0IGFsbCBhcHBsaWNhdGlvbnMgaGF2
ZSB0byBhZ3JlZSB0bw0KPiB1c2UgaC93IHRpbWUgYmFzZSBpbiBldGZfZW5xdWV1ZV90aW1lc29y
dGVkbGlzdC4gSW4gcHJhY3RpY2UgdGhhdA0KPiBtYWtlcyB0aGlzIGgvdyBtb2RlIGEgcWRpc2Mg
dXNlZCBieSBhIHNpbmdsZSBwcm9jZXNzPw0KDQpBIHNpbmdsZSBwcm9jZXNzIHRoZW9yZXRpY2Fs
bHkgZG9lcyBub3QgbmVlZCBFVEYsIGp1c3Qgc2V0IHRoZSBza2ItPiB0c3RhbXAgYW5kIHVzZSBh
IHBhc3MgdGhyb3VnaCBxdWV1ZS4NCkhvd2V2ZXIgdGhlIG9ubHkgd2F5IG5vdyB0byBzZXQgVENf
U0VUVVBfUURJU0NfRVRGIGluIHRoZSBkcml2ZXIgaXMgdXNpbmcgRVRGLg0KDQpUaGUgRVRGIFFE
SVNDIGlzIHBlciBuZXR3b3JrIGludGVyZmFjZS4NClNvIGFsbCBhcHBsaWNhdGlvbiB0aGF0IHVz
ZXMgYSBzaW5nbGUgbmV0d29yayBpbnRlcmZhY2UgaGF2ZSB0byBjb21wbHkgdG8gdGhlIFFESVND
IGNvbmZpZ3VyYXRpb24uDQpTb3VuZCBsaWtlIGFueSBvdGhlciBuZXcgZmVhdHVyZSBpbiB0aGUg
TmV0TGluay4NCg0KVGhlb3JldGljYWxseSBhIHNpbmdsZSBuZXR3b3JrIGludGVyZmFjZSBjb3Vs
ZCBwYXJ0aWNpcGF0ZSBpbiAyIFRTTi9QVFAgZG9tYWlucy4NCkluIHRoYXQgY2FzZSB5b3UgY2Fu
IGNyZWF0ZSBvbmUgUURJU0Mgd2l0aG91dCAidXNlIGhhcmR3YXJlIHRpbWUtc3RhbXAiIGZvciBm
aXJzdCBUU04vUFRQIGRvbWFpbiBhbmQgc3luY2hyb25pemUgdGhlIFBIQyB0byBzeXN0ZW0gY2xv
Y2suDQpBbmQgdXNlIHRoZSBzZWNvbmQgb25lIHdpdGggYSBRRElTQyB0aGF0IHVzZSBoYXJkd2Fy
ZSB0aW1lLXN0YW1wLg0KWW91IHdpbGwgbmVlZCBhIGRyaXZlci9oYXJkd2FyZSB0aGF0IHN1cHBv
cnQgbXVsdGlwbGUgUEhDcy4NClRoZSBzZXBhcmF0aW9uIG9mIHRoZSBkb21haW5zIGNvdWxkIGJl
IHVzaW5nIFZMQU5zLg0KDQpOb3RlOiBBIFRTTiBkb21haW4gaXMgYm91bmQgdG8gYSBQVFAgZG9t
YWluLg0KDQo+IA0KPj4+DQo+Pj4gQnR3OiB0aGlzIGlzIHF1aXRlIGEgbG9uZyBsaXN0IG9mIEND
OnMNCj4+Pg0KPj4gSSBuZWVkIHRvIHVwZGF0ZSBteSBjb21wYW55IGNvbGxlYWd1ZXMgYXMgd2Vs
bCBhcyB0aGUgTGludXggZ3JvdXAuDQo+IA0KPiBPZiBjb3Vyc2UuIEJ1dCBldmVuIGlnbm9yaW5n
IHRoYXQgdGhpcyBpcyBzdGlsbCBxdWl0ZSBhIGxhcmdlIGxpc3QgKD4gNDApLg0KPiANCj4gTXkg
cmVzcG9uc2UgeWVzdGVyZGF5IHdhcyBhY3R1YWxseSBibG9ja2VkIGFzIGEgcmVzdWx0IDspIFJl
dHJ5aW5nIG5vdy4NCj4gDQoNCkkgbGVmdCA1IHBlb3BsZSBmcm9tIFNpZW1lbnMsIEkgaG9wZSBp
dCBpbXByb3Zlcy4NCg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIGVubGlnaHRlbm1l
bnRzLCB0aGV5IGFyZSB2ZXJ5IHVzZWZ1bA0KICAgRXJleg0K
