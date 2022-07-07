Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBB56ADE9
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiGGVsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiGGVsA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 17:48:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3230F63;
        Thu,  7 Jul 2022 14:47:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCRZY003652;
        Thu, 7 Jul 2022 21:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=mYUReDqAAtD2Mc/Slejp/JsQFVi9e1ncghZX3Vavmh0=;
 b=xnJ9jBf8Ufq6J0JVjaiWi0JryS/PVZ3dV0d11TbTkdML8UPIRmyHYhNMlt6sUKGAbpGU
 k64Gx9anLLCmwum/I538ASOgU7UbRmo0/u29MVFnQku7yXhDpqdJGknQJgZIIC+7PFfP
 6qYda/BRPr3r6+vj493eF+dScvU9YM4s8t2JLgWLYQl/zXR8xZlQ8D3ZS3wKx1kMJb2F
 Wuvi0Du4suhANFR9tbfeGAiD3ULI9Pz2yiGidy2GDPuTmHeR5W5sEf3iPLZfq0hS05mS
 g2ODR6pqBet/WF8GYQOzJ13vdtCxaIsKTlR+/B8gSHDywC5rA0KruYY4lScx0RauYNvz yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubye73u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267LjM4l030275;
        Thu, 7 Jul 2022 21:47:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 21:47:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 267LlRsY033607;
        Thu, 7 Jul 2022 21:47:27 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7c5ag-1;
        Thu, 07 Jul 2022 21:47:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-parisc@vger.kernel.org,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        linuxppc-dev@lists.ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        Matt Wang <wwentao@vmware.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arch@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        iommu@lists.linux-foundation.org,
        Denis Efremov <efremov@linux.com>,
        Mark Salyzyn <salyzyn@android.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
Date:   Thu,  7 Jul 2022 17:47:20 -0400
Message-Id: <165723020283.18731.6642678816129479253.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624155226.2889613-1-arnd@kernel.org>
References: <20220624155226.2889613-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HrfrZsc4HaH6Tm6et7M--Pti1gCHS_F-
X-Proofpoint-ORIG-GUID: HrfrZsc4HaH6Tm6et7M--Pti1gCHS_F-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 24 Jun 2022 17:52:23 +0200, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The virt_to_bus/bus_to_virt interface has been deprecated for
> decades. After Jakub Kicinski put a lot of work into cleaning out the
> network drivers using them, there are only a couple of other drivers
> left, which can all be removed or otherwise cleaned up, to remove the
> old interface for good.
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/3] scsi: BusLogic remove bus_to_virt
      https://git.kernel.org/mkp/scsi/c/9f7c2232e131
[2/3] scsi: dpt_i2o: remove obsolete driver
      https://git.kernel.org/mkp/scsi/c/b04e75a4a8a8

-- 
Martin K. Petersen	Oracle Linux Engineering
