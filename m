Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC36AA499
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjCCWif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 17:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCCWiS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 17:38:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D732129B;
        Fri,  3 Mar 2023 14:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677882993; x=1709418993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gGlcDw0Q0thhRpgCxmNnZRm6/dDpzfzusxXryNs9tH8=;
  b=RgTD6fvrgsgBCbTxSo/sBlH7q31rG7RMbHLm+vjJ7iuF6iasHQSrsVqR
   uOOE+nUs8EP0FUGAVpnEwUdCB5yfXFcRJoOQWPYp3AMbDK+Sh7qmZFP6a
   JoGOkcCCEzvKUDHrKTraPnXNnBr5CPI/MKwUIDjxWpfQS3E9rBRuyIGGL
   yCxSfkHEpgajQhJgqepq3YB/HBECRJLRaKW4SeEBntrq514T0qdjl8mNt
   J5bFPJ+EuhCq9ltN1dTtmH+23QdFYawKlaLdbop5As2OsjZK4EvnBP9Qe
   PTFUGmTK4x0R5avjvAEAhWyKCD/sufolY4CfS3CXWjjKViNkFMnjdvadh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="335200880"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="335200880"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785455108"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="785455108"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2023 14:35:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 14:35:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 14:35:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 14:35:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 14:35:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA0r18Y3EiZSwKhj8Zy4zBipM7Ql0xtQJxXeEatw7uB09WO749Ep06QpuS+6YJMoF+cKcVzeSnjrJDb+zVNOE+jaTF5Rvm2LXQAYzDW8a9UikDsFUZIQh0Y1Uo5kJX8JoCTMA3vo4fHIGbdJaGp6WU0ZjkJwufhVfihWK9rvrY1IbIr4EwcpiqwlXN+uiD6/WThYLF4Fehmmu2XEnCheuW3kRj5GfXgy+Vw1PTytsx0oBtDmgUSqq/GdaVeILD7z5ueLUeSN5caJ5qcG9gCwuCZ6o803oT0E/4swiRuSZrTSO83xgxvId0L3K/adXs+/x3MNrDp7+ah85RA+Eil1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGlcDw0Q0thhRpgCxmNnZRm6/dDpzfzusxXryNs9tH8=;
 b=YdZCOGOGr93vwn/SF+yuMCITx4uHiuvNMUUw4DkfSkpQCkm35XJ6tmx9P0e1yxVQL4NzXF/m4SsAVFDCKRBfFYryDum/ho/c/CFaf5ow/lD6A3+iWtAtOzYIuAS32v4uxY23xSeJ6EhbCECgFrcHf77ucDqNNl89YbKulJ8Kt2G185L+vwL/XzRXCTcRwaHAWA0inPWGUeHwCVDnqbEGcNCwXLCkm9inACEkGu1k4AU9DYAfZ6as639uyhfzNwex6SgHN2ptPNU0ypsnuxIhwdtM2sLjg+/J4g8LaAVNh0mVG/6S8c0nJ/0R51p729fNtmgbnY6i+q3ySx4m0hrETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB7099.namprd11.prod.outlook.com (2603:10b6:510:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 22:35:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 22:35:05 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAAb6AIABcWmAgAH3BYA=
Date:   Fri, 3 Mar 2023 22:35:05 +0000
Message-ID: <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
         <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
         <ZADQISkczejfgdoS@arm.com>
In-Reply-To: <ZADQISkczejfgdoS@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB7099:EE_
x-ms-office365-filtering-correlation-id: ef109c51-56a8-42b4-9aee-08db1c378966
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0rhwWXItS7E9GGhh+7fT+lSxmm8MQb5mPHc7K8lkilrN6MHUrFaUvb1hdAeV59S21haeTlPGII7lQUPhb7nn0QlthOFlA0uuMJmED+ftJ42MEujvosGhSAEp9OHHnxvZqo/aRY5eMfBK6N2zGHvTZr/UKn36lM3Pdt0G3hBjson3+ST2Z8868QNLE+WQsL/zqbD+bUAWdCJA6yxMyK4eUjOoHrT8li/EE7SqdJa8cEHPNCGerrAYEYvqAtZW5SVSTtpI9ygDoFSKFUuh0Q1Vg/dQSAomXG57upIDhaPMwNBF00MG1ePOPcnXeBhRUWBiP88InAxUBIc3B52/IoP58heWP4/3ntkQuBYc8Ip3z/ZWD6l+tHFkHbCJIqQmI8HUL+DAWdsDgfmdsRzPZPGRCnM54ZPuFBpq5Y25nQLZXorE8ziwr8SiI7qFym6Lhajx/t6qEo5S2WcYNUu/c4wZy1rcV1y1F58ciCQ49tf4Bm+wZ6F9x6TXYOke3DbczLbFEAKUkx/nwKPIYOrOdViORTlFigWS31FHDoFChvwZlQcedjU8QbYbUVMRPcKX8SMg+ILDZBUlA6RTwu6TcYc51U1F+wsASi+mySwfvf8mGsqwdkz0xolJ08az0E5yXBZofy3kMbr8WgpEJXFxRGBdvZyov1SFaZVQQtzzaX6ZuZe++4dLMao37Ox7dOYObhkgEPnu8E0zqWQ4fcZzOM50myKTBqyjZP18SfVTw2p9EL7/D0XjZdak0Zg+rWUqFyO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(86362001)(6512007)(6506007)(2616005)(36756003)(2906002)(6486002)(71200400001)(186003)(26005)(82960400001)(7406005)(7416002)(478600001)(5660300002)(38070700005)(110136005)(83380400001)(54906003)(4326008)(64756008)(91956017)(8676002)(66476007)(8936002)(921005)(66446008)(66556008)(76116006)(316002)(66946007)(122000001)(38100700002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0ExMmxPM29Vb2p4RXhFQ3FoQzQxdWhMZ1Q2K2hZV01ReVUxVnM3cGppRmJO?=
 =?utf-8?B?VEt1L3hJTStYYzNVeUFwOE52WlowcVBNRGRVdHRVRFZ0enIxc2ttRHdjUEVO?=
 =?utf-8?B?T21BMUk0czRxbFJ5Z0VVb3pUT3pwYXdNNXpEb0dzVWZXcVZPcXh1MXFwL3hP?=
 =?utf-8?B?cHRseG5zcnVGellWbHdPZjd4dTNOZ240YmFMUHpaejV3QVdjVVRCUzg4eGVz?=
 =?utf-8?B?Rk51RVZqeGJUQ3ZoUkFsSFljaFNZUUtuN1lZbUFoR0pqdzhWeVpkd1J2R1Zn?=
 =?utf-8?B?RVdwQ3k4Z29KSkVBVnJUNE1oeVljSGNRYjFNdURtaG5hUFVQS1pacFpJTWdx?=
 =?utf-8?B?YjBnR0pwMEhNRlVsVzZuTW5kb3U1US9FNUlHVmdXME1JMnZvUTVoY3VaV0hO?=
 =?utf-8?B?bFNhbEFpWHNDUDdsT1kxT09xUVdjeDdZNERocGw2cmdkYmx3elZKRzFyRWs1?=
 =?utf-8?B?TVNqMXd2eGdmYkxRSThYNDZBMkUvdXlLRWU4d3lqTGo0ZDNlU2srMkZmSnRD?=
 =?utf-8?B?OXIvVkJGNEgybC9wUVo0NTEwM2pkbEhQRTdwQnVXL2xSbkF3VWFWYS9yL0RW?=
 =?utf-8?B?bTAwTE1YaVVta3lpZE0wVDYwT2hiZFA4R2E3M0NUS0NqVk9CSkN2TTJrOFNv?=
 =?utf-8?B?bG1JcEdPaDNMNlN6LzVmRnBaQVB5bWYzM3pSMFhHbXZyei9EZDU4WkNEQ1R3?=
 =?utf-8?B?R0ZXamdVS3Nhem54M0EyT3ZxY0ZwRzM4dGxGbmpMNGRZVnZmV1ZqSWNXaXNx?=
 =?utf-8?B?Q1U5NWtteUpZVHpJYkw5Y2dNYU85dkpDNW5sMHZnQlVQYjFZQUJ2bkVrL0xw?=
 =?utf-8?B?dGI1U2V4NFRvNnYySkNzMzVRNjVFQXhQWElYc0NhQXhyaXVpZTJrUDhhc1Bh?=
 =?utf-8?B?U0lQdE1JeXlGR2I3MkJxMU5LdnNFZjV2d1dZSHlIYjg5TmROb1E0MEVOVXFo?=
 =?utf-8?B?R0NkdWp3TlhJaE9aZ0pNMEcvZnczSUdMK2JCVHV1c1ZVUWZMWmxncHU3eGxV?=
 =?utf-8?B?OTJBck1wS3Z3bGs3UnU2QkJKOVBvcENJWU1CTCs1bE5rb2lIN1lseE10TGRy?=
 =?utf-8?B?UXRSSXZXSks2Tk9zcWZxVVYxZkgzNWwvTWFJVmxRK2ROa2xZbjdJSWpzZTZD?=
 =?utf-8?B?ekovM1ZWL1p4V29PTXhETjVXUldTd0RhaWFuT1dUTks1VTNiMHlKSkpBUklL?=
 =?utf-8?B?aE5wTW8relBPK1VhOVVOZjNNeW13VC95NW8vZTRZQkMveFZlaldCWEl3bWZD?=
 =?utf-8?B?NlVNSHRZaCtPWWgveVRIZkY2K05JVzdjNytCOHJRM0hnRFJDOFNEK0E4WCto?=
 =?utf-8?B?SzlMeG4zRW1NbHdzYWlZNFZKWVoyTEdpWVBCSmpNNE1oM1REdjVOMVBIS0pD?=
 =?utf-8?B?QlpEcmVNRlVEYW80YW8yaDVDUTBxWW5pRC9WM0dJNXNwYzZrTCt2UzBHeWFE?=
 =?utf-8?B?WkNJdHNSanNJNzV5OWJwQTE1YWMxQWtldGpIR0RUUlFXcVRTV2VBaHhuenN1?=
 =?utf-8?B?cFIxMThKbmhVQU1odUc2djFyb01QTXZGcHZLOERlZ05ESVhncklpVS83N1pv?=
 =?utf-8?B?VU11RUp1N2tCK0ttYXg0RG1XU0NXQXQ3dmVJUFZDcitrdW5UQmkzL2N4UTJp?=
 =?utf-8?B?UGIwemJMNnJRMWM0VHpla1p5aklaaTE3ZTRyQWtYWjRzVnhITGxOd0ErcmU2?=
 =?utf-8?B?WUJETGdJeVZSU2RFby9RYzJhbG1lNUhreHJ2TitiUXMrU09SUGV0LzhCZ1hZ?=
 =?utf-8?B?RjQvSnZPaGtFdmo5NGpxY3pPQ0xjcXF3ejZvTVRGTXplNEFmWTJ2aXlDVjdU?=
 =?utf-8?B?TEN1M1g5QXRKdDJ1K0ptSGpKU2JMeFZOeCtKcnZWL2lxQk5UQUtrSGszdlM3?=
 =?utf-8?B?U3J2d3BWRDJsRCtDYzJobk1mSFd5cDFFUE02YlZ4aVZzMlVpM0Q0eENzaWpW?=
 =?utf-8?B?bWdLSFo5K1RwMEEvb2lYZUh3aG1tSHhVcGRPalFJTXYyM2lKM0VrRVllK29Z?=
 =?utf-8?B?MHRQdXk3eURuZzFOc0hFSkhxTENUUkc5eWlyVWJ2ZkRSRVJzSFBkK2NlSGZw?=
 =?utf-8?B?QU0xbUdleStSMnVacHVNM2svQ2ZsWnVOZ0RhQkZDVDltVTZqbXpSWjY5ZEpE?=
 =?utf-8?B?dCt1N2RwOHJqS0dqeUExS3RuZTAxaXhVTGRqZVZYYS9JQktDbmNKV3VqcmVN?=
 =?utf-8?Q?tRjAnrpflvANrfFpGk0h99U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B207F1088CCA854A8BAC0B14B1126471@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef109c51-56a8-42b4-9aee-08db1c378966
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 22:35:05.6726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyWJ9NZhisJmxneYCptTKwHFfMPkpF1uB9pYvL9n3vXF9jhoJ++Du68fk/nivofohUVp8TvPoCsKaxVljyMjuHsZYwrq4cNu9bcd3B8u7Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDE2OjM0ICswMDAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+ID4gQWx0ZXJuYXRpdmVseSwgdGhlIHRocmVhZCBzaGFkb3cgc3RhY2tzIGNvdWxk
IGdldCBhbiBhbHJlYWR5IHVzZWQNCj4gPiB0b2tlbg0KPiA+IHB1c2hlZCBhdCB0aGUgZW5kLCB0
byB0cnkgdG8gbWF0Y2ggd2hhdCBhbiBpbi11c2UgbWFwX3NoYWRvd19zdGFjaw0KPiA+IHNoYWRv
dyBzdGFjayB3b3VsZCBsb29rIGxpa2UuIFRoZW4gdGhlIGJhY2t0cmFjaW5nIGFsZ29yaXRobSBj
b3VsZA0KPiA+IGp1c3QNCj4gPiBsb29rIGZvciB0aGUgc2FtZSB0b2tlbiBpbiBib3RoIGNhc2Vz
LiBJdCBtaWdodCBnZXQgY29uZnVzZWQgaW4NCj4gPiBleG90aWMNCj4gPiBjYXNlcyBhbmQgbWlz
dGFrZSBhIHRva2VuIGluIHRoZSBtaWRkbGUgb2YgdGhlIHN0YWNrIGZvciB0aGUgZW5kIG9mDQo+
ID4gdGhlDQo+ID4gYWxsb2NhdGlvbiB0aG91Z2guIEhtbS4uLg0KPiANCj4gYSBiYWNrdHJhY2Vy
IHdvdWxkIHNlYXJjaCBmb3IgYW4gZW5kIHRva2VuIG9uIGFuIGFjdGl2ZSBzaGFkb3cNCj4gc3Rh
Y2suIGl0IHNob3VsZCBiZSBhYmxlIHRvIHNraXAgb3RoZXIgdG9rZW5zIHRoYXQgZG9uJ3Qgc2Vl
bQ0KPiB0byBiZSBjb2RlIGFkZHJlc3Nlcy4gdGhlIGVuZCB0b2tlbiBuZWVkcyB0byBiZSBpZGVu
dGlmaWFibGUNCj4gYW5kIG5vdCBicmVhayBzZWN1cml0eSBwcm9wZXJ0aWVzLiBpIHRoaW5rIGl0
J3MgZW5vdWdoIGlmIHRoZQ0KPiBiYWNrdHJhY2UgaXMgYmVzdCBlZmZvcnQgY29ycmVjdCwgdGhl
cmUgY2FuIGJlIGNvcm5lci1jYXNlcyB3aGVuDQo+IHNoYWRvdyBzdGFjayBpcyBkaWZmaWN1bHQg
dG8gaW50ZXJwcmV0LCBidXQgZS5nLiBhIHByb2ZpbGVyIGNhbg0KPiBzdGlsbCBtYWtlIGdvb2Qg
dXNlIG9mIHRoaXMgZmVhdHVyZS4NCg0KU28ganVzdCB0YWtpbmcgYSBsb29rIGF0IHRoaXMgYW5k
IHJlbWVtYmVyaW5nIHdlIHVzZWQgdG8gaGF2ZSBhbg0KYXJjaF9wcmN0bCgpIHRoYXQgcmV0dXJu
ZWQgdGhlIHRocmVhZCdzIHNoYWRvdyBzdGFjayBiYXNlIGFuZCBzaXplLg0KR2xpYmMgbmVlZGVk
IGl0LCBidXQgd2UgZm91bmQgYSB3YXkgYXJvdW5kIGFuZCBkcm9wcGVkIGl0LiBJZiB3ZSBhZGRl
ZA0Kc29tZXRoaW5nIGxpa2UgdGhhdCBiYWNrLCB0aGVuIGl0IGNvdWxkIGJlIHVzZWQgZm9yIGJh
Y2t0cmFjaW5nIGluIHRoZQ0KdHlwaWNhbCB0aHJlYWQgY2FzZSBhbmQgYWxzbyBwb3RlbnRpYWxs
eSBzaW1pbGFyIHRoaW5ncyB0byB3aGF0IGdsaWJjDQp3YXMgZG9pbmcuIFRoaXMgYWxzbyBzYXZl
cyB+OCBieXRlcyBwZXIgc2hhZG93IHN0YWNrIG92ZXIgYW4gZW5kLW9mLQ0Kc3RhY2sgbWFya2Vy
LCBzbyBpdCdzIGEgdGlueSBiaXQgYmV0dGVyIG9uIG1lbW9yeSB1c2UuDQoNCkZvciB0aGUgZW5k
LW9mLXN0YWNrLW1hcmtlciBzb2x1dGlvbjoNCkluIHRoZSBjYXNlIG9mIHRocmVhZCBzaGFkb3cg
c3RhY2tzLCBJJ20gbm90IHNlZWluZyBhbnkgaXNzdWVzIHRlc3RpbmcNCmFkZGluZyBtYXJrZXJz
IGF0IHRoZSBlbmQuIFNvIGFkZGluZyB0aGlzIG9uIHRvcCBvZiB0aGUgZXhpc3Rpbmcgc2VyaWVz
DQpmb3IganVzdCB0aHJlYWQgc2hhZG93IHN0YWNrcyBzZWVtcyBsb3dlciBwcm9iYWJpbGl0eSBv
ZiBpbXBhY3QNCnJlZ3Jlc3Npb24gd2lzZS4gRXNwZWNpYWxseSBpZiB3ZSBkbyBpdCBpbiB0aGUg
bmVhciB0ZXJtLg0KDQpGb3IgdWNvbnRleHQvbWFwX3NoYWRvd19zdGFjaywgZ2xpYmMgZXhwZWN0
cyBhIHRva2VuIHRvIGJlIGF0IHRoZSBzaXplDQpwYXNzZWQgaW4uIFNvIHdlIHdvdWxkIGVpdGhl
ciBoYXZlIHRvIGNyZWF0ZSBhIGxhcmdlciBhbGxvY2F0aW9uICh0bw0KaW5jbHVkZSB0aGUgbWFy
a2VyKSBvciBjcmVhdGUgYSBuZXcgbWFwX3NoYWRvd19zdGFjayBmbGFnIHRvIGRvIHRoaXMNCihp
dCB3YXMgZXhwZWN0ZWQgdGhhdCB0aGVyZSBtaWdodCBiZSBuZXcgdHlwZXMgb2YgaW5pdGlhbCBz
aGFkb3cgc3RhY2sNCmRhdGEgdGhhdCB0aGUga2VybmVsIG1pZ2h0IG5lZWQgdG8gY3JlYXRlKS4g
SXQgaXMgYWxzbyBwb3NzaWJsZSB0byBwYXNzDQphIG5vbi1wYWdlIGFsaWduZWQgc2l6ZSBhbmQg
Z2V0IHplcm8ncyBhdCB0aGUgZW5kIG9mIHRoZSBhbGxvY2F0aW9uLiBJbg0KZmFjdCBnbGliYyBk
b2VzIHRoaXMgdG9kYXkgaW4gdGhlIGNvbW1vbiBjYXNlLiBTbyB0aGF0IGlzIGFsc28gYW4NCm9w
dGlvbi4NCg0KSSB0aGluayBJIHNsaWdodGx5IHByZWZlciB0aGUgZm9ybWVyIGFyY2hfcHJjdGwo
KSBiYXNlZCBzb2x1dGlvbiBmb3IgYQ0KZmV3IHJlYXNvbnM6DQogLSBXaGVuIHlvdSBuZWVkIHRv
IGZpbmQgdGhlIHN0YXJ0IG9yIGVuZCBvZiB0aGUgc2hhZG93IHN0YWNrIGNhbiB5b3UNCmNhbiBq
dXN0IGFzayBmb3IgaXQgaW5zdGVhZCBvZiBzZWFyY2hpbmcuIEl0IGNhbiBiZSBmYXN0ZXIgYW5k
IHNpbXBsZXIuDQogLSBJdCBzYXZlcyA4IGJ5dGVzIG9mIG1lbW9yeSBwZXIgc2hhZG93IHN0YWNr
Lg0KDQpJZiB0aGlzIHR1cm5zIG91dCB0byBiZSB3cm9uZyBhbmQgd2Ugd2FudCB0byBkbyB0aGUg
bWFya2VyIHNvbHV0aW9uDQptdWNoIGxhdGVyIGF0IHNvbWUgcG9pbnQsIHRoZSBzYWZlc3Qgb3B0
aW9uIHdvdWxkIHByb2JhYmx5IGJlIHRvIGNyZWF0ZQ0KbmV3IGZsYWdzLg0KDQpCdXQganVzdCBk
aXNjdXNzaW5nIHRoaXMgd2l0aCBISiwgY2FuIHlvdSBzaGFyZSBtb3JlIG9uIHdoYXQgdGhlIHVz
YWdlDQppcz8gTGlrZSB3aGljaCBiYWNrdHJhY2luZyBvcGVyYXRpb24gc3BlY2lmaWNhbGx5IG5l
ZWRzIHRoZSBtYXJrZXI/IEhvdw0KbXVjaCBkb2VzIGl0IGNhcmUgYWJvdXQgdGhlIHVjb250ZXh0
IGNhc2U/DQo=
