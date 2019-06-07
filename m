Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD55394C8
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfFGSym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 14:54:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbfFGSym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 14:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a08/7CnmoGCvdW3fg/j064hE6wBqrv1dsgLNs5Wzg9M=; b=g77KJxiYIq13fiIKP/xmovj1mc
        JT2c8zGqMbdABpI0A3hLILbYAVz+2X/PXxEtlv9XKERhElZwyFcxEx05Ph1GEByYy10mr0xg1HtmB
        YX/f4IFpn75jIyGlC+J7TAtlhqeK5Sl25dU5Z2ocCI6JFx8k5Nu4dOZErYtTUzJ5QkOSZfM69kktY
        /qEeGeavT4+ij55UZR5aSM3FJW6/o+ogRzkMzlFchNt4U73T+czaVcxlpYEpwjSmMBK9bhcqX0iL5
        YOOYzjBmHd0eIooZF9eVHYkXv4PwG/+t55sznxE5/hcLV2Wx2aj+66K6o+9LgF3+ocDltkCmoNk0b
        f4mdUxSA==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sp-QE; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Fp-NV; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH v3 20/20] docs: pci: fix broken links due to conversion from pci.txt to pci.rst
Date:   Fri,  7 Jun 2019 15:54:36 -0300
Message-Id: <780cb6c2dfe860873394675df6580765ea5a2680.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some documentation files were still pointing to the old place.

Fixes: 229b4e0728e0 ("Documentation: PCI: convert pci.txt to reST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/memory-barriers.txt                    | 2 +-
 Documentation/translations/ko_KR/memory-barriers.txt | 2 +-
 drivers/scsi/hpsa.c                                  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index f70ebcdfe592..f4170aae1d75 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -548,7 +548,7 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 	[*] For information on bus mastering DMA and coherency please read:
 
-	    Documentation/PCI/pci.txt
+	    Documentation/PCI/pci.rst
 	    Documentation/DMA-API-HOWTO.txt
 	    Documentation/DMA-API.txt
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index db0b9d8619f1..07725b1df002 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -569,7 +569,7 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 
 	[*] 버스 마스터링 DMA 와 일관성에 대해서는 다음을 참고하시기 바랍니다:
 
-	    Documentation/PCI/pci.txt
+	    Documentation/PCI/pci.rst
 	    Documentation/DMA-API-HOWTO.txt
 	    Documentation/DMA-API.txt
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1bef1da273c2..53df6f7dd3f9 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7760,7 +7760,7 @@ static void hpsa_free_pci_init(struct ctlr_info *h)
 	hpsa_disable_interrupt_mode(h);		/* pci_init 2 */
 	/*
 	 * call pci_disable_device before pci_release_regions per
-	 * Documentation/PCI/pci.txt
+	 * Documentation/PCI/pci.rst
 	 */
 	pci_disable_device(h->pdev);		/* pci_init 1 */
 	pci_release_regions(h->pdev);		/* pci_init 2 */
@@ -7843,7 +7843,7 @@ static int hpsa_pci_init(struct ctlr_info *h)
 clean1:
 	/*
 	 * call pci_disable_device before pci_release_regions per
-	 * Documentation/PCI/pci.txt
+	 * Documentation/PCI/pci.rst
 	 */
 	pci_disable_device(h->pdev);
 	pci_release_regions(h->pdev);
-- 
2.21.0

