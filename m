Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFF6016B7
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJQS53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQS52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 14:57:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553C75CCB;
        Mon, 17 Oct 2022 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666033043; x=1697569043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=im/VvX5cy6NYRckMpT+OCDWlBbdjlsEtJtiAP1hRLyU=;
  b=b7bAwb3y+dWpFe7NeT3uyIToYq+WbHexkpWqw3OAl+h8V3kj0z64pNgS
   XtRPdwxg0A5kmOEJAEI23qzJ5XLySxOQ+djam4sL1mg9VwxI1rS+vgCEV
   WAci5MIiY4Mkmpz7Qy+Tu4+M43SQ3hmImGI8ahVemQVI6VfYPrpT34Rzg
   f8KwGR2EbV+AK+kLJ2YJtoV14yLsABE30+kTFvVetQDckHS03SStsUEI/
   ADQiz4YVpvuG3oQWDyjLAR9BGUhzKbVyxkEf/zAOGuka36Xa0ucaXxHW7
   BpqP+ANabsHvbEcbXJuOYiHthBhWwoJEo6OZAsXzEKZR/wTPGN2CSpxeI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289189139"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289189139"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 11:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="661594293"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="661594293"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2022 11:57:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 11:57:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 11:57:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 11:57:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 11:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7AuVCoqFMqqpMlOsdKa6OR8XunLlCT8q88YFad5czDXk8pGZgxI2KGxhvg3odsZj4+L5Q04k3qRPEimn0DWw8ng/al7rZbYGncMBgxmQoSNxM0R66WAtxX1A2xl1VawG/U3Gk3f8G5Q10QXbmW9aLbJ9F4E4eUnSUyRNqqdtMr6ZNFAoc8NyLfCQ7cJh7YdmMVn+QoHelB/dfvbLIHqVxmog08Sd1nArPPTyz4eyWZ/5eVk1XdE/foLvyUQqM7NUNzzrtbYyIXPhmBwGjVfYq8J2s2N0dcJ1SQ8NwPVAhxNXJILiQhx8GuCCFm3D43Pp3zDx3jrmeo3DkvmDc1EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im/VvX5cy6NYRckMpT+OCDWlBbdjlsEtJtiAP1hRLyU=;
 b=dbm95xjr0qL9gp/DssRmmRi8QW99VA9pICnzUZBfzeJLPdKWkXKv6wQzO2LYnA4nwQZvEY9nx8mFJRXIOKljReiSeMe6hoXbX9oiAOxlfdSY52dSM8GOQqNrSVJGMt9EHyVT1EuO6nhuRCt2FA+ayXpFIxQLc4LeRPw3lEPD/y3K9ZMEyyNCuFPnoBiTRPIpiWgV1ZAXghMfBsby2qJW1GjohwpOr58r38JaJSEWYS4cpECdsrbWggQdXIN8XiPrwKVNMQoqym6liI2jUJgQ8UxRMZA46G5N9X8ZKyQD1gNNmihQtKqRaBDo/Kqv85TVtAXzk6LvREsZ36M7Npru8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 18:57:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 18:57:13 +0000
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Topic: [PATCH v2 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Index: AQHY1FMHaBGUriWTVUOSMB01kEFp5a4PTXGAgAO+cAA=
Date:   Mon, 17 Oct 2022 18:57:13 +0000
Message-ID: <ea4c2081fa1498386da52931cd19b8c495d5dc6b.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-6-rick.p.edgecombe@intel.com>
         <Y0qBiSXdZepd7Is9@zn.tnic>
In-Reply-To: <Y0qBiSXdZepd7Is9@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: 178162c6-b6c4-4b5b-89fb-08dab071670a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V13pEkmgQJFsvDZ3d3DRAWG+4gY+AcUQZFwuMoqiKQHAT1u5j0S09vSnrq8Bdl9OVxbsvTQoYA1VFw1PagN2Hffy9jFo9wpPgIDCs6KkkdqdeQ+95PyRWc3Ll1MId3Eh3Xsu42LwGyWcDnznhpzudIg1jmOFySJGBrtfXW63mko9gg2yGeYVpPt3ijQsbc8zlc347kZT1zsIeyVNmgyVP0ecfUblBVGWc69LudPTZPHs+wlTZyv6PwH0DVElp238WH+2h/HActzdA41ihhhkjYycauSzh5MZAiAJNksVOMtg/qlcY6KOYAMS22hx/lUN7FiNobxeS7dmelH0HEf5S5NPHcUzbP4G2fQ4cHB9DmACxNYXcgZ1m+FxPafKMC3lEtVxs68bOcS0uVqLkyJVbE7ZyPqoFqTZ8fDsvqNc5Wg8B7urxYN6tvFAzI0JoKv4lcp8TMmnnmPFSRlBHf3OlGfFeTCF9Z6ZrXDqADgruYYOzH6mx7VSdWqTissOakyCaUV6KDGXAX0/YorQFyuYFlxpUNJEc//qSbfWacFrX3Ggx6vdY2dVOGqSo3kVzUBYIZnb4tnOCVkPiHO5p/Z99N8dASLe02VAjyK5+rHp02g7IdaZQoHkcCbx8pO5T51uf0gopXdbF1ppV80ESFqYAq246FTz5saK/G55YODbpcn2v7BQS3fehitqaA3Vzhq/SKoboRQhaB5t8MTtnjA26LwXW2Tq7jfsjmOKawLIcEFW/nUXGt7Hx+x50dmnuZ6prsd/dnJTZwAO9l8ub501t/iZLIHcGt8hhkBwxLx/Hxs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(6916009)(66476007)(66556008)(64756008)(66946007)(66446008)(54906003)(76116006)(4326008)(8676002)(316002)(2616005)(186003)(86362001)(83380400001)(2906002)(26005)(41300700001)(6506007)(36756003)(5660300002)(7406005)(7416002)(4001150100001)(6512007)(8936002)(478600001)(6486002)(38100700002)(82960400001)(122000001)(71200400001)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhhWlBDZHRVOVpBT2YvK1VYMGpGMWVNMk5PQmlyZkZRY1QzaXBNUDJTMFdp?=
 =?utf-8?B?K0RwNi9QcGdpaUFDYXJueElsVHBIS3VKUmJ1bXZaZ0JUTmlORGFHODJpakJ3?=
 =?utf-8?B?UjdheG1OQUVoL3NMWWxwOXptS2h0dENDTC9tYjk4YlpxR016N1JuOXBaelpS?=
 =?utf-8?B?RVVZRjBDL2U4Q3JpTE5oVmZxT3hYRVo1MW56YURnaDRySXZuaHBjaHorVGpB?=
 =?utf-8?B?UGZQRDN6bEkyNlN4bzB2dndvZHVZd3h0c0RVY3hyeXhaUUNzZVhrV2Z3NlFD?=
 =?utf-8?B?QmwrUmp1Uk1tU3pReElKSm4xMnBkTmEwOVBJYXpUckZGQVBscE5uQUNqVnpl?=
 =?utf-8?B?bXRPZ2RYNDVLWi9EQVNvbEVRVkRkQWs0WGxTaWptODN3cE9tdkQ2cHVWMmpR?=
 =?utf-8?B?aHVtNXNOQkRnL29MT044YndwdE9iNHZLRG1BcFdYeWVvUXlwU3RRNkhQbXVo?=
 =?utf-8?B?UlZFaTFwMFFNOFRaVnUvNDhsbHo1S0FMb3pPbEtoQWo3VENVdUVyQm8xWm5i?=
 =?utf-8?B?VnVOYnMrcHRFQ3Y1VUx0YkZzTmR6R0JNaU1vRzhYOWhYTytlNHB6dTkrTkty?=
 =?utf-8?B?MUpkUW93YUt0YUJKY2xDWmxEcitKRTNta2tqWTAvN3lJOTZYR1FsVTNzS250?=
 =?utf-8?B?SzFLU1VBYW5pMHIyMy9MNm1KeXVOanBrVHVnNWRQVlZPNEJ4UndsUysva2F2?=
 =?utf-8?B?KzYwTk5mRXB3bVZiQXRYQjB6enBEdE5JZ1E5S2llQVlHOXZ5azNrcjdpTVg5?=
 =?utf-8?B?S1ZiTFhIWWpIKzdNaUd4c0xwc0xhcDMwdWduUDVYaU9pejFxMjhzeVJ2UUk4?=
 =?utf-8?B?RlYzUkhjVjhnd0JYVXhNMDRQdnJDczRBV05RZlR5UzJUZmU0blNlNU1US2lY?=
 =?utf-8?B?MUFiQ3hqcXJGSXVLY0hSbTR6TDNHYm0vZDBHMzNPVlZTeUV4UlFPdkp1MFk3?=
 =?utf-8?B?aXZySk9KMlNEdGRESHFZNXRrakVKQTZxTnMyWld5V0dqQkw3NGxSZlkvVkRV?=
 =?utf-8?B?V0hVOUdVcDhkYU5DWmZlMkhOeVJkMExaVTlkVWNpSUNvU1k3dGNxMVpINUpC?=
 =?utf-8?B?THlaaFN0eVk3STcrSkdvNXBoT1pwMlMyVVFHNyttNlF3M1d0dlJyK1V3MHFk?=
 =?utf-8?B?aFp3ekZNaHNJYWxobjY4N0FNMjFzWnMvWGF6Wm5lTGY5VEhWaGVZVmdHWVlk?=
 =?utf-8?B?SGpHSHBrcUZLdStPNThqOFJWckczK3dEdEQ5bWtkRGt5YnFQbmlNT2liVjlF?=
 =?utf-8?B?YkpCd1c3NjdXOUVtbDJGNWhES2VYbDlzMXduV05YcFN2cjZHKzRJU3hjbDMy?=
 =?utf-8?B?NTlyNDdoZFNnWFNGSXJNTnFMSGZiZEhGTmllTmFaejNxd01HVzZMRGowUFpn?=
 =?utf-8?B?NkphZzFzNHpOTXU3T1BWZ0FZODhDa25uakdxSGNoa0tYOTc5bDQ4MGdBYTBB?=
 =?utf-8?B?YS9ia0N6WjJEU3FEUHNGcVo2Yno2UGJhaTNTTmJwMEkzTk5XMmlWQXZLSVlq?=
 =?utf-8?B?V1M3V1lYRVBucERJRko2NitDbHgxSUczMXJsTXlETzRDTHpYdkZ2eVBDejRO?=
 =?utf-8?B?WFpOaTN1ZERsenVhQTVtNzZRUnVUWlFGQ1ZURXJQWEROOGVKTndBdnpoNWsw?=
 =?utf-8?B?dDJTTDUyeVJZZFdEbW1zUmhwYmtNS3ZXUHhyQ0wvTWxyQ2NyL0xnYVJxUzlL?=
 =?utf-8?B?RENxL2g1RmdjT1dZR1pIeGczSmdFRXp2ZU5CQW5zeGVsNTdySmtYZVkyOFVD?=
 =?utf-8?B?Q0RZTUpXczR1d1F4SDFNMHNYWXZJdGUwMCtZVDkwZVZra0phTEl0Rzc3d0Ez?=
 =?utf-8?B?bDE3ZjFQc0hZaUNtUmhXNmUvR2E1MUo4QTNQMEFkTXk2YXZMdFVJdVdqNXdB?=
 =?utf-8?B?MC9tc01TUndEaytIUmhoc0EyNnBBUXpSVXkxUm5Eb0JqUmdYT0xzTUloYWJa?=
 =?utf-8?B?bk1Qb0kwOHV5TjBpMGdYbDFpTlJFdTBBeVVjL2NGUGlDeFovRFNBR25vTjBT?=
 =?utf-8?B?bFJPdEFwb09QOGFUcEIyaTNZZTZiV2I5NzFucmN0WDcvWFluamdHWVlPT1Rk?=
 =?utf-8?B?VmxZU01xdGtzRGxVcTMrbnYwb0ROdlJHQUU3clJ3dDFmblNqaE9sSlNOYWM4?=
 =?utf-8?B?azRBdkthNDBwUnNuNWlVVjh5SDA4TWdlUFRycmx6QlhHeG1xOUhjcnpwNk9t?=
 =?utf-8?Q?/L02LoP9VZnBNajSgAJJL4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A49DDA974264C741B50F710D7F442CCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178162c6-b6c4-4b5b-89fb-08dab071670a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 18:57:13.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2n3svGincdjgJJ4mwYnYuBhGbAcWeGHq5upKjizS7naZFfmmiIt5890282emgVFY/m+29347zJAy5332Ztni2dLBqHXcq+yKzoi+D7+R0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIyLTEwLTE1IGF0IDExOjQ2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjAyUE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEJvdGggWFNBVkUgc3RhdGUgY29tcG9uZW50cyBhcmUgc3VwZXJ2aXNv
ciBzdGF0ZXMsIGV2ZW4gdGhlIHN0YXRlDQo+ID4gY29udHJvbGxpbmcgdXNlci1tb2RlIG9wZXJh
dGlvbi4gVGhpcyBpcyBhIGRlcGFydHVyZSBmcm9tIGVhcmxpZXINCj4gPiBmZWF0dXJlcw0KPiA+
IGxpa2UgcHJvdGVjdGlvbiBrZXlzIHdoZXJlIHRoZSBQS1JVIHN0YXRlIGEgbm9ybWFsIHVzZXIg
KG5vbi0NCj4gPiBzdXBlcnZpc29yKQ0KPiANCj4gXl5eXl4NCj4gDQo+IEEgdmVyYiBpcyBtaXNz
aW5nIGluIHRoYXQgc2VudGVuY2UuDQoNCk9vcHMgeWVzLg0KDQo+IA0KPiA+ICsJIng4NyBmbG9h
dGluZyBwb2ludCByZWdpc3RlcnMiCQkJLA0KPiA+ICsJIlNTRSByZWdpc3RlcnMiCQkJCQksDQo+
ID4gKwkiQVZYIHJlZ2lzdGVycyIJCQkJCSwNCj4gPiArCSJNUFggYm91bmRzIHJlZ2lzdGVycyIJ
CQkJLA0KPiA+ICsJIk1QWCBDU1IiCQkJCQksDQo+ID4gKwkiQVZYLTUxMiBvcG1hc2siCQkJCSwN
Cj4gPiArCSJBVlgtNTEyIEhpMjU2IgkJCQkJLA0KPiA+ICsJIkFWWC01MTIgWk1NX0hpMjU2IgkJ
CQksDQo+ID4gKwkiUHJvY2Vzc29yIFRyYWNlICh1bnVzZWQpIgkJCSwNCj4gPiArCSJQcm90ZWN0
aW9uIEtleXMgVXNlciByZWdpc3RlcnMiCQksDQo+ID4gKwkiUEFTSUQgc3RhdGUiCQkJCQksDQo+
ID4gKwkiQ29udHJvbC1mbG93IFVzZXIgcmVnaXN0ZXJzIgkJCSwNCj4gPiArCSJDb250cm9sLWZs
b3cgS2VybmVsIHJlZ2lzdGVycyAodW51c2VkKSIJLA0KPiA+ICsJInVua25vd24geHN0YXRlIGZl
YXR1cmUiCQkJLA0KPiA+ICsJInVua25vd24geHN0YXRlIGZlYXR1cmUiCQkJLA0KPiA+ICsJInVu
a25vd24geHN0YXRlIGZlYXR1cmUiCQkJLA0KPiA+ICsJInVua25vd24geHN0YXRlIGZlYXR1cmUi
CQkJLA0KPiA+ICsJIkFNWCBUaWxlIGNvbmZpZyIJCQkJLA0KPiA+ICsJIkFNWCBUaWxlIGRhdGEi
CQkJCQksDQo+ID4gKwkidW5rbm93biB4c3RhdGUgZmVhdHVyZSIJCQksDQo+IA0KPiBXaGF0IEtl
ZXMgc2FpZC4gOikNCg0KU3VyZSwgSSdsbCBhZGp1c3QgdGhlIGNvbW1hLg0KDQo+IA0KPiA+ICsJ
WENIRUNLX1NaKCZjaGtlZCwgc3osIG5yLCBYRkVBVFVSRV9ZTU0sICAgICAgIHN0cnVjdA0KPiA+
IHltbWhfc3RydWN0KTsNCj4gPiArCVhDSEVDS19TWigmY2hrZWQsIHN6LCBuciwgWEZFQVRVUkVf
Qk5EUkVHUywgICBzdHJ1Y3QNCj4gPiBtcHhfYm5kcmVnX3N0YXRlKTsNCj4gPiArCVhDSEVDS19T
WigmY2hrZWQsIHN6LCBuciwgWEZFQVRVUkVfQk5EQ1NSLCAgICBzdHJ1Y3QNCj4gPiBtcHhfYm5k
Y3NyX3N0YXRlKTsNCj4gPiArCVhDSEVDS19TWigmY2hrZWQsIHN6LCBuciwgWEZFQVRVUkVfT1BN
QVNLLCAgICBzdHJ1Y3QNCj4gPiBhdnhfNTEyX29wbWFza19zdGF0ZSk7DQo+ID4gKwlYQ0hFQ0tf
U1ooJmNoa2VkLCBzeiwgbnIsIFhGRUFUVVJFX1pNTV9IaTI1Niwgc3RydWN0DQo+ID4gYXZ4XzUx
Ml96bW1fdXBwZXJzX3N0YXRlKTsNCj4gPiArCVhDSEVDS19TWigmY2hrZWQsIHN6LCBuciwgWEZF
QVRVUkVfSGkxNl9aTU0sICBzdHJ1Y3QNCj4gPiBhdnhfNTEyX2hpMTZfc3RhdGUpOw0KPiA+ICsJ
WENIRUNLX1NaKCZjaGtlZCwgc3osIG5yLCBYRkVBVFVSRV9QS1JVLCAgICAgIHN0cnVjdA0KPiA+
IHBrcnVfc3RhdGUpOw0KPiA+ICsJWENIRUNLX1NaKCZjaGtlZCwgc3osIG5yLCBYRkVBVFVSRV9Q
QVNJRCwgICAgIHN0cnVjdA0KPiA+IGlhMzJfcGFzaWRfc3RhdGUpOw0KPiA+ICsJWENIRUNLX1Na
KCZjaGtlZCwgc3osIG5yLCBYRkVBVFVSRV9YVElMRV9DRkcsIHN0cnVjdA0KPiA+IHh0aWxlX2Nm
Zyk7DQo+ID4gKwlYQ0hFQ0tfU1ooJmNoa2VkLCBzeiwgbnIsIFhGRUFUVVJFX0NFVF9VU0VSLCAg
c3RydWN0DQo+ID4gY2V0X3VzZXJfc3RhdGUpOw0KPiANCj4gVGhhdCBsb29rcyBzaWxseS4gSSB3
b25kZXIgaWYgeW91IGNvdWxkIGRvOg0KPiANCj4gCXN3aXRjaCAobnIpIHsNCj4gCWNhc2UgWEZF
QVRVUkVfWU1NOglYQ0hFQ0tfU1ooc3osIFhGRUFUVVJFX1lNTSwgc3RydWN0DQo+IHltbWhfc3Ry
dWN0KTsJICByZXR1cm47DQo+IAljYXNlIFhGRUFUVVJFX0JORFJFR1M6CVhDSEVDS19TWihzeiwg
WEZFQVRVUkVfQk5EUkVHUywNCj4gc3RydWN0IG1weF9ibmRyZWdfc3RhdGUpOyByZXR1cm47DQo+
IAljYXNlIC4uLg0KPiAJLi4uDQo+IAlkZWZhdWx0Og0KPiAJCS8qIHRoYXQgZmFsbHMgaW50byB0
aGUgV0FSTiBldGMgKi8NCj4gDQo+IGFuZCB0aGVuIHlvdSBnZXQgcmlkIG9mIHRoZSBpZiBjaGVj
ayBpbiB0aGUgbWFjcm8gaXRzZWxmIGFuZCBsZWF2ZQ0KPiB0aGUNCj4gbWFjcm8gYmUgYSBkdW1i
LCB1bmNvbmRpdGlvbmFsIG9uZS4NCj4gDQo+IEhtbW0uDQo+IA0KDQpIbW0geWVhLiBBbm90aGVy
IHJlYXNvbiB0aGUgYWN0dWFsIGRlZmluZSBpcyBwYXNzZWQgaW4gaXMgdGhhdCB0aGUNCm1hY3Jv
IHdhbnQncyB0byBzdHJpbmdpZnkgdGhlIFhGRUFUVVJFIGRlZmluZSBpbiBvcmRlciB0byBnZW5l
cmF0ZSB0aGUgDQptZXNzYWdlIGxpa2UgdGhpczoNClhGRUFUVVJFX1lNTTogc3RydWN0IGlzIDEy
MyBieXRlcywgY3B1IHN0YXRlIGlzIDQ1NiBieXRlcw0KDQpUaGUgZXhhY3QgZm9ybWF0IG9mIHRo
ZSBtZXNzYWdlIGlzIHByb2JhYmx5IG5vdCB0b28gY3JpdGljYWwgdGhvdWdoLiBJZg0KaW5zdGVh
ZCBpdCB1c2VkIHhmZWF0dXJlX25hbWVzW10sIGl0IGNvdWxkIGJlOg0KW0FWWCByZWdpc3RlcnNd
OiBzdHJ1Y3QgaXMgMTIzIGJ5dGVzLCBjcHUgc3RhdGUgaXMgNDU2IGJ5dGVzDQoNClRoZSBmdWxs
IGJsb2NrIGxvb2tzIGxpa2UgKGxpa2UgeW91IGhhZCk6DQpzd2l0Y2ggKG5yKSB7DQpjYXNlIFhG
RUFUVVJFX1lNTToJICByZXR1cm4gWENIRUNLX1NaKHN6LCBuciwgc3RydWN0IHltbWhfc3RydWN0
KTsNCmNhc2UgWEZFQVRVUkVfQk5EUkVHUzoJICByZXR1cm4gWENIRUNLX1NaKHN6LCBuciwgc3Ry
dWN0DQptcHhfYm5kcmVnX3N0YXRlKTsNCmNhc2UgWEZFQVRVUkVfQk5EQ1NSOgkgIHJldHVybiBY
Q0hFQ0tfU1ooc3osIG5yLCBzdHJ1Y3QNCm1weF9ibmRjc3Jfc3RhdGUpOw0KY2FzZSBYRkVBVFVS
RV9PUE1BU0s6CSAgcmV0dXJuIFhDSEVDS19TWihzeiwgbnIsIHN0cnVjdA0KYXZ4XzUxMl9vcG1h
c2tfc3RhdGUpOw0KY2FzZSBYRkVBVFVSRV9aTU1fSGkyNTY6ICByZXR1cm4gWENIRUNLX1NaKHN6
LCBuciwgc3RydWN0DQphdnhfNTEyX3ptbV91cHBlcnNfc3RhdGUpOw0KY2FzZSBYRkVBVFVSRV9I
aTE2X1pNTToJICByZXR1cm4gWENIRUNLX1NaKHN6LCBuciwgc3RydWN0DQphdnhfNTEyX2hpMTZf
c3RhdGUpOw0KY2FzZSBYRkVBVFVSRV9QS1JVOiAJICByZXR1cm4gWENIRUNLX1NaKHN6LCBuciwg
c3RydWN0IHBrcnVfc3RhdGUpOw0KY2FzZSBYRkVBVFVSRV9QQVNJRDogCSAgcmV0dXJuIFhDSEVD
S19TWihzeiwgbnIsIHN0cnVjdA0KaWEzMl9wYXNpZF9zdGF0ZSk7DQpjYXNlIFhGRUFUVVJFX1hU
SUxFX0NGRzogIHJldHVybiBYQ0hFQ0tfU1ooc3osIG5yLCBzdHJ1Y3QgeHRpbGVfY2ZnKTsNCmNh
c2UgWEZFQVRVUkVfQ0VUX1VTRVI6CSAgcmV0dXJuIFhDSEVDS19TWihzeiwgbnIsIHN0cnVjdA0K
Y2V0X3VzZXJfc3RhdGUpOw0KY2FzZSBYRkVBVFVSRV9YVElMRV9EQVRBOiBjaGVja194dGlsZV9k
YXRhX2FnYWluc3Rfc3RydWN0KHN6KTsgcmV0dXJuDQp0cnVlOw0KZGVmYXVsdDoNCglXQVJOX09O
Q0UoMSwgIm5vIHN0cnVjdHVyZSBmb3IgeHN0YXRlOiAlZFxuIiwgbnIpOw0KCVhTVEFURV9XQVJO
X09OKDEpOw0KCXJldHVybiBmYWxzZTsNCn0NCg0KSSBsaWtlIGhvdyBpdCBmaXRzIHRoZSBYRkVB
VFVSRV9YVElMRV9EQVRBIGNoZWNrIGluIHdpdGggdGhlIHJlc3QuDQoNClRoYW5rcyENCg==
