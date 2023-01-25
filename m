Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92B67B9BE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 19:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjAYSoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjAYSoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 13:44:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833045BEA;
        Wed, 25 Jan 2023 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674672243; x=1706208243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TQ0ERZfsDLYiAgskX5LmJCp6K2CnKru+Z3g3Zo2c5OU=;
  b=KSQQrjnFVUzXAhyJ/OoX9Q82nEn7Jz6BO0BOzxlWV7tvMx39eJ9eQMmX
   MZPf+I2EtIcRMwhBgeZnZQkHMAsbCESd6VW1A8jvfHrKW+YlZKUOr+lKD
   P2FMZ7qBCUw6G7NPoHHkH6BwfVunsjHCJyTjTNUOORK7N1Ean9DZ+gcIB
   YCbn8xiwClDguFdLZ6q3QFUTgIS+M9BJfFE8Dyz8ayLJUcHHTKB7laFMr
   yxN2Vs3JjXVKglRGZPpEK1QDJ+6qnU9r1608yGHcuJqDdYg7MiQXs9mC9
   lp2Tq/psgv2gMxcUkCs5LRbLRloklbXfEisR8jvJg57l58tpgfJQR5zef
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326669351"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326669351"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="655906832"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="655906832"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2023 10:44:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:44:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:44:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:43:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA964MOvVWuhr71Yy0udYvKmRIWQbwsBnWPHTgKpFIhLyb3h+gESdd8koIM0G4cOIssbHS45Anm/TjzbOJOHa0aiKTA0ZBPOYBrj2cRCwFuq/KVz9iJKHAnSTYE+TmlZtgsw/6VBwmyZ04ZjwqdpyfL8P/iX0jR2DZBIcprJQM6eg6Q8zItbB4JdPnu7DDAkCJx3103i3QnKzer3TW91U5+z0x8iXNcUbilOr4yENof94MjBq6PRtOmdSLC6gxm/s0A7+uJYZsf5xsh779ftPme+nNsHPOJxRwk64cEyA5fA4u0GE+ctCneUNOQd+/la1ASnBFWZwkClXKM6hYJj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ0ERZfsDLYiAgskX5LmJCp6K2CnKru+Z3g3Zo2c5OU=;
 b=bM53d/2NIc4fFvXHDbYNsxhBoySzajDqmrU769oUlhOGH6dlXB1x2x6YhtvqfbjcVkmfKgmCSTi1L7tr+67GkK557673EfsSmv1BnJx4n2nhGwaCvZQMrXXbeLHFs7V7fDhK83zXWIMihlQUmwNOu0pExTeMs2Qj4WEHuGGiUGy45df35qW1PIP5am8vYPvZq37d8e51X/1hLIW4sgcOItdMW0GsRGzGLM3SOhkpT8nOC1RSou9yIYlAN2fVhL/BsVRlnsRuYs4Nm4LOkXvqZTUvjzjKr9edxg4y3yccg+DidzlghO7lXpjQNAmVOjMUH/Ahxc+gvNLsXqgGrxJXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:43:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 18:43:47 +0000
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
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAA==
Date:   Wed, 25 Jan 2023 18:43:47 +0000
Message-ID: <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
In-Reply-To: <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7329:EE_
x-ms-office365-filtering-correlation-id: 1c1d93e7-0d39-4653-3ea0-08daff0417cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5cNQejNGOBTVwp6qtczq55iNhYRwNleX9dI2tiz2BmtE3oDb5kIjdT7ZYNg9fBQCFlZjlJunBPCdhXmWc19gjf0K9OjVwrAMX5qDWRRe7dpPACOZFNfo/4Q+N2+U379l1cHUMW7bm3prnjUbHLA8x7ZtAROnht0Voof0eEBi6GqRbUMlfvfm3UTVDdJUKqcXMX52e9OYjOIEiFGmKz53tZzA/IBcNMK6/K++qEh/ITDe2slEEHM6pgeb/JLeFT4BgH7xu+YLq4+FuNHVUghtSIbjtBIyjVxiXmI4WCpa0Ontb3Ob06lWszoPAEPO4HMZVd8oY6ssDSkuMbENbGZuN0Or6ws2qYOUaMf/X1CXTfhd62Q5xIzQBgZkn/UQ7x52yTQVdAj3tYd1zEZkfhK/eIKwhYPO5ZDW/0gckHfSq7pfXIqL+wbsKwuXe/Apb2PuqLShyioDYp0ff9/vRi3XfZASXmqMNfcNz1C3IsOYCwUfA2Cc2QfCQdr6KZ/DDJhR8X4Mv6CKDwjsANlg0KglWZn62Zo8Jy2ioFX9MOj5H1fSohZtMrBEgmMdMerFR9KycsC5eUQucabawnwYy/0ibMR8J0WGN76hI9ALeHV370D55pcHoao9FzKxjhFMRE0IDaIptRkp47ruBUMw65Ov+UakL/xcJb2ofS3Xgu3Vv0i2GY92A4NAjcsuIAILiOEi5GhtfMAVnTIEBm1PUpLvKPKnCOD5bXlSL9FGGtNNagN8/B1K+XogIoOHYBDcbGeyoe0vzP9spfmEAGpjFCeVO3bhlkz311Or2zbvaOTPErdzFoniNAgoEiHor+VB44i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(2616005)(41300700001)(8936002)(921005)(38100700002)(122000001)(2906002)(7406005)(7416002)(82960400001)(5660300002)(83380400001)(6486002)(6506007)(966005)(86362001)(186003)(6512007)(26005)(478600001)(71200400001)(64756008)(66946007)(76116006)(38070700005)(66476007)(66556008)(66446008)(4326008)(8676002)(316002)(110136005)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlozR3hMd1RvRHhwSEx3Ukx6YmgzalpJamFEb0RqUnYvdU5GTkV3NU91M3VQ?=
 =?utf-8?B?NUhTbk1yMGswYUE2dldDcWZPdVQxYXhpUGF6Nk5XcEtkNHRyZFBCRXYyYW4w?=
 =?utf-8?B?YVlpTVNMZGw1MURBaHJzSTRaWHNDUEFyL1Bsc2JRNkxCNWdZWUFOaGpXY0x1?=
 =?utf-8?B?WnVUcEpiazYwS1dyMjF0bWVrZDc5ak5kV0oycDhHeCs5SU1QeGlRS1BjWThh?=
 =?utf-8?B?SURWR3RTaG5pdlBHMzg5dk1ROHgvRFJ4dERQZzVhNG9PQ1JOcnlZUWdCTDNQ?=
 =?utf-8?B?dmpHSkNoNlkyTk93ZVF2L1JhSUJkcHRxTENWN252L2NpS2Q0WEVScGJvWmtL?=
 =?utf-8?B?Q0U4MTRkQWp5TVY3RThZNEI4eTVDdmFXYlh0NzYvUGlKUGtGNmc3QndxYytX?=
 =?utf-8?B?NWV0UzhPbnpPanY5cmRuRURTUE5lUzdTSVl2U3prQitCVHBXL2JXQzRsMWQx?=
 =?utf-8?B?TU5uYVo2Ny95SXNLQTVvUTRDVzdYODRRQVRtL2g1Z1IxemNlZG1BODRzSFo3?=
 =?utf-8?B?RjVjaWQ0eHY0eWc5Z3ZzVkNGajdmSXBLNHNwQzJRUUhTeFI5aHY3Rml1VHJr?=
 =?utf-8?B?b3VMbjByemFhc2NuQytXUW1kMzdHeWRpTG9rSEhGNkNOSDBFQmVsTnpsM2k5?=
 =?utf-8?B?QmVCdUJMVUtXa1pIQlNrNmxxbnVLeWlDUFM5THBodWpMVjdRc1ZwaVlvTUVU?=
 =?utf-8?B?RDZSdUl0bzhiU1pJM0RycjBKVExXNUJvQkR6Mld0YnNzRUdnWG5FSWNJZXlX?=
 =?utf-8?B?RDlnMXIvRnd6K3o2aGpCVk56ekI2VXJsTktLT2FNYjN2M21FQjBBd1Uvd05h?=
 =?utf-8?B?bm03UUd1Y1FGWlVJUFdBdis2Z2haeEJUeThuaDN2Q2dndDZlUFB6d1dRcXRa?=
 =?utf-8?B?dUVqcW5IRVc3YThVMHlKZC93YVpTeUZha0ExcW55cnhNcnIvaUJLc3N4TkZp?=
 =?utf-8?B?eXcyaWovVUNQMHpyeExBa3JZYk8zWmJXaVAzSmVROE9zQTNGOThEOGFNanFa?=
 =?utf-8?B?ZHVIZWFUeitrdXJMSG5GTmVoTUJxdFFxbXJUeTR2U1hyaEtLT1hUNm5WOCtR?=
 =?utf-8?B?eGFsMTlOdUVmS3l0ZmtEczNpbmp3bVhSWkNjUTc5MGJCWE1jcXhpc3FSWkdy?=
 =?utf-8?B?TStzNWhoSEhlaHdRSTVPNDFxSFJJOXJ5Ui9tWDlHTzdMVFgxTk84U2srcUZy?=
 =?utf-8?B?SzhjcitRVlkvSkhGRG0rUHJDblVLUUsvNVViM2cxcUVlcHdXYVhtTFRHUHhR?=
 =?utf-8?B?RWFCVDF3cXdsNUVxZmVNWXdBclVuaXBOcVdpVFRid3pobkxZeHpjZ256NkJ6?=
 =?utf-8?B?Q1FpL0tSNkZhZkltTzIwSXA4dS8vMVpyZzA3TXJDNGVvRWVSeXZwRWJoL1l5?=
 =?utf-8?B?Z0EvNDJ6NHU3UVBmWXNIWmFabCthSFYzQ2tqQzBVa01YdUZlN1V2aWUxZUJy?=
 =?utf-8?B?WHhsU0VTT2R6Mnh0KzN2Qk1PZ2JQcUp2UncxL3ZRUENNNE5FUXNqQ3hKTEJo?=
 =?utf-8?B?ZWNDaHVybkRnYUw1ZlFiMWQrQk9lbWFYR2x6TjVIZzJGUHJJOUdGUlUxWWlM?=
 =?utf-8?B?TTY1WlVKRFlFblIvVy92eEhRRk1KVmJxY2djQlMyK2Q3K3F0dktOSG1acXhP?=
 =?utf-8?B?RGZuRHpJN25jYWVZMWlqWkhsS1FMOU1JcmdBSFFFYVpWdUxNVmw5bzI5QXF4?=
 =?utf-8?B?OEJ2YXMwd2EzUVJhc2pPc3NVbDNmVUFvemcya1RHV3RqR0o5QS9iM1IydUFU?=
 =?utf-8?B?a3FSeHQvUlludkdhc2lrK1VQaEtIV01vYWNPaEJtK2lLdVhnT1orLzdQWjNj?=
 =?utf-8?B?VUJXMFpwK3BING0wa2tjc2JsSGRTdm41RE1yYURmbG81a3QyeGVwZkFHSVR3?=
 =?utf-8?B?SHVQclZydG01NFJEc2M0bzdNSkU3M3VJZDNJeGJTUkwwVE1ES2pzTldXUk5B?=
 =?utf-8?B?K3FSam44ZWd3WmpzaGduK0FRWG8xcVhtOWhoaW9KNUN1Q2ZiQWhhL2RjNEdM?=
 =?utf-8?B?UlBUSGMvT041aGo1by94M0ROSWtYaFYvSzRoUnFsWTVOMHduaHhGSEpRandE?=
 =?utf-8?B?YSs2aGdKaVlZbzB1NjFzNExQWGZOMUQrTkhLWTM1MmRlZHY4TU5tdUhyQ1RX?=
 =?utf-8?B?NjNBc2tuR05hQlh0dWxRRzJLeEM1bllUcm91c1RUdXdNQU90TlIrMktKQnFT?=
 =?utf-8?Q?eyOLujleoXuTohDqX/aPQQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA19F80D89231247B80E5B1E367F8B2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1d93e7-0d39-4653-3ea0-08daff0417cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 18:43:47.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGsikV0AzPJTtNC769D7AU8oYfZlHG2M2YAUf3AsOutAXHat/bbmpETplfiSV3Iu/YirXjo8pV2HxAtbG8S1qxGlcpYyPU50uIV6TmTXMiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDEwOjI3ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gPiA+IFJvdWdobHkgc3BlYWtpbmc6IGlmIHdlIGFic3RyYWN0IGl0IHRoYXQgd2F5IGFu
ZCBnZXQgYWxsIG9mIHRoZQ0KPiA+ID4gImhvdw0KPiA+ID4gdG8NCj4gPiA+IHNldCBpdCB3cml0
YWJsZSBub3c/IiBvdXQgb2YgY29yZS1NTSwgaXQgbm90IG9ubHkgaXMgY2xlYW5lciBhbmQNCj4g
PiA+IGxlc3MNCj4gPiA+IGVycm9yIHByb25lLCBpdCBtaWdodCBldmVuIGFsbG93IG90aGVyIGFy
Y2hpdGVjdHVyZXMgdGhhdA0KPiA+ID4gaW1wbGVtZW50DQo+ID4gPiBzb21ldGhpbmcgY29tcGFy
YWJsZSAoZS5nLiwgdXNpbmcgYSBkZWRpY2F0ZWQgSFcgYml0KSB0byBhY3R1YWxseQ0KPiA+ID4g
cmV1c2UNCj4gPiA+IHNvbWUgb2YgdGhhdCB3b3JrLiBPdGhlcndpc2UgbW9zdCBvZiB0aGF0ICJz
aHN0ayIgaXMgcmVhbGx5IGp1c3QNCj4gPiA+IHg4Ng0KPiA+ID4gc3BlY2lmaWMgLi4uDQo+ID4g
PiANCj4gPiA+IEkgZ3Vlc3MgdGhlIG9ubHkgY2FzZXMgd2UgaGF2ZSB0byBzcGVjaWFsIGNhc2Ug
d291bGQgYmUgcGFnZQ0KPiA+ID4gcGlubmluZw0KPiA+ID4gY29kZSB3aGVyZSBwdGVfd3JpdGUo
KSB3b3VsZCBpbmRpY2F0ZSB0aGF0IHRoZSBQVEUgaXMgd3JpdGFibGUNCj4gPiA+ICh3ZWxsLA0K
PiA+ID4gaXQNCj4gPiA+IGlzLCBqdXN0IG5vdCBieSAib3JkaW5hcnkgQ1BVIGluc3RydWN0aW9u
IiBjb250ZXh0IGRpcmVjdGx5KTogYnV0DQo+ID4gPiB5b3UNCj4gPiA+IGRvDQo+ID4gPiB0aGF0
IGFscmVhZHksIHNvIC4uLiA6KQ0KPiA+ID4gDQo+ID4gPiBTb3JyeSBmb3Igc3R1bWJsaW5nIG92
ZXIgdGhhdCB0aGlzIGxhdGUsIEkgb25seSBzdGFydGVkIGxvb2tpbmcNCj4gPiA+IGludG8NCj4g
PiA+IHRoaXMgd2hlbiB5b3UgQ0NlZCBtZSBvbiB0aGF0IG9uZSBwYXRjaC4NCj4gPiANCj4gPiBT
b3JyeSBmb3Igbm90IGNhbGxpbmcgbW9yZSBhdHRlbnRpb24gdG8gaXQgZWFybGllci4gQXBwcmVj
aWF0ZSB5b3VyDQo+ID4gY29tbWVudHMuDQo+ID4gDQo+ID4gUHJldmlvdXNseSB2ZXJzaW9ucyBv
ZiB0aGlzIHNlcmllcyBoYWQgY2hhbmdlZCBzb21lIG9mIHRoZXNlDQo+ID4gcHRlX21rd3JpdGUo
KSBjYWxscyB0byBtYXliZV9ta3dyaXRlKCksIHdoaWNoIG9mIGNvdXJzZSB0YWtlcyBhDQo+ID4g
dm1hLg0KPiA+IFRoaXMgd2F5IGFuIHg4NiBpbXBsZW1lbnRhdGlvbiBjb3VsZCB1c2UgdGhlIFZN
X1NIQURPV19TVEFDSyB2bWENCj4gPiBmbGFnDQo+ID4gdG8gZGVjaWRlIGJldHdlZW4gcHRlX21r
d3JpdGUoKSBhbmQgcHRlX21rd3JpdGVfc2hzdGsoKS4gVGhlDQo+ID4gZmVlZGJhY2sNCj4gPiB3
YXMgdGhhdCBpbiBzb21lIG9mIHRoZXNlIGNvZGUgcGF0aHMgIm1heWJlIiBpc24ndCByZWFsbHkg
YW4NCj4gPiBvcHRpb24sIGl0DQo+ID4gKm5lZWRzKiB0byBtYWtlIGl0IHdyaXRhYmxlLiBFdmVu
IHRob3VnaCB0aGUgbG9naWMgd2FzIHRoZSBzYW1lLA0KPiA+IHRoZQ0KPiA+IG5hbWUgb2YgdGhl
IGZ1bmN0aW9uIG1hZGUgaXQgbG9vayB3cm9uZy4NCj4gPiANCj4gPiBCdXQgYW5vdGhlciBvcHRp
b24gY291bGQgYmUgdG8gY2hhbmdlIHB0ZV9ta3dyaXRlKCkgdG8gdGFrZSBhIHZtYS4NCj4gPiBU
aGlzDQo+ID4gd291bGQgc2F2ZSB1c2luZyBhbm90aGVyIHNvZnR3YXJlIGJpdCBvbiB4ODYsIGJ1
dCBpbnN0ZWFkIHJlcXVpcmVzDQo+ID4gYQ0KPiA+IHNtYWxsIGNoYW5nZSB0byBlYWNoIGFyY2gn
cyBwdGVfbWt3cml0ZSgpLg0KPiANCj4gSSBwbGF5ZWQgd2l0aCB0aGF0IGlkZWEgc2hvcnRseSBh
cyB3ZWxsLCBidXQgZGlzY2FyZGVkIGl0LiBJIHdhcyBub3QgDQo+IGFibGUgdG8gY29udmluY2Ug
bXlzZWxmIHRoYXQgaXQgd291bGRuJ3QgYmUgcmVxdWlyZWQgdG8gcGFzcyBpbiB0aGUNCj4gVk1B
IA0KPiBhcyB3ZWxsIGZvciB0aGluZ3MgbGlrZSBwdGVfZGlydHkoKSwgcHRlX21rZGlydHkoKSwg
cHRlX3dyaXRlKCksIC4uLiANCj4gd2hpY2ggd291bGQgZW5kIHVwIGZhaXJseSB1Z2x5IChvciBl
dmVuIGltcG9zc2libGUgaW4gdGhpbmcgc2xpa2UNCj4gR1VQLWZhc3QpLg0KPiANCj4gRm9yIGV4
YW1wbGUsIEkgd29uZGVyIGhvdyB3ZSdkIGJlIGhhbmRsaW5nIHN0dWZmIGxpa2UgZG9fbnVtYV9w
YWdlKCkgDQo+IGNsZWFubHkgY29ycmVjdGx5LCB3aGVyZSB3ZSB1c2UgcHRlX21vZGlmeSgpICsg
cHRlX21rd3JpdGUoKSwgYW5kDQo+IGVpdGhlciANCj4gY2FsbCBtaWdodCBzZXQgdGhlIFBURSB3
cml0YWJsZSBhbmQgbWFpbnRhaW4gZGlydHkgYml0IC4uLg0KDQpwdGVfbW9kaWZ5KCkgaXMgaGFu
ZGxlZCBsaWtlIHRoaXMgY3VycmVudGx5Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjMwMTE5MjEyMzE3LjgzMjQtMTItcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQoNClRo
ZXJlIGhhcyBiZWVuIGEgY291cGxlIGl0ZXJhdGlvbnMgb24gdGhhdC4gVGhlIGN1cnJlbnQgc29s
dXRpb24gaXMgdG8NCmRvIHRoZSBEaXJ0eS0+U2F2ZWREaXJ0eSBmaXh1cCBpZiBuZWVkZWQgYWZ0
ZXIgdGhlIG5ldyBwcm90cyBhcmUgYWRkZWQuDQoNCk9mIGNvdXJzZSBwdGVfbW9kaWZ5KCkgY2Fu
J3Qga25vdyB3aGV0aGVyIHlvdSBhcmUgYXJlIGF0dGVtcHRpbmcgdG8NCmNyZWF0ZSBhIHNoYWRv
dyBzdGFjayBQVEUgd2l0aCB0aGUgcHJvdCB5b3UgYXJlIHBhc3NpbmcgaW4uIEJ1dCB0aGUNCmNh
bGxlcnMgdG9kYXkgZXhwbGljaXRseSBjYWxsIHB0ZV9ta3dyaXRlKCkgYWZ0ZXIgZmlsbGluZyBp
biB0aGUgb3RoZXINCmJpdHMgd2l0aCBwdGVfbW9kaWZ5KCkuIFRvZGF5IHRoaXMgcGF0Y2ggY2F1
c2VzIHRoZSBwdGVfbWt3cml0ZSgpIHRvIGJlDQpza2lwcGVkIGFuZCBhbm90aGVyIGZhdWx0IG1h
eSBiZSByZXF1aXJlZCBpbiB0aGUgbXByb3RlY3QoKSBhbmQgbnVtYQ0KY2FzZXMsIGJ1dCBpZiB3
ZSBjaGFuZ2UgcHRlX21rd3JpdGUoKSB0byB0YWtlIGEgVk1BIHdlIGNhbiBqdXN0IG1ha2UgaXQN
CnNoYWRvdyBzdGFjayB0byBzdGFydC4NCg0KSXQgbWlnaHQgYmUgd29ydGggbWVudGlvbmluZywg
dGhlcmUgd2FzIGEgc3VnZ2VzdGlvbiBpbiB0aGUgcGFzdCB0byB0cnkNCnRvIGhhdmUgdGhlIHNo
YWRvdyBzdGFjayBiaXRzIGNvbWUgb3V0IG9mIHZtX2dldF9wYWdlX3Byb3QoKSwgYnV0IE1NDQpj
b2RlIHdvdWxkIHRoZW4gdHJ5IHRvIG1hcCB0aGUgemVybyBwYWdlIGFzIChzaGFkb3cgc3RhY2sp
IHdyaXRhYmxlDQp3aGVuIHRoZXJlIHdhcyBhIG5vcm1hbCAobm9uLXNoYWRvdyBzdGFjaykgcmVh
ZCBhY2Nlc3MuIFNvIEkgaGFkIHRvDQphYmFuZG9uIHRoYXQgYXBwcm9hY2ggYW5kIHJlbHkgb24g
ZXhwbGljaXQgY2FsbHMgdG8gcHRlX21rd3JpdGUvc2hzdGsoKQ0KdG8gbWFrZSBpdCBzaGFkb3cg
c3RhY2suDQoNCj4gDQo+IEhhdmluZyB0aGF0IHNhaWQsIG1heWJlIGl0IGNvdWxkIHdvcmsgd2l0
aCBvbmx5IGEgc2luZ2xlIHNhdmVkLWRpcnR5DQo+IGJpdCANCj4gYW5kIHBhc3NpbmcgaW4gdGhl
IFZNQSBmb3IgcHRlX21rd3JpdGUoKSBvbmx5Lg0KPiANCj4gcHRlX3dycHJvdGVjdCgpIHdvdWxk
IGRldGVjdCAid3JpdGFibGU9MCxkaXJ0eT0xIiBhbmQgbW92ZSB0aGUgZGlydHkNCj4gYml0IA0K
PiB0byB0aGUgc29mdC1kaXJ0eSBiaXQgaW5zdGVhZCwgcmVzdWx0aW5nIGluIA0KPiAid3JpdGFi
bGU9MCxkaXJ0eT0wLHNhdmVkLWRpcnR5PTEiLA0KPiANCj4gcHRlX2RpcnR5KCkgd291bGQgcmV0
dXJuIGRpcnR5PT0xfHxzYXZlZC1kaXJ0eT09MS4NCj4gDQo+IHB0ZV9ta2RpcnR5KCkgd291bGQg
c2V0IGVpdGhlciBzZXQgZGlydHk9MSBvciBzYXZlZC1kaXJ0eT0xLA0KPiBkZXBlbmRpbmcgDQo+
IG9uIHRoZSB3cml0YWJsZSBiaXQuDQo+IA0KPiBwdGVfbWtjbGVhbigpIHdvdWxkIGNsZWFuIGJv
dGggYml0cy4NCj4gDQo+IHB0ZV93cml0ZSgpIHdvdWxkIGRldGVjdCAid3JpdGFibGUgPT0gMSB8
fCAod3JpdGFibGU9PTAgJiYgZGlydHk9PTEpIg0KPiANCj4gcHRlX21rd3JpdGUoKSB3b3VsZCBh
Y3QgYWNjb3JkaW5nIHRvIHRoZSBWTUEsIGFuZCBpbiBhZGRpdGlvbiwgbWVyZ2UNCj4gdGhlIA0K
PiBzYXZlZC1kaXJ0eSBiaXQgaW50byB0aGUgZGlydHkgYml0Lg0KPiANCj4gcHRlX21vZGlmeSgp
IGFuZCBta19wdGUoKSAuLi4uIHdvdWxkIHJlcXVpcmUgbW9yZSB0aG91Z2h0IC4uLg0KDQpOb3Qg
c3VyZSBJJ20gZm9sbG93aW5nIHdoYXQgdGhlIG1rX3B0ZSgpIHByb2JsZW0gd291bGQgYmUuIFlv
dSBtZWFuIGlmDQpXcml0ZT0wLERpcnR5PTEgaXMgbWFudWFsbHkgYWRkZWQgdG8gdGhlIHByb3Q/
DQoNClNob3VsZG4ndCBwZW9wbGUgZ2VuZXJhbGx5IHVzZSB0aGUgcHRlX21rd3JpdGUoKSBoZWxw
ZXJzIHVubGVzcyB0aGV5DQphcmUgZHJhd2luZyBmcm9tIGEgcHJvdCB0aGF0IHdhcyBhbHJlYWR5
IGNyZWF0ZWQgd2l0aCB0aGUgaGVscGVycyBvcg0Kdm1fZ2V0X3BhZ2VfcHJvdCgpPyBJIHRoaW5r
IHRoZXkgY2FuJ3QgbWFudWFsbHkgY3JlYXRlIHByb3QncyBmcm9tIGJpdHMNCmluIGNvcmUgbW0g
Y29kZSwgcmlnaHQ/IEFuZCB4ODYgYXJjaCBjb2RlIGFscmVhZHkgaGFzIHRvIGJlIGF3YXJlIG9m
DQpzaGFkb3cgc3RhY2suIEl0J3MgYSBiaXQgb2YgYW4gYXNzdW1wdGlvbiBJIGd1ZXNzLCBidXQg
SSB0aGluayBtYXliZQ0Kbm90IHRvbyBjcmF6eSBvZiBvbmU/DQoNCj4gDQo+IA0KPiBGdXJ0aGVy
LCBwdGVwX21vZGlmeV9wcm90X2NvbW1pdCgpIG1pZ2h0IGhhdmUgdG8gYmUgYWRqdXN0ZWQgdG8N
Cj4gcHJvcGVybHkgDQo+IGZsdXNoIGluIGFsbCByZWxldmFudCBjYXNlcyBJSVJDLg0KDQpTb3Jy
eSwgSSdtIG5vdCBmb2xsb3dpbmcuIENhbiB5b3UgZWxhYm9yYXRlPyBUaGVyZSBpcyBhbiBhZGp1
c3RtZW50DQptYWRlIGluIHB0ZV9mbGFnc19uZWVkX2ZsdXNoKCkuDQoNCj4gDQo+ID4gDQo+ID4g
eDg2J3MgcHRlX21rd3JpdGUoKSB3b3VsZCB0aGVuIGJlIHByZXR0eSBjbG9zZSB0byBtYXliZV9t
a3dyaXRlKCksDQo+ID4gYnV0DQo+ID4gbWF5YmUgaXQgY291bGQgYWRkaXRpb25hbGx5IHdhcm4g
aWYgdGhlIHZtYSBpcyBub3Qgd3JpdGFibGUuIEl0DQo+ID4gYWxzbw0KPiA+IHNlZW1zIG1vcmUg
YWxpZ25lZCB3aXRoIHlvdXIgY2hhbmdlcyB0byBzdG9wIHRha2luZyBoaW50cyBmcm9tIFBURQ0K
PiA+IGJpdHMNCj4gPiBhbmQganVzdCBsb29rIGF0IHRoZSBWTUE/IChJJ20gdGhpbmtpbmcgYWJv
dXQgdGhlIGRyb3BwaW5nIG9mIHRoZQ0KPiA+IGRpcnR5DQo+ID4gY2hlY2sgaW4gR1VQIGFuZCBk
cm9wcGluZyBwdGVfc2F2ZWRfd3JpdGUoKSkNCj4gDQo+IFRoZSBzb2Z0LXNoc3RrIGJpdCB3b3Vs
ZG4ndCBiZSBhIGhpbnQsIGl0IHdvdWxkIGJlIGxvZ2ljYWxseQ0KPiBjaGFuZ2luZyANCj4gdGhl
ICJ0eXBlIiBvZiB0aGUgUFRFIHN1Y2ggdGhhdCBhbnkgb3RoZXIgUFRFIGZ1bmN0aW9ucyBjYW4g
ZG8gdGhlDQo+IHJpZ2h0IA0KPiB0aGluZyB3aXRob3V0IGhhdmluZyB0byBjb25zdW1lIHRoZSBW
TUEuDQoNClllYSwgdHJ1ZS4NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCBpZGVhcyBo
ZXJlLCBJJ2xsIGdpdmUgdGhlOg0KcHRlX3QgcHRlX21rd3JpdGUoc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWEsIHB0ZV90IHB0ZSkNCi4uLnNvbHV0aW9uIGEgdHJ5Lg0K
