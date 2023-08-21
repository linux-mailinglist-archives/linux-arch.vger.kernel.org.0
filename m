Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571C783028
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbjHUSSV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjHUSSV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 14:18:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AA13E;
        Mon, 21 Aug 2023 11:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE353Sc4Dj8WNEVdNgIs15L+YzRffb7a0vmjx2hQ7iugnGGINCDsSE2jmej/2bNYSbp2ZAz3y4L0+ePsQxBDC4qYrF8fq+deXuLyR4o/v7gzfAWmMq12mtxFYnTB1R5PdHvIKjLo5u4xAg46r6kKQS31cS76URPkFHFf0ZluL34xP4+rCnljJCMd3LkPHRVPNjyiPUQD7ckFCBWm+tRRltts5hj9H/iokddZtH9x6lRvL4M5ENqHAOOV2O6mAP3NGK1qxIwBtAg8rDLKJB3Xo00VT+XpUA9xMbBtPK8YuHOSHwKaZ22YYZQrvY/IrA616lsZjQtC1pq6JeqQyL3ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXVNYKySDoCGNiKR7PgD61+8xi+H2NuFzeyypxp6FRs=;
 b=A9PuPjyXC5FSuTnG9CjgqBNwoz9JnFy5ekbsidpc9ujwbC7YhJh/fzqyl9GV7PRRHJh1O9ldKJl/PltIOtZprxlX1hCXA6Bf0dUIVRHOgWmlhPlzddI1Ka88tYA+o8y4keq82qOm8wdDNhCOSER+GI2JiWS+bP6fnWnx5ZQGzXYYyr7qgJTKtTE5tWPZpyds4odT0z0hOi0crP1+8kcMB97rMcTTWMSTPnf3tzSO08obWSmtg5x+mTtAX68t5l7JJs8Gzk7oJuI3Dwr7yI7RB4UAiTjXN7zFOktli633nzf6oamjVfpiofirlsYfhlCzQLNLeZ3ur4d2q1ghB4jJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXVNYKySDoCGNiKR7PgD61+8xi+H2NuFzeyypxp6FRs=;
 b=XkaCIzeUo7S2s+yaTLxyid4EBOs9uRI7vo7Z/dVicjwXXnqS4N7LQdbrP2XaLQxinEUnHzofl7cNsBalwaSIoKrGzTcxqXnzT6o4nyt9JwT+hpS2dsXBrw1WwS4lDr+X2Q2isazqKPyQeos1r3UdEX9nXBJbpYF1BF4ExwMGuTo=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0656.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.4; Mon, 21 Aug 2023 18:18:00 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 18:18:00 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Topic: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Index: AQHZ0VZ96EEPB9Xi80mUoj983vpcr6/0nE6Q
Date:   Mon, 21 Aug 2023 18:18:00 +0000
Message-ID: <PUZP153MB063571CB1D30770996948726BE1EA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04ba616b-a491-405f-96ca-e4549b2dd16a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T11:06:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0656:EE_
x-ms-office365-filtering-correlation-id: 1612834f-a648-42b5-b6b3-08dba272f3c8
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cmpin80+P+AH5QWrnJaF11yVYJTDg04jI+wqcq9kphzxqTb+v7KXkikJlwSIGwnq2FL3zWQPEvSoAuUcgSRriUhvBF2lGyM/4OkGY9qOjNcH9kUfQtz0JBHSgs09zwvRFY5Y3PZG+RBPxMTJRCMQfv/xuqLygtNeg+aktmp7HGV9E/VwG655mvebOnFei7O7ZS3PtiHlwxtVZ2QVK9ArZrXEfYvVtAgvCPquEeIW19iUD/jj111SiCrnIlr2yw6xW8say522D+aFX8JTAvIeYCgLb1h3VdVEf7mtJqSVuCA+uKsTeIVzzxTWGpjquAMZbT0XAhcVgK0iqKRS9nwfYgXfzGkseyYXbDqCYBduJGcwmeP54kVZr3CZjRI/ycnAJWFpt7WoQvwHE0jW6y6NfyJv6raINc4Y6So+1im3vvJjB+tcWxlbRSi2YMT4KNPCE2F77JXUYDB3HDP1gNMNgipChz1Xj+IM1y1HfQPmdKHlk4KPEM1vye0J1qGyMQeGGRg2tzO6OP/HUs7j+45A7n4t5tx6ulRY/Jiikq++/ArXP76NFThJYwjfQ/6CqVna+yMNP2ZgYf6yofgOwaUnX7N4RqaekdeNHxoX40lTDkP7EfCMp5OBarGlD7HvbIX07cdMlwcqYutZ4LPRA3mCXhIRqzwqg3/4u/uZmgJY3pIzKOF+MV4dBct+St0Wc/JR2S5fBT4r3JtDgYOcQTotJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(10290500003)(478600001)(71200400001)(53546011)(55016003)(6506007)(7696005)(41300700001)(12101799020)(54906003)(316002)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(110136005)(9686003)(8936002)(8676002)(52536014)(4326008)(5660300002)(33656002)(8990500004)(82960400001)(38070700005)(38100700002)(122000001)(82950400001)(83380400001)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkywCGsNKpr/f8RboeJqGaStjW+8b8WgZpGrpSdSATr53eBTHntsCqaUDJA0?=
 =?us-ascii?Q?8tbplpDNE09idHBpIPgUMlqJIKS2PmTAWZqvFe2BdfSmf4ezCetPIhRjCYbq?=
 =?us-ascii?Q?gdck3+frTF1Mc7ye5dU2DDunoxmajDh8Gq7vT0gSOB2PfU6UPbewwP6oWW2n?=
 =?us-ascii?Q?zvIT2gCfZ9EGQDTr2et4RrQcliEbDlF25GcHXJ1T3xrGILdLx6T/EnpBoEkO?=
 =?us-ascii?Q?1srkITDfDPNPW9P3Q2i8pBrJqXOjW6hMz/+hCpV5pMdT+j1Z94glbKJVFcLd?=
 =?us-ascii?Q?/uclx5FdITwW0L6Xhbb1pglkFSDvkMi0HmMRJMNgLAW+5NpGlP4OPHKLLjZy?=
 =?us-ascii?Q?DHNAIzIOD4BiGQ3FMvSIxdJjCs+NvGZt3rAqc/Iy6tehTRHMVYosncXg82zF?=
 =?us-ascii?Q?/wskJidDetfJwVY68d6tvI6aNrGsYa/flx3Neq+TO89DbJnkFIR25CwORF5q?=
 =?us-ascii?Q?MRgtGcI2hURAPOZAtCVpp58AIZk76W3KIHUaYlFxAYfgo66QBCfupqzCc1ym?=
 =?us-ascii?Q?QxioQaDf9sWKASrsg8/yXHV2ZOOAlY0chz3W5Vf6lmae9K/HXdjPXCpt7JeQ?=
 =?us-ascii?Q?v+k9fjju6H67wXcluXBeQrfB5ODChRo7kPioZVH1BLxYpFdCwDEXrH1diuiz?=
 =?us-ascii?Q?U+C0ieXZcDURReSmKtLjxw2zg7v6eH+M2coXqkslozYxaNYGWuNeCrhIgdzV?=
 =?us-ascii?Q?zN90qSgtUFXCZ4tCxwZyvu72HACDKH3cVws+PhVsvE9GyELhYC5gOp3Qaqfe?=
 =?us-ascii?Q?wDHB4heiq2s/GoyJYzXQ8qJDGW85lGVn64/iaw9ENRYA7v+VQaimvRQYvgFl?=
 =?us-ascii?Q?pOzqvF8wVq0hx5dc4raB5sIVazJkXxZsiw1Hv/m3fLFQhkF+14uOFKjv1ZpB?=
 =?us-ascii?Q?VCmdYs4TU8tD/sw3ysWOmOU/iCvC/KLneblcp9x6lkr/Zoi7OoPFyQ9eW2Ll?=
 =?us-ascii?Q?ODdaFMt1y4vWY9osUMbIBYJydOHAjKGzX+M0UEtL4jypfogZag2RbQVWRgcj?=
 =?us-ascii?Q?1d4zyBMuW7WwS7ZLqUBcW5Wn7za2kL4L00+/JbUYyIW7IDkXmJmMaiTEyT+3?=
 =?us-ascii?Q?3HQI/KYaLo7gm2euoJCzfIrzSs1GqvuZQsK+WQomIbe4ar8HNTid1df0UOrp?=
 =?us-ascii?Q?taehTUgD09t6fSijJlSvFSaMqAqnhjFZOrMTV/LXkuymDQle2jmVhUhExq6o?=
 =?us-ascii?Q?qBPjiAJ27Kk0ic67ugEBAWN6557Gr6pLuueqM6rwmdpoqMcwGoD3PXEZqBW8?=
 =?us-ascii?Q?a+SXC/X1W14xplGqrRXiL9Dy35QN4Ij6xJRBC7BWnXrjCMSw7tTLm39jy47J?=
 =?us-ascii?Q?ezUOnyB84X8DCD/umnvUEoj2vJTJDkoN7D/hXWwZPu7ALeNhHwl4H/elN2RA?=
 =?us-ascii?Q?v1C6JVG55j/SdN+YXut8NmD1gLyX7MX1S1tP5iJ+WCyy0OJMS/XMGpPI/2wn?=
 =?us-ascii?Q?GbvQsOQNStZHrPkQjOVda3auTXJGxwjE+otLjOOuR29o3Fy3+PpjgJS57fp6?=
 =?us-ascii?Q?/mxX4RmGOed0ROGGZriiKKZBrcn1OjBaN6vBGVEhYN/OE5sK4GSUQfYTbltR?=
 =?us-ascii?Q?O3lMhBrAF6dsaWH36Ig7xI1fwkKE472YKdrA8AxL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1612834f-a648-42b5-b6b3-08dba272f3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 18:18:00.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQUtYt4i3N2Z8/vDZgOgpmvKRYA9ZXcDD9S3wrwmQU1b/120yS5g1w0NOLQz9z319dvj/+lqY8Q6hVCeuwycKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Sent: Friday, August 18, 2023 3:32 AM
> To: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org;
> x86@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> arch@vger.kernel.org
> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
> RATHOR <mukeshrathor@microsoft.com>; stanislav.kinsburskiy@gmail.com;
> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
> catalin.marinas@arm.com
> Subject: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
> VMMs running on Hyper-V
>=20
> Add mshv, mshv_root, and mshv_vtl modules:
>=20

<snip>

> +	ret =3D mshv_set_vp_registers(vp->index, vp->partition->id,
> +				    1, &dispatch_suspend);
> +	if (ret)
> +		pr_err("%s: failed to suspend partition %llu vp %u\n",
> +			__func__, vp->partition->id, vp->index);
> +
> +	return ret;
> +}
> +
> +static int
> +get_vp_signaled_count(struct mshv_vp *vp, u64 *count)
> +{
> +	int ret;
> +	struct hv_register_assoc root_signal_count =3D {
> +		.name =3D HV_REGISTER_VP_ROOT_SIGNAL_COUNT,
> +	};
> +
> +	ret =3D mshv_get_vp_registers(vp->index, vp->partition->id,
> +				    1, &root_signal_count);
> +
> +	if (ret) {
> +		pr_err("%s: failed to get root signal count for partition %llu vp
> %u",
> +			__func__, vp->partition->id, vp->index);
> +		*count =3D 0;

Have we missed a return here ?
Moreover, the return type of this function is never checked consider
checking it or change it to void.

<snip>

> +
> +/* Retrieve and stash the supported scheduler type */
> +static int __init mshv_retrieve_scheduler_type(void)
> +{
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));
> +	input->property_id =3D HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input,
> output);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +		return hv_status_to_errno(status);
> +	}
> +
> +	hv_scheduler_type =3D output->scheduler_type;
> +	local_irq_restore(flags);
> +
> +	pr_info("mshv: hypervisor using %s\n",
> scheduler_type_to_string(hv_scheduler_type));

Nit: In this file we are using two styles of prints, few are appended with
"mshv:" and few with "__func__".  It's better to have a single style
for one module.
