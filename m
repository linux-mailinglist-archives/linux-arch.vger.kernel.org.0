Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4E42FF96
	for <lists+linux-arch@lfdr.de>; Sat, 16 Oct 2021 03:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhJPBIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 21:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhJPBIr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 21:08:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73E596124B;
        Sat, 16 Oct 2021 01:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634346399;
        bh=qI/DPYBEZTEHCJ+NzjHjKkesxMHUP6XmMdmjrhqvq+g=;
        h=From:To:Cc:Subject:Date:From;
        b=hTZp0rYoYpmcBI4BmjJ/SklRXywWdAn4LObNTATcqgZ4A0x94T8RlX+g7S5YKPMRv
         7chL0VKNZh5XOHdF0DcjjqtehBSRmbKVJ25Q3baTiT8jz2TfL0QGXvnoKS70pg0uXC
         FyM22hdz6xbSl/vSGsRKSA1K3Z4o2RpKKeXywF7p+u+dNO5Rbb2CDDtIB63/YGiZU2
         FfObkK9kZbuD8FWnYmNv3/jbRSBQLP52MzPBS2sK46E0xwWlGOQpm0ffqLuHPxvy4b
         WA49yxFqUamKfwM9S7miIUUq4+fozgH8CavDGJdKl0X/cS14Odb49gEh5fsbtCERjS
         pR/oDeVGWNt7A==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky fixes for v5.15-rc6
Date:   Sat, 16 Oct 2021 09:06:35 +0800
Message-Id: <20211016010635.2860644-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus:

The following changes since commit e21e52ad1e0126e2a5e2013084ac3f47cf1e887a:

  csky: Make HAVE_TCM depend on !COMPILE_TEST (2021-10-16 07:20:12 +0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.15-rc6

for you to fetch changes up to e21e52ad1e0126e2a5e2013084ac3f47cf1e887a:

  csky: Make HAVE_TCM depend on !COMPILE_TEST (2021-10-16 07:20:12 +0800)

----------------------------------------------------------------
csky updates for 5.15-rc6

Only 5 fixups:
 - Make HAVE_TCM depend on !COMPILE_TEST
 - bitops: Remove duplicate __clear_bit define
 - Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
 - Fixup regs.sr broken in ptrace
 - don't let sigreturn play with priveleged bits of status register

----------------------------------------------------------------
