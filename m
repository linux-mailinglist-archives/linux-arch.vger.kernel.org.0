Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A567BAF4
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjAYTqS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 14:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjAYTqQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 14:46:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96C58967;
        Wed, 25 Jan 2023 11:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674675972; x=1706211972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JHsfvpl36dzvKR+JtxbaHusQ4uUk3fjtJVzg1z1S7hA=;
  b=UvkGWA2HwEodCgmifVXbthSCW+5P1BDTot7qfxMc/H3ycZ+eb945ezga
   G+h+Xe8tlz2GDpfPNmW5QuL4EoF7aJUyd0h2svtRC9dGW5QnE/wu8NBpe
   /IcEfjmrDI50RJ3HQx/4he1IS9Ej5j0nHh5kKm3MLFrvcQsCezA956S5W
   O1PLnmFwo2o5qr7OFiF0NNYISI4CvX82t1cIcv3zyjQBtCbQZo0Qy7UjE
   ivZizbpu5SFcWIzV5z+I7qE0kPlNqiSG+EiwHcSLlZfrv8w+xNHS4pD9d
   C6UVi2ykIU7iaIAo/X9fc9OlYT24LXir2+KIIvv3LZegvU/2ZqWUT3/8z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306319288"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306319288"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 11:46:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786554663"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="786554663"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2023 11:46:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 11:46:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 11:46:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 11:46:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqaPFCfJ6yUDA+kSDQHXZqCIUlqgmF7BfrUWi2n3hyHN5R/eSPIWTdL/DmGzYURFoF3YHfjiOAQaVM/b2I3z/gMa5BytJUCqG/h1gAMds6elRThwlT+u5HBXFSFeLhOzJRjHcUlki8TbK/49m72B0OsSWOgBO2H5OfcOxqOGcqTS25axo6st+nznfVokKtj1Ne9rWDlhlvx5lD10tO6aC6GjN0mTjnY16wz31O7FsCgtd8VLJFDLVGmfmjjmweFBv6JojnENry/bSxcNXi+7B/VPpPLGvzT+Cf66OMb1Y01iKq+rpb7Y+dGbsidvYdQwMiStu94BID4z1PrqXAKFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHsfvpl36dzvKR+JtxbaHusQ4uUk3fjtJVzg1z1S7hA=;
 b=HafvtAJX6/avQ/tnpoZAlATh/NUNeCjkbccYIIBrmv9qUO/WEs4GXdWMRCgqLa6FQBeqg2qUWa4Sa37IIr4+LPgtecikAJs2GnnKG71N2Kdzut8qwcbLMGTCjMoTw2fvoGmxGliFI5iAgUtke42yRqJgnSFNqMWwTQuyMSqpXiNMQ6kSDUWLBTwVIZVWttURV9MDcVZEyDF+cL+d7R4CGv/XenzPDhEj4L8bdbDWovxIediqY0XFnpFkwMdI0BXUWyl1NHbMG7TO6DZkUlCEp5a64WtCpeyhdCvVEEEsWcQ1XtW5A4UKETD7nNz+WQCaCD6RcZKwHgvtaBcJFkj53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 19:46:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 19:46:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 00/39] Shadow stacks for userspace
Thread-Topic: [PATCH v5 00/39] Shadow stacks for userspace
Thread-Index: AQHZLExFkDaYZ4rA9keHNDvD4qL75a6mUW0AgAE+64CAAB9TAIAH4w+A
Date:   Wed, 25 Jan 2023 19:46:05 +0000
Message-ID: <fb8c10dc4d134c03467815f0bcd934a06cd684e6.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119142602.97b24f3cdba75f20f97786d3@linux-foundation.org>
         <b6d88208b987c9cbbdb194b344d2a537dbd76914.camel@intel.com>
         <202301201118.6A55DE336@keescook>
In-Reply-To: <202301201118.6A55DE336@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7438:EE_
x-ms-office365-filtering-correlation-id: 73190aa6-2256-4d7b-52d6-08daff0ccc66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnrDUIt7mq7idDryfyfaq9zGU/zCNc5Mc8O5x6Eddd+jJhJUYLiewe4EqMtL2lM5Ah5tT7sezIA130nVCIQNfsO460jYyuVLkRWK5oDJ/WqmRTX6LevYCiXTwjBLa0MohVnGNw3AfxXkMbEzXyD/4ne7MC/giMY652FrOygjv+zk+BS4VGGz+m3IYG/Xf0/qKzJGF6Zq9aATeaidiq+qo9HHaHGU5r3Ubl+xfigVW3jc13ps1vW7uNvleVoAimrLAWe1uiVFnIq9Y4GDwmfg8Ifs3BnCZ268IcTeSZLZnJD6e+18nsu4dfVfcUrqa6wPzm0c9jVYIO1uotcfpvMtCbTs8BjTcO8p+oSx4VNmbepwoZuZylc5/jnZjJnPC6gXaW/IIA+5sxxUWGXHQrloeizt4HlLSJkeAKmqfl9Fhv9iR5yPEx0mJ3mJTTA+1oAmikqX6IK9dRnByXL7yI39xHZe0TZoTcddZUAtvMkZTHGKC22s0lVHk0AgyxZVgKhBZhJg/Co1YUgjwoQrfWuvV/xmxgItTtROy383C92FwiYqhHd3zq/fmfP1cp2FxuOWQaCtG7FnD2FCN+wDaEo26/dH1wYlnNMAoCG1Nj/0H6tZAr/Ld/60JHUjA59jnjJ04l2FAO/SH7M1PajTV1pEu2SBlRkTDF5kJL7zdbVjlPAWsQ115/q4MXI3ncH+nLz0tYFgk+2C8k1AkvP7ciJf4ex8YMG6KnNnqpYuSXi2lDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199018)(478600001)(6486002)(8936002)(41300700001)(36756003)(82960400001)(38100700002)(5660300002)(7416002)(7406005)(2906002)(186003)(26005)(54906003)(6512007)(71200400001)(86362001)(6506007)(6916009)(8676002)(66946007)(66556008)(66476007)(66446008)(4326008)(76116006)(64756008)(38070700005)(91956017)(2616005)(316002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNqZ091Vnh4ZlNYSkorNlhRWlZMWXlzdDJNeVZjMjVjejFPTXpCRGtPYS9i?=
 =?utf-8?B?MkZLM0FuS0VVczh3STI3Q0JmbmMrOXE5dnJUWU1FZEtTbC8wdlZZUStDNVZ0?=
 =?utf-8?B?V2JWTjF5cFFGSlhXNndscmNneTIrYmVaR0JieGFsUTJSSE1UWXMwUlh2MHdV?=
 =?utf-8?B?Wmx2eDM2RFRHWmhPUGhUU0hZTE9samV6eVY0elErdExqcy9iZ1NjNGczTTNu?=
 =?utf-8?B?a25qY3BwRnV4akV1VkI2Rys2UTZTS2dmOWt5eEo1QkxxcHNhN0FMR3orTlhh?=
 =?utf-8?B?VFhQWUtSQ0IxdGFhaGs5WHByd2tQOWpwMEYzSW50d2tOQkt5eDNuc1ovNXkr?=
 =?utf-8?B?bGlWbVJlTFFJOUNGb3hDSmNaZVZ1VFZzNSt4M0R1UVNqeERvNWpaTHJnZVpr?=
 =?utf-8?B?SUp5MHkyd0xPbnpnSGk0NjduQnIxY1J6bnJ6Y1QrN2VWTDNVVU1nL0JCdmZq?=
 =?utf-8?B?aVJyc1pPcndXRG5xcTBCaERITExQQWNRcEVIQVJjZVpCWElLRWNHbnVoeU1Q?=
 =?utf-8?B?UXFnY00vUVM2RFRrRGMrbkpHbjR4VUdyTDVaMHZNb051bGhXN2NYYllhRURo?=
 =?utf-8?B?Q1Exb0tIaS9qV3JmcTg3dllBZnBzOUNPaHFaSHJjRnZJMnluWjljSzExV0t0?=
 =?utf-8?B?aC9uUHlOdGV3ZXBVZEpMOWUwSzBtbzZFejd2MHdXckptbS9IWHdvVzdIVSs0?=
 =?utf-8?B?TXVaV0NxUHcwTWlWK3p1QVFSWkZrNENoVUVuT1IvM1gzZi9KSG02YS9mc05a?=
 =?utf-8?B?ODduNGZ1aEpGempjcy9wdkZNNlluclVyWHNuNjQvVjlBVWF6ZU1ScTJXY2ND?=
 =?utf-8?B?R3I0a3ZBeGMyTitWZWc1OEljczRmdFdHeGVVWnloMzBiWGQyQm1LeHZYNUs4?=
 =?utf-8?B?TVJBaWVlcGJnYk1lSlZpYlN3bk03TW5ZbWVSeXczY3VTVTNxNG1YeVkzU0p0?=
 =?utf-8?B?a1ArclI4MG54a0xUODcyU0Q5aUNMaGZPSkJBV0M1cnBaeU9jUkptcGpsaHhS?=
 =?utf-8?B?bDNOcWlqT2xWY0pBWkp2Y09vRjZqVzAxeXRBeU02L3hHYkFaazhidEJlSXBw?=
 =?utf-8?B?THBBbmhqdmtqWkxFK3NVa2Eya0xtVkNFTkx0NjhMWlBaS24vSWZsU1FNOU9Z?=
 =?utf-8?B?QUVQNUIyb3NMclJETUM5bVA5WlNrSFJoUDVCN1hldm5rTitQTHcwYUhGUUhW?=
 =?utf-8?B?elRpWWltVG9vZXI4RUJtUDRlY0VRcjNiNHdHVGdsZHVMQmRMSWVFZnBYMFVi?=
 =?utf-8?B?RGtHd2QwekdOeHZsR0xwYmhmcVM1RGY0TFpLSUs3aUtuR0JNSzUyTmovRnJN?=
 =?utf-8?B?enRZTnd4YXJkNVVvNzNMT3Y2MkpkdmdxMXlzZElYUzRLMisxaUd0ZmMvSkxt?=
 =?utf-8?B?aUtzRzlMbXV3QUhUYlZuL1pZeCtndzVQRzFucnhzdW0xWHNaUkhHK3VwSFE3?=
 =?utf-8?B?WmcvSFp6dklSZUh6cXcrMVgxTjJNb3dzdUR6ZXlSd1FzbDFPQm5RNFBKR2lX?=
 =?utf-8?B?SENoY096NFlRMWs0MkVYSWU5clcwL0JwV3NGNHN5QTAvUmVEdlBnaURveWc3?=
 =?utf-8?B?OThUbW9CUHVTRFFuR0hrS21vVU9jaWRuWlBxbjJNcDE5dFdZcFhRdFUwYytQ?=
 =?utf-8?B?LzJmMzY1MlVoRXRramVSTmpEWHdBNUlVME02MWNQUjc1Zk9VYzFpUTEveFdT?=
 =?utf-8?B?dVVYSG9XeE9wczhYTVJlZXg2bGNTcjZCUmhQeXRKMlZncWo2bmphNExnbWFK?=
 =?utf-8?B?eFIvTDRFQ2ZyZ0M2RVE3dytodEk3bzgwb2cySW5MWnFCdXRCSTVRbGdCUUJh?=
 =?utf-8?B?RDlnWDVROWptQk9LdXpPK1pjd1g5VW5XZlQwb3EzaU56VnQxaWRMUUVCUDFS?=
 =?utf-8?B?cWU3OUFhcC9jVmdoQStVV3ZESFVOMTM2akZQdDM2SVZQRzdZdWg2dW5Ubzh5?=
 =?utf-8?B?SGlPdmEzekRUZXNuWTdWME1RUE9rL09yT0lqRkErYiszZ3Zjc2Zvc2JISXhm?=
 =?utf-8?B?OExrcWFOOC9oN1Ixa095cWg4aWJ1Z1paMFJJNk9OaTZJeUVFZGQzMngrRkdH?=
 =?utf-8?B?V3hpK3JNSmgxemxjRHpOb3dBTE1zU3hPNGFQODhpaXdDVHUyVGFMSXRIenM1?=
 =?utf-8?B?VXA2NkIra2NEMjkxbDVMZmVseEErOHczZ0FEZFEwN1FOVFJ2cFZaTmJTNkxs?=
 =?utf-8?Q?O9fbBLSoaUWJpvB3vf2xOdA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84BA3CE2ABBBFD41B2608FA3FE7AB619@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73190aa6-2256-4d7b-52d6-08daff0ccc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 19:46:06.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNB2ubHvcMjMJJDeJpcRMmSUErQ9UiPVvM0ukVRzta6RX/hx6apQlZRO0bviflTEQ2JpL4RI0mbkvwMiVbO2FgD3K7DMGZG/CXtS92DK8rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTIwIGF0IDExOjE5IC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IEZyaSwgSmFuIDIwLCAyMDIzIGF0IDA1OjI3OjMwUE0gKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQ
IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wMS0xOSBhdCAxNDoyNiAtMDgwMCwgQW5kcmV3IE1v
cnRvbiB3cm90ZToNCj4gPiA+IE9uIFRodSwgMTkgSmFuIDIwMjMgMTM6MjI6MzggLTA4MDAgUmlj
ayBFZGdlY29tYmUgPA0KPiA+ID4gcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0K
PiA+ID4gDQo+ID4gPiA+IFNIU1RLDQo+ID4gPiANCj4gPiA+IFNvdW5kcyBsaWtlIG1lIHRyeWlu
ZyB0byBzd2VhciBpbiBSdXNzaWFuIHdoaWxlIGRydW5rLg0KPiA+ID4gDQo+ID4gPiBJcyB0aGVy
ZSBhbnkgY2hhbmNlIG9mIHMvc2hzdGsvc2hhZG93X3N0YWNrL2c/DQo+ID4gDQo+ID4gSSdtIGZp
bmUgd2l0aCB0aGUgbmFtZSBjaGFuZ2UuIEkgdGhpbmsgc2hzdGsgZ290IGRlYmF0ZWQgYW5kIHBp
Y2tlZA0KPiA+IGVhcmx5IGluIHRoZSBoaXN0b3J5IG9mIHRoZSBzZXJpZXMgYmVmb3JlIEkgZ290
IGludm9sdmVkLiAic2hzdGsiDQo+ID4gaXMNCj4gPiBuaWNlIGFuZCBzaG9ydCwgYnV0IGl0J3Mg
bm90IGNvbXBsZXRlbHkgY2xlYXIgd2hhdCBpdCBpcyB1bmxlc3MgeW91DQo+ID4gYWxyZWFkeSBr
bm93IGFib3V0IHNoYWRvdyBzdGFjay4gU28gdGhlcmUgaXMgYSB0cmFkZW9mZiBvZiBjbGFyaXR5
DQo+ID4gYW5kDQo+ID4gbGluZSBsZW5ndGgvd3JhcHBpbmcuIERvZXMgYW55b25lIGVsc2UgaGF2
ZSBhbnkgc3Ryb25nIG9waW5pb25zPw0KPiANCj4gSSBwcmVmZXIgU0hTVEsgYmVjYXVzZSBpdCBz
cGVjaWZpY2FsbHkgbWVhbnMgeDg2J3MgaGFyZHdhcmUgc2hhZG93DQo+IHN0YWNrIGZyb20gQ0VU
LiBMb3RzIG9mIHRoaW5ncyBjYW4gKGFuZCBoYXZlKSBpbXBsZW1lbnRlZCB0aGluZ3MNCj4gY2Fs
bGVkDQo+ICJzaGFkb3cgc3RhY2siLg0KDQpUaGlzIG1ha2VzIHNlbnNlIHRvLCBlc3BlY2lhbGx5
IGlmIHdlIGNhbiBoaWRlIGl0IG1vcmUgZnJvbSB0aGUgY29yZS1tbSANCmNvZGUgcGVyIERhdmlk
IEhpbGRlYnJhbmQncyBzdWdnZXN0aW9uLiBJIGd1ZXNzIEknbGwgbGVhdmUgaXQgZm9yIG5vdw0K
dW5sZXNzIGFueW9uZSBlbHNlIGhhcyBhIHN0cm9uZ2VyIG9waW5pb24uDQo=
