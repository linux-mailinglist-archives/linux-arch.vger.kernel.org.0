Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC16AADD0
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCECKs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Mar 2023 21:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCECKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Mar 2023 21:10:47 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518713D58;
        Sat,  4 Mar 2023 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3ZoSoAgAc45as1CbqRRfIYjrDgicK0h9/Eydc3y8CvI=; b=uL31q83onkyvAad/3/HrEjNKCF
        Q/ch0bwsL0cHBeH6t9o2+jUxC2h8HCgZI/LXxuinBRAoVWnVCYgV6xsqom+okFRwpFHQhX/UEv/dN
        NqobvNrRa4F1jk9282S6xqaRWr6ROxfsYwDGm0c0hYMI9LcQjBvIRWxehofrjp4ki3r8LvaUc+FRX
        QOOcyiTIKlmU1xCZEfhsUrryeCOl3HcV2yy6EExlSG+1rHuWkxrV2N/SdNohdYFD/9lrjuABti8M4
        80e3bfyd5AANlUga0YQ8UfpARuBHnlx0Ex4W9ThuI/075uHJxTvx7ADxMFxLHjCQuygoxCcamtfrP
        VmNkyUXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pYdpi-00E15l-21;
        Sun, 05 Mar 2023 02:10:42 +0000
Date:   Sun, 5 Mar 2023 02:10:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [git pull] VM_FAULT_RETRY fixes
Message-ID: <ZAP6IvbWaNjPthCq@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to caa82ae7ef52b7cf5f80a2b2fbcbdbcfd16426cc:

  openrisc: fix livelock in uaccess (2023-03-02 12:32:44 -0500)

----------------------------------------------------------------
VM_FAULT_RETRY fixes

Some of the page fault handlers do not deal with the following case
correctly:
	* handle_mm_fault() has returned VM_FAULT_RETRY
	* there is a pending fatal signal
	* fault had happened in kernel mode
Correct action in such case is not "return unconditionally" - fatal
signals are handled only upon return to userland and something like
copy_to_user() would end up retrying the faulting instruction and
triggering the same fault again and again.

What we need to do in such case is to make the caller to treat that
as failed uaccess attempt - handle exception if there is an exception
handler for faulting instruction or oops if there isn't one.

Over the years some architectures had been fixed and now are handling
that case properly; some still do not.  This series should fix the
remaining ones.

Status:
	m68k, riscv, hexagon, parisc: tested/acked by maintainers.
	alpha, sparc32, sparc64: tested locally - bug has been
reproduced on the unpatched kernel and verified to be fixed by
this series.
	ia64, microblaze, nios2, openrisc: build, but otherwise
completely untested.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (10):
      m68k: fix livelock in uaccess
      riscv: fix livelock in uaccess
      hexagon: fix livelock in uaccess
      parisc: fix livelock in uaccess
      alpha: fix livelock in uaccess
      sparc: fix livelock in uaccess
      ia64: fix livelock in uaccess
      microblaze: fix livelock in uaccess
      nios2: fix livelock in uaccess
      openrisc: fix livelock in uaccess

 arch/alpha/mm/fault.c      | 5 ++++-
 arch/hexagon/mm/vm_fault.c | 5 ++++-
 arch/ia64/mm/fault.c       | 5 ++++-
 arch/m68k/mm/fault.c       | 5 ++++-
 arch/microblaze/mm/fault.c | 5 ++++-
 arch/nios2/mm/fault.c      | 5 ++++-
 arch/openrisc/mm/fault.c   | 5 ++++-
 arch/parisc/mm/fault.c     | 7 ++++++-
 arch/riscv/mm/fault.c      | 5 ++++-
 arch/sparc/mm/fault_32.c   | 5 ++++-
 arch/sparc/mm/fault_64.c   | 7 ++++++-
 11 files changed, 48 insertions(+), 11 deletions(-)
