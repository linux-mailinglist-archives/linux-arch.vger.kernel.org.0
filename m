Return-Path: <linux-arch+bounces-8897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4F9C0E76
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C2B1C21612
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EE218593;
	Thu,  7 Nov 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L2nY6Q5m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="snzK18tM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B217F57;
	Thu,  7 Nov 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006563; cv=fail; b=Gp5jcYVNbzzufnO98LYX4Hq+tL8yV//3Z7yXC4eS8JT1w/8rN3Xu2xgz7XQ2owi4bdUKw8zGuaP+lLh6XwWFYtYK2rz1Ca6GOK0zVzolz5KLVUpOTf5u5LMeIBBhGqKl2MUwmigqt+J9dh54gM7rj4qVAydMFlLTut5iYHJpdGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006563; c=relaxed/simple;
	bh=P5KqMCBbw7Tz85lC8YXD6NTkITnpZKTc8pnpXCGWWuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdwQMDFivPCz9TJgQ3RLJDv65CtoeF80z9oGtOoo4tVxn5pUIY28MFSYJiHBud7Hb1ayxoR4PkBbGaL7wlEZ5mOLO7T259J1WOa6lCVEj4DPBFl/zG/NJ4b0ahmn4WwVtJT54mAJ04Jq8R1s33J/yIS8RFBMSLnpqFrTeP3tPf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L2nY6Q5m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=snzK18tM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBdS4002626;
	Thu, 7 Nov 2024 19:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1q6nQeCGiOFRAbGCFzLJlaf/ZZKfw59FJgWWVjOWKfY=; b=
	L2nY6Q5mCh2ASIpbSrsIl5C1tm9qw9KS/wAxgW9WqQSbIQxC0IbS6R1cL1utkbEO
	gP7ffyqyV2pP8qnmbi661+TrKNLqhe7yfaWl9loOzSV3Nj5Og6R+XI5BUy46q2hh
	CMzioOpZb8ZiWAhL3SZ2VsWXALPz8U0RouZAqhT1uxOFZhS//v66lJ3sU5SLAYD2
	sV5GUw0HDtWvkO9keZ9/knckoHJygU6qIaQopgjMPn1WqR6DC5Pgql00VPdCGByZ
	fN0UgTH+J9dMpqUB4N66n/wsORimaWaogWjTAs2FoPIcY5KToBVSICxIPVgX42vT
	E4uxFfsaUfk8XVqSEWGKug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmtbbbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IKU0T031448;
	Thu, 7 Nov 2024 19:08:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6ck3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv11kPNPNnInttMyjpZYHgZILHvtPrMFQC2IEnfhOtqZaibf1xWhF3rKZPlHPurGo1LEVJbv4wkFEfLzRX95B5TJTaap0IRhe2JsGctXst2N/u+PQ2wS/uCSNpVzWe4AGPvMkBsPBPN8gYtQ1DHD09JMpfstr1ovYoHXYiWRDUELHbda6qGWFiokJTVWK9J3Mh/DiYD1ge3BQVe3z1z0rzO/4fWcr+Lj+uF8uv7GaR5lO3cm/DhvQuIiAksLopliNl6S/J6BZDI0io/wIQz2ZKO6njygrjaWKFfIYUaf0DhwoIjDgBn094P+c7SOzcRzaZHGScfZSXAnVRhe3Db/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q6nQeCGiOFRAbGCFzLJlaf/ZZKfw59FJgWWVjOWKfY=;
 b=AvQmpOVl4EaXl0CCqIIXiDkLOBVSng+8W65pXNMLx6OQw6jq29hLr4uvmXw9w+W/qtYxnY2fz+OGFXhE0mit03Gg92m7z74t4848HEKaVh5XJY6ebsw2DGsp1vuQOxH0lG6SlZWNVSU46jJKhqy7gnt6il/lAFO8SFBm/M2BYIuF+4X2THhKW7rDkRy97HqiN85poM55W1mgHymQ9Hpb8KwbklVs9RKtKgO4I2v1pS7b82Gs1QgtFNZN3FCSGjXkjBCfUiRMCu0eWreHgDThh38YfhN/MjAO8mCsjQjslMkTeQIS1jpho95j3gA3XAKDWHdY7JWlCeKWTXGh/cs1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q6nQeCGiOFRAbGCFzLJlaf/ZZKfw59FJgWWVjOWKfY=;
 b=snzK18tMOOscgG710bofND832iTgMMUR3hQ8MXj0vohyE2lAirtyyecGSa12UKn+QQVPduYYNTDOhkaBIS8WD8OazJ55VxZ2r9XuVAlyZnKDTyhCo+W8dtq60q0drdlwpSFU8ajDfMyKYZIqy7bPskDvOSlx47ssofF9ZymUJwM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:40 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v9 07/15] arm64: add support for polling in idle
Date: Thu,  7 Nov 2024 11:08:10 -0800
Message-Id: <20241107190818.522639-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdccd6a-22ac-455c-255d-08dcff5f973f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UIAEfUKHP9zdcN84Pg5Gkq8jqqlCOOt5YI0UvBh+fEfWA+g+chZ6V5HnrZ2v?=
 =?us-ascii?Q?fxwQVfVEoHJeViXQu3ManJ8iOqM0bHG5VEIM251NQs+wWryEPFR4yArwwFtQ?=
 =?us-ascii?Q?66oIDhbJn00cqxQfTkQ3/McTE972EjhUW1Gvx582EFLjSlXJXrgRGgKfURhd?=
 =?us-ascii?Q?LI3FtqBEvapO8wfatKXJLU6Gj9hfVJtw+QUO9coFbGOHD0a3+ffgo4ZnJIV7?=
 =?us-ascii?Q?5CpmKBcnivS/foxQfbVkglBpQ3hPrNZB/Sd3f+Wq9e7uq5Ec3eNUW+GcX+o4?=
 =?us-ascii?Q?1CaaOFztsjz896M0QVqdPaeumgUA/s6k3uTWY+MeHIwYnf9sWIQ123Bbfpji?=
 =?us-ascii?Q?Cliw6ErBFCLcZPRJMfOV3qx4PKVjmRp/1ap+ZYjZ+9V/W4e+qSjcRldvqaRz?=
 =?us-ascii?Q?U31qyznsJJE78LCkroCgWgpTLlytIfZ4D72xvhgB8ScNYukCDYIe1i68clpY?=
 =?us-ascii?Q?9QW9J47qGjbRROnWcSBXHi0E33+d4kGyd5kHqwOrEKqPXApNb51VoZWsiwbs?=
 =?us-ascii?Q?swn8/y/aU1xfMiQla1sPZWHnE97oMlFjfb9gcq9agRSwr1By4Ttcs22nuAn7?=
 =?us-ascii?Q?fBZjOv776ohExEPWmIlTjnFMPtiDz9P+NbLfBs/7oRchkXneJpn6eVFW0NA2?=
 =?us-ascii?Q?foJBXVDoQ9yBzQ7GCwmfldxlgZyBvXCy3cem51QiXenA81lZFWIrhoFG7Wk7?=
 =?us-ascii?Q?MM0Z8X4s2oMJERydWe8xD7fGOV/9Vnta7/Bk3t9DAmJ8R+Qd/z0tk6vmBQhR?=
 =?us-ascii?Q?SOHr3OtcRfzXuMGR90hfVuJNylC5PvuP0Ejw1cruoDS/A3N4/zxwyQ6ZBKeG?=
 =?us-ascii?Q?TskT2qxvZZZgZLPSeZWSGA3w3TSdkqGVlhbLyNYKGk2evXrfww3Vcdul6q64?=
 =?us-ascii?Q?DMn6C+3R7IWbpHzP8u31pWzjOgJjACiLtNmnGk88FBYpez5C7HrZ9/SAOyPo?=
 =?us-ascii?Q?hRg8HqipdafbR//89TzTH38LpILDb0Dl/6JPi8k95MUa1/2CndbSNlcWl2Nh?=
 =?us-ascii?Q?NwFcbvrQNNWwPaegPYBLZ4ofAp5RSzQRonr1mt1T7RhF3DzRNQo8HqWLoNH8?=
 =?us-ascii?Q?qc4S6l0KZNYpYqlJgpBJJUGwSfMYyCtDOLFDIIoVaryMd2Lb8kYok/u9H/Hu?=
 =?us-ascii?Q?mKvDU62gz80rX6lLFSVyYCMSoriY7OXzutyKHBqxMx4Umq5Tf6ryGLzIpNfw?=
 =?us-ascii?Q?AhgFfNfhNLjyxR0CGGMRSuA79zjSiWkCWFTm/tJfO5SmSx7GCGK0Ogbl3086?=
 =?us-ascii?Q?2fIrj8BP0JzX0mRpCNUUDpk1SX4jFWp+zA8q+vjyKh4HRY+UNrNZsxYIRIHf?=
 =?us-ascii?Q?CvcxriT8bpaqLWU+kQRvtGtC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?090xko0aO6/3GjyHJP4DmDf1BlmDNwuyFpctgVLaX6x73KoeGdN4/i/IEhuO?=
 =?us-ascii?Q?kKzcbSznsCU56b+lTgI1XrFKVP3ru753UqqbxH7JjqhoV7zDfsKKl2SIvRrQ?=
 =?us-ascii?Q?Jo7Xk5jHIoM2ejhSqOS+RkjfxdcAlbxZqd7rXguq4lX1cd+Ek0rvyKIo2wgO?=
 =?us-ascii?Q?Ge10fUp81ER9UmlvDdyHZhljEbNfB688h1iiNSTw302TBBcOCp3/bUOypp42?=
 =?us-ascii?Q?AU6dzWIxkHqCTEWRVHJUeCgmH9LBQdgkTWxMCN1JlQcMO5QK9L0J1puVimrQ?=
 =?us-ascii?Q?jNj9DTq/gUTjz0RJy+WB8J9ZTnz5Uoc96D0Ips7VjOYEhTSei67hRvElKDBa?=
 =?us-ascii?Q?YLRPjmlxr5XxUUJgr5Ec6G8EE6UL7283yw/AkWiprx0/TD0JVpVU1x5gz9po?=
 =?us-ascii?Q?3p/LwAKYLAWceJfGBsDxSJZg4tEVEKXW3Xhtjufznzabe0gvA4EbdNFWRYrZ?=
 =?us-ascii?Q?0rkg8i62LWR9mg/vkdgFN9dlKs7GZ4FCjFoAs4xO8bNFGE9cFnvPeKdwbbTZ?=
 =?us-ascii?Q?RgI3lxjC7Conb5fwYTx4G60nBNcc7bDcNlS3VSS6oZoxTKc2lmxZ+bv8/rVf?=
 =?us-ascii?Q?/vfoM726zDl5OFLT/br6IXxd9Wm52VbnJQyFG4u+6d92uDf9J2o16BWTh8RU?=
 =?us-ascii?Q?jMjlhopHTflt+dDFTn4ssT/2hf8QCCJjDUXgB0fQjFAkx86EnVGXPfj3CyjN?=
 =?us-ascii?Q?syyGggk4tXxkfsZylO40EFBJrEu0LG65bIF7wcznYlx24CFa8hII7HkAoaIM?=
 =?us-ascii?Q?ILGLijfQGz9/LEcQiiG1A6jRLNgaecXLVWClqD9j7oPPhez7dDY0dDVCSu5I?=
 =?us-ascii?Q?HBUCWDfFW0+H64UJZTkkYelHXc0MX6uVbkmuJYbg+87IHYbisjIQcS4ixnj0?=
 =?us-ascii?Q?oi9K68JHgnZ+ngFeP1lcBIniVCuqhkThHsdC3yNUT0u0n9Ni0IUZDZlyixJC?=
 =?us-ascii?Q?DogflHYLdV1ks/qPEvw2Vc/8HNeAoel3o5hYSlFLX4VdcLBrsslL+viRMTu8?=
 =?us-ascii?Q?eJ5941jHi2trgL9ejgnLz+cBjubzP3TX/zVb1vGC4/VrjPCEAjhXiVM3TB3b?=
 =?us-ascii?Q?GZ8j2BIuoCX7zH2e6eb6vBLB6nTcxoNLoOikSkmVhSTJeo54a97TJ38/XMAs?=
 =?us-ascii?Q?3OwjZc0+I0JLK4M49sf0dgftfAEtxmWw+cs+JY6OI2ECee4LakXiViSUkOJG?=
 =?us-ascii?Q?fvk6L9OZWsswha4agMzq1Q3TxfmWeBv67SOMZbcHt8A3fOU7iTvJOkBS7+uz?=
 =?us-ascii?Q?dH4jPsIPEyAaAVzQ2egW6rYGLZM4/v+EIdS7KCaPIhnVKFkPWIqJNiWDa5nJ?=
 =?us-ascii?Q?ABGgPpVWuqEoKYA9ViMcZUMiCZsGbuxgLjH/4x5lDRRJ60L2+tKDbaWp+XtN?=
 =?us-ascii?Q?LXSGEnAjcJ+W4yiEYF/AldzrD6Mrk0BFvvaOmqwwDPmzI+l45Wlp8pwrgyFf?=
 =?us-ascii?Q?CtOAI0ODL8IX9YzobAzS9Kjch4jkQnqtmsH2eAf5OpnrAN4OWnEJlzFwtAJO?=
 =?us-ascii?Q?Lf8xo4FA03YLavZu/3SwJSRAgR5LMDC/I9xzsXJazSHigqT1jZc+eEEbilyE?=
 =?us-ascii?Q?eTq4CrkTsAKOT9Bt5Xkq7M4SAXgEBKhoG2jWrgZFIS4KIPrbL9bwMdDP802M?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hRpdB28O5yqGrLv8XlrpRK/u0OYuTywmKXTQO1kzrYR/umjg/FLpST7nmaKsGFZegu5f1nA/nt5/zjUJqEmleI7ZT71aDDWsoj77GK+2oeKnV2WLqOJJUh+n5KV4tqtfvdMJOoHHDrxuCJlUPYffHDsb3yDIIDH4C5SRJ7SBBpsv2PfqOaGk1cj6trTsVnz+DMME2EZG0U7UGDhuDg68op+Jegc4pQibSIgUZMYxxIkbGURh3cLuoj3FWADLVv2tvrLrKxzNC41Jbmctl9Dnvgrz+x2QgWFfxsZeGriXV6+ZMDZj15K7DPjYRoogZIwEZtHXEpy7lIOfF0a2pxHqDOYUFcu/UE87lggamt+Qimou1mZDx973LTJUN/TV3x2ZoBnMlLPxHl4GioWitQm0wBe35RHiF6WACuoI3ijTOelksPBdl4Alp5FumhH+YqJAETKEiMVW+CDaT40sYD0bepF2SWu+3M05x7RhKvlBxgp00TgCJujedsyFap38R/Az4cEvA3PSNYutLVu2D6qrxpQLsuWIYjvZLS6EQsi3ZgifKFvwx/BwDw8ner+qCgM3fhSOcEwet95RXtMQkJsqefNTUnsdNDnf3qAHw7y2E00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdccd6a-22ac-455c-255d-08dcff5f973f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:40.6121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsG+nL1mpNC6JOzcLxyUaf+Bg2r+tePj8qImxOB5wCQt7XMWzokHVOx2mm1NIeX1vWx22aRkKw94scgd+j6DMYjutXKyiRcOAismtGT/05I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-GUID: q-ZnQTNtF1NGdKq2LF_4BTj-hWqlLicE
X-Proofpoint-ORIG-GUID: q-ZnQTNtF1NGdKq2LF_4BTj-hWqlLicE

Polling in idle with poll_idle() needs TIF_POLLING_NRFLAG support,
and a cheap mechanism to do the actual polling via
smp_cond_load_relaxed_timeout().

Both of these are present on arm64. So, select ARCH_HAS_OPTIMIZED_POLL
to enable it.

Enabling this should help reduce the cost of remote wakeups, since if
the target sets TIF_POLLING_NRFLAG (as it does while polling in idle),
the scheduler does those just by setting the need-resched bit. This
contrasts with sending an IPI, and incurring the cost of handling the
interrupt on the receiver.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6dcc593..43762c68e357 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	select ARCH_HAS_OPTIMIZED_POLL
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
-- 
2.43.5


