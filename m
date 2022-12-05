Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C06436B0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiLEVUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiLEVUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 16:20:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDEB24BE1;
        Mon,  5 Dec 2022 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670275242; x=1701811242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8mXmukrim/sR6Xrlf+DpPw1+jocoFCUtLHu7rPbgxUg=;
  b=D+LUbSNxyjruO98SNMTVTyN/ko66LX6P6UN5p9XdTv+cDIGxYTPElA5E
   4Xgz2aC+MHn4D/gtJORgPEUrBlGaRJoDje+elUdjzjnwp9NKT7R0QRU63
   huGi0QvVNK4AGa/v88FsKu9TgyS02vnCnACO+4zz3lHmXD7des0aFLN5X
   zpnFtkGZ0q1g9E5rZFlIueNtv4TuxUGo3UKwGkSLawfJm9ZYfusNEUJUH
   r1eK91xbbPClYLlbL3XNrjdRKzOtBGo8L92KmZ/2UeB3X//pKLPc2S4vU
   x21Og1v1ooa79QrwuUaqUwVEq5lP4TWGYZmQ95fK6R7OBkL7temb0/xUZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315174161"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315174161"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:20:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="645972341"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="645972341"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2022 13:20:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 13:20:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 13:20:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 13:20:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdBusGEwNCCBlZHFtQVodmV7/QoxILT/Zmeu5/fXidwVK75Q+R5V5BDNRGs1d3ivLHSEM+5OcAlYEuAtZwtG6J86ptQY/dQuAMSpMFGZs0RaPKEj74BtV3QUeGuIBPpKFdh6BHOALHr3RNTQ8lRPVk0QLnpTB++675VJ5pPXsEaHKOFPUAKydr8tRpFKWrKM1v61X8kw18D/wzwegyxr9r+BOukzVvSZ++sq7m21XQtGsqUuZaNhmqVOH9MoqSt7qVIU9cL9VtbVJZGqjhnFLByUUqnQhxM9sAtFbMgGgZkB7uJ190otpdTfI5cl3A9tXcxSdnzEW9JZz7Mi4obbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mXmukrim/sR6Xrlf+DpPw1+jocoFCUtLHu7rPbgxUg=;
 b=mWzMdH/7eI9QSTy79f5cEqX7XSG6Dc8cPjVvurik7hjI8uECNJxO8Edbfg/XUAAOw5W+4lW3jkDqptsje/J2lYPYdpnyH9PUijxAoM0eQujBhr+iVQAVCOuDuANbK0w3Uuzqe0wqvJkuxyT948NegM30mKV8Nnu7nMkBv/rUvy+ASYT1NgXoH/nUDbN8RKyOjwMvgH+b+VeOj34koz4yaoYu4kIZ8Rmgq0Zibv/90h27rj8H/BLLfihFQWw0iMS3vHYMaY2pGGesIChItzC5kjZfl1xbfGsTqBFPWWQOcV9jZZsuEB6D9E5G7TbXF/LllDbPs40SvLySWncowTncow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7881.namprd11.prod.outlook.com (2603:10b6:208:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 21:20:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 21:20:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>
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
Subject: Re: [PATCH v4 01/39] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v4 01/39] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZBq9RnFWlgoZ+OUegYhyoG0ha3a5b3VqAgAP0EAA=
Date:   Mon, 5 Dec 2022 21:20:28 +0000
Message-ID: <954960f79cd11e2aa9e2b9ac5da87e5cf7b41d5a.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-2-rick.p.edgecombe@intel.com>
         <Y4sPn/EQgqQI/sSN@debian.me>
In-Reply-To: <Y4sPn/EQgqQI/sSN@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7881:EE_
x-ms-office365-filtering-correlation-id: c882ce45-8d16-4e16-bdbc-08dad7068870
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lewHIIjYKky6TKf57Lk+vALQO/G+ncJESgKxackMgoZDIsorNRtUZ3fnohlXOgO1CQP/R0xnxsSM2ip26n0tNCzTW2UF+jBdiFGf44/r/79Oh6xiSmwY/UEBrmPJNSCQLyX9sRGjGsgW7cdiSK/2reF5JwH+aRfBriSQPFvB17uPXNN1nLqnN1OehnnxKwGlHKcw4YDCivdkcIa7Uc+NkifllA/4h4BmJbAMaI/OXTyIr1ocnkhoiK7gwPLRDG6go3lFkDLtm95ySWBIkjqNFfi+HIFHUxjFIxDgWBgICOX8EBAmSYJ3BX/dxbFHjanjKI6D6A+Z9n8qwV2u6AU0H/j+0Y4B5kMtAgYNoVMAiAoy7LpAhSUXLQ8LHPwPEOoY+nbnkGxKEQkFe4u6tgbK042U1SN52IOiyF55lApgh41jlvc5CiFSY9s/1MoXmSy58yLu6WXndeuhrqBScSBklqjTqgfG8+UbQBlVOG5taS7Utst0L3RbpRA2+cfCkMPQQ+75p8/KLYRYVn97QmXMTCqb0LU1hA11/8KLbG7A88BM6G0X6naVOewcL6MalP0kKfWMK+rsdU5PZwrRxyOMtqjSmAxhCfYEasycExWlbUWf7XNxZJyk0OQTjjO5YyMTkRXYIPCCKo9FTWg0sjkEprRAtKTgsxNO7NbrYwVD8QN85sgxx54ZX0K3mVFfm2GSUJ1EOGcFW2G/StiK2JBXiZhE8/zSLQQ9wV6tx0f93CQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(83380400001)(2906002)(41300700001)(186003)(8936002)(7416002)(7406005)(4744005)(86362001)(122000001)(36756003)(38070700005)(5660300002)(38100700002)(82960400001)(6506007)(316002)(26005)(6512007)(6486002)(478600001)(54906003)(6916009)(66476007)(8676002)(66446008)(64756008)(2616005)(4326008)(66556008)(76116006)(71200400001)(91956017)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STFlT21Ha3VBSlNYYmxmbFkrZi9VTzd2dW9ZNkRyYkxLT01VQXk3cWErUXZz?=
 =?utf-8?B?QTJnN0lzeDdicnJ6eWxrYUlKREFwVWY4T3draXNSQ0Zjalp5VjlNN3dGeXhQ?=
 =?utf-8?B?b2F5dytmK3NGV08xaEliSUlNcEdERGVvVW13SXd6QzFJaHRuczVSTkxQUEJF?=
 =?utf-8?B?NHpoTWlmZlo1ZTQzWC8zbnhNUjUzWkE0QTZFL3BwaGtkb1JRZG44YnhwOTZD?=
 =?utf-8?B?eVRtSlVPRGYxaDVmUGtQT0s3bld3QzJSYUhSMEo5RVE0WTdXYXdPcjBsaTF0?=
 =?utf-8?B?SkV2dWMyemZZZEFiZ3RUbW9zNW5FNmppRmFDeGZHa1V2MlpjMmg4NlZDMjFU?=
 =?utf-8?B?TXlGQWFaRWFzV3FFa1dueTJnNTdibENFSkVHTGRQQmhRU0RGcHR0TjBqaVdO?=
 =?utf-8?B?Ti9zbXZYcGY4Vy9SQ0oweHBTTFFtSGN5ZTh1QmxkNVE3dUxXOEFhZVFDWjlZ?=
 =?utf-8?B?bnQ5S3YrS3dZa0ZqTDhuczd2MmhYZjJNRnZjcFdFSURZa3JxQ2NxR1ovM2Fh?=
 =?utf-8?B?NGhOT3pZSTd1MDF3TEJVWXppbTh4eXZlREcxd2lZSVpIVnZ6Z2ZsdjhOOXNW?=
 =?utf-8?B?WTErT2dRZzNDYmUyWmNIZllRQy9ITnVKQkEzOGkwUzBTQTN6c1hCL3FSVXlH?=
 =?utf-8?B?aWQ3MW82MllVUjVLczYybkdRU3hJNGRWVVRUMkVCd3QvSGJFY0tCL1lWLzNK?=
 =?utf-8?B?SDdkeGJSUlN4Vms1NlI2OG5oalcrSnZiNlhYcWFPNFk4aG14ODY1QmprSGNG?=
 =?utf-8?B?K29IQkxlUGNvd2htcGVib1d6dERSL2tRWkdlZnVQejdCSUNhQ3VoYStUSHlr?=
 =?utf-8?B?a2NESk9HZUN4dWFiQU1JVFhxQkVYMldKNGc0bWhDS1V0SXdSbDVlRlJxQ1p6?=
 =?utf-8?B?WmMwcTVGMFhDRklrV09YdmlYOE1aRGlLMHFtZExRamV2TFJBU0tpcFY1NHZx?=
 =?utf-8?B?d3JmOWM3R0hjUEtPT0E0YTBqa2xlVG5MeEtuZ3c1d2pESkVERHR1WmNWMUFF?=
 =?utf-8?B?TmNrZU1SOEY3enQ2a1N6VWtVcG8reFlkSjdSKzBIRlZNR01XdkJSQWhqMHhG?=
 =?utf-8?B?WkpaVGVMbENRTENnQ1FNa3JQTjByeDkzak9xRnJTRlRTd0lNd3lOVnZSYTE0?=
 =?utf-8?B?M255bWN2aE42c3QrUFk1WDJBNHhoTnlOaDE3SHJQamZNQnlWWGp6WlNGVzA5?=
 =?utf-8?B?Q1FnNDBwN2RNa2Q2b2JVZ3EraHhXU205cHFLV1ZEVlhNSU5qdkI1NnJTVEpV?=
 =?utf-8?B?SGFNWnc5MVdDciswVW9zc0x2d3lvQ050Q1pEb2xpbmJrNzgydk9iZ2R3WUd4?=
 =?utf-8?B?bC9sNFpmYU5yMmVSdFl4MEkzZi9ySnlzMUhrS0pnaXEwVGg3NzZadVQvUGRN?=
 =?utf-8?B?V3o2cFhpbmlUYVFaOFlVZGp6aks2aFFJNnV5QXV1ZVBzYkRxcDYyRlJBdG9a?=
 =?utf-8?B?aWowWjc0bUdEOWlSZkF3RjNzV0tkT2tPTXB1TkliY3lvNEJFaFhKUTBSSlZH?=
 =?utf-8?B?T3AxZTBKMVNtT2xiQzN1amJaK1RudVN3eCthMnNDdnVaSEFEQm8wODMxMzg4?=
 =?utf-8?B?UFdiY3VWYjVGWXB5VGhWWm5nb3F5MWp6QXFXQWwxTXZXaC83NE5vZmNFWi9l?=
 =?utf-8?B?aStMMzV2eXRqSDRkNjBBMUpaVlZYbzk5UTlkeCtkQXhhOEdSUFlUSDJPY0t0?=
 =?utf-8?B?YjcvcG83OGI4VjRDNjUxa25IY0NpKzV6KyszRmx4SDFMRmxteWNZclVtWG1n?=
 =?utf-8?B?RWx0dTA4NWRmZ0pqOHVraXlQVHNVQWk5UUZnOWkwbFMvSit1cVE4enNTaXdk?=
 =?utf-8?B?Y1g3NUtwTDY1TGtmVkRsZzR0Rk9LT3A5N0piMDBxY003Z1NLV0puQlovNldz?=
 =?utf-8?B?T2trc2FjYy9SSFQ2ejlsaXQ5YnJ0SWVJeEwwY2R3Q05JRXFzUDRaU2FRSlZw?=
 =?utf-8?B?TWE5ck1kZkxkTTBTNTZPaDVYZEFFQXQ1SW1WdWM4STY0SHdzbjNuaDFKbHJR?=
 =?utf-8?B?QXNzMWtsaU9wOFEvMENFRHlwU0h0ekpyUHUwdzNYdUNIcElSTHR5RFRiVXhm?=
 =?utf-8?B?S0puWkhGVUExSTBGQlh5TmFYeE5NTVNpc1piY2NJSUhBRG9Db1hTK2xjWUtY?=
 =?utf-8?B?NjdpNTFDaTFSNGptTlhZd05SdTFrb09lQVhPY3pyY2M0NGlVWDY0L3l3dDZ5?=
 =?utf-8?Q?XS8jqFLmw6unZvic26rpnPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1D2ABB94DDABC46B6A6637C206768C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c882ce45-8d16-4e16-bdbc-08dad7068870
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 21:20:28.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2KwxUvdAONR9OzfkMF/YwLhId+XdSIK8huQxIoo0aR//nnYuEDniAuxgRQXBL+9eG9kC5fBaStWFK+fxfO8WU3t9O+03hnagM7rt924KbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIyLTEyLTAzIGF0IDE1OjU4ICswNzAwLCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0K
PiBPbiBGcmksIERlYyAwMiwgMjAyMiBhdCAwNDozNToyOFBNIC0wODAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiArQW4gYXBwbGljYXRpb24ncyBDRVQgY2FwYWJpbGl0eSBpcyBtYXJrZWQg
aW4gaXRzIEVMRiBub3RlIGFuZCBjYW4NCj4gYmUgdmVyaWZpZWQNCj4gPiArZnJvbSByZWFkZWxm
L2xsdm0tcmVhZGVsZiBvdXRwdXQ6DQo+ID4gKw0KPiA+ICsgICAgcmVhZGVsZiAtbiA8YXBwbGlj
YXRpb24+IHwgZ3JlcCAtYSBTSFNUSw0KPiA+ICsgICAgICAgIHByb3BlcnRpZXM6IHg4NiBmZWF0
dXJlOiBTSFNUSw0KPiANCj4gU2hlbGwgY29tbWFuZHMgc2hvdWxkIGJlIGluc2lkZSBsaXRlcmFs
IGNvZGUgYmxvY2sgKHRyeSBkb3VibGUNCj4gY29sb24pLg0KPiBBYm92ZSBpcyByZW5kZXJlZCBh
cyBkZWZpbml0aW9uIGxpc3RzIGluc3RlYWQuDQo+IA0KPiA+ICtUaGUgcmV0dXJuIHZhbHVlcyBh
cmUgYXMgZm9sbG93aW5nOg0KPiA+ICsgICAgT24gc3VjY2VzcywgcmV0dXJuIDAuIE9uIGVycm9y
LCBlcnJubyBjYW4gYmU6Og0KPiANCj4gRHJvcCBpbmRlbnRhdGlvbiBvbiB0aGUgc2Vjb25kIGxp
bmUsIG9yIGJldHRlciB5ZXQsIGNvbnRpbnVlIHRoZQ0KPiBsaW5lLA0KPiBsaWtlICIuLi4gYXMg
Zm9sbG93aW5nLiBPbiBzdWNjZXNzLCAuLi4iDQo+IA0KPiBPdGhlcndpc2UgTEdUTSwgdGhhbmtz
IGZvciByZXZpZXcuIA0KPiANCj4gSW4gYW55IGNhc2UsDQo+IA0KPiBSZXZpZXdlZC1ieTogQmFn
YXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+DQoNClN1cmUgb24gYm90aCwgYW5kIHRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCg==
