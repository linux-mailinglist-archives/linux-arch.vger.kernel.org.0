Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F96514CD6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377285AbiD2Obh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346129AbiD2Obg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:31:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77468A146B;
        Fri, 29 Apr 2022 07:28:18 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TED6Ad021389;
        Fri, 29 Apr 2022 14:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MWi7WiPEgqtSij4vL0heC05PrHWR8tvb+RSfjf1GRc8=;
 b=pFWFj9t2fHRFYDLNGDMtcWettJg0OtdSfkRZZwAJYTbLV1V0lUKLkwXCY3fuOPNouOye
 Xk4wkLohN6dsupOwOuPjl5qi16UmPwEPz7tAJq1OZ9PqRu+zKVVM1xl4+RetcPsCP2gT
 FGxyEhYQcZqSE4teVDOD8v2x2g1KGTM2TAt1MlYgA5kg0Cbu4ktH4gY5/UpzFsK5onA/
 qmtc/sFDNE7N1xSO143fBrkx8/2kp5ZPDuUA1rOQ950Qn+LkMPmc/tWOLJl5aqMsg5EY
 xlBfvmMILyYD1DHh2tOY6sJiTZpUqchQ4fdJKayAj9gJN+HUqT4oLzQ06uFzxeHegovF BQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtntkn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:28:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TEKu52008140;
        Fri, 29 Apr 2022 14:28:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm9391964-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 14:28:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TES9rk56295912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:28:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D1952054;
        Fri, 29 Apr 2022 14:28:09 +0000 (GMT)
Received: from sig-9-145-61-57.uk.ibm.com (unknown [9.145.61.57])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFADF5204F;
        Fri, 29 Apr 2022 14:28:08 +0000 (GMT)
Message-ID: <23b488fbf8aa6144c841b1692558b37ce5242abd.camel@linux.ibm.com>
Subject: Re: [PATCH 03/37] ACPI: add dependency on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Date:   Fri, 29 Apr 2022 16:28:08 +0200
In-Reply-To: <20220429135108.2781579-5-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m6eGKLDnvXZ9v31GsOvT-3D8hGejgRbJ
X-Proofpoint-GUID: m6eGKLDnvXZ9v31GsOvT-3D8hGejgRbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_07,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=482
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 15:50 +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As ACPI always uses I/O port access we simply depend
> on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Sorry everyone. I sent this as PATCH in error while preparing to sent
the same series as RFC. Since e-mail has no remote delete and I lack a
time machine let's just all pretend you only got the RFC.

