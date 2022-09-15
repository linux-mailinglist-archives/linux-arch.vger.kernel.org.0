Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA15B9AE4
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIOMfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOMfO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 08:35:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488916D56F;
        Thu, 15 Sep 2022 05:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxoqoSvC7DLylpZUJPF1rEmp/W62h81B+4hzCNdXNAzzmX4q8cFAfAY8az1obl9lOjlgTWowJmDCiyRV8wl9Djtp/ONdX5eQjax+ziDZDoVwZd9Fn4xSd+RVopnRK/SzCWoaJOui6wnmAX/86avyEwPQp1njTXxG8Dw13GhGsCwakn85c0XSl9HnQ4ScpJ7XTlfAP37e3K4ftUy/Vbz3K/4ca+kxWtgp05/BGSA/LptNRKnXBIGKa3SEz+k0mfeZgt+fFNVfAvYDPUYObR5v6bh1uWhmllmIMz4za0/LHIKI4tJ/ylZ8RzQPPit+NNcpz3chDLv+u1q2N6PSv9gBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRU7+G06DVHI+62u4JrZF9q+rT4VvfpIHf1SJt97P7Y=;
 b=C8C+hZExTyjowPuWXjRyb16fcwFIjHZ26M4a7Rx3rC3Lib6AU+CxcOXT2zN63UZtsF+kUiz2b8TiGUM1bdoxOx/D/DczQxrthd/i0mifrnpbVXP3suF1DojjeP5uPzxWm3o5SHh8QM4qxEhoDDEFBB2D6w3GOFMnhxIjBz8U7o3NWLO3AaQ9YGBdAJDSDkcFN9EKMCP5grFZfMGJa7xRV9Ohf9l/q/GxoLkipT5Rzy4R2VRXWrFsgo4WkbYECGD1Qcb/h5T6nN0zpYbgJdDfwG4bUQ6fCKup0xeVSnsUynbvxEdJk02FX7txAAb9tqkwcOi1M9SFgdOLknOmttKGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRU7+G06DVHI+62u4JrZF9q+rT4VvfpIHf1SJt97P7Y=;
 b=ITaRDxCbYWJnQQiC/fgC0X3VtoGt6tlL4o1lG9JsdbL+4GzfJ/5J9nu3Pd9fmOatjLwYcKZ3/ftNstrJVqNPsBTaeTQc6w/+Et6ij22rZfn4LfjMlAe94h9slLPF6mP5g0rZE/VfYyB2UVWq6Rr6MdR2s8Z1jfdSAgHxB0+VeH5hiaLHELAVIb3ii5B4xLFu24bb+Hp38XHma4EPqoq99P+WIVTmaHptfgvO9Xhoo4djYNG6HLlNJXUvL94gos/3fagODyjVhSmhKqMIdR8ZphHG8UtrhQq/VZtdqIyY6wYF5ud1wYnxNgfzc7xZH181wTYNK6kgHtu0pFOlXl/Dug==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 12:35:10 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 12:35:09 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Topic: [PATCH] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Index: AQHYyMA9YvMyHkwA3EyvMDv7VnmV1K3gaHCAgAAFBkA=
Date:   Thu, 15 Sep 2022 12:35:09 +0000
Message-ID: <PH0PR12MB548126FEF030E0BDF79D773EDC499@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <6698eda3-977b-902f-ba23-89cfd674c121@gmail.com>
In-Reply-To: <6698eda3-977b-902f-ba23-89cfd674c121@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB7104:EE_
x-ms-office365-filtering-correlation-id: cd6d43ca-c4b1-4afa-52fb-08da9716ba59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gj71Q784wC/G50LTF0K6NJXNlSIr09vgSyXbpkdBJ42QqpeZ69Qn2jIulPx+DU0qAF8SFFrBwxsB1QQolStzedZQkfrzQajf8hRCIgMOdajU+abQvsbJeUE+0Hi3yU3UQmXbI6x2qTfkXf+4xQ4CVi71UwDHDGKCeYzEDXz5qrzjZdQdXb9fL82RDTXXlksLQY/2M09u7ZpfiQI6qvb2xyfnDP4COs6qiV9IuyWP8wshmGN06TObF7nqfsGghnE2Vu45CeCxfpbQF3PvmcJUcleTp4p2p+yA17+vGZ15R6k18m74GaElhLATPDyaeHmyRSZIrMKGfpYZDfou2c0jgS7JRWNjPtVPaVsGEUeS/zxyJRY3KoosKRKG47W5wfzy80464Piw6HQXiPRMAXvSU/CSQyvy6XDZlQeclHeQ5541ARFeHJfQ6O8whOVjXXbpKIx/D1gpaFfwP8RGmh1MrvUdN690KYZ62ozX94pbBWQ4U4EUy9oXs2xGHAN/7FqjwQFqe4gniLjy+gfs623dJT5K24e1iIigc7orIMtDiFGviUHYb23nm4Bh13bURCnakKvLhV75E3q7oUNw1RTk79yYAs6oI/UTAzDvmG+2Wb10uJUCWlycL6W6Bw8RBiohujNqSkU+64oA1wq/1Q2uNepBcUeEA1j3gsWxvjNJAD+empYIwYMGIOpdYYnqwgc+DeEEiqaWmiVGtp0iNkQcK6TguiITexlJkgl2wyV9X9UuFaAx8xjcKPtGxY+2zieP2h+E6OI/E1LHeMFEAMnFrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(122000001)(38100700002)(26005)(2906002)(55016003)(38070700005)(7416002)(5660300002)(52536014)(4744005)(83380400001)(8936002)(186003)(41300700001)(64756008)(921005)(66476007)(33656002)(66946007)(76116006)(9686003)(7696005)(53546011)(6506007)(66446008)(8676002)(86362001)(478600001)(316002)(71200400001)(66556008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ptVDRhR3FsTER4cTNLcGhkNW1pWXFHNncxS2tieVpXcWtRcVFGUmY1anZV?=
 =?utf-8?B?K0poZ1J1NWM0TGhNby9KMFlEYUFGaU13VGVVTG1BS3R2Q3dNNFpRaEJ5WER1?=
 =?utf-8?B?c3ErRU4vUU90azV2UjczcVlPbjJSYkdFb2gyMHVUT2FzWkR3Z3dQR0lmVVFi?=
 =?utf-8?B?akRKRU5uczdJdGNnRWZxVmhTSGVjOEIvTUpTMU5lbFdCZDAxUzBKS3FZd3Q3?=
 =?utf-8?B?ZE1BY3ROKzlMVDNJd3BrV3Rsd2ROUXUxV1ppSkNVVXg0QTFSZHFJSkNKOHBF?=
 =?utf-8?B?d3RQWmtrS05DaHM1aThGc0ljR3FDUXlXWFpEUGs0aFdQekF4dlo3VVhmODA5?=
 =?utf-8?B?QXYrWG1aalZxZXlJb1pLcHVHYUVsSVRaRDNLYWVBcnR5OWZza1FhYlpvT1FM?=
 =?utf-8?B?eWZEV1FRZ1JyOWtGY2lEN0F3MFpzVFBpeGhzV2o3YlUvdEs3UllLRVpHcXRr?=
 =?utf-8?B?S0tKRjZSVUkxTkNUcDN6aGdMc2lqclFBRFB1N0xHY3daYktQeXY1b1NuN004?=
 =?utf-8?B?bDREeWJWVVRmazk1NVgvbGt0M3VKa0tHMGFTdSs2d1BwS09aVmZIcG8xdkQy?=
 =?utf-8?B?RlFTTTdJZklwL00yY3ROOWYzY3VCZUZob1B6YmlFOW5yMkhCbzdsUGFyQmdy?=
 =?utf-8?B?R0IrdE5ZUW4vcTlzM2tkdjM2d2NVMFFMQ2NZSVNBOCtHVzR4T1JQTms0bjR0?=
 =?utf-8?B?Y0wxZWNud0VaaWMwczlIbVV2dXFKMExaelh1bjdZT1JBNVU3VVJCb044UVE1?=
 =?utf-8?B?UjhjK0dJMHNmcEVNSzdTeHhlbWIzWktuM2FxcXVjTkhaZ2g0R1RFSSs4NGRE?=
 =?utf-8?B?amx3OWsrUGVHWTdTN1plS3RVdXh6b2s3VkthTlZ3RDlpWVhpUXB2UDJWbzFt?=
 =?utf-8?B?a2lBUlhuN21wVUcwOVYzbDZlS1h0cjQxVlFqT2RWbkptd2YvT1pkQzM1eG01?=
 =?utf-8?B?U3RVMDRWaEc4MUthUUZ4OFNoZk4rbXBXM21oNHZBRXhOZ3FxZjI4cG43YSt5?=
 =?utf-8?B?NFptenVub09vSW1mREx5VXJ4aVlLc2ZybWVIeFc3alBWc0pjVTFJYXY1aUFt?=
 =?utf-8?B?UXQ1UlZnQjlNSVNPaUhPWCtHZ0RUbjU0cjhqa0h4bktCa2pVUHNhSE05TEYx?=
 =?utf-8?B?azMxYjhMRWtrY0o3N3ovQzBCQ3dGdzFJVDJpYnI3WVZmdGJpemREeGZLTmx6?=
 =?utf-8?B?ZFRwd2dYVEx3OUFoNTNnbVFSYllnTEs1Z1JhanRSZU5jQ1BwK0kzSGxtQ2ZV?=
 =?utf-8?B?cjJGbFE1RHNTaTRmUDJ3OWZxVFpDSkt6QUZacjB5VlpQaXBKVHRQVVRHeEl4?=
 =?utf-8?B?T2xWT1AwWFUxeFNtcU94UmIzY1RIL2NnTEJkb2gyejcxclE4bHJIaDd5TEtN?=
 =?utf-8?B?RGo0eG1YUlNTVHN5MGh1NWlRcmxoSCs5b1pMNEhFN2pSZGlaQnd0QVRGVHND?=
 =?utf-8?B?V0FFZVUwaWQzZUJTRURLRFNUL3Q3SkNYaXJFOThpUlFBUURkME0zVUFhWHdD?=
 =?utf-8?B?VzBwbzM1VThabStXTWZORkJscUlqM2VtUFp6blpYOUUyRnNTSjFkTE1ERUU3?=
 =?utf-8?B?enorOFNweHFncHg4U2ZpY2MveDFXWWtvbFoxUisxaHVXdlhvNEFkTlIrazAw?=
 =?utf-8?B?cmFhOVptc1NSSmZ0d3hQRFRmSjJiei9Fa0E5UEQyK3dBMUVYb3VWYlB4VFdX?=
 =?utf-8?B?cUpOaDNxK0E4V2VzQ0RSUVFsaGx6b0laYjc3RnFib0E2ZDljUGRvTmZFeGpp?=
 =?utf-8?B?Vld2R2xHaEFrQUd6UlVrcmRjYTU3dFo3OEpSeGh1dC9jZTJEOC9xZUNFRS9Y?=
 =?utf-8?B?TEhJblVTRnhWM05Rb3Q0QmpLNGd0OFUxLy82b0JkVk1ZOEtyZGRWSVJjSVA1?=
 =?utf-8?B?TkZoK1pnK21odyt6YW8xTUhEQTZCbTQ5NUdIN3p3T1VlQ0MrTStXR2JLK3V3?=
 =?utf-8?B?SDlET1MvUzg1OW1zaWZBRlVHUVd6cUJ5bTFlcTR5VUQ1dDI0ZlFra2xHTUw5?=
 =?utf-8?B?OFZjSTI3MTdTRHFvYUhEdSt6ZUdkUkxBSkh3Y1YzeVFnWUowUCtQbGFVR0hn?=
 =?utf-8?B?QjRNTTFDWmo4VzQwRDJvNEo2RG9IK3RhODUremt0U0JoZ1RkWGZwSm9sV3do?=
 =?utf-8?Q?y4XY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6d43ca-c4b1-4afa-52fb-08da9716ba59
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 12:35:09.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSpX3I0PRO1BUSuIfR2D/kquN0ApoYMQt5ih5pYRmO9QSHaED96pa9m2EuMicvNGne26bAe44GmyH33WaSW2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAxNSwgMjAyMiA4OjE2IEFNDQoNCj4gT24gOS8xNS8yMiAxMjowMSwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+IFRoZSBjaXRlZCBjb21taXQgWzFdIGRlc2NyaWJlcyB0
aGF0IHdoZW4gdXNpbmcgd3JpdGVsKCksIGV4cGxjaXQgd21iKCkNCj4gPiBpcyBub3QgbmVlZGVk
LiBIb3dldmVyLCBpdCBzaG91bGQgaGF2ZSBzYWlkIHRoYXQgZG1hX3dtYigpIGlzIG5vdA0KPiA+
IG5lZWRlZC4NCj4gPg0KPiA+IEhlbmNlIHVwZGF0ZSB0aGUgZXhhbXBsZSB0byBiZSBtb3JlIGFj
Y3VyYXRlIHRoYXQgbWF0Y2hlcyB0aGUgY3VycmVudA0KPiA+IGltcGxlbWVudGF0aW9uIGFuZCBk
b2N1bWVudCBzZWN0aW9uIG9mIGRtYV93bWIoKS9kbWFfcm1iKCkuDQo+ID4NCj4gPiBbMV0gY29t
bWl0IDU4NDY1ODFlMzU2MyAoImxvY2tpbmcvbWVtb3J5LWJhcnJpZXJzLnR4dDogRml4IGJyb2tl
biBETUENCj4gPiB2cy4gTU1JTyBvcmRlcmluZyBleGFtcGxlIikNCj4gDQo+IEp1c3Qgc2F5IHRo
ZSBibGFtZWQgY29tbWl0IHdpdGhvdXQgdXNpbmcgbnVtYmVyZWQgcmVmZXJlbmNlcy4NCg0KT2su
IFdpbGwgc2VuZCB2MSB3aXRoIHRoZSBjaGFuZ2UuDQo=
