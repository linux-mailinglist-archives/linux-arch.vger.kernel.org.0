Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438D4B31C2
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 01:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbiBLAMR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 19:12:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiBLAMQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 19:12:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D50D75;
        Fri, 11 Feb 2022 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644624734; x=1676160734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WcEb43MrzbHLGQD/1Arb+K1jWssGCPpIkoujEym7vDw=;
  b=YlJBk80gGbPvDgzDOxI8spHVrC9dZuWq1LouIuaMRhugWU1fG/+iamq9
   IbQERJJvqjgkox7iTbHF9C0CmBPSIq0hAvUh/yqrI58EgUh9WAS9DY6Oq
   fpd8KPnMvH9sZNXFqbspLdFgeNf0ZP322ubiN1asNvfCYU7vxCCIOoR0j
   koJlfT8ftHdVmP+FiHsiDSYMvByTlxynIRpGMzEFQDotSZ8tI7utL1RcN
   XUjmbUC+eMDNkrk/ymIAm3oDsSKF0PbMcPM3i6evIf+K5mmkXhMfEMpBM
   O7c9ZeRt7xXFnho5vQXvg9NI4oWoCOUKwqEfoI5fMHy2EG0ZGizFDdy/S
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249780730"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249780730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="537792566"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2022 16:12:12 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:12:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:12:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 16:12:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 16:12:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBUN/PWiD2gdEyjz0eWgQ4qRXcnL6DNUGssfOLNu+KPXZjq2d4CnwdK2NMs/cQM+9yzX01dSGQUdXt57m2wsOiLA+RcMG7KP6fkQN5yVO+5hbI9TtQRXnGimWMqIeLPa09PcaSBL4OzF5gk3LM60MRSyfeQwityIcTZQf4h1BsnpvICT8LBfHB42fgDHYFtwSH8u3j1i+cUy2NeYwA5Hx3Y7RK9F2m5TlLQveM+b+9LsTau7iqHa1Dqpq7vnTrRFgtB7MaPRUEPwQGXIUHU4TF0g33jQl5ql16K+kl/UxMzJb5feXI+HMclhwrQgP4PxQ1Z1NfgVT2bzBKzFlUlmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcEb43MrzbHLGQD/1Arb+K1jWssGCPpIkoujEym7vDw=;
 b=EkFSLDc88+K4FQK6f8E68TRsX9akgxk/v8VS0Y5hxzHAu1C1coQyZmVuOX0+tAEyewWoSgqM0G7XPF6+OG4yyGIGGkSusq+1RpTcNwrI57xXSGlAx4OJSGCCagQjuB7rfcFSFQgnugy7u1WnMsaqlgUpdPjzen/uKM4e+1ggwUmz+0nfBLS3z2ERHYiJf7cWBLCqWsjYUwmjp4hbakuAS8bWhk48gQKdcYvGKlTpGGZOpRw9UwNm82TqNZIV5GbMwSjEjQ2dp4S6o9O48Zo8nKXniig5r3/9py4NEiCW/9nh4yykRoIQlTvQmhRYTTGLchZnVemQOYwFFWwIySoXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1309.namprd11.prod.outlook.com (2603:10b6:300:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Sat, 12 Feb
 2022 00:12:09 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Sat, 12 Feb 2022
 00:12:09 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 25/35] x86/cet/shstk: Add user-mode shadow stack support
Thread-Topic: [PATCH 25/35] x86/cet/shstk: Add user-mode shadow stack support
Thread-Index: AQHYFh923xvcoEXwQEO9zyHFBsM2fqyPFEyAgAAJzQA=
Date:   Sat, 12 Feb 2022 00:12:09 +0000
Message-ID: <5a2778096ca847273964fe174b0fbfd818a966cb.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-26-rick.p.edgecombe@intel.com>
         <e2586482-dfba-2752-0247-7b8dfe95d7fe@intel.com>
In-Reply-To: <e2586482-dfba-2752-0247-7b8dfe95d7fe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86633f93-3c2d-4056-45a2-08d9edbc4f9a
x-ms-traffictypediagnostic: MWHPR11MB1309:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB13099EC327ACA4DBAC12D4B6C9319@MWHPR11MB1309.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKgS9Z7/4jP4+L6HYJEWZxAnMKK7oPHAYcFGysgT2KLDtdoVTJS2pYXCHeoNa+D/BadcINy51rpcMrhpqSgcQ2IphqI7GjvKFGRrsTkORU0RWtN0eabV1Iszxu6TPV4ZeFBQmCph3RtLqcNDkwYqmzCx3WBbeVxZxbYOLzH7frxoD4Sm4+d0/AGCMCfBkSN17Mxyih8fzlKV0Fa0LkGwDsWjd5Z+3nlLuTjW7GPd5Jp7YLrlxodQU/K0il/0vKwxRjK75HvN8u7YyB9DbwaWdk7i/Jst1t8by6AYd+MTGPqUvYv18Ow6U+/PI+s7Yvj+MCwM0WL0zd4cB9hbi7G7LmXlC1rfvsKgQ+GtVj7tuNY2WguLB30kg50u8wPhJWVOVZSSa/DX1nEuV0RgOZl52MhQFWjQNI0NlSBZ3jrF8TDlmWu2Om6A6Kp8kqzZZUnOYcaR6gUJWddtmGgWFVy0R3B+P8e6LGktRql/JnwD1XaOAHxi+NutELN1p/JK7J1ELbgQXzba6w/+Ic8PNLv4f16xfF4ZKgApzgpZURv9isRTuvKEpLm2P8eS1AXkxDz1EVEwYOGlTykP+98EAxs0WscyPn/Z5HgugvGyQqoyIhhsdenBG6Ek1pKZjUN17soGewYautNyZBBwDRLiEOMzKkpru5xTTyXaflkjSuVArhRa7aDRq2/lmsudoAMe56TRNwiWd4wQdVGrsOulbbDkBacWAnMWLCpjkMDFKLvlVnsB8p6cU3RTYweoU2ib/oop
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(2906002)(26005)(186003)(71200400001)(122000001)(53546011)(921005)(2616005)(8676002)(8936002)(82960400001)(66946007)(6512007)(6506007)(508600001)(316002)(86362001)(6486002)(110136005)(4744005)(38100700002)(4326008)(38070700005)(7406005)(66556008)(64756008)(76116006)(7416002)(66476007)(5660300002)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkUwY0VUY1ZCNXRtbzIwQ2JMZ3A4cTQrbjlPb0h2Rk1TcnNuR0RVdzBkTHQ3?=
 =?utf-8?B?dm14NTV4Y2hway9NeThTOVpIbXBEdGZIRG4vSHVtREg1MHN4VDJ6RkVaK2pY?=
 =?utf-8?B?eHhxQi9aTS9RaE82N1JtU1BHV0pKQ0tGdHdYVXp1aE9CU1BNMU5ubTE4T3Q2?=
 =?utf-8?B?ZnlkeWZuSHhKdEJRUlFyWWhWVW9SK1dHUHZNdWpUVkt2LzE2ZHg2VGxZM29S?=
 =?utf-8?B?V2FHWlAwWmJxQlI2V1l4UWRtY0ptcXVSeEYvanVMY21ndXczWkF1QVNsdEJU?=
 =?utf-8?B?UFlBV09YZzk3VW5xU3VuMWU0MmNHV21jRXB1V0poQk90cktYZ1BVYmZNcmpX?=
 =?utf-8?B?N3FXTFFOc1ZJZG5jMHV2Z3MzeC81K1dFamNSMjNMQUJJTkN2d3dIR3hxVTNU?=
 =?utf-8?B?V2h6SXpXK2hiOUkzSDNOemJDMkFuZDJWWHVXWjkweERzcGNtTyt3YUdHRU9I?=
 =?utf-8?B?VWlQZytWeGxFNEc4MXJWWmRaTVduVVVZYUdwVml2emIvcFRzUm1CdTdmanZN?=
 =?utf-8?B?cTZmTG5hYlBVRHNtVXRqcGM0YmpReU1uUU1FQjlNTjllc2ZIOTdGU3hqNHZ1?=
 =?utf-8?B?YThBWW9KSmg0cVoxOEFyRDZIU0tHQm1mVjM2dEY5cTkyZFNqVkhRSjZNTUlU?=
 =?utf-8?B?WVRuVXdJZmpHTmhvYWFGMDJzeE5vTUFZNmFjc241Vk01MXVubEhyYjYwQVZt?=
 =?utf-8?B?cmdkczExV3E0T0V1N2hBUFBBL09PV2dWYUFHWkFQU21FaFM2eGUrTVlTU2JS?=
 =?utf-8?B?TDNhT254a3QveG1oMFBDTXhCUW1jOXUrLzJ2c0VvaGpxL1hqZzFRZXdIdVdn?=
 =?utf-8?B?SmJ1VDhJOVMzekhDOWJCOStGZHBYTmdYZFdWSWZYOGRXMGZpbFJ5bC9ROTVu?=
 =?utf-8?B?Z0dXd2kwSy96U2xvREFGQmc3ZHMrMGd0TDA1bVNOVXFIV0FDaURJV3RDZUJn?=
 =?utf-8?B?bzRhQWlKVzdua2dDdmdYUXFvYjVXRVRoa1Fha1NXZXUzQ0NKYmg2Y0MrNVAw?=
 =?utf-8?B?aUdCaklzWk53QWpxQWV0eTkzZW4zOTFSMFR3WU4xdEdaamxzTUZ0d3Z0OVR2?=
 =?utf-8?B?TVptTWdQMWp5dlhmTURXODJ2SUIzQzhHZjJRd3QrWXpWUGRXckFHVTRBbWVT?=
 =?utf-8?B?dHc4QUkybGErdzZDV04xem0vNm50aGdOSzcvTGRpeUpuMEd4aXJSaDhjcDJC?=
 =?utf-8?B?L3NBYnRRSFNzSFpoQ0hQcU05M2QvQUhtcVFyclJHTUlSQVZaMWhudTlyejY2?=
 =?utf-8?B?VVhCMkVtMlVIVmZjTW42L29xZUNJOERNWjNsVjI4MjJzVENaQlhUdHp4L2Rr?=
 =?utf-8?B?b1VNYnQrVS8rYmFRNExHMmdsbWc3UVR5TXFubWc0Y09RQUIzTHRjQm5vdktP?=
 =?utf-8?B?WDc1a2lubkwxOUIwS0cvc2p1L2R2N1dzV0tNLzV4UWtPdE1qUnNGOG0zaG5x?=
 =?utf-8?B?SXJ6dW9ZNFpaSTkzSWxRNVRKQStJUVZpL2orWGZiTjBGOVBQKzR1V3hIZVhw?=
 =?utf-8?B?Rjh3Tkd1MVZvc3RvVURQK0FmK0QyM1ZDbm1xTGh1U2FxM0htV1Nzcm1aZ2lQ?=
 =?utf-8?B?YVppT1dFODJ3SlVMN08zT2FoZHYrbmpRTFQxaXVqcXdqTFN0RE1IeDhrUGda?=
 =?utf-8?B?eTk4TUFEZFJwcDVCc3hXWjdKT3hJbytQTG52NGRwbmJEWTlWWVpncWpVMmdp?=
 =?utf-8?B?cTUvQXhwR1RjekVUTVdOYW44QWJPOTl4MGQ4aXVVV0lkZ09vbkVUNG9abUJ4?=
 =?utf-8?B?enF2YWw1YXROcGVnQllzSENVWkkwejN5OXl0RSsvUEdDN1d1djJFUjdLM3Ix?=
 =?utf-8?B?bGxsQnk3SS9DQnI1Nmk1UytpM2N4alJmcS9FcmkrMFNIUkNzT2tBVHh0a2tz?=
 =?utf-8?B?cHlGbFhEdW42b0toMkRUK3hmQzk1dHllNHZxeXMwaEhydGQ0ZUV6YmJ1UXB2?=
 =?utf-8?B?aUdlV2VVcVJ6NWxvb0JyaWxGcUd2MkptQWd2NGJmbVQxYTdaSHBIbVZtbzJz?=
 =?utf-8?B?TldwbTFTdzBQTkFCbmJOZDRIQ09NRC8vU0hydEpSVERadWNWNVMzM3VPRllt?=
 =?utf-8?B?cXllTElkanV3V2k1T3l5VmlEYXE3UTF2SzlNNTkvTURwUnB3d3pSMVhqUkk3?=
 =?utf-8?B?bG9WSGtTeDJoK0tpWHZWK3NCa2pTODJVVlgzZnVLc3RPYVBjOG05dG0zRklI?=
 =?utf-8?B?b3VWVXhNMlFlclJ6c3pVQTFpWCswTDA1eENSU1pKZ1N5R2dnK1p0dFpYVVJJ?=
 =?utf-8?Q?xFN1OpnCSPYDM98q3U5aAc+haNLZyL1U8zdExApFdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BEEC1F9E224194C8DD3A1871535F35D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86633f93-3c2d-4056-45a2-08d9edbc4f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 00:12:09.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGSb+RZLJyfptBv8prmSXM0ZkW4GYD+3SOuZMS+XBKYJUsq6wTs4Kto5N+HFT7PyuOdIJBb5tHWLCR3K05LYO2SyHJD4zanVuEaMVpfZ5mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTExIGF0IDE1OjM3IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gQWRkIHRoZSB1c2Vy
IHNoYWRvdyBzdGFjayBNU1JzIHRvIHRoZSB4c2F2ZSBoZWxwZXJzLCBzbyB0aGV5IGNhbiBiZQ0K
PiA+IHVzZWQNCj4gPiB0byBpbXBsZW1lbnQgdGhlIGZ1bmN0aW9uYWxpdHkuDQo+IA0KPiBEbyB0
aGVzZSBNU1JzIGV2ZXIgYWZmZWN0IGtlcm5lbC1tb2RlIG9wZXJhdGlvbj8NCj4gDQo+IElmIHNv
LCB3ZSBtaWdodCBuZWVkIHRvIHN3aXRjaCB0aGVtIG1vcmUgYWdncmVzc2l2ZWx5IGF0IGNvbnRl
eHQtDQo+IHN3aXRjaA0KPiB0aW1lIGxpa2UgUEtSVS4NCj4gDQo+IElmIG5vdCwgdGhleSBjYW4g
Y29udGludWUgdG8gYmUgY29udGV4dC1zd2l0Y2hlZCB3aXRoIHRoZSBQQVNJRCBzdGF0ZQ0KPiB3
aGljaCBkb2VzIG5vdCBhZmZlY3Qga2VybmVsLW1vZGUgb3BlcmF0aW9uLg0KPiANCj4gRWl0aGVy
IHdheSwgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIHNvbWUgY2hhbmdlbG9nIG1hdGVyaWFsIHRv
IHRoYXQNCj4gZWZmZWN0Lg0KDQpUaGUgb25seSBzcGVjaWFsIHNoYWRvdyBzdGFjayB0aGluZyB0
aGUga2VybmVsIGRvZXMgaXMgV1JVU1MsIHdoaWNoIHBlcg0KdGhlIFNETSBvbmx5IG5lZWRzIHRo
ZSBDUjQgYml0IHNldCB0byB3b3JrICh1bmxpa2UgV1JTUykuIFNvIEkgdGhpbmsNCnRoZSBsYXp5
IHJlc3RvcmUgaXMgb2suDQo=
