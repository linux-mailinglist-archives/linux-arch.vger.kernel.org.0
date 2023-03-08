Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804716B1691
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 00:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCHXgo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 18:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 18:36:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B39545E;
        Wed,  8 Mar 2023 15:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678318602; x=1709854602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EgHSHL1djFaEpU2CRFN9CP5gjaRgCo+Pp3SNE/rYdng=;
  b=oHZLWaR9eCsF5wZTBkGhkP4PDdy1z4rsBRkDh/jETSTt5EuAhTDrzG1s
   SyF39lkMtGfOsSjRON6xLJ/4aqPC583vwrPTOtZU6rYT7dkNBAN/nTdIl
   qUwTPYuoa8nQKNA2sAL5kEV+1Ag5QetWdRbP+qY0WxQH1KzrO/Ughfg8T
   zmQ/Uwyoes3DibcTA/zbPYZl45r2M4OnpN9jqP9MnX7ZN1U9is7UurN8W
   YJ31fMaihue2SIvtecCpD3BCDTqZG8vYF11CDrbZW43wo4mq7TjYy/A5N
   EgQhER7O7hbPp0vy0Er/xlvyVZQQWtLSt6BVf/sU2+Z5jkemyTvBIfwa0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316697694"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="316697694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 15:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="800954533"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800954533"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2023 15:36:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:36:38 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 15:36:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 15:36:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 15:36:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSyWOmz/XWuSzdozXrOUH7rCdFu0N0IPSDtL9EUHfmxxfkHCoc5tWZIFxXRQ8tL/IkVDLI/r5YqxPs3ZJ81ApvOHKgUiwTTNCsLJ7nRByUfxhonLoiavq+/oE9OoLceUVd9ssMiT/dVs+Q6RrEUkSlIbuLYG1525KfU3YOSE78azAT3fr3RQiu4GwbA3dOxPXBSGfSNlyXldghq2TBuUCpSN4w3t4W0owu0Q5GkLTGLzhj3eb9lsvzBBE9cAIRWtg0/3RVeKAsMlHYizZVfZbeyp6ryDXQMgxO6pW1B+CjGQa/322527ipgCEyJzWWDWL1B4aYlT5IxrwXvfSBZvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgHSHL1djFaEpU2CRFN9CP5gjaRgCo+Pp3SNE/rYdng=;
 b=GQQVWGXNrXwU2Ro8RGacv4Ka5IUkj9SQY2Nbue63cb/NYoghJjmbwT4rBQapD2LXCgSC9Wtyg9CYURCbSTbFUMip4ZkrvjoIwtauJI490XOJA5dw2vJXqb3xcIhBbcvC0ml/RUDLI5hF04EJbFFxD88QD15HfZ23eWmpIKyBlA2EBZ3UVXL4b/tdmgp34yP065xWYofQBg99/NC7QYW1Isf3xuZTM3Ea8liOzklWgvLFKLe+8eo30ymTukJP59BExa8Dfx9xDxnDoSwVdA0FUKMBihRNsltIjhYrIzw5um69ZWYp7H+W0xvFLQjJNW6Q0ES7EGFxAcF7nza6Q3H5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 23:36:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 23:36:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 26/41] mm: Warn on shadow stack memory in wrong vma
Thread-Topic: [PATCH v7 26/41] mm: Warn on shadow stack memory in wrong vma
Thread-Index: AQHZSvtF7PSwYp+R/UC2yJIIvXkld67woQ8AgAD2kQA=
Date:   Wed, 8 Mar 2023 23:36:25 +0000
Message-ID: <85e19c517092e406a9433ce43c4627d33930a99a.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-27-rick.p.edgecombe@intel.com>
         <ZAhNInCPPYt0q6Kl@zn.tnic>
In-Reply-To: <ZAhNInCPPYt0q6Kl@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA0PR11MB4701:EE_
x-ms-office365-filtering-correlation-id: 6835426b-7a1a-4744-da48-08db202deec2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDL4UKvWdT1BXd6Jttx9wybLLmPEqgxuiDRSyfs1S69oERIm81pzBkN05d1OJ8WY3YMnVXxqxyJMdBwaK0CcpEdQZMfThbMuKjwsj6hpIfwi4zQ+eoX0mxiA56kQEUfO+LdYG947t9oEcIPvEkPEnuX1aq5L3GdhC0KUQWkFhhX0HtJ35R2eXIKkjyptgKYj1Yk2yJp0f5WbAbeazlWIgmStp58KQcElq4RAQNI7ZsKJ15eM0jD5YwLXY29v2T6gGVQS7Y1VjByK7PXMdPdDaB232W5i1zPsKE42BOhsGt/1k+JZvJmWcD2qkdxks7eahvE8bwIEW3dThPxvDlSYIhFsKbQ4aIpL/pK4YQtMsPQ8NQtE68cbHXlAt+fodkZXbdm4vL9AL42ELh0J2xpKnPiN8Nj9vW5LQA2zyr6o+A43lXGQy/MIzdi/VDUxpnb5LnA3/mO1j9Tu8iRboYy0W6IRBaQdnzZ8iePUHaWgGsn268DZ/Rh8lmdj6dJbcDap47iE5typQAg+wNgap6YmADW779j8ve4mXHt85n6QDzhjgBVfrlhv+qWYgSu0VhLT++pJ+/becPZwgTklumB/EBrnY21F5id8CqiC7So56mvJkO/q4N5Wd3omoTyrYDBG51Oc/k4wPyra1kAMiZFIRi3unmNTNSrc1l5U/o/c/PtvM3kED8YOgUWMfmy2YjV/L+osCpPi5wRxK5DuehV1eBtewhlUYqoNVq8Ne8cRRsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(2906002)(71200400001)(6486002)(186003)(38100700002)(26005)(6512007)(83380400001)(6506007)(66946007)(41300700001)(91956017)(86362001)(76116006)(66446008)(66556008)(64756008)(66476007)(4326008)(8676002)(478600001)(38070700005)(54906003)(316002)(6916009)(2616005)(7416002)(122000001)(36756003)(7406005)(82960400001)(8936002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHphZjRpWHBBSmJTbGJqaFR0VjMvV3RYTmV6eUVPcTMzbDFYRC9SU3cyY0ha?=
 =?utf-8?B?dnI0d1ViSXNMQzZZa00yOXBtR21SakZDSG9iSU1tV25UQzRKaHV0Z0xwTS94?=
 =?utf-8?B?R2FZQW0wRVpiRTduaVYzSVpoczRWa0dFWEhXY09BUVZiSzJvRk8vdWFpYWZS?=
 =?utf-8?B?TVo1dTkrN2l2TSttQkFBaEhyTXVOQWtGcnJvM2R0a2Q4SVdNNWZScTM5cFhL?=
 =?utf-8?B?cDZRMHIxbTU3YkFJVExwc1JRVVQ0R0VKNUorRDg0ZS9VYmFKeGp1Y3RralpE?=
 =?utf-8?B?V2FjRUFFOCsxUm5Na1QvODJDTWlHTEFuV0QyZ21IUk00VmRHNFRRYkZ4dTBP?=
 =?utf-8?B?SFBjam43aVM4TDI3U2txQ2EybjBydWRDTWM1MU10eW5LZWZMSDZSZEc1dEFF?=
 =?utf-8?B?L2VybHRzMk9DaG9HSGJwb08ySFluMnM4YWZ3VVdwYlY3VElTS2hoMVpPZ0ll?=
 =?utf-8?B?cG5rM1h0ZnFQUWRCNkNYazh5b0ZQUHpZbmMxWHBtTS93Ti9DSFBQT3l3bEs5?=
 =?utf-8?B?am12dVlGTGU3M0JhV29zWHcyanNiM2FNZ2RGS2RYdkc1eFFsWTQ1YWU4NTJ1?=
 =?utf-8?B?czZxeFR0N1kwYzluNVNCdGFSNlY5MU4xbEh1U0I0clFuK1FlbmlqUktQOUpV?=
 =?utf-8?B?SnNSdHVHa3U2NytWV2JJdFpGZk5QZ0JMWXhjNCtCUUY0T1lBUmpadkpsT2NN?=
 =?utf-8?B?WUQrSGxUcWM2dWY5cS8wOFZaa09QUStpdjJ0dEhPdGlETDZEZ09PUzBxMnlU?=
 =?utf-8?B?bUZ4clRJSUVUTWR1RndpbnpiUWlYaHNZakNFSk9SeXIya05EUGdCb3Axcy9E?=
 =?utf-8?B?ODYyMDByUDFvc2FKNHVJMFNMc3ROL0ovL1ZlYUU2Zmk0NnBwZHprTjdRVUQ1?=
 =?utf-8?B?ZEI4VjIzdXFmVk5yY1A3ZWRXMUJzckRvSWNwUk15S1MyR0VsZTZ2Q2NTa2ZC?=
 =?utf-8?B?cEZwWTNEYUt5WHYvY2dOSHVRQW9TTXNQNk5UMkxqZVFNZ005QVFHQkV0NEli?=
 =?utf-8?B?aDY0MVJTalF5ZHpscTFSd3J3Und5K0tySG93MGJ0Q2ZvbjRJS2ZTdzVqS1BT?=
 =?utf-8?B?eWNPWUFYNy9tNkVBbjE2bmNKaUtGcDhZOWsrWTR2ZUhDZ0M2TVFRY3NKRU9O?=
 =?utf-8?B?alQ1U1ZLS3M5TVY4Rkl0ejIrbmQ1SlZ4bmYxQWV5VERSNGpFZ3UzbzFUTW5h?=
 =?utf-8?B?eHhuaDgvZk45TFErYTBXT3MyYkxkVHErdlpkMlk4bFVyNVNvRUd0NlJEaGRn?=
 =?utf-8?B?RUJoRnZqeGltcUtxUjA3dGcvZ24zVkpYaEJXeEZqelNJWks1bGphT2lXTGxE?=
 =?utf-8?B?NWRFSWdhbVgxRlYzVk9wRlQ2ZHEvWm53MWszOFd1aGxYbWN6YWF3RE0vTld6?=
 =?utf-8?B?V1ZiQzl5Z2VCZHJCMDczOVRqbjVncSt2Uk9VR1VYS2luQjFiRnpBUis3WXlM?=
 =?utf-8?B?S3hCdXlsaXFXaXA3UHAvdUtpcGlGZEVsQ1dFYlBBcFJ6dGY5SUFGUXQ4SFJO?=
 =?utf-8?B?ZWhTVUE3YWF6cFp4WDE0LzcxeVRUVDNVa1IxOHRPYmRkZDdNY2NNOEt4a0VC?=
 =?utf-8?B?YTg5anFnV2Q2dUsvaWZOSFBmMGoyYUlRTXluVU5HM3VHekU4SjdvRFkzcC9a?=
 =?utf-8?B?SFkyWU1Jdzdtb1dTY0EreTlqY0U4SEY5c2R3bFQ5am53QzlSTEdxM3ZZeEhB?=
 =?utf-8?B?eXdJUEdNc1hXeTJVMUlvcTlaR3A0SFhXWUxXdElSYjd6aUhWdEh3dGdUWFp2?=
 =?utf-8?B?UlJ4Nm1iYXhNU0dodzRNUjZiL0hxSG8rQjVZZjU3S244TC9XVEdrQXpYOWEx?=
 =?utf-8?B?M2VSUVhKeHNkbVZvWDFrRW05N25VZkdMK01nbnF3OTZVbmVvdzE0Y3pXU2pi?=
 =?utf-8?B?VEJzSnArOFFnM1MwUmcyS0h2K3JUajlETjRBL2wyU0pyNkZrZEwxbGZMQ0xm?=
 =?utf-8?B?T2g0MGpsN1dMdnVMYWVnUU1uWWVibUN3MWkxRGx3dU1oMG11RlgvOEVrUU0x?=
 =?utf-8?B?NXBEZWlxS0g3MmVSZ3B0Zk5ITnA0VGVSdEV5bkpjMmJqVW1hQUVFT3RFbnNw?=
 =?utf-8?B?eURWQ3hDMzBFbWtlK1loM2wrRWFvZ3I4bXAvM21BZytNUDAwYnpBUFJ0ZnI5?=
 =?utf-8?B?QW0zVzAySjJaQzRjakQ4ZjBzTU95bGhXV3V5MnV2MmJ6RjNHOWRGc0JFQlp6?=
 =?utf-8?Q?82gL1Qjw2vBkK0XOmJTreU4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BD280454F750742A36FCE83256285B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6835426b-7a1a-4744-da48-08db202deec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 23:36:25.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRYBqFbK613aa689DscHL3DmvpnIhITncclFBlcAVCB4ckYU91ABxt5PxQM4tOaIxzlhIdNgUaKQjNJ1F23E/m4JDsmQQXHthaDyfbyY+iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
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

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDA5OjUzICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQyUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFRoZSB4ODYgQ29udHJvbC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xv
Z3kgKENFVCkgZmVhdHVyZSBpbmNsdWRlcw0KPiA+IGEgbmV3DQo+ID4gdHlwZSBvZiBtZW1vcnkg
Y2FsbGVkIHNoYWRvdyBzdGFjay4gVGhpcyBzaGFkb3cgc3RhY2sgbWVtb3J5IGhhcw0KPiA+IHNv
bWUNCj4gPiB1bnVzdWFsIHByb3BlcnRpZXMsIHdoaWNoIHJlcXVpcmVzIHNvbWUgY29yZSBtbSBj
aGFuZ2VzIHRvIGZ1bmN0aW9uDQo+ID4gcHJvcGVybHkuDQo+ID4gDQo+ID4gT25lIHNoYXJwIGVk
Z2UgaXMgdGhhdCBQVEVzIHRoYXQgYXJlIGJvdGggV3JpdGU9MCBhbmQgRGlydHk9MSBhcmUNCj4g
PiB0cmVhdGVkIGFzIHNoYWRvdyBieSB0aGUgQ1BVLCBidXQgdGhpcyBjb21iaW5hdGlvbiB1c2Vk
IHRvIGJlDQo+ID4gY3JlYXRlZCBieQ0KPiA+IHRoZSBrZXJuZWwgb24geDg2LiBQcmV2aW91cyBw
YXRjaGVzIGhhdmUgY2hhbmdlZCB0aGUga2VybmVsIHRvIG5vdw0KPiA+IGF2b2lkDQo+ID4gY3Jl
YXRpbmcgdGhlc2UgUFRFcyB1bmxlc3MgdGhleSBhcmUgZm9yIHNoYWRvdyBzdGFjayBtZW1vcnku
IEluDQo+ID4gY2FzZSBhbnkNCj4gPiBtaXNzZWQgY29ybmVycyBvZiB0aGUga2VybmVsIGFyZSBz
dGlsbCBjcmVhdGluZyBQVEVzIGxpa2UgdGhpcyBmb3INCj4gPiBub24tc2hhZG93IHN0YWNrIG1l
bW9yeSwgYW5kIHRvIGNhdGNoIGFueSByZS1pbnRyb2R1Y3Rpb25zIG9mIHRoZQ0KPiA+IGxvZ2lj
LA0KPiA+IHdhcm4gaWYgYW55IHNoYWRvdyBzdGFjayBQVEVzIChXcml0ZT0wLCBEaXJ0eT0xKSBh
cmUgZm91bmQgaW4gbm9uLQ0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrIFZNQXMgd2hlbiB0aGV5IGFy
ZSBiZWluZyB6YXBwZWQuIFRoaXMgd29uJ3QgY2F0Y2ggdHJhbnNpZW50DQo+ID4gY2FzZXMNCj4g
PiBidXQgc2hvdWxkIGhhdmUgZGVjZW50IGNvdmVyYWdlLiBJdCB3aWxsIGJlIGNvbXBpbGVkIG91
dCB3aGVuDQo+ID4gc2hhZG93DQo+ID4gc3RhY2sgaXMgbm90IGNvbmZpZ3VyZWQuDQo+ID4gDQo+
ID4gSW4gb3JkZXIgdG8gY2hlY2sgaWYgYSBwdGUgaXMgc2hhZG93IHN0YWNrIGluIGNvcmUgbW0g
Y29kZSwgYWRkIHR3bw0KPiA+IGFyY2gNCj4gDQo+IHMvcHRlL1BURS8NCg0KWWVzLCBpdCBtYXRj
aGVzIHRoZSByZXN0Lg0K
