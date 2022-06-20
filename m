Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D5521B6
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiFTP63 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244627AbiFTP6Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 11:58:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138A1EADD;
        Mon, 20 Jun 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655740700; x=1687276700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y/djgT4iBBr/ArnH7FkGhAdyqkPJZ0/L/qncw9+btx4=;
  b=RUrJbJikiMyTjZqHXK/3QVyWOgnfg2J0H+RjTPUzZW3ghB6ajQtM9eEq
   riFRI5/t7AWMHO3UBpqSZn33jdw9zoxyd9dM3ho4sEFccTJIUig85/qgD
   J/3VPTztJYos4sRdpTSSBOIe5szWoYz3GO22YVpEh5gcUESM+qGw5yZSa
   57ZDPJ7s54sdOShx3ongvCsHvGLfJMzuliXngC97SRBUtkvH/VY2cZujw
   5usfihT9LomBBveiwQl/mKEdqrM99C1qA7SYkx96ipP518nXnrD13Bgjz
   qGUr78+14zWK/IFAk+Ie2og6eFuiPiQmxwZ5GZzaFVorebYL6rApllRAY
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="100863497"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 08:58:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 08:58:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Jun 2022 08:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL+ropdJ6rlf91+V9TB+UCQc8Wsiv9cE2jyM0eL8d0hy76lGKGI9qcD/rdWJqPkDbdeDAaUjl5FBhui+IFM2v9j1iSH/RTHFKlc831TEBVxSwrF2zuTJIRNCAOvXF6BWRHNpngyswZGwoDib1xpAZ5GlqPXpu5nAA0bjLtWgyuQlx3m+fbEMpq6LhRTIwaIzhAKQw6M5QaOMJVCBc2ZtWU4Cig5/HhrgFYAsc+S/gmmdvPsRQVNsK6REg+mRsIZ22QFPfSB9OLcfQOo6CcoPor+50UxeWC+AbLoODmhnmMn2OCbQ7rmfC9PbDWtK2xtkB9dmuGBUGsYWsnNS7+N+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/djgT4iBBr/ArnH7FkGhAdyqkPJZ0/L/qncw9+btx4=;
 b=K9IiPoiTDPn5JcMPsrHVAbU7++CR+GnEy09reArSAWCI/TuCyIsPZzduDPrr59kSL7vf97xPwGmKuKVs43myhU6oLboOHPU3y5ZeM4CH/fbdiLD0cbBdkmmiPpLz8WKzWPRBNjGWcXh+5wWs79IijLFYoIrGtpy6pSHE4m7HP5t+MIn+59zjKipPF4rec5VIttuHVY4UFBPe2yljax8EM3JihxbpD6Ag5RHy/86q+v1OFgmHv50JdguyZuRvMkYVdT+oG2tHfpJB+64MikOdN859J4ABNHogU3hQXIJ+VmmB5dXhKlmeNovTlhlrx19AwOyH291pfBkYLu3uOJ17jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/djgT4iBBr/ArnH7FkGhAdyqkPJZ0/L/qncw9+btx4=;
 b=IN2zbO9Psza4o+BBj/b8PyKN2e76CkBhpy02yfqCwC4iVX1P9qPn6hIN20s0BXPWGxKXWl/MXLv/62fvh8jiw4RETiTo6mRT7hhiyg7jymI8tHdJpaWmZtaWO0NrO+JbTGjCzQR1r9TfFBJWngU4oxk4z596nbJ9wwPtXJNel4s=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5507.namprd11.prod.outlook.com (2603:10b6:610:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Mon, 20 Jun
 2022 15:57:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.020; Mon, 20 Jun 2022
 15:57:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <palmer@rivosinc.com>, <arnd@arndb.de>,
        <peterz@infradead.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5] riscv: Add qspinlock support
Thread-Topic: [PATCH V5] riscv: Add qspinlock support
Thread-Index: AQHYhL4f4Ilerb/kb0KG65AHApdLRK1Yc4QA
Date:   Mon, 20 Jun 2022 15:57:55 +0000
Message-ID: <a498a2ff-2503-b25c-53c9-55f5f2480bf6@microchip.com>
References: <20220620155404.1968739-1-guoren@kernel.org>
In-Reply-To: <20220620155404.1968739-1-guoren@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1e6352-93a0-4e74-803c-08da52d5a3ca
x-ms-traffictypediagnostic: CH0PR11MB5507:EE_
x-microsoft-antispam-prvs: <CH0PR11MB55076FCB2C3B086F034560F398B09@CH0PR11MB5507.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 469puQ15gviT2ttt7NNSb0jaqzZ1T4piUVg9wPDmGE84Wfd1DQe7Ht+ytCoSVeSkIXdwy9kjPkLbudbtGJIU3s+x+W+Cry6txkqd873qqXcOIeKD4nbVxQ7IrdwvCmJr+uMrOrAb/6PpxrenoVMYHk3TF0lTUkNDcT6yjcSp/aaBlV0AfeDowDyU03+n+LJqX5UcMA07qePCQsqLImCH+aD6Gp2CZsUX1XIDclReGhJp+IWaoVDQ/U7SHqAmyOwqfkq7KJcZyp40YO/FI43D/kom+lq3CKTX2MD/TUArjkzGvdAv/H/IDFd7vt8QLxBWNTCY3t+GV6zXOINRDh614BhvguxB4G16nF59pUtT1oTiazB+y2tI8BcsOT0QzzV4T9gTgpo5qvm4ibG9fTZ1TOmNULmrOAtJPt5yxjmUqS9dgnYH/ryPRvjAGzNdVGcrErq2tvsSoHeDeJb/hSnplN9SeOwb6exyoH5fzoqBcVxw5wrb0XsTuh2SP/r7MXvJZ2SUI+zmhTCh6dJL/xOd+dYrspXgAFtuuwGchsYoyml6qnND05hnRWT2969MJgiowjEcNMZD0NaOPV3ZnLeydBwepk8X9J7OsMMg9D4z5CAwGFDsVKiwGMeM46h2UcJAyGmmxvEDdeMY88c8u3VeqxQ1xfvZSOdDr+gGczww9YheK7fkoEaEsqCpdnUIFuc/F8SQm/pTPQSutv/5yr/P3w/CR9Bp82pOcKRLXmKu/m3yD3b81yHt63lMtiEvJ5KUU+xTCqDYdXQvQ9GE9gyLS+xiGKuGCkdmyOeXXCQNErtyR4qZnk7EsMLM7d0Njx45suU6rDqnMQ41mouaMskYbbmpky6OsqkbA5bHQtbzXyTh1B4FaCxNat0B7cJlJYpWpRURB9YmG6lRiHrR7A/fyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(366004)(346002)(376002)(2616005)(36756003)(71200400001)(66446008)(66476007)(186003)(5660300002)(64756008)(478600001)(966005)(7416002)(66556008)(31686004)(76116006)(316002)(6506007)(6486002)(66946007)(8676002)(53546011)(83380400001)(110136005)(4326008)(41300700001)(2906002)(26005)(122000001)(8936002)(38100700002)(31696002)(86362001)(6512007)(91956017)(54906003)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhQV1RvdkpXeEVlMWpXdWEwNjIwb0gvK0E3eHpmeE00dW01dWpLMitoSElH?=
 =?utf-8?B?bDN3UXd2TXBOcXRzKzBKSW1nc2dUUWJ0SUd5cE1IckJCSjg4YUlmWEFTVlFx?=
 =?utf-8?B?SHNIRmJNUVV3WmV1VzA2TzFzUkNITG1HeTdsQWhiNzNhamovK0NNTjMwUERa?=
 =?utf-8?B?dklyWExYL3RUMVNOQ1dSbE85VjVHUE5NbURIUk5hODZKdWx6alBvT1ZiZUkv?=
 =?utf-8?B?ZkVyNXh4ZzBFYXlDMmtnMkY0OUFleFpleHljdnBXbGtRaUVTUWhHRnA2Vzd5?=
 =?utf-8?B?N0pVOWplczNqR21PeWhXQnhkc2Q2bHZmRmdHWGpGM25PaFMzaVRxSThGTUNY?=
 =?utf-8?B?aUZJd25NWW1NZEcxcGo5RTdoV015bFpHQTRwK3A5UWJMeEZHcGhFTW1KZS9M?=
 =?utf-8?B?MjlRVGFNRnV0cUkrVFFIaS9ab3c2cWFMWktmR21WMVdjSFJqY3E4SjYxZWJI?=
 =?utf-8?B?Z3RmcGJTMTV0OVR6eHNnSmZqNlNtSUpVSXFEOGN0bWZnR0UyNW5BNW9nVmhX?=
 =?utf-8?B?OENNQTJ6Y05maWVuUndMVGIyZnZmSzFjcm5LR2orZUNkZVB3K2xyK3o2K1VT?=
 =?utf-8?B?d043bldJbUxqVm9rcEZRTHE0NFh3Y2Zsb0doZXU0dHcxUE9SYXJYYldpVk9u?=
 =?utf-8?B?a3dCSGZ4TThudmhhcjdiTWVzeEQzL093dWx4b1MwZUltQS9XMDRDVHNCeG1N?=
 =?utf-8?B?dVd5aUlVWkQrREdqK3BCaHRZb1Z6UHZvQTJHaVJwMWo0RmJ1NXFISGZpMUpu?=
 =?utf-8?B?aUtFb2xpcGIrWlY3OUpDSkl6bUJWYjg1NFdNL1dURzJibCs0R0h2V2FKcE0z?=
 =?utf-8?B?Q2VJbyswcWk1c0lIeWJhdEprWW9OeTBNdTJlb1NveE9FTWZwV0ljZG80aVda?=
 =?utf-8?B?anc5SGJCUnF0MnVJN0hiTHJZRWxmeFpGR01OVmtESlJYbUN3SlhJNzU4WFZt?=
 =?utf-8?B?YWpCSE8xUmszQmRWTjFlejl4ZzUxc2RtQVlvbVVNOVNSOUVpTktQRnNXaEQy?=
 =?utf-8?B?SnVOUkRCQWJyWU9CTG1XaFBlWjh3TFN6b0grNHFob0EwTHlEd3B3bExaaFVB?=
 =?utf-8?B?ODljUGp1cU1VSFJkMFBWOGhsTUNIZU40RnJvNjlEaXUwMEhYL0doVDFWVlNm?=
 =?utf-8?B?cmZDcFprZDErL08vZXBqVnc3MWExV0hMTWc3bEhqQUJVWkk2VmlCYlh6dVlB?=
 =?utf-8?B?MTkxK05Rc2lqamVYSUY5b2hGUXpYYUs1ZDJjRk9PWVNxREliRDM3SWFaOTNB?=
 =?utf-8?B?SW9xaURMdXExK01yVFROTG9VU0hMQlp1ejNSeDNlMi83M1RmMWdwRVRJS254?=
 =?utf-8?B?eFBNWnNBQmxmanFnTmd0MWJqUmlnazN2alcySkYzSDBESEtGRlBrK2txNU5O?=
 =?utf-8?B?OHBtMUY3QzZHU0dFWU9FaTdmaFFIbG02amVmam5pVUJKdjM2RFpHUGdQa0tB?=
 =?utf-8?B?ZFVGRWVuTGhZNkNHbEhKMmRPZG43QXVtWXdzcHdMbXQ1V0lIR2pMZ0tlL1Vi?=
 =?utf-8?B?NG5DdEU0enROd0hueFlVUjV5MDgrT09tYkNJRWE4ZGwzMmk1VTNBQ2R5ZURI?=
 =?utf-8?B?UERnYXhEQTZZL3R4cVRlQmlhVXVsU2IzZDdRK0tRSHpKYnF1N3kwNGlQS1Nr?=
 =?utf-8?B?bkxqRksvSGxseDdwMXVLVncwbG5yQkFXYXRpMDBweDdmcm1KR0FBdFpiWnFZ?=
 =?utf-8?B?MTk0WnFiUGFINFowclViRWlJVjNFaTkzVlFib3lrYVEvWnZCYzgxaGJ6Ujg0?=
 =?utf-8?B?UUtJU29LTjhTQzQ5d0JOTUVxSmJCdDJzOW9UY2dIUjFWU0FXV21kcHlDcHVx?=
 =?utf-8?B?TVc4NER6NGJ1bXdlQTBxTHg1Wk50UDBQaXZ3RlRqY2E1dUExNGJMLzcxT0pE?=
 =?utf-8?B?QmdDYlpRTXVTS0ZKUTVYcVBDVUtxZi9sSExqTzBXTjY5N0FmMncwTXVpOHVH?=
 =?utf-8?B?RzJ1UUYzakd2TnlvQXJvQlRxSFRncEFOZDIxZHdlcmQ4VGMrY0JZRlh0cUZS?=
 =?utf-8?B?YWhHa0Q5ZGtBeU5jMURVRUY3eEMxODJBSTc4RmJsRDkvNUV3RnB5NzZrWjZJ?=
 =?utf-8?B?MkJvYnR5UWszTzVVcU9kU3FsbFdRRlQzZkFWOStkeDBuTWVyN3F4emlxeDBX?=
 =?utf-8?B?SmprbWQ3R1BCYWpzWGxlUi9ZbjNNL0JZSDRKZ1FrSy9BWEFlVU8vb3Y1OWs0?=
 =?utf-8?B?WHAwTXZoUHorK3VUbnBPMERVYzhkSWQzU0oxb0NUTzQrYzF5anBQUFUrQS9n?=
 =?utf-8?B?U09HRDZ2OUc1dDFaZDFsdjcyYy9mMFBtSC9pM1B6Vzl6TkRNRW1VeHk0K2RI?=
 =?utf-8?B?V3FWaS9mcnBBM2ltNlcxSTBRdnpEY21aenZNY0lscnVaM1lhalZCRnB0bXFv?=
 =?utf-8?Q?ni8hvXt1kzx+hu9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64F8B602B64A9A44B482B8490383F88B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1e6352-93a0-4e74-803c-08da52d5a3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 15:57:55.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxb5DlhWtWLsa9Q74gMxWkqE/wEuQWqftsA7vqos9kC4NSdPfnRtb1b68loH5erQrVFQsIhwXLudyXxAvM16w8uXFQjX4O6kZubkETgFank=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5507
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCk9uIDIwLzA2LzIwMjIgMTY6NTQsIGd1b3JlbkBrZXJuZWwub3JnIHdyb3RlOg0KPiBGcm9t
OiBHdW8gUmVuIDxndW9yZW5AbGludXguYWxpYmFiYS5jb20+DQo+IA0KPiBFbmFibGUgcXNwaW5s
b2NrIGFuZCBtZWV0IHRoZSByZXF1aXJlbWVudHMgbWVudGlvbmVkIGluIGE4YWQwN2U1MjQwYzkN
Cj4gKCJhc20tZ2VuZXJpYzogcXNwaW5sb2NrOiBJbmRpY2F0ZSB0aGUgdXNlIG9mIG1peGVkLXNp
emUgYXRvbWljcyIpLg0KPiANCj4gIC0gUklTQy1WIGF0b21pY18qX3JlbGVhc2UoKS9hdG9taWNf
Kl9hY3F1aXJlKCkgYXJlIGltcGxlbWVudGVkIHdpdGgNCj4gICAgb3duIHJlbGF4ZWQgdmVyc2lv
biBwbHVzIGFjcXVpcmUvcmVsZWFzZV9mZW5jZSBmb3IgUkNzYw0KPiAgICBzeW5jaHJvbml6YXRp
b24uDQo+IA0KPiAgLSBSSVNDLVYgTFIvU0MgcGFpcnMgY291bGQgcHJvdmlkZSBhIHN0cm9uZy93
ZWFrIGZvcndhcmQgZ3VhcmFudGVlDQo+ICAgIHRoYXQgZGVwZW5kcyBvbiBtaWNyby1hcmNoaXRl
Y3R1cmUuIEFuZCBSSVNDLVYgSVNBIHNwZWMgaGFzIGdpdmVuDQo+ICAgIG91dCBzZXZlcmFsIGxp
bWl0YXRpb25zIHRvIGxldCBoYXJkd2FyZSBzdXBwb3J0IHN0cmljdCBmb3J3YXJkDQo+ICAgIGd1
YXJhbnRlZSAoUklTQy1WIFVzZXIgSVNBIC0gOC4zIEV2ZW50dWFsIFN1Y2Nlc3Mgb2YNCj4gICAg
U3RvcmUtQ29uZGl0aW9uYWwgSW5zdHJ1Y3Rpb25zKS4gU29tZSByaXNjdiBjb3JlcyBzdWNoIGFz
IEJPT012Mw0KPiAgICAmIFhpYW5nU2hhbiBjb3VsZCBwcm92aWRlIHN0cmljdCAmIHN0cm9uZyBm
b3J3YXJkIGd1YXJhbnRlZSAoVGhlDQo+ICAgIGNhY2hlIGxpbmUgd291bGQgYmUga2VwdCBpbiBh
biBleGNsdXNpdmUgc3RhdGUgZm9yIEJhY2tvZmYgY3ljbGVzLA0KPiAgICBhbmQgb25seSB0aGlz
IGNvcmUncyBpbnRlcnJ1cHQgY291bGQgYnJlYWsgdGhlIExSL1NDIHBhaXIpLg0KPiANCj4gIC0g
UklTQy1WIGNvdWxkIHByb3ZpZGUgY2hlYXAgYXRvbWljX2ZldGNoX29yX2FjcXVpcmUoKSB3aXRo
IFJDc2MuDQo+IA0KPiAgLSBSSVNDLVYgb25seSBwcm92aWRlcyByZWxheGVkIHhoZzE2IHRvIHN1
cHBvcnQgcXNwaW5sb2NrLg0KPiANCj4gVGhlIGZpcnN0IHZlcnNpb24gb2YgcGF0Y2ggd2FzIG1h
ZGUgaW4gMjAxOS4xIFsxXS4gVGhlIHNlY29uZCB2ZXJzaW9uDQo+IHdhcyBtYWRlIGluIDIwMjAu
MTEgWzJdLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIw
MTkwMjExMDQzODI5LjMwMDk2LTEtbWljaGFlbGpjbGFya0BtYWMuY29tLyNyDQo+IFsyXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8xNjA2MjI1NDM3LTIyOTQ4LTItZ2l0LXNl
bmQtZW1haWwtZ3VvcmVuQGtlcm5lbC5vcmcvDQo+IA0KPiBDaGFuZ2UgVjU6DQo+ICAtIFVwZGF0
ZSBjb21tZW50IHdpdGggUklTQy1WIGZvcndhcmQgZ3VhcmFudGVlIGZlYXR1cmUuDQo+ICAtIEJh
Y2sgdG8gVjMgZGlyZWN0aW9uIGFuZCBvcHRpbWl6ZSBhc20gY29kZS4NCj4gDQo+IENoYW5nZSBW
NDoNCj4gIC0gUmVtb3ZlIGN1c3RvbSBzdWItd29yZCB4Y2hnIGltcGxlbWVudGF0aW9uDQo+ICAt
IEFkZCBBUkNIX1VTRV9RVUVVRURfU1BJTkxPQ0tTX1hDSEczMiBpbiBsb2NraW5nL3FzcGlubG9j
aw0KPiANCj4gQ2hhbmdlIFYzOg0KPiAgLSBDb2RpbmcgY29udmVudGlvbiBieSBQZXRlciBaaWps
c3RyYSdzIGFkdmljZXMNCj4gDQo+IENoYW5nZSBWMjoNCj4gIC0gQ29kaW5nIGNvbnZlbnRpb24g
aW4gY21weGNoZy5oDQo+ICAtIFJlLWltcGxlbWVudCBzaG9ydCB4Y2hnDQo+ICAtIFJlbW92ZSBj
aGFyICYgY21weGNoZyBpbXBsZW1lbnRhdGlvbnMNCg0KSGV5LA0KSG93IGNvbWUgdGhlIGNoYW5n
ZWxvZyBpcyBpbnNpZGUgdGhlIGNvbW1pdCBtZXNzYWdlPw0KSSBhc3N1bWUgaXRzIGEgY29weSBw
YXN0ZSBlcnJvci4uDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3Vv
IFJlbiA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdW8gUmVu
IDxndW9yZW5Aa2VybmVsLm9yZz4NCj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4NCj4gQ2M6IFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+DQo+IENjOiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBDYzogUGFsbWVyIERhYmJlbHQgPHBhbG1l
ckByaXZvc2luYy5jb20+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL0tidWls
ZCAgICAgICAgICAgfCAgNCArKy0tDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NtcHhjaGcu
aCAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3NwaW5sb2NrLmggICAgICAgfCAxMiArKysrKysrKysrKysNCj4gIGFyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vc3BpbmxvY2tfdHlwZXMuaCB8IDEyICsrKysrKysrKysrKw0KPiAgNSBmaWxlcyBjaGFu
Z2VkLCA1MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2suaA0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2tfdHlwZXMuaA0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0KPiBpbmRleCAz
MmZmZWY5ZjZlNWIuLjNiMGIxMTdiNGU5NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9LY29u
ZmlnDQo+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0KPiBAQCAtMzMzLDYgKzMzMywxNSBAQCBj
b25maWcgTk9ERVNfU0hJRlQNCj4gIAkgIFNwZWNpZnkgdGhlIG1heGltdW0gbnVtYmVyIG9mIE5V
TUEgTm9kZXMgYXZhaWxhYmxlIG9uIHRoZSB0YXJnZXQNCj4gIAkgIHN5c3RlbS4gIEluY3JlYXNl
cyBtZW1vcnkgcmVzZXJ2ZWQgdG8gYWNjb21tb2RhdGUgdmFyaW91cyB0YWJsZXMuDQo+ICANCj4g
K2NvbmZpZyBSSVNDVl9VU0VfUVVFVUVEX1NQSU5MT0NLUw0KPiArCWJvb2wgIlVzaW5nIHF1ZXVl
ZCBzcGlubG9jayBpbnN0ZWFkIG9mIHRpY2tldC1sb2NrIg0KPiArCWRlcGVuZHMgb24gU01QICYm
IE1NVQ0KPiArCXNlbGVjdCBBUkNIX1VTRV9RVUVVRURfU1BJTkxPQ0tTDQo+ICsJZGVmYXVsdCB5
IGlmIE5VTUENCj4gKwloZWxwDQo+ICsJICBNYWtlIHN1cmUgeW91ciBtaWNybyBhcmNoIExML1ND
IGhhcyBhIHN0cm9uZyBmb3J3YXJkIHByb2dyZXNzIGd1YXJhbnRlZS4NCj4gKwkgIE90aGVyd2lz
ZSwgc3RheSBhdCB0aWNrZXQtbG9jay4NCj4gKw0KPiAgY29uZmlnIFJJU0NWX0FMVEVSTkFUSVZF
DQo+ICAJYm9vbA0KPiAgCWRlcGVuZHMgb24gIVhJUF9LRVJORUwNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vS2J1aWxkIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9LYnVp
bGQNCj4gaW5kZXggNTA0ZjhiN2U3MmQ0Li5lMDY2Y2NhYjY0MTcgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vS2J1aWxkDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vS2J1aWxkDQo+IEBAIC0yLDEwICsyLDEwIEBADQo+ICBnZW5lcmljLXkgKz0gZWFybHlfaW9y
ZW1hcC5oDQo+ICBnZW5lcmljLXkgKz0gZmxhdC5oDQo+ICBnZW5lcmljLXkgKz0ga3ZtX3BhcmEu
aA0KPiArZ2VuZXJpYy15ICs9IG1jc19zcGlubG9jay5oDQo+ICBnZW5lcmljLXkgKz0gcGFycG9y
dC5oDQo+IC1nZW5lcmljLXkgKz0gc3BpbmxvY2suaA0KPiAtZ2VuZXJpYy15ICs9IHNwaW5sb2Nr
X3R5cGVzLmgNCj4gIGdlbmVyaWMteSArPSBxcndsb2NrLmgNCj4gIGdlbmVyaWMteSArPSBxcnds
b2NrX3R5cGVzLmgNCj4gK2dlbmVyaWMteSArPSBxc3BpbmxvY2suaA0KPiAgZ2VuZXJpYy15ICs9
IHVzZXIuaA0KPiAgZ2VuZXJpYy15ICs9IHZtbGludXgubGRzLmgNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vY21weGNoZy5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9j
bXB4Y2hnLmgNCj4gaW5kZXggMTJkZWJjZTIzNWU1Li5mN2Y4ZTM1OWQzYWMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY21weGNoZy5oDQo+ICsrKyBiL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vY21weGNoZy5oDQo+IEBAIC0xNyw2ICsxNywyMiBAQA0KPiAgCV9fdHlwZW9m
X18obmV3KSBfX25ldyA9IChuZXcpOwkJCQkJXA0KPiAgCV9fdHlwZW9mX18oKihwdHIpKSBfX3Jl
dDsJCQkJCVwNCj4gIAlzd2l0Y2ggKHNpemUpIHsJCQkJCQkJXA0KPiArCWNhc2UgMjoJCQkJCQkJ
CVwNCj4gKwkJdTMyIHRlbXA7CQkJCQkJXA0KPiArCQl1MzIgc2hpZiA9ICgodWxvbmcpX19wdHIg
JiAyKSA/IDE2IDogMDsJCQlcDQo+ICsJCXUzMiBtYXNrID0gMHhmZmZmIDw8IHNoaWY7CQkJCVwN
Cj4gKwkJX19wdHIgPSAoX190eXBlb2ZfXyhwdHIpKSgodWxvbmcpX19wdHIgJiB+KHVsb25nKTIp
OwlcDQo+ICsJCV9fYXNtX18gX192b2xhdGlsZV9fICgJCQkJCVwNCj4gKwkJCSIwOglsci53ICUw
LCAlMlxuIgkJCQlcDQo+ICsJCQkiCWFuZCAgJTEsICUwLCAlejNcbiIJCQlcDQo+ICsJCQkiCW9y
ICAgJTEsICUxLCAlejRcbiIJCQlcDQo+ICsJCQkiCXNjLncgJTEsICUxLCAlMlxuIgkJCVwNCj4g
KwkJCSIJYm5leiAlMSwgMGJcbiIJCQkJXA0KPiArCQkJOiAiPSZyIiAoX19yZXQpLCAiPSZyIiAo
dGVtcCksICIrQSIgKCpfX3B0cikJXA0KPiArCQkJOiAickoiICh+bWFzayksICJySiIgKF9fbmV3
IDw8IHNoaWYpCQlcDQo+ICsJCQk6ICJtZW1vcnkiKTsJCQkJCVwNCj4gKwkJX19yZXQgPSAoX19y
ZXQgJiBtYXNrKSA+PiBzaGlmOwkJCQlcDQo+ICsJCWJyZWFrOwkJCQkJCQlcDQo+ICAJY2FzZSA0
OgkJCQkJCQkJXA0KPiAgCQlfX2FzbV9fIF9fdm9sYXRpbGVfXyAoCQkJCQlcDQo+ICAJCQkiCWFt
b3N3YXAudyAlMCwgJTIsICUxXG4iCQkJXA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS9zcGlubG9jay5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9jay5oDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmQzZmQwOWNmZjUy
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9j
ay5oDQo+IEBAIC0wLDAgKzEsMTIgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovDQo+ICsjaWZuZGVmIF9fQVNNX1NQSU5MT0NLX0gNCj4gKyNkZWZpbmUgX19BU01f
U1BJTkxPQ0tfSA0KPiArDQo+ICsjaWZkZWYgQ09ORklHX0FSQ0hfVVNFX1FVRVVFRF9TUElOTE9D
S1MNCj4gKyNpbmNsdWRlIDxhc20vcXNwaW5sb2NrLmg+DQo+ICsjaW5jbHVkZSA8YXNtL3Fyd2xv
Y2suaD4NCj4gKyNlbHNlDQo+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvc3BpbmxvY2suaD4NCj4g
KyNlbmRpZg0KPiArDQo+ICsjZW5kaWYgLyogX19BU01fU1BJTkxPQ0tfSCAqLw0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oIGIvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAwMDAwMC4uOTI4MTIzN2I1ZjRlDQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oDQo+IEBAIC0wLDAgKzEs
MTIgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsjaWZu
ZGVmIF9fQVNNX1NQSU5MT0NLX1RZUEVTX0gNCj4gKyNkZWZpbmUgX19BU01fU1BJTkxPQ0tfVFlQ
RVNfSA0KPiArDQo+ICsjaWZkZWYgQ09ORklHX0FSQ0hfVVNFX1FVRVVFRF9TUElOTE9DS1MNCj4g
KyNpbmNsdWRlIDxhc20tZ2VuZXJpYy9xc3BpbmxvY2tfdHlwZXMuaD4NCj4gKyNpbmNsdWRlIDxh
c20tZ2VuZXJpYy9xcndsb2NrX3R5cGVzLmg+DQo+ICsjZWxzZQ0KPiArI2luY2x1ZGUgPGFzbS1n
ZW5lcmljL3NwaW5sb2NrX3R5cGVzLmg+DQo+ICsjZW5kaWYNCj4gKw0KPiArI2VuZGlmIC8qIF9f
QVNNX1NQSU5MT0NLX1RZUEVTX0ggKi8NCg==
