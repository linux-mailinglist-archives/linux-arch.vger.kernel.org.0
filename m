Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF66EA261
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 05:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjDUDel (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 23:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDUDek (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 23:34:40 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D61FFF;
        Thu, 20 Apr 2023 20:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5+co4+JmtHY1ByX3zD6zJnw4C7YFt+RZZPUm7Xp+HET6luYcujadT+FZIxPDUX+5RQgNufXbFf+RtTLNwD+qRReHheUfly05WxA4tPjUdrNs9AGVqXNs71xnzetSEX/h3aF1/2723w9Q1tz36tfQ7itz0uZYEdZRMkWKS2y/91YOQdD8ICy/V+33+UxKo5hkckGBiEQQsOHYVn/Id4AGZ4pX5UIFQF+ltW7pSi38nBPmkA+TjRIGYKQNZl/PMYyMnbKgVg166gZ5D0/xIlxA5l4MNGfdxlCD9rAdRNnfJ/OVtbywiPldbE6PaB8RdLMrOaWmICT2aXxAAC4PQzEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmUTyrcyL9G+YgA6lf+8XhYEA5fBWtYt0IWkoPJq+To=;
 b=acjI9W4yiLHR4hpbY0Rj9O8mT4UlzhHrk6Vo4WvsbttyIUT64nrBV8B48vr73LVTjTE3ne88wGxpBrZMCAwLVQToH3pySaMHLlvT3UWM3ro+WYoKAPK446MUF9kF6I7iDSjquCM7CV7RleksT1RwXhDJasjZec9hD6xbt7SC/IujEHeByFA5HbJwoQ2tkrSr/FUupAgiDppNVBjWZd1jMGYfqp2P7qGR7CK8SPiPDnz8IwXx1+o0C4a2I1FG/+920YWvywxxbVCf4Z3faOP6yzyz2oCmqYeEw7KaXZFcqzc83M3MmXK49jVdNd/m6VFqJ2UUoRa5wk+J4bH7+rL40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmUTyrcyL9G+YgA6lf+8XhYEA5fBWtYt0IWkoPJq+To=;
 b=ZAMIpq8cOV2i0DckXDnwE5Awv4wq9HUNkP/xKZR8FaeXHCNFsNupA9aogwVhvirFNY3e4kyR4ANrdlMVfTsiKRGDijyFAp5HZfBHIZUuttS9CB+1Fqabm6HnDGBPiCxHQydzIWyRugPLzTIdDqaPAhGPf4ZvOhMRVK5njTHQ3zs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SA0PR21MB1963.namprd21.prod.outlook.com (2603:10b6:806:ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.14; Fri, 21 Apr
 2023 03:34:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 03:34:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZaluiU1mCuu/uekyGswn5O4Hjua8nuTuQgA109FA=
Date:   Fri, 21 Apr 2023 03:34:35 +0000
Message-ID: <SA1PR21MB133594BEC237231D1BE99CDBBF609@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-6-decui@microsoft.com>
 <BYAPR21MB168861A32D07E5D2EB0A80B0D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168861A32D07E5D2EB0A80B0D79B9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9af51bf1-775f-4d61-9219-26878e137693;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-12T13:59:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SA0PR21MB1963:EE_
x-ms-office365-filtering-correlation-id: 006c6bce-4a37-4841-a2ff-08db4219545e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KahUwwwKvMUWS7naclVhINfRDO3NmZ7QHREW0h7PelvWomhJrCQzFW56frvb0OUmpGLSD43QXGhd++Zrr1PzAwRvr7lJKMDNV80yfZjBhcY1jZtpu/xqnMG9fLqaECpZNLE4j9MRMX9PO09E3CDyS+uLwkWRgg1ohCuYpNdE36ECVd0sesfPDECt/sazfrix+Pb26eHCq7DdcgOVHWDFVzu/Oy+0qdnv4cyr2Ozvd1NUGet1asax0oAsac4w5OBVxUEGSnFaZYl7luJjc8Q+5RZrkoCuThu+MWuiHRN0PWoHkbZ7TzcGsjf2C50u6P6TH5zhvK0Br7CJfXPh2hKEccRBXmn0lu75CiE9CdpFNlpet+RDkYZVA1nshOUzbdIBsq3OLDFO92z5OeVkDZXfWVho2Sj290WXscVXpfVqlPpY/CqTc57hQSe3V6ZJZ0/cKNlCnmX3A/QHgjVETRR0R8f+Xh79dIpjSvYon/68gIb0O87i+litvOvz4vtX/iuCwezuIlDHHTLDBbDX5COT2V7yEJgy7cHUsMg+wN2ujFTMl/SV5w+nrtxi/VuSzXHM165KgdMUF1NB4NoKF2IuCL5LJw64pxFkDymKZnARVNCG0bjh9fOzOSFcVMJ4bsdfL2vslg5I4q8iTHtwJsLMjiUIa8QASmIFfW+hPb5cGnpR4QLV74TLT4bz/xAEHLjJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(66946007)(66476007)(66556008)(38100700002)(76116006)(4326008)(110136005)(8990500004)(64756008)(66446008)(2906002)(83380400001)(82960400001)(82950400001)(122000001)(186003)(54906003)(52536014)(7416002)(33656002)(921005)(8936002)(8676002)(478600001)(786003)(316002)(6506007)(26005)(9686003)(5660300002)(86362001)(107886003)(10290500003)(38070700005)(7696005)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mcrDXeaPBcBIbiKniML6kbzgfiBjnBJagJgelsovq2nkH7wvgObfXXQGnD6u?=
 =?us-ascii?Q?81+AfiWXw/laX9mOzDej/O8vB3lpYnaclp3jsY0py9TgrMR1ZDcBGumFiRFe?=
 =?us-ascii?Q?d2X4uYU3AygrUyQY8FSlL0SyJUCL6CaHUEPf3u3HzfdkCU3JZibkyzuUw45g?=
 =?us-ascii?Q?zlYqQpVP0dy43hZaVFzn0DgxjiGGh5KZMfRmjqhIpOjIoBaJQh6DnbLZTwuY?=
 =?us-ascii?Q?+B792J/zDTaWayPJOEc8QMbYtTvYlXjxDbNU56/rddK/4GcvGPHMxTj0zRng?=
 =?us-ascii?Q?nat9VKjc5bJ0puxvXi8xj+Kl3AMyxkstH4vtHFqBiKIZJmDxXaqOnVS3HRZT?=
 =?us-ascii?Q?Z5CHDytrSgdwrbmegbTIsyoFjJLkDnAI073bcAbnUTakyJGUhPUHXcpjFMkR?=
 =?us-ascii?Q?oMH97R8OMNlzQrxoHQbLgbOqZd/7tJb74+8VWArnZ9PawKfflcbAqfQAQs6s?=
 =?us-ascii?Q?fDXLgGSzwOEAIh52nc/nwYKwZrNUryKLLlTAFAn1RokdI6SJuJNlV3j17UQK?=
 =?us-ascii?Q?InVgOjXWvASH6YE8EcLHpDM3wIuznX0bTa+pKiMglkvQwcbvbtp53C6j3GSp?=
 =?us-ascii?Q?26jwFo9aLFEpnS3SzP4nRY3br19voau9Q/UOSfnEabAJgJ2KiKekYAG9dYZv?=
 =?us-ascii?Q?A/slILRnGuWJ4Hc30h84qhdFQed1+N4CVS1TfYleeXU3CLf9BmJlX/n+CmP0?=
 =?us-ascii?Q?aaf1BcXDeOU5hEADPJup/OzK2H/sbjQN82wE66zn4JcW1u2WEHRAJETlwlh3?=
 =?us-ascii?Q?jY0nuczmd8jWDAJ3556GGDcwpOsZvhJXh0aPqIHuG+5zHf1x0g//4OR66ujZ?=
 =?us-ascii?Q?otCi4lfVeRInO38biI4rW7Wo0wzrbcd1oNGxgiWtY5IkbUgy78WgbRBM26M+?=
 =?us-ascii?Q?28Zqw08/67RIoetAkKWM8P8GkH/6YbvGKXeuUhSCO/i8lThY91bkUQeCw6Wi?=
 =?us-ascii?Q?o27krqAEDPY5Zx0njZTDI0fPDLD8qNhYgHoeYdaJeUTC73DkARRad5NyNnMR?=
 =?us-ascii?Q?BqmyAeee4oebaPL6aU1uGX73+QC1DNKOgNC+mo2fwQCZxQbtFGgLMTs2bAeN?=
 =?us-ascii?Q?2ANmTLzptwtwnQFZ0TGmD2bVW+mV3u7V3pnVudDTLY8w6kv4ASU1wTs04o6E?=
 =?us-ascii?Q?4zOKGPYJKtxAdkmT8tfAdZZdomDA1o5sBw00ghgKGXgZ3HpR44iF+djrs1N4?=
 =?us-ascii?Q?zzSieVheWLvKlLe5TUPDjIluHLYncDJ69fQHqrA4u56JdhAq4dyE5wPzeKQg?=
 =?us-ascii?Q?K0iEOo9O8ZM5efUzNW9ypXl4pF/kxmpSVtLeTkb6ogWeMWdfy0smNAHEnrlR?=
 =?us-ascii?Q?9e2s5P+/To4recQ9v0N4APIMxjDv+FlM5WjP9lm8s+8yeHM+F784NbyobC4p?=
 =?us-ascii?Q?MWhdrHndUp6NT0czWjphsrb+UaTjyn32sPOgIbomCWRwdoTAYPTtcqFRPmfK?=
 =?us-ascii?Q?S33jPBz75VPBQPLaCx3eTs2HjiW5X8onJiZ8fA3i3m/VnZu90uhx5rU0qnod?=
 =?us-ascii?Q?c4PW4jx49GQbi+qhwFTg32kdykw1yzqay/XhCKWxPqe3qFHbbpdlPaNhXPAU?=
 =?us-ascii?Q?qveepLC49cbn+jwKoODCh9vzrK5LndDTDpcNay80?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006c6bce-4a37-4841-a2ff-08db4219545e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 03:34:35.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsHc79Z8hzQ0t8UGWVJqVr9iYiVHEbjpoRHMGYJw3BzkTlGjBfhA00W8zpkezJeftNZ4CjdIsGXlqLpw7J027g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Wednesday, April 12, 2023 7:05 AM
> > @@ -168,6 +170,30 @@ int hv_synic_alloc(void)
> >  			pr_err("Unable to allocate post msg page\n");
> >  			goto err;
> >  		}
> > +
> > +
> > +		if (hv_isolation_type_tdx()) {
> > +			ret =3D set_memory_decrypted(
> > +				(unsigned long)hv_cpu->synic_message_page, 1);
> > +			if (ret) {
> > +				pr_err("Failed to decrypt SYNIC msg page\n");
> > +				goto err;
> > +			}
> > +
> > +			ret =3D set_memory_decrypted(
> > +				(unsigned long)hv_cpu->synic_event_page, 1);
> > +			if (ret) {
> > +				pr_err("Failed to decrypt SYNIC event page\n");
> > +				goto err;
> > +			}
> > +
> > +			ret =3D set_memory_decrypted(
> > +				(unsigned long)hv_cpu->post_msg_page, 1);
> > +			if (ret) {
> > +				pr_err("Failed to decrypt post msg page\n");
> > +				goto err;
> > +			}
> > +		}
>=20
> One other comment:  The memory for the synic_message_page,
> synic_event_page, and post_msg_page is obtained using get_zeroed_page().
> But after the decryption, the memory contents will be random garbage that

I'm not sure about this, as I don't see any "unknown msgtype=3D" message fr=
om
vmbus_on_msg_dpc() :-)=20

I agree it's good to add a memset(). Will do it in v5.

> isn't all zeroes.  You'll need to do a memset() after the decryption to g=
et the
> contents back to zero.  Compare with Patch 6 in Tianyu's fully enlightene=
d
> SNP patch series.
>=20
> Michael
=20
