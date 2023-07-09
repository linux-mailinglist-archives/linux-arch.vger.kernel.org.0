Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2E74C62C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jul 2023 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjGIP3J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jul 2023 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjGIP2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2023 11:28:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289A10D4;
        Sun,  9 Jul 2023 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688916422; x=1720452422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P5yWJo2u6/BL5HHHHk0Y4hIaRMuhhCmXhjWnF7TCzsU=;
  b=B2TFI+U93n6Sa5fD0QSFDu7L0Wb0pkRVc+Ja5kE2PGyT9qfxsCeKTvht
   +08DLcIvN+VSUn3LxKb60Tr4eI3CJOQkMTjMvq6+9y44ZOEO9APDORMp/
   J2Esjwwz1BUXPk399DDC4CKQDP5TYjAOJnCbytl/0WRf8A2pwLw4Gy9G6
   321WRSGgnGKzvhemeG/bfP3LsiDipDbrffYzQ7cXCwBOxyJw3VkStDBJT
   JR7nTu3ziKYM6vZNWwsLMT/JZum9Fl+T0qd8gGKRyzFbaJlyONRP1H3Hg
   jGRBDHZcka78Z0mz6hTnByHqAFZUvsYXBSRb3L9HhYJJ2Zyzi/KynOVJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="367671415"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="367671415"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 08:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810572070"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="810572070"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2023 08:25:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 08:25:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 08:25:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 9 Jul 2023 08:25:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 9 Jul 2023 08:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELvp3wuUazVH4Iay9Pu/ivrzDnSl7xz5OOzHebYkyae+36gsVXbUuiL7bJO4A00wCpF88mGNYMhe9NtWaYmzAhbf3PF/OO/a0Eh8BO3DCdZMoA3tkMg3m8UvrO9YvfhcZp+FwO1VjGONCuJ0tH3qTbIg4lBflWE0AwSRgpWwz85qHXKBdeN4k0iLPECmyy1osPU+vMqSGR3WTLt4vGf0ojk/3MXcQONIiF0R+6HiRAz0xe2IIChPO6O7FgAKEY/rTz8a2a2F7EKVkXv3WAg1J1L/gk6cCTbEUVdocWPT7B3l8tl10TuGHmzfL0ZTNBr/lISxiUTnTZ3ymeY69zs68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5yWJo2u6/BL5HHHHk0Y4hIaRMuhhCmXhjWnF7TCzsU=;
 b=mP6ljcAeUbEPdkA1ll1i2oJELQYF9UkWpWaitW/afyn3cnK5Bql+LotHdvJciok/LBmsM/8XEAvI9ErK4uiRD+d48k4KnZeHUABzpiYAdey8Ile0cYwycSy8LbWI1qfcXa5QR+W06U/Fru3sWoI/cp76heWS2GyA9nNV8Cw8BrB8k1u3zKhN7jVlkgacHALq/KAjhl/6vEjiGW+bRjRZrcHnjiBWH0++S2OFTCKUADW0poNlCqUTAZqVrgyNIVlzFYaf4L2NKFf3Zqps7Q4yeIwa+6w3jgb7kyaL5cRqa9fno/PnP0p8v+l01VcVRv7okStXWYnNQMye5ZwAGay0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7262.namprd11.prod.outlook.com (2603:10b6:8:13c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sun, 9 Jul
 2023 15:25:50 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9932:938f:1d21:93cb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9932:938f:1d21:93cb%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 15:25:50 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>
CC:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
Thread-Topic: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
Thread-Index: AQHZr1BM9gzmeFoLCkCaGIrrlOZu8K+xlKUA
Date:   Sun, 9 Jul 2023 15:25:50 +0000
Message-ID: <c66e3e800a7d257ef7a90749fe567f056f4c3ace.camel@intel.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7262:EE_
x-ms-office365-filtering-correlation-id: bf3fbbee-aea8-48df-70e1-08db8090c6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ge6QePWwSviZHhCOYj7XG5Il0LR5QQrEwoojwZ2Zy9TfZ/7UWu3Toa+8YozEcC2EJRPZtb+khb9jrsWwXynEaVYhpqlI5mtgzsi/nfkTEXNoVOhhRsar33xM8LcaFaRbHqiwoqSvHB74XeQh5VKHyn/5RhhQT0TGBmhFCiO22/weDpucb5w8GmC47lRfOwEpBXq7jOA0SAOszNAzullMP2dkVS9+YIzpUGWYEpCGpbJiPyYK1MnPmih9Lqrq9i0Qndf/Tr+5TCMtiQvrKRudR1QPNOyduH60NZvnCX4u6xDDp1WKqjzz+2E8TALyQPFb3KMfddBmDO3BXxUN7Q3WGtAjOiD65+OeA8z7OZhvH/w8lzqUHLZ9T/HfYGkx0oG6hsZJIwUcrxXeJd6Zf7MlX7w6rEn3KTXtToqwIhhvfPF/5/w3wElw13Q5zrkzBd4KEZo2BdqXhQXgik6+qHbttFcjPDsglxCNkBQMUZL1yfrapMhtf1BmzT5ABG4vJYeU095EOtba3wk6hBZfYx+BGKBCO64Lbvy051lpee8nvMC7VxWQuC3mwiQt19ralQUFtsgBggsukUxdFhFG2kKC8OnVQukem+FBMIVxLcnT/BijOO2QIYh7FHjNDOGfYo1xuUuK+qnI2eO2vhKBeHvKvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(186003)(6506007)(26005)(966005)(6512007)(2616005)(83380400001)(4326008)(41300700001)(2906002)(66556008)(7416002)(316002)(8936002)(64756008)(5660300002)(8676002)(66476007)(66446008)(6486002)(54906003)(478600001)(76116006)(91956017)(66946007)(110136005)(71200400001)(36756003)(122000001)(82960400001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THZqMW8yUHV2V2xRZHo3cHZKZzVLWTlNU1Q3NzBueFpHRGIxMnoxY0k4dlZj?=
 =?utf-8?B?Wlc5bVFySXNJdVpteVVIUnM1cXdRM2Naa2ZtU3d3TlExcGJCMFFNVVptOUsz?=
 =?utf-8?B?R3ZpUWlkL1pxcnU2Qk5rSUQrcWNXd0g1RnBhNjNGUE5RVGFGYzF6ajcyVWR6?=
 =?utf-8?B?M2REa2Q1T2piajdDRDh4RUdIM0w0UjBadVhJSUFWekVKYTU0V1F3dlFNZjM0?=
 =?utf-8?B?cHRxc0xNMEdKaURxR3NaT1loUWQwb2FDNk9CR0lkV09VVmFvdEwrclc1L2ZK?=
 =?utf-8?B?Uyt1WUNrMmJrak5XOWtGYlRhalRvd0JlR0pSQ3N4bXFXbUhlSnczTVErRFcx?=
 =?utf-8?B?by9NczYvWnhnZE9OM2pCUmxMUHZLVHhWMGNRaUdCK1JmaW1vMkRlaEdLSWs3?=
 =?utf-8?B?dlVDb1RKTDlienEzdko4VExxVjlJRXBDRlBtUUNuUnFueGlpT05ZT1lzY0V4?=
 =?utf-8?B?YlhNT1NibnlscmIyVElIMkpnZEM2OEphdWd4aVcxZkRnSU5WdjdvWkRRdk4x?=
 =?utf-8?B?VlEySXBQK3pPOHNJazJraVA4aWNXQXF1aldCT082U2trMWxrVlNwQWpiSUFj?=
 =?utf-8?B?LzJsSWVZZVNuWURLOE1DR2hzOTVXWFh2dGYwZmEweUFsYTNNdW1LSnlFazQy?=
 =?utf-8?B?dmJkQ2hTbS9DQlpNVC9wdXJsTkJkYmFibUV5SEFrOG0vY1p2V1o0eXNtL3FL?=
 =?utf-8?B?SlBSN0JxV0JUbjk0SWs5cjNncDBvSjVBSkNuQTVISlRxYUp0SUFPSHlDeThE?=
 =?utf-8?B?Q0JuVDlKV2wxWWwwb0ZwYUl0QnF4dGk0cXk2a3lpdmxVZ2ZUUTdvaEJvVWM3?=
 =?utf-8?B?SlBQQU5Oa2JJWk1lOVRxeTRFTnYvNFlza1hCTzlFcGxmbTNhWkhNSGU5Y1pq?=
 =?utf-8?B?RlVvQW1CcXN3UXRIRHhEeEFzWTJFQjZPRWNOM3hQU2cvenVzN21aT3FlQkFC?=
 =?utf-8?B?REMySkxRN0tDYjYyamU2MHBOVnJCVk1YT294Z0xUdmh1TEVuVkFSYnVyZ3BR?=
 =?utf-8?B?Wm02bUxLMXBQbVIxSEQ2Y2hkOHdncGIyK3RNOTQwaWVTZGVpaFNJSUZyK2Ur?=
 =?utf-8?B?TVlyYjJWRVhtNFlVbmM3eWd6T1hxOUM0WjgxcFU2Ly9ETE0wRElObXM4RW9a?=
 =?utf-8?B?MDZ0c3BXaStjdWZlZ1Y3OTA2TE03cStGa1o1dUtLeHUrQ3FibW92NndRTmRv?=
 =?utf-8?B?enI3RjlzWmVLUU5CdVVNVVhqZ3Frc1I5OGY3Mi8vNDBQdTFPNkdmRmJodER5?=
 =?utf-8?B?cTg5Um5USWdBcTcyRnhkc1NnSm45Q0VsemxFZU1UeVNKeDVWS1RlVDN1YXBH?=
 =?utf-8?B?TTlibUg4L3RPZGJjcGF6WWZVZ3huWnRFL1V3UVdIQ241V0hwRjFBbEJtVitY?=
 =?utf-8?B?WjN4TjYzSXEwblJMZ0FtcVZpYzdQK2lDRW5GbWUxWnluaS91emtWMkRicmRR?=
 =?utf-8?B?S0JOdzhuZ1hFUmJWUGs0UkNYd0VxZ3MwWmNFOVVuOC94ZXNtRmtsRmhmb3Bi?=
 =?utf-8?B?Y28wdUE2dHhOUlR1bEFNYm00UmFqcEpaQVBJejFTNUhmSHBDdzU3bmFUNVpY?=
 =?utf-8?B?TjlNNjVGYnlQUTVzNHc4ejg0OVE1K29KRHhOb1FJQmNUQ1FvS3hHMlpsbjRH?=
 =?utf-8?B?TTBhRmxRbFcwdjQ2aURZWEt1eEp1S0xtNDdrenhVWW5kbHhJWFdiRHE2TTho?=
 =?utf-8?B?Z2VUZFZpMjBISTlyeHJUQlo3algvNTJsQ3hBL09nZXQzdXZiaUxDelJ4bVRn?=
 =?utf-8?B?NDdYbm8vWjNNa01Vdm52eXNRTURieW03K0xqVHFQZTNhOUd6RGVZV3YrTFFu?=
 =?utf-8?B?TnNLcFJldk95VG1LMTZYTDBUdGZiOG84UXovd2pjSjB1UTF2aVN0MHc1dGJz?=
 =?utf-8?B?Vk9wcDhNUmZSb2k1bDZFQ0xhSXRCSXRrcGZnMlBIOG80REVGSnFianZLUnV2?=
 =?utf-8?B?dGVCdmZlSEFLaElITXpvc0dEM2hWRkNXUmx4c1FiSWVDTmZmY2wwZlJRVTZX?=
 =?utf-8?B?aDNlOTNSVjNhVHBxT0tRaDd2RU9uZkNUNE9rNmNPM2xVeGo2WG54YytjZTRq?=
 =?utf-8?B?TGI1Nm5Xb25zOERBNGcyQ2JxQXVtWjB1dkxNczBZSDJvc25SS281aldYUHQr?=
 =?utf-8?B?Yk9zUityUEFhVmlhR0NTcGtUWk8wbFRGZGFmcWVNQnZFSHBnNzgvTzRLY2Fz?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B82AC1B5E95CC45ADDF922A8B434F37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3fbbee-aea8-48df-70e1-08db8090c6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 15:25:50.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1D6idXSJj1jvVIIXOgbGhyFrgq8dpEI10WcbpsW5fQGGSfO+R6y31oeI7ziiihXgXGmTaf10muPNv5UlY6X7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksIExhdXJlbnQsDQoNCkkgcmFuIGludG8gYSBib290IGhhbmcgcmVncmVzc2lvbiB3aXRoIGxh
dGVzdCB1cHN0cmVhbSBjb2RlLCBhbmQgaXQNCnRvb2sgbWUgYSB3aGlsZSB0byBiaXNlY3QgdGhl
IG9mZmVuZGluZyBjb21taXQgYW5kIHdvcmthcm91bmQgaXQuDQoNCk5vdyBJIGhhdmUgdGVzdGVk
IHRoaXMgcGF0Y2ggc2VyaWVzIG9uIGFuIEludGVsIFJhcHRvckxha2UgSHlicmlkDQpwbGF0Zm9y
bSAoNCBQY29yZXMgd2l0aCBIVCBhbmQgNCBFY29yZXMgd2l0aG91dCBIVCksIGFuZCBpdCB3b3Jr
cyBhcw0KZXhwZWN0ZWQuDQoNClNvLCBmb3IgcGF0Y2ggMX43IGluIHRoaXMgc2VyaWVzLA0KDQpU
ZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVp
DQoNCk9uIFdlZCwgMjAyMy0wNy0wNSBhdCAxNjo1MSArMDIwMCwgTGF1cmVudCBEdWZvdXIgd3Jv
dGU6DQo+IEknbSB0YWtpbmcgb3ZlciB0aGUgc2VyaWVzIE1pY2hhZWwgc2VudCBwcmV2aW91c2x5
IFsxXSB3aGljaCBpcw0KPiBzbWFydGx5DQo+IHJldmlld2luZyB0aGUgaW5pdGlhbCBzZXJpZXMg
SSBzZW50IFsyXS7CoCBUaGlzIHNlcmllcyBpcyBhZGRyZXNzaW5nDQo+IHRoZQ0KPiBjb21tZW50
cyBzZW50IGJ5IFRob21hcyBhbmQgbWUgb24gdGhlIE1pY2hhZWwncyBvbmUuDQo+IA0KPiBIZXJl
IGlzIGEgc2hvcnQgaW50cm9kdWN0aW9uIHRvIHRoZSBpc3N1ZSB0aGlzIHNlcmllcyBpcyBhZGRy
ZXNzaW5nOg0KPiANCj4gV2hlbiBhIG5ldyBDUFUgaXMgYWRkZWQsIHRoZSBrZXJuZWwgaXMgYWN0
aXZhdGluZyBhbGwgaXRzIHRocmVhZHMuDQo+IFRoaXMNCj4gbGVhZHMgdG8gd2VpcmQsIGJ1dCBm
dW5jdGlvbmFsLCByZXN1bHQgd2hlbiBhZGRpbmcgQ1BVIG9uIGEgU01UIDQNCj4gc3lzdGVtDQo+
IGZvciBpbnN0YW5jZS4NCj4gDQo+IEhlcmUgdGhlIG5ld2x5IGFkZGVkIENQVSAxIGhhcyA4IHRo
cmVhZHMgd2hpbGUgdGhlIG90aGVyIG9uZSBoYXMgNA0KPiB0aHJlYWRzDQo+IGFjdGl2ZSAoc3lz
dGVtIGhhcyBiZWVuIGJvb3RlZCB3aXRoIHRoZSAnc210LWVuYWJsZWQ9NCcga2VybmVsDQo+IG9w
dGlvbik6DQo+IA0KPiBsdGNkZW4zLWxwMTI6fiAjIHBwYzY0X2NwdSAtLWluZm8NCj4gQ29yZcKg
wqAgMDrCoMKgwqAgMCrCoMKgwqAgMSrCoMKgwqAgMirCoMKgwqAgMyrCoMKgwqAgNMKgwqDCoMKg
IDXCoMKgwqDCoCA2wqDCoMKgwqAgNw0KPiBDb3JlwqDCoCAxOsKgwqDCoCA4KsKgwqDCoCA5KsKg
wqAgMTAqwqDCoCAxMSrCoMKgIDEyKsKgwqAgMTMqwqDCoCAxNCrCoMKgIDE1Kg0KPiANCj4gVGhp
cyBtaXhlZCBTTVQgbGV2ZWwgbWF5IGNvbmZ1c2VkIGVuZCB1c2VycyBhbmQvb3Igc29tZSBhcHBs
aWNhdGlvbnMuDQo+IA0KPiBUaGVyZSBpcyBubyBTTVQgbGV2ZWwgcmVjb3JkZWQgaW4gdGhlIGtl
cm5lbCAoY29tbW9uIGNvZGUpLCBuZWl0aGVyDQo+IGluIHVzZXINCj4gc3BhY2UsIGFzIGZhciBh
cyBJIGtub3cuIFN1Y2ggYSBsZXZlbCBpcyBoZWxwZnVsIHdoZW4gYWRkaW5nIG5ldyBDUFUNCj4g
b3INCj4gd2hlbiBvcHRpbWl6aW5nIHRoZSBlbmVyZ3kgZWZmaWNpZW5jeSAod2hlbiByZWFjdGl2
YXRpbmcgQ1BVcykuDQo+IA0KPiBXaGVuIFNNUCBhbmQgSE9UUExVR19TTVQgYXJlIGRlZmluZWQs
IHRoaXMgc2VyaWVzIGlzIGFkZGluZyBhIG5ldyBTTVQNCj4gbGV2ZWwNCj4gKGNwdV9zbXRfbnVt
X3RocmVhZHMpIGFuZCBmZXcgY2FsbGJhY2tzIGFsbG93aW5nIHRoZSBhcmNoaXRlY3R1cmUNCj4g
Y29kZSB0bw0KPiBmaW5lIGNvbnRyb2wgdGhpcyB2YWx1ZSwgc2V0dGluZyBhIG1heCBhbmQgYSAi
YXQgYm9vdCIgbGV2ZWwsIGFuZA0KPiBjb250cm9saW5nIHdoZXRoZXIgYSB0aHJlYWQgc2hvdWxk
IGJlIG9ubGluZWQgb3Igbm90Lg0KPiANCj4gdjQ6DQo+IMKgIFJlYmFzZSBvbiB0b3Agb2YgNi41
J3MgdXBkYXRlcw0KPiDCoCBSZW1vdmUgYSBkZXBlbmRhbmN5IGFnYWluc3QgdGhlIFg4NidzIHN5
bWJvbA0KPiBjcHVfcHJpbWFyeV90aHJlYWRfbWFzaw0KPiB2MzoNCj4gwqAgRml4IGEgYnVpbGQg
ZXJyb3IgaW4gdGhlIHBhdGNoIDYvOQ0KPiB2MjoNCj4gwqAgQXMgVGhvbWFzIHN1Z2dlc3RlZCwN
Cj4gwqDCoMKgIFJld29yZCBzb21lIGNvbW1pdCdzIGRlc2NyaXB0aW9uDQo+IMKgwqDCoCBSZW1v
dmUgdG9wb2xvZ3lfc210X3N1cHBvcnRlZCgpDQo+IMKgwqDCoCBSZW1vdmUgdG9wb2xvZ3lfc210
X3RocmVhZHNfc3VwcG9ydGVkKCkNCj4gwqDCoMKgIEludHJvZHVjZSBDT05GSUdfU01UX05VTV9U
SFJFQURTX0RZTkFNSUMNCj4gwqDCoMKgIFJlbW92ZSBzd2l0Y2goKSBpbiBfX3N0b3JlX3NtdF9j
b250cm9sKCkNCj4gwqAgVXBkYXRlIGtlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiANCj4gWzFdDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4cHBjLWRldi8yMDIzMDUyNDE1NTYzMC43OTQ1
ODQtMS1tcGVAZWxsZXJtYW4uaWQuYXUvDQo+IFsyXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eHBwYy1kZXYvMjAyMzAzMzExNTM5MDUuMzE2OTgtMS1sZHVmb3VyQGxpbnV4LmlibS5j
b20vDQo+IA0KPiANCj4gTGF1cmVudCBEdWZvdXIgKDIpOg0KPiDCoCBjcHUvaG90cGx1ZzogcmVt
b3ZlIGRlcGVuZGFuY3kgYWdhaW5zdCBjcHVfcHJpbWFyeV90aHJlYWRfbWFzaw0KPiDCoCBjcHUv
U01UOiBSZW1vdmUgdG9wb2xvZ3lfc210X3N1cHBvcnRlZCgpDQo+IA0KPiBNaWNoYWVsIEVsbGVy
bWFuICg4KToNCj4gwqAgY3B1L1NNVDogTW92ZSBTTVQgcHJvdG90eXBlcyBpbnRvIGNwdV9zbXQu
aA0KPiDCoCBjcHUvU01UOiBNb3ZlIHNtdC9jb250cm9sIHNpbXBsZSBleGl0IGNhc2VzIGVhcmxp
ZXINCj4gwqAgY3B1L1NNVDogU3RvcmUgdGhlIGN1cnJlbnQvbWF4IG51bWJlciBvZiB0aHJlYWRz
DQo+IMKgIGNwdS9TTVQ6IENyZWF0ZSB0b3BvbG9neV9zbXRfdGhyZWFkX2FsbG93ZWQoKQ0KPiDC
oCBjcHUvU01UOiBBbGxvdyBlbmFibGluZyBwYXJ0aWFsIFNNVCBzdGF0ZXMgdmlhIHN5c2ZzDQo+
IMKgIHBvd2VycGMvcHNlcmllczogSW5pdGlhbGlzZSBDUFUgaG90cGx1ZyBjYWxsYmFja3MgZWFy
bGllcg0KPiDCoCBwb3dlcnBjOiBBZGQgSE9UUExVR19TTVQgc3VwcG9ydA0KPiDCoCBwb3dlcnBj
L3BzZXJpZXM6IEhvbm91ciBjdXJyZW50IFNNVCBzdGF0ZSB3aGVuIERMUEFSIG9ubGluaW5nIENQ
VXMNCj4gDQo+IMKgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdcKgwqDC
oMKgwqAgfMKgwqAgMSArDQo+IMKgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPiDCoGFyY2gvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAzICsNCj4gwqBhcmNoL3Bvd2VycGMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPiDCoGFyY2gvcG93ZXJwYy9p
bmNsdWRlL2FzbS90b3BvbG9neS5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE1ICsrDQo+IMKg
YXJjaC9wb3dlcnBjL2tlcm5lbC9zbXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgOCArLQ0KPiDCoGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9o
b3RwbHVnLWNwdS5jwqAgfMKgIDMwICsrLS0NCj4gwqBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bz
ZXJpZXMvcHNlcmllcy5owqDCoMKgwqDCoCB8wqDCoCAyICsNCj4gwqBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3BzZXJpZXMvc2V0dXAuY8KgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPiDCoGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDQgKy0NCj4gwqBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+IMKgYXJjaC94ODYva2VybmVsL3NtcGJv
b3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCAtDQo+
IMKgaW5jbHVkZS9saW51eC9jcHUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI1ICstLQ0KPiDCoGluY2x1ZGUvbGludXgvY3B1X3NtdC5o
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMzICsrKysN
Cj4gwqBrZXJuZWwvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNDIgKysrKysrKysrKysrKy0tLQ0KPiAtLQ0K
PiDCoDE1IGZpbGVzIGNoYW5nZWQsIDE5NiBpbnNlcnRpb25zKCspLCA4NSBkZWxldGlvbnMoLSkN
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9jcHVfc210LmgNCj4gDQoNCg==
