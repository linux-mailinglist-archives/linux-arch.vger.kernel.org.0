Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73520409DAE
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbhIMUFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:05:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:38689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347782AbhIMUFr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336358"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336358"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643906"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:29 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 02/13] Documentation/x86: Add documentation for User Interrupts
Date:   Mon, 13 Sep 2021 13:01:21 -0700
Message-Id: <20210913200132.3396598-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For now, include just the hardware and software architecture summary.

<This is the same content as the cover letter.

Some of the kernel design details and other information from the cover
letter can eventually be moved here.>

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 Documentation/x86/index.rst           |   1 +
 Documentation/x86/user-interrupts.rst | 107 ++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/x86/user-interrupts.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 383048396336..0d416b02131b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -31,6 +31,7 @@ x86-specific Documentation
    tsx_async_abort
    buslock
    usb-legacy-support
+   user-interrupts
    i386/index
    x86_64/index
    sva
diff --git a/Documentation/x86/user-interrupts.rst b/Documentation/x86/user-interrupts.rst
new file mode 100644
index 000000000000..bc90251d6c2e
--- /dev/null
+++ b/Documentation/x86/user-interrupts.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+User Interrupts (UINTR)
+=======================
+
+Overview
+========
+User Interrupts provides a low latency event delivery and inter process
+communication mechanism. These events can be delivered directly to userspace
+without a transition through the kernel.
+
+In the User Interrupts architecture, a receiver is always expected to be a user
+space task. However, a user interrupt can be sent by another user space task,
+kernel or an external source (like a device). The feature that allows another
+task to send an interrupt is referred to as User IPI.
+
+Hardware Summary
+================
+User Interrupts is a posted interrupt delivery mechanism. The interrupts are
+first posted to a memory location and then delivered to the receiver when they
+are running with CPL=3.
+
+Kernel managed architectural data structures
+--------------------------------------------
+UPID: User Posted Interrupt Descriptor - Holds receiver interrupt vector
+information and notification state (like an ongoing notification, suppressed
+notifications).
+
+UITT: User Interrupt Target Table - Stores UPID pointer and vector information
+for interrupt routing on the sender side. Referred by the senduipi instruction.
+
+The interrupt state of each task is referenced via MSRs which are saved and
+restored by the kernel during context switch.
+
+Instructions
+------------
+senduipi <index> - send a user IPI to a target task based on the UITT index.
+
+clui - Mask user interrupts by clearing UIF (User Interrupt Flag).
+
+stui - Unmask user interrupts by setting UIF.
+
+testui - Test current value of UIF.
+
+uiret - return from a user interrupt handler.
+
+User IPI
+--------
+When a User IPI sender executes 'senduipi <index>' the hardware refers the UITT
+table entry pointed by the index and posts the interrupt vector into the
+receiver's UPID.
+
+If the receiver is running the sender cpu would send a physical IPI to the
+receiver's cpu. On the receiver side this IPI is detected as a User Interrupt.
+The User Interrupt handler for the receiver is invoked and the vector number is
+pushed onto the stack.
+
+Upon execution of 'uiret' in the interrupt handler, the control is transferred
+back to instruction that was interrupted.
+
+Refer the Intel Software Developer's Manual for more details.
+
+Software Architecture
+=====================
+User Interrupts (Uintr) is an opt-in feature (unlike signals). Applications
+wanting to use Uintr are expected to register themselves with the kernel using
+the Uintr related system calls. A Uintr receiver is always a userspace task. A
+Uintr sender can be another userspace task, kernel or a device.
+
+1) A receiver can register/unregister an interrupt handler using the Uintr
+receiver related syscalls.
+		uintr_register_handler(handler, flags)
+
+2) A syscall also allows a receiver to register a vector and create a user
+interrupt file descriptor - uintr_fd.
+		uintr_fd = uintr_create_fd(vector, flags)
+
+Uintr can be useful in some of the usages where eventfd or signals are used for
+frequent userspace event notifications. The semantics of uintr_fd are somewhat
+similar to an eventfd() or the write end of a pipe.
+
+3) Any sender with access to uintr_fd can use it to deliver events (in this
+case - interrupts) to a receiver. A sender task can manage its connection with
+the receiver using the sender related syscalls based on uintr_fd.
+		uipi_index = uintr_register_sender(uintr_fd, flags)
+
+Using an FD abstraction provides a secure mechanism to connect with a receiver.
+The FD sharing and isolation mechanisms put in place by the kernel would extend
+to Uintr as well.
+
+4a) After the initial setup, a sender task can use the SENDUIPI instruction to
+generate user IPIs without any kernel intervention.
+		SENDUIPI <uipi_index>
+
+If the receiver is running (CPL=3), then the user interrupt is delivered
+directly without a kernel transition. If the receiver isn't running the
+interrupt is delivered when the receiver gets context switched back. If the
+receiver is blocked in the kernel, the user interrupt is delivered to the
+kernel which then unblocks the intended receiver to deliver the interrupt.
+
+4b) If the sender is the kernel or a device, the uintr_fd can be passed onto
+the related kernel entity to allow them to setup a connection and then generate
+a user interrupt for event delivery. <The exact details of this API are still
+being worked upon.>
+
+Refer the Uintr man-pages for details on the syscall interface.
-- 
2.33.0

