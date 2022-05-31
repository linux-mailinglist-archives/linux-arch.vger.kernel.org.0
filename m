Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056B5394EF
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbiEaQZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbiEaQZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 12:25:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047F95DC9;
        Tue, 31 May 2022 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654014319; x=1685550319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6aOzdtBktGWMUMKR4duDqJ0Y/yXqrojPkRWs2ht7i5Q=;
  b=CaWT1UxNbwyWagHRAdG2Vmlsr61P37mNWNLoEhs985ON5AA5dTR5V94H
   S1KpJCuxxUyDZFDJ3uD1Xc4jhUbJkBtWn7sabf9l5WiiODRaCpSHrsviP
   iFr8mvWnxOkmh56bXPUuIxwaZxgRQHk391gD7Vu8vcwzvyKrFppPbwZ4u
   CbnqmbaOfEKxf798z47P+6XsLg+zDaIlvgDrB6aUCIMMFkiK4ZOA02RFe
   fsKsNYpzbXkOC225/YbleJ9bsm5lXn4KY0RuwctP/GbiBkFPCSxwKO5Vv
   nsSPSgWzMhLaQ0e2s1rEIIL+TzgtLm87LI6MXlhT0E3SceWQxx/XUyLQN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275313018"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275313018"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 09:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="581161441"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 31 May 2022 09:25:17 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 09:25:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 09:25:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 09:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAu6FV4glhRYtP+YOEciTi1WuqYgQCtoFD6ajbpHJhQtd0hlhvn+UYM3v6yVKj00tdg35acqZLoNHDRO9fM0tUW2kobV9jJ0jy+ia7y8iq/iXHVIeJLYiId1oKhxPcac940fyNfQKyIjml636VEhOXyts+y/VJaBjZs9OwqYNo1LZrPG5Y5UV8ZFbVVzBpazRHhbl4rm/RmeWPUaIOXzPoues1ujxFVDIcjm9D+hxwrciHVjHuw8JoMG+sofr9DRBD4/Soe+4cf+IO+u9Rn51CmA6vEHyRKmNDrCCFfn8hjCa0i+chT5jHIefgrki1qcAqvladjgVFAZkflDt/6H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aOzdtBktGWMUMKR4duDqJ0Y/yXqrojPkRWs2ht7i5Q=;
 b=eOgJ7pc+d0LFQuNgsD1BBILaiv9A6yyPBihtFJcqYverLgum/S0WY7nzJmm25ouiZCMHclXLpSonEup8EstmvTqLND2Amw5R6gec813ZEkUDRWbrRFnyS/hVmrJcDGDUv3C2EHCEGcnnrbOIfLRQ4dTaRRsJQ+q5sDoiD1fys3w2kDOjdvN6Z7aLaicXTA1mMnPweZ07CVuvr2eeymGIY+dPJ4qEQLmz2B/FCR5M4rjCFRmS24LVqVqw1ov2jYOuNzDX0EBDj3fR7EtvsXuY9vht1pEsL8pHL0ds46B0+CJl/JufToHx9rO6TNBhOUSJIrhG0UdL6eRgqJATl9PyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB3988.namprd11.prod.outlook.com (2603:10b6:405:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 16:25:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5293.019; Tue, 31 May
 2022 16:25:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4CAAZeygIAddLsAgAAA+YCAABC1gIAAF8EAgASAo4CAADfAgIAAKfMAgAEo6oCABLJcAIAAAt+AgIUewYCAAEo0AA==
Date:   Tue, 31 May 2022 16:25:13 +0000
Message-ID: <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
References: <Yh0wIMjFdDl8vaNM@kernel.org>
         <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
         <Yh0+9cFyAfnsXqxI@kernel.org>
         <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
         <YiEZyTT/UBFZd6Am@kernel.org>
         <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
         <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
         <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
         <YiZVbPwlgSFnhadv@kernel.org>
         <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
         <YpYDKVjMEYVlV6Ya@kernel.org>
In-Reply-To: <YpYDKVjMEYVlV6Ya@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db994af8-581c-4ed7-714f-08da432223de
x-ms-traffictypediagnostic: BN6PR11MB3988:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB39883E59749BF6F83FF59B3EC9DC9@BN6PR11MB3988.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ADC7RTZQQ4AUWeAb/uWagbN3ABEgMmpeYT8z06Sce8C7yZm/AfiPorClMyNH9QpSQE7H+JCvKKYWRljHEweQmXvsXifwir9esEXusUbPHRfjLTGVMYvLnM+jIDCAshTjoW5V5Yk0APKsnIdX2ANJe555LrtGEqEuw6e+93lwJTV3rLqHDgXVer3mAk6KsFbEa9m8cShHt4k0u6z2tTBgPw4RQExEEmgwzYniMVY4DERc7lIRpL1aE+aAjXq79pT136xDmDGLVsONQ7T3IHpyJgTJjiV+tQQN0ZwVHpjfU0l+d7sTstXV+pH6SqbXewagivYfSOozY9lWJJRIN1X22LwPrgQPSNQ99rTLyOwYHubn3L0nRNeal6vzHTzUdvtmBbD67W/s7KpG0PlsdimZNEYBcEoyaMDPu6A7EvpmJdxAzfcPuf3we9GVBJ/2j7TNJurTYG+N5bM7jUP9RmKCPCJU6CoYkSD76A3tO5RN0RKYRCkhp2TmoI52VbWobJfzqYETX4YesbMXUc3+j815xuzZJB/JFlaBzTdBHjoKZAHAiy8EcB55O4cgDf5TIZwmGHJWTZt8jrDSnyavfjRO0ForPMQxnQIw353OPD9F2J315JQwX2Jy/621YKNjJ3dphb3A+7VVUgiq0IfomL8NdGTNpN7GMlbY5PIjzrTtD3JUttkQM1Rzu5acjuakleYymmglAvLSYRPmw5hlbZRSSf/JTA3X75I183UcCzlkx+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(122000001)(82960400001)(86362001)(186003)(6486002)(6512007)(38070700005)(26005)(54906003)(316002)(38100700002)(8936002)(110136005)(508600001)(36756003)(66556008)(4326008)(8676002)(71200400001)(66946007)(2906002)(66446008)(64756008)(66476007)(5660300002)(83380400001)(7416002)(7406005)(76116006)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SithbmQ2UVNRR3Axcy9yS3BxUVRNMXhJbC9NOGdyMmRPN0hOcDVvWXBkUkln?=
 =?utf-8?B?UHQxWGtFOThPOWloVzgvVnBJb1ptZ3RNUHFuNVd5OUlkMDFraGFXZGpyM0c4?=
 =?utf-8?B?c3duc1VwMHRSVngzamRVYmZzbVArWHlOZE5KRjBXQTZULytKM1h2eXR3WkFx?=
 =?utf-8?B?ajAzeEJ3YTlKSmlXUllDVmxtd1h2U3R6MWVWOHg0dlN2TTJncDNabG9PRnNs?=
 =?utf-8?B?NFE4eG44UkI5V0pDbUpNVmo1c25jRytVMWtnZ1kzcU5lMURBZDkzM1FteTNP?=
 =?utf-8?B?Y29yaFlWd04yUUFqNFM2Y0lMOVp4emVmMlphT3d3M1FvdmJ1bXlxcUNBclVE?=
 =?utf-8?B?alB6QmpBSWdNSmxiZmdQN3JRaTB1Zy9KaFJzTUtWeWx0N2RDZkE2WEN3OFFD?=
 =?utf-8?B?RHVqam82Vm5YTTN3UUVPOUkwNjJQV1dPVVZpMVZJNDNvZHRSZ3NxRDFFbEtz?=
 =?utf-8?B?cTdwUG1GNEJ3MHpRNWl5aHozdzE3RnVlL0RRMUpBOFd3SUVuMHRDa0xrN09R?=
 =?utf-8?B?SzZoVDFtSmtUc1UrNFBNSG5aS3lvNVU2d2Fva1RxY0JsbjRNUTlVSEFFVEt0?=
 =?utf-8?B?OGZPNEpwbWZXMEhrdHRoRDlqTjYxZ0p6V1h3blJLSWtUdEhFNDc3R3RxQzVs?=
 =?utf-8?B?TWx4WFZNZnhrT2N4SndSMzE5REJDSk5Uc2gxaE5WTXppRHhnZFArNlQrZWl1?=
 =?utf-8?B?YXpKazFIVEFYTW9aSDlHTG9WdW84aHZ2N1lvRnUxYkxXSHg5WW5sQTAvUDVH?=
 =?utf-8?B?TVFZY0VxcVc0M3ZPUmZGcXVhRTNtMDRqS0Zwb0hGNm1JMGN2eXVkMXpmY2pp?=
 =?utf-8?B?Y2dHQnBtdjdXK3pBRlF1SXNBNEVhUEcvL2VvdFVxa2JlNnVVY29NcEZwaDlW?=
 =?utf-8?B?ZDkrbXVuSDZ0aG9OaW1pQTNoRGM2ejJtZDdpcHczUzZkUGxrV3g0ZVBFUENZ?=
 =?utf-8?B?bEJ4WnlHTURDczJBWTQvQ3Z6Mm1jS1FvQmVlTC90UUNWWHErdzAvcUFISnVT?=
 =?utf-8?B?TmhQMlpsK2RVWHh1c1F1b0hlWHdyZDNhNWdLdlMyckdLaUR3YVk0emMrZjl4?=
 =?utf-8?B?c3ZKYzF4NEhjKzlWRktZeVBoSHpEUnBBTHN5eklnREs5REtlR2tOV0dKMmdr?=
 =?utf-8?B?cVljTGZXWlhMamZ4QmZjdUw4QjMwMWVZUW0xUDdNd1oza2VoV245R1NLQzBD?=
 =?utf-8?B?Q2Z4NTZBMmxXdlFCYnBsRHhYK29janN2cWRrWWlFYTR1aUlLREg5WUNhaXVt?=
 =?utf-8?B?bUoyTDUxMDBCb2l2YkZwQXR1NG15c3Z1bXVoeDhVK2NMQVVpaHNnMlY4bEVH?=
 =?utf-8?B?RUxSQ2Fhck8ycEFvTFhVVEJKL2xOMEdRTU5uL2Nrdi9nSVRjN3BpNHFrVXV2?=
 =?utf-8?B?VldUUjhlUHBxT3lsYlY3UHBIKytLdGl4RlRoNUpXQTVDeXFTRjdhQnlLSlNW?=
 =?utf-8?B?ckNDVGJIVTlsejNoNE1zNmR2dFJkS2oveEhZZWoweWs1OWhDTml5K0grVktR?=
 =?utf-8?B?T1ZOSlh3MTIrVHNzVVhkeU9VbjVhaXVKVU1tUGFtVk10SjdDeW5kcHBsU2dn?=
 =?utf-8?B?TldoUVdURnc2YWFBRnU1VFpIcnV2UnlDMitFWURubXVrNlhzYlVzdTBpWU83?=
 =?utf-8?B?U1ZTaXR3VVdhR3p5WDAvSXM4TEhsV2NPVlQyY0h0Slg1M2doV3V1ZmYvcmFH?=
 =?utf-8?B?ekRIZFdxaW8vQXNieVJHOHdSSzN1cHZtRW9mcEVPZkxvTEdrbXVKb2o0a1Bi?=
 =?utf-8?B?Qjc0eERSdjRxbkNrOWtjU2VNVEViTDFyeWcwcnhUQmRQU29DOXJYRzlGcTg2?=
 =?utf-8?B?TENmKzFjcGlBS1hrckRtTk9BM2kyUTZ6NTdyN3NtWXdoSE1vQWg1UEk1OVZJ?=
 =?utf-8?B?Wk9BRDE5ck5ZQlg4MDRheVEwRThqVHdSeE5DQys4d1JtM2ZYRkJMNC9kVW43?=
 =?utf-8?B?aEozaE5yZG1HNU4xZG5OVnpzbzZiRkNsZURYclNjdnJkUmdxSDJjR0VMV2ZZ?=
 =?utf-8?B?YmtqNGh2d3ZBQmlVa3Y1RUI2cnNmZXVKOHd1R0tNY1FWdlpQcnY5VUFRd1ZR?=
 =?utf-8?B?SlZQdzNxSHZTaW4xYWJTNVorUGN1VkNYTWwzL2p6cDU4NWx0V2JhSks4UGpr?=
 =?utf-8?B?M0pOcHA0bHJyTTdUWEZNZnp1NUNtcTNQUTVIc0hEV2xTQTRuSVFsL2sxR1pM?=
 =?utf-8?B?UTFQTVNvMzRkT2V5T2EyK2xicTFsUWVBaHZyeEhWaStNdGhDUDJHb2tWNDJa?=
 =?utf-8?B?VkZ4U2k0VktKYTRPdTFOY2cvRnJrM2F0TEJqd2xtZ2dpOUQvMGpDRUNFa2Zn?=
 =?utf-8?B?SndMYmVuN3ZtZWZqWnBzRzBkR21wdkJlVytVTnQvN083VTFrdEZKNzEvQkFt?=
 =?utf-8?Q?kxLq/HfeBCf2HK/FvhU7uLhCP151O3M9Wm9Mu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDA6F9C453A7484D93D62F2C627E1C64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db994af8-581c-4ed7-714f-08da432223de
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 16:25:13.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEY1nm/DLoheSOMFi5+Oqk3YWjEwoGHMmnhGtp1mqWBKlYmSQflsHB7PnXKPgRcbN6ktZ0WqQmEKh1JCaQymjxt1TZ5iBk4x3+kr99lsm0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

TWlrZSwNCg0KVGhhbmtzIGZvciBkb2luZyB0aGlzLiBHbGFkIHRvIGhlYXIgdGhpcyBpcyBzb2x2
YWJsZSB3aXRoIHRoZSBjdXJyZW50DQpwYXJhZGlnbS4NCg0KT24gVHVlLCAyMDIyLTA1LTMxIGF0
IDE0OjU5ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiAqIGFkZCBhYmlsaXR5IHRvIHVu
bG9jayBzaGFkb3cgc3RhY2sgZmVhdHVyZXMgdXNpbmcgcHRyYWNlLiBUaGlzIGlzDQo+IHJlcXVp
cmVkIGJlY2F1c2UgdGhlIGN1cnJlbnQgZ2xpYmMgKG9yIGF0IGxlYXN0IGluIHRoZSB2ZXJzaW9u
IEkgdXNlZA0KPiBmb3INCj4gdGVzdHMpIGxvY2tzIHNoYWRvdyBzdGFjayBzdGF0ZSB3aGVuIGl0
IGxvYWRzIGEgcHJvZ3JhbS4gVGhpcyBsb2NraW5nDQo+IG1lYW5zDQo+IHRoYXQgYSBwcm9jZXNz
IHdpbGwgZWl0aGVyIGhhdmUgc2hhZG93IHN0YWNrIGRpc2FibGVkIHdpdGhvdXQgYW4NCj4gYWJp
bGl0eSB0bw0KPiBlbmFibGUgaXQgb3IgaXQgd2lsbCBoYXZlIHNoYWRvdyBzdGFjayBlbmFibGVk
IHdpdGggV1JTUyBkaXNhYmxlZCBhbmQNCj4gYWdhaW4sIHRoZXJlIGlzIG5vIHdheSB0byByZS1l
bmFibGUgV1JTUy4gV2l0aCB0aGF0LCBwdHJhY2UgbG9va2VkDQo+IGxpa2UgdGhlDQo+IG1vc3Qg
c2Vuc2libGUgaW50ZXJmYWNlIHRvIGludGVyZmVyZSB3aXRoIHRoZSBzaGFkb3cgc3RhY2sgbG9j
a2luZy4NCg0KU28gd2hhdGV2ZXIgZ2xpYmMgeW91IGhhdmUgbG9jaydzIGZlYXR1cmVzIGV2ZW4g
aWYgaXQgZG9lc24ndCBlbmFibGUNCnNoYWRvdyBzdGFjaz8gSG1tLCBJJ3ZlIG5vdCBlbmNvdW50
ZXJlZCB0aGlzLiBXaGljaCBnbGliYyBpcyBpdD8NCg0KV1JTUyBpcyBhIGZlYXR1cmUgd2hlcmUg
eW91IHdvdWxkIHVzdWFsbHkgd2FudCB0byBsb2NrIGl0IGFzIGRpc2FibGVkLA0KYnV0IFdSU1Mg
Y2Fubm90IGJlIGVuYWJsZWQgaWYgc2hhZG93IHN0YWNrIGlzIG5vdCBlbmFibGVkLiBMb2NraW5n
DQpzaGFkb3cgc3RhY2sgYW5kIFdSU1Mgb2ZmIHRvZ2V0aGVyIGRvZXNuJ3QgaGF2ZSBhbnkgc2Vj
dXJpdHkgYmVuZWZpdHMNCmluIHRoZW9yeS4gc28gSSdtIHRoaW5raW5nIGdsaWJjIGRvZXNuJ3Qg
bmVlZCB0byBkbyB0aGlzLiBUaGUga2VybmVsDQpjb3VsZCBldmVuIHJlZnVzZSB0byBsb2NrIFdS
U1Mgd2l0aG91dCBzaGFkb3cgc3RhY2sgYmVpbmcgZW5hYmxlZC4NCkNvdWxkIHdlIGF2b2lkIHRo
ZSBleHRyYSBwdHJhY2UgZnVuY3Rpb25hbGl0eSB0aGVuPw0KDQpSaWNrDQo=
