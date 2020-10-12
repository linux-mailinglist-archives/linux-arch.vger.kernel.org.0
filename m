Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62AC28BA7A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbgJLOK5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 10:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389415AbgJLOK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 10:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602511856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qeLRzZ2kmlgn/5uncvk+yQgdLuVN4fv/HfcAAmZlzhY=;
        b=FPglRbBDzMs6Ce0yDbhDIEtEigVvVQojDFaZFpaxStvZ2Lc/bPMeT+8B0KsFeIKyW0kdE9
        L2AyTUZ2jrsjZwFHnW3GPzscazr4b3rrGONs6ibic1Tahbsc5Tu0D4VAcK39sUyvSQgAxc
        +RF+x9+8dyRDBtujfVs6LWaT4TMJpSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-R7YYZCLVOIC0kqtErudtYQ-1; Mon, 12 Oct 2020 10:10:52 -0400
X-MC-Unique: R7YYZCLVOIC0kqtErudtYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655F1104D3E0;
        Mon, 12 Oct 2020 14:10:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-187.rdu2.redhat.com [10.10.117.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 166B760C0F;
        Mon, 12 Oct 2020 14:10:48 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] arm64: Fix redefinition of init_new_context()
Date:   Mon, 12 Oct 2020 10:10:32 -0400
Message-Id: <20201012141032.6333-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The linux-next commit c870baeede75 ("asm-generic: add generic MMU
versions of mmu context functions") missed a case in the arm64/for-next
branch.

Signed-off-by: Qian Cai <cai@redhat.com>
---
 arch/arm64/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index da5f146e665b..cd5c33a50469 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -176,6 +176,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  */
 void check_and_switch_context(struct mm_struct *mm);
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
-- 
2.28.0

