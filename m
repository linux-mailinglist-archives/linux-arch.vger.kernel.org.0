Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5272E815
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbjFMQQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbjFMQPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:15:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C52AE4A;
        Tue, 13 Jun 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672953; x=1718208953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0U2cwbkyUuTAI9fOh9arm1xJSPvXM/Vlz7KbWvXnSso=;
  b=kBQ8WasxZXYw80pKCevdG702+ZLJ5rV1yBxFIJ3k+etVsyFpnjVpMSPD
   JhCBcI4KVL43el5Dr3T33QW1uYQZy+mPmQjJ8rickmCUR1Fr9YJ6xh5lJ
   kSoQHhIDh2/F+bLJ50g0K+PlcMxu+aLyPUUjHfRUlS0sQ5/tE3lwUU45F
   pn2eHWhEqTBhNSm89+KB0HmRfe2cV/nPIJV7InIv1Z+yOhRnyX3UdXUDS
   ZJ/EMde4ZW9p32YTYdyHrCnPx6wuOtshQJHOoxVZ60wVGzbsSVTfrQyLP
   8rIMTmbvki7te2Rvj94VLkpL7jek7/ABRFhd9RhBZ88BQ9Foc2fwBFj/e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360864481"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="360864481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711714710"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="711714710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 09:14:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:14:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6UOy2yXCjRsdXoVjzSbrrjd4df/upWOPWG8iANi2LkDtzLNAyXQyvopLyCDxbmmb9QLJkZZmnpWBo8PNk2fIMn+1OY0n21Od6mB+Y0hy9L0pSvqB3h1DyWGL7h9+w5uCeMeBAJe5nXAzBsBzS5naRo82OKu3S2e4sf3AMGU8D6gvafuumHS7xBAZwdOoCOdx+ouoYpiRLZvXkP8lm0w9t3xD+Qd+sZe42bYSNHjRhHs8TU5Vmk5tLwKrhIu7fy2629nYxv65vEop265XE7+CX5uaLcMHsyhN42sIBTlVdsNUsc7fNEUcdUxchWaknzxxkFBrsAsXGH2/a+MNiJWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U2cwbkyUuTAI9fOh9arm1xJSPvXM/Vlz7KbWvXnSso=;
 b=PwMKmsHdpG+eEja6/lcVeIdeF/dbDw9+fgAUyokSyQbphXjDMmSSYfMtoFv1L+ohibgdFPqNMj1d96ARXWZvgICeiTA53JDpPvUK/27vdfEM8zK5z0Gw16N8MUpgGZNh0EMiZqSVMeeMdSfQVcRlOMmR8A27wLbnihb0gyTcaa3TO8dksyZllE9MSCZjyKmKoEYAPpeXEZlGk/nYJYNr47debttrpZ2E3dNrREqFAMifyMkqQid2W2BTpZnKgZepRXCbKnUD9tY5VrETblibdho/74E/mHCnKk0XgTmkWGH5ffb7hTzEo8ST92tmXhiYBgQ6fdSLgpjiAEXa/TAoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 16:14:41 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:14:41 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Topic: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Index: AQHZnYu46x2k3QQH7UG560N9dHwyWK+IqZSAgAA/pAA=
Date:   Tue, 13 Jun 2023 16:14:41 +0000
Message-ID: <b5febf204db2c2d080e32a9429a4265340091034.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
         <497e571e-e4de-7634-7da6-683599a4bbba@redhat.com>
In-Reply-To: <497e571e-e4de-7634-7da6-683599a4bbba@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5314:EE_
x-ms-office365-filtering-correlation-id: 3b1f2c63-43d2-4862-8bb4-08db6c294b35
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MulyZ9ewDuskFAn6KPqfwq96ctWqHcaqxQgr4IrdJ3O0ecE/SklcseWyhzW69h8Dq2gH5b13cRCfTbVM5myhmMymbaPTrprMCt4buBTy5EQUsN1/XRQTAl3No7adnLDrtlRqaef0AzlD8viV75mIOF5EpzJFur2ka8kOhpgV8W+hBUgN2xbuSFER2FfMQPSDz7NdBZWFCsn09aAK9c0LDDm8x9X6i5wUsRcB56QwZGpafpN9IeE4hhrpmy2LAGDUjlqixw1H8JC2fFcdxNFWH1ZfS8QA8P4R3dbamYfKREE/MyMGiFguG1l1sPfcVh/yVBAAz9WKkT6K0fpuTgT32+qus0IgHD1ptJISp1VritbV0kc/l+W2UqSS9NtnQi1N0fNaAp8qrAK8cVvynL5x5lw9xgwgdoDoFujxedRel9f4T89fuyuXJ2WUwuGWyAuJkpYuIpFQe4LVue8jZptMYLSwsO2lWhDTI6NePexQZ0EJ6Ut4VwgyFIG0wU1YABoJkxjzPz655nHUHfv1QK8QN5H/n2f5Ke/0HKVBe28u3+77Ucgn9SQ8BEr0LO2/wvjnSAHqpnSvfibcWQ8b8xcrtRanRDvmpErwvyz24BODpwLKEQRtXuvWB6JR8bi0DrdMN0b5OgAy0wxUhS0LaPffw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(2616005)(5660300002)(6486002)(110136005)(54906003)(921005)(122000001)(82960400001)(71200400001)(41300700001)(8676002)(8936002)(66476007)(64756008)(316002)(66556008)(66946007)(478600001)(4326008)(91956017)(66446008)(76116006)(38100700002)(186003)(26005)(6512007)(6506007)(86362001)(558084003)(7366002)(7416002)(38070700005)(2906002)(7406005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVQ0a0ppMHZJNWhxMkNHanhaRkVlVGlGYnlzZW9ydExDRW53ZUphRExPTW1p?=
 =?utf-8?B?VjhSOURzdzRJaUlqV0lpVHo0SERHSnE4bkN4cXpvU05hNVJOSzVHdVRzbXY5?=
 =?utf-8?B?ZXRlQjdMTkdEcGRVNW9kcVZNanFodW04Z2UydTkwTDBzcUJMTDRKREU5c1N5?=
 =?utf-8?B?bTFzVmdqT09VazA4K0FybktwTWcrNVRtWVFQR2FxQnF2SGVMS3ZrTWErbGVT?=
 =?utf-8?B?VVovS29kRU1GdEJ1VVlYQUg4ZHJYRlBBb3RZVVhMd1pWRTZ0Z3NndEN0ejVI?=
 =?utf-8?B?RXprenk0K2lCdE96cjRTc3greU1WTzJqdFNoeC9kMVRpWlZvNVhUbEJRYzRL?=
 =?utf-8?B?a3A2U1V3RXgxYVBibHgwcVBJVk1CYWNldXo2dnhLMUhYVjhNVFhnL3ZMQ21H?=
 =?utf-8?B?M3cwRWc4MGh2eWNaZ2lwemxrYXQyUHg1UkhEZFBmMmRZN1Zhb3VIdTg5NDVB?=
 =?utf-8?B?K1pqWHQrODhnQmtVS2VxbEw5ZTlPSjRuNkpuWG14d0N0c2grRjB1cUVpTkNt?=
 =?utf-8?B?eGFMOEJxRElnekYvWWNuTm5wcmRySTU0QjA3Vml5SWUwcC9TSGowZTVyd3Zp?=
 =?utf-8?B?UnpJNlIzYzkzalExWnVnWG5icVBSa2laU3dnZXorN1l3RkhnQ3BkWGJUOXpt?=
 =?utf-8?B?aFJzS0dVRXBxeFJqZTlzcjJ6ZzJWL1UzL3Z6Q2hWbXFIaXhjbjk4ZnJvdGps?=
 =?utf-8?B?UUJMc2owNDFKQVhTaDAzejVJaHFWMzNVUXpUR1J4WnZ0M0RQeXloN0o0NVoy?=
 =?utf-8?B?S2M2dnFvQktYTXJHZ21kU05NTE96QUJKN01sUVJkL2MxOTlMRkt5a1VYRnly?=
 =?utf-8?B?NDd3eXZ2Q0Y1N3FCRzVJUmgzK1lGcFdtcGJFZnZGTTU4UFZaUFBZTHc5Z1cy?=
 =?utf-8?B?TnJWTVJWMmIyMGVJNmRIR0Q1ejZGWTNOUmw2YjlVQVEvZnJQRDl3YTJERmJI?=
 =?utf-8?B?N1ZPKzFwNzhtdjJQT2twbldmb0hybTcrdkZMKzVaa0dIdXVNN29wTVBidVJQ?=
 =?utf-8?B?TVgvNHRVR3FBSUZhQ2I4Ykt0aFV4Uit1N1V5UWpiZ1JzcWhtb0ZDbTFQaHRB?=
 =?utf-8?B?Z0N2NzJsQWZzZnZVWURYSUhWWWd3ekpUWFRrSjEwS01hemd0UUJDVjVUU0JR?=
 =?utf-8?B?Vk4vVXFXa1Y1VGJLS0pEcWF6Rzlrb3g1TmVZUkFGQldtK3hMbVVGVThHK2h0?=
 =?utf-8?B?RWNrV3hLSEhUcUM2MkZwWmE1UlJCcXE4eGFEOW1sYkhsMHpCZWIzT3lFdlBS?=
 =?utf-8?B?MnNBaEsvOGQ0c1pvUlY2OTVkK0oxTXBJN2dHRHhTalFuMHBmOWZ5cjJLNy8v?=
 =?utf-8?B?ZVgzODZOZE1KRFdROEdKazNhNlE4bDlmZkFkUTNsTkh2a0VNMHg1THh0VU50?=
 =?utf-8?B?azlkaUpaODc1ZnFUUDNoTjNybExHVUE2eUFDbUZrZ3pqWkcyTkdhSFpQaU85?=
 =?utf-8?B?SGozU1lTZjdXd3NsTkFURGdMVkhpS3JxWFQ5TkREandqQ240NnA1eWFoYVNj?=
 =?utf-8?B?ZERILzg0OWhiYmhIaVl0MEIyTVZRNnNYUzVIRmhNUDhFdzdZeHFHT3hlWldx?=
 =?utf-8?B?d1BRT0ZHaVY0YzYrcXlYTmltRDVyK0swYjNpYm1Wc0RUNjlBMm51aWc5dk5L?=
 =?utf-8?B?ZWpSOVFrRFJlZDcvZ1RPWXVTRTZLVmlJeUthc2paZFFXdTBZaHVwUk5yMW5y?=
 =?utf-8?B?Y0R0algrOGorZW9XS3NNcjVhVnU3VWw4VDBHalhqOEJsL2tyMHM5L3ZGUlRZ?=
 =?utf-8?B?dkhjWm93cEdJV2VzN1BOZERsbXhpVDVzQUVCSlB2MUV6ZzRQQUlReCt5Y3R1?=
 =?utf-8?B?RTJUa2lZS2RXT1JGS0Y2cGRwM1BVVmcyZEQ1ekN5eGl2YkpuRVN1aVhpNGhR?=
 =?utf-8?B?TUhScHNoNGN3Wm5VdW1HQkJkZnZVcXlCZ3VCMnJYMUFZUWZ4d0FxZ1ZDdWVx?=
 =?utf-8?B?YWpzdmw3bG1ZQml3a3RxcHl5bTFOVmNoNUoyN2NpVkF4b0RQWnZZbDV5ZkZD?=
 =?utf-8?B?OFRVSzR2TmkvWXRMTU1VbFJySDQxbnNVT3hWTkpueWFTVUwxeDYxa3NITWpG?=
 =?utf-8?B?WStFaVlENUpOVnZtOS9yUkRaYXR0dERnZWRYaHEvUVlRbEh1bkorR0lOQUFW?=
 =?utf-8?B?Ym9hWCtpTWRUejY4RDk1VTc2YzgxVE5ZRmtDU2xUdERwcWFVc3lWQ0NNOHQw?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EE3FBC8E983814C9215D2E914896984@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1f2c63-43d2-4862-8bb4-08db6c294b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:14:41.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdY0AxD+z6fGM/DsdhB2lTM6OiBsB/5HakO7vjKViEj0E7tMGXVghY+XCUQI1vHMlcmOx7LCl4sszMBTS0EhTAoskWrVhIvLO/3Hg6tBKzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE0OjI2ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gDQo+IEFja2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4N
Cg0KVGhhbmtzIQ0K
