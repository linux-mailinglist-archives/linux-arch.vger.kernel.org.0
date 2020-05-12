Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC541CFAE2
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgELQht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:49 -0400
Received: from foss.arm.com ([217.140.110.172]:58172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgELQhs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60BA511B3;
        Tue, 12 May 2020 09:37:48 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0B593F305;
        Tue, 12 May 2020 09:37:47 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/14] prctl.2: tfix mis-description of thread ID values in procfs
Date:   Tue, 12 May 2020 17:36:48 +0100
Message-Id: <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Under PR_SET_NAME, the [tid] value seen in procfs as
/proc/self/task/[tid] is mistakenly described as the name of the
thread, whereas really the name is on /proc/self/task/[tid]/comm.

Fix it.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index a35b748..9736434 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -808,8 +808,10 @@ and retrieved using
 The attribute is likewise accessible via
 .IR /proc/self/task/[tid]/comm ,
 where
-.I tid
-is the name of the calling thread.
+.I [tid]
+is the the thread ID of the calling thread, as returned by
+.BR gettid (2).
+.\" prctl PR_GET_NAME
 .TP
 .BR PR_GET_NAME " (since Linux 2.6.11)"
 Return the name of the calling thread,
-- 
2.1.4

