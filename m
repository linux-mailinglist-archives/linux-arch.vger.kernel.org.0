Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334BF7B7404
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 00:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbjJCWNE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJCWNE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 18:13:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82158AB;
        Tue,  3 Oct 2023 15:13:01 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393M841h017578;
        Tue, 3 Oct 2023 22:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YP5wAVIPc/j/VuI7EZ2emXZX/mLoB2rjvhdkiLByvlM=;
 b=HCirntTjn/QkQiFBB4hOlGZfTF3baZd3CuljLrtOMexdxPWXvTzZA04BXAMxIayANAGA
 DrtZ/hcr09JrM/RaY3/jgdaOIXP7DH81nNrMQci1aGZL4eVG8vq6Ni+nZxyhjjEur0Md
 gYOyr6qPbJFFq2mojj+T9DS6M1E3zx2ZxfLYXIH46Ux4CPMFZ0JSHNHIAZF2ySxrp7jr
 wDWM7ohlpLE27ZsyUx1D8lLAQFELpouHm7SRlquW9gKKVqLNr4SWS/kwuCOt5vu+mvon
 zlmAuaPEobbR/rh3JV/OaO83OczxWR4Z3s4iZDPh+vH/LITJnfKEBL3uQwHa+U3RYWW6 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgu8909kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 22:12:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 393M90vj020103;
        Tue, 3 Oct 2023 22:12:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgu8909k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 22:12:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 393KhBFR010898;
        Tue, 3 Oct 2023 22:12:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q1nmd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 22:12:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 393MCfbj26673772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 22:12:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA40858058;
        Tue,  3 Oct 2023 22:12:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E05D58057;
        Tue,  3 Oct 2023 22:12:41 +0000 (GMT)
Received: from [9.61.61.107] (unknown [9.61.61.107])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Oct 2023 22:12:41 +0000 (GMT)
Message-ID: <b4864730-1b12-4dd8-b6e9-85d78dad5e34@linux.ibm.com>
Date:   Tue, 3 Oct 2023 17:12:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Language: en-US
To:     Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
References: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
 <97eb2099-23c2-4921-89ac-9523226ad221@linaro.org>
 <891957ad-453e-4c68-9c5a-7a979667543d@linux.ibm.com>
 <057366c2-ee65-441d-b2ac-f40e1d94b44e@linaro.org>
From:   Peter Bergner <bergner@linux.ibm.com>
In-Reply-To: <057366c2-ee65-441d-b2ac-f40e1d94b44e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QBv_-BKDIIjD6Ym1H1PQ2Xb6PFMUBl_I
X-Proofpoint-GUID: Tb47txw3PRJ5F1pBchWwQ_ZiRAOEEZ1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=598
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310030167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/23 9:08 AM, Adhemerval Zanella Netto wrote:
> What it is not clear to me is what kind of ABI boundary you are trying to
> preemptively add support here. The TCB ABI for __builtin_cpu_supports is
> userland only, so if your intention is just to allow gcc to work on older
> glibcs, it should be a matter to just reserve the space on tcbhead_t.

Yes, extending tcbhead_t to contain the slots for hwcap3 and hwcap4 are the
ABI extensions we are interested in, and not something that can be backported
into a distro point release.  Yes, we don't strictly need the AT_HWCAP3 and
AT_HWCAP4 kernel defines to reserve (and clear) that space in glibc, but....



> If your intention is to also add support on glibc, it makes more sense to
> already reserve it.  For __builtin_cpu_supports it should work, although
> for glibc itself some backporting would be required (to correctly showing
> the bits with LD_SHOW_AUXV).

Our intention is to also add the glibc support too once we have the
AT_HWCAP3 and AT_HWCAP4 kernel macros defined.  1) Once the defines are
there, adding the support should be pretty straight forward, so why wait?
And 2) part of the glibc and compiler support introduces a new symbol
that is exported by glibc and referenced by the compilers to ensure the
compilers *never* access the hwcap* fields in the TCB unless the glibc
supports them.  See the symbol __parse_hwcap_and_convert_at_platform used
for HWCAP/HWCAP2.  We'll need a similar one for HWCAP3/HWCAP4 and I'm
doubtful whether the distros will allow the backport of a patch that
introduces a new exported symbol from glibc in a distro point release.


Peter


