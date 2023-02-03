Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349068A2E2
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 20:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCTYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 14:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjBCTYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 14:24:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4816AD4;
        Fri,  3 Feb 2023 11:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675452258; x=1706988258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SK5dR16hs6MDu5loTe3AfUXzXmXpoHP6O5ubSyXqK70=;
  b=JcEFwVUYUbfWwtND8AR1uuKw80xc+rphTO7zk47VarKRt3jxDmrb9Q45
   LhAwCPb44JSKFkroJBjjpODM6g41APkliKzR82bTZtp2XBFSludgmClSu
   mHf31AY6RcYFPMJrA/ii9jN1F5T6XYctN4vYBE0sJyB9S9E3os3Z+Q0Et
   8S913iGgN7HuGF4KQQfK6Yd9kxCiOHCFTudILGXpb+l5Ox69PoG7TRgk9
   zotH/9elszntVOAkwUfADWt/bBm7WZGzzDJxLiJ9gq7MOWWXuzXGRDZ4J
   G2NatGJDk0YErLMTPeVk1Q52J+6SxBGQFu+DDiHR3uLFiWQr6C9NqjzLq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="356175065"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="356175065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 11:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="774438537"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="774438537"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2023 11:24:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 11:24:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 11:24:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 11:24:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 11:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiYf2TtWDqfziukb0wtiNByid0w9KY2fo0C+2bMPlYMSjjfNkNLGSZBTeFsiDxHXhh+D4iAi3tXp9hPHxdm0b7L/WLtlwBmeLRZW2cAyhZi4X4qDGIgS1McSb3zK/IPHt7eDr9w9wNMlxU3PdgVC5x/2/pnmG9AmxtuQSZYKazYesf7p58ZJJoRbu7FxDcJkFZjh5RyyPuHlwVOozfpfqMU3seclb2TV/8FGMcOVbmna107WvQdW39Jv3V4zhhbb+SJtQ2ZmsaUlhkVpfoQAYHcYWaKE/9UavkN9Y2eT84i04GSW5AbzGhPmGi0al3llDq8GRi3eA6o0VNT5ZUHjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK5dR16hs6MDu5loTe3AfUXzXmXpoHP6O5ubSyXqK70=;
 b=JgDo7MEZ1z8W33rprrf8WdZr6dMVqOSP1wqxjlDQnB06kHrH2N6By7f1PncRl1jnGXy1ZjQ8TBP6ieOPqkB7s3W9zYhx+lamdKKHuA29W5fkoj2Uh7Ec8nNvAbM49nJRflg23MGFN+rwXehk/AQd0dLSRvp9p0idh7F+8QfPpKLIqR034vXIJl9POo3Yce6eXNjEZ12MWX3ZhF2+6WOXi1emDaw93pz0jiF2kz1kaGcCIIhr2wEr/JlrJVFdM3ySIoitnXkeVTF1mufBY7S2TtS0nVGU0evwyKcYdioJszkS9QfsRf665qAaoycB7kboZNlKC8cnXpIOm4q6K2XlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 19:24:09 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 19:24:09 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 07/39] x86: Add user control-protection fault handler
Thread-Topic: [PATCH v5 07/39] x86: Add user control-protection fault handler
Thread-Index: AQHZLExQ4M56KjXsiEavS5cSBSCSk669rWqAgAAEKIA=
Date:   Fri, 3 Feb 2023 19:24:08 +0000
Message-ID: <393a03d063dee5831af93ca67636df75a76481c3.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-8-rick.p.edgecombe@intel.com>
         <Y91b2x8pSFtmB+w6@zn.tnic>
In-Reply-To: <Y91b2x8pSFtmB+w6@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7354:EE_
x-ms-office365-filtering-correlation-id: 86908ede-da8e-47c0-b479-08db061c38c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adcrPzDDhdL2PgB9S0K7gNlV3G4VtKyv2ALdqd+YaNCdVPXm+yKNs1Pb+oApIxJdSlyeyHxDsYGhKFQyeDkViQM16qzBzDk+CmG/LZm/RZccZU2g7WxCmvkb+0Q/3sOH8gXmN7ZyaH80RG2SyICQcMH4eyGb5gac7S7XDcWKnIkKNVuS4+gSsOL7lzyxMZ95jXWvGGTdMykzp20vRzBaiMwblfPWPg2wP16ak/gNO8Gun7tYnJZHEHSjjV/wvx1xhQCq1hWbr9JBKWxczHwhcU7ePCkpu9nzzW4OyhwwMhovzqwZrQjwb6WzS9SbcFTJ2WAYzSMcBXD4KzJHvuC3g5XRRiUTb7F0pKn+U1Slnt+s3n+5R9p0Ub6uclilsuyDaxJZQ2H9+5jTE0kl7Zf0bWyj88Xw1vG/FJU+KMJLjhblkGv3srZLV+6oceYjdcahjkKnb/bS+tB4vASa97we9TDcEgLtzYRCYBb6Xd71+lH+mlXEtSRJ7YWHL1Z4Is1d8x/pyJY+6q+3cfOF2MY4w4d8/s4r9eopB1OPR2aeMmhBkUyQHmgkckDCKJhlXbLy/wH55o6rbRed0uLoPlkm1nurkR7gCA0H1BMPipad1JTenygA+/Z2n/SrIocvZrRP2QUTZt2eDZ5aAYArgw0mOsc3H2k+RUfGzCO2VVkSknHJFe3sljLTGXNlyrqdn4MZisRT3c2ua4Eeu9PMY7iLAXN6dkXMWqKE2McTm0EN5dE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(36756003)(38100700002)(122000001)(86362001)(26005)(186003)(6512007)(83380400001)(38070700005)(6916009)(66946007)(6506007)(2616005)(66556008)(66476007)(54906003)(316002)(76116006)(91956017)(8676002)(64756008)(66446008)(4326008)(71200400001)(478600001)(6486002)(2906002)(7416002)(7406005)(82960400001)(8936002)(41300700001)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkNaYjZYL1Nvbm94cDJRQXhEY3l1d1k5SVJwT0dTTUM5K0N5ZFpQYjlZckRS?=
 =?utf-8?B?Vk55MndGYnNiM2hZVmplRFpIUjJYR0wvekoxcmlmOHFHZkdvUTJKSmN3NUJz?=
 =?utf-8?B?SzgzbExCait2MXh0dGtGaGlFKzg2R0ZWSFBQclBCejFIalBEWnM1dnJsb2pV?=
 =?utf-8?B?UlFnWUdjcjdvalBqTVFtYTdiSmpkM1dreW0yQ0lObDVoZDY0Sk5FT1JwUVlZ?=
 =?utf-8?B?TmpZUnFFaDRZNFZwNi8zM25qR2NTcENPUlZEVTZCSURydlRTU3gzSkFmZ2dW?=
 =?utf-8?B?ZCtwQXFDZ2lqcjV6eW5xT2JYZGVRRlkrZ0VMRElVekdwMDJ1bzFEQTRJYVgx?=
 =?utf-8?B?dE81Q1YxQ0tKRUpzdjN3ZCt2Y0xiK2I4ckE1THc3VXFMa09MWVdHYW91eHFS?=
 =?utf-8?B?TVNFalJ3aE43L05ZZytRV2xxdmZEMi9PZ01sYStoZlBlNmxNcWYyKytvZG9Q?=
 =?utf-8?B?bnQwanQ0STFFemhEcjVKd0RmUGV0MUFKNjNHQmI3OFdWcHBIc2tVRzc4Vnoy?=
 =?utf-8?B?cEYzdHpnc21OT2dJazlPUnpkSmM0SXlVa3NQZEpoL2FzWFZhMkVFRkpxQUl5?=
 =?utf-8?B?TmZzdkpld0hPVVU0TlFadFlkNnBaWG01c3MyeVR6aUtzSkxVUzRCQy8rekN6?=
 =?utf-8?B?N3RkeWM1bm5QZGJTbEtoMFJXbVd0SFVWd0ZOeXhXQ3YxWm5qb0VzR3dBbVpF?=
 =?utf-8?B?bXU3UEhzaDRmaWZUQWlQQXU0Uk5YaGdNdmZ6MU4zUG81c2RNd0YxWXhMaWtO?=
 =?utf-8?B?R1B2R3VXaVVMZVlNN3BYODZ1NldqQ2N5R3hNNTVrRGdMMTQrODBXODh1cnVY?=
 =?utf-8?B?V2tNUUhUZHVFVURCSFhBci83anczaTArN0NnWHlhNTBIYTRhbEcwaXFKelph?=
 =?utf-8?B?MUhvc3JtT1M0Q3RnSGI1TU1KdUp1THZDdEtXYmI0eXpPU29UbUloTUlFdzEw?=
 =?utf-8?B?cTBnbmlMdlhlam4zK1hWQ3BxRHZMVkMzSmxXZTkveXBkdnNuOUxiY3VsbExV?=
 =?utf-8?B?SFNqWXVERDRxdlMrU3E0dnVYeGxUWGUvMHA3MERGS1lOdU9WZXg4N2xjTlNl?=
 =?utf-8?B?aGYxYkgwQU94UnM5TXRMcmo0MUY5YitFdGc4bEZrV3IyRU51YXhjSks1NXZT?=
 =?utf-8?B?WVBldnRaVzBIRWZwRmlRQ2NVdXQvdWZNcUxEU2dJV1lLNDdHR29pbFZRZTZL?=
 =?utf-8?B?Vm9QVlJncDZFSnlkYWRjNmFRT0ZyNXJOb0JnMWpNMjJRd1BQSnNyMElkUThp?=
 =?utf-8?B?MThSUWF5SVdpUWowRUYzWlhFK1lrZnQ3K1gzeisvTXhFUVBRL0s4SWRpYlpi?=
 =?utf-8?B?RFB1UndTdFIra2c3dzRBUWg4R0dUV0ZHb2Q1UmFPTWZPb2VUNE1vUmh0bGRh?=
 =?utf-8?B?Y0RkbkZXWVNqd2R0ME1YMzh0WkMydWlJRGpsUWFuaU5MMHU4ajBBRHIxcGR0?=
 =?utf-8?B?L1dWMFdiU0FPM1MwWm1lcXM3MDhSTGZtTFRyUU9VR041ZUVMNjN5SnZVUjV5?=
 =?utf-8?B?WWZRQ2dZNS8rNEZRdlN3VFNDb09WYkVyNDJpalRhUVVyOHBDSENuUkZLV1hi?=
 =?utf-8?B?NkRINGsyVWllTldaSjd1TUdKQXBMV0pBb2IwN3JxUTNnYStOeFBDWnJvaVFU?=
 =?utf-8?B?S1M1dEliNm9vL29xa1ZrU2tXWjNGcmoyb2FXam5HcllVN1h3YTcvZTBhMTMz?=
 =?utf-8?B?SGE0QWtNNms4bng2SWR1Sm1iRllJRU9BV24xZ2dOdDROSXFyUmFsdEFZVkxy?=
 =?utf-8?B?MW0xU3gwSjh3MEcydVJuVmt2OFEwSXJ0dGRkaFRqdFBrckpydkdPTkl4cy9u?=
 =?utf-8?B?OCtFQ0o2eGF5SmV5QUlSaHVHbk0welVUWVIyVXJHQU01ejd6UCt2ck9HT09h?=
 =?utf-8?B?RFBQM2ZUSms4VGZLMU1JMEFZblJ2UGtWV1dSZjR4TEluVWEwMEl3dVhCTDJl?=
 =?utf-8?B?Q1pIcFU2ZFN2dmhqdFA2M1lJa0E3ZHF3ZFROaFEySEg2NjNFSWJTbDNOd3Nz?=
 =?utf-8?B?YzdHVjlUVWpmclJCOUJwNnB0Vkx4MS8xSHJGZ2dXbTMra2FXQ1ZlcmZLRFZP?=
 =?utf-8?B?eks3dWUvek14bEtGTnV0MDBHTWRDcE1jcGVkYmJoY3B2bVE2eVpkVHVXZkVJ?=
 =?utf-8?B?aDBMdG8rbFJxNHNNTmE3dEVZbjlldTBwN0F5WEV1ZGZZM2VqUW5zMnZtUHhs?=
 =?utf-8?Q?Ibe/5SIrsYL7Xu5aNEs/kME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <133A52396AF99742BA703BBB8FBAED45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86908ede-da8e-47c0-b479-08db061c38c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 19:24:08.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGEU9WdCPFRhxATTb/rk1tReXmn/8sgzHnsA0/7dDJZ5pDRBOkY4TJVFkX6itAQ0QNcHS0uv07cZm7Rt2kJigdtg9KQ1w8nWjkNsPbJXTBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
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

T24gRnJpLCAyMDIzLTAyLTAzIGF0IDIwOjA5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDAxOjIyOjQ1UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDcvMzldIHg4NjogQWRkIHVz
ZXIgY29udHJvbC1wcm90ZWN0aW9uDQo+ID4gZmF1bHQgaGFuZGxlcg0KPiANCj4gU3ViamVjdDog
eDg2L3Noc3RrOiBBZGQuLi4NCg0KU3VyZS4NCg0KPiANCj4gPiBGcm9tOiBZdS1jaGVuZyBZdSA8
eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEEgY29udHJvbC1wcm90ZWN0aW9uIGZh
dWx0IGlzIHRyaWdnZXJlZCB3aGVuIGEgY29udHJvbC1mbG93DQo+ID4gdHJhbnNmZXINCj4gPiBh
dHRlbXB0IHZpb2xhdGVzIFNoYWRvdyBTdGFjayBvciBJbmRpcmVjdCBCcmFuY2ggVHJhY2tpbmcN
Cj4gPiBjb25zdHJhaW50cy4NCj4gPiBGb3IgZXhhbXBsZSwgdGhlIHJldHVybiBhZGRyZXNzIGZv
ciBhIFJFVCBpbnN0cnVjdGlvbiBkaWZmZXJzIGZyb20NCj4gPiB0aGUgY29weQ0KPiA+IG9uIHRo
ZSBzaGFkb3cgc3RhY2suDQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9jZXQuYyBiL2FyY2gveDg2L2tlcm5lbC9jZXQuYw0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zM2Q3ZDExOWJlMjYNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NldC5jDQo+ID4gQEAgLTAsMCArMSwx
NTIgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArDQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9wdHJhY2UuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9idWdzLmg+
DQo+ID4gKyNpbmNsdWRlIDxhc20vdHJhcHMuaD4NCj4gPiArDQo+ID4gK2VudW0gY3BfZXJyb3Jf
Y29kZSB7DQo+ID4gKwlDUF9FQyAgICAgICAgPSAoMSA8PCAxNSkgLSAxLA0KPiANCj4gVGhhdCBs
b29rcyBsaWtlIGEgbWFzaywgc28NCj4gDQo+IAlDUF9FQ19NQVNLDQo+IA0KPiBJIGd1ZXNzLg0K
DQpUaGUgbmFtZSBzZWVtcyBiZXR0ZXIsIGJ1dCB0aGlzIGlzIGFjdHVhbGx5IGZyb20gdGhlIGV4
aXN0aW5nIGtlcm5lbA0KSUJUIGNvbnRyb2wgcHJvdGVjdGlvbiBleGNlcHRpb24gY29kZS4gU28g
aXQgc2VlbXMgbGlrZSBhbiBzZXBhcmF0ZQ0KY2hhbmdlLiBXb3VsZCB5b3UgbGlrZSB0byBzZWUg
aXQgc251Y2sgaW50byB0aGUgdXNlciBzaGFkb3cgc3RhY2sNCmhhbmRsZXIsIG9yIGNvdWxkIHdl
IGxlYXZlIHRoaXMgZm9yIGZ1dHVyZSBjbGVhbnVwcz8NCg0KS2VlcyBwb2ludGVkIG91dCB0aGF0
IGFkZGluZyB0byB0aGUgaGFuZGxlciBhbmQgbW92aW5nIGl0IGluIHRoZSBzYW1lDQpwYXRjaCBt
YWtlcyBpdCBkaWZmaWN1bHQgdG8gc2VlIHdoZXJlIHRoZSBjaGFuZ2VzIGFyZS4gSSdtIHNwbGl0
dGluZw0KdGhpcyBvbmUgaW50byB0d28gcGF0Y2hlcyBmb3IgdGhlIG5leHQgdmVyc2lvbi4NCg0K
PiANCj4gPiArDQo+ID4gKwlDUF9SRVQgICAgICAgPSAxLA0KPiA+ICsJQ1BfSVJFVCAgICAgID0g
MiwNCj4gPiArCUNQX0VOREJSICAgICA9IDMsDQo+ID4gKwlDUF9SU1RST1JTU1AgPSA0LA0KPiA+
ICsJQ1BfU0VUU1NCU1kgID0gNSwNCj4gPiArDQo+ID4gKwlDUF9FTkNMCSAgICAgPSAxIDw8IDE1
LA0KPiA+ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgdm9pZCBkb191c2VyX2NwX2Zh
dWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1bnNpZ25lZCBsb25nDQo+ID4gZXJyb3JfY29kZSkN
Cj4gPiArew0KPiA+ICsJc3RydWN0IHRhc2tfc3RydWN0ICp0c2s7DQo+ID4gKwl1bnNpZ25lZCBs
b25nIHNzcDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogQW4gZXhjZXB0aW9uIHdhcyBqdXN0
IHRha2VuIGZyb20gdXNlcnNwYWNlLiBTaW5jZSBpbnRlcnJ1cHRzDQo+ID4gYXJlIGRpc2FibGVk
DQo+ID4gKwkgKiBoZXJlLCBubyBzY2hlZHVsaW5nIHNob3VsZCBoYXZlIG1lc3NlZCB3aXRoIHRo
ZSByZWdpc3RlcnMNCj4gPiB5ZXQgYW5kIHRoZXkNCj4gPiArCSAqIHdpbGwgYmUgd2hhdGV2ZXIg
aXMgbGl2ZSBpbiB1c2Vyc3BhY2UuIFNvIHJlYWQgdGhlIFNTUA0KPiA+IGJlZm9yZSBlbmFibGlu
Zw0KPiA+ICsJICogaW50ZXJydXB0cyBzbyBsb2NraW5nIHRoZSBmcHJlZ3MgdG8gZG8gaXQgbGF0
ZXIgaXMgbm90DQo+ID4gcmVxdWlyZWQuDQo+ID4gKwkgKi8NCj4gPiArCXJkbXNybChNU1JfSUEz
Ml9QTDNfU1NQLCBzc3ApOw0KPiA+ICsNCj4gPiArCWNvbmRfbG9jYWxfaXJxX2VuYWJsZShyZWdz
KTsNCj4gPiArDQo+ID4gKwl0c2sgPSBjdXJyZW50Ow0KPiANCj4gSG1tLCBzaG91bGQgeW91IHJl
YWQgY3VycmVudCBiZWZvcmUgeW91IGVuYWJsZSBpbnRlcnJ1cHRzPyBOb3QgdGhhdA0KPiBpdA0K
PiBjaGFuZ2VzIGZyb20gdW5kZXIgdXMuLi4NCg0KSSB0aGluayB3ZSBoYXZlIHRvIHJlYWQgaXQg
YmVmb3JlIHdlIGVuYWJsZSBpbnRlcnJ1cHRzIG9yIHVzZQ0KZnByZWdzX2xvY2soKS4gU28gcmVh
ZGluZyBpdCBiZWZvcmUgc2F2ZXMgZGlzYWJsaW5nIHByZWVtcHRpb24gbGF0ZXIuDQoNCj4gDQo+
ID4gKwl0c2stPnRocmVhZC5lcnJvcl9jb2RlID0gZXJyb3JfY29kZTsNCj4gPiArCXRzay0+dGhy
ZWFkLnRyYXBfbnIgPSBYODZfVFJBUF9DUDsNCj4gPiArDQo+ID4gKwkvKiBSYXRlbGltaXQgdG8g
cHJldmVudCBsb2cgc3BhbW1pbmcuICovDQo+ID4gKwlpZiAoc2hvd191bmhhbmRsZWRfc2lnbmFs
cyAmJiB1bmhhbmRsZWRfc2lnbmFsKHRzaywgU0lHU0VHVikgJiYNCj4gPiArCSAgICBfX3JhdGVs
aW1pdCgmY3BmX3JhdGUpKSB7DQo+ID4gKwkJcHJfZW1lcmcoIiVzWyVkXSBjb250cm9sIHByb3Rl
Y3Rpb24gaXA6JWx4IHNwOiVseA0KPiA+IHNzcDolbHggZXJyb3I6JWx4KCVzKSVzIiwNCj4gPiAr
CQkJIHRzay0+Y29tbSwgdGFza19waWRfbnIodHNrKSwNCj4gPiArCQkJIHJlZ3MtPmlwLCByZWdz
LT5zcCwgc3NwLCBlcnJvcl9jb2RlLA0KPiA+ICsJCQkgY3BfZXJyX3N0cmluZyhlcnJvcl9jb2Rl
KSwNCj4gPiArCQkJIGVycm9yX2NvZGUgJiBDUF9FTkNMID8gIiBpbiBlbmNsYXZlIiA6ICIiKTsN
Cj4gPiArCQlwcmludF92bWFfYWRkcihLRVJOX0NPTlQgIiBpbiAiLCByZWdzLT5pcCk7DQo+ID4g
KwkJcHJfY29udCgiXG4iKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmb3JjZV9zaWdfZmF1bHQo
U0lHU0VHViwgU0VHVl9DUEVSUiwgKHZvaWQgX191c2VyICopMCk7DQo+ID4gKwljb25kX2xvY2Fs
X2lycV9kaXNhYmxlKHJlZ3MpOw0KPiA+ICt9DQo+IA0KPiANCg==
