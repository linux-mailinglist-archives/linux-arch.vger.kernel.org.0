Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75231AB12C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411744AbgDOTHk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:07:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416836AbgDOSiG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Apr 2020 14:38:06 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MC2wN-1jYS6T13bp-00CQnf; Wed, 15 Apr 2020 20:38:04 +0200
Received: by mail-qv1-f54.google.com with SMTP id p19so646288qve.0;
        Wed, 15 Apr 2020 11:38:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubLG+lokQ6JXUQco2+TG0Qf+Q3jm5nHXYzNNLm97LadYXY6oCps
        q1bNhIiCnLc3BMbGQITLbsOuJ9DlA3FjuzGItTI=
X-Google-Smtp-Source: APiQypLeMj/EorU7qlWkHFCDo4wD7AwtsjSP3Dtuwu4VCxu2GcQe4uViFL6XZq7BHY/bNpriSbgN/XVg0X0f0/I28c8=
X-Received: by 2002:a05:6214:40f:: with SMTP id z15mr5992996qvx.210.1586975882995;
 Wed, 15 Apr 2020 11:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200415165218.20251-1-will@kernel.org> <20200415165218.20251-12-will@kernel.org>
In-Reply-To: <20200415165218.20251-12-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 20:37:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jSS89Ldhu1g46zLTBHDVHUr3HSdyq_c7yiTfM8w6hDg@mail.gmail.com>
Message-ID: <CAK8P3a2jSS89Ldhu1g46zLTBHDVHUr3HSdyq_c7yiTfM8w6hDg@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BU/cm+mYM8i4UC+XqZm23B3JEszZ79dAucDTv9O1s5q1NppQszH
 5s+DY7CjIEX4N6dVB/CT7lhT2pBegm2leJfq+EM8tha4tDmDm7nVkeUB9hJbPBDjHPU0ezr
 d/LAeiYTzf+6TDLlj4Gi4mcCvoHoUzXRzkgdtqg5dF7gWA8ilxG0lZK2zF098N/0ZkgJU3B
 PkXEk+8zqufOntZlxjazw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:21w4q4Zj1xE=:cC0d9Ak+Ua5+CKn/y0DBy4
 snk5Ml+4GZfRW6DWLTIKthiAUvjR1/MTwOIzVFP00rLCSF5ma/n/7tiJMNupdgIEwhSdkyoHY
 t/vj3pSKJl3BN/6qzGfIYOh/KBP7zeueN6SNf3LaSjBXzA/TN+1O37gAz7fvtkH4LfD098vxg
 imJCHrULy9HZZNO2i2N3FvCsCTe4XoiAfSnn+2PNemcYaLn0tSQ+bQf6zC7r1I7+MrrCy0hhU
 dCCHtIPeedfBzqzcHG/f+YLGsW1LgiJD+YQmdWAbgZk7/K9VvzyDJyDjZWIEVFh278xDYp7Cg
 wIkydFgHPNxfNMv211wFY7kZHMnJbZAOZRxuXKalGq51Y1EYe/1AaK1tGKTRn6OhK0CU7NyJ6
 UuTHoYNXEKNP8IJj61d9E4CfdqWne4JABB5xWjfTPJ45ssR4PZJFY5F4b8QuSve5qWaw3MzAf
 Aktw+lSHXVQBAE30g+5ZLJEuBOOZFEmuRi1LsTPAo7a4lwMkNcppcOhFRVmxNwgWQhDlR10w9
 22nCAFf6G/wnCRZdyykiYyreD0wgTFT8IFKS6BDyuLlpjAQv8RCCV/QfCpZPsu9/M2drLDZUa
 fqRCtjA8eLoTS9eMqhthrxZyoFvbXL/w5DqwFbHmbqMVcEoqx31I0fdVSXTljbuyFgNImRppu
 m2vuBzAzK4jqCMxv1ZYQg3kj0LnU0unIhqhLQQquJo+aob+bt00j9U4K8ZC1e+6+AwG/SgiMn
 IEMZj7jn4HGuquh4Sf2k0oITc8aTpNPo7RkHk6AMq5+NdQbiDH+a5bJq5lvzfUaLC071mG//u
 DBPKB+w8/8Yn4Xz2qipAhWSBSx696bEIWRSV0K+HEERaJpeIFI=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 15, 2020 at 6:53 PM Will Deacon <will@kernel.org> wrote:
>
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also know to have codegen
> issues which can lead to silent miscompilation:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> Raise the minimum GCC version for kernel build to 4.8 and remove some
> tautological Kconfig dependencies as a consequence.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

On a related note, I've updated the cross-compilers on kernel.org and
done some randconfig testing on all major versions from v4.8 to 9.3.
There were a couple of minor regressions with 4.8 (mostly harmless
warnings), but overall gcc-4.8 is still working well. I did not try older
compilers.

       Arnd
