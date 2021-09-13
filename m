Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E3409DA6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhIMUFq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:05:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:38689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237491AbhIMUFq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336356"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643904"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:28 -0700
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
Subject: [RFC PATCH 00/13] x86 User Interrupts support
Date:   Mon, 13 Sep 2021 13:01:19 -0700
Message-Id: <20210913200132.3396598-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

User Interrupts Introduction
============================

User Interrupts (Uintr) is a hardware technology that enables delivering
interrupts directly to user space.

Today, virtually all communication across privilege boundaries happens by going
through the kernel. These include signals, pipes, remote procedure calls and
hardware interrupt based notifications. User interrupts provide the foundation
for more efficient (low latency and low CPU utilization) versions of these
common operations by avoiding transitions through the kernel.

In the User Interrupts hardware architecture, a receiver is always expected to
be a user space task. However, a user interrupt can be sent by another user
space task, kernel or an external source (like a device).

In addition to the general infrastructure to receive user interrupts, this
series introduces a single source: interrupts from another user task.  These
are referred to as User IPIs.

The first implementation of User IPIs will be in the Intel processor code-named
Sapphire Rapids. Refer Chapter 11 of the Intel Architecture instruction set
extensions for details of the hardware architecture [1].

Series-reviewed-by: Tony Luck <tony.luck@intel.com>

Main goals of this RFC
======================
- Introduce this upcoming technology to the community.
This cover letter includes a hardware architecture summary along with the
software architecture and kernel design choices. This post is a bit long as a
result. Hopefully, it helps answer more questions than it creates :) I am also
planning to talk about User Interrupts next week at the LPC Kernel summit.

- Discuss potential use cases.
We are starting to look at actual usages and libraries (like libevent[2] and
liburing[3]) that can take advantage of this technology. Unfortunately, we
don't have much to share on this right now. We need some help from the
community to identify usages that can benefit from this. We would like to make
sure the proposed APIs work for the eventual consumers.

- Get early feedback on the software architecture.
We are hoping to get some feedback on the direction of overall software
architecture - starting with User IPI, extending it for kernel-to-user
interrupt notifications and external interrupts in the future. 

- Discuss some of the main architecture opens.
There is lot of work that still needs to happen to enable this technology. We
are looking for some input on future patches that would be of interest. Here
are some of the big opens that we are looking to resolve.
* Should Uintr interrupt all blocking system calls like sleep(), read(),
  poll(), etc? If so, should we implement an SA_RESTART type of mechanism
  similar to signals? - Refer Blocking for interrupts section below.

* Should the User Interrupt Target table (UITT) be shared between threads of a
  multi-threaded application or maybe even across processes? - Refer Sharing
  the UITT section below.

Why care about this? - Micro benchmark performance
==================================================
There is a ~9x or higher performance improvement using User IPI over other IPC
mechanisms for event signaling.

Below is the average normalized latency for a 1M ping-pong IPC notifications
with message size=1.

+------------+-------------------------+
| IPC type   |   Relative Latency      |
|            |(normalized to User IPI) |
+------------+-------------------------+
| User IPI   |                     1.0 |
| Signal     |                    14.8 |
| Eventfd    |                     9.7 |
| Pipe       |                    16.3 |
| Domain     |                    17.3 |
+------------+-------------------------+

Results have been estimated based on tests on internal hardware with Linux
v5.14 + User IPI patches.

Original benchmark: https://github.com/goldsborough/ipc-bench
Updated benchmark: https://github.com/intel/uintr-ipc-bench/tree/linux-rfc-v1

*Performance varies by use, configuration and other factors.

How it works underneath? - Hardware Summary
===========================================
User Interrupts is a posted interrupt delivery mechanism. The interrupts are
first posted to a memory location and then delivered to the receiver when they
are running with CPL=3.

Kernel managed architectural data structures
--------------------------------------------
UPID: User Posted Interrupt Descriptor - Holds receiver interrupt vector
information and notification state (like an ongoing notification, suppressed
notifications).

UITT: User Interrupt Target Table - Stores UPID pointer and vector information
for interrupt routing on the sender side. Referred by the senduipi instruction.

The interrupt state of each task is referenced via MSRs which are saved and
restored by the kernel during context switch.

Instructions
------------
senduipi <index> - send a user IPI to a target task based on the UITT index.

clui - Mask user interrupts by clearing UIF (User Interrupt Flag).

stui - Unmask user interrupts by setting UIF.

testui - Test current value of UIF.

uiret - return from a user interrupt handler.

User IPI
--------
When a User IPI sender executes 'senduipi <index>', the hardware refers the
UITT table entry pointed by the index and posts the interrupt vector (63-0)
into the receiver's UPID.

If the receiver is running (CPL=3), the sender cpu would send a physical IPI to
the receiver's cpu. On the receiver side this IPI is detected as a User
Interrupt. The User Interrupt handler for the receiver is invoked and the
vector number (63-0) is pushed onto the stack.

Upon execution of 'uiret' in the interrupt handler, the control is transferred
back to instruction that was interrupted.

Refer Chapter 11 of the Intel Architecture instruction set extensions [1] for
more details.

Application interface - Software Architecture
=============================================
User Interrupts (Uintr) is an opt-in feature (unlike signals). Applications
wanting to use Uintr are expected to register themselves with the kernel using
the Uintr related system calls. A Uintr receiver is always a userspace task. A
Uintr sender can be another userspace task, kernel or a device.

1) A receiver can register/unregister an interrupt handler using the Uintr
receiver related syscalls. 
		uintr_register_handler(handler, flags)
		uintr_unregister_handler(flags)

2) A syscall also allows a receiver to register a vector and create a user
interrupt file descriptor - uintr_fd. 
		uintr_fd = uintr_create_fd(vector, flags)

Uintr can be useful in some of the usages where eventfd or signals are used for
frequent userspace event notifications. The semantics of uintr_fd are somewhat
similar to an eventfd() or the write end of a pipe.

3) Any sender with access to uintr_fd can use it to deliver events (in this
case - interrupts) to a receiver. A sender task can manage its connection with
the receiver using the sender related syscalls based on uintr_fd.
		uipi_index = uintr_register_sender(uintr_fd, flags)

Using an FD abstraction provides a secure mechanism to connect with a receiver.
The FD sharing and isolation mechanisms put in place by the kernel would extend
to Uintr as well. 

4a) After the initial setup, a sender task can use the SENDUIPI instruction
along with the uipi_index to generate user IPIs without any kernel
intervention.
		SENDUIPI <uipi_index>

If the receiver is running (CPL=3), then the user interrupt is delivered
directly without a kernel transition. If the receiver isn't running the
interrupt is delivered when the receiver gets context switched back. If the
receiver is blocked in the kernel, the user interrupt is delivered to the
kernel which then unblocks the intended receiver to deliver the interrupt.

4b) If the sender is the kernel or a device, the uintr_fd can be passed onto
the related kernel entity to allow them to setup a connection and then generate
a user interrupt for event delivery. <The exact details of this API are still
being worked upon.>

For details of the user interface and associated system calls refer the Uintr
man-pages draft:
https://github.com/intel/uintr-linux-kernel/tree/rfc-v1/tools/uintr/manpages.
We have also included the same content as patch 1 of this series to make it
easier to review.

Refer the Uintr compiler programming guide [4] for details on Uintr integration
with GCC and Binutils.

Kernel design choices
=====================
Here are some of the reasons and trade-offs for the current design of the APIs.

System call interface
---------------------
Why a system call interface?: The 2 options we considered are using a char
device at /dev or use system calls (current approach). A syscall approach
avoids exposing a core cpu feature through a driver model. Also, we want to
have a user interrupt FD per vector and share a single common interrupt handler
among all vectors. This seems easier for the kernel and userspace to accomplish
using a syscall based approach.

Data sharing using user interrupts: Uintr doesn't include a mechanism to
share/transmit data. The expectation is applications use existing data sharing
mechanisms to share data and use Uintr only for signaling.

An FD for each vector: A uintr_fd is assigned to each vector to allow fine
grained priority and event management by the receiver. The alternative we
considered was to allocate an FD to the interrupt handler and having that
shared with the sender. However, that approach relies on the sender selecting
the vector and moves the vector priority management to the sender. Also, if
multiple senders want to send unique user interrupts they would need to
coordinate the vector selection amongst them.

Extending the APIs: Currently, the system calls are only extendable using the
flags argument. We can add a variable size struct to some of the syscalls if
needed.

Extending existing mechanisms
-----------------------------
Uintr can be beneficial in some of the usages where eventfd() or signals are
used. Since Uintr is hardware-dependent, thread-specific and bypasses the
kernel in the fast path, it makes extending existing mechanisms harder.

Main issues with extending signals:
Signal handlers are defined significantly differently than a User interrupt
handler. An application needs to save/restore registers in a user interrupt
handler and call uiret to return from it. Also, signals can be process directed
(or thread directed) but user interrupts are always thread directed.

Comparison of signals with User Interrupts:
+=====================+===========================+===========================+
|                     | Signals                   | User Interrupts           |
+=====================+===========================+===========================+
| Stacks              | Has alt stacks            | Uses application stack    |
|                     |                           | (alternate stack option   |
|                     |                           | not yet enabled)          |
+---------------------+---------------------------+---------------------------+
| Registers state     | Kernel manages incl.      | App responsible (Use GCC  |
|                     | FPU/XSTATE area           | 'interrupt' attribute for |
|                     |                           | general purpose registers)|
+---------------------+---------------------------+---------------------------+
| Blocking/Masking    | sigprocmask(2)/sa_mask    | CLUI instruction (No per  |
|                     |                           | vector masking)           |
+---------------------+---------------------------+---------------------------+
| Direction           | Uni-directional           | Uni-directional           |
+---------------------+---------------------------+---------------------------+
| Post event          | kill(), signal(),         | SENDUIPI <index> - index  |
|                     | sigqueue(), etc.          | derived from uintr_fd     |
+---------------------+---------------------------+---------------------------+
| Target              | Process-directed or       | Thread-directed           |
|                     | thread-directed           |                           |
+---------------------+---------------------------+---------------------------+
| Fork/inheritance    | Empty signal set          | Nothing is inherited      |
+---------------------+---------------------------+---------------------------+
| Execv               | Pending signals preserved | Nothing is inherited      |
+---------------------+---------------------------+---------------------------+
| Order of delivery   | Undetermined              | High to low vector numbers|
| for multiple signals|                           |                           |
+---------------------+---------------------------+---------------------------+
| Handler re-entry    | All signals except the    | No interrupts can cause   |
|                     | one being handled         | handler re-entry.         |
+---------------------+---------------------------+---------------------------+
| Delivery feedback   | 0 or -1 based on whether  | No feedback on whether the|
|                     | the signal was sent       | interrupt was sent or     |
|                     |                           | received.                 |
+---------------------+---------------------------+---------------------------+

Main issues with extending eventfd():
eventfd() has a counter value that is core to the API. User interrupts can't
have an associated counter since the signaling happens at the user level and
the hardware doesn't have a memory counter mechanism. Also, eventfd can be used
for bi-directional signaling where as uintr_fd is uni-directional.

Comparison of eventfd with uintr_fd:
+====================+======================+==============================+
|                    | Eventfd              | uintr_fd (User Interrupt FD) |
+====================+======================+==============================+
| Object             | Counter - uint64     | Receiver vector information  |
+--------------------+----------------------+------------------------------+
| Post event         | write() to eventfd   | SENDUIPI <index> - index     |
|                    |                      | derived from uintr_fd        |
+--------------------+----------------------+------------------------------+
| Receive event      | read() on eventfd    | Implicit - Handler is        |
|                    |                      | invoked with associated      |
|                    |                      | vector.                      |
+--------------------+----------------------+------------------------------+
| Direction          | Bi-directional       | Uni-directional              |
+--------------------+----------------------+------------------------------+
| Data transmitted   | Counter - uint64     | None                         |
+--------------------+----------------------+------------------------------+
| Waiting for events | Poll() family of     | No per vector wait.          |
|                    | syscalls             | uintr_wait() allows waiting  |
|                    |                      | for all user interrupts      |
+--------------------+----------------------+------------------------------+

Security Model
==============
User Interrupts is designed as an opt-in feature (unlike signals). The security
model for user interrupts is intended to be similar to eventfd(). The general
idea is that any sender with access to uintr_fd would be able to generate the
associated interrupt vector for the receiver task that created the fd.

Untrusted processes
-------------------
The current implementation expects only trusted and cooperating processes to
communicate using user interrupts. Coordination is expected between processes
for a connection teardown. In situations where coordination doesn't happen
(say, due to abrupt process exit), the kernel would end up keeping shared
resources (like UPID) allocated to avoid faults.

Currently, a sender can easily cause a denial of service for the receiver by
generating a storm of user interrupts. A user interrupt handler is invoked with
interrupts disabled, but upon execution of uiret, interrupts get enabled again
by the hardware. This can lead to the handler being invoked again before normal
execution can resume. There isn't a hardware mechanism to mask specific
interrupt vectors. 

To enable untrusted processes to communicate, we need to add a per-vector
masking option through another syscall (or maybe IOCTL). However, this can add
some complexity to the kernel code. A vector can only be masked by modifying
the UITT entries at the source. We need to be careful about races while
removing and restoring the UPID from the UITT.

Resource limits
---------------
The maximum number of receiver-sender connections would be limited by the
maximum number of open file descriptors and the size of the UITT.

The UITT size is chosen as 4kB fixed size arbitrarily right now. We plan to
make it dynamic and configurable in size. RLIMIT_MEMLOCK or ENOMEM should be
triggered when the size limits have been hit.

Main Opens
==========

Blocking for interrupts
-----------------------
User interrupts are delivered to applications immediately if they are running
in userspace. If a receiver task has blocked in the kernel using the placeholder
uintr_wait() syscall, the task would be woken up to deliver the user interrupt.
However, if the task is blocked due to any other blocking calls like read(),
sleep(), etc; the interrupt will only get delivered when the application gets
scheduled again. We need to consider if applications need to receive User
Interrupts as soon as they are posted (similar to signals) when they are
blocked due to some other reason. Adding this capability would likely make the
kernel implementation more complex.

Interrupting system calls using User Interrupts would also mean we need to
consider an SA_RESTART type of mechanism. We also need to evaluate if some of
the signal handler related semantics in the kernel can be reused for User
Interrupts.

Sharing the User Interrupt Target Table (UITT)
----------------------------------------------
The current implementation assigns a unique UITT to each task. This assumes
that User interrupts are used for point-to-point communication between 2 tasks.
Also, this keeps the kernel implementation relatively simple.

However, there are of benefits to sharing the UITT between threads of a
multi-threaded application. One, they would see a consistent view of the UITT.
i.e. SENDUIPI <index> would mean the same on all threads of the application.
Also, each thread doesn't have to register itself using the common uintr_fd.
This would simplify the userspace setup and make efficient use of kernel
memory. The potential downside is that the kernel implementation to allocate,
modify, expand and free the UITT would be more complex.

A similar argument can be made for a set of processes that do a lot of IPC
amongst them. They would prefer to have a shared UITT that lets them target any
process from any process. With the current file descriptor based approach, the
connection setup can be time consuming and somewhat cumbersome. We need to
evaluate if this can be made simpler as well.

Kernel page table isolation (KPTI)
----------------------------------
SENDUIPI is a special ring-3 instruction that makes a supervisor mode memory
access to the UPID and UITT memory. The current patches need KPTI to be
disabled for User IPIs to work. To make User IPI work with KPTI, we need to
allocate these structures from a special memory region that has supervisor
access but it is mapped into userspace. The plan is to implement a mechanism
similar to LDT. 

Processors that support user interrupts are not affected by Meltdown so the
auto mode of KPTI will default to off. Users who want to force enable KPTI will
need to wait for a later version of this patch series to use user interrupts.
Please let us know if you want the development of these patches to be
prioritized (or deprioritized).

FAQs
====
Q: What happens if a process is "surprised" by a user interrupt?
A: For tasks that haven't registered with the kernel and requested for user
interrupts aren't expected or able to receive to user interrupts.

Q: Do user interrupts affect kernel scheduling?
A: No. If a task is blocked waiting for user interrupts, when the kernel
receives a notification on behalf of that task we only put it back on the
runqueue. Delivery of a user interrupt in no way changes the scheduling
priorities of a task.

Q: Does the sender get to know if the interrupt was delivered?
A: No. User interrupts only provides a posted interrupt delivery mechanism. If
applications need to rely on whether the interrupt was delivered they should
consider a userspace mechanism for feedback (like a shared memory counter or a
user interrupt back to the sender).

Q: Why is there no feedback on interrupt delivery?
A: Being a posted interrupt delivery mechanism, the interrupt delivery
happens in 2 steps:
1) The interrupt information is stored in a memory location (UPID).
2) The physical interrupt is delivered to the interrupt receiver.

The 2nd step could happen immediately, after an extended period, or it might
never happen based on the state of the receiver after step 1. (The receiver
could have disabled interrupts, have been context switched out or it might have
crashed during that time.) This makes it very hard for the hardware to reliably
provide feedback upon execution of SENDUIPI.

Q: Can user interrupts be nested?
A: Yes. Using STUI instruction in the interrupt handler would allow new user
interrupts to be delivered. However, there no TPR(thread priority register)
like mechanism to allow only higher priority interrupts. Any user interrupt can
be taken when nesting is enabled.

Q: Can a task receive all pending user interrupts in one go?
A: No. The hardware allows only one vector to be processed at a time. If a task
is interested in knowing all the interrupts that are pending then we could add
a syscall that provides the pending interrupts information.

Q: Do the processes need to be pinned to a cpu?
A: No. User interrupts will be routed correctly to whichever cpu the receiver
is running on. The kernel updates the cpu information in the UPID during
context switch.

Q: Why are UPID and UITT allocated by the kernel?
A: If allocated by user space, applications could misuse the UPID and UITT to
write to unauthorized memory and generate interrupts on any cpu. The UPID and
UITT are allocated by the kernel and accessed by the hardware with supervisor
privilege.

Patch structure for this series
===============================
- Man-pages and Kernel documentation (patch 1,2)
- Hardware enumeration (patch 3, 4)
- User IPI kernel vector reservation (patch 5)
- Syscall interface for interrupt receiver, sender and vector
  management(uintr_fd) (patch 6-12)
- Basic selftests (patch 13)

Along with the patches in this RFC, there are additional tests and samples that
are available at:
https://github.com/intel/uintr-linux-kernel/tree/rfc-v1

Links
=====
[1]: https://software.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html
[2]: https://libevent.org/
[3]: https://github.com/axboe/liburing
[4]: https://github.com/intel/uintr-compiler-guide/blob/uintr-gcc-11.1/UINTR-compiler-guide.pdf

Sohil Mehta (13):
  x86/uintr/man-page: Include man pages draft for reference
  Documentation/x86: Add documentation for User Interrupts
  x86/cpu: Enumerate User Interrupts support
  x86/fpu/xstate: Enumerate User Interrupts supervisor state
  x86/irq: Reserve a user IPI notification vector
  x86/uintr: Introduce uintr receiver syscalls
  x86/process/64: Add uintr task context switch support
  x86/process/64: Clean up uintr task fork and exit paths
  x86/uintr: Introduce vector registration and uintr_fd syscall
  x86/uintr: Introduce user IPI sender syscalls
  x86/uintr: Introduce uintr_wait() syscall
  x86/uintr: Wire up the user interrupt syscalls
  selftests/x86: Add basic tests for User IPI

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/user-interrupts.rst         | 107 +++
 arch/x86/Kconfig                              |  12 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   6 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   6 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/entry-common.h           |   4 +
 arch/x86/include/asm/fpu/types.h              |  20 +-
 arch/x86/include/asm/fpu/xstate.h             |   3 +-
 arch/x86/include/asm/hardirq.h                |   4 +
 arch/x86/include/asm/idtentry.h               |   5 +
 arch/x86/include/asm/irq_vectors.h            |   6 +-
 arch/x86/include/asm/msr-index.h              |   8 +
 arch/x86/include/asm/processor.h              |   8 +
 arch/x86/include/asm/uintr.h                  |  76 ++
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/cpu/common.c                  |  61 ++
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/fpu/core.c                    |  17 +
 arch/x86/kernel/fpu/xstate.c                  |  20 +-
 arch/x86/kernel/idt.c                         |   4 +
 arch/x86/kernel/irq.c                         |  51 +
 arch/x86/kernel/process.c                     |  10 +
 arch/x86/kernel/process_64.c                  |   4 +
 arch/x86/kernel/uintr_core.c                  | 880 ++++++++++++++++++
 arch/x86/kernel/uintr_fd.c                    | 300 ++++++
 include/linux/syscalls.h                      |   8 +
 include/uapi/asm-generic/unistd.h             |  15 +-
 kernel/sys_ni.c                               |   8 +
 scripts/checksyscalls.sh                      |   6 +
 tools/testing/selftests/x86/Makefile          |  10 +
 tools/testing/selftests/x86/uintr.c           | 147 +++
 tools/uintr/manpages/0_overview.txt           | 265 ++++++
 tools/uintr/manpages/1_register_receiver.txt  | 122 +++
 .../uintr/manpages/2_unregister_receiver.txt  |  62 ++
 tools/uintr/manpages/3_create_fd.txt          | 104 +++
 tools/uintr/manpages/4_register_sender.txt    | 121 +++
 tools/uintr/manpages/5_unregister_sender.txt  |  79 ++
 tools/uintr/manpages/6_wait.txt               |  59 ++
 42 files changed, 2626 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/x86/user-interrupts.rst
 create mode 100644 arch/x86/include/asm/uintr.h
 create mode 100644 arch/x86/kernel/uintr_core.c
 create mode 100644 arch/x86/kernel/uintr_fd.c
 create mode 100644 tools/testing/selftests/x86/uintr.c
 create mode 100644 tools/uintr/manpages/0_overview.txt
 create mode 100644 tools/uintr/manpages/1_register_receiver.txt
 create mode 100644 tools/uintr/manpages/2_unregister_receiver.txt
 create mode 100644 tools/uintr/manpages/3_create_fd.txt
 create mode 100644 tools/uintr/manpages/4_register_sender.txt
 create mode 100644 tools/uintr/manpages/5_unregister_sender.txt
 create mode 100644 tools/uintr/manpages/6_wait.txt


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.33.0

