Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCCA747BBB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 05:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGEDPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 23:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGEDPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 23:15:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC05910FC;
        Tue,  4 Jul 2023 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688526900; x=1720062900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=miYgIugmWRzKDtyEcs+DQiz090oan+41Hu0TJByvbEQ=;
  b=cVVZEJckF66chdwFktcnSR9+NHvjU2pUNHN0sfgbgVCrrEFLiPJgS3ea
   g7GHb0NawYaDpTmc3gMAw8J7EV5b7Bx2Q90HnEhv+pevJmue4O90mS+ao
   e3cexsIa6e5LAhrVQkVgjw5pVp9dicOQxxNNd0A2OKCOIE+5NCzEci3D1
   Paxiw7c1Z8eHD2YuKdnQES8cFkcJ+ShoIvT33XXVUOpCberzl5TFU82gz
   b1bLLd9BdxgjOlXQD7mqyly3yJhBtXHAR5IyFkaAzXQrRmcD1Z+N8cDhj
   Cy8R5u1IbIvlv8jNom3fY58Vl3g4EgZ9vTIZBFQKNgcgRVWIJymzlFkP0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="360714746"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="360714746"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 20:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="669253240"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="669253240"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2023 20:14:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 20:14:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 20:14:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 20:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA8qA2u/XlA2iwwFTw5bZtsNDr/PpkH/iu8FUbWjwEgznBszXO9jTYGJfuflhOfsijXj9Uo9qiUBgNvWx1NEEDA2XL4L4LhPLiqxGPJxAw+u3QZT6YNBmFKcQtPJZD98A/autbkMpd3bKVq3gL/cmF/UwY+xR22MfFYNiYRWFC7K3Z2rYd7NwQyF1rzrkutmMB89BE5w5yAWcnzRnr9wQo2qVB/xgcuZ3p09Pco6ufX5VP4XhHNFLQGYjO+v4NHP8po+2/Lx6sUp0siZCjPMlPZhU58uX2IcmXd9D/nRk0ecPaS4ZCLRkbZwHFFpEfi62IoGw2m1OB0wHqGxHS4USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miYgIugmWRzKDtyEcs+DQiz090oan+41Hu0TJByvbEQ=;
 b=bVVf7P/RW1I/RLtQvkW4dC2KbuIxjNAQc3Hp9b/63MgqAHVUquE+W9G2yqf0JuI6NaEY+ONFHi5v50Z3M6v1Fy9Qyyak5/qJbpzbhZIBUBQaQdwzjDsKsCUvEr/nG8M6GYQZDMH6ec/HVA7WIvikApcugWC1DJkOl2AhqlXZrlE3ZIb6dEzrysgKqRFqSIe3llhqBjGlcb2bJgiFIDAfoU97yOGI318ArZI00EhyB0KNyGUHXMfr6tAH1WUCWc44ybhwNV7zPhXjJRcXs6vvDhsxHVNjfqEDcGauBUkGu4clOxDPDCKnz2ymdwm+Wxr3JAcXd7lc2P4pck3R2wHKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 03:14:56 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::23ed:f657:76a5:722d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::23ed:f657:76a5:722d%2]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 03:14:56 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
CC:     lkp <lkp@intel.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] cpu/SMT: Allow enabling partial SMT states via
 sysfs
Thread-Topic: [PATCH v3 6/9] cpu/SMT: Allow enabling partial SMT states via
 sysfs
Thread-Index: AQHZqpdeiHo5WT4pfUGCwZQmUGJYIa+qiIOA
Date:   Wed, 5 Jul 2023 03:14:55 +0000
Message-ID: <5801fb9a94c2ce00ca44220be0b1a5bd7f8ff44f.camel@intel.com>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
         <20230629143149.79073-7-ldufour@linux.ibm.com>
In-Reply-To: <20230629143149.79073-7-ldufour@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: 925ae951-15ec-477c-ed5d-08db7d060202
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crXOvb4y5QPm13pzxRSUDLSlNOmGpBrOTJukCb0VGm6MdiZvK/NhIILu2M9yt5yzCQHoqtBWfLGbjoPxJmot7L6T55fAdbtUOzAXKWa4NbvclcVKSDkLJ6s8WamkDjuxAUgf72XezAWPK4OmrKIL4MzQMNG5pQFUkwm80mzph5VhbpFvgS6zetHAflVC+N7omK+Wm07gdDgBrq7bhWYm7RGjFs2KxsaCqNReWuLQSTeIjxbYtsLp020gBM+TxRlOwrKVVt2JXFFpnDEYbWcHy+c4aw6M2MNHNkie9k24N0Hpv3dcrZ5Jq2S5w3AJC/pCuuFFYfRNHkghcPwmcj55vhsjmUt5fkwjmKV6AQfDxpLICH/HP1gR/HY2Z6yWrMsQSoLug11PRRGysaNPFm9NNBD096Y/V5Twru6ZymCVHzbjOBzqkRVrXG3uPnbdBIxGFNNVcXnCYB5zujhgG3tVHhqu9lm2unrbXusR7oR9xHmroN+yWsYoPWoHVx92HDYaGM2FmlyFr5OPQKF88k8yLFhuP/m0G5UHLLuuj47WSb0mbLwb77xUeKz7tpmKc5+PQOgXlFLMY9THjyuJ0487lHGbXZjuEScgfBmL0Mkymzq/SMPRHLkwduCTSudZ+FfM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(54906003)(41300700001)(4744005)(6486002)(71200400001)(82960400001)(122000001)(2616005)(186003)(6506007)(26005)(38100700002)(6512007)(86362001)(38070700005)(110136005)(478600001)(316002)(36756003)(2906002)(64756008)(91956017)(76116006)(66556008)(66476007)(66946007)(8936002)(8676002)(4326008)(66446008)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9JUnc1R3MvbU1NYnV1c1U1THRud2ZaTnIxSys5ZDNWL1F1cFpJVUNGMnMw?=
 =?utf-8?B?ZjJoNnJKOTlOQWVNQ2oyV2J0NUZHbnJna3dXZjcyTlg4SVNNQklwV2c4WFlt?=
 =?utf-8?B?OUhmYVRSMUNzOFdIdlFOWFJmdmpHM01QVHBZdm1PdmVqdkp4ZmplYXpXeUhx?=
 =?utf-8?B?dFFIOEJwc3pjRkRiL2NqTG1CWHVPc2p4UCthVmtqK0diZTladlA1eVlnQ1ls?=
 =?utf-8?B?U3hNWXYyaVVHZUZrU1p5Mnh0dUd2V0lhTmZkT1NlK2Vkbk1qODNJcVIwNVdX?=
 =?utf-8?B?UlhvWU5yRXJnRDluajBtZVFRT1UzajFXZVVkd3JtbllaWTNGUkxoWnhwWFlY?=
 =?utf-8?B?aVV3cnhBN2lTc1VnNFFMNXB5TkhTeVQxODU2V0RyZ0dmS3R2RDlkTEg5V3B2?=
 =?utf-8?B?RXNtTzZtcjM1Z2pMV0pZNlM2VGVRVllrN2twZTdxYklqWUlEdTZhWnpOeXl3?=
 =?utf-8?B?TUJYMGRrTVYrUFo5U0pJckIwR0hrQTNkekJBTEw5R2t5SFl5M29yK2RvK1px?=
 =?utf-8?B?emF6Rk9PZjFGL3JyWUMxSytUQnhZWGROOSt6ME9yNkZjdktOZGdjSHRCU0lH?=
 =?utf-8?B?SXlUR25xUVNlTFRET1d6WlR5ekkvZjQrMkpXTVRLb01pTkMveitXakYwaStp?=
 =?utf-8?B?b084cE16Y1RXRVpBNUpXWkVTMmtFUnRSRldnRDEyK29UaTVmK3hUaWlSK1Na?=
 =?utf-8?B?S05malVTMXhhWG1hOTZ1Y0RKWThOcCtHTThldFIyNE9QeGFPZWFnN051ZGk5?=
 =?utf-8?B?U2ZFU3paWTdkcE9oamtyTTgrWGpjSWk4anNuVGk3eGQwZENWdE5UcVJlTDNh?=
 =?utf-8?B?b0x6dE9MZXZQbExUOHZRUXJma2RVSitITEZvRHdDZ0pQeHZWZWhrME0rRVJl?=
 =?utf-8?B?eWMwNks3SlZSVHZkWE5STU1UcmROVVVtTmRYMFhOdDloZjlLMkdKK2gyTVdO?=
 =?utf-8?B?bXNWck1aQW5SbG5nNElXNFJnMmVhbTN3ME9OdUFiTXZWYkNzNk52QnFsQ3Ja?=
 =?utf-8?B?OTV0T2Z4Tmo1UUVkeXVYWjRYTlBrMjVnanFYMkF3cmdGaGlSZ1RUZnNzNE5u?=
 =?utf-8?B?eHFzYWgxWWRRWFRGdGwzQWNvN3Jpd0RJc2JRR1YvaDhkdE5QTFdLMUQ2THVl?=
 =?utf-8?B?SVNiL1BvSDdWWUZxSDRkWEJWZVBHK3VPUi9FZ240U0gwczI3Wk9kWC9sbWFK?=
 =?utf-8?B?ZUJlQlVXcjZPSC9FazIxS3NaRk5ubkV2Wi9YbCsrcjY0aXd1RWYwTkpBeWwy?=
 =?utf-8?B?SEJRVGJ5WitnRmJDV2ZBZkpNajhwcXBrUGhUUjFmMU8rNmxvWVV5UUdkemI5?=
 =?utf-8?B?MmVIakNOWWwxbnYwSVJLeVBxSGZhSXNoVXg5SGE1UmErV2xrQk9RMHM4OGxW?=
 =?utf-8?B?L0lPWHMwS1lqWkUybzZEcU1rT0RqQVJhbkZISGVVOFJvVjhyZjlpelRKL1JD?=
 =?utf-8?B?VklHUkM5U3Y4a3doSG5qdmZTRFVKYndjZFB2dVZWT1pBVWltdjZLUlJ5TjJU?=
 =?utf-8?B?WTdUUUMyNVdPdlNEU05EdjVva2FQTXJBak9TM29OL1VUeU56L2h1a1AvR2lu?=
 =?utf-8?B?YU4wLzFnbGtRTU5FbWxqMW1KZ1ovMklpdmp4S25iNUFERkRzSU55OEE2UG8w?=
 =?utf-8?B?UFVDZVNqYWc3SlI1bU4rMFRMdWNiTGlvUk1FdFRxYm4vTUluLzdmRlVIMFMw?=
 =?utf-8?B?bUpLMWxJVzdXZHF1WWZPYkRuMUNaZ2pZMHI3VFMzNGVmamRvTUl2SXIvNmRm?=
 =?utf-8?B?ZjhyZ0hVSWxHM2QvV3ZzcEs1Snl3RVlWcE1MNDBQd1RBUm5FcXFGRmxSaXRn?=
 =?utf-8?B?cHl1d3phRmVUUFM0bS84Z2p6NG0xcUw5VzZ0YUtxdVA3WHdqYnZCMTNPeTRm?=
 =?utf-8?B?VkdiQ2NFQXBNN0FUREhZQnhzanNNY0JsdUk5UVhwMU1UVE5GUVpwL3h0STIv?=
 =?utf-8?B?KzRPS2hmcjgvZ3VaUXVQRlE5WU4xT2ZpZGxrQ0sxMkxWNFdLeUE3Zyt2L2pi?=
 =?utf-8?B?emR4K1NsK0dxcGY1MHdmcFNzQmhtUWN0WVB6eFV4RUQ1QS9IaHNGZ3JpMEJZ?=
 =?utf-8?B?VDloVXJ2WW5BRDRyMTErcUUxOUtBcEo2akFnNW5PUFYyNmhucVhpWEExa2FD?=
 =?utf-8?B?WGNSQlI4S2tyOXdRSVFSVWhyU01VMGdSTU5VdEZtL2JTQXJYQ0piS09jMzJB?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527F659231D85F48921509353F17F45B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ae951-15ec-477c-ed5d-08db7d060202
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 03:14:55.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70Ct6Tz3xPPprZExkfOF6vVzfangTcZKWM6HhleYEpJZ5/ZXfvMnDIBDYz+mw+YX6icBi7MfRxkvASLlHWZHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDE2OjMxICswMjAwLCBMYXVyZW50IER1Zm91ciB3cm90ZToK
PiBAQCAtMjU4MCw2ICsyNTk3LDE3IEBAIHN0YXRpYyBzc2l6ZV90IGNvbnRyb2xfc2hvdyhzdHJ1
Y3QgZGV2aWNlCj4gKmRldiwKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqc3Rh
dGUgPSBzbXRfc3RhdGVzW2NwdV9zbXRfY29udHJvbF07Cj4gwqAKPiArI2lmZGVmIENPTkZJR19I
T1RQTFVHX1NNVAo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKgICogSWYgU01U
IGlzIGVuYWJsZWQgYnV0IG5vdCBhbGwgdGhyZWFkcyBhcmUgZW5hYmxlZCB0aGVuCj4gc2hvdyB0
aGUKPiArwqDCoMKgwqDCoMKgwqAgKiBudW1iZXIgb2YgdGhyZWFkcy4gSWYgYWxsIHRocmVhZHMg
YXJlIGVuYWJsZWQgc2hvdyAib24iLgo+IE90aGVyd2lzZQo+ICvCoMKgwqDCoMKgwqDCoCAqIHNo
b3cgdGhlIHN0YXRlIG5hbWUuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKGNwdV9zbXRfY29udHJvbCA9PSBDUFVfU01UX0VOQUJMRUQgJiYKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3B1X3NtdF9udW1fdGhyZWFkcyAhPSBjcHVfc210X21heF90aHJlYWRzKQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxu
IiwgY3B1X3NtdF9udW1fdGhyZWFkcyk7Cj4gKyNlbmRpZgo+ICsKCk15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCBjcHVfc210X2NvbnRyb2wgaXMgYWx3YXlzIHNldCB0bwpDUFVfU01UX05PVF9JTVBM
RU1FTlRFRCB3aGVuIENPTkZJR19IT1RQTFVHX1NNVCBpcyBub3Qgc2V0LCBzbyB0aGlzCmlmZGVm
IGlzIG5vdCBuZWNlc3NhcnksIHJpZ2h0PwoKdGhhbmtzLApydWkK
