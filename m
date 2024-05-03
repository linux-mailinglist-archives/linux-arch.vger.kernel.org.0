Return-Path: <linux-arch+bounces-4160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1348BA6C8
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 08:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529CF1C21E7B
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE1139CE5;
	Fri,  3 May 2024 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U0Fo00mN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A1139CE0;
	Fri,  3 May 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716069; cv=none; b=TAjdXJ/CZxLYBlMrIEHNbCffvIPr9+BG7qxu0nbgO4n6UTF533DH6RtdJqTihnMXmxYo8Z+q9DWPEqL2pgkgqLlCocVB7Sz66Zb1VxWcA60crvO3+cKiZ88iIw5vUqT0e9TjM3U/IVKP8lvzbaVUNl4s+aPMp3Eyj3rvdYjK5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716069; c=relaxed/simple;
	bh=DPsdH3zT5urvwafVvXpNTNuL6PYPYbkxu+maScMGS5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ipr/BMpTVpabr2fEG5HdW+8hhuQ3nvEP2hmfAZIOB+lHC0TaM5iME2p8syx0NRP5b0tJrDR65FkU0UByw0W+U5z15Fq9rwp6EX56dVVqwPAilO9me/uu8IVI1Ng2yzV3PPyfZaByAHW2DJ5L4bDW7TZDnTPa/9h+CvEHDsiiNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U0Fo00mN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4433a53G004818;
	Fri, 3 May 2024 06:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=noN7kBLxq9TVGdHUBmY+gSoaFbzmaEzOs2TwYGDA4NA=; b=U0
	Fo00mN+XXjGU8b/VaAv8ENQXxmXztOCDwkY1Qe1bQiafxAnopThnVdYwUX/Jf4Aa
	xATL/sB5o1OokTs7y0NcRSRY1KEkcpwI84k40q31WC41CUkzv5Hg6utRT/K29FQv
	pyuyOIwGZSfxj8AdrnRprofbH4RRj37b6KJDFo9P6EIGzu8K9KI3O7QDjOG2j4sJ
	QjLUjeBQnrW6xQ49pG1m6ZYYd0u2BV8/dmUVxuEzs1gSxRTZ+wq4qbOMkncesqUt
	5PiFQWkY3M1pYZi5qYpZqyQd5uOIC8tp9Bs3zlkoJHEd50J/HNOPb4wC+J73gPP7
	eO02QrtSpjm4vE6TKdDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv6q0td3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 06:00:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44360wPC008346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 06:00:58 GMT
Received: from [10.216.13.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 23:00:54 -0700
Message-ID: <d7f7cfae-78d5-41aa-aaf9-0d558cdfcbea@quicinc.com>
Date: Fri, 3 May 2024 11:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] BUILD REGRESSION
 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
To: Greg KH <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List
	<linux-mm@kvack.org>,
        <amd-gfx@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
        <intel-xe@lists.freedesktop.org>, <linux-arch@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>
References: <202405030439.AH8NR0Mg-lkp@intel.com>
 <2024050342-slashing-froth-bcf9@gregkh>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2024050342-slashing-froth-bcf9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6_fT_RHzM9at2lNZPzBwfaLMctBtVtb
X-Proofpoint-GUID: O6_fT_RHzM9at2lNZPzBwfaLMctBtVtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=726 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030041



On 5/3/2024 10:42 AM, Greg KH wrote:
> Ok, I'm getting tired of seeing these for the USB portion of the tree,
> so I went to look for:
> 
> On Fri, May 03, 2024 at 04:44:42AM +0800, kernel test robot wrote:
>> |-- arc-randconfig-002-20240503
>> |   `-- drivers-usb-dwc3-core.c:warning:variable-hw_mode-set-but-not-used
> 
> This warning (same for all arches), but can't seem to find it anywhere.
> 
> Any hints as to where it would be?
> 

Hi Greg,

  I think the hw_mode was not removed in hs_phy_setup and left unused.

  Thinh reported the same when there was a merge conflict into linux 
next (that the hw_mode variable was removed in ss_phy_setup and should 
be removed in hs_phy_setup as well):

https://lore.kernel.org/all/20240426213923.tyeddub4xszypeju@synopsys.com/

  Perhaps that was missed ?

Regards,
Krishna,

