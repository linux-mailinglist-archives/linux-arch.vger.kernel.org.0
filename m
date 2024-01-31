Return-Path: <linux-arch+bounces-1946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6C844614
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E341929419D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997612CDB3;
	Wed, 31 Jan 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHerG/iw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OvbQt26t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1612C54B;
	Wed, 31 Jan 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721961; cv=fail; b=sTfOMk8fandr7pXCtJVIpB0wDf5WWVS9zfE4DWpv/XHEth9u6eVZmVeVAH/ACaIr1/4sjFiEWG8auaPMW7+3GbFv+NR0uotKGnanhCV9HVEKCawLXpy6vYOQPt+8OUk+mR2plnUzpvRNaDJsJBFgLFjie/Szzk7b3sA7KCL4sY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721961; c=relaxed/simple;
	bh=6lwlahWQgRjGUyqoNVyjkxpREBr2N5caJeFnec4at7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4fBWVZnAbMxpMYCf8CA7QX1Ucm7ccmVTT7Bfqxt7tn5NYHsLCA9fh4npHrVpNtZ46pIydNzqn2B40Bh/E0cpW66XtHJgKiTy9WeBFFvTmf+5vbVspHmp0D1Y7r4FJQr3p0nCNT/TYW5VKwI87o0BNMdKPePuazICgjPltILyxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHerG/iw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OvbQt26t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHC3hU004756;
	Wed, 31 Jan 2024 17:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=05fyeGhIMhB1lOJKioTUONn/STr+y5O4M3hrptRHV1k=;
 b=VHerG/iwekOA3DLY8gNPgGKTa1Z8JACw5wErcCpeBIxwE6a7yOSUzBPdPGeL1RgHWFkX
 yOrW1c3UW9OAeNMKgiy7Y1pkrYRGwtgCqCQDSax25ZI1i1m1owGPS6K8OM6Njoxdu47t
 qSFnA5ituVtg0OZSPDagwXQWi7LfLJhOB6T+xoYg8CEBJZIDSya3XBUyfnpFXeS2P0d5
 CqVkAX/4CAO5SBaocsMgOnsHu8IcAbljC4y8db14TCuwqO2+diY+8WVXwyLf63wQW+2U
 lGTu5G2yU+75bJD7MghYfaCYGZtZEHVBY27HJa1CtnCbQGBKqQ7Fg2K55Ug/uCKbromJ 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqb2ehv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:25:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGvhw7036101;
	Wed, 31 Jan 2024 17:25:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fmncn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD93YpZEFVU6LMt5/v+xy0c7XiQMv+3zfhZXnYBaKVo1Lzo5ylO7YxnMUClu03Ea2X8LphlcT/p1glhaMeehTrwyJ55jEw613oJtNCjamozR7c8wS+Mg1xFrqYz9nHHIVQozxp0fEvnPzY1wvalKPmjWaHY45ri/xDe7dBl/pgSEy+zaGYVpC2W0/dKtqwpQkEoaQkQPBJdxWLn3k2eZeuly9LsqbAmYkO5FeZTpY8zZBv9F5YuKRoxa+6aQ1BK+bM0SYKXPpp42y1YoGUvLk9BdazK0Hif0aSK7/mVojDi2s1zjDznj1HcSk20nm7lF9X6K3fZ7dHpO3/4Zy/6n8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05fyeGhIMhB1lOJKioTUONn/STr+y5O4M3hrptRHV1k=;
 b=oaJj3wI6Px5Pj5KvSEWoGHvx4hSVbNbzmP1FDOzOk8+/13GwaBPnFB7s3K8dtDJ3ocIHItyqKMfTG8ewZb4nttiwkwQrP99/XIJ0uQI6NNq38ulNuaSe8YQOWqAEgsAaj6MlE79wKGuv1F+G4IOd4ppylNqUSykM0hqXqiAvPeP11wfaTUBM7gD714VX504ltyCnygGw57GtQQBu+G++iI9C5moLe60PID6vV9XGgtzvW4mQhj+e/DhO/sBcaCtW4org1su79Bnkfg41ilx/PaOQVLZv0x94xvOOg5D5+rW+cZh6nh7RK1JD2irAjJjXZzHpfuIwUDcB6bFfVhg72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05fyeGhIMhB1lOJKioTUONn/STr+y5O4M3hrptRHV1k=;
 b=OvbQt26t5yfkM3UZU8qfnpK9aVWDXtta82ec0NXxzGauqL9immcHPtSkVYbi4Uxu+fOOo+wwEhPn03hRGMkoMky3nhfv04fifznGlHDYzyNx9/3L4mrOAlHVvHbwvLOpQS/bRt5Q9HgaSwQBcxQkcEAreW5Pnt/wveZI1G8xX/U=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7979.namprd10.prod.outlook.com (2603:10b6:8:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 31 Jan
 2024 17:25:29 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7228.035; Wed, 31 Jan 2024
 17:25:29 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
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
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or functional)
 processor devices
Thread-Topic: [PATCH RFC v4 01/15] ACPI: Only enumerate enabled (or
 functional) processor devices
Thread-Index: AQHaVGWXrmQ6tbct00qr+/5CouVONrD0LCkA
Date: Wed, 31 Jan 2024 17:25:29 +0000
Message-ID: <05A27863-22ED-4CF6-BBD6-5349ED1330A9@oracle.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVDmP-0027YJ-EW@rmk-PC.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS0PR10MB7979:EE_
x-ms-office365-filtering-correlation-id: 239c1c46-8156-4f08-0c80-08dc22819f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 13rnIGOyd4jAamv+GHXnmeeqvZMxtl71EHFiI4+S7mbugbDBTVRGGfTgveZnuIDRV/UWqlbKEEI1kVEwSnVVUpbL+7Vh+NSkF4l4nTGt21quKeeZNR9tzv9JehVfDwQcuKU27UiWnvNMLNmXr4Ix8/vyjCqGCarIo1LA9M/w6BGDnRCYjsvS6FFZSUqb8R299G/sxVx17nRaWT7LfqX12qndkrHyX66HJdaeZVKC8moe4bbOJqat2/qXWX7Ok+xXGR+P5rx6cN8HRkiCLiMZkwiHI4zycoexC2c/szcxjhjlHdFD7/qsxwB1cdV1/tV1t12lVZzB7Yg9E/Aon2AXfP36Mo+xw1oBDGDLj+OWHZB4CvXv7/wV6o7WkJrqYzTRfyYk9zbHgp7lLpKj+PC3Y9HshGxqZX+gWFJhcCQAT98l2m7Dx7tjZ0QMOpYfN9+SOv5LTdJ+AB+9mQt4bwyfbcM09WYlVtitccEn/OR/4fIBQ2PTPDXvCGIrO6JdQ3WWXhIKHmKGVcwhzYnYewd/4j/jWymf8sMFQocy3cyxATW6NQ3BqHR1ltp3YR3kfmEAc3ql/IwnS0WKOdr+pKgYHuNqooMjH+gXytUgnghm9bXDC8R3NNoiCdbqaQjP4YUP1ZNo8TUIp+KbGEIbJW7OZzC35JXgEQSj4G1yGWl3u5BhWHI2SxrmMAJrlk9qg4yI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(36756003)(38070700009)(41300700001)(44832011)(8936002)(4326008)(8676002)(6512007)(2906002)(33656002)(2616005)(5660300002)(66946007)(478600001)(6486002)(966005)(76116006)(66446008)(64756008)(6506007)(38100700002)(86362001)(53546011)(91956017)(66476007)(54906003)(316002)(66556008)(71200400001)(7416002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KIKUvpWWX6fu8l7PCOEbuGh1nO+sAPXA/M+YwRYtT1pxbnnEyB0eLR0vAkuu?=
 =?us-ascii?Q?CoDZm653IdFhx2CqK+0nfUdV3kPy9vdrBoEkHiNiQq0OdPEixTa7g1bgziJC?=
 =?us-ascii?Q?EFwhOg6KEdgrThslD++FSEqJ4HfM9nnS4+/laMf3KlHMs/1dz7WrKrKVXo/N?=
 =?us-ascii?Q?ZZ3tSh57abYbBECTHicYtsweVnPLLY/OxNDDHbXWlbzOjWa6tReJHn0eg+Rn?=
 =?us-ascii?Q?nTTDMcqW6kD6LvA2c2WTqMOGtu+uSnlQbYXwOm+XQobTk4pwJuVkek4wHt75?=
 =?us-ascii?Q?BJ2HXMVCM4s8NQnjbfZE+TsWc6ny4+jMeE1xsclNJEULInKsiqF6ENmwdwm6?=
 =?us-ascii?Q?dIWaDuChs9/ikq/Cl3TD+PWGhAwBmuincI8qoh4MX2kT31P/pX+utmRMI7Hf?=
 =?us-ascii?Q?rwS44bN6AHf1vxJbDmIdSd5tbC+r3ajpWUSWFcV3CowDAJBCftpXpG6biGkg?=
 =?us-ascii?Q?LQjmXO2v1nfWoynXMqKmnORxKTnR1iuqiVG6QobvvnFNeHu5h+F3Axum42Kv?=
 =?us-ascii?Q?YoyTAc8l8IUI/wJlMDqbfOnfo6qFF/qky+LHUZFj2EfUWV0p+qaGfGwmDsD0?=
 =?us-ascii?Q?lcUz4Td8Bk0IJCF/abcgsRSO9UoHTU9bPyZZWxiwhxChjoglANE/jxh5Wz4I?=
 =?us-ascii?Q?TkVfHF1TXR4iZRlVM0tLz0tHc5AC11bdfv9xERPJc2M03XLLvVNB8KaqknRP?=
 =?us-ascii?Q?XNOzazwWmYWX+IhTqw6Feo3bmen/8oq/T+5R52S+khxb8W6sd4zrm/SL8EDI?=
 =?us-ascii?Q?R8XwWUrCWV+biKGEvod+ydHlewreq5eJPby6PhqRTQSbgE6Bek29you94g4l?=
 =?us-ascii?Q?WLBH7K8Ysp82hW9l6OHXjRy920RvgtF7ptq7CRRQJT7ON96xMcvNpB5uBGL7?=
 =?us-ascii?Q?D3DNHXbhy4f5jJidCQNS7yzmlP1+JInvf+bPyr2aE21PrWI04BWsV/Kmit8h?=
 =?us-ascii?Q?xZCYeAnZTtWwv8w5fpHSBLTnL0Mf8ZLtI4ldlPlI6L4bIK8wZoWfaRbOiR5x?=
 =?us-ascii?Q?TNW1gXYwGipYquYW88EnSQvBeVZVdssm9+k/xQIpeSPy82QIURaRqsJOpcLT?=
 =?us-ascii?Q?xgtWxuYRiMKA8dg1Aq82AOHnAvg5MY312+b7IU8Dabq61AmZZzxt77ph0txG?=
 =?us-ascii?Q?VKHK1GtgWfpgseVY4V+2O/wZAIGataKxCmIw+ujUvfPLdBzd6M95wkI7tQni?=
 =?us-ascii?Q?5KENat0Z3c52hODZahmIhCfu/kRleUmiL0L+LWWuLuEKaRi4zm18hQC/dmcw?=
 =?us-ascii?Q?WgsThR4nC4NPL6t6D3baUpxtrfJjXGgAuiuTlC/luil3caeXMYVCqCGMfCbE?=
 =?us-ascii?Q?L2NlXnQQlJ6HdL8kvf+jP4AKYvhZgbYVhRqLcoMxM0HzijJBzhI+dDyuXbAR?=
 =?us-ascii?Q?XRUCsqjRgltX4HjKF24buCOY6rhg+Oakqf/gihb9Pm3pB9FM+1bPEWUJZNCi?=
 =?us-ascii?Q?g1BQp1w4wO3B0x7t+sTWznQTBVqR5S0mTTx1bRTDabEiWydsRZ1Ia3fCS3mk?=
 =?us-ascii?Q?Qdt/w0UWZYi20X89mi52CZfmedI2Z9/+grMvb+FFgShROSxNzuDebg98RMFq?=
 =?us-ascii?Q?yUW18fYgt69iKWJPUXexslCT51JKbD7fZkrTOUMeZPBzLzoG1k/lSxLIMbpB?=
 =?us-ascii?Q?XEsnWMjWcqHt0aKGMKM+HIk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FC90E6C189EA44E9F8E6FF2032CAE53@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	85+Cagi0gvsXMI9BJYndbO906L0RqDraYRDudbP+w/fmQrKuULcqPd2hapmV6EGOLXHSyoNBAVVoif62KxRldomV6jlMRMxzJAlIdeH5yyQE9jJC/X/3NoRIomL9vP9MqiwYK0tM15lKZ/HUC8/xIIpvgUM6ohWTIgB9wf1v0CXOD5fkYVrGuXVRBYLYnMkL2HKKhBWjPlzhOg/pQi9NOb3UoPCqhPj0V+lHOSGdVT/kpNQqtz+NT17zr+cnFXvxQUQ14pd+jZ8JT5UVKf8T2XK7zDb4Bb+Pnp0mbLy2IIPLAWAHiqPYzot0S8eJ9yvr3KTly1UbOOJvrG3/+GwXvd4k72VaETEFrhdMVazUVz1wGCcnsvloN7lrxppzW246WGeBbSXbH7BR4r9fMMxX+bhZqwQ4TF9qekDFvlLbmQZIBGqQ6dNCZn6mYNZxYDOcGorsODDjAi/MZdenuRzO9AmbtAImZjBh9ApSq8YccYV746NkEFXdqSmqhb+PKg25s+yMqR07j2FaL0smAcDeFD3Fd+Etm42QfNddJqHE5CsAy9vM1iHnOHStEslIB/lyHh2imHe7L4xhO8BJk5wxoHl5brzpcrBW/FwEyuIep4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239c1c46-8156-4f08-0c80-08dc22819f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:25:29.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMp6qsK4jiEKMN99JKVfk+YN9UNTHz4isX/uXu3wCNXwOpdtObrnvZyJ1lOzv3XZgExRW4aLkwstqc9RX1VO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310134
X-Proofpoint-GUID: e3s_sTLO9TF_C4Po0IXfVKJiSDYXeFje
X-Proofpoint-ORIG-GUID: e3s_sTLO9TF_C4Po0IXfVKJiSDYXeFje

Hi

> On 31 Jan 2024, at 15:49, Russell King <rmk+kernel@armlinux.org.uk> wrote=
:
>=20
> From: James Morse <james.morse@arm.com>
>=20
> Today the ACPI enumeration code 'visits' all devices that are present.
>=20
> This is a problem for arm64, where CPUs are always present, but not
> always enabled. When a device-check occurs because the firmware-policy
> has changed and a CPU is now enabled, the following error occurs:
> | acpi ACPI0007:48: Enumeration failure
>=20
> This is ultimately because acpi_dev_ready_for_enumeration() returns
> true for a device that is not enabled. The ACPI Processor driver
> will not register such CPUs as they are not 'decoding their resources'.
>=20
> ACPI allows a device to be functional instead of maintaining the
> present and enabled bit, but we can't simply check the enabled bit
> for all devices since firmware can be buggy.
>=20
> If ACPI indicates that the device is present and enabled, then all well
> and good, we can enumate it. However, if the device is present and not

enumerate

> enabled, then we also check whether the device is a processor device
> to limit the impact of this new check to just processor devices.
>=20
> This avoids enumerating present && functional processor devices that
> are not enabled.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
> * Incorporate comment suggestion by Gavin Shan.
> Changes since RFC v3:
> * Fixed "sert" typo.
> Changes since RFC v3 (smaller series):
> * Restrict checking the enabled bit to processor devices, update
>   commit comments.
> * Use Rafael's suggestion in
>   https://lore.kernel.org/r/5760569.DvuYhMxLoT@kreacher
> * Updated with a fix - see:
>   https://lore.kernel.org/all/Zbe8WQRASx6D6RaG@shell.armlinux.org.uk/
> ---
> drivers/acpi/acpi_processor.c | 11 +++++++++
> drivers/acpi/device_pm.c      |  2 +-
> drivers/acpi/device_sysfs.c   |  2 +-
> drivers/acpi/internal.h       |  4 ++-
> drivers/acpi/property.c       |  2 +-
> drivers/acpi/scan.c           | 46 +++++++++++++++++++++++++++--------
> 6 files changed, 53 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 4fe2ef54088c..cf7c1cca69dd 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,6 +626,17 @@ static struct acpi_scan_handler processor_handler =
=3D {
> },
> };
>=20
> +bool acpi_device_is_processor(const struct acpi_device *adev)
> +{
> + if (adev->device_type =3D=3D ACPI_BUS_TYPE_PROCESSOR)
> + return true;
> +
> + if (adev->device_type !=3D ACPI_BUS_TYPE_DEVICE)
> + return false;
> +
> + return acpi_scan_check_handler(adev, &processor_handler);
> +}
> +
> static int acpi_processor_container_attach(struct acpi_device *dev,
>   const struct acpi_device_id *id)
> {
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..e3c80f3b3b57 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
> return -EINVAL;
>=20
> device->power.state =3D ACPI_STATE_UNKNOWN;
> - if (!acpi_device_is_present(device)) {
> + if (!acpi_dev_ready_for_enumeration(device)) {
> device->flags.initialized =3D false;
> return -ENXIO;
> }
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 23373faa35ec..a0256d2493a7 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_devi=
ce *acpi_dev, char *modalia
> struct acpi_hardware_id *id;
>=20
> /* Avoid unnecessarily loading modules for non present devices. */
> - if (!acpi_device_is_present(acpi_dev))
> + if (!acpi_dev_ready_for_enumeration(acpi_dev))
> return 0;
>=20
> /*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 6588525c45ef..1bc8b6db60c5 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -62,6 +62,8 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug=
_profile *hotplug,
> int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
>       const char *hotplug_profile_name);
> void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool=
 val);
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +     struct acpi_scan_handler *handler);
>=20
> #ifdef CONFIG_DEBUG_FS
> extern struct dentry *acpi_debugfs_dir;
> @@ -121,7 +123,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
> void acpi_device_remove_files(struct acpi_device *dev);
> void acpi_device_add_finalize(struct acpi_device *device);
> void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
> bool acpi_device_is_battery(struct acpi_device *adev);
> bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> const struct device *dev);
> @@ -133,6 +134,7 @@ int acpi_bus_register_early_device(int type);
> const struct acpi_device *acpi_companion_match(const struct device *dev);
> int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>  struct kobj_uevent_env *env);
> +bool acpi_device_is_processor(const struct acpi_device *adev);
>=20
> /* ----------------------------------------------------------------------=
----
>                                   Power Resource
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a6ead5204046..9f8d54038770 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1486,7 +1486,7 @@ static bool acpi_fwnode_device_is_available(const s=
truct fwnode_handle *fwnode)
> if (!is_acpi_device_node(fwnode))
> return false;
>=20
> - return acpi_device_is_present(to_acpi_device_node(fwnode));
> + return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
> }
>=20
> static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e6ed1ba91e5c..fd2e8b3a5749 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device =
*adev)
> int error;
>=20
> acpi_bus_get_status(adev);
> - if (acpi_device_is_present(adev)) {
> + if (acpi_dev_ready_for_enumeration(adev)) {
> /*
> * This function is only called for device objects for which
> * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *ad=
ev, void *not_used)
> int error;
>=20
> acpi_bus_get_status(adev);
> - if (!acpi_device_is_present(adev)) {
> + if (!acpi_dev_ready_for_enumeration(adev)) {
> acpi_scan_device_not_enumerated(adev);
> return 0;
> }
> @@ -1917,11 +1917,6 @@ static bool acpi_device_should_be_hidden(acpi_hand=
le handle)
> return true;
> }
>=20
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> - return adev->status.present || adev->status.functional;
> -}
> -
> static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>       const char *idstr,
>       const struct acpi_device_id **matchid)
> @@ -1942,6 +1937,18 @@ static bool acpi_scan_handler_matching(struct acpi=
_scan_handler *handler,
> return false;
> }
>=20
> +bool acpi_scan_check_handler(const struct acpi_device *adev,
> +     struct acpi_scan_handler *handler)
> +{
> + struct acpi_hardware_id *hwid;
> +
> + list_for_each_entry(hwid, &adev->pnp.ids, list)
> + if (acpi_scan_handler_matching(handler, hwid->id, NULL))
> + return true;
> +
> + return false;
> +}
> +
> static struct acpi_scan_handler *acpi_scan_match_handler(const char *idst=
r,
> const struct acpi_device_id **matchid)
> {
> @@ -2405,16 +2412,35 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>  * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for=
 enumeration
>  * @device: Pointer to the &struct acpi_device to check
>  *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet depende=
ncies.
>  *
> - * Return true if the device is ready for enumeratino. Otherwise, return=
 false.
> + * Return true if the device is ready for enumeration. Otherwise, return=
 false.
>  */
> bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
> {
> if (device->flags.honor_deps && device->dep_unmet)
> return false;
>=20
> - return acpi_device_is_present(device);
> + /*
> + * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> + * (!present && functional) for certain types of devices that should be
> + * enumerated. Note that the enabled bit should not be set unless the
> + * present bit is set.
> + *
> + * However, limit this only to processor devices to reduce possible
> + * regressions with firmware.
> + */
> + if (!device->status.present)
> + return device->status.functional;
> +
> + /*
> + * Fast path - if enabled is set, avoid the more expensive test to
> + * check whether this device is a processor.
> + */
> + if (device->status.enabled)
> + return true;
> +
> + return !acpi_device_is_processor(device);

Otherwise, feel free to add:

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>

Thanks

Miguel

> }
> EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>=20
> --=20
> 2.30.2
>=20
>=20


