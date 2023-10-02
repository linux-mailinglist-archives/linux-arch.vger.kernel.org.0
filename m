Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F767B5C6C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 23:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjJBVTm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJBVTl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 17:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB570A4;
        Mon,  2 Oct 2023 14:19:38 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392LJDiQ000786;
        Mon, 2 Oct 2023 21:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gatv7sy+EOwFxHcezDJOHWDu3nM1vA3GE7rgG9QZ/KI=;
 b=GlQP1vi4L/n3i6tR1nGdk/3FPGSstrkoaNsqO4MIqQAX6UMER+faRjVDlwFX9DCxp0+1
 wiAQ48fc1fts/APs9F35r79/zWcAmhCyA9vlYUri6XeznNlLqh0QNxlECmANXFM1LdpX
 DA/5v2LmVEjll0UO0BANCz4/xTvdpJrWiLhNMt1bisI1k3crGOJ1JjxwpxfVPnev4I/r
 wCtQ8Ubva8GRIkuwA7hmAur9l/D5oaHhWIY+B9+oF8NrktxgJoY49+Kis3E9WplluL4/
 uba3lt24vcN+N71c5W9JmS8eP/Nvc06UWk/b5rEpZDTVbz+4jQ66Lx5vyxvB6P2aIrmH Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg5p3002v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 21:19:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 392LJD0T000844;
        Mon, 2 Oct 2023 21:19:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg5p3002b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 21:19:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 392K30dV005924;
        Mon, 2 Oct 2023 21:19:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0scuh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 21:19:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 392LJBht65733118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Oct 2023 21:19:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A80FB58058;
        Mon,  2 Oct 2023 21:19:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0832858057;
        Mon,  2 Oct 2023 21:19:11 +0000 (GMT)
Received: from [9.61.61.107] (unknown [9.61.61.107])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Oct 2023 21:19:10 +0000 (GMT)
Message-ID: <891957ad-453e-4c68-9c5a-7a979667543d@linux.ibm.com>
Date:   Mon, 2 Oct 2023 16:19:10 -0500
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
From:   Peter Bergner <bergner@linux.ibm.com>
In-Reply-To: <97eb2099-23c2-4921-89ac-9523226ad221@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iwOxse1LKTd-mzgBl_gDQrG6AZJZ2pID
X-Proofpoint-GUID: oXttozJ5pEGhCYcwaRXxZAKaOtCxpjge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=716 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Adhemerval, sorry for the delay in replying, I was a little under the
weather last week.


On 9/27/23 11:03 AM, Adhemerval Zanella Netto wrote:
> On 26/09/23 19:02, Peter Bergner wrote:
>> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
>> access by our __builtin_cpu_supports built-in function.  The TCB space for
>> the HWCAP entries - which are created in pairs - is an ABI extension, so
>> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
>> problematical, given distro unwillingness to apply ABI modifying patches
>> to distro point releases.  Define AT_HWCAP3 and AT_HWCAP4 in the generic
>> uapi header so they can be used in GLIBC to reserve space in the powerpc
>> TCB for their future use.
> 
> This is different than previously exported auxv, where each AT_* constant
> would have a auxv entry. On glibc it would require changing _dl_parse_auxv
> to iterate over the auxv_values to find AT_HWCAP3/AT_HWCAP4 (not ideal, 
> but doable).

When you say different, do you mean because all AUXVs exported by the kernel
*will* have an AT_HWCAP and AT_HWCAP2 entry and AT_HWCAP3/AT_HWCAP4 won't?
I don't think that's a problem for either kernel or glibc side of things.
I'm not even sure there is a guarantee that every AT_* value *must* be
present in the exported AUXV.

The new AT_HWCAP3/AT_HWCAP4 defines are less than AT_MINSIGSTKSZ, so they
don't affect the size of _dl_parse_auxv's auxv_values array size and the
AT_HWCAP3 and AT_HWCAP4 entries in auxv_values[] are already initialized
to zero today.  Additionally, the loop in _dl_parse_auxv already parses
the entire AUXV, so there is no extra work for it to do, unless and until
AT_HWCAP3 and AT_HWCAP4 start being exported by the kernel.  Really, the
only extra work _dl_parse_auxv would need to do, is add two new stores:

  GLRO(dl_hwcap3) = auxv_values[AT_HWCAP3];
  GLRO(dl_hwcap4) = auxv_values[AT_HWCAP4];



> Wouldn't be better to always export it on fs/binfmt_elf.c, along with all 
> the machinery to setup it (ELF_HWCAP3, etc), along with proper documentation?

You mean modify the kernel now to export AT_HWCAP3 and AT_HWCAP4 as zero
masks?  Is that really necessary since we don't need or have any features
defined in them yet?  GLIBC's _dl_parse_auxv doesn't really need them to
be exported either, since in the absence of the entries, it will just end
up using zero masks for dl_hwcap3 and dl_hwcap4, so everything is copacetic
even without any kernel changes.

As I mentioned, our real problem is the lead time for getting changes that
affect the user ABI into a distro release, and ppc's copy/cache of the HWCAP
masks is an ABI change.  If we wait to add this support until when we
actually have a need for HWCAP3, then we won't have any support until
the next major distro release.  However, if we can add this support now,
which I don't think is an onerous change on glibc's part, then we can
start using it immediately when Linux starts exporting them.


Peter




