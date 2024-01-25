Return-Path: <linux-arch+bounces-1582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87183C42D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E366128C7D3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6F6025A;
	Thu, 25 Jan 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TmFTntqB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oXSStfP9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C3B5FEE5;
	Thu, 25 Jan 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191015; cv=fail; b=ABvjt0FdKQZ2aeLigrJf15b1trVe6xlMKLJx3cdJZDUOByDVlRvPqnD6WVoxtRDpI4xy9q4z7y1dzeUuKyiapdvIoanPDZi76k3tD+Fn8aCp0cWw1Oh8IhMKKjCjBKuJnCZDacyNpbjIb529o14E544E+4/ChCipwsuzXMpJv6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191015; c=relaxed/simple;
	bh=k1oE6nD1+MW4lvKgNt+OHIjptCwFbp+RR7rTQUVc+Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwA4rNWbdpiEHkxwDV2lI+bjxSN+iL+tzTG6wRJ7sBBquJCHDUOqId2g9rD3VnrLyMyNBy/UUql4Quo78Ows+tucFz1amZVkahgtICjEiVdNx8ESE2cyVy97p2wkpxgcbEIGoLKHDRXY1xooMkBmXomP4Vv5dkkvChG+Q9jn30k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TmFTntqB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oXSStfP9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9xgcP000883;
	Thu, 25 Jan 2024 13:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=k1oE6nD1+MW4lvKgNt+OHIjptCwFbp+RR7rTQUVc+Lc=;
 b=TmFTntqBE7rSVnqJHMflQRDNFJPi4gvyymFycR//wIjrp1+7Ebre5Tw9RVL/RVQdAcMd
 92PSMpx73Nh+qzWpOefOz3Zv1jra1MVXKmIaUfGB+M3cke4OTnk5tL6TE+H41+DvZyd1
 KxkxA++9EPaNHTUW6X8XDUx0xxOsYB792mZeZgaHvSoUZ/HzD14ahDaLgOdYqcwvZ0PC
 gQ+jcimbhJffMT/m69I6aV1M+IDvFP1wm33dnztoo6ZKKs9hb8OWXJXMeKJKwgXz1xAA
 FaY4FbzIFJzx8e6LjqeHerbJDU8fPVOGXObJiZ6idhaYTYHfiFCCuzUGoO5AGqHp8alc DQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7any1wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 13:56:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PDMIMP003912;
	Thu, 25 Jan 2024 13:56:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32ufkgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 13:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/eviHqD0K6cXp1SR36ctoebs62GUPuYXa6v1N3Lg0NHNuJzk68Jd8HvkaiuYrGwi9+9xsa5e5P/BVuZGo77mXCOZhTv5E3wAikXELf0NOeRgKMNFQWekcZvwFG4d3D9yburRNQeZe2FQ+exPrtpZeBENXhv6qgg3/EcBEL+mtAY0fEmVydU7vVUH2T540ol6yQ95+RoqybVc4/+tfaWqzRG3g7SNTSevzpZU2oY8hZb6L1sf0e0qVGlHI5EORNBA5QL2/+VsK72u9OLmGpSTnTC2z9S2rhkA7AAI3rDxsaz38SwsyOBVhttvoHSKQx2IucJrjLpS5kwoeJnk7HGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1oE6nD1+MW4lvKgNt+OHIjptCwFbp+RR7rTQUVc+Lc=;
 b=EDsdS2R4PsUTSp7A8XiQaNw95qo5sVCn+T9xAgSLmY8Ess4HFKxKgL9Ajn5o8xHxnwEMxGo/HOWKIzZsELgqRUgwKPV77DO3TVJ9hGQL+1baAuLXysKfEbdNHaZ7Q5HerXTxAOyiIbF/KdPB47i7D0f9xWbX1UMsbQL22owBt2oFlBvrMrb9rQ3WubyJQnRPKtwlpQUqrpnYea/c1cDU2L+qm9rWKl/9uPREyoyxrqirusojcBS/Th7rI/+LQRjud+HXLObWePqKuDn1wtptv65kFVra3jvslpElJ1u8CGVCMbQQnaS0/MIHLUR6NNduU16EQdDm/l7AW/lBb2+XAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1oE6nD1+MW4lvKgNt+OHIjptCwFbp+RR7rTQUVc+Lc=;
 b=oXSStfP9le1pD0VulQMaU8kUeP9V+DdgzHggPdP5datjjUXt+WED1f6zXiJ/XKE95wTKy5Pz/Ys0ZdPejqPSIIuMvkgfMppJ1B9UhoIO6axhncuYZFpDXyYFbGJKnjEY6nigKM/sx6FJMIqBgwUesmh1SpMNMnpnCUqRscEzCFY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH3PR10MB7764.namprd10.prod.outlook.com (2603:10b6:610:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 13:56:22 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 13:56:22 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "acpica-devel@lists.linuxfoundation.org"
	<acpica-devel@lists.linuxfoundation.org>,
        "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org"
	<linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        James Morse
	<james.morse@arm.com>,
        "vishnu@os.amperecomputing.com"
	<vishnu@os.amperecomputing.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Thread-Topic: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Thread-Index: 
 AQHaLcLc/wjfu2JnFESs2zDgI4SFhrCvhDOAgCtmDoCAC1MDgIAABa0AgAASz4CAAQt6gIADb8AA
Date: Thu, 25 Jan 2024 13:56:22 +0000
Message-ID: <3A26D95F-7366-4354-A010-318A98660076@oracle.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk> <20240122160227.00002d83@Huawei.com>
 <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
 <Za6mHRJVjb6M1mun@shell.armlinux.org.uk> <20240123092725.00004382@Huawei.com>
In-Reply-To: <20240123092725.00004382@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CH3PR10MB7764:EE_
x-ms-office365-filtering-correlation-id: d8894fc8-1a81-482b-9883-08dc1dad6a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YEapK7/qrpngKXmiyJMYLaKz1HHmDDVPigb5bNhlxKiM27zfYIbl2PY7c/refjdXCevG3qCW3aYOSSN0of2KVymbQjqLtQtThuVzeJeoGu9UZFHEE9ooYggV3tvuwmqQeTL2o8nBT++FC/+STFL2jpDDYZPVMiRa0DitYj99VHecaOMx2qLUDccLvxIK4ODN+NMDCtGyk+i7TUe7o+95RifZweLKhnyxYGWEQcuExOmdIZ33rSLcIcsp4QmrEuCqCTsUM/bHudGHlG0gNAn/oqrRJ2aASbqQYgq1qsSK+0KQpV4iT7/onFD1dppLccXmsYhF2/M0s5IYtdNyrznH250P/j+6VX0Ry98PJ8loikYxQDmQ8Xn+luZAQXHRf1k+Jf7JPmwg8mX+s4YDfYscMKen3tW2DLjwbNMn6/He4nmYoX2jFw/TgrRBuAolRJwdbPR/p+7UEpUO11o6QWBZgpUFo5aWCKEzgAZgRFrzsiwwRZhjQGW701Wl7sShRifpsS1HgYONGKGnyhHGXTVMw2UnXWxDVqVNfZ+XsA36cSwANcKgl3xtRgWmtx7dYunecgOgKwacuWm6CgAFsjsT5tSVvEaUG4TSTLFQJfeQVmKpr1l4WomyxjLJtKv96NWBn/X32OvHH33zt6GKdXojxw239LPdm669z0OjOHocAQaXzu8rtYQ0vhCFbokRi/s3
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(2906002)(33656002)(7416002)(36756003)(44832011)(5660300002)(4326008)(2616005)(6916009)(66946007)(54906003)(66556008)(66476007)(66446008)(64756008)(316002)(6486002)(6506007)(478600001)(53546011)(8676002)(91956017)(86362001)(76116006)(8936002)(71200400001)(38070700009)(122000001)(83380400001)(6512007)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WlFZcGFxWmtzdWszYk44OXYreXEvcG51N25Wb1lsWkkxOVFsV1NBL3hCd2Va?=
 =?utf-8?B?MEdseUdqVVE1dXlyb1pKZzRjQURmeHV5NEpFV3JKWC9nUTBzOStISW1RR2dM?=
 =?utf-8?B?RFJvZWptNjRaME1VQlZLdlRmQVRjUTdLY2wvZndjakNXczJ0RmFqc3Zha05Q?=
 =?utf-8?B?blZXd2hWcTJDYm13eXNLTHZyZktodkhZVVQ4N0w1ZVdxK05aWDhOV1F0MHVL?=
 =?utf-8?B?a1B1SGlBM3d3N1Vnd2pEM1RGbjl3Y1FBbHhjWC9ORHZxTFpqTFZCL042ajUz?=
 =?utf-8?B?ZE01MXdueU5yMjM2WmVNczBySkVwclVSNHhucmlZSUsva2Z4ZkFFNXdmVDZv?=
 =?utf-8?B?OGNkSG50SCtqQWNJU09uWjNlTm41dE1GZUJudysyd04wdmNvYTl6cC9uRllw?=
 =?utf-8?B?czR0N1pxbFRRbCtVK2R1aFcxbHo2bFVuRmM3T0RLdENLY250NmcvdUFUaTMx?=
 =?utf-8?B?K0QvYW81aTRncFAzV3NVQ3dhdFdlQmJ6a2JiNVBlMVFibUdtR3QvNE1saEt2?=
 =?utf-8?B?WkNCM0JZUnRtd0UxYU9BZFlsL1IrdjNSeVcvQ2pOc0hUaFRrbkVDdzVYUjlO?=
 =?utf-8?B?T2R0QlpQWlNoVEpjblRuMTBZNS8rYW52bUppdEl5YWI5VUVHTUsrRFdHZmsx?=
 =?utf-8?B?MnF1NGl0Z1ZtMm5PdllwaS9CQ3VsNEdnb2pKZ0l0ZlFoS3JVY2tuck9NeVJo?=
 =?utf-8?B?cFpRSGNzMnJVVnVhaEdoWTlxcXhuejZDZVh4Nkk4N0FYUTAvdk9kd0VDejFn?=
 =?utf-8?B?N2drUjMvcXpkZExWWkVUSElmSGpBSjBSLzVjMTByTG1WYWRUaGtaeVlMMy9J?=
 =?utf-8?B?NmJ1Q1EwbWNjcGcrQVdZOVJHVjFoZGZ6emtlV3ViampHUzYwRFRJUWJ3bnN3?=
 =?utf-8?B?aGxYZlRaL3ZneWh6ek82UDJQTU10c1BaeTdLbXNMUGVkS0t2U2E0VGlDSWpi?=
 =?utf-8?B?ZDlBMUNGUTd5OStRcWVGUkd2OXduZVdOTEZTYkl5cFRCeko0cy9pL051dFpz?=
 =?utf-8?B?N1VZNjFvVWV6VjVpdWxpanBXUCtYOXQ5eStCLzhveWR2K0plQlVtTjlNcVgz?=
 =?utf-8?B?K1Z6WG9FNEtiZTZZUjdleXlOOERsNEpySDh1U0VjL05FRmxYdkhCUGZJV1By?=
 =?utf-8?B?YU9QNWcyelhQcGZhUmVJQ3JNanlyT3BMRGZnUnZCL1FrNTM3Q29YeTl2Mjha?=
 =?utf-8?B?NjdDVzQyUW4rSVNTM1Y1R3NsMWFNRExHb0Z1RjR1MHN0bXQrby9kb0hxTGlK?=
 =?utf-8?B?STVkdVU2SWNmR2Q2WXI3TDdNbjhsM3pCUFROVlpmdkxyUHNRbmJ5V2taZm5K?=
 =?utf-8?B?NHM0Y3Y1R1dIWWxsclhFYmtJdlUrRVZSb1pZZk5wQWhISzR3RHBZWlFIL2J1?=
 =?utf-8?B?YkJyV1BLMzJoUTV5UklVYmxPeGc3N0lGWGpDcnNBamxUbU9WVjVmYk1FNDRM?=
 =?utf-8?B?TXhKRC9ubW1ScUZIcThJZEtWcUdCNng4OFZaSzkvcmNMSnpScnRjbndtWXVY?=
 =?utf-8?B?QTZuMXRuaCtXNFk2RVZvaW9SY0ozOUdrSU9rSmQzcGI3N1VDdys5OUdjcmxH?=
 =?utf-8?B?MkdoVE1ZTnZza0JUUzZNQWF0ZERzY09VajcvdGFjV0Q0UW96TVFDVW9vVG9s?=
 =?utf-8?B?Tmttb3poZG9BVitEdDY3d3hSd3VuS1Uwek9vQXh1Y0FjQWFBUWM4WWJIYU5v?=
 =?utf-8?B?WWRXdkNIUXdudFVoeTZYNnBXb04wK0VsRkFud2JDeWNmREdzeUlLdkVlbDE4?=
 =?utf-8?B?dzh0WUZqVWlnY2sxNGtqR2VrSG1YVVkvWkY0T01RZFI2ZkhFNWdUVTBlOEdy?=
 =?utf-8?B?YndUSkMyWUFlWGlieGtUSFZYMVMrSDlPN1NZSEowNUE0WUUrclhWblVHT290?=
 =?utf-8?B?T2JaWHpLeHVnTTVBZjJVRldHVFhzNTZYQW5XMGlxUERqTUJkaW9rZ0J3d2Mw?=
 =?utf-8?B?NHRqSGs3SUYxL0hycTFpdUJIaFVTQStlSUpmRkpvR2xrTGoycE1ocTdHRHF1?=
 =?utf-8?B?L2xnZXh4NjJVcllvaW9nY3pzWFBkWGVWcktVSzh1ZWgvMjQxRnZ0RFcyRndL?=
 =?utf-8?B?YUZUOURFd0UxUXFZUmxKWC8zTEJZVnNJTmhUTm42a0pDQ2VoL1BtRy91enNy?=
 =?utf-8?B?dXAwbjZnU1lZL3ZQd210Q0dVTjhZdkNzZjhUdFBXWkhzS2UwMVkvMzlqU1Fs?=
 =?utf-8?Q?cd/hwYjq6DQbBbNCuui/U1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107B742473746544996FA6C588527D04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PUSD4i5OTYzBzqgFVcPhKy07hm3PJ1ybCuNLF4Qf7w1Vk6ublWU9DcdBeEtw621AKgquKCNKZ4yA3N4AW+anGA73JKb6gCMWGt2/iv1rukAXIah+s7Wq5abLgb9XyjBO92kFLOyNzrtr5EUyfnvxp3iecZ4MLeaawAFRn+yTrgMzvJLDRGgAWcdBOJT8UgVrXdshNYlhuhfnnjX+Wsa5Q2NwMGc3EqCbLieiRVhJrLJwYdiD0LnBFVkQw0wwCTML0heI7w+6WQbV5iGvLnDE0+hIu4359M+f9KCFu1Zc64L5a/u9vtoS9TUukXPw+9MJ0PgIg0ZQ68XpDjXdXzjnL3vEqard8sLJITXPlZg7Vnm9z4FVyPXXrfMj19CykrgCK46WQY2DqOpgfGsfoSLvg52v1Z3uBEcZVcwwErvDocYOKYGOFMusQ0NOi9CP3bq4CfV6XBwYSDZF/wdxOFTJiP5UWIFPFSASZ1pUGVNbXY/1J23fv7r79eAKxXcRXNyPMNPaGF9r0aNIi85ZOrseJeG7wc5mh595T6guIUoArR4Qq1pVYR2QamaSkPuf3Uj+zdYk140VeRE+Ap6XiMuSbSh2PeaCYbA6zeeIZo1IRXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8894fc8-1a81-482b-9883-08dc1dad6a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 13:56:22.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGWrVzAuR09A2jQZSxuhZiQNbtnwLY0a1p/2K00nAJKzVL+w312JQ/v3cSZlg3gOf97le9ggB024ITJOaDtmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250097
X-Proofpoint-GUID: tsufFf4z88U1fpRS3UpuYOqA5MQbc_Pl
X-Proofpoint-ORIG-GUID: tsufFf4z88U1fpRS3UpuYOqA5MQbc_Pl

SGkNCg0KPiBPbiAyMyBKYW4gMjAyNCwgYXQgMDg6MjcsIEpvbmF0aGFuIENhbWVyb24gPGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIyIEphbiAyMDI0
IDE3OjMwOjA1ICswMDAwDQo+ICJSdXNzZWxsIEtpbmcgKE9yYWNsZSkiIDxsaW51eEBhcm1saW51
eC5vcmcudWs+IHdyb3RlOg0KPiANCj4+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDA1OjIyOjQ2
UE0gKzAxMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPj4+IE9uIE1vbiwgSmFuIDIyLCAy
MDI0IGF0IDU6MDLigK9QTSBKb25hdGhhbiBDYW1lcm9uDQo+Pj4gPEpvbmF0aGFuLkNhbWVyb25A
aHVhd2VpLmNvbT4gd3JvdGU6ICANCj4+Pj4gDQo+Pj4+IE9uIE1vbiwgMTUgSmFuIDIwMjQgMTE6
MDY6MjkgKzAwMDANCj4+Pj4gIlJ1c3NlbGwgS2luZyAoT3JhY2xlKSIgPGxpbnV4QGFybWxpbnV4
Lm9yZy51az4gd3JvdGU6DQo+Pj4+IA0KPj4+Pj4gT24gTW9uLCBEZWMgMTgsIDIwMjMgYXQgMDk6
MjI6MDNQTSArMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6ICANCj4+Pj4+PiBPbiBXZWQs
IERlYyAxMywgMjAyMyBhdCAxOjQ54oCvUE0gUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxp
bnV4Lm9yZy51az4gd3JvdGU6ICANCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEZyb206IEphbWVzIE1vcnNl
IDxqYW1lcy5tb3JzZUBhcm0uY29tPg0KPj4+Pj4+PiANCj4+Pj4+Pj4gQUNQSSBoYXMgdHdvIGRl
c2NyaXB0aW9ucyBvZiBDUFVzLCBvbmUgaW4gdGhlIE1BRFQvQVBJQyB0YWJsZSwgdGhlIG90aGVy
DQo+Pj4+Pj4+IGluIHRoZSBEU0RULiBCb3RoIGFyZSByZXF1aXJlZC4gKEFDUEkgNi41J3MgOC40
ICJEZWNsYXJpbmcgUHJvY2Vzc29ycyINCj4+Pj4+Pj4gc2F5cyAiRWFjaCBwcm9jZXNzb3IgaW4g
dGhlIHN5c3RlbSBtdXN0IGJlIGRlY2xhcmVkIGluIHRoZSBBQ1BJDQo+Pj4+Pj4+IG5hbWVzcGFj
ZSIpLiBIYXZpbmcgdHdvIGRlc2NyaXB0aW9ucyBhbGxvd3MgZmlybXdhcmUgYXV0aG9ycyB0byBn
ZXQNCj4+Pj4+Pj4gdGhpcyB3cm9uZy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IElmIENQVXMgYXJlIGRl
c2NyaWJlZCBpbiB0aGUgTUFEVC9BUElDLCB0aGV5IHdpbGwgYmUgYnJvdWdodCBvbmxpbmUNCj4+
Pj4+Pj4gZWFybHkgZHVyaW5nIGJvb3QuIE9uY2UgdGhlIHJlZ2lzdGVyX2NwdSgpIGNhbGxzIGFy
ZSBtb3ZlZCB0byBBQ1BJLA0KPj4+Pj4+PiB0aGV5IHdpbGwgYmUgYmFzZWQgb24gdGhlIERTRFQg
ZGVzY3JpcHRpb24gb2YgdGhlIENQVXMuIFdoZW4gQ1BVcyBhcmUNCj4+Pj4+Pj4gbWlzc2luZyBm
cm9tIHRoZSBEU0RUIGRlc2NyaXB0aW9uLCB0aGV5IHdpbGwgZW5kIHVwIG9ubGluZSwgYnV0IG5v
dA0KPj4+Pj4+PiByZWdpc3RlcmVkLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gQWRkIGEgaGVscGVyIHRo
YXQgcnVucyBhZnRlciBhY3BpX2luaXQoKSBoYXMgY29tcGxldGVkIHRvIHJlZ2lzdGVyDQo+Pj4+
Pj4+IENQVXMgdGhhdCBhcmUgb25saW5lLCBidXQgd2VyZW4ndCBmb3VuZCBpbiB0aGUgRFNEVC4g
QW55IENQVSB0aGF0DQo+Pj4+Pj4+IGlzIHJlZ2lzdGVyZWQgYnkgdGhpcyBjb2RlIHRyaWdnZXJz
IGEgZmlybXdhcmUtYnVnIHdhcm5pbmcgYW5kIGtlcm5lbA0KPj4+Pj4+PiB0YWludC4NCj4+Pj4+
Pj4gDQo+Pj4+Pj4+IFFlbXUgVENHIG9ubHkgZGVzY3JpYmVzIHRoZSBmaXJzdCBDUFUgaW4gdGhl
IERTRFQsIHVubGVzcyBjcHUtaG90cGx1Zw0KPj4+Pj4+PiBpcyBjb25maWd1cmVkLiAgDQo+Pj4+
Pj4gDQo+Pj4+Pj4gU28gd2h5IGlzIHRoaXMgYSBrZXJuZWwgcHJvYmxlbT8gIA0KPj4+Pj4gDQo+
Pj4+PiBTbyB3aGF0IGFyZSB5b3UgcHJvcG9zaW5nIHNob3VsZCBiZSB0aGUgYmVoYXZpb3VyIGhl
cmU/IFdoYXQgdGhpcw0KPj4+Pj4gc3RhdGVtZW50IHNlZW1zIHRvIGJlIHNheWluZyBpcyB0aGF0
IFFFTVUgYXMgaXQgZXhpc3RzIHRvZGF5IG9ubHkNCj4+Pj4+IGRlc2NyaWJlcyB0aGUgZmlyc3Qg
Q1BVIGluIERTRFQuICANCj4+Pj4gDQo+Pj4+IFRoaXMgY29uZnVzZXMgbWUgc29tZXdoYXQsIGJl
Y2F1c2UgSSdtIGZhciBmcm9tIHN1cmUgd2hpY2ggbWFjaGluZXMgdGhpcw0KPj4+PiBpcyB0cnVl
IGZvciBpbiBRRU1VLiAgSSdtIGd1ZXNzaW5nIGl0J3MgYSBsZWdhY3kgdGhpbmcgd2l0aA0KPj4+
PiBzb21lIG9sZCBkaXN0cm8gdmVyc2lvbiBvZiBRRU1VIC0gc28gd2UnbGwgaGF2ZSB0byBwYXBl
ciBvdmVyIGl0IGFueXdheQ0KPj4+PiBidXQgZm9yIGN1cnJlbnQgUUVNVSBJJ20gbm90IHN1cmUg
aXQncyB0cnVlLg0KPj4+PiANCj4+Pj4gSGVscGZ1bGx5IHRoZXJlIGFyZSBhIGJ1bmNoIG9mIEFD
UEkgdGFibGUgdGVzdHMgc28gSSd2ZSBiZWVuIGNoZWNraW5nDQo+Pj4+IHRocm91Z2ggYWxsIHRo
ZSBtdWx0aSBDUFUgY2FzZXMuDQo+Pj4+IA0KPj4+PiBDUFUgaG90cGx1ZyBub3QgZW5hYmxlZC4N
Cj4+Pj4gcGMvRFNEVC5kaW1tcHhtICAtIDR4IFByb2Nlc3NvciBlbnRyaWVzLiAgLXNtcCA0DQo+
Pj4+IHBjL0RTRFQuYWNwaWhtYXQgLSAyeCBQcm9jZXNzb3IgZW50cmllcy4gIC1zbXAgMg0KPj4+
PiBxMzUvRFNEVC5hY3BpaG1hdCAtIDJ4IFByb2Nlc3NvciBlbnRyaWVzLiAtc21wIDINCj4+Pj4g
dmlydC9EU0RULmFjcGlobWF0dmlydCAtIDR4IEFDUEkwMDA3IGVudHJpZXMgLXNtcCA0DQo+Pj4+
IHEzNS9EU0RULmFjcGlobWF0LW5vaW5pdGlhdG9yIC0gNCB4IFByb2Nlc3NvciAoKSBlbnRyaWVz
IC1zbXAgNA0KPj4+PiB2aXJ0L0RTRFQudG9wb2xvZ3kgLSA4eCBBQ1BJMDAwNyBlbnRyaWVzDQo+
Pj4+IA0KPj4+PiBJJ3ZlIGFsc28gbG9va2VkIGF0IHRoZSBjb2RlIGFuZCB3ZSBoYXZlIHZhcmlv
dXMgdHlwZXMgb2YNCj4+Pj4gQ1BVIGhvdHBsdWcgb24geDg2IGJ1dCB0aGV5IGFsbCBidWlsZCBh
cHByb3ByaWF0ZSBudW1iZXJzIG9mDQo+Pj4+IFByb2Nlc3NvcigpIGVudHJpZXMgaW4gRFNEVC4N
Cj4+Pj4gQXJtIGxpa2V3aXNlIHNlZW1zIHRvIGJ1aWxkIHRoZSByaWdodCBudW1iZXIgb2YgQUNQ
STAwMDcgZW50cmllcw0KPj4+PiAoYW5kIGRvZXNuJ3QgeWV0IGhhdmUgQ1BVIEhQIHN1cHBvcnQp
Lg0KPj4+PiANCj4+Pj4gSWYgYW55b25lIGNhbiBhZGQgYSByZWZlcmVuY2Ugb24gd2h5IHRoaXMg
aXMgbmVlZGVkIHRoYXQgd291bGQgYmUgdmVyeQ0KPj4+PiBoZWxwZnVsLiAgDQo+Pj4gDQo+Pj4g
WWVzLCBpdCB3b3VsZC4NCj4+PiANCj4+PiBQZXJzb25hbGx5LCBJIHdvdWxkIHByZWZlciB0byBh
c3N1bWUgdGhhdCBpdCBpcyBub3QgbmVjZXNzYXJ5IHVudGlsIGl0DQo+Pj4gdHVybnMgb3V0IHRo
YXQgKDEpIHRoZXJlIGlzIGZpcm13YXJlIHdpdGggdGhpcyBpc3N1ZSBhY3R1YWxseSBpbiB1c2UN
Cj4+PiBhbmQgKDIpIHVwZGF0aW5nIHRoZSBmaXJtd2FyZSBpbiBxdWVzdGlvbiB0byBmb2xsb3cg
dGhlIHNwZWNpZmljYXRpb24NCj4+PiBpcyBub3QgcHJhY3RpY2FsLg0KPj4+IA0KPj4+IE90aGVy
d2lzZSwgd2UnZCBtYWtlIGl0IGVhc2llciB0byBzaGlwIG5vbi1jb21wbGlhbnQgZmlybXdhcmUg
Zm9yIG5vDQo+Pj4gZ29vZCByZWFzb24uICANCj4+IA0KPj4gSWYgU2FsaWwgY2FuJ3QgY29tZSB1
cCB3aXRoIGEgcmVhc29uLCB0aGVuIEknbSBpbiBmYXZvdXIgb2YgZHJvcHBpbmcNCj4+IHRoZSBw
YXRjaCBsaWtlIGFscmVhZHkgZG9uZSBmb3IgcGF0Y2ggMi4gSWYgdGhlIGNvZGUgY2hhbmdlIHNl
cnZlcyBubw0KPj4gdXNlZnVsIHB1cnBvc2UsIHRoZXJlJ3Mgbm8gcG9pbnQgaW4gbWFraW5nIHRo
ZSBjaGFuZ2UuDQo+PiANCj4gDQo+IFNhbGlsJ3Mgb3V0IHRvZGF5LCBidXQgSSd2ZSBtZXNzYWdl
ZCBoaW0gdG8gZm9sbG93IHVwIGxhdGVyIGluIHRoZSB3ZWVrLg0KPiANCj4gSXQgJ21pZ2h0JyBi
ZSB0aGUgb2RkIGNvbGQgcGx1ZyBwYXRoIHdoZXJlIFFFTVUgaGFsZiBjb21lcyB1cCwgdGhlbiBl
eHRyYQ0KPiBDUFVzIGFyZSBhZGRlZCwgdGhlbiBpdCBib290cy4gKHVzZWQgYnkgc29tZSBvcmNo
ZXN0cmF0aW9uIGZyYW1ld29ya3MpDQo+IEkgZG9uJ3QgaGF2ZSBhIHNldCB1cCBmb3IgdGhhdCBh
bmQgSSB3b24ndCBnZXQgdG8gY3JlYXRpbmcgb25lIHRvZGF5IGFueXdheQ0KPiAod2UgYWxsIGxv
dmUgc3RhcnQgb2YgdGhlIHllYXIgcGxhbm5pbmcgd29ya3Nob3BzISkNCj4gDQo+IEkndmUgK0ND
J2QgYSBmZXcgcGVvcGxlIGhhdmUgcnVuIHRlc3RzIG9uIHRoZSB2YXJpb3VzIGl0ZXJhdGlvbnMg
b2YgdGhpcw0KPiB3b3JrIGluIHRoZSBwYXN0LiAgTWF5YmUgb25lIG9mIHRoZW0gY2FuIHNoZWQg
c29tZSBsaWdodCBvbiB0aGlzPw0KPiANCg0KSUlVQywgdGhpcyBwYXRjaCBjb3ZlcnMgYSBzY2Vu
YXJpbyBmb3Igbm9uIGNvbXBsaWFudCBmaXJtd2FyZSBhbmQgaW4gd2hpY2ggbXkgDQp0ZXN0cyBm
b3IgQUFyY2g2NCB1c2luZyBSRkMgdjIgaGF2ZSBiZWVuIHVuYWJsZSB0byB0cmlnZ2VyIGl0cyBl
cnJvciBtZXNzYWdlIHNvIA0KZmFyLiBUaGlzIGRvZXMgbm90IG1lYW4sIGhvd2V2ZXIsIHRoaXMg
cGF0Y2ggc2hvdWxkIG5vdCBiZSB0YWtlbiBmb3J3YXJkIHRob3VnaC4NCg0KSXQgc2VlbXMgYmVu
ZXZvbGVudCBlbm91Z2ggZGV0ZWN0aW5nIG5vbiBjb21wbGlhbnQgZmlybXdhcmUgYW5kIHN0aWxs
IHByb2NlZWQgDQp3aGlsZSBoYXZpbmcgd2hvZXZlciB1c2VzIHRoYXQgZmlybXdhcmUgdG8gZ2V0
IHRvIGtub3cgdGhhdC4NCg0KSSdtIG5vdCBzdXJlLCBob3dldmVyLCB3aGV0aGVyIHRoZSByZWZl
cmVuY2UgdG8gYSBzcGVjaWZpYyBWTU0gc2hvdWxkIGJlIGluIHRoZSANCmNvbW1pdCBtZXNzYWdl
IHRob3VnaC4gVGhhdCBtaWdodCBub3QgYmUgYW55dGhpbmcgdG8gZG8gd2l0aCB0aGUga2VybmVs
IHNvIGEgDQptb3JlIG1lYW5pbmdmdWwgcmV3cml0ZSBvbiB0aGlzIHNlcGFyYXRpb24gb2YgY29u
Y2VybnMgY291bGQgYmUgdXNlZnVsLg0KDQpNaWd1ZWwNCg0KPiBKb25hdGhhbg0KDQoNCg==

