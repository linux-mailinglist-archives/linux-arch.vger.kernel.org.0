Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2E1CFAE6
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgELQhw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgELQhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CA6711D4;
        Tue, 12 May 2020 09:37:52 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E5883F305;
        Tue, 12 May 2020 09:37:51 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/14] prctl.2: Document removal of Intel MPX prctls
Date:   Tue, 12 May 2020 17:36:52 +0100
Message-Id: <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Intel MPX API was removed from Linux 5.4.  See Linux
commit f240652b6032 ("x86/mpx: Remove MPX APIs")

Document this change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 man2/prctl.2 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7a3fc5c..a84fb1d 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -784,7 +784,7 @@ option enabled.
 .RE
 .\" prctl PR_MPX_ENABLE_MANAGEMENT
 .TP
-.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19) "
+.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19, removed in Linux 5.4; only on x86) "
 .\" commit fe3d197f84319d3bce379a9c0dc17b1f48ad358c
 .\" See also http://lwn.net/Articles/582712/
 .\" See also https://gcc.gnu.org/wiki/Intel%20MPX%20support%20in%20the%20GCC%20compiler
@@ -859,6 +859,12 @@ had been called.
 .IP
 For further information on Intel MPX, see the kernel source file
 .IR Documentation/x86/intel_mpx.txt .
+.IP
+.\" commit f240652b6032b48ad7fa35c5e701cc4c8d697c0b
+.\" See also https://lkml.kernel.org/r/20190705175321.DB42F0AD@viggo.jf.intel.com
+Due to a lack of toolchain support,
+.BR PR_MPX_ENABLE_MANAGEMENT " and " PR_MPX_DISABLE_MANAGEMENT
+are not supported by Linux 5.4 or later.
 .\" prctl PR_SET_NAME
 .TP
 .BR PR_SET_NAME " (since Linux 2.6.9)"
-- 
2.1.4

