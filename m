Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74D7783DF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHJW7k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 18:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHJW7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 18:59:39 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0342272C;
        Thu, 10 Aug 2023 15:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U37vngB+HVRzk0Dv5TU5lZYvee9IRc/utAc5Nge3U8zZzSrNkzOfAMWl9s+WuGVp6WQxYGooBuc9+FtbpUxtUZqiInEvse19OM0JQsPYsPNHRVbkC/5bUqyJmQcF7igiSHDAJ2u7CXYQvrtR76Nox/NviHjm4j3v5WVLOtFR0ax0RMlnEh+tmhLhqN/9zF1TtG9zIrAQAVmnvZcqGgHYZUCwQUDp4ooVPnRfXUNua44RLpDg7rhnpSe+/RcrfRyVSoh17YqXHEJXajffnGVnPLLSMrY6tdIG57ApdapEDFVRE0PG6or50tFnHN1CgY2ZGcuf5V9FW4VrnKIseDdCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0WREgJDE34zQGoUnMkOZuVRWDnxZm6U36UycywXRds=;
 b=lz8QzjG8r7Qa4xuoQ3usiSs574b90GIf+W7UyqGkrG5bhhHAvyx7UXRmKHJmAfBkd+UmEToaWbd1B2qBS0SgUZWI5ePNQdOeQYlF6DbIaVHS9L9hJkpFGcBDp+wuaxafAfibq3iXUxJ6LRs8c41pUMpQQ5nNhJjA66AXminek3KH8JmESkiyHw7DCHhKMCpaXqus8foX5YJY4GaYPbPGneGyADuF6pgUvmcwL0Uxzb99ScaGDnjhwLCCTnCEzJkrIpZVeU08/aYV+vVA+DaUovRviWv57RnVmOQtQqReEIuFLJ7UncbZ4EOk7PEpe6WFCAhwTlmVYVsi6j93ptO0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0WREgJDE34zQGoUnMkOZuVRWDnxZm6U36UycywXRds=;
 b=cw4WbPJDsTlN+8W8Rz5h8b0JilXK6W2pfdGbXeNUYFp4NU2pcNLJlSdfTkIy80zg4J3R8U4tcz/3QS4/C2ru92qjn6RjMx5NqewDcEkEQ6hCYj1XoQHHhn23OulMADtXktzEPtO0sgiyGRI+gF/l4J6zwGnAC/qEUtnkT5IzSF8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS0PR21MB3950.namprd21.prod.outlook.com (2603:10b6:8:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Thu, 10 Aug
 2023 22:59:35 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Thu, 10 Aug 2023
 22:59:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH V5 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH V5 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZy6RY7nYR/0UDx067fCeHwlC69q/kIcWg
Date:   Thu, 10 Aug 2023 22:59:35 +0000
Message-ID: <SA1PR21MB1335C309189196688CDAA7CCBF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-3-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59b80390-6a4a-44fd-8230-a80175f51422;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-10T22:46:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS0PR21MB3950:EE_
x-ms-office365-filtering-correlation-id: 05a99900-2d86-431f-1ffd-08db99f57754
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKNHtzVQOKzCSKOD8P98HyFKO5wyatS1dtDXwpM+zYZ1a/1/D2BEKQl5Ow3R3tagzcKlqcJrSHd2YU0I5V62/W/hVoZQCf5To4WQGsKi9U+zK6YMgdu7bbYuu4xYhCBgbkeIqELy54DQhxYAcN6wGht4iTcZozrnNKqMpJtIcqvMhSbO4Sx81R3hMq2FI/f1ERTOzxItpbvFyPPlA1W1oT2WlZZr1FDarXbBMXQHrVP1pnYN4V4PgPL0ljZYK5tH6CrKrdfTfhm/PGoAEpO4QPUpDNQt+D70jctjhNVzZjErxmgQ6nmEZJx//SW3Wxj+TIfH4DbyUdUhzwSXNYsWVAgau8ge2yfrhaT5grPaYn/fEHU24xKOrVvT5EM8WyalBexd0O9AIAKsBITxjWd+lHdnSNCxhTmS8twJIBT+bpfrvI2LeJZUlBR1dNJFo9qDaew/ZTSVoSv6NgO6qi2c66dAFlIk6V/27LgD8ZdLCl339XPDdDPEptvnKGvd3fpiMgf1INSyfzW7b/HbcizzVlg8TyKQzyH7AE7zqg6t/DFNp3E7xkvfS2FyD/foKQjvt5A20ABsX5pCWsVOOEN5HLv1O2N/p/Le9aC+YyIogkrMNorx/jvBXo3NKWsEjhd5rNH+JW5EP16sdPtOrcWoiEJh0tync09BD23uA7Jhmac90jxqrxFV9k6XDAX1d6nk34JIIDo+Cas6MOxFWpmXBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(1800799006)(186006)(451199021)(82960400001)(8676002)(7416002)(82950400001)(122000001)(12101799016)(921005)(54906003)(110136005)(6636002)(8936002)(316002)(66946007)(4326008)(66556008)(41300700001)(66446008)(38100700002)(66476007)(64756008)(76116006)(5660300002)(52536014)(86362001)(478600001)(8990500004)(55016003)(38070700005)(26005)(6506007)(7696005)(10290500003)(9686003)(33656002)(107886003)(2906002)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/CYUm6/noVVrqSfFI0lSDCvjc+zadpI8DwmBYMPvXEen80ZxSm/zp/ZwcM6?=
 =?us-ascii?Q?p3qjv/m04NnSQKap9YfZoaF+5pjgyyuSndmROgX/ZXsuFa7OaxfvFQA1QYr6?=
 =?us-ascii?Q?E7cXukQJfA8sUmit24uwMS/ovn3eAjcxu0AsVwr8D6CxBo4CZIk0h/9gcTeG?=
 =?us-ascii?Q?xlgm3Z8kpAOtJi9QHsiVq31qV8L1XEFDn1SZKNpwRXOSmFcEc8F3B77Zld7c?=
 =?us-ascii?Q?YEiRkNPlUKlmkNwW4OOzC7Ag6C/v7Yd86GwWh7Hbrce2aeZah2wi1tZxKPnB?=
 =?us-ascii?Q?9cRZ/q9bU5okwhSG/Cca8A3KOQeAREqGcf+C+jTDgH6//B3gog3mCMszFE9U?=
 =?us-ascii?Q?OCwXwGTqAqShh5jLG3Ifi4746o8Nv20qg7EoXN5ipqZzN5HqClCgXMLpQJww?=
 =?us-ascii?Q?9upqV4H/N3gcaVZYu8yBReGttYGqGVpkOa/ppUhs2ntb+PZ+a4OwSLEP9Zzn?=
 =?us-ascii?Q?RBOV3Dmkanz/39SYwdqUI8al8mEYA9ujiZ6S8JVBPGi4052TUdc8PjOETPTV?=
 =?us-ascii?Q?SO/jusPDnZ2oh3GgLr9g56g8EOnJJ58hJ0lm4oS/xhkEzb16MmICeButxgRM?=
 =?us-ascii?Q?1Mou9rOUDbKfNPjJAnh8XFD3vhx9Pg5c6oBw+67g8R5og1XWIsNA7dmfdK73?=
 =?us-ascii?Q?5kcn8L7jE7mfeLBP9OoeEt8O11lpGLSyqwLveYApjjTsq4NpRVRACQGBSHjf?=
 =?us-ascii?Q?/JARJ8oCwrJokNF3uKoP3jeK7FyfUGQ3GdoQW+VrZVF2WnDhWwvwcoc5ZpaF?=
 =?us-ascii?Q?wDXA9t5c5zm3paHrw+3dnM7YZNCAZb2e4m0bQHdpZ2f+UlSF/CSvt4mJDRs0?=
 =?us-ascii?Q?jet6BmKZqVcJ1P02sZQnXI5iT61nm5v5Owo+HIb/y9SoC80jchigbWKL7FUc?=
 =?us-ascii?Q?tC2SoW09lQvvqys5Cj/ikA/9DD2IuP1PcUwIfnJdM8wmRpZMZI9vi58wpr6I?=
 =?us-ascii?Q?3CjMxweyIDzRLHpVBSlPFZHp8C55mLF+nOtICS6ewmGZ2v36NpsSCTx4F/Qe?=
 =?us-ascii?Q?HT2JqV57Z0uxmWzdFd00Uo4t7qo3GoQgkCSquE1lPgo7UQkFNOkqeNN8gJYd?=
 =?us-ascii?Q?EIr/8eL1UP/7GGkXmeeNvfcVJMpS+v4c+6wttVZqYB8Bjevc653+6G+2H+QP?=
 =?us-ascii?Q?E0ehS1vOxYOmuF2g8vysuzIBxJyvU+uj1AhFKb5tQD3k8Yqcks7DYjfG/6Ew?=
 =?us-ascii?Q?Xm7ZRFBhZyVfAq8y7ieaLz/ZtKnQgXU327nPXwWqwL2GoaEKRo0LkaM3HAjU?=
 =?us-ascii?Q?Eov23lZYToiisaTn1fthiQFCftbvuCO7wedA1GXMi455rXrj0aqYJUwae3Wj?=
 =?us-ascii?Q?0O4XpXBp05GZyhFnNVFEqF2D2G/0rnm83+1QcqI0mjHOdjjqEU0nLWSsmOLm?=
 =?us-ascii?Q?/geMcWPdJ9XuRfOnZCHISAASqDHF9zrsFWvoRO2Pz6YZrnOfhPzZOy0zEiEb?=
 =?us-ascii?Q?+VDzXhyyBtwQyRgaSXW0mRV6UCV/DR8Iw/JYpj4J1cgqmlj7e1U+mPg8jnnF?=
 =?us-ascii?Q?Hue2M44twPLphAG2FRjCQ4MBzrXAYu8bLiKyH5H0Q9FoOg69lCZTPi9oD50g?=
 =?us-ascii?Q?4HSGmhN7AOL95t7L5vu9kjMfqaqEU4TH1G/oZpPs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a99900-2d86-431f-1ffd-08db99f57754
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 22:59:35.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oftty7aEOTG/ujx0e1/E1qjpBWS/31cFFsJ8kfAgAuV0JLVM1a6Trr9Zl5QvAQomBz58GxCZM9kRufhzCePb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
>  [...]
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> @@ -378,6 +378,41 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 |
> HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	unsigned long flags;
> +	u64 ret;

This should be
	u64 ret =3D 0;

> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;
> +	if (!input) {
> +		local_irq_restore(flags);
> +		goto done;

Here the uninitialized 'ret' is returned.=20

If we move the "done:" label one line earlier, we won't need the=20
the above " local_irq_restore(flags);"
Maybe we should add a WARN_ON_ONCE(1) before "goto done"?

> +	}
> +
> +	memset(input, 0, struct_size(input, element, 1));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret)) {
> +		ret =3D output->as64.low & HV_X64_VTL_MASK;
> +	} else {
> +		pr_err("Failed to get VTL and set VTL to zero by default.\n");
> +		ret =3D 0;

If we have "u64 ret =3D 0;", we won't need the "ret =3D 0;" here, and we
won't need the curly braces.

> +	}
> +
> +	local_irq_restore(flags);
> +done:
> +	return ret;
> +}

After the above minor issues are fixed, feel free to add
Reviewed-by: Dexuan Cui <decui@microsoft.com>
