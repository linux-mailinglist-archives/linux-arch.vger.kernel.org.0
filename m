Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6588047D503
	for <lists+linux-arch@lfdr.de>; Wed, 22 Dec 2021 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhLVQRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbhLVQRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 11:17:47 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E80C061401
        for <linux-arch@vger.kernel.org>; Wed, 22 Dec 2021 08:17:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r139so1892074qke.9
        for <linux-arch@vger.kernel.org>; Wed, 22 Dec 2021 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mnXk95uBakRb4EU1/OymnSvMTCOVSvUuXAwdVRaWu8U=;
        b=fgsgC1iMMnP7QRwbhyF0hB1XUIG7rTC44aNBz9NUriaef+nXgxsrbhPIVWH7GvqX9D
         lGNL+Jy+akd3WVX4bVc6yaAAR/FRv7IQ/DX/IAadWnNIGxhiHlNLLJBC6y/mdPhl8Tpb
         G734TaupRA0VlADlOJthxA7c8PW1F4o1nmP56OdqCnECkfVuQ4EoLj4LRE41bxheGixl
         WTBrdbW3yS9aRO/sU+TK/i8XSotVXtqgh1K04C/1tCA4Rdh4E6su+H9DrjEbF8Csb9ya
         s5XNTis8Uj9Q1kwDiE8X8hBF+DODYexW+omBKLx68HMmJ1yGyT1me+ziW1FAz18+wKrI
         Dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mnXk95uBakRb4EU1/OymnSvMTCOVSvUuXAwdVRaWu8U=;
        b=UjHL1yT7FA96NkpYxX3IqNH1QgoP4KvpvkFC8URXVp9zPry7Qz7KJFjQngWzxemk3Q
         qovETaJC4yxlVb8yuv/Z7vZqWbYllnmW8wFmHOO+4hlr2RMEGNIIZE8ORvVPhLirdMA6
         T4j42/eMAY+WWmJYp9sVcSpOM1Ds9ENmvORhtNRrbThMGYpmoRn2IvjO+tP56U6kmjcY
         i1kFrm+7cBcKkVGphtmUeS//uux/lpYOtMaIVAQVPk1xwAKXRVccyffEYiv4QI7Ko5sW
         JkBxvAAFzhrsLpxF8mjrnpQ6hQNbM7iKPYlKUE4QZOFe46GXckVVIyTvpJEmvuGTCmx7
         KXag==
X-Gm-Message-State: AOAM5308FFFQm4zF6Z9SIuAWlTNSh/kT5HzY/qBk3vdoUMmhpRqEA4EZ
        EyPSAGB+nqtz/rpcNHF++w6iuw==
X-Google-Smtp-Source: ABdhPJzCZHpvB1YySILVUagAeszWKlq2MnrtcqTwlcdCnITJOL0jTCP4U/nBHbtwtadxSRq+fNtbkA==
X-Received: by 2002:a37:42d0:: with SMTP id p199mr2467284qka.523.1640189865965;
        Wed, 22 Dec 2021 08:17:45 -0800 (PST)
Received: from ?IPv6:2601:547:900:1070:2884:a8a1:1486:3664? ([2601:547:900:1070:2884:a8a1:1486:3664])
        by smtp.gmail.com with ESMTPSA id o9sm2040225qtk.81.2021.12.22.08.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 08:17:45 -0800 (PST)
From:   Chrisma Pakha <cpakha@andrew.cmu.edu>
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>,
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        seth@cmu.edu
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
Message-ID: <9b5a8cf9-5ce6-c6ba-951f-757135d74492@andrew.cmu.edu>
Date:   Wed, 22 Dec 2021 11:17:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/13/21 4:01 PM, Sohil Mehta wrote:
> User Interrupts Introduction
> ============================
>
> User Interrupts (Uintr) is a hardware technology that enables delivering
> interrupts directly to user space.
>
> Today, virtually all communication across privilege boundaries happens by going
> through the kernel. These include signals, pipes, remote procedure calls and
> hardware interrupt based notifications. User interrupts provide the foundation
> for more efficient (low latency and low CPU utilization) versions of these
> common operations by avoiding transitions through the kernel.
>
> In the User Interrupts hardware architecture, a receiver is always expected to
> be a user space task. However, a user interrupt can be sent by another user
> space task, kernel or an external source (like a device).
>
> In addition to the general infrastructure to receive user interrupts, this
> series introduces a single source: interrupts from another user task.  These
> are referred to as User IPIs.
>
> The first implementation of User IPIs will be in the Intel processor code-named
> Sapphire Rapids. Refer Chapter 11 of the Intel Architecture instruction set
> extensions for details of the hardware architecture [1].
>
> Series-reviewed-by: Tony Luck<tony.luck@intel.com>
>
> Main goals of this RFC
> ======================
> - Introduce this upcoming technology to the community.
> This cover letter includes a hardware architecture summary along with the
> software architecture and kernel design choices. This post is a bit long as a
> result. Hopefully, it helps answer more questions than it creates :) I am also
> planning to talk about User Interrupts next week at the LPC Kernel summit.
>
> - Discuss potential use cases.
> We are starting to look at actual usages and libraries (like libevent[2] and
> liburing[3]) that can take advantage of this technology. Unfortunately, we
> don't have much to share on this right now. We need some help from the
> community to identify usages that can benefit from this. We would like to make
> sure the proposed APIs work for the eventual consumers.
>
> - Get early feedback on the software architecture.
> We are hoping to get some feedback on the direction of overall software
> architecture - starting with User IPI, extending it for kernel-to-user
> interrupt notifications and external interrupts in the future.
>
> - Discuss some of the main architecture opens.
> There is lot of work that still needs to happen to enable this technology. We
> are looking for some input on future patches that would be of interest. Here
> are some of the big opens that we are looking to resolve.
> * Should Uintr interrupt all blocking system calls like sleep(), read(),
>    poll(), etc? If so, should we implement an SA_RESTART type of mechanism
>    similar to signals? - Refer Blocking for interrupts section below.
>
> * Should the User Interrupt Target table (UITT) be shared between threads of a
>    multi-threaded application or maybe even across processes? - Refer Sharing
>    the UITT section below.
>
> Why care about this? - Micro benchmark performance
> ==================================================
> There is a ~9x or higher performance improvement using User IPI over other IPC
> mechanisms for event signaling.
>
> Below is the average normalized latency for a 1M ping-pong IPC notifications
> with message size=1.
>
> +------------+-------------------------+
> | IPC type   |   Relative Latency      |
> |            |(normalized to User IPI) |
> +------------+-------------------------+
> | User IPI   |                     1.0 |
> | Signal     |                    14.8 |
> | Eventfd    |                     9.7 |
> | Pipe       |                    16.3 |
> | Domain     |                    17.3 |
> +------------+-------------------------+
>
> Results have been estimated based on tests on internal hardware with Linux
> v5.14 + User IPI patches.
>
> Original benchmark:https://github.com/goldsborough/ipc-bench
> Updated benchmark:https://github.com/intel/uintr-ipc-bench/tree/linux-rfc-v1
>
> *Performance varies by use, configuration and other factors.
>
> How it works underneath? - Hardware Summary
> ===========================================
> User Interrupts is a posted interrupt delivery mechanism. The interrupts are
> first posted to a memory location and then delivered to the receiver when they
> are running with CPL=3.
>
> Kernel managed architectural data structures
> --------------------------------------------
> UPID: User Posted Interrupt Descriptor - Holds receiver interrupt vector
> information and notification state (like an ongoing notification, suppressed
> notifications).
>
> UITT: User Interrupt Target Table - Stores UPID pointer and vector information
> for interrupt routing on the sender side. Referred by the senduipi instruction.
>
> The interrupt state of each task is referenced via MSRs which are saved and
> restored by the kernel during context switch.
>
> Instructions
> ------------
> senduipi <index> - send a user IPI to a target task based on the UITT index.
>
> clui - Mask user interrupts by clearing UIF (User Interrupt Flag).
>
> stui - Unmask user interrupts by setting UIF.
>
> testui - Test current value of UIF.
>
> uiret - return from a user interrupt handler.
>
> User IPI
> --------
> When a User IPI sender executes 'senduipi <index>', the hardware refers the
> UITT table entry pointed by the index and posts the interrupt vector (63-0)
> into the receiver's UPID.
>
> If the receiver is running (CPL=3), the sender cpu would send a physical IPI to
> the receiver's cpu. On the receiver side this IPI is detected as a User
> Interrupt. The User Interrupt handler for the receiver is invoked and the
> vector number (63-0) is pushed onto the stack.
>
> Upon execution of 'uiret' in the interrupt handler, the control is transferred
> back to instruction that was interrupted.
>
> Refer Chapter 11 of the Intel Architecture instruction set extensions [1] for
> more details.
>
> Application interface - Software Architecture
> =============================================
> User Interrupts (Uintr) is an opt-in feature (unlike signals). Applications
> wanting to use Uintr are expected to register themselves with the kernel using
> the Uintr related system calls. A Uintr receiver is always a userspace task. A
> Uintr sender can be another userspace task, kernel or a device.
>
> 1) A receiver can register/unregister an interrupt handler using the Uintr
> receiver related syscalls.
> 		uintr_register_handler(handler, flags)
> 		uintr_unregister_handler(flags)
>
> 2) A syscall also allows a receiver to register a vector and create a user
> interrupt file descriptor - uintr_fd.
> 		uintr_fd = uintr_create_fd(vector, flags)
>
> Uintr can be useful in some of the usages where eventfd or signals are used for
> frequent userspace event notifications. The semantics of uintr_fd are somewhat
> similar to an eventfd() or the write end of a pipe.
>
> 3) Any sender with access to uintr_fd can use it to deliver events (in this
> case - interrupts) to a receiver. A sender task can manage its connection with
> the receiver using the sender related syscalls based on uintr_fd.
> 		uipi_index = uintr_register_sender(uintr_fd, flags)
>
> Using an FD abstraction provides a secure mechanism to connect with a receiver.
> The FD sharing and isolation mechanisms put in place by the kernel would extend
> to Uintr as well.
>
> 4a) After the initial setup, a sender task can use the SENDUIPI instruction
> along with the uipi_index to generate user IPIs without any kernel
> intervention.
> 		SENDUIPI <uipi_index>
>
> If the receiver is running (CPL=3), then the user interrupt is delivered
> directly without a kernel transition. If the receiver isn't running the
> interrupt is delivered when the receiver gets context switched back. If the
> receiver is blocked in the kernel, the user interrupt is delivered to the
> kernel which then unblocks the intended receiver to deliver the interrupt.
>
> 4b) If the sender is the kernel or a device, the uintr_fd can be passed onto
> the related kernel entity to allow them to setup a connection and then generate
> a user interrupt for event delivery. <The exact details of this API are still
> being worked upon.>
>
> For details of the user interface and associated system calls refer the Uintr
> man-pages draft:
> https://github.com/intel/uintr-linux-kernel/tree/rfc-v1/tools/uintr/manpages.
> We have also included the same content as patch 1 of this series to make it
> easier to review.
>
> Refer the Uintr compiler programming guide [4] for details on Uintr integration
> with GCC and Binutils.
>
> Kernel design choices
> =====================
> Here are some of the reasons and trade-offs for the current design of the APIs.
>
> System call interface
> ---------------------
> Why a system call interface?: The 2 options we considered are using a char
> device at /dev or use system calls (current approach). A syscall approach
> avoids exposing a core cpu feature through a driver model. Also, we want to
> have a user interrupt FD per vector and share a single common interrupt handler
> among all vectors. This seems easier for the kernel and userspace to accomplish
> using a syscall based approach.
>
> Data sharing using user interrupts: Uintr doesn't include a mechanism to
> share/transmit data. The expectation is applications use existing data sharing
> mechanisms to share data and use Uintr only for signaling.
>
> An FD for each vector: A uintr_fd is assigned to each vector to allow fine
> grained priority and event management by the receiver. The alternative we
> considered was to allocate an FD to the interrupt handler and having that
> shared with the sender. However, that approach relies on the sender selecting
> the vector and moves the vector priority management to the sender. Also, if
> multiple senders want to send unique user interrupts they would need to
> coordinate the vector selection amongst them.
>
> Extending the APIs: Currently, the system calls are only extendable using the
> flags argument. We can add a variable size struct to some of the syscalls if
> needed.
>
> Extending existing mechanisms
> -----------------------------
> Uintr can be beneficial in some of the usages where eventfd() or signals are
> used. Since Uintr is hardware-dependent, thread-specific and bypasses the
> kernel in the fast path, it makes extending existing mechanisms harder.
>
> Main issues with extending signals:
> Signal handlers are defined significantly differently than a User interrupt
> handler. An application needs to save/restore registers in a user interrupt
> handler and call uiret to return from it. Also, signals can be process directed
> (or thread directed) but user interrupts are always thread directed.
>
> Comparison of signals with User Interrupts:
> +=====================+===========================+===========================+
> |                     | Signals                   | User Interrupts           |
> +=====================+===========================+===========================+
> | Stacks              | Has alt stacks            | Uses application stack    |
> |                     |                           | (alternate stack option   |
> |                     |                           | not yet enabled)          |
> +---------------------+---------------------------+---------------------------+
> | Registers state     | Kernel manages incl.      | App responsible (Use GCC  |
> |                     | FPU/XSTATE area           | 'interrupt' attribute for |
> |                     |                           | general purpose registers)|
> +---------------------+---------------------------+---------------------------+
> | Blocking/Masking    | sigprocmask(2)/sa_mask    | CLUI instruction (No per  |
> |                     |                           | vector masking)           |
> +---------------------+---------------------------+---------------------------+
> | Direction           | Uni-directional           | Uni-directional           |
> +---------------------+---------------------------+---------------------------+
> | Post event          | kill(), signal(),         | SENDUIPI <index> - index  |
> |                     | sigqueue(), etc.          | derived from uintr_fd     |
> +---------------------+---------------------------+---------------------------+
> | Target              | Process-directed or       | Thread-directed           |
> |                     | thread-directed           |                           |
> +---------------------+---------------------------+---------------------------+
> | Fork/inheritance    | Empty signal set          | Nothing is inherited      |
> +---------------------+---------------------------+---------------------------+
> | Execv               | Pending signals preserved | Nothing is inherited      |
> +---------------------+---------------------------+---------------------------+
> | Order of delivery   | Undetermined              | High to low vector numbers|
> | for multiple signals|                           |                           |
> +---------------------+---------------------------+---------------------------+
> | Handler re-entry    | All signals except the    | No interrupts can cause   |
> |                     | one being handled         | handler re-entry.         |
> +---------------------+---------------------------+---------------------------+
> | Delivery feedback   | 0 or -1 based on whether  | No feedback on whether the|
> |                     | the signal was sent       | interrupt was sent or     |
> |                     |                           | received.                 |
> +---------------------+---------------------------+---------------------------+
>
> Main issues with extending eventfd():
> eventfd() has a counter value that is core to the API. User interrupts can't
> have an associated counter since the signaling happens at the user level and
> the hardware doesn't have a memory counter mechanism. Also, eventfd can be used
> for bi-directional signaling where as uintr_fd is uni-directional.
>
> Comparison of eventfd with uintr_fd:
> +====================+======================+==============================+
> |                    | Eventfd              | uintr_fd (User Interrupt FD) |
> +====================+======================+==============================+
> | Object             | Counter - uint64     | Receiver vector information  |
> +--------------------+----------------------+------------------------------+
> | Post event         | write() to eventfd   | SENDUIPI <index> - index     |
> |                    |                      | derived from uintr_fd        |
> +--------------------+----------------------+------------------------------+
> | Receive event      | read() on eventfd    | Implicit - Handler is        |
> |                    |                      | invoked with associated      |
> |                    |                      | vector.                      |
> +--------------------+----------------------+------------------------------+
> | Direction          | Bi-directional       | Uni-directional              |
> +--------------------+----------------------+------------------------------+
> | Data transmitted   | Counter - uint64     | None                         |
> +--------------------+----------------------+------------------------------+
> | Waiting for events | Poll() family of     | No per vector wait.          |
> |                    | syscalls             | uintr_wait() allows waiting  |
> |                    |                      | for all user interrupts      |
> +--------------------+----------------------+------------------------------+
>
> Security Model
> ==============
> User Interrupts is designed as an opt-in feature (unlike signals). The security
> model for user interrupts is intended to be similar to eventfd(). The general
> idea is that any sender with access to uintr_fd would be able to generate the
> associated interrupt vector for the receiver task that created the fd.
>
> Untrusted processes
> -------------------
> The current implementation expects only trusted and cooperating processes to
> communicate using user interrupts. Coordination is expected between processes
> for a connection teardown. In situations where coordination doesn't happen
> (say, due to abrupt process exit), the kernel would end up keeping shared
> resources (like UPID) allocated to avoid faults.
>
> Currently, a sender can easily cause a denial of service for the receiver by
> generating a storm of user interrupts. A user interrupt handler is invoked with
> interrupts disabled, but upon execution of uiret, interrupts get enabled again
> by the hardware. This can lead to the handler being invoked again before normal
> execution can resume. There isn't a hardware mechanism to mask specific
> interrupt vectors.
>
> To enable untrusted processes to communicate, we need to add a per-vector
> masking option through another syscall (or maybe IOCTL). However, this can add
> some complexity to the kernel code. A vector can only be masked by modifying
> the UITT entries at the source. We need to be careful about races while
> removing and restoring the UPID from the UITT.
>
> Resource limits
> ---------------
> The maximum number of receiver-sender connections would be limited by the
> maximum number of open file descriptors and the size of the UITT.
>
> The UITT size is chosen as 4kB fixed size arbitrarily right now. We plan to
> make it dynamic and configurable in size. RLIMIT_MEMLOCK or ENOMEM should be
> triggered when the size limits have been hit.
>
> Main Opens
> ==========
>
> Blocking for interrupts
> -----------------------
> User interrupts are delivered to applications immediately if they are running
> in userspace. If a receiver task has blocked in the kernel using the placeholder
> uintr_wait() syscall, the task would be woken up to deliver the user interrupt.
> However, if the task is blocked due to any other blocking calls like read(),
> sleep(), etc; the interrupt will only get delivered when the application gets
> scheduled again. We need to consider if applications need to receive User
> Interrupts as soon as they are posted (similar to signals) when they are
> blocked due to some other reason. Adding this capability would likely make the
> kernel implementation more complex.
>
> Interrupting system calls using User Interrupts would also mean we need to
> consider an SA_RESTART type of mechanism. We also need to evaluate if some of
> the signal handler related semantics in the kernel can be reused for User
> Interrupts.
>
> Sharing the User Interrupt Target Table (UITT)
> ----------------------------------------------
> The current implementation assigns a unique UITT to each task. This assumes
> that User interrupts are used for point-to-point communication between 2 tasks.
> Also, this keeps the kernel implementation relatively simple.
>
> However, there are of benefits to sharing the UITT between threads of a
> multi-threaded application. One, they would see a consistent view of the UITT.
> i.e. SENDUIPI <index> would mean the same on all threads of the application.
> Also, each thread doesn't have to register itself using the common uintr_fd.
> This would simplify the userspace setup and make efficient use of kernel
> memory. The potential downside is that the kernel implementation to allocate,
> modify, expand and free the UITT would be more complex.
>
> A similar argument can be made for a set of processes that do a lot of IPC
> amongst them. They would prefer to have a shared UITT that lets them target any
> process from any process. With the current file descriptor based approach, the
> connection setup can be time consuming and somewhat cumbersome. We need to
> evaluate if this can be made simpler as well.
>
> Kernel page table isolation (KPTI)
> ----------------------------------
> SENDUIPI is a special ring-3 instruction that makes a supervisor mode memory
> access to the UPID and UITT memory. The current patches need KPTI to be
> disabled for User IPIs to work. To make User IPI work with KPTI, we need to
> allocate these structures from a special memory region that has supervisor
> access but it is mapped into userspace. The plan is to implement a mechanism
> similar to LDT.
>
> Processors that support user interrupts are not affected by Meltdown so the
> auto mode of KPTI will default to off. Users who want to force enable KPTI will
> need to wait for a later version of this patch series to use user interrupts.
> Please let us know if you want the development of these patches to be
> prioritized (or deprioritized).
>
> FAQs
> ====
> Q: What happens if a process is "surprised" by a user interrupt?
> A: For tasks that haven't registered with the kernel and requested for user
> interrupts aren't expected or able to receive to user interrupts.
>
> Q: Do user interrupts affect kernel scheduling?
> A: No. If a task is blocked waiting for user interrupts, when the kernel
> receives a notification on behalf of that task we only put it back on the
> runqueue. Delivery of a user interrupt in no way changes the scheduling
> priorities of a task.
>
> Q: Does the sender get to know if the interrupt was delivered?
> A: No. User interrupts only provides a posted interrupt delivery mechanism. If
> applications need to rely on whether the interrupt was delivered they should
> consider a userspace mechanism for feedback (like a shared memory counter or a
> user interrupt back to the sender).
>
> Q: Why is there no feedback on interrupt delivery?
> A: Being a posted interrupt delivery mechanism, the interrupt delivery
> happens in 2 steps:
> 1) The interrupt information is stored in a memory location (UPID).
> 2) The physical interrupt is delivered to the interrupt receiver.
>
> The 2nd step could happen immediately, after an extended period, or it might
> never happen based on the state of the receiver after step 1. (The receiver
> could have disabled interrupts, have been context switched out or it might have
> crashed during that time.) This makes it very hard for the hardware to reliably
> provide feedback upon execution of SENDUIPI.
>
> Q: Can user interrupts be nested?
> A: Yes. Using STUI instruction in the interrupt handler would allow new user
> interrupts to be delivered. However, there no TPR(thread priority register)
> like mechanism to allow only higher priority interrupts. Any user interrupt can
> be taken when nesting is enabled.
>
> Q: Can a task receive all pending user interrupts in one go?
> A: No. The hardware allows only one vector to be processed at a time. If a task
> is interested in knowing all the interrupts that are pending then we could add
> a syscall that provides the pending interrupts information.
>
> Q: Do the processes need to be pinned to a cpu?
> A: No. User interrupts will be routed correctly to whichever cpu the receiver
> is running on. The kernel updates the cpu information in the UPID during
> context switch.
>
> Q: Why are UPID and UITT allocated by the kernel?
> A: If allocated by user space, applications could misuse the UPID and UITT to
> write to unauthorized memory and generate interrupts on any cpu. The UPID and
> UITT are allocated by the kernel and accessed by the hardware with supervisor
> privilege.
>
> Patch structure for this series
> ===============================
> - Man-pages and Kernel documentation (patch 1,2)
> - Hardware enumeration (patch 3, 4)
> - User IPI kernel vector reservation (patch 5)
> - Syscall interface for interrupt receiver, sender and vector
>    management(uintr_fd) (patch 6-12)
> - Basic selftests (patch 13)
>
> Along with the patches in this RFC, there are additional tests and samples that
> are available at:
> https://github.com/intel/uintr-linux-kernel/tree/rfc-v1
>
> Links
> =====
> [1]:https://software.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html
> [2]:https://libevent.org/
> [3]:https://github.com/axboe/liburing
> [4]:https://github.com/intel/uintr-compiler-guide/blob/uintr-gcc-11.1/UINTR-compiler-guide.pdf
>
> Sohil Mehta (13):
>    x86/uintr/man-page: Include man pages draft for reference
>    Documentation/x86: Add documentation for User Interrupts
>    x86/cpu: Enumerate User Interrupts support
>    x86/fpu/xstate: Enumerate User Interrupts supervisor state
>    x86/irq: Reserve a user IPI notification vector
>    x86/uintr: Introduce uintr receiver syscalls
>    x86/process/64: Add uintr task context switch support
>    x86/process/64: Clean up uintr task fork and exit paths
>    x86/uintr: Introduce vector registration and uintr_fd syscall
>    x86/uintr: Introduce user IPI sender syscalls
>    x86/uintr: Introduce uintr_wait() syscall
>    x86/uintr: Wire up the user interrupt syscalls
>    selftests/x86: Add basic tests for User IPI
>
>   .../admin-guide/kernel-parameters.txt         |   2 +
>   Documentation/x86/index.rst                   |   1 +
>   Documentation/x86/user-interrupts.rst         | 107 +++
>   arch/x86/Kconfig                              |  12 +
>   arch/x86/entry/syscalls/syscall_32.tbl        |   6 +
>   arch/x86/entry/syscalls/syscall_64.tbl        |   6 +
>   arch/x86/include/asm/cpufeatures.h            |   1 +
>   arch/x86/include/asm/disabled-features.h      |   8 +-
>   arch/x86/include/asm/entry-common.h           |   4 +
>   arch/x86/include/asm/fpu/types.h              |  20 +-
>   arch/x86/include/asm/fpu/xstate.h             |   3 +-
>   arch/x86/include/asm/hardirq.h                |   4 +
>   arch/x86/include/asm/idtentry.h               |   5 +
>   arch/x86/include/asm/irq_vectors.h            |   6 +-
>   arch/x86/include/asm/msr-index.h              |   8 +
>   arch/x86/include/asm/processor.h              |   8 +
>   arch/x86/include/asm/uintr.h                  |  76 ++
>   arch/x86/include/uapi/asm/processor-flags.h   |   2 +
>   arch/x86/kernel/Makefile                      |   1 +
>   arch/x86/kernel/cpu/common.c                  |  61 ++
>   arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
>   arch/x86/kernel/fpu/core.c                    |  17 +
>   arch/x86/kernel/fpu/xstate.c                  |  20 +-
>   arch/x86/kernel/idt.c                         |   4 +
>   arch/x86/kernel/irq.c                         |  51 +
>   arch/x86/kernel/process.c                     |  10 +
>   arch/x86/kernel/process_64.c                  |   4 +
>   arch/x86/kernel/uintr_core.c                  | 880 ++++++++++++++++++
>   arch/x86/kernel/uintr_fd.c                    | 300 ++++++
>   include/linux/syscalls.h                      |   8 +
>   include/uapi/asm-generic/unistd.h             |  15 +-
>   kernel/sys_ni.c                               |   8 +
>   scripts/checksyscalls.sh                      |   6 +
>   tools/testing/selftests/x86/Makefile          |  10 +
>   tools/testing/selftests/x86/uintr.c           | 147 +++
>   tools/uintr/manpages/0_overview.txt           | 265 ++++++
>   tools/uintr/manpages/1_register_receiver.txt  | 122 +++
>   .../uintr/manpages/2_unregister_receiver.txt  |  62 ++
>   tools/uintr/manpages/3_create_fd.txt          | 104 +++
>   tools/uintr/manpages/4_register_sender.txt    | 121 +++
>   tools/uintr/manpages/5_unregister_sender.txt  |  79 ++
>   tools/uintr/manpages/6_wait.txt               |  59 ++
>   42 files changed, 2626 insertions(+), 8 deletions(-)
>   create mode 100644 Documentation/x86/user-interrupts.rst
>   create mode 100644 arch/x86/include/asm/uintr.h
>   create mode 100644 arch/x86/kernel/uintr_core.c
>   create mode 100644 arch/x86/kernel/uintr_fd.c
>   create mode 100644 tools/testing/selftests/x86/uintr.c
>   create mode 100644 tools/uintr/manpages/0_overview.txt
>   create mode 100644 tools/uintr/manpages/1_register_receiver.txt
>   create mode 100644 tools/uintr/manpages/2_unregister_receiver.txt
>   create mode 100644 tools/uintr/manpages/3_create_fd.txt
>   create mode 100644 tools/uintr/manpages/4_register_sender.txt
>   create mode 100644 tools/uintr/manpages/5_unregister_sender.txt
>   create mode 100644 tools/uintr/manpages/6_wait.txt
>
>
> base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f

Hi All,
My apologies if this email was sent twice.
I was not sure if my previous email followed the proper reply instruction.
I resent this email using the first reply method (Saving the mbox file, 
importing it into my mail client, and using reply-to-all from there).
The following is our understanding of the proposed User Interrupt.

----------------------------------------------------------------------------------------

We have been exploring how user-level interrupts (UIs) can be used to
improve performance and programmability in several different areas:
e.g., parallel programming, memory management, I/O, and floating-point
libraries.  Before we venture into the discussion here, we want to
make sure we understand the proposed model. We describe our
understanding below in four sections:

1. Current target use cases
2. Preparing for future use cases
3. Basic Understanding
4. Multi-threaded parallel programming example

If people on this thread could either confirm or point out our
misunderstandings, we would appreciate it.

# Current Use Cases

The Current RFC is focused on sending an interrupt from one user-space
thread (UST) to another user-space thread (UST2UST).  These threads
could be in different processes, as long as the sender has access to
the receiver's User Interrupt File Descriptor (uifd).  Based on our
understanding, UIs are currently targeted as a low overhead
alternative for the current IPC mechanisms.

# Preparing for future use cases

Based on the RFC, we are aware that allowing a device and the kernel
to send a UI is still in development.  Both these cases would support
imprecise interrupts.  We can see a clear use case for the Device to
user-space thread (D2UST) UI, for example, supporting a fast way for a
GPU to inform a thread that it has finished executing a particular
kernel. If someone could point out an example for Kernel to
user-space thread (K2UST) UI, we would appreciate it.

In our work, we have also been exploring precise UIs from the
currently running thread.  We call these CPU to UST (CPU2UST) UIs.
For example, a SIGSEGV generated by writing to a read-only page, a
SIGFPE generated by dividing a number by zero.

- QUESTION: Is there is a rough draft/plan that we can refer to that 
describes the
current thinking on these three cases.

- QUESTION: Are there use cases for K2UST, or is K2UST the same as CPU2UST?

# Basic Understanding

First, we would like to make sure that our understanding of the 
terminology and the data structures is correct.

- User Interrupt Vector (UIV): The identity of the user interrupt.
- User Interrupt Target Table (UITT):
   This allows the sender to locate the "address" of the receiver 
through the uifd.
- ui_frame: Argument passed to the UI handler. It contains a stack 
pointer, saved flags, and an instruction pointer.
- Sender: The thread that issues the `_senduipi`.
- Receiver: The thread that receives the UI from the sender.

Below outlines our understanding of the current API for UIs.

- Each thread that can receive UIs has exactly one handler
   registered with `uintr_register_handler` (a syscall).
- Each thread that registers a handler calls `uintr_create_fd` for
   every user-level interrupt vector (UIV) that they expect to receive.
- The only information delivered to the handler is the UIV.
- There are 64 UIVs that can be used per thread.
- A thread that wants to send a UI must register the receiver's uifd 
with `uintr_register_sender`  (a syscall).
   This returns an index the sender uses to locate the receiver.
- `_senduipi(index)` sends a user interrupt to a particular destination.
   The sender's UITT and index determine the destination.
- A thread uses `_stui` (and `_clui`) to enable (and disable) the 
reception of UIs.
- As for now, there is no mechanism to mask a particular UIV.
- A UI is delivered to the receiver immediately only if it is currently 
running.
- If a thread executes the `uintr_wait()`, it will be scheduled only 
after receiving a UI.
   There is no guarantee on the delay between the processor receiving 
the UI and when the thread is scheduled.
- If a thread is the target of a UI and another thread is running, or 
the target thread is blocked in the kernel,
   then the target thread will handle the UI when it is next scheduled.
- Ordinary interrupts (interrupt delivered with CPL=0) have a higher 
priority over user interrupts.
- UI handler only saves general-purpose registers (e.g., do not save 
floating-point registers).
- User Interrupts with higher UIV are given a higher priority than those 
with smaller UIV.

## Private UITT

The Current RFC focuses on a private UITT where each thread has its own
UITT.  Thus, different threads executing `_senduipi(index1)` with the
same `index1` may cause different receiver threads to be interrupted.

In many cases, the receiver of an interrupt needs to know which thread
sent the interrupt. If we understand the proposal correctly, there are
only 64 user-level interrupt vectors (UIVs), and the UIV is the only
information transmitted to the receiver. The UIV itself allows the
receiver to distinguish different senders through careful management
of the receiver's UIV.

- QUESTION: Given the code below where the same UIV is registered twice:
```c
   uintr_fd1 = uintr_create_fd(vector1, flags)
   uintr_fd2 = uintr_create_fd(vector1, flags)
```
Would `uintr_fd1` be the same as `uintr_fd2`, or would it be registered 
with a different index in the UITT table?

- QUESTION: If it is registered in a different index, would the
   receiver be able to distinguish the sender if `uintr_fd1` and
   `uintr_fd2` are used from two different threads?

- QUESTION: What is the intended future use of the `flags` argument?

## Shared UITT

In the case of the shared UITT model, all the threads share the same
UITT and thus, if two different threads execute `_senduipi(index)`
with the same index, they would both cause an interrupt in the
same destination/receiver.

- QUESTION: Since both threads use the same entry (same
   destination/receiver), does this mean that the receiver will not be
   able to distinguish the sender of the interrupt?

# Multi-threaded parallel programming example

One of the uses for UIs that we have been exploring is combining the
message-passing and shared memory models for parallel programming.  In
our approach, message-passing is used for synchronization and shared
memory for data sharing.  The message passing part of the programming
pattern is based loosely on Active Messages (See ISCA92), where a
particular thread can turn off/on interrupts to ignore incoming
messages so they can execute critical sections without having to
notify any other threads in the system.

- QUESTION: Is there any data on the performance impact of `_stui` and 
`_clui`?

----------------------------------------------------------------------------------------


Thank you.
Best regards,
Chrisma

