Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D3177EBB6
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjHPV0X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHPVZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:25:51 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834BF1FE2;
        Wed, 16 Aug 2023 14:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbQFWAcI8xqT5x1JIQXg0wzu06jg1Z0dxJdZ3exwag4fJfYoqipYm98KS0YYTekG7qDGIaDOUPhsmSMD8ssuZJOMyBTVy4sqWHWkEnJlAli4ehDT0UtjslZ517/HMl0Oa3rqt+WPAco6bBxc9SILAxnSb4ZKxYmLJ+EU9nhdXwuQa1NgQFeKkvfCDljfMgqk1RtPpQLjej3tisBslQe2CRSXwjttAJXY5VBNf8dzQRoDv5aTX84IVRSBofDSBlZnk+vh51OeG+mzUj7nakdB1VDVXOKrnsRAG4bEDLVLtviXb7ILL/Aie/rzABGdU+KosG5P6yWuYzBoaqer08Bhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsWpeKRGPeobxCXWMacYRG26vhwVuWOOSLNTwE+fHsc=;
 b=QwK1RVrLoi0X7s+WXot3rQ0j2/RglyJSMtk6anNNNZZNmCdNiRt4z6kY3bGxlPdLoN7Svk31VoV9wV19N3gysZ8pi/e0OLTCY0ri2lAZJtHjA0HudrPw0sze13exlkULvjasVUFssSCcIH0KZp3j2oouare+DGD5gsMNJSgpNaNlRL9JItiKEGZHuSLriNkGnpwUuvcr3FMWl4RFmmH218U4wEkQx1znJlYmmpU1cXhdzaNpRhhJJEUC1uh7FREYz/Vq3P5Mi5kOUDk0oEXj5Rv22VNKFpstbj2o03GcQIlj3acxJ2h/PnKrIlwz3IbvMyG9Xool+KG7cYqy1FFdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsWpeKRGPeobxCXWMacYRG26vhwVuWOOSLNTwE+fHsc=;
 b=JTn5MN9Vug5zjmhteeUNKvofnvdJ+majQFHl9hy59YQ9IxUi2GovdM5lNKLfuRzJd0d+MEpgwU5EAIYmpnf/qCS18ZtDDysGo13B7DztX6JOZEJXCx/hck0STLE0+ZlhFTVoGaRt/zwzCIGmmPxZTI9Mo0DbMy9DN3w9uLHBNGI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3483.namprd21.prod.outlook.com (2603:10b6:a03:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.12; Wed, 16 Aug
 2023 21:25:47 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 21:25:47 +0000
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
Subject: RE: [PATCH v6 6/8] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Topic: [PATCH v6 6/8] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Index: AQHZ0FqWdl5qMCCLekayFwYyh2282q/tb45A
Date:   Wed, 16 Aug 2023 21:25:47 +0000
Message-ID: <SA1PR21MB13351C485DBCC1B79891508ABF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-7-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba460136-f61b-4e32-ae3e-023922d64cad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T21:25:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3483:EE_
x-ms-office365-filtering-correlation-id: 92d5adec-678f-4ff7-2a86-08db9e9f5b45
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgKgGrWoKR4FuYVk2WDcpz6QCsFgfDZ7MT2k/8YqOYGwNC4oujUMkI9pw6kUGK7kl/WiNmdsFExbnlG72xDSxTAUWZ2iwf0qJdiRqK5xVf8iWnTz0eGfgWjYzc0AuIVoirtuRAxri07y6e0fGUwWThPhgiV9esZGap7ZD4lPhIsuiutJLECA+GUaWB78pvP6yHjgIdy5j3tFIXa07O8ey06r858QL1Lm7xyVi+CYJuGOdRxnioNWIpHqtzUDOX5Hm28pnsaRkG2aPwBVFtW/ZfLyWvte5dNFSzvMOnO3RV+Y0oygYW1d5j4nMV1H+UV3iW8S7oS4b5kVvMnnXTuCENLEkowgfN5fMzJTtTsr8bosdIpYCzE1fckfInuMKD88poLaPx8EjHa5ENn/+19NY5yrPldNXbjZrd+iuJAhXLFkd+jExgI8YMoTrY3/5k5X5QzhJqiNJ7GhDlHnl22zDaL+k2PP4tmeheQ3RGsRQLKWFqVgB0PTaTu82WqZC63vXTrvFehOC9y0X3QCv9BZ4mbR1aPUMhpsJrrcLy06XI5cK/e/GF2ppefPtNLxrAxKv4+Kbgtr9dkH/NYvOjUw/U/sPZbvfuYy5xlKKkNlunNFqyr5oxFf7p7E3DAQ5ImfrLhztxnxG8gQSq4scvFbH5uC7NubFSuIGJM2RiLWqKgX4RNe5aRHVWAk42FnsvgY3lZl8cmGGBm5aUWnOppzOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199024)(186009)(1800799009)(10290500003)(54906003)(55016003)(6506007)(2906002)(107886003)(66556008)(8990500004)(64756008)(82950400001)(7416002)(5660300002)(76116006)(82960400001)(41300700001)(316002)(66946007)(66476007)(8936002)(52536014)(38100700002)(8676002)(4326008)(6636002)(921005)(66446008)(122000001)(71200400001)(86362001)(9686003)(33656002)(558084003)(38070700005)(7696005)(12101799020)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PfteyP7+e+/VUae2V4zvkZrccigH1+XWATvl2wdgaBd0ZrsebFfCa7vUfE/K?=
 =?us-ascii?Q?9j3yQo6nGq/nus8mkLI9PSRp4Z9GUpqObv/ulq1Q3N7T/SRDg6PczpcRspXY?=
 =?us-ascii?Q?9mj4Qu/s8t8S3f/beCy3arrHtbEGgmNXm71fLL+Anj7YcVIiwG8dwRn03WS5?=
 =?us-ascii?Q?0e0so/gXoyliUUXE+0RP80QP/9QQCthJfIYx1ZNgfI+2mdPh5GhAAFi+5hAF?=
 =?us-ascii?Q?Di27/l5JRWO9kI4S5oi8/s2amZ/G8yk+TrS7tpnWuNdAnO1R5cHK7nrrNUED?=
 =?us-ascii?Q?+1IuOczCjK0L/R9YSenvJrusKvz29zkXrb1NhDlFsXmGoJJSBr6OAGIlperQ?=
 =?us-ascii?Q?MAN1o6Asw0Fk4+jqtpgGfs6pbwE60N7MuoRahizMA1mgsmI0VHXLhXeOaUS5?=
 =?us-ascii?Q?9dsNbU2T3w3aA5UWD2fxp1mdAVr0DooBKd+rZ9e7moQo784z+st4+2lsI+Eq?=
 =?us-ascii?Q?FiKHf5qT/ruaeimooCGPKjxgYesIcUFH/6HjnwrAnzxetnckjldsUcPqVwBs?=
 =?us-ascii?Q?vYsL5r3cWKhFO6mnOYOnOPwKNGR/zJtDy/pUV/ZPmiDYA5CLSMN5l3pSt4bD?=
 =?us-ascii?Q?cWgqV7/LbUQqwjxcfVy2+dSn+iYOpAzvNsdKC4NPMN++4/JwK/ZRHHr7Zdzq?=
 =?us-ascii?Q?AR1cZ2PVwv9/NJU9cI57AS39djkm66FjRuE9fHUVzy931Cm7ApO90yFAUYJf?=
 =?us-ascii?Q?OpCKJ3GiWAtbq9+OqoduoB4TO2i0GxIu9yRmPb7oMq8NNMGnlA+xkLCVcYBv?=
 =?us-ascii?Q?kZ5sLbiAgg652APAD4AXN58YIR+S+83YYcJ6IbHvLINrjo7UoTamr57GQ1BD?=
 =?us-ascii?Q?I45DKcH66IcHJ6441JOD7ZlZY+QFWPILh+JijX1vRjWQ6lE/EOm8QilkhfHf?=
 =?us-ascii?Q?Ugd52ywbgfGPwqb59QaD1XKJ4CGBxoPR1aMDAKNjlOksxc5b8jIzvi3H4HWl?=
 =?us-ascii?Q?SJhOMl4aA1Zn55jpZDczHnD8FapNb+6fq5JGW1wZ9PDbtSELC0XTNbVDJSxy?=
 =?us-ascii?Q?357omv0nyUb29qgBReUIt9lStSOTx5is6SCXfYMT6FvFcrN+vjy1ceOIMspO?=
 =?us-ascii?Q?AeZkupb4XlYPQ2FXRwn7jCCq937gEj/0mBanN+hlbL1MrkHlhGh+mUNrmq/N?=
 =?us-ascii?Q?SmIOCSpgPZT7saEqC+J/iU11+yjdy5aVNFqcc3lV8bPjxaIuGngkLxuXNU/R?=
 =?us-ascii?Q?mrpOcKPAVhHy+7ENN/9zNW0fTc8dFsS6GN+BiDo5Ni21nqd4eQLkeaZtB7MJ?=
 =?us-ascii?Q?O+tH7JqQ4tQB59jhQpyCUIWgPPO1iL+MkjtWzMs1tKqq/QYAPVtFxIO/7dRZ?=
 =?us-ascii?Q?TxCXoG7EMCqbyOArLUBL7Avs2H1b3d8gcNocnMs/fXRRvFqktjiw2juMaYdM?=
 =?us-ascii?Q?EeoCoRu4nWyYsES6jf4uoYGTuD7GK7OxKQCax1o1aVuRsYFaebeikv3JUxHW?=
 =?us-ascii?Q?SUKUNxk7es7iEZHwXVKf8JiBB4glekVwPpdNQDm5UMvmPYQBwz7ssLfNFECr?=
 =?us-ascii?Q?WLP4yVc2hUkdtNxiQuWbQDwn5UmTb38QECx+LGXVxZvaQp26IRPadXkOgkDc?=
 =?us-ascii?Q?b7qt8U9Xe8o+879puJx/DyjDkQWt0F1YyAt9ufDCIq22D8PMxAkaIoUXg6Yx?=
 =?us-ascii?Q?xgBdfX21LtQQhvwnIle2YRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d5adec-678f-4ff7-2a86-08db9e9f5b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:25:47.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUM3eu7nwxVPSblM7BOXH/6Duj3tBCDYwyvIBkvk81nKWV2NJbPc1DfBa6XNCD+dJiu/HCjEvqsk0xZqUrLi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3483
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
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> Hyper-V tsc page is shared with hypervisor and mark the page
> unencrypted in sev-snp enlightened guest when it's used.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
