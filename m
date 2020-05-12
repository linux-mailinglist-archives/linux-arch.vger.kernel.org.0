Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9A1CFAE1
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgELQht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:49 -0400
Received: from foss.arm.com ([217.140.110.172]:58164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELQhs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C404D6E;
        Tue, 12 May 2020 09:37:47 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA7123F305;
        Tue, 12 May 2020 09:37:46 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/14] prctl.2: Add health warning
Date:   Tue, 12 May 2020 17:36:47 +0100
Message-Id: <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In reality, almost every prctl interferes with assumptions that the
compiler and C library / runtime rely on.  prctl() can therefore
make userspace explode in a variety ways that are likely to be hard
to debug.

This is not obvious to the uninitiated, so add a warning.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 man2/prctl.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7932ada..a35b748 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -66,6 +66,11 @@ prctl \- operations on a process or thread
 manipulates various aspects of the behavior
 of the calling thread or process.
 .PP
+Note that careless use of
+.BR prctl ()
+can confuse the userspace run-time environment,
+so these operations should be used with care (if at all).
+.PP
 .BR prctl ()
 is called with a first argument describing what to do
 (with values defined in \fI<linux/prctl.h>\fP), and further
-- 
2.1.4

