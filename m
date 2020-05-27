Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCE1E4FFA
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgE0VRq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 17:17:46 -0400
Received: from foss.arm.com ([217.140.110.172]:44720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0VRp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 17:17:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5206E31B;
        Wed, 27 May 2020 14:17:45 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76D0B3F52E;
        Wed, 27 May 2020 14:17:43 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 0/6] prctl.2 man page updates for Linux 5.6
Date:   Wed, 27 May 2020 22:17:32 +0100
Message-Id: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A bunch of updates to the prctl(2) man page to fill in missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
fixes).

Patches from the v1 series [1] that have been applied or rejected
already have been dropped.

People not Cc'd on the whole series can find the whole series at
https://lore.kernel.org/linux-man/ .

Patches:

 * Patch 1 is a new (but trivial) formatting fix, unrelated to the new
   prctls.

 * Patches 2-3 relate to the speculation control prctls.  These are
   unmodified from v1, but need review.

 * Patches 4-5 relate to the arm64 prctls from v1, with reviewer
   feedback incorporated.  (See notes in the patches.)

 * Patch 6 is *draft* wording for the arm64 address tagging prctls.
   The semantics of address tagging is particularly slippery, so
   this needs discussion before merging.


[1] https://lore.kernel.org/linux-man/29a02b16-dd61-6186-1340-fcc7d5225ad0@gmail.com/T/#t


Dave Martin (6):
  prctl.2: ffix use literal hyphens when referencing kernel docs
  prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add PR_PAC_RESET_KEYS (arm64)
  prctl.2: Add tagged address ABI control prctls (arm64)

 man2/prctl.2 | 444 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 435 insertions(+), 9 deletions(-)

-- 
2.1.4

