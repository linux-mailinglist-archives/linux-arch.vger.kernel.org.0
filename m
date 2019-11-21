Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A79105466
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUO2Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 09:28:24 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:35207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKUO2X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 09:28:23 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MhlbM-1hu2qb31Zg-00doDm; Thu, 21 Nov 2019 15:28:21 +0100
Received: by mail-qt1-f175.google.com with SMTP id o11so3828152qtr.11;
        Thu, 21 Nov 2019 06:28:21 -0800 (PST)
X-Gm-Message-State: APjAAAVpE/RjHL+ncTjs8J92/qo5V8Y4lkqGlbPq37p3OVWARlA3KohO
        XoqskO+3h16FUtM80skNMPwfCV718CVABjY2b8E=
X-Google-Smtp-Source: APXvYqxB3fiYXtrETUp5EiMiQ9fb0AeisI+RwKyT7xggRKZinaPFWQOgz7hTMTjBH+1fCN1q48qajjrjZ95bUArYxrA=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr2519477qtk.304.1574346500017;
 Thu, 21 Nov 2019 06:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-8-arnd@arndb.de>
 <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
In-Reply-To: <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 15:28:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0VORzqLLTFpt9VYn_SONsve+-q0fTrZrPbLMpX9T6SBQ@mail.gmail.com>
Message-ID: <CAK8P3a0VORzqLLTFpt9VYn_SONsve+-q0fTrZrPbLMpX9T6SBQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 08/23] y2038: ipc: remove __kernel_time_t
 reference from headers
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LnPyaKtdAcRIfsrfVOvLgTpY2NYcJVXxz9V2TfTsyIVjaxXXWXo
 J0B/STj89T5mtEIVTc0DQpBVMrYNCU0NcRKyMbhUocUGEvCLRsv+tXSavgQ9f1ideIJ9QR/
 Y5hh36oQ5DHX7KGoy+fvIxvqyEiOiRDO5LBnW77E+fjNVlQJvkzhlyATiPB5C1vEiZb5+oS
 z+IMcyRaYAXzuuyPNj62w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8A/19T5M7NU=:IiGojC9BupST0/of+E3q2T
 awxsjk77FWMnOwQ4nks8TRVJzj8MaemtAxeTd5LZ6AU026M7mvm1hvPPHZ4QB1SOCc3AYUgwj
 JPVxeNksokjiewTxADZhlkQvmoHlH8s8IySCW9mTS2t5RD8o/IIkeCztir/MtztaDyYhZGCEF
 rJutdeF8yCwCOVEmI7Ryya6bzcLeLgOMSoT5Xc8Tr9ih6rF+jVFaOUAXQMQ6sS/CqZm07Z50W
 7mFRhVnGeKtcmbTcT0NTLP401mk/Y8oiEAIVOQBfgMLuw2i+hxNpBaSfN4BVM41IYS3h0x3HD
 uGGmN8Xg4IinXM7DMSUMDAzn6EMtVtq/QLtMgQqKk3tDFwE1zBuRSd44KbYWGHF3Q5aMOUzd8
 9Sz0SWtwZrbXJw+mhMw8rLqVMwp4yN0nU2VyHFcMDvtMFQ3BNUPTwIen5wbxdh2wWV5N7roDc
 doz4p7AZTAPDJskv5JNv1EKjjCl6xvoqQ7wnIp+Al8cIJxYnH6J4UDx5XPfdsrRS4pa+71lbm
 EWW0/i/p7///JQKDcKCh7ZZ4LPUrE/h1kYwBQP1MHg5hYP9OpFlu0k36Uv+f4AIeXpq+0CrfQ
 /bVHc+NPvKLBmPdC+v6whkNTSXKYLqce/eejLUwRvJjXDpqKQ00siEcCr21Vy62/XMUgoTMP0
 ruAJ3GS2Boof4iy+ow6k+pyZug2crvFBwPmgP5Um5R8Hg5YP1dPhXvfbkPFqPAfvGwOvoplet
 J2AWy7clG4cWvOnoOy52qSRXi9wlksgco1NEKVg+ITDnHMNlDT01gV4H6HNCGkOncaZ02mV1f
 WoJKk4TZPuzgJh5AqeiuSTyXXyIiy919eAAca+VxYDVUHKVsaVa633SN22EcLEV1YskVIIOMm
 T2iRBlyk5NdX4Xcg6V7A==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 20, 2019 at 11:49 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> [...]
> > --- a/arch/x86/include/uapi/asm/sembuf.h
> > +++ b/arch/x86/include/uapi/asm/sembuf.h
> > @@ -21,9 +21,9 @@ struct semid64_ds {
> >       unsigned long   sem_ctime;      /* last change time */
> >       unsigned long   sem_ctime_high;
> >  #else
> > -     __kernel_time_t sem_otime;      /* last semop time */
> > +     long            sem_otime;      /* last semop time */
> >       __kernel_ulong_t __unused1;
> > -     __kernel_time_t sem_ctime;      /* last change time */
> > +     long            sem_ctime;      /* last change time */
> >       __kernel_ulong_t __unused2;
> >  #endif
> >       __kernel_ulong_t sem_nsems;     /* no. of semaphores in array */
> [...]
>
> We need to use __kernel_long_t here to do the right thing on x32.

Good catch, thanks for the review!

I applied the patch below now on top.

       Arnd

commit c7ebd8a1c1825c3197732ea692cf3dde34a644f5 (HEAD)
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Nov 21 15:25:04 2019 +0100

    y2038: ipc: fix x32 ABI breakage

    The correct type on x32 is 64-bit wide, same as for the other struct
    members around it, so use  __kernel_long_t in place of the original
    __kernel_time_t here, corresponding to the rest of the structure.

    Fixes: caf5e32d4ea7 ("y2038: ipc: remove __kernel_time_t reference
from headers")
    Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/x86/include/uapi/asm/sembuf.h
b/arch/x86/include/uapi/asm/sembuf.h
index 7c1b156695ba..20cab43c4b15 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -21,9 +21,9 @@ struct semid64_ds {
        unsigned long   sem_ctime;      /* last change time */
        unsigned long   sem_ctime_high;
 #else
-       long            sem_otime;      /* last semop time */
+       __kernel_long_t sem_otime;      /* last semop time */
        __kernel_ulong_t __unused1;
-       long            sem_ctime;      /* last change time */
+       __kenrel_long_t sem_ctime;      /* last change time */
        __kernel_ulong_t __unused2;
 #endif
        __kernel_ulong_t sem_nsems;     /* no. of semaphores in array */
