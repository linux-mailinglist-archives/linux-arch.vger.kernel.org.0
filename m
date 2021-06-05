Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37239CA3C
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFERjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 13:39:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:35725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhFERjc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 13:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622914614;
        bh=1hXV/yjZLA0wxI2MASfsKb+LCQQTwffVxcZC0DJ8vZc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LZJs/HfrhXXEYrxoffCqJHPONff2AbYWO7ycBaQyxZ3War/piYaNNsKqSLF/7FJ1w
         tzFS7umCnlXN+9Jm+yI35mAvFxV4M5A5XjfIHYWrY+WnOGDK0+/TMhAYgh46OPMMlr
         OFQ/nfxFm7SqPgeUgG38Snlab6GR8GxcX4MgstFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mel3n-1lH4QF0AxJ-00akS2; Sat, 05 Jun 2021 19:36:54 +0200
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
Subject: [PATCH v8 7/8] Documentation: Add documentation for the Brute LSM
Date:   Sat,  5 Jun 2021 17:04:04 +0200
Message-Id: <20210605150405.6936-8-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KL9tDrO6fCH0+oVpAMP680+/i0P5U/y+YiqVSYK3DibHnISQsk
 ApRWspMjCltTb1smQIsTuiH1gj8a3MZ3Nk1qk6D0DkgkzyUmniVAgRCqb/u4ASwudQSG+hg
 ezL0FgYqc7qvDnnA6nUcE4I0DDcliEjIJ8mD0rwSWyT5b+qrge1jPahM43lfT3HTcujxHun
 fgH7iK8tok24hAG6EJtxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jef2qRjYI5M=:bw6UHTDC/E2yoxW+Kxz/OF
 Y0bMnMn71GilFvcfkFrZS5HMQn3np2kZVdA7o/HUMWNb12gmNv5xrgWV7mMdl7tGKYgM7pXBv
 iO9dGd6L1tFuvsIZp4at/tOKtqIMfc+OCfY9ZTYp0ZbVT2ZQmJLG2OK0PdpaUpQK9fiL4xaFf
 3diJODOM5zsYe1DpM3cHdnKQy75My0A01v/EIyVanYyBRl51ndtF0IziLtnifU9iMC7EnJonr
 vS1rDXhr7kqJFa5Dl4PLh6xPvjWnRsRcLlyyBeephHm6gtey/wkuvguNXLyFQUZoivVPg6cFs
 2Fo+B13T5XOh3OATuUdgaGHLPnh3UibGoHhhTxz72BUQ62Xq5U4wEoAFpOQLnWjnGxhJFqqY4
 tb3MuersWSow0RL4sAUwBrJgr6Ieg7pCwATyXAxjAWB/ejzv4Gm3bZwuPavpprWlltt8OmdMa
 PzgwpK6kR5R+UnwTDahZpS5g2KhZuQ8lbvmIVyTaVo6ZTei11vGVN6Rdf5pMjRCVpHePHeI4v
 PilI+R4iCy1g28Xqej1OwZMki09e5S4DPgxyZAmVDCJfCAbuzXDqbQ65wCuSzzeFmwcbXCU+w
 FwDm3mGgs/VrhtjwTt4aAh+ANLoosfPTUQnM4orRRwgmbAf/ytLx1WmuA5szL8b0pDvTHh5cA
 WITBIQJJAsCwhjCKMth0TYa8narIj31ZJqY4qCR8GhtS8/rMn6EJh2MrlAGZ74YNSpqeKS5uf
 8FzFJN08McY26rYCj7W+9EbpGOb5RvUJCu42ACbcN8vEa6JPD0BiFiS9RCTR1ZMo29nwv8Xqq
 bvZ0G5pUVFJag4u0hHn21bO3/Ely+x0kbEFItKybXJOeChgefu57o4Zr3TyY7IaZRjk/m6qYX
 d4J5pcR9NHr4iznDB75dQ8k0zCBiUBx28thrDaNVhzhSlt80kmyV/wsV17VVu7dlLgYKH+SJJ
 IigU2ovbnta/dZL9RJaUA+wrNLTSW/chs9L+sbznt8DNwTum7Bw9lGmVWEuyvg7J3yLVEVLep
 zoX08B4QZb2g04hu33D2ZKhtYLPSGGhiqbfLE0Y9hUJsQRjHdRp5hCGFBShGo0Zu/4LH6PFY2
 D7dY0tiPl9LjEaUrEsZEcMRJ6eb4kJov7Ur
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add some info detailing what is the Brute LSM, its motivation, weak
points of existing implementations, proposed solutions, notifications,
enabling, disabling, configuration and self-tests.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 Documentation/admin-guide/LSM/Brute.rst | 359 ++++++++++++++++++++++++
 Documentation/admin-guide/LSM/index.rst |   1 +
 security/brute/Kconfig                  |   3 +-
 3 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Brute.rst

diff --git a/Documentation/admin-guide/LSM/Brute.rst b/Documentation/admin=
-guide/LSM/Brute.rst
new file mode 100644
index 000000000000..087da9c07374
=2D-- /dev/null
+++ b/Documentation/admin-guide/LSM/Brute.rst
@@ -0,0 +1,359 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D
+Brute
+=3D=3D=3D=3D=3D
+
+Brute is a Linux Security Module that detects and mitigates fork brute fo=
rce
+attacks against vulnerable userspace processes.
+
+
+Motivation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Attacks against vulnerable userspace applications with the purpose to bre=
ak ASLR
+or bypass canaries traditionally use some level of brute force with the h=
elp of
+the fork system call. This is possible since when creating a new process =
using
+fork its memory contents are the same as those of the parent process (the
+process that called the fork system call). So, the attacker can test the =
memory
+infinite times to find the correct memory values or the correct memory ad=
dresses
+without worrying about crashing the application.
+
+Based on the above scenario it would be nice to have this detected and
+mitigated, and this is the goal of this implementation. Specifically the
+following attacks are expected to be detected:
+
+ 1. Launching (fork()/exec()) a setuid/setgid process repeatedly until a
+    desirable memory layout is got (e.g. Stack Clash).
+ 2. Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly un=
til a
+    desirable memory layout is got (e.g. what CTFs do for simple network
+    service).
+ 3. Launching processes without exec() (e.g. Android Zygote) and exposing=
 state
+    to attack a sibling.
+ 4. Connecting to a fork()ing network daemon (e.g. apache) repeatedly unt=
il the
+    previously shared memory layout of all the other children is exposed =
(e.g.
+    kind of related to HeartBleed).
+
+In each case, a privilege boundary has been crossed:
+
+ | Case 1: setuid/setgid process
+ | Case 2: network to local
+ | Case 3: privilege changes
+ | Case 4: network to local
+
+So, what really needs to be detected are fork/exec brute force attacks th=
at
+cross any of the commented bounds.
+
+
+Other implementations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The public version of grsecurity, as a summary, is based on the idea of d=
elaying
+the fork system call if a child died due to some fatal signal (``SIGSEGV`=
`,
+``SIGBUS``, ``SIGKILL`` or ``SIGILL``). This has some issues:
+
+Bad practices
+-------------
+
+Adding delays to the kernel is, in general, a bad idea.
+
+Scenarios not detected (false negatives)
+----------------------------------------
+
+This protection acts only when the fork system call is called after a chi=
ld has
+crashed. So, it would still be possible for an attacker to fork a big amo=
unt of
+children (in the order of thousands), then probe all of them, and finally=
 wait
+the protection time before repeating the steps.
+
+Moreover, this method is based on the idea that the protection doesn't ac=
t if
+the parent crashes. So, it would still be possible for an attacker to for=
k a
+process and probe itself. Then, fork the child process and probe itself a=
gain.
+This way, these steps can be repeated infinite times without any mitigati=
on.
+
+Scenarios detected (false positives)
+------------------------------------
+
+Scenarios where an application rarely fails for reasons unrelated to a re=
al
+attack.
+
+
+This implementation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The main idea behind this implementation is to improve the existing ones
+focusing on the weak points annotated before. Basically, the adopted solu=
tion is
+to detect a fast crash rate instead of only one simple crash and to detec=
t both
+the crash of parent and child processes. Also, fine tune the detection fo=
cusing
+on privilege boundary crossing. And finally, as a mitigation method, kill=
 all
+the offending tasks involved in the attack and mark the executable as "no=
t
+allowed" (to block the following executions) instead of using delays.
+
+To achieve this goal, and going into more details, this implementation is=
 based
+on the use of some statistical data shared across all the processes that =
can
+have the same memory contents. Or in other words, a statistical data shar=
ed
+between all the fork hierarchy processes after an execve system call.
+
+The purpose of these statistics is, basically, collect all the necessary =
info to
+compute the application crash period in order to detect an attack. To tra=
ck all
+this information, the extended attributes (xattr) of the executable files=
 are
+used. More specifically, the name of the attribute is "brute" and uses th=
e
+"security" namespace. So, the full xattr name for the Brute LSM is:
+
+ ``security.brute``
+
+The same can be achieved using a pointer to the fork hierarchy statistica=
l data
+held by the ``task_struct`` structure, but this has an important drawback=
: a
+brute force attack that happens through the execve system call losts the =
faults
+info since these statistics are freed when the fork hierarchy disappears.=
 Using
+the last method (pointer in the ``task_struct`` structure) makes not poss=
ible to
+manage this attack type that can be successfully treated using extended
+attributes.
+
+To detect a brute force attack it is necessary that the statistics shared=
 by all
+the fork hierarchy processes be updated in every fatal crash and the most
+important data to update is the application crash period.
+
+The crash period is the time between two consecutive faults, but this als=
o has a
+drawback: if an application crashes twice in a short period of time for s=
ome
+reason unrelated to a real attack, a false positive will be triggered. To=
 avoid
+this scenario the exponential moving average (EMA) is used. This way, the
+application crash period will be a value that is not prone to change due =
to
+spurious data and follows the real crash period.
+
+These statistics are stored in the executables using the extended attribu=
tes
+feature. So, the detection and mitigation of brute force attacks using th=
is LSM
+it is only feasible in filesystems that support xattr.
+
+.. kernel-doc:: security/brute/brute.c
+   :identifiers: brute_raw_stats
+
+This is a fixed sized struct with a very small footprint. So, in referenc=
e to
+memory usage, it is not expected to have problems storing it as an extend=
ed
+attribute.
+
+Concerning to access rights to this statistical data, as stated above, th=
e
+"security" namespace is used. Since no custom policy, related to this ext=
ended
+attribute, has been implemented for the Brute LSM, all processes have rea=
d
+access to these statistics, and write access is limited to processes that=
 have
+the ``CAP_SYS_ADMIN`` capability.
+
+Attack detection
+----------------
+
+There are two types of brute force attacks that need to be detected. The =
first
+one is an attack that happens through the fork system call and the second=
 one is
+an attack that happens through the execve system call. Moreover, these tw=
o
+attack types have two variants. A slow brute force attack that is detecte=
d if a
+maximum number of faults per fork hierarchy is reached and a fast brute f=
orce
+attack that is detected if the application crash period falls below a cer=
tain
+threshold.
+
+Attack mitigation
+-----------------
+
+Once an attack has been detected, this is mitigated killing all the offen=
ding
+tasks involved. Or in other words, once an attack has been detected, this=
 is
+mitigated killing all the processes that are executing the same file that=
 is
+running during the brute force attack. Also, to prevent the executable in=
volved
+in the attack from being respawned by a supervisor, and thus prevent a br=
ute
+force attack from being started again, the file is marked as "not allowed=
" and
+the following executions are avoided based on this mark. This method allo=
ws
+supervisors to implement their own policy: they can read the statistics, =
know if
+the executable is blocked by the Brute LSM and why, and act based on this
+information. If they want to respawn the offending executable it is only
+necessary to remove the "``security.brute``" extended attribute and thus =
remove
+the statistical data.
+
+Fine tuning the attack detection
+--------------------------------
+
+To avoid false positives during the attack detection it is necessary to n=
arrow
+the possible cases. To do so, and based on the threat scenarios that we w=
ant to
+detect, this implementation also focuses on the crossing of privilege bou=
nds.
+
+To be precise, only the following privilege bounds are taken into account=
:
+
+ 1. setuid/setgid process
+ 2. network to local
+ 3. privilege changes
+
+Moreover, only the fatal signals delivered by the kernel are taken into a=
ccount
+avoiding the fatal signals sent by userspace applications (with the excep=
tion of
+the ``SIGABRT`` user signal since this is used by glibc for stack canary,
+malloc, etc. failures, which may indicate that a mitigation has been trig=
gered).
+
+Userspace notification via waitid() system call
+-----------------------------------------------
+
+Although the xattr of the executable is accessible from userspace, in com=
plex
+daemons this file may not be visible directly by the supervisor as it may=
 be run
+through some wrapper. So, an extension to the ``waitid()`` system call ha=
s been
+added.
+
+ ``int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);``
+
+Upon successful return, ``waitid()`` fills in the ``siginfo_t`` structure
+pointed to by ``infop``, but now, the ``si_code`` field can be:
+
+ ``CLD_BRUTE``: child was killed by brute LSM. Defined as value 7.
+
+in addition to the following codes:
+
+ | ``CLD_EXITED``: child has called exit. Defined as value 1.
+ | ``CLD_KILLED``: child was killed by signal. Defined as value 2.
+ | ``CLD_DUMPED``: child terminated abnormally. Defined as value 3.
+ | ``CLD_TRAPPED``: traced child has trapped. Defined as value 4.
+ | ``CLD_STOPPED``: child has stopped. Defined as value 5.
+ | ``CLD_CONTINUED``: stopped child has continued. Defined as value 6.
+
+Exponential moving average (EMA)
+--------------------------------
+
+This kind of average defines a weight (between 0 and 1) for the new value=
 to add
+and applies the remainder of the weight to the current average value. Thi=
s way,
+some spurious data will not excessively modify the average and only if th=
e new
+values are persistent, the moving average will tend towards them.
+
+Mathematically the application crash period's EMA can be expressed as fol=
lows:
+
+ period_ema =3D period * weight + period_ema * (1 - weight)
+
+Related to the attack detection, the EMA must guarantee that not many cra=
shes
+are needed. To demonstrate this, the scenario where an application has fa=
iled
+and then has been running without any crashes for a month, will be used.
+
+The period's EMA can be written now as:
+
+ period_ema[i] =3D period[i] * weight + period_ema[i - 1] * (1 - weight)
+
+If the new crash periods have insignificant values related to the first c=
rash
+period (a month in this case), the formula can be rewritten as:
+
+ period_ema[i] =3D period_ema[i - 1] * (1 - weight)
+
+And by extension:
+
+ | period_ema[i - 1] =3D period_ema[i - 2] * (1 - weight)
+ | period_ema[i - 2] =3D period_ema[i - 3] * (1 - weight)
+ | period_ema[i - 3] =3D period_ema[i - 4] * (1 - weight)
+
+So, if the substitution is made:
+
+ | period_ema[i] =3D period_ema[i - 1] * (1 - weight)
+ | period_ema[i] =3D period_ema[i - 2] * (1 - weight)\ :sup:`2`
+ | period_ema[i] =3D period_ema[i - 3] * (1 - weight)\ :sup:`3`
+ | period_ema[i] =3D period_ema[i - 4] * (1 - weight)\ :sup:`4`
+
+And in a more generic form:
+
+ period_ema[i] =3D period_ema[i - n] * (1 - weight)\ :sup:`n`
+
+Where "n" represents the number of iterations to obtain an EMA value. Or =
in
+other words, the number of crashes to detect an attack.
+
+So, if we isolate the number of crashes:
+
+ | period_ema[i] / period_ema[i - n] =3D (1 - weight)\ :sup:`n`
+ | log(period_ema[i] / period_ema[i - n]) =3D log((1 - weight)\ :sup:`n`)
+ | log(period_ema[i] / period_ema[i - n]) =3D n * log(1 - weight)
+ | n =3D log(period_ema[i] / period_ema[i - n]) / log(1 - weight)
+
+Then, in the commented scenario (an application has failed and then has b=
een
+running without any crashes for a month), the approximate number of crash=
es to
+detect an attack (using the default implementation values for the weight =
and the
+crash period threshold) is:
+
+ | weight =3D 7 / 10
+ | crash_period_threshold =3D 30 seconds
+
+ | n =3D log(crash_period_threshold / seconds_per_month) / log(1 - weight=
)
+ | n =3D log(30 / (30 * 24 * 3600)) / log(1 - 0.7)
+ | n =3D 9.44
+
+So, with 10 crashes for this scenario an attack will be detected. If thes=
e steps
+are repeated for different scenarios and the results are collected:
+
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ time without any crashes number of crashes to detect an attack
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ 1 month                  9.44
+ 1 year                   11.50
+ 10 years                 13.42
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+However, this computation has a drawback. The first data added to the EMA=
 not
+obtains a real average showing a trend. So the solution is simple, the EM=
A needs
+a minimum number of data to be able to be interpreted. This way, the case=
 where
+a few first faults are fast enough followed by no crashes is avoided.
+
+Per system enabling/disabling
+-----------------------------
+
+This feature can be enabled at build time using the
+``CONFIG_SECURITY_FORK_BRUTE`` option or using the visual config applicat=
ion
+under the following menu:
+
+ Security options  ``--->`` Fork brute force attack detection and mitigat=
ion
+
+Also, at boot time, this feature can be disable too, by changing the "``l=
sm=3D``"
+boot parameter.
+
+Per system configuration
+------------------------
+
+To customize the detection's sensibility there are five new sysctl attrib=
utes
+for the Brute LSM that are accessible through the following path:
+
+ ``/proc/sys/kernel/brute/``
+
+More specifically, the files and their description are:
+
+**ema_weight_numerator**
+
+ .. kernel-doc:: security/brute/brute.c
+    :doc: brute_ema_weight_numerator
+
+**ema_weight_denominator**
+
+ .. kernel-doc:: security/brute/brute.c
+    :doc: brute_ema_weight_denominator
+
+**max_faults**
+
+ .. kernel-doc:: security/brute/brute.c
+    :doc: brute_max_faults
+
+**min_faults**
+
+ .. kernel-doc:: security/brute/brute.c
+    :doc: brute_min_faults
+
+**crash_period_threshold**
+
+ .. kernel-doc:: security/brute/brute.c
+    :doc: brute_crash_period_threshold
+
+Kernel selftests
+----------------
+
+To validate all the expectations about this implementation, there is a se=
t of
+selftests. This tests cover fork/exec brute force attacks crossing the fo=
llowing
+privilege boundaries:
+
+ 1. setuid process
+ 2. privilege changes
+ 3. network to local
+
+Also, there are some tests to check that fork/exec brute force attacks wi=
thout
+crossing any privilege boundary already commented doesn't trigger the det=
ection
+and mitigation stage. Moreover, a test to verify the userspace notificati=
on via
+the ``waitid()`` system call has also been added.
+
+To build the tests:
+ ``make -C tools/testing/selftests/ TARGETS=3Dbrute``
+
+To run the tests:
+ ``make -C tools/testing/selftests TARGETS=3Dbrute run_tests``
+
+To package the tests:
+ ``make -C tools/testing/selftests TARGETS=3Dbrute gen_tar``
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin=
-guide/LSM/index.rst
index a6ba95fbaa9f..1f68982bb330 100644
=2D-- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -41,6 +41,7 @@ subdirectories.
    :maxdepth: 1

    apparmor
+   Brute
    LoadPin
    SELinux
    Smack
diff --git a/security/brute/Kconfig b/security/brute/Kconfig
index 5da314d221aa..d2dd33b08642 100644
=2D-- a/security/brute/Kconfig
+++ b/security/brute/Kconfig
@@ -9,6 +9,7 @@ config SECURITY_FORK_BRUTE
 	  offending tasks are killed. Also, the executable file involved in the
 	  attack will be marked as "not allowed" and new execve system calls
 	  using this file will fail. Like capabilities, this security module
-	  stacks with other LSMs.
+	  stacks with other LSMs. Further information can be found in
+	  Documentation/admin-guide/LSM/Brute.rst.

 	  If you are unsure how to answer this question, answer N.
=2D-
2.25.1

