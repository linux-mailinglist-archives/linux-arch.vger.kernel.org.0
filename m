Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B0137762
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgAJTm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 14:42:56 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJTm4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 14:42:56 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MeTsQ-1jQALS1vNM-00aSXi; Fri, 10 Jan 2020 20:42:54 +0100
Received: by mail-qk1-f171.google.com with SMTP id x1so2953658qkl.12;
        Fri, 10 Jan 2020 11:42:54 -0800 (PST)
X-Gm-Message-State: APjAAAWBPVyLB6T267DIP/hhUxRxW7Dmm9SfiOzbkPclq7f6UEjKMm/V
        9ST6lVkCQCtzcTcKEgGCk2iygKMPc4mIu6lJsdI=
X-Google-Smtp-Source: APXvYqzbBDJetuIP2AxIVMlt1l/ueQP3AP+6umNRi4uyQzmIdxL8PsdmNyjbRyqK4rz4kxClVWV5FCQyR2/lEd0yr9w=
X-Received: by 2002:a37:84a:: with SMTP id 71mr4703601qki.138.1578685373260;
 Fri, 10 Jan 2020 11:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-8-will@kernel.org>
In-Reply-To: <20200110165636.28035-8-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 20:42:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
Message-ID: <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] locking/barriers: Use '__unqual_scalar_typeof'
 for load-acquire macros
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VtWkG5t3b7jmFW/oIX7NXwWSMIe4cv+Pf3BWC5gZdss1cK3y7PL
 t+w2jK+ARiorrug1YBOJDdS0zvN5DDTU7CtKw8tuwthIs4Oy2sUXb9CAbgRmJ6oGvg0kkel
 zYyTPLXRIdCc92frIQxghb8D93/jtkSrgLZa4jc7jm+C+Iv86B9QxY7U5QUUrpsIr4v71Bo
 1sdb+1INLzdmx5XghWILA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LIABXQUOcVw=:sLjGtRim3imdLEVtoiHBSh
 6VTo2BkYZk8Bprjd6xKuzadcf6lEFzxFAEbpzM2M8h1dsd8u5JTmggx/al78xhY6r+bbaLB58
 QmQqZrZFAHtRD/appkPfkjZX/RTMUgFpvs9J4moQJuR8/egv6ekQIzSW/0ZqMnicsmoT0uYNw
 8aj+B3od+OCP3e52ew4PzKNVWKOX+LGhZDCJYRWC+tbU/lNmUwZ+MbCGxglmp7/Ketr5wzETc
 AvU7U3Bbwiv/0IV6Pq2Bir2IQ5Y4Qf7r/pV6ElYWbNVwCuVBoBeln+R3wEryehmtxOf9JOA9A
 RlimA2oxfqDvRj9dalsm8cMUW+Oo1Am8Y1r8wAX1Ktcc0mSMYbGdul/le6nH8nRPIwO+FZ7Ac
 BBGbm9jHepMWbZxTOKD6MH0b3HWvXbqbaDYz5wDGIBxKsI+4SarUNRUQBUXgldjxFxdA1Hbjx
 sy/3iMugeCsfBH7qkL5JK++W8U5oo8JfQmEe/DFpygQDftntM3tl9Im+Aw3K90RjvHXPXn+O3
 bSh1npA9f7L7XE9xC9QRD1Tib3gOLuMSWcUdD3jRRxdMJmPXr9igF4xL2OLm0okbjBV5h9V6k
 W8WiejfzqKI6btGhCJd3wh3jBhEnVoKBsGTr/Z3S5vmDPWRr+yI0ojH/bSpJYjn9tWeLy+2sZ
 0ULCtJJY9MMWolxSfa4ACZTs65LJBNIdrZcFSBst8Jh2aYk7rYJNo260h4kHzWvxnCBn3rerG
 v6BiQMX9QyUWBRDMuC+w6fxLGdt+9RUZRE/E32hZgwQrOOWu2PwcydyVaJI78SSCdoFGNjo6J
 l0e8GF5Qcky4CT11IwI1r+jUoiB+5x8O3ZDo5PtOAi16aWiPmfntVwAxDFfIQ2WcA589wQatO
 gXw4uTC0FhsZQ22uyTog==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 5:57 PM Will Deacon <will@kernel.org> wrote:

> @@ -128,10 +128,10 @@ do {                                                                      \
>  #ifndef __smp_load_acquire
>  #define __smp_load_acquire(p)                                          \
>  ({                                                                     \
> -       typeof(*p) ___p1 = READ_ONCE(*p);                               \
> +       __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
>         compiletime_assert_atomic_type(*p);                             \
>         __smp_mb();                                                     \
> -       ___p1;                                                          \
> +       (typeof(*p))___p1;                                              \
>  })

Doesn't that last  (typeof(*p))___p1 mean you put the potential
'volatile' back on the assignment after you went through the
effort of taking it out?

       Arnd
