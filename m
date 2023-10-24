Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2147D4D76
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 12:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjJXKPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjJXKPp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 06:15:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8EDC;
        Tue, 24 Oct 2023 03:15:42 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O8gMUn025612;
        Tue, 24 Oct 2023 10:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/JO1Ln+FVnF0VUFhTBWQcNS1RfWsJw5IgbeYH4NZnAE=;
 b=iGEpnia1WRIAgAQmXlwtGu29jxF7qX6NTczNSifoRD7Xx4znm9/zOk6295GPebwtdoY3
 Ue64RT2FkUfbga/tI2HWriBx72XFfV+USgWSMm++nlY0C+F9XlJpVQi98glgC5rj5/1e
 1YHWe/ikj8LdNQnIVGyum/C6F2KqJyDag2H6C4zlnHj+IVaetFGcBsc5DPkF3v5rsHDl
 NQZmL09eaF4WYQeHSwyaW4mfXJ2h/42ZknVXNbPn3XRq85oQT2ad2jFFi2+Tk/JCPHbb
 M2Ze/y554Kj9LgdTuuX2GWrdXPBNluIfx9hDjbXP/vLpx9pxNDYoygzA2+erNjsfNfjk Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcw5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 10:15:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OA61b9001631;
        Tue, 24 Oct 2023 10:15:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bk0a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 10:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E22c1+YfQu/hpS+NHEabm7zYNzoHsjGHFWAz3tNNjGZt84GHBFaNMKeGgHlr4afH5u1WSe0BcYBus9m9YUIBiyeCX9Vi8iT94B4vvnVNWKOC2KBrUwZNLxW6X0Hp/HQjwTpuIX4d7EWbhyzL2byxhPbm/vAdnvWdJ2bDhsvCseR+qVAX8uVEdmawEC4nv92CP6E6YR4uhb3IAdeNL8+68Q/59JXPBlxX0pFWxzY2iSXJHsB2alAE1L2N4TbA/aD8vTJoUohGLbv9Bm8UPknqG2jAK4WYFV7bTqhVuSlKcL5fkB3T+/LV/jc8V6NR9A/0hdSjtaSodIN45QM+UnPZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JO1Ln+FVnF0VUFhTBWQcNS1RfWsJw5IgbeYH4NZnAE=;
 b=QL3REQlDNc6H4U8w7NkC0S0lU6xsPYOmyb2rYXbxPorPnbrLX58xaKML3n7hyoh6k09jlY6ikJ96m8XgD+eBh+EQh/6xguj0/KbVJoqbAsic9DcD7K6YvGf4JXC/HWkDsk3gbluM5/i3FbgwFkeU8mo+z/OfovbbmW7zGf6wcJCqaQFBJ0fGUBgjKYRPyAIU93IvZqySfHWLyhM71DHb30djPWxRfQb8rwPCHzg4O5k3ehdUuX+3q0aUc2nQXFGMLNQ6AFM7upFs2O3iLmMcZjYmAQwGPZeJhXfsmO7A8BPUPkLjpS+tstqStHcDzfUdnLlQo5xvZSEbfzlmkyre1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JO1Ln+FVnF0VUFhTBWQcNS1RfWsJw5IgbeYH4NZnAE=;
 b=kxF4tYU1uSDDWORkKCzMZrPIwFTkoBVusuo1wQFoSOsvLSnWz73NUt7S5m7m5rNzSagiNrUxM+vrOaq/bZdsYWR92CMhaySqRzSRLyMVwD4buNLVagBESWL6kF6iAKM9ZOiUYbkmcUZ+jcVyzMnYQevqE10FRe7KpfgmWy8S8uI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SN7PR10MB6362.namprd10.prod.outlook.com (2603:10b6:806:26e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 10:15:07 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 10:15:07 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
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
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Thread-Topic: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Thread-Index: AQHaA4XrE/IZIk/4qEmFw9b0m3YY3LBYvtMA
Date:   Tue, 24 Oct 2023 10:15:07 +0000
Message-ID: <5589E5A5-9F97-416A-9C48-9828B0BE58CD@oracle.com>
References: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SN7PR10MB6362:EE_
x-ms-office365-filtering-correlation-id: 4da43581-23dc-4e37-de6f-08dbd47a18e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjtdBRfk2fJL+IOOe9fJd3NkM90n6xiguQbX3STK9UvaQq8V2AXYJ/CYQeMZHpumBVcfGbt+3S5lEK75LClOj/G6UxJbLocl3DHTaJH54bqqkclHXLFlswaaJ77ffF7FGr3g/OsDkj7ynGqDSkaDWs6hqeQin3WvXb2gK32y/RKWspdCvMXy7/5D0W8t1S5efrF1a7Q2BXI03H0jPV/F5y35vVk17mN0RQ4kOqOtRA5/yBjVgjbPqjLYdYudFkD5pzaxhpR0f+SUZ7afFJQMXp0YTMlWqOa4cIcUAe9TRWyZJOib9GrfCpgczihPMahYep3NQvklXC75j673baBkPryClby3EmjPTOIrqSnI1xwfXtiWcOS0v5UrWO8547mOWYrqVF+CPMgfkIaBpUkFtFrlkP2Xi/AFO70Zaowiyw7pIeXA/+NnexkKK/q/8EQSleP1XsG9se1x16K8F236p3Hyv4lp3D8oMDhrmBYtzPfns9fUZWLIu3T1a8mOYREYK+Egnznxe3pC4ed9cgCjQeK5t/wq7tNv+9VZpwnihGA2JN5HbSvn7tP86rOgPwBDxJYWQi3hVDmTd7DayTj+KhRWLolRH+W7D1QBBfbQY/AfjYjgIyxrGhXj4BkaXn9XxzUPHkgNIm94fTBRgOJnzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(91956017)(86362001)(38070700009)(2616005)(38100700002)(5660300002)(4326008)(7416002)(44832011)(2906002)(6512007)(122000001)(83380400001)(26005)(53546011)(6506007)(8936002)(54906003)(8676002)(36756003)(71200400001)(33656002)(6486002)(64756008)(41300700001)(66446008)(478600001)(66556008)(316002)(66946007)(76116006)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkZxWEk4VnFuSGtmZVpYQjV3MExROFgzU294bisxMjh5VndtRWQ3cFhlaEFR?=
 =?utf-8?B?RUJQM0lCbDljOEdMVUFKV0lGMW5Gc21Nd2RHSmFXSktrNDJLL1ZadHlSQXVY?=
 =?utf-8?B?WVJ6S2tvMWd6WXU5bEppMVR1dVk0OWxUbFJLVVpIRjRYdWdTUzl2cjFxcHBy?=
 =?utf-8?B?bGN1MWhvUkhQY3JDcDVEWnVqcW5CSVRpTWsrQmxpVWUyWlJxVXZPYlZVNkN3?=
 =?utf-8?B?cHpGK3hucXg4R2FISDUxbUd0bDAzRXo0NFZaaU1KS3k3ZkJTcEEwYWUxV3Iv?=
 =?utf-8?B?Q1BOODArbVZqbTFCVzYzRDhwbndhdDJPSnhUSWhKT3F0OXkrOVJVMHFTQnlZ?=
 =?utf-8?B?blVWc3VuanVJS1JjUUVTNlBtWGVJZ3daSGJMY1hzNzN6L0JYVjY0dnBWQUdi?=
 =?utf-8?B?K25CbEdqejZaanM3WENqSTlmb29kZFNXL1ZQakp6NXFDWmhNdmZNQzNtZzZ3?=
 =?utf-8?B?RmpjYWtBejFzQTh3YkVpdDBLaDY3MEM2OU10Y3FxMjhmajFSczRJSjJnLzlF?=
 =?utf-8?B?WWxOTDd4WUYxMU5LTkhLSUk5ay9DQ2tPUUJRVmFCa1VnUnFJN21nMkdlV0RX?=
 =?utf-8?B?RVVuc0phaTNwZEdYdThxdTUyeEt3VERWMmI5N3YzQkRjb3krUWt6d1ZtTFpy?=
 =?utf-8?B?cFpMQzIycnk4MHRZNnJZb2k3ZlZSb1hDZnZHM1BHQlFteWJSZDA3MkE0elRn?=
 =?utf-8?B?Qk1LQXN1YjlpazZKOWkvQ0ZHUm8rdm0rWU5sUWJITmNZNml2TjgyWEZ6UUl0?=
 =?utf-8?B?THZjbEtjcHgvZkhuOFpqYjZXb25Ya201cmVTaWtYZGJGQld2bVpKZk9nS1Yr?=
 =?utf-8?B?Mk4ySEJlMHRtWnFlRVAwRFVNQkJQK2VoMzlhZHBTL1VReXplM0JEVitTVlRC?=
 =?utf-8?B?QzloMDhqQnU0T0h2UnZoV0dpK1lUYUEwZFZhMWtyS090ZzkrR09zK09LOUV4?=
 =?utf-8?B?N09XRFZ3d2VZQWU4c0U0MFhvcm5hODN4UUZ1RlJVTlRBbmtuNnpkODliTG9v?=
 =?utf-8?B?TFpNbGhnbDM5UWcxQy82b0tyZHdKaXRiZjI1U3FzMXR6UDNISjl0VGUvVFVN?=
 =?utf-8?B?eEpaSUlDQ2RPbHBTeGlVNkIxZHA3Rk9lbHA1QklJOVR2SS9ZTVk3NEJyWk54?=
 =?utf-8?B?aTJIT0tFM2xXWlRaVjcwOVR5Mi8veU1aazAvVXhFNFpjTGJIeC9OMTQxOUxZ?=
 =?utf-8?B?UmhiTW5zaHVvOC93UGhkQzVVbVlQZUVSdUtqcHZqczA5T1FyZVVsSURYaUkr?=
 =?utf-8?B?Y0hGckZsQjlYVVl1eGRJWXRaYW9CMmZvdmRaaDFNMURLRFd5MFVBUk5PT09m?=
 =?utf-8?B?UGZodmxIRFdrY3BzaVJZMkQ1ZEIzSmFYK0xmR3ordEE4T0pIZVdKa3hpaFJn?=
 =?utf-8?B?ZlplV2VacjNVSDRpbG5HVS81a1VVeVc3cHo5ckt3a29weGZLbTVBY0xTSDFi?=
 =?utf-8?B?SHlHVU9zUGZJdkt4dG9lQUl0aWdUODlwajIvbjdXWVJpR0hOR2Vwek5lRWk5?=
 =?utf-8?B?U0hETXlaaU5TMXFUTWpzSy83RkZYTEJ4VkxPR0NOK21WWU5rNnhGRlpJN3Ey?=
 =?utf-8?B?dDNxY055S0p0cWxvNUdIcStvSFZLOVBZbGMwc1pFM2Z3OVVHYXFlNzFkNlJy?=
 =?utf-8?B?b0JFNDBLNGIzTzNHeHNLWXBaNThTODZYdlMzb05sNU5UcG1UV1RzMk5jT2w5?=
 =?utf-8?B?QzNNZ2lZQUFKMGNlTGdSeEFXdEF1QkNHSkNodmlnOUFEQ29kRlFBeEtPdkVw?=
 =?utf-8?B?L05Cd3lOYm1PL2JHT1o2OGExOEkrR0MvdVFGbkZVakNhYUZ4TzR0SXpKSDZi?=
 =?utf-8?B?ZkpVa0tJWVJhejRBSG4wM1BKL1JxNHFxVS9uVHVBR2srRVR1LzFWNm1nUFp3?=
 =?utf-8?B?T2FSMkROOEZxK2FpdmtLeGJkZWpOemRUNzNIUjY0UFNJKzZpeENvYTVNUmhG?=
 =?utf-8?B?ZEFvZCtFZUdtcHEvUmhUcVpXMjkvdkZqc0JnVEN1Y2g4UzV6bE9MaUx4YzJ5?=
 =?utf-8?B?NUQwdUNONFAxcVhGYTVSUVdhVjZvVnpicmNsSktqNzlCN05Zci9Pbnd3UFND?=
 =?utf-8?B?cWV5cFgvckZNWnVBZUd1ZHBVb3ZPRkI1RjIxVUNnOFdvTW1xSm5Yc2RFMTF5?=
 =?utf-8?B?NzJTaXpPNVBqQk1BREc1MEcwb056bk1yZWo4N0ZlWkRsbEhRd3ZTZ0Zzdnk5?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0036823A71A3C443A872C1919F1FA23F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkUxOW5vWHVub0MwSTEwTm4wMkl6VE1pUk5aeTVhcFZqeDhHUXhicXFTS2Na?=
 =?utf-8?B?YXVTNGk0Q3Fhdi9taEl4THkxQXNYazMyNjJ5QXJEVVNqOFhZeFhPLzh0Y1Nr?=
 =?utf-8?B?OHI1bjMvWjJNRis3bjlqSGwyVmNWMDJndWNYanZPUEI2MzBxbEJaaFhpckFy?=
 =?utf-8?B?OVp3QVM0dkJ0aldKc3YwMlpaSVpqRm5xUmhmZ3doK3pYU1ZjN3c4RnBjZC91?=
 =?utf-8?B?dDQ2KzI3c2N3TC96bnF5ZVkzQU9uSVgyUXlNeHMya2RqNGFDZkdOZHN0Q1JC?=
 =?utf-8?B?Q3Z0UU5rWm4wYkFFUHlqdkZYN0toaERxK24xZVZMejMxc2xRdmdKa2xCaGJs?=
 =?utf-8?B?b1lsQ2haZ1BzZE11VFlWODJDRWVqZ1NGS0NEcW1YeHp0eE12Zkh1Sk5DSFRK?=
 =?utf-8?B?RjJaYkFUNEhWUGFaU2ZMUEVxUTVTT0ZpTm5zekJDY2xqanJzTVdJZlpTcFlw?=
 =?utf-8?B?aW1FWENRS2poK1FxU2tqQWU0SHNrajdxYlNUZGJncHgrMVBpb3pJTUNackVj?=
 =?utf-8?B?QitnMUlNMittS0tjdVpzNmVmTm5Hd2ZZckc1NFBycVJQT1o1RWRlZjk3d1dy?=
 =?utf-8?B?OVV1aTFiNzNMamJzOW5WRFZPK3o5TmkyYW9LdXZOZndZZnpPcldaazV6T01U?=
 =?utf-8?B?UTgvQjcvcUdiVkt0b1dIVnRXaHFnWUFzQmppOURYQVVvM0dRMTJxdGM2dXA3?=
 =?utf-8?B?TDV6M1lhNDUrNG56Wk1UenpoV3hyYnQ4bTQ3b3A1U2I3SWtPUVZRZGJyWkFV?=
 =?utf-8?B?RzVZRU5KaWwxKythTGxhTzJGMUFhaDEvbmdpYWllYTdmRUZ2Mit6dStSRyts?=
 =?utf-8?B?Ykd1b0dYQS9HTjZZWFQ5QzdOeC9nWFJKdTJNSG12TFgveWM4Ykd6SzZxelR3?=
 =?utf-8?B?OU5GNjhCZFhkRlVzUjhJQ0c2QTJpcUlWUTZHZjlqTHIrL29GSG81RlFlNGlk?=
 =?utf-8?B?aUl0SG9uYUpwMUJ6U3Y2aXpZVFRJdExIRnBDSWFmcUxBUXFNdUVSM3N2ZVl2?=
 =?utf-8?B?NDBsSm9lUm1lYlVtWnRoemZGaFB1eVhRTHBlcUpSOGgzd0NuYzBmUXFZcEVR?=
 =?utf-8?B?THJwMjRJLzVLT0lxSE9xbWdaMHZCT1VFbVVtQllHY2d3R2N5bDZERnA0WU0x?=
 =?utf-8?B?WjhtVGc1dWh3RHlkaUFsbW93WmM3VzdMak4yY3J3LzBwVnUrY2pFKzd4Y1lJ?=
 =?utf-8?B?YjZpNmhyYkVncnV2YzZjVEpwV0NrZk5xVFZieXZNdXY3S0FzTHZXSkFUZUZa?=
 =?utf-8?B?T3dXRGFTZFdNeXYwU2VVTzJhUld5YlJEUkp5QWoxM3lXNVo3aXZiV3BwWlMx?=
 =?utf-8?B?ZFhkRmpESTJ0TmtFK2lXS3Y0N3N4ZVFpMUdkbDA5aVVBZEorbXRPbHhTd0Qz?=
 =?utf-8?B?WVJ3R0lZQ2JyYXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da43581-23dc-4e37-de6f-08dbd47a18e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:15:07.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNqP0MlPrAWO+rzIPziNR5tC8PhLDoRejfy+sZZ/Eip68U3S20cI84T7L5FRopbxb8QYGhdUxWaW7FSUZFN3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_09,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240086
X-Proofpoint-GUID: S4nn2rnrbUgA4PaVZZWN2QD94bfgpEey
X-Proofpoint-ORIG-GUID: S4nn2rnrbUgA4PaVZZWN2QD94bfgpEey
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KPiBPbiAyMCBPY3QgMjAyMywgYXQgMTg6NDcsIFJ1c3NlbGwgS2luZyA8
cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+IHdyb3RlOg0KPiANCj4gRnJvbTogSmFtZXMgTW9y
c2UgPGphbWVzLm1vcnNlQGFybS5jb20+DQo+IA0KPiBhY3BpX3NjYW5fZGV2aWNlX25vdF9wcmVz
ZW50KCkgaXMgY2FsbGVkIHdoZW4gYSBkZXZpY2UgaW4gdGhlDQo+IGhpZXJhcmNoeSBpcyBub3Qg
YXZhaWxhYmxlIGZvciBlbnVtZXJhdGlvbi4gSGlzdG9yaWNhbGx5IGVudW1lcmF0aW9uDQo+IHdh
cyBvbmx5IGJhc2VkIG9uIHdoZXRoZXIgdGhlIGRldmljZSB3YXMgcHJlc2VudC4NCj4gDQo+IFRv
IGFkZCBzdXBwb3J0IGZvciBvbmx5IGVudW1lcmF0aW5nIGRldmljZXMgdGhhdCBhcmUgYm90aCBw
cmVzZW50DQo+IGFuZCBlbmFibGVkLCB0aGlzIGhlbHBlciBzaG91bGQgYmUgcmVuYW1lZC4gSXQg
d2FzIG9ubHkgZXZlciBhYm91dA0KPiBlbnVtZXJhdGlvbiwgcmVuYW1lIGl0IGFjcGlfc2Nhbl9k
ZXZpY2Vfbm90X2VudW1lcmF0ZWQoKS4NCj4gDQo+IE5vIGNoYW5nZSBpbiBiZWhhdmlvdXIgaXMg
aW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VA
YXJtLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1saW51
eC5vcmcudWs+DQoNCkZpeGVzOiA0NDNmYzgyMDIyNzIgKCJBQ1BJIC8gaG90cGx1ZzogUmV3b3Jr
IGdlbmVyaWMgY29kZSB0byBoYW5kbGUgc3VwcmlzZSByZW1vdmFsc+KAnSkgPw0KDQo+IC0tLQ0K
PiBUaGlzIGlzIGFub3RoZXIgcGF0Y2ggZnJvbSBKYW1lcycgYWFyY2g2NCBob3RwbHVnIHZjcHUg
c2VyaWVzLg0KPiANCj4gSSBhc2tlZDoNCj4+IElzIHRoaXMgYW5vdGhlciBwYXRjaCB3aGljaCBv
dWdodCB0byBiZSBzdWJtaXR0ZWQgd2l0aG91dCB3YWl0aW5nDQo+PiBmb3IgdGhlIHJlc3Qgb2Yg
dGhlIHNlcmllcz8NCj4gdG8gd2hpY2ggSm9uYXRoYW4gQ2FtZXJvbiByZXBsaWVkOg0KPj4gTG9v
a3MgbGlrZSBhIHZhbGlkIHN0YW5kYWxvbmUgY2hhbmdlIHRvIG1lLg0KPiANCj4gU28gbGV0J3Mg
Z2V0IHRoaXMgcXVldWVkIHVwLg0KPiANCj4gZHJpdmVycy9hY3BpL3NjYW4uYyB8IDggKysrKy0t
LS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvc2Nhbi5jIGIvZHJpdmVycy9hY3BpL3NjYW4u
Yw0KPiBpbmRleCBlZDAxZTE5NTE0ZWYuLjE3YWI4NzVhN2Q0ZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9hY3BpL3NjYW4uYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvc2Nhbi5jDQo+IEBAIC0yODks
MTAgKzI4OSwxMCBAQCBzdGF0aWMgaW50IGFjcGlfc2Nhbl9ob3RfcmVtb3ZlKHN0cnVjdCBhY3Bp
X2RldmljZSAqZGV2aWNlKQ0KPiByZXR1cm4gMDsNCj4gfQ0KPiANCj4gLXN0YXRpYyBpbnQgYWNw
aV9zY2FuX2RldmljZV9ub3RfcHJlc2VudChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXYpDQo+ICtz
dGF0aWMgaW50IGFjcGlfc2Nhbl9kZXZpY2Vfbm90X2VudW1lcmF0ZWQoc3RydWN0IGFjcGlfZGV2
aWNlICphZGV2KQ0KPiB7DQo+IGlmICghYWNwaV9kZXZpY2VfZW51bWVyYXRlZChhZGV2KSkgew0K
PiAtIGRldl93YXJuKCZhZGV2LT5kZXYsICJTdGlsbCBub3QgcHJlc2VudFxuIik7DQo+ICsgZGV2
X3dhcm4oJmFkZXYtPmRldiwgIlN0aWxsIG5vdCBlbnVtZXJhdGVkXG4iKTsNCj4gcmV0dXJuIC1F
QUxSRUFEWTsNCj4gfQ0KPiBhY3BpX2J1c190cmltKGFkZXYpOw0KPiBAQCAtMzI3LDcgKzMyNyw3
IEBAIHN0YXRpYyBpbnQgYWNwaV9zY2FuX2RldmljZV9jaGVjayhzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmFkZXYpDQo+IGVycm9yID0gLUVOT0RFVjsNCj4gfQ0KPiB9IGVsc2Ugew0KPiAtIGVycm9yID0g
YWNwaV9zY2FuX2RldmljZV9ub3RfcHJlc2VudChhZGV2KTsNCj4gKyBlcnJvciA9IGFjcGlfc2Nh
bl9kZXZpY2Vfbm90X2VudW1lcmF0ZWQoYWRldik7DQo+IH0NCj4gcmV0dXJuIGVycm9yOw0KPiB9
DQo+IEBAIC0zMzksNyArMzM5LDcgQEAgc3RhdGljIGludCBhY3BpX3NjYW5fYnVzX2NoZWNrKHN0
cnVjdCBhY3BpX2RldmljZSAqYWRldiwgdm9pZCAqbm90X3VzZWQpDQo+IA0KPiBhY3BpX2J1c19n
ZXRfc3RhdHVzKGFkZXYpOw0KPiBpZiAoIWFjcGlfZGV2aWNlX2lzX3ByZXNlbnQoYWRldikpIHsN
Cj4gLSBhY3BpX3NjYW5fZGV2aWNlX25vdF9wcmVzZW50KGFkZXYpOw0KPiArIGFjcGlfc2Nhbl9k
ZXZpY2Vfbm90X2VudW1lcmF0ZWQoYWRldik7DQoNCkZlZWwgZnJlZSB0byBhZGQNCg0KUmV2aWV3
ZWQtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUuY29tPg0KDQpUaGFuayB5b3UN
Cg0KTWlndWVsDQoNCj4gcmV0dXJuIDA7DQo+IH0NCj4gaWYgKGhhbmRsZXIgJiYgaGFuZGxlci0+
aG90cGx1Zy5zY2FuX2RlcGVuZGVudCkNCj4gLS0gDQo+IDIuMzAuMg0KPiANCj4gDQoNCg==
