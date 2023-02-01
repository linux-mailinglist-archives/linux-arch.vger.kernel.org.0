Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D20686D1A
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 18:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBARd4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 12:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBARdy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 12:33:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B26FD20;
        Wed,  1 Feb 2023 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675272810; x=1706808810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a1IYnDnv1XNsuG7Ehf9QHczsT/ccUWIHiKAfEejmcIc=;
  b=bcBuOO3bW+N/Csfzz8ezqfIxYq0fUxILeFNc4wdylOuhQ/lmPUGGqG9K
   2Vk4frU+0x1OOX88m5EGQm4yHPCgcWBBirfNUXmDEnkUiJZ+4MjCcCQ2P
   8IV0Cl4gSnnY4PfK03pyXYgYM8ZfemJPoNWuItQhrVk07JNP4ZzjCmLtg
   1FjRdP7jyTgL2Q6qyeP5BDftZvb81Uddi0dAORvfDZ0uEBv96niZ9m0ne
   gBe9IQY/k9m3TODEB1bGTcD2FPx/wJI9AvPy/JZNCpW6oQuv2/X4nU4Qn
   Qg919Dce7pdW44YMsZAni3zKnWbXAwOvmPd1mp66e3tbEj+yFPkV+/5YX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390604707"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390604707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="753751277"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="753751277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2023 09:32:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 09:32:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 09:32:50 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 09:32:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks7sdbkLWMqGuSGxM0IpIPtMi4dF2ICA25HeSlpZGMoL+9NLkO0ldMbP3xFaqCnCh6e5yXMsOQ6JDeC5757rXtNj/FjlEwA7Er4Y1X8sSyL/XZRzHB/y1SN7tJ9jXMCfJIDT+O/YxJuy1egRjql16GTxB35x3GnlQMzWJA9f8Z9NcfnXQZphRuab3uwpobMfT0qjPw3clpbGzOjZ2CTK80HJ9estnHiXkYPaOrqY1WZuWoJXi+0qIiSb3rGQw1kNrXdxGcNUKYmfBh8GrIQO8tdLclMQFiVkGjXKRWgLHYDZNEk1b8neIS2yoik15yTOp7MifZWuqrtyAJ0QhXCgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1IYnDnv1XNsuG7Ehf9QHczsT/ccUWIHiKAfEejmcIc=;
 b=fcQvhCXT3M5E0DdszPO58EdtvHiH9twfGbJYjt7MPNgl+8P9Q7AhIe9nJjXIkivHLcCcvsQUzbi6BaltHBcTr5ijiLEVlwFVNYHFwOG/O4gqr80jDx8/vdcJmJ6VNkj5XfZpEk05hD8Pmoa/LKCgIy5q2cSJtNIG3tI5CwVilharL9QI7qf6HPI5yZnjhnEkvMQ49i+TBLY4vTMJNPRGJH4wWLfQs5I9YDwb1L42G+dxCuXTnmLZQBvFeYbU3HnO8g0iXRxcFh18H7TXqamVzaGQDV0XW8u3DZ+ZSud9am1RaMHbCBBXAU65/vrvJYb4LvAsc5IblJ3DEHT1ClqrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO6PR11MB5601.namprd11.prod.outlook.com (2603:10b6:303:13d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Wed, 1 Feb
 2023 17:32:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 17:32:30 +0000
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
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
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4CAAUjWAIAAHt0AgAD++ACAAJuKAIAAaOSAgACChICAAMGNAIABTW0AgACQ4gCABTvWgIAA99iAgACfS4CAAI4qgA==
Date:   Wed, 1 Feb 2023 17:32:30 +0000
Message-ID: <f55d9563c432db15f8a768381103abe8e986a42b.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
         <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
         <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
         <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
         <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
         <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
         <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
         <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
         <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
         <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
         <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
         <0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com>
         <f337d3b0e401c210b67a6465bf35f66f6a46fc3d.camel@intel.com>
         <a4857ccd-1d5f-2169-40bc-e7a75a0c896f@redhat.com>
In-Reply-To: <a4857ccd-1d5f-2169-40bc-e7a75a0c896f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO6PR11MB5601:EE_
x-ms-office365-filtering-correlation-id: af69c95a-d672-43b9-5501-08db047a4b62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4AuPQtUs4aXVm+GewFGtkzHNMEs3aMHks8lIMFKgVYSTriU8dY/ycUHYqT89B1OwVVmQHFjZVUcyIMHt6nmRCD03VuHXIFHj//2Pui221uGs3bWVawy7MOU+APxEFVrY3Vzac2UO3VybNe4DjPV5nXm7FgIQO0b9eU7kCAQu8J+CahAOIITaClom4tlYMMv5Y+yeXXZEHjwBnIs7thcNxL4oPXwLJ/WX+qYEnXty3GvORP4xKjsPkCdEVqw9lHvzKoEwGWsFjliiTywi4zRzt4BO5FJumEBl7KwKNpDl3ThWr4nySyr5LsvjyPu4QowqtJ2DWmf3SnuEfXCKWHueUk9hIofu6T6eb6yYFmSi8xIJ9si5u4pT1eTeXswYpl8M5Nfomjms7omvzGaRO1ycD1HVC0pPD3lUyakATtshWYTy1xxAVMDIrMJYUr9/vuGySYN7AM9HnqguEa/qT1/JzX/gS/gERc4gY4255ag9aPtmtRI0ISIfx/ZARqzHbx9kupCMZp7eP1+hmgDH7B7fitPIUS/a6JQgZymzrosgKd65riBRMneQV3eFap5Wh41+UXlLkyYji1Z1PjrqBunoYgKgMYWF9PniyF0SXzNCGNo8oSSihbydQhiyw/9LWQVFgHuvd9MV2uehAx8J117AMot1qCzRfH5PKV+TFP020bOlFfNDbezTaBsWC4kGiQ8aN7LmpfmqcgfMHBuKujc5SUOeC0iDm4WSGypd7+Al0lBQl1vdJwM0JRKqdzXbZfpTqeMsxhY4tqcabw9Y/r9NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199018)(2616005)(2906002)(110136005)(478600001)(6486002)(4744005)(71200400001)(5660300002)(7416002)(7406005)(122000001)(38100700002)(82960400001)(8936002)(921005)(316002)(38070700005)(36756003)(86362001)(6512007)(76116006)(66446008)(66476007)(66556008)(4326008)(64756008)(8676002)(41300700001)(6506007)(66946007)(26005)(186003)(91956017)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ti9KejFZay9qbmEwSmJRZm1qaVdtaVVsRTVJLzhobndsYlJrQU5uV09iVHlz?=
 =?utf-8?B?WlZueWhlMW9keUdxT1pxZ2Z3TmdhTHJsdmsxMUsxcWFwQkZvSWxkR1pONUVu?=
 =?utf-8?B?anBlVjNseHNjeXZ6MUNwOC9uVXpDT25zNG15ZkE4NStxNXZvbU9uU1d0R241?=
 =?utf-8?B?Ymc3RmRvNW8wRnVRVHhiQWVzWjMxYUQvai96SW5pbk4wVHo1RnZtSE5veVpU?=
 =?utf-8?B?elNVUU96bmRkb2k0aU5XRGxsckNpTjBJemFYY2tCM25xQmNMZGhWeFdIZEg4?=
 =?utf-8?B?VFJHQ0duTEFtREpWSmFnOE5WdTM3cEFwT0kxRTZjdHRGWW8xOWtmTnFWKzRO?=
 =?utf-8?B?YlRxQWlVTk0wVVVjT1drR3kxRkthQW5hWWJEMGhEZEZaUis4ZnhrekZIblFu?=
 =?utf-8?B?MnFraHMrWS9DWGluNTg4b0ttY2FNelJrMVgrcUhKcmYrOFFPcG8rVGRwWHJI?=
 =?utf-8?B?a1hkdGVDZGQ2dnU1NW5WQlA1cXltbk5uTFdJQmdPbXZFbE9BYTQ5bjdQQWFV?=
 =?utf-8?B?Skl6dURJN2dhOExoRHhjMlpIWTdQS2tTWUsxZ1lIQmFrSTVvTDZhQzhjUVZh?=
 =?utf-8?B?eFlyOWFYL0xRU0VaZlNGRExxK0ZKelNpT2g5eVp2bytWRnpJYjRDenVrNnEy?=
 =?utf-8?B?UkZOZ09aOTBNVkxkbDNNUDhzeU9GSGpPUEN4NVhkMUpsNnVmTG5PVmV6S1Aw?=
 =?utf-8?B?WmdpbUtQUTVoNTJlY21UTjhpU2JTWjBaNzl2Z25zNzdqN3FpWmJGdlVSdktZ?=
 =?utf-8?B?cFVpeVY1c0JZeTVGa1dneFhxKzdZUThublFEcXE5ZGFMc2pUcE5yMm1NTmNr?=
 =?utf-8?B?eExwOUhpZG9nYjZtU1U5aUVINHFKQWZzazVZNVc1SjdyUllPMVNtR0FxZzQv?=
 =?utf-8?B?eVZFR0NIZDRac0xDNWkyaGQvVEN5MzkzMDlQRG85MXVTUEk3cFZnc2VhL2hW?=
 =?utf-8?B?cjFqeXYyNXVuSi8zbWd0Vnd0NkNubHB3UC9xVTBiZkVQMFpheTNjQWp1K2lp?=
 =?utf-8?B?T09oRXUzSEx0ZU9VMEFJbXVyKzJoRU9hdnhWUms0dWQyMTRsYjJSRSsyc3Fu?=
 =?utf-8?B?SWxKcFlCSVdGK3JTcWs5OWFlNjRqdVFMNng3YzViZWdCLzEydVNzb00rc3BF?=
 =?utf-8?B?RzloWXdkc1FzUGxzWFhVMXN6WU5VYUw3QmMxd2ZhU0N1c3czeEU5NTFhWTNN?=
 =?utf-8?B?djBJOUd3ajFpNFprci9GYXRCTXVIY29aVXpUZi84M2RseTNKUmlkNHZsQkNo?=
 =?utf-8?B?amY2TktDYnBDaVk4L3BQV0dEckRjaktnS3RiSlMrOStOMVpCR3NuTEpvT3Ez?=
 =?utf-8?B?OVIrN0R0Vkhjak16a000cDBqT2NMY1BUK2FRdU90c0ZCZWVwZHQraXB2d3Ay?=
 =?utf-8?B?bTY5OEV5cEtleG5ZSUU1OW9iZS82emVudVlQa2pMQlo5RXRLMjZ5dzRUUFdE?=
 =?utf-8?B?ditkSUVZSmpNOHFITi8zTHpFNUVZa2V1eEI5dEphQmtXQ1l3ei9jWUxLL29v?=
 =?utf-8?B?angxNmw5eXdJYi9mYUZWakxIL1d1YmpSMitCVzZER0dSak1wblBIR25xNS9a?=
 =?utf-8?B?OFZTa2dnT0UvaDh1K0psZ2lhaUJpTnZWZ3Jndi9GU3ZnczJlbE0zSzh4KzUr?=
 =?utf-8?B?QUVaMGJpZW40QmZKeXRac05yMm1ZZ1J5SUZWbFpYTWhXd2xHdEZsYXBiU1hU?=
 =?utf-8?B?UHNwb2J6SERsREFyOVVPNmc2d21yREhHTnBzS0NOWE50K2NGdFZYSEcvTWdl?=
 =?utf-8?B?alJ5dDh0TENGbm9uOW0xbUN4VkFjZHNYQ2RpM3MzbGptcStWSEpOL09uM0JM?=
 =?utf-8?B?M0tUVDJkSVVQNEJoU1IwODJUaUFUeW1pQTg2azRnWjY0WnVxTVl0eElMR3V5?=
 =?utf-8?B?MVFndFBFRU1MUmVFUFRIVUMrTkljNUt1MGV6bHliZGduaU9pZTB0KzlSaWc2?=
 =?utf-8?B?NEJYbnhCYnVmTktCOUVTM2Q4NzhuaWRWUTAzTDl1QnNyaXdNTmIrUnE2MmdS?=
 =?utf-8?B?SEF5V3plN1JPcXRHTnB6bmlob3AwTVFaVWhCc3M4bllaNWpOZDJnOGZNSzh5?=
 =?utf-8?B?MXZaZW1Eb21oMW1TdTJTQ1dleXNrU3llMytoQnErU1QrUExTWVBOSytRQTZX?=
 =?utf-8?B?S29GR3JpZlhnK0VOWTBhVXhtTWc4RjJSTzgvYm5Fak1FY3RxMzlBY0EzRERw?=
 =?utf-8?Q?KkZQqEkK2GlQ9r2/E3nJo2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23E7278D81C5EA4CB3227247B548C6F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af69c95a-d672-43b9-5501-08db047a4b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 17:32:30.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpxLm0T7izy8er1mucRx5BUu2xfZFwtPYOszRGtszJ7X6qM5DV/yOLUKhFqR3L43Z9PUiIBQQcmvXNPxefJH/L0YtKeM0CySvRdLWzsyPu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDEwOjAzICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gPiANCj4gPiBUaGUgb3RoZXIgcHJvYmxlbSBpcyB0aGF0IG9uZSBvZiBOVUxMIHBhc3Nl
cnMgaXMgbm90IGZvciBrZXJuZWwNCj4gPiBtZW1vcnkuDQo+ID4gaHVnZV9wdGVfbWt3cml0ZSgp
IGNhbGxzIHB0ZV9ta3dyaXRlKCkuIFNoYWRvdyBzdGFjayBtZW1vcnkgY2FuJ3QNCj4gPiBiZQ0K
PiA+IGNyZWF0ZWQgd2l0aCBNQVBfSFVHRVRMQiwgc28gaXQgaXMgbm90IG5lZWRlZC4gVXNpbmcN
Cj4gPiBwdGVfbWt3cml0ZV9rZXJuZWwoKSB3b3VsZCBsb29rIHdlaXJkIGluIHRoaXMgY2FzZSwg
YnV0IG1ha2luZw0KPiA+IGh1Z2VfcHRlX21rd3JpdGUoKSB0YWtlIGEgVk1BIHdvdWxkIGJlIGZv
ciBubyByZWFzb24uIE1heWJlIG1ha2luZw0KPiA+IGh1Z2VfcHRlX21rd3JpdGUoKSB0YWtlIGEg
Vk1BIGlzIHRoZSBiZXR0ZXIgb2YgdGhvc2UgdHdvIG9wdGlvbnMuDQo+ID4gT3INCj4gPiBrZWVw
IHRoZSBOVUxMIHNlbWFudGljcy4uLiAgQW55IHRob3VnaHRzPw0KPiANCj4gV2VsbCwgdGhlIHJl
YXNvbiB3b3VsZCBiZSBjb25zaXN0ZW5jeS4gRnJvbSBhIGNvcmUtbW0gcG9pbnQgb2Ygdmlldw0K
PiBpdCANCj4gbWFrZXMgc2Vuc2UgdG8gaGFuZGxlIHRoaXMgYWxsIGNvbnNpc3RlbmN5LCBldmVu
IGlmIHRoZSBzaW5nbGUgdXNlciANCj4gKHg4Nikgd291bGRuJ3Qgc3RyaWN0bHkgcmVxdWlyZSBp
dCByaWdodCBub3cuDQo+IA0KPiBJJ2QganVzdCBwYXNzIGluIHRoZSBWTUEgYW5kIGNhbGwgaXQg
YSBkYXkgOikNCg0KT2ssIEknbGwgZ2l2ZSBpdCBhIHNwaW4uDQo=
