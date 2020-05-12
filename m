Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23CD1CFAF1
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgELQh5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgELQh4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A648D6E;
        Tue, 12 May 2020 09:37:56 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D2873F305;
        Tue, 12 May 2020 09:37:55 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/14] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
Date:   Tue, 12 May 2020 17:36:56 +0100
Message-Id: <1589301419-24459-12-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
for the PR_SPEC_STORE_BYPASS "misfeature" of
PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 man2/prctl.2 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 66417cf..2361b44 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
 Same as
 .B PR_SPEC_DISABLE
 but cannot be undone.
+.TP
+.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
+Same as
+.BR PR_SPEC_DISABLE ,
+but but the state will be cleared on
+.BR execve (2).
 .RE
 .IP
 If all bits are 0,
@@ -1251,6 +1257,17 @@ with the same value for
 .I arg2
 will fail with the error
 .BR EPERM .
+.\" commit 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
+.TP
+.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
+Same as
+.BR PR_SPEC_DISABLE ,
+but but the state will be cleared on
+.BR execve (2).
+Currently only supported for
+.I arg2
+equal to
+.B PR_SPEC_STORE_BYPASS.
 .RE
 .IP
 Any unsupported value in
@@ -1898,11 +1915,12 @@ was
 .BR PR_SET_SPECULATION_CTRL
 and
 .IR arg3
-is neither
+is not
 .BR PR_SPEC_ENABLE ,
 .BR PR_SPEC_DISABLE ,
+.BR PR_SPEC_FORCE_DISABLE ,
 nor
-.BR PR_SPEC_FORCE_DISABLE .
+.BR PR_SPEC_DISABLE_NOEXEC .
 .SH VERSIONS
 The
 .BR prctl ()
-- 
2.1.4

