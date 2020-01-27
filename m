Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95BF149F39
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 08:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgA0H0W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 02:26:22 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:37505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgA0H0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 02:26:21 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQeIA-1jGO0w1Lni-00NkXH; Mon, 27 Jan 2020 08:26:20 +0100
Received: by mail-qk1-f178.google.com with SMTP id q15so8681606qke.9;
        Sun, 26 Jan 2020 23:26:20 -0800 (PST)
X-Gm-Message-State: APjAAAXo6yGNTX4WiZmZRQfrosrPSVm7SjLJUIwyt/DfqlYhuyX5Yi2a
        rLBGazeqeZTAdef0YYieKRLfngPgXv4iPkT1fsU=
X-Google-Smtp-Source: APXvYqxlylkK1tDp0siCP+ozzjLtsjUJ1/pYYXDqAsuxoykoyBiDLDdftjf04CgOzZk2GHrZ8hTORthbFnaJFMo2yc0=
X-Received: by 2002:a05:620a:12e1:: with SMTP id f1mr14839537qkl.394.1580109979147;
 Sun, 26 Jan 2020 23:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck> <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
 <20200123190125.GA2683468@rani.riverdale.lan> <20200126010959.vhq7mg4esoq5w26j@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200126010959.vhq7mg4esoq5w26j@e107158-lin.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jan 2020 08:26:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2P41JjO8=GTSVL9WVEfjA_M+StH7Ons27SqSNK2JOrHg@mail.gmail.com>
Message-ID: <CAK8P3a2P41JjO8=GTSVL9WVEfjA_M+StH7Ons27SqSNK2JOrHg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ahfyygVcR59V0LNaGPKYoyNS1BjUiiy8xN3GSibjLksSJclAyZJ
 LMCHKHudTnjEKO8AmJ3yN3xpfFPamCml9t1e7fwZJXlDSXck4+bPhE4pxH7FE4ls88jd2bk
 IvfxfNYmjsaIJQVWMIi3bMrcvG/jx0JBQo3CacojQZM8qlCWOQb8gyzZ5K7/NtKJSMppByY
 vVmEzb6cShDXHeYj87CiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SckyZFLtMSg=:lyWcXYdhWBXEXYN4cGLYiF
 lYa2Ta3dgLaUcB2FcogMXdDX5dyefS5hU0nvIpTMIcSzS2LxhEe39zYnv1m/n/LKg1oxoAcPw
 TmjBXKge/hHBi9uW3B9qmcTx/LNXM8vnKjEtbkgnF9uVj8eNJzc20Rx9RlXUUBuEOHNfCvgiX
 g9h/aC+4i+Vm4XikHqiX1e5mur8AiQrUtSD7e/A71+PduXc4WYsE+rruYjq7vsqcXUy9dRovv
 9TeWGbMKaQ6vQ/X2qRD37qoCtcoFLagLjLhGY2JPOgX9bC56G8ZjC8boJuR5AU620OeLyiRga
 yOmzyCsli3G7AVQ2mEDzYSoGPxtiREXpH/OksQVkA6lq+Q4dk8uvAeXLU2gW/tE1te6kaURBL
 MJtmJkJtPbw50Ga9ykrjldj7iQF3LkYF63fAQZYlTkzbAxuB9Kzn7xhyGSvSCGeT5v/N6mpET
 OD8fja5slfffpcwoO5O6FIt1purlDTKbzpzBnSGzVDtr92huRiEf+sSuT2ekcE85VL2uNfpvh
 b88SCFTDJRjhb8VS0+IfxOYjSg227GRoo97VJtPk0M3gshSf+onSv0imMvmMNVDPzFj5BymUD
 fuApRs53wgGuRd0QZKOj3d9O309V8huI8OMOn/qV4u5ONZQW5ty543uv/Cpxig9ch6Mhxv9Uj
 jJfw/pClXRXPNrYNaSSymqEk+E6dDEfBofD5G0hyViLY9zuDqQSyR6QOreIgwlu8c6yYGAxu0
 +uT0GVJ7Gwl/xDMUNXRm0P82fsYSQg3Il6Tu0hFGVzGzO1c0k6cTwMEyUPnlIy9QZKiEXxka7
 lLtD1mj4rB+z99Q00KUbAuO+9jFzNyWon4HkpD9ggCnfH8QUpE=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 26, 2020 at 2:10 AM Qais Yousef <qais.yousef@arm.com> wrote:
> On 01/23/20 14:01, Arvind Sankar wrote:
> > On Thu, Jan 23, 2020 at 10:45:08AM -0800, Nick Desaulniers wrote:
> > > On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > Reposting Arnd's link
> > https://www.spinics.net/lists/linux-kbuild/msg23648.html
>
> This list seems to be x86 centric? I remember when the switch to GCC 4.6
> happened a couple or more archs had to be dropped because they lacked a newer
> compiler.

There are two architectures that already had problems last time:

- unicore32 never had any compiler that shipped with sources, only an ancient
  set of gcc binaries that already had problems building the kernel during the
  move to gcc-4.6. The maintainer said he'd work on providing support for
  modern gcc or clang, but I don't think anything came out of that.

- hexagon had an unmaintained gcc-4.5 port, but internally Qualcomm were
  already using clang to build their kernels, which should now work with the
  upstream version. I don't think there are any plans to have a more modern
  gcc.

Everything else works with mainline gcc now, openrisc and csky were the
last to get added in gcc-9.

Some of the older sub-targets (armv3, s390-g6, powerpcspe) are removed
in gcc-9, but these have a few more years before we need to worry about
them.

     Arnd
