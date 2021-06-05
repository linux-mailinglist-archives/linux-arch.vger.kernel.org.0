Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2839C999
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFEPu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 11:50:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:57561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhFEPu7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 11:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622908090;
        bh=NR7CetDZEJKb4urZklHxpJH9CQk1kXh04lqUmzV2VFQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z14fX/BDAt8rlYVCQ2W1JNECZ3Nbr3z0zf696jh81htz40qSfRY0BFqa+OTqs6UQc
         hvOtA2fzDnez1/y9ZLgQArJDKGPCzM/rXnk57dikoUY9XQfyIovRJX/elMzmWInjJv
         6DwSejwqkhFwEpT48eX/PirFuddTqMi8EzKAWEEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M3DJv-1loAYJ1jtF-003cjU; Sat, 05 Jun 2021 17:48:10 +0200
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
Subject: [PATCH v8 2/8] security/brute: Define a LSM and add sysctl attributes
Date:   Sat,  5 Jun 2021 17:03:59 +0200
Message-Id: <20210605150405.6936-3-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605150405.6936-1-john.wood@gmx.com>
References: <20210605150405.6936-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JXaQJfGTcSR0lvHjmBWsXjH1ZKVaVjnn0UvOhP+EbAQRPkBCgI1
 DA5IRh+UNu+/Foy/9XrfO0tedY3Jna3eK8GYRvg5YfgDHkZ7aOB3/f0QHPN7+Xwm1B4ggPX
 oF4zge1gUtstoNA8epEYi/+IrvFgxXlA4pXzn/AIm0P9Bl8GLGwwVUWvJtu5nqZzbSYriSE
 +2Dl2rhtjTEbB952r9mdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cIMC9mC3TMU=:NSGpjSHDR71UOOzUcq+D8h
 Fvx5o+hh92fPHWJCoZImAzaaAYFpFyeKLItdngS+TtLrwYzlxS5ehrb0bG2LB3XMbKLFnv5PN
 86dABR0nSTk4K5FhenkeF1vC+e3YB0zPVW1D8a/L+MHgpcaFAukMHa6/Xd2qZ0s9gumf5ig2E
 aFn+4Pm19jsGKmko6OkS6LGmhJC2VwimAPKxzREORk+DP38nR0F2i6aSoNNFomvi4iu/JQ8af
 AX2dWNn34sgzR2i0YxwZ8uhnXaJFeeh2SQBf/NxU2HXBG7glOAXU7S56KabsefLvuNI6AI63h
 u8ZvIvGsTYpnMB7VhiuhMn+ASse+6vwL256Z2pVvJvpwkdl5wnbwPT5L72/3x0aNS9ovS6zW3
 Cn2SFf63wFtkEnZRqiALV/MjmUNCYwFrP8wnIXLprTMCV8tXD3EfpRKBf6GtJ0v7O6Kpx+4if
 Al0gDypbLmy17cwltnXRkgQEvbwRew2GjgCsc+KDzHnOXtgn7XT6AvWkyVR9McpKuk9fFIvXQ
 Owgbv6OroIa/dya2wgqLir3LJlYDY30Rs7z+U5ppuHxm7P49ZPyAwGDaQOaS9KPyPVrhuSkzt
 smBNh4Nr7Kb6gwyJwXSKj4jcZEWLR8pvUlUSgqFXv4jOWL4paYEf4STwbgo0cQ1/wq8PTN3Aj
 2OItlA9Enz/vdLPDvU1gO3EQeGyvTtm/nMU2IbvVh/sl6/7rHzOIej1+Lr9FCEklzzvlsCr7t
 K5tXszJ84GAtLCxVMORdG4gBi2cCfPWZB5SrByb9lRO7AD7DSAnk+JU3dTuzRbhar1mgxlCJR
 FoXUuG/OzuXs20SRiZBnSKPHTfMnHtTs+0eGJ8/w+B717zAQUWyZgp+3UQPyyyC5IsxT9JmCZ
 Tac1sRS76dMFqsIBzpvBcsvW4PkMoodb47xx67mLHqQk4K5xH7wb2X0HhoUmB4EmASOkhAN+i
 VgySvfPQLrQ+gYDr9NYu++wjRGK1Pjtld6lDxH5TCy7H0iY4WOaGoIGjpn1exHdSn9Ux3Zh/Z
 0TF1EvxFSXr8CfmUXLr2i92Ix//Yxg/C/pof6d9SQ+neM6joiowcHIDTaW6ibQ9qZnkcDdkZy
 4MJn6crPtaslDjYPO3bcXnVV5uPB8XftL+X
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a new Kconfig file to define a menu entry under "Security options"
to enable the "Fork brute force attack detection and mitigation"
feature.

The detection of a brute force attack can be based on the number of
faults per application and its crash rate.

There are two types of brute force attacks that can be detected. The
first one is a slow brute force attack that is detected if the maximum
number of faults per fork hierarchy is reached. The second type is a
fast brute force attack that is detected if the application crash period
falls below a certain threshold.

The application crash period must be a value that is not prone to change
due to spurious data and follows the real crash period. So, to compute
it, the exponential moving average (EMA) will be used.

This kind of average defines a weight (between 0 and 1) for the new
value to add and applies the remainder of the weight to the current
average value. This way, some spurious data will not excessively modify
the average and only if the new values are persistent, the moving
average will tend towards them.

Mathematically the application crash period's EMA can be expressed as
follows:

period_ema =3D period * weight + period_ema * (1 - weight)

Moreover, it is important to note that a minimum number of faults is
needed to guarantee a trend in the crash period when the EMA is used.

So, based on all the previous information define a LSM with five sysctl
attributes that will be used to fine tune the attack detection.

ema_weight_numerator
ema_weight_denominator
max_faults
min_faults
crash_period_threshold

This patch is a previous step on the way to fine tune the attack
detection.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/Kconfig        |  11 +--
 security/Makefile       |   2 +
 security/brute/Kconfig  |  14 ++++
 security/brute/Makefile |   2 +
 security/brute/brute.c  | 147 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100644 security/brute/Kconfig
 create mode 100644 security/brute/Makefile
 create mode 100644 security/brute/brute.c

diff --git a/security/Kconfig b/security/Kconfig
index 0ced7fd33e4d..2df1727f2c2c 100644
=2D-- a/security/Kconfig
+++ b/security/Kconfig
@@ -241,6 +241,7 @@ source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"

 source "security/integrity/Kconfig"
+source "security/brute/Kconfig"

 choice
 	prompt "First legacy 'major LSM' to be initialized"
@@ -278,11 +279,11 @@ endchoice

 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinu=
x,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,sel=
inux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" =
if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFA=
ULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smac=
k,tomoyo,apparmor,bpf"
+	default "landlock,lockdown,brute,yama,loadpin,safesetid,integrity,smack,=
selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,brute,yama,loadpin,safesetid,integrity,apparm=
or,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,brute,yama,loadpin,safesetid,integrity,tomoyo=
,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,brute,yama,loadpin,safesetid,integrity,bpf" i=
f DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,brute,yama,loadpin,safesetid,integrity,selinu=
x,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index 47e432900e24..94d325256413 100644
=2D-- a/security/Makefile
+++ b/security/Makefile
@@ -14,6 +14,7 @@ subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown
 subdir-$(CONFIG_BPF_LSM)		+=3D bpf
 subdir-$(CONFIG_SECURITY_LANDLOCK)	+=3D landlock
+subdir-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute

 # always enable default capabilities
 obj-y					+=3D commoncap.o
@@ -34,6 +35,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
 obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+=3D bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
+obj-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute/

 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+=3D integrity
diff --git a/security/brute/Kconfig b/security/brute/Kconfig
new file mode 100644
index 000000000000..5da314d221aa
=2D-- /dev/null
+++ b/security/brute/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+config SECURITY_FORK_BRUTE
+	bool "Fork brute force attack detection and mitigation"
+	depends on SECURITY
+	help
+	  This is an LSM that stops any fork brute force attack against
+	  vulnerable userspace processes. The detection method is based on
+	  the application crash period and as a mitigation procedure all the
+	  offending tasks are killed. Also, the executable file involved in the
+	  attack will be marked as "not allowed" and new execve system calls
+	  using this file will fail. Like capabilities, this security module
+	  stacks with other LSMs.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/brute/Makefile b/security/brute/Makefile
new file mode 100644
index 000000000000..d3f233a132a9
=2D-- /dev/null
+++ b/security/brute/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SECURITY_FORK_BRUTE) +=3D brute.o
diff --git a/security/brute/brute.c b/security/brute/brute.c
new file mode 100644
index 000000000000..0edb89a58ab0
=2D-- /dev/null
+++ b/security/brute/brute.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lsm_hooks.h>
+#include <linux/sysctl.h>
+
+/**
+ * DOC: brute_ema_weight_numerator
+ *
+ * Weight's numerator of EMA.
+ */
+static unsigned int brute_ema_weight_numerator __read_mostly =3D 7;
+
+/**
+ * DOC: brute_ema_weight_denominator
+ *
+ * Weight's denominator of EMA.
+ */
+static unsigned int brute_ema_weight_denominator __read_mostly =3D 10;
+
+/**
+ * DOC: brute_max_faults
+ *
+ * Maximum number of faults.
+ *
+ * If a brute force attack is running slowly for a long time, the applica=
tion
+ * crash period's EMA is not suitable for the detection. This type of att=
ack
+ * must be detected using a maximum number of faults.
+ */
+static unsigned int brute_max_faults __read_mostly =3D 200;
+
+/**
+ * DOC: brute_min_faults
+ *
+ * Minimum number of faults.
+ *
+ * The application crash period's EMA cannot be used until a minimum numb=
er of
+ * data has been applied to it. This constraint allows getting a trend wh=
en this
+ * moving average is used.
+ */
+static unsigned int brute_min_faults __read_mostly =3D 5;
+
+/**
+ * DOC: brute_crash_period_threshold
+ *
+ * Application crash period threshold.
+ *
+ * A fast brute force attack is detected when the application crash perio=
d falls
+ * below this threshold. The units are expressed in seconds.
+ */
+static unsigned int brute_crash_period_threshold __read_mostly =3D 30;
+
+#ifdef CONFIG_SYSCTL
+static unsigned int uint_max =3D UINT_MAX;
+#define SYSCTL_UINT_MAX (&uint_max)
+
+/*
+ * brute_sysctl_path - Sysctl attributes path.
+ */
+static struct ctl_path brute_sysctl_path[] =3D {
+	{ .procname =3D "kernel", },
+	{ .procname =3D "brute", },
+	{ }
+};
+
+/*
+ * brute_sysctl_table - Sysctl attributes.
+ */
+static struct ctl_table brute_sysctl_table[] =3D {
+	{
+		.procname	=3D "ema_weight_numerator",
+		.data		=3D &brute_ema_weight_numerator,
+		.maxlen		=3D sizeof(brute_ema_weight_numerator),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D &brute_ema_weight_denominator,
+	},
+	{
+		.procname	=3D "ema_weight_denominator",
+		.data		=3D &brute_ema_weight_denominator,
+		.maxlen		=3D sizeof(brute_ema_weight_denominator),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D &brute_ema_weight_numerator,
+		.extra2		=3D SYSCTL_UINT_MAX,
+	},
+	{
+		.procname	=3D "max_faults",
+		.data		=3D &brute_max_faults,
+		.maxlen		=3D sizeof(brute_max_faults),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D &brute_min_faults,
+		.extra2		=3D SYSCTL_UINT_MAX,
+	},
+	{
+		.procname	=3D "min_faults",
+		.data		=3D &brute_min_faults,
+		.maxlen		=3D sizeof(brute_min_faults),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D SYSCTL_ONE,
+		.extra2		=3D &brute_max_faults,
+	},
+	{
+		.procname	=3D "crash_period_threshold",
+		.data		=3D &brute_crash_period_threshold,
+		.maxlen		=3D sizeof(brute_crash_period_threshold),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec_minmax,
+		.extra1		=3D SYSCTL_ONE,
+		.extra2		=3D SYSCTL_UINT_MAX,
+	},
+	{ }
+};
+
+/**
+ * brute_init_sysctl() - Initialize the sysctl interface.
+ */
+static void __init brute_init_sysctl(void)
+{
+	if (!register_sysctl_paths(brute_sysctl_path, brute_sysctl_table))
+		panic("sysctl registration failed\n");
+}
+
+#else
+static inline void brute_init_sysctl(void) { }
+#endif /* CONFIG_SYSCTL */
+
+/**
+ * brute_init() - Initialize the brute LSM.
+ *
+ * Return: Always returns zero.
+ */
+static int __init brute_init(void)
+{
+	pr_info("becoming mindful\n");
+	brute_init_sysctl();
+	return 0;
+}
+
+DEFINE_LSM(brute) =3D {
+	.name =3D KBUILD_MODNAME,
+	.init =3D brute_init,
+};
=2D-
2.25.1

