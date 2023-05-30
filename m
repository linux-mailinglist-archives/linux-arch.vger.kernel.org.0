Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE1715693
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjE3HW1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjE3HWR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 03:22:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F381B4;
        Tue, 30 May 2023 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685431301; x=1716967301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rxIAP8lHuOgfB7L+qbEmgGwLzbXFFXWqqxV+7aG8JF8=;
  b=OO1NIAhw0tHAIBCBhwOe9JyHK4/mi585AonhOFAe3VF6tpf9aratQr3B
   y1zgk4kwznYAOG5BSMTGqnDuhHU6vR6hIAofJaj5FegpCf2nuPN9Lr3Lf
   MDyMufFrbeL+cLzeg9ONKiNs9xeTnNkwN4Dfu9ZtujdwiZuFiIyGuvE+N
   RmnJbQhXZz2F+09aVS0rOhQfGgrJrrT+h5+GnSBYah0Swj/AA6FQyNXo+
   KlKh3PFm6ndM8NXH0wrHBUrep/0ULsT5Ca4OPiDN0XEnH+4SiRUAo3HF4
   UFIrnOYZVKDZICc8QkD0n64SYamRZvhWLpk7tcfyBKin5SX2xRyIqVwtv
   g==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="154546461"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 00:20:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 00:20:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 00:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obCnWKuSfmgqjm1tZBTT0Kz8DSNln0Lj/3r3dLClx1dBvLdaNTLbmCvGwzV7+Tu8uEBkrIc5YR0DxRDbCQny/xoSQqcwO2FaQO7nqBT1kmnG11BB+iaZDAHIQba8hTt9enYGSZGhZeHE2vv7m/32s0Gv1qnwSD0Aq9ny+R1intVmLLOaMEqvcKHOLfUwSwzMxM8Y6bjzDOnvgTixMDgRlP0P3CKgAFcBp/mIZHZ3AKPQ1ztAmOUx3zJP047vS5DTxu8FV8QlPAVXwhBLikhRzfBG7wO1nj5MUstxNz/3obht9Fszhmt/2gr8sOJcQ1WECiE+D5lN9ids1bhN4vbA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxIAP8lHuOgfB7L+qbEmgGwLzbXFFXWqqxV+7aG8JF8=;
 b=UR6pZmkmLj9R8TEH/KQpulO8VvLi6md2teMz+Z40u+NO6SbXlSs+Jqg/3vLGKDPf5JufcWUSPiCjt+SVxiBydpp+MaKt3LT5lmUET6FL39WpHPRxqhQK2n2qNYxAo0QW9GroG4b6CiHQHdxq6OAdPxTtsyxmeWI3lup4UFokNpp3WWm4IzZc6Yz9dFpm76K0xs9zb980ONGfEwR8j9dBT8+7uN1QJLr0Nmsgjm1XDIJ1cQDdx1B4VY8ktrzMvu02vu+9X6KipJQAcuy2VJZMjs5jV3zxYtf6weMwFhTUhX5VQjc/mV8wkVl6e9+YxM+aipbgNEkxl+hRKq/ieibDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxIAP8lHuOgfB7L+qbEmgGwLzbXFFXWqqxV+7aG8JF8=;
 b=p5aNFXqbW8W2yn4lezTAfZxzF2TKRRaMck0jc8S2MR8aNjcYlhZBHObtlHwO6buT97OLzIkXHZX8T+Z461XiI4CFxWzbk5svwaLHDsqtV3mcN4uLlHhEvvcRCQyJFiHIaZXyXzvXNevScmrZ1peEmy9M7DfgWW6qfwcdyqoJ35M=
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9)
 by CH0PR11MB5521.namprd11.prod.outlook.com (2603:10b6:610:d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:20:18 +0000
Received: from SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::8052:da5b:3a4d:45a]) by SJ0PR11MB7154.namprd11.prod.outlook.com
 ([fe80::8052:da5b:3a4d:45a%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 07:20:18 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmitry.torokhov@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <linux-input@vger.kernel.org>,
        <linux-sunxi@lists.linux.dev>, <linux-pwm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] docs: update some straggling Documentation/arm
 references
Thread-Topic: [PATCH v2 6/7] docs: update some straggling Documentation/arm
 references
Thread-Index: AQHZkscvIdN9W+pkhUmgiiCVazVTiQ==
Date:   Tue, 30 May 2023 07:20:18 +0000
Message-ID: <b4dac802-f600-6459-1f4a-241a62676fdd@microchip.com>
References: <20230529144856.102755-1-corbet@lwn.net>
 <20230529144856.102755-7-corbet@lwn.net>
In-Reply-To: <20230529144856.102755-7-corbet@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7154:EE_|CH0PR11MB5521:EE_
x-ms-office365-filtering-correlation-id: 73dc0369-636b-4268-7895-08db60de5260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5QmMBDZEAlK1PU1GWIxGEfRIxqjkT5LODuRTkX+oyOqwiT7wiguoItCa2FKibMJb0HtY01F6BucpTR/92SxQmEddOdVw32HVLbs8w12k7EU9orSfebGNy9ibeteZd0N5PeY2r+On6OyrDCJSQRpMOCTWvI4Ebszb9j70R1Op5anz7Xd0bdGnLP4DmPdYQ53zhvF+yssM1lTaswt+D8PJpqsihtBa3cUw5xZTz9TOJ/uZ4ONVNPXAwNF76rFYWfMQC6mJ2lwPASiEqpfVcYOtSKACHWJ50eR8djacnv7P5VWrJ0WL8jqUSr1cD4iZY1MdbjzY+5kDhWgbIJ4EM1wfLFufXvPY3fKYSprFHRNbIriaoWmTv5oVUXt7n2NwbpM+Qu2q072gnBe12uELkRMxPSaS/j9yODYGv61vpo64KTQe4npDapnQoFyNKIWo/Cl1iq6vBKFOGo8Ra4wuhDhYSZOmuUTOlPPxRLtwd30hUiyy/LcH1vyqW0rWcX4kGgLrzBp/3DDDCPu4B5mzFVScfcSQ+IoVNSExWInlgLn+vDkGlQBmuiQnSCx0yHQl6x0Tt7qVSbCUXxW+ioccm4DyTbI4RasClnatQ4UG6nTezBhYHHWOemtucaVld4v4BgXPOB9NGbbmUuKSXoG5T51+3YBNSd2XxGaz/XGuEX3d9NWq65SBg4JBO7qjUECU60q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(31686004)(6486002)(478600001)(54906003)(110136005)(83380400001)(2616005)(31696002)(38070700005)(86362001)(36756003)(53546011)(6512007)(6506007)(71200400001)(4744005)(2906002)(186003)(26005)(122000001)(4326008)(38100700002)(76116006)(66946007)(66556008)(66476007)(66446008)(8936002)(316002)(64756008)(8676002)(91956017)(5660300002)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXc4cFd1Q0V5cFdId0VManExODE4OU5kazEvQ1F6dXEvRjl5L2ZENklaS2Fh?=
 =?utf-8?B?bjU5S0d2M2g3RGRuR2hnS3V2OE51b0pNaGVocitDaHp3eTZGV2t3QXZoV0ZZ?=
 =?utf-8?B?ODlOVUlWNFVMRnd1NkxSdUU3Q052OXU1Wmw4VElDTEQxTVhLeDJKZHdrSGVS?=
 =?utf-8?B?KzV1K2doMUtTbDUxVXJ2b3Ftc3R6N2xpV1RaNUhwYndXTUJLdUVtbkJnRTFR?=
 =?utf-8?B?NWZvZU5yMlpPanJBeG9TbGc5LzQ5TGkwWjM2RWtQQjJla1gxWDdsSmZVa1FK?=
 =?utf-8?B?WkVQZnI0bElhUitUK0Vsci9yU0JuR0gwSUR2QW5QQ1ExaWluVUlpQTczM3NT?=
 =?utf-8?B?ajZ2SVBJcVcvNis5Zm5jYTNyN0ZybVRnbHhsVkFBS0xOQ1hqZE9jeXh0ZHlx?=
 =?utf-8?B?RTJlbXZzK2poeVdsU2oxUVBPT0tDRnpXUGRBbUlVSXdrWGZjRkJLeWVJTXZm?=
 =?utf-8?B?VkhNWVhYR09jVDJCUkplWllFbnVtYUVSaUk5aXhoSGcvNGIwTzl6N084d1JT?=
 =?utf-8?B?TSs2OW81NmM1Tjg5dkp2L0FvajdxTmwwL2kzUXhZNnlNcU1WT1ZEbW9wQlRx?=
 =?utf-8?B?QXVaUXNFeUg2N2FoenIySlMyQk1PNjNycUVQVkpiN2JNL3hUZEVHSmhic0VW?=
 =?utf-8?B?TWxkZU9UM0hqQTBBUXI4K2R3dk1uOHQ2dzlXVDBlTzFHWG9FY2dGbWdMaiti?=
 =?utf-8?B?Q0NiOWJoQVdMV1lsSDNhcXkvMllDMmhkd3ZwV1pVYk5aYVBCWXljRlgrZFZS?=
 =?utf-8?B?VGpyQ0pzSXJzOW1EUTVCZEV6UStybWdmQnVKVzR5bXgyZG0vTktUTFhkKzJY?=
 =?utf-8?B?S2swNzJYWldGZUZsM0xCQ0s1VFlWb2xFZlphd1gvQWlGR2RrNENkZW1XUnFW?=
 =?utf-8?B?cTdINmNwOW5BVTFFL1M1d3BQeEx0Nm9BZ0t5UlM5SUF4TWZGWG9Sdm9hRUpF?=
 =?utf-8?B?c3k4Yk9DNzdqR3RUWVFpVDBNWmlRUEFaZGFtY3krdjY5bFhIWklROXdyTW82?=
 =?utf-8?B?b0VCaXFsYmxYTGNtbmMxNnpJZFNSdTJpUmhqTHhtZzVHV05VTlZIcFVUSmFL?=
 =?utf-8?B?dC9HNDExTDRUN3JLR21VR09jMG9NdjEyL01qbEYwY05jM1JvVXA2WnZWNStn?=
 =?utf-8?B?SDNxTlU2ZUhaV3NQL3N0TzZEMWsvQWFkYlE2cEdyVE41Ulh4RlhqU1gweXIx?=
 =?utf-8?B?Tnh5ZzF3Z2lOcHlCVlZ2eGZ3MHc0VitneTV4RTRZWXQ0R3JidXVPSjNiMCtx?=
 =?utf-8?B?OXgrSk0xSzdxdVU1d1piaG01MG1XN0RqNnlnRVlaL3JUMU9HenUwVnA5bWZ3?=
 =?utf-8?B?VzBMMHB6OTJBRVJRclhJekhudnhIVUY3NjJrcmFWRU5DUHhXdVQ0TDI5c014?=
 =?utf-8?B?Zk9JdlFwSU5QNVEwK0Q0a1JWTDczVEpFYUV6aEgxRFlURmdYbUNIczcyWVU0?=
 =?utf-8?B?Zm9PS2lTVFBjVFpHcWU5TWRtVytNM2gvNUtmM2xYT2JwN1VEbnpwbER0Qk85?=
 =?utf-8?B?N3NGdTBvQ2dLaXNHVXRqcGM3Tk5qM2UrZTNHNzE5cmx6cEtzaTZlL0s1Vy9K?=
 =?utf-8?B?Q0tZdTlrdkl6NUZQcFdHMHJoUXJnZEVwVFVRajllUW9ZNmNPbjFSTWppYm9X?=
 =?utf-8?B?VFBqZ2dkcWQ2dXBmWmZEREwzc2xXVjJ6WVdZcTg2cmxJMUxzbGQxdGprR0tq?=
 =?utf-8?B?SGt2V3UyVlJ0RXI4NU9udHh1eVVvcG9kdDRYWUl5NmRkOEJFTWxFMkR3ejNo?=
 =?utf-8?B?dCtoME56cFdvSnhOMFcxUGtyUjhHMTI3dHVGRmQvTG02NUxzSElMM1JGcXM3?=
 =?utf-8?B?NEpOekFnRVliNDJrYWRMeDY5ZEUzV2hNdTJRbjFlTzNnbUpFVEw5b2dCRnFy?=
 =?utf-8?B?MDdiTzBVU0ZpdjRvRjdOVXhUUC83M1dzdWFHd040aGM3YjJTT1d4ZEhZck8v?=
 =?utf-8?B?TmgxUG9GaklyVXJSRXhDaEV6Z1RYNlJXQUdpbE52clhBYll1RTZNZlpoWVcz?=
 =?utf-8?B?QnlJeGFvTDhlNVhuVW9BZFgvcS9Gc3YvQ2VUbE5oOHlkYU5sSkZhSEVlUjc0?=
 =?utf-8?B?d1JKUVYyVDVFK1hqdjg2eTk1K1V2L29aQ3o0K0Y1VGRneThJVnhab3ZkN1R4?=
 =?utf-8?Q?OKYn6e9sm95ZWDf/jVS68IHEI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8FD226F31863242A6095DF27814E9FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dc0369-636b-4268-7895-08db60de5260
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 07:20:18.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Tq2nTAFJNekzaubvscKRoTPVyd8bKsAXGSduUas4IWtw9hWLSyCphFu+RvOAlbrdGN7M9yc1ek/jEIyFP1aCNG+fRqG3K757gOuOVLE9L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5521
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDUvMjAyMyBhdCAxNjo0OCwgSm9uYXRoYW4gQ29yYmV0IHdyb3RlOg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0K
PiBpbmRleCAwYzU2N2Q5NjIzY2QuLjVmN2QyODY4NzFjZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wd20vcHdtLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4gQEAg
LTYsNyArNiw3IEBADQo+ICAgICogICAgICAgICAgICAgIEJvIFNoZW48dm9pY2Uuc2hlbkBhdG1l
bC5jb20+DQo+ICAgICoNCj4gICAgKiBMaW5rcyB0byByZWZlcmVuY2UgbWFudWFscyBmb3IgdGhl
IHN1cHBvcnRlZCBQV00gY2hpcHMgY2FuIGJlIGZvdW5kIGluDQo+IC0gKiBEb2N1bWVudGF0aW9u
L2FybS9taWNyb2NoaXAucnN0Lg0KPiArICogRG9jdW1lbnRhdGlvbi9hcmNoL2FybS9taWNyb2No
aXAucnN0Lg0KPiAgICAqDQo+ICAgICogTGltaXRhdGlvbnM6DQo+ICAgICogLSBQZXJpb2RzIHN0
YXJ0IHdpdGggdGhlIGluYWN0aXZlIGxldmVsLg0KDQpGb3IgTWljcm9jaGlwIGNoYW5nZXM6DQpB
Y2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpU
aGFua3MgSm9uYXRoYW4uIEJlc3QgcmVnYXJkcywNCiAgIE5pY29sYXMNCg0KLS0gDQpOaWNvbGFz
IEZlcnJlDQoNCg==
