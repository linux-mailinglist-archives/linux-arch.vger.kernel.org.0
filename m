Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF552BD40
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiERNrp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiERNrk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 09:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECEF1A7D02;
        Wed, 18 May 2022 06:47:39 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IDjXnC013126;
        Wed, 18 May 2022 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EDe/+pdzlxIoBylO7CAv63QnQqy0iQVd6S+YcTCmEBY=;
 b=G1D0L0FCriobg+ImnRFkAn0ORxAHPPDveSX/tTZvI28TNaxUOHFitEKLdahI5hEsXcYb
 yqKCRIaySxd0xD/41y0vsU6YHvgh+o2iFYhGuyJ6apnQ3kl8sCz6IoU9SZUdjRVWTqml
 Q2KiRoix8dIysD0cdOfdLs1x3Plp2jPyWPJLB8tK3tLjvUgZ/Z8vYdTPbN/SpUmmUlI1
 X6DK7mBYvpFWzdCHe2mbJc5a9bswjmHeSZMvptaiteZK57YxOB2lZgSDLBgNGTnduhFL
 7g+0Ik8ryVjSYLZOmPNB2MpCNMWHKjTNBJKmshevJ9Al7JKwtme5WFYvlDTxRqPvXlL8 YA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g51y8g1gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:47:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IDgQxu023010;
        Wed, 18 May 2022 13:47:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429dstn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:47:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IDlIQc49938932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:47:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBFCAA405B;
        Wed, 18 May 2022 13:47:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40AF3A4054;
        Wed, 18 May 2022 13:47:18 +0000 (GMT)
Received: from sig-9-145-66-197.uk.ibm.com (unknown [9.145.66.197])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 13:47:18 +0000 (GMT)
Message-ID: <87df1eda7d8e28f49a92def8bfe4d549494d2db0.camel@linux.ibm.com>
Subject: Re: [RFC v2 29/39] rtc: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>
Date:   Wed, 18 May 2022 15:47:17 +0200
In-Reply-To: <YoQeagVSRyaeA+vd@mail.local>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-52-schnelle@linux.ibm.com>
         <YoQeagVSRyaeA+vd@mail.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DT_VBPgHxa1GyeLQG_GScPNPzU4blgvU
X-Proofpoint-ORIG-GUID: DT_VBPgHxa1GyeLQG_GScPNPzU4blgvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=620 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-05-18 at 00:15 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 29/04/2022 15:50:49+0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> 
> I'm fine taking that this cycle if there are no dependencies. Should I?
> 

I'd say the dependency here is the first patch in the series and we
don't seem to have full consensus on this yet. So as of now I sadly
don't think so.

