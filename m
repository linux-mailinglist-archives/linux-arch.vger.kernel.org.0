Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA8A516C0D
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383760AbiEBIep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379416AbiEBIen (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 04:34:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BF17E34;
        Mon,  2 May 2022 01:31:14 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2428ADh1031464;
        Mon, 2 May 2022 08:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=doxriEulTiZsDY7ZIJpyPf8vZ1hJT5S/w2opti4Vq4o=;
 b=B04jwbyGwEyCVU6Nwhnj41IfBNVTRlBTEXB5HszJ3Y/gddaSN2J/qrmiIOq4pDsEos/x
 gWeF5rMoq9SamjXl836zKxP0Em/gzVFcE8jPbjLPPhQ51buM48D+oykeRmQS7VRhDPP/
 WP4KZqoSdK9169OMX2X8JOMgE6a9hgTUbvjzPeFvDRySodWChXImEF+S5zb1SskPaDUm
 fByB9hbD31HJP2c26KY6BFIda5VFWKWgIMlf4m5XaztWcMhhamRLxYVu//pTHfTe/zaS
 YKmik1zCXZbZl6v+SHdHv7le0V905pO47wbY29jX99gwZQKC/TRWcMThI95jikowlCTe 0Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fta1bj0ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 08:31:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2428TtqS014959;
        Mon, 2 May 2022 08:31:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3frvr8tc9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 08:31:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2428V1G858720618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 08:31:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2315C5204E;
        Mon,  2 May 2022 08:31:01 +0000 (GMT)
Received: from sig-9-145-11-74.uk.ibm.com (unknown [9.145.11.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C42FE5204F;
        Mon,  2 May 2022 08:31:00 +0000 (GMT)
Message-ID: <c3b98e9503abaeac9e4eeca9b7539b60a612b5e6.camel@linux.ibm.com>
Subject: Re: [RFC v2 16/39] leds: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Date:   Mon, 02 May 2022 10:31:00 +0200
In-Reply-To: <20220429185435.GB2597@duo.ucw.cz>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
         <20220429135108.2781579-29-schnelle@linux.ibm.com>
         <20220429185435.GB2597@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5yBLo7nQfOdQG8vDLxFa5rJeNNlJ3XOX
X-Proofpoint-ORIG-GUID: 5yBLo7nQfOdQG8vDLxFa5rJeNNlJ3XOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=297 adultscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-04-29 at 20:54 +0200, Pavel Machek wrote:
> Hi!
> 
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> I don't see a problem there.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> (Its marked RFC so I'm not taking the patch.. right?)
> 
> Best regards,
> 								Pavel

Right and thank you.

