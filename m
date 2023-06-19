Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C963A735C60
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jun 2023 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFSQpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFSQpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 12:45:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B502E64;
        Mon, 19 Jun 2023 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687193092; x=1718729092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FaSkzBOPoESIXOkKsdtT+pyO78lp5lP1B+RKY4au7qA=;
  b=XJ7O9oBlScNVjKM1I/Pn7A5lCYeTj1FeZH/kNVuGwFDF/ouiQZYQPO4M
   /qkbNelsC+1volZh6+b3fRPgWvkKNINyrLi2UudAKtXT/Du+GAuRwbUGj
   5pNGc1v4GTZ8v/Qyj+90MFfjnn6TWmmX46+oZkngE+mwNFe95WLNN9MVv
   Eqifkzx20ik2G253r6FCKjI7+9L7CykWyFu68xTEX36a0GM19TIXkjmrJ
   OgF/pG9ojJrUMbKz2ATVjKh+nnO9kpFxW9q1MeFW9xN4Pul9+QrGZaVBZ
   MW+UWFMMbJ8E7EHnVvYrBjUxwjKfNo7SnDElxbCb1MDIaoakRbmoiukhO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="358543230"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="358543230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 09:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="887975849"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="887975849"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 19 Jun 2023 09:44:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 09:44:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 09:44:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 09:44:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 09:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKQgoYGyR/aKQ5bug9KY4Nkshbd9bnhegXSq8Q6hRrMV3ut44IrRdVMv0vCoJGEIAf19VsRHRqeYFW9pvJ7J+Rh3kB17phVWhz01S0IXr6IuWwJMss0yDQvyTMN/3mEfE+YW+/4NpUdyjrIxXOdofa7v5OcLI/1tfndL2km9r2TL029eTuCPLBFUscwzgrcgGDnfdPkoXY1BQ+yJ59dINFYBTzAJ3Lte/HJFAdYO/gjOLUmce3diTwpQsxeb+Pd3ROHLRdNfZ7EZrWCZQUNZIAAqAtfBSDeWjl/KJAtt/t8HJKm7HT2gVRD719wuQwUukCkGSUThHZHdmtEEwevaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaSkzBOPoESIXOkKsdtT+pyO78lp5lP1B+RKY4au7qA=;
 b=Wo6qIzkZmNXaGyuFA4ASPMmj5p1tc9ncJ+vhsaVBomwsjS3rTMs8zd4crnQ216BLaKEmcoxQIdV5znmis5vF9P1dy+1g8OjAxfKTkx5n4y8iiiw8IsKvYtV5f8kFVNsEyeAuxy9o7U1RTEWzJ2QDUvMRIT1EqSBrGpK7BRaMaVz/YXggS3zZ8qpFwWSAakMALPok+CB0J7aM5zb1IDF8UMr4Wwb0Nfna2ExIz0ojvXNTR9bRm2lp9Wfl8rCuZi0ZEUJgX3IbAeB5poU9GD8Y6hUVXX5jHwHGQpiHSqxeKS8cqdsGwWGwNlG2v8Zq1xlSt7geHorGuhlg1c5hwLiRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 16:44:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 16:44:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGA
Date:   Mon, 19 Jun 2023 16:44:41 +0000
Message-ID: <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
         <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
         <87y1knh729.fsf@oldenburg.str.redhat.com>
         <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
In-Reply-To: <ZJAWMSLfSaHOD1+X@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 5d51336b-6851-4a10-7a8f-08db70e47ace
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0MPZ3BlO+zwTefzumWxnDW9BUrOLvprv0mTo2WeMTk8ItnuiI/2SpI5lQGxQWYKoXiKpXOZbLygQtOomTngf4ggxpMyScxUHew19/N1PnXzgGC51mGB8sZPZb5wNw8NP1bWc+W9Td6DoIQCo3Xf9anDSSRZ4G7cdgw3v6MAuJjTFX+LfURFJU5l3ZUmP5cGj2tSKFIQKe6CnsNZFvuL83PfNaTFv1lRtcEwBC//9W9wSIib04kYpuwD8jYMCSNqhQKIqgt0ZKzsEFzq7VMGhLvL4LU/1LNCXo5QKntQClO3ArAtHH/3Cx9sdz5+Yj9a+WJQmhf/Y/iSWlZ41EzjGZDFa1SoWE86g3EgynFf05aKZnY7glmYUJffiCSmwPCMGajN1FICbFRS2r02pTQcWqW19t8p/1DLvy1M6xXpwQ9ADgHK5pxDkrE4YdS4Fi3s8kLRI4aD+6V232ZI0vtPcl/yaVeoTE/Vo3TM6MMaAFocnMGQN4l4Pyfme6pBmn3AvqCf+IHKVTCofquVIFE5gM58TIVe8/j0GaHROzAsxH03vDRRShdYW04lH2+WLQjfcO8CCYn1Dv6CO5ZWsAG/cVWANuvYImw2UBgp4fJDHpU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(478600001)(2906002)(66899021)(966005)(54906003)(6486002)(2616005)(110136005)(86362001)(71200400001)(122000001)(38070700005)(36756003)(26005)(186003)(6506007)(6512007)(7416002)(8936002)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(7406005)(5660300002)(91956017)(38100700002)(316002)(4326008)(83380400001)(82960400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdWQy8rRDI1NFdZc0M3T2NucUF3Rm11WDdEVGs3dU9neWwyL2FEc3JiTWwr?=
 =?utf-8?B?K1BWUC83TVd2MkNQb1RCNEtlMVVYWmJOQnFFam96M2I1NXhBbDVPdXc5NjF6?=
 =?utf-8?B?ZE94dnAyZmZyM1g1ZXViUEMzcVR6MUFoNTM4THRVZjh5UXNmQVZMUTZqM09F?=
 =?utf-8?B?bWllei83WTRnaTdyMUVHSDJWVmxDVE5VQjhVY2h5cEhOSVEzRDdJczRlcXhU?=
 =?utf-8?B?ZHhzNGNvME0wcVlTZDA4QnBlcmxBbzRhaW1zYmx6VlZJKzJ2OWtKa3p3bWYx?=
 =?utf-8?B?cTBmYU5JZThNSmhTRVJwNHdGOE1SbG9hRE1Zc0ZRODRzZ0djdFB3UjRlTHdQ?=
 =?utf-8?B?cHhqUFBjUVRLWFVZbkFkYTFiRDVLMmltRDdMc0ExTmV6TE45K1JhdEEzaHZN?=
 =?utf-8?B?V0VnV0pMT1hmd3VKbmRFUE1JOWVCY29zRjZzMFd5UWxVKzE4clBveGdwVVlC?=
 =?utf-8?B?K0pPOWYrdnBjdU83NVVTVlUwdVpaV1NUNzZ4d3NMNTJhS0dPNGpqbVZsSW4z?=
 =?utf-8?B?clg2dlh3YkxJN0ErVDN0ZmxTd0FhVFdDN1ZGWnduMGtOczRyWGUySmxQTnVk?=
 =?utf-8?B?OEE1SDROYk9IWjJSdEdNeTNRdGpXT2VIMEFQNWpCUktTTlJESVVZcWgwaVUv?=
 =?utf-8?B?Z1BxSW4yaXpUdUFJaHNNL1phelc0Ty85ODlMZGcxWGphc3M5bjBrNDREVWlC?=
 =?utf-8?B?Q2pleGUyNHNvNnZ1bU02YTJRUkhSNFprUFBlcVRvemtXdFRNMDM1YmhmaUJy?=
 =?utf-8?B?eFRuRXVaK2ZnWGN0OEhYYjUrcmdPeXZES2EyTUxzQkR1dkQyT081dWNLK3NG?=
 =?utf-8?B?eFdZWDVLVC9IbEdFWFcxUVU0WEN6ZnBUWU9HanJIQ0lPV0FhalRreUZVbTJS?=
 =?utf-8?B?ckVQWnhFTE1NSFpORWhRM1lYSktVTUhQWjlRbEI4OEJDRlg1RGhpZEVmaG5z?=
 =?utf-8?B?OGt2YUJJNm9MYmlOcktVUURFd2hkQXJRZVJHQ3NIRWFLVkdTdlo5bHdaL3F3?=
 =?utf-8?B?LzI5S0NSNUQyeUdUTW5nWmJiSGVPT1hyTmRLWmZSZGJuVnh1Q3o3RWtERWs5?=
 =?utf-8?B?VUd1VWgrb1d2cDJ1Qm1ZR3dROEYwQkRwL3FJaHU3QXlRS2pjRW5ZWFVWN1BI?=
 =?utf-8?B?cE82TkZMU2VuZnoyK0owUnpLZVJ4eXU3cjdjWGF3dDYydFBuVDg4dkx3dWhB?=
 =?utf-8?B?WG9VbTR2VHc3NElBTS93ZTFuL3A1Z0FXaS8xU2gva3B4MEpmMGd0L1lNWGpT?=
 =?utf-8?B?L2w5bjNLM1JuM1RjR0xnaEFDTm9sQkFpMFRFTEUwRFVGb0pVY083YnlsaUd6?=
 =?utf-8?B?ZlQ1NTRYb1RXUnRQVTZUemtOcGhiQnE5aW1lVmJPQW1WU0ErdFFmaW50VTJB?=
 =?utf-8?B?WGIxbFQ0VTJzMEVEUmQ2WUFTWS8vRTNUTHQzZ2gxVStoWVZSblZ2L2ltZTBK?=
 =?utf-8?B?bXAzRHNpZno1bXdHVmh4OTNPM2RibE4zSkljaUk1UzNyTlBGQWU4aFk1SmZR?=
 =?utf-8?B?Z3Q2REpXTmx6MTBWSkZ2Q1NYUkQvVU00SlA5MHJQMThCNjZWOGNkU2NQMFBP?=
 =?utf-8?B?ak1LYW96NnoyWmV0MFBZaEVFdEJ4YmhwYXZRYWk3aHVuaEtxZU9vdkd3R2dD?=
 =?utf-8?B?NFFqM3JWajk5enRUaERlZnprdENHUGduVTNNajY4R3J1L1V0VHI4UEhwejlO?=
 =?utf-8?B?RkxyT2xVZEpXRk53dnI2R3dydGJjS1BkbHdtd21QdVJ2TEptdXJIR3hHUnJR?=
 =?utf-8?B?T1dzeURkNGFkVUp0ZmFqc1kvQ0hsU1Q4ZkJSM09kMVBCQ0g5d2NudzVXcWl3?=
 =?utf-8?B?YnNYVDFDWEphSlFkcjVjQWtNM2NEY1o2dHRvejkvdDN4V25TcjZ2NzFOVlEx?=
 =?utf-8?B?MGo5VWNtSk9HS2ZjcktFSUVZQzBRa05XTWFjVHU0OUtya1ZmSEIyc2tyQ1pL?=
 =?utf-8?B?dnJ0bnBwekI0ZmxYcHNLbDhESjNXdnlPZWZFYnNlMDlCRFplYkFTSEFKZWds?=
 =?utf-8?B?U2VZK2NsN2thbHRMbmhQRUFCeFRXM0lmRnZZUHAveWVFdm0rQ1FwdWEwdnZ2?=
 =?utf-8?B?NEZ6SFcwUTkyZ2svU2FiOWJpZUxpMHgzS3czMmpKcE1FTzR4Tm1IcldVNE9n?=
 =?utf-8?B?TUczUEFyc1hvYVZNY3dsMVR0aUdrL2pFNEJxZW5KSHQrT0hJTjJGRndLaHFM?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E59313054A7C8D43AFF930026434D909@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d51336b-6851-4a10-7a8f-08db70e47ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:44:41.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZntkhJH6AXG8HD3tIIcr6ZJ8IoM7Xc7nrMVTsmkWiPRcLQdN8CFYxikwHD84ba4D9SF6LwG7IEYmhTBqMJmlv00/i8aXOp63jdKIAIOqpyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDA5OjQ3ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwNi8xNC8yMDIzIDE2OjU3LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjMtMDYtMTQgYXQgMTE6NDMgKzAxMDAsIHN6YWJvbGNzLm5hZ3lAYXJt
LmNvbcKgd3JvdGU6DQo+ID4gPiBpIGRvbnQgdGhpbmsgeW91IGNhbiBhZGQgc2lnYWx0c2hzdGsg
bGF0ZXIuDQo+ID4gPiANCj4gPiA+IGxpYmdjYyBhbHJlYWR5IGhhcyB1bndpbmRlciBjb2RlIGZv
ciBzaHN0ayBhbmQgdGhhdCBjYW5ub3QgaGFuZGxlDQo+ID4gPiBkaXNjb250aW5vdXMgc2hhZG93
IHN0YWNrLg0KPiA+IA0KPiA+IEFyZSB5b3UgcmVmZXJyaW5nIHRvIHRoZSBleGlzdGluZyBDKysg
ZXhjZXB0aW9uIHVud2luZGluZyBjb2RlIHRoYXQNCj4gPiBleHBlY3RzIGEgZGlmZmVyZW50IHNp
Z25hbCBmcmFtZSBmb3JtYXQ/IFllYSB0aGlzIGlzIGEgcHJvYmxlbSwgYnV0DQo+ID4gSQ0KPiA+
IGRvbid0IHNlZSBob3cgaXQncyBhIHByb2JsZW0gd2l0aCBhbnkgc29sdXRpb25zIG5vdyB0aGF0
IHdpbGwgYmUNCj4gPiBoYXJkZXINCj4gPiBsYXRlci4gSSBtZW50aW9uZWQgaXQgd2hlbiBJIGJy
b3VnaHQgdXAgYWxsIHRoZSBhcHAgY29tcGF0aWJpbGl0eQ0KPiA+IHByb2JsZW1zLlswXQ0KPiAN
Cj4gdGhlcmUgaXMgb2xkIHVud2luZGVyIGNvZGUgaW5jb21wYXRpYmxlIHdpdGggdGhlIGN1cnJl
bnQgcGF0Y2hlcywNCj4gYnV0IHRoYXQgd2FzIGZpeGVkLiBob3dldmVyIHRoZSBuZXcgdW53aW5k
IGNvZGUgYXNzdW1lcyBzaWduYWwNCj4gZW50cnkgcHVzaGVzIG9uZSBleHRyYSB0b2tlbiB0aGF0
IGp1c3QgaGF2ZSB0byBiZSBwb3BwZWQgZnJvbSB0aGUNCj4gc2hzdGsuIHRoaXMgYWJpIGNhbm5v
dCBiZSBleHBhbmRlZCB3aGljaCBtZWFucw0KPiANCj4gMSkga2VybmVsIGNhbm5vdCBwdXNoIG1v
cmUgdG9rZW5zIGZvciBtb3JlIGludGVncml0eSBjaGVja3MNCj4gwqDCoCAob3IgdG8gYWRkIHdo
YXRldmVyIG90aGVyIGZlYXR1cmVzKQ0KPiANCj4gMikgc2lnYWx0c2hzdGsgY2Fubm90IHdvcmsu
DQo+IA0KPiBpZiB0aGUgdW53aW5kZXIgaW5zdGVhZCBpbnRlcnByZXRzIHRoZSB0b2tlbiB0byBi
ZSB0aGUgb2xkIHNzcCBhbmQNCj4gZWl0aGVyIGluY3NzcCBvciBzd2l0Y2ggdG8gdGhhdCBzc3Ag
KGRlcGVuZGluZyBvbiBjb250aW5vdXMgb3INCj4gZGlzY29udGlub3VzIHNoc3RrLCB3aGljaCB0
aGUgdW53aW5kZXIgY2FuIGRldGVjdCksIHRoZW4gMSkgYW5kIDIpDQo+IGFyZSBmaXhlZC4NCj4g
DQo+IGJ1dCBjdXJyZW50bHkgdGhlIGRpc3RyaWJ1dGVkIHVud2luZGVyIGJpbmFyeSBpcyBpbmNv
bXBhdGlibGUgd2l0aA0KPiAxKSBhbmQgMikgc28gc2lnYWx0c2hzdGsgY2Fubm90IGJlIGFkZGVk
IGxhdGVyLiBicmVha2luZyB0aGUgdW53aW5kDQo+IGFiaSBpcyBub3QgYWNjZXB0YWJsZS4NCg0K
Q2FuIHlvdSBwb2ludCBtZSB0byB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dD8gSSB0ZXN0ZWQg
YWRkaW5nIGZpZWxkcw0KdG8gdGhlIHNoYWRvdyBzdGFjayBvbiB0b3Agb2YgdGhlc2UgY2hhbmdl
cy4gSXQgd29ya2VkIHdpdGggSEoncyBuZXcNCih1bnBvc3RlZCBJIHRoaW5rKSBDKysgY2hhbmdl
cyBmb3IgZ2NjLiBBZGRpbmcgZmllbGRzIGRvZXNuJ3Qgd29yayB3aXRoDQp0aGUgZXhpc3Rpbmcg
Z2NjIGJlY2F1c2UgaXQgYXNzdW1lcyBhIGZpeGVkIHNpemUuDQoNCj4gDQo+ID4gVGhlIHByb2Js
ZW0gaXMgdGhhdCBnY2MgZXhwZWN0cyBhIGZpeGVkIDggYnl0ZSBzaXplZCBzaGFkb3cgc3RhY2sN
Cj4gPiBzaWduYWwgZnJhbWUuIFRoZSBmb3JtYXQgaW4gdGhlc2UgcGF0Y2hlcyBpcyBzdWNoIHRo
YXQgaXQgY2FuIGJlDQo+ID4gZXhwYW5kZWQgZm9yIHRoZSBzYWtlIG9mIHN1cHBvcnRpbmcgYWx0
IHNoYWRvdyBzdGFjayBsYXRlciwgYnV0IGl0DQo+ID4gaGFwcGVucyB0byBiZSBhIGZpeGVkIDgg
Ynl0ZXMgZm9yIG5vdywgc28gaXQgd2lsbCB3b3JrIHNlYW1sZXNzbHkNCj4gPiB3aXRoDQo+ID4g
dGhlc2Ugb2xkIGdjYydzLiBISiBoYXMgc29tZSBwYXRjaGVzIHRvIGZpeCBHQ0MgdG8ganVtcCBv
dmVyIGENCj4gPiBkeW5hbWljYWxseSBzaXplZCBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lLCBi
dXQgdGhpcyBvZiBjb3Vyc2UNCj4gPiB3b24ndA0KPiA+IHN0b3Agb2xkIGdjYydzIGZyb20gZ2Vu
ZXJhdGluZyBiaW5hcmllcyB0aGF0IHdvbid0IHdvcmsgd2l0aCBhbg0KPiA+IGV4cGFuZGVkIGZy
YW1lLg0KPiA+IA0KPiA+IEkgd2FzIHdhZmZsaW5nIG9uIHdoZXRoZXIgaXQgd291bGQgYmUgYmV0
dGVyIHRvIHBhZCB0aGUgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiBbMV0gc2lnbmFsIGZyYW1lIHRv
IHN0YXJ0LCB0aGlzIHdvdWxkIGJyZWFrIGNvbXBhdGliaWxpdHkgd2l0aCBhbnkNCj4gPiBiaW5h
cmllcyB0aGF0IHVzZSB0aGlzIC1mbm9uLWNhbGwtZXhjZXB0aW9ucyBmZWF0dXJlIChpZiB0aGVy
ZSBhcmUNCj4gPiBhbnkpLCBidXQgd291bGQgc2V0IHVzIHVwIGJldHRlciBmb3IgdGhlIGZ1dHVy
ZSBpZiB3ZSBnb3QgYXdheSB3aXRoDQo+ID4gaXQuDQo+IA0KPiBpIGRvbid0IHNlZSBob3cgLWZu
b24tY2FsbC1leGNlcHRpb25zIGlzIHJlbGV2YW50Lg0KDQpJdCB1c2VzIHVud2luZGVyIGNvZGUg
dGhhdCBkb2VzIGFzc3VtZSBhIGZpeGVkIHNoYWRvdyBzdGFjayBzaWduYWwNCmZyYW1lIHNpemUu
IFNpbmNlIGdjYyA4LjUgSSB0aGluay4gU28gdGhlc2UgY29tcGlsZXJzIHdpbGwgY29udGludWUg
dG8NCmdlbmVyYXRlIGNvZGUgdGhhdCBhc3N1bWVzIGEgZml4ZWQgZnJhbWUgc2l6ZS4gVGhpcyBp
cyBvbmUgb2YgdGhlDQpsaW1pdGF0aW9ucyB3ZSBoYXZlIGZvciBub3QgbW92aW5nIHRvIGEgbmV3
IGVsZiBiaXQuDQoNCj4gDQo+IHlvdSBjYW4gdW53aW5kIGZyb20gYSBzaWduYWwgaGFuZGxlciAo
dGhpcyBpcyBub3QgYSBjKysgcXVlc3Rpb24NCj4gYnV0IHVud2luZCBhYmkgcXVlc3Rpb24pIGFu
ZCBpbiBwcmFjdGljZSBlaCB3b3JrcyBlLmcuIGlmIHRoZQ0KPiBzaWduYWwgaXMgcmFpc2VkIChz
eW5jIG9yIGFzeW5jKSBpbiBhIGZyYW1lIHdoZXJlIHRoZXJlIGFyZSBubw0KPiBjbGVhbnVwIGhh
bmRsZXJzIHJlZ2lzdGVyZWQuIGluIHByYWN0aWNlIGNvZGUgcmFyZWx5IHJlbGllcyBvbg0KPiB0
aGlzIChiZWNhdXNlIGl0J3Mgbm90IHZhbGlkIGluIGMrKykuIHRoZSBtYWluIHVzZXIgb2YgdGhp
cyBpDQo+IGtub3cgb2YgaXMgdGhlIGdsaWJjIGNhbmNlbGxhdGlvbiBpbXBsbWVudGF0aW9uLiAo
dGhhdCBpcyBzcGVjaWFsDQo+IGluIHRoYXQgaXQgbmV2ZXIgY2F0Y2hlcyB0aGUgZXhjZXB0aW9u
IHNvIHNzcCBkb2VzIG5vdCBoYXZlIHRvIGJlDQo+IHVwZGF0ZWQgZm9yIHRoaW5ncyB0byB3b3Jr
LCBidXQgaW4gcHJpbmNpcGxlIHRoZSB1bndpbmRlciBzaG91bGQNCj4gc3RpbGwgdmVyaWZ5IHRo
ZSBlbnRyaWVzIG9uIHNoc3RrLCBvdGhlcndpc2UgdGhlIHNlY3VyaXR5DQo+IGd1YXJhbnRlZXMg
YXJlIGJyb2tlbiBhbmQgdGhlIGNsZWFudXAgaGFuZGxlcnMgY2FuIGJlIGhpamFja2VkLg0KPiB0
aGVyZSBhcmUgZ2xpYmMgYWJpIGlzc3VlcyB0aGF0IHByZXZlbnQgZml4aW5nIHRoaXMsIGJ1dCBp
biBvdGhlcg0KPiBsaWJjcyB0aGlzIG1heSBiZSBzdGlsbCByZWxldmFudCkuDQoNCkknbSBub3Qg
ZnVsbHkgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBoZXJlLiBUaGUgZ2xpYmMgc2hh
ZG93DQpzdGFjayBzdHVmZiB0aGF0IGlzIHRoZXJlIHRvZGF5IHN1cHBvcnRzIHVud2luZGluZyB0
aHJvdWdoIGEgc2lnbmFsDQpoYW5kbGVyLiBUaGUgbG9uZ2ptcCBjb2RlICh1bmxpa2UgZm5vbi1j
YWxsLWV4ZWN0aW9ucykgZG9lc24ndCBsb29rIGF0DQp0aGUgc2hzdGsgc2lnbmFsIGZyYW1lLiBJ
dCBqdXN0IGRvZXMgSU5DU1NQIHVudGlsIGl0IHJlYWNoZXMgaXRzDQpkZXNpcmVkIFNTUCwgbm90
IGNhcmluZyB3aGF0IGl0IGlzIElOQ1NTUGluZyBvdmVyLg0KDQo+IA0KPiA+IE9uIG9uZSBoYW5k
IHdlIGFyZSBhbHJlYWR5IGp1Z2dsaW5nIHNvbWUgY29tcGF0aWJpbGl0eSBpc3N1ZXMgc28NCj4g
PiBtYXliZQ0KPiA+IGl0J3Mgbm90IHRvbyBtdWNoIHdvcnNlLCBidXQgb24gdGhlIG90aGVyIGhh
bmQgdGhlIGtlcm5lbCBpcyB0cnlpbmcNCj4gPiBpdHMNCj4gPiBiZXN0IHRvIGJlIGFzIGNvbXBh
dGlibGUgYXMgaXQgY2FuIGdpdmVuIHRoZSBzaXR1YXRpb24uIEl0IGRvZXNuJ3QNCj4gPiAqbmVl
ZCogdG8gYnJlYWsgdGhpcyBjb21wYXRpYmlsaXR5IGF0IHRoaXMgcG9pbnQuDQo+ID4gDQo+ID4g
SW4gdGhlIGVuZCBJIHRob3VnaHQgaXQgd2FzIGJldHRlciB0byBkZWFsIHdpdGggaXQgbGF0ZXIu
DQo+ID4gDQo+ID4gPiDCoChtYXkgYWZmZWN0IGxvbmdqbXAgdG9vIGRlcGVuZGluZyBvbg0KPiA+
ID4gaG93IGl0IGlzIGltcGxlbWVudGVkKQ0KPiA+IA0KPiA+IGdsaWJjJ3MgbG9uZ2ptcCBpZ25v
cmVzIGFueXRoaW5nIGV2ZXJ5dGhpbmcgaXQgc2tpcHMgb3ZlciBhbmQganVzdA0KPiA+IGRvZXMN
Cj4gPiBJTkNTU1AgdW50aWwgaXQgZ2V0cyBiYWNrIHRvIHRoZSBzZXRqbXAgcG9pbnQuIFNvIGl0
IGlzIG5vdA0KPiA+IGFmZmVjdGVkIGJ5DQo+ID4gdGhlIHNoYWRvdyBzdGFjayBzaWduYWwgZnJh
bWUgZm9ybWF0LiBJIGRvbid0IHRoaW5rIHdlIGNhbiBzdXBwb3J0DQo+ID4gbG9uZ2ptcGluZyBv
ZmYgYW4gYWx0IHNoYWRvdyBzdGFjayB1bmxlc3Mgd2UgZW5hYmxlIFdSU1Mgb3IgZ2V0IHRoZQ0K
PiA+IGtlcm5lbCdzIGhlbHAuIFNvIHRoaXMgd2FzIHRvIGJlIGRlY2xhcmVkIGFzIHVuc3VwcG9y
dGVkLg0KPiANCj4gbG9uZ2ptcCBjYW4gc3VwcG9ydCBkaXNjb250aW5vdXMgc2hhZG93IHN0YWNr
IHdpdGhvdXQgd3Jzcy4NCj4gdGhlIGN1cnJlbnQgY29kZSBwcm9wb3NlZCB0byBnbGliYyBkb2Vz
IG5vdCwgd2hpY2ggaXMgd3JvbmcNCj4gKGl0IGJyZWFrcyBhbHRzaHN0ayBhbmQgZ3JlZW4gdGhy
ZWFkIHVzZXJzIGxpa2UgcWVtdSBmb3Igbm8NCj4gZ29vZCByZWFzb24pLg0KPiANCj4gZGVjbGFy
aW5nIHRoaW5ncyB1bnN1cHBvcnRlZCBtZWFucyB5b3UgaGF2ZSB0byBnbyBhcm91bmQgdG8NCj4g
YXVkaXQgYW5kIG1hcmsgYmluYXJpZXMgYWNjb3JkaW5nbHkuDQoNClRoZSBpZGVhIHRoYXQgYWxs
IGFwcHMgY2FuIGJlIHN1cHBvcnRlZCB3aXRob3V0IGF1ZGl0aW5nIGhhcyBiZWVuDQphc3N1bWVk
IHRvIGJlIGltcG9zc2libGUgYnkgZXZlcnlvbmUgSSd2ZSB0YWxrZWQgdG8sIGluY2x1ZGluZyB0
aGUNCkdMSUJDIGRldmVsb3BlcnPCoGRlZXBseSB2ZXJzZWQgaW4gdGhlIGFyY2hpdGVjdHVyYWwg
bGltaXRhdGlvbnMgb2YgdGhpcw0KZmVhdHVyZS4gU28gaWYgeW91IGhhdmUgYSBtYWdpYyBzb2x1
dGlvbiwgdGhlbiB0aGF0IGlzIGEgbm90YWJsZSBjbGFpbQ0KYW5kIEkgdGhpbmsgeW91IHNob3Vs
ZCBwcm9wb3NlIGl0IGluc3RlYWQgb2YganVzdCBhbGx1ZGluZyB0byB0aGUgZmFjdA0KdGhhdCB0
aGVyZSBpcyBvbmUuDQoNClRoZSBvbmx5IG5vbi1XUlNTICJsb25nam1wIGZyb20gYW4gYWx0IHNo
YWRvdyBzdGFjayBzb2x1dGlvbiIgdGhhdCBJDQpjYW4gdGhpbmsgb2Ygd291bGQgaGF2ZSBzb21l
dGhpbmcgbGlrZSBhIG5ldyBzeXNjYWxsIHBlcmZvcm1pbmcgc29tZQ0KbGltaXRlZCBzaGFkb3cg
c3RhY2sgYWN0aW9ucyBub3JtYWxseSBwcm9oaWJpdGVkIGluIHVzZXJzcGFjZSBieSB0aGUNCmFy
Y2hpdGVjdHVyZS4gV2UnZCBoYXZlIHRvIHRoaW5rIHRocm91Z2ggaG93IHRoaXMgd291bGQgaW1w
YWN0IHRoZQ0Kc2VjdXJpdHkuwqBUaGVyZSBhcmUgYSBsb3Qgb2Ygc2VjdXJpdHkvY29tcGF0aWJp
bGl0eSB0cmFkZW9mZnMgdG8gcGFyc2UNCmluIHRoaXMuIFNvIGFsc28sIGp1c3QgYmVjYXVzZSBz
b21ldGhpbmcgY2FuIGJlIGRvbmUsIGRvZXNuJ3QgbWVhbiB3ZQ0Kc2hvdWxkIGRvIGl0LiBJIHRo
aW5rIHRoZSBwaGlsb3NvcGh5IGF0IHRoaXMgcG9pbnQgaXMsIGxldHMgZ2V0IHRoZQ0KYmFzaWNz
IHdvcmtpbmcgdGhhdCBjYW4gc3VwcG9ydCBtb3N0IGFwcHMsIGFuZCBsZWFybiBtb3JlIGFib3V0
IHN0dWZmDQpsaWtlIHdoZXJlIHRoaXMgYmFyIGlzIGluIHRoZSByZWFsIHdvcmxkLg0KDQo+IA0K
PiA+ID4gd2UgY2FuIGNoYW5nZSB0aGUgdW53aW5kZXIgbm93IHRvIGtub3cgaG93IHRvIHN3aXRj
aCBzaHN0ayB3aGVuDQo+ID4gPiBpdCB1bndpbmRzIHRoZSBzaWduYWwgZnJhbWUgYW5kIGJhY2tw
b3J0IHRoYXQgdG8gc3lzdGVtcyB0aGF0DQo+ID4gPiB3YW50IHRvIHN1cHBvcnQgc2hzdGsuIG9y
IHdlIGNhbiBpbnRyb2R1Y2UgYSBuZXcgZWxmIG1hcmtpbmcNCj4gPiA+IHNjaGVtZSBqdXN0IGZv
ciBzaWdhbHRzaHN0ayB3aGVuIGl0IGlzIGFkZGVkIHNvIGluY29tcGF0aWJpbGl0eQ0KPiA+ID4g
Y2FuIGJlIGRldGVjdGVkLiBvciB3ZSBzaW1wbHkgbm90IHN1cHBvcnQgdW53aW5kaW5nIHdpdGgN
Cj4gPiA+IHNpZ2FsdHNoc3RrIHdoaWNoIHdvdWxkIG1ha2UgaXQgcHJldHR5IG11Y2ggdXNlbGVz
cyBpbiBwcmFjdGljZS4NCj4gPiANCj4gPiBZZWEsIEkgd2FzIHRoaW5raW5nIGFsb25nIHRoZSBz
YW1lIGxpbmVzLiBTb21lZGF5IHdlIGNvdWxkIGVhc2lseQ0KPiA+IG5lZWQNCj4gPiBzb21lIG5l
dyBtYXJrZXIuIE1heWJlIGJlY2F1c2Ugd2Ugd2FudCB0byBhZGQgc29tZXRoaW5nLCBvciBtYXli
ZQ0KPiA+IGJlY2F1c2Ugb2YgdGhlIHByZS1leGlzdGluZyB1c2Vyc3BhY2UuIEluIHRoYXQgY2Fz
ZSwgdGhpcw0KPiA+IGltcGxlbWVudGF0aW9uIHdpbGwgZ2V0IHRoZSBiYWxsIHJvbGxpbmcgYW5k
IHdlIGNhbiBsZWFybiBtb3JlDQo+ID4gYWJvdXQNCj4gPiBob3cgc2hhZG93IHN0YWNrIHdpbGwg
YmUgdXNlZC4gU28gaWYgd2UgbmVlZCB0byBicmVhayBjb21wYXRpYmlsaXR5DQo+ID4gd2l0aCBh
bnkgYXBwcywgd2Ugd291bGQgbm90IHJlYWxseSBiZSBpbiBhIGRpZmZlcmVudCBzaXR1YXRpb24g
dGhhbg0KPiA+IHdlDQo+ID4gYXJlIGFscmVhZHkgaW4gKGlmIHdlIGFyZSBnb2luZyB0byB0YWtl
IHByb3BlciBjYXJlIHRvIG5vdCBicmVhaw0KPiA+IHVzZXJzcGFjZSkuIFNvIGlmL3doZW4gdGhh
dCBoYXBwZW5zIGFsbCB0aGUgbGVhcm5pbmcncyBjYW4gZ28gaW50bw0KPiA+IHRoZQ0KPiA+IGNs
ZWFuIGJyZWFrLg0KPiA+IA0KPiA+IEJ1dCBpZiBpdCdzIG5vdCBjbGVhciwgdW53aW5kZXIncyB0
aGF0IHByb3Blcmx5IHVzZSB0aGUgZm9ybWF0IGluDQo+ID4gdGhlc2UNCj4gPiBwYXRjaGVzIHNo
b3VsZCB3b3JrIGZyb20gYW4gYWx0IHNoYWRvdyBzdGFjayBpbXBsZW1lbnRlZCBsaWtlIHRoYXQN
Cj4gPiBSRkMNCj4gPiBsaW5rZWQgZWFybGllciBpbiB0aGUgdGhyZWFkLiBBdCBsZWFzdCBpdCB3
aWxsIGJlIGFibGUgdG8gcmVhZCBiYWNrDQo+ID4gdGhlDQo+ID4gc2hhZG93IHN0YWNrIHN0YXJ0
aW5nIGZyb20gdGhlIGFsdCBzaGFkb3cgc3RhY2ssIGl0IGNhbid0IGFjdHVhbGx5DQo+ID4gcmVz
dW1lIGNvbnRyb2wgZmxvdyBmcm9tIHdoZXJlIGl0IHVud291bmQgdG8uIEZvciB0aGF0IHdlIG5l
ZWQgV1JTUw0KPiA+IG9yDQo+ID4gc29tZSBrZXJuZWwgaGVscC4NCj4gDQo+IHdyc3MgaXMgbm90
IG5lZWRlZCB0byByZXN1bWUgY29udHJvbCBmbG93IG9uIGEgZGlmZmVyZW50IHNoc3RrLg0KDQpX
UlNTIGxldHMgeW91IHJlc3VtZSBjb250cm9sIGZsb3cgYXQgYXJiaXRyYXJpbHkgcG9pbnRzIGJ5
IHdyaXRpbmcgeW91cg0Kb3duIHJlc3RvcmUgdG9rZW4uIE90aGVyd2lzZSB0aGVyZSBhcmUgcmVz
dHJpY3Rpb25zLg0KDQo+IA0KPiAoaWYgeW91IG5lZWRlZCB3cnNzIHRoZW4gdGhlIG1hcF9zaGFk
b3dfc3RhY2sgd291bGQgYmUgdXNlbGVzcy4pDQoNCm1hcF9zaGFkb3dfc3RhY2sgaXMgdXN1YWxs
eSBwcmVwb3B1bGF0ZWQgd2l0aCBhIHRva2VuLCBvdGhlcndpc2UgaXQNCmRvZXMgbmVlZCBXUlNT
IHRvIGNyZWF0ZSBvbmUgb24gaXQuDQoNCj4gDQo+ID4gDQo+ID4gWzBdDQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC83ZDgxMzNjN2UwMTg2YmRhZWIzODkzYzFjODA4MTQ4ZGMwZDEx
OTQ1LmNhbWVsQGludGVsLmNvbS8NCj4gPiANCg0K
