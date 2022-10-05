Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC30C5F5CDE
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJEWpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEWpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 18:45:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA0E4DB59;
        Wed,  5 Oct 2022 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665009940; x=1696545940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pFDHye/GQzBXxu7LtKqK/zNMT5atbiMvPO5VuedTVGs=;
  b=TffbAiDk8f0US6ZXQF4eYbMAcyo7QVfXotIyyoLwOlKJmsLGGzQpqOdD
   FhYYWapN2E3Tx/RD/E9ZVKFTjQTsDnLjrjzRGv3lh+Wdg9lZ/z2q6oz28
   +UAC3TORVZSL/hCKPOCA4xYm3ukLNRr/SWqvxltOBG9fFt2gWwzgXFgFj
   nh+LNPL0tlzG4Z5IeYmF+1ZP5tmGGwtYXfXlPBRRLLvo6o8KuSxV1rSIG
   +gdq1ItNhfAkPpzIZuVfxbAznRZNKlnbbo/6SI3JaQvlJKJoW5EDrb6dg
   DPhdW3lZVViCsWwkpgR1DXC5BGr09Sjvb7z7yUSZxjiJZGgHFulSow0Vx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="303267633"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="303267633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 15:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="749938865"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="749938865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2022 15:45:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 15:45:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 15:45:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 15:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQH7/NIb2/ilhydTrO/uzbQRN46WssRrSK7xR0hOl8XMfqsQAAmiUz5QQ35rh6SFJ9eYy2GhTTW2zv0fglLl2NeUCrclI4sukVvz2T7RIj9s1/dS4gIIPbLDyK71sM3De3aWFjRwr8aelXoWsd18XPj+xy33mkJcfwCRVNGyR52hCF7AyXxG6ptLjlZuLoDSNR+7Na0HIQIAHPX9hPEj/+yBUw7lmN5mYcMlyUZSGr/meJxqy+bUemNIlYsraMX9kfxjsjWl4lTriBLsVmphxtp3S/y/4x1Y5rlBHPypontebkCcpkculASgnNjRNU/3V84GRGEOpot6qNUG2z0lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFDHye/GQzBXxu7LtKqK/zNMT5atbiMvPO5VuedTVGs=;
 b=DC/pp/HmN7wVFL4VOEfJzMbSMgqNQtKAey4Ep5xqn3mAJmXvJxcbMstC9Kr8v3rWlrVOZGv65g1xi51eKX65Ji60k2C02qnP/qdo7wefULfXsxfkJ/cpkzIqif7buAbQo9ip/77QhD+Oin47B4e7FhnNqsMfCGcLF8RKUeqNwF4eEG9Opnh1Ah48r5eWpYNMmQfBG9HzJ3iSpS953fu3QtcfhptzO87J5sJsPnmL3JAZHHk9MnVQenIAsX5/H1dVU6cwaCiRyeOB+GmHh0Y1MUrlRr1g1BmxwHKBNjnI7keIcw7XNMHlpdxpaBDasQxMNgB9jLmorBZdizm2XEV8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 22:45:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Wed, 5 Oct 2022
 22:45:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY1FMIU7BZJQMEy0SHUZZeq6SSP63/lCEAgADbjwA=
Date:   Wed, 5 Oct 2022 22:45:31 +0000
Message-ID: <3173cc221978018cec2926691c74d34e8b80512b.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-8-rick.p.edgecombe@intel.com>
         <Yz1Q3EGtvZBKNR31@hirez.programming.kicks-ass.net>
In-Reply-To: <Yz1Q3EGtvZBKNR31@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: 07cee9c7-df4b-4f69-a24f-08daa7234eb1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7hfuaueUSiJU0gtNKxLdM3+qv4zwpnaOON3dlPc6k7qmT1LfUHf7emKWeK57P+lQBdDPkgvfQde1vTjG5ffT0yAFsfcCO5mpflz3vKry5FFDIRL7rzcuwEAy1+G0P4rxvZgOO9lezpVd+f8M4/+aj71qw55dHX1mEpdj5RdTdwm2eSytH8+wQjzQQySf2Gg7CV/Wlnbaoiqs1wwwyTf02DFFfdoSePX4QFTjc3l2WMP9EblEnrjbnV9AW7cnQXcO8cOIuAr1RKu0HLq60enzlWCNctYS8W64ndo7hbmhjm/FktAeuJLX97ISE9dnpr2AaaN9hggZ0r5WPK7KQTXtnV3us/+v8bl6+yHxQwbo8lUDb8XgbXV1zQvsaLVYBT7i8grYmQ4QlWcfC+tSW/SNSSeQqyzyChxHLUFmY/oLqjekyLVuBbITguIeIW2yEqA1Ram383aaGh+N9C54DsBWfmJxpeRWVszBhYqHULQ3uSkemCMDFtBo05PjKGr/TkNobfZeh1WTlLHRpYH0hpS3k/7xrZmyFpOaCSmOQxbO4twS3KAwJz/ho+Nd2hlhm8PE/ITLm+A+L3XrL8B1RaMNQWkgRxsMGqH1w8U8NELCbZrtR1Zh+zbTTYFfck2ZXFf6S8cjmthhSej0IHqY20n9nk69AcPQwKQ6hBTzTThjYxQbz+FAOT71t2Z8dJpu0wYZZgkfstFEiPsspBCcoExBDGPd0y+o5kKCkTz/bnfpZ/I9tJ9OuW5rPsJRs6psrXe2JJQqiv6p0G2EN92iCfDu7wD0/T0uNqySiM78rZX+wI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(66946007)(66476007)(38070700005)(82960400001)(64756008)(76116006)(66556008)(66446008)(91956017)(8936002)(41300700001)(122000001)(38100700002)(316002)(86362001)(83380400001)(4326008)(186003)(2616005)(478600001)(6486002)(26005)(6506007)(6512007)(71200400001)(8676002)(5660300002)(6916009)(36756003)(2906002)(54906003)(7416002)(7406005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWIwa2xDeVNVK0NlalBZN2E4V0RObUcxRy9DQkt0cmtlTkNmOFJmTnBrNlZT?=
 =?utf-8?B?TithR3BSY3JmZTFBb2lRTGFMQmwwNkxLZnhHb0xQeCtXamhtY3ZzZWdJNlp0?=
 =?utf-8?B?WkFtUHJUVS91RlJ4TXhNa0VsemlnVWFLc2grMEhNUisxYm1lVHIzell1azFn?=
 =?utf-8?B?aTFXVmJUbTVlSXNUN2JjZjZVc3dCRzRuSkF2S0o0TGExUkNSR3hYbWhlUlcy?=
 =?utf-8?B?MDA0SVBWbStBdkZtVFA0cVNsMlJBZjdSay9pbk42NWh4VUpNV3kwNVRna1R6?=
 =?utf-8?B?cU8rUXZMSndpaWpQcncwc3BXdDBVaGpMZG5yT29yaFR0TGZ6N3lKWjd0TTBF?=
 =?utf-8?B?eHVXR2I3cC9jRVNjcUQxTFY4dTErbFFRNXRxYnlOaDVZTjYyWGlYMWlsQnVp?=
 =?utf-8?B?TmVsWXJ3L0lLbGNhL2RSR1hMaEZmUzNlU2lrczlscHhIdkZpeFZWdDREYWRy?=
 =?utf-8?B?TkczcTIybEVmUDBFcG5IUkc0T2VoMHhqcXZra2s4MjlMM2hkNWNRUysybU5a?=
 =?utf-8?B?WkJSZXZKTENRbmR1L0hGNktIYVk5azFKamtwbG9FUUMyWDZWS0NSMHNISE9Z?=
 =?utf-8?B?WUxhOTUySC9zeldZakF1MlVTaWVpRmFmQzRIK3VaSmc3cVlSNkE2V0xkcnNm?=
 =?utf-8?B?c09NQVZadGJYNjFDQlFtMU95bFhWS3o4OUQrOUFHRk91aUlubU5hT3ljSHRT?=
 =?utf-8?B?UXg3MFVQeWRoRXVRNmJyUTBDcm04Ly8xaWlkNWdUZldqTFAzdHdLUytlWVBO?=
 =?utf-8?B?c1U3SVdoeHYwM0ZOc053akVKWXo5amxqNVRhTzFtTHhpUE9ocE5rMGxNLzhi?=
 =?utf-8?B?ZnFUNlMrQWxSR3psejJjNzZxNkVITnZ0dUFobDZYVDZjUWlrZERYSTV5K3Nz?=
 =?utf-8?B?V1poNEo0bXVDU1VzMlRKZFd2dGFhUitrRE9WK21EWmhsOGN3RldIRUdFZklS?=
 =?utf-8?B?Z0lFUHR0QSsxVkVUam0wMWJvOSt4djNhNE9RY1JyRzYwS2ErZmxaSk5iRlk4?=
 =?utf-8?B?aWp0WmphQ2Q0VjlyQUMzWmpTWmhDY3ROUzdHYm5qcEg0d1FqK3c3ZDFvTnNH?=
 =?utf-8?B?Sjh1M1BCMnFDZjY5Nmkyd25tTHo3VDV1SmRTY3ZQdjhYMjVjbXBIaUpnZGpC?=
 =?utf-8?B?SUxLYjc0K2ptNDYvN3lKNzdqTGNzK3ZTYUZMOFdST0JjaVA4WnZSWUFGVWhN?=
 =?utf-8?B?NWQxUm8yQnVRaHpCUWF0SHF4Skdsc0RPaDlrTTZ4NEhIVUxKWm1wYnBYUDlq?=
 =?utf-8?B?VmUwWDFoT3lVNUYzR1luU3hicnNLNFVWU2NadENxR1RuNHo4QXZaeWMzZzk2?=
 =?utf-8?B?S2gwSFdpQzdLdXlIWWVab0EwM3RXbWlBRm1SRmQ4RUhlb0R4QjVMUWZNbDY0?=
 =?utf-8?B?NTFoaUNIT0RXWDduOVo2S3N2emZuaUY0QzF2WS9PTkFDVGpNT1MvL1UyaEVy?=
 =?utf-8?B?M2tZejJSVDdEczJWdTIza0RjekVEbjdEYnZIR091cmJvYS9pMFl0cStOTWN1?=
 =?utf-8?B?Q2FTSk9zakVXcEdnZDNDamJGOFBZL29oeVhOK2FFejZVSzJHS2dvV1I2cWVG?=
 =?utf-8?B?SFlDYWhpcmp1cnU1UUw0UFViaFpaNjlxajNuUk14dCtkckF5TFlSRmxmd0hr?=
 =?utf-8?B?eWNxbHpZMzhrV3NvYlhKaXhacFRCRXdTTjdTQW9ZVnpTdXBDV1JHQXpFejlQ?=
 =?utf-8?B?eUQxYWFOSzVIZjk4MFZnNFlQOFVqRGh1UHF4cnlOdEczK25EaEZVcmwxZW1U?=
 =?utf-8?B?QTFpbUNDN1BHRGFGY2ZCc2ZGSmdCUVVsVHhmeDZ4dm1uNzIzMmJDbTgvUXBT?=
 =?utf-8?B?U2pZZ2NKS3NGMDIwS1BvOWRydHgxRzA2UEFNMDR4Mlh3YzJsTXo2S2swUEtw?=
 =?utf-8?B?Z1F1ZHBMOGxPQm5Oaml0c2VPTjN6OGJYK0ZtNWdxaEo5Q1BuL1RNSVZiMUt6?=
 =?utf-8?B?RGg2dTZiYURuTTZtNTlzSi94dWVGUjVZMjJZcGRlWWM3T0pUZnZwakxodEhv?=
 =?utf-8?B?SW1SSitHL2poZXpIUmY0ZXhZbXU5MHFKQUx2TFdhZWF6UVBudUl4eUV6Y3ZQ?=
 =?utf-8?B?b0FHT0tjejhUL043VTVwRm9wdDZVK2t4UUo1NUJhSzVkOE1nRExrTjVjS01J?=
 =?utf-8?B?c2ppTnJwQm80d0tLa1pWVDhKa3FQRDBua2pSNVhXU0RyQTNNM0Y1OGxzS01I?=
 =?utf-8?Q?Q1I6VKmXBmthcoZVMJS3Nrg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F1FCCFA93F833438EDDF5AEEEDF6950@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cee9c7-df4b-4f69-a24f-08daa7234eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 22:45:31.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wqh7LLzp7Tpccattd1YrNhbMJnrHYAur/43aqULYBe+8Qms8KKLSBFJSbnkCvIPD8ume9xDZWrqLWMQ3kPagRsVeToiG5FCci6CJIPU4OZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDExOjM5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MDRQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYyBi
L2FyY2gveDg2L2tlcm5lbC90cmFwcy5jDQo+ID4gaW5kZXggZDYyYjJjYjg1Y2VhLi5iN2RkZTg3
MzAyMzYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL3RyYXBzLmMNCj4gPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0KPiA+IEBAIC0yMjksMTYgKzIyMyw3NCBAQCBlbnVt
IGNwX2Vycm9yX2NvZGUgew0KPiA+ICAJQ1BfRU5DTAkgICAgID0gMSA8PCAxNSwNCj4gPiAgfTsN
Cj4gPiAgDQo+ID4gLURFRklORV9JRFRFTlRSWV9FUlJPUkNPREUoZXhjX2NvbnRyb2xfcHJvdGVj
dGlvbikNCj4gPiArI2lmZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ID4gK3N0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgY29udHJvbF9wcm90ZWN0aW9uX2VycltdID0gew0KPiA+ICsJInVu
a25vd24iLA0KPiA+ICsJIm5lYXItcmV0IiwNCj4gPiArCSJmYXItcmV0L2lyZXQiLA0KPiA+ICsJ
ImVuZGJyYW5jaCIsDQo+ID4gKwkicnN0b3Jzc3AiLA0KPiA+ICsJInNldHNzYnN5IiwNCj4gPiAr
fTsNCj4gPiArDQo+ID4gK3N0YXRpYyBERUZJTkVfUkFURUxJTUlUX1NUQVRFKGNwZl9yYXRlLA0K
PiA+IERFRkFVTFRfUkFURUxJTUlUX0lOVEVSVkFMLA0KPiA+ICsJCQkgICAgICBERUZBVUxUX1JB
VEVMSU1JVF9CVVJTVCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBkb191c2VyX2NvbnRyb2xf
cHJvdGVjdGlvbl9mYXVsdChzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4gPiArCQkJCQkgICAgIHVu
c2lnbmVkIGxvbmcgZXJyb3JfY29kZSkNCj4gPiAgew0KPiA+IC0JaWYgKCFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpIHsNCj4gPiAtCQlwcl9lcnIoIlVuZXhwZWN0ZWQgI0NQ
XG4iKTsNCj4gPiAtCQlCVUcoKTsNCj4gPiArCXN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrOw0KPiA+
ICsJdW5zaWduZWQgbG9uZyBzc3A7DQo+ID4gKw0KPiA+ICsJLyogUmVhZCBTU1AgYmVmb3JlIGVu
YWJsaW5nIGludGVycnVwdHMuICovDQo+ID4gKwlyZG1zcmwoTVNSX0lBMzJfUEwzX1NTUCwgc3Nw
KTsNCj4gPiArDQo+ID4gKwljb25kX2xvY2FsX2lycV9lbmFibGUocmVncyk7DQo+ID4gKw0KPiA+
ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSkNCj4gPiArCQlX
QVJOX09OQ0UoMSwgIlVzZXItbW9kZSBjb250cm9sIHByb3RlY3Rpb24gZmF1bHQgd2l0aA0KPiA+
IHNoYWRvdyBzdXBwb3J0IGRpc2FibGVkXG4iKTsNCj4gPiArDQo+ID4gKwl0c2sgPSBjdXJyZW50
Ow0KPiA+ICsJdHNrLT50aHJlYWQuZXJyb3JfY29kZSA9IGVycm9yX2NvZGU7DQo+ID4gKwl0c2st
PnRocmVhZC50cmFwX25yID0gWDg2X1RSQVBfQ1A7DQo+ID4gKw0KPiA+ICsJLyogUmF0ZWxpbWl0
IHRvIHByZXZlbnQgbG9nIHNwYW1taW5nLiAqLw0KPiA+ICsJaWYgKHNob3dfdW5oYW5kbGVkX3Np
Z25hbHMgJiYgdW5oYW5kbGVkX3NpZ25hbCh0c2ssIFNJR1NFR1YpICYmDQo+ID4gKwkgICAgX19y
YXRlbGltaXQoJmNwZl9yYXRlKSkgew0KPiA+ICsJCXVuc2lnbmVkIGludCBjcGVjOw0KPiA+ICsN
Cj4gPiArCQljcGVjID0gZXJyb3JfY29kZSAmIENQX0VDOw0KPiA+ICsJCWlmIChjcGVjID49IEFS
UkFZX1NJWkUoY29udHJvbF9wcm90ZWN0aW9uX2VycikpDQo+ID4gKwkJCWNwZWMgPSAwOw0KPiA+
ICsNCj4gPiArCQlwcl9lbWVyZygiJXNbJWRdIGNvbnRyb2wgcHJvdGVjdGlvbiBpcDolbHggc3A6
JWx4DQo+ID4gc3NwOiVseCBlcnJvcjolbHgoJXMpJXMiLA0KPiA+ICsJCQkgdHNrLT5jb21tLCB0
YXNrX3BpZF9ucih0c2spLA0KPiA+ICsJCQkgcmVncy0+aXAsIHJlZ3MtPnNwLCBzc3AsIGVycm9y
X2NvZGUsDQo+ID4gKwkJCSBjb250cm9sX3Byb3RlY3Rpb25fZXJyW2NwZWNdLA0KPiA+ICsJCQkg
ZXJyb3JfY29kZSAmIENQX0VOQ0wgPyAiIGluIGVuY2xhdmUiIDogIiIpOw0KPiA+ICsJCXByaW50
X3ZtYV9hZGRyKEtFUk5fQ09OVCAiIGluICIsIHJlZ3MtPmlwKTsNCj4gPiArCQlwcl9jb250KCJc
biIpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWlmIChXQVJOX09OX09OQ0UodXNlcl9tb2RlKHJl
Z3MpIHx8IChlcnJvcl9jb2RlICYgQ1BfRUMpICE9DQo+ID4gQ1BfRU5EQlIpKQ0KPiA+IC0JCXJl
dHVybjsNCj4gDQo+IFdoeSBhcmUgeW91IHJlbW92aW5nIHRoZSAoZXJyb3JfY29kZSAmIENQX0VD
KSAhPSBDUF9FTkRCUiBjaGVjayBmcm9tDQo+IHRoZQ0KPiBrZXJuZWwgaGFuZGxlcj8NCg0KQXJn
aC4gSXQgd2FzIGFjY2lkZW50YWxseSByZW1vdmVkIHdpdGggdGhlIHVzZXJfbW9kZSgpIGNoZWNr
LiBJJ2xsIGZpeA0KaXQuDQoNCj4gDQo+ID4gKwlmb3JjZV9zaWdfZmF1bHQoU0lHU0VHViwgU0VH
Vl9DUEVSUiwgKHZvaWQgX191c2VyICopMCk7DQo+ID4gKwljb25kX2xvY2FsX2lycV9kaXNhYmxl
KHJlZ3MpOw0KPiA+ICt9DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRpYyB2b2lkIGRvX3VzZXJfY29u
dHJvbF9wcm90ZWN0aW9uX2ZhdWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KPiA+ICsJCQkJCSAg
ICAgdW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlKQ0KPiA+ICt7DQo+ID4gKwlXQVJOX09OQ0UoMSwg
IlVzZXItbW9kZSBjb250cm9sIHByb3RlY3Rpb24gZmF1bHQgd2l0aCBzaGFkb3cNCj4gPiBzdXBw
b3J0IGRpc2FibGVkXG4iKTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gKyNpZmRl
ZiBDT05GSUdfWDg2X0tFUk5FTF9JQlQNCj4gPiArDQo+ID4gK3N0YXRpYyBfX3JvX2FmdGVyX2lu
aXQgYm9vbCBpYnRfZmF0YWwgPSB0cnVlOw0KPiA+ICsNCj4gPiArZXh0ZXJuIHZvaWQgaWJ0X3Nl
bGZ0ZXN0X2lwKHZvaWQpOyAvKiBjb2RlIGxhYmVsIGRlZmluZWQgaW4gYXNtDQo+ID4gYmVsb3cg
Ki8NCj4gPiAgDQo+ID4gK3N0YXRpYyB2b2lkIGRvX2tlcm5lbF9jb250cm9sX3Byb3RlY3Rpb25f
ZmF1bHQoc3RydWN0IHB0X3JlZ3MNCj4gPiAqcmVncykNCj4gPiArew0KPiA+ICAJaWYgKHVubGlr
ZWx5KHJlZ3MtPmlwID09ICh1bnNpZ25lZCBsb25nKSZpYnRfc2VsZnRlc3RfaXApKSB7DQo+ID4g
IAkJcmVncy0+YXggPSAwOw0KPiA+ICAJCXJldHVybjsNCj4gPiBAQCAtMjgzLDkgKzMzNSwyOSBA
QCBzdGF0aWMgaW50IF9faW5pdCBpYnRfc2V0dXAoY2hhciAqc3RyKQ0KPiA+ICB9DQo+ID4gIA0K
PiA+ICBfX3NldHVwKCJpYnQ9IiwgaWJ0X3NldHVwKTsNCj4gPiAtDQo+ID4gKyNlbHNlDQo+ID4g
K3N0YXRpYyB2b2lkIGRvX2tlcm5lbF9jb250cm9sX3Byb3RlY3Rpb25fZmF1bHQoc3RydWN0IHB0
X3JlZ3MNCj4gPiAqcmVncykNCj4gPiArew0KPiA+ICsJV0FSTl9PTkNFKDEsICJLZXJuZWwtbW9k
ZSBjb250cm9sIHByb3RlY3Rpb24gZmF1bHQgd2l0aCBJQlQNCj4gPiBkaXNhYmxlZFxuIik7DQo+
ID4gK30NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19YODZfS0VSTkVMX0lCVCAqLw0KPiA+ICANCj4g
PiArI2lmIGRlZmluZWQoQ09ORklHX1g4Nl9LRVJORUxfSUJUKSB8fA0KPiA+IGRlZmluZWQoQ09O
RklHX1g4Nl9TSEFET1dfU1RBQ0spDQo+ID4gK0RFRklORV9JRFRFTlRSWV9FUlJPUkNPREUoZXhj
X2NvbnRyb2xfcHJvdGVjdGlvbikNCj4gPiArew0KPiA+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFi
bGVkKFg4Nl9GRUFUVVJFX0lCVCkgJiYNCj4gPiArCSAgICAhY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9TSFNUSykpIHsNCj4gPiArCQlwcl9lcnIoIlVuZXhwZWN0ZWQgI0NQXG4iKTsN
Cj4gPiArCQlCVUcoKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAodXNlcl9tb2RlKHJlZ3Mp
KQ0KPiA+ICsJCWRvX3VzZXJfY29udHJvbF9wcm90ZWN0aW9uX2ZhdWx0KHJlZ3MsIGVycm9yX2Nv
ZGUpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWRvX2tlcm5lbF9jb250cm9sX3Byb3RlY3Rpb25fZmF1
bHQocmVncyk7DQo+IA0KPiBUaGVzZSBmdW5jdGlvbiBuYW1lcyBhcmUgd2VpcmRseSBsb25nLCBz
dXJlbHkgdGhleSBjYW4gZG8gd2l0aG91dCB0aGUNCj4gX2ZhdWx0IHBhcnQgYXQgdGhlIHZlcnkg
bGVhc3QuIEFuZCBhcyBzdGF0ZWQgYWJvdmUsIEkgd291bGQgcmVhbGx5DQo+IGxpa2UNCj4gdGhl
IGtlcm5lbCB0aGluZyB0byByZXRhaW4gdGhlIGVycm9yX2NvZGUgYXJndW1lbnQuDQo+IA0KDQpJ
IGNhbiBzaG9ydGVuIHRoZW0uIFRoYW5rcy4NCg0KPiA+ICt9DQo+ID4gKyNlbmRpZiAvKiBkZWZp
bmVkKENPTkZJR19YODZfS0VSTkVMX0lCVCkgfHwNCj4gPiBkZWZpbmVkKENPTkZJR19YODZfU0hB
RE9XX1NUQUNLKSAqLw0KPiANCj4gDQo=
