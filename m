Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD648FFDC
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 02:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiAQBO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jan 2022 20:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiAQBO5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jan 2022 20:14:57 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA34C06173E
        for <linux-arch@vger.kernel.org>; Sun, 16 Jan 2022 17:14:57 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t1so1343736qkt.11
        for <linux-arch@vger.kernel.org>; Sun, 16 Jan 2022 17:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrew.cmu.edu; s=google-2021;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K6Eoc7SHg6GXRpqRVCIjFM1kncjBJ/efZihL9Xup8bE=;
        b=eR7nN0GZ3uc8a0lXI4mXCrabLyRkqejRFRpa8K0pFMZsBnNTrLbUCeOJJvTjdin8df
         IO5lH5QVuloUJumZgnRXI8R9sRnMrWxoMjMO0JrF68UwaCjLcCuC5PXA77AEPcqRNfnp
         NfU16ghBuggEyv7sHsGKbdnASihuAybaG20e4oE+57cRQXSMS4oqBa+UjWwqP1VBXFMI
         OZ251EwtUT9BjH38eGJ/7/HoD/UazoyyMclWvhe2Tgkr4lQaVPyt1gjZExSxP0DDUM80
         OMVuzlhKARKFWYpi46hhf0+zKvxPnK2oF5LLGdq9hc/VztfnQMpRj+kzpVKzX1p7kNFa
         JVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K6Eoc7SHg6GXRpqRVCIjFM1kncjBJ/efZihL9Xup8bE=;
        b=SL5sKe7jrmbDFKSSNgnZT9eCBbjyhziVk01FU78r160UafeXuKh5izNMsZB2AQpE1F
         eRbRcJugL81IkOKURA8SWi3QjoOC6BgnQpLlmY/ViZ18CzB1lcnWNo0dGbMrz1JcBOxs
         QWSHKuHCJpzKWST9qexeZ8qybKT+Dx+duw6A2oan0zVX94kCQRomBBnxyD+IUdk62DcV
         SU72Mf7piMX8R8Y2HEitulj0fyWDTrb+zg0+fe8Bihlb3JwDRa5LWAGOaY8V/fj1HdbH
         ZmCsIh4Ir8z8hBKkUuM6A9mIMbA45zH7dqhwZn1jlY7eSO3rJdJW7hHPOt4E/s3ldTJA
         vLbg==
X-Gm-Message-State: AOAM531UpHJNm5zQVQwXmV0gdXiZasx3gsUf2dqRDLCosLIlZugKa5VK
        LfpQglY3uvY23aaGM59DI3Y71Q==
X-Google-Smtp-Source: ABdhPJxE6fP16gG5EwuvrEri77geVtSPdEcMP7JZB89Ki1FgarDLWjUEgX6krosQAyHad2CQ5PsFYg==
X-Received: by 2002:a05:620a:205a:: with SMTP id d26mr13293737qka.54.1642382095876;
        Sun, 16 Jan 2022 17:14:55 -0800 (PST)
Received: from ?IPV6:2601:547:900:1070:90da:bfc1:ba35:80f5? ([2601:547:900:1070:90da:bfc1:ba35:80f5])
        by smtp.gmail.com with ESMTPSA id t204sm7639348qka.127.2022.01.16.17.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 17:14:55 -0800 (PST)
Message-ID: <3d8d8dd7-deb4-f5c4-c7c5-e1d5972c71f4@andrew.cmu.edu>
Date:   Sun, 16 Jan 2022 20:14:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>
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
        seth@cmu.edu, x86@kernel.org
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <9b5a8cf9-5ce6-c6ba-951f-757135d74492@andrew.cmu.edu>
 <7c1038de-0bae-3b87-d4e4-8a30a910ebdd@intel.com>
From:   Chrisma Pakha <cpakha@andrew.cmu.edu>
In-Reply-To: <7c1038de-0bae-3b87-d4e4-8a30a910ebdd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sohil,

Thank you for your reply and the clarification.

>>
>> We have been exploring how user-level interrupts (UIs) can be used to
>> improve performance and programmability in several different areas:
>> e.g., parallel programming, memory management, I/O, and floating-point
>> libraries.
>
> Can you please share more details on this? It would really help 
> improve the API design.
>
Of course! Below we describe a few use cases for both user-level 
interrupts (UIs) and user-level exceptions (UEs). We realize that the 
current proposal is targeted towards UIs, but we also describe some UEs 
use cases because we believe handling exceptions without going through 
the kernel may provide even more of a benefit than UIs. We hope these 
use cases can influence the direction of the API so that it can be made 
forward compatible for future hardware revisions.

To be clear, we distinguish between interrupts (generated from an 
external source, such as another core or Device) that are most likely 
imprecise and asynchronous and exceptions (generated by the currently 
executing program) that need to be precise and synchronous.

# UST2UST

A UI is a mechanism to allow two or more threads to communicate with one 
another asynchronously without requiring the intervention of the kernel 
or a change in privilege. We believe that having UIs can help integrate 
the shared memory model and message passing model for multicore 
processors. This integration makes it easier to build parallel programs, 
allowing developers to take advantage of both models. The shared memory 
model provides an easy way to share data between threads, while the 
message passing model can be used for synchronization between threads.

In the following section, we will describe two use cases for UIs.
- We show how UIs can be used to improve parallel program performance by 
reducing the overhead of exposing parallelism.
- We show how UIs can be used to build efficient active messages.

Both of the use cases we present below require the receiver of a UI to 
know which thread issued it. At the end of the email we describe how we 
would implement this using the current API and suggest an alternative, 
and possibly more streamlined approach.

## Lazy Work Stealing

One of the hurdles in writing parallel programs is ensuring that the 
cost of parallelizing the code does not become a bottleneck in program 
performance. Some of these overheads come from unnecessarily exposing 
too much parallelism, even if all cores are busy. One mechanism to 
reduce this overhead is to lazily expose parallelism only when it is 
needed. This can be done through stack unwinding (similar to how 
Exception Handling works). Whenever a thread (thief) asks for work from 
another thread (victim), the victim will perform stack unwinding, 
creating the work for the thief. This approach to lazy thread creation 
requires some mechanism for the thief to ask for work.

We have implemented a prototype compiler and runtime for this mechanism. 
Our runtime requires a mechanism for the thief to signal the victim when 
it needs work. We implement this signaling through polls because the 
current IPI mechanism is too expensive to use. However, requiring the 
victim to poll can introduce excessive polling overhead and/or introduce 
significant latency between the request and the response. The compiler 
tries to keep the overhead of polling low (<5%) while still ensuring 
that the latency between a work-stealing request and its response is as 
low as possible. Currently, we essentially only poll for work requests 
in the function prologue, keeping the overhead to about 2% of execution 
time on average. This works well for almost all applications. However, 
in some applications, this can add 100 of microseconds of latency to the 
response of a work-stealing request.

One reason we use polling today, instead of the victim just taking work, 
is that there are points in the program where work-stealing is not 
allowed. So, in addition to having an inexpensive mechanism to request 
work, we need an inexpensive method to disallow the requests. IOW, the 
compiler only inserts polls at points where it is safe to do so. With 
the UI mechanism in the proposed API, we could signal a work-stealing 
request with a UST2UST UI and disallow such requests by disabling 
interrupts. One nice advantage of the current proposal is that disabling 
interrupts is a *local* operation, making it very inexpensive and not 
causing any interference with the rest of the threads. In other words, 
an important benefit of the proposed UI mechanism is that we can ensure 
atomicity (with respect to work stealing) without having to do any 
global communication.

## Implementing Active Message

Active messages can efficiently support the message passing parallel 
programming model. With the proposed API, the UI could signal that an AM 
is being delivered while shared memory data structures could be used for 
the payload. As described in the above use case, this would allow 
receiving threads to provide atomicity by disabling interrupts without 
any global communication.

Clearly, having a shared address space makes data access and management 
easier for parallel programming. On the other hand, controlling access 
to that data can often be cleaner to implement in message passing 
models. Dogan et al. have shown promising improvements by using explicit 
messaging hardware to accelerate Machine Learning and Graphs workloads 
(see [DHAKWETAL17,DAKK19]). Explicit messaging is used as a 
synchronization mechanism and has better scalability than shared 
memory-based synchronization. The current proposal would support this 
model integration with significantly lower overheads and lower latencies 
compared to what are available on today's machines.

------------------------------------------------------------------------
# D2UST

Applications that frequently interact with external devices can benefit 
from UIs. To achieve high performance, conventional IO approaches 
through the kernel are not appealing as it incurs high overhead. It 
requires context switching and data transfer from kernel-space to 
user-space, possibly polluting the cache and TLB. One improvement to 
bypass the kernel is by pinning pages to specific physical addresses, 
where these pages act as a buffer between user-space and device. 
However, since the device cannot directly interrupt the UST, the UST 
needs to poll to check if the data from the device is available. 
However, having the UST poll can easily erase any potential performance 
improvements offered by bypassing the kernel in the first place. 
Allowing a device to interrupt a UST under the proposed API will 
eliminate the need to poll and support atomicity as required which could 
significantly improve application performance.

This would be particularly useful when an application uses a GPU as an 
accelerator for parallel computation and CPU for serial computation (see 
[WBSACETAL08]). An example would be K-means. Finding which clusters each 
point belongs to is computed in the GPU (in parallel), while computing 
the mean is computed in the CPU (in serial). As this process is 
iterative, there are multiple computation transitions between the CPU 
and GPU. Without UIs, the only real option is to poll for GPU task 
completion, complicating control flow if there is also other work for 
the CPU thread to do. With UIs, keeping the GPU busy can be handled by 
the UI handler. The result would be cleaner code and better load 
balancing. To make this work, the D2UST interrupt will have to ensure 
that the process that started the task on the GPU is the same one that 
is currently running. When a different process is running, the interrupt 
will have to be saved by the kernel so it can be delivered to the UST 
when is is next scheduled.

------------------------------------------------------------------------

# CPU2UST

Providing a low cost user-level exception mechanism could fundamentally 
change the approach to implementing many algorithms. Examples range 
across many common tasks, e.g., checking for valid pointers, 
preprocessing floating-point data, garbage collection, etc. Today, due 
to the high cost of exception handling, programmers go to great lengths 
to ensure that exceptions do not happen. Unfortunately, this leads to 
more code and often less performance. Below we describe different 
scenarios where UEs could potentially reduce programming effort and/or 
improve performance.

## API for CPU2UST

For the examples, below we propose a small modification to the proposed 
API to support exceptions. We propose that a handler be registered for a 
particular fault to distinguish the exception type. Potentially, the 
`flags` argument could hold the `signum`, or a bit in the `flags` 
argument could indicate that a third parameter was being included with 
the `signum`. We suggest including `signum` in the current API for 
future use.

```
int uintr_register_handler(u64 handler_address, unsigned int flags, int 
signum);
```

Since each handler is registered for a particular exception, the handler 
itself would only have one argument, a pointer to the `__uintr_frame`. 
In some cases, the handler might need the `error_code` information 
(e.g., for a page-fault), which could be obtained using a new function, 
`unsigned long long __get_ue_errorcode(void)`.

```
__attribute__ ((interrupt))
void
handlerFunction (struct __uintr_frame *ui_frame)
{
   // Get error code if needed
   // unsigned long long error_code = __get_ue_errorcode();
   ...
}
```

We envision four ways for the user handler to manipulate the thread's 
state. Here we assume that a UE is handled by the thread that causes the 
exception.

1. Continuing the faulting thread of control.
2. Suspending a faulting thread or continuing another thread in the same 
process.
3. Deferring processing of the fault back to the kernel.
4. Or, finally, terminating the thread of control.

In case 1, where the faulting thread is continued, the handler can 
simply use the uiret (It could potentially modify the return address on 
the stack to change where execution continues). For case 2, we do not 
have a proposed API yet, but potentially some set of functions that 
extend pthreads might be appropriate. For case 3, the handler would use 
a trap to signal that the kernel should continue processing the 
exception. The compiler would have to restore registers appropriately 
before the trap is executed.

## Binary rewriting

Binary rewriting is a valuable technique for debugging, optimizing, 
repairing, emulating, and hardening (tightening security) a program 
[WMUW19]. One implementation of binary rewriting is to replace the 
probed instructions (instrumentation points) with a redirect instruction 
(either jump or trap) to the patch instructions. Most developers use 
jump instructions instead of traps due to their lower cost. However, 
because instructions have variable encoding lengths, inserting jump 
instructions requires care, e.g., "instruction punning" [CSDN17] with a 
combination of padding and eviction [DGR20]. On the other hand, the trap 
instruction is only a single byte, allowing it to replace any patched 
instruction. If the trap can be made inexpensive, this would potentially 
allow a simpler approach to binary rewriting without control flow recovery.

## Binary Emulation for forward/backward compatibility

Some processor families have an all encompassing ISA of which only a 
subset is implemented in hardware for some instances of the family. 
Applications built for the processor family either have to be recompiled 
for each instance or software emulation must handle the unimplemented 
instructions. If there is a UE for the illegal instruction fault, this 
can potentially be made inexpensive enough to avoid recompilation. 
Furthermore, it could be a way to handle legacy code and allow future 
generations to avoid the older crufty instructions that are no longer 
commonly used.

## Floating-Point Performance

Today, floating-point algorithms often preprocess the data in order to 
avoid underflow (or overflow) exceptions. If UEs were low enough cost, 
it is possible that these time consuming data preparation steps could be 
removed and only run if an exception was generated. A simple example is 
the calculation of the Root Mean Square (RMS) of a vector [HFT94,H96]. 
The common approach to calculating a vector's RMS is to scan the input 
vector and then potentially scale it to avoid underflow/overflow. For 
many applications, the common case is that the data does not require 
rescaling. In those cases, one could calculate the RMS on the unscaled 
data and only scale it if a UE was generated.

## Memory: garbage collection and watch points

User-level Page Fault exceptions (ULPF) is one essential component for 
improving the performance of a wide variety of applications. For 
example, in [AL20], we describe a solution that shows how ULPFs when 
combined with a mechanism that allows the user a limited ability to 
change a page's permissions without kernel intervention, can be used to 
implement an unlimited number of efficient software watchpoints. Our 
experiments were performed using GEM5, where we made changes to the MMU 
and TLB. However, Intel's Memory Protection Keys for User (MPK) [MPK17] 
combined with UE could also potentially do the trick.

Another example of an application that could benefit from ULPF is 
Concurrent Garbage Collection. Concurrent Garbage collection allows both 
the program (aka mutator) threads and the collector to run in parallel. 
To implement concurrent GC, a read barrier or write barrier is often 
needed (these are GC terms and should not be confused with hardware 
memory barriers). These barriers ensure that the GC invariants are 
maintained before a read or write operations. The write barrier prevents 
the GC from reclaiming a live object that was recently accessed by the 
mutator (in the case of a concurrent mark-sweep) [BDS91]. The read 
barrier prevents the mutator from reading stale objects (in the case of 
concurrent mark-compact) [AL91]. Both read and write barriers can be 
implemented using ULPF. The programmer can use the permission bit in the 
user-level page tables to cheaply turn on/off memory protection (e.g., 
inside the handler).

Belay et al. [BBMTMETAL12] has shown how to implement Boehm GC[BDS91] (a 
mostly parallel mark-sweep GC used in the Mono project [Mono18] and 
Objective-C [Objc15]) on their platform, Dune. Dune is a platform that 
allows user-space direct access to exceptions and privileged hardware 
features. The results show both speedup and slowdown, where the slowdown 
is attributed to their platform's inherent overhead. On the other hand, 
Click et al. [CTW05] and Tene et al. [TIW11] have built a custom system 
to build a Pauseless GC. This custom system allows fast page fault 
handling. The mechanism described in [AL20] could be extended to 
implement a similar approach.

# References

- [AL91] Appel, Andrew W. and Li, Kai, Virtual Memory Primitives for 
User Programs (1991)
- [AL20] Li, Qingyang, User Level Page Faults (2020), 
http://reports-archive.adm.cs.cmu.edu/anon/2020/CMU-CS-20-124.pdf
- [BBMTMETAL12] Belay, Adam and Bittau, Andrea and Mashtizadeh, Ali and 
Terei, David and Mazi\`{e}res, David and Kozyrakis, Christos, Dune: Safe 
User-Level Access to Privileged CPU Features (2012)
- [BDS91] Boehm, Hans-J. and Demers, Alan J. and Shenker, Scott, Mostly 
Parallel Garbage Collection (1991)
- [CSDN17] Chamith, Buddhika and Svensson, Bo Joel and Dalessandro, Luke 
and Newton, Ryan R., Instruction Punning: Lightweight Instrumentation 
for X86-64 (2017)
- [CTW05] Click, Cliff and Tene, Gil and Wolf, Michael, The Pauseless GC 
Algorithm (2005)
- [DAKK19] Dogan, Halit and Ahmad, Masab and Kahne, Brian and Khan, 
Omer, Accelerating Synchronization Using Moving Compute to Data Model at 
1,000-core Multicore Scale (2019)
- [DHAKWETAL17] Dogan, Halit and Hijaz, Farrukh and Ahmad, Masab and 
Kahne, Brian and Wilson, Peter and Khan, Omer, Accelerating Graph and 
Machine Learning Workloads Using a Shared Memory Multicore Architecture 
with Auxiliary Support for in-Hardware Explicit Messaging (2017)
- [DGR20] Duck, Gregory J. and Gao, Xiang and Roychoudhury, Abhik, 
Binary Rewriting without Control Flow Recovery (2020)
- [ECGS92] von Eicken, Thorsten and Culler, David E. and Goldstein, Seth 
Copen and Schauser, Klaus Erik, Active Messages: A Mechanism for 
Integrated Communication and Computation (1992)
- [H96] Hauser, John R., Handling Floating-Point Exceptions in Numeric 
Programs (1996)
- [HFT94] Hull, T. E. and Fairgrieve, Thomas F. and Tang, Ping-Tak 
Peter, Implementing Complex Elementary Functions Using Exception 
Handling (1994)
- [Mono18] https://www.mono-project.com/docs/advanced/runtime/ (2018)
- [MPK17] 
https://www.kernel.org/doc/Documentation/x86/protection-keys.txt (2017)
- [Objc15] 
https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/Garbage-Collection.html (2015)
- [TIW11] Tene, Gil and Iyengar, Balaji and Wolf, Michael, C4: The 
Continuously Concurrent Compacting Collector (2011)
- [WBSACETAL08] Wong, Henry and Bracy, Anne and Schuchman, Ethan and 
Aamodt, Tor M. and Collins, Jamison D. and Wang, Perry H. and Chinya, 
Gautham and Groen, Ankur Khandelwal and Jiang, Hong and Wang, Hong , 
Pangaea: A tightly-coupled IA32 heterogeneous chip multiprocessor (2008)
- [WMUW19] Wenzl, Matthias and Merzdovnik, Georg and Ullrich, Johanna 
and Weippl, Edgar, From Hack to Elaborate Technique—A Survey on Binary 
Rewriting (2019)

>> # Preparing for future use cases
>> If someone could point out an example for Kernel to
>> user-space thread (K2UST) UI, we would appreciate it.
>>
>
> The idea here is improve the kernel-to-user event notification 
> latency. Theoretically, this can be useful when the kernel sees event 
> completion on one cpu but it want to signal (notify) a thread actively 
> running on some other CPU. The receiver thread can save some cycles by 
> avoiding ring transitions to receive the event.
>
> IO_URING is one of the examples for kernel-to-user event 
> notifications. We are evaluating whether providing a UINTR based 
> completion mechanism can have benefit over eventfd based completions. 
> The benefits in practice are yet to be measured and proven.
>
Thank you for the clarification.

- QUESTION: If the processor has D2UST capability, would this allow the 
device to directly send the interrupt to the target process (the process 
that initiates the I/O through io_uring) instead of the kernel?

>> In our work, we have also been exploring precise UIs from the
>> currently running thread.  We call these CPU to UST (CPU2UST) UIs.
>> For example, a SIGSEGV generated by writing to a read-only page, a
>> SIGFPE generated by dividing a number by zero.
>>
>
> It is definitely possible in future to delivery CPU events as User 
> Interrupts. The hardware architecture for this is still being worked 
> on internally.
>
> Though our focus isn't on exceptions being delivered as User 
> Interrupts. Do you have details on what type of benefit is expected?
>
Described in the use-cases we mentioned above.

>> - QUESTION: Is there is a rough draft/plan that we can refer to that 
>> describes the
>> current thinking on these three cases.
>>
>> - QUESTION: Are there use cases for K2UST, or is K2UST the same as 
>> CPU2UST?
>>
>
> No, K2UST isn't the same as CPU2UST. We would expect limited benefits 
> from K2UST but on the other hand CPU2UST can provide significant 
> speedup since it avoids the kernel completely.
>
> Unfortunately, due to the large scope of the feature, the hardware 
> architecture development is happening in stages. I don't have detailed 
> plans for each of the sources of User Interrupts.
>
> Here is our rough plan:
>
> 1. Provide a common infrastructure to receive User Interrupts. This is 
> independent of the source of the interrupt. The intention here is to 
> keep the software APIs generic and extendable so that future sources 
> can be added without causing much disturbance to the older APIs.
>
> 2. Introduce various sources of User Interrupts in stages:
>
> UST2UST - This RFC. Available in the upcoming Sapphire Rapids processor.
>
> K2UST - Also available in upcoming Sapphire Rapids. Working towards 
> proving the value before sending something out.
>
> D2UST - Future processor. Hardware architecture being worked on 
> internally. Not much to share right now.
>
> CPU2UST - Future processor. Hardware architecture being worked on 
> internally. Not much to share right now.

Thank you for the update, really appreciate it.


>
> The saving and restoring of the registers is done by gcc when the 
> muintr flag along with the 'interrupt' attribute is used. Applications 
> can choose to save floating point registers as part of the interrupt 
> handler as well.
>
> To make it easier for applications we are working on implementing a 
> thin library that can help with some of this common functionality like 
> saving floating point registers or redirecting to 64 sub-handlers.

- QUESTION: Would this thin library also provide a mechanism to share 
data between sender and receiver through shared memory (similar to 
implementing Active message)?
- QUESTION: Is there a plan in the future to allow data to be 
transmitted along with the interrupt?

>> # Multi-threaded parallel programming example
>>
>> One of the uses for UIs that we have been exploring is combining the
>> message-passing and shared memory models for parallel programming.  In
>> our approach, message-passing is used for synchronization and shared
>> memory for data sharing.  The message passing part of the programming
>> pattern is based loosely on Active Messages (See ISCA92), where a
>> particular thread can turn off/on interrupts to ignore incoming
>> messages so they can execute critical sections without having to
>> notify any other threads in the system.
>>
>
> This look like a good fit for the User IPI (UST2UST) implementation in 
> this RFC. Have you had a chance to evaluate the current API design for 
> this usage?

Our approach requires point-to-point communication to implement the 
UST2UST use cases described above. From my understanding, the current 
API requires (n-1)*n descriptors to enable point-to-point communication 
(assuming a private UITT). Here, each receiver assigns a vector to the 
UI file descriptor (uifd) and shares it with the appropriate sender. 
This way, the receivers know the sender based on the vector.

Have other approaches to handling the case where the receiver needs to 
know the sender's identity been explored? In particular, approaches that 
do not require n^2 descriptors be created? In the context of the RFC, 
one possibility we have thought about would be where the sender assigns 
a vector to uifd (maybe based on its cpuid) and shares this information 
to all receivers. This would possibly only require n descriptors.

> Also, is any of the above work publicly available?

Not yet. We are still working on it and hope to update you on it.

Best regards,
Chrisma and Seth

