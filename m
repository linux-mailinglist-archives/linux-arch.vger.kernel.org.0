Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FC250789
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHXS2m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHXS2k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:40 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD7020767;
        Mon, 24 Aug 2020 18:28:37 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v8 16/28] mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
Date:   Mon, 24 Aug 2020 19:27:46 +0100
Message-Id: <20200824182758.27267-17-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since arm64 memory (allocation) tags can only be stored in RAM, mapping
files with PROT_MTE is not allowed by default. RAM-based files like
those in a tmpfs mount or memfd_create() can support memory tagging, so
update the vm_flags accordingly in shmem_mmap().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..ec94f4c7851e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2267,6 +2267,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 			vma->vm_flags &= ~(VM_MAYWRITE);
 	}
 
+	/* arm64 - allow memory tagging on RAM-based files */
+	vma->vm_flags |= VM_MTE_ALLOWED;
+
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
