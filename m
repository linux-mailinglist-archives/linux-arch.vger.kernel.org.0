Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656127785A8
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 04:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjHKCzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 22:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKCzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 22:55:39 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020017.outbound.protection.outlook.com [52.101.128.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114C12D60;
        Thu, 10 Aug 2023 19:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8dU5UpFSFkMfUvXDaMLDsA7+Abcp6egOmolP9eTgtBxEy/u7VAYMza2KNPESoQSMvNJQ10hbNGwngNy1qXw3UsdDI04s7g48cNdYFQT8hw9pBR4F+IqbQchdMtuoxeAjrw4SQ6hHoA+geFWSv5gsqz2w9gDlv8wpT9YFIjz8UPTPQb9YqO45Xyj41EALUfylp/lvG2uMtvpqq79BkmWMf9Xpsep5MdL5oc9ZwCdv9MKZ6bd5ydez3sLcQnahWaew6RexvgLaIZE+CgvCJ6hHlk11FK5AYgoIiGLklUppzE75aRA8eg9KGS1i3zmL/jZtIm5AO73MqRZdB/lxKPjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3h+5N89RbhlMn8TWkBj3NlBtpzlwV2nundIqF74zAY=;
 b=WlO/+/uMDasrmgMOaM7TEibhjFJnaAyRahN0+RwhtapStLyQiyw5GhtOIbaBIcaL4wquvls2cBTx2JU30GeBnC0LBrfubM0MeXU5/Lhk3w46peQtBziXS9idVHOa8UkYN0FeufYX8k1p9pxE39FVxCrwXspEgpqRkljS2Sph7tIQ/9lIrKuD8rTdUP/VhoXEd3cjOcRSwuzJ5IIKU70fciP+uf2tghbirBBsmjLhYnUp6gzo4K5rdt47N+GRlzmyxGpBzPPcEbmjwsTerQ+D3s1VivhFIktuLMnYuT2f4LJ+NcvfKfpnbXMXg0PB3ogW6KfLsy2Bb/z1Y/S0zpe1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3h+5N89RbhlMn8TWkBj3NlBtpzlwV2nundIqF74zAY=;
 b=ak0RA6aycNbnE1JMOGhxuhogOu684NhxdF6Ma2EaD9uqtTdaZd3TAIAggM8b0swAN86HUznir2ZSMJe/pSpZGcOPPMljCPMDMeAyZOx5GEFBohLF0+kGoVOf2ugOVzVOz2CmjTBaSvESpMHYq3p8nebNdd3jwrfeGYKnbuIejys=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 KL1P15301MB0434.APCP153.PROD.OUTLOOK.COM (2603:1096:820:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.8; Fri, 11 Aug 2023 02:55:33 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 02:55:33 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>, Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Thread-Topic: [EXTERNAL] [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in
 VMBus init message
Thread-Index: AQHZqKeHE/Z/njW7J0ynfWu9eGUrHK+uEnnQgDBxB4CABXjwAIAAsDhg
Date:   Fri, 11 Aug 2023 02:55:32 +0000
Message-ID: <PUZP153MB0635A5298052278ECA3325A7BE10A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-3-ltykernel@gmail.com>
 <PUZP153MB0749BAAA8E288D76938704A5BE2DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <ZNB3m6Qiml7JDTQ7@liuwe-devbox-debian-v2>
 <da667608-a8aa-f5b8-1621-de29b3f19272@gmail.com>
In-Reply-To: <da667608-a8aa-f5b8-1621-de29b3f19272@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4b5fff1-be8c-42a6-9c9c-9b9d01733c05;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T02:53:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|KL1P15301MB0434:EE_
x-ms-office365-filtering-correlation-id: 79fddbb6-8a5d-4b3b-115d-08db9a166dfc
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0Kp2yZjt+7rz2+pqnW/0UebUbXHcCxKhcClhdq3irPpbq6QJxRcgTaea+wpzMmlaguKe76M383WC9RVyjj/w/3Uy151vIa6XCPFUOKExGbj/sFZDLfVUuk66JcMvG22A2SgSynKutZb54v5xO0P1oEBvOvszVKV7palbXc9zYgKXhUXPQgoeJ2kbUWFPDCf6I8isD6WKq+EihZcb80Un29/EWYSaKfxiHgiIz/hsDtYktNxpSG2CogzRLGUT9sMQXATFnoO3twAtwkv7AA+J39/VXrnCnpguTTgmoAf/hIsmZ7w6QjwPbs4Cobfrc8BbP7m6RgQgUFEUL5ldGrPEQNiCngH7n00o5JD5UCaKkNPVE3MmjY8UWYiCyAAplqqfe+ltCqbAl4yCpkOAdedyfVlHVItHCoqedmFXuV1AwvYPPbZ0oaKhDbve1r0v/yn5COs/a2LAiAtbQqyzLd8ZHYE9AfBo46evzuzNunf6vMt0UQ8fOuvyxhAU1+9fRlWOA5xn2axx+xYiu6vvyrfQA+RqU4EM/U29ROFjDJFx+MC8Wp9w7u2zvrbVBajxxo00TRclRMTkWEvo4h3Y/+bNOY9+NKeNUdGAVfPLHaenZhIyX/LBrH1M7po2ah1f3mtmYgYl4Xdk5eCPAy9pIspiHHtlHqGxdkWJiEWg+M0ip85Zi2cZMWb043t5smlRS6MXy9/hWI4wXvpUQYZW1sWFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(1800799006)(186006)(6506007)(8676002)(8936002)(53546011)(41300700001)(8990500004)(33656002)(2906002)(83380400001)(15650500001)(122000001)(38100700002)(82960400001)(86362001)(82950400001)(38070700005)(7416002)(55016003)(5660300002)(9686003)(66946007)(66556008)(66476007)(64756008)(7696005)(76116006)(4326008)(478600001)(66446008)(10290500003)(12101799016)(52536014)(71200400001)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJ5dXkzTGw1ZjdwcHVHdDU0NVpFNTloQzR3ZFZiU3dYUXJRYnB3d1poWThP?=
 =?utf-8?B?bG4vVmY2Qlh1OTdUYUhSMThVVEFnZ3U4dFN5YUlqdzFZS2ZiZXdPeERxRFNy?=
 =?utf-8?B?R3FsQldRbE5HcjVuNXBaNjM3TnNQQ0pZQ2tUaWFXS2Nmanl6Rnk3ZUZVVEhV?=
 =?utf-8?B?dzE2a1lIOVVSZmdJbGRaRFpjOXFTNUhqQWRkNVdtRUhzSFFMOG1UMFpTZERo?=
 =?utf-8?B?VWIvOUVDMU1mTVVRUjhPVWdrVWh5cWUzV1dGMHc2VTFaVkcrOUV0OEJGVXk2?=
 =?utf-8?B?TnhEdk1Ua3JwWjlUVWVSVTRsbG5lWVRKWXpNZGcxSWE4anVIaTM4aHRyZTM2?=
 =?utf-8?B?RjlzMURpd1BqbjRpM1Y3ODdwWW1wYUUrYS9HSVc2S2FUOU1VYnVsUkxzRkhp?=
 =?utf-8?B?aTFhN082Rkppa2xqT1ZHdlVoanBFNS9KNnRaeDRqYXc2bXlZQlRLM2hMTkx6?=
 =?utf-8?B?VXJCbDV2eE9SV2wrZmNvOEwyVks1ckF3MTJKY0xTTHlsUWhZTXFscXFOYzMv?=
 =?utf-8?B?RVpQdmhEM0crZWtlOFNzY3JtWFJhN1hXMkFMOTZoRURvWlJkUjJIT1BlN1hr?=
 =?utf-8?B?OVhoWG1MOWlxcUhNcEppQTBESUdSQkVTU2trc2g0bVVuZUFlVStVNFNST0FB?=
 =?utf-8?B?bDBIK3FDdXhHemlCczRRUjA2TWhXeEVGS0lBd2xRK0FLQlJCU1RQN2tDeVVq?=
 =?utf-8?B?Rm5OVzFHVWxaUGJXRW1QU0R2Nzlad2J1OUk0TmJzQi9HQ0UyR0c4YTZnVFB4?=
 =?utf-8?B?NWd3emo0MVBOOEcwSjRsaEluZmpMQ2Z6T2N3RUFxT09tdFpYc3I4VnFxdnNW?=
 =?utf-8?B?Q2wyNTFkNDlZLzcwR1Q2eDdJMXk2N3NWYVJJYXUxQ3l2V094N3ZLRFQrNVBO?=
 =?utf-8?B?Z1dJVEZnK3NoZ1N6dzR5YURlTUpRa2h5WG9jUXR0U1psa01CTXFoNHV5NGdZ?=
 =?utf-8?B?aUsyVm45QmdxK3Z6Q3FZUDFTMEF6RVAvc3BRZXR2Mm14eTRMMUVkOHh1TS9U?=
 =?utf-8?B?d3d1WVdGUkJXOUh5NXNWOG5EK0J5M240YjZvTkNiS1hmeXVaRlJTZ25IS3Vl?=
 =?utf-8?B?VTY3b2pDYk1adVBlSklIL2hOUkFKMlVMRlVnVlFTV1R4a3I5VmUrcGc4dksv?=
 =?utf-8?B?SVE3c2JhR1lFdTJhS2RzZE4zd0lmZThYV2RJYUVJYkZ6YW1FbThwRGVCOE91?=
 =?utf-8?B?YnlLdlNnU1pBYlJ2QnVSbnU3Q0VCR2JaMG5SbDY5YkcvZ1l5L1phMDNIZ1Ni?=
 =?utf-8?B?UTZtTUlvK3M5N04vaHhEeHdPWHFyQ054OEIxY3V6U3c0ODR3OTRTckNsTFBr?=
 =?utf-8?B?OXFnRUZBU21FNStnUjR1UVgxOFBtLzFmVWdXdm1KUHBCazNxa0t5ZWg5Wnhp?=
 =?utf-8?B?czliQ2gyeTlwRDZqbzZrdjNUUmJYVEZPbzhpMFV6bVZmYzJHQTdwVVlQNHMw?=
 =?utf-8?B?d0h1NnRNeVVHVElONTlFU3VxMWZlaDNWRzZTRDk2ZEdWelgrekw0akRPK2dS?=
 =?utf-8?B?Ui83QVVVdWVWcmFTSlZFdFZrZ2tpQWFyaFJWM0lKdzQrblN1K3QwTHhTZC9u?=
 =?utf-8?B?R3hzWkJIU1FTOWV6OFlNQ2J0YVJrY0RXS2JpdzNXT3RpTk5ZSHJ2TzMvR0M2?=
 =?utf-8?B?bDhWNGlrRHljc3BZQVhpVlVYOUkwc0dnS20wNGdJUGFRU3JDandVZlZGTlE4?=
 =?utf-8?B?UXREbEJHbVVmRUtic0ZJSlJpRkdscmlGa1ZKc0FZTVZobXU1ZzlkQnRNUFky?=
 =?utf-8?B?cVFoM0Q4dXNkQWdCcC9PMmVLQ1hucDVZY29PSDBrNks1UzRHampMK3ZxNFpz?=
 =?utf-8?B?UkQvb1g0dUtOWHMyQmpoSVRTTWpvZGhlUUNqc2dsd09wRnNSUnlWbGVtWlQy?=
 =?utf-8?B?cUVrRmdJMHIyazFyTWNsOGxaMDE5TEsxaWdpcmJSRTFhZldRQlBzRFF2K3dS?=
 =?utf-8?B?OC9kMUZBTnFNeUhTcDBTTHEzeFdHV3lXUnhDZlhUR0x0QVdzZjMzcUtMbUNN?=
 =?utf-8?B?YlpwMmc1RWhVNXBJc2FWKzN4SmJGZkZCQU5YRCtnNTJjZ1diMW9STUVBYUVF?=
 =?utf-8?B?aGM4d1NwK2N6MElETEpHQ3JjcmIyYWpPTUpMditxUEZpYUFJK1locEsvazBI?=
 =?utf-8?Q?Mu8SXnDLZqBSSgEFF5azEf3cn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fddbb6-8a5d-4b3b-115d-08db9a166dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 02:55:32.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2HQlYBY9i8txFlxnWW8P8BdZxAtwmYdxfcqw6AGnADKp9ivuOPRwtJN4lFS5alskzno7Xo/lBGFnd2ft3CpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGlhbnl1IExhbiA8bHR5
a2VybmVsQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMCwgMjAyMyA5OjUz
IFBNDQo+IFRvOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+OyBTYXVyYWJoIFNpbmdoIFNl
bmdhcg0KPiA8c3NlbmdhckBtaWNyb3NvZnQuY29tPg0KPiBDYzogS1kgU3Jpbml2YXNhbiA8a3lz
QG1pY3Jvc29mdC5jb20+OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29t
PjsgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47DQo+IHRnbHhAbGludXRyb25peC5k
ZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlOw0KPiBkYXZlLmhhbnNlbkBsaW51eC5p
bnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOw0KPiBkYW5pZWwubGV6Y2Fu
b0BsaW5hcm8ub3JnOyBhcm5kQGFybmRiLmRlOyBNaWNoYWVsIEtlbGxleSAoTElOVVgpDQo+IDxt
aWtlbGxleUBtaWNyb3NvZnQuY29tPjsgVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQu
Y29tPjsgbGludXgtDQo+IGFyY2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1oeXBlcnZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgdmt1em5ldHMgPHZr
dXpuZXRzQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFtQQVRDSCBWMiAy
LzldIHg4Ni9oeXBlcnY6IFNldCBWaXJ0dWFsIFRydXN0IExldmVsIGluDQo+IFZNQnVzIGluaXQg
bWVzc2FnZQ0KPiANCj4gT24gOC83LzIwMjMgMTI6NDggUE0sIFdlaSBMaXUgd3JvdGU6DQo+ID4g
T24gRnJpLCBKdWwgMDcsIDIwMjMgYXQgMDk6MDc6NTRBTSArMDAwMCwgU2F1cmFiaCBTaW5naCBT
ZW5nYXIgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+PiArDQo+ID4+PiArCXJldCA9IGh2X2RvX2h5
cGVyY2FsbChjb250cm9sLCBpbnB1dCwgb3V0cHV0KTsNCj4gPj4+ICsJaWYgKGh2X3Jlc3VsdF9z
dWNjZXNzKHJldCkpDQo+ID4+PiArCQl2dGwgPSBvdXRwdXQtPmFzNjQubG93ICYgSFZfWDY0X1ZU
TF9NQVNLOw0KPiA+Pj4gKwllbHNlDQo+ID4+PiArCQlwcl9lcnIoIkh5cGVyLVY6IGZhaWxlZCB0
byBnZXQgVlRMISAlbGxkIiwgcmV0KTsNCj4gPj4NCj4gPj4gSW4gY2FzZSBvZiBlcnJvciB0aGlz
IGZ1bmN0aW9uIHdpbGwgcmV0dXJuIHZ0bD0wLCB3aGljaCBjYW4gYmUgdGhlIHZhbGlkIHZhbHVl
DQo+IG9mIHZ0bC4NCj4gPj4gSSBzdWdnZXN0IHdlIGluaXRpYWxpemUgdnRsIHdpdGggLTEgc28g
YW5kIHRoZW4gY2hlY2sgZm9yIGl0cyByZXR1cm4uDQo+ID4+DQo+ID4+IFRoaXMgY291bGQgYmUg
YSBnb29kIHV0aWxpdHkgZnVuY3Rpb24gd2hpY2ggY2FuIGJlIHVzZWQgZm9yIGFueQ0KPiA+PiBI
eXBlci1WIFZUTCBzeXN0ZW0sIHNvIHRoaW5rIG9mIG1ha2luZyBpdCBnbG9iYWwgPw0KPiA+Pg0K
PiA+DQo+ID4gVGlhbnl1IC0tIHlvdXIgdGhvdWdodCBvbiB0aGlzPw0KPiANCj4gSW4gY3VycmVu
dCB1c2VyIGNhc2VzLCB0aGUgZ3Vlc3Qgb25seSBydW5zIGluIFZUTDAgYW5kIEh5cGVyLVYgbWF5
IHJldHVybiBWVEwNCj4gZXJyb3IgaW4gc29tZSBjYXNlcyBidXQga2VybmVsIHN0aWxsIG1heSBy
dW4gd2l0aCAwIGFzIFZUTC4NCj4gDQo+IEkganVzdCBzZW50IG91dCB2NSBhbmQgc2V0IFZUTCB0
byAwIGJ5IGRlZmF1bHQgaWYgZmFpbCB0byBnZXQgVlRMIGZyb20gSHlwZXItViBhbmQNCj4gZ2l2
ZSBvdXQgYSB3YXJuaW5nIGxvZy4gVGhlIGdldF92dGwoKSBpcyBvbmx5IGNhbGxlZCBvbiBlbmxp
Z2h0ZW5lZCBTRVYtU05QDQo+IGd1ZXN0LiBJZiB0aGVyZSBpcyBuZXcgY2FzZSB0aGF0IG5lZWRz
IGhhbmRsZSB0aGUgZXJyb3IgZnJvbSBIeXBlci1WIHdoZW4NCj4gY2FsbCBWVEwgaHZjYWxsLCB3
ZSBtYXkgYWRkIHRoZSBsb2dpYyBsYXRlci4NCg0KSSB1bmRlcnN0YW5kIHlvdXIgcmVxdWlyZW1l
bnQuDQpJTU8gaXQncyBjbGVhbmVyIGlmIGZ1bmN0aW9uIHJldHVybnMgZXJyb3JzLCByYXRoZXIg
dGhhbiByZWx5aW5nIHNvbGVseSBvbiBlcnJvciBwcmludHMuDQpXaGlsZSBjYWxsZXIgb2YgdGhp
cyBmdW5jdGlvbiBjYW4gY2hvb3NlIHRvIGlnbm9yZSBlcnJvcnMsIHRoZSBmdW5jdGlvbiBtdXN0
IG5vdCBvdmVybG9vayB0aGVtLg0Kc29tZXRoaW5nIGxpa2UgdGhpcyBzaG91bGQgd29yayBmb3Ig
eW91ciByZXF1aXJlbWVudDoNCg0KcmV0ID0gZ2V0X3Z0bCgpDQptc19oeXBlcnYudnRsID0gcmV0
IDwgMCA/IDAgOiByZXQ7DQoNClRoaXMgd2F5IGRlc2lyZWQgZnVuY3Rpb25hbGl0eSB3aWxsIGJl
IGludGFjdCwgYW5kIGZ1bmN0aW9uIGFsc28gd2lsbCBiZSBzZWxmLWNvbnRhaW5lZC4NCg==
