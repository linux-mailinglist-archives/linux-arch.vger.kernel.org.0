Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEEA7CFE17
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346337AbjJSPjU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbjJSPjT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 11:39:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AE9E;
        Thu, 19 Oct 2023 08:39:18 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JFadhM006435;
        Thu, 19 Oct 2023 15:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=j0R1Ga/kpGsfsZxYDsOKQGw5axBGZpmFvBJQOoMUbIU=;
 b=GbHccPC3f5652sKQHy/rCTbSwZdvRDqPhlrZARyg/uBbQ3htwghs01EZk9vQXiMZ1GmD
 9sy8xQmnlZFD74BQGG05Ueb9OI9WAAf1IrmHHwUNxQC332qnzyY4Tj+n2jpoRmxrYkc2
 WeDa1Dm0/td6cjlpgWmHK0pft+fPJJvwVAlf0/MWeX5LT36I+Bk9YW25QvxV16rU/xfo
 8AWWem0HqL791Vq5LTm3YbSspcyMHAGUgz5QoELfYCzbHvwuoS+rO8A2Md4aoeS5Xmt2
 mR8bisLHydthj/dLUvxrgr/2ltm5GP0Mrls12vdWfQ4ODDTWQ7qopib6tQ4JlOHELK13 sg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu71q0thp-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 15:38:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JEin6J030742;
        Thu, 19 Oct 2023 15:32:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr7hk1bbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 15:32:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JFW8NC44368204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 15:32:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE89020043;
        Thu, 19 Oct 2023 15:32:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A2FE20040;
        Thu, 19 Oct 2023 15:32:07 +0000 (GMT)
Received: from osiris (unknown [9.171.41.136])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 15:32:07 +0000 (GMT)
Date:   Thu, 19 Oct 2023 17:32:05 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        amd-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 2dac75696c6da3c848daa118a729827541c89d33
Message-ID: <20231019153205.9160-A-hca@linux.ibm.com>
References: <202310190456.pryB092r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310190456.pryB092r-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pLCVHeZl1pGGUcpHU0HZgqokDhWlFOun
X-Proofpoint-GUID: pLCVHeZl1pGGUcpHU0HZgqokDhWlFOun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_14,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=702
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 19, 2023 at 04:07:35AM +0800, kernel test robot wrote:
> arch/s390/include/asm/ctlreg.h:129:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
> arch/s390/include/asm/ctlreg.h:80:9: warning: array subscript 0 is outside array bounds of 'struct ctlreg[0]' [-Warray-bounds=]
...
> |-- s390-defconfig
> |   `-- arch-s390-include-asm-ctlreg.h:warning:array-subscript-is-outside-array-bounds-of-struct-ctlreg
...
> s390                                defconfig   gcc  

I'm wondering how this warning can appear in the builds. array-bounds
warnings are explicitly disabled, see init/Kconfig: CC_NO_ARRAY_BOUNDS. And
as expected, if I compile the kernel with gcc, defconfig, and with or
without W=1 the option -Wno-array-bounds is passed to the compiler.

And also as expected I do not see the above warnings.

So something is quite odd here.
