Return-Path: <linux-arch+bounces-8960-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2179C33E2
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A911F213DE
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B0136347;
	Sun, 10 Nov 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f00ljkgJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6E12D758;
	Sun, 10 Nov 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258341; cv=none; b=o5X/Sjet/606OGMpo+SxTe0w3C5/5jbxehTrwDSF2h3QiB0X2HlNr0WN758w+fLlf4oZGJEwTj7YgMvnimYrQ5iE1DaZvYkgcxN3DUdVpLC8yi976tnj73iZlQju5DNQG7XxUXyamVjoBy5G2bwoHJuXeuSkB/r9GjP9dUGr/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258341; c=relaxed/simple;
	bh=Zh43aHcr41VN7hfnjL4eA6KL8O6ghcfl65fvv/diVUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV6W9FxdsfXUyzTn6wknyT+sZn5crQrcUSZCjFFWdSM0B3jAQeDLPBKAglDLQFU2xQcNmQ/ryIaNeL5/4E5pWBuJPyF/KCuGeeVR+zNSzhFDekKKvtvEMP0xsFW5k7uD7eqT5/2LOp154pE+SXvlx/ZobKrwuNMzxTZlAOi+y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f00ljkgJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AADb9lj029404;
	Sun, 10 Nov 2024 17:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/MQhKShWGkxbTeinh+Z0QoTvscc1CN
	ozq3b2Qju3K/M=; b=f00ljkgJCYMVH/kIe+h8R2/uVkFz0lul6v37QQbffmXg9V
	13J+Tny2uwtcAn1tdkAd0oFWC2x7QZshmRznr6kNomzynShHN/tnZIZ7hbHYTWJj
	MqspCoxfMk8PlanhbxxBQdRBBsGwS62xIWKgCAa62k4bjjwUDU93/tla1lRL9e4k
	kVkHExNntK1pkjk9obsOP2u8VGBYYucCjXQMZerF+aFHKvnAxZ601c5w8IUw4LDG
	JB1oyOFrxzNOwpy8enC54iE+pCTg7DOw0/1+fTj9YFCEHcaMDQ1y3yzkiNbHy8cN
	MXNY5qIkZHjp1m48WMkl1ZX5vLrwEhQ7H3SUFKHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tpvmsd2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AAH5TLr016963;
	Sun, 10 Nov 2024 17:05:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tpvmsd2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA3FxuE004065;
	Sun, 10 Nov 2024 17:05:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms10uc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AAH5QGw58130722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 17:05:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8705E20049;
	Sun, 10 Nov 2024 17:05:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBBB20040;
	Sun, 10 Nov 2024 17:05:25 +0000 (GMT)
Received: from osiris (unknown [9.171.74.231])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Nov 2024 17:05:25 +0000 (GMT)
Date: Sun, 10 Nov 2024 18:05:24 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v19 11/19] s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
Message-ID: <20241110170524.6661-C-hca@linux.ibm.com>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
 <173125385879.172790.60734156759309440.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173125385879.172790.60734156759309440.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zz-6mYj45FElpJcXUgDWkm5Iza_ji5jI
X-Proofpoint-GUID: GFyYZ8N9EpRadcR7Uav-c2AYEabtmZET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=474 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100151

On Mon, Nov 11, 2024 at 12:50:58AM +0900, Masami Hiramatsu (Google) wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Add ftrace_graph_func() which is required for fprobe to access registers.
> This also eliminates the need for calling prepare_ftrace_return() from
> ftrace_caller().
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  Changes in v19:
>   - Newly added.
> ---
>  arch/s390/Kconfig              |    1 +
>  arch/s390/include/asm/ftrace.h |    5 ++++
>  arch/s390/kernel/entry.h       |    1 -
>  arch/s390/kernel/ftrace.c      |   48 ++++++++++++----------------------------
>  arch/s390/kernel/mcount.S      |   11 ---------
>  5 files changed, 20 insertions(+), 46 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

