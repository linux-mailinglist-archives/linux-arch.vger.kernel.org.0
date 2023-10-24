Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6298C7D4F07
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJXLja (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjJXLj3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 07:39:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C4AC;
        Tue, 24 Oct 2023 04:39:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O7JxMk031526;
        Tue, 24 Oct 2023 11:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yAU6WPEXqqjm4WdYmImTfqb3RgTdvBnhBqt70wrmvIc=;
 b=p6XD/5ZUfbizbABbgyLrk3BWbd/HUAVpI5YlNnoKTbWi573o271zHzUPMIsmBweu9quC
 h/aGqioP79afpJype3TrILkaHAWW6ye1IfAIgVNiR2OE1a1c9udJQvCM2kPFUYYlv9oj
 jbPpKNE3wW0dgpioRaCHj9Mpq0cmjXMyZQjHosolw6caZo7UgAOQl1n8piJByUxgIdhc
 CUMHoIe2NoqhSoBYt4HnwiKWAUI8mB0agotJzNI5LQSDKBFEKfR098WmXt4zTLdt2470
 OjVKEnX+T1Q6xw8KohdGnwlcmNo8cTVtY09swLG6rYaFu7neqP+eHEH7O/oe5y18i0A0 Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbd9qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:38:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9umO3015094;
        Tue, 24 Oct 2023 11:38:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5355kqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzzkb0zydgsYBA+4Xoz+PoIavO6ku78Qc3iPkFbsE1Sl2BX/GTgwndME40dckV4DUtcJ4LfUClZhdP/Fs8v7zypS9Q46QRWjTXrhLfw9ABxaiobyfqIkwUt/6Jxf1g9Fhd4qFBOEPjmq/MNzofnuQ0HR7HmWPuF5z8f8CtANYFRdFYy8Z/VY4Z7dP3aTCjQtNbXd2VcbTl784btw5vcOqDIj/4B5bBIQHhePLLtkFDDupLT2wGUcZzPWrARJ+A7mME4sYpZMQBVm4ponkbOLZAUOpCHqUOSvUZgbT3qxCe/hq7T6frcB7SPmd/gf5NbZe+tg5oU/xTBWGsafIOmd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAU6WPEXqqjm4WdYmImTfqb3RgTdvBnhBqt70wrmvIc=;
 b=DRn7lgaElvpgHjimnGqtGdryh19dB9e87dtVs96rCtnupv030ZsDZ83vb++TeFI+eEdeLnb9RMi3WNAehYf0oHzGYimHw6k6x4SHNCZv8rGODBfJkTqqpvZWnsEJ/p1sqJsVEX6oz0+0lglm3Dd56UYYv4JWCuPSgOCJ6YBDflfWWn6RCBg+Aj9/c7tSggjqfMdjlqGZS2DGch82F1Iz8QtDTUrTkWrQMJpWI+87gwPsvFt1d95jXERzYxSQHA+7mUICYp3TgirRZ4vMcqWzKOBElhxyDo8l9iomLzGt8EGkN6Q910JKiril+IGVbWUoNwOQk40tns3YBB0VBMA4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAU6WPEXqqjm4WdYmImTfqb3RgTdvBnhBqt70wrmvIc=;
 b=n7Jw8ZCMS5hK/EGT9sAHehVhfn8KT1ayMtt20vztWEgrEAsBU2TG4Y5z5siwVY9+OwvrFJw7cEnAzAbXoTYvSxmRWNwHHGpvGvIIQEBtxHYnWJkxEg6+2eDDtrwdrzHpPwSrxN6fuHMfHQGk1MK42Aqq9hUx+5F4vsEXatfaDdg=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 11:38:39 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 11:38:39 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Thread-Topic: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Thread-Index: AQHaA4XrE/IZIk/4qEmFw9b0m3YY3LBYvtMAgAAUroCAAAKpAA==
Date:   Tue, 24 Oct 2023 11:38:39 +0000
Message-ID: <E2E02CC9-83E6-42A6-8450-000539930EDD@oracle.com>
References: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
 <5589E5A5-9F97-416A-9C48-9828B0BE58CD@oracle.com>
 <ZTeqeRRbJgEdbMV3@shell.armlinux.org.uk>
In-Reply-To: <ZTeqeRRbJgEdbMV3@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH0PR10MB6984:EE_
x-ms-office365-filtering-correlation-id: 5682f942-1ffd-4cff-88f4-08dbd485c456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzbVkzWCEqANZm4V6gADfAIEMWOFGbi9DnYYqIydmn9KMB137/gjqUg3041wUdCvDvkcoiAvFAOi6JkKIPeLk2bX41Qm5hagx0A0SQpjhPkRe42sMXQbGxzdZhhuOdvKybuyRzevAgS1Yjb7T5STBilXK62V8AP9Jg+LRDyb+6r0lQz09gO/JR1LShfT1BPZGX/z/nH6/Us5Njt/SbiKc2LB5c5x1PuOI2/qfolo7du2IMYkebQXR0QD28DmUmhmBlQm4zOoGTN5BE1etkcI7VSjs2ACeGSrZMafAww8hqDyt09qSWrPEpVAYADFt7/nqNcVIrkr0UCyv/+ybTdqwC+RjetxbqtUjK6PhaDmPRzZm50G1N37hle/uOfOSIvkfGDwXgcfac23qRUM3IJuvEDrL/pl4YLmcXJXk1tSqKIJ+fQCdy6zasDatzeQRSNIM/5WmruPRuCqxnQIjGYmurwOagwSIPukHAshS68pWpSXt49CYLMWhWklgIvlUZksS1vpDF/IyjU9CmAygwakqswSJqlJ0uEb603fCzjG495zKaSghcedWeig0fKcidES0YWK61DK/iQHD544O2lR9KTgItLfcRG6otoArPj2bEShSnYhWLblB1rLqoXCSw82
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(2906002)(38100700002)(66476007)(54906003)(64756008)(66446008)(122000001)(66946007)(316002)(66556008)(76116006)(6916009)(2616005)(478600001)(71200400001)(6506007)(6486002)(53546011)(966005)(6512007)(44832011)(91956017)(86362001)(7416002)(36756003)(5660300002)(33656002)(8676002)(4326008)(8936002)(38070700009)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFHVS9vdkZBS252VG5ocU1oMVBHRTJ0YnZhSkR5a1k2c0ZDdzMzYlBwTXFy?=
 =?utf-8?B?c1R2cEpEQmRRNWxmUDRRbVp2NTlTMjQwQTJJa2dDejA2aDhKVHE3V2RrY2Nz?=
 =?utf-8?B?WE9ybVF5dnZBc0w4akJXMC9yUmNJS3RRazlWTHI0MHZHSDN5OWdiWEY0QkQr?=
 =?utf-8?B?eXdNQmdWODV0UlpreDltWTFsbUFPeWsyNWJPQ1J6cUQzTmZPWE9OQ3NzQ0dX?=
 =?utf-8?B?djBqTWtBZlpxTXpBQWpycktsMEhRZS9hbzVnV29DaFRteks3Q3BQTXViMUtZ?=
 =?utf-8?B?T3poUFdnN2NyNFMrVjVPQmlNcDdlM0VONUZFa0FTcmIxcFlVRjdBUkdwRlhY?=
 =?utf-8?B?cWV5VGcya1NESk9leWV4Nytha3RsVkNNSjVtTmx1YTJySE9vL2NJUm1qOE83?=
 =?utf-8?B?RXQ2SzVQWHpHR2JVZXdKZzl3UXFNaTFkWmZGaVNzMnpFNFUzdlVVb0xBNWxz?=
 =?utf-8?B?VkVoYjNEY2xTbHlYZThvV2hQMkF1NGNrVytqYlNIbmpVemZzUktyL2dtN0F5?=
 =?utf-8?B?M0V2SGQ4S1hBVy90eGg1a0lZdDJjYXlaU2NZbnNWQjdSNVdsUTZyc1BDc1A5?=
 =?utf-8?B?WFZMbHFNeEZaelRkUjgrTHBEanZ1emh0NDdNWFEzaEQrZEhKV00yVG5KY2Jw?=
 =?utf-8?B?VGRPV0hNTGc2UlpSQXYvQ29aZ1llVnBaNStyNk10ZEFUc1Frd0NQSkVCZlFj?=
 =?utf-8?B?V3lnNkx2QnU3b1ZoMEVjekYwb2pjWENtSUtUekMxUXkwWG9NN1BrYU10bzBp?=
 =?utf-8?B?U1I5STcyc1RVWU42azVOTUVZZWM0YnMrRGZpSlVYQ09xZ3M1Z0ZFRkM4TU9i?=
 =?utf-8?B?WHpZM2dvQVdqYW43Y202UDc2VGRXYmxSMzQ5MGk1aVhESko4SllYT1IrU2sv?=
 =?utf-8?B?UWVyY2NpUHJkYldydE15REZDemhUZ2FVcnFabnB0YmNlYnhuUHp3T3l1ZTFv?=
 =?utf-8?B?cGVoVWZpYS8relNYQTB5YWp5OEF2Z0ZKZ0tQVGd1QW1GM3ZSUTNVM2h4L0xa?=
 =?utf-8?B?R1YrbFNLYlVmWlVUSXYyalI1MWpvV2xqSDBBMWpycFY1V2UxWkZ1bm15QVBx?=
 =?utf-8?B?cjM3TktoL3pxeVY0UnhoWm1FTytmeUdiNk1WVmJyNDlFM1pNY0pQZktFOE9w?=
 =?utf-8?B?RkZCMHBpaHlXVkh3L2RaV0ZSaUM4eDAyaTdGYVNjUWdac1daOUpydWFvN3RB?=
 =?utf-8?B?L1VQTmN0SnJKY2hOMFpNVmREY1psTTBFVENPZUxFazdZa00wZXlQT3VhZEM4?=
 =?utf-8?B?bFphR2liaUw5UlJxVkEvY3JlOSticG1iSnNqaGx6STNVdStwdzgxdUZVTjR0?=
 =?utf-8?B?Q1d0ODhqSTZQcjZBdDJLbzJFT0JGcjVKZTZFRjhldnkvRW1mVDJFOFYyTEVt?=
 =?utf-8?B?a2h1TDBXZ3J2dy80dmlVWFAvRy9VNkoxcTFaRmZveHdXM1FCZXFrNGRsR2lX?=
 =?utf-8?B?VlgzSDgvOVNsRDNSUSsxa2h4WXN2UjN0VEMvVmJkYXVRbG5UNU5HM3ljY0pF?=
 =?utf-8?B?ellLanZNQmlDaEdSMDZqTkxyVldmL2htL1VPYVBTcVNic3RHZGFXS05MQXgy?=
 =?utf-8?B?cmR6QzVrVVZXVkE0ZTJ5Z1lMbS9vZ21PY2c0UVZJRk1tUWg2TnFJbWsvL3BR?=
 =?utf-8?B?Zjg4Z01KMENkWkxuSElTSU1LOEYyVnJVWkk0ZEpSMjFBYVB0NkV0UnRPL0xF?=
 =?utf-8?B?YXhhdGhraFN6QWY1Y010amZ5b2hYTDhsZHVQVWVTZ3VjUTR2Y0o4ZGlpOXIw?=
 =?utf-8?B?elB1Z2ZUQ0l0TTdWUExMcitramZDQ0xsbjMzaTd6b21wRFQ2azN2azdXREU2?=
 =?utf-8?B?UzZPZ2FjUVRzS2ZQUCsyTlp6cXl5NlhiandoS2IzRjBwWllMelRoTmUxMnJJ?=
 =?utf-8?B?SE9hWTJ4WXpodm9SRS9zTlZLMy9iNkdLdzByYTNzY3FPcFMvOFJ4UHRsZUgz?=
 =?utf-8?B?K01pWWtTQXlTMk9PQ0ROcitGeWN1aURXOGF1YkJxUzVJcHBKUWsyRlh0SVcz?=
 =?utf-8?B?WVh1bnRTSXZ4WkdmVVFxMEozZ3F1VXNtWG5wZXBoT2UyOVlUTnJHM1lTZ2F5?=
 =?utf-8?B?VHQ3cUVSZG1nclF5dm5HTXlPOE53SHE3dXNuTmFFZnEvOHVxK2t4OFNKV0kr?=
 =?utf-8?B?aFVLMFVUQUtuMWFGTUJrcVVFbTVHQmluTjJHQ2FSSTFuNFZsKzl3NmlqMVE4?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E587084CFE69D47BCD75793A759C85F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dzJMOUZkdTE4U1BwZzBvcTlTNGYydkQ4Y3U4S2lZSDYzeFRWclhrSU1vZ3BS?=
 =?utf-8?B?T1VnaFNjOGQ3UEhKR1FPVWpFbDlNQ3F4U2RudnRaQjFRSXNTY3FCbkU1MjV5?=
 =?utf-8?B?aG9zQ1hpYWtyTytRcE53UGlLMG1aQ2NPcHRCYWlrVllCdmtYSGpydTlqTGRw?=
 =?utf-8?B?N2o0bUxrUWpNdTBDNDRpWHl1eE96QU9nNzVhdWpsN0w2SndwZEE3NUIwVWUv?=
 =?utf-8?B?QkVvcVd2N2Yva0h2SjlRQjlpbnN4anlYa21hYUZqeEttQkRCUExIekZOb05C?=
 =?utf-8?B?ZGRSUTU4K0FRQUVhSlhSRk9FZHMySTdvZ1lsb0Y2KzYzTURXNDN0ZW90aUxW?=
 =?utf-8?B?SnFXNlpqR2pxcWw0OTRTSCtaNmkxTFBYYU1RbFlQU2xaL2V5NUNGTDBubFBF?=
 =?utf-8?B?VEFMd2J1NzZHRWs5T3NGeEVnVi9saUN4TWpPWSt0V1VQRzk4TDR0blkzNnhW?=
 =?utf-8?B?dWxSNlFVY0xibVZ5aG5Gc0kvZ3RITlBvQ1JzOUxnaC94ZDBtTTZzbUFVSHlT?=
 =?utf-8?B?ZS91U25YZVpUajUzRHIwZEsrc1RxUjdyaFVRMTQzakhjcnF3U3R6ckpLOUxt?=
 =?utf-8?B?ditxQXBpRzRCblM2UnJDWTJ4SWNrWWgwYlFTeG94RE01cXZQYVVXeStWQXNW?=
 =?utf-8?B?cmswQUQxUkN5Z1pwaVdhYUd5REZKTzA1b2JYa0ErdmNOb2xSbUdCb2t1c1lE?=
 =?utf-8?B?aVRJMm5UaktYdVROeCtZSURVcmtRc3c2bElnbmd0SkVoVHo1cXowNTBmWDZq?=
 =?utf-8?B?RlE2elZSK2tYVVl2d05JUkswcHcvdytKOWEyakZiR0RWM2ZDR0d6SmdIM0tC?=
 =?utf-8?B?Y1BrMk80cHhQVHVJdTJZakYwNVFBdUdpeHFoa2hSMktyOXVaM0x4VHB1MWw1?=
 =?utf-8?B?VU1VeHZiV1dHdlk2Y2RjYzZpeG9kRDBsRHBQL2JVMU1xNC9hSzBNTkRjcW5N?=
 =?utf-8?B?dmVkWkNSN1VtbzVXdG9OVGE3M3hCeWR4US9JWXFVMHUwZm9zYk1nOXZwdGJK?=
 =?utf-8?B?b2R6M2JKazl2OHpWUHpTV3FZandrdmlPcUtDUkpFRHllaER2cysvZGNGeUxC?=
 =?utf-8?B?bjNpUlVHa3lkaWl1K3FiWWwySFZqT2JrcmxPcThxN0NlcFZ4Qmp5clptM2tz?=
 =?utf-8?B?NGVyYjNqZ1V1bEVZdjg2cFp1OG9FUW52VGJHbkxwcUV0U0dZSDBWZzNwejhw?=
 =?utf-8?B?SWp2Nm1kSDRUakszVnh6aTh5eHpxZVg3dmdqR0NTMXFEeVM4VUJHMWZ6bGts?=
 =?utf-8?B?bzFjM0dXTFY5YUs4TS9EQW5uQTNjelNYMURLT2hRbmZqcGpEOFZlWVcvYUFh?=
 =?utf-8?B?YUJ6bHRJM3hHUVk5eG5aL2VLY0Y1OXBXZlRZK0lkS1pkSTAxZVRmTE9USlU2?=
 =?utf-8?B?WVpyZnBORUhjb2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5682f942-1ffd-4cff-88f4-08dbd485c456
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 11:38:39.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wgBq8hXqXuJrVObYCzftURBt3gXqmUjy8lkn9X7j2XJ/AeO/ymYvjO03omOTD17xAuuOCu/f0i3+lyigJryhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=958
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240098
X-Proofpoint-GUID: df1Kz_C9Z-Tqy4h7LLz-PUW1IfStV9s0
X-Proofpoint-ORIG-GUID: df1Kz_C9Z-Tqy4h7LLz-PUW1IfStV9s0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KPiBPbiAyNCBPY3QgMjAyMywgYXQgMTE6MjgsIFJ1c3NlbGwgS2luZyAo
T3JhY2xlKSA8bGludXhAYXJtbGludXgub3JnLnVrPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0
IDI0LCAyMDIzIGF0IDEwOjE1OjA3QU0gKzAwMDAsIE1pZ3VlbCBMdWlzIHdyb3RlOg0KPj4gSGkg
UnVzc2VsbCwNCj4+IA0KPj4+IE9uIDIwIE9jdCAyMDIzLCBhdCAxODo0NywgUnVzc2VsbCBLaW5n
IDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4gd3JvdGU6DQo+Pj4gDQo+Pj4gRnJvbTogSmFt
ZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+DQo+Pj4gDQo+Pj4gYWNwaV9zY2FuX2Rldmlj
ZV9ub3RfcHJlc2VudCgpIGlzIGNhbGxlZCB3aGVuIGEgZGV2aWNlIGluIHRoZQ0KPj4+IGhpZXJh
cmNoeSBpcyBub3QgYXZhaWxhYmxlIGZvciBlbnVtZXJhdGlvbi4gSGlzdG9yaWNhbGx5IGVudW1l
cmF0aW9uDQo+Pj4gd2FzIG9ubHkgYmFzZWQgb24gd2hldGhlciB0aGUgZGV2aWNlIHdhcyBwcmVz
ZW50Lg0KPj4+IA0KPj4+IFRvIGFkZCBzdXBwb3J0IGZvciBvbmx5IGVudW1lcmF0aW5nIGRldmlj
ZXMgdGhhdCBhcmUgYm90aCBwcmVzZW50DQo+Pj4gYW5kIGVuYWJsZWQsIHRoaXMgaGVscGVyIHNo
b3VsZCBiZSByZW5hbWVkLiBJdCB3YXMgb25seSBldmVyIGFib3V0DQo+Pj4gZW51bWVyYXRpb24s
IHJlbmFtZSBpdCBhY3BpX3NjYW5fZGV2aWNlX25vdF9lbnVtZXJhdGVkKCkuDQo+Pj4gDQo+Pj4g
Tm8gY2hhbmdlIGluIGJlaGF2aW91ciBpcyBpbnRlbmRlZC4NCj4+PiANCj4+PiBTaWduZWQtb2Zm
LWJ5OiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4+PiBSZXZpZXdlZC1ieTog
R2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxs
IEtpbmcgKE9yYWNsZSkgPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPg0KPj4gDQo+PiBGaXhl
czogNDQzZmM4MjAyMjcyICgiQUNQSSAvIGhvdHBsdWc6IFJld29yayBnZW5lcmljIGNvZGUgdG8g
aGFuZGxlIHN1cHJpc2UgcmVtb3ZhbHPigJ0pID8NCj4gDQo+IEknbSBub3Qgc3VyZSBhIHBhdGNo
IHRoYXQgaXMgbWVyZWx5IHJlbmFtaW5nIGEgZnVuY3Rpb24gc2hvdWxkIGV2ZXINCj4gaGF2ZSBh
IEZpeGVzIHRhZywgc2luY2UgaXQncyBqdXN0IGEgbmFtaW5nIGlzc3VlLCBpdCBkb2Vzbid0IGZp
eCBhDQo+IGJ1ZywgY2hhbmdlIGZ1bmN0aW9uYWxpdHkgb3IgYW55dGhpbmcgbGlrZSB0aGF0Lg0K
PiANCj4gSSB3b3VsZCBzdWdnZXN0IHRoYXQgdGhlcmUgd291bGQgbmVlZCB0byBiZSBnb29kIHJl
YXNvbiB3aHkgc3VjaCBhDQo+IHBhdGNoIHNob3VsZCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZSBr
ZXJuZWxzIC0gZm9yIGV4YW1wbGUsIHNvbWV0aGluZw0KPiBlbHNlIHRoYXQgZG9lcyBmaXggYSB1
c2VyIHZpc2libGUgYnVnIHJlcXVpcmVzIHRoaXMgY2hhbmdlLg0KPiANCg0KVW5kZXJzdG9vZC4g
VGhhbmtzIGZvciBjbGFyaWZ5aW5nIQ0KDQpNaWd1ZWwNCg0KPiBUaGFua3MuDQo+IA0KPiAtLSAN
Cj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxv
cGVyL3BhdGNoZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNl
bnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQoNCg0K
