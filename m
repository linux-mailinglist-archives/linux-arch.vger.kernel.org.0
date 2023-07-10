Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F49E74E19A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 00:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGJW5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 18:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGJW5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 18:57:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B3BFB;
        Mon, 10 Jul 2023 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689029818; x=1720565818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b0FuC0dT2v791y/700VzRmGtCdMGIieC8HEsH1khSBI=;
  b=LCl8NHOHkQ3+FZ+RWwCDkXzXckWZndSMLj1RpsjabvwD/eEbm6FAi/eT
   WE0CKzUatIoxa8XMXE+j6RVW2+iCpqd5nQnOHctGmZHEKwA5moo981Zae
   3EXlw+Rbu9fzVabaEDZWYbZit7FPg3aerBX57mhIgunxFk+lhhYwWpqCU
   kX+Tx3cnoOKs6B8JqN1SGZ5s1iQ4sE4OAEjKLpFkdmqDdbRlekoDFDvS9
   8LXVUzuQaO/gbT6LiAfq0nhcPQ6gEMRtDmobmPF1pgQcu28sfd7Wjv89+
   p5AsmenNxnCOQCMJGMn8m8Giu++zlwET5ciEHPgYh+YvgeMaIS4MiODyu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349282174"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="349282174"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 15:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="790952791"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="790952791"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2023 15:56:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 15:56:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 15:56:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 15:56:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 15:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8uhrAq9z9gqjNjXBAuP2vSW3XgruVWOdg9H8AWNuW7NdjyJb2DG1+mbo3PNC11RtmGg4KOXH04lQ+9E6TIV4p4Iymtq0Q3mBAVGyV3YsGloOWZhzeRMGVMgwdUkSYJ1IMWvwq+0Cbc8iHWnD3SljbA0GVU3MrTYMXjP6TqLQu8qbmKTj0XlRzINjIzl3d71SEsFff9rw2FmBXJ3ayBx0rYnBbYXfD7WHelI/IPNnGOcuMrSFabjfIaI8/sfboQ+HNrMWLlGErf9z7Noq9pIRWJgZTDW5LGl+v9ovJ0crcJHYAk9R+F3PJJiNFmj7bKQ0TyTGejKdac8NSgTqpSm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0FuC0dT2v791y/700VzRmGtCdMGIieC8HEsH1khSBI=;
 b=ZMfjX85wUrJQL6nWHZWM9ViTGQCBpDGNN4CiD4tePrH0LoEhxT2vMcG0rVTFKCxJCl5yB2abuK+ecHJeRUfByN0GZTIKaWxw0/b7DK/Yo3AHZ7u92IJhbLZES4Pv9XMi6ILY1Soiylcvmzn2b/hg9ErvM4msKzmAalBCqPzao6Hrao9jZ+NMT4GWuSo2FQ99V8nWm+toFTjSSLCOcKDXZntpCeKj2ANskDxOPrAfrPxNwM8YxcAqyUxXo3xE8L5x7ce95I6aFUI7GQIjzqo+Zn0mL9KJu+grdhQL52OoG36LiU6jWGrl4lWT9WFM+AJzOsfAGuFaT/bdyLIpDDLf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:56:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::ac6b:a101:ff02:a1bb%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:56:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsAgAEz1ACAAFjMgIABYAUAgAAlDACABKrzgIAAZTSA
Date:   Mon, 10 Jul 2023 22:56:51 +0000
Message-ID: <1c0460a2042480b6a2d4cc1f6b99b27ab1371f3a.camel@intel.com>
References: <ZJR545en+dYx399c@arm.com>
         <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
         <ZJ2sTu9QRmiWNISy@arm.com>
         <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
         <ZKMRFNSYQBC6S+ga@arm.com>
         <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
         <ZKa8jB4lOik/aFn2@arm.com>
         <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
         <ZKguVAZe+DGA1VEv@arm.com>
         <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
         <ZKw3zSKxCug0IbC1@arm.com>
In-Reply-To: <ZKw3zSKxCug0IbC1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6857:EE_
x-ms-office365-filtering-correlation-id: 3d12b36b-a385-4426-1348-08db8198f328
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XLpLOZssCdO5xXbZ0kp+7+cHJV5M3n53D07oxVtqALKuoOhf19rQkh2Np4dyt6/n7ItY9y4m8lfLk95r1qPp64itAhR6YBYWRjC6RKzOrGWPgOPTuCXZTQs6ZymjswBKFEbve1YsP5WVSxajeJ7u1W5eZyMYB7TkM/7tTeln5y0MCVietemE8d719y3OY05V2jtt/4FSxhFnGiZtOhkg5r4D1ha7bEo03cVcnw2WWPPlKgGEq/PEsv00MqlfMPvhK6PpPm+nhOnV1vQaVa0b0Lf9+ctfgtn3raxIGGYVKmfqNcutv+Cz3lrwrES+ifjH76ww4MjxxL9ibHROIBVq5LoG4qi8ht1Q1pUG0/B+6qm7MGBAaR+9FKVuT/DyY9bCjG5KgyS518Rgj4wMq3JC1GCGPhkt3t4iTb8fKvXRsI3LbxuqpsX11kbdSdJrVbDdKYrBBpKDnqbID3iZH1Hg/zUR+8W0KGP8w7e6avzOii0sXzxBpVjBbcyYOF0gAtuHcIS1ismpdkfl6e0yILKW2YeRXyPhKfvIVHEwNJ8Ac5oGpVFTWipwL/9qX9p4oelHuciibQNgfIZeRcDGv9uAzvDvdzM/6IT1ZAiX0To1r3BKVcY1lxjmt/jpSSLRgVG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(186003)(26005)(2616005)(6512007)(6506007)(83380400001)(41300700001)(4326008)(64756008)(66446008)(316002)(2906002)(66556008)(7416002)(7406005)(5660300002)(66946007)(8936002)(8676002)(66476007)(478600001)(6486002)(76116006)(71200400001)(110136005)(54906003)(91956017)(36756003)(122000001)(38070700005)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVkxUDdCVWRzSmdmZmxHMXFFQXN6Z0xJV1BBQUh0Zmc0V3BoYVFKV1pPR1ZC?=
 =?utf-8?B?Q0pxRFNMb1J3bDVvVmUvdUxSUFlHdFhGSDBhbk51c2ZSUXRYN1owSTNzdzND?=
 =?utf-8?B?YkFwZnNmdE9VNGExc1dZYjV3RGxFQjduRlMxdC9hQ3JUdS94UUpiWDFFdUZs?=
 =?utf-8?B?ZTIrODU3OEs0bDZPTDVCcEFiQXk3eGR1NjdNenQ2TlJHWExUbm5WYlQwbDBE?=
 =?utf-8?B?Q0VtenduYnk1QVhHNlMzSHp3aU45UHo3b05hN2RNNFlhQU4yTnpnVVBPUVlu?=
 =?utf-8?B?RUVrZVFNQmZMOUFuVzkzVHpWVDh6Y3Q2bVR6YWZMQWlEeVYzUDZuVlJCYmpx?=
 =?utf-8?B?bEFpRFlHSGF1bTJ5dlk5TVNMQjEvTkpJbDJXbHFkTWMzMjRCSkFvUEd4bkpB?=
 =?utf-8?B?N1NGTU90R3VIQmJLaXZsLzN3RUJmSFdObHlZeTlRcVpwL3IxcE1Xam9vY0ov?=
 =?utf-8?B?TUNVY0F1RTExSDBPQ2xkdUdiUkEvWEVSTXYwUkx0aDJXeWU0V3gxeU5TTmVZ?=
 =?utf-8?B?RnU4UjhheW5DZE03ankxMHVkQnU3NmlmZVpISm5RUTdocTUrMWZDYmpxKzVS?=
 =?utf-8?B?WEhaT0pPbnlTTWU0WC9idWVQSC9ZV0RXMlhodmJNWmVWQlIxbzV2RmdWUnJF?=
 =?utf-8?B?Rm1UcW9tRG1ETHB3WUJIVElqcXE4Wm9Gb1RuSnN3VzBpYnk3T2VYVTFuY0ZC?=
 =?utf-8?B?SVptdkF3cmpWeUw0b3NIRVRuVngrWWZTdzAvTklHcmc1RGUrZ1E5U0ZBMFFK?=
 =?utf-8?B?Mm5MVHBUem00MTBXeWFpMzkzNG5OQlREQmlyMmNaUmx2c1Q0bVg4dE5tU2RK?=
 =?utf-8?B?cnlyMzdzamZoeVVvRHlwd1ZteDJyMXgwZ1ZXMUtuMVpmU1hGWWduSVh5Sjdu?=
 =?utf-8?B?OGtVQ05TN1BsTXIzZTNocG56VitDR0tSS2hyZDFWMDIxMW9jSVlnY3lENDlk?=
 =?utf-8?B?Z0l5Y1NhV3V0MnBKT05KbzNFcFJ4Z0lzR3Bvc2g5d1F0M2ZuME1nWFNSVmtx?=
 =?utf-8?B?Q1pkS0k5Rko2Slc5L2NMS0hGKy9Ba3RFSFhTSEVUN29VT20vRmxYZTR4Z2k2?=
 =?utf-8?B?Ni9XaG9tVXlmTElXbjBsN0Fzczd3WWJaR3dKdUJ1cUc4ZCt3NmYxc0Z4VTNh?=
 =?utf-8?B?dzA2VWdJckJjSkJPUnQzUDZkYkZUMG1BSjZUV3ZDLyt1QlNaQi83NHRpMHZL?=
 =?utf-8?B?akhsZWR2OHBuTW9vWnJPSnJnbFQzM0ZJT2ZBSk1IOTFEZzl3VmhFNFFGOUEw?=
 =?utf-8?B?WkxNZklHSU1TQnQwTnh1K0p6NHBTVmxzNGg3WXN4eENyRDJ6a2s4Mlo0OW8r?=
 =?utf-8?B?c3QwN0hLQWhJU1RuZmE5UXpPeE9aMHpGWlFXbTVsaW9FdmhXQVk2OXJ2bEc5?=
 =?utf-8?B?elNibjBEVEVIMTNwcjZrejhIS1YwWSs3WUx1NFRNbnVmOG1pOUVHMWFPUndV?=
 =?utf-8?B?QzBOSFpUMEkvbEJtSnNtQlIzOEd1SVBpdjFLRVE0YXdGNlN2OVJRM0dqZUFW?=
 =?utf-8?B?OE5MdUt1azJrMWpaTmhZNmxhK0prYXFJSStiWUZPaHg0dVNBZzlEanVCQTA1?=
 =?utf-8?B?UGo5RGNZTFBMM2lXSlljUUxDK0JHMFlIRXozUFpSYzlzMi95VmFJZDI2VXFX?=
 =?utf-8?B?Z2JWN2JBaGhaemxldStud3owWVZEL1BOTGFLVHo0cG9FUVNIWi90Q0pMTXdY?=
 =?utf-8?B?RnVyT3ZVdDZJVkd2ZnozdkM1dnp5MEF5Q1hEMEkrVGRCL0J2MlUzei8veWNw?=
 =?utf-8?B?TzdpMVdUWTJkYzJNMktlS2FtcEY2TktVc1JxZkc3NlkwKzhPU3I3SGJkRndl?=
 =?utf-8?B?UzZGZ2RlRVFZak81UU5GUkUvYzI1L0hzMEpFbVpIdURnVEZwNU1CaXlJLzMx?=
 =?utf-8?B?Qndxem5zc3JldnJFbXBYalNDK2RCMXU5WDZLeHVsZWZQcGFCQy9WV1pKSkpN?=
 =?utf-8?B?dWlUUStpekNoTWs4R1Rxd1JVaEt3bVEvMGt2VXFTVloyOEpVK3dPdzlHcDJy?=
 =?utf-8?B?aVY5bXRCdzZQUHR6ZVNMa2oxK1RLbjBLK0FqMmJkU09UZGtrUUpGdFh1UDZ5?=
 =?utf-8?B?VkZ6Nkg0UHUrYWp6N1hLOWdoZGZldVBPaTEyWk03KzdEc0FxZkFDamZ1bDJs?=
 =?utf-8?B?SE1QQUd1RW5vODRKOEhFL3VpSXNYWkZ4bkpMcjg4RWl4dSttQndmRlNJQUZF?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EED5CBA8210704195AF8B55DD29E0F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d12b36b-a385-4426-1348-08db8198f328
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:56:51.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQ3GcwIrwWZGc0ocb0gM9cNcqq5xhuaYMuXuZfhTd0ml/KkFEudtqppaHffBenAmAQZpk78igljmmhLaR5l3ICyqZ+5tyRo5143kjqPFMpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTEwIGF0IDE3OjU0ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+ID4gU29tZSBtYWlscyBiYWNrLCBJIGxpc3RlZCB0aGUgdGhyZWUgdGhpbmdzIHlv
dSBtaWdodCBiZSBhc2tpbmcgZm9yDQo+ID4gZnJvbQ0KPiA+IHRoZSBrZXJuZWwgc2lkZSBhbmQg
cG9pbnRlZGx5IGFza2VkIHlvdSB0byBjbGFyaWZ5LiBUaGUgb25seSBvbmUNCj4gPiB5b3UNCj4g
PiBzdGlsbCB3ZXJlIHdpc2hpbmcgZm9yIHVwIGZyb250IHdhcyAiTGVhdmUgYSB0b2tlbiBvbiBz
d2l0Y2hpbmcgdG8NCj4gPiBhbg0KPiA+IGFsdCBzaGFkb3cgc3RhY2suIg0KPiA+IA0KPiA+IEJ1
dCBob3cgeW91IHdhbnQgdG8gdXNlIHRoaXMgaW52b2x2ZXMgYSBsb3Qgb2YgZGV0YWlscyBmb3Ig
aG93DQo+ID4gZ2xpYmMNCj4gPiB3aWxsIHdvcmsgKGF1dG9tYXRpYyBzaGFkb3cgc3RhY2sgZm9y
IHNpZ2FsdHN0YWNrLCBzY2FuLXJlc3RvcmUtDQo+ID4gaW5jc3NwLA0KPiA+IGV0YykuIEkgdGhp
bmsgeW91IGZpcnN0IG5lZWQgdG8gZ2V0IHRoZSBzdG9yeSBzdHJhaWdodCB3aXRoIG90aGVyDQo+
ID4gbGliYw0KPiA+IGRldmVsb3BlcnMsIG90aGVyd2lzZSB0aGlzIGlzIGp1c3QgYnJhaW5zdG9y
bWluZy4gSSdtIG5vdCBhIGdsaWJjDQo+ID4gY29udHJpYnV0b3IsIHNvIHdpbm5pbmcgbWUgb3Zl
ciBpcyBvbmx5IGhhbGYgdGhlIGJhdHRsZS4NCj4gPiANCj4gPiBPbmx5IGFmdGVyIHRoYXQgaXMg
c2V0dGxlZCBkbyB3ZSBnZXQgdG8gdGhlIHByb2JsZW0gb2YgdGhlIG9sZA0KPiA+IGxpYmdjYw0K
PiA+IHVud2luZGVycywgYW5kIGhvdyBpdCBpcyBhIGNoYWxsZW5nZSB0byBldmVuIGFkZCBhbHQg
c2hhZG93IHN0YWNrDQo+ID4gZ2l2ZW4NCj4gPiBnbGliYydzIHBsYW5zIGFuZCB0aGUgZXhpc3Rp
bmcgYmluYXJpZXMuDQo+ID4gDQo+ID4gT25jZSB0aGF0IGlzIHNvbHZlZCB3ZSBhcmUgYXQgdGhl
IG92ZXJmbG93IHByb2JsZW0sIGFuZCB0aGUgY3VycmVudA0KPiA+IHN0YXRlIG9mIHRoaW5raW5n
IG9uIHRoYXQgaXMgImknbSBmYWlybHkgc3VyZSB0aGlzIGNhbiBiZSBkb25lIChidXQNCj4gPiBp
bmRlZWQgY29tcGxpY2F0ZWQpIi4NCj4gPiANCj4gPiBTbyBJIHRoaW5rIHdlIGFyZSBzdGlsbCBt
aXNzaW5nIGFueSBhY3Rpb25hYmxlIHJlcXVlc3RzIHRoYXQgc2hvdWxkDQo+ID4gaG9sZCB0aGlz
IHVwLg0KPiA+IA0KPiA+IElzIHRoaXMgYSByZWFzb25hYmxlIHN1bW1hcnk/DQo+IA0KPiBub3Qg
ZW50aXJlbHkuDQo+IA0KPiB0aGUgaGlnaCBsZXZlbCByZXF1aXJlbWVudCBpcyBhIGRlc2lnbiB0
aGF0DQo+IA0KPiBhKSBkb2VzIG5vdCBicmVhayBtYW55IGV4aXN0aW5nIHNpZ2FsdHN0YWNrIHVz
ZXMsDQo+IA0KPiBiKSBhbGxvd3MgaW1wbGVtZW50aW5nIGp1bXAgYW5kIHVud2luZCB0aGF0IHN1
cHBvcnQgdGhlDQo+IMKgwqAgcmVsZXZhbnQgdXNlLWNhc2VzIGFyb3VuZCBzaWduYWxzIGFuZCBz
dGFjayBzd2l0Y2hlcw0KPiDCoMKgIHdpdGggbWluaW1hbCB1c2Vyc3BhY2UgY2hhbmdlcy4NCg0K
UGxlYXNlIG9wZW4gYSBkaXNjdXNzaW9uIHdpdGggdGhlIG90aGVyIGdsaWJjIGRldmVsb3BlcnMg
dGhhdCBoYXZlIGJlZW4NCmludm9sdmVkIHdpdGggc2hhZG93IHN0YWNrIHJlZ2FyZGluZyB0aGlz
IHN1YmplY3QoYikuIFBsZWFzZSBpbmNsdWRlIG1lDQooYW5kIHByb2JhYmx5IEFuZHlMIHdvdWxk
IGJlIGludGVyZXN0ZWQ/KS4gSSB0aGluayB3ZSd2ZSB0YWxrZWQgaXQNCnRocm91Z2ggYXMgbXVj
aCBhcyB5b3UgYW5kIEkgY2FuIGF0IHRoaXMgcG9pbnQuIExldCdzIGF0IGxlYXN0IHN0YXJ0IGEN
Cm5ldyBtb3JlIGZvY3VzZWQgdGhyZWFkIG9uIHRoZSAidW53aW5kIGFjcm9zcyBzdGFja3MiIHBy
b2JsZW0uIEFuZCBhbHNvDQpnZXQgc29tZSBjb25zZW5zdXMgb24gdGhlIHdpc2RvbSBvZiB0aGUg
cmVsYXRlZCBzdWdnZXN0aW9uIHRvIGxlYWsNCnNoYWRvdyBzdGFja3MgaW4gb3JkZXIgdG8gdHJh
bnNwYXJlbnRseSBzdXBwb3J0IGV4aXN0aW5nIHBvc2l4IEFQSXMuDQoNCj4gDQo+IHdoZXJlIChi
KSBoYXMgbm90aGluZyB0byBhZGQgdG8gdjEgYWJpOiBleGlzdGluZyB1bndpbmQNCj4gYmluYXJp
ZXMgbWVhbiB0aGlzIG5lZWRzIGEgdjIgYWJpLiAodGhlIHBvaW50IG9mIGRpc2N1c3NpbmcNCj4g
djIgYWhlYWQgb2YgdGltZSBpcyB0byB1bmRlcnN0YW5kIHRoZSBjb3N0IG9mIHYyIGFuZCB0aGUN
Cj4gZGl2ZXJnZW5jZSB3cnQgdGFyZ2V0cyB3aXRob3V0IGFiaSBjb21wYXQgaXNzdWUuKQ0KPiAN
Cj4gZm9yIChhKSBteSBhY3Rpb25hYmxlIHN1Z2dlc3Rpb24gd2FzIHRvIGFjY291bnQgYWx0c3Rh
Y2sNCj4gd2hlbiBzaXppbmcgc2hhZG93IHN0YWNrcy4gdG8gZG9jdW1lbnQgYW4gYWx0c3RhY2sg
Y2FsbA0KPiBkZXB0aCBsaW1pdCBvbiB0aGUgbGliYyBsZXZlbCAoZS5nLiBmaXhlZCAxMDAgaXMg
ZmluZSkgd2UNCj4gbmVlZCBndWFyYW50ZWVzIGZyb20gdGhlIGtlcm5lbC4gKGNvbnNpZGVyIHJl
Y3Vyc2l2ZSBjYWxscw0KPiBvdmVyZmxvd2luZyB0aGUgc3RhY2sgd2l0aCBhbHRzdGFjayBjcmFz
aCBoYW5kbGVyOiBmb3IgdGhpcw0KPiB0byBiZSByZWxpYWJsZSBzaGFkb3cgc3RhY2sgc2l6ZSA+
IHN0YWNrIHNpemUgaXMgbmVlZGVkLg0KPiBidXQgdGhlIGRpZmYgY2FuIGJlIHRpbnkgZS5nLiAx
IHBhZ2UgaXMgZW5vdWdoLikNCj4gDQo+IHlvdXIgcHJldmlvdXMgMyBhY3Rpb25hYmxlIGl0ZW0g
bGlzdCB3YXMNCj4gDQo+IDEuIGFkZCB0b2tlbiB3aGVuIGhhbmRsaW5nIHNpZ25hbHMgb24gYWx0
c3RhY2suDQo+IA0KPiB0aGlzIGZhbGxzIHVuZGVyIChiKS4geW91ciBzdW1tYXJ5IGlzIGNvcnJl
Y3QgdGhhdCB0aGlzDQo+IHJlcXVpcmVzIHNvcnRpbmcgb3V0IG1hbnkgZmlkZGx5IGRldGFpbHMu
DQo+IA0KPiAyLiB0b3Agb2Ygc3RhY2sgdG9rZW4uDQo+IA0KPiB0aGlzIGNhbiB3b3JrIGRpZmZl
cmVudGx5IGFjcm9zcyB0YXJnZXRzIHNvIGkgaGF2ZSBub3RoaW5nDQo+IGFnYWluc3QgdGhlIHg4
NiB2MSBhYmksIGJ1dCBvbiBhcm02NCB3ZSBwbGFuIHRvIGhhdmUgdGhpcy4NCj4gDQo+IDMuIG1v
cmUgc2hhZG93IHN0YWNrIHNpemluZyBwb2xpY2llcy4NCj4gDQo+IHRoaXMgY2FuIGJlIGRvbmUg
aW4gdGhlIGZ1dHVyZSBleGNlcHQgdGhlIGRlZmF1bHQgcG9saWN5DQo+IHNob3VsZCBiZSBmaXhl
ZCBmb3IgKGEpIGFuZCBhIHNtYWxsZXIgc2l6ZSBpbnRyb2R1Y2VzIHRoZQ0KPiBvdmVyZmxvdyBp
c3N1ZSB3aGljaCBtYXkgcmVxdWlyZSB2Mi4NCj4gDQo+IGluIHNob3J0IHRoZSBvbmx5IGltcG9y
dGFudCBjaGFuZ2UgZm9yIHYxIGlzIHNoc3RrIHNpemluZy4NCg0KSSB0cmllZCBzZWFyY2hpbmcg
dGhyb3VnaCB0aGlzIGxvbmcgdGhyZWFkIGFuZCBBRkFJQ1QgdGhpcyBpcyBhIG5ldw0KaWRlYS4g
U29ycnkgaWYgSSBtaXNzZWQgc29tZXRoaW5nLCBidXQgeW91ciBwcmV2aW91cyBhbnN3ZXIgb24g
dGhpcygzKQ0Kc2VlbWVkIGNvbmNlcm5lZCB3aXRoIHRoZSBvcHBvc2l0ZSBwcm9ibGVtIChvdmVy
c2l6ZWQgc2hhZG93IHN0YWNrcykuDQoNClF1b3RlZCBmcm9tIGEgcGFzdCBtYWlsOg0KT24gTW9u
LCAyMDIzLTA3LTAzIGF0IDE5OjE5ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20gd3JvdGU6
DQo+IGkgdGhpbmsgaXQgY2FuIGJlIGFkZGVkIGxhdGVyLg0KPiANCj4gYnV0IGl0IG1heSBiZSBp
bXBvcnRhbnQgZm9yIGRlcGxveW1lbnQgb24gc29tZSBwbGF0Zm9ybXMsIHNpbmNlIGENCj4gbGli
YyAob3Igb3RoZXIgbGFuZ3VhZ2UgcnVudGltZSkgbWF5IHdhbnQgdG8gc2V0IHRoZSBzaGFkb3cg
c3RhY2sNCj4gc2l6ZSBkaWZmZXJlbnRseSB0aGFuIHRoZSBrZXJuZWwgZGVmYXVsdCwgYmVjYXVz
ZQ0KPiANCj4gLSBsYW5ndWFnZXMgYWxsb2NhdGluZyBsYXJnZSBhcnJheXMgb24gdGhlIHN0YWNr
DQo+ICAgKHRvbyBiaWcgc2hhZG93IHN0YWNrIGNhbiBjYXVzZSBPT00gd2l0aCBvdmVyY29tbWl0
IG9mZiBhbmQNCj4gICBybGltaXRzIGNhbiBiZSBoaXQgbGlrZSBSTElNSVRfREFUQSwgUkxJTUlU
X0FTIGJlY2F1c2Ugb2YgaXQpDQo+IA0KPiAtIHRpbnkgdGhyZWFkIHN0YWNrIGJ1dCBiaWcgc2ln
YWx0c3RhY2sgKG11c2wgbGliYywgZ28pLg0KDQpTbyB5b3UgY2FuIHByb2JhYmx5IHNlZSBob3cg
SSBnb3QgdGhlIGltcHJlc3Npb24gdGhhdCAzIHdhcyBjbG9zZWQuDQoNCkJ1dCBhbnl3YXlzLCBv
aywgc28gaWYgd2UgYWRkIGEgcGFnZSB0byBldmVyeSB0aHJlYWQgYWxsb2NhdGVkIHNoYWRvdw0K
c3RhY2ssIHRoZW4geW91IGNhbiBndWFyYW50ZWUgdGhhdCBhbiBhbHQgc3RhY2sgY2FuIGhhdmUg
c29tZSByb29tIHRvDQpoYW5kbGUgYXQgbGVhc3QgYSBzaW5nbGUgYWx0IHN0YWNrIHNpZ25hbCwg
ZXZlbiBpbiB0aGUgY2FzZSBvZg0KZXhoYXVzdGluZyB0aGUgZW50aXJlIHN0YWNrIGJ5IHJlY3Vy
c2l2ZWx5IG1ha2luZyBjYWxscyBhbmQgcHVzaGluZw0Kbm90aGluZyBlbHNlIHRvIHRoZSBzdGFj
ay4gU1NfQVVUT0RJU0FSTSByZW1haW5zIGEgYml0IG11ZGR5Lg0KDQpBbHNvIGdsaWJjIHdvdWxk
IGhhdmUgdG8gc2l6ZSB1Y29udGV4dCBzaGFkb3cgc3RhY2tzIHdpdGggYW4gYWRkaXRpb25hbA0K
cGFnZSBhcyB3ZWxsLiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gZ2V0IHNvbWUgb3RoZXIg
c2lnbnMgb2YNCmludGVyZXN0IG9uIHRoaXMgdHdlYWsgZHVlIHRvIHRoZSByZXF1aXJlbWVudHMg
Zm9yIGdsaWJjIHRvIHBhcnRpY2lwYXRlDQpvbiB0aGUgc2NoZW1lLiBDYW4geW91IGdhdGhlciB0
aGF0IHF1aWNrbHksIHNvIHdlIGNhbiBnZXQgdGhpcyBhbGwNCnByZXBwZWQgYWdhaW4/DQoNClRv
IG1lICh1bmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nKSwgaXQgc2VlbXMgbGlrZSBjb21wbGlj
YXRpbmcgdGhlDQplcXVhdGlvbiBmb3IgcHJvYmFibHkgbm8gcmVhbCB3b3JsZCBiZW5lZml0IGR1
ZSB0byB0aGUgbG93IGNoYW5jZXMgb2YNCmV4aGF1c3RpbmcgYSBzaGFkb3cgc3RhY2suIEJ1dCBp
ZiB0aGVyZSBpcyBjb25zZW5zdXMgb24gdGhlIGdsaWJjIHNpZGUsDQp0aGVuIEknbSBoYXBweSB0
byBtYWtlIHRoZSBjaGFuZ2UgdG8gZmluYWxseSBzZXR0bGUgdGhpcyBkaXNjdXNzaW9uLg0KDQo=
