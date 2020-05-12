Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8631CFAEA
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgELQhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:54 -0400
Received: from foss.arm.com ([217.140.110.172]:58198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgELQhx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A1F212FC;
        Tue, 12 May 2020 09:37:53 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50A783F305;
        Tue, 12 May 2020 09:37:52 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/14] prctl.2: Work around bogus constant "maxsig" in PR_SET_PDEATHSIG
Date:   Tue, 12 May 2020 17:36:53 +0100
Message-Id: <1589301419-24459-9-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The description of PR_SET_PDEATHSIG refers to "maxsig", which is
apparently intended to stand for the maximum defined signal number.

maxsig seems not to be a thing, even in the kernel.

Reword to use the standard constant NSIG.  (Discussion of SIGRTMIN
and SIGRTMAX seems out of scope here, and anyway is not relevant to
the kernel.)

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index a84fb1d..1e04859 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -955,7 +955,9 @@ will operate in the privilege-restricting mode described above.
 .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
 Set the parent-death signal
 of the calling process to \fIarg2\fP (either a signal value
-in the range 1..maxsig, or 0 to clear).
+in the range 1 ..
+.BR NSIG " \-"
+1, or 0 to clear).
 This is the signal that the calling process will get when its
 parent dies.
 .IP
-- 
2.1.4

