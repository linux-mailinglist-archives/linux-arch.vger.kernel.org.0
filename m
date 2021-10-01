Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503941F494
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355801AbhJASPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355815AbhJASOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6FEC0613E2;
        Fri,  1 Oct 2021 11:13:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oj15-20020a17090b4d8f00b0019f8860d6e2so823283pjb.5;
        Fri, 01 Oct 2021 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZ8+vjgDy9kw2gHjiqwgXRboYBPVO+HI6NRlplglmj8=;
        b=IlnSzdiLjPho2Ike4x8jNoU8mIrxXmY38u16kS7eGgjbbTxqJtd0tkfv2uXr+9WOEO
         khl3n7sZ9Tt80iF4wK4LRn/540zE7jW3idOGx+qPLxQfK0To6qValMahgOChuvNWXZIy
         8gOlNUvzDS2N0R1VkJzAuTJIxoUqraF8Sz5e/EPF59Qh70Ckf2dQADmqkGn1JQrc9kbL
         0FdP77EJCPVdseBbszFHuGYlzHmMHZDqvGHR/l/xg/YNdn7Sb0aCBa+T2TwLXzw0aTQQ
         s7CmzK9f+Q1Or7w/gIQHqXOxUA3rYTU/tIdVjY9G3yrKLSbv/tHx2tZGG8BBazFYJvYr
         RAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZ8+vjgDy9kw2gHjiqwgXRboYBPVO+HI6NRlplglmj8=;
        b=A0xc/Y88dVgzeew58LKlVga6Ax9KmRjVx61WBrFzesQErrClteBeBeGp6tX/JGYvli
         fpRvnfMyisiGtDYtN9H4Czo+02PIUg/mvVXgBrX6jL67wSHJt0hrt5b4hcVr1U7Ju1NS
         Iu08PE5iUDYWfyWGlj3C0TA6AEBdU1oCIbysrs6d7i270iY4pt9pF4oQQB9L+WQ8mcUs
         upy+JOBF4HO9z1e79Zw90T0dlhHSpoOk7BT4D3RWFelB/SaZP6XKLBzrRul0llfA0jho
         xQp7Z0SdN/cyI+B5pc6wrxv9tOGZmvLcN1zVLjMSv+6jy/PLanh4JKmd3yLvuDwMMI5R
         Ng1w==
X-Gm-Message-State: AOAM533Lisnsj6xeKH0YxyufY1CUKwso8q8jmMMuy/d9BdpwtD2WsDeg
        unnX7dVy+bX6dAg3HvopjGA=
X-Google-Smtp-Source: ABdhPJzy58tUXUnZzbMA7VWyWu67BArti2kasBmj1/7wKyNpGd6rUu2o7tJFvcrftCsTY3pCiv/SJg==
X-Received: by 2002:a17:902:7684:b0:13d:e9ec:b467 with SMTP id m4-20020a170902768400b0013de9ecb467mr10553913pll.77.1633111987245;
        Fri, 01 Oct 2021 11:13:07 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d12sm7255213pgf.19.2021.10.01.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 07/16] all: replace find_next{,_zero}_bit with find_first{,_zero}_bit where appropriate
Date:   Fri,  1 Oct 2021 11:12:36 -0700
Message-Id: <20211001181245.228419-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_first{,_zero}_bit is a more effective analogue of 'next' version if
start == 0. This patch replaces 'next' with 'first' where things look
trivial.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/powerpc/platforms/pasemi/dma_lib.c |  4 ++--
 arch/s390/kvm/kvm-s390.c                |  2 +-
 drivers/block/rnbd/rnbd-clt.c           |  2 +-
 drivers/dma/ti/edma.c                   |  2 +-
 drivers/iio/adc/ad7124.c                |  2 +-
 drivers/infiniband/hw/irdma/hw.c        | 16 ++++++++--------
 drivers/media/cec/core/cec-core.c       |  2 +-
 drivers/media/mc/mc-devnode.c           |  2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c            | 10 +++++-----
 drivers/soc/ti/k3-ringacc.c             |  4 ++--
 drivers/tty/n_tty.c                     |  2 +-
 drivers/virt/acrn/ioreq.c               |  3 +--
 fs/f2fs/segment.c                       |  8 ++++----
 fs/ocfs2/cluster/heartbeat.c            |  2 +-
 fs/ocfs2/dlm/dlmdomain.c                |  4 ++--
 fs/ocfs2/dlm/dlmmaster.c                | 18 +++++++++---------
 fs/ocfs2/dlm/dlmrecovery.c              |  2 +-
 fs/ocfs2/dlm/dlmthread.c                |  2 +-
 lib/genalloc.c                          |  2 +-
 net/ncsi/ncsi-manage.c                  |  4 ++--
 21 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 270fa3c0d372..26427311fc72 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -375,7 +375,7 @@ int pasemi_dma_alloc_flag(void)
 	int bit;
 
 retry:
-	bit = find_next_bit(flags_free, MAX_FLAGS, 0);
+	bit = find_first_bit(flags_free, MAX_FLAGS);
 	if (bit >= MAX_FLAGS)
 		return -ENOSPC;
 	if (!test_and_clear_bit(bit, flags_free))
@@ -440,7 +440,7 @@ int pasemi_dma_alloc_fun(void)
 	int bit;
 
 retry:
-	bit = find_next_bit(fun_free, MAX_FLAGS, 0);
+	bit = find_first_bit(fun_free, MAX_FLAGS);
 	if (bit >= MAX_FLAGS)
 		return -ENOSPC;
 	if (!test_and_clear_bit(bit, fun_free))
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6a6dd5e1daf6..59459960ec3a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2019,7 +2019,7 @@ static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
 	while ((slotidx > 0) && (ofs >= ms->npages)) {
 		slotidx--;
 		ms = slots->memslots + slotidx;
-		ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, 0);
+		ofs = find_first_bit(kvm_second_dirty_bitmap(ms), ms->npages);
 	}
 	return ms->base_gfn + ofs;
 }
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index bd4a41afbbfc..5864c9b46cb9 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -196,7 +196,7 @@ rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
 		return per_cpu_ptr(sess->cpu_queues, bit);
 	} else if (cpu != 0) {
 		/* Search from 0 to cpu */
-		bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
+		bit = find_first_bit(sess->cpu_queues_bm, cpu);
 		if (bit < cpu)
 			return per_cpu_ptr(sess->cpu_queues, bit);
 	}
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f1..caa4050ecc02 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1681,7 +1681,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 			dev_dbg(ecc->dev, "EMR%d 0x%08x\n", j, val);
 			emr = val;
-			for (i = find_next_bit(&emr, 32, 0); i < 32;
+			for (i = find_first_bit(&emr, 32); i < 32;
 			     i = find_next_bit(&emr, 32, i + 1)) {
 				int k = (j << 5) + i;
 
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e45c600fccc0..bc2cfa5f9592 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -347,7 +347,7 @@ static int ad7124_find_free_config_slot(struct ad7124_state *st)
 {
 	unsigned int free_cfg_slot;
 
-	free_cfg_slot = find_next_zero_bit(&st->cfg_slots_status, AD7124_MAX_CONFIGS, 0);
+	free_cfg_slot = find_first_zero_bit(&st->cfg_slots_status, AD7124_MAX_CONFIGS);
 	if (free_cfg_slot == AD7124_MAX_CONFIGS)
 		return -1;
 
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7de525a5ccf8..eea6bf9360d3 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1704,14 +1704,14 @@ static enum irdma_status_code irdma_setup_init_state(struct irdma_pci_f *rf)
  */
 static void irdma_get_used_rsrc(struct irdma_device *iwdev)
 {
-	iwdev->rf->used_pds = find_next_zero_bit(iwdev->rf->allocated_pds,
-						 iwdev->rf->max_pd, 0);
-	iwdev->rf->used_qps = find_next_zero_bit(iwdev->rf->allocated_qps,
-						 iwdev->rf->max_qp, 0);
-	iwdev->rf->used_cqs = find_next_zero_bit(iwdev->rf->allocated_cqs,
-						 iwdev->rf->max_cq, 0);
-	iwdev->rf->used_mrs = find_next_zero_bit(iwdev->rf->allocated_mrs,
-						 iwdev->rf->max_mr, 0);
+	iwdev->rf->used_pds = find_first_zero_bit(iwdev->rf->allocated_pds,
+						 iwdev->rf->max_pd);
+	iwdev->rf->used_qps = find_first_zero_bit(iwdev->rf->allocated_qps,
+						 iwdev->rf->max_qp);
+	iwdev->rf->used_cqs = find_first_zero_bit(iwdev->rf->allocated_cqs,
+						 iwdev->rf->max_cq);
+	iwdev->rf->used_mrs = find_first_zero_bit(iwdev->rf->allocated_mrs,
+						 iwdev->rf->max_mr);
 }
 
 void irdma_ctrl_deinit_hw(struct irdma_pci_f *rf)
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 551689d371a7..7322e7cd9753 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -106,7 +106,7 @@ static int __must_check cec_devnode_register(struct cec_devnode *devnode,
 
 	/* Part 1: Find a free minor number */
 	mutex_lock(&cec_devnode_lock);
-	minor = find_next_zero_bit(cec_devnode_nums, CEC_NUM_DEVICES, 0);
+	minor = find_first_zero_bit(cec_devnode_nums, CEC_NUM_DEVICES);
 	if (minor == CEC_NUM_DEVICES) {
 		mutex_unlock(&cec_devnode_lock);
 		pr_err("could not get a free minor\n");
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index f11382afe23b..680fbb3a9340 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -217,7 +217,7 @@ int __must_check media_devnode_register(struct media_device *mdev,
 
 	/* Part 1: Find a free minor number */
 	mutex_lock(&media_devnode_lock);
-	minor = find_next_zero_bit(media_devnode_nums, MEDIA_NUM_DEVICES, 0);
+	minor = find_first_zero_bit(media_devnode_nums, MEDIA_NUM_DEVICES);
 	if (minor == MEDIA_NUM_DEVICES) {
 		mutex_unlock(&media_devnode_lock);
 		pr_err("could not get a free minor\n");
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index fbbb78f6885e..ab4b133e1ccd 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -211,7 +211,7 @@ static int dra7xx_pcie_handle_msi(struct pcie_port *pp, int index)
 	if (!val)
 		return 0;
 
-	pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, 0);
+	pos = find_first_bit(&val, MAX_MSI_IRQS_PER_CTRL);
 	while (pos != MAX_MSI_IRQS_PER_CTRL) {
 		generic_handle_domain_irq(pp->irq_domain,
 					  (index * MAX_MSI_IRQS_PER_CTRL) + pos);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 134ad0f8779d..5f5d570054b9 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -18004,8 +18004,8 @@ lpfc_sli4_alloc_xri(struct lpfc_hba *phba)
 	 * the driver starts at 0 each time.
 	 */
 	spin_lock_irq(&phba->hbalock);
-	xri = find_next_zero_bit(phba->sli4_hba.xri_bmask,
-				 phba->sli4_hba.max_cfg_param.max_xri, 0);
+	xri = find_first_zero_bit(phba->sli4_hba.xri_bmask,
+				 phba->sli4_hba.max_cfg_param.max_xri);
 	if (xri >= phba->sli4_hba.max_cfg_param.max_xri) {
 		spin_unlock_irq(&phba->hbalock);
 		return NO_XRI;
@@ -19682,7 +19682,7 @@ lpfc_sli4_alloc_rpi(struct lpfc_hba *phba)
 	max_rpi = phba->sli4_hba.max_cfg_param.max_rpi;
 	rpi_limit = phba->sli4_hba.next_rpi;
 
-	rpi = find_next_zero_bit(phba->sli4_hba.rpi_bmask, rpi_limit, 0);
+	rpi = find_first_zero_bit(phba->sli4_hba.rpi_bmask, rpi_limit);
 	if (rpi >= rpi_limit)
 		rpi = LPFC_RPI_ALLOC_ERROR;
 	else {
@@ -20325,8 +20325,8 @@ lpfc_sli4_fcf_rr_next_index_get(struct lpfc_hba *phba)
 		 * have been tested so that we can detect when we should
 		 * change the priority level.
 		 */
-		next_fcf_index = find_next_bit(phba->fcf.fcf_rr_bmask,
-					       LPFC_SLI4_FCF_TBL_INDX_MAX, 0);
+		next_fcf_index = find_first_bit(phba->fcf.fcf_rr_bmask,
+					       LPFC_SLI4_FCF_TBL_INDX_MAX);
 	}
 
 
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 312ba0f98ad7..573be88f8191 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -358,8 +358,8 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 		goto out;
 
 	if (flags & K3_RINGACC_RING_USE_PROXY) {
-		proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
-					      ringacc->num_proxies, 0);
+		proxy_id = find_first_zero_bit(ringacc->proxy_inuse,
+					      ringacc->num_proxies);
 		if (proxy_id == ringacc->num_proxies)
 			goto error;
 	}
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5be6d02dc690..9fc2319a394d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1975,7 +1975,7 @@ static bool canon_copy_from_read_buf(struct tty_struct *tty,
 	more = n - (size - tail);
 	if (eol == N_TTY_BUF_SIZE && more) {
 		/* scan wrapped without finding set bit */
-		eol = find_next_bit(ldata->read_flags, more, 0);
+		eol = find_first_bit(ldata->read_flags, more);
 		found = eol != more;
 	} else
 		found = eol != size;
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 80b2e3f0e276..5ff1c53740c0 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -246,8 +246,7 @@ void acrn_ioreq_request_clear(struct acrn_vm *vm)
 	spin_lock_bh(&vm->ioreq_clients_lock);
 	client = vm->default_client;
 	if (client) {
-		vcpu = find_next_bit(client->ioreqs_map,
-				     ACRN_IO_REQUEST_MAX, 0);
+		vcpu = find_first_bit(client->ioreqs_map, ACRN_IO_REQUEST_MAX);
 		while (vcpu < ACRN_IO_REQUEST_MAX) {
 			acrn_ioreq_complete_request(client, vcpu, NULL);
 			vcpu = find_next_bit(client->ioreqs_map,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f3f4dee43985..51fa34a1c218 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2557,8 +2557,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
 		if (dir == ALLOC_RIGHT) {
-			secno = find_next_zero_bit(free_i->free_secmap,
-							MAIN_SECS(sbi), 0);
+			secno = find_first_zero_bit(free_i->free_secmap,
+							MAIN_SECS(sbi));
 			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
 		} else {
 			go_left = 1;
@@ -2573,8 +2573,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 			left_start--;
 			continue;
 		}
-		left_start = find_next_zero_bit(free_i->free_secmap,
-							MAIN_SECS(sbi), 0);
+		left_start = find_first_zero_bit(free_i->free_secmap,
+							MAIN_SECS(sbi));
 		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
 		break;
 	}
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f89ffcbd585f..a17be1618bf7 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -379,7 +379,7 @@ static void o2hb_nego_timeout(struct work_struct *work)
 
 	o2hb_fill_node_map(live_node_bitmap, sizeof(live_node_bitmap));
 	/* lowest node as master node to make negotiate decision. */
-	master_node = find_next_bit(live_node_bitmap, O2NM_MAX_NODES, 0);
+	master_node = find_first_bit(live_node_bitmap, O2NM_MAX_NODES);
 
 	if (master_node == o2nm_this_node()) {
 		if (!test_bit(master_node, reg->hr_nego_node_bitmap)) {
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 9f90fc9551e1..c4eccd499db8 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -1045,7 +1045,7 @@ static int dlm_send_regions(struct dlm_ctxt *dlm, unsigned long *node_map)
 	int status, ret = 0, i;
 	char *p;
 
-	if (find_next_bit(node_map, O2NM_MAX_NODES, 0) >= O2NM_MAX_NODES)
+	if (find_first_bit(node_map, O2NM_MAX_NODES) >= O2NM_MAX_NODES)
 		goto bail;
 
 	qr = kzalloc(sizeof(struct dlm_query_region), GFP_KERNEL);
@@ -1217,7 +1217,7 @@ static int dlm_send_nodeinfo(struct dlm_ctxt *dlm, unsigned long *node_map)
 	struct o2nm_node *node;
 	int ret = 0, status, count, i;
 
-	if (find_next_bit(node_map, O2NM_MAX_NODES, 0) >= O2NM_MAX_NODES)
+	if (find_first_bit(node_map, O2NM_MAX_NODES) >= O2NM_MAX_NODES)
 		goto bail;
 
 	qn = kzalloc(sizeof(struct dlm_query_nodeinfo), GFP_KERNEL);
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 9b88219febb5..227da5b1b6ab 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -861,7 +861,7 @@ struct dlm_lock_resource * dlm_get_lock_resource(struct dlm_ctxt *dlm,
 		 * to see if there are any nodes that still need to be
 		 * considered.  these will not appear in the mle nodemap
 		 * but they might own this lockres.  wait on them. */
-		bit = find_next_bit(dlm->recovery_map, O2NM_MAX_NODES, 0);
+		bit = find_first_bit(dlm->recovery_map, O2NM_MAX_NODES);
 		if (bit < O2NM_MAX_NODES) {
 			mlog(0, "%s: res %.*s, At least one node (%d) "
 			     "to recover before lock mastery can begin\n",
@@ -912,7 +912,7 @@ struct dlm_lock_resource * dlm_get_lock_resource(struct dlm_ctxt *dlm,
 		dlm_wait_for_recovery(dlm);
 
 		spin_lock(&dlm->spinlock);
-		bit = find_next_bit(dlm->recovery_map, O2NM_MAX_NODES, 0);
+		bit = find_first_bit(dlm->recovery_map, O2NM_MAX_NODES);
 		if (bit < O2NM_MAX_NODES) {
 			mlog(0, "%s: res %.*s, At least one node (%d) "
 			     "to recover before lock mastery can begin\n",
@@ -1079,7 +1079,7 @@ static int dlm_wait_for_lock_mastery(struct dlm_ctxt *dlm,
 		sleep = 1;
 		/* have all nodes responded? */
 		if (voting_done && !*blocked) {
-			bit = find_next_bit(mle->maybe_map, O2NM_MAX_NODES, 0);
+			bit = find_first_bit(mle->maybe_map, O2NM_MAX_NODES);
 			if (dlm->node_num <= bit) {
 				/* my node number is lowest.
 			 	 * now tell other nodes that I am
@@ -1234,8 +1234,8 @@ static int dlm_restart_lock_mastery(struct dlm_ctxt *dlm,
 		} else {
 			mlog(ML_ERROR, "node down! %d\n", node);
 			if (blocked) {
-				int lowest = find_next_bit(mle->maybe_map,
-						       O2NM_MAX_NODES, 0);
+				int lowest = find_first_bit(mle->maybe_map,
+						       O2NM_MAX_NODES);
 
 				/* act like it was never there */
 				clear_bit(node, mle->maybe_map);
@@ -1795,7 +1795,7 @@ int dlm_assert_master_handler(struct o2net_msg *msg, u32 len, void *data,
 		     "MLE for it! (%.*s)\n", assert->node_idx,
 		     namelen, name);
 	} else {
-		int bit = find_next_bit (mle->maybe_map, O2NM_MAX_NODES, 0);
+		int bit = find_first_bit(mle->maybe_map, O2NM_MAX_NODES);
 		if (bit >= O2NM_MAX_NODES) {
 			/* not necessarily an error, though less likely.
 			 * could be master just re-asserting. */
@@ -2521,7 +2521,7 @@ static int dlm_is_lockres_migratable(struct dlm_ctxt *dlm,
 	}
 
 	if (!nonlocal) {
-		node_ref = find_next_bit(res->refmap, O2NM_MAX_NODES, 0);
+		node_ref = find_first_bit(res->refmap, O2NM_MAX_NODES);
 		if (node_ref >= O2NM_MAX_NODES)
 			return 0;
 	}
@@ -3303,7 +3303,7 @@ static void dlm_clean_block_mle(struct dlm_ctxt *dlm,
 	BUG_ON(mle->type != DLM_MLE_BLOCK);
 
 	spin_lock(&mle->spinlock);
-	bit = find_next_bit(mle->maybe_map, O2NM_MAX_NODES, 0);
+	bit = find_first_bit(mle->maybe_map, O2NM_MAX_NODES);
 	if (bit != dead_node) {
 		mlog(0, "mle found, but dead node %u would not have been "
 		     "master\n", dead_node);
@@ -3542,7 +3542,7 @@ void dlm_force_free_mles(struct dlm_ctxt *dlm)
 	spin_lock(&dlm->master_lock);
 
 	BUG_ON(dlm->dlm_state != DLM_CTXT_LEAVING);
-	BUG_ON((find_next_bit(dlm->domain_map, O2NM_MAX_NODES, 0) < O2NM_MAX_NODES));
+	BUG_ON((find_first_bit(dlm->domain_map, O2NM_MAX_NODES) < O2NM_MAX_NODES));
 
 	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
 		bucket = dlm_master_hash(dlm, i);
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 0e7aad1b11cc..e24e327524f8 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -451,7 +451,7 @@ static int dlm_do_recovery(struct dlm_ctxt *dlm)
 	if (dlm->reco.dead_node == O2NM_INVALID_NODE_NUM) {
 		int bit;
 
-		bit = find_next_bit (dlm->recovery_map, O2NM_MAX_NODES, 0);
+		bit = find_first_bit(dlm->recovery_map, O2NM_MAX_NODES);
 		if (bit >= O2NM_MAX_NODES || bit < 0)
 			dlm_set_reco_dead_node(dlm, O2NM_INVALID_NODE_NUM);
 		else
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index c350bd4df770..eedf07ca23ca 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -92,7 +92,7 @@ int __dlm_lockres_unused(struct dlm_lock_resource *res)
 		return 0;
 
 	/* Another node has this resource with this node as the master */
-	bit = find_next_bit(res->refmap, O2NM_MAX_NODES, 0);
+	bit = find_first_bit(res->refmap, O2NM_MAX_NODES);
 	if (bit < O2NM_MAX_NODES)
 		return 0;
 
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 9a57257988c7..00fc50d0a640 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -251,7 +251,7 @@ void gen_pool_destroy(struct gen_pool *pool)
 		list_del(&chunk->next_chunk);
 
 		end_bit = chunk_size(chunk) >> order;
-		bit = find_next_bit(chunk->bits, end_bit, 0);
+		bit = find_first_bit(chunk->bits, end_bit);
 		BUG_ON(bit < end_bit);
 
 		vfree(chunk);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 7121ce2a47c0..78814417d753 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -608,7 +608,7 @@ static int clear_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	bitmap = &ncf->bitmap;
 
 	spin_lock_irqsave(&nc->lock, flags);
-	index = find_next_bit(bitmap, ncf->n_vids, 0);
+	index = find_first_bit(bitmap, ncf->n_vids);
 	if (index >= ncf->n_vids) {
 		spin_unlock_irqrestore(&nc->lock, flags);
 		return -1;
@@ -667,7 +667,7 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 		return -1;
 	}
 
-	index = find_next_zero_bit(bitmap, ncf->n_vids, 0);
+	index = find_first_zero_bit(bitmap, ncf->n_vids);
 	if (index < 0 || index >= ncf->n_vids) {
 		netdev_err(ndp->ndev.dev,
 			   "Channel %u already has all VLAN filters set\n",
-- 
2.30.2

