Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DD1E5000
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE0VS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 17:18:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0VS1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 17:18:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A2E01042;
        Wed, 27 May 2020 14:18:27 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A16F3F52E;
        Wed, 27 May 2020 14:18:26 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
Date:   Wed, 27 May 2020 22:17:34 +0100
Message-Id: <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 man2/prctl.2 | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index dc99218..b6fb51c 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
 .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
 Sets the state of the speculation misfeature specified in
 .IR arg2 .
-Currently, the only permitted value for this argument is
+Currently, this argument must be one of:
+.RS
+.TP
 .B PR_SPEC_STORE_BYPASS
-(otherwise the call fails with the error
+speculative store bypass control, or
+.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
+.TP
+.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
+indirect branch speculation control.
+.RE
+.IP
+(Otherwise the call fails with the error
 .BR ENODEV ).
-This setting is a per-thread attribute.
+These settings are per-thread attributes.
 The
 .IR arg3
 argument is used to hand in the control value,
@@ -1235,13 +1244,16 @@ Same as
 .BR PR_SPEC_DISABLE ,
 but cannot be undone.
 A subsequent
-.B
-prctl(..., PR_SPEC_ENABLE)
+.BR prctl (\c
+.IR arg2 ,
+.BR PR_SPEC_ENABLE )
+with the same value for
+.I arg2
 will fail with the error
 .BR EPERM .
 .RE
 .IP
-Any other value in
+Any unsupported value in
 .IR arg3
 will result in the call failing with the error
 .BR ERANGE .
-- 
2.1.4

