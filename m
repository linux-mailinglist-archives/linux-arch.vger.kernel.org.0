Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8FF39C951
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFEPHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 11:07:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:55487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEPHm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 11:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622905482;
        bh=nDMcdivvtZk+4DB6rcxNvVgw58wPsb5SoU/GJkToBuE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hpknOmxzgLZcKjCMGSmYEhMG2xRbGgMEJb2JIlKZ4Nr9CGqO0Glc4CV0bj6WuEzZR
         MovlzASCehv0No6dmO4LIl4J+ASbo1ezQ2MWSNR56BTxubMmyXx+DYlFmggibO8awL
         w7aljZ2skym8YxB/Kyf08XI8QtSR0Gxj9sFOf2lM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1McpNo-1lFeno17xa-00ZvB6; Sat, 05 Jun 2021 17:04:42 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     John Wood <john.wood@gmx.com>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v8 0/8] Fork brute force attack mitigation
Date:   Sat,  5 Jun 2021 17:03:57 +0200
Message-Id: <20210605150405.6936-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EWEBuV65D2z8Em4HJUvFJE4hXBGkdvet1My+Q35ZJZnHew/Atj6
 i9zYGDk3wZamY/yIaa8OvtrP2kK1ONAhusLKRIpN8tCEFzPdwgKnfaajwW1lNUAPTpy/tFN
 9t2wuyWdbVYwqVUwwzB7o6zfTe/txkTykHnx+xD3Pjp/AuVx6Su/PBXNVixFx0TPx0l2X0E
 j4HL7ayANfUE5OXl+iOrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:byJzPVsfXi4=:FxyuwlTIhGfFHpN/qBmBlw
 A6nW59mrr/TgSYOf8jIx0yQFd861Gm0OwAo88bXs7Ipc1L6VIiGIbdLt6a1C4E4abq9ogEFGV
 Gg7b5TU2pOtkYJXMYVPNxSgogWdeUaOzbvGGOzxj9BtXSnDAB/ZeMs6TYg/8Ix6hAgCDywGte
 0pJEUW86oir/aaZ+lkt1I7PBtviT949WswdCDRy6e6kPHKtGZouihHyKVIBglhHFEtb1DTWkm
 U75wbSBjQDws3qymj0dYsgtTLDf2q9qcM5fAbo8RL70Of5eaAswDIXa9RhsnmLi1f6CRa8e0t
 vF7cois045VoyE3zNwtkBmwkLkfsX0MsbOGPyBaJ4Nw86ba/99U/OAKPuwDU6q7R779+vvmBL
 kRNN49MK7x7I58KelOEOKyk86XufRhNJ1jglcCqrBI1HY2S+qsq0HXkHGWJfjkS3g5FRkakOS
 fXrehi6z7JEtwCByijJN35IqvWiY9WrzLwiN2jT7rQtglOFG8jtJZENUStjj3pRo74COaJ+ze
 SVuekVXdf3ZFM5nEDgbyfaUePrWGuZH96suENexgooS/0XMntVuvclw2i3MCVzP0dFzDQqbuT
 1jmG0G9VzjACziPo7H6Ghm9OOsNP0cWympvr+0/hO4LqYAfyy1wd1D21WmMdK5MxOG35d0z75
 EdLiaJ1C9jZaL3UQoO1IPKXwUR9+mbA2UOdHr1EkzMhorcPtbiEliZfob4O1KNTaZs7OCWHd+
 PTfYx5BcHudKKy5KyAbzQYOwCgxRajhpEcjAhw43rt5o1VZd2p246Oa5MFMCrFm4ikZcT95lw
 T20xC9rK6aBB0BhdOo2A4BQi67QpWbmyemQSyHshPUklKz8HelzC9ekSLTEGCvElB72N4s0Q3
 0sg/pba+seKNPTmCAOAFwbVw4rGQt5LeAmFmv2jcpDly/M1D4WXAy4kjDjRus8KODpCEnVKIU
 2pA6+OahN31Ud/REhhuHImKLizUrfb9hYxMmSGH87BsrhvW1Tu7eNfl5l/wpRXVWLlYjg9bmx
 96JXnPW3lJPc4Kgb50tyBPm7U1hUt8+HDGuyCQuqmXfHh1P6LPxf26xcHJyNCnRt3TUB6cyoX
 g179vlCe5QGD8HyOZP2pc+c/NpzAGvYxF7M
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Attacks against vulnerable userspace applications with the purpose to brea=
k
ASLR or bypass canaries traditionally use some level of brute force with
the help of the fork system call. This is possible since when creating a
new process using fork its memory contents are the same as those of the
parent process (the process that called the fork system call). So, the
attacker can test the memory infinite times to find the correct memory
values or the correct memory addresses without worrying about crashing the
application.

Based on the above scenario it would be nice to have this detected and
mitigated, and this is the goal of this patch serie. Specifically the
following attacks are expected to be detected:

1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
    desirable memory layout is got (e.g. Stack Clash).
2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly
    until a desirable memory layout is got (e.g. what CTFs do for simple
    network service).
3.- Launching processes without exec() (e.g. Android Zygote) and exposing
    state to attack a sibling.
4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly unti=
l
    the previously shared memory layout of all the other children is
    exposed (e.g. kind of related to HeartBleed).

In each case, a privilege boundary has been crossed:

Case 1: setuid/setgid process
Case 2: network to local
Case 3: privilege changes
Case 4: network to local

So, what will really be detected are fork/exec brute force attacks that
cross any of the commented bounds.

The implementation details and comparison against other existing
implementations can be found in the "Documentation" patch.

It is important to mention that the v8 and v7 versions have changed the
method used to track the information related to the application crashes.
Prior this versions, a pointer per process (in the task_struct structure)
held a reference to the shared statistical data. Or in other words, these
stats were shared by all the fork hierarchy processes. But this has an
important drawback: a brute force attack that happens through the execve
system call losts the faults info since these statistics are freed when th=
e
fork hierarchy disappears. So, the solution adopted in the v6 version was
to use an upper fork hierarchy to track the info for this attack type. But=
,
as Valdis Kletnieks pointed out during this discussion [1], this method ca=
n
be easily bypassed using a double exec (well, this was the method used in
the kselftest to avoid the detection ;) ). So, in this version, to track
all the statistical data (info related with application crashes), the
extended attributes feature for the executable files are used. The xattr i=
s
also used to mark the executables as "not allowed" when an attack is
detected. Then, the execve system call rely on this flag to avoid followin=
g
executions of this file.

[1] https://lore.kernel.org/kernelnewbies/20210330173459.GA3163@ubuntu/

Moreover, I think this solves another problem pointed out by Andi Kleen
during the v5 review [2] related to the possibility that a supervisor
respawns processes killed by the Brute LSM. He suggested adding some way s=
o
a supervisor can know that a process has been killed by Brute and then
decide to respawn or not. So, now, the supervisor can read the brute xattr
of one executable and know if it is blocked by Brute and why (using the
statistical data).

[2] https://lore.kernel.org/kernel-hardening/878s78dnrm.fsf@linux.intel.co=
m/

Although the xattr of the executable is accessible from userspace, in
complex daemons this file may not be visible directly by the supervisor as
it may be run through some wrapper. So, an extension to the waitid() syste=
m
call has been added in this version. This was suggested by Andi Kleen [3]
during the v7 review. (The case with supervisors using cgroups is not yet
tested).

[3] https://lore.kernel.org/kernel-hardening/19903478-52e0-3829-0515-3e176=
69108f7@linux.intel.com/

Knowing all this information I will explain now the different patches:

The 1/8 patch defines a new LSM hook to get the fatal signal of a task.
This will be useful during the attack detection phase.

The 2/8 patch defines a new LSM and the necessary sysctl attributes to fin=
e
tuning the attack detection.

The 3/8 patch detects a fork/exec brute force attack and narrows the
possible cases taken into account the privilege boundary crossing.

The 4/8 patch mitigates a brute force attack.

The 5/8 patch adds the extension to the waitid system call to notify to
userspace that a task has been killed by Brute LSM when an attack is
mitigated.

The 6/8 patch adds self-tests to validate the Brute LSM expectations.

The 7/8 patch adds the documentation to explain this implementation.

The 8/8 patch updates the maintainers file.

This patch serie is a task of the KSPP [4] and can also be accessed from m=
y
github tree [5] in the "brute_v8" branch.

[4] https://github.com/KSPP/linux/issues/39
[5] https://github.com/johwood/linux/

When I ran the "checkpatch" script I got the following errors, but I think
they are false positives as I follow the same coding style for the others
extended attributes suffixes.

=2D-----------------------------------------------------------------------=
----
../patches/brute_v8/v8-0003-security-brute-Detect-a-brute-force-attack.pat=
ch
=2D-----------------------------------------------------------------------=
----
ERROR: Macros with complex values should be enclosed in parentheses
89: FILE: include/uapi/linux/xattr.h:80:
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX

=2D-----------------------------------------------------------------------=
-----
../patches/brute_v8/v8-0006-selftests-brute-Add-tests-for-the-Brute-LSM.pa=
tch
=2D-----------------------------------------------------------------------=
-----
ERROR: Macros with complex values should be enclosed in parentheses
159: FILE: tools/testing/selftests/brute/rmxattr.c:18:
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX

When I ran the "kernel-doc" script with the following parameters:

./scripts/kernel-doc --none -v security/brute/brute.c

I got the following warning:

security/brute/brute.c:118: warning: contents before sections

But I don't understand why it is complaining. Could it be a false positive=
?

The previous versions can be found in:

RFC
https://lore.kernel.org/kernel-hardening/20200910202107.3799376-1-keescook=
@chromium.org/

Version 2
https://lore.kernel.org/kernel-hardening/20201025134540.3770-1-john.wood@g=
mx.com/

Version 3
https://lore.kernel.org/lkml/20210221154919.68050-1-john.wood@gmx.com/

Version 4
https://lore.kernel.org/lkml/20210227150956.6022-1-john.wood@gmx.com/

Version 5
https://lore.kernel.org/kernel-hardening/20210227153013.6747-1-john.wood@g=
mx.com/

Version 6
https://lore.kernel.org/kernel-hardening/20210307113031.11671-1-john.wood@=
gmx.com/

Version 7
https://lore.kernel.org/kernel-hardening/20210521172414.69456-1-john.wood@=
gmx.com/

Changelog RFC -> v2
=2D------------------
- Rename this feature with a more suitable name (Jann Horn, Kees Cook).
- Convert the code to an LSM (Kees Cook).
- Add locking  to avoid data races (Jann Horn).
- Add a new LSM hook to get the fatal signal of a task (Jann Horn, Kees
  Cook).
- Add the last crashes timestamps list to avoid false positives in the
  attack detection (Jann Horn).
- Use "period" instead of "rate" (Jann Horn).
- Other minor changes suggested (Jann Horn, Kees Cook).

Changelog v2 -> v3
=2D-----------------
- Compute the application crash period on an on-going basis (Kees Cook).
- Detect a brute force attack through the execve system call (Kees Cook).
- Detect an slow brute force attack (Randy Dunlap).
- Fine tuning the detection taken into account privilege boundary crossing
  (Kees Cook).
- Taken into account only fatal signals delivered by the kernel (Kees
  Cook).
- Remove the sysctl attributes to fine tuning the detection (Kees Cook).
- Remove the prctls to allow per process enabling/disabling (Kees Cook).
- Improve the documentation (Kees Cook).
- Fix some typos in the documentation (Randy Dunlap).
- Add self-test to validate the expectations (Kees Cook).

Changelog v3 -> v4
=2D-----------------
- Fix all the warnings shown by the tool "scripts/kernel-doc" (Randy
  Dunlap).

Changelog v4 -> v5
=2D-----------------
- Fix some typos (Randy Dunlap).

Changelog v5 -> v6
=2D-----------------
- Fix a reported deadlock (kernel test robot).
- Add high level details to the documentation (Andi Kleen).

Changelog v6 -> v7
=2D-----------------

- Add the "Reviewed-by:" tag to the first patch.
- Rearrange the brute LSM between lockdown and yama (Kees Cook).
- Split subdir and obj in security/Makefile (Kees Cook).
- Reduce the number of header files included (Kees Cook).
- Print the pid when an attack is detected (Kees Cook).
- Use the socket_accept LSM hook instead of socket_sock_rcv_skb hook to
  avoid running a hook on every incoming network packet (Kees Cook).
- Update the documentation and fix it to render it properly (Jonathan
  Corbet).
- Manage correctly an exec brute force attack avoiding the bypass (Valdis
  Kletnieks).
- Other minor changes and cleanups.

Changelog v7 -> v8
=2D-----------------

- Rebase against v5.13-rc4.
- Fix a build error if CONFIG_IPV6 and/or CONFIG_SECURITY_NETWORK is not
  set (kernel test robot).
- Notify to userspace that a task has been killed by Brute LSM (Andi
  Kleen).
- Add a new test to verify that the userspace notification is working.
- Update the documentation accordingly with this new feature.
- Other minor changes and cleanups.

Any constructive comments are welcome.
Thanks in advance.

John Wood (8):
  security: Add LSM hook at the point where a task gets a fatal signal
  security/brute: Define a LSM and add sysctl attributes
  security/brute: Detect a brute force attack
  security/brute: Mitigate a brute force attack
  security/brute: Notify to userspace "task killed"
  selftests/brute: Add tests for the Brute LSM
  Documentation: Add documentation for the Brute LSM
  MAINTAINERS: Add a new entry for the Brute LSM

 Documentation/admin-guide/LSM/Brute.rst  | 359 ++++++++++
 Documentation/admin-guide/LSM/index.rst  |   1 +
 MAINTAINERS                              |   8 +
 arch/x86/kernel/signal_compat.c          |   2 +-
 include/brute/brute.h                    |  16 +
 include/linux/lsm_hook_defs.h            |   1 +
 include/linux/lsm_hooks.h                |   4 +
 include/linux/security.h                 |   4 +
 include/uapi/asm-generic/siginfo.h       |   3 +-
 include/uapi/linux/xattr.h               |   3 +
 kernel/exit.c                            |   6 +-
 kernel/signal.c                          |   5 +-
 security/Kconfig                         |  11 +-
 security/Makefile                        |   2 +
 security/brute/Kconfig                   |  15 +
 security/brute/Makefile                  |   2 +
 security/brute/brute.c                   | 795 +++++++++++++++++++++++
 security/security.c                      |   5 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/brute/.gitignore |   3 +
 tools/testing/selftests/brute/Makefile   |   5 +
 tools/testing/selftests/brute/config     |   1 +
 tools/testing/selftests/brute/exec.c     |  46 ++
 tools/testing/selftests/brute/rmxattr.c  |  34 +
 tools/testing/selftests/brute/test.c     | 507 +++++++++++++++
 tools/testing/selftests/brute/test.sh    | 269 ++++++++
 26 files changed, 2099 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/Brute.rst
 create mode 100644 include/brute/brute.h
 create mode 100644 security/brute/Kconfig
 create mode 100644 security/brute/Makefile
 create mode 100644 security/brute/brute.c
 create mode 100644 tools/testing/selftests/brute/.gitignore
 create mode 100644 tools/testing/selftests/brute/Makefile
 create mode 100644 tools/testing/selftests/brute/config
 create mode 100644 tools/testing/selftests/brute/exec.c
 create mode 100644 tools/testing/selftests/brute/rmxattr.c
 create mode 100644 tools/testing/selftests/brute/test.c
 create mode 100755 tools/testing/selftests/brute/test.sh

=2D-
2.25.1

