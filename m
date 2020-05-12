Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E601CFAD8
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgELQhG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 12:37:06 -0400
Received: from foss.arm.com ([217.140.110.172]:58122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgELQhG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:37:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40451FB;
        Tue, 12 May 2020 09:37:05 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4798B3F305;
        Tue, 12 May 2020 09:37:04 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 00/14] prctl.2 man page updates for Linux 5.6
Date:   Tue, 12 May 2020 17:36:45 +0100
Message-Id: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A bunch of updates to the prctl(2) man page to fill in the missing
prctls (mostly) up to Linux 5.6 (along with a few other tweaks fixes).

People not Cc'd on the whole series can find the whole series at
https://lore.kernel.org/linux-man/ .

Patches:

 * Patches 1-6 and 8-9 are rather trivial optional tweaks and fixes
   that don't make substantive changes.  I can live with some of these
   being dropped.

 * Patch 7 (removal of the MPX prctls) could use an Ack, but should be
   uncontroversial.

 * Patches 10-11 cover recent extensions to the speculation control
   prctls.

 * Patch 12 adds one particular case Errors for EINVAL, applicable to
   all arch-specific prctls.  I've not tried too hard to be 100%
   comprehensive with the error conditions, since the list in its
   current form looks in need of a major overhaul.

 * Patches 13-14 add the new arm64-specific prctls.
   (PR_SET_TAGGED_ADDR_CTRL requires a bit more discussion and will be
   posted separately.)

Maintainer notes:

 * I'm *asssuming* that the datestamps in .TH are automatically
   updated by maintainer scripts, since maintaining them by hand would
   interact very badly with rebase.  If needed I can go update them by
   hand though.

 * Similarly, in the days of git (and because I see no recent entries)
   I'm assuming that in-file changelogs no longer need to be updated.
   Again, I'm happy to do that if needed.


Dave Martin (14):
  prctl.2: tfix clarify that prctl can apply to threads
  prctl.2: Add health warning
  prctl.2: tfix mis-description of thread ID values in procfs
  prctl.2: srcfix add comments for navigation
  prctl.2: tfix listing order of prctls
  prctl.2: ffix quotation mark tweaks
  prctl.2: Document removal of Intel MPX prctls
  prctl.2: Work around bogus constant "maxsig" in PR_SET_PDEATHSIG
  prctl.2: tfix minor punctuation in SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_INDIRECT_BRANCH for SPECULATION_CTRL prctls
  prctl.2: Add PR_SPEC_DISABLE_NOEXEC for SPECULATION_CTRL prctls
  prctl.2: Clarify the unsupported hardware case of EINVAL
  prctl.2: Add SVE prctls (arm64)
  prctl.2: Add PR_PAC_RESET_KEYS (arm64)

 man2/prctl.2 | 496 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 384 insertions(+), 112 deletions(-)

-- 
2.1.4

