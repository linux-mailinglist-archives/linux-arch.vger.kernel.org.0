Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBE5FE42C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJMV2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJMV2a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 17:28:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9218DAB3;
        Thu, 13 Oct 2022 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665696509; x=1697232509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SdHqKvgdukNKUnzOUCfJX/EKYLed83kTks8wSSlL0NU=;
  b=GhKfhjUOTMh58EfpOVUzsSiZx+w3rr62zC6uDcfPlB4RjfE+moKtn7dG
   1evhyeBR37fyuQWQNYfXRvFqAhCdg4+jWkubsJXuoda38fwf32LzUMBST
   eCgKBtq41rD2JFz42LU2iKyvlx+1FyE36/yB0c+pWndEJscmtv3OpZx0K
   7DVzxvljl8lMRfXevA9tvJknZaLvTG4O07gzgH9tkCj9ztztMruqhg9Q/
   nwUSneeXXI+DUkWLumdk0H8wcbQvOi/EumkWKayrAqgdUGRxmoBT+XVxg
   Gw3bJrUNnNdKyszq0BYLhmSGfF77vwapegIKLlvVoAnOx2jmwJV0jYUJJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305199026"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305199026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 14:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="622316773"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="622316773"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 13 Oct 2022 14:28:27 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 14:28:27 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 14:28:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 14:28:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 14:28:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZLO3+AlQvbAMsb36sImnkFk5xdNJpOQmAqgt5WDAtyYX/4gGBojYtDbzOTHFSLWnBlNEg4NwKYhDhVH/aXP0QgYsyUDXoYOVDVVNdudan8JnVJk1cCKVlm8rFk1Z4/uOmiXMLXuYvsdghkVjKZ4oD170n4Q4sCRv/t6LnOYvhx97Mk1nJzTPxLjg25ZhxA/oxHN5QtWbGRYKAqJJqtOrz05Tm2+kvilFsI/BzOw5bA63JnixcCofmc5ebIl9EoCMTPNmjqUx0i6a7tLb0NtsdxwLQo1QJwHc5q2AuXz1sdFrwXiTGTmFUOcrw8ug5I7lQK2ZVv/AYXaPnOxFlqKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdHqKvgdukNKUnzOUCfJX/EKYLed83kTks8wSSlL0NU=;
 b=HJTgb6aHDK21t0e8QJA3O0plV/fdYIBJ0lAt0+Gb6zxZK+vFkIBrwISr63ylqJkHh3Wvv6Q29V8qHVAeyjBMbf4GkhdIQ+bXDK3lXK6cElaebkwVTMu3lMAoBhXFdOUWchjT5UbGD0DB3mH4bYI7REVV4hB55S/MPvTGAZbKM2VIMO31MtTH/dgIWv7a4EHl7v5JfxEZK8z/GEhZhWeXV8txpN7XMPxgY76nQlt8DHMKqwCCMMnb1MeqVeG/7R80mRn8ZY2G97xNKQM/4MVCXDSt5NWTN6CFaN76yxgMYpDttXXR+Avo74bTizzoC/mKyw3sxDUIJCmkOM6NQOzTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 13 Oct
 2022 21:28:23 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 21:28:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY1FL/9ZOrfh44YkS3ARV6MT/4g64HnGzRgABKE4CAAt11coACKNeA
Date:   Thu, 13 Oct 2022 21:28:22 +0000
Message-ID: <cc1838888e9da64415331e6f7d83965b553daae7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-2-rick.p.edgecombe@intel.com>
         <87ilkr27nv.fsf@oldenburg.str.redhat.com>
         <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
         <87v8opz0me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87v8opz0me.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA1PR11MB6942:EE_
x-ms-office365-filtering-correlation-id: 78400135-bf00-4c46-8d21-08daad61db30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKx/J/6dcFHbkst6Yvo1nGUfRxUzl05XryWeUHLXqMQ8F6a7rSzAYkzxOtXGtUYjC3wv/sxuyaCxoRSvzZvcLEMMNFn9C6pq3TuCtCdsC4tWNpttOhRc6xRCRjzdWFEhuoNtdQW5WnIoEQdlZAId2r4g4rs6ugVGI5mKVL6qkbNOE5T0tPx3H5MtIhMdrVbiDYGj4iyZeim5SF4qh8Wl97RGXb+2oW9T/pxDGa/uw6G8e/VGatdP/ThOMCDwlqNyslYhJoERWiniOd45y2GvC/beuczh6p5haBraZK8h/zR8QTEcMrV5+SyYWboZZuVZYq33LhXY2HMcdYGZm6fKOn0TyhgFAOaJEDu2extlMwrtyjL2XqicGYkjRx89qnzJ4rutYjY6NLsqRqlq45K8wUiQlGY/5Q/5iSVKXXZEdP+6g10KVg18yqYHoc37ZH8s0nEw1HNBtD0zsbN7UAJnytQAZaxAeAaWRnnBAG/iDiMJ85Ci/Y8PtRXSGH0R9XcpRw0CeeobZAvb/1ZFcB4c9GTAYfRvTlF639Q5hfk826XXWcrhmhrMUnW6F5zl2pOODIkRzKliJnbDN6G/dsbIC/N7a488iq4CCo+21b6tVz7cj0AebKFAHQ4pWJk6Wu0FZBUK1Q2S70a4DnNlTvSTIdsy9I8WBGcGdKCElWE7x2VB0K9rgFqD6xo5vYwdiZ1ShORBmloKru2+qmWOG3a0D7KZPm7y2VKuW4bFMkYlrPUJn1LOMELeqPGOGidV8ofdQztyl5rvAwICzilFAyR32Ed6MwL01o/ehyZTdKm9O0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(66899015)(36756003)(478600001)(2616005)(82960400001)(86362001)(122000001)(7416002)(6916009)(38100700002)(8936002)(186003)(2906002)(66476007)(83380400001)(64756008)(26005)(316002)(5660300002)(4001150100001)(66556008)(6512007)(6486002)(54906003)(76116006)(6506007)(38070700005)(66946007)(7406005)(4326008)(41300700001)(71200400001)(8676002)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUtnRk5tT2hIclY1Vm44MStXVEwxajBrclQ1S21qaHBnMXlBT2NYREdicUY3?=
 =?utf-8?B?VUl5QVByeDU3Sjh4NFo2STFZbiswcVlHS3o3MEdHSmw0dXhKQXg4dDZlWEtH?=
 =?utf-8?B?eVhpMXY3TjJKZHdlQkZxdy9qVFg4QndMNVpHM2JBdVJOSVpTWnlpRWV4bHdH?=
 =?utf-8?B?cURxUEE3QmFzcXlyZTMyZEtxL3U1alM0cDhYVlVneC9QSWU4VzNVcVJqWHlJ?=
 =?utf-8?B?eVl1UnhENkl6dGVIaVNpbzN5L2tjNEJRSUttd05CeHhtbDhuelpKOTdnVEpr?=
 =?utf-8?B?NDhJcEUzZVFWeUh3dStpYVBwNTZYSTdTWEd3T3puYlBqMGUzMGliLzFPTFpM?=
 =?utf-8?B?Ny8wa3dIMWxiSnZqZmRsYVlod0l4ZFNBWEtmc0Y3RnNKaGlybjJUUGJaZ3Ja?=
 =?utf-8?B?N1lrRjN2SXJabWFLUkUxeWJjWW9YWU9BWEJYb2VMdld0SHBnemZxTW53a1FK?=
 =?utf-8?B?dHFES1NBcUhmVEhkQTcwUEkyTTl4Y2VXa0tFYW52YU1BbC9BclArUlRoa2tY?=
 =?utf-8?B?dXpOVFJuOTgrZ0txdXVQalE1TlR6QmdLYnBUSHc4bWo3Q2xnZHhuRDNyaU1D?=
 =?utf-8?B?Vkc2Vmh3enJxRW04Q25lckRIa0h5dkpCQjVJcU0xWElrSU83TWhMQ2tXVXpK?=
 =?utf-8?B?ZDY3QUdibHk0NDZkaTJENGdOZHFGRWFOelNyZ2RDZVRlajFISGFFNXdILzB2?=
 =?utf-8?B?b1hIRVd4amFDWWhrSTVCZ0tWcjk5NjBrTjFIWDAydzhhaWJYeVlXZHRhdWhR?=
 =?utf-8?B?aW42cmVGUXc4WHp0S1hBYW80bEo3WW1NQjlJalljVmJUbWxmNHpoRi9jQ2RG?=
 =?utf-8?B?UUlKRzRDY3dyQzFoOGl1Z2V1Qm1Vdm5SYUF5encrQXhXMEY4S0hocWZmcDRJ?=
 =?utf-8?B?L3FHUUxpdGZLMHVtbVZIVDBJbG0reG9oODhpL0VMdFNDbjl2Uy9nTmpDQU1T?=
 =?utf-8?B?SG4vTCtDeUxLZisydU1EMnhPMWRrV3VwNXhxdXY3Skg4dkZjWTJWZHNzWnBm?=
 =?utf-8?B?TGlhRERLc1AyTGZOS1ArWHRrOG1mREc1ZGRGREJkc3dEMWEyanB2MWJtbFRM?=
 =?utf-8?B?dlB6TzY3RldNYVZPcWJYYjNFaXdGWUszZUtReU5TS0ZwUXpRNVJFSEpUcnhT?=
 =?utf-8?B?cUt5S0k3YmJIZE9PVjNDZDBtVEwxTVJxVk9mbGJqSTdya2pxbEsxSTZnbHZP?=
 =?utf-8?B?OTZvKzBuOXdGN0xGcnRiTVE5R0hDL1hNQUhDeWhSZkp5SmNCbkZGVG44bDJH?=
 =?utf-8?B?aVgzQURmbnA0dlJId0duVjNWU1RhaEs2U1BYTnpQSDl1Y1JXa1czMndVb2lr?=
 =?utf-8?B?ZCtTNE1jdndPbTB5d1VXdTY1dDlXSENoOFk4VS9zQll5Zjc4T3JTMTU5VHNs?=
 =?utf-8?B?c0x6ekh2Sk5jYmkzdWloWmNVL2pRWjZtbE1mWTBOZTFhL2hyYzIrSFNZQ2pB?=
 =?utf-8?B?YWJQQzRXQTliRXNQcEJVaFNlSDdIbzc2TXY4MUhmNzhGai9zYXIxaTZINjdq?=
 =?utf-8?B?M1FVTDBWVDIvWjJnMUtOR0U4Z3BnMXg5VlRIMWtxZEJ3N1ExZFpnQWU0SG5P?=
 =?utf-8?B?NWJ0OTF6emFYdnBVa25FaVg0SGdaOXJQekdKMit2Rzl2bWRXU3hFTzFSK3lW?=
 =?utf-8?B?RkgwNkZYRDN2UjBDS0l4eFR0QmNUY1NEOVZrLzdGMVlNOFF3VnNsZlpxbDdt?=
 =?utf-8?B?akwweXJyRkNvbzJEUHlvUVk4RkwxZU9zZno3NUpSSGxhR1RSRytHMUxqS0FW?=
 =?utf-8?B?WG9pbGxzTmgyTi9vQjI2alpZSTA3OVlQOWpMQXZSUlI1MFppSnhZN2dpWDBQ?=
 =?utf-8?B?MW1pMjVNcVhBYldGU0xEei9CZXlSZ2E0U2NiRDQzRjc1a0NCc1VUbzNwRnZL?=
 =?utf-8?B?MU5ubnhyMm1BN2xQRGJyWmpEOUZqbzFsMFNyeWhMc0hJYmk2NmNrQlRFMXBR?=
 =?utf-8?B?MDdSZ3lLK0oydWZyUkc2bzhHR0RaeDhNWDVNNGNHeUt1N2hOTFkvMVZCV1lt?=
 =?utf-8?B?VGhIUGtYTGRDU0lUWjlKeiswTHlNNHdwRkMzWkZYWUdreS9zTnZkUTRFRE1i?=
 =?utf-8?B?OHo0eU4xd2FPbUhCQk9PZ2wwQlArYTJDMnBoSG9EMHR6ckRFdDdYQXpCMFY0?=
 =?utf-8?B?WXZibkxUUjR4ZXk4OC8xNnRpNVhwVTByLzNJa0hQM1BkMWU3UVA2aHlzQ01y?=
 =?utf-8?Q?iUGnXanbkM2Pb0Cz5k17m1E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D40E5110C29FC64F8B79DA2C9D4C2129@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78400135-bf00-4c46-8d21-08daad61db30
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 21:28:22.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oYfuhZ7fjPCwTY9H03hqHbOggmaJq53i4Ct5F24txVJ46TpJtlmawHsu4CfzqFlo2aV+m4lDuyUOvLyLRmp6cyco1X4uaHSLbmEiwc17A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDE0OjI5ICswMjAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gVGhlIEFCSSB3YXMgZmluYWxpemVkIGFyb3VuZCBmb3VyIHllYXJzIGFnbywgYW5kIHdlIGhh
dmUgc2hpcHBlZA0KPiBzZXZlcmFsDQo+IEZlZG9yYSBhbmQgUmVkIEhhdCBFbnRlcnByaXNlIExp
bnV4IHZlcnNpb25zIHdpdGggaXQuICBPdGhlcg0KPiBkaXN0cmlidXRpb25zIGRpZCBhcyB3ZWxs
LiAgSXQncyBhIGJpdCBsYXRlIHRvIG1ha2UgY2hhbmdlcyBub3csIGFuZA0KPiBjZXJ0YWlubHkg
bm90IGZvciBzdWNoIHRyaXZpYWxpdGllcy4gIEluIHRoZSBjYXNlIG9mIHRoZSBJQlQgQUJJLCBp
dA0KPiBtYXkNCj4gYmUgdGVtcHRpbmcgdG8gc3RhcnQgb3ZlciBpbiBhIGxlc3MgdHJpdmlhbCB3
YXksIHRvIHJhZGljYWxseSByZWR1Y2UNCj4gdGhlDQo+IGFtb3VudCBvZiBFTkRCUiBpbnN0cnVj
dGlvbnMuICBCdXQgdGhhdCBkb2Vzbid0IGNvbmNlcm4gU0hTVEssIGFuZA0KPiB0aGVyZSdzIG5v
IGFjdHVhbCBpbXBsZW1lbnRhdGlvbiBhbnl3YXkuDQo+IA0KPiBCdXQgYXMgSC5KLiBpbXBsaWVk
LCB5b3Ugd291bGQgaGF2ZSB0byBkbyByYXRoZXIgbmFzdHkgdGhpbmdzIGluIHRoZQ0KPiBrZXJu
ZWwgdG8gcHJldmVudCB1cyBmcm9tIGFjaGlldmluZyBBQkkgY29tcGF0aWJpbGl0eSBpbiB1c2Vy
c3BhY2UsDQo+IGxpa2UNCj4gcGFyc2luZyBwcm9wZXJ0eSBub3RlcyBvbiB0aGUgbWFpbiBleGVj
dXRhYmxlIGFuZCBkaXNhYmxpbmcgdGhlIG5ldw0KPiBhcmNoX3ByY3RsIGNhbGxzIGlmIHlvdSBz
ZWUgc29tZXRoaW5nIHRoZXJlIHRoYXQgeW91IGRvbid0IGxpa2UuIDgtKQ0KPiBPZiBjb3Vyc2Ug
bm8gb25lIGlzIGdvaW5nIHRvIGltcGxlbWVudCB0aGF0Lg0KPiANCj4gKFdlIGFyZSBmaW5lIHdp
dGggc3dhcHBpbmcgb3V0IGdsaWJjIGFuZCBpdHMgZHluYW1pYyBsb2FkZXIgdG8gZW5hYmxlDQo+
IENFVCB3aXRoIHRoZSBhcHByb3ByaWF0ZSBrZXJuZWwgbWVjaGFuaXNtLCBidXQgd2Ugd291bGRu
J3Qgd2FudCB0bw0KPiBjaGFuZ2UgdGhlIHdheSBhbGwgb3RoZXIgYmluYXJpZXMgYXJlIG1hcmtl
ZCB1cC4pDQoNClNvIHdlIGhhdmUgdGhlc2UgY29tcGF0aWJpbGl0eSBpc3N1ZXMgd2l0aCBleGlz
dGluZyBiaW5hcmllcy4gV2Uga25vdw0Kc29tZSBhcHBzIGFyZSB0b3RhbGx5IGJyb2tlbi4gSXQg
c291bmRzIGxpa2UgeW91IGFyZSBwcm9wb3NpbmcgdG8NCmlnbm9yZSB0aGlzIGFuZCBsZXQgcGVv
cGxlIHdobyBoaXQgdGhlIGlzc3VlcyB3b3JrIHRocm91Z2ggaXQNCnRoZW1zZWx2ZXMuIFRoaXMg
d2FzIGFsc28gcHJvcG9zZWQgYnkgb3RoZXIgZ2xpYmMgZGV2ZWxvcGVycyBhcyBhDQpzb2x1dGlv
biBmb3IgcGFzdCBDRVQgY29tcGF0aWJpbGl0eSBpc3N1ZXMgdGhhdCBicm9rZSBib290IG9uIGtl
cm5lbA0KdXBncmFkZS4gSSBoYXZlIHRvIHNheSwgYXMgdGhlIHBlcnNvbiBwdXNoaW5nIHRoZXNl
IHBhdGNoZXMsIEnigJltDQp1bmNvbWZvcnRhYmxlIHdpdGggdGhpcyBhcHByb2FjaC4gSSBkb27i
gJl0IHRoaW5rIHVzZXJzIHdpbGwgbGlrZSB0aGUNCnJlc3VsdHMuIEJhc2ljYWxseSwgZG8gdGhl
eSB3YW50IHRvIHVwZ3JhZGUgYW5kIHJ1biBhIGJ1bmNoIG9mIHVudGVzdGVkDQppbnRlZ3JhdGlv
biB3aXRoIGtub3duIGZhaWx1cmVzPyBJIGFsc28gZG9u4oCZdCB3YW50IHRvIGdldCB0aGlzIGZl
YXR1cmUNCnJldmVydGVkIGFuZCBJ4oCZbSBub3QgZXhhY3RseSBzdXJlIGhvdyB0aGlzIHNjZW5h
cmlvIHdvdWxkIGJlIHRha2VuLg0KDQpCdXQgSSBoZWFyIHRoZSBwb2ludCBhYm91dCBpdCBub3Qg
YmVpbmcgaWRlYWwgdG8gYWJhbmRvbiB0aGUgZXhpc3RpbmcNCkNFVCB1c2Vyc3BhY2UuIEkgdGhp
bmsgdGhlcmUgaXMgYWxzbyBhIHBvaW50IGFib3V0IGhvdyB1c2Vyc3BhY2UgY2hvc2UNCnRvIGRv
IHRoaXMgb3B0aW1pc3RpYyBhbmQgZWFybHkgd2lkZSBlbmFibGluZywgZXZlbiBpZiBpdCB3YXMg
YSBiYWQNCmlkZWEsIGFuZCBzbyBob3cgbXVjaCBzaG91bGQgdGhlIGtlcm5lbCB0cnkgdG8gc2F2
ZSB1c2Vyc3BhY2UgZnJvbQ0KaXRzZWxmLiBTbyB3aGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlz
IGluc3RlYWQ6DQoNClRoZSBjdXJyZW50IHBzQUJJIHNwZWMgdGFsa3MgYWJvdXQgdGhlIGJpbmFy
eSBiZWluZyBjb21wYXRpYmxlIHdpdGgNCnNoYWRvdyBzdGFjay4gSXQgZG9lc27igJl0IHNheSBt
dWNoIGFib3V0IHdoYXQgc2hvdWxkIGhhcHBlbiBhZnRlciB0aGUNCmxvYWRlci4gU2luY2UgdGhl
IGdyZWF0ZXIgZWNvc3lzdGVtIGhhcyB1c2VkIHRoaXMgYml0IHdpdGggYSBtb3JlDQpjYXZhbGll
ciBhdHRpdHVkZSwgZ2xpYmMgY291bGQgdHJlYXQgaXQgYXMgYSByZXF1ZXN0IGZvciBhIHdhcm4g
YW5kDQpjb250aW51ZSBtb2RlLiBJbiB0aGUgbWVhbnRpbWUgd2UgY291bGQgaGF2ZSBhIG5ldyBi
aXQgc2hzdGtfc3RyaWN0LA0KdGhhdCByZXF1ZXN0cyBiZWhhdmlvciBsaWtlIHRoZXNlIHBhdGNo
ZXMgaW1wbGVtZW50LCBhbmQga2lsbHMgdGhlDQpwcm9jZXNzIG9uIHZpb2xhdGlvbi4gR2xpYmMv
dG9vbHMgY291bGQgYWRkIHN1cHBvcnQgZm9yIHRoaXMgc3RyaWN0IGJpdA0KYW5kIGFueW9uZSB0
aGF0IHdhbnRzIHRvIG1vcmUgY2FyZWZ1bGx5IGNvbXBpbGUgd2l0aCBpdCBjb3VsZCBmaW5hbGx5
DQpnZXQgc2hhZG93IHN0YWNrIHRvZGF5LiBUaGVuIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUg
d2FybiBhbmQNCmNvbnRpbnVlIG1vZGUgY291bGQgZm9sbG93IHRoYXQsIGFuZCBnbGliYyBjb3Vs
ZCBtYXAgdGhlIG9yaWdpbmFsIHNoc3RrDQpiaXQgdG8gdGhhdCBrZXJuZWwgbW9kZS4gU28gdGhl
IG9sZCBiaW5hcmllcyB3b3VsZCBnZXQgdGhlcmUNCmV2ZW50dWFsbHksIHdoaWNoIGlzIGJldHRl
ciB0aGFuIHRoZSBjb250aW51aW5nIG5vdGhpbmcgdGhleSBoYXZlDQp0b2RheS4NCg0KQW5kIHNw
ZWFraW5nIG9mIGhhdmluZyBub3RoaW5nIHRvZGF5LCB0aGVyZSBhcmUgcGVvcGxlIHRoYXQgcmVh
bGx5IHdhbnQNCnRvIHVzZSBzaGFkb3cgc3RhY2sgYW5kIGRvIG5vdCBjYXJlIGF0IGFsbCBhYm91
dCBoYXZpbmcgQ0VUIHN1cHBvcnQgZm9yDQpleGlzdGluZyBiaW5hcmllcy4gTmVpdGhlciBnbGli
YyBvciBlbGYgYml0cyBhcmUgcmVxdWlyZWQgdG8gdXNlIGtlcm5lbA0Kc2hhZG93IHN0YWNrIHN1
cHBvcnQuIFNvIGlmIGl0IGNvbWVzIHRvIGl0LCBJIGRvbuKAmXQgd2FudCB0byBob2xkDQpzdXBw
b3J0IGJhY2sgZm9yIG90aGVyIHVzZXJzIGJlY2F1c2UgdGhlIGVsZiBub3RlIGJpdCBlbmFibGlu
ZyBwYXRoDQpncmV3IHNvbWUgaXNzdWVzLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgYWJvdXQgd2hh
dCB5b3UgdGhpbmsgb2YgdGhhdCBwbGFuLg0K
