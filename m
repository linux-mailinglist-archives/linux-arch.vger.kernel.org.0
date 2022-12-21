Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558D652A87
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 01:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiLUAiE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 19:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiLUAiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 19:38:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBA3E32;
        Tue, 20 Dec 2022 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671583081; x=1703119081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eZraCeZcn9drs3flvXb7Dn/nOgkyrzKqSHADooktwio=;
  b=I33Hq15TlWcHbomPOc6mQhd+9IeVawKj7j5J+70/eHdSxTCA/pHhjNaK
   uQYbw5P4ClkbqaKjGZT84Rj9lCQ+dMKdHGET0048wWvLGWEBSdGw7zr+h
   U/SobpIf+u/XYaqzkoO+NB/lDWJZcG9h36hNY4kz4/19/IXb07bpzdox7
   O7FwcyqsWBxmHo5jJL0OU6GmDYHAxLSCLkVF6mXZDnx7NZodnDbl1TqK4
   qcftlEz+WEj1C+iuRZAk5SMKYkRWu61mfkMUvCOVxeabh91HTIytzvG2B
   uWmT0kLPeA0sl6LD6YO7Cb4oBeAAQp3RIZ3vZ/H2TXSlEIV0XFMgs47RL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="307433826"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="307433826"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 16:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896677132"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="896677132"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2022 16:37:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:37:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:37:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 16:37:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 16:37:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mariBmd70nexYzKV8KTbZnqCPjjwapkOAPT/kqCBpg55VXgr0tZVWy07vzzXzJHt8F6ygPDmkWXZdrhN139lnxfItbeEpiO30UMH+GaRTc7esglcHqOUSG7BDYd2FwXTMUrywjVacmubJQTUTfIHjlrXu3pBrcP4fGBmNMfs+UeeOchMbvB8c0SA16P7D+IjzpRVlkVXNXHIbJRIa0sYllY2ZkhE/JzdHNrDObctVEl0jHfDWOHncUxJ5hIE3M8FgbFu0QBEcEiJ39fs1jJslxdLylzlXxRt5H+g+1jUgeXhTA85jqvZe0+WeVB0Fr1eYnj6ii6+Zm20srd/2m8/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZraCeZcn9drs3flvXb7Dn/nOgkyrzKqSHADooktwio=;
 b=G294hNYG6oL3RlIEfkZeJjGhQLAItL27y+caFji5yEwXrfmUAzpxghd/MkqGhPkmkWOiu0ZccDKrtM0DLgZYD40D0pTSppeK3TQfdjTsbyehxhubEOr9cDpIomuy+fd5oGEN2M5GjM9TqlK+XGXuUWpYto8swN/qlufzVav1XITVFDLh0fdqTXfTWRpfXjolFq6LXD32FRfsj1Fhq1/qodcSREla1STy+mKARqEb7ZP7zei5P6HxKZ7jZYDJoUV66z42ObwqQhwRQsgKfAepwdL0aSgkhRkH6ATDi7Qiy8voVr96FXojO2GkUBm2kjFNuDImstrZiMDW2QwYtkcozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:37:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:37:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Topic: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Index: AQHZBq9UGJ4pSWbilUqMOVDoCgC2J653EFAAgACLOQA=
Date:   Wed, 21 Dec 2022 00:37:51 +0000
Message-ID: <3aaf1b0d67492415acb9b3d06bb97e916cb7b77a.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-8-rick.p.edgecombe@intel.com>
         <Y6HglBhrccduDTQA@zn.tnic>
In-Reply-To: <Y6HglBhrccduDTQA@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: 2dcfeecc-74c6-4b73-d053-08dae2eb97a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOoc0FqWV/RQcJRQyHSAHdrAi7rOumQjWHTK6eKx0w679SnWt2gZHXKHssYidWbQN/qEtoJvZCKMGETivsz+Xt7iP4Jcka4tLtevDJ9oAdzx3FVW7twhPFBGe6ufYyN18YhlR9szIEuts31VIxZP/lcTkiIagAm8HPcMj01O7aviiTO4uype1/y0UQgtB5DuyQ03lxpswk1IGgYo5H6EViabKnAzomiZcxPUMpMSs7c+O87jq5DDX+ujM2wV9eQFajCvB3nb0sZP1dekLq/rG/m5ZS7DERr5YofQd8oziNcOrstZI9RKY57lbChxRPWjcszFF1mASM1SIfSv7jHUpTHFTb4Sw0LilVRffEc6Bo6opI4Z7nHslfGSWNukcaIFhffPzuC72itzMJl148qKCeM9oueFp5nVtiKfKolZHSUpcfCGkt032qbv6ilVSrnQgseNv0IYBBO5sQQIe/qwTQeuUCRML57NC1wXu4PRmobv+fI6N2tN30Iwz3QuVCvl95vbLD/NR77D7sgQxedzdC/SoISKqcmRn5W2KFs0GxO7ZkwopJJ1AKSqFtywLvIeXrQSvsj6/SXg6gj6oLUoV30bh+Cz39lIXnQCt5Lr+Ktpyygv9W4mhV/O2SOUMV5B4ociJ71AxlsaLs0o4V85Ro++Jaj9RMxIj3IUrDsZlcS//d//L9N438oGQOTRTozVI0uyurLjOL1SUTx0fYGi1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(8936002)(38100700002)(83380400001)(6486002)(71200400001)(36756003)(6506007)(4001150100001)(41300700001)(54906003)(2906002)(478600001)(26005)(186003)(122000001)(5660300002)(6916009)(6512007)(316002)(7406005)(8676002)(7416002)(4326008)(2616005)(66446008)(91956017)(64756008)(86362001)(66946007)(76116006)(82960400001)(66556008)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVRQzRjOGZLekZWYXdDRnlZSzdRcjZHZ2JhU3BuSkhIZmJpRFFPNDZIOURY?=
 =?utf-8?B?WE1lYys0VGhUNXFLazV3R3gwd1M2WTVTR201RlBzdFFTRTd1aTMycURyaCtY?=
 =?utf-8?B?VFJUVGxTZURNRG9mdDQ3ZjhtK0RYUTVhTXEzMWJDaENMNTgvSjI1UUFzK2hR?=
 =?utf-8?B?ZWJFMnJmaGRabVFYcWVLeU9ML05wVlFQeE9YdGIvTVFkV3Q1U0hacERQN3pW?=
 =?utf-8?B?Nzd4NmhBYzJVQ2ZzdjZ5Uk1SY0wzN2twcGhPYnNkeThoOEVGYlN0UjNSYXlT?=
 =?utf-8?B?bXVYNW5QSUc2VFRqOWJrQitIYXFLYUdCSndTeXJEYWV3ckh0ekE1OGx2a1dO?=
 =?utf-8?B?NzVEV3cxdVdLdGMvY0tZcG1mMHRRYnFUOGhyUWVJRmZ4OUViMHJWQVh0cnN5?=
 =?utf-8?B?VjUvRm40WHllemVtdTBCakVocWNWSDZqK1phbk1HZHpwUWZqanJ0OUN6MCt0?=
 =?utf-8?B?ZFp2ZWUrQzBaaGJjUUtuOVNubGd4UDdWZUJ6SHhuQVJmRHZTWnAwUkNMSE5F?=
 =?utf-8?B?cWZ1emgrUTdHU2ozcGUxNmtyU2FDVi9uZmllRmo3MG9OWGxWVkRPWXRmUzBJ?=
 =?utf-8?B?UFlqVlpyejBwYzkrTHpVQVEyMm9zaExVdW5TZXZRRDFBbkxpRTcxMERQZFVN?=
 =?utf-8?B?MmlvKzEyeHJmTmNhcnpLdFFiZEVCUW5UbVlPLzZZNWNReHhHOGNKRTlQYlJT?=
 =?utf-8?B?YVgzVE5WWlBXbjIxaVFmMzZTQkVsZ0ZPWjRhYTJNV203OGFRRlNLa3Rua0Uy?=
 =?utf-8?B?T1BXTUU0ekY4MEY3SkxBYU9tNHVRRGM4VGZOeDBRd0lZUCtkY1hxMmdKclBM?=
 =?utf-8?B?bTJFVzUxRzlwSXFhTWU0cTBmRnI3cFpLR2syVkU3ZERLOVI5RjRmUGNSNW0z?=
 =?utf-8?B?cmNYWE9ZczhiNS9uKzNUdFBGdU92aHR0bW5qVTQxWUtJcFVwb0diQU1DOGYx?=
 =?utf-8?B?R1hBdFFtNnpaMDNEMlpzTENJeVB3RHhUdUI2M2V5UVg2cWtHbi9TNG1NSHho?=
 =?utf-8?B?L1VQZCt1YWRFdHNCNmt4YXhVbUdJaEcvQnVKR0xIOGVyUzZxekhCWW9hbmlQ?=
 =?utf-8?B?R3Q0MzRFSXN0UGtaOTY5SkxIY1F0WUpjd1BiTlhOdXlXcmt5Yk91Yk5HWUd1?=
 =?utf-8?B?MmpKcUN2QjhyM3JEWWFzSUdIRE1BYXNwcWRiUWpyVk9nYUhRNUdObjkvcVNW?=
 =?utf-8?B?TjBVMytGaGRlZHZNQVlCVFVVa0dTNHlGMjQ3NWh4clN5VUtubCtibDMxczcw?=
 =?utf-8?B?RDBTcXk3K09uaW81S1d1cHI4amhCOWYzL3JhOVNnMnd3OG9MMXRWNDlqUTNn?=
 =?utf-8?B?d3RDUTJUd2x3cTdOZEdBeHYvM3VRZEs4Z0sxdWpRK0EvUjF5UU1IcHU4a1JM?=
 =?utf-8?B?cUEwQ0FSc2hMOENpblJpTkMwcmw1bXY0UkEvVUdTM3cxVTl5VlkvTmJtYjVL?=
 =?utf-8?B?WlY0bWJjWkZVd05HYmhZT0VCQ3d0SmZYczdwdlJSZkhqWUF2UVhEcXlPUXp6?=
 =?utf-8?B?aFg5QU9zTmxhaVp6VkpKRmZIQ0w4Nlc0NnFhVWxjbDZTWkRBOWUzdGRlTmsx?=
 =?utf-8?B?N1FyZWxsWlViNEFWRXNOeFJjbmdwV1YydVc3cmgzWWFXRmk1ZFlCa1V3bFJx?=
 =?utf-8?B?bzI4MFdtS0R4b2RyWC9xcElYOFpjV0E2RUVpMlcwVjJNbDVkNjdxNUlVVFlL?=
 =?utf-8?B?MG9RcmUzSjJ6dlZJYWZEZnc5T1NmSXFHM3pSRzlNLzIyN0pRV1ZDTHBPemhr?=
 =?utf-8?B?Tzd6Y1E3ejcvN3pZY2FUTUtnU0Y0cjAzTDZMMi9Ld1RqVDhVMytLSzhQZFlR?=
 =?utf-8?B?K0dhMldQZ1c2SnZuZkZjNHMvTC9ERTZTYmhPWWl6ZzRxdlJ6NWVBOGhyMTZm?=
 =?utf-8?B?dkwyQ2dqNVZ3SmlGYkJrNEJSbWNwaWhmeFVweml2K2FJY2dObnhFRVZ6TDBD?=
 =?utf-8?B?emJpb1VVVmxPazhJRGEwS0g0enB2elhuYWpJYy9lZm43OTIvM0xtZTJSVFJq?=
 =?utf-8?B?ZmdtcXVyUHVLQVlobk1NUXRrUnAwSWpxUU0yRjZ4c2ZIM2V6NkFJTm14elQ2?=
 =?utf-8?B?Z2Z1SUorYWREY1RXWTRLcWtvNU1UeE1rMGxYd3h6bzBhc3ZZR1RvY1d1NVhE?=
 =?utf-8?B?UWQ1S3lac0lqdUtkYmhjZUNWZ2MwdU1jZWxoZCthQmdrckFZUkg1RmsyMTRx?=
 =?utf-8?Q?j17zmVtfYvTxHc4y1pJL2uU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD0E8B2D009A244AAE5C06A71792351E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcfeecc-74c6-4b73-d053-08dae2eb97a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 00:37:51.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpSPUDUAoCcJqB3kk7MD8ayGYaTGQ4Ay+gRP6EZiTLlj9E+ObF6p+WP2BC7lhNj532njS6O7JnZUb1QFsuW+4/OKnOLPznyWduQw1p4y6dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDE3OjE5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjM0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gQSBjb250cm9sLXByb3RlY3Rpb24gZmF1bHQgaXMgdHJpZ2dlcmVkIHdoZW4g
YSBjb250cm9sLWZsb3cNCj4gPiB0cmFuc2Zlcg0KPiA+IGF0dGVtcHQgdmlvbGF0ZXMgU2hhZG93
IFN0YWNrIG9yIEluZGlyZWN0IEJyYW5jaCBUcmFja2luZw0KPiA+IGNvbnN0cmFpbnRzLg0KPiA+
IEZvciBleGFtcGxlLCB0aGUgcmV0dXJuIGFkZHJlc3MgZm9yIGEgUkVUIGluc3RydWN0aW9uIGRp
ZmZlcnMgZnJvbQ0KPiA+IHRoZSBjb3B5DQo+ID4gb24gdGhlIHNoYWRvdyBzdGFjay4NCj4gPiAN
Cj4gPiBUaGVyZSBhbHJlYWR5IGV4aXN0cyBhIGNvbnRyb2wtcHJvdGVjdGlvbiBmYXVsdCBoYW5k
bGVyIGZvcg0KPiA+IGhhbmRsaW5nIGtlcm5lbA0KPiA+IElCVC4gUmVmYWN0b3IgdGhpcyBmYXVs
dCBoYW5kbGVyIGludG8gc2VwYXJhdGUgdXNlciBhbmQga2VybmVsDQo+ID4gaGFuZGxlcnMsDQo+
IA0KPiBVbmtub3duIHdvcmQgW3NlcGFyYXRlXSBpbiBjb21taXQgbWVzc2FnZS4NCj4gU3VnZ2Vz
dGlvbnM6IFsnc2VwYXJhdGUnLCANCj4gDQo+IFlvdSBjb3VsZCB1c2UgYSBzcGVsbGNoZWNrZXIg
d2l0aCB5b3VyIGNvbW1pdCBtZXNzYWdlcyBzbyB0aGF0IGl0DQo+IGNhdGNoZXMgYWxsIHRob3Nl
IHR5cG9zLg0KDQpBcmdoLCBzb3JyeS4gSSdsbCB1cGdyYWRlIG15IHRvb2xzLg0KDQo+IA0KPiAu
Li4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC90cmFwcy5jIGIvYXJjaC94
ODYva2VybmVsL3RyYXBzLmMNCj4gPiBpbmRleCA4YjgzZDhmYmNlNzEuLmUzNWM3MGRjMWFmYiAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0KPiA+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC90cmFwcy5jDQo+ID4gQEAgLTIxMywxMiArMjEzLDcgQEAgREVGSU5FX0lEVEVO
VFJZKGV4Y19vdmVyZmxvdykNCj4gPiDCoMKgwqDCoMKgwqDCoMKgZG9fZXJyb3JfdHJhcChyZWdz
LCAwLCAib3ZlcmZsb3ciLCBYODZfVFJBUF9PRiwgU0lHU0VHViwgMCwNCj4gPiBOVUxMKTsNCj4g
PiDCoH0NCj4gPiDCoA0KPiA+IC0jaWZkZWYgQ09ORklHX1g4Nl9LRVJORUxfSUJUDQo+ID4gLQ0K
PiA+IC1zdGF0aWMgX19yb19hZnRlcl9pbml0IGJvb2wgaWJ0X2ZhdGFsID0gdHJ1ZTsNCj4gPiAt
DQo+ID4gLWV4dGVybiB2b2lkIGlidF9zZWxmdGVzdF9pcCh2b2lkKTsgLyogY29kZSBsYWJlbCBk
ZWZpbmVkIGluIGFzbQ0KPiA+IGJlbG93ICovDQo+ID4gLQ0KPiA+ICsjaWZkZWYgQ09ORklHX1g4
Nl9DRVQNCj4gPiDCoGVudW0gY3BfZXJyb3JfY29kZSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoENQ
X0VDwqDCoMKgwqDCoMKgwqAgPSAoMSA8PCAxNSkgLSAxLA0KPiA+IMKgDQo+ID4gQEAgLTIzMSwx
NSArMjI2LDg3IEBAIGVudW0gY3BfZXJyb3JfY29kZSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoENQ
X0VOQ0zCoMKgwqDCoMKgID0gMSA8PCAxNSwNCj4gPiDCoH07DQo+ID4gwqANCj4gPiAtREVGSU5F
X0lEVEVOVFJZX0VSUk9SQ09ERShleGNfY29udHJvbF9wcm90ZWN0aW9uKQ0KPiA+ICtzdGF0aWMg
Y29uc3QgY2hhciBjb250cm9sX3Byb3RlY3Rpb25fZXJyW11bMTBdID0gew0KPiANCj4gWW91IGFs
cmVhZHkgdXNlIHRoZSAiY3BfIiBwcmVmaXggZm9yIHRoZSBvdGhlciB0aGluZ3MsIG1pZ2h0IGFz
IHdlbGwNCj4gdXNlDQo+IGl0IGhlcmUgdG9vLg0KDQpTdXJlLg0KDQo+IA0KPiA+ICvCoMKgwqDC
oMKgwqDCoFswXSA9ICJ1bmtub3duIiwNCj4gPiArwqDCoMKgwqDCoMKgwqBbMV0gPSAibmVhciBy
ZXQiLA0KPiA+ICvCoMKgwqDCoMKgwqDCoFsyXSA9ICJmYXIvaXJldCIsDQo+ID4gK8KgwqDCoMKg
wqDCoMKgWzNdID0gImVuZGJyYW5jaCIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgWzRdID0gInJzdG9y
c3NwIiwNCj4gPiArwqDCoMKgwqDCoMKgwqBbNV0gPSAic2V0c3Nic3kiLA0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKmNwX2Vycl9zdHJpbmcodW5zaWduZWQgbG9uZyBl
cnJvcl9jb2RlKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGNwZWMg
PSBlcnJvcl9jb2RlICYgQ1BfRUM7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChjcGVj
ID49IEFSUkFZX1NJWkUoY29udHJvbF9wcm90ZWN0aW9uX2VycikpDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNwZWMgPSAwOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBj
b250cm9sX3Byb3RlY3Rpb25fZXJyW2NwZWNdOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCBkb191bmV4cGVjdGVkX2NwKHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25n
DQo+ID4gZXJyb3JfY29kZSkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoFdBUk5fT05DRSgx
LCAiVW5leHBlY3RlZCAlcyAjQ1AsIGVycm9yX2NvZGU6ICVzXG4iLA0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2VyX21vZGUocmVncykgPyAidXNlciBtb2Rl
IiA6ICJrZXJuZWwgbW9kZSIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNwX2Vycl9zdHJpbmcoZXJyb3JfY29kZSkpOw0KPiA+ICt9DQo+ID4gKyNlbmRpZiAv
KiBDT05GSUdfWDg2X0NFVCAqLw0KPiA+ICsNCj4gPiArdm9pZCBkb191c2VyX2NwX2ZhdWx0KHN0
cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nDQo+ID4gZXJyb3JfY29kZSk7DQo+IA0K
PiBXaGF0J3MgdGhhdCBmb3J3YXJkIGRlY2xhcmF0aW9uIGZvcj8NCg0KVGhlIHJlYXNvbiBpcyBj
cHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1VTRVJfU0hTVEspIHdpbGwgY29tcGlsZS0N
CnRpbWUgZXZhbHVhdGUgdG8gZmFsc2Ugd2hlbiB1c2VyIHNoYWRvdyBzdGFjayBpcyBub3QgY29u
ZmlndXJlZCwgc28gYQ0KZG9fdXNlcl9jcF9mYXVsdCgpIGltcGxlbWVudGF0aW9uIGlzIG5vdCBu
ZWVkZWQgaW4gdGhhdCBjYXNlLiBUaGUNCnJlZmVyZW5jZSBpbiBleGVjX2NvbnRyb2xfcHJvdGVj
dGlvbiB3aWxsIGdldCBvcHRpbWl6ZWQgb3V0LCBidXQgaXQNCnN0aWxsIG5lZWRzIHRvIGJlIGRl
ZmluZWQuDQoNCk90aGVyd2lzZSBpdCBjb3VsZCBoYXZlIGEgc3R1YiBpbXBsZW1lbnRhdGlvbiBp
biBhbiAjZWxzZSBibG9jaywgYnV0DQp0aGlzIHNlZW1lZCBjbGVhbmVyLg0KDQo+IA0KPiBJbiBh
bnkgY2FzZSwgcHVzaCBpdCBpbnRvIHRyYXBzLmggcGxzLg0KDQpJdCdzIG5vdCByZWFsbHkgc3Vw
cG9zZWQgdG8gYmUgY2FsbGVkIGZyb20gb3V0c2lkZSB0cmFwcy5jLiBUaGUgb25seQ0KcmVhc29u
IGl0IGlzIG5vdCBzdGF0aWMgaXQgYmVjYXVzZSBpdCBkb2Vzbid0IHdvcmsgd2l0aCB0aGVzZQ0K
SVNfRU5BQkxFRCgpLXN0eWxlIHNvbHV0aW9ucyBmb3IgY29tcGlsaW5nIG91dCBjb2RlLiBOb3cg
SSdtIHdvbmRlcmluZw0KaWYgdGhlc2UgYXJlIG5vdCBwcmVmZXJyZWQuLi4NCg0KPiANCj4gSSBn
b3R0YSBzYXksIEknbSBub3QgYSBiaWcgZmFuIG9mIHRoYXQgaWZkZWZmZXJ5IGhlcmUuIERvIHdl
IHJlYWxseQ0KPiByZWFsbHkgbmVlZCBpdD8NCg0KWW91IG1lYW4gaGF2aW5nIHNlcGFyYXRlIHBh
dGhzIGZvciBrZXJuZWwgSUJUIGFuZCB1c2VyIHNoYWRvdyBzdGFjaw0KdGhhdCBjb21waWxlIG91
dD8gSSBndWVzcyBpdCBjb3VsZCBqdXN0IGFsbCBiZSBpbiBwbGFjZSBpZg0KQ09ORklHX1g4Nl9D
RVQgaXMgaW4gcGxhY2UuDQoNCkkgZG9uJ3Qga25vdywgSSB0aG91Z2h0IGl0IHdhcyByZWxhdGl2
ZWx5IGNsZWFuLCBidXQgSSBjYW4gcmVtb3ZlIGl0Lg0KDQo+IA0KPiA+ICsjaWZkZWYgQ09ORklH
X1g4Nl9VU0VSX1NIQURPV19TVEFDSw0KPiA+ICtzdGF0aWMgREVGSU5FX1JBVEVMSU1JVF9TVEFU
RShjcGZfcmF0ZSwNCj4gPiBERUZBVUxUX1JBVEVMSU1JVF9JTlRFUlZBTCwNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgREVGQVVM
VF9SQVRFTElNSVRfQlVSU1QpOw0KPiA+ICsNCj4gPiArdm9pZCBkb191c2VyX2NwX2ZhdWx0KHN0
cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nDQo+ID4gZXJyb3JfY29kZSkNCj4gPiDC
oHsNCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRV
UkVfSUJUKSkgew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoIlVu
ZXhwZWN0ZWQgI0NQXG4iKTsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQlVH
KCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHRhc2tfc3RydWN0ICp0c2s7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBzc3A7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDC
oC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogQW4gZXhjZXB0aW9uIHdhcyBqdXN0IHRha2VuIGZy
b20gdXNlcnNwYWNlLiBTaW5jZQ0KPiA+IGludGVycnVwdHMgYXJlIGRpc2FibGVkDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgICogaGVyZSwgbm8gc2NoZWR1bGluZyBzaG91bGQgaGF2ZSBtZXNzZWQgd2l0
aCB0aGUNCj4gPiByZWdpc3RlcnMgeWV0IGFuZCB0aGV5DQo+ID4gK8KgwqDCoMKgwqDCoMKgICog
d2lsbCBiZSB3aGF0ZXZlciBpcyBsaXZlIGluIHVzZXJzcGFjZS4gU28gcmVhZCB0aGUgU1NQDQo+
ID4gYmVmb3JlIGVuYWJsaW5nDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0cyBzbyBs
b2NraW5nIHRoZSBmcHJlZ3MgdG8gZG8gaXQgbGF0ZXIgaXMgbm90DQo+ID4gcmVxdWlyZWQuDQo+
ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgcmRtc3JsKE1TUl9JQTMy
X1BMM19TU1AsIHNzcCk7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGNvbmRfbG9jYWxfaXJx
X2VuYWJsZShyZWdzKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgdHNrID0gY3VycmVudDsN
Cj4gPiArwqDCoMKgwqDCoMKgwqB0c2stPnRocmVhZC5lcnJvcl9jb2RlID0gZXJyb3JfY29kZTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqB0c2stPnRocmVhZC50cmFwX25yID0gWDg2X1RSQVBfQ1A7DQo+
ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFJhdGVsaW1pdCB0byBwcmV2ZW50IGxvZyBzcGFt
bWluZy4gKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoc2hvd191bmhhbmRsZWRfc2lnbmFscyAm
JiB1bmhhbmRsZWRfc2lnbmFsKHRzaywNCj4gPiBTSUdTRUdWKSAmJg0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoCBfX3JhdGVsaW1pdCgmY3BmX3JhdGUpKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHByX2VtZXJnKCIlc1slZF0gY29udHJvbCBwcm90ZWN0aW9uIGlwOiVs
eCBzcDolbHgNCj4gPiBzc3A6JWx4IGVycm9yOiVseCglcyklcyIsDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHNrLT5jb21tLCB0YXNrX3BpZF9u
cih0c2spLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlZ3MtPmlwLCByZWdzLT5zcCwgc3NwLCBlcnJvcl9jb2RlLA0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwX2Vycl9zdHJpbmcoZXJyb3Jf
Y29kZSksDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZXJyb3JfY29kZSAmIENQX0VOQ0wgPyAiIGluIGVuY2xhdmUiIDoNCj4gPiAiIik7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50X3ZtYV9hZGRyKEtFUk5fQ09OVCAi
IGluICIsIHJlZ3MtPmlwKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJf
Y29udCgiXG4iKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+IMKgDQo+ID4gLcKgwqDCoMKg
wqDCoMKgaWYgKFdBUk5fT05fT05DRSh1c2VyX21vZGUocmVncykgfHwgKGVycm9yX2NvZGUgJiBD
UF9FQykgIT0NCj4gPiBDUF9FTkRCUikpDQo+ID4gK8KgwqDCoMKgwqDCoMKgZm9yY2Vfc2lnX2Zh
dWx0KFNJR1NFR1YsIFNFR1ZfQ1BFUlIsICh2b2lkIF9fdXNlciAqKTApOw0KPiA+ICvCoMKgwqDC
oMKgwqDCoGNvbmRfbG9jYWxfaXJxX2Rpc2FibGUocmVncyk7DQo+ID4gK30NCj4gPiArI2VuZGlm
DQo+ID4gKw0KPiA+ICt2b2lkIGRvX2tlcm5lbF9jcF9mYXVsdChzdHJ1Y3QgcHRfcmVncyAqcmVn
cywgdW5zaWduZWQgbG9uZw0KPiA+IGVycm9yX2NvZGUpOw0KPiA+ICsNCj4gPiArI2lmZGVmIENP
TkZJR19YODZfS0VSTkVMX0lCVA0KPiA+ICtzdGF0aWMgX19yb19hZnRlcl9pbml0IGJvb2wgaWJ0
X2ZhdGFsID0gdHJ1ZTsNCj4gPiArDQo+ID4gK2V4dGVybiB2b2lkIGlidF9zZWxmdGVzdF9pcCh2
b2lkKTsgLyogY29kZSBsYWJlbCBkZWZpbmVkIGluIGFzbQ0KPiA+IGJlbG93ICovDQo+IA0KPiBZ
ZWFoLCBwbHMgcHV0IHRoYXQgY29tbWVudCBhYm92ZSB0aGUgZnVuY3Rpb24uIFNpZGUgY29tbWVu
dHMgYXJlDQo+IG5hc3R5Lg0KPiANCj4gVGh4Lg0KPiANClN1cmUuIFRoYW5rcy4NCg0K
