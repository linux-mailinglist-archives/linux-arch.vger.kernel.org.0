Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52647783025
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbjHUSRo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbjHUSRm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 14:17:42 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14612F;
        Mon, 21 Aug 2023 11:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2Q28GslaSFJr+SvHw8CmYgmrQykNPIYYJHgnZd3zy9CI5JUDtZq4jbnXR2unDiPLdwu5kesXMlSiTrTOudPnmvE+92/EATwDY9ckYLmjCOrabrOnV8wOkPn/tUKK2YvZgXl+HRC5CIx2g/XSLmlPmSBgRgxwgw1ersKaCXbz9CE7+794wzZ2jUNb5HlBAuyDtVsiZXJOX1RCys4oYwmvRfXmG+vIvy9DDctc2bA1Gdq3LNvF4uBpJp5fui9tv1ZHPlNfXV70dSJ4w4eBw72S515/v/Lbz1vcfKdjPG+5v0i2PkioVVn5JXhISf0lFCcWAE5xAdcVdLtu7T5BSbz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HGcm0QtJ5LcfiTvLl3dzlgdLTb4ihJ3IZQDKvaOlWg=;
 b=WG8vGz3L2Ttk7qNKgdOCVHSC3HAnfHLGa6RgJdHpHcgm3kDsU6YcdW4ooT333flyHjOU5U/gvh8tnZxZGDOAZdlGHN+D39v2LWwYbvuWoeZltIso0Mz10T4ITRws1rXUKjoqBLAOD1O+wRGnL7jMB7AGY43dqngET/oNHSnsqFLYVo3EicAqwdsXNg2O9ostYeQnPXJgAcQJsrhvk/vWHQcyktaV1Gzr8PaUTHptakw+lX29sDO5lgmej3U5C4TxfF9iV/BQhzzZ7/Kv4Yw9NaP1/ySrOdOXvpIRKX/lCRL7ViKLvTA8qUJ1RfQjC+W4MhU33vtYXZD8eyn2fcu8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HGcm0QtJ5LcfiTvLl3dzlgdLTb4ihJ3IZQDKvaOlWg=;
 b=LheWtyKasF7fNN8Wh19T3UNlwJ7slWMY5vi+ZIHrn0S5zZlvYZy4uqRVywT3nj7gtnThAsdeDM+gRBvhrhsw187Oy6vloj1mY9b7ButXbQzQdN8tu6TUiZq6fjZMSCC9oBfPFSLNoXae9kHhiy19lFM0QhecMkJ6gjdqiOLTb1k=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1311.namprd21.prod.outlook.com (2603:10b6:a03:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Mon, 21 Aug
 2023 18:17:30 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 18:17:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v2 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully
 enlightened TDX/SNP VM
Thread-Topic: [PATCH v2 5/9] Drivers: hv: vmbus: Support >64 VPs for a fully
 enlightened TDX/SNP VM
Thread-Index: AQHZ06TUj05o/4FsiU6WoMQ7db/eq6/0zgLQgABBYpA=
Date:   Mon, 21 Aug 2023 18:17:30 +0000
Message-ID: <SA1PR21MB133563B4AA42F3443E22D790BF1EA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-6-decui@microsoft.com>
 <BYAPR21MB1688D35BBB82B43320C8A04BD71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688D35BBB82B43320C8A04BD71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c727f11e-8a08-4ddb-b8dc-45cf0d42eec4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T14:20:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1311:EE_
x-ms-office365-filtering-correlation-id: 8f9dd670-c7d6-4d8c-99fa-08dba272e228
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DdxkqX02qPsMyYpNj7hoLcA49uPAmilQI0OJ+PrGZ+2D67T2vbKiDq+gbOYL3fawTTO6db2PtH0hGomlnbYSCybkKQBHk6onwi+wV37yB9W7Ai1kUkpxGJIEH94/FR5wG0iKcf5RtZCFVwHv9tP5kWwBaz93HtU4dJKNEv3n9e4oEU6R5ME4cHR2GNLpQhvuqXH+RoKK31j9l6gqJvMkHuEu0nijHJg5vAkKt5yIOMumz4Ei2smhpGVqFgrc63UR1tfINAoKVdBGC4lzVG4DIGtjjRB14cycOjl4x0phqPSkJfKDMTx3eXE4TJflF9EJ23nU6z/avv77FKPZMIaGty8D0HzfHXG0WI9IOMgXjCZbUkdHpTGkRnx0JH5KJ7q7IPM/tc/jkuGsP4S+85DWTT/VCg16qop4emcaK8o36CQiNwm3pQD0vt6FHyjWsXVF7qON872G2wPMFJ9EbGj+Cu9zrHVXAB2bM/PvRFol+AVCM5/gbjvdLH6owcP75fwFLj0oLAN+MuKqKKPCCFYOlIb0dPzmx2EFOE2fYk1jRVVWVaZyRsVRuuXlN5IEEYzTPZybwD5MKOO+ve7h1e6EqXzUrkQLXxSvGamCUZjop0rKsIriqIi/V5Ib0c/mRIkhyYPtkz9YYuYldIS6dH5lUAG3ZbYAfgHsbFv3msdger4jJQxWY6PELC5r3TQedMe+4EyrZxr7Ca5WyZkZiMoMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(8990500004)(9686003)(7416002)(7406005)(71200400001)(2906002)(7696005)(4744005)(55016003)(6506007)(86362001)(122000001)(38070700005)(38100700002)(54906003)(316002)(66556008)(66476007)(66446008)(82960400001)(76116006)(66946007)(110136005)(41300700001)(64756008)(478600001)(921005)(8936002)(82950400001)(4326008)(5660300002)(33656002)(8676002)(52536014)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gCfOJs+MdL++9S+DLaVjtI9cYNsJIN77IJ2T1DfUFQMtBrelpDaWM4OFej+/?=
 =?us-ascii?Q?yROGvjfF7kXosioJIU/23SS/YwiokYmmU+pSddGMbo8+D4JSbkRac3jUlxUW?=
 =?us-ascii?Q?5fmNyqAEkP+9sErn0GiQfIRfXul5mRS6NBxLlt18btWCH0VJcPJBmt5XqgaE?=
 =?us-ascii?Q?LBp4702K35yTM+oEGjA6p9GvaKvJRjy/F8NZqzRDgRUgI1YatKEC9RspkR7r?=
 =?us-ascii?Q?+BUxOuhlW0OuutokeDUbBCe8RalL2RmIVjHtR1LAQ5GK3pe2of6BNpMH8AUn?=
 =?us-ascii?Q?VLIeBY4ka5DCmS/0R6waiaElj8lpFCkB1LlMIwiD2HzlMcLDm/u4ZFwQAtET?=
 =?us-ascii?Q?dQuRa1LVVWpb7yALTjzDVXz3IdW4gAbEc3mSCmx20xd5WwL19lPq8VOXP4nm?=
 =?us-ascii?Q?MYNjuRJNXzQYMAGmdWgyLjsIqfROnMI6brvNK/sXapHL2UYbcWIIIfNc8jL6?=
 =?us-ascii?Q?lzQ+lFA59D/D0nfe9Ir3I+Mkmd4LecJ+1wOb2Nnr2pX/NisOF9zzo6BkXa8d?=
 =?us-ascii?Q?5S+94rfbt6qEdROdW71NMtpHDm5irPxVY7UdzQ3QpYjEAtNUN9n9NqD1eVZA?=
 =?us-ascii?Q?VBOvbZVGDg5IPopaZl2OIgCOLuAxa9XHjpdJzGPpajEcRSPdW2TGoypF/Saf?=
 =?us-ascii?Q?qtroJqW9+MPGeCKyN+a/xYTp8RfobXOwWA3kBseUK6ZxihNiEDMl/S2n0QJX?=
 =?us-ascii?Q?jb2n8oXqw0ySRPveYIVR77QBsoVjxOxpwxUkOkmll+R6pNFnbtt5RdZyP1vE?=
 =?us-ascii?Q?ba+aoL7h+z3aQLSBZoEkVHzM8fEIe9OUxDgY3E6B8p6+E2j86or/4EfzfJ4R?=
 =?us-ascii?Q?h6uv1rNYZ+qcWD5cR7rHzwSCcIb24NmaanDh5ZOoLH7kovFdXBUB0EnSOeiF?=
 =?us-ascii?Q?GeMfrrKgavblYQT/8hos3yiR0Dz4qK1HhNwqL+M21vtqaFQskqoqh38MTgsV?=
 =?us-ascii?Q?IlvJsEE+9CK+mYGulbao2aGAIx3/aVThD5WMiayy4+Hr2bqcT/XKlgpVf9uR?=
 =?us-ascii?Q?LPta726crw+COUd20Y2+EcZI+s6XDrgJN/aGRwfsaKlDfkvAXAefEDOAR42u?=
 =?us-ascii?Q?W8mOuyQlwz0CxlAOJcHjV6lbyQ9dcVjtqxZT/pwIJJ4aubAT7fb/4nwOhTUO?=
 =?us-ascii?Q?2kW0oIirkA5VDpL/OgxyRIwyCV5rmoVH2bkK8TSO5SrkhV5/X11f2dhZeVOB?=
 =?us-ascii?Q?1IqwVdiz+NfhpdEZudX32uvlqvuSmvP8JhgVo9Uj8u2Bm+3KUFJLFpZElsI3?=
 =?us-ascii?Q?To6a9d0bwjiEp+ILH5wdJh9/vmDOw1HUFKyaUshC9JdIpv9Wsw4VOdKrP8YJ?=
 =?us-ascii?Q?ETRTihYn8lXYTlppllwrVC/kgm/GIqIu3pW0OpOUcpUTuDlZPUj2ZYkoQHU2?=
 =?us-ascii?Q?psCVEcSgLAqHUsSYUGv8dfIoijirUXuanPEqKf8/JMA78n5Kghez5zttjjs0?=
 =?us-ascii?Q?M5RJzyyw9M18BP0w6W2QF9RsPY3p/aZqWu9uA+G5szwkllOsZwlgASO3Mp+6?=
 =?us-ascii?Q?+C3znTjuCmjFbErNiuwKH7OHG2pUYOX9h7P7lWdYog4uNFGfaI6sa6ZqlJ0Y?=
 =?us-ascii?Q?63ntyaGU9+AM+vIabBeVupM0iHtsrk6GXuf3dwllSdcZJbUGx+QnBU+Ztj5u?=
 =?us-ascii?Q?XybhwWjIchkKydiW4Fp8Els5b51+YWB4bb01m6nwICXX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9dd670-c7d6-4d8c-99fa-08dba272e228
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 18:17:30.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9JXWYHquZAx+7w7RxuTwn598EjQXLLz4DcaEhg/nBiWmBXJVUfvrK7iRbEzg7HR3ZL7MEzk93O1ajqmlwPtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, August 21, 2023 7:30 AM
> [...]
> From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, August 20, 2023
> 1:27 PM
> > [...]
> > When such a VM has more than 64 VPs, if the hyperv_pcpu_input_arg is
> > not NULL, hv_common_cpu_init() -> set_memory_decrypted() -> ... ->
> > cpa_flush() -> on_each_cpu() -> ... -> hv_send_ipi_mask() -> ... ->
> > __send_ipi_mask_ex() tries to call hv_do_fast_hypercall16() with the

s/hv_do_rep_hypercall/hv_do_rep_hypercall

> Actually, it tries to call hv_do_rep_hypercall().  Using the memory-based
> hyperv_pcpu_input_arg with a "fast" hypercall doesn't make sense.

Thanks for spotting the mistake!

> > hyperv_pcpu_input_arg as the hypercall input page, which must be a
> > decrypted page in such a VM, but the page is still encrypted at this
> > point, and a fatal fault is triggered.
> >
> Modulo the minor correction in the commit message,
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks!
