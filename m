Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3873A45A9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhFKPpE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 11:45:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:55819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhFKPpD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Jun 2021 11:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623426100;
        bh=wSl94BM+7x5/sCumDnkuvfHVswV21AdjoNAYK7HUeg0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ktv15AFt+uhCBDslUDCIx1FJIBzYrZ3u61mrbS09SZ8CYUSCThBLz9MaVwyb1Fozf
         N/Pe2Jskoc0lhiOmiEts4rJ9FuzobAcwu2xGxvRTpGZ8WsFF/RQexkFqRKv/lNV7Bq
         wQGqYp/p9mytBvSd2EU+qff/qDr4dH4JDQL623e4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.228.41]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1laTQ31Nax-00JdlI; Fri, 11
 Jun 2021 17:41:40 +0200
Date:   Fri, 11 Jun 2021 17:41:23 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 0/8] Fork brute force attack mitigation
Message-ID: <20210611154123.GA3057@ubuntu>
References: <20210605150405.6936-1-john.wood@gmx.com>
 <202106081616.EC17DC1D0D@keescook>
 <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
 <202106090951.8C1B5BAD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106090951.8C1B5BAD@keescook>
X-Provags-ID: V03:K1:z/ThWGP2ZXkRX2ENXQAW/y0IqOK8vdtgPOoV6FgxUCUCFL6dypE
 Q2jb1TIg/EBtSsnOOmZRk5QWnOZUUHjYolIgJf4CYCaeOTqxYMjuXgRhvutKU4VTq9EfK0+
 IUIbEDpjRaIJsJwfD7MpdryDp+sCXpPdVSWuhbsVu6c/zi6waJmk5puVuhdQQFmxwj9kiJ/
 IK8pJI6fVbxIjv/MIv5Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jcw2bEeUOA4=:8Y2o1L32c5gONZQWS8a6u7
 X2yTDJ2C8O2Jc69Azq8go7nM7u/PFeRW2EmORk1I7Iqkd4O4ShnurPNRasNNF0EKq7wANU5qX
 zmUZkCcOvCwp42c7Qp026M3OOS/Gge2Bl6TPrQAA8s6BpRD6Z+YQZvrfJyoEtYjVR/0OQpDL5
 ACGwLBqWsL4OEOe+64DU1jg0AOi/9NlSNGyrACjq7Z3oJMC3YX4oByU6ElloP0UGdEJa0CDXT
 8wugo0k6PStZzcj1/x72E336qPT2V6/EnA3BlKF5LrMF0tgUa9T2PAY+gXJSy+WnDuNZCXSek
 PfTgzkQ6FiUa2a4aHT1ThrwQwiinfDq0fnQj5MoL5u265ZxQFTCYatuL4cp6wivUsn5jqM9gW
 +5f7axMaY6YW9KtorDOzDFmMVTucu3Zw03shXZpgvu/rNRw1HKtXpYo+uzjkOq7G+F3Ko9RY3
 G8jqxIQGiE+WZ0yhsrDfwfTwANnuiGaMqTkjL8k8Wsfn6y4t/51RZRM69SoMfkgSwnXxv2Pca
 jtXNU22sj4dFI6cI0Rzs6Oi39yurSDmWg2H0Vq2mFYeWpVkCVxJIDb9jB9ruCj4HuijGklNQ3
 G4Vk5JBp8GIotoPp/BZcUebHaRHoxGXXP2mQcdWft6wvFZDTwMS4QYCOvPhjVd4A/yxaByH1f
 J/6W0LJgi3VyJ73ZFmVPrd+zreavLizvV38Lx+ZCYvcZmiVsQaUMB4hlpp+VANQcrdyJcetXg
 ZEQD6J14tEwXXk12ZsmjvEaXmatCzKaIBT+vZKj2NDWCLQmdvBmcW0173aaIULFRyEqoVO3Vy
 riOm373Is1aOpOdCetPbyqwjXgfx5epO5yba/NPMQzq0s0zpTS3qvrXkM2nMzk2CMGXdJtpqk
 8ZKYeqMTpH0XfOSAQo6vPSpqxaaT3OOyjpzlAxHfZa5KMYOIkBpTnr/vBqUVCx1zvq9IodGLn
 qYbl4szFzS6q3vPwivuE7b2WaaOMQKsn863wA+i1LvAQdcdrYu+0NGwo9/46BHWW82C5AY4c7
 Oa1sAGJ1VQt/tD81gDBBot/qgLcAAR5/XaNy34PTubEYzkMbE0KhdInOVW9Rv4pENYHbjv/8w
 azBKa8ZZeHW0J2WanyqMOeuBmd/fG4IM6B7
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 09, 2021 at 09:52:29AM -0700, Kees Cook wrote:
> On Tue, Jun 08, 2021 at 04:38:15PM -0700, Andi Kleen wrote:
> >
> > On 6/8/2021 4:19 PM, Kees Cook wrote:
> > > On Sat, Jun 05, 2021 at 05:03:57PM +0200, John Wood wrote:
> > > > [...]
> > > > the kselftest to avoid the detection ;) ). So, in this version, to=
 track
> > > > all the statistical data (info related with application crashes), =
the
> > > > extended attributes feature for the executable files are used. The=
 xattr is
> > > > also used to mark the executables as "not allowed" when an attack =
is
> > > > detected. Then, the execve system call rely on this flag to avoid =
following
> > > > executions of this file.
> > >
> > > I have some concerns about this being actually usable and not creati=
ng
> > > DoS situations. For example, let's say an attacker had found a hard-=
to-hit
> > > bug in "sudo", and starts brute forcing it. When the brute LSM notic=
es,
> > > it'll make "sudo" unusable for the entire system, yes?
> > >
> > > And a reboot won't fix it, either, IIUC.
> > >
> > The whole point of the mitigation is to trade potential attacks agains=
t DOS.
> >
> > If you're worried about DOS the whole thing is not for you.
>
> Right, but there's no need to make a system unusable for everyone else.
> There's nothing here that relaxes the defense (i.e. stop spawning apache
> for 10 minutes). Writing it to disk with nothing that undoes it seems a
> bit too much. :)

Here I have merge the first reply.

> It seems like there is a need to track "user" running "prog", and have
> that be timed out. Are there use-cases here where that wouldn't be
> sufficient?

Ok, what do you think of the following proposal:

Add an uid_t field to the structure saved in the xattr. So this struct
contains now

faults: Number of crashes.
nsecs: Last crash timestamp as the number of nanoseconds in the
       International Atomic Time (TAI) reference.
period: Crash period's moving average.
flags: Statistics flags.
uid: User id not allowed to run the executable.

The logic would be the following:

1. faults, nsecs and period are updated in every crash and is a common inf=
o
   for all the users.
2. If the max number of faults is reached, it is "not allowed" to run the
   executable by any user. This condition blocks the file until root clear
   the xattr. No timeout.
3. When an attack is detected the uid of the user that is running the app
   is saved in the xattr and the executable is marked as "not allowed" to
   run by this user. The "not allowed" state has a timeout (more below).
4. When someone tries to run the executable, if his uid is different from
   the uid saved in the xattr, then the operation is "allowed".
5. When someone tries to run the executable, if his uid is equal to the
   uid saved in the xattr, then the operation is "not allowed". This user
   is banned for a timeout.
6. When someone tries to run the executable and the timeout has expired,
   the operation is "allowed" and the saved uid is removed.
7. If the executable crashes again when it is run by a user different from
   the one saved in the xattr (and the timeout has no expired), the file
   is marked as "not allowed" to run by any user. All users are banned for
   a timeout.

The timeout: I think there are two options here.

1. A fixed timeout set by a sysctl attribute.
2. A dynamic timeout calculated from the info stored in the xattr. The
   timeout would be the needed period to guarantee that when the app is
   run again and it crashes, the attack detection will not be triggered.
   To be more clear I expose the formulas:

   Mathematically the application crash period's EMA can be expressed as
   follows:

   period_ema[i] =3D period[i] * weight + period_ema[i - 1] * (1 - weight)

   If we isolate period:

   period[i] =3D (period_ema[i] - period_ema[i - 1] * (1 - weight)) / weig=
ht

   Where period_ema[i] is the "crash_period_threshold", period_ema[i - 1]
   is the last period ema saved in the xattr and period[i] is the dynamic
   timeout.

As a final point. Possibly there are more cases but the logic would be the
one explained. I think that it is not necessary to save the uid for every
user that crashes the app nor the crashes info for every user. If more
than one user crashes the application, something "bad" is happening. So,
all users are banned for a timeout. This way the info saved in the xattr
has a fixed size and we prevent an attacker from abusing this size.

I hope this proposal can be enough. What do you think?

John Wood.
