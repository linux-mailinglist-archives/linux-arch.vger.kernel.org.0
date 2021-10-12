Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135A42ACBE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJLS75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 14:59:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:46306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhJLS75 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 14:59:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="224671475"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="224671475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="491108150"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2021 11:57:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 11:57:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 12 Oct 2021 11:57:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 12 Oct 2021 11:57:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 12 Oct 2021 11:57:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F94PbaBrlx+mXkltm9ZNLiSoEKS3fHgoFOIBLnrpREj3dJdSABLvTUYIYnBl4div8bIF7ajYe7vKAcl7TO0JkCaRV1YFgnTUSRmtLheUiR64kpuCqkVpERsG+YvlpCV1hQ99EpOpnH1Cpr7Np/pbm71ho7ntP1y7PCw+hLVom5CjV9AyzpsqadKGvc2PitkESDHlEMpFt08pnOrAkm3P0z7GHdGyEr0fvQLjAFPgHIRtkZ4EUsmJ0r6LKhXZlBnOoext7Wxrt7qZt6rYFrFyOCAVHN33pFa+jCKcrTi6DRMxVrGpelk2i8pBNHqsyU+Jjk4F/AF/341ef8xC0KXybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tQEhZp7Fz5yReuniT0/Mr73X5oCAzaFEpsmKL0Znzg=;
 b=erkhEuTuDV25RsvGCfhl9A8U/0anwntGF4pGr2EfavQgL9TXgrVJGpFfexhiuhM6D26AGd8NrT7cgLgHgM5UOauqSQ4Ye2QlmKjVM0rKBBexTJQ+ZkJdl+1luDZAuCBOAnfISTTuQ1i4uONPqQyxfgXA/cuJilOfZdhWGsG72ykQQOjIYOQzHuYtvALx2p5lnXG9PQPhaSA4TA6EBaC6fuE6lgdu8ECjg/MRqBRHWFgudQje0Dkm7S5L8EAjW2gkhHgW3ZpAvazlbtK9LUtIap9B5UYIzyCl5t6bOCOuasjWwgIJB9Nn9NnSDv6b3GSHCuIUWIm3nXt5M/dx3Ev39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tQEhZp7Fz5yReuniT0/Mr73X5oCAzaFEpsmKL0Znzg=;
 b=KtiIbhl3GnnffqJPVQ/6d4XaEyQiQXXM0vYSfM9rj0YOShmGD4W5SArl5QsfNY/7GKYxPZWEZqpmXAreUk9+dnV3pO3saD02Plu21k3KJTF81kEsdgOHDpwkeiF07AS54ALqLmDwlwRygAbcK/mY2k9e0rJ00aA7Ezs8VZRocOE=
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB4442.namprd11.prod.outlook.com (2603:10b6:5:1d9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18; Tue, 12 Oct 2021 18:57:46 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::e52d:425f:5db8:9742%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 18:57:46 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Topic: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Thread-Index: AQHXvKYONYCiLR7qcUWwBEZSAUzHCavKbb0AgAC0m4CAAavhgIAC4/bggAAFVICAAABFkA==
Date:   Tue, 12 Oct 2021 18:57:46 +0000
Message-ID: <DM8PR11MB57505C520763DF706309E177E7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <f850d2d6-d427-8aeb-bd38-f9b5eb088191@linux.intel.com>
In-Reply-To: <f850d2d6-d427-8aeb-bd38-f9b5eb088191@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32e11cba-a657-46d5-de4b-08d98db22dea
x-ms-traffictypediagnostic: DM6PR11MB4442:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB44428E08F3E6D66F1BCBE141E7B69@DM6PR11MB4442.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66MuJTFanBOloxNxaSeT1N2KwLiBmNM6DwtJQOd2DQzmL6/R6iYlg0oPLWlV/Pl5HbcrMUcqjtOoytCi9eTyzs/nPIjGqltVI6LkN1NNu/qMx/GUgVeUcbVOvZ08p1fVo/dRUCXVXkqYDQ5bPO7AvKlaL8gHomltV8NOpCGhaaFqp0ljiuo9taDwpTkxiBGt1Bc5bHfKiDQbWNClS/b/NDajuD35+BQC5Sb4Ul9vjNisaxXipgxDD9iRx2nE/uYKyMO9ny+YMiF5riXFCl8BDZ3lG98PpDxQXvZlf+zM1Q/qON9Gz9WESEhzOc/XkyEjr66ArlbJE4ej4f2/rcwD5SHGq7lWEN/Dwt24RsQyUDLBGUtPKffzL6mStiStAm1wHF3yPYfwwCxDor46h/axaPQn6AEz87T0UGAjqj9CRMK7rSN+tvgZnIAZOeCBn1pTitCILTxkpPyqcwL9GrqKM5o6Ewwei3LP65bl0CVYGI/Z06tobnP19WxqyEwR56us7TpvW76JFGprHmqfcgaqWfSswNKHZPRbW/LWdlsDBa/Tg9Mh8y0ljuSQMYOJ83JsjhUIQVD8RkYNu2VDvLNaF1XG5vqlKyWW0T4ejyVIWOL6ztn5V5PvaxAXxljPN1q+uYAFK3WCsxgHImdcUi2n6w9qlyClg9pCbeB8yUI6p0qIP778I1RMUZ+rKvm5wxscuHIMgOv5eJ89CBoBkMxUSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(55016002)(8676002)(64756008)(8936002)(66946007)(66556008)(66446008)(76116006)(71200400001)(52536014)(9686003)(26005)(186003)(66476007)(7406005)(7416002)(6506007)(7696005)(508600001)(5660300002)(4744005)(54906003)(316002)(110136005)(38070700005)(86362001)(2906002)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk93YjcxSW12QnhPN2pjRnJ3NjVMdXRad0Y4MmhEa0JPak53bnJPNS9SdmFn?=
 =?utf-8?B?bEszMDgzWWpXTm5FSjhIVVFJZEp4UkZhRnBNeWRMTTJIU2hGVUwzUWhwWGxK?=
 =?utf-8?B?SGRKRXBZNkZGdmFCMTg5TzZSZW5QL1lkc2pKYkFIbXRVWGJvMFF3ZDNGSkt1?=
 =?utf-8?B?R1k3bTVwaU9DaU1lMXd6SlZvZW5xTGhaSHJMWktOTUJqYU5FeHRHTG5kaU00?=
 =?utf-8?B?VEhobWhwSFJiVWlYRDV1eHViSXFweGtxc292SkNKckNGV2poSEZGNlRPQ3c1?=
 =?utf-8?B?dHR1V2lPSm1GQitqbVlOcG9iVTFRV3BQOGtJV09rYmNGNStxa3NQcGhpOXhO?=
 =?utf-8?B?REsyME9JZDc3dFNjNmNMYUlOQU1EaUtTcmpBNHpLVkpDeHk5dFlMQ3JsQm9W?=
 =?utf-8?B?L3BkZnZmK21XM2hWdStGSU9yM3FkaXJKcGpScEoya25XcjR1eERwM3JYSmhk?=
 =?utf-8?B?UE1JMFA4NmdMV25nL2xRa0JOanJUYklGKzFmWi91OS9kSFR5TysyQ1FhR2xv?=
 =?utf-8?B?U1RkbENqQ3FnaW44NDVMSUFZQkFaRHBRYm1oNlI5RGlyN1JIendWQjhYNi80?=
 =?utf-8?B?ajZXSTZiMTZpb3l5N05pN1M5RHhDaVhiYlZqdThNd25aay9oZ3hjNklrcENW?=
 =?utf-8?B?Q0pPbFZHS1lIMWpiMklLcXlkeFJwa2ZZc3d1WEJ3VUt2RXVZVDhoU1RUQ0ow?=
 =?utf-8?B?dDNQd0JVWE9WOVNZdS9kdkUyT1NLdU1tR2lZcUxsRWFjclBGUnd3OW51U0lK?=
 =?utf-8?B?dlZiM21VOEc5R2pUVDNXRkhqcjlzU1J1Y2xqdFZqOExDL0c5Vk1qMWhPcUU0?=
 =?utf-8?B?dWJVM1k5Njl6VVBZeU5HSVVZb0dSZlZ0WmdySG9RZFdKcURKbTBxME5Eeklo?=
 =?utf-8?B?TEhpenFWMzVHQjJPZVdRWXp1TVNVZjlxUXg5OENUbGNUUUhSbE9BTG5qekY4?=
 =?utf-8?B?cGNHY3o3Q2twUHVnbnlnUjJEMDVRZ2I4dU84RGx1TEN2dDdmL1dGSXE4dVBw?=
 =?utf-8?B?Z1JyV1BYdE0wb1FzbjBzQ2ptMjI1bEpQclBQVGtTLzdvbGtOdk5wVzI3VW51?=
 =?utf-8?B?S2h3SDh3U3BHNndHbnV1Y3JYdXluWE1wSlZWdGdvc1MrV016emhWc2FUMU94?=
 =?utf-8?B?YUlzZnFBRTZua1Y4SXk2eUpLZ0ZUSlNPRmFvTGl4UkdMallYOTJpcWdsemtY?=
 =?utf-8?B?bHcvNjFoYTZ3cXA2VjdTTmhxeG5UaVB3M1BGVFNDdXB1Q295VjRvZHV4VXBP?=
 =?utf-8?B?clo1NGR5Y1dXSzV1Mmhsd3Bya1VLZVd6eUFvdy9XVnJrbVZFbmdTSmtra2pP?=
 =?utf-8?B?aWlQZmE5Ynd4VUVPTGNVVUxvdEs4S2RHYVNnTGIvblRtY1NvL0tmSUVTU01i?=
 =?utf-8?B?NDgzcHNWb3hrUlpqLzUrK0xWU01NTDB1dVdPSVc4SXFtZVFDS1NELzlISlNm?=
 =?utf-8?B?UG5aL3J5b3pEVGxTbmdWN3pmVjJma1YwaGNKM3E1VzFXZTdmaHh3aGdYRUpx?=
 =?utf-8?B?aVUwRW5Bd3JUVlRWdFdMWDZYK0RHSjdUTVZhbDMvdVFLVWl4YUFQdzVLNnEx?=
 =?utf-8?B?N0FnNTRNeGVkN2dvTE1tWm1PZjJ5UVFHbmU3TC9YMG96K1pTUVFwYjRvWkx6?=
 =?utf-8?B?UG1OQ0hlYVFSeWd5a3pPT3o4MFZEdkNMeEwrL2hBZnN0bEp2eCtlN3BTWE5m?=
 =?utf-8?B?OWN4R2NLWGNvMTlISE8xOUpwZFUwU0pNZ1dETGdneTNFK3Q5amdmcloybEVr?=
 =?utf-8?Q?BMEKGbJ1mflDnSjZBchX3oWMKhbrt5I5guAjgn1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e11cba-a657-46d5-de4b-08d98db22dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 18:57:46.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZdJy8O1qjvfWVOHdjaVfaduftQ5/hzrdPSBBFS5sO20YWfWPDzqJJJbRQHyghd/BUZoNt2V+v8nBn6dF6JwhRB5Vpp48pGL7rhtgxW4+1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4442
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IEkgc3VzcGVjdCB0aGUgdHJ1ZSBudW1iZXIgaXMgZXZlbiBoaWdoZXIgYmVjYXVzZSB0aGF0
IGRvZXNuJ3QgaW5jbHVkZSBJTw0KPiBpbnNpZGUgY2FsbHMgdG8gb3RoZXIgbW9kdWxlcyBhbmQg
aW5kaXJlY3QgcG9pbnRlcnMsIGNvcnJlY3Q/DQoNCkFjdHVhbGx5IGV2ZXJ5dGhpbmcgc2hvdWxk
IGJlIGluY2x1ZGVkLiBTbWF0Y2ggaGFzIGNyb3NzLWZ1bmN0aW9uIGRiIGFuZA0KSSBhbSB1c2lu
ZyBpdCBmb3IgZ2V0dGluZyB0aGUgY2FsbCBjaGFpbnMgYW5kIGl0IGZvbGxvd3MgZnVuY3Rpb24g
cG9pbnRlcnMuDQpBbHNvIHNpbmNlIEkgYW0gc3RhcnRpbmcgZnJvbSBhIGxpc3Qgb2YgaW5kaXZp
ZHVhbCByZWFkIElPcywgZXZlcnkgc2luZ2xlDQpiYXNlIHJlYWQgSU8gaW4gZHJpdmVycy8qIHNo
b3VsZCBiZSBjb3ZlcmVkIGFzIGZhciBhcyBJIGNhbiBzZWUuIEJ1dCBpZiBpdCB1c2VzDQpzb21l
IHdlaXJkIElPIHdyYXBwZXJzIHRoZW4gdGhlIGFjdHVhbCBsaXN0IG1pZ2h0IGJlIGhpZ2hlci4g
DQo=
