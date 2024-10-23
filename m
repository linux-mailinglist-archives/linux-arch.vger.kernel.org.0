Return-Path: <linux-arch+bounces-8490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1259AD2ED
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5B31C21A31
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900D91CCB31;
	Wed, 23 Oct 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a1i4A9yg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177C1E51D;
	Wed, 23 Oct 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704545; cv=none; b=FKGcoOhPH5jAXur/gvFtzlfZ6c5GNKmy1NN71oKzg4un23S/iPI9dXClWBqeRWZH1AKtEaMwrLy4rUwIfEJlTVQRHZZmS5mJuBoSihEdA0TWjut17Pcu/W6T2O5cTKk/mrOKqjfLfISuc+nZMsDcHn4ohJytxPcHSJFPiTbb8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704545; c=relaxed/simple;
	bh=k2Bj3VXPR0ZuBfvyPjLK8zR/CYVAAN8k3ytdAnEmoWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c0omQgSM19gFIBg+gWI/vS7YSzh19ac/DcqQrUTJl7TMIrzGLQNdnNMgQd/z3TDL28y4ZTd2exTxfviinXYOm2/qS6So/oZqP4UfwkaZ9pRvNV3Jc1GbNj2u/Fm27u65PEW87Qb3+EjgJrbfrLT8cBWGy89ms3WFtjbW8XeYkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a1i4A9yg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9xkfL025452;
	Wed, 23 Oct 2024 17:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3fD3aX3zs17RkkSDvbOeJ48quwFT5oEexv/xr8A200k=; b=a1i4A9ygluEtdPU8
	j5d1F9tWSvBP2gnqPt7x2SrbEZDnVD3noHOF86qM2xlgYRlFspks/ewRHORBF1cg
	8fvzZUeCM3xK8io/++eai+HQ8+xmKFIf5vaDr+VgmU7pFSazOjFzjTiwMSqKtsN6
	JsBYs17BPyo8kLyxIFM4xwHSVpOq/z6ALTtWEErB47w8Lbz7E69zm61sDXJIPuDK
	1M+69Nl85oUL8t3eZVeG1niMoH5X67fS6g8pJPue19ctEozw4DGoc0YahQ6fJ77t
	OWV3C0hdmYY/+4l6Bf5dRAyRyQa1Ngg3vAmVTctDQH3YSIxEsoo6V8G/BStIhNwv
	qfU/hw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41tyn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:28:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NHSnVG008769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:28:49 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 10:28:49 -0700
Message-ID: <368aa911-7a88-4a00-8830-4a183fd6f352@quicinc.com>
Date: Wed, 23 Oct 2024 10:28:49 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: add new kallsyms selftests
To: Luis Chamberlain <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <petr.pavlu@suse.com>,
        <samitolvanen@google.com>, <da.gomez@samsung.com>
CC: <masahiroy@kernel.org>, <deller@gmx.de>, <linux-arch@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <kris.van.hees@oracle.com>
References: <20241021193310.2014131-1-mcgrof@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241021193310.2014131-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hOul45tTK3b2ScIrQNG3txmXPHvd1B2q
X-Proofpoint-ORIG-GUID: hOul45tTK3b2ScIrQNG3txmXPHvd1B2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=900 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230109

On 10/21/24 12:33, Luis Chamberlain wrote:
...
> +gen_template_module_exit()
> +{
> +	cat <<____END_MODULE
> +static int __init auto_test_module_init(void)
> +{
> +	return auto_runtime_test();
> +}
> +module_init(auto_test_module_init);
> +
> +static void __exit auto_test_module_exit(void)
> +{
> +}
> +module_exit(auto_test_module_exit);
> +
> +MODULE_AUTHOR("Luis Chamberlain <mcgrof@kernel.org>");
> +MODULE_LICENSE("GPL");
> +____END_MODULE
> +}

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Is that a concern here?
Should we add a MODULE_DESCRIPTION()?

/jeff

