Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492F235F00B
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 10:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbhDNIqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 04:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhDNIqd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 04:46:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BFE5613C3;
        Wed, 14 Apr 2021 08:46:08 +0000 (UTC)
Date:   Wed, 14 Apr 2021 10:46:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <20210414084605.pdlnjkwa3h47jxno@wittgenstein>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
 <20210414044020.GA44464@yury-ThinkPad>
 <20210414081422.5a9d0c4b@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210414081422.5a9d0c4b@coco.lan>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 08:14:22AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 13 Apr 2021 21:40:20 -0700
> Yury Norov <yury.norov@gmail.com> escreveu:
> 
> > Ping?
> > 
> > On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> > > Recently added memfd_secret() syscall had a flags parameter passed
> > > as unsigned long, which requires creation of compat entry for it.
> > > It was possible to change the type of flags to unsigned int and so
> > > avoid bothering with compat layer.
> > > 
> > > https://www.spinics.net/lists/linux-mm/msg251550.html
> > > 
> > > Documentation/process/adding-syscalls.rst doesn't point clearly about
> > > preference of ABI-agnostic types. This patch adds such notification.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  Documentation/process/adding-syscalls.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> > > index 9af35f4ec728..46add16edf14 100644
> > > --- a/Documentation/process/adding-syscalls.rst
> > > +++ b/Documentation/process/adding-syscalls.rst
> > > @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
> > >  registers.  (This concern does not apply if the arguments are part of a
> > >  structure that's passed in by pointer.)
> > >  
> > > +Whenever possible, try to use ABI-agnostic types for passing parameters to
> > > +a syscall in order to avoid creating compat entry for it. Linux supports two
> > > +ABI models - ILP32 and LP64. 
> 
> > > + The types like ``void *``, ``long``, ``size_t``,
> > > +``off_t`` have different size in those ABIs;
> 
> In the case of pointers, the best is to use __u64. The pointer can then
> be read on Kernelspace with something like this:
> 
> 	static inline void __user *media_get_uptr(__u64 arg)
> 	{
> 		return (void __user *)(uintptr_t)arg;
> 	}
> 
> 
> > > types like ``char`` and  ``int``
> > > +have the same size and don't require a compat layer support. For flags, it's
> > > +always better to use ``unsigned int``.
> > > +
> 
> I don't think this is true for all compilers on userspace, as the C
> standard doesn't define how many bits an int/unsigned int has. 
> So, even if this is today's reality, things may change in the future.
> 
> For instance, I remember we had to replace "int" and "enum" by "__u32" 
> and "long" by "__u64" at the media uAPI in the past, when we start
> seeing x86_64 Kernels with 32-bits userspace and when cameras started 
> being supported on arm32.
> 
> We did have some real bugs with "enum", as, on that time, some
> compilers (gcc, I guess) were optimizing them to have less than
> 32 bits on certain architectures, when it fits.

Fwiw, Aleksa and I have written extended syscall documentation
documenting the agreement that we came to in a dedicated session with a
wide range of kernel folks during Linux Plumbers last year. We simply
never had time to actually send this series but fwiw here it is. It also
mentions the use of correct types. If people feel it's worth it I can
send as a proper series:

From 9035258aaa23c5e1bb5bc2242f97221a3e5b9a87 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 14:27:47 +0200
Subject: [PATCH 1/6] docs: split extensibility section into two subsections

The section already explains two different formats that are available to
extend a syscall. Move each into its own subsection. This clarifies the
structure and will be useful when we extend each section in follow-up
patches.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 906c47f1a9e5..3853ce57e757 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -65,6 +65,9 @@ together with the corresponding follow-up system calls --
 ``pipe``/``pipe2``, ``renameat``/``renameat2`` -- so
 learn from the history of the kernel and plan for extensions from the start.)
 
+Baseline extensibility: adding a flag argument
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 For simpler system calls that only take a couple of arguments, the preferred
 way to allow for future extensibility is to include a flags argument to the
 system call.  To make sure that userspace programs can safely use flags
@@ -76,6 +79,9 @@ flags, and reject the system call (with ``EINVAL``) if it does::
 
 (If no flags values are used yet, check that the flags argument is zero.)
 
+Advanced extensibility: extensible structs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 For more sophisticated system calls that involve a larger number of arguments,
 it's preferred to encapsulate the majority of the arguments into a structure
 that is passed in by pointer.  Such a structure can cope with future extension

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.27.0

From de1b27a0d29ac8edfb19226e3ad0547831f12a97 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 14:37:53 +0200
Subject: [PATCH 2/6] docs: require unsigned int as type for flag arguments

This has been an undocumented requirement for quite a long time but people
still get confused and add system calls that use e.g. unsigned long as flag
argument. Document the unsigned int requirement for flag arguments.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 3853ce57e757..c08c3a6e7979 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -70,9 +70,16 @@ Baseline extensibility: adding a flag argument
 
 For simpler system calls that only take a couple of arguments, the preferred
 way to allow for future extensibility is to include a flags argument to the
-system call.  To make sure that userspace programs can safely use flags
-between kernel versions, check whether the flags value holds any unknown
-flags, and reject the system call (with ``EINVAL``) if it does::
+system call.  As such, flag arguments function as a baseline for extensibility.
+
+Different types such as ``int`` or ``unsigned long`` have been used for flag
+arguments.  Since this is not just inconsistent but can also lead to issues
+with sign- and zero extension all new system calls are expected to use
+``unsigned int`` as type for flag arguments.
+
+To make sure that userspace programs can safely use flags between kernel
+versions, check whether the flags value holds any unknown flags, and reject the
+system call (with ``EINVAL``) if it does::
 
     if (flags & ~(THING_FLAG1 | THING_FLAG2 | THING_FLAG3))
         return -EINVAL;
-- 
2.27.0

From 08bc20493242d93c187b8cdcf9c2353e385a2565 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 14:52:56 +0200
Subject: [PATCH 3/6] docs: clarify flag value checking a little

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index c08c3a6e7979..faea347c0ecb 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -77,14 +77,18 @@ arguments.  Since this is not just inconsistent but can also lead to issues
 with sign- and zero extension all new system calls are expected to use
 ``unsigned int`` as type for flag arguments.
 
-To make sure that userspace programs can safely use flags between kernel
-versions, check whether the flags value holds any unknown flags, and reject the
-system call (with ``EINVAL``) if it does::
+A system call doesn't need to support any flags right away to justify adding
+a flag argument.  If no flags are supported yet, the new system call needs
+to check that the flag argument is zero and to return ``EINVAL`` if it is not::
 
-    if (flags & ~(THING_FLAG1 | THING_FLAG2 | THING_FLAG3))
+    if (flags)
         return -EINVAL;
 
-(If no flags values are used yet, check that the flags argument is zero.)
+Similarly, if flags are supported the system call needs to check that no
+unknown flag values are present and return ``EINVAL`` if there are::
+
+    if (flags & ~(THING_FLAG1 | THING_FLAG2 | THING_FLAG3))
+        return -EINVAL;
 
 Advanced extensibility: extensible structs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.27.0

From 35745a05b7d7350f2039b7d868e52f6c306f7c8e Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 15:39:38 +0200
Subject: [PATCH 4/6] docs: extend section about extensible structs

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 88 +++++++++++++++++------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index faea347c0ecb..875e32bbabac 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -65,6 +65,7 @@ together with the corresponding follow-up system calls --
 ``pipe``/``pipe2``, ``renameat``/``renameat2`` -- so
 learn from the history of the kernel and plan for extensions from the start.)
 
+
 Baseline extensibility: adding a flag argument
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -90,34 +91,81 @@ unknown flag values are present and return ``EINVAL`` if there are::
     if (flags & ~(THING_FLAG1 | THING_FLAG2 | THING_FLAG3))
         return -EINVAL;
 
+
 Advanced extensibility: extensible structs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For more sophisticated system calls that involve a larger number of arguments,
-it's preferred to encapsulate the majority of the arguments into a structure
-that is passed in by pointer.  Such a structure can cope with future extension
-by including a size argument in the structure::
-
-    struct xyzzy_params {
-        u32 size; /* userspace sets p->size = sizeof(struct xyzzy_params) */
-        u32 param_1;
-        u64 param_2;
-        u64 param_3;
+it's preferred to encapsulate the majority of the arguments into an extensible
+structure that is passed in by pointer.
+
+Extensible structs are versioned by their size.  For any new non-flag based
+extension a new field has to be added to the end of the extensible struct.  The
+zero value of the new field must not have any meaning so the system call can
+continue to display the old behavior.
+
+Extensible struct system calls can and should use the dedicated
+``copy_struct_from_user`` API which enforces the following behavior:
+
+ - The kernel will reject any size that is smaller than the initially supported
+   size of the extensible struct.
+ - If the extensible struct size the kernel knows about is equal to the size
+   passed in from userspace then ``copy_struct_from_user`` will copy the struct
+   verbatim.
+ - If the extensible struct size the kernel knows about is larger than the size
+   passed in from userspace the kernel will copy the size userspace indicated
+   and treat all additional extensions it knows about as zero.
+ - If the extensible struct size the kernel knows about is smaller than the
+   size passed in from userspace the kernel will copy the number of bytes it
+   knows about and verify that all trailing bytes are zero.  If non-zero bytes
+   are present the kernel returns ``E2BIG``.  While not an intuitive error code
+   at first, ``E2BIG`` means that the argument list is too long.
+
+Early examples for extensible struct system calls include
+:manpage:`perf_event_open(2)` and :manpage:`sched_setattr(2)`.  These system
+calls implement mostly similar behavior even before the introduction of
+``copy_struct_from_user`` but have since been switched over to it.  Newer
+examples include :manpage:`clone3(2)` and :manpage:`openat2(2)`.
+
+The size associated with an extensible struct can either be passed as
+a separate argument in the system call as is e.g. done for :manpage:`clone3(2)`
+and :manpage:`openat2(2)`.  Alternatively, the size can be passed as the first
+field in the extensible struct as is e.g. done for :manpage:`sched_setattr(2)`.
+
+Any struct passed from userspace to the kernel and especially extensible
+structs must ensure that they are correctly padded.  This ensures that no data
+can be leaked on accident or on purpose by an attacker from the kernel.  The
+easiest way to ensure that a struct is correctly padded is to always use 64 bit
+fields::
+
+    struct sys_foo_args {
+        __aligned_u64 arg1;
+        __aligned_u64 arg2;
+        __aligned_u64 arg3;
+        __aligned_u64 arg4;
+        __aligned_u64 arg5;
     };
 
-As long as any subsequently added field, say ``param_4``, is designed so that a
-zero value gives the previous behaviour, then this allows both directions of
-version mismatch:
+System calls that need to worry about the size of their extensible structs or
+need fields to be of a specific size can rely on careful manual struct
+packing::
+
+    struct sys_foo_args {
+        __u32 arg1;
+        __u16 arg2;
+        __u16 arg3;
+        __u32 arg4;
+        __u32 arg5;
+        __u64 arg6;
+    };
 
- - To cope with a later userspace program calling an older kernel, the kernel
-   code should check that any memory beyond the size of the structure that it
-   expects is zero (effectively checking that ``param_4 == 0``).
- - To cope with an older userspace program calling a newer kernel, the kernel
-   code can zero-extend a smaller instance of the structure (effectively
-   setting ``param_4 = 0``).
+(There are tools such as ``pahole`` available that allow to check whether
+a struct is correctly padded!)
 
-See :manpage:`perf_event_open(2)` and the ``perf_copy_attr()`` function (in
-``kernel/events/core.c``) for an example of this approach.
+Note that in contrast to flag arguments passed as register arguments flag
+arguments in extensible structures can be 64 bit wide.  As with simple
+flag-only system calls, the system call needs to verify any unknown values for
+flag-like fields in the passed struct are zeroed.
 
 
 Designing the API: Other Considerations
-- 
2.27.0

From 92d48ab239e28f56d1d685ca1f1618aef08e7fe6 Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 15:57:36 +0200
Subject: [PATCH 5/6] docs: document how to name revised syscalls

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 875e32bbabac..663d1b768121 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -168,6 +168,28 @@ flag-only system calls, the system call needs to verify any unknown values for
 flag-like fields in the passed struct are zeroed.
 
 
+Designing the API: Revisions of syscalls
+-----------------------------------------------
+
+System calls that were not designed to be extensible or system calls that use
+a flag argument for extensions running out of bits (e.g. :manpage:`clone(2)`)
+sometimes need to be replaced.
+
+If the revised system call provides a superset (or a reasonably large subset,
+such as when a feature that turned out to be a design mistake is dropped) of
+the features of the old system call, it is common practice to give it the same
+name with a number appended.  Examples for this include ``dup2``/``dup3``,
+``epoll_create``/``epoll_create1`` and others.
+
+For some syscalls the appended number indicates the number of arguments
+(``accept``/``accept4``) for others the number of the revision
+(``clone``/``clone3``, ``epoll_create``/``epoll_create1``).  New system calls
+that are a revision of an earlier system call should treat the appended number
+as the number of the revision.  For example, if you were to add a revised
+version of ``readlinkat`` with an additional flag argument it should be named
+``readlinkat2``.
+
+
 Designing the API: Other Considerations
 ---------------------------------------
 
-- 
2.27.0

From 0f61fcb2949170532283048e8ac0d8e3c16305db Mon Sep 17 00:00:00 2001
From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 4 Sep 2020 17:06:05 +0200
Subject: [PATCH 6/6] docs: add section about multiplexers

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 Documentation/process/adding-syscalls.rst | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 663d1b768121..ef1fa5fb223d 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -51,6 +51,45 @@ interface.
    getting/setting a simple flag related to a process.
 
 
+Designing the API: No more multiplexers
+---------------------------------------
+
+New system calls are not allowed to be multiplexers.  The kernel strongly
+encourages simple system call designs.
+
+The kernel has historically supported multiplexing system calls but both the
+kernel and userspace have learned the hard way that this is usually
+a significant design mistake.  The list of actively supported multiplexing
+system calls ranges from domain specific multiplexers such as
+:manpage:`seccomp(2)` or :manpage:`keyctl(2)` to more generic multiplexers such
+as :manpage:`prctl(2)` and :manpage:`ptrace(2)`, up to ``ioctl``, a generic
+multiplexer not bound to any specific API or functionality.  In essence,
+a multiplexing system call often implements the functionality of multiple
+simple system calls.
+
+Multiplexers are especially problematic when they are type-polymorph. This
+includes all multiplexers that pass different types through a void pointer,
+a ``long``, or a union using a specific argument to differentiate the type or
+the member of the union to look at.  The ``ioctl`` multiplexer is a prime
+example of a type-polymorph multiplexer.  Depending on the second argument
+passed to ``ioctl`` different types can be passed as the third argument.  Some
+multiplexers, including ``ioctl``, :manpage:`prctl(2)`, or :manpage:`fcntl(2)`
+even pass a different number of arguments depending on the command that is
+executed.
+
+Multiplexers also pose significant problems for userspace libraries:
+
+ - Type safety is lost for the most part.
+ - There are no real advantages in terms of useability.  In fact, userspace
+   libraries do consider exposing the commands implemented by a system call as
+   separate library calls.
+ - Multiplexers provide problems for 32 bit systems on 64 bit kernels.  They
+   can for example cause breakage with ILP32 (i.e. I-ntegers, L-ongs, and
+   P-ointers are 32 bit wide) targets when types are not promoted correctly for
+   use with the kernel/userspace ABI.  Getting this wrong is easier than
+   getting it right.
+
+
 Designing the API: Planning for Extension
 -----------------------------------------
 
-- 
2.27.0

