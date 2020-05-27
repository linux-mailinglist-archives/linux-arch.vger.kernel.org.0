Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B451E4FFE
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE0VS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 17:18:26 -0400
Received: from foss.arm.com ([217.140.110.172]:44758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0VS0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 17:18:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F0A031B;
        Wed, 27 May 2020 14:18:26 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B2303F52E;
        Wed, 27 May 2020 14:18:25 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] prctl.2: ffix use literal hyphens when referencing kernel docs
Date:   Wed, 27 May 2020 22:17:33 +0100
Message-Id: <1590614258-24728-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is one case of a cross-reference to a kernel documentation
filename that uses unescaped hyphens.

To avoid misrendering, escape these as \- similarly to other
instances.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 968a75a..dc99218 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1261,7 +1261,7 @@ This parameter may enforce a read-only policy which will result in the
 call failing with the error
 .BR ENXIO .
 For further details, see the kernel source file
-.IR Documentation/admin-guide/kernel-parameters.txt .
+.IR Documentation/admin\-guide/kernel\-parameters.txt .
 .\"
 .\" prctl PR_TASK_PERF_EVENTS_DISABLE
 .TP
-- 
2.1.4

