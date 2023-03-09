Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058C6B2DD9
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCITjx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 14:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCITjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 14:39:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506CCE5015;
        Thu,  9 Mar 2023 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678390788; x=1709926788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qVe9TuJZUeYZAup7l/xyFBR04a8qoYDg8PYX1TBQcR4=;
  b=QV/bThkYLnMulHyJsRtrkjqVCnmdKLP5upPOtAJWF/Gil0PUvTVZXwfJ
   2U3bXCEsnNN4nGVMdpMvOknxbbMRo0QUd2Dlo/ge/8HCFIu6wrC5Ibbek
   pdlHTJqyiGqHFEZUc+EMniA4Ur/UUKmzmIWU3CyapYMJrb42q41s3yjTY
   UMb+2tiRro5rFrj1UYl68SIoB38vIvMQJRBwh+0QVi4tDhC8OOWvh9Z51
   lFIQLa1dht04bgzKZ6FT7AFWTVyRJb6aEk5T6HrGICCGUANmcvJLPsE8j
   Uc6nkuZx6xSLtFI9VvIm0772LVbamVgD3vyPJyi5tfsa6E0/G40zHEbRA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="324899540"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="324899540"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 11:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="677521928"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="677521928"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 09 Mar 2023 11:39:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 11:39:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 11:39:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 11:39:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjIFpCxx+oSmb4j6HNnWkNiaw19+cvJt0nB0rSKGaaI/OwtMta5bLqYDMO+ytX2xw8Ih//rfVC8lB+/Okl5370VhoMRRRRkLqkMVER1xOlbhJb1LFIsT8myA5WYJOb/z6DIgIqjet2WehfHEyU9YB2o4U9kCno1RcQ2tmx/RGNUC3svoYLxMUkP9ok51/ksh4hJKeL3K98z4S3u/JSmeA3gYLzZ0yExA96JOLUSDh9hoH7a35utDQWEimXt3MxqXWjUjWsxm8TKHHqTLfU5fPA8UCz3w4Z6TEcrQasorAQPNp2H8A+CBQi2062Mh5pBu8uld+nID9KSeQu55GVAJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVe9TuJZUeYZAup7l/xyFBR04a8qoYDg8PYX1TBQcR4=;
 b=Dw9kEycQbKt+N0x+rQBwqekuPP6Zmf8bufyXt4K8MGfok+E9puNO1oveDjltb//QTixDXo+5sla9qHSIz4rKA06WDMmmu07kc1VQ4IHsinhYO5givj964xUHfh9M8pL6uEmZ6vtwTpFdKrXgngZOi7vvER+BfDM1epvj/gMY3qjT75MPMF39Giz8BprX6FWCZ+dqVodYdmgPs0vMguJ4vw0QHobc0gbAjqFKiwqD9AqTrgStcTrPilDEvVMJEvW4JFgZ/CXZKSCtw+cUOsU0YGkCjvQMhk+NqX6UHKuVyeNdxokDVb/36LnJD92SEW6u6UmgkXov3FmYMtFR65+PYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 19:39:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 19:39:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "al.grant@arm.com" <al.grant@arm.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>, "nd@arm.com" <nd@arm.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK7nwRCAgAsaUoCAAAxuAA==
Date:   Thu, 9 Mar 2023 19:39:41 +0000
Message-ID: <aaf918de8585204fb0785ac1fc0f686a8fd88bb0.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZADbP7HvyPHuwUY9@arm.com> <20230309185511.GA1964069@debug.ba.rivosinc.com>
In-Reply-To: <20230309185511.GA1964069@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM6PR11MB4738:EE_
x-ms-office365-filtering-correlation-id: ac9d6a15-2186-4378-3c14-08db20d60722
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4tW5O8/QMHMKMnJHeA0Ggw6zQJNmc60qPtkrQhsvlawlmTkcVh3WsE+tTAIyLXKjhKm83NeTnaqHU75+NACpP9uE5x/v+wYNVVONGxNJZtoxwiWy4TWNyUZMT5mmkLeJQc70HX7DWnqFRLc4axkPQjJs1kF/8KibRSa8kzVZSr22OhpxVv8GhrC19IuNjAVnypAF2qeXqGPgKCZCyHvEvxux1zwMW1q0odFW9myqVBDHnzP5LUDL0H2lMX9xrnVqx27CGROVET5b+UuxwHKn7olkRo4UXfNj9uiCV2o3vcupMNy8aJTq664d1cL2liuzBriZMToOAu7GGofox5wYqQAyRnjy1i2iR35sda0klFQoBAwmXIvRSe3Z5K2igCaNjq1R0Pwrd8FQXYC6+1OusGu8iT8VwTSki4zuxoZpYOHYc7Y3+ZwzE+B/r1hTvpVDZlChZuY62ekWRyPO72a52bg2qYp7h5eiBOJ4cb+D9QW33/yOzZeauI+HmnCH67Tb/iiywc9PnOaTWuGG5MrkMCZeA6GujLkcVGQ2QgZ8IAwPBhQ3fKbOhNCEy7IV65USbbq6SeW1OTcS2YGPsCtypB+SYUG5dSkN0+BeqSy8nyVs3/oaDFWPJW2FqgvH0QfBskxZSiPgnObaW1tz01dEYx2ouE05M96aOped+R8FhmEMa3I6EOY77NJ9sr38kPGKdOYDXE3ZN1+tiVEd3zIYDXxJeHP5vyhyB0gSVNHP4rR1ez2aBAYmZDuCw8kW0kd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199018)(66899018)(82960400001)(186003)(966005)(6486002)(71200400001)(36756003)(54906003)(478600001)(38100700002)(38070700005)(86362001)(316002)(110136005)(122000001)(6512007)(83380400001)(26005)(41300700001)(2616005)(5660300002)(7406005)(7416002)(6506007)(64756008)(76116006)(91956017)(8936002)(66446008)(66556008)(66476007)(2906002)(8676002)(66946007)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0ZuWHhQN1FCS3V5aTVrZ2UxbHlsQ2JXVWtycWlaU2pXcVYyZFFvbituYUUr?=
 =?utf-8?B?dVFBK1d5Q3lGUWJhdDhZemxBTWcyanZWMEVIeU5lZ2tNQ0lTVkxaSWp5SVlG?=
 =?utf-8?B?d0FPU3laQjY3OHZERStFUkx0eXh4aWZiSmJrL0k2QkZ6YUU3enIzSmJUSmZm?=
 =?utf-8?B?TkFnSDhyTEMwNmNYRTRvWW5IWkdKY0d1aGNFQ3Zsa1g5aUxIMDJoYkhzT0Nl?=
 =?utf-8?B?TTZ3eEdnOTdacHRpbW41MVZ2Ujh4R3hMN2hKZmVmdUJpcHRVMEpKSTliLzdF?=
 =?utf-8?B?WWZSU09NelhWNVQ4OHduRmwwdjROcXJTMkVoT01xcVRZVE9wZG1HaXh1b3BW?=
 =?utf-8?B?N2RwYnRkZHFkblFYZlZOOFRVRWlXYnJSSEN6cW1JR011OEo0NmxxZmE4SEcy?=
 =?utf-8?B?ZnRjWm9QTXYxanVmSkpnc1c1SW5rRkVRbVcreEc4MHRHdnYvSDFlVWJPMkpV?=
 =?utf-8?B?WXlVYkNTT0lTZElXdFYwSXpiTnFyMU9YVFA1Zy9uVTljc1VCd2s0OUhyRVdW?=
 =?utf-8?B?YWY4YkpINmNESUdtUS81ZkxIdVE0UTEvelRia0JtTyt4cWpsYkZoUm1jN3hv?=
 =?utf-8?B?Tzg5RzBRMW11Wkd4bUU1NXFnWHcvV0t5aUdtN3FoTytwV2pQTnZ4VGNGUllM?=
 =?utf-8?B?WHBhQ0dlSHZvS1VLdUhpckp0ZFFOYjFZN25ySUU2YnVJRHBwZTNZaTl2Y2hY?=
 =?utf-8?B?RjNPYzNXK3VoZjVsTTBTQ2syaTRwWVlLK0g1aW1Ra09OUWJlNXdtNUZ2dWFv?=
 =?utf-8?B?d3JjbFd0bHBHV2FNS2lYeUdWVzBsam05dGI3N3JmSng3eE9JSUc2MmNMR1Zo?=
 =?utf-8?B?SnRsVVhlUEJ2Y0MyeWhoZ05idGdHTkJhNWVRV2p2elF0VXFHbUo1Znh1UkU2?=
 =?utf-8?B?ZlRaTkw0UlYwMHJwNDU2RVhqWTFOZHlYOURFMWJRUk5MOTN1QmtWRG5jT2hL?=
 =?utf-8?B?MGlWSFRmUm4rZGxQQVpjS1NNQ2pIeDFQUWxnRUtJRnlpVURqUllLR04wbUJr?=
 =?utf-8?B?aFlCckxkbU5YODZzK01lcnhCWVdBdDM5am9mRzYwWEV3SXJmenVTbWFEL3ln?=
 =?utf-8?B?dkNQVU5QVW9yZTNlajQwR1dFR1IyNUFWZDdtcW94RitLcDFSeVJCTVE1SUw2?=
 =?utf-8?B?UUZiWVNGeGFKNzJ2NjZKVWJrYi96MkkveUZ5RWxIZzgvNGlsdk12Rnl0RGxz?=
 =?utf-8?B?OHVvcHlHcDFhRUg2T2VVNkh0QXVCZVU2VnpkaVBnNmdWMGI2MTRxZEJjUHdL?=
 =?utf-8?B?cy9sK2NzTnp1SVBRVTFpeFNnN3lsU2xrM1VzMTJyb2ZMK3JJV05oVDc2QWtO?=
 =?utf-8?B?VTVXT3F2ckpjMGl0SG1PMlNRYVZ5SVE4TXlxb2x1ekVyazZuSm8rc2M2WWdJ?=
 =?utf-8?B?N01FZFpGSjlTRjU1R1YrV2Y3akV0WUhEdHRPM2pvd0xmYmNxRkdzTDVGVC9Y?=
 =?utf-8?B?a1lTY2VRYjQ1bzg2dEp6aithZDlkak1BcjJ2Snc1YTFjOHFYZW5DTU5vZkRk?=
 =?utf-8?B?MDVqMEI1S2Z4czI0YzlUTmExQTYyc2xDTWVzTzZ2YUd0N2hMd2xLQjduUEo2?=
 =?utf-8?B?VXlxeHVOU3BYc2lhLzBRZE5jVk4xVlQrZ0JvMXoxVU5lRXQ3MjNIVXc3QmI0?=
 =?utf-8?B?ZGZDMldheDhkN2FhbHBVQ0tybS9NTVNzU3pBV1NnMDdRYlI0WVpsMlk1VGl1?=
 =?utf-8?B?TUMzVjl0MWZlWGFVL2JSM3NZekVmR21CTThiMzJzdjFhMDZkRG9idU1US0dI?=
 =?utf-8?B?Tlp0L2thM1oyajNWM05weUs1SE5IdmNoeUltSkJhL2dtK1h3WlRRekFBM1Z0?=
 =?utf-8?B?am1OZWE5dEIrb25QR0Z3TXhKdm1MRThvUFUrdi9DV2xpakQzODBJR0lVVVdw?=
 =?utf-8?B?VDBsK0ZZOGxUVksrL0tyN2oxMlh3NUJpbE10MFBEaU4yaFRIeUowa1pJRFg0?=
 =?utf-8?B?WFArYzJ5c3lmTGJkd1ptdXBQWjEyRHlZWWZlV0V4NDVZeUd4VlBTUThESkdv?=
 =?utf-8?B?Sm5iV3NuOVV5TmJ6cEhZelFVdmc4UkdNaU1GMkV5YklJMWo5MWpnSUtlS3Zr?=
 =?utf-8?B?dEc2V2VYcUwrbE1IV3laVXdNd2RWRmU3K3RDS0VlTUptWVlDdkxmQldXKzZD?=
 =?utf-8?B?T3pSY0tIVXdxdjNxYjdiaUFqdzA3YkFnM2NRU2dSYXlyM1Ewblg0cFlYN1U1?=
 =?utf-8?Q?uIecyBYWioOjEYR/jhFGsIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D7C1F10037F274B9116A78A6839BBEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9d6a15-2186-4378-3c14-08db20d60722
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 19:39:41.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pYQmzp6USMqihHpXrh0H8K7VLh5n4bD8vcm6HUTmEdiTNL9g0ckjZJ+kYCHtIf1wm7u0vn81SZl3qjSMxg6BJ0ir8X0IB9f1tLZMwujJB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDEwOjU1IC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIFRodSwgTWFyIDAyLCAyMDIzIGF0IDA1OjIyOjA3UE0gKzAwMDAsIFN6YWJvbGNzIE5hZ3kg
d3JvdGU6DQo+ID4gVGhlIDAyLzI3LzIwMjMgMTQ6MjksIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0K
PiA+ID4gUHJldmlvdXNseSwgYSBuZXcgUFJPVF9TSEFET1dfU1RBQ0sgd2FzIGF0dGVtcHRlZCwN
Cj4gPiANCj4gPiAuLi4NCj4gPiA+IFNvIHJhdGhlciB0aGFuIHJlcHVycG9zZSB0d28gZXhpc3Rp
bmcgc3lzY2FsbHMgKG1tYXAsIG1hZHZpc2UpDQo+ID4gPiB0aGF0IGRvbid0DQo+ID4gPiBxdWl0
ZSBmaXQsIGp1c3QgaW1wbGVtZW50IGEgbmV3IG1hcF9zaGFkb3dfc3RhY2sgc3lzY2FsbCB0byBh
bGxvdw0KPiA+ID4gdXNlcnNwYWNlIHRvIG1hcCBhbmQgc2V0dXAgbmV3IHNoYWRvdyBzdGFja3Mg
aW4gb25lIHN0ZXAuIFdoaWxlDQo+ID4gPiB1Y29udGV4dA0KPiA+ID4gaXMgdGhlIHByaW1hcnkg
bW90aXZhdG9yLCB1c2Vyc3BhY2UgbWF5IGhhdmUgb3RoZXIgdW5mb3Jlc2Vlbg0KPiA+ID4gcmVh
c29ucyB0bw0KPiA+ID4gc2V0dXAgaXQncyBvd24gc2hhZG93IHN0YWNrcyB1c2luZyB0aGUgV1JT
UyBpbnN0cnVjdGlvbi4gVG93YXJkcw0KPiA+ID4gdGhpcw0KPiA+ID4gcHJvdmlkZSBhIGZsYWcg
c28gdGhhdCBzdGFja3MgY2FuIGJlIG9wdGlvbmFsbHkgc2V0dXAgc2VjdXJlbHkNCj4gPiA+IGZv
ciB0aGUNCj4gPiA+IGNvbW1vbiBjYXNlIG9mIHVjb250ZXh0IHdpdGhvdXQgZW5hYmxpbmcgV1JT
Uy4gT3IgcG90ZW50aWFsbHkNCj4gPiA+IGhhdmUgdGhlDQo+ID4gPiBrZXJuZWwgc2V0IHVwIHRo
ZSBzaGFkb3cgc3RhY2sgaW4gc29tZSBuZXcgd2F5Lg0KPiA+IA0KPiA+IC4uLg0KPiA+ID4gVGhl
IGZvbGxvd2luZyBleGFtcGxlIGRlbW9uc3RyYXRlcyBob3cgdG8gY3JlYXRlIGEgbmV3IHNoYWRv
dw0KPiA+ID4gc3RhY2sgd2l0aA0KPiA+ID4gbWFwX3NoYWRvd19zdGFjazoNCj4gPiA+IHZvaWQg
KnNoc3RrID0gbWFwX3NoYWRvd19zdGFjayhhZGRyLCBzdGFja19zaXplLA0KPiA+ID4gU0hBRE9X
X1NUQUNLX1NFVF9UT0tFTik7DQo+ID4gDQo+ID4gaSB0aGluaw0KPiA+IA0KPiA+IG1tYXAoYWRk
ciwgc2l6ZSwgUFJPVF9SRUFELCBNQVBfQU5PTnxNQVBfU0hBRE9XX1NUQUNLLCAtMSwgMCk7DQo+
ID4gDQo+ID4gY291bGQgZG8gdGhlIHNhbWUgd2l0aCBsZXNzIGRpc3J1cHRpb24gdG8gdXNlcnMg
KG5ldyBzeXNjYWxscw0KPiA+IGFyZSBoYXJkZXIgdG8gZGVhbCB3aXRoIHRoYW4gbmV3IGZsYWdz
KS4gaXQgd291bGQgZG8gdGhlDQo+ID4gZ3VhcmQgcGFnZSBhbmQgaW5pdGlhbCB0b2tlbiBzZXR1
cCB0b28gKHRoZXJlIGlzIG5vIGZsYWcgZm9yDQo+ID4gaXQgYnV0IGNvdWxkIGJlIHNxdWVlemVk
IGluKS4NCj4gDQo+IERpc2N1c3Npb24gb24gdGhpcyB0b3BpYyBpbiB2Ng0KPiANCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDIyMzAwMDM0MC5HQjk0NTk2NkBkZWJ1Zy5iYS5yaXZv
c2luYy5jb20vDQo+IA0KPiBBZ2FpbiBJIGtub3cgZWFybGllciBDRVQgcGF0Y2hlcyBoYWQgcHJv
dGVjdGlvbiBmbGFnIGFuZCBzb21laG93IGR1ZQ0KPiB0byBwdXNoYmFjaw0KPiBvbiBtYWlsaW5n
IGxpc3QsDQo+ICBpdCB3YXMgYWRvcHRlZCB0byBnbyBmb3Igc3BlY2lhbCBzeXNjYWxsIGJlY2F1
c2Ugbm8gb25lIGVsc2UNCj4gaGFkIHNoYWRvdyBzdGFjay4NCj4gDQo+IFNlZWluZyBhIHJlc3Bv
bnNlIGZyb20gU3phYm9sY3MsIEkgYW0gYXNzdW1pbmcgYXJtNCB3b3VsZCBhbHNvIHdhbnQNCj4g
dG8gZm9sbG93DQo+IHVzaW5nIG1tYXAgdG8gbWFudWZhY3R1cmUgc2hhZG93IHN0YWNrLiBGb3Ig
cmVmZXJlbmNlIFJGQyBwYXRjaGVzIGZvcg0KPiByaXNjLXYgc2hhZG93IHN0YWNrLA0KPiB1c2Ug
YSBuZXcgcHJvdGVjdGlvbiBmbGFnID0gUFJPVF9TSEFET1dTVEFDSy4NCj4gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjMwMjEzMDQ1MzUxLjM5NDU4MjQtMS1kZWJ1Z0ByaXZvc2lu
Yy5jb20vDQo+IA0KPiBJIGtub3cgZWFybGllciBkaXNjdXNzaW9uIGhhZCBiZWVuIHRoYXQgd2Ug
bGV0IHRoaXMgZ28gYW5kIGRvIGEgcmUtDQo+IGZhY3RvciBsYXRlciBhcyBvdGhlcg0KPiBhcmNo
IHN1cHBvcnQgdHJpY2tsZSBpbi4gQnV0IGFzIEkgdGhvdWdodCBtb3JlIG9uIHRoaXMgYW5kIEkg
dGhpbmsgaXQNCj4gbWF5IGp1c3QgYmUNCj4gbWVzc3kgZnJvbSB1c2VyIG1vZGUgcG9pbnQgb2Yg
dmlldyBhcyB3ZWxsIHRvIGhhdmUgY29nbml0aW9uIG9mIHR3bw0KPiBkaWZmZXJlbnQgd2F5cyBv
Zg0KPiBjcmVhdGluZyBzaGFkb3cgc3RhY2suIE9uZSB3b3VsZCBiZSBzcGVjaWFsIHN5c2NhbGwg
KGluIGN1cnJlbnQgbGliYykNCj4gYW5kIGFub3RoZXIgYG1tYXBgDQo+ICh3aGVuZXZlciBmdXR1
cmUgcmUtZmFjdG9yIGhhcHBlbnMpDQo+IA0KPiBJZiBpdCdzIG5vdCB0b28gbGF0ZSwgaXQgd291
bGQgYmUgbW9yZSB3aXNlIHRvIHRha2UgYG1tYXBgDQo+IGFwcHJvYWNoIHJhdGhlciB0aGFuIHNw
ZWNpYWwgYHN5c2NhbGxgIGFwcHJvYWNoLg0KDQpUaGVyZSBpcyBzb3J0IG9mIHR3byB0aGluZ3Mg
aW50ZXJtaXhlZCBoZXJlIHdoZW4gd2UgdGFsayBhYm91dCBhDQpQUk9UX1NIQURPV19TVEFDSy4N
Cg0KT25lIGlzOiB3aGF0IGlzIHRoZSBpbnRlcmZhY2UgZm9yIHNwZWNpZnlpbmcgaG93IHRoZSBz
aGFkb3cgc3RhY2sNCnNob3VsZCBiZSBwcm92aXNpb25lZCB3aXRoIGRhdGE/IFJpZ2h0IG5vdyB0
aGVyZSBhcmUgdHdvIHdheXMNCnN1cHBvcnRlZCwgYWxsIHplcm8gb3Igd2l0aCBhbiBYODYgc2hh
ZG93IHN0YWNrIHJlc3RvcmUgdG9rZW4gYXQgdGhlDQplbmQuIFRoZW4gdGhlcmUgd2FzIGFscmVh
ZHkgc29tZSBjb252ZXJzYXRpb24gYWJvdXQgYSB0aGlyZCB0eXBlLiBJbg0Kd2hpY2ggY2FzZSB0
aGUgcXVlc3Rpb24gd291bGQgYmUgaXMgdXNpbmcgbW1hcCBNQVBfIGZsYWdzIHRoZSByaWdodA0K
cGxhY2UgZm9yIHRoaXM/IEhvdyBtYW55IHR5cGVzIG9mIGluaXRpYWxpemF0aW9uIHdpbGwgYmUg
bmVlZGVkIGluIHRoZQ0KZW5kIGFuZCB3aGF0IGlzIHRoZSBvdmVybGFwIGJldHdlZW4gdGhlIGFy
Y2hpdGVjdHVyZXM/DQoNClRoZSBvdGhlciB0aGluZyBpczogc2hvdWxkIHNoYWRvdyBzdGFjayBt
ZW1vcnkgY3JlYXRpb24gYmUgdGlnaHRseQ0KY29udHJvbGxlZD8gRm9yIGV4YW1wbGUgaW4geDg2
IHdlIGxpbWl0IHRoaXMgdG8gYW5vbnltb3VzIG1lbW9yeSwgZXRjLg0KU29tZSByZWFzb25zIGZv
ciB0aGlzIGFyZSB4ODYgc3BlY2lmaWMsIGJ1dCBzb21lIGFyZSBub3QuIFNvIGlmIHdlDQpkaXNh
bGxvdyBtb3N0IG9mIHRoZSBvcHRpb25zIHdoeSBhbGxvdyB0aGUgaW50ZXJmYWNlIHRvIHRha2Ug
dGhlbT8gQW5kDQp0aGVuIHlvdSBhcmUgaW4gdGhlIHBvc2l0aW9uIG9mIGNhcmVmdWxseSBtYWlu
dGFpbmluZyBhIGxpc3Qgb2Ygbm90LQ0KYWxsb3dlZCBvcHRpb25zIGluc3RlYWQgbGV0dGluZyBh
IGxpc3Qgb2YgYWxsb3dlZCBvcHRpb25zIHNpdCB0aGVyZS4NCg0KVGhlIG9ubHkgYmVuZWZpdCBJ
J3ZlIGhlYXJkIGlzIHRoYXQgaXQgc2F2ZXMgY3JlYXRpbmcgYSBuZXcgc3lzY2FsbCwNCmJ1dCBp
dCBhbHNvIHNhdmVzIHNldmVyYWwgTUFQXyBmbGFncy4gVGhhdCwgYW5kIHRoYXQgdGhlIFJGQyBm
b3IgcmlzY3YNCmRpZCBhIFBST1RfU0hBRE9XX1NUQUNLIHRvIHN0YXJ0LiBTbywgeWVzLCB0d28g
cGVvcGxlIGFza2VkIHRoZSBzYW1lDQpxdWVzdGlvbiwgYnV0IEknbSBzdGlsbCBub3Qgc2VlaW5n
IGFueSBiZW5lZml0cy4gQ2FuIHlvdSBnaXZlIHRoZSBwcm9zDQphbmQgY29ucyBwbGVhc2U/DQoN
CkJUVywgaW4gZ2xpYmMgbWFwX3NoYWRvd19zdGFjayBpcyBjYWxsZWQgZnJvbSBhcmNoIGNvZGUu
IFNvIEkgdGhpbmsNCnVzZXJzcGFjZSB3aXNlLCBmb3IgdGhpcyB0byBhZmZlY3Qgb3RoZXIgYXJj
aGl0ZWN0dXJlcyB0aGVyZSB3b3VsZCBuZWVkDQp0byBiZSBzb21lIGNvZGUgdGhhdCBjb3VsZCBk
byB0aGluZ3MgZ2VuZXJpY2FsbHksIHdpdGggc29tZWhvdyB0aGUNCnNoYWRvdyBzdGFjayBwaXZv
dCBhYnN0cmFjdGVkIGJ1dCB0aGUgc2hhZG93IHN0YWNrIGFsbG9jYXRpb24gbm90Lg0K
