Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D171F6E483D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDQMtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 08:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDQMt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 08:49:29 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86529CF;
        Mon, 17 Apr 2023 05:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt9wtS2A3Qmk9yLOE55odkIZktMI1PKvPGBfyJKPhp2+2FCTe60KKiEHQPRDO7r9Bs2M0IxuV0366pPD3ow0vqRx5gzu4bIl6Y8kkzSb6ePaYpDB2FaBUitfQetOih1doAHFzvNwiPRv+6ibvxNeOtfHiBTvturmkQvJyR+yWWTTSBZ8meKvSHds53qgDH41gEkyDf9zR+geiNywvBtkA8OvYErklyQdqNODWI4b+OTgsLKnOXT3Bh1v2i1zATbn0ofrxmjbLbEEPkjiRtxpxrbDyRwAFVrC1gObIkmVLP8Lhq+faVNycPWH7gFlf7Pmt11QTkEFpiCRX/TlevILAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFWwUunvWL0l82TpOt8pDlzJs6pJnaYimhNsOfvRlVw=;
 b=SnGwFtBwagEPzDuuNWpkY9Ey1CQ6M+krx/Qxpmt7Ax/7MU4azt+KxFdy6rp4uZEK8QnkbzJ4if6tzPez63VVIUwKljjyoeoZVKeOfvIEzio57uiTeLmHpKn6u2fCFn7+5YeS0ePE6yzO1/QVt5ci1y6Q8ZDnXG1NVJnyWC2Za0rl8dfzB89JvOZ/fhLNLbnLwW9+s8/oVWBZj8ALMtDn4q+CN/MXyXtUb/aXAF6j79G98459AuA1+Gv+cyJJM+8np4neHlr/73xjhmiRxjGKn/q+AOYc8/MV0LsjIopPIYhjde8bJqXk3MZECF/6sb9PY3yeYi5ziNf3ZVfZ0Eys2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFWwUunvWL0l82TpOt8pDlzJs6pJnaYimhNsOfvRlVw=;
 b=cNphsEGDmfOFgPu5A3SZ+QEHn4PRNsYh+ygY412EUBmxbO4hOmLAcou26H4FD+6zunJVEGGDOdL6zesVcj8omRKgvHQ6Tkifxc66S5bWh2VNfa5z5DYZOzUwG43fsqjCGH2LommTessq2SFwhFRHfdrYk04pbljOxGWN200Ylp0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB2027.namprd21.prod.outlook.com (2603:10b6:303:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.1; Mon, 17 Apr
 2023 12:49:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7%5]) with mapi id 15.20.6340.001; Mon, 17 Apr 2023
 12:49:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Topic: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for
 sev-snp enlightened guest
Thread-Index: AQHZZlQTt4ihITK/WUKaKaTay6hYrK8ny1KQgAXQHoCAAeyXcA==
Date:   Mon, 17 Apr 2023 12:49:24 +0000
Message-ID: <BYAPR21MB16889228F8F5E91DFE43AF3CD79C9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-9-ltykernel@gmail.com>
 <BYAPR21MB1688DB1442B486A8DEBEF821D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <b4c74d0e-5b54-5101-ec18-cc09449ed358@gmail.com>
In-Reply-To: <b4c74d0e-5b54-5101-ec18-cc09449ed358@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8540d53-7287-48d3-a93f-b44f4683ba05;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-17T12:44:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB2027:EE_
x-ms-office365-filtering-correlation-id: e0890cc0-736d-4b20-a7ab-08db3f422c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJMTlAqyqPyZbokK5kMf1JM+ceW/5/Ysjk9OBQxOhlFH3SgPVQk75ykNLtTYuWZTlhw12ZTFFUIdNzCO4aTEHnLcEe0qoq0ZWGqLH1iyLx8G0exvlZW6LFbRrefW116GVRQS8M0aEfqPoS4Zz+FIgNe+t5XI7NAA8MTplNW/mYlPHHF0Mya1eqYdeJe9Z4O2/D9z8v91tvVjFRVKgyQd4qlSqNvUacviFUMhrWEZcUhBq5omnNFmblncsZTOQpnDGiqWJ0Uad1jVInc+vYmzgg7WrCG0ytZqvkVjN/SnJdmuATs588A3aoLcCk49YXr0o4E2BJ/XBhs2v40Pxj9poZ+R3U54BrycsAAkYAl4DPJ4Fm64XxHog5H0VUGWb9ic7jTtN3kLwWMC2aNHJyGaNIS42HIv4/j87miFs9dwVrqqlorB5CeXbh7BEMjjLGdlIBthgoHkshloPce9vxbtV7XcVuQqTpE+bTEnj8DU3tCJkxH1a6gJih01v/cUdGNfezbP65GngdHKGZQmvjqAZZ8n6j/fGnbNiPnwJsxKCF8Z+CPElY0pLXXHhY9aZaW9VIR6HtIznYBP1+rF+XtlqI7ebIiYHsd44ObjAWzkZN5eMXMPNgXCMeqh50kXoVH1W1ogq408b+/mrTweV1J3S0q4UMmATyae05NWEp9TiOgQZ9XUaTwGjjFVIEi6qDnf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(33656002)(110136005)(54906003)(4326008)(786003)(316002)(76116006)(66556008)(66446008)(64756008)(66946007)(66476007)(71200400001)(478600001)(10290500003)(7696005)(55016003)(8990500004)(5660300002)(8936002)(8676002)(41300700001)(52536014)(4744005)(7416002)(2906002)(7406005)(38070700005)(86362001)(122000001)(82950400001)(921005)(82960400001)(38100700002)(6506007)(9686003)(186003)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFJ4NGNmZ3RMSkhDVHpOUFNWVDg3dkZta3hrMGZRK1h2dEdaeTlyZG1WbWZp?=
 =?utf-8?B?WCs0VzZFWjhzbVhrMyttZWhzQ3dkWkhzdjlQZGNLMzFGWWExVXQwK1FpV0tm?=
 =?utf-8?B?RnFCM0hqdE5wajJYR2hLOFcyalRHdEdXSTZvU3ZHSWtDN2hCbDlQUy9wL0FM?=
 =?utf-8?B?eDRMb2VLQTRNNFJvSzVKbVBZZ0V2d1ZUenFBc2kyZlRyRkNyZHNUWmRJR3JC?=
 =?utf-8?B?ellZSXBsRnJqSEZseExlU1hRYnBhZ1N2eFJqQWdVVkdVUW81QXU1a2tGYjVl?=
 =?utf-8?B?OEE5dUdqaDZMVytMa2NpSGlnYlVsYm4zbjlTZ2o5bUJaYU9pTUxHNDhvN1dh?=
 =?utf-8?B?SjNldWlvRWl4aWR2RlNkUkdyNTcyVzZuc1o2UjB1S21kTEV1WVJpekE2TUhN?=
 =?utf-8?B?ZmxiOGpPYTVyempYeDFaSzRrUmtEcmQrV2hHZ2FyVkt4dWVsRjAxL2paSzZl?=
 =?utf-8?B?UzRXeXlrMjFScC9DZzBjVmpielJweFp5WGlucXArTkg0K3E5ZDRZUU9yU0hk?=
 =?utf-8?B?UHNrQTdzOWVrTERscHZOWXI5Z29LUTgrRXJVVjhsSWFHdzFJcVcxRUp4dUkw?=
 =?utf-8?B?aGcwcFhIZ0ptTWN3UUFac2RCS212b05UM25EYVdSWURKMHpRSWYrTk9tcndF?=
 =?utf-8?B?TitDUjUyblVCcmd6WUhpSWdrYjdtd1hPOUJ4TUt6SFJsb1ZjQlFrNEJWL0ht?=
 =?utf-8?B?Z3QxQmxvNllIQnRzUFdkSmpzSEdpc2txSEd5ZHlLL2dtbER5eVhBUXRuTGZU?=
 =?utf-8?B?SDd6WXo5Sm5uYWpYNEVna1JENzdCYVlMbktMSE1kQXRPYnJzbEdNSWRqQzVV?=
 =?utf-8?B?LzI2b3liOVg2UGZoNU9iY3hHelRZZ3VzV1pDZzkrRlE4alVQdHlPVU5KTEQ4?=
 =?utf-8?B?Vm5TbHcvenBEVjZOV1BCSXpGb1htS1VZVG1TaUpFb3BUeDZlRnNnR2ZLeURm?=
 =?utf-8?B?U1RMTC9GOWJreWJ5anJ5VXBYMTZ3ME5uU0RZekhQRnBHaHdFZDIwU0VFNkY3?=
 =?utf-8?B?MXhJVGNrRjB5V0QvZXVLd1I1Z1R0S0pwb3VuRTZpSFBLenhTdWJGMllnWDlx?=
 =?utf-8?B?MlloRUhzQUZ3K052WEQzWklGT1RFa0tpN2ltVll0c3VIc0lYM3pxNmUzalM0?=
 =?utf-8?B?L0RxVHdzQUJ2QXB0RUZ1R242K0V5bHQzNG1iSkFtVElRWUxIWW4vV3NjckFz?=
 =?utf-8?B?eTE0NG8yckxENFJWVFoyb1ZGQkx4R2ZxMkdMUms0RlV3QjVlRVMxZ2NKWFFN?=
 =?utf-8?B?WGovM0dwRFdVY09KM3FTV2puUkJIaTViTE9laHYzZU9uRVNtLzgzSXgxU1pE?=
 =?utf-8?B?NEgrSjhGcWxXRHRlNHp4Z2U1VFNKenBYNlNpSXEyL2VucnFzNlVManJZM29j?=
 =?utf-8?B?c2s4UVJ1enpJaUhzUjk5eTZCVGZuRHFWNEtrK0txY01XVE8yNzF6cE5STnM3?=
 =?utf-8?B?NDBocGtVVnlTUlJjOE1pRldnL0FTNUlyak40SGpNdm9EbWZZV0VwaVp2V29G?=
 =?utf-8?B?UmEvMnRoeTZyd1FEcFBMWEN3K05OdmFROCswcThRTmdiUkZDVUZJZUxIWURC?=
 =?utf-8?B?b1ZZUXdFN00xRmdZdzZGc095TUhFeG1rTldaTDVkN3QwVFhneTJvMmdrS0RJ?=
 =?utf-8?B?SDhGemZYSHVsbmpBRTNmVnVZL3pMbUtMMitEOTkrMkhheWpnblgrblZrU0Mw?=
 =?utf-8?B?NGpKTlJUUHhWK05NTFFXV3psd1dXWFZrMzBEMG51VTNaN2ZaSTJWdTZjUDNa?=
 =?utf-8?B?Qlpjd1lYUUUvekRMU0pnY0ZSbXdUNExaR3c2THdadkI0TVZGSW44RGVaSVN3?=
 =?utf-8?B?RDF4Zi9aL0dIWEJVTG5GdjE3SUY5SGNyVWdjSUdYdGpidXovdGVwdzZZaG9q?=
 =?utf-8?B?cjN0S1llODhBdnR2TG1TUmxWYmNhRXhMWVd2MjBvekh3UXNDTUlKcGFRMDFK?=
 =?utf-8?B?R2hrUmt1cVpYdENUNnN2Zm1zRkZ2aTEwa3MwdFFVUDhRSkx6TllIWGJoN1Vt?=
 =?utf-8?B?Yk4yU29WN2RsNS9ocDd5cU9SNzErc2REa2RhcXBmSFp3anZMbHk5OGw3WVps?=
 =?utf-8?B?cHlNTmxrV0pjQkpHeWF6NjIxY2xoNW90WXF4QmNxYUp6UjgvKzMwL0NicmZK?=
 =?utf-8?B?UnBNc0w3am1mbUt1ajhiMDBndXNhdStwYlBzK0hLT1FwSWVmRGE4cFZ2Z29E?=
 =?utf-8?B?Ly9UZjJrMUw5bFBxM1J4QVIyRGFGNWJoQnBwVng5di9DVEJ5THpmRC85RVFZ?=
 =?utf-8?B?SzJvT3VuYkdCeHUyalZERzlmMnJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0890cc0-736d-4b20-a7ab-08db3f422c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:49:24.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCrO6WNl8tdtUTwnJtAJINdTpNphNoYxi9hUCZeTSbEijpkbIIhAiGCt+rr/oofjJrdrbGJc/JxXs3w1gC8sEnV25A4qStjQGF64svGqIEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiA8bHR5a2VybmVsQGdtYWlsLmNvbT4gU2VudDogU3VuZGF5LCBBcHJp
bCAxNiwgMjAyMyAxMjoyMSBBTQ0KPiANCj4gT24gNC8xMi8yMDIzIDEwOjM5IFBNLCBNaWNoYWVs
IEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+PiArCS8qIFJlYWQgcHJvY2Vzc29yIG51bWJlciBh
bmQgbWVtb3J5IGxheW91dC4gKi8NCj4gPj4gKwlwcm9jZXNzb3JfY291bnQgPSAqKHUzMiAqKV9f
dmEoRU5fU0VWX1NOUF9QUk9DRVNTT1JfSU5GT19BRERSKTsNCj4gPj4gKwllbnRyeSA9IChzdHJ1
Y3QgbWVtb3J5X21hcF9lbnRyeSAqKShfX3ZhKEVOX1NFVl9TTlBfUFJPQ0VTU09SX0lORk9fQURE
UikNCj4gPj4gKwkJCSsgc2l6ZW9mKHN0cnVjdCBtZW1vcnlfbWFwX2VudHJ5KSk7DQo+ID4gV2h5
IGlzIHRoZSBmaXJzdCBtYXAgZW50cnkgYmVpbmcgc2tpcHBlZD8NCj4gDQo+IFRoZSBmaXJzdCBl
bnRyeSBpcyBwb3B1bGF0ZWQgd2l0aCBwcm9jZXNzb3IgY291bnQgYnkgSHlwZXItVi4NCg0KUGVy
aGFwcyBhZGQgYSBjb21tZW50IHRvIGFja25vd2xlZGdlIHRoYXQgdGhlIGJlaGF2aW9yDQppcyBh
IGJpdCB1bmV4cGVjdGVkOg0KDQpUaGUgMHRoIGVudHJ5IGluIHRoZSBtZW1vcnkgbGF5b3V0IGFy
cmF5IGNvbnRhaW5zIGp1c3QgYSAzMi1iaXQNCnByb2Nlc3NvciBjb3VudC4gIFJlYWQgdGhhdCB2
YWx1ZSBhbmQgdGhlbiBza2lwIG92ZXIgdGhlIHJlbWluZGVyDQpvZiB0aGUgMHRoIGVudHJ5LiAg
U3RhcnQgcHJvY2Vzc2luZyBtZW1vcnlfbWFwX2VudHJ5J3Mgd2l0aCBhcnJheQ0KZWxlbWVudCAx
Lg0KDQpNaWNoYWVsDQoNCg0K
