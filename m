Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD966A8B13
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 22:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCBVTY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 16:19:24 -0500
Received: from mga06b.intel.com ([134.134.136.31]:43661 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbjCBVTX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Mar 2023 16:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677791963; x=1709327963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KAGpzt1dQSDfZ9W3l9iYdgCZS4Rar+DLq/RQa2s/k/w=;
  b=bJ+cQH8egut3BoakvsJB3Btu/mtvHYvaiHLtKu1iwen7q1oBdrrG8Exf
   /u4MCxHJHsfX7OUFWqQrVPYOxyNDBwkesBILOjodiJs32r+jeCv85PoS4
   ohyes2igwqyoHZ0cljk/cZs16wB7fLtJn/ek5g1unDPlRGrFKkVa7s9cU
   rVaZenoROZbSB5xp4dyVNsTLO9Jpo56VUv945Sfz+AmtJ7migs0n04Fq9
   IzrmHF0N86vGRRQIphY5YGZBej9FKVhf4orHlI5B7l9hmG0j789AcLQhN
   x2uLDZolQbvm7CFZhYZUukcABQkTb2FTPGuPk75lU6OhD/qVFiFguuL/U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397448113"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="397448113"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 13:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="1004307239"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="1004307239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 13:17:54 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 13:17:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 13:17:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 13:17:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwbsRVLEUe5v1585SOnkV5K/rqu7TsinTtEWn95Tf7bfqO3ZPTgNEAKVX0ajC8emYR3yWG7OpgIbgiv2evbQIjg3L/uxBrUhfIcLfSvd8AZ4TzePS39B6htDZAXP6rOZzzjRNfbTZDE4RMUZDVHSQcoqZxQLM6gg77ZYo/LEDi7po0vKBpOlo1SgpsfsPsAFDfzgsdR1KhhVYxIkDFKyBpn2oGRc7PizUK53BcjzEBMJa3HdFuQmWJOxvjMFLTVOUXMPTRtrHTDuOvFC9eQ8GcBV5RRwiaej7I1xoYQcwREBYcC7PAOeXSdQU8n5NfrKElEo53cp75zE+TG/GGWDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAGpzt1dQSDfZ9W3l9iYdgCZS4Rar+DLq/RQa2s/k/w=;
 b=BzGjSE484BQK2NqFeoq7BnpJB2In9VvcfNp6k90M+luCZI+OiFObPM3jQmmem6F2koA18tEfnAJ0c85RJyGCi9Y9ZCPZtYw4qyfMVX0RI1vNt1grt8Xn4NLrVM+qN6fxAId/le1K1jJ56VS2/i3BgRUFDxVb/C5KGyzrNGvLQTQCy8coAKkOqQiUuRfCa5urn4AS1+Vt5AFSWFQQ4yy1X3HdYJfP5iSn2lFieEpZ2n0kDhwSjqPsXVePbD+Ka1l07VCpjQJOhnHgkh30nuamyn2L8HAj3MrghA3ThxhAHOlStmrYSpGAy6PFz1dzXPooezND6w7RlOBat+bWZ0+HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:17:49 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 21:17:49 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgCAAXK9AIAAVL+A
Date:   Thu, 2 Mar 2023 21:17:49 +0000
Message-ID: <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
         <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
         <ZADLZJI1W1PCJf5t@arm.com>
In-Reply-To: <ZADLZJI1W1PCJf5t@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB7651:EE_
x-ms-office365-filtering-correlation-id: afa9a8e4-82a9-4662-b53f-08db1b63935c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0q0+k2lC6RIYJsRdcvNX0CQMT0p8iSVxQhBfkG+9X6HzfZfC27P4aVUkP7Bewx1tibNIMfPS49toiigrF8A4xFoxMce3ZN5obydy78oXe1cEPUyrR+F1OmdL/4P5lWFSdqYlBbdFXdMOaF+gb//DvZ39KJJi8dED+zWbgjuBweFYKei9lVLeOKREIlW2+iVWmfDkIw6m0QNUMbgIIvwSZSOwElcEVSEDQU2xCLrR72NPReSUuSb5Vxc0XKhkUDABNTrL1w3p9mq1iZA1t4peZQmvXFz8LJA4R25qWzaOWCt5xLJ+F01GYDVJuhr9Nx9Iyd2lOG+avSuyb9NSIzJfhuez0qlgd6DyTph2MY2zi/e8Lh94Nab8a9gp52tGXHFFbNjnKGLkpTm/SY5RV57DB8gzmP/AHzvmfjFBQ+k/oNb/SnL9hCIE270vIKTVmqG+YYk3Ok7Ruj196D/4Ese3CC/0jmIIfw5gZc10p5MH1s6kWUx/NmqR3LvJqSawFvk3CWq0gJfIR3h2iUfKXXUIQOUnvxMplOL6mkm9du0Oxt953VwHSRKjqhbu3jztZEIaxLRhg0eh23gNhyBTv/jJY/whAtKTNwATDdgKTJXlOv2W3OoYaIKkYzLSw5ZUSllgzqLj48TgLPYDniQHBmIptJW4EZobdxGkbX2AZk9pJyp+Ehjs8w1jlAYCgSRRHLfugeVre83HZe+Z7KIeeO+CLJfdQaMhGWdGyncbBNwWJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(66899018)(66556008)(83380400001)(122000001)(36756003)(26005)(7416002)(8936002)(5660300002)(82960400001)(7406005)(478600001)(86362001)(921005)(66476007)(38070700005)(38100700002)(2616005)(186003)(6506007)(6512007)(71200400001)(6486002)(966005)(2906002)(30864003)(66446008)(8676002)(76116006)(66946007)(64756008)(41300700001)(316002)(91956017)(110136005)(54906003)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjNZNXJkTzJYSzhpV0tjbGl0MUlYUGVQWGFFSmppSjVvSHdpVXB3dWpLSHh5?=
 =?utf-8?B?T1JNQ2dPVmtWUEgrb1gvdnBVOU5jWVB1MnAvalp3cmpmQ21Jd2wyd0JaMDRM?=
 =?utf-8?B?bDU5Z2FRMzB1Ny9VVkg1ekdHVWhXSnNqeXU5TzdFRUNBUDUxdmJLVmNKS0Rh?=
 =?utf-8?B?aHNJeE8xZUVmSVF5T2JUUkUraS9HWVRFUFRQcTBvaWd0Z0xYTHM0Q1RWdGpL?=
 =?utf-8?B?c1BhTWNUY1VjdXkxSk1qSVhTeHpEa3FRZnpWYkpudCtRcjBlUnFTOS9lNUNV?=
 =?utf-8?B?a09JYUxma3k2cGFKdmJxd21PUEwwbStCa2p3NEhRRmd1NDBOenZzNFBBbUtO?=
 =?utf-8?B?Uy9HeTNqNmVIZlZHREFlZnRqNGtremFHNlFEWVYxUlZJQnhua3ZCSVNVd0Y1?=
 =?utf-8?B?MFNNbzZqMlhIbldZUE8zTXlPdmZIVjNDZksxckdYV1ZKL2tYOS9lNktpblpi?=
 =?utf-8?B?OHg3UEtVQ0xjTzhzVmx3bjUwU1kzUnBMS3FkSkZWSnVSd1FYUktMMVB4L2pr?=
 =?utf-8?B?eXp0eEkrZ05sa0pIZUNhNEdzU1g4TWdpTVRObjlrVnVidERuUE1EZTZRak9B?=
 =?utf-8?B?UjBqU3p3NmdpRlJ5SWFtVXdSSFRHbDFQWTJKNjRFdG9sVzJJRjAwYnYzK2dW?=
 =?utf-8?B?Nm1WazhoZTZicDBORVpldE9LWGNtRWl5M3JJYlhMUmFCdCtWRUNMdk5xejd6?=
 =?utf-8?B?OWQwN0tsUG93MkhJZjJNQXdxOEp2eWUyQ21lNFZYelVWZDRDMHQ1ZXNCd2Jj?=
 =?utf-8?B?UDZGU2FnZ2tSYS9EWW03U2MyWFExa0pqeEFnVjl3WVA1RlNwYkFhRWs2Mm1B?=
 =?utf-8?B?ZlNvcElzbWR5ME9CNUM1REhuOTRNOThDbFFUSGgrT3pxdkRRTG85a20vdTVi?=
 =?utf-8?B?WEdTVDU4V0gzbFE0eE1wTVIxcGlKZHdYVng5K211cHVkOC8vSlNEa1B5SlE5?=
 =?utf-8?B?VHpRZ3hYdk80Qm5BVFVXR3NBb3hrbVl2aDgxTmd2UXNBSURlNlIzeHNtZU9U?=
 =?utf-8?B?WXBnY1RhbUFTVUxIa1dCVkFFOTBwQ3BxUlFBWnVkVDBOek9xUldWQkl5clBX?=
 =?utf-8?B?MTRNQUdjTVRIWUpCYmRoMExBZENJNmJsSkpVaERGUnpKOWdNTHdzN0swditz?=
 =?utf-8?B?WGE5TFBqbS9ldWE1a3BLZXBRWXNVM2FmN0p2dmp4VktnYlRpNFh0UDZHdWxs?=
 =?utf-8?B?MGFMMy9sWktKbVdvT01KZEpjaXgzd2V1V3EwMU5RaU94Q3d1d2pXQlF3YmM2?=
 =?utf-8?B?UnNTdVN3MDhkbDdlYVZRUUZyTHNEbDNaSFVBQTloOVFBRURBVDZuN3dpUlY3?=
 =?utf-8?B?WDVMNnFpcnF5RHIwbVJ6dWwxcjFxa0w1c2F0enBrelo0R2ZsRW5BeVUyWHlW?=
 =?utf-8?B?RkNrMlhmRTc0TURrakZjQTZDeHZ4TXVyTlQ2NXRWTUV0RW1NenEyRjdqUERu?=
 =?utf-8?B?TDk1bHFaYmRVdTFSUzJwNElnRDlKRUVpY29NNjFMdi9qQVNKL0JqUFpmaHZO?=
 =?utf-8?B?Y2JBWGUyQTVFREhlc2RvY0Q5UHRaRm9laUE3b1E1eXlQd2lXNVMvekxMV0p4?=
 =?utf-8?B?Mm1BeWw4dE42T0lkbXlGS1FXUE1PSTc0V05mci9CZncyUzhwMlpBVXV5dkxZ?=
 =?utf-8?B?SUljdGlqdDU2Qldoc2FSRk1TdHdnbDRRRnJUUGsxc3BpbHdFNzJvRi9CcDdB?=
 =?utf-8?B?eml2V1dpZG1tSytQbUZ6bVlwN3hGeUpxaHhJbWRPbm5IK1V5RWNkRDR3dWpU?=
 =?utf-8?B?UEszTkVod2xodlRpanZ0VzhCV05tZ1NpQXdyWlJ1cGF2QmdkTFpIK0NieW5N?=
 =?utf-8?B?cWdDZFViVExuamNKbTRNeFJsRVdTQ0hINitaSVd1ejBjUlhkK1plZHhoQW1E?=
 =?utf-8?B?OVYwbU1PVm5KaVdBTVdJQWp6NllDdmJyRkhyYnIwTXR5ZEpTWXIvY2NCT2Z0?=
 =?utf-8?B?eWVZVTJVcDFGeVI4dnE3YUJ4bXU4QUMxWDYwTmZERld5bFdpYXRWM1hKRUs0?=
 =?utf-8?B?Vy9OMUhJcUFUcjRKNEFqK29hdWZPcldmMXlneFVMRk50SjNZTzhZdmJ2K3BK?=
 =?utf-8?B?cE12b2MzM0JEZ3hFYUJNbWhaSzZvWk4yOG5EQkZ1WmRHajFMKzF4VmJwWDRL?=
 =?utf-8?B?MGwzRUtrcExEaEJTSXE3NFlhMTk2YWVqMnpwRUFVaWkybGlkRXdLNlJFWXRJ?=
 =?utf-8?Q?frLXU3PEhrTusUFIfXuunyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2286D6021B5E48BA10F33662FAA17B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa9a8e4-82a9-4662-b53f-08db1b63935c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 21:17:49.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKBNg7KTR8KK0cBvofgU8OeeJoYVjXxPhkxdQ84rBmV5QoTOAMZDESgFMbZcsXWJsavbxp/s2xiEm39y/9rvYDYYaByu7TQbXHXPveEFWfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDE2OjE0ICswMDAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwMy8wMS8yMDIzIDE4OjA3LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjMtMDMtMDEgYXQgMTQ6MjEgKzAwMDAsIFN6YWJvbGNzIE5hZ3kgd3Jv
dGU6DQo+ID4gPiBUaGUgMDIvMjcvMjAyMyAxNDoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+
ID4gPiA+ICtBcHBsaWNhdGlvbiBFbmFibGluZw0KPiA+ID4gPiArPT09PT09PT09PT09PT09PT09
PT0NCj4gPiA+ID4gKw0KPiA+ID4gPiArQW4gYXBwbGljYXRpb24ncyBDRVQgY2FwYWJpbGl0eSBp
cyBtYXJrZWQgaW4gaXRzIEVMRiBub3RlIGFuZA0KPiA+ID4gPiBjYW4NCj4gPiA+ID4gYmUgdmVy
aWZpZWQNCj4gPiA+ID4gK2Zyb20gcmVhZGVsZi9sbHZtLXJlYWRlbGYgb3V0cHV0OjoNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgIHJlYWRlbGYgLW4gPGFwcGxpY2F0aW9uPiB8IGdyZXAgLWEgU0hT
VEsNCj4gPiA+ID4gKyAgICAgICAgcHJvcGVydGllczogeDg2IGZlYXR1cmU6IFNIU1RLDQo+ID4g
PiA+ICsNCj4gPiA+ID4gK1RoZSBrZXJuZWwgZG9lcyBub3QgcHJvY2VzcyB0aGVzZSBhcHBsaWNh
dGlvbnMgbWFya2Vycw0KPiA+ID4gPiBkaXJlY3RseS4NCj4gPiA+ID4gQXBwbGljYXRpb25zDQo+
ID4gPiA+ICtvciBsb2FkZXJzIG11c3QgZW5hYmxlIENFVCBmZWF0dXJlcyB1c2luZyB0aGUgaW50
ZXJmYWNlDQo+ID4gPiA+IGRlc2NyaWJlZA0KPiA+ID4gPiBpbiBzZWN0aW9uIDQuDQo+ID4gPiA+
ICtUeXBpY2FsbHkgdGhpcyB3b3VsZCBiZSBkb25lIGluIGR5bmFtaWMgbG9hZGVyIG9yIHN0YXRp
Yw0KPiA+ID4gPiBydW50aW1lDQo+ID4gPiA+IG9iamVjdHMsIGFzIGlzDQo+ID4gPiA+ICt0aGUg
Y2FzZSBpbiBHTElCQy4NCj4gPiA+IA0KPiA+ID4gTm90ZSB0aGF0IHRoaXMgaGFzIHRvIGJlIGFu
IGVhcmx5IGRlY2lzaW9uIGluIGxpYmMgKGxkLnNvIG9yDQo+ID4gPiBzdGF0aWMNCj4gPiA+IGV4
ZSBzdGFydCBjb2RlKSwgd2hpY2ggd2lsbCBiZSBkaWZmaWN1bHQgdG8gaG9vayBpbnRvIHN5c3Rl
bSB3aWRlDQo+ID4gPiBzZWN1cml0eSBwb2xpY3kgc2V0dGluZ3MuIChlLmcuIHRvIGZvcmNlIHNo
c3RrIG9uIG1hcmtlZA0KPiA+ID4gYmluYXJpZXMuKQ0KPiA+IA0KPiA+IEluIHRoZSBlYWdlciBl
bmFibGluZyAoYnkgdGhlIGtlcm5lbCkgc2NlbmFyaW8sIGhvdyBpcyB0aGlzDQo+ID4gaW1wcm92
ZWQ/DQo+ID4gVGhlIGxvYWRlciBoYXMgdG8gaGF2ZSB0aGUgb3B0aW9uIHRvIGRpc2FibGUgdGhl
IHNoYWRvdyBzdGFjayBpZg0KPiA+IGVuYWJsaW5nIGNvbmRpdGlvbnMgYXJlIG5vdCBtZXQsIHNv
IGl0IHN0aWxsIGhhcyB0byB0cnVzdCB1c2Vyc3BhY2UNCj4gPiB0bw0KPiA+IG5vdCBkbyB0aGF0
LiBEaWQgeW91IGhhdmUgYW55IG1vcmUgc3BlY2lmaWNzIG9uIGhvdyB0aGUgcG9saWN5DQo+ID4g
d291bGQNCj4gPiB3b3JrPw0KPiANCj4gaSBndWVzcyBteSBpc3N1ZSBpcyB0aGF0IHRoZSBhcmNo
IHByY3RscyBvbmx5IGFsbG93IHNlbGYgcG9saWNpbmcuDQo+IHRoZXJlIGlzIG5vIGtlcm5lbCBt
ZWNoYW5pc20gdG8gc2V0IHBvbGljeSBmcm9tIG91dHNpZGUgdGhlIHByb2Nlc3MNCj4gdGhhdCBp
cyBlaXRoZXIgaW5oZXJpdGVkIG9yIGFzeW5jaHJvbm91c2x5IHNldC4gcG9saWN5IGlzIGNvbXBs
ZXRlbHkNCj4gbWFuYWdlZCBieSBsaWJjIChhbmQgZG9uZSB2ZXJ5IGVhcmx5KS4NCj4gDQo+IG5v
dyBpIHVuZGVyc3RhbmQgdGhhdCBhc3luYyBkaXNhYmxlIGRvZXMgbm90IHdvcmsgKHRoYW5rcyBm
b3IgdGhlDQo+IGV4cGxhbmF0aW9uKSwgYnV0IHNvbWUgY29udHJvbCBmb3IgZm9yY2VkIGVuYWJs
ZS9sb2NraW5nIGluaGVyaXRlZA0KPiBhY3Jvc3MgZXhlYyBjb3VsZCB3b3JrLg0KDQpJcyB0aGUg
aWRlYSB0aGF0IHNoYWRvdyBzdGFjayB3b3VsZCBiZSBmb3JjZWQgb24gcmVnYXJkbGVzcyBvZiBp
ZiB0aGUNCmxpbmtlZCBsaWJyYXJpZXMgc3VwcG9ydCBpdD8gSW4gd2hpY2ggY2FzZSBpdCBjb3Vs
ZCBiZSBhbGxvd2VkIHRvIGNyYXNoDQppZiB0aGV5IGRvIG5vdD8NCg0KSSB0aGluayB0aGUgbWFq
b3JpdHkgb2YgdXNlcnMgd291bGQgcHJlZmVyIHRoZSBvdGhlciBjYXNlIHdoZXJlIHNoYWRvdw0K
c3RhY2sgaXMgb25seSB1c2VkIGlmIHN1cHBvcnRlZCwgc28gdGhpcyBzb3VuZHMgbGlrZSBhIHNw
ZWNpYWwgY2FzZS4NClJhdGhlciB0aGFuIGxvc2UgdGhlIGZsZXhpYmlsaXR5IGZvciB0aGUgdHlw
aWNhbCBjYXNlLCBJIHdvdWxkIHRoaW5rDQpzb21ldGhpbmcgbGlrZSB0aGlzIGNvdWxkIGJlIGFu
IGFkZGl0aW9uYWwgZW5hYmxpbmcgbW9kZS4gZ2xpYmMgY291bGQNCmNoZWNrIGlmIHNoYWRvdyBz
dGFjayBpcyBhbHJlYWR5IGVuYWJsZWQgYnkgdGhlIGtlcm5lbCB1c2luZyB0aGUNCmFyY2hfcHJj
dGwoKXMgaW4gdGhpcyBjYXNlLg0KDQpXZSBhcmUgaGF2aW5nIHRvIHdvcmsgYXJvdW5kIHRoZSBl
eGlzdGluZyBicm9rZW4gZ2xpYmMgYmluYXJpZXMgYnkgbm90DQp0cmlnZ2VyaW5nIG9mZiB0aGUg
ZWxmIGJpdHMgYXV0b21hdGljYWxseSBpbiB0aGUga2VybmVsLCBidXQgSSBzdXBwb3NlDQppZiB0
aGlzIHdhcyBhIHNwZWNpYWwgIkkgZG9uJ3QgY2FyZSBpZiBpdCBjcmFzaGVzIiBmZWF0dXJlLCBt
YXliZSBpdA0Kd291bGQgYmUgb2suIE90aGVyd2lzZSB3ZSB3b3VsZCBuZWVkIHRvIGNoYW5nZSB0
aGUgZWxmIGhlYWRlciBiaXQgdG8NCmV4Y2x1ZGUgdGhlIG9sZCBiaW5hcmllcyB0byBldmVuIGJl
IGFibGUgdG8gZG8gdGhpcywgYW5kIHRoZXJlIHdhcw0KZXh0cmVtZSByZXNpc3RhbmNlIHRvIHRo
aXMgaWRlYSBmcm9tIHRoZSB1c2Vyc3BhY2Ugc2lkZS4NCg0KPiANCj4gPiA+IEZyb20gdXNlcnNw
YWNlIFBPViBJJ2QgcHJlZmVyIGlmIGEgc3RhdGljIGV4ZSBkaWQgbm90IGhhdmUgdG8NCj4gPiA+
IHBhcnNlDQo+ID4gPiBpdHMgb3duIEVMRiBub3RlcyAoaS5lLiBrZXJuZWwgZW5hYmxlZCBzaHN0
ayBiYXNlZCBvbiB0aGUNCj4gPiA+IG1hcmtpbmcpLg0KPiA+IA0KPiA+IFRoaXMgaXMgYWN0dWFs
bHkgZXhhY3RseSB3aGF0IGhhcHBlbnMgaW4gdGhlIGdsaWJjIHBhdGNoZXMuIE15DQo+ID4gdW5k
ZXJzdGFuZCB3YXMgdGhhdCBpdCBhbHJlYWR5IGJlZW4gZGlzY3Vzc2VkIGFtb25nc3QgZ2xpYmMg
Zm9sa3MuDQo+IA0KPiB0aGVyZSB3ZXJlIG1hbnkgZ2xpYmMgcGF0Y2hlcyBzb21lIG9mIHdoaWNo
IGFyZSBjb21taXR0ZWQgZGVzcGl0ZSBub3QNCj4gaGF2aW5nIGFuIGFjY2VwdGVkIGxpbnV4IGFi
aSwgc28gaSdtIHRyeWluZyB0byByZXZpZXcgdGhlIGxpbnV4IGFiaQ0KPiBjb250cmFjdHMgYW5k
IGV4cGVjdCB0aGlzIHBhdGNoIHRvIGJlIGF1dGhvcmF0aXZlLCBwbGVhc2UgYmVhciB3aXRoDQo+
IG1lLg0KDQpILkouIGhhcyBzb21lIHJlY2VudCBvbmVzIHRoYXQgd29yayBhZ2FpbnN0IHRoaXMg
a2VybmVsIHNlcmllcyB0aGF0DQptaWdodCBpbnRlcmVzdCB5b3UuIFRoZSBleGlzdGluZyB1cHN0
cmVhbSBnbGliYyBzdXBwb3J0IHdpbGwgbm90IGdldA0KdXNlZCBkdWUgdG8gdGhlIGVuYWJsaW5n
IGludGVyZmFjZSBjaGFuZ2UgdG8gYXJjaF9wcmN0bCgpICh0aGlzIHdhcyBvbmUNCm9mIHRoZSBp
bnNwaXJhdGlvbnMgb2YgdGhlIGNoYW5nZSBhY3R1YWxseSkuDQoNCj4gDQo+ID4gPiAtIEkgdGhp
bmsgaXQncyBiZXR0ZXIgdG8gaGF2ZSBhIG5ldyBsaW1pdCBzcGVjaWZpY2FsbHkgZm9yIHNoYWRv
dw0KPiA+ID4gICBzdGFjayBzaXplICh3aGljaCBieSBkZWZhdWx0IGNhbiBiZSBSTElNSVRfU1RB
Q0spIHNvIHVzZXJzcGFjZQ0KPiA+ID4gICBjYW4gYWRqdXN0IGl0IGlmIG5lZWRlZCAoYW5vdGhl
ciByZWFzb24gaXMgdGhhdCBzdGFjayBzaXplIGlzDQo+ID4gPiAgIG5vdCBhbHdheXMgYSBnb29k
IGluZGljYXRvciBvZiBtYXggY2FsbCBkZXB0aCkuDQo+ID4gDQo+ID4gSG1tLCB5ZWEuIFRoaXMg
c2VlbXMgbGlrZSBhIGdvb2QgaWRlYSwgYnV0IEkgZG9uJ3Qgc2VlIHdoeSBpdCBjYW4ndA0KPiA+
IGJlDQo+ID4gYSBmb2xsb3cgb24uIFRoZSBzZXJpZXMgaXMgcXVpdGUgYmlnIGp1c3QgdG8gZ2V0
IHRoZSBiYXNpY3MuIEkgaGF2ZQ0KPiA+IHRyaWVkIHRvIHNhdmUgc29tZSBvZiB0aGUgZW5oYW5j
ZW1lbnRzIChsaWtlIGFsdCBzaGFkb3cgc3RhY2spIGZvcg0KPiA+IHRoZQ0KPiA+IGZ1dHVyZS4N
Cj4gDQo+IGl0IGlzIGFjdHVhbGx5IG5vdCBvYnZpb3VzIGhvdyB0byBpbnRyb2R1Y2UgYSBsaW1p
dCBzbyBpdCBpcw0KPiBpbmhlcml0ZWQNCj4gb3IgcmVzZXQgaW4gYSBzZW5zaWJsZSB3YXkgc28g
aSB0aGluayBpdCBpcyB1c2VmdWwgdG8gZGlzY3VzcyBpdA0KPiB0b2dldGhlciB3aXRoIG90aGVy
IGlzc3Vlcy4NCg0KTG9va2luZyBhdCB0aGlzIGFnYWluLCBJJ20gbm90IHN1cmUgd2h5IGEgbmV3
IHJsaW1pdCBpcyBuZWVkZWQuIEl0DQpzZWVtcyBtYW55IG9mIHRob3NlIHBvaW50cyB3ZXJlIGp1
c3QgZm9ybXVsYXRpb25zIG9mIHRoYXQgdGhlIGNsb25lMw0Kc3RhY2sgc2l6ZSB3YXMgbm90IHVz
ZWQsIGJ1dCBpdCBhY3R1YWxseSBpcyBhbmQganVzdCBub3QgZG9jdW1lbnRlZC4gSWYNCnlvdSBk
aXNhZ3JlZSBwZXJoYXBzIHlvdSBjb3VsZCBlbGFib3JhdGUgb24gd2hhdCB0aGUgcmVxdWlyZW1l
bnRzIGFyZQ0KYW5kIHdlIGNhbiBzZWUgaWYgaXQgc2VlbXMgdHJpY2t5IHRvIGRvIGluIGEgZm9s
bG93IHVwLg0KDQo+IA0KPiA+ID4gVGhlIGtlcm5lbCBwdXNoZXMgb24gdGhlIHNoYWRvdyBzdGFj
ayBvbiBzaWduYWwgZW50cnkgc28gc2hhZG93DQo+ID4gPiBzdGFjaw0KPiA+ID4gb3ZlcmZsb3cg
Y2Fubm90IGJlIGhhbmRsZWQuIFBsZWFzZSBkb2N1bWVudCB0aGlzIGFzIG5vbi0NCj4gPiA+IHJl
Y292ZXJhYmxlDQo+ID4gPiBmYWlsdXJlLg0KPiA+IA0KPiA+IEl0IGRvZXNuJ3QgaHVydCB0byBj
YWxsIGl0IG91dC4gUGxlYXNlIHNlZSB0aGUgYmVsb3cgbGluayBmb3INCj4gPiBmdXR1cmUNCj4g
PiBwbGFucyB0byBoYW5kbGUgdGhpcyBzY2VuYXJpbyAoYWx0IHNoYWRvdyBzdGFjaykuDQo+ID4g
DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgaXQgY2FuIGJlIG1hZGUgcmVjb3ZlcmFibGUgaWYgc2ln
bmFscyB3aXRoIGFsdGVybmF0ZQ0KPiA+ID4gc3RhY2sNCj4gPiA+IHJ1bg0KPiA+ID4gb24gYSBk
aWZmZXJlbnQgc2hhZG93IHN0YWNrLiBBbmQgdGhlIHRvcCBvZiB0aGUgdGhyZWFkIHNoYWRvdw0K
PiA+ID4gc3RhY2sNCj4gPiA+IGlzDQo+ID4gPiBqdXN0IGNvcnJ1cHRlZCBpbnN0ZWFkIG9mIHB1
c2hlZCBpbiB0aGUgb3ZlcmZsb3cgY2FzZS4gVGhlbg0KPiA+ID4gbG9uZ2ptcA0KPiA+ID4gb3V0
DQo+ID4gPiBjYW4gYmUgbWFkZSB0byB3b3JrIChjb21tb24gaW4gc3RhY2sgb3ZlcmZsb3cgaGFu
ZGxpbmcgY2FzZXMpLA0KPiA+ID4gYW5kDQo+ID4gPiByZWxpYWJsZSBjcmFzaCByZXBvcnQgZnJv
bSB0aGUgc2lnbmFsIGhhbmRsZXIgd29ya3MgKGFsc28NCj4gPiA+IGNvbW1vbikuDQo+ID4gPiAN
Cj4gPiA+IERvZXMgU1NQIGdldCBzdG9yZWQgaW50byB0aGUgc2lnY29udGV4dCBzdHJ1Y3Qgc29t
ZXdoZXJlPw0KPiA+IA0KPiA+IE5vLCBpdCdzIHB1c2hlZCB0byB0aGUgc2hhZG93IHN0YWNrIG9u
bHkuIFNlZSB0aGUgdjIgY292ZXJsZXR0ZXIgb2YNCj4gPiB0aGUNCj4gPiBkaXNjdXNzaW9uIG9u
IHRoZSBkZXNpZ24gYW5kIHJlYXNvbmluZzoNCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMjA5MjkyMjI5MzYuMTQ1ODQtMS1yaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbS8NCj4gDQo+IGkgdGhpbmsgdGhpcyBzaG91bGQgYmUgcGFydCBvZiB0aGUgaW5pdGlhbCBk
ZXNpZ24gYXMgaXQgbWF5IGJlIGhhcmQNCj4gdG8gY2hhbmdlIGxhdGVyLg0KDQpUaGlzIGlzIGFj
dHVhbGx5IGhvdyBpdCBjYW1lIHVwLiBBbmR5IEx1dG9taXJza2kgc2FpZCwgcGFyYXBocmFzaW5n
LA0KIndoYXQgaWYgd2Ugd2FudCBhbHQgc2hhZG93IHN0YWNrcyBzb21lZGF5LCBkb2VzIHRoZSBz
aWduYWwgZnJhbWUgQUJJDQpzdXBwb3J0IGl0PyIuIFNvIEkgY3JlYXRlZCBhbiBBQkkgdGhhdCBz
dXBwb3J0cyBpdCBhbmQgYW4gaW5pdGlhbCBQT0MsDQphbmQgc2FpZCBsZXRzIGhvbGQgb2ZmIG9u
IHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIGZpcnN0IHZlcnNpb24gYW5kDQpqdXN0IHVzZSB0
aGUgc2lnZnJhbWUgQUJJIHRoYXQgd2lsbCBhbGxvdyBpdCBmb3IgdGhlIGZ1dHVyZS4gU28gdGhl
DQpwb2ludCB3YXMgdG8gbWFrZSBzdXJlIHRoZSBzaWduYWwgZm9ybWF0IHN1cHBvcnRlZCBhbHQg
c2hhZG93IHN0YWNrcyB0bw0KbWFrZSBpdCBlYXNpZXIgaW4gdGhlIGZ1dHVyZS4NCg0KPiANCj4g
InNpZ2FsdHNoc3RrKCkgaXMgc2VwYXJhdGUgZnJvbSBzaWdhbHRzdGFjaygpLiBZb3UgY2FuIGhh
dmUgb25lDQo+IHdpdGhvdXQgdGhlIG90aGVyLCBuZWl0aGVyIG9yIGJvdGggdG9nZXRoZXIuIEJl
Y2F1c2UgdGhlIHNoYWRvdw0KPiBzdGFjayBzcGVjaWZpYyBzdGF0ZSBpcyBwdXNoZWQgdG8gdGhl
IHNoYWRvdyBzdGFjaywgdGhlIHR3bw0KPiBmZWF0dXJlcyBkb27igJl0IG5lZWQgdG8ga25vdyBh
Ym91dCBlYWNoIG90aGVyLiINCj4gDQo+IHRoaXMgbWVhbnMgdGhleSBjYW5ub3QgYmUgY2hhbmdl
ZCB0b2dldGhlciBhdG9taWNhbGx5Lg0KDQpOb3Qgc3VyZSB3aHkgdGhpcyBpcyBuZWVkZWQgc2lu
Y2UgdGhleSBjYW4gYmUgdXNlZCBzZXBhcmF0ZWx5LiBTbyB3aHkNCnRpZSB0aGVtIHRvZ2V0aGVy
Pw0KDQo+IA0KPiBpJ2QgZXhwZWN0IG1vc3Qgc2lnYWx0c3RhY2sgdXNlcnMgdG8gd2FudCB0byBi
ZSByZXNpbGllbnQNCj4gYWdhaW5zdCBzaGFkb3cgc3RhY2sgb3ZlcmZsb3cgd2hpY2ggbWVhbnMg
bm9uLXBvcnRhYmxlDQo+IGNvZGUgY2hhbmdlcy4NCg0KUG9ydGFibGUgYmV0d2VlbiBhcmNoaXRl
Y3R1cmVzPyBPciBiZXR3ZWVuIHNoYWRvdyBzdGFjayB2cyBub24tc2hhZG93DQpzdGFjaz8NCg0K
SXQgZG9lcyBzZWVtIGxpa2UgaXQgd291bGQgbm90IGJlIHVuY29tbW9uIGZvciB1c2VycyB0byB3
YW50IGJvdGgNCnRvZ2V0aGVyLCBidXQgc2VlIGJlbG93Lg0KDQo+IA0KPiBpIGRvbid0IHNlZSB3
aHkgYXV0b21hdGljIGFsdCBzaGFkb3cgc3RhY2sgYWxsb2NhdGlvbiB3b3VsZA0KPiBub3Qgd29y
ayAoa2VybmVsIG1hbmFnZXMgaXQgdHJhbnNwYXJlbnRseSB3aGVuIGFuIGFsdCBzdGFjaw0KPiBp
cyBpbnN0YWxsZWQgb3IgZGlzYWJsZWQpLg0KDQpBaCwgSSB0aGluayBJIHNlZSB3aGVyZSBtYXli
ZSBJIGNhbiBmaWxsIHlvdSBpbi4gQW5keSBMdXRvIGhhZA0KZGlzY291bnRlZCB0aGlzIGlkZWEg
b3V0IG9mIGhhbmQgb3JpZ2luYWxseSwgYnV0IEkgZGlkbid0IHNlZSBpdCBhdA0KZmlyc3QuIHNp
Z2FsdHN0YWNrIGxldHMgeW91IHNldCwgcmV0cmlldmUsIG9yIGRpc2FibGUgdGhlIHNoYWRvdyBz
dGFjaywNCnJpZ2h0Li4uIEJ1dCB0aGlzIGRvZXNuJ3QgYWxsb2NhdGUgYW55dGhpbmcsIGl0IGp1
c3Qgc2V0cyB3aGVyZSB0aGUNCm5leHQgc2lnbmFsIHdpbGwgYmUgaGFuZGxlZC4gVGhpcyBpcyBk
aWZmZXJlbnQgdGhhbiB0aGluZ3MgbGlrZSB0aHJlYWRzDQp3aGVyZSB0aGVyZSBpcyBhIG5ldyBy
ZXNvdXJjZXMgYmVpbmcgYWxsb2NhdGVkIGFuZCBpdCBtYWtlcyBjb21pbmcgdXANCndpdGggbG9n
aWMgdG8gZ3Vlc3Mgd2hlbiB0byBkZS1hbGxvY2F0ZSB0aGUgYWx0IHNoYWRvdyBzdGFjayBkaWZm
aWN1bHQuDQpZb3UgcHJvYmFibHkgYWxyZWFkeSBrbm93Li4uDQoNCkJ1dCBiZWNhdXNlIG9mIHRo
aXMgdGhlcmUgY2FuIGJlIHNvbWUgbW9kZXMgd2hlcmUgdGhlIHNoYWRvdyBzdGFjayBpcw0KY2hh
bmdlZCB3aGlsZSBvbiBpdC4gRm9yIG9uZSBleGFtcGxlLCBTU19BVVRPRElTQVJNIHdpbGwgZGlz
YWJsZSB0aGUNCmFsdCBzaGFkb3cgc3RhY2sgd2hpbGUgc3dpdGNoaW5nIHRvIGl0IGFuZCByZXN0
b3JlIHdoZW4gc2lncmV0dXJuaW5nLg0KQXQgd2hpY2ggcG9pbnQgYSBuZXcgYWx0c3RhY2sgY2Fu
IGJlIHNldC4gSW4gdGhlIG5vbi1zaGFkb3cgc3RhY2sgY2FzZQ0KdGhpcyBpcyBuaWNlIGJlY2F1
c2UgZnV0dXJlIHNpZ25hbHMgd29uJ3QgY2xvYmJlciB0aGUgYWx0IHN0YWNrIGlmIHlvdQ0Kc3dp
dGNoIGF3YXkgZnJvbSBpdCAoc3dhcGNvbnRleHQoKSwgZXRjKS4gQnV0IGl0IGFsc28gbWVhbnMg
eW91IGNhbg0KImNoYW5nZSIgdGhlIGFsdCBzdGFjayB3aGlsZSBvbiBpdCAoImNoYW5nZSIgc29y
dCBvZiwgdGhlIGF1dG8gZGlzYXJtDQpyZXN1bHRzIGluIHRoZSBrZXJuZWwgZm9yZ2V0dGluZyBp
dCB0ZW1wb3JhcmlseSkuDQoNCkkgaGVhciB3aGVyZSB5b3UgYXJlIGNvbWluZyBmcm9tIHdpdGgg
dGhlIGRlc2lyZSB0byBoYXZlIGl0ICJqdXN0IHdvcmsiDQp3aXRoIGV4aXN0aW5nIGNvZGUsIGJ1
dCBJIHRoaW5rIHRoZSByZXN1bHRpbmcgQUJJIGFyb3VuZCB0aGUgYWx0IHNoYWRvdw0Kc3RhY2sg
YWxsb2NhdGlvbiBsaWZlY3ljbGUgd291bGQgYmUgd2F5IHRvbyBjb21wbGljYXRlZCBldmVuIGlm
IGl0DQpjb3VsZCBiZSBtYWRlIHRvIHdvcmsuIEhlbmNlIG1ha2luZyBhIG5ldyBpbnRlcmZhY2Uu
IEJ1dCBhbHNvLCB0aGUgaWRlYQ0Kd2FzIHRoYXQgdGhlIHg4NiBzaWduYWwgQUJJIHNob3VsZCBz
dXBwb3J0IGhhbmRsaW5nIGFsdCBzaGFkb3cgc3RhY2tzLA0Kd2hpY2ggaXMgd2hhdCB3ZSBoYXZl
IGRvbmUgd2l0aCB0aGlzIHNlcmllcy4gSWYgYSBkaWZmZXJlbnQgaW50ZXJmYWNlDQpmb3IgY29u
ZmlndXJpbmcgaXQgaXMgYmV0dGVyIHRoYW4gdGhlIG9uZSBmcm9tIHRoZSBQT0MsIEknbSBub3Qg
c2VlaW5nDQphIHByb2JsZW0ganVtcCBvdXQuIElzIHRoZXJlIGFueSBzcGVjaWZpYyBjb25jZXJu
IGFib3V0IGJhY2t3YXJkcw0KY29tcGF0aWJpbGl0eSBoZXJlPw0KDQo+IA0KPiAiU2luY2Ugc2hh
ZG93IGFsdCBzdGFja3MgYXJlIGEgbmV3IGZlYXR1cmUsIGxvbmdqbXAoKWluZyBmcm9tIGFuDQo+
IGFsdCBzaGFkb3cgc3RhY2sgd2lsbCBzaW1wbHkgbm90IGJlIHN1cHBvcnRlZC4gSWYgYSBsaWJj
IHdhbnTigJlzDQo+IHRvIHN1cHBvcnQgdGhpcyBpdCB3aWxsIG5lZWQgdG8gZW5hYmxlIFdSU1Mg
YW5kIHdyaXRlIGl04oCZcyBvd24NCj4gcmVzdG9yZSB0b2tlbi4iDQo+IA0KPiBpIHRoaW5rIGxv
bmdqbXAgc2hvdWxkIHdvcmsgd2l0aG91dCBlbmFibGluZyB3cml0ZXMgdG8gdGhlIHNoYWRvdw0K
PiBzdGFjayBpbiB0aGUgbGliYy4gdGhpcyBjYW4gYWxzbyBhZmZlY3QgdW53aW5kaW5nIGFjcm9z
cyBzaWduYWwNCj4gaGFuZGxlcnMgKG5vdCBmb3IgYysrIGJ1dCBlLmcuIGdsaWJjIHRocmVhZCBj
YW5jZWxsYXRpb24pLg0KDQpnbGliYyB0b2RheSBkb2VzIG5vdCBzdXBwb3J0IGxvbmdqbXAoKWlu
ZyBmcm9tIGEgZGlmZmVyZW50IHN0YWNrIChmb3INCmV4YW1wbGUgZXZlbiB0b2RheSBhZnRlciBh
IHN3YXBjb250ZXh0KCkpIHdoZW4gc2hhZG93IHN0YWNrIGlzIHVzZWQuIElmDQpnbGliYyB1c2Vk
IHdyc3MgaXQgY291bGQgYmUgc3VwcG9ydGVkIG1heWJlLCBidXQgb3RoZXJ3aXNlIEkgZG9uJ3Qg
c2VlDQpob3cgdGhlIEhXIGNhbiBzdXBwb3J0IGl0Lg0KDQpISiBhbmQgSSB3ZXJlIGFjdHVhbGx5
IGp1c3QgZGlzY3Vzc2luZyB0aGlzIHRoZSBvdGhlciBkYXkuIEFyZSB5b3UNCmxvb2tpbmcgYXQg
dGhpcyBzZXJpZXMgd2l0aCByZXNwZWN0IHRvIHRoZSBhcm0gc2hhZG93IHN0YWNrIGZlYXR1cmUg
YnkNCmFueSBjaGFuY2U/IEkgd291bGQgbG92ZSBpZiBnbGliYy90b29scyB3b3VsZCBkb2N1bWVu
dCB3aGF0IHRoZSBzaGFkb3cNCnN0YWNrIGxpbWl0YXRpb25zIGFyZS4gSWYgdGhlIGFsbCB0aGUg
YXJjaCdzIGhhdmUgdGhlIHNhbWUgb3Igc2ltaWxhcg0KbGltaXRhdGlvbnMgcGVyaGFwcyB0aGlz
IGNvdWxkIGJlIG9uZSBkZXZlbG9wZXIgZ3VpZGUuIEZvciB0aGUgbW9zdA0KcGFydCB0aG91Z2gs
IHRoZSBsaW1pdGF0aW9ucyBJJ3ZlIGVuY291bnRlcmVkIGFyZSBpbiBnbGliYyBhbmQgdGhlDQpr
ZXJuZWwgaXMgbW9yZSB0aGUgYnVpbGRpbmcgYmxvY2tzLg0KDQo+IA0KPiBpJ2QgcHJlZmVyIG92
ZXJ3cml0aW5nIHRoZSBzaGFkb3cgc3RhY2sgdG9wIGVudHJ5IG9uIG92ZXJmbG93IHRvDQo+IGRp
c2FsbG93aW5nIGxvbmdqbXAgb3V0IG9mIGEgc2hhZG93IHN0YWNrIG92ZXJmbG93IGhhbmRsZXIu
DQo+IA0KPiA+ID4gSSB0aGluayB0aGUgbWFwX3NoYWRvd19zdGFjayBzeXNjYWxsIHNob3VsZCBi
ZSBtZW50aW9uZWQgaW4gdGhpcw0KPiA+ID4gZG9jdW1lbnQgdG9vLg0KPiA+IA0KPiA+IFRoZXJl
IGlzIGEgbWFuIHBhZ2UgcHJlcGFyZWQgZm9yIHRoaXMuIEkgcGxhbiB0byB1cGRhdGUgdGhlIGRv
Y3MgdG8NCj4gPiByZWZlcmVuY2UgaXQgd2hlbiBpdCBleGlzdHMgYW5kIG5vdCBkdXBsaWNhdGUg
dGhlIHRleHQuIFRoZXJlIGNhbg0KPiA+IGJlIGENCj4gPiBibHVyYiBmb3IgdGhlIHRpbWUgYmVp
bmcgYnV0IGl0IHdvdWxkIGJlIHNob3J0IGxpdmVkLg0KPiANCj4gaSB3YW50ZWQgdG8gY29tbWVu
dCBvbiB0aGUgc3lzY2FsbCBiZWNhdXNlIGkgdGhpbmsgaXQgbWF5IGJlIGJldHRlcg0KPiB0byBo
YXZlIGEgbWFnaWMgbW1hcCBNQVBfIGZsYWcgdGhhdCB0YWtlcyBjYXJlIG9mIGV2ZXJ5dGhpbmcu
DQo+IA0KPiBidXQgaSBjYW4gZ28gY29tbWVudCBvbiB0aGUgc3BlY2lmaWMgcGF0Y2ggdGhlbi4N
Cj4gDQo+IHRoYW5rcy4NCg0KQSBnZW5lcmFsIGNvbW1lbnQuIE5vdCBzdXJlIGlmIHlvdSBhcmUg
YXdhcmUsIGJ1dCB0aGlzIHNoYWRvdyBzdGFjaw0KZW5hYmxpbmcgZWZmb3J0IGlzIHF1aXRlIG9s
ZCBhdCB0aGlzIHBvaW50IGFuZCB0aGVyZSBoYXZlIGJlZW4gbWFueQ0KZGlzY3Vzc2lvbnMgb24g
dGhlc2UgdG9waWNzIHN0cmV0Y2hpbmcgYmFjayB5ZWFycy4gVGhlIGxhdGVzdA0KY29udmVyc2F0
aW9uIHdhcyBhcm91bmQgZ2V0dGluZyB0aGlzIHNlcmllcyBpbnRvIGxpbnV4LW5leHQgc29vbiB0
byBnZXQNCnNvbWUgdGVzdGluZyBvbiB0aGUgTU0gcGllY2VzLiBJIHJlYWxseSBhcHByZWNpYXRl
IGdldHRpbmcgdGhpcyBBQkkNCmZlZWRiYWNrIGFzIGl0IGlzIGFsd2F5cyB0cmlja3kgdG8gZ2V0
IHJpZ2h0LCBidXQgYXQgdGhpcyBzdGFnZSBJIHdvdWxkDQpob3BlIHRvIGJlIGZvY3VzaW5nIG1v
c3RseSBvbiBjb25jcmV0ZSBwcm9ibGVtcy4NCg0KSSBhbHNvIGV4cGVjdCB0byBoYXZlIHNvbWUg
YW1vdW50IG9mIEFCSSBncm93dGggZ29pbmcgZm9yd2FyZCB3aXRoIGFsbA0KdGhlIG5vcm1hbCB0
aGluZ3MgdGhhdCBlbnRhaWxzLiBTaGFkb3cgc3RhY2sgaXMgbm90IHNwZWNpYWwgaW4gdGhhdCBp
dA0KY2FuIGNvbWUgZnVsbHkgZmluYWxpemVkIHdpdGhvdXQgdGhlIG5lZWQgZm9yIHRoZSByZWFs
IHdvcmxkIHVzYWdlDQppdGVyYXRpdmUgZmVlZGJhY2sgcHJvY2Vzcy4gQXQgc29tZSBwb2ludCB3
ZSBuZWVkIHRvIG1vdmUgZm9yd2FyZCB3aXRoDQpzb21ldGhpbmcsIGFuZCB3ZSBoYXZlIHF1aXRl
IGEgYml0IG9mIGluaXRpYWwgY2hhbmdlcyBhdCB0aGlzIHBvaW50Lg0KDQpTbyBJIHdvdWxkIGxp
a2UgdG8gbWluaW1pemUgdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24gdW5sZXNzIGFueW9uZQ0K
c2VlcyBhbnkgbGlrZWx5IHByb2JsZW1zIHdpdGggZnV0dXJlIGdyb3d0aC4gQ2FuIHlvdSBiZSBj
bGVhciBpZiB5b3UNCnNlZSBhbnkgY29uY3JldGUgcHJvYmxlbXMgYXQgdGhpcyBwb2ludCBvciBh
cmUgbW9yZSBsb29raW5nIHRvIGV2YWx1YXRlDQp0aGUgZGVzaWduIHJlYXNvbmluZz8gSSdtIHVu
ZGVyIHRoZSBhc3N1bXB0aW9uIHRoZXJlIGlzIG5vdGhpbmcgdGhhdA0Kd291bGQgcHJvaGliaXQg
bGludXgtbmV4dCB0ZXN0aW5nIHdoaWxlIGFueSBBQkkgc2hha2Vkb3duIGhhcHBlbnMNCmNvbmN1
cnJlbnRseSBhdCBsZWFzdD8NCg0KVGhhbmtzLA0KUmljaw0K
