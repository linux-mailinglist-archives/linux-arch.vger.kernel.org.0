Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CE6B5279
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjCJVC3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 16:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCJVCK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 16:02:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A3AF8A59;
        Fri, 10 Mar 2023 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678482088; x=1710018088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c/eaXsRLxa0U6fiKJVp+bOIocv4WMd0U3qGSvoRJxWI=;
  b=lK7xZh96BrfCGhY7jfc+UpoEEULmHq7vkNstbX4gyhAjn22r9TAcxVLT
   CPSsuQw7BNGYfnWrjibvPcgbupWGipZ/hcf/35KvyDkvoXil/kSe9/x8g
   wOGAswcUGRBWtgUHMqtB8MjiHkz9elg5y5+xNwCVQfzphVmzN99ax1evL
   tsXhoOwGfhqc18xudeNjNk2+55lOJxpQbe4YOMh80ZlC/FSsc3jxAPmM8
   bVxwhO1ZcPPMzr0v4suLQoYot3v7ht7x5KvGeJcCEtv3Tyhzw31NKKJsG
   LZ7wmYBro23lmobAwSgokpvg97+foYsVJsTpA5GKLnQcCx9Xexk3r1kwP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="338385072"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="338385072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="766966241"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="766966241"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2023 13:01:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 13:01:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 13:01:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 13:01:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 13:01:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frtyoXHW7ZuoKm7dooyaFIJgQRk4PdOtTBhNF8sRX6ZHLH909rABRhMFGU5TW3RKr84M94Oi7r10KH0KqFAw6lUGUnlj6naDDlnQbnZC2KaYmF1de/273Nc3A4ESRUhCSjNPJdwYzSRaVDix2b+lAT1tM0lcqv1b0K6LXhusOpRuWlIspmq7do+7pJoKrJ+YcfNDqrrPvJonKBnjI2a7PK7RU0sVn9qk16ze+9S3WZLVNqjYUEdq6Ceo7ZGpFc0yAh5KR/Iq5LtnBpUr8+mZG/+utFI5ggHI3+zalApbhrrjvFDKorcZ1QytvRuCC+yeq8mxV73ct7x3Zc5V7eg5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/eaXsRLxa0U6fiKJVp+bOIocv4WMd0U3qGSvoRJxWI=;
 b=CtqZOkJ1LQnjM8NjEjFJvzDHRgrxrpGyg1g6qlfIJnz7qoSdgIwXaH2WXLzwll9CD9KSEJXpuhYt5v8Ncpqm0aKCl0e5QbXPb8zrY7vZ06x1FAZxmkmYBGWTqo3FhBBehQcA0ETitQ6w1TMVe3Wc4eT0IBYIwl78cozwP1jVSCLv6HUXZhzFhpJ/asCDkwe4m75tfmYaz3UH+XZPQtXYft8cddaspJXfj1RuNtwCb/9y4JUToppxyF9w2XuYtv/OIhL6su3ZgZkaekx6T1h8dkSGZuSSGIQmhDQUr4mn4EC4fJlXvHfJsYjN8fESAcmbXmBrbZ4ODOXd5dEgFZzt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 21:01:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 21:01:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZSvtC0qoWAoXd0kKURn+giTskNK7wu1QAgADbO4CAAOD+AIAAQrQAgAB0BgCAABbcgIAADgKAgAEs5ICAAAdhAIAABIwAgAAFAAA=
Date:   Fri, 10 Mar 2023 21:01:21 +0000
Message-ID: <fc54eebeaf80a51da05fb220f029dea23ef0fa7a.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-29-rick.p.edgecombe@intel.com>
         <ZAhjLAIm91rJ2Lpr@zn.tnic>
         <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
         <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
         <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
         <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
         <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
         <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
         <CAMe9rOo990TPY-VDzOgGq7aN1aQUjZaWiXLRC81XTq_xqFUm9w@mail.gmail.com>
         <f020ce5ba5727dc6e25b6cc158be15e9c2ad0bee.camel@intel.com>
         <CAMe9rOqSSH06azPmGM4_oLsJO65D5F5UzZoN_GJ3+s842a9mAA@mail.gmail.com>
In-Reply-To: <CAMe9rOqSSH06azPmGM4_oLsJO65D5F5UzZoN_GJ3+s842a9mAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7540:EE_
x-ms-office365-filtering-correlation-id: 7c1f1ddb-e9ae-472d-5c66-08db21aa9a4f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Q+zfpLiMuj/RB/lEtj5xnDz+YlBLnDN3kFuOTxN554pqZ95QcB3X0KAVFJeEctuhhEsH5DXZmhgy2jKnI/INPZAZlUKKgo3v74wcQJo4aXhur+FRB1rAgDnEpYZ3PhDfU1joQEP6yEiPFYrofPTUzdzhEisMcf01mW3RQTKEHx+hOvcraXQSYNvb5zn03SgEFyWd0aV8goufkv/iG1gb84ZIQKP9T7bS3Z5E3HUyixlMsWbHqd3J1AyzwiA+s0SqJzEx8W4rwCXJTqVjn7NFl3uBCtGPJO1Av3hq/t5GAI8q2nkKA1gjMTXSI3WZ51eBOVR/R/QUu4jORPtaKIcO6x5ECVc1c3ykzRXsHVJuiJHV52i7tt5R6DU86n7osb9a/cDC3LjzEyDaeWgGfKhgunf62o6CXRutRmiRCiPDyMNg+3z2xc4ephCU1xY5+LoFRCVJRey4OqiV0G6QZ3sI2Cp+rNttP/UNlOYfsDFWUA/dANjG8o8B1gn2aF6du5POJ7yIZftqIEu1GFQbhK2TrZqLsJBifYSwD0+Gqp1QyIVE2V/vOGAdcv8dbMPgNslMsC8jp4c8i8+jCCjpx/0XloBjkhsLh9fniwGHpkQyku8aw0hKgQ+7lo4BSLl/ZtopbWJb0+pc52CpWVwgIDrtLbZ9ICbVuDCCRh4EM7hSWNXUMdOKu44cIiTpToepHcSxfv9Gljor4bZYhmSWRP3l0dtq2skniFxHIL1MXliaEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(8936002)(36756003)(6506007)(5660300002)(7406005)(26005)(6512007)(38100700002)(82960400001)(122000001)(7416002)(83380400001)(186003)(2616005)(86362001)(66556008)(54906003)(66446008)(76116006)(41300700001)(66946007)(316002)(8676002)(64756008)(4326008)(66476007)(6916009)(6486002)(71200400001)(53546011)(478600001)(38070700005)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJVNCszUHZNY1Axd3ljaHowclgzWTFVcGtieWdaMkQ4QVdYV2I1YXhNTVpH?=
 =?utf-8?B?V3pKMnZ2OHEva05iQzZ3RzJDYlJPWHFZQnROc2t5NzlsWHRzM082RVlOWldT?=
 =?utf-8?B?bjhUYU1FZ2ZlMHRwUTFYUzBRRzdrK2FhZUt2dWhZSTdFNkJiWU5hL0lTOGpo?=
 =?utf-8?B?bXIrNmdabTJ5T3pDOUhDaDZxaHF2bTlTdHhROEh5ZlNVanR5cDJqQTR4T0Ez?=
 =?utf-8?B?M3hzYVNYVHdPMEYyOTdaYnB6eW1jUjV0OHh1ZXdaV1dhYnF2SDJ5SUhwdFps?=
 =?utf-8?B?ZU9aYzExVmtyR1pneDJRNXUzdCthQURNUW5DejVXS2xDSm80MlE3K04zTXdt?=
 =?utf-8?B?aG5hVldPKzcxTk42WVhpbVRzN001RWhtc3hLTDJ0ZDJ0SmFNbzc0ZU9qNlRm?=
 =?utf-8?B?SllSU0JhbTVWNFFMKzMrN0VHc2NzdG5PZDRMeGNqRWZPR2NRZUxKdkNiSFpp?=
 =?utf-8?B?NERWRDNsb1MzeDB4VGVMSk1EcjBqaXFObWFmcGxrMDFmS1NxRXdsZlBiU3dz?=
 =?utf-8?B?dVU4c2xMdU0wL0txMEZSZVIrdW12QTBkNlNoS0pMcFJmRkxBZys0TDY5bFo1?=
 =?utf-8?B?VDdtMm1JcC9CYkNhYmhCeHRkbFh6UU1CVGJkb3pQQkNBZ001NEtpTG5XQi9m?=
 =?utf-8?B?bTBRUm82YUZEWGV1Umw2bm1OaUVWQm9SYWNMZCs2dC9PY3U0VmNyU1p2cHAw?=
 =?utf-8?B?eWpWZ1prRnQyZElnSVBYVFlhWnF4K0QrVTVHOXVrRWhScDBreS9ML1NjQjNv?=
 =?utf-8?B?ODhRWXVZV1l3VU40ei9ZUkhHWEpuaFB6azJIRG85U01xVkhhV0pRL1AzbXVR?=
 =?utf-8?B?UExXWFNvREJMMWlkQ043cFRTZmxNcW1SSklKS1U2QlN2YWVFTm9DV1JZY00x?=
 =?utf-8?B?eEVaMENVNVFMU2R2bXNWZS83ckFGRTQ0dTJ6OFVSZ3QyNkZKMldiajVCUEdq?=
 =?utf-8?B?V25DblhramtRZTg3TnVMcGVpbnp4L2N2SzZNTzVjQkFyV1dxZk4xYzQzZGUr?=
 =?utf-8?B?L1hvL2owZGNKcWVIUEdhNFZBME03bi9vMVJhRk42bXVHRjNYUlNaYTBTVmdK?=
 =?utf-8?B?bjlGOHNwSDdrb1d6TjNWNFY0eENyOEFpbGFyQ29UZU9uZDhxRTdidm5tQkpt?=
 =?utf-8?B?eXpneG1yUHNaQXc2ZTJpRlZhOXQvTDIxdWFiaC9tZ0w2OUtVTzBJN2tqb2JY?=
 =?utf-8?B?bEgrU0RvQXRyZ2dFeGlYT1luTTRHV0pLZXlzejdLdit6RmFZd0s4UFFmczR3?=
 =?utf-8?B?MEUrNzZlMUZYTGdYcE9XUGk1ZHlMcGZRU3Uxb2JUdkRuaEY3T1lhSFNlSGVs?=
 =?utf-8?B?VTVKbUNGSFlDMGNTOGg3V3BhbkRpNTVadk16SWVpSXl1NzlCWUpORUJxTDAv?=
 =?utf-8?B?RStoamNGYkRsL3EyQlpIRHZOSEVoLzkxN28yVENiL3JrQndLRkw1cnI0NzN6?=
 =?utf-8?B?bmNmMWN1V252Wk5yL2Vha1BQVkNXNTNVYmxXOUxHbUoyNHRtbFBIMStBYjBm?=
 =?utf-8?B?aGRwMG1uUnYyYjhjSXdtY29pVDFIWldLaW9rRTF6aW9kT1pTcTFuU3JwVGln?=
 =?utf-8?B?d3o4NlBiSGJtdEQ0N1IycG82cDRTVGdFaWpUMTBhL21zNW5JSVBWZUZzMGxF?=
 =?utf-8?B?MjRtakh3Ui9WSTRCN3VXSm5hK3pjUUtUT29Sb0JxZ2JJaXYxTDdLOFljTHd2?=
 =?utf-8?B?TG9VZldmRjJZQnhBQ1NScXVzeFRWL2tVUGYyaXNkMU14SnlhUlJLR0hJQ2Z3?=
 =?utf-8?B?MXg2cVdQNFBrUUlGM0xPWWFJUTBsZmo1S2NKZ2RMSlJCVTh2cU1kOEZMVEtC?=
 =?utf-8?B?L255T0E3Z1lINldvamYzQ2ZpaEF3bW1uYlM0UEJEcDhkUVFCTXJLdkxCNHRW?=
 =?utf-8?B?clJMZjdZR3JZcFRLSFJWcGs1Vlg2QUNZTUF0Z1Nma1ZLcC9aMVg3M3h6QTFM?=
 =?utf-8?B?UXlJSXUwNUJNMUpmZk5McVk4T3drVEVIOGJRZkJyMXJKK0JHejVSc0JnbnVV?=
 =?utf-8?B?ZDhZa1RMTVlRUmxxT0tOb0o3WnRCYkY1eERFZ1dVUzFxaFhZamJtL3BnVlQ2?=
 =?utf-8?B?OVlTNVhmWEEydm5DR2FzVzRFaTF3M2VnZjhjQmhZK3U5cDdzNW5QZk1sWGtj?=
 =?utf-8?B?N2pBaUR6UStKSFdHY2hERGYxOGlnYlYzZ1hKb2dJT25neVBSaGsxNUhTWWdG?=
 =?utf-8?Q?zlDIVPCvGgaa1ehfw5mOxaM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D39AAD67652B4BACE8B1CE98B24466@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1f1ddb-e9ae-472d-5c66-08db21aa9a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 21:01:21.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDsUN0ju5lMaAZCtpuG/FYBxZF5UOIocm6oWcIaxTAL28YoZBSGpqazJuwX0rtLfIfEDgtzAMiN4UP2iigfqb9QcgejUyQlGdBPS6bLS0yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDEyOjQzIC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiBPbiBG
cmksIE1hciAxMCwgMjAyMyBhdCAxMjoyNyBQTSBFZGdlY29tYmUsIFJpY2sgUA0KPiA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMy0wMy0x
MCBhdCAxMjowMCAtMDgwMCwgSC5KLiBMdSB3cm90ZToNCj4gPiA+ID4gPiBTbyBpdCBkb2VzOg0K
PiA+ID4gPiA+IDEuIEVuYWJsZSBzaGFkb3cgc3RhY2sNCj4gPiA+ID4gPiAyLiBDYWxsIGVsZiBs
aWJzIGNoZWNraW5nIGZ1bmN0aW9ucw0KPiA+ID4gPiA+IDMuIElmIGFsbCBnb29kLCBsb2NrIHNo
YWRvdyBzdGFjay4gRWxzZSwgZGlzYWJsZSBzaGFkb3cNCj4gPiA+ID4gPiBzdGFjay4NCj4gPiA+
ID4gPiA0LiBSZXR1cm4gZnJvbSBlbGYgY2hlY2tpbmcgZnVuY3Rpb25zIGFuZCBpZiBzaHN0ayBp
cw0KPiA+ID4gPiA+IGVuYWJsZWQsDQo+ID4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4gPiB1bmRlcmZs
b3cgYmVjYXVzZSBpdCB3YXMgZW5hYmxlZCBpbiBzdGVwIDEgYW5kIHdlIGhhdmUgcmV0dXJuDQo+
ID4gPiA+ID4gYWRkcmVzc2VzDQo+ID4gPiA+ID4gZnJvbSAyIG9uIHRoZSBzaGFkb3cgc3RhY2sN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgY2FuJ3QgYmUgaW1w
cm92ZWQgaW4gZ2xpYmMgdG8gbG9vaw0KPiA+ID4gPiA+IGxpa2U6DQo+ID4gPiA+ID4gMS4gQ2hl
Y2sgZWxmIGxpYnMsIGFuZCByZWNvcmQgaXQgc29tZXdoZXJlDQo+ID4gPiA+ID4gMi4gV2FpdCB1
bnRpbCBqdXN0IHRoZSByaWdodCBzcG90DQo+ID4gPiA+ID4gMy4gSWYgYWxsIGdvb2QsIGVuYWJs
ZSBhbmQgbG9jayBzaGFkb3cgc3RhY2suDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHdpbGwgdHJ5IGl0
IG91dC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEN1cnJlbnRseSBnbGliYyBlbmFibGVzIHNo
YWRvdyBzdGFjayBhcyBlYXJseSBhcyBwb3NzaWJsZS4gIFRoZXJlDQo+ID4gPiBhcmUgb25seSBh
IGZldyBwbGFjZXMgd2hlcmUgYSBmdW5jdGlvbiBjYWxsIGluIGdsaWJjIG5ldmVyDQo+ID4gPiBy
ZXR1cm5zLg0KPiA+ID4gV2UgY2FuIGVuYWJsZSBzaGFkb3cgc3RhY2sganVzdCBiZWZvcmUgY2Fs
bGluZyBtYWluLiAgIFRoZXJlIGFyZQ0KPiA+ID4gcXVpdGUgc29tZSBjb2RlIHBhdGhzIHdpdGhv
dXQgc2hhZG93IHN0YWNrIHByb3RlY3Rpb24uICAgSXMgdGhpcw0KPiA+ID4gYW4gaXNzdWU/DQo+
ID4gDQo+ID4gVGhhbmtzIGZvciBjaGVja2luZy4gSG1tLCBkb2VzIHRoZSBsb2FkZXIgZ2V0IGF0
dGFja2VkPw0KPiANCj4gTm90IEkga25vdyBvZi4gIEJ1dCB0aGVyZSBhcmUgdXNlciBjb2RlcyBm
cm9tIC5pbml0X2FycmF5DQo+IGFuZCAucHJlaW5pdF9hcnJheSB3aGljaCBhcmUgZXhlY3V0ZWQg
YmVmb3JlIG1haW4uICAgSW4gdGhlb3J5LA0KPiBhbiBhdHRhY2sgY2FuIGhhcHBlbiBiZWZvcmUg
bWFpbi4NCg0KSG1tLCBpdCB3b3VsZCBiZSBuaWNlIHRvIG5vdCBhZGQgYW55IHN0YXJ0dXAgb3Zl
cmhlYWQgdG8gbm9uLXNoYWRvdw0Kc3RhY2sgYmluYXJpZXMuIEkgZ3Vlc3MgaXQncyBhIHRyYWRl
b2ZmLiBNaWdodCBiZSB3b3J0aCBhc2tpbmcgYXJvdW5kLg0KDQpCdXQgeW91IGNhbid0IGp1c3Qg
ZW5hYmxlIHNoYWRvdyBzdGFjayBiZWZvcmUgYW55IHVzZXIgY29kZT8gSXQgaGFzIHRvDQpnbyBz
b21ldGhpbmcgbGlrZT8NCjEuIEV4ZWN1dGUgaW5pdCBjb2Rlcw0KMi4gQ2hlY2sgZWxmIGxpYnMN
CjMuIEVuYWJsZSBTSFNUSw0KDQpPciB3aGF0IGlmIHlvdSBqdXN0IGRpZCB0aGUgZW5hYmxlLWRp
c2FibGUgZGFuY2UgaWYgdGhlIGV4ZWNpbmcgYmluYXJ5DQppdHNlbGYgaGFzIHNoYWRvdyBzdGFj
ay4gSWYgaXQgZG9lc24ndCBoYXZlIHNoYWRvdyBzdGFjaywgdGhlIGVsZiBsaWJzDQp3b24ndCBj
aGFuZ2UgdGhlIGRlY2lzaW9uLg0KDQoNCg==
