Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE56461995
	for <lists+linux-arch@lfdr.de>; Mon, 29 Nov 2021 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbhK2Oj5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Nov 2021 09:39:57 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbhK2Oh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2021 09:37:57 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5gAG-1mysjf29CU-007Gsm; Mon, 29 Nov 2021 15:34:37 +0100
Received: by mail-wr1-f47.google.com with SMTP id o13so37156719wrs.12;
        Mon, 29 Nov 2021 06:34:37 -0800 (PST)
X-Gm-Message-State: AOAM533YO9pcAlCOuiri8drEfW4cYQrrLb39W8tVOdYEHYzEv7a6bSes
        6IebKL4KaiG9qEAurNUb4TDGnAwjmp+7rDMH6J4=
X-Google-Smtp-Source: ABdhPJyXREqU8kKGWYixStrxiAg8L4JSL6SJLG6LnHyFXcHPbgouHOXEYlIbqnHI43DcIJk+Fnqff7ZB74EzR6XRxRY=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr34125698wrp.209.1638196477109;
 Mon, 29 Nov 2021 06:34:37 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
In-Reply-To: <YaTAffbvzxGGsVIv@yuki>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Nov 2021 15:34:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
Message-ID: <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     David Laight <David.Laight@aculab.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FKTMbfOX7sEgcBPHAVuFovuPo3UmeiJ8He2f4ltEjxhbfD3LMXb
 sRpyke8vrnDz50IJGGrfjU8IH6qREcbah4K6SEmCSbJUKKIYOv46gIIW9lcoLOKyv9VDdq4
 00zrjVApJe/7XBHsFyEqoceKA1tv9CLDrrZOPeGudBIoO0sAufYNJTzSKUY3gZq6Tf996lP
 okJFxLO1xYysSSvhj3Wdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MSRBOd1hb+s=:UaAflMWgcfWMgbg2zzFpwJ
 I5Qu4PmcHrjNaaadsp9j4X6S63sJGfzHMZdcbfyt3ve2wfYylsLOpEpYSY52pNMB/dkgT9TQz
 tnSNIL8WKecurf5TFZokc9vzNHTGpjPaYn4/8VZUBaIk0hyu622pzq3lF9Za/h7fJu0zLwnJI
 qRcQeG/R0C8VYaqxVJZaUpOyYeDuv04PMiDIth/wNloaLXEke/4qhhx7MmPZ6KeIVyxSiobF+
 GuSHcqo7nT/bCQbp0eorVUa5TUDYIUJBrVMgYfRCwpf1B/NQHVrWCPre2fldjN1NGL1Jfd4a3
 sB7RX7uHZ1cUh7LDcFek97Ebb3u4Xad0sDqQX6/SXAgD1xzNVxumfG0ffzsw0gfn9uLCkKQJp
 I9oyj+Y5gnvH+u4oWN+hIGm/dC1HnfgJWkFEg86Bfo0AmniYek5CH4aYMlfXCOaV8zDOSa7/K
 grjRae83mPGFnGl5H78IpjamDCwzzF1sAMH94qT8f368Z1GrF5pqpGS4MxkKOSSSOQNGF9tl2
 JJmZASArR5cryW4rpqh0xq/Gk/ii8WuwV90zpz6QB/syoNC0oz4Dmg2Cm9uKaWV5mi09M/4Xx
 leV3rcVk86IAyPyP22YtLS6JPdqVYidsvgalYKIUSW04HH1HbgyLzsbJZ0UtBrHSI9a/X/SaZ
 0cJ97yBoLW3ZlcezJgNrL6zZfvwQ8k+2PXstHl+ynJZ4BaqliO3bnWWgP50UoCWyWR5s=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 29, 2021 at 12:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> What about guarding the change with __STDINT_COMPATIBLE_TYPES__ as:
>
> #if defined(__STDINT_COMPATIBLE_TYPES__)
> # include <stdint.h>
>
> typedef __u64 uint64_t;
> ...

I don't think we can include stdint.h here, the entire point of the custom
kernel types is to ensure the other kernel headers can use these types
without relying on libc headers.

While some of driver specific kernel headers have libc dependencies
in them, the general rule is to keep the kernel headers as standalone
usable.

       Arnd
