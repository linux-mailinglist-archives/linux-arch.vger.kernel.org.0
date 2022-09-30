Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4319D5F0363
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 05:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiI3DlM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 23:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3DlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 23:41:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B17EFEE;
        Thu, 29 Sep 2022 20:41:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u12so3121233pjj.1;
        Thu, 29 Sep 2022 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GsJL71zBc0kUncy0B1Baf1aatIrD2b+ye64C2hSTZDw=;
        b=QHUsUemaJemvK+9u/noyxU0kDBzkolQo7gSntrhI+Y8mPIW1QZSUfzsWJYvdTeP+Zx
         hAKRltsNuwb5Ib6ni9Eu2wqvkjuctWBsBt1+YGsqHAFORs9PWOHJr3EQPIb7FgpFF45C
         W8JX4iAGyWyVV1+co/0PpLaemTMPHL5mtUvuAZ0Q4QAZW2Z/XZXFWabUUTF1VD2vT6vd
         iyV2iq8nHkBRYh1UIA0/ZU9wp/jeqzeoBmoy0/BUfF0iGMRJasN5xRDqw4jJT3PcvTez
         jbQdKF77r84g9q4Smp5dtWEy0lfxRsJt8C+hF1FH9FFU2m9BfnG8ODUJqF3qzkKeUOIu
         YoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GsJL71zBc0kUncy0B1Baf1aatIrD2b+ye64C2hSTZDw=;
        b=Kd0T2V02jGNmXXJpXeN4q9+SpsgrZRCnlDFL7Xt+tdW9dnRrZRumzXXCQjzhaqpUl/
         aZEuL5e79uQGIKosJmil+i9wonWD0Wh3vHTUYv1v5CJdNwHj7Mn/oCbcWdWeVS2dUc1g
         NmGjJORUg7SZXQgxhhDymwKUsXEKjW7ERPRp6CrlnOa8ZqNboSUwgRagRqnD0yBzLgB6
         z/aaw8k1mSmkMidDLLuDpdi0wTcBdgqaAEvw1SDuu1nebTxJvbc0sgfBou/6LZBgIU5H
         JvGcACRkBSN7cJ/NdNyFZJ+W7R00mCHljyeN/huM2gdXTC0sgmTxMZ4T4OTZ/qlSuOSq
         pVsA==
X-Gm-Message-State: ACrzQf19TJtRLfZJSw2ayhCgSWNv1UTht3G9n/gFTNzK+SIZw2Ndumnk
        SsFT4TdDyQW5juOdz1yEHGk=
X-Google-Smtp-Source: AMsMyM5It3aJjg1M83/P5mmD86k816Euz6h2VgrPhh7vuN5+OA4Viy5OUl6Mzc/b5kEy80N5N5l5ZQ==
X-Received: by 2002:a17:90a:2b0c:b0:203:b7b1:2ba2 with SMTP id x12-20020a17090a2b0c00b00203b7b12ba2mr7332499pjc.34.1664509267586;
        Thu, 29 Sep 2022 20:41:07 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a668a00b00203ab277966sm4315763pjj.7.2022.09.29.20.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 20:41:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6AB0710374D; Fri, 30 Sep 2022 10:41:03 +0700 (WIB)
Date:   Fri, 30 Sep 2022 10:41:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Message-ID: <YzZlT7sO56TzXgNc@debian.me>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eGuHlwYLjB6uXtie"
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--eGuHlwYLjB6uXtie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 03:28:58PM -0700, Rick Edgecombe wrote:
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Control-flow Enforcement Technology (CET)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Control-flow Enforcement Technology (CET) is term referring to several
> +related x86 processor features that provides protection against control
> +flow hijacking attacks. The HW feature itself can be set up to protect
> +both applications and the kernel. Only user-mode protection is implement=
ed
> +in the 64-bit kernel.
> +
> +CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
> +a secondary stack allocated from memory and cannot be directly modified =
by
> +applications. When executing a CALL instruction, the processor pushes the
> +return address to both the normal stack and the shadow stack. Upon
> +function return, the processor pops the shadow stack copy and compares it
> +to the normal stack copy. If the two differ, the processor raises a
> +control-protection fault. Indirect branch tracking verifies indirect
> +CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
> +opcodes. Not all CPU's have both Shadow Stack and Indirect Branch Tracki=
ng
> +and only Shadow Stack is currently supported in the kernel.
> +
> +The Kconfig options is X86_SHADOW_STACK, and it can be disabled with
> +the kernel parameter clearcpuid, like this: "clearcpuid=3Dshstk".
> +
> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0=
=2E1
> +or later are required. To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +At run time, /proc/cpuinfo shows CET features if the processor supports
> +CET.
> +
> +Application Enabling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An application's CET capability is marked in its ELF header and can be
> +verified from readelf/llvm-readelf output:
> +
> +    readelf -n <application> | grep -a SHSTK
> +        properties: x86 feature: SHSTK
> +
> +The kernel does not process these applications directly. Applications mu=
st
> +enable them using the interface descriped in section 4. Typically this
> +would be done in dynamic loader or static runtime objects, as is the case
> +in glibc.
> +
> +Backward Compatibility
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +GLIBC provides a few CET tunables via the GLIBC_TUNABLES environment
> +variable:
> +
> +GLIBC_TUNABLES=3Dglibc.tune.hwcaps=3D-SHSTK,-WRSS
> +    Turn off SHSTK/WRSS.
> +
> +GLIBC_TUNABLES=3Dglibc.tune.x86_shstk=3D<on, permissive>
> +    This controls how dlopen() handles SHSTK legacy libraries::
> +
> +        on         - continue with SHSTK enabled;
> +        permissive - continue with SHSTK off.
> +
> +Details can be found in the GLIBC manual pages.
> +
> +CET arch_prctl()'s
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Elf features should be enabled by the loader using the below arch_prctl'=
s.
> +
> +arch_prctl(ARCH_CET_ENABLE, unsigned int feature)
> +    Enable a single feature specified in 'feature'. Can only operate on
> +    one feature at a time.
> +
> +arch_prctl(ARCH_CET_DISABLE, unsigned int feature)
> +    Disable features specified in 'feature'. Can only operate on
> +    one feature at a time.
> +
> +arch_prctl(ARCH_CET_LOCK, unsigned int features)
> +    Lock in features at their current enabled or disabled status.
> +
> +The return values are as following:
> +    On success, return 0. On error, errno can be::
> +
> +        -EPERM if any of the passed feature are locked.
> +        -EOPNOTSUPP if the feature is not supported by the hardware or
> +         disabled by kernel parameter.
> +        -EINVAL arguments (non existing feature, etc)
> +
> +Currently shadow stack and WRSS are supported via this interface. WRSS
> +can only be enabled with shadow stack, and is automatically disabled
> +if shadow stack is disabled.
> +
> +Proc status
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To check if an application is actually running with shadow stack, the
> +user can read the /proc/$PID/arch_status. It will report "wrss" or
> +"shstk" depending on what is enabled.
> +
> +The implementation of the Shadow Stack
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Shadow Stack size
> +-----------------
> +
> +A task's shadow stack is allocated from memory to a fixed size of
> +MIN(RLIMIT_STACK, 4 GB). In other words, the shadow stack is allocated to
> +the maximum size of the normal stack, but capped to 4 GB. However,
> +a compat-mode application's address space is smaller, each of its thread=
's
> +shadow stack size is MIN(1/4 RLIMIT_STACK, 4 GB).
> +
> +Signal
> +------
> +
> +By default, the main program and its signal handlers use the same shadow
> +stack. Because the shadow stack stores only return addresses, a large
> +shadow stack covers the condition that both the program stack and the
> +signal alternate stack run out.
> +
> +The kernel creates a restore token for the shadow stack and pushes the
> +restorer address to the shadow stack. Then verifies that token when
> +restoring from the signal handler.
> +
> +Fork
> +----
> +
> +The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are requir=
ed
> +to be read-only and dirty. When a shadow stack PTE is not RO and dirty, a
> +shadow access triggers a page fault with the shadow stack access bit set
> +in the page fault error code.
> +
> +When a task forks a child, its shadow stack PTEs are copied and both the
> +parent's and the child's shadow stack PTEs are cleared of the dirty bit.
> +Upon the next shadow stack access, the resulting shadow stack page fault
> +is handled by page copy/re-use.
> +
> +When a pthread child is created, the kernel allocates a new shadow stack
> +for the new thread.

The documentation above can be improved (both grammar and formatting):

---- >8 ----

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
index 6b270a24ebc3a2..f691f7995cf088 100644
--- a/Documentation/x86/cet.rst
+++ b/Documentation/x86/cet.rst
@@ -15,92 +15,101 @@ in the 64-bit kernel.
=20
 CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
 a secondary stack allocated from memory and cannot be directly modified by
-applications. When executing a CALL instruction, the processor pushes the
+applications. When executing a ``CALL`` instruction, the processor pushes =
the
 return address to both the normal stack and the shadow stack. Upon
 function return, the processor pops the shadow stack copy and compares it
 to the normal stack copy. If the two differ, the processor raises a
 control-protection fault. Indirect branch tracking verifies indirect
-CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
-opcodes. Not all CPU's have both Shadow Stack and Indirect Branch Tracking
-and only Shadow Stack is currently supported in the kernel.
+``CALL``/``JMP`` targets are intended as marked by the compiler with ``END=
BR``
+opcodes. Not all CPUs have both Shadow Stack and Indirect Branch Tracking
+and only Shadow Stack is currently supported by the kernel.
=20
-The Kconfig options is X86_SHADOW_STACK, and it can be disabled with
-the kernel parameter clearcpuid, like this: "clearcpuid=3Dshstk".
+The Kconfig options is ``X86_SHADOW_STACK`` and it can be overridden with
+the kernel command-line parameter ``clearcpuid`` (for example
+``clearcpuid=3Dshstk``).
=20
 To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
-or later are required. To build a CET-enabled application, GLIBC v2.28 or
+or later are required. To build a CET-enabled application, glibc v2.28 or
 later is also required.
=20
-At run time, /proc/cpuinfo shows CET features if the processor supports
-CET.
+At run time, ``/proc/cpuinfo`` shows CET features if the processor supports
+them
=20
-Application Enabling
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Enabling CET in applications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
-An application's CET capability is marked in its ELF header and can be
-verified from readelf/llvm-readelf output:
+The CET capability of an application is marked in its ELF header and can be
+verified from ``readelf``/``llvm-readelf`` output::
=20
     readelf -n <application> | grep -a SHSTK
         properties: x86 feature: SHSTK
=20
 The kernel does not process these applications directly. Applications must
-enable them using the interface descriped in section 4. Typically this
+enable them using :ref:`cet-arch_prctl`. Typically this
 would be done in dynamic loader or static runtime objects, as is the case
 in glibc.
=20
 Backward Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-GLIBC provides a few CET tunables via the GLIBC_TUNABLES environment
+glibc provides a few CET tunables via the ``GLIBC_TUNABLES`` environment
 variable:
=20
-GLIBC_TUNABLES=3Dglibc.tune.hwcaps=3D-SHSTK,-WRSS
+  * ``GLIBC_TUNABLES=3Dglibc.tune.hwcaps=3D-SHSTK,-WRSS``
+
     Turn off SHSTK/WRSS.
=20
-GLIBC_TUNABLES=3Dglibc.tune.x86_shstk=3D<on, permissive>
-    This controls how dlopen() handles SHSTK legacy libraries::
+  * ``GLIBC_TUNABLES=3Dglibc.tune.x86_shstk=3D<on, permissive>``
=20
-        on         - continue with SHSTK enabled;
-        permissive - continue with SHSTK off.
+    This controls how :manpage:`dlopen(3)` handles SHSTK legacy libraries.
+    Possible values are:
=20
-Details can be found in the GLIBC manual pages.
+    * ``on``         - continue with SHSTK enabled;
+    * ``permissive`` - continue with SHSTK off.
=20
-CET arch_prctl()'s
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+.. _cet-arch_prctl:
=20
-Elf features should be enabled by the loader using the below arch_prctl's.
+CET arch_prctl() interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
-arch_prctl(ARCH_CET_ENABLE, unsigned int feature)
-    Enable a single feature specified in 'feature'. Can only operate on
+ELF features should be enabled by the loader using the following
+:manpage:`arch_prctl(2)` subfunctions:
+
+  * ``arch_prctl(ARCH_CET_ENABLE, unsigned int feature)``
+
+    Enable a single feature specified in ``feature``. Can only operate on
     one feature at a time.
=20
-arch_prctl(ARCH_CET_DISABLE, unsigned int feature)
-    Disable features specified in 'feature'. Can only operate on
+  * ``arch_prctl(ARCH_CET_DISABLE, unsigned int feature)``
+
+    Disable features specified in ``feature``. Can only operate on
     one feature at a time.
=20
-arch_prctl(ARCH_CET_LOCK, unsigned int features)
-    Lock in features at their current enabled or disabled status.
+  * ``arch_prctl(ARCH_CET_LOCK, unsigned int features)``
+
+    Lock in features at their current status.
+
+  * ``arch_prctl(ARCH_CET_UNLOCK, unsigned int features)``
=20
-arch_prctl(ARCH_CET_UNLOCK, unsigned int features)
     Unlock features.
=20
-The return values are as following:
-    On success, return 0. On error, errno can be::
+On success, :manpage:`arch_prctl(2)` returns 0, otherwise the errno
+can be:
=20
-        -EPERM if any of the passed feature are locked.
-        -EOPNOTSUPP if the feature is not supported by the hardware or
-         disabled by kernel parameter.
-        -EINVAL arguments (non existing feature, etc)
+  - ``EPERM`` if any of the passed feature are locked.
+  - ``EOPNOTSUPP`` if the feature is not supported by the hardware or
+    disabled by the kernel command-line parameter.
+  - ``EINVAL`` if the arguments are invalid (non existing feature, etc).
=20
 Currently shadow stack and WRSS are supported via this interface. WRSS
 can only be enabled with shadow stack, and is automatically disabled
 if shadow stack is disabled.
=20
-Proc status
+proc status
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-To check if an application is actually running with shadow stack, the
-user can read the /proc/$PID/arch_status. It will report "wrss" or
-"shstk" depending on what is enabled.
+To check if an application is actually running with shadow stack, users can
+read ``/proc/$PID/arch_status``. It will report ``wrss`` or
+``shstk`` depending on what is enabled.
=20
 The implementation of the Shadow Stack
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -108,11 +117,11 @@ The implementation of the Shadow Stack
 Shadow Stack size
 -----------------
=20
-A task's shadow stack is allocated from memory to a fixed size of
-MIN(RLIMIT_STACK, 4 GB). In other words, the shadow stack is allocated to
+The shadow stack of a task is allocated from memory to a fixed size of
+``MIN(RLIMIT_STACK, 4 GB)``. In other words, the shadow stack is allocated=
 to
 the maximum size of the normal stack, but capped to 4 GB. However,
-a compat-mode application's address space is smaller, each of its thread's
-shadow stack size is MIN(1/4 RLIMIT_STACK, 4 GB).
+the address space of a compat-mode application is smaller; the shadow stack
+size of each of its thread is ``MIN(1/4 RLIMIT_STACK, 4 GB)``.
=20
 Signal
 ------
@@ -123,19 +132,19 @@ shadow stack covers the condition that both the progr=
am stack and the
 signal alternate stack run out.
=20
 The kernel creates a restore token for the shadow stack and pushes the
-restorer address to the shadow stack. Then verifies that token when
-restoring from the signal handler.
+restorer address to it. Then the kernel verifies that token when restoring
+from the signal handler.
=20
 Fork
 ----
=20
-The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are required
-to be read-only and dirty. When a shadow stack PTE is not RO and dirty, a
+The shadow stack vma has ``VM_SHADOW_STACK`` flag set; its PTEs are requir=
ed
+to be read-only and dirty. When a shadow stack PTE is read-write and dirty=
, a
 shadow access triggers a page fault with the shadow stack access bit set
 in the page fault error code.
=20
 When a task forks a child, its shadow stack PTEs are copied and both the
-parent's and the child's shadow stack PTEs are cleared of the dirty bit.
+shadow stack PTEs of parent and child are cleared of the dirty bit.
 Upon the next shadow stack access, the resulting shadow stack page fault
 is handled by page copy/re-use.
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--eGuHlwYLjB6uXtie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzZlSwAKCRD2uYlJVVFO
o/E+AQC4R370JtlvOpcNfLV29O/Klt/2032cP5rnzHigPFNppwD9Gg2sSM6SIeq9
12n3CQKTry04jtXt1YhJb5TVXy4U/Ak=
=lClp
-----END PGP SIGNATURE-----

--eGuHlwYLjB6uXtie--
