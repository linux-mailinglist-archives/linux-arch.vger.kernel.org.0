Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F46B1296
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCHUD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 15:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCHUD0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 15:03:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C861AA5;
        Wed,  8 Mar 2023 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678305803; x=1709841803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N63+jQiu9QkWzU+PkZbw2kvy5W3NUO8k+6ELjZB8yeY=;
  b=YioaWq1BH6V51hDvqEPszTKHCOcwOXLvnfPZpvmlb3YLGeEt90xtrWQW
   RVJxAxid9HJTJzhR01Zp5AiEHliLD9WOYsnaF9o0Fh5A+QVfoiO9MjTg3
   lydU9YA28EN8wm0jQfRMOsmtyhuTUFzYnpCmuiIVJMGC28MX4ChvboEjo
   s5VM089ggghneMQ3NA+OpG5JbiCP4MkRwJ7TuYBTlvAkUEOGe8fGh8Ktm
   AeVgB238j6bk5JF0rbKuEQ+TJ6BXE9qo7p2YBFWrhQsRFAeWrux1PWL3e
   34I3ZsEFMOsyiD39dHJyC6FJj5Mc2mIAuWTNdtTy3OSl238OS9P09Jnvp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="334967508"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="334967508"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 12:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851245933"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851245933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 12:03:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 12:03:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 12:03:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 12:03:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsWdkEZ9bmMTott4a35JEe8QvniKz/mJh9ogHt8kr7mMDgLA298pmg5ERalcZFjsDlTl7yYn7P8b4cAH+padY45keJEPWHHDx/6lgvuxkckGKZqxNqtPOVUcKrpTQcaVj9wI1d6wzv6cjMQXLKWUh+W6sOLoObgXln0H7WhgFgPIp1etKtOgGpuJUQ6xjWxeSRJVC7UBEtjGZt5p2V/qr5GI7sNEDRMErno9ntuaYXpTWGKHSrB2qWdIgS+6rAknPVe+p2zMwdTOprFuofCCJvRO8v9gcQw6ZMSvZoOOT7TZWIS4G2DBB/zDM2mdxtMAeAi9e/4xOH+ztME93b6cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N63+jQiu9QkWzU+PkZbw2kvy5W3NUO8k+6ELjZB8yeY=;
 b=dp07nWyTxW1310MYfNL8qD22KtVAxyiLb8se2cHvD+U0TJk2r2PHpfz1yD6BVYKsw+yzbUymOBtz2AcEai/92jg/VXcIndgrLf2G5H3MJvFGuGeBepDSTbYs6vmJNH40XgPjhYjAid1LBoII6Kyb+oZkpBdemP3Fs+kgwa+3GZmt2ao/wTRjo57kuSw9tmlDtnlri0dIn49MhnHsf8aUjq6h/utqwJpyvqbMNn9FwLmcNS3KJYG7iTBVAka1F36nzkvxqRqG1W8RI2Dowa9fCrXRI+5ydVsYbOuTUpv+hxB6WS+904gcIR0Sl/LtQdWExRlat32a7ct1Zxl43YHQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 20:03:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 20:03:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Index: AQHZSvtG+2WnM2cLTkqogSV10ayPpq7xDpwAgABNdwA=
Date:   Wed, 8 Mar 2023 20:03:17 +0000
Message-ID: <d4d472e2e44787eccfbcc693bdf338370013f8a9.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-31-rick.p.edgecombe@intel.com>
         <ZAipCNBCtPA2bcck@zn.tnic>
In-Reply-To: <ZAipCNBCtPA2bcck@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6241:EE_
x-ms-office365-filtering-correlation-id: 3647ac67-72f6-4278-a7f8-08db2010289d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7iqwLJyKpHwPXORAmFCNONx1VBDOGFHJtvKF5vsbb9Klkvzm3VPAMgQUQWtXM8dHj3szisb53lbthKYDiqdV7BFBWkmlOChGlqeGqc2XPMmD/NJGPM/SwwEfb6EhqnQ8PbYbQXEYrvalbDlncpy2qQ9EbfkuTtnmKeGMJbQddHQsNCTprf9am34MLNiThMuEShlrwKoKM852mTvG0zY01VH9OyDUHOK+hOGcLA/pT3Fsr5IwN0hoblZ31T1GvAO82ml1anz88o1vxUmnh0sggrF8+JabBxO+OhGDJGkz18Yqtk/Yc5+bv0WIyQ1sqUOMVp6S24VADLBGerlLYmylZvuVhkXFZHzzLTRElK2IcAz6DuFfIjr0gPqigskUDo3XfIlAuv44q/XKWwaqNu3D5hFf6ZMAum0fJSOeqSVCcHG5BZnpBjwe+/7ISFT0BYXc9kdz5LrkisG76NIQFe72i6CQOAUgRnPo93txq+nf0i/Odu0x2NhA+pfru5Y0q4fVTgrxLnE/4LsLDZMUi/WKcaopfIoQsrR9e+IeqwyyqhWdTZxCdyNMvU5rXilj+dXoV6hUUUPNKflb5zfB0sL7GfqOI1QCAe09SiS6O4bz6xaigpCzwdA4h/Hv+JdS8czad4GTTQvLxxu4Nii7lXoIDeZHeYYZnHOdsaDPlDIXbkzg6Bdsy9zw72TB/TFZliXoCt2V6ZPYJjCkkxVTIFurrzTxqhF92jhFD+ENUG7kaI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(36756003)(316002)(54906003)(478600001)(6486002)(7406005)(8936002)(5660300002)(71200400001)(4326008)(66556008)(7416002)(91956017)(8676002)(66476007)(76116006)(6916009)(66446008)(64756008)(66946007)(2906002)(82960400001)(122000001)(186003)(6506007)(38070700005)(38100700002)(86362001)(2616005)(26005)(41300700001)(6512007)(83380400001)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDFpMnRKM3l2b29icFVreFJmV0RUb1FBQlRwVDZKUHFJOVZWVnJGTE9sYk1W?=
 =?utf-8?B?L2prRFdLYkRBY1IvdE1UMkdpaXFMeG45Z25DeWVnQjVGbzM1TGdEdnRraGQx?=
 =?utf-8?B?UnVZa1B2NFhHRDl5RzRVOUQ5UUZKazBSOEp3SWhtb2VBeFNPQ0lYUFpYcTR5?=
 =?utf-8?B?bUlxSk9HTFI3VlhIMXR1NkQwQnlVOU5xRGdraHNEYkVnc1hDSTVPRjMxbzNn?=
 =?utf-8?B?a2NzMFRxZVBXTWhhYXpHSWoybXgxcG53S3VXeGFKSm4zZmFTSHBsS0s3eTVi?=
 =?utf-8?B?cENCYlBWcVdtY1o5ZGV2MVRZMFFRQ2w5QWwxeWZXaW5GbTZybEt3ek9mOGVQ?=
 =?utf-8?B?RTJSS3RlWHhTZmo3LzFXSFMxZTloWGtNNTVOckFYbTZGd2NYL0tDbGJHRHlW?=
 =?utf-8?B?aERSTjQ3RU9iR0IxWkFiNlZWR3hlK3RTM2w2ZG9SWjNOMTVtRGhKZVpZbUhm?=
 =?utf-8?B?aXcvRE5KWFdENkJ1L1d6RzhQTDg3cHMxY2ZWNVR0eHpxUktlRUt3bjRCYlRL?=
 =?utf-8?B?TktrbGo1WDhLWDBjOERZajA2R3liNlM5NWJEenlDcE9DR1VtWVpoVXJKMWZ6?=
 =?utf-8?B?dVJXVTRjV05Hb05DUWlVWDFJeWgwOXREWTVGclA2U3o0Q3FRdk1mUzZMWGNZ?=
 =?utf-8?B?R0owMnY0U0lDdmdleUJER3ZHTmxyOC81UmZlZ1RsT0FqTmZlZ0JJa2FJOFMw?=
 =?utf-8?B?V2J6R1p2b3B4cnFNL09tMCt1OVJ4a0NFYjhJZ2p1WVBsTUxsVmJ5RCtPTlkr?=
 =?utf-8?B?ai9XSlRzSnRnVWhzZ1FQOE5wT1R3am9aZTZxbjY0ZzJvNlBzcVFxUEp6eS9L?=
 =?utf-8?B?ZFViak0waVpRc3JQZ2FnQTRjTXduYmVjb2tML2lXbGVWTzZ5VTdUSm8wNlQy?=
 =?utf-8?B?SkdUYTBTZWd2ekRFUDRuZjVJNEVxTmZRSWRZV0ZxaUdKTkRLblY4S29TZE5D?=
 =?utf-8?B?c2hNbWVzd3pkSW1wcEQxeXV1RWcwcms2UldrOG95K2VXRE0wYUluRE5JYTdv?=
 =?utf-8?B?ekRPakFzTUJ0RjdybG1YeEg0dkM3NnZDYjZtalM0Z1pLcU5IZEJiMk11Yk1a?=
 =?utf-8?B?QUJkbFVVdjY2M0c0NlhSdjhrWUJyeUVjc09Vc3JKcG5qbm9oRlRYK20xcEhp?=
 =?utf-8?B?VURSd2w2S0o1ejNseVUxZXJNUUhxaERjSCtIRHdKd1dHN3lPcHBsb3REYmZ4?=
 =?utf-8?B?cjlOazNzTXNDQWhFcU5IZ280c0lxZ1lLQ0hlRTZpdVZPQzlBQ2NOcW8rNjNQ?=
 =?utf-8?B?NmZELzdKNHloT1grTkxIdHovejhPeVMzVVdFeEM2RU44NUdYOElYd3MzbE1q?=
 =?utf-8?B?TUZ1NlRaT2dJOVNUMENQeVNrT3FFSURiaE1aSjQ5bWFmZml0RFFoaUdoNVlM?=
 =?utf-8?B?SDlWOEZMYzBDMVF3ZFU0a0FYOFlveW0xSHN1MzN6MFhIY3J5ek1KWkgrWWI4?=
 =?utf-8?B?ZGNqSmpXNmlEWlVNOStNVXJTK0YzWk56ZlNubUZyRzBIY1dmeDBwcXhwY0ZC?=
 =?utf-8?B?VTRteXlCc3E2Y2ZZTnpkNWFiRDlIOFZzRW5yOXdUSkd2RkVwemV2YkZzMkxq?=
 =?utf-8?B?dGNmam5zZGZHTHdza3NsSUZNbFdtV2huSTg4M1Z4QkpJVWQxU3duWkZEMUdm?=
 =?utf-8?B?YjRWY2xzRVlaMGNxNGhmK3hRbWVUZDA3VHJINFQwRW0xdW00RTNLaS9KRSts?=
 =?utf-8?B?S0xzR2VCOGs2Wkw0MEo0aTJ3RThLS3QyZkVMcHRHNXorY29YZlBsNG13YlNq?=
 =?utf-8?B?dURrOTJZUURSL2c2SkNqQ1VkZExhMVlWaFhTaUpYb28yWUZlVzF2ZkVrbnpo?=
 =?utf-8?B?QTdiL2NoS0xHTnlZOTZjY0NaV3JmUXNQbkxJUDVFYTl2TFdiVjBUbzZEem44?=
 =?utf-8?B?bmhSdkxTejE4eTZIekFiaGh6K1FHYVkrb0FLVTNsc3Q0L2ZjTGlRUHJDWnhC?=
 =?utf-8?B?SHFrN3RldjBsWkVnclFRdm16bk56bmdiZ2sxeWpwVmJrc3hSMi9vN1Q3bk9x?=
 =?utf-8?B?b2Q3VWRHcHdVQVBSeU9tV2N5RHRlSk14aDFYcGMxbENyREtaQWM0NHRqemQy?=
 =?utf-8?B?WC9wWXlPM3JvS09PRjZ6MElwVnRQQ3dJVDQ3djRFVlhBckxPNWQrenl1SS9S?=
 =?utf-8?B?NWlIVVBwWlhqM1M0ZzF4T05lK1A3Rk5tVU4wMktsWERjcFp3N2pOUnlYdnY1?=
 =?utf-8?Q?Kl1hiCWXzks7Q6Ru0qm6Y1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8188D837C9C2FA4787A9DE8887E5F91F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647ac67-72f6-4278-a7f8-08db2010289d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 20:03:17.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7f9cLy/8NLXhNW7e83V4xjNPPVEfSWMePPr3yDDaglP3joJqDMcPdwnqVabElop7EhKc9+SsoIpHLyou1QS3FMel4sg6Rm94ubzilBP/LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDE2OjI2ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQ2UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gV2hlbiBhIHByb2Nlc3MgaXMgZHVwbGljYXRlZCwgYnV0IHRoZSBjaGlsZCBz
aGFyZXMgdGhlIGFkZHJlc3MNCj4gPiBzcGFjZSB3aXRoDQo+ID4gdGhlIHBhcmVudCwgdGhlcmUg
aXMgcG90ZW50aWFsIGZvciB0aGUgdGhyZWFkcyBzaGFyaW5nIGEgc2luZ2xlDQo+ID4gc3RhY2sg
dG8NCj4gPiBjYXVzZSBjb25mbGljdHMgZm9yIGVhY2ggb3RoZXIuIEluIHRoZSBub3JtYWwgbm9u
LWNldCBjYXNlIHRoaXMgaXMNCj4gPiBoYW5kbGVkDQo+IA0KPiAibm9uLUNFVCINCg0KU3VyZS4N
Cg0KPiANCj4gPiBpbiB0d28gd2F5cy4NCj4gPiANCj4gPiBXaXRoIHJlZ3VsYXIgQ0xPTkVfVk0g
YSBuZXcgc3RhY2sgaXMgcHJvdmlkZWQgYnkgdXNlcnNwYWNlIHN1Y2gNCj4gPiB0aGF0IHRoZQ0K
PiA+IHBhcmVudCBhbmQgY2hpbGQgaGF2ZSBkaWZmZXJlbnQgc3RhY2tzLg0KPiA+IA0KPiA+IEZv
ciB2Zm9yaywgdGhlIHBhcmVudCBpcyBzdXNwZW5kZWQgdW50aWwgdGhlIGNoaWxkIGV4aXRzLiBT
byBhcw0KPiA+IGxvbmcgYXMNCj4gPiB0aGUgY2hpbGQgZG9lc24ndCByZXR1cm4gZnJvbSB0aGUg
dmZvcmsoKS9DTE9ORV9WRk9SSyBjYWxsaW5nDQo+ID4gZnVuY3Rpb24gYW5kDQo+ID4gc3RpY2tz
IHRvIGEgbGltaXRlZCBzZXQgb2Ygb3BlcmF0aW9ucywgdGhlIHBhcmVudCBhbmQgY2hpbGQgY2Fu
DQo+ID4gc2hhcmUgdGhlDQo+ID4gc2FtZSBzdGFjay4NCj4gPiANCj4gPiBGb3Igc2hhZG93IHN0
YWNrLCB0aGVzZSBzY2VuYXJpb3MgcHJlc2VudCBzaW1pbGFyIHNoYXJpbmcgcHJvYmxlbXMuDQo+
ID4gRm9yIHRoZQ0KPiA+IENMT05FX1ZNIGNhc2UsIHRoZSBjaGlsZCBhbmQgdGhlIHBhcmVudCBt
dXN0IGhhdmUgc2VwYXJhdGUgc2hhZG93DQo+ID4gc3RhY2tzLg0KPiA+IEluc3RlYWQgb2YgY2hh
bmdpbmcgY2xvbmUgdG8gdGFrZSBhIHNoYWRvdyBzdGFjaywgaGF2ZSB0aGUga2VybmVsDQo+ID4g
anVzdA0KPiA+IGFsbG9jYXRlIG9uZSBhbmQgc3dpdGNoIHRvIGl0Lg0KPiA+IA0KPiA+IFVzZSBz
dGFja19zaXplIHBhc3NlZCBmcm9tIGNsb25lMygpIHN5c2NhbGwgZm9yIHRocmVhZCBzaGFkb3cg
c3RhY2sNCj4gPiBzaXplLiBBDQo+ID4gY29tcGF0LW1vZGUgdGhyZWFkIHNoYWRvdyBzdGFjayBz
aXplIGlzIGZ1cnRoZXIgcmVkdWNlZCB0byAxLzQuDQo+ID4gVGhpcw0KPiA+IGFsbG93cyBtb3Jl
IHRocmVhZHMgdG8gcnVuIGluIGEgMzItYml0IGFkZHJlc3Mgc3BhY2UuIFRoZSBjbG9uZSgpDQo+
ID4gZG9lcyBub3QNCj4gPiBwYXNzIHN0YWNrX3NpemUsIHdoaWNoIHdhcyBhZGRlZCB0byBjbG9u
ZTMoKS4gSW4gdGhhdCBjYXNlLCB1c2UNCj4gPiBSTElNSVRfU1RBQ0sgc2l6ZSBhbmQgY2FwIHRv
IDQgR0IuDQo+ID4gDQo+ID4gRm9yIHNoYWRvdyBzdGFjayBlbmFibGVkIHZmb3JrKCksIHRoZSBw
YXJlbnQgYW5kIGNoaWxkIGNhbiBzaGFyZQ0KPiA+IHRoZSBzYW1lDQo+ID4gc2hhZG93IHN0YWNr
LCBsaWtlIHRoZXkgY2FuIHNoYXJlIGEgbm9ybWFsIHN0YWNrLiBTaW5jZSB0aGUgcGFyZW50DQo+
ID4gaXMNCj4gPiBzdXNwZW5kZWQgdW50aWwgdGhlIGNoaWxkIHRlcm1pbmF0ZXMsIHRoZSBjaGls
ZCB3aWxsIG5vdCBpbnRlcmZlcmUNCj4gPiB3aXRoDQo+ID4gdGhlIHBhcmVudCB3aGlsZSBleGVj
dXRpbmcgYXMgbG9uZyBhcyBpdCBkb2Vzbid0IHJldHVybiBmcm9tIHRoZQ0KPiA+IHZmb3JrKCkN
Cj4gPiBhbmQgb3ZlcndyaXRlIHVwIHRoZSBzaGFkb3cgc3RhY2suIFRoZSBjaGlsZCBjYW4gc2Fm
ZWx5IG92ZXJ3cml0ZQ0KPiA+IGRvd24NCj4gPiB0aGUgc2hhZG93IHN0YWNrLCBhcyB0aGUgcGFy
ZW50IGNhbiBqdXN0IG92ZXJ3cml0ZSB0aGlzIGxhdGVyLiBTbw0KPiA+IENFVCBkb2VzDQo+ID4g
bm90IGFkZCBhbnkgYWRkaXRpb25hbCBsaW1pdGF0aW9ucyBmb3IgdmZvcmsoKS4NCj4gPiANCj4g
PiBVc2Vyc3BhY2UgaW1wbGVtZW50aW5nIHBvc2l4IHZmb3JrKCkgY2FuIGFjdHVhbGx5IHByZXZl
bnQgdGhlIGNoaWxkDQo+ID4gZnJvbQ0KPiANCj4gIlBPU0lYIg0KDQpPay4NCg0KPiANCj4gLi4u
DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L2NvcmUuYw0KPiA+IGIv
YXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmMNCj4gPiBpbmRleCBmODUxNTU4YjY3M2YuLmJjM2Rl
NGFlYjY2MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvZnB1L2NvcmUuYw0KPiA+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jDQo+ID4gQEAgLTU1Miw4ICs1NTIsNDEg
QEAgc3RhdGljIGlubGluZSB2b2lkIGZwdV9pbmhlcml0X3Blcm1zKHN0cnVjdA0KPiA+IGZwdSAq
ZHN0X2ZwdSkNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gPiArI2lmZGVmIENPTkZJR19YODZf
VVNFUl9TSEFET1dfU1RBQ0sNCj4gPiArc3RhdGljIGludCB1cGRhdGVfZnB1X3Noc3RrKHN0cnVj
dCB0YXNrX3N0cnVjdCAqZHN0LCB1bnNpZ25lZCBsb25nDQo+ID4gc3NwKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgY2V0X3VzZXJfc3RhdGUgKnhzdGF0ZTsNCj4gPiArDQo+ID4gKwkvKiBJZiBzc3Ag
dXBkYXRlIGlzIG5vdCBuZWVkZWQuICovDQo+ID4gKwlpZiAoIXNzcCkNCj4gPiArCQlyZXR1cm4g
MDsNCj4gPiArDQo+ID4gKwl4c3RhdGUgPSBnZXRfeHNhdmVfYWRkcigmZHN0LT50aHJlYWQuZnB1
LmZwc3RhdGUtPnJlZ3MueHNhdmUsDQo+ID4gKwkJCQlYRkVBVFVSRV9DRVRfVVNFUik7DQo+ID4g
Kw0KPiA+ICsJLyoNCj4gPiArCSAqIElmIHRoZXJlIGlzIGEgbm9uLXplcm8gc3NwLCB0aGVuICdk
c3QnIG11c3QgYmUgY29uZmlndXJlZA0KPiA+IHdpdGggYSBzaGFkb3cNCj4gPiArCSAqIHN0YWNr
IGFuZCB0aGUgZnB1IHN0YXRlIHNob3VsZCBiZSB1cCB0byBkYXRlIHNpbmNlIGl0IHdhcw0KPiA+
IGp1c3QgY29waWVkDQo+ID4gKwkgKiBmcm9tIHRoZSBwYXJlbnQgaW4gZnB1X2Nsb25lKCkuIFNv
IHRoZXJlIG11c3QgYmUgYSB2YWxpZA0KPiA+IG5vbi1pbml0IENFVA0KPiA+ICsJICogc3RhdGUg
bG9jYXRpb24gaW4gdGhlIGJ1ZmZlci4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKFdBUk5fT05fT05D
RSgheHN0YXRlKSkNCj4gPiArCQlyZXR1cm4gMTsNCj4gPiArDQo+ID4gKwl4c3RhdGUtPnVzZXJf
c3NwID0gKHU2NClzc3A7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArI2Vs
c2UNCj4gPiArc3RhdGljIGludCB1cGRhdGVfZnB1X3Noc3RrKHN0cnVjdCB0YXNrX3N0cnVjdCAq
ZHN0LCB1bnNpZ25lZCBsb25nDQo+ID4gc2hzdGtfYWRkcikNCj4gDQo+IAkJCQkJCQkJICAgICAg
Xg0KPiBeXl5eXl5eXl5eDQo+IHNzcCwgbGlrZSBhYm92ZS4NCj4gDQo+IEJldHRlciB5ZXQ6DQo+
IA0KPiBzdGF0aWMgaW50IHVwZGF0ZV9mcHVfc2hzdGsoc3RydWN0IHRhc2tfc3RydWN0ICpkc3Qs
IHVuc2lnbmVkIGxvbmcNCj4gc3NwKQ0KPiB7DQo+ICNpZmRlZiBDT05GSUdfWDg2X1VTRVJfU0hB
RE9XX1NUQUNLDQo+IAkuLi4NCj4gI2VuZGlmDQo+IAlyZXR1cm4gMDsNCj4gfQ0KPiANCj4gYW5k
IGxlc3MgaWZkZWZmZXJ5Lg0KDQpTdXJlLiBTb21ldGltZXMgcGVvcGxlIHRlbGwgbWUgdG8gb25s
eSBpZmRlZiBvdXQgd2hvbGUgZnVuY3Rpb25zIHRvDQptYWtlIGl0IGVhc2llciB0byByZWFkLiBJ
IHN1cHBvc2UgaW4gdGhpcyBjYXNlIGl0J3Mgbm90IGhhcmQgdG8gc2VlLg0KDQoNCj4gDQo+IA0K
PiANCj4gPiArew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArI2VuZGlmDQo+ID4gKw0K
PiA+ICAvKiBDbG9uZSBjdXJyZW50J3MgRlBVIHN0YXRlIG9uIGZvcmsgKi8NCj4gPiAtaW50IGZw
dV9jbG9uZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKmRzdCwgdW5zaWduZWQgbG9uZyBjbG9uZV9mbGFn
cywNCj4gPiBib29sIG1pbmltYWwpDQo+ID4gK2ludCBmcHVfY2xvbmUoc3RydWN0IHRhc2tfc3Ry
dWN0ICpkc3QsIHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsDQo+ID4gYm9vbCBtaW5pbWFsLA0K
PiA+ICsJICAgICAgdW5zaWduZWQgbG9uZyBzc3ApDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBmcHUg
KnNyY19mcHUgPSAmY3VycmVudC0+dGhyZWFkLmZwdTsNCj4gPiAgCXN0cnVjdCBmcHUgKmRzdF9m
cHUgPSAmZHN0LT50aHJlYWQuZnB1Ow0KPiA+IEBAIC02MTMsNiArNjQ2LDEyIEBAIGludCBmcHVf
Y2xvbmUoc3RydWN0IHRhc2tfc3RydWN0ICpkc3QsDQo+ID4gdW5zaWduZWQgbG9uZyBjbG9uZV9m
bGFncywgYm9vbCBtaW5pbWFsKQ0KPiA+ICAJaWYgKHVzZV94c2F2ZSgpKQ0KPiA+ICAJCWRzdF9m
cHUtPmZwc3RhdGUtPnJlZ3MueHNhdmUuaGVhZGVyLnhmZWF0dXJlcyAmPQ0KPiA+IH5YRkVBVFVS
RV9NQVNLX1BBU0lEOw0KPiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiBVcGRhdGUgc2hhZG93IHN0
YWNrIHBvaW50ZXIsIGluIGNhc2UgaXQgY2hhbmdlZCBkdXJpbmcNCj4gPiBjbG9uZS4NCj4gPiAr
CSAqLw0KPiA+ICsJaWYgKHVwZGF0ZV9mcHVfc2hzdGsoZHN0LCBzc3ApKQ0KPiA+ICsJCXJldHVy
biAxOw0KPiA+ICsNCj4gPiAgCXRyYWNlX3g4Nl9mcHVfY29weV9zcmMoc3JjX2ZwdSk7DQo+ID4g
IAl0cmFjZV94ODZfZnB1X2NvcHlfZHN0KGRzdF9mcHUpOw0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMN
Cj4gPiBpbmRleCBiNjUwY2RlM2Y2NGQuLmJmNzAzZjUzZmE0OSAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3Byb2Nl
c3MuYw0KPiA+IEBAIC00OCw2ICs0OCw3IEBADQo+ID4gICNpbmNsdWRlIDxhc20vZnJhbWUuaD4N
Cj4gPiAgI2luY2x1ZGUgPGFzbS91bndpbmQuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS90ZHguaD4N
Cj4gPiArI2luY2x1ZGUgPGFzbS9zaHN0ay5oPg0KPiA+ICANCj4gPiAgI2luY2x1ZGUgInByb2Nl
c3MuaCINCj4gPiAgDQo+ID4gQEAgLTExOSw2ICsxMjAsNyBAQCB2b2lkIGV4aXRfdGhyZWFkKHN0
cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQ0KPiA+ICANCj4gPiAgCWZyZWVfdm04Nih0KTsNCj4gPiAg
DQo+ID4gKwlzaHN0a19mcmVlKHRzayk7DQo+ID4gIAlmcHVfX2Ryb3AoZnB1KTsNCj4gPiAgfQ0K
PiA+ICANCj4gPiBAQCAtMTQwLDYgKzE0Miw3IEBAIGludCBjb3B5X3RocmVhZChzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnAsIGNvbnN0DQo+ID4gc3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzICphcmdzKQ0K
PiA+ICAJc3RydWN0IGluYWN0aXZlX3Rhc2tfZnJhbWUgKmZyYW1lOw0KPiA+ICAJc3RydWN0IGZv
cmtfZnJhbWUgKmZvcmtfZnJhbWU7DQo+ID4gIAlzdHJ1Y3QgcHRfcmVncyAqY2hpbGRyZWdzOw0K
PiA+ICsJdW5zaWduZWQgbG9uZyBzaHN0a19hZGRyID0gMDsNCj4gPiAgCWludCByZXQgPSAwOw0K
PiA+ICANCj4gPiAgCWNoaWxkcmVncyA9IHRhc2tfcHRfcmVncyhwKTsNCj4gPiBAQCAtMTc0LDcg
KzE3NywxMyBAQCBpbnQgY29weV90aHJlYWQoc3RydWN0IHRhc2tfc3RydWN0ICpwLCBjb25zdA0K
PiA+IHN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyAqYXJncykNCj4gPiAgCWZyYW1lLT5mbGFncyA9
IFg4Nl9FRkxBR1NfRklYRUQ7DQo+ID4gICNlbmRpZg0KPiA+ICANCj4gPiAtCWZwdV9jbG9uZShw
LCBjbG9uZV9mbGFncywgYXJncy0+Zm4pOw0KPiA+ICsJLyogQWxsb2NhdGUgYSBuZXcgc2hhZG93
IHN0YWNrIGZvciBwdGhyZWFkIGlmIG5lZWRlZCAqLw0KPiA+ICsJcmV0ID0gc2hzdGtfYWxsb2Nf
dGhyZWFkX3N0YWNrKHAsIGNsb25lX2ZsYWdzLCBhcmdzLQ0KPiA+ID5zdGFja19zaXplLA0KPiA+
ICsJCQkJICAgICAgICZzaHN0a19hZGRyKTsNCj4gDQo+IFRoYXQgZnVuY3Rpb24gd2lsbCByZXR1
cm4gMCBldmVuIGlmIHNoc3RrX2FkZHIgaGFzbid0IGJlZW4gd3JpdHRlbiBpbg0KPiBpdA0KPiBh
bmQgeW91IHdpbGwgY29udGludWUgbWVycmlseSBhbmQgY2FsbA0KPiANCj4gCWZwdV9jbG9uZSgu
Li4sIHNoc3RrX2FkZHI9MCk7DQo+IA0KPiB3aHkgZG9uJ3QgeW91IHJldHVybiB0aGUgc2hhZG93
IHN0YWNrIGFkZHJlc3Mgb3IgbmVnYXRpdmUgb24gZXJyb3INCj4gaW5zdGVhZCBvZiBhZGRpbmcg
YW4gSS9PIHBhcmFtZXRlciB3aGljaCBpcyBwcmV0dHkgbXVjaCBhbHdheXMgbmFzdHkNCj4gdG8N
Cj4gZGVhbCB3aXRoLg0KDQpPbiBhIHNoYWRvdyBzdGFjayBhbGxvY2F0aW9uIGVycm9yLCB3ZSBm
YWlsIHRoZSBjb3B5X3RocmVhZCgpLiBXaGVuDQpzaGFkb3cgc3RhY2sgaXMgZW5hYmxlZCwgdGhl
IGFwcCBtaWdodCBiZSBhYmxlIHRvIGhhbmRsZSBhIGNsb25lDQpmYWlsdXJlLCBidXQgd291bGQg
bm90IGJlIGFibGUgdG8gaGFuZGxlIHN0YXJ0aW5nIGEgbmV3IHRocmVhZCB3aXRob3V0DQpnZXR0
aW5nIGEgbmV3IHNoYWRvdyBzdGFjay4NCg0KU28gaW4geW91ciBzdWdnZXN0aW9uIEkgZ3Vlc3Mg
d2Ugd291bGQgaGF2ZSB0d28gdHlwZXMgb2YgZmFpbHVyZSBvbmUNCnRoYXQgc2lnbmlmaWVzIHNo
YWRvdyBzdGFjayBpcyBlbmFibGVkIGFuZCB0aGUgYWxsb2NhdGlvbiBmYWlsZWQsIGFuZA0KYW5v
dGhlciB0aGF0IHNpZ25pZmllcyB0aGF0IHNoYWRvdyBzdGFjayBpcyBub3QgZW5hYmxlZCwgc28g
emVybyBuZWVkcw0KdG8gYmUgcGFzc2VkIGludG8gZnB1X2Nsb25lKCk/DQoNCldlIG5lZWQgdGhl
IG91dHB1dCBwYXJhbSBpbiBzaHN0a19hbGxvY190aHJlYWRfc3RhY2soKSBiZWNhdXNlIHdlIG5l
ZWQNCnRvIHVwZGF0ZSB0aGUgU1NQIHRvIHRoZSBuZXcgc2hhZG93IHN0YWNrLiBJZiB3ZSB3YW50
IHRvIG1ha2UgdGhlIG5vbi0NCnNoYWRvdyBzdGFjayBjYXNlIGhhbmRsZWQgZGlmZmVyZW50bHks
IEkgdGhpbmsgdGhlIGV4dHJhIGNvbmRpdGlvbmFscw0KYXJlIHdvcnNlLCBsaWtlOg0KLyogQWxs
b2NhdGUgYSBuZXcgc2hhZG93IHN0YWNrIGZvciBwdGhyZWFkIGlmIG5lZWRlZCAqLw0KcmV0ID0g
c2hzdGtfYWxsb2NfdGhyZWFkX3N0YWNrKHAsIGNsb25lX2ZsYWdzLCBhcmdzLT5zdGFja19zaXpl
LA0KCQkJCSZzaHN0a19hZGRyKTsNCmlmIChyZXQgPT0gLUVPUE5PVFNVUFApDQoJZnB1X2Nsb25l
KHAsIGNsb25lX2ZsYWdzLCBhcmdzLT5mbiwgMCk7DQplbHNlIGlmIChyZXQgPCAwKQ0KCXJldHVy
biByZXQ7DQplbHNlDQoJZnB1X2Nsb25lKHAsIGNsb25lX2ZsYWdzLCBhcmdzLT5mbiwgc2hzdGtf
YWRkcik7DQoNCkRvIHlvdSB0aGluaz8NCg0KSXQgdXNlZCB0byBiZSB0aGF0IHNoc3RrX2FsbG9j
X3RocmVhZF9zdGFjaygpIHJlYWNoZWQgaW50byBGUFUNCmludGVybmFscyB0byBkbyB0aGUgU1NQ
IHVwZGF0ZSBpdHNlbGYuIFRoZW4gdGhlIGFiaWxpdHkgdG8gZG8gdGhpcyB3YXMNCnJlbW92ZWQu
IFNvIEkgY2FtZSB1cCB3aXRoIGFuIGludGVyZmFjZSBmb3IgYWxsb3dpbmcgZmVhdHVyZXMgdG8g
bW9kaWZ5DQpYU0FWRSBidWZmZXJzIGZyb20gb3V0c2lkZSB0aGUgRlBVIGNvZGUuIE9uIGZ1cnRo
ZXIgZGlzY3Vzc2lvbiwgbGV0dGluZw0KY29kZSBvdXRzaWRlIHRoZSBGUFUgaGF2ZSBmbGV4aWJs
ZSBhY2Nlc3MgdG8gdGhlIFhTQVZFIGJ1ZmZlciBjb3VsZA0KY29uc3RyYWluIHRoZSBGUFUgY29k
ZSBmcm9tIGFkZGluZyBvcHRpbWl6YXRpb25zLiBTbyBUaG9tYXMgc3VnZ2VzdGVkDQp0byBwYXNz
IHRoZSBTU1AgYWxvbmcgaW50byBGUFUgY29kZSBzbyB0aGF0IHRoZSBGUFUgbW9kaWZpY2F0aW9u
IGNvdWxkDQpiZSBhbGwgbW9ub2xpdGhpYyBhbmQgZmxleGlibGUuDQoNCklmIHRoZSBkZWZhdWx0
IFNTUCB2YWx1ZSBsb2dpYyBpcyB0b28gaGlkZGVuLCB3aGF0IGFib3V0IHNvbWUgY2xlYXJlcg0K
Y29kZSBhbmQgY29tbWVudHMsIGxpa2UgdGhpcz8NCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9wcm9jZXNzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQppbmRleCBiZjcwM2Y1
M2ZhNDkuLmJkMTIzNTI3ZmNjYSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNz
LmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCkBAIC0xNDIsNyArMTQyLDcgQEAg
aW50IGNvcHlfdGhyZWFkKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgY29uc3Qgc3RydWN0DQprZXJu
ZWxfY2xvbmVfYXJncyAqYXJncykNCiAgICAgICAgc3RydWN0IGluYWN0aXZlX3Rhc2tfZnJhbWUg
KmZyYW1lOw0KICAgICAgICBzdHJ1Y3QgZm9ya19mcmFtZSAqZm9ya19mcmFtZTsNCiAgICAgICAg
c3RydWN0IHB0X3JlZ3MgKmNoaWxkcmVnczsNCi0gICAgICAgdW5zaWduZWQgbG9uZyBzaHN0a19h
ZGRyID0gMDsNCisgICAgICAgdW5zaWduZWQgbG9uZyBuZXdfc3NwOw0KICAgICAgICBpbnQgcmV0
ID0gMDsNCiANCiAgICAgICAgY2hpbGRyZWdzID0gdGFza19wdF9yZWdzKHApOw0KQEAgLTE3Nywx
MyArMTc3LDE4IEBAIGludCBjb3B5X3RocmVhZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGNvbnN0
DQpzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MgKmFyZ3MpDQogICAgICAgIGZyYW1lLT5mbGFncyA9
IFg4Nl9FRkxBR1NfRklYRUQ7DQogI2VuZGlmDQogDQotICAgICAgIC8qIEFsbG9jYXRlIGEgbmV3
IHNoYWRvdyBzdGFjayBmb3IgcHRocmVhZCBpZiBuZWVkZWQgKi8NCisgICAgICAgLyoNCisgICAg
ICAgICogQWxsb2NhdGUgYSBuZXcgc2hhZG93IHN0YWNrIGZvciB0aHJlYWQgaWYgbmVlZGVkLiBJ
ZiBzaGFkb3cNCnN0YWNrLA0KKyAgICAgICAgKiBpcyBkaXNhYmxlZCwgbmV3X3NzcCB3aWxsIHJl
bWFpbiAwLCBhbmQgZnB1X2Nsb25lKCkgd2lsbA0Ka25vdyBub3QgdG8NCisgICAgICAgICogdXBk
YXRlIGl0Lg0KKyAgICAgICAgKi8NCisgICAgICAgbmV3X3NzcCA9IDA7DQogICAgICAgIHJldCA9
IHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhwLCBjbG9uZV9mbGFncywgYXJncy0NCj5zdGFja19z
aXplLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNoc3RrX2FkZHIp
Ow0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm5ld19zc3ApOw0KICAg
ICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogDQotICAgICAgIGZw
dV9jbG9uZShwLCBjbG9uZV9mbGFncywgYXJncy0+Zm4sIHNoc3RrX2FkZHIpOw0KKyAgICAgICBm
cHVfY2xvbmUocCwgY2xvbmVfZmxhZ3MsIGFyZ3MtPmZuLCBuZXdfc3NwKTsNCiANCiAgICAgICAg
LyogS2VybmVsIHRocmVhZCA/ICovDQogICAgICAgIGlmICh1bmxpa2VseShwLT5mbGFncyAmIFBG
X0tUSFJFQUQpKSB7DQoNCg0K
