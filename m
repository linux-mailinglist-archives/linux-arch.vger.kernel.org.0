Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EBE1CFAEE
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgELQhz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:55 -0400
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgELQhy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA6B7D6E;
        Tue, 12 May 2020 09:37:53 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D0983F305;
        Tue, 12 May 2020 09:37:53 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
Date:   Tue, 12 May 2020 17:36:54 +0100
Message-Id: <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix a few very minor bits of punctuation in
PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 1e04859..e8eaf95 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1175,13 +1175,13 @@ The return value uses bits 0-3 with the following meaning:
 .TP
 .BR PR_SPEC_PRCTL
 Mitigation can be controlled per thread by
-.B PR_SET_SPECULATION_CTRL
+.BR PR_SET_SPECULATION_CTRL .
 .TP
 .BR PR_SPEC_ENABLE
 The speculation feature is enabled, mitigation is disabled.
 .TP
 .BR PR_SPEC_DISABLE
-The speculation feature is disabled, mitigation is enabled
+The speculation feature is disabled, mitigation is enabled.
 .TP
 .BR PR_SPEC_FORCE_DISABLE
 Same as
@@ -1228,11 +1228,11 @@ which is one of the following:
 The speculation feature is enabled, mitigation is disabled.
 .TP
 .BR PR_SPEC_DISABLE
-The speculation feature is disabled, mitigation is enabled
+The speculation feature is disabled, mitigation is enabled.
 .TP
 .BR PR_SPEC_FORCE_DISABLE
 Same as
-.B PR_SPEC_DISABLE
+.BR PR_SPEC_DISABLE ,
 but cannot be undone.
 A subsequent
 .B
-- 
2.1.4

