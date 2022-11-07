Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36461FD4D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 19:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiKGSUc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 13:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKGSUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 13:20:12 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13242E46;
        Mon,  7 Nov 2022 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667845200; x=1699381200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F+UEHyr5XNWuXoYds2FSX6Finwz5YGflY5qXaZF9b/M=;
  b=gBJnPrT0L7IemAu08x9MdSlxb29qxiRDLYAV5oejvhbeTNYQhIqqwNQ4
   4ISWlryGecV4mq5Mn1mx2nO5hiATRWe7zAAUMxicEHoaZz/1pPyuyX4rW
   G68E/VgaNnCpr3Kr6IUZxd1bZrDRmaGyVgxIyWkChsPYmvE8pySMqdu3X
   bYMajtUEUPXPNxWVXyGbMfjPEIEAS4kdv56GXH0/d5IybvIddqNiePODd
   nIuFkDpfl71CRc53BR3B7RAt/uqCmfa1riyiGtCgGNpRhm2uXWmBFF49u
   j3tYlNHXJhmivuhU2cDaxP3RwNMsSqaw/BK67TxCM7as1EtvL04gffAdi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374756930"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374756930"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638469963"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638469963"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 10:19:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 10:19:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 10:19:57 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 10:19:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkWhf7otS5z7m2w/yQclreFiFIq7kUhCVtBFCLFaeMLISRofLzpfPJUnGrZjdpU/wvZsmMBjDqPIL9LpoGelXv8guYNT2yNOylRfEeAexGCIM4h0hjGDKmUtthlhD20vo8shqP/8JAplfEtdo3d9lYEo1XjHrQgaog+z+znPmrarMEPMlrSZeWsCQTkmAF7ndohhlHymWUKJX3kZLZ8Ed7K+pDIONed9Q61nxMmmoGRJnSrwYOaTd8pA2KEkDaoJiWP/O/LjnVs/w2+TZ2NgYAHyRZG0rMyy5p1LXz4u4bo5WJTPRZLJOKln+wWwvUO7SAY8C71q/vCmEpBZkvKINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+UEHyr5XNWuXoYds2FSX6Finwz5YGflY5qXaZF9b/M=;
 b=WI8APSaMDiLQ82Vz18kia86du6DauDFR4xdbPodTp952rhrjFLF8AMexfgw+TcXCJz5CAo52PKCuxJWWb2HVstvjieOmp8vwvdooNGUSIBYyZZHKgoHo1CEstx9WrsgJCisr5s7MwnoLnH6QGaxG1Pc9DqbqZSjt6iYA1qolWuoNxKuE3QfP2vysRqQxAD4ebDOQuUbllGfJxTZQlSS9vtVUnZfip8vJL4+oBbiGlqkHTkLnN06G1gG9rph6Jr815/2GEGlD0E6M2O77/yqIODyKW3z4BMBltOMoBnyEH0XPBrWlIg6epTYjKNPrJbZogbR+C/MqkY4/IZOFMeOQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 18:19:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 18:19:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHY8J5NR6vBThIFiE2muQ7xksETCK4zxHGAgAAFWQA=
Date:   Mon, 7 Nov 2022 18:19:48 +0000
Message-ID: <14b4c6e3d5b7b259e832ff44e64597f1cf344ffe.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-5-rick.p.edgecombe@intel.com>
         <Y2lHxb5BnbQi499s@zn.tnic>
In-Reply-To: <Y2lHxb5BnbQi499s@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB5960:EE_
x-ms-office365-filtering-correlation-id: 44447e0d-099d-4d91-79fc-08dac0eca775
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ud3oEgRyemRb/VABhAk8bgL+BTeBXiT5cM4sxwwz1cvrcMrlvHkzZfk4ejWbIRo9xZsiDHvBpk/+tXobLHkKEO9sWmYK8cB/wYRbch9Tdf0GA8Fj6fmlKji3Ynnc+WmCNBg/I2yPS2b3op1ziygOr5zoREM5y0OiHG2caQzA1WR8/TonOVoKGmUaTEXHmSTlUtfosMiVVCw7eNklf1D2Aw2OWamsUiq9G2/9cMG1tMzViBq+XGeIV1DZ53vtLZx+zzC/My1sRWBpWuxuoBfYLkjg4ILDyD6ru+MDm3Ja8393rHxcux18FLPjlvbz4xBbgBCx4T27cZMN0aC6p2fO8rJGJoFI3RtAey/gfSet6UZhb0Y0/J9L65qDnumlPbREtfzIkB0gfDcRi3Swd8okiOSv8QGsexcCGB71x9kpZQtN0RutccRsBNzGprfSJQJH9fcCnCV0u/j78uSHON6fzSj5KR4d4T3FyLiFNR1dw4ztXzLsEHQzP25eSQxOlDHfKj7GcpCxF2eh8oG9rJkiOiIBj0tv8fKEtVPAGz8R0wim33g6x1atn+PZa9l3rXJYQ90F57sEU0FruJEqo0kpynscCLe6+75UjBbdUy+lRDYWL03fa8k73sCRi5zqygqtpaZaluVXCW5ttQtDVNoyywmjueQQovlyKcOej55DWuzK9lMxi6bzEL/EbkdgWosw70tUwZgDqdtOkSxBd8xBMkB87pcnkoXWR9kKHQyIuIxJFZ+f39tbVQSs4YmOL/1L3CYaRLsKUd4/phUKLU8DlJwkzNgIsOsFOKQcH8YSNrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(186003)(2906002)(91956017)(7406005)(41300700001)(26005)(76116006)(8676002)(66446008)(316002)(66476007)(66946007)(66556008)(36756003)(64756008)(6512007)(2616005)(5660300002)(8936002)(6506007)(86362001)(82960400001)(7416002)(38100700002)(38070700005)(122000001)(4326008)(83380400001)(71200400001)(6486002)(478600001)(54906003)(6916009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlEckJFYzFqaUVneDVmK3p0elBlRlV3dE5NU0hQa0w0SmhoWUdRNUFJaHoz?=
 =?utf-8?B?clhhYUNSQ3pjWVhteWRRTzdaTmZVdmlNamZNais5c2JPR0F5bDZValEzaWoz?=
 =?utf-8?B?NXB0MXBISkk5bklYTEx6eElIMEc4M080QTV6eHlwcmY0MUFvWUpLUHJRTm0w?=
 =?utf-8?B?UDBZM256MU1xb2UxeFo3MnhMNzhsMEhMNk0rT3hWZHZiQ2gvVGJzZmxER1FF?=
 =?utf-8?B?U3NubFpIZTQyNlc3RW5rOUNsUS8wRW8yWTJEUnBYdHFuWUw2dXIxRHFaU1gr?=
 =?utf-8?B?NDBoT240N3RKNzg4MGdHaUo1SVJ3MEZiS0dtWWhJQ0xWcnhnYkwvSklCNGc5?=
 =?utf-8?B?ZlpoV3NJbEcwMUJRbTJULzJzaWRtdXdyN1BkbU9kcUkvUEtVT014aDBqL2hZ?=
 =?utf-8?B?TDArakx4ZlBQSVlXTEdpNUdXTEpoeHBOSFI3TldDelAySlNFUXQ5cTMxKzBp?=
 =?utf-8?B?ZzR1VExzM2N6L2FwK3Bodkk2VzdYLy93VVpMaU9STlc5WDlSN2lzTytRYnZ5?=
 =?utf-8?B?WTRKUlVPUG5HU1R0a2lNZVZ4dUk3ekJacHFMM1VFeHl1a3IxdlhMS2pQcGY4?=
 =?utf-8?B?SUIwNXRmc1d6di9Rc2w2L1RHSmprOG5Ib2NkNE9NWDlPOXErVWh1RWVXV1Bh?=
 =?utf-8?B?d1VQVXlDTlBNUVhBMFNyTXIvc0locEY1OFRXUFRvdUF3emlJUi9oU2NxUmV0?=
 =?utf-8?B?a3VXRVJzQmxXVTZtUlFHR1BidXZMakxWbGtwd1J4QUd5cE5XT0RWWSsxRGQx?=
 =?utf-8?B?b1Y3Nk9IeEU3cjZEem9GeVZPRnZlTWxGSHJvclZjQzI4b3VabVo4S3JtUE1J?=
 =?utf-8?B?UDlEamU4S083dVJGZjFoYVZuMFhnNEsrenJENVRYQTYyY1NtbGdhQTdyc3ZN?=
 =?utf-8?B?RmlzUWhjemlVZkI4TDFtWW9GaFpaVGpwb1AvYzROZ0FmdlRxTlptbzV0QUlM?=
 =?utf-8?B?VHpJQXF0S1BTMCtQR01ST0xpQzNRdVk2Y1dITUtZbms3TXpFdkFDY1Q0bStV?=
 =?utf-8?B?TzJTZ1Z4Q2dJd0M2d0VvdERwU2RSUFd2cDJKRzhlY252K2xtY2ZoSnJyc201?=
 =?utf-8?B?UWZqbWdUcG04YkpPeStjaSsveXprWnpkVGNaQjdLWFBqZjRKdkdaK1hmbkRw?=
 =?utf-8?B?V29zMXVSYXRBaFNSdkVmQmVRZWxZakJGamJmVVlIa0FFRDNJbnBSdHl3aURu?=
 =?utf-8?B?MzJRbWJiaGpGNHNkV2w4cm45bHJISjNlUUV0TDVUQ0tPc2FaOVFoOENhYXVl?=
 =?utf-8?B?c2Y4RG9Ra00rR0J6QnhiOGRNK25VeXZxS1piVG1idTIxd081U2hkSitwVDVS?=
 =?utf-8?B?Q0ZDRVhiVms0MFRkbUZ6K1c0SVJ6SVJpUnJBd2pldzhCc3JtUlFweHdKSFhR?=
 =?utf-8?B?aHFsSDFCV0pZZmtJTmVlNVZXaGErZ3MvQ1I0ZDlvT2RJOFczaTI1WTZmM2px?=
 =?utf-8?B?WXUxcmVEWlFuMEJKZXdaNFE4R3l6RmZuZDAxZi9BTzE4eW5YNzZSb0VtQm9I?=
 =?utf-8?B?NHR1NzFORjdpZDRtWHVoMkptYk5WWGhMMU4vSGdOb1B3RWh0S1FlS2paL2h3?=
 =?utf-8?B?K3B5U0ZFd3NmdFdndlFwRTNKZ1Bmb1pKaEJTcmRaczZYYXdjQVJWbVhqMDJj?=
 =?utf-8?B?Z0ViNjRyalo2ekt4S1ltUkhETVIyNVYwNzJYTHR4c1orWVNsWmppS3RhSlJ5?=
 =?utf-8?B?TVU3UzlqUzFhQ2hvRkVrZFhPQXZZUzBZUFphRS9jV3Q1KzdXOS96bi9ORGxS?=
 =?utf-8?B?OXBhbVhibFZZdmEzc0lCSlRCd3J3Y0tLZytrZlU5alZCcVpGWnpUOWtvbUVM?=
 =?utf-8?B?RSs2OXNicThXOUhaWkFtSnpXbEdWcVB3VDZaN2hXRFY5RnR5d3oyV2tabU55?=
 =?utf-8?B?dW1DUy9icUc5LzVyU29oMldyK1ptYTA3UHQwWTVvUjRwMUZRbjR5NXNQMXZw?=
 =?utf-8?B?dHZqNCtVUmdYenJKaGtxMWtVWlVKU2Rnem14dnc1NS9EemFBUG1tRUJucjIz?=
 =?utf-8?B?SFZBWnJnaHphakdEL3lPS05oekpVRjBlMFVlZHBZbGo2bkptUWptOGhpZXg1?=
 =?utf-8?B?cDAxeEY5L1ZJK05FeXpUR1ZUOGRSdStzWEovQ2RNMTNGVXRKc01UMHE5c0Jl?=
 =?utf-8?B?T1RkMG1UcjQ5T29xV0FpQmMvMmloVW91WEJqWW9vNkdteEJsSVBxMTR4RW44?=
 =?utf-8?Q?oG3M5opeVupFwcPSV8lG17E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DC4FD99A2E32E4787BEEC1DDD082D02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44447e0d-099d-4d91-79fc-08dac0eca775
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 18:19:48.0499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBd1zFCOBYSUXOL2+RZOCwcv4Hvn0Doiica/jNbI3A+qG+4JYVNd+QTQ1ZG4X0lInT5Wl8NTcr8i9pqf7B5Asd7tt+4eEvHISw103Vek8aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE5OjAwICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgTm92IDA0LCAyMDIyIGF0IDAzOjM1OjMxUE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+ICBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc2V0dXBfY2V0KHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4gPiAgew0KPiA+IC0JdTY0IG1zciA9IENFVF9FTkRCUl9F
TjsNCj4gPiArCWJvb2wga2VybmVsX2lidCA9IEhBU19LRVJORUxfSUJUICYmDQo+ID4gY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JQlQpOw0KPiA+ICsJYm9vbCB1c2VyX3Noc3RrOw0K
PiA+ICsJdTY0IG1zciA9IDA7DQo+ID4gIA0KPiA+IC0JaWYgKCFIQVNfS0VSTkVMX0lCVCB8fA0K
PiA+IC0JICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQo+ID4gKwkv
Kg0KPiA+ICsJICogRW5hYmxlIHVzZXIgc2hhZG93IHN0YWNrIG9ubHkgaWYgdGhlIExpbnV4IGRl
ZmluZWQgdXNlcg0KPiA+IHNoYWRvdyBzdGFjaw0KPiA+ICsJICogY2FwIHdhcyBub3QgY2xlYXJl
ZCBieSBjb21tYW5kIGxpbmUuDQo+ID4gKwkgKi8NCj4gPiArCXVzZXJfc2hzdGsgPSBjcHVfZmVh
dHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSAmJg0KPiA+ICsJCSAgICAgSVNfRU5BQkxF
RChDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLKSAmJg0KPiA+ICsJCSAgICAgIXRlc3RfYml0
KFg4Nl9GRUFUVVJFX1VTRVJfU0hTVEssICh1bnNpZ25lZCBsb25nDQo+ID4gKiljcHVfY2Fwc19j
bGVhcmVkKTsNCj4gDQo+IEh1aCwgd2h5IHBva2UgYXQgY3B1X2NhcHNfY2xlYXJlZD8gDQoNCkl0
IHdhcyB0byBjYXRjaCBpZiB0aGUgc29mdHdhcmUgdXNlciBzaGFkb3cgc3RhY2sgZmVhdHVyZSBn
ZXRzIGRpc2FibGVkDQphdCBib290IHdpdGggdGhlICJjbGVhcmNwdWlkIiBjb21tYW5kLiBJcyB0
aGVyZSBhIGJldHRlciB3YXkgdG8gZG8NCnRoaXM/DQoNCj4gDQo+IExvb2sgYmVsb3c6DQo+IA0K
PiA+ICsJaWYgKCFrZXJuZWxfaWJ0ICYmICF1c2VyX3Noc3RrKQ0KPiA+ICAJCXJldHVybjsNCj4g
PiAgDQo+ID4gKwlpZiAodXNlcl9zaHN0aykNCj4gPiArCQlzZXRfY3B1X2NhcChjLCBYODZfRkVB
VFVSRV9VU0VSX1NIU1RLKTsNCj4gPiArDQo+ID4gKwlpZiAoa2VybmVsX2lidCkNCj4gPiArCQlt
c3IgPSBDRVRfRU5EQlJfRU47DQo+ID4gKw0KPiA+ICAJd3Jtc3JsKE1TUl9JQTMyX1NfQ0VULCBt
c3IpOw0KPiA+ICAJY3I0X3NldF9iaXRzKFg4Nl9DUjRfQ0VUKTsNCj4gPiAgDQo+ID4gLQlpZiAo
IWlidF9zZWxmdGVzdCgpKSB7DQo+ID4gKwlpZiAoa2VybmVsX2lidCAmJiAhaWJ0X3NlbGZ0ZXN0
KCkpIHsNCj4gPiAgCQlwcl9lcnIoIklCVCBzZWxmdGVzdDogRmFpbGVkIVxuIik7DQo+ID4gIAkJ
c2V0dXBfY2xlYXJfY3B1X2NhcChYODZfRkVBVFVSRV9JQlQpOw0KPiA+ICAJCXJldHVybjsNCj4g
PiAgCX0NCj4gPiAgfQ0KPiA+ICsjZWxzZSAvKiBDT05GSUdfWDg2X0NFVCAqLw0KPiA+ICtzdGF0
aWMgaW5saW5lIHZvaWQgc2V0dXBfY2V0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykge30NCj4gPiAr
I2VuZGlmDQo+ID4gIA0KPiA+ICBfX25vZW5kYnIgdm9pZCBjZXRfZGlzYWJsZSh2b2lkKQ0KPiA+
ICB7DQo+ID4gLQlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JQlQpKQ0KPiA+
IC0JCXdybXNybChNU1JfSUEzMl9TX0NFVCwgMCk7DQo+ID4gKwlpZiAoIShjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkgfHwNCj4gPiArCSAgICAgIGNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfU0hTVEspKSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJd3Jt
c3JsKE1TUl9JQTMyX1NfQ0VULCAwKTsNCj4gPiArCXdybXNybChNU1JfSUEzMl9VX0NFVCwgMCk7
DQo+IA0KPiBIZXJlIHlvdSBuZWVkIHRvIGRvDQo+IA0KPiAJc2V0dXBfY2xlYXJfY3B1X2NhcChY
ODZfRkVBVFVSRV9JQlQpOw0KPiAJc2V0dXBfY2xlYXJfY3B1X2NhcChYODZfRkVBVFVSRV9TSFNU
Syk7DQoNClRoaXMgb25seSBnZXRzIGNhbGxlZCBieSBrZXhlYyB3YXkgYWZ0ZXIgYm9vdCwgYXMg
a2V4ZWMgaXMgcHJlcHBpbmcgdG8NCnRyYW5zaXRpb24gdG8gdGhlIG5ldyBrZXJuZWwuIERvIHdl
IHdhbnQgdG8gYmUgY2xlYXJpbmcgZmVhdHVyZSBiaXRzIGF0DQp0aGF0IHRpbWU/DQoNCj4gDQo+
IGFuZCB0aGVuIHRoZSBjcHVfZmVhdHVyZV9lbmFibGVkKCkgdGVzdCBhYm92ZSBhbG9uZSBzaG91
bGQgc3VmZmljZS4NCj4gDQo+IEJ1dCwgYmVmb3JlIHlvdSBkbyB0aGF0LCBJJ2QgbGlrZSB0byBh
c2sgeW91IHRvIHVwZGF0ZSB5b3VyIHBhdGNoc2V0DQo+IG9udG9wIG9mIHRpcC9tYXN0ZXIgYmVj
YXVzZSB0aGUgY29uZmxpY3RzIGFyZSBnZXR0aW5nIG5vbi10cml2aWFsLg0KPiBUaGlzDQo+IG9u
ZSBkb2Vzbid0IGV2ZW4gd2FudCB0byBhcHBseSB3aXRoIGEgbGFyZ2UgZnV6ejoNCj4gDQo+ICQg
cGF0Y2ggLXAxIC0tZHJ5LXJ1biAtRjIwIC1pIC90bXAvbmV3DQo+IGNoZWNraW5nIGZpbGUgYXJj
aC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KPiBIdW5rICMxIEZBSUxFRCBhdCA1OTYuDQo+IDEg
b3V0IG9mIDEgaHVuayBGQUlMRUQNCj4gDQo+IFRoeC4NCg0KU3VyZSwgc29ycnkgYWJvdXQgdGhh
dC4gSSdsbCB0YXJnZXQgdGlwIGZvciB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0K
