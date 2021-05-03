Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC396372049
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECTTj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 15:19:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60694 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhECTTj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 15:19:39 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7966BC000E;
        Mon,  3 May 2021 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1620069525; bh=RLFhFcct3sZyHHEEdlld+8h7UrRO1toxzcabCPMoraY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gXNl6ueiNIpVNa+W87QeNOsaXVo+WliP0nGs7Ryky050wIUZaRx0KrDl79J+rmpkG
         qzDo2smYuMhXMdZR55q22kdewCXKIziXq3/Q47QkprqMPlBgdtn6eBj+hRzPYQM1Xj
         wWzOjpRmOoH27BAP7zjbDiIqDsRMiNOUHUHHqjNMZFPA2U/xf8RWNjoaKB6Xa9pOuf
         s+2zxuFntBuJg/Znza/lnYM1ROorwtI8eW9ML8Ht5qvTLU/RPYdyL5Jw4mTLfYQ8xB
         xWSRsZaNsjgtbXapr2NSiUS2JVdK/7te0rsdBRiXzitLhyuGEqz3AqKLK1TYmrptKA
         NIkTs/qfHiAww==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DD93BA0070;
        Mon,  3 May 2021 19:18:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 98FC64011C;
        Mon,  3 May 2021 19:18:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Qvyvb946";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP5KGSeyNq8oLoM+otqpyJAeXL2C2nhIi8xb48Hoh5r+qR/gPFbUiNNzy/pMEkYw0YROZdfhHNBA29OhjO6mtad3zhJ0W4aeXNtYVKS48dO4qwH5eoevojIicgIPnFeH+nMFk5mB8t9jXmolrSOiE+ram731mHrGWPDFwK4x1wJZ5/QGFpAaoUCtE+tyOHA0vtOdnpPW47EzGJYNKJO0Ps4ofZuf8xAjIihVKDoQw24yT/eN9aKezQwIcliVZj8r1YNKoXe5ntYLzoXaYHrpMorEMVl6wEGKeDUi8TYocEt5kMbjdnZemH9lneeAHSiBcQQ9G5NswZbUf8NdAEIv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLFhFcct3sZyHHEEdlld+8h7UrRO1toxzcabCPMoraY=;
 b=YNPagun7IC2FQv97dWAH4yDMS3pOLGvLvfbr+5MF4fBVZkv9Hcb6U026FZVp5vRdnJPqmtvEyTyHFgqhWAhV8haWc0iQLvyk6dscXEomp06k9sruWXTlGMcluPg16sRR7WVp8Zo2b1+OA5m7tA00VxbpKpb8Ou5SJvsa+CSUFuCwv3S3qZDXllNf74TkEhH9MLqU8i6IuM/7xOabl9yRXopGZNXIabn4MBNZ3BXHXQnnlA+SFe0JH4JZCA1ae0Scs5BD+vS4yeR/1ICq+ho0RKXvSEuQyogGuY34Ct29qe4QW+2lY0SdK2GiGu+PIcpip2D9iPlgOymTUBCbaKd68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLFhFcct3sZyHHEEdlld+8h7UrRO1toxzcabCPMoraY=;
 b=Qvyvb946qGeedNVVwZCLeuGVr32bGcmDuPTTiG36SnSNhaZy4YlrPPuuwWOPiww5RQfoXwLQuFDXfSVhstL5jzbR+Yw9NPon5wcFUFm6crjVNRECJZ3gWYeercyXDM9fCjq638+YRLV53u/GGkAfgf4YjDuaGkzWuO6R4RLSX2Q=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 19:18:38 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 19:18:38 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Thread-Topic: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Thread-Index: AQHXPgHd1RlrjZ3rIE6wtN03PsVzsqrSCyeAgAAbEYA=
Date:   Mon, 3 May 2021 19:18:38 +0000
Message-ID: <e37b5c4c-f22d-ca3d-2361-40e8ba95cb12@synopsys.com>
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
 <CAHk-=wi4Rgo7f17AwYduEPKr6SEVq-mxRJiZ5S5X0hQ9RWmkYA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4Rgo7f17AwYduEPKr6SEVq-mxRJiZ5S5X0hQ9RWmkYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54fbc952-b321-402d-f1e0-08d90e68414b
x-ms-traffictypediagnostic: BY5PR12MB3940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3940CA9FF7EB4BBE58B88BC1B65B9@BY5PR12MB3940.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBRvpZxdtGXZHKzubzoGf3D7Uy6bwFYtwYmZZ9MO1zKjyClRdWOuSDede2DXtyXhX9NTNLA04iEjy6Mb8mq6L/aqSkgHLTt5RcSaw1ikAmsXLsYI3vYcyQ9/SvcB2UCUL3LBJe9sPW61H58OWKzqsKbBMuEqTCMXYlec8R3AW5VfmOYDYiN2WR9jGaJGBjGn9leCQtf0jUWCVXLDkyQvCRRckSPEVJABFGRN2jfgxtoeb48MNU4yLObrO+pgqYmA76nlvTb2lvR8BGJJOcaktxboKNiRsXGzOf6d5YEEM4nACAtioSWMEFx3AkNmPxGIf+VepBxcVuVf9wzPYb8MmG3N3pQ1l+RKA0+XaAjlHecaGv2x+bIYwqtSC7XAXwk6PrwKYGRd5XaUYzFPVjx8cm7noIxZm1OGgYNME4SL57iHHZjV4S8TdeWQ3M6u8wCDuOI3Gbf0evN1Ver9B74VDPGBRIvJ2NNQ04PSutw1hG1W1BvVqrHA5DB8HVZFoWCwRsEijSthJib7qThWsZ837LpWf+ucq6T7iNKUheSUi6RGO95Mq1EZj8OS7fPD3G7/yPkUFLxZDXfnU/nkFr/S0ebWxO94uoyEwwQyYnjW4/3PfaAVGlxJThkOONtvBoMOBbdSOsYwNvwN8MktgB6dF8pF+uD2wVnXt+s8bIk5C09uWNZyOtPCAzvZeMeWE/uf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(376002)(39860400002)(478600001)(5660300002)(86362001)(66476007)(66556008)(31696002)(71200400001)(38100700002)(2906002)(66446008)(64756008)(122000001)(83380400001)(66946007)(31686004)(76116006)(186003)(2616005)(8676002)(6512007)(54906003)(6486002)(316002)(110136005)(26005)(8936002)(53546011)(6506007)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWcwM0tINHVwTEU4Sjc1VUtSbmxmZGlsVFhDUm9lWC93NkwrUy8wSzQ4VTFS?=
 =?utf-8?B?elptUEpDaU5iWW83L0NxMldSQk9ySnRPV00vN2tVVktWNkhqZHgrZUNjdWdG?=
 =?utf-8?B?aTIvaEhzVXhEVVhBUUhZVnFpSEU2ZFlJZUJBUjZVZG4yek5QcGZHdFdXbmF6?=
 =?utf-8?B?MmcyVm1pdWlKaXh2T0JNTzA3ZkI3ZUlVdEZkVlJrMzd5VlQrT2lSL2ZsWWF3?=
 =?utf-8?B?WklrTlVXOFg5bnREeVU5UWVKa0FOYWRHZ1UzSk5Rd1NueTVCMVE0TzFiU1la?=
 =?utf-8?B?bEoxYlhJUitsM3ltaXNXcVFod3dHcXh5OENqZ3NoQms2Um5wSEdXZnk3WGFX?=
 =?utf-8?B?OFFaQnVqakRoUUZKeHpBa0d5MkcxQ2k4aWNsZEUya3hDQlBTVGdMV1hIVDZE?=
 =?utf-8?B?blVSWlYvaGFnM1V1eEVja2NXN0xYcEdsUHdNYlRjU0Mva3g5bnZoTGJCaXVZ?=
 =?utf-8?B?WWpTNlVLOU4vTFJNNGFjVUNJZzVlWVpseHRZWmRud3psMGloMm1NaGhNTDlp?=
 =?utf-8?B?UTlqUFhESHptbnV1UUdaMmhEM0hMNXRGOWV4TSttcTlZRXNRckkzeThJc2R3?=
 =?utf-8?B?WUF0MkpqWVVCSW5hMWhxZm5CTno1ZEEyeVp3ZmZxSUNBWFhEVGZDcnpQbytn?=
 =?utf-8?B?L3U5cHBpa2pKTWZYb3hlYVlnQVdEUmxFZ2RlViszdktSdnozd1VaMEpFdGlo?=
 =?utf-8?B?SVRjK2lyelpDQW1jR3BXTkVWUCtRT1pZVER3cCtvejF3elZCN1FheE9yY2dY?=
 =?utf-8?B?Q3JjejE2SjhSdzlFeVN6enhnYUI3MkhLaEd4OUIyVlMxVjBpSkxoUmFUNjhY?=
 =?utf-8?B?Vzh4NjlkeE9sbW5MUTV5Wm5wK2NxMnppN3lsSDJ1K2wxa2hyd2E3VUlmN3Bp?=
 =?utf-8?B?a1lMTnl2bFdhbUVycGFPeTZBZVN0elFRTTFYUkp1WXNzWVZ3SXhhZE9uaUpz?=
 =?utf-8?B?bVZJdzhwblM3VzVPVEQvcFNMbmFhSzZQUGFVQ21hU0kweThlV1dsWWMzY0lL?=
 =?utf-8?B?OUxKODVCMW9Nd1NzRFFtM0dYdmczTnVmL05BVzJ5ZHVnMGk2eUZXZFlGSkdu?=
 =?utf-8?B?NEhXM1M1aVZXdkRxR242WU53eDhxbER0WXo3OVUxSXF6VHZnUm9HQVJ0QjFW?=
 =?utf-8?B?ZlRKcmpMSFV0UU5OTEdXL0FsbTNTMVUvbDAvZGIyTStqZkFOaWcvdkpaRDNR?=
 =?utf-8?B?eGlWMzlkOVN4dCt1YVZKeXlFVHVaUStyKyt4TDJ4dHlaVklmMzd5dEFNMzBE?=
 =?utf-8?B?L1VyaWk0czEwL3ovbDh6SU15Ui9CYWRWejAzRy9RYnkxS3c3N24ybXBOK3VR?=
 =?utf-8?B?UzhkZEE5aUdaZjZDS2lwUnV6TzQyQnhoaUp3RmNPTW1mcC9ROEN4WGFSUTNS?=
 =?utf-8?B?MzNHWENGblFTcG10OVhQQ2tQUHJUN0U3WnBpWTJQL0tvZHJWaC9Pa1NLalVF?=
 =?utf-8?B?aWNlVjFyemhOTXNLZjhINUJkL0VHdDZyQnlWai96RjNiWmRWeGlFVXhnUTBH?=
 =?utf-8?B?K3hlZlhyQytmUm5rUkdCYVF6S0hwVWFiVkdpcDVrdGpFc3NXcUpJN09NQkdk?=
 =?utf-8?B?R2FFekhjSTIwdGIyK01PRFdtaVkyRHV2eTdHS3VIVVRSOXB2ZUJ2MUVsRUtt?=
 =?utf-8?B?MW51YUVHc0lsYXBwcDFRdDZkemZLMktZbjVlb1ZZNWpMaHQ0NmJ4WERCVmpr?=
 =?utf-8?B?MUVaWVV2RFJzZWpFc29KK3dXRlg4WHMrOHVxV1ZYYTFqRUJJaUNOMXVMQk1a?=
 =?utf-8?Q?3sUZJv4kqE2suDXB+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8830F9400C82794DBD80B249E926FCD2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fbc952-b321-402d-f1e0-08d90e68414b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 19:18:38.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYihg/uzg7DlpWI8Yi2xqBv+AX1MHmyzwghClh23SoOuEITBY6fCubLr27QAX0ouAlOeP4FOKcwQFNlZ+sVEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNS8zLzIxIDEwOjQxIEFNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MzAsIDIwMjEgYXQgMTo0NiBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+IEkndmUgaGl0IGEgbWFpbmxpbmUgZ2NjIDEwLjIgKGFsc28gZ2NjIDku
MykgYnVnIHdoaWNoIHRyaWdnZXJzIGF0IC1PMw0KPj4gY2F1c2luZyB3cm9uZyBjb2RlZ2VuLg0K
PiBTbyBpdCBkb2VzIHNlZW0gdG8gYmUgYSBnY2MgYnVnIG9yIGF0IGxlYXN0IG1pcy1mZWF0dXJl
IHdoZXJlIGdjYyBnZXRzDQo+IHRoZSBhbGlhc2luZyBkZWNpc2lvbiB3cm9uZyB3aGVuIHZlY3Rv
cml6aW5nIHRoZSBjb2RlLg0KPg0KPiBUaGF0IHNhaWQsIHRoZSBmYWN0IHRoYXQgZ2NjIGV2ZW4g
dHJpZXMgdG8gdmVjdG9yaXplIHRoZSBjb2RlIHNob3dzDQo+IGhvdyBwb2ludGxlc3MgaXQgd2Fz
IGZvciB1cyB0byAoeWVhcnMgYWdvKSB0cnkgdG8gbWFrZSBpdCB1c2UgMTYtYml0DQo+IGFjY2Vz
c2VzIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4NCj4gU28gY2FuIHlvdSB0cnkgdGhpcyBwYXRjaCB0
aGF0IGJhc2ljYWxseSByZXZlcnRzIHNvbWUgb2YgdGhvc2UNCj4ga2VybmVsLXNwZWNpZmljIGNo
YW5nZXMgdG8gemxpYidzIGluZmZhc3QuYyAtIGFuZCBkb2VzIHNvIGJ5IGp1c3QNCj4gdXBncmFk
aW5nIGl0IHRvIGEgbmV3ZXIgdmVyc2lvbiBmcm9tIGEgbW9yZSBtb2Rlcm4gemxpYiAod2hpY2gg
aW4gdGhpcw0KPiBjYXNlIHN0aWxsIG1lYW5zICJmcm9tIDIwMTciLCBidXQgdGhhdCdzIHRoZSBt
b3N0IHJlY2VudCB2ZXJzaW9uIHRoZXJlDQo+IGlzKS4NCj4NCj4gVGhpcyBpcyBhIGZhaXJseSBx
dWljayBoYWNrLCBhbmQgSSByZWFsbHkgdHJpZWQgdG8ga2VlcCBpdCB0byBqdXN0DQo+IGluZmZh
c3QuYyBhbmQgaW5mdHJlZXMuYyB3aXRoIGEgZmV3IG1pbmltYWwgZml4dXBzIHRvIGluZmxhdGUu
Yw0KPiBpdHNlbGYuDQo+DQo+IE1vc3Qgb2YgdGhlIGNoYW5nZXMgYXJlIGZvciBuYW1pbmcgKHdo
aWNoIHNlZW1zIHRvIGJlIGF0IGxlYXN0IHBhcnRseQ0KPiBmb3IgQysrIG5hbWVzcGFjZSByZWFz
b25zLCBpZSAidGhpcyIgLT4gImhlcmUiKSwgYnV0IHRoZXJlJ3Mgc29tZQ0KPiBjbGVhbnVwIHdy
dCBtYXhpbXVtIHRhYmxlIHNpemVzIGV0YyB0b28uDQo+DQo+IE5PVEUhIEkgaGF2ZSBub3QgdGVz
dGVkIHRoaXMgcGF0Y2ggaW4gYW55IG90aGVyIHdheSB0aGFuICJpdCBjb21waWxlcw0KPiB3aXRo
IGFsbG1vZGNvbmZpZyIuIFRoZSBkaWZmIGxvb2tzIHJlYXNvbmFibGUgdG8gbWUsIGJ1dCB0aGF0
J3MgYWxsDQo+IEknbSByZWFsbHkgZ29pbmcgdG8gc2F5Lg0KPg0KPiBEb2VzIHRoaXMgYXZvaWQg
dGhlIGdjYyAtTzMgcHJvYmxlbSBmb3IgeW91Pw0KDQpZZXMgaXQgZG9lcy4gSSBidWlsdCB0aGUg
Zm9sbG93aW5nOg0KDQoyMDIxLTA1LTAzIGI5M2JlZGNmOGZhNCBVcGRhdGUgemxpYiBpbmZmYXN0
IGNvZGUgdG8gbW9yZSBtb2Rlcm4gemxpYg0KMjAyMS0wMi0yNiBlYTY4MDk4NTQ2OGYgQVJDOiBm
aXggQ09ORklHX0hBUkRFTkVEX1VTRVJDT1BZDQoyMDIxLTA0LTIzIGY3MTE4ZjhhZGExYiBBUkM6
IGVudHJ5OiBmaXggb2ZmLWJ5LW9uZSBlcnJvciBpbiBzeXNjYWxsIA0KbnVtYmVyIHZhbGlkYXRp
b24NCjIwMjEtMDQtMjEgMWNiN2VlZmRhN2VkIEFSQzoga2dkYjogYWRkICdmYWxsdGhyb3VnaCcg
dG8gcHJldmVudCBhIHdhcm5pbmcNCjIwMjEtMDMtMjIgMTYzNjMwYjJkOTViIGFyYzogRml4IHR5
cG9zL3NwZWxsb3MNCjIwMjEtMDQtMTEgZDQzNDQwNWFhYWI3IExpbnV4IDUuMTItcmM3DQoNCkFu
ZCBpdCBzZWVtcyB0byBiZSBEVFJUDQoNCnwgTGludXggdmVyc2lvbiA1LjEyLjAtcmM3LTAwMDA1
LWdiOTNiZWRjZjhmYTQgDQoodmluZWV0Z0B2aW5lZXRnLUxhdGl0dWRlLTc0MDApIChhcmMtbGlu
dXgtZ2NjLmJyX3JlYWwgKEJ1aWxkcm9vdCANCjIwMjEuMDItNi1nNWUyOWJhN2JmNzMyKSAxMC4y
LjAsIEdOVSBsZCAoR05VIEJpbnV0aWxzKSAyLjM2LjEpICM2NzggDQpQUkVFTVBUIE1vbiBNYXkg
MyAxMToyOTozMiBQRFQgMjAyMQ0KfCBNZW1vcnkgQCA4MDAwMDAwMCBbMTAyNE1dDQp8IC4uLg0K
fCDCoCB3aXRoIGVudmlyb25tZW50Og0KfMKgIMKgwqAgSE9NRT0vDQp8wqAgwqDCoCBURVJNPWxp
bnV4DQp8IFN0YXJ0aW5nIHN5c2xvZ2Q6IE9LDQp8IFN0YXJ0aW5nIGtsb2dkOiBPSw0KfCBSdW5u
aW5nIHN5c2N0bDogT0sNCnwgJA0KfCAkIHpjYXQgL3Byb2MvY29uZmlnLmd6IHwgZWdyZXAgIihP
UFRJTXxDT01QUkVTU0lPTl9HWklQKSINCnwgQ09ORklHX0lOSVRSQU1GU19DT01QUkVTU0lPTl9H
WklQPXkNCnwgIyBDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQN
CnwgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRV9PMz15DQp8DQp8ICQgZnJlZSAt
bQ0KfMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b3RhbMKgwqDCoMKgwqDCoMKgIHVzZWTC
oMKgwqDCoMKgwqDCoCBmcmVlwqDCoMKgwqDCoCBzaGFyZWQgYnVmZi9jYWNoZcKgwqAgDQphdmFp
bGFibGUNCnwgTWVtOsKgwqDCoMKgwqDCoMKgwqDCoMKgIDEwMTLCoMKgwqDCoMKgwqDCoMKgwqDC
oCAzwqDCoMKgwqDCoMKgwqDCoCA5NzjCoMKgwqDCoMKgwqDCoMKgwqAgMzEgMzHCoMKgwqDCoMKg
wqDCoMKgIDk3Mg0KfCBTd2FwOg0KfA0KDQo+IEl0IHdvdWxkIGJlIGxvdmVseSBpZiBzb21lYm9k
eSBhbHNvIHRvb2sgYSBsb29rIGF0IHNvbWUgb2YgdGhlIG90aGVyDQo+IHpsaWIgY29kZSwgbGlr
ZSBpbmZsYXRlLmMgaXRzZWxmLiBCdXQgc29tZSBvZiB0aGF0IGNvZGUgaGFzIHJhdGhlcg0KPiBz
dWJ0bGUgY2hhbmdlcyBmb3IgdGhpbmdzIGxpa2UgczM5MCBoYXJkd2FyZSBzdXBwb3J0LCBhbmQg
d2UgaGF2ZQ0KPiB0aGlobmdzIGxpa2Ugb3VyIGZhbGx0aHJvdWdoIHJ1bGVzIGV0Yywgc28gaXQg
Z2V0cyBhIGJpdCBoYWlyaWVyLg0KDQpJIHRvb2sgYSBxdWljayBsb29rLCBidXQgdGhlcmUgc29t
ZSB0byBiZSBzdWJ0bGUgc3RhdGUgbWFjaGluZSBjaGFuZ2VzIA0KaW4gaW5mbGF0ZS5jIHdoaWNo
IEknbSBub3QgY29tZm9ydGFibGUgbXVja2luZyBhcm91bmQgd2l0aC4NCg0KPiBXaGljaCBpcyB3
aHkgSSBkaWQganVzdCB0aGlzIGZhaXJseSBtaW5pbWFsIHBhcnQuDQo+DQo+IE5vdGUgdGhhdCB0
aGUgY29tbWl0IG1lc3NhZ2UgaGFzIGEgIk5vdC15ZXQtc2lnbmVkLW9mZi1ieToiIGZyb20gbWUu
DQo+IFRoYXQncyBwdXJlbHkgYmVjYXVzZSBJIHdhbnRlZCBpdCB0byBiZSBvYnZpb3VzIHRoYXQg
dGhpcyBuZWVkcyBhIGxvdA0KPiBtb3JlIHRlc3RpbmcgLSBJJ20gbm90IGNvbWZ5IHdpdGggdGhp
cyBwYXRjaCB1bmxlc3Mgc29tZWJvZHkgdGFrZXMgaXQNCj4gdXBvbiB0aGVtc2VsdmVzIHRvIGFj
dHVhbGx5IHRlc3QgaXQgdW5kZXIgZGlmZmVyZW50IGxvYWRzIChhbmQNCj4gZGlmZmVyZW50IGFy
Y2hpdGVjdHVyZXMpLg0KDQpNYXliZSBnaXZlIGl0IHNvbWUgdGltZSB0byBiYWtlIGluIGxpbnV4
LW5leHQgZm9yIGEgNS4xNCBpbmNsdXNpb24gPw0KVGh4IGFnYWluIGZvciBqdW1waW5nIGluIGFu
ZCBzdGVlcmluZyBnY2MgZm9sa3MgdG8gcmlnaHQgY29uY2x1c2lvbnMuDQoNCi1WaW5lZXQNCg==
