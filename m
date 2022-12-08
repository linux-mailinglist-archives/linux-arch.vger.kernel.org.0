Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62364797E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 00:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLHXJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 18:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 18:09:20 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022024.outbound.protection.outlook.com [40.93.200.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE035133B;
        Thu,  8 Dec 2022 15:09:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL2y2jRoNi8E7a67drItFMepTkvI4U+K1QWJtTjKtfzrG9yiKbVf38LjC38pc1/21cZBagm8JW7iaPdXgZBVO3v04/TZqcR3fX/MBnc0k33nxvewUZnKQaSCw1Q6zIZHaDj7WHeFtQVZ9BMq8gs0cKa2k8ryloucJMcVVeRc6Q3dPN0BnTfyS/0jJ+3kzgdhIcqiDTFPLAABlMjKsEUzIAOEz+pyuU6WXB29LCB7XBLglzumFgWfGAaPLWP0F3Wl7OsOUP+BlMZOTm4Oj5jVXPhfoiHD4s4V7f9q2Yd6OhB9WROHqurIOUGlOBE8Y06dU7dR0enNJ8DUPEHnQAngRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu+qktjCY5ZgwrNIUEjHQYduna1ZU2IAg1LM4sKLqb8=;
 b=DHsHIuW4u4Q7diCobqW+3Z9jOhU8St6euTCyUSWieAEhY4m3XpsONcsXBcuOV34/z391PZBd7tVibeu2JIlU37Zy5Fpmm4tt8kV4yxJ6+Jk+5oUl18esNadHMN6HTV4O7nBMU2ZnJ2A6sQCqTrvpwApH5WPuUDZiI5x66tZpOmBuwI36CT9MfpDADz6m8mC8GrM26E8BtAYIIuuVlMqns3WhezRi+totdH99eSU1giZTMPVbtpPmIvsGTTBy5jF6+MxRh5c5dswjI0qy7LN4/YUa/xl4sRF/N0SJbPPDX9W0SR//J45f0WMRgqHD2aX8Cx4JfBf7B5LtwVtp2gn34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu+qktjCY5ZgwrNIUEjHQYduna1ZU2IAg1LM4sKLqb8=;
 b=hIhAWfyuY5riwlXKqJZ8QbJLLwPb9u0PhicycnTMpDIXDiwd8w2bKoPgUgaXCgoyXcAGmXDh1XbAk/+80l/Zw5ZBJx+hmYPRB8nr6YmoQu+ipZ8TGCxQcnwE8EF1sA8tR7cLopZMA1+GV+/7n/x3H/+q7a9RnmyYM0F7ZbKw1YE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1468.namprd21.prod.outlook.com (2603:10b6:5:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Thu, 8 Dec
 2022 23:09:17 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5924.004; Thu, 8 Dec 2022
 23:09:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Thread-Topic: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Thread-Index: AQHZCdPpXH6AK9q30U+Ekg4k2yGxvq5kjyiAgAARLpA=
Date:   Thu, 8 Dec 2022 23:09:17 +0000
Message-ID: <SA1PR21MB133514CE3EAC690C8A82B942BF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-5-decui@microsoft.com>
 <20221208220705.gog2lmlooio4act3@box.shutemov.name>
In-Reply-To: <20221208220705.gog2lmlooio4act3@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=83e1e361-e106-494c-9510-69f5a90c8080;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-08T23:08:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1468:EE_
x-ms-office365-filtering-correlation-id: ade0404c-fc17-49f7-6d76-08dad9713b0b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQIekBeFqNRUW7U7lfswm0bHy55hJW7xFrruSAtYRUykWo/xGZk/VBEOl9EEF+5vRv5MPNJEN/hy0O12viP1iVnlrr1QQ1IJqeImrHIzJxEXGd+y+kwzWyKNjhZgRCw0ftovvrIIjLX0fUYF8wlPVaNb9EobMnH3Pt11RgcyjRUQnLX6X5XRfs0NBrL9WUoLE5y7YP72fUbOzJUllecgcQRZE0byzSF3XUxdHnx5QqpQsR4Lr1NumM4I+w/Dl/rMAjvAi3PvUfkQ63pwroPPyCnzEjC/rsJ3UGtyizC0wXfxhBegbD0lBYo1vpyRlLYyfIS+lT1bXGKxOSdLIzt+AYFjP3phg3Q0+zuEWnF9a3Ghg1laRWBkorMHAg6Kfb45Eb6wQKJPKC7EVrH2Dy4C6S/UnPINql2HgXjG7ZOHtJx5FD+hSn1kJbkyer5kSSq1VIKGDymLnHohSeiZRGpo8bsSQ9E74so5440zR219qV5mfcGNHa1n8/ad00+f3xW9Wy6AmjqSkJVbzFBwNzvAfMLxRdPf3N/mrEFvdkRrrMXlRj8tfiU+leKRA53vYSNyyHrq7v+PvB8Wy3/loFkbF9PPjFn8GskYOmpP3MO9maOnaf8peOy+sPn77QGCSe3qvRk3uNAe7UUkTfb6KYyayXi8OJWgIy9ubAL3Ye1IDzOZPxqZW4DS3mQYOlVFPt89OXCdFQxNiL3P6R6u/9N5yWN9gr8Hznl73YbSidJ1lUcmawvGMUxInG5FZbSepXA2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(6506007)(38100700002)(86362001)(38070700005)(71200400001)(558084003)(7696005)(55016003)(8990500004)(10290500003)(33656002)(478600001)(26005)(8936002)(2906002)(4326008)(7416002)(52536014)(66946007)(66446008)(64756008)(6916009)(8676002)(9686003)(76116006)(316002)(41300700001)(5660300002)(54906003)(66556008)(66476007)(82960400001)(122000001)(186003)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MiZNpwMHlRsGRHfF/ffJioD45O0VWeXKF/P82zRHb1JvAU2Vvh4XGy4ZPVSr?=
 =?us-ascii?Q?COBvvMwXDy0gksJn/esapyb7PAcdOXYjsw+iwyIQ27TGUZsy882wrd+V6EjT?=
 =?us-ascii?Q?fEjg6QFi+VqDtxGhdZ1rA4t0B/47KYIVM0UG/7h5HGrw0cLZ+UlRhzrS8mde?=
 =?us-ascii?Q?txZbL2LW58YwXTSYHhPIIj3oAXdX6WhwcpzD4EC1G911dC/DjbFFFRc1JnTt?=
 =?us-ascii?Q?OtkfbgCAk3otpR4VMecMQoFyS+2a2D0b4y3xVZPCsxP3JpBStXT+/PiuqBkb?=
 =?us-ascii?Q?/dagXKKiEf/nGAn7zi8EQS2S6nBsRbPiJzNqLFqYHWoF1H/3/heG5FbqdQxE?=
 =?us-ascii?Q?FHvCjU+23xuer9BIBh6hbkPWnbdCGvqDPGKZdrZ5AN8Fktp8b1ElNyIJ6XlQ?=
 =?us-ascii?Q?OVvQ+hCOnGAg/zifVurk+B/NpHoLJCZCewb7KshsWYK5gf0KAz9dpL02ptV7?=
 =?us-ascii?Q?eRJMMIHT7kpBuu1D0RDCm/SBT3WvBllwcumKWHKOHMWudCuxYiva49c82CPJ?=
 =?us-ascii?Q?ikHcPC4gTLUYv7H/5C/pAIGDbbzGFD5Sc9jByiMwfyXgoQkG0v++ouLG2Dzu?=
 =?us-ascii?Q?q7DV/SdF9Nu+MvxhHcoCDMEosGyKYvl1DJiE6/9zYy4a/UrCExfTVbnA3sLT?=
 =?us-ascii?Q?BGz6PVFIR43ssslk98ar2jWj47TrW30ySUiu722DLkx0/RaT6cvLbKdLKSBG?=
 =?us-ascii?Q?TJp6I5EPHypZbsCdZPl/tQ+Sbd4plOOgzpvbktXeXyxGwa6sfsQAkHPRdAZQ?=
 =?us-ascii?Q?J4Knq3pgJAkxlet/wmGizmqbyJb8PSBTmjSmWEvtReuXb3Ee/Arf5CSajFPs?=
 =?us-ascii?Q?5DL70HyhQwrqSbTo+fTsNu97Qz1vkkH4CH9ilG0kT5WRTkqmrIjSdprkypc5?=
 =?us-ascii?Q?ve5vK7SUvF0eADvy7Ah+A5RXyKnD4BDJmq+82pKG9ThnjyEWpbT5dzQIwHKE?=
 =?us-ascii?Q?aQUkVuftdwuc5Guu9vrslxHzE7wfu8cZcdWGF6STgMODSblVzPp4VWK3zHfN?=
 =?us-ascii?Q?jw1J/RCbQoH1RhCxbQU9ZKdNpKjjXtkGxGgsPSm/LO0hXsueY3P1nDi9qIIs?=
 =?us-ascii?Q?wzaFiGEzmKc7QK4poO/JJP2e4dmw49xJWkQMYJXrZdvA5JbqlJXrjq1P6X40?=
 =?us-ascii?Q?pLOLF6lThuIPnnbZc+f3FwlgIGlmWCxdPj3+0VPON+hyQV+4XpXm58GxURSl?=
 =?us-ascii?Q?PzkodfaRUM5o3RKWAUbn04DBrU7p7G4r6H6jDpe0VKBis2Jai6xohCnaqnu6?=
 =?us-ascii?Q?BQwtMWsY4e3ccLyU2Muy1wQV298aYpBSAVF1K84MCl7SaRv/LLYT5/jE7IuM?=
 =?us-ascii?Q?+2naD4iprJoLD516iDmCvByomO2jN/C0r6ZwMMCJzeRGMpdCno/BnuF43f6q?=
 =?us-ascii?Q?v0SiIRmXPW85z3m+pLswhFWzCfWCd2fkUOuoOtW17i7c/KCVFHy2BdFgOyjG?=
 =?us-ascii?Q?ebD4J6kIWn0UPqBKKgFyGU0I2uJRJvQsCke/XV1ps1A0CZvEJboAEVhxRu0Z?=
 =?us-ascii?Q?7uD+PR9BDA/oQXpDoVAVLbUC6uzKzODz+nIRvoQ1iIJU0SeOyX+TlaAGIInd?=
 =?us-ascii?Q?TX6eDM06Ht0R88PVX3Y/iKG6qASl81s2W0AwOp5o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade0404c-fc17-49f7-6d76-08dad9713b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 23:09:17.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZtdMrvd0Zj9ozc/8O9EGXM7t/tzoOcrUWJ7oBM3tBDIn9mWw8NVLFdbIJVV/kkzUX2ES+s4b6x5mCVjFkuFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Thursday, December 8, 2022 2:07 PM
> [...]
>=20
> Since you submit the patch you need to add your Signed-off-by.

Ok. Will do.
