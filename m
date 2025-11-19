Return-Path: <linux-arch+bounces-14951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA27C70364
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD3323A8630
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7D34106D;
	Wed, 19 Nov 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ERUqV30j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S1MXYCyJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A362E7F08;
	Wed, 19 Nov 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569879; cv=fail; b=Wtnk+Xe0GWFnWpVokStjJial6Dk5TbIZLjZdSSJuWUwuhMDPymahs5z3C1x3IcwdqxoXWKAYL+TgL2d8qqALC2aYchv7whEcfocVg+tCedw99vtk2mIBenuCRmI+qQl7LdAaHuEKQj0V8XL2is4ztsxPdmK1ins/lGl15mMbmw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569879; c=relaxed/simple;
	bh=bhBEQ0tGAhgF+83DRiP3frFiI4+B7YhHdyjJAsJKSrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxbtaMXc1YF7d10OsMhup3KcBvZbdFZB3dHPyFxfOV6dcRzzbTwN1A5VvYCfymZXVrNZvrGlnWRRbW8Hy+srfL3TArAFicxa56+coz2w72Vhut8YIK4p33pbLQF96g8xTI7/+acwTLOvbRQt8ZqPEIsy5HixmwPX1eLZ0nSGS50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ERUqV30j; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S1MXYCyJ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEfuwn021298;
	Wed, 19 Nov 2025 16:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ieDpejtHRK5TMUnI+jG18GefiMhSjBak6bTvEFOfxeE=; b=
	ERUqV30jejIeXIT6b66R1mRpvdIbcvMMClGMZo030A0is8YjEs14YHxVvO9j3k05
	kABJZ6qWLoSbBdDW+ZUEyFSr8QNpR6BKw0fD0yq3l0eLS2dOEnLUH3FqtX+cODhf
	sxh9vVq56hnp/vNzHsUmDB9mLBipUcxfwAU1jVLZ1xKM8toObYIRjRDzpDYuEJj5
	liqInR6zEbtSZ+6+2blwxU7/yK31r1tQ3mqndB8B6OxTHpomi/f5BQTTxN5FF/YF
	SLsdNuu0SMl2KbNsWZR249Q7IrAh9F/4uwU5Htq0m/7q5bljj/NplSOjWcRN0yCn
	sGOIBNLSZVuNgifZuXuH3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej967be3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:30:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJFh8I6036004;
	Wed, 19 Nov 2025 16:30:36 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyn366c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPuHYchqZiIjCPb6lGYNVzPIRSTtHFIB0UsWK30BDNAZecMS5QBl/tB8+up/t3g28Vvcw6FgyUhcVXMRI/o0DpfsXsi5IenkeTSBGYkJYcQhtnoSg7mLS6esi0NOAbXxrNtw3fxcDCttm9EIyfUuSXrqJIvRKR13y5gSYKUycTSA251qEhVPwTaL+N4DiO0EjiMZ8ozxctd/iioW4U/ruzIe2BtmCwzHoovIrzOKA4HUtdcZRr4k+J5ujp/KPc+FKX4MkoN0rZEfRd7+7/vi3uRUcVc6qkN+BgN+mj/JxVuh+Vc1cdPyACBFTzsQxm1qfWypdW/cwGL4jxMQyOIjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVNU/CWT30o7lH3/TWDeXNmli/IPHZURBIS1aCP04PY=;
 b=QEpVs8tGM1eF4yDjNlQaciY7MZxOc5hzjg9lAJC9piPWHe5KsjZFOKxkou/zvcAV46ufmwihICm5LHdnEiwvUELOCIOpCypA+56sZBrmmz/0cst7n8GR+yABiU5435zZxuF/ER5HMjV7HwMmH7AyZqBgpUlpADFprGmgHG7qBLKI9teF1ySSPtR6N0YTrFtJ4vx6EV+StSTOy8lQFPoHcYyGS8I08QKe/9lG7Kr9E6dvI1WtxxlVkKAtbXGZ0iPOuf7HLsLlaCosgPHQNui56ErayOx6s076lK+tpG0EFrVRwSn/IPFTAzy6JsGnBTHXIjMnry3ZLUAk6OdlcMwRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVNU/CWT30o7lH3/TWDeXNmli/IPHZURBIS1aCP04PY=;
 b=S1MXYCyJlWkv77za0PLY0RxGYV5ti3d8DE+UKt8zQzkojQIRmPMq+aNZb8e1zAOI16e/QaBE/WhXRbP2AW7plggtwJmKaArAhc1/SRubu3NxZv7Y5JsEQnRABaDvd0iOukj5CcqWMGeBjIwUx/U1xPbfnqh+zMvzc8CBXMNjgV8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7840.namprd10.prod.outlook.com (2603:10b6:510:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 16:30:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:30:29 +0000
Date: Wed, 19 Nov 2025 16:30:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
        pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net,
        david@redhat.com, mhocko@suse.com, tudor.ambarus@linaro.org,
        mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, jonechou@google.com,
        rostedt@goodmis.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 00/26] Introduce meminspect
Message-ID: <6c9b0aa2-820c-4153-ad64-cd2a45f7cf32@lucifer.local>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 5316275c-7160-4756-c426-08de2788f415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?4QbAgXQJh0HfjIgjpGhaaihoS7A5wWFFy2o3bOE8ydSjUuZ6TgB4HdQMTB?=
 =?iso-8859-1?Q?TDK6TIbZqBU9OCVbDpHihjDNzsyoNXu5YxCCW87IXkv4pHbu6xu0jKOz7u?=
 =?iso-8859-1?Q?ak1qUb1/fVmFlpDz+0CtL+FyfGWMfyRb+f2A0tU9miCsP8DAGSOxifMZlR?=
 =?iso-8859-1?Q?/zHIn4+ntgo0QsMfXsdueITmNxw6qgbPcdaLrf6HJBzVOoVOByDJs8t8ih?=
 =?iso-8859-1?Q?7s7gCwx/NOgoAk2tszBNa8w2TpVg/ZoovpjheYqiK6TvroIm4isBssQE3G?=
 =?iso-8859-1?Q?uH1UpW5z5KIQpXeA8UK8iugDHwfjRpqF1io89aINz3kmNuypFGCw2NM1yG?=
 =?iso-8859-1?Q?1zSiB7SPBSwa9OIMfQjrgfAEO4LGqlWkYK/XDN8siiIMvu8yKAy9wteask?=
 =?iso-8859-1?Q?mkIi+QxRKNZasR5lvqHP7mpH67Tcg/d4JVhRx2rmpz4KM7GpUiJTcaHcM5?=
 =?iso-8859-1?Q?f6KgIrn+XrRU95PGNJS3Kt4mHsgXp6z94x5nnrFT8u+8eTkTg1RSoMzYE9?=
 =?iso-8859-1?Q?9yY0KHpP/azOKk83yFvAK1DAE01V7oG9iAY3qaE0gittlmVgOrJgfv7tqZ?=
 =?iso-8859-1?Q?6+NLIDqjj27nyJnUK6pTAlxHqxVKSrDbeim0nA0yKvqRA0NsdbBcsvizxE?=
 =?iso-8859-1?Q?hyMi9sSuvqtDLE5Grfs/0kZUy4+q16Zpe/5oX7j14L5XYfSBr0HVZ/eEmi?=
 =?iso-8859-1?Q?g5w1cxLYFIuPsTM4PqDRDcj/MufMWBa6pC/9Y0iKziOGXR+REtJEa4CUC2?=
 =?iso-8859-1?Q?5vnCNEqYP6MfUA1QWSJWgjNY5WWw/GIu7YJsvJztdmaj0aM41ZRtfEcyuS?=
 =?iso-8859-1?Q?2/bNHeIUJI803VCxGZfzBRJRKdimVjEgisbRtBm99CqCP+etI9wqoj5aEG?=
 =?iso-8859-1?Q?no3JgY9OuuGCSJ8mBMfQMh9H3eO7LshPbmgToT7v0z95chiYM7l+kGiOMR?=
 =?iso-8859-1?Q?NEa622XqPPH0H+PmwR39FVFL9JNeHFEExOK6dov7xDGdUQMga22b+WY4NY?=
 =?iso-8859-1?Q?WappOL8+oeJ3JsdknPMjbGSKCfZlXxtc8PfobJUSj/vnSWpoGrTdQT+xS+?=
 =?iso-8859-1?Q?TpxHOm073AyJUtqXYiKMnfaXtxGsVR3S3P/Np8qFCyo0cyyxlUdEQp/nXf?=
 =?iso-8859-1?Q?Rg+/Re2GYVY30oxZyap2LqbL2ddfaLqDqgMt97RF5wJwIC1zqDJj6kReYh?=
 =?iso-8859-1?Q?CzhPEQV3vKBDqR4q+iFG2w5iI2N0cAOiJO/p6nIBuX4eXynF85lk0UHG1y?=
 =?iso-8859-1?Q?Y72Gz0lSxSV63M7KpZfntWUCTuoKZMG5RDlyGw4wfMzroaTwHstj5KEoKY?=
 =?iso-8859-1?Q?Ju95mOHuKWY2FEPgJ7kilWRrqWK7ZyBkDZEW/3bp12c/ZBfB/M/jNt6LGh?=
 =?iso-8859-1?Q?8LX2Y6D8jw2Rs5qUuALFGjQwAHXqpqsMl7vQcSsNzL53ez202n5sS1CPiC?=
 =?iso-8859-1?Q?XqcAihKIHxnayvZ/Arda3pPvF8uixhucME0Zxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DuppdDKMYtLnXgtodQXfBYvEa0DGRvoKBqM6F3K95oeeWsp57P0RojAlTX?=
 =?iso-8859-1?Q?luAC0XIEWzsgfRXNiDgmNNkCD0x3VGQpbOUAyGXc9W3N67RJ7T5uInV/NE?=
 =?iso-8859-1?Q?mQ18XIT0l4ZS9GN48zEoIrG2wtPJ1flFUUwMihGSw+IeaSW6k45RasQoOb?=
 =?iso-8859-1?Q?jXvXY/yk4vBG7AGk/lx/P1IKGAxwisSVB/NzPgO1PtZH3xrPw3aSdLDRoX?=
 =?iso-8859-1?Q?G9cEpsplNk5T24zJwYOtaq+37Q1WtfH7T5ZXPWpGWXeSBe2lwDwKKxvAME?=
 =?iso-8859-1?Q?mZcUoNm4HUL1bxVmYHnkAHRM3nAFKMUzMcZVBUA3qMwlbLMJAfLS7hNyo1?=
 =?iso-8859-1?Q?7idsT+JeEalb9xyD6AysULULBwxKej55diZcYbVT9CY2W5lzTgTuyrnqHe?=
 =?iso-8859-1?Q?RUJlpVKfKO628GLGj97JgiDaejBwkpeFcot1HL4NUbqgha9cJeSF9+xDK5?=
 =?iso-8859-1?Q?NLO/W8+ytWeAvb2p8SbdAfrFuUwi6aQ5SzzCFUb/Z75vI4oM9lYMAsonOa?=
 =?iso-8859-1?Q?W14YANdeFGopUaN1ZgVN7MkNiZgI8tBqowiQCwp3D5kH4ST4hIaLM1QNZe?=
 =?iso-8859-1?Q?9TN3dIHSnSTbJCalU7aUbtHJf+csrNaEatNdaiSAERqPRr0B/u4/YsXxoy?=
 =?iso-8859-1?Q?mDQf+d9up6XWttd14iCj+hcwy/1lkG8IbK+G1pxx+z5jLIxkBTgmbIbdK7?=
 =?iso-8859-1?Q?4Hk/O8lkSmOwsedo5vsdWFCw2mCAqNWpWCio6hx3OfwUGMy+hCCFC1JwHZ?=
 =?iso-8859-1?Q?LnwP3sA56Kp0ckM70t3hXbNph9dONZMc247W7eFX/mdwAh2h+lheuJkPOj?=
 =?iso-8859-1?Q?IxSkf6SmVt9ydnnoi6DzTc2hSLJY+Ox7Nt6Z9xeCDgTf+Q/T4lCHd/KUTK?=
 =?iso-8859-1?Q?vayPArp1AtsT2xsHbZqUYlnLrKNhzRsT2JWHJ4QsKKO/XAn7kaxCXbc/Ux?=
 =?iso-8859-1?Q?6AARa+lYttQg56ywk1bS55A0t/qpGhn9zm6qmJddE7xAjk4Dwmre2g692N?=
 =?iso-8859-1?Q?rpXyhNZSxXXG4JFnNxu3JotEj7tHLMNUy+O6KuZo1WuHRFA1yFVn5oEUNr?=
 =?iso-8859-1?Q?F8qenQgB1Ax0SFKarikOgMpj4LU/Gg9yx6PMHXzJMd9xkUxNzlna0Uidu8?=
 =?iso-8859-1?Q?lMSRJTotQaKQWlB9QUWYhs5cqARYtY7ylqAeTBfFVNIBmysJkv7nJqJpQ7?=
 =?iso-8859-1?Q?BMAYNwqmOEEhqWc3xQtJFdkFbjxVPFJ9u/c42dq3mYWihaDVW2GKeZnwWE?=
 =?iso-8859-1?Q?bUdvt/pfcGh8O75wsHiQQM4EMAEn4M0hq4C38TaOWRWRRmBFE+18obVnYq?=
 =?iso-8859-1?Q?jeTJVCAtA1Yjt+leH0pqx5t36rqTxwWlblBTWiUnG67nDhd/91y9ACKZIx?=
 =?iso-8859-1?Q?YqWXjJXIkVxtg4UwlNxwp3dPYHIJYqcqaR6Tzf9mScbkyVEOyBBxP2s4Lh?=
 =?iso-8859-1?Q?ZOSVU2xTGWcODfc65fu4KQVLyySM2VyzxgCDnMQkwcisvypK9ltIeKBmvK?=
 =?iso-8859-1?Q?62vP6dJpEmCtn3qzOIYc+76Qm9YZkOV91XdfCNqVX+5HHrZFX9k1axfAS3?=
 =?iso-8859-1?Q?Z4aRMlpMqimS9pV0opodux+XBmIu4q9/NMd0Y7ZdLMkrUVfB9f6wPdmLBC?=
 =?iso-8859-1?Q?q+P+OcGsG+/1Ma8ev6KwibOZ9Y8vfJhwJ2z7QmKgahs+Uwq7A/Ya4zoQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uv3FVlpCiw+LiT9dSV+EPGIqbyy0MNYD9UgM7jJSarZMn6pR2qF1TqzZsSDFbCq+XNOkX/Feh2jmfXfZrbzSKP2zntNLUX4oK1vhLURcHCj2zaaoBa4eVdXz0NC6/WWHEoFH9+8k88i8PEQK8upF52iFrMsZu9KZHsLuXpdOe+jAJuVpfX6qly1vMq4ZGTBvwwwXgxVUd0plR7kit63rtxW6MyVg113Qpv0C947a45sCd0QuGfrRuUGvY/on4Qx03HfvV1j6TUeR0UtyvJX59sR39UfHrYFfDVyD1wuYb2fMNvRYAcCmy5Oxy3uclv1kW3Fx6WPm803CFwmTK5xnZHt+9SEdGx+rQlFknIM0J+yQxGSu8cTrwfjijCZfct6EBjBHOsuGKc0gPqVBM5+8u0Eajmi1tCgNNPru+EQba+h4+F2l4PyiYXBSyFQTcUb3iB70Ju1vv1pWYH9Dcq5Le0LUhnBWrPaY727oqceowOqmlGFiaqDZhQu7ODvW7BaIvrOsqUkAfztJA9Qr/TEAjJ7KWPkXS8YX8OvMZz5UO32RSJNLOLQ3sWfgjaGW+lkxftzXpcbvvQgVzJ1OJbqQ37szAZI569dkPX1dVFxBu9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5316275c-7160-4756-c426-08de2788f415
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:30:29.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xpAIeH5ATum/YqaxPPshGd2oEZCll79v++FtBqDbVwCCLNTaB8c81V8slJ+YquZw99jgcR659CW09rHWYArmRVyskMVerNL3l37w+yi/Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190130
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691df0ae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Oh2cFVv5AAAA:8 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=vnREMb7VAAAA:8 a=COk6AnOGAAAA:8 a=bLXd17yOAAAA:8 a=07d9gI8wAAAA:8
 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=meVymXHHAAAA:8
 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
 a=cm27Pg_UAAAA:8 a=ufHFDILaAAAA:8 a=Ikd4Dj_1AAAA:8 a=PuvxfXWCAAAA:8
 a=GvQkQWPkAAAA:8 a=AiHppB-aAAAA:8 a=pGLkceISAAAA:8 a=37rDS-QxAAAA:8
 a=9tWYmmpX5zqD_7IvvX8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=7KeoIwV6GZqOttXkcoxL:22 a=UYjydHh6ynBBc6_pBLvz:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22 a=XOuVWTVwyKTMzSnUH6Op:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2JgSa4NbpEOStq-L5dxp:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22
 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf awl=host:12098
X-Proofpoint-GUID: KAACB7-LHzNPPwrhK6esT4IFElcciOjG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX78wwkWQGah4y
 /4TEUtcYRtiwYsZ+U8MpX6bSLLz1QpkxunZqcUC6LtJ/QANc6mx8k4ylerjxE9rqGhrqg06NZha
 oe3Aeg8t1JAqK+Ld+r2w/H2ObaY/fMA3WJ1hFJSZf3i+DZ4Ab4tjXfAvJsFVu7tUu4TLZBtBfxU
 gm5gZ+ztM69HRI9VSFUXV6UnkxFBhj8ce29Zqz+Bl0L0QRO3QCM94e8OwZQ4s86hZS3LT27iKfG
 /OgFv216CRizhbeD9CnWMUWu3y95ki04ScsNsRy2IrIosXSsKsFpuFk/SkGHH3e8QKhL1t6SQIw
 134ggtTWDaElhb6JzixQzr8rc3D/MuqJ9giikzoUXZxpo5GPD7GkWM1uqTrbzO2A0ZZcMr5u5RN
 3nYHNZ+YzKPAirbc6ztB2sy2+g9pg/0ALuBI937cWI7nPLHA4LI=
X-Proofpoint-ORIG-GUID: KAACB7-LHzNPPwrhK6esT4IFElcciOjG

Hi Eugen,

You've not run scripts/get_maintainer.pl so this is missing a ton of maintainers
that you're required to send this to. This is not a great start for a huge 26
patch series that seems to want to make very significant changes.

Please try to follow proper kernel procedure.

Here's the list:

Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION PROCESS)
Bjorn Andersson <andersson@kernel.org> (maintainer:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
Mathieu Poirier <mathieu.poirier@linaro.org> (maintainer:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
Konrad Dybcio <konradybcio@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
Mike Rapoport <rppt@kernel.org> (maintainer:MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION)
Thomas Gleixner <tglx@linutronix.de> (maintainer:CPU HOTPLUG)
Peter Zijlstra <peterz@infradead.org> (maintainer:CPU HOTPLUG,commit_signer:8/46=17%,removed_lines:4/63=6%)
Kees Cook <kees@kernel.org> (maintainer:EXEC & BINFMT API, ELF,commit_signer:7/46=15%)
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER,commit_signer:1/2=50%)
Juri Lelli <juri.lelli@redhat.com> (maintainer:SCHEDULER)
Vincent Guittot <vincent.guittot@linaro.org> (maintainer:SCHEDULER)
Dietmar Eggemann <dietmar.eggemann@arm.com> (reviewer:SCHEDULER)
Steven Rostedt <rostedt@goodmis.org> (reviewer:SCHEDULER)
Ben Segall <bsegall@google.com> (reviewer:SCHEDULER)
Mel Gorman <mgorman@suse.de> (reviewer:SCHEDULER)
Valentin Schneider <vschneid@redhat.com> (reviewer:SCHEDULER)
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - CORE,commit_signer:5/46=11%,commit_signer:14/22=64%)
David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - CORE)
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
"Liam R. Howlett" <Liam.Howlett@oracle.com> (reviewer:MEMORY MANAGEMENT - CORE)
Vlastimil Babka <vbabka@suse.cz> (reviewer:MEMORY MANAGEMENT - CORE)
Suren Baghdasaryan <surenb@google.com> (reviewer:MEMORY MANAGEMENT - CORE)
Michal Hocko <mhocko@suse.com> (reviewer:MEMORY MANAGEMENT - CORE)
Petr Mladek <pmladek@suse.com> (maintainer:PRINTK,commit_signer:5/22=23%)
John Ogness <john.ogness@linutronix.de> (reviewer:PRINTK)
Sergey Senozhatsky <senozhatsky@chromium.org> (reviewer:PRINTK,added_lines:21/262=8%,removed_lines:9/89=10%)
Anna-Maria Behnsen <anna-maria@linutronix.de> (maintainer:HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS)
Frederic Weisbecker <frederic@kernel.org> (maintainer:HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS)
Brendan Jackman <jackmanb@google.com> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
Johannes Weiner <hannes@cmpxchg.org> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
Zi Yan <ziy@nvidia.com> (reviewer:MEMORY MANAGEMENT - PAGE ALLOCATOR)
Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Christoph Lameter <cl@gentwo.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Chris Li <chrisl@kernel.org> (maintainer:MEMORY MANAGEMENT - SWAP)
Kairui Song <kasong@tencent.com> (maintainer:MEMORY MANAGEMENT - SWAP)
Kemeng Shi <shikemeng@huaweicloud.com> (reviewer:MEMORY MANAGEMENT - SWAP)
Nhat Pham <nphamcs@gmail.com> (reviewer:MEMORY MANAGEMENT - SWAP)
Baoquan He <bhe@redhat.com> (reviewer:MEMORY MANAGEMENT - SWAP)
Barry Song <baohua@kernel.org> (reviewer:MEMORY MANAGEMENT - SWAP)
"Thomas Weiﬂschuh" <thomas.weissschuh@linutronix.de> (added_lines:13/207=6%)
workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)
linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM)
linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
linux-mm@kvack.org (open list:MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION)

On Wed, Nov 19, 2025 at 05:44:01PM +0200, Eugen Hristev wrote:
> meminspect is a mechanism which allows the kernel to mark specific memory
> areas for memory dumping or specific inspection, statistics, usage.
> Once regions are marked, meminspect keeps an internal list with the regions
> in a dedicated table.
> Further, these regions can be accessed using specific API by any interested driver.

Instincitivley not a great fan of exposing and manipulating memory resources to
drives in such a way but I haven't looked into this in detail here.

> Regions being marked beforehand, when the system is up and running, there
> is no need nor dependency on a panic handler, or a working kernel that can
> dump the debug information.
> meminspect can be primarily used for debugging. The approach is feasible to work
> when pstore, kdump, or another mechanism do not.
> Pstore relies on persistent storage, a dedicated RAM area or flash, which
> has the disadvantage of having the memory reserved all the time, or another
> specific non volatile memory. Some devices cannot keep the RAM contents on
> reboot so ramoops does not work. Some devices do not allow kexec to run
> another kernel to debug the crashed one.
> For such devices, that have another mechanism to help debugging, like
> firmware, kmemdump is a viable solution.
>
> meminspect can create a core image, similar with /proc/vmcore, with only
> the registered regions included. This can be loaded into crash tool/gdb and
> analyzed. This happens if CRASH_DUMP=y.
> To have this working, specific information from the kernel is registered,
> and this is done at meminspect init time, no need for the meminspect users to
> do anything.
>
> This version of the meminspect patch series includes two drivers that make use of it:
> one is the Qualcomm Minidump, and the other one is the Debug Kinfo
> backend for Android devices, reworked from this source here:
> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/android/debug_kinfo.c
> written originally by Jone Chou <jonechou@google.com>
>
> *** History, motivation and available online resources ***
>
> The patch series is based on both minidump and kmemdump previous implementations.
>
> After the three RFC kmemdump versions, considering the ML discussions, I decided to
> move this into kernel/ directory and rework it into naming it meminspect, as Thomas Gleixner
> suggested.
> I will present this version at Plumbers conference in Tokyo on December 13th:
> https://lpc.events/event/19/contributions/2080/
> I am eager to discuss it there face to face.
>
> Initial version of kmemdump and discussion is available here:
> https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
>
> Kmemdump has been presented and discussed at Linaro Connect 2025,
> including motivation, scope, usability and feasability.
> Video of the recording is available here for anyone interested:
> https://www.youtube.com/watch?v=r4gII7MX9zQ&list=PLKZSArYQptsODycGiE0XZdVovzAwYNwtK&index=14
>
> Linaro blog on kmemdump can be found here:
> https://www.linaro.org/blog/introduction-to-kmemdump/
>
> Linaro blog on kmemdump step by stem using minidump backend is available here:
> https://www.linaro.org/blog/kmemdump-step-by-step-on-qualcomm-automotive-platform/
>
> The implementation is based on the initial Pstore/directly mapped zones
> published as an RFC here:
> https://lore.kernel.org/all/20250217101706.2104498-1-eugen.hristev@linaro.org/
>
> The back-end implementation for qcom_minidump is based on the minidump
> patch series and driver written by Mukesh Ojha, thanks:
> https://lore.kernel.org/lkml/20240131110837.14218-1-quic_mojha@quicinc.com/
>
> The RFC v2 version with .section creation and macro annotation kmemdump
> is available here:
> https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
>
> The RFC v3 version with making everything static, which was pretty much rejected due to
> all reasons discussed on the public ML:
> https://lore.kernel.org/all/20250912150855.2901211-1-eugen.hristev@linaro.org/

OK so you've sent several RFC's and not cc'd the right people in any of them :/

This isn't great kernel etiquette.

>
> *** How to use meminspect with minidump backend on Qualcomm platform guide ***
>
> Prerequisites:
> Crash tool compiled with target=ARM64 and minor changes required for usual crash
> mode (minimal mode works without the patch)
> **A patch can be applied from here https://p.calebs.dev/1687bc **
> This patch will be eventually sent in a reworked way to crash tool.
>
> Target kernel must be built with :
> CONFIG_DEBUG_INFO_REDUCED=n ; this will have vmlinux include all the debugging
> information needed for crash tool.
>
> Also, the kernel requires these as well:
> CONFIG_MEMINSPECT,  CONFIG_CRASH_DUMP and the driver CONFIG_QCOM_MINIDUMP
>
> Kernel arguments:
> Kernel firmware must be set to mode 'mini' by kernel module parameter
> like this : qcom_scm.download_mode=mini
>
> After the kernel boots, and minidump module is loaded, everything is ready for
> a possible crash.
>
> Once the crash happens, the firmware will kick in and you will see on
> the console the message saying Sahara init, etc, that the firmware is
> waiting in download mode. (this is subject to firmware supporting this
> mode, I am using sa8775p-ride board)
>
> Example of log on the console:
> "
> [...]
> B -   1096414 - usb: init start
> B -   1100287 - usb: qusb_dci_platform , 0x19
> B -   1105686 - usb: usb3phy: PRIM success: lane_A , 0x60
> B -   1107455 - usb: usb2phy: PRIM success , 0x4
> B -   1112670 - usb: dci, chgr_type_det_err
> B -   1117154 - usb: ID:0x260, value: 0x4
> B -   1121942 - usb: ID:0x108, value: 0x1d90
> B -   1124992 - usb: timer_start , 0x4c4b40
> B -   1129140 - usb: vbus_det_pm_unavail
> B -   1133136 - usb: ID:0x252, value: 0x4
> B -   1148874 - usb: SUPER , 0x900e
> B -   1275510 - usb: SUPER , 0x900e
> B -   1388970 - usb: ID:0x20d, value: 0x0
> B -   1411113 - usb: ENUM success
> B -   1411113 - Sahara Init
> B -   1414285 - Sahara Open
> "
>
> Once the board is in download mode, you can use the qdl tool (I
> personally use edl , have not tried qdl yet), to get all the regions as
> separate files.
> The tool from the host computer will list the regions in the order they
> were downloaded.
>
> Once you have all the files simply use `cat` to put them all together,
> in the order of the indexes.
> For my kernel config and setup, here is my cat command : (you can use a script
> or something, I haven't done that so far):
>
> `cat memory/md_KELF1.BIN memory/md_Kvmcorein2.BIN memory/md_Kconfig3.BIN \
> memory/md_Ktotalram4.BIN memory/md_Kcpu_poss5.BIN memory/md_Kcpu_pres6.BIN \
> memory/md_Kcpu_onli7.BIN memory/md_Kcpu_acti8.BIN memory/md_Kmem_sect9.BIN \
> memory/md_Kjiffies10.BIN memory/md_Klinux_ba11.BIN memory/md_Knr_threa12.BIN \
> memory/md_Knr_irqs13.BIN memory/md_Ktainted_14.BIN memory/md_Ktaint_fl15.BIN \
> memory/md_Knode_sta16.BIN memory/md_K__per_cp17.BIN memory/md_Knr_swapf18.BIN \
> memory/md_Kinit_uts19.BIN memory/md_Kprintk_r20.BIN memory/md_Kprintk_r21.BIN \
> memory/md_Kprb22.BIN memory/md_Kprb_desc23.BIN memory/md_Kprb_info24.BIN \
> memory/md_Kprb_data25.BIN  memory/md_Khigh_mem26.BIN memory/md_Kinit_mm27.BIN \
> memory/md_Kunknown29.BIN memory/md_Kunknown30.BIN memory/md_Kunknown31.BIN \
> memory/md_Kunknown32.BIN memory/md_Kunknown33.BIN memory/md_Kunknown34.BIN \
> memory/md_Kunknown35.BIN memory/md_Kunknown36.BIN memory/md_Kunknown37.BIN \
> memory/md_Kunknown38.BIN memory/md_Kunknown39.BIN memory/md_Kunknown40.BIN \
> memory/md_Kunknown41.BIN memory/md_Kunknown42.BIN memory/md_Kunknown43.BIN \
> memory/md_Kunknown44.BIN memory/md_Kunknown45.BIN  memory/md_Kunknown46.BIN \
> memory/md_Kunknown47.BIN memory/md_Kunknown48.BIN memory/md_Kunknown49.BIN \
> memory/md_Kunknown50.BIN memory/md_Kunknown51.BIN memory/md_Kunknown52.BIN \
> memory/md_Kunknown53.BIN memory/md_Kunknown54.BIN memory/md_Kunknown55.BIN \
> memory/md_Kunknown56.BIN memory/md_Kunknown57.BIN > ~/minidump_image`
>
> Once you have the resulted file, use `crash` tool to load it, like this:
> `./crash --no_modules --no_panic --no_kmem_cache --zero_excluded vmlinux minidump_image`
>
> There is also a --minimal mode for ./crash that would work without any patch applied
> to crash tool, but you can't inspect symbols, etc.
>
> Once you load crash you will see something like this :
>       KERNEL: /home/eugen/linux-minidump/vmlinux  [TAINTED]
>     DUMPFILE: /home/eugen/a
>         CPUS: 8 [OFFLINE: 6]
>         DATE: Thu Jan  1 02:00:00 EET 1970
>       UPTIME: 00:00:25
>        TASKS: 0
>     NODENAME: qemuarm64
>      RELEASE: 6.18.0-rc2-00030-g65df2b8a0dde
>      VERSION: #33 SMP PREEMPT Mon Nov 17 13:30:54 EET 2025
>      MACHINE: aarch64  (unknown Mhz)
>       MEMORY: 0
>        PANIC: ""
> crash> log
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd4b2]
> [    0.000000] Linux version 6.18.0-rc2-00030-g65df2b8a0dde
>
> *** Debug Kinfo backend driver ***
> I don't have any device to actually test this. So I have not.
> I hacked the driver to just use a kmalloc'ed area to save things instead
> of the shared memory, and dumped everything there and checked whether it is identical
> with what the downstream driver would have saved.
> So this synthetic test passed and memories are identical.
> Anyone who actually wants to test this, feel free to reply to the patch.
> I have also written a simple DT binding for the driver.
>
> Thanks for everyone reviewing and bringing ideas into the discussion.
>
> Eugen
>
> Changelog for meminspect v1:
> - rename to meminspect
> - start on top of v2 actually, with the section and all.
> - remove the backend thing, change the API to access the table
> - move everything to kernel/
> - add dependency to CRASH_DUMP instead of a separate knob
> - move the minidump driver to soc/qcom
> - integrate the meminspect better into memblock by using a new memblock flag
> - minor fixes : use dev_err_probe everywhere, rearrange variable declarations,
> remove some useless code, etc.
>
> Changelog for RFC v3:
> - V2 available here : https://lore.kernel.org/all/20250724135512.518487-1-eugen.hristev@linaro.org/
> - Removed the .section as requested by David Hildenbrand.
> - Moved all kmemdump registration(when possible) to vmcoreinfo.
> - Because of this, some of the variables that I was registering had to be non-static
> so I had to modify this as per David Hildenbrand suggestion.
> - Fixed minor things in the Kinfo driver: one field was broken, fixed some
> compiler warnings, fixed the copyright and remove some useless includes.
> - Moved the whole kmemdump from drivers/debug into mm/ and Kconfigs into mm/Kconfig.debug
> and it's now available in kernel hacking, as per Randy Dunlap review
> - Reworked some of the Documentation as per review from Jon Corbet
>
>
> Changelog for RFC v2:
> - V1 available here: https://lore.kernel.org/lkml/20250422113156.575971-1-eugen.hristev@linaro.org/
> - Reworked the whole minidump implementation based on suggestions from Thomas Gleixner.
> This means new API, macros, new way to store the regions inside kmemdump
> (ditched the IDR, moved to static allocation, have a static default backend, etc)
> - Reworked qcom_minidump driver based on review from Bjorn Andersson
> - Reworked printk log buffer registration based on review from Petr Mladek
>
> I appologize if I missed any review comments.
> Patches are sent on top on 6.18-rc2
>
> Eugen Hristev (26):
>   kernel: Introduce meminspect
>   init/version: Annotate static information into meminspect
>   mm/percpu: Annotate static information into meminspect
>   cpu: Annotate static information into meminspect
>   genirq/irqdesc: Annotate static information into meminspect
>   timers: Annotate static information into meminspect
>   kernel/fork: Annotate static information into meminspect
>   mm/page_alloc: Annotate static information into meminspect
>   mm/show_mem: Annotate static information into meminspect
>   mm/swapfile: Annotate static information into meminspect
>   kernel/vmcore_info: Register dynamic information into meminspect
>   kernel/configs: Register dynamic information into meminspect
>   mm/init-mm: Annotate static information into meminspect
>   panic: Annotate static information into meminspect
>   kallsyms: Annotate static information into meminspect
>   mm/mm_init: Annotate static information into meminspect
>   sched/core: Annotate runqueues into meminspect
>   mm/memblock: Add MEMBLOCK_INSPECT flag
>   mm/numa: Register information into meminspect
>   mm/sparse: Register information into meminspect
>   printk: Register information into meminspect
>   remoteproc: qcom: Extract minidump definitions into a header
>   soc: qcom: Add minidump driver
>   soc: qcom: smem: Add minidump device
>   dt-bindings: reserved-memory: Add Google Kinfo Pixel reserved memory
>   meminspect: Add Kinfo compatible driver
>
>  Documentation/dev-tools/index.rst             |   1 +
>  Documentation/dev-tools/meminspect.rst        | 139 ++++++
>  .../reserved-memory/google,kinfo.yaml         |  49 ++
>  MAINTAINERS                                   |  13 +
>  drivers/remoteproc/qcom_common.c              |  56 +--
>  drivers/soc/qcom/Kconfig                      |  13 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/minidump.c                   | 272 ++++++++++
>  drivers/soc/qcom/smem.c                       |  10 +
>  include/asm-generic/vmlinux.lds.h             |  13 +
>  include/linux/memblock.h                      |   7 +
>  include/linux/meminspect.h                    | 261 ++++++++++
>  include/linux/soc/qcom/minidump.h             |  72 +++
>  init/Kconfig                                  |   2 +
>  init/version-timestamp.c                      |   3 +
>  init/version.c                                |   3 +
>  kernel/Makefile                               |   1 +
>  kernel/configs.c                              |   6 +
>  kernel/cpu.c                                  |   5 +
>  kernel/fork.c                                 |   2 +
>  kernel/irq/irqdesc.c                          |   2 +
>  kernel/kallsyms.c                             |  10 +
>  kernel/meminspect/Kconfig                     |  30 ++
>  kernel/meminspect/Makefile                    |   4 +
>  kernel/meminspect/kinfo.c                     | 289 +++++++++++
>  kernel/meminspect/meminspect.c                | 470 ++++++++++++++++++
>  kernel/panic.c                                |   4 +
>  kernel/printk/printk.c                        |  12 +
>  kernel/sched/core.c                           |   2 +
>  kernel/time/timer.c                           |   2 +
>  kernel/vmcore_info.c                          |   4 +
>  mm/init-mm.c                                  |  11 +
>  mm/memblock.c                                 |  36 ++
>  mm/mm_init.c                                  |   2 +
>  mm/numa.c                                     |   2 +
>  mm/page_alloc.c                               |   2 +
>  mm/percpu.c                                   |   2 +
>  mm/show_mem.c                                 |   2 +
>  mm/sparse.c                                   |   4 +
>  mm/swapfile.c                                 |   2 +
>  40 files changed, 1766 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/dev-tools/meminspect.rst
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>  create mode 100644 drivers/soc/qcom/minidump.c
>  create mode 100644 include/linux/meminspect.h
>  create mode 100644 include/linux/soc/qcom/minidump.h
>  create mode 100644 kernel/meminspect/Kconfig
>  create mode 100644 kernel/meminspect/Makefile
>  create mode 100644 kernel/meminspect/kinfo.c
>  create mode 100644 kernel/meminspect/meminspect.c
>
> --
> 2.43.0
>
>
>

