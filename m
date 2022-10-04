Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19745F4743
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJDQOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJDQOZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 12:14:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A924C61113;
        Tue,  4 Oct 2022 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900064; x=1696436064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MYFRHkMZiwuOl2M7LqdI/DxZkZ7yR+FlNybkd0qKu8Y=;
  b=G7wPF2qHx6gA5UzMqt8h5Q9HhYuXSuhZD9AMWOmd40aJ/16GPPEVEt3X
   +Gv2ZSpQ63vquAF7lzKcaqWQ0zEf6mqBD9xeRWk2++p+tqwn97y+ofxIw
   XP3IXGenxL40oobdQSlPTi0jPuslEYqsbBVbL5AjqzwexgPNDwn3dsclo
   bZSYK8tAaW+zim58U3xkJ31uC+1qcz3yzKwBDk+HKseUNq8y5TsduQML/
   nIiv9zDHYd1GQKmhroaK7NGQPmdRvgJ+kZ0sJGcP/ls8PoBmWblztD4L4
   ALt0izCy+GPa4eseVIKD8e1nKtaLZDym5Joxj30pp/Cz9vfo5nL5pjPtd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="286142494"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="286142494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728276265"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="728276265"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2022 09:13:51 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:13:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:13:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:13:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwFCtTSOXLiaAxD+mb3BkcLKarCmktMvkTTrFmzZDDidU8rtOjnDQEcJ6vQ4QQGfo2LVKp5xgiAGUYmdQ64LVV87lnjSn1KN0cOfqupCeNY9gx10cXbRDocgvDFXRwl1Z4vHprSO6IVl7wYM1cFhK8ZaZ10Izkz8VV3XRic3q7ISyCe1LmSdWuELAPOga0BKmnys/jlGUGnPdxbEAfAC61YrgDYBNV746sXZh773kSZyBji2LbSamDAooAh6Ntf5xg0Fuq5Lp09CoZXdSjpniXZ3D6eZSWBPN250ajB5DkHI+SEfDBVXT9ijcZd4KBPMUjOEcoy91uux5Z9Ne1fKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYFRHkMZiwuOl2M7LqdI/DxZkZ7yR+FlNybkd0qKu8Y=;
 b=gxs0K8N0TlgCBOqgz+DVPfkRN8lqL4pZuZ2IwspUqul4un8yzDVO7UQsM+OmXZA9y3FPH6hc5KUBfqeBuwn+Oq1XTtCY7EfxQJH7c7snDvFMlVxFrRWeehKt6RKQhrDASGWZyet4sElC2VyBPl+oXNHBKi6MtW3NVdB/G30nlyyR2YwISFP20UWXth+1YwgTlvXxXy75wWV+e/JExc2E4mwwZZPb7OcOazZFaMk27kGFSdvIYjFlKuFmUwivls0pqny4l4UB3fVLOIx+Hez4hO9vgbGzf21A/fNcBDUpyKOFQ3CS8VeJUZzBPrRQkh0CwrHL+aBGq0IETptvRs7WfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 16:13:41 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 16:13:41 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Thread-Topic: [PATCH v2 06/39] x86/fpu: Add helper for modifying xstate
Thread-Index: AQHY1FMJrtB3LEMfaUW58zSfmJBEFq38+AqAgAAmNICAATGGgIAAIB+A
Date:   Tue, 4 Oct 2022 16:13:41 +0000
Message-ID: <9246d8b4d968c258e60e5cced2adc4b04d257b9c.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-7-rick.p.edgecombe@intel.com>
         <202210031045.419F7DB396@keescook>
         <e0b3662ac478a7d2ae1991e8c674732592c2ea88.camel@intel.com>
         <62c6c3a7-3bd2-69ee-36cd-341e11c43978@intel.com>
In-Reply-To: <62c6c3a7-3bd2-69ee-36cd-341e11c43978@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW3PR11MB4585:EE_
x-ms-office365-filtering-correlation-id: 174770f5-401e-428c-eda7-08daa6236786
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ye89yLgAbMthaWODhm9sVABmvUenABjCAcpQbSJjf2O4gNQLL5hALAi1gR5zh1NNfQ86Dtk2p0IVqP99mUJKwgnm1dN+bo09clCUugc7yQbscEgb+eqA24uoSJqwdG0a6sgSTPiNmQEPqyQnRWr6FFung0NYU91pVEzXuIv008bz/Px2Wxe9ORpJcahgy32A5j42xrsgZKNlzmqlphFkJLJqXGVOE6h3oMvyLCKC08O965C2EsvGg54x8jhqBj1qq1doVYdiWKvI21fjpKSyWbhn4Z6JJbEjdK2xuXw06MMN+h42kICY/BVqgRFdV0l359UnwKm/4QPfO783GdeU+jY2I2L+NuebV8sZiB5C3ZJMQlRiodojdFTrH/Risc+O9UZmXlFUXHXcauUpx8QRnL4gurdJ4Y6kpPyZR/5qT3ZHVNny+amAE7Ls8c5No6ccDgpGeBsVIWk1tUbC4yOTlYxT3BEycyxTCychPcRIcKnlnaD99gva1xhefInICQ6HrzC/KRC9FIFMof5b8rJDJYh1YX9+t0IfrAQznEFrIAfQ/P1En8IuWdBzNYYhylUTBNCQtXfOSq5KeUj7F43OQDEJdE2H9SOjepJ+AZbqB+E6xP5v2ueZV1Y/OZRagjPi6LgThE/n0wfUWUJGPgGspdvdFI4dB69YvQa2jLTBRlUWyjv0jl6S284abLcDA7sWAA+1IrRhQsItYgHtV5VrPW6+GXytGrvbN+GFxvJKIeDaBxmMbx6Ltt3/7ibTLKu+4wkYUa7t1WyU3Os8HA6zKn1WU9x+eC6r6nIdNI83Rk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(36756003)(8936002)(6506007)(53546011)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(7406005)(4326008)(7416002)(5660300002)(4744005)(6512007)(26005)(478600001)(186003)(110136005)(6636002)(71200400001)(6486002)(54906003)(8676002)(91956017)(316002)(2616005)(2906002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2lPWk9PYXVZNDNNZVdCbU1Yc09wQUNFS001QVdxK3puTmV5RytZYTFkaDht?=
 =?utf-8?B?MXBpSW1YcG4vY1R4ZURZSTY0QWZmZG1DMlZGclBUZ00yNW8wd2ZubkJMZjhQ?=
 =?utf-8?B?NVZhSktmekdoS2FmSlZPV1NXWXJQVjk5MGxYUjNNSVoxSG4yZGJsdVNrbTVN?=
 =?utf-8?B?VU1iMTFQTzV4a1luZUxtdzRCTDJ6UWFhcW1QblVNVU5oZng1dWsxTEVCa2JY?=
 =?utf-8?B?eVgrWGJmV2ZNdFpBU3JoWjFoWlpBcnVoTU1hNERIOHVXM0hPdHExdDlQZkJx?=
 =?utf-8?B?ZXZERXFLV2UrcS9TNk9sSkk1RXhFMzVHYmZGUy94K0YzeW5jV3Nab0FTZjE1?=
 =?utf-8?B?b0lIb0NiQTNocHl0bTJ4Z1o0aURVb0lWVFpZMUkwWG1nZ0RYdW5Oc0pPSWJ1?=
 =?utf-8?B?QTNLbTY2WmNOanhrTnNITElKNjM0UUZIOGVqTEZHVFhhSnlBTlp2Rkl2amYz?=
 =?utf-8?B?K3VwNUZyTTBaWFJEaHIzUHZVNFhZb0FHdzREZzZVWWZSUGxRRmZJMUMxYTcy?=
 =?utf-8?B?dExPTHMrNzlKamFnNkdJbWc3MXlqZDF5MEUySysyUTFrc255WVc2VFhOVjA0?=
 =?utf-8?B?VTJpamIyYnRxcFNsM29pU1NJOU5id0RmN2lHZmh6TjZEbGJ5MG9jSXNPVlZx?=
 =?utf-8?B?clJMU1pDL0VzQnBSWC94d2Z0cE1ST0Q3U2l4dW9QQ3dHZVQrQzdjWWY3TDRW?=
 =?utf-8?B?cFE4SlE5R05TSmpGUk5WcFE1NlczN29wRUo1RVFQVEtTSE9Ka1FuZkJvcGtS?=
 =?utf-8?B?Q29RNzVxcUl0YVN1WnZPaTBrWHdQNjRMUzdqRGJpbkpJY0lJR1pkNGpScHJy?=
 =?utf-8?B?ZDYyZEZNV3I2UE10ZlBYYjVaZk1sQnd6RXgvdnB5UkwvYkZqUDhuT0dvaXBS?=
 =?utf-8?B?SHlSSk9sSHJoL3Fjd0RpMVlKcFlHb2hiRUhtMXdrUXFJMVdKV3hEdjg3dGlD?=
 =?utf-8?B?bThYMDhCVSszSUJTazZ6WkVWL0cxSXRHVjVBa3AvSUplWE1FcXdSUVUxMkph?=
 =?utf-8?B?c3hnbkIxL2YyTE5pMmpZMWgybWp2MHpTMWYwODdyMVBZamdMSHZSb3I1dnhS?=
 =?utf-8?B?aVBsejdwMjRaZ3pSenl0SjJYaCs2b2sxak8vWUJ6bEgvUmlHeGVSWk4ydVk5?=
 =?utf-8?B?VmVHS0wxeGRVNXVxVHlpVXNSSnh2M1RzVFl5VkZMb05ld2QyME5SVEJucGRJ?=
 =?utf-8?B?V1I0cEoyYlJ3MzZ3MVplakJ2VHh5b05heU01YmNjTUZFL1J0U0Y4RE1kZ3RQ?=
 =?utf-8?B?ek0zTDBUMU83TEZpMkFLNjFpaWJzVm5YYnlLMHk1VytiSTBxSnkwZDNYS21C?=
 =?utf-8?B?aU1VT3EzNjVoV0ZnQmlSWVU0b010MVVWdGtoY1A5QUluZzZFakt2QU1Vd2dG?=
 =?utf-8?B?WlVWZVhUQllJRkZibEc5M2pTanFRTm1zblFsaUprZVBWdi82Sm4ydXhyQ01L?=
 =?utf-8?B?M0hpb3lFWkdMWFVlUVhBMjNnam14OFdIbFZ0dHlCUGVSdlBmd09FR1Vua0VN?=
 =?utf-8?B?SkZabldVNGp2Y3NRdm9RRTVMTnZNK2hEZGZZRXV2bkFsckpMa2ZVcGFnYTJp?=
 =?utf-8?B?dTFONzdRbDR3KzBrV3Q2TDRWYU8xZTd5VUUrcjVNVG41Y2VTellmWFg5c2hJ?=
 =?utf-8?B?MkFLYWtXMVlabnl2TG9WYkoxSnM1RWlzN0pka1VsbXJoZmQrQmVtQmlpcCtE?=
 =?utf-8?B?MTVvU2VmSEFNQzBLaEtuRmo4cTdFZVNVMng3N1U1V2E5RWJDeHk4VWRMUzhT?=
 =?utf-8?B?OTl1b0ZPdUZDTzlUbitKd09sdXMydDNRRkVOK3Z4L0luZmlTZXpteDJLbHA0?=
 =?utf-8?B?QU1ydDhzWUNBWGplYlF3WTJTL2MzZjV2U2VoOE1VTDdiNDZ6bkJEUnQyblNo?=
 =?utf-8?B?Y3BEYzNIb3VjTTlxc2tvVFVPRHFzL252TnFRWE9ablk3Z1pocWN4OUxKUmxo?=
 =?utf-8?B?bTI1dUtHa2ZVc2w3bWtPQllsS3BQREluZjNUT2l2eFc4V3l5NlhOaDQ2d1o4?=
 =?utf-8?B?ZkczN3diNmw1RUNKY3RveHRIU0t6Z05zM04vc21RVHhVNTB6di9DeEw3TFFU?=
 =?utf-8?B?T0hTekJPL1RQWUcxR25uVmhxT3FYMEs4WWZjc3ZTdk9mbHlOK08rQWxRbDVs?=
 =?utf-8?B?S2N6eWhXeFpjd2tVRGRlYkEvUlpCY1ZJN1VhK1FiZzlCeSt0QmtVUHgyVzQ0?=
 =?utf-8?Q?pKKHAJhJJapGKD/nHjr5tEA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4D96C1304F5CB428EDB25797AC70226@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174770f5-401e-428c-eda7-08daa6236786
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:13:41.6683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqX3IDYE3m+H/FwnWp2WMcVDSo3yxMW65yHf6zizsqNggfcKXprbxXNLjd9UAkLCwWcHrWeU/aEeF0F3Aoc+rVN+Zmmr9itl3N+91z/MKJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDA3OjE4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTAvMy8yMiAxMzowNSwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4gVGhlIENFVCBz
dGF0ZSBpcyB4c2F2ZXMgbWFuYWdlZC4gSXQgZ2V0cyBsYXppbHkgcmVzdG9yZWQgYmVmb3JlDQo+
ID4gcmV0dXJuaW5nIHRvIHVzZXJzcGFjZSB3aXRoIHRoZSByZXN0IG9mIHRoZSBmcHUgc3R1ZmYu
IFRoaXMNCj4gPiBmdW5jdGlvbg0KPiA+IHdpbGwgZm9yY2UgcmVzdG9yZSBhbGwgdGhlIGZwdSBz
dGF0ZSB0byB0aGUgcmVnaXN0ZXJzIGVhcmx5IGFuZA0KPiA+IGxvY2sNCj4gPiB0aGVtIGZyb20g
YmVpbmcgYXV0b21hdGljYWxseSBzYXZlZC9yZXN0b3JlZC4gVGhlbiB0aGUgdGFza3MgQ0VUDQo+
ID4gc3RhdGUNCj4gPiBjYW4gYmUgbW9kaWZpZWQgaW4gdGhlIE1TUnMsIGJlZm9yZSB1bmxvY2tp
bmcgdGhlIGZwcmVncy4gTGFzdCB0aW1lDQo+ID4gSQ0KPiA+IHRyaWVkIHRvIG1vZGlmeSB0aGUg
c3RhdGUgZGlyZWN0bHkgaW4gdGhlIHhzYXZlIGJ1ZmZlciB3aGVuIGl0IHdhcw0KPiA+IGVmZmlj
aWVudCwgYnV0IGl0IGhhZCBpc3N1ZXMgYW5kIFRob21hcyBzdWdnZXN0ZWQgdGhpcy4NCj4gDQo+
IENhbiB5b3UgZ2V0IHRoZSBnaXN0IG9mIHRoaXMgaW4gYSBjb21tZW50LCBwbGVhc2U/DQoNClN1
cmUuDQo=
