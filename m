Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD88514E3D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377918AbiD2Ow3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377247AbiD2Ow2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:52:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65011A8898;
        Fri, 29 Apr 2022 07:49:10 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEfZUf004938;
        Fri, 29 Apr 2022 14:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4ZnB8z/kqQsBnlmxLzPpVnOItllUAOgHvLRoMPq1TDQ=;
 b=jGBy5OHwSF2zWBA7opNO8ELtwNwMge99Y/T322q60dkr2spZiZpHs+yG8P+uorMs0vD7
 TK5wNu19IVYvLNVdiGYac0pwIW1A92FF1IBxzvo91YsJ82zFUYzbMPAcVjzbKjjcrd6k
 I6VcriFzC/CqtuKeaFOq5cwVEcCeDd89qxKjP47wEL3tcTCMpqJx7RrIHGP2gEmpruMp
 MrezWxhMtPyOdzPG6rZhJ8dBlTJ0n0U2ofJcd5/mGlo8CJ5UKNW2qeWUR4M3wjWSFer0
 qIwC6FXPTwz5uXqVdkG2JrwGfs1Fr9sfPEMEJs2AReDtw6aimdXaktTEW0hY+kRIVfYR Tw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3frj0m04hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:49:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TEgn3e020603;
        Fri, 29 Apr 2022 14:49:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm939194v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:49:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TEn1dD49217884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:49:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DE76A404D;
        Fri, 29 Apr 2022 14:49:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABAEAA4040;
        Fri, 29 Apr 2022 14:49:00 +0000 (GMT)
Received: from sig-9-145-61-57.uk.ibm.com (unknown [9.145.61.57])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 14:49:00 +0000 (GMT)
Message-ID: <93f2b6dbbde62a0c35f5f7d6c7a32c80462cfa7b.camel@linux.ibm.com>
Subject: Re: [PATCH 35/37] /dev/port: don't compile file operations without
 CONFIG_DEVPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 29 Apr 2022 16:49:00 +0200
In-Reply-To: <20220429135108.2781579-64-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-64-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jmL8ucFbjNXb2ixY57AaqrqsGUZ8j3Ik
X-Proofpoint-ORIG-GUID: jmL8ucFbjNXb2ixY57AaqrqsGUZ8j3Ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_07,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=671 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 15:51 +0200, Niklas Schnelle wrote:
> In the future inb() and friends will not be available when compiling
> with CONFIG_HAS_IOPORT=n so we must only try to access them here if
> CONFIG_DEVPORT is set which depends on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Sorry everyone. I sent this as PATCH in error while preparing to sent
the same series as RFC. Since e-mail has no remote delete and I lack a
time machine let's just all pretend you only got the RFC.

