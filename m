Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75F22A23B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgGVWL1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbgGVWL0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80ACC0619DC;
        Wed, 22 Jul 2020 15:11:24 -0700 (PDT)
Message-Id: <20200722215954.464281930@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=ahlK79PK5YUaQAhd7lygE8UJdfTKv0Vu+HW5xnc5ELM=;
        b=G7gFd1y4nAOmB1fa4bznNO6Hn3Xz5vGns+k1b2AAzgB3r8aFNsAxK66jM7k+woJjeVIGPk
        98ntp/LIG2+BVCPqkuHjXZQI75CRxyf81EpjyYchX1/id1bgwygapu4zV6NpZj5iV+34lN
        5jupVlM/5oMJUto46ob0x4SNkXVFEdZ/4vVsJBiX7zlSsHAjQy9gxt5C0toWs91Bpe/RZs
        L185WibgR0N4V4qXYAj4nyjC7PSyi9i1q0vQ+1ut7dpat2CwoFRTkp6RJ+x9moWliHMRCE
        h3QD1iopZgNwAdQKa8R+EDTF0w281Ry2bTenti8lF/lPd6GforcDq/MMnNnnZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=ahlK79PK5YUaQAhd7lygE8UJdfTKv0Vu+HW5xnc5ELM=;
        b=miICDflKl+rPTMgRosTGj5rJ8+uSXdXfY8WUsObaLLnl8ki5Ojwpope+EfNnupX4TEtU3L
        iAM7h9QaqHryhDDQ==
Date:   Wed, 22 Jul 2020 23:59:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 00/15] entry, x86, kvm: Generic entry/exit functionality
 for host and guest
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the 5th version of generic entry/exit functionality for host and
guest.

The 4th version is available here:

    https://lore.kernel.org/r/20200721105706.030914876@linutronix.de

Changes vs. V4:

  - Add the missing instrumentation prevetions to the entry Makefile (Kees)
  - Rename exit_to_guest to xfer_to_guest (Sean)

The patches depend on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

The lot is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

Thanks,

	tglx


