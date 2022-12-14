Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231FB64CF36
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiLNSMd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiLNSMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 13:12:31 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11022014.outbound.protection.outlook.com [52.101.53.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E3631E;
        Wed, 14 Dec 2022 10:12:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfs9EYPGoFsPxFoo+wR2HU92P68jY03DK4UtTQfIN++0YHB909FM07xwmY+8M2CW6f4SQ+Nq/ByF2F1CwojhEJDzkeXdcPl707Btk8yQIi7VVn7YXghCxs2Bivs+WewN7r8amm9MDtvibXGJqWnE5Yq90THzaSvY9PUEkulYM3l7y3xcLE++zjCuogcI4L9F0l8+bgHeCkZJ3LjvFZ7oSTYHVkqcC2xszhLBQsphy2XjzEyqJedLRVb2hzFQavMioz3vnpihf2ebOqgHAnPFvQjkcclXRS4hoTZeJAQgoEUlIVR639BGHaQy7Kyi+MtuvaLQJ+vNdrquFYpDZxATLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c9w5GjKMsQemQW53XqsfjkQ5d0InuaT3oewswnM0rc=;
 b=UySCvXkBlDaPWyVcDuB4bWb+mLHztRo81aGp62Q8SVnAjqFx6BxzK66bcLPnvS27UXNzugp+ZptJspv+X2Puod35PgKN97DoFIzvwI31YAMcCEDSyIkdTcPE+6JwchYdgjt0O6CDDmhYp+8FNB+IkGfiNMWhr1APfbmwJdGahPYo9b5gfxvVxgsPxx4hGuDriKBgCMq82iG//7+NxzHUgX3BcwyXTx3QMDpHQuPuoWg2HrrRSSkzVkwk2klXCC0v/7/sENegm7IBM9MdTxDvVDZdvWgVycxm5bhUcPilG3CGBN5ncOejuL9uJ4ztHWBPc0eY24wlFFde8v0Y/RREvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c9w5GjKMsQemQW53XqsfjkQ5d0InuaT3oewswnM0rc=;
 b=A1PPV0s/mBpgVrXgT+bsifBYpfbIqXMIl1SDKZ3mIOxrGNx8m3n8pYUazs5LIANFOHxuj5on9x12DzJDRajujnIUTkyMnOw/aLQrlON+9cMTisai1LFp6ed+w6XDvC5vh+XKLcZLkdExET3iizZOzxSEDAJR82KWQGf4ivf0nL8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3724.namprd21.prod.outlook.com (2603:10b6:208:3d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Wed, 14 Dec
 2022 18:12:20 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Wed, 14 Dec 2022
 18:12:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V2 09/18] x86/hyperv: set target vtl in the vmbus init
 message
Thread-Topic: [RFC PATCH V2 09/18] x86/hyperv: set target vtl in the vmbus
 init message
Thread-Index: AQHY+8nhL15s1gAK70uUJfURBxqIDa5t1qjA
Date:   Wed, 14 Dec 2022 18:12:19 +0000
Message-ID: <BYAPR21MB1688EB0765C172A1D12EB53DD7E09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-10-ltykernel@gmail.com>
In-Reply-To: <20221119034633.1728632-10-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=397976f2-e125-4831-932d-6fd86ff55dcd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-14T18:08:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3724:EE_
x-ms-office365-filtering-correlation-id: 9281aad6-d70d-4a13-ae84-08daddfebd91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnI5wvMxzDvjQVWkZ24oAQbcoaAWsVYqA3vk6FbBd2qmhpY/RzVnC9dssqpLdPQzuEgr4o6J2dlLJQXE04n51RV/o5Y2oMDE9ovEaxJVHdV1hUMT+229yOYg9XYUyTnuwuba5oFb436z9IDxUrS2VPbqtpT2eX46x1MG7VqUFNBLI05c3u1TRvicziLM5mxm3BzH7P85vg0x8z757s3/JqysHHhs47jd3G47JLXjtm87ZJS0D2rxxNnscB9eeFwHGTepHpw8BdlMhHeyt2JM7ymJWuiERmJANg3ZuDQUm5rGgMMRxImmEQ29kjK2etDDyfEYOaaTjh+VFm5nsK0eiu6Mtx0HpAOKCgD9rc3Kvvb+VVCCHJu/k6kYLd7zPX1olagfpUi99sbZSByJzs7L8cQdHPg8EtVoimZEKlNoKYiSAfglDRnC71a9cmF4bJwOOUkIJpl3dg7xqupAlLxfNBE0cekcK3YnGFhHiqwWgrt9jCrSWAD71Sgz7uGBgaHleNIZvNfUSXeWvTMKLK96J59YJg/odG7SXTVKJfGa+Bi43zRwP8QjYGm88MSKhBJBq0FVYcHHLO0+PxzVYD0ipDfBvDy5/4gxwwzYx/bmsBJq7ojwzlMRBvq2ClaHFzK9q5Zkathcfk3750gakKaN1W+GzGCr4d6urqTsyJ0gn7fn9y8ZvJs052gG82Mvn0VUEw39T3ZpHKx1coLoMDekjjfh1yLzVSwI4HCc7nUZECji18xbqlhy8Aac3aq/LErQe1dmviXKZHEeVZ6lL/Uo7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(38070700005)(86362001)(15650500001)(8936002)(7406005)(921005)(122000001)(8990500004)(33656002)(7416002)(2906002)(52536014)(5660300002)(83380400001)(8676002)(66556008)(10290500003)(66446008)(41300700001)(9686003)(110136005)(4326008)(66476007)(76116006)(55016003)(186003)(26005)(38100700002)(6506007)(71200400001)(7696005)(64756008)(82950400001)(66946007)(82960400001)(54906003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3NKGjdC8Y3MtwKpps/GCw1PlDpThGalBhV2mYxoPE+KNPWfelb646A1O0kT?=
 =?us-ascii?Q?GjqrdZsHhHKgJqDu84c9hdAE+TBzPkRxNY+G054xfh/0rVTJCnyA/pPKFymY?=
 =?us-ascii?Q?k+gLnkHEmAVOh89DNFJaHJCsSNZdHr5AFhreMkpoBNpNP/E34sXNhY5TfaJW?=
 =?us-ascii?Q?mNBe8CGed7rYNpCLM37iryvb5MAf/XrOYN1Q8vbx7pG8WxY0pM1AjbM53w3/?=
 =?us-ascii?Q?1m7G7YYh+RObl9PBAUFqDnol5/Z6cQsQ14g7bQgHBxkvfwuOKpYZtnxeBUFk?=
 =?us-ascii?Q?KwNA6LVwdQhGPSDuKcyOMUS4obZlwiMDc+IlfxakC57hqtIC3ubgZeeNzOYU?=
 =?us-ascii?Q?bo/Hr/i28bJU1gcX6AWOFWi9JuQp/xS85h8bTp8G3SPm4EKnkvHseOR8CWzE?=
 =?us-ascii?Q?kpDvyi9ofQSGdApjNCleG0Xj9WGqs56hQu3UsSyTnUXHixGwVzj2pWDhHs7A?=
 =?us-ascii?Q?gW+3tsK7J8LysGObBSIKRB19aLGZr6OlPKRtpMspM+9bUNByTtIYNpvqxAAD?=
 =?us-ascii?Q?R7IpOg1O9mgRrGqCxJ23vvPElK1g2tI/r+nukD/WXeLjTc/0xf73hkeeC6Qh?=
 =?us-ascii?Q?ZBZcol3n7D4vJYHlKnNGN+GspxRDjuPjrYpRIGjLEsiL5Ty2okXLGxkHaf1z?=
 =?us-ascii?Q?KjGSVH2AoTKxye7eGJgx4x/CB4xRTvV6sKWw540vFFx332IktAWLlh97J33L?=
 =?us-ascii?Q?RJ04qy+kE7XbEQ/bLquWCxg7jzOxwYBxTecg8vX6/1HQCDGhFlaxHl7g4IXl?=
 =?us-ascii?Q?fQirQCG63yKf69olP/xBQRyR2ZFdaJwUWYLZ7hUi+dtEqnMf4dG8v4jXTEUh?=
 =?us-ascii?Q?6R/v0AkMjoeHdYsET+3iB+M860eeYeUFP/Gl9EMiYydf5dZPa9hBXqFoEZrV?=
 =?us-ascii?Q?03rt0ibZUQUM5xUhasH59BEPbhTDA8tMhdRANHq3KKDXAu9qy+DiA4QP6uLU?=
 =?us-ascii?Q?vr+UVYIjXKqCzweAt5jofEba/jxWlUGEWXcbvazgtY3ym3wNzuS3KjtRyQh8?=
 =?us-ascii?Q?zAbCWRlymH1CfbRuvkjhkM+Tu+v4NmV7Nt6jklYPISixcB619D/BM+4V9A7h?=
 =?us-ascii?Q?2DTSzN+7mWiQvYdi8+iNfZXudICygCmYpp0Kxcf4JkkgK2FADaaxf+iXbXZc?=
 =?us-ascii?Q?qkP1hqKaEwCeg62m9+nPs4cAGiHNvCC6JTuD5ieGsZkfrm+X/5ZsjfwO7ltu?=
 =?us-ascii?Q?myr0KYjAm1wBd0ZwC6su54F6ScpnulquoQdNf09Zu8z+i3PzytjS+EiFIapp?=
 =?us-ascii?Q?UkWrVGHlHjnFwo/Ve5ttSQPP7tsCkEI5Q/RzGfznqNOCxHr497t9RXYW8m/F?=
 =?us-ascii?Q?dK0EkquJqehLzUpUXvtde+b7y2pomchZog66cOrhA0nWu5LO3RX6e9Zf4V3y?=
 =?us-ascii?Q?DyF8BLXBGCHLmfz+b+MeihMHgQ6R7xsCVIIHXv1Dt5hDmbfPW74rxvJtwYaO?=
 =?us-ascii?Q?hAOgkWs7cYNekXPy2mUeq6wtAIh1BnwUGhYmQbPL9oQZ1iOOG9aaRQ8pmi8f?=
 =?us-ascii?Q?7nysHBWZApcW/nnHT+Au15+bRbxKGGr1GnDdzsviM5P/YhaiBn8JTp0m5P3L?=
 =?us-ascii?Q?IFv9SQkmxpd/8CSUyjT6oX5/acKtslNC1vvS5/t1vupH+spGP/Fmd0M9teso?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9281aad6-d70d-4a13-ae84-08daddfebd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 18:12:19.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Xu8fkckXsMawX09zugjsqPYELNy66GxuKB9nSsl13o716b/NEKAl0S/7/+RIp6pIndzZKDmfcFeC5AlZZwIkDeh5G8rb9tyYSyqpXeIsuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3724
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, November 18, 2022 7:46=
 PM
>=20

Subject prefix here should be "Drivers: hv: vmbus:"

Per my comments on Patch 5, I'd suggest squashing this patch into
Patch 5.  But also per my comments on Patch 5, I'm not clear on
why the current behavior of defaulting the VTL to zero needs to
be replaced by explicitly fetching and setting the VTL.

Michael

> Set target vtl (Virtual Trust Level) in the vmbus init message.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/connection.c | 1 +
>  include/linux/hyperv.h  | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 43141225ea15..09a1253b539a 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginf=
o *msginfo, u32 version)
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl =3D ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 3b42264333ef..2be0b5efd1ea 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
>  		u64 interrupt_page;
>  		struct {
>  			u8	msg_sint;
> -			u8	padding1[3];
> -			u32	padding2;
> +			u8	msg_vtl;
> +			u8	reserved[6];
>  		};
>  	};
>  	u64 monitor_page1;
> --
> 2.25.1

