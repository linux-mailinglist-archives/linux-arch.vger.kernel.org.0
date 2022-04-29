Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1787514E18
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiD2OvV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377214AbiD2OvT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:51:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5278FFB1;
        Fri, 29 Apr 2022 07:48:00 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEa1a7038152;
        Fri, 29 Apr 2022 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+Pd3boeYYOqUdToIy6lpJJ2YBcwWkKSMUxL2UvbDusM=;
 b=A5pEsHf3aag4EZD85V5+yxcsdEm9nbT+jlW6bqD8ZrGGAsFcxcwVUtpjMR3vVhO5PCBQ
 QSAOnlsnKFKo+HwiMtx6ANYzN4uk+cyOlpAQEaY77Kf05oA6R5M3tEvwXUQaY5RVR7bk
 i6eQ3dS1iz+/6Al+ZctYsmaP4CCIUIHvrf6xzMu6CfSR5f5dDR6gzeFgAKzbqbuD5juf
 krHz1RttRZ7RQvNYtF3uAyjITEwb6rMsVMgQzKqEEd+FlpVLCsdqzaVWh5nf6k+WJ4jR
 bGJCspQj3Bz4gqpm11rl8eNCSzhjccQp1qdfanTw46f07ijauFB7j3sd7qXjoK7RQMP5 PA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvaq3c23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:47:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TEh80R028152;
        Fri, 29 Apr 2022 14:47:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93919xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:47:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TEldwX50069908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:47:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6957F5204E;
        Fri, 29 Apr 2022 14:47:39 +0000 (GMT)
Received: from sig-9-145-61-57.uk.ibm.com (unknown [9.145.61.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DAB8F5204F;
        Fri, 29 Apr 2022 14:47:38 +0000 (GMT)
Message-ID: <176948b2d0bdfc86ca91e28fe924aa7e979b3667.camel@linux.ibm.com>
Subject: Re: [PATCH 30/37] watchdog: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>
Date:   Fri, 29 Apr 2022 16:47:38 +0200
In-Reply-To: <20220429135108.2781579-55-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-55-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s58YXPn1fWE0pyyYeoMyZ31DiWJCmGAi
X-Proofpoint-GUID: s58YXPn1fWE0pyyYeoMyZ31DiWJCmGAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_07,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=506 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 15:50 +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Sorry everyone. I sent this as PATCH in error while preparing to sent
the same series as RFC. Since e-mail has no remote delete and I lack a
time machine let's just all pretend you only got the RFC.

