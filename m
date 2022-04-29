Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA1514E38
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376275AbiD2Owx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbiD2Oww (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:52:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73AAB89B5;
        Fri, 29 Apr 2022 07:49:31 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDsA3K015859;
        Fri, 29 Apr 2022 14:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xoywMIV1matZOHY8izfXpbGzTngIRjvpfi88UXGscU0=;
 b=lTlsTIJwxQOY8VeQz+Hpos1Oi3zycc/3coARHSS9dg8mTmBlrZHxNhBzR9WjO/lGvjnu
 sFUSJtWdChJMDTeM3YB2j1PolHgCZYwJ0qvuBUERuYCfoPeuLzLpdRvi2lI7y9fz/Cef
 f3wLxBCFN7MhBwmtMTlKuAgvV0dDRzQJ+dGLflRSu+MRIJ02FzR4tI9ZZliVZtK83yB7
 YtUbKNaMWBMimazGTOmeBSkRXtOnfL0wFlCKz+Vq7hfOtMF4UTxHl8BZxFyT1IWsIXQJ
 4LV5yjpYA7TcYKsTU02o98r5a+1xi1Ovkv6yUCXDu6O4aY1yiTXAF2aAvXwrXJK0Loaz jg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fque1dwns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:49:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TEgh4W028005;
        Fri, 29 Apr 2022 14:49:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm9391a0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:49:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TEaCmn48628194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:36:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49E7511C050;
        Fri, 29 Apr 2022 14:49:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE9C11C04C;
        Fri, 29 Apr 2022 14:49:20 +0000 (GMT)
Received: from sig-9-145-61-57.uk.ibm.com (unknown [9.145.61.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 14:49:20 +0000 (GMT)
Message-ID: <c557350bdcb1fc2bf73aa30dd631d198f41a5071.camel@linux.ibm.com>
Subject: Re: [PATCH 36/37] usb: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Date:   Fri, 29 Apr 2022 16:49:20 +0200
In-Reply-To: <20220429135108.2781579-66-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-66-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UN4aB-gpZNQg5N9UU37zP7etRSe9_sx1
X-Proofpoint-GUID: UN4aB-gpZNQg5N9UU37zP7etRSe9_sx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_07,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=438 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204290080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 15:51 +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to guard sections of code calling them
> as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> drivers requiring these functions need to depend on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Sorry everyone. I sent this as PATCH in error while preparing to sent
the same series as RFC. Since e-mail has no remote delete and I lack a
time machine let's just all pretend you only got the RFC.

