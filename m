Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255076B1589
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 23:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCHWtC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 17:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCHWs6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 17:48:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDEBC888B;
        Wed,  8 Mar 2023 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678315709; x=1709851709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LgUEu4Zo/KVEIJbJYm9r6QLpMjo20g6+KaJsK8WL0jo=;
  b=ABWE/JuI/yJ0lhvht2kTcxh2bKPqaAmpwYbvrPRz/NCLuOJRwywUg+JB
   yVqrfAbKqUUhWShL/X2x67LrZvd1049USeWvAyxM/js9X1/dyjbpnGYDI
   9Urs3biBOHD2cHs1caiego6Ms2HMi6QYG1TIiT6fd/+NNnU6Bt1TJfWLo
   iCEdkoifCC1xm3oJWYmf4yjTb34RczqhpcIDHiX3UiPzh/sDABsJgqk3Z
   xj/aLUIZ1VUgRC7pQhbhsdlKSHoKCj8HZQkQKPAKZNmhiRP633m3YYIVr
   eN3DuFM0u8IkKR/PoSUytRn7S5iN3XUoEAKfYxZRwgSIjIZ+ZFOrBECbX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335000201"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="335000201"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 14:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="654521161"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="654521161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2023 14:48:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 14:48:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 14:48:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 14:48:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 14:48:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQz+0QVEUaTbbXzuwq6/AVha2D5mdty61WhHIFYBj4BD4KpSM8MRA2kvv3VQMrzz6KIgL7JaF95HJ7NoRvbyYIiv2e5reApwCdCwBZbwmFKTycTeMEIzzwYAKp724/89zwir2I39LcwilRwLslW4GfIUsnRi8J8VdnyH052L77FXQhUQ9nlpt6YkqK4WAdi24N1qtMVZZHLskZ74z7XvkgxvGrWWfhm541dBnz9tDg6F8ySmscKNNhiKQhKs2A1uQ3U/BgBcSbxMhlmkvoZKRjhc2CM3CdrQIPhipZSvBhajq+HsHWsjCiAASxD5xbiCkyy2JZJeQexEaWAx1u5AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgUEu4Zo/KVEIJbJYm9r6QLpMjo20g6+KaJsK8WL0jo=;
 b=jXwbH/Eys6qDM6FiaDLajqZruG5dOZZCeywnqVeYBwtSVkcz7ULoeVSkiUpV+ZdFDUVRE42g9olskypimsqRJ/YnPmmUyLjd22X5FJrOw4qNQj0WJk8q5P8JMAa/QWg0AES8ZyS+l/v4tJCMd3ayAgnU2psfN4dKC0ZfbucJhwWVt0tJce6STq9jlkonMw23dQvRYKMSrJfm8vXsnRURcKos/V1gQQQf3yST9FS5zb5fP+coydLf3qqpQCWewUq7X8X3vy+xbsnrYRV2QVmUDXe8eOS501AQa8LfDZLBG+lEEookCTDeBJFdDnD9sY9vFjSEw7cb5Qxt/QEckpYFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 22:48:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 22:48:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Thread-Index: AQHZSvs++K1PtX8ek0a42/7LHbL15q7tb5iAgAEjDoCAAJe5gIAAAyGAgAJcrIA=
Date:   Wed, 8 Mar 2023 22:48:16 +0000
Message-ID: <07deaffc10b1b68721bbbce370e145d8fec2a494.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-22-rick.p.edgecombe@intel.com>
         <ZAWfZcJLXUfNt1Fs@zn.tnic>
         <f91bbe94b51c0855da921a770685aa17c06c8beb.camel@intel.com>
         <20230307103251.GAZAcS0zpon573Ox3N@fat_crate.local>
         <f31108e7-c862-ace7-23b2-82ae9376ad38@redhat.com>
In-Reply-To: <f31108e7-c862-ace7-23b2-82ae9376ad38@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB7498:EE_
x-ms-office365-filtering-correlation-id: dffeaa91-503c-4ad0-085a-08db20273500
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSX6tDbzm1L3KA3mu2EXEIVHBNf758yBCo3S5zFKrw4MkoD7VfujP80sx1G67ocPGAfz9IbTDc9hac1Mf2rOZmRNHls7fzeewSQYV6k4yNnAjpdIw+erfDSX+f4wZP4zvOTsY/X30ya/lmFTQNzZP8cVJJNPA9TUG2vbteemlv0XrTJOufoyMaT/mDGKokudX0oWGtwO2SftTmJ7Zw2yrdIKqxOSHC4YOO9U+WoTLklwQmHxM+w8nPxTKh5iVv0IZfVOCwGIFOgtjsO9eovpLWuNcJG9r3E/c5pcLcKiBFlZjVt9L/OmJUOMEj0DDWEnHgrmz1OFK1v4AKfifZeena0ajNmfKOs8LJjCanZham6buQdp2JuUnEs+Ny2bGWvOOvgONqrwqEs+14GzQdn2ljEZJevrWUmEPAIaFzRFoxeIQvhRIwPPFAPvpVSaLGTGJkzhTjeNCezywewkGrr1rkaMaFdamvFkVMuzvDXHFPpsaXaJCA1K2CIvur9PXYmcffmsJK+WpCdfJxvgwn7MiI9DHiOMTiauRCCNvkci8K4THv52YW10ug87k02CPFq16VKUlu6ZNxxmXW/8AGJMdADyFYwbVcZ6ldUafrXRAlKNhrO+tOwgaB1tiUylak2/Ov4/WS2YmqlykvBZ96iuqdyMr+WnlSh8pciD3zl5IgNnoDxV1oZxElJ0WJuTO10XhMmTbFtf7qyJxK+PH8ZLLtCAIQ57K8n15bMJraqBGVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199018)(2906002)(5660300002)(54906003)(7416002)(7406005)(83380400001)(8936002)(41300700001)(316002)(86362001)(8676002)(66946007)(66446008)(76116006)(91956017)(66476007)(2616005)(110136005)(66556008)(64756008)(38070700005)(4326008)(478600001)(36756003)(71200400001)(38100700002)(6486002)(6506007)(186003)(82960400001)(122000001)(6512007)(26005)(53546011)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFVKQ1MyYU52QitnaUJPRmI2cksxRWw5WGFyaTRRZHRmVjFlaVBVcG5NcnYv?=
 =?utf-8?B?V0h4RHAreW5rSHk5ZWdBdC94ZC9ib0pxZUxLL3I5ZWtRVU84c01DV2kxZDQz?=
 =?utf-8?B?cEs1a00yTm1EWkRwa1JzSk5IYVpRNGltb2o1RnVxVFFpYmdYNjA2NTlEYk5K?=
 =?utf-8?B?VS8xZDMxNHJrVFpPdGViVlhHanZGRHZXOTRGdStoTktJVldXOER5bEVFT1B3?=
 =?utf-8?B?WkdHc3ViYm9PY091Ullxc0k1aHVQaGx4cVAxSE5HUlJ3NjU5dFhYQktNR3Zl?=
 =?utf-8?B?UXJ1NzlFYUkwdjZMbzZMcmt6VWlxTFZHcXhxMytEaTU4aldtK2E4dTFXU1BV?=
 =?utf-8?B?aW5ESzJjUjNZcTVaLzFVMkc2SW5ZNnJyT0srdEx4SVlFOGZtUDY1YTlWK1dh?=
 =?utf-8?B?a1FnelNuYVZSWjhjemVRRnRjL0RFYzJpb1B3MktKZ3VJZlplaCtJamJ1Sis2?=
 =?utf-8?B?MVZ2ZzJVSGJybDR1SE9ybHdGY3BHdHJKYUtUeGVPR1ZRUE03OXVNWGUyUmMy?=
 =?utf-8?B?Qk5XY2JaM2ZhQmFRS1c3NDFScmNOeURpVmxib3JpT2krYTRSUEtndVJuMWRx?=
 =?utf-8?B?NFZtNU5ua0RabnFwT2NxWUhWSWcrZHNWdXE3bXY5TWhMYi9iNmJ6YlEydzhv?=
 =?utf-8?B?UnZoQWtITDlUeHRWZGdwS2lqaXpJL25KMjk4ekpOTzVwU3A0azc3WnZTMm1E?=
 =?utf-8?B?MUVzK0s4UmJEMkptNXNPNDhuVmFydHNmMkR6YVNNNDlaeWNDVTU1OWFhdzB5?=
 =?utf-8?B?SW43T1VxdjBoRjUzSVpxem8xeDM4aFduRGV0Z2tiT1Z5NjdoM0wwTllEVDNl?=
 =?utf-8?B?TC8xbmVYOC9EbE5BWEcraFZLbFJUd2NFc1dLMzkyR2tuQ1lvcGdKVU1vblpY?=
 =?utf-8?B?VHNHRGx2SmVoL1VFQmJHQzZjSUVjZzdlenVtYU9oWFFKYWdCSFlDZXJaQ08z?=
 =?utf-8?B?WGZqRnI4ekU5QjlvTk84Z20wKzh6NlY3QmZjd3RhY3dPWTFHTWNHUzNXeHg3?=
 =?utf-8?B?bTZuRGRlbEw4Mm9LVnF4eU83Z0kxUDBqUFA4TjYxREVCRml0V1JhcHBpWDlk?=
 =?utf-8?B?aTh4Tk5pOThLSWF5VXIwMUI3aU9CZnQwTmNyMkVKam1scHNjdFVTRFQ4ZTEz?=
 =?utf-8?B?clBORmRxQVAvT1o4OXgrY09oVzN5akVKZzJKR0FvejlCVFJwazhTcTNSMDRT?=
 =?utf-8?B?Y0FzTTBjN0ZscmREZW1zRWs5aUw1RHFXS20vTUJvR3RkTitna3RlWG9Gc0JO?=
 =?utf-8?B?dktObmplWTM1enpZZWdZejJyWXIvYkkwMHFlODFoUk5DSzQ1ZHBmUkNqWmxR?=
 =?utf-8?B?N09Ub0xtaEdJWjJmTXhBZ29ZWHVNQ253Nkl0Q2JxSGc3WjAxck5Mblh6OEVC?=
 =?utf-8?B?Q2doUFNLSzYyc1lxSXJvdm5HSTJGaXBRR3BaWDhqV29iWFcxK3NqYTAvSTVv?=
 =?utf-8?B?Z2x2b1ZUbXY2RnpjeXRYQi9SMkJqUmx1RWowNE9KQnBMeEVqdmhoclp0NDR3?=
 =?utf-8?B?czFhWUhtNXkyc09ObTJkT1ZnTFhFNVBCaUcxL0FIN1lNWHBWSGMrT2xkL20w?=
 =?utf-8?B?bzBZRUNNeVVUTVlkRkI2SEFMOUo3ekVMSHo0akR2cGNKb2RndWN6YzhYSUpI?=
 =?utf-8?B?eHljaXlrd3NiRHRJYm12cW1BY2tvK2sybEZ5UWx2aVlZUXlsdGVhM2Zpb0ZH?=
 =?utf-8?B?VHZoRHBId3lWWXk0WEV2UlFkSEFPNHE1MFFHNlBZNlpRYUtub1hueUk5VHBw?=
 =?utf-8?B?bW1NUDdmLzdSL00zTUozdEk3aVZkamg4Ti9PUDRyak5VMGVtYWc4K0JsVVJ1?=
 =?utf-8?B?SjZ4TTV5amNZamxILzQwVmNpdmlUWnRwV0RhQ1gvamY2RHorYnZqM0lIbFRK?=
 =?utf-8?B?cEovcDlPaVVZWGNORW4rc3YyR3c1SzhnTCs0N2VsVWp6NGsxMVA4MHV0RTlF?=
 =?utf-8?B?QXlnMjJHRTZ1RU1Xd3o4K1Vkak8xdTAwVjNNdHB6TTBueldwaFkzOUJvdW5E?=
 =?utf-8?B?N1JsMVhOQmY1TVJyb0U4NmtJTkRnRytNQi92M2ZzNEVERXVzaXlYV29SU1Qy?=
 =?utf-8?B?ZzhVWmpOWUZhYTFnV0lhR2J1ekhuaWUvVWtQMlhNY0MrR0ZZTHQ0TTB3MDVD?=
 =?utf-8?B?cHhqZzRUMTBWV0dBMEwrMFhDaFB2YXNndFdZdDNaRzk3S0h5eDlLVTNWakVr?=
 =?utf-8?Q?57VkJyonuCi227THDjOm9KI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EE4A564192D694B8C6EB035F28BF0E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffeaa91-503c-4ad0-085a-08db20273500
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 22:48:16.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WV14QPWcZDmdwrvf9m4YieZyZ9nEdl/DQuipPemvus7+eVA7FF2MOS1dQMTpmPVpjYc9UxlIxHnlCXM/tgjYtjaEqg5dXVY21fifBagX2gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
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

T24gVHVlLCAyMDIzLTAzLTA3IGF0IDExOjQ0ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMDcuMDMuMjMgMTE6MzIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbiBU
dWUsIE1hciAwNywgMjAyMyBhdCAwMToyOTo1MEFNICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3
cm90ZToNCj4gPiA+IE9uIE1vbiwgMjAyMy0wMy0wNiBhdCAwOTowOCArMDEwMCwgQm9yaXNsYXYg
UGV0a292IHdyb3RlOg0KPiA+ID4gPiBKdXN0IHR5cG9zOg0KPiA+ID4gDQo+ID4gPiBBbGwgc2Vl
bSByZWFzb25hYmxlIHRvIG1lLiBUaGFua3MuDQo+ID4gPiANCj4gPiA+IEZvciB1c2luZyB0aGUg
bG9nIHZlcmJpYWdlIGZvciB0aGUgY29tbWVudCwgaXQgaXMgcXVpdGUgYmlnLiBEb2VzDQo+ID4g
PiBzb21ldGhpbmcgbGlrZSB0aGlzIHNlZW0gcmVhc29uYWJsZT8NCj4gPiANCj4gPiBZZWFoLCBp
dCBkb2VzLiBJIHdvdWxkbid0IHdhbnQgdG8gbG9zZSB0aGF0IGV4cGxhbmF0aW9uIGluIGEgY29t
bWl0DQo+ID4gbWVzc2FnZS4NCj4gPiANCj4gPiBIb3dldmVyLCB0aGlzIHNwZWNpYWwgYXNwZWN0
IHBlcnRhaW5zIHRvIHRoZSBzaHN0ayBpbXBsZW1lbnRhdGlvbg0KPiA+IGluIHg4Ng0KPiA+IGJ1
dCB0aGUgY29kZSBpcyBnZW5lcmljIG1tIGFuZCBzdWNoIGFyY2gtc3BlY2lmaWMgY29tbWVudHMg
YXJlDQo+ID4ga2luZGENCj4gPiB1bmZpdHRpbmcgdGhlcmUuDQo+ID4gDQo+ID4gSSB3b25kZXIg
aWYgaXQgd291bGQgYmUgYmV0dGVyIGlmIHlvdSBjb3VsZCBzdGljayB0aGF0IGV4cGxhbmF0aW9u
DQo+ID4gc29tZXdoZXJlIGluIGFyY2gveDg2LyBhbmQgb25seSByZWZlciB0byBpdCBpbiBhIHNo
b3J0IGNvbW1lbnQNCj4gPiBhYm92ZQ0KPiA+IFZNX1NIQURPV19TVEFDSyBjaGVjayBpbiBzdGFj
a19ndWFyZF9zdGFydF9nYXAoKS4uLg0KPiANCj4gKzENCg0KSSBjYW4ndCBmaW5kIGEgZ29vZCBw
bGFjZSBmb3IgaXQgaW4gdGhlIGFyY2ggY29kZS4gQmFzaWNhbGx5IHRoZXJlIGlzDQpubyBhcmNo
L3g4NiBmdW5jdGlvbmFsaXR5IHRoYXQgaGFzIHRvIGRvIHdpdGggZ3VhcmQgcGFnZXMuIFRoZSBj
bG9zZXN0DQppcyBwdGVfbWt3cml0ZSgpIGJlY2F1c2UgaXQgYXQgbGVhc3QgcmVmZXJlbmNlcyBW
TV9TSEFET1dfU1RBQ0sgYnV0IGl0DQpkb2Vzbid0IHJlYWxseSBmaXQuDQoNCldlIGNvdWxkIHRv
IGFkZCBhbiBhcmNoIHZlcnNpb24gb2Ygc3RhY2tfZ3VhcmRfc3RhcnRfZ2FwKCkgYnV0IHdlIGhh
ZA0KdGhhdCBhbmQgcmVtb3ZlZCBpdCBmb3Igb3RoZXIgc3R5bGUgcmVhc29ucy4gQ29kZSBkdXBs
aWNhdGlvbiBJSVJDLg0KDQpTbyBJIHRob3VnaHQgdG8ganVzdCBtb3ZlIGl0IGVsc2V3aGVyZSBp
biBtbS5oIHdoZXJlIFZNX1NIQURPV19TVEFDSyBpcw0KZGVmaW5lZC4NCg==
